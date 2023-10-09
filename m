Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5897BD1CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 03:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344880AbjJIBb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 21:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjJIBb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 21:31:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4101799;
        Sun,  8 Oct 2023 18:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696815083;
        bh=RF58q+xXgFqMy1W+kf6f5efUO8YDOhVnUo6mzSypuPA=;
        h=Date:From:To:Cc:Subject:From;
        b=gEOc2+2PSwcdFd9tQ5V9fn/DDOwyYub5ThVajV3WkX3YFpbh+Rm9N5rNyTvX0olB2
         2x2V4U/02u1iaJj5X3JkQTxnrfzpJXL8u017SvSxwxaSPnO9TN7n4CORz9UhKp4eep
         rQoWNLGOspz6WlyxLFI1/8yvDlrj3+2AkeGEvLlUt1YPWcRQyZDyFavGqZnDCGMxda
         RRsiVTdhXkphpaVAMAl5v1ESE9QPx0muS4OWQLVkcicXUUgT6z0Ep9gp74fR0CV9Yr
         MmGLFHWL8eKhlyyP5S7J524qVXXXsKYbirUO4+scEzgnFOeVflf2nvqeoudA0/iXVi
         j0S8dNU8cpCtQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S3hMG4fTQz4x5q;
        Mon,  9 Oct 2023 12:31:20 +1100 (AEDT)
Date:   Mon, 9 Oct 2023 12:31:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: linux-next: manual merge of the block tree with the asm-generic
 tree
Message-ID: <20231009123118.4487a0e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/teycTZNgREgDu/GHd9yJThK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/teycTZNgREgDu/GHd9yJThK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got conflicts in:

  arch/alpha/kernel/syscalls/syscall.tbl
  arch/arm/tools/syscall.tbl
  arch/arm64/include/asm/unistd.h
  arch/arm64/include/asm/unistd32.h
  arch/m68k/kernel/syscalls/syscall.tbl
  arch/microblaze/kernel/syscalls/syscall.tbl
  arch/mips/kernel/syscalls/syscall_n32.tbl
  arch/mips/kernel/syscalls/syscall_n64.tbl
  arch/mips/kernel/syscalls/syscall_o32.tbl
  arch/parisc/kernel/syscalls/syscall.tbl
  arch/powerpc/kernel/syscalls/syscall.tbl
  arch/s390/kernel/syscalls/syscall.tbl
  arch/sh/kernel/syscalls/syscall.tbl
  arch/sparc/kernel/syscalls/syscall.tbl
  arch/x86/entry/syscalls/syscall_32.tbl
  arch/xtensa/kernel/syscalls/syscall.tbl
  include/uapi/asm-generic/unistd.h

