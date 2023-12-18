Return-Path: <linux-kernel+bounces-2995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7548165B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F7F1F21515
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8913979E1;
	Mon, 18 Dec 2023 04:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tBbXiqYO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714479C0;
	Mon, 18 Dec 2023 04:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702874722;
	bh=ZXB6ZFNDe3ozZs3/77x3SEORE0DodjB1qFk+2S8Q/yQ=;
	h=Date:From:To:Cc:Subject:From;
	b=tBbXiqYOBeKWtzw+O+tG1vINmSfIyLCknz+OApbqSrsFqywrUjYeHMIjgCKlDUO6Q
	 q+MNphtZy6ee+3ROqfPu1L2hCuWLzFFuwMzjX9zvCEN2tcNic8ptuxd9MSsc32p7cM
	 xTCrZ1Eltfwg2y4x2R1Rfj0NSl7wbBB2JgrHFQZgwC1/PpMBDxFpxNzbQjmmkG6511
	 A33pw27eMKrwnDluq/niZkCRivsNyXIVzuvgqk/2Ujbcagj0ksw63XNWX6HY2hj/dx
	 qgkyJ72XtDmoiBQd98xDzrFzgk24jIuzbmnSkiYFvYANDrqa1jth4c9ILZGKsc5ure
	 ybQfhdwW9xIug==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4StnLp30zHz4xM2;
	Mon, 18 Dec 2023 15:45:22 +1100 (AEDT)
Date: Mon, 18 Dec 2023 15:45:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins
 <brendanhiggins@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Michal Wajdeczko
 <michal.wajdeczko@intel.com>, Rae Moar <rmoar@google.com>
Subject: linux-next: manual merge of the kunit-next tree with Linus' tree
Message-ID: <20231218154521.2394ed2c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8C8pzyDxSCAHjp_ftBpRCd9";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8C8pzyDxSCAHjp_ftBpRCd9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kunit-next tree got a conflict in:

  lib/kunit/test.c

between commit:

  2e3c94aed51e ("kunit: Reset suite counter right before running tests")

from Linus' tree and commit:

  6d696c4695c5 ("kunit: add ability to run tests after boot using debugfs")

from the kunit-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc lib/kunit/test.c
index 7aceb07a1af9,e803d998e855..000000000000
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@@ -708,8 -675,11 +713,13 @@@ int __kunit_test_suites_init(struct kun
  		return 0;
  	}
 =20
 +	kunit_suite_counter =3D 1;
 +
+ 	/* Use mutex lock to guard against running tests concurrently. */
+ 	if (mutex_lock_interruptible(&kunit_run_lock)) {
+ 		pr_err("kunit: test interrupted\n");
+ 		return -EINTR;
+ 	}
  	static_branch_inc(&kunit_running);
 =20
  	for (i =3D 0; i < num_suites; i++) {

--Sig_/8C8pzyDxSCAHjp_ftBpRCd9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/zmEACgkQAVBC80lX
0Gzr5Qf/TRS7iuYjnSrBZanWQ49Ai1Qpo6HKAxwGtQ3L2MAl08Y6+N7P1EUe7Wxp
W8tbPwkQlSSvaRasPvFdSOgJmvrSqC8q8U7ghiFeQHn57raKHj5AQqtF7tsgwoxf
3EHQwE0rtkdf3b8nO6KuX+sYExd1W4vgtMg9TXdjG3Ub7jvNvYKcZ0FNtzlfQVNK
yfDtx5aNF7kFtT2qeCS90iLVB+tNyXGkhp7lViRtcCnuRJmkCkfpP4Y9nD33q52A
67jDiMt2Itwb8ITLEg+5ZoWuCkJgEu0z0u47HxCxTmSV72rLG6h9phbU1iAS5Xnj
mCdBhC9VrsGgToRWMnH+KYILh6WWMQ==
=TBja
-----END PGP SIGNATURE-----

--Sig_/8C8pzyDxSCAHjp_ftBpRCd9--

