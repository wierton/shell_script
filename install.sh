#!/bin/bash

username=wierton

homedir=${homedir}
cd ${homedir}

# add-apt-repository
add-apt-repository -y ppa:umang/indicator-stickynotes
add-apt-repository -y ppa:ubuntu-toolchain-r/test # gcc-7
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add - # virtualbox
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add - # virtualbox
apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-5.0 main" # clang-5.0
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - # clang-5.0
apt-get update

# curl
apt-get install -y curl

# indicator-stickynotes
apt-get install -y indicator-stickynotes

# gcc-7
apt-get install -y gcc-7 g++-7
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 50
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 50

# shadowsocks
apt-get install -y shadowsocks

# virtualbox
apt-get install -y virtualbox-5.2

# clang-5.0
apt-get install -y clang-5.0
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-5.0 50

# zsh
apt-get install -y tmux git zsh vim vim-gnome unzip unrar
sudo -S -u ${username} sh -c '
git config --global user.name 141242068-ouxianfei
git config --global user.email 141242068@smail.nju.edu.cn
git config --global core.editor vim
git config --global color.ui true
git config --global push.default simple
'
sudo -S -u ${username} sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)

# numlock
apt-get install -y numlockx
if ! grep "numlockx on" /etc/profile; then
echo "numlockx on" >> /etc/profile
fi

# cppman
apt-get install -y cppman

# tmux
echo 'bind [ copy-mode
bind -t vi-copy v begin-selection
bind -t vi-copy y copy-selection
bind ] pasteb
setw -g mode-keys vi
run-shell ${homedir}/.tmux/tmux-resurrect/resurrect.tmux
' > ${homedir}/.tmux.conf
sudo -S -u ${username} sh -c '(mkdir ${homedir}/.tmux &&
	cd ${homedir}/.tmux &&
	git clone https://github.com/tmux-plugins/tmux-resurrect.git)'


# libsdl
apt-get install -y libsdl1.2-dev libsdl2-dev

# cmake-3.10
apt-get install cmake
wget http://www.cmake.org/files/v3.10/cmake-3.10.1.tar.gz 
tar -xvzf cmake-3.10.1.tar.gz 
(su - ${username} && cd cmake-3.10.1/ && cmake . && make && sudo make install)

# cross chain
apt-get install -y binutils-mips-linux-gnu
apt-get install -y cpp-mips-linux-gnu
apt-get install -y g++-mips-linux-gnu
apt-get install -y gcc-mips-linux-gnu
apt-get install -y gcc-mips-linux-gnu-base

# scala rust
apt-get install -y scala
curl -sSf https://static.rust-lang.org/rustup.sh | sh
mkdir -p ${homedir}/.vim/{ftdetect,indent,syntax} &&
	for d in ftdetect indent syntax ; do
		wget -O ${homedir}/.vim/$d/scala.vim https://raw.githubusercontent.com/derekwyatt/vim-scala/master/$d/scala.vim;
	done

# python libraries
apt-get install -y python-pip python3-pip python-virtualenv
update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10
update-alternatives --install /usr/bin/pip pip /usr/bin/pip2 20
pip2 install yd
pip2 install numpy && pip3 install numpy
pip2 install scipy && pip3 install scipy
pip2 install tensorflow && pip3 install tensorflow

# docker
apt-get install -y docker.io
apt-get install -y docker-compose

# autoremove
apt-get autoremove
