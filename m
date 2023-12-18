Return-Path: <linux-kernel+bounces-3043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2E1816681
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1821C222E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DA06FB5;
	Mon, 18 Dec 2023 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kgVug3ij"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8266FA2;
	Mon, 18 Dec 2023 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702880976;
	bh=VIr1Qg8hRwXOHwauYTH9ptmHgfQl036lsyUBTHTHMek=;
	h=Date:From:To:Cc:Subject:From;
	b=kgVug3ijdrFIK/vPvAJh6HwsiFTCxrDOYmrjy42PsNqz/V0wMZ2CU2rlBcZBmfuXJ
	 vU+vEeonsmk0YeszVKXd7aNMXUTMDkHsxrHPRzRz/HFslUHIKkmYUuSA7cA8OFCfrt
	 liQbSEmq3MM7qTeCwxhnVdeIuHY1zIr3Oz4OMVwllAQVBgXAa4hvV5kgIabzTDpBYC
	 ZgwSrwfJtmqsNwBUdR4NAIKw2gDGGJlYwAhsv2AT+ZEKRZkZlvEaREAWsHtKJ6gKMO
	 cQAkN68fl5FC9D7Dk0VFK22xXKDksZvKKPyKMGcuzKvA9bGPSAUMgd5tEwoDy/63lm
	 5gk8C79ujMYjQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Stqg42znVz4wch;
	Mon, 18 Dec 2023 17:29:36 +1100 (AEDT)
Date: Mon, 18 Dec 2023 17:29:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the header_cleanup tree
Message-ID: <20231218172935.0730d54c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v_qSPXxUfm_d/nv8om4z/te";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/v_qSPXxUfm_d/nv8om4z/te
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the header_cleanup tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/linux/uaccess.h:12,
                 from include/linux/uio.h:9,
                 from include/linux/socket.h:8,
                 from include/linux/compat.h:15,
                 from arch/powerpc/kernel/asm-offsets.c:12:
arch/powerpc/include/asm/uaccess.h: In function 'copy_mc_to_user':
arch/powerpc/include/asm/uaccess.h:374:13: error: implicit declaration of f=
unction 'check_copy_size' [-Werror=3Dimplicit-function-declaration]
  374 |         if (check_copy_size(from, n, true)) {
      |             ^~~~~~~~~~~~~~~
include/linux/uaccess.h: At top level:
include/linux/uaccess.h:66:1: error: conflicting types for 'check_copy_size=
'; have 'bool(const void *, size_t,  bool)' {aka '_Bool(const void *, long =
unsigned int,  _Bool)'}
   66 | check_copy_size(const void *addr, size_t bytes, bool is_source)
      | ^~~~~~~~~~~~~~~
arch/powerpc/include/asm/uaccess.h:374:13: note: previous implicit declarat=
ion of 'check_copy_size' with type 'int()'
  374 |         if (check_copy_size(from, n, true)) {
      |             ^~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Caused/exposed by commit

  f95cbe69154f ("thread_info, uaccess.h: Move HARDENED_USERCOPY to better l=
ocation")

I have reverted that commit for today.

I then got this:

arch/powerpc/kvm/book3s_64_vio.c: In function 'kvm_spapr_tce_release_iommu_=
group':
arch/powerpc/kvm/book3s_64_vio.c:103:17: error: implicit declaration of fun=
ction 'cond_resched_rcu'; did you mean 'cond_resched_lock'? [-Werror=3Dimpl=
icit-function-declaration]
  103 |                 cond_resched_rcu();
      |                 ^~~~~~~~~~~~~~~~
      |                 cond_resched_lock
cc1: all warnings being treated as errors

and this:

arch/powerpc/kernel/interrupt.c: In function 'syscall_exit_prepare':
arch/powerpc/kernel/interrupt.c:275:9: error: implicit declaration of funct=
ion 'rseq_syscall'; did you mean 'si_syscall'? [-Werror=3Dimplicit-function=
-declaration]
  275 |         rseq_syscall(regs);
      |         ^~~~~~~~~~~~=20
      |         si_syscall  =20
cc1: all warnings being treated as errors

For which I applied this:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 18 Dec 2023 17:26:13 +1100
Subject: [PATCH] fix up for some header_claenup patches

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/interrupt.c  | 1 +
 arch/powerpc/kvm/book3s_64_vio.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrup=
t.c
index c4f6d3c69ba9..94e9e2cdc557 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -4,6 +4,7 @@
 #include <linux/err.h>
 #include <linux/compat.h>
 #include <linux/sched/debug.h> /* for show_regs */
+#include <linux/rseq.h>
=20
 #include <asm/kup.h>
 #include <asm/cputime.h>
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_=
vio.c
index 14c6d7e318da..b569ebaa590e 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -20,6 +20,7 @@
 #include <linux/iommu.h>
 #include <linux/file.h>
 #include <linux/mm.h>
+#include <linux/rcupdate_wait.h>
=20
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/v_qSPXxUfm_d/nv8om4z/te
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/5s8ACgkQAVBC80lX
0Gz1rgf8D+VMexFZv47V+quoaTGRr2QUmkFTv41GxordrhJnyeg04V5ysFqALIpr
k8ZXyEAjhcdpd++BI+b96znDA3OWTv985VeZHBHBz/Jd7RP0QpMfGvu34IgLlrCC
TIAOey/Xw+XFOD7qaiYrcPU0jTurtMjCvbdNUOqXemx3hiab3uYqKEO4+kVJseCi
6sQSfDIdeiCoTrgGG1B9esx0XthuIrOo3Mh35k3RRtljAR3vUIHUbMux99sdfy5o
I78Wnrvx04Z6YWkpQuv/GwpCfXMexcK4uEJzhOYkvv5ZTgBGR8qcoVQBmTvaNePW
8jnF9BFdZmIxAtWUFs7qz3Yq3Suunw==
=5H7R
-----END PGP SIGNATURE-----

--Sig_/v_qSPXxUfm_d/nv8om4z/te--

