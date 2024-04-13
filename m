Return-Path: <linux-kernel+bounces-143527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C0E8A3A89
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18EF283992
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2E31804F;
	Sat, 13 Apr 2024 02:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pfr48ukl"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4324B8831;
	Sat, 13 Apr 2024 02:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712976228; cv=none; b=Nq2TrsS0BeVBj2bFHzlltKkWy9NP/B2Ncx7X9WHXKchFi8PgmL22IjZ+N+oMQJEqQjuHYDvbAvmkAf9nnxy0fojobwj8chH8GSTgQb6Ep5qA3FiucOeruR2BhoPzH8C/Lwu1z+Nj7YvsnkxkBV7wzrIgutOp+qu1NEC+bhzAj6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712976228; c=relaxed/simple;
	bh=uTVry+7Yk0Yx2bIliqO9FLjvtQb3GTZpPJ+GYHnc3XY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjdghBndWrEoho5qaEL+xt/UlDEghXX9qwWDPLituzTs/bCVmBfPSc2/R/CpxnQVM3LhYJjcvj5D1PabdLhrMvNHsjyuozZthZYgRh3UIGVMxxDmuLSGRffU4WjtKjHGzIKKKV/FB5bvuZ2M+ptnQVRk1/OTgTS2FJ4Jgh2kCtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=pfr48ukl; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712976221;
	bh=9nQeBX4dxmkDHV+U6JS+37Qf6B1PkL6FnLHBHNt7+hA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pfr48ukl3Xaeb61xKxCw0ei2sagvDVmXf0StOAiiGDul94R96OTKvdFqusX8EOJDz
	 CYQWAlN/qX5yirhpZ/XBBZW5SfAs+VgJ8li8C1gBDS9/D9JVclL2bzlbf39Eej6aZF
	 6+5sC3TPzOQRIq79P+epNEYHf4SYUC3w38Ly3DZhdLBFry9AAIqy+zujzZ623R01lO
	 uLoj1DDmaa88Cc8viS2QSfcNwZqZW7qCWIg2JkTnrhQ5Z49rgklXDhbHmlG5x5rf3x
	 /d6vaprUfpZZaHpSlJs8mSjK/fJ+6Vpgvg7piazg19u2lpYnuR6oyfEjuUR6SLT5K7
	 eFIZoUsfYWReQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VGd6P3KP5z4wx5;
	Sat, 13 Apr 2024 12:43:41 +1000 (AEST)
Date: Sat, 13 Apr 2024 12:43:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Namhyung Kim
 <namhyung@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20240413124340.4d48c6d8@canb.auug.org.au>
In-Reply-To: <ZhlRn0TUkcDaAZT5@x1>
References: <20240402094116.79751030@canb.auug.org.au>
	<ZhlRn0TUkcDaAZT5@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uSPG1V6M+jjDHAsHTyK=rEV";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/uSPG1V6M+jjDHAsHTyK=rEV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Fri, 12 Apr 2024 12:22:07 -0300 Arnaldo Carvalho de Melo <acme@kernel.or=
g> wrote:
>
> On Tue, Apr 02, 2024 at 09:41:16AM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the perf tree, today's linux-next build (native i.e. ppc6=
4le
> > perf) failed like this:
> >=20
> > make[3]: *** No rule to make target '/home/sfr/next/next/tools/include/=
uapi/linux/stat.h', needed by '/home/sfr/next/perf/libbpf/staticobjs/libbpf=
o'.  Stop. =20
>=20
> How is this built? Using O=3D/home/sfr/next/perf?

Yes.  The actual command line is:

make -C tools/perf -f Makefile.perf -s -O -j60 O=3D/home/sfr/next/perf NO_B=
PF_SKEL=3D1

The source directory is /home/sfr/next/next.  This is a PowerPC 64 little e=
ndian
build (on a PowerPC 64 little endian host).

