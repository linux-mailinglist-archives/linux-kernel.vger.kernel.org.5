Return-Path: <linux-kernel+bounces-6119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9492B8194D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494121F2242D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BF640BEC;
	Tue, 19 Dec 2023 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GOFGxc/E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03F40BE3;
	Tue, 19 Dec 2023 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703030168;
	bh=NLVVHDWoo4m9iV9XvG532dnuIVRB29z5UhevReT02ss=;
	h=Date:From:To:Cc:Subject:From;
	b=GOFGxc/EXg4t8Q81hlp7wTBJEzma4pTGro4f+Ku01X+fHL19gw6Wpe8ElOYWhSQL7
	 8kWez2H7MtSv3unqU1vGc7xZbsx4r6cAQJRY2eCUjUEAsslqChDSXJSFo3qIEA/6cc
	 Uyak7e09rnA/RuOleRw0VacSqoGSITzmByv9YbH/OWxLkHZtLckBjHU+gWU+7qfi/1
	 GDAh78GAZvG3TpDIlbsQPG8sndNsVLfoGQSDD2Xuyz2m0es/eImTdNvi/sNF+9RU0y
	 grEdvV5QDDA0RRACyPximZtPItWkeGzsuLfJHSbYLlQ3D1XktDULHo1tlOgaTsogwq
	 myp8nwp313cOw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Svtr65D82z4wdB;
	Wed, 20 Dec 2023 10:56:06 +1100 (AEDT)
Date: Wed, 20 Dec 2023 10:56:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the overlayfs-fixes
 tree
Message-ID: <20231220105605.6f288fb6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6g6=DC18imHbQW_6+JNOh7b";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/6g6=DC18imHbQW_6+JNOh7b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/overlayfs/copy_up.c

between commit:

  413ba91089c7 ("ovl: fix dentry reference leak after changes to underlying=
 layers")

from the overlayfs-fixes tree and commit:

  a8b0026847b8 ("rename(): avoid a deadlock in the case of parents having n=
o common ancestor")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/overlayfs/copy_up.c
index 696478f09cc1,e44dc5f66161..000000000000
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@@ -779,13 -757,14 +779,15 @@@ static int ovl_copy_up_workdir(struct o
  	 * lock ordering with sb_writers, which shouldn't be held when calling
  	 * ovl_copy_up_data(), so lock workdir and destdir and make sure that
  	 * temp wasn't moved before copy up completion or cleanup.
 -	 * If temp was moved, abort without the cleanup.
  	 */
  	ovl_start_write(c->dentry);
- 	if (lock_rename(c->workdir, c->destdir) !=3D NULL ||
- 	    temp->d_parent !=3D c->workdir) {
+ 	trap =3D lock_rename(c->workdir, c->destdir);
+ 	if (trap || temp->d_parent !=3D c->workdir) {
 +		/* temp or workdir moved underneath us? abort without cleanup */
 +		dput(temp);
  		err =3D -EIO;
+ 		if (IS_ERR(trap))
+ 			goto out;
  		goto unlock;
  	} else if (err) {
  		goto cleanup;

--Sig_/6g6=DC18imHbQW_6+JNOh7b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWCLZUACgkQAVBC80lX
0Gy9ZQf/TKvMMRNi2k9D3lsqVxFiufLXa2OFmMjxwlWt31G/X7V0Xahdf4Rsbiye
n8x6fxhIHw4Q8dnGjVxHibQqChCb7LCzIW/g7Wdk3LlgnnBRzxBeJWNKN04309LA
LHw943nz7ZLTgilDCs6Yztzf7Rzlj6fT/guFCxDIEqK2bGhS/KSoIFO10fO+kdI4
p23fevEVZIH7WuzTeQHtDln+29HWBGVKjfhrB7yeVhzlOTmm1UX7b73DRS44RfV3
C5sCicivmXoBau2TKyb0hpOPN9dtHH2aTjfbGIToDzC77DAjgGeKf/C8GbUIi7ID
6cLLrcDDrRc7FXNfNSKIzQNCc7Bc3A==
=fRHf
-----END PGP SIGNATURE-----

--Sig_/6g6=DC18imHbQW_6+JNOh7b--

