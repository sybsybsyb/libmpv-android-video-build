#!/bin/bash -e

. ../../include/depinfo.sh
. ../../include/path.sh

build=_build$ndk_suffix

if [ "$1" == "build" ]; then
	true
elif [ "$1" == "clean" ]; then
	rm -rf _build$ndk_suffix
	exit 0
else
	exit 255
fi

unset CC CXX # meson wants these unset

<<<<<<< HEAD
meson setup $build --cross-file "$prefix_dir"/crossfile.txt \
	--default-library shared -Dprefer_static=true \
	-Dgpl=false -Dcplayer=false \
	-Dvulkan=disabled -Dlibplacebo=disabled \
	-Diconv=disabled -Dlua=enabled \
	-Dlibmpv=true -Dmanpage-build=disabled
=======
PKG_CONFIG="pkg-config --static" \
./waf configure \
	--enable-lgpl \
	--disable-cplayer \
	--disable-vulkan \
	--disable-libplacebo \
	--disable-lua \
	--disable-iconv \
	--enable-libmpv-shared \
	--disable-manpage-build \
	-o "`pwd`/_build$ndk_suffix"
>>>>>>> 5564f4b1808f99844d0d32bf556f6c7bb7ff24d6

ninja -C $build -j$cores
DESTDIR="$prefix_dir" ninja -C $build install

ln -sf "$prefix_dir"/lib/libmpv.so "$native_dir"
