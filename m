Return-Path: <linux-kernel+bounces-6110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C98F8194BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE3A1F2342B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E2C3FB04;
	Tue, 19 Dec 2023 23:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WyRKwk0t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15143EA7D;
	Tue, 19 Dec 2023 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703029656;
	bh=yG7epzk7fodBt427P9omimt0DRcleEmV5g9hp/dhs9Q=;
	h=Date:From:To:Cc:Subject:From;
	b=WyRKwk0tYsa/jB71M+fNNx5RKP1TTRuAkQIP7opN2wHz4/uhIg/skV7yR5/QgalI2
	 9ZZ4x+bPfV1zgpuPPM7UBU7qfLI9cr0lhR9bjxsC4aQiV28m2X4kuBnpeyrsdmmxeo
	 L/QVc4hJXI3a4+HPadNtMNFBbyUynru8c6dZCghe9VFFjXjiQCiG1C+4FfcdTBsWJt
	 pnJqw+32uwZ1x7tLvLp+r44aAKma885Ye801DVdAM8/CQP+6xanavIZlH+6xAjboUb
	 n3xzTGMTgKJgC66RxvN7tUoktLLZdGzBwxwhdUpFdMShj50X5KvGp2tNkqyS9UFdEE
	 J7Bvt8ZJH4eew==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvtfH2JjLz4wd4;
	Wed, 20 Dec 2023 10:47:35 +1100 (AEDT)
Date: Wed, 20 Dec 2023 10:47:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, Jan Kara <jack@suse.cz>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the f2fs tree
Message-ID: <20231220104734.0979a9f8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5=M40P7dLA5C/mRQPI=9M=u";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/5=M40P7dLA5C/mRQPI=9M=u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/f2fs/namei.c

between commit:

  53edb549565f ("f2fs: fix to avoid dirent corruption")

from the f2fs tree and commit:

  7deee77b993a ("f2fs: Avoid reading renamed directory if parent does not c=
hange")

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

diff --cc fs/f2fs/namei.c
index ede6afb81762,fdc97df6bb85..000000000000
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@@ -1104,8 -1106,8 +1105,8 @@@ static int f2fs_rename(struct mnt_idma
  		iput(whiteout);
  	}
 =20
- 	if (old_dir_entry) {
- 		if (old_dir !=3D new_dir)
+ 	if (old_is_dir) {
 -		if (old_dir_entry && !whiteout)
++		if (old_dir_entry)
  			f2fs_set_link(old_inode, old_dir_entry,
  						old_dir_page, new_dir);
  		else

--Sig_/5=M40P7dLA5C/mRQPI=9M=u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWCK5YACgkQAVBC80lX
0Gw4qwf+PrXULbmLGlG3NKze/3B5ZSapHarkOg4bEeMAqWy9R9kUjDf2F13jk294
NVuiXgagmCdUdGO8BVv5V1/j6TmCegD7CdxRl5cZr4PEOYL7/mwCk39ao5HjAXEA
KPDc1MiZB9fTmX5EM6y99KXGJ+GX9s6fMl6Mm3iImU10b6eSPuGNhkau1UJQrEb6
evJl/uqMtNcN0QE+X6CqXIugQmj9uWpgD7N+PMASLKJbrWfs5AbJwJ90YJ0lhdvm
qkV9vl1NDtgBWfBURzQXXN1uAdBKFUSZZwj17S9lqfPqqb9+wgZa5P4XHtk+YhS/
NhpbpZbF1n879QUv+/c0w+qGL3B6cw==
=OCYL
-----END PGP SIGNATURE-----

--Sig_/5=M40P7dLA5C/mRQPI=9M=u--