OK, I just tested on my x86_64 laptop:
(I started with a clone of Linus' current tree)

pine:~/next/next (master)$ rm -rf ../perf
pine:~/next/next (master)$ mkdir ../perf
pine:~/next/next (master)$ make -C tools/perf -f Makefile.perf -s -O -j10 O=
=3D/home/sfr/next/perf NO_BPF_SKEL=3D1
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
  diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
  diff -u tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h
  diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h
  diff -u tools/include/linux/bits.h include/linux/bits.h
  diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/a=
sm/disabled-features.h
  diff -u tools/arch/x86/include/asm/required-features.h arch/x86/include/a=
sm/required-features.h
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpu=
features.h
  diff -u tools/arch/x86/include/asm/irq_vectors.h arch/x86/include/asm/irq=
_vectors.h
  diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-i=
ndex.h
  diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/k=
vm.h
  diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/ua=
pi/asm/kvm.h
  diff -u tools/arch/s390/include/uapi/asm/kvm.h arch/s390/include/uapi/asm=
/kvm.h
  diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/a=
sm/kvm.h
  diff -u tools/include/asm-generic/bitops/__fls.h include/asm-generic/bito=
ps/__fls.h
  diff -u tools/include/asm-generic/bitops/fls.h include/asm-generic/bitops=
/fls.h
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cpu=
type.h
Makefile.config:455: No libdw DWARF unwind found, Please install elfutils-d=
evel/libdw-dev >=3D 0.158 and/or set LIBDW_DIR
Makefile.config:460: No libdw.h found or old libdw.h found or elfutils is o=
lder than 0.138, disables dwarf support. Please install new elfutils-devel/=
libdw-dev
Makefile.config:602: No sys/sdt.h found, no SDT events are defined, please =
install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:688: Warning: Disabled BPF skeletons as clang (clang) is mi=
ssing
Makefile.config:800: slang not found, disables TUI support. Please install =
slang-devel, libslang-dev or libslang2-dev
Makefile.config:1083: No libbabeltrace found, disables 'perf data' CTF form=
at support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1147: No openjdk development package found, please install =
JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
Makefile.config:1160: libpfm4 not found, disables libpfm4 support. Please i=
nstall libpfm4-dev

Auto-detecting system features:
..                                   dwarf: [ OFF ]
..                      dwarf_getlocations: [ OFF ]
..                                   glibc: [ on  ]
..                                  libbfd: [ on  ]
..                          libbfd-buildid: [ on  ]
..                                  libcap: [ on  ]
..                                  libelf: [ on  ]
..                                 libnuma: [ on  ]
..                  numa_num_possible_cpus: [ on  ]
..                                 libperl: [ on  ]
..                               libpython: [ on  ]
..                               libcrypto: [ on  ]
..                               libunwind: [ on  ]
..                      libdw-dwarf-unwind: [ OFF ]
..                             libcapstone: [ on  ]
..                                    zlib: [ on  ]
..                                    lzma: [ on  ]
..                               get_cpuid: [ on  ]
..                                     bpf: [ on  ]
..                                  libaio: [ on  ]
..                                 libzstd: [ on  ]

  PERF_VERSION =3D 6.9.rc3.g8f2c057754b2
pine:~/next/next (master)$ git merge perf-tools-next=20
Auto-merging MAINTAINERS
Merge made by the 'ort' strategy.
 MAINTAINERS                                        |    1 +
 tools/include/uapi/asm-generic/fcntl.h             |  221 --
	.
	.
	.
 create mode 100644 tools/perf/util/disasm.h
pine:~/next/next (master)$ make -C tools/perf -f Makefile.perf -s -O -j10 O=
=3D/home/sfr/next/perf NO_BPF_SKEL=3D1
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
  diff -u tools/include/linux/bits.h include/linux/bits.h
  diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/a=
sm/disabled-features.h
  diff -u tools/arch/x86/include/asm/required-features.h arch/x86/include/a=
sm/required-features.h
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpu=
features.h
  diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-i=
ndex.h
  diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/k=
vm.h
  diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/ua=
pi/asm/kvm.h
  diff -u tools/arch/s390/include/uapi/asm/kvm.h arch/s390/include/uapi/asm=
/kvm.h
  diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/a=
sm/kvm.h
  diff -u tools/include/asm-generic/bitops/__fls.h include/asm-generic/bito=
ps/__fls.h
  diff -u tools/include/asm-generic/bitops/fls.h include/asm-generic/bitops=
/fls.h
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cpu=
type.h
  diff -u tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h arch/x=
86/include/asm/irq_vectors.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/linu=
x/fs.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h include/uapi/l=
inux/vhost.h
  diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/=
sound/asound.h
Makefile.config:465: No libdw DWARF unwind found, Please install elfutils-d=
evel/libdw-dev >=3D 0.158 and/or set LIBDW_DIR
Makefile.config:470: No libdw.h found or old libdw.h found or elfutils is o=
lder than 0.138, disables dwarf support. Please install new elfutils-devel/=
libdw-dev
Makefile.config:612: No sys/sdt.h found, no SDT events are defined, please =
install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:698: Warning: Disabled BPF skeletons as clang (clang) is mi=
ssing
Makefile.config:810: slang not found, disables TUI support. Please install =
slang-devel, libslang-dev or libslang2-dev
Makefile.config:1093: No libbabeltrace found, disables 'perf data' CTF form=
at support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1157: No openjdk development package found, please install =
JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
Makefile.config:1170: libpfm4 not found, disables libpfm4 support. Please i=
nstall libpfm4-dev

Auto-detecting system features:
..                                   dwarf: [ OFF ]
..                      dwarf_getlocations: [ OFF ]
..                                   glibc: [ on  ]
..                                  libbfd: [ on  ]
..                          libbfd-buildid: [ on  ]
..                                  libcap: [ on  ]
..                                  libelf: [ on  ]
..                                 libnuma: [ on  ]
..                  numa_num_possible_cpus: [ on  ]
..                                 libperl: [ on  ]
..                               libpython: [ on  ]
..                               libcrypto: [ on  ]
..                               libunwind: [ on  ]
..                      libdw-dwarf-unwind: [ OFF ]
..                             libcapstone: [ on  ]
..                                    zlib: [ on  ]
..                                    lzma: [ on  ]
..                               get_cpuid: [ on  ]
..                                     bpf: [ on  ]
..                                  libaio: [ on  ]
..                                 libzstd: [ on  ]

  PERF_VERSION =3D 6.9.rc3.g42c4635c8dee
make[3]: *** No rule to make target '/home/sfr/next/next/tools/include/uapi=
/linux/stat.h', needed by '/home/sfr/next/perf/libbpf/staticobjs/libbpf.o'.=
  Stop.
make[2]: *** [Makefile:157: /home/sfr/next/perf/libbpf/staticobjs/libbpf-in=
o] Error 2
make[1]: *** [Makefile.perf:892: /home/sfr/next/perf/libbpf/libbpf.a] Error=
 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile.perf:264: sub-make] Error 2

--=20
Cheers,
Stephen Rothwell

--Sig_/uSPG1V6M+jjDHAsHTyK=rEV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYZ8VwACgkQAVBC80lX
0GzD7QgAi4oX2RmV/SVD78CJxtiH5KLuqKYdNBmL1z7qVX4NdwLRQ5Vs0NvOgR52
wqLcPGn39iMMNmG6ez96sW+OpXVNraZdZQalNWF8AxixlEsdJYYZg+qzl8a0kCe2
5qjGpgNJSF6iGfIpuPTsGTaSJfwPuBA+hm9wgNvZS+AFFtE8Pl02jT+1+3emNHvH
MFc5a6lemU95LMuO6iu+LUmPshPNphZ45Zxmg+b76wrHILJrD0o9MwNYn3e3s5ap
E1SvnPilLDT9aOgS+B6jI+5Qby/j4WOh8ErMLwhUH1NNRBNK7Jiv1U3SrJ45YSfO
lz0BeKLQ6vQIjHLfXQs5sXHaEchy6Q==
=EXPd
-----END PGP SIGNATURE-----

--Sig_/uSPG1V6M+jjDHAsHTyK=rEV--