between commits:

  2fd0ebad27bc ("arch: Reserve map_shadow_stack() syscall number for all ar=
chitectures")

from the asm-generic tree and commits:

  9f6c532f59b2 ("futex: Add sys_futex_wake()")
  cb8c4312afca ("futex: Add sys_futex_wait()")
  0f4b5f972216 ("futex: Add sys_futex_requeue()")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/alpha/kernel/syscalls/syscall.tbl
index 5d05ab716a74,b1865f9bb31e..000000000000
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@@ -492,4 -492,6 +492,7 @@@
  560	common	set_mempolicy_home_node		sys_ni_syscall
  561	common	cachestat			sys_cachestat
  562	common	fchmodat2			sys_fchmodat2
 -563	common	futex_wake			sys_futex_wake
 -564	common	futex_wait			sys_futex_wait
 -565	common	futex_requeue			sys_futex_requeue
 +563	common	map_shadow_stack		sys_map_shadow_stack
++564	common	futex_wake			sys_futex_wake
++565	common	futex_wait			sys_futex_wait
++566	common	futex_requeue			sys_futex_requeue
diff --cc arch/arm/tools/syscall.tbl
index 45ec6e1dc872,93d0d46cbb15..000000000000
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@@ -466,4 -466,6 +466,7 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 +453	common	map_shadow_stack		sys_map_shadow_stack
+ 454	common	futex_wake			sys_futex_wake
+ 455	common	futex_wait			sys_futex_wait
+ 456	common	futex_requeue			sys_futex_requeue
diff --cc arch/arm64/include/asm/unistd.h
index 6a28fb91b85d,531effca5f1f..000000000000
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
diff --cc arch/arm64/include/asm/unistd32.h
index 0774d9cbe563,c453291154fd..000000000000
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@@ -911,8 -911,12 +911,14 @@@ __SYSCALL(__NR_set_mempolicy_home_node
  __SYSCALL(__NR_cachestat, sys_cachestat)
  #define __NR_fchmodat2 452
  __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 +#define __NR_map_shadow_stack 453
 +__SYSCALL(__NR_map_shadow_stack, sys_map_shadow_stack)
+ #define __NR_futex_wake 454
+ __SYSCALL(__NR_futex_wake, sys_futex_wake)
+ #define __NR_futex_wait 455
+ __SYSCALL(__NR_futex_wait, sys_futex_wait)
+ #define __NR_futex_requeue 456
+ __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 =20
  /*
   * Please add new compat syscalls above this comment and update
diff --cc arch/m68k/kernel/syscalls/syscall.tbl
index 12d0ce43b094,f7f997a88bab..000000000000
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@@ -452,4 -452,6 +452,7 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 +453	common	map_shadow_stack		sys_map_shadow_stack
+ 454	common	futex_wake			sys_futex_wake
+ 455	common	futex_wait			sys_futex_wait
+ 456	common	futex_requeue			sys_futex_requeue
diff --cc arch/microblaze/kernel/syscalls/syscall.tbl
index de8219c4300c,2967ec26b978..000000000000
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@@ -458,4 -458,6 +458,7 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 +453	common	map_shadow_stack		sys_map_shadow_stack
+ 454	common	futex_wake			sys_futex_wake
+ 455	common	futex_wait			sys_futex_wait
+ 456	common	futex_requeue			sys_futex_requeue
diff --cc arch/mips/kernel/syscalls/syscall_n32.tbl
index a5096a064fb4,383abb1713f4..000000000000
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@@ -391,4 -391,6 +391,7 @@@
  450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	n32	cachestat			sys_cachestat
  452	n32	fchmodat2			sys_fchmodat2
 +453	n32	map_shadow_stack		sys_map_shadow_stack
+ 454	n32	futex_wake			sys_futex_wake
+ 455	n32	futex_wait			sys_futex_wait
+ 456	n32	futex_requeue			sys_futex_requeue
diff --cc arch/mips/kernel/syscalls/syscall_n64.tbl
index 0044031d9c70,c9bd09ba905f..000000000000
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@@ -367,4 -367,6 +367,7 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	n64	cachestat			sys_cachestat
  452	n64	fchmodat2			sys_fchmodat2
 +453	n64	map_shadow_stack		sys_map_shadow_stack
+ 454	n64	futex_wake			sys_futex_wake
+ 455	n64	futex_wait			sys_futex_wait
+ 456	n64	futex_requeue			sys_futex_requeue
diff --cc arch/mips/kernel/syscalls/syscall_o32.tbl
index cf44a6ac38fa,ba5ef6cea97a..000000000000
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@@ -440,4 -440,6 +440,7 @@@
  450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	o32	cachestat			sys_cachestat
  452	o32	fchmodat2			sys_fchmodat2
 +453	o32	map_shadow_stack		sys_map_shadow_stack
+ 454	o32	futex_wake			sys_futex_wake
+ 455	o32	futex_wait			sys_futex_wait
+ 456	o32	futex_requeue			sys_futex_requeue
diff --cc arch/parisc/kernel/syscalls/syscall.tbl
index 4048ed480a04,9f0f6df55361..000000000000
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@@ -451,4 -451,6 +451,7 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 +453	common	map_shadow_stack		sys_map_shadow_stack
+ 454	common	futex_wake			sys_futex_wake
+ 455	common	futex_wait			sys_futex_wait
+ 456	common	futex_requeue			sys_futex_requeue
diff --cc arch/powerpc/kernel/syscalls/syscall.tbl
index d845e14c38f3,26fc41904266..000000000000
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@@ -539,4 -539,6 +539,7 @@@
  450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 +453	common	map_shadow_stack		sys_ni_syscall
+ 454	common	futex_wake			sys_futex_wake
+ 455	common	futex_wait			sys_futex_wait
+ 456	common	futex_requeue			sys_futex_requeue
diff --cc arch/s390/kernel/syscalls/syscall.tbl
index 416645f1c1fb,31be90b241f7..000000000000
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@@ -455,4 -455,6 +455,7 @@@
  450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_m=
empolicy_home_node
  451  common	cachestat		sys_cachestat			sys_cachestat
  452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
 +453  common	map_shadow_stack	sys_map_shadow_stack		sys_map_shadow_stack
+ 454  common	futex_wake		sys_futex_wake			sys_futex_wake
+ 455  common	futex_wait		sys_futex_wait			sys_futex_wait
+ 456  common	futex_requeue		sys_futex_requeue			sys_futex_requeue
diff --cc arch/sh/kernel/syscalls/syscall.tbl
index bf36587b87b5,4bc5d488ab17..000000000000
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@@ -455,4 -455,6 +455,7 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 +453	common	map_shadow_stack		sys_map_shadow_stack
+ 454	common	futex_wake			sys_futex_wake
+ 455	common	futex_wait			sys_futex_wait
+ 456	common	futex_requeue			sys_futex_requeue
diff --cc arch/sparc/kernel/syscalls/syscall.tbl
index f45f8c5ed076,8404c8e50394..000000000000
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@@ -498,4 -498,6 +498,7 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 +453	common	map_shadow_stack		sys_map_shadow_stack
+ 454	common	futex_wake			sys_futex_wake
+ 455	common	futex_wait			sys_futex_wait
+ 456	common	futex_requeue			sys_futex_requeue
diff --cc arch/x86/entry/syscalls/syscall_32.tbl
index 54748f6d7c45,31c48bc2c3d8..000000000000
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@@ -457,4 -457,6 +457,7 @@@
  450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	i386	cachestat		sys_cachestat
  452	i386	fchmodat2		sys_fchmodat2
 +453	i386	map_shadow_stack	sys_map_shadow_stack
+ 454	i386	futex_wake		sys_futex_wake
+ 455	i386	futex_wait		sys_futex_wait
+ 456	i386	futex_requeue		sys_futex_requeue
diff --cc arch/xtensa/kernel/syscalls/syscall.tbl
index 10a7eecbedf0,dd71ecce8b86..000000000000
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@@ -423,4 -423,6 +423,7 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 +453	common	map_shadow_stack		sys_map_shadow_stack
+ 454	common	futex_wake			sys_futex_wake
+ 455	common	futex_wait			sys_futex_wait
+ 456	common	futex_requeue			sys_futex_requeue
diff --cc include/uapi/asm-generic/unistd.h
index 00df5af71ca1,d9e9cd13e577..000000000000
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@@ -822,12 -822,15 +822,18 @@@ __SYSCALL(__NR_cachestat, sys_cachestat
 =20
  #define __NR_fchmodat2 452
  __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
+ #define __NR_futex_wake 454
+ __SYSCALL(__NR_futex_wake, sys_futex_wake)
+ #define __NR_futex_wait 455
+ __SYSCALL(__NR_futex_wait, sys_futex_wait)
+ #define __NR_futex_requeue 456
+ __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 =20
 +#define __NR_map_shadow_stack 453
 +__SYSCALL(__NR_map_shadow_stack, sys_map_shadow_stack)
 +
  #undef __NR_syscalls
- #define __NR_syscalls 454
+ #define __NR_syscalls 457
 =20
  /*
   * 32 bit systems traditionally used different

--Sig_/teycTZNgREgDu/GHd9yJThK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUjV+YACgkQAVBC80lX
0Gx9zQf+JGLvql1cyUt9KyBLnbeU6r4aHpl6g7jTI2UC5seWwR/Kl+U/ySATiZ8M
Jg6GuUFQZ50VIuxZa5Mq1ubrAUba+1MDUNXZqT7p1dDf26gdrAP0z5Tzub7q4ESA
BN5jJgxV3ezD7ZB22K/RKFNLee15Lr8QO2R2LSYM0k9PXF88PnrPyaBH7ytEMefY
+UVMGyaL7ouTYrBU/FeK8jpPTHaePNNzct/xUF4Oh6xDHqx6RHrw+X4Lrh6gtwKh
gydOzsJ8aLnNyfKnnelxb/f7XRdT90HRMxI2QJ98RZKxlnPyHXN8NT/xrNDC6QnB
sRMCvkSqySbPDa21IIwL5nUCNxp7MA==
=zL5A
-----END PGP SIGNATURE-----

--Sig_/teycTZNgREgDu/GHd9yJThK--
