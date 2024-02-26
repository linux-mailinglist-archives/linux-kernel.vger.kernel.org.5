Return-Path: <linux-kernel+bounces-82440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3329086849A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F9BB21B48
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E1F135A63;
	Mon, 26 Feb 2024 23:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MCwtZwGa"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B5A13541B;
	Mon, 26 Feb 2024 23:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708990114; cv=none; b=EtMAEFNYkGfe+0Pn3jy6v0N2Z0MUNll96TlU2A8LWZynDuypozqfqp/VtbXg4n1rF287fKAE66eUfTBtVj7iK3Jn5efC+xvTYexhUqmGW6epQdZxox56YTStjLAPrYuMPwtscVSkg9RQqNHkkpMYq8cGGw1pzk6RFGtvOnqeCcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708990114; c=relaxed/simple;
	bh=vpnQdb+6rc5A4iBkipWUZqFQkOPYet+kLGEWv6NTJ4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=S3DO/VXeg4UGS0+HJzbvHcwErRgTVRHW4IV1/RjqAndrc4WKSgUWK00nOOrQ3ko5nTqvpWoqg3HKjnKwVb4gmjxgL3cTvYguob2PGaGopA0plg9IfniZeD9yrS/EaR/jYoYC4fXP/Sn5CdMK2oRim/S6EQ9MlNP1qIXYPotbjWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MCwtZwGa; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708990108;
	bh=7/s82SZsxC7vPzBKKfBkGYTuP9xvJQUaq4CPgmdV56c=;
	h=Date:From:To:Cc:Subject:From;
	b=MCwtZwGaX48rjnIvqpbI546NJeYqWMA2DuG4VFwG7vtceyrx7N8O97G9b0gf6CQmz
	 r6JMkAFBT32KjrOAs7DYkOZg3GCK3ABN9WEhSbq7lRCFeb/EoWC0sJB414J/2tRLqj
	 8mVVi7sEOsjfTaGk/NPg9MV+VsUjp5lH8LKS+LqR/MI9Ug23URenlrtymskpJOHzOO
	 gmR1cgcIGxXWhjuAAXBRt7ZSIhG8tzkIWr7V+Lza6PGIt26ZXQE9/N0k6gMakNIIiz
	 5DXodFRRBloosIbnfWx7aprGeiVqh2j4boyU2et+fS1lYhOY5Y/55Ss/0BYOjvfjen
	 jK4LIYHkGViOQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TkGyM6Tslz4wc1;
	Tue, 27 Feb 2024 10:28:27 +1100 (AEDT)
Date: Tue, 27 Feb 2024 10:28:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, David Chinner <david@fromorbit.com>
Cc: <linux-xfs@vger.kernel.org>, Chandan Babu R <chandanbabu@kernel.org>,
 Dave Chinner <dchinner@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the xfs tree
Message-ID: <20240227102827.313113cd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zMghNRgdfH=5PkYXoN51Xav";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/zMghNRgdfH=5PkYXoN51Xav
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/xfs/xfs_buf.c

between commits:

  d4c75a1b40cd ("xfs: convert remaining kmem_free() to kfree()")
  5076a6040ca1 ("xfs: support in-memory buffer cache targets")

from the xfs tree and commit:

  1b9e2d90141c ("xfs: port block device access to files")

from the vfs-brauner tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/xfs/xfs_buf.c
index 7fc26e64368d,01b41fabbe3c..000000000000
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@@ -2030,8 -1951,9 +2030,8 @@@ xfs_free_buftarg
  	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
  	/* the main block device is closed by kill_block_super */
  	if (btp->bt_bdev !=3D btp->bt_mount->m_super->s_bdev)
- 		bdev_release(btp->bt_bdev_handle);
+ 		fput(btp->bt_bdev_file);
 -
 -	kmem_free(btp);
 +	kfree(btp);
  }
 =20
  int
@@@ -2095,20 -1994,20 +2095,20 @@@ out_destroy_lru
  struct xfs_buftarg *
  xfs_alloc_buftarg(
  	struct xfs_mount	*mp,
- 	struct bdev_handle	*bdev_handle)
+ 	struct file		*bdev_file)
  {
 -	xfs_buftarg_t		*btp;
 +	struct xfs_buftarg	*btp;
  	const struct dax_holder_operations *ops =3D NULL;
 =20
  #if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
  	ops =3D &xfs_dax_holder_operations;
  #endif
 -	btp =3D kmem_zalloc(sizeof(*btp), KM_NOFS);
 +	btp =3D kzalloc(sizeof(*btp), GFP_KERNEL | __GFP_NOFAIL);
 =20
  	btp->bt_mount =3D mp;
- 	btp->bt_bdev_handle =3D bdev_handle;
- 	btp->bt_dev =3D bdev_handle->bdev->bd_dev;
- 	btp->bt_bdev =3D bdev_handle->bdev;
+ 	btp->bt_bdev_file =3D bdev_file;
+ 	btp->bt_bdev =3D file_bdev(bdev_file);
+ 	btp->bt_dev =3D btp->bt_bdev->bd_dev;
  	btp->bt_daxdev =3D fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_of=
f,
  					    mp, ops);
 =20

--Sig_/zMghNRgdfH=5PkYXoN51Xav
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXdHpsACgkQAVBC80lX
0GxrnggAkx3gftIJ07lW96LpqENWFh7RzH4cT5vUQTE2bBbRGNBXCGc/aVwwXrjm
Y/iZcJE8C1Nj/iw7aFVqHrAia0ua5aI/KmjLvGPIMzhS7AAorZEqpfNj9Hpv6ZHh
hfla0emge+q2g1vH91aFmr24BAEdpjsjNspmbjsZ+sg2pEljcuF0L61Miqpu8AUd
YA0apU4pthA+3M9f5EaX6XRmhLxLeYZ73if4a586rldUr/TmF6hgugNY/PbFvVHx
g3Js19WVLoiHWOLUxM2HB9JjihIasPmka17Dsrn3GVWtv6tU2EMEqvg1OpCPaw+S
Y9ugshaujilSFahd0skL67Y6A4Rsjg==
=oNoD
-----END PGP SIGNATURE-----

--Sig_/zMghNRgdfH=5PkYXoN51Xav--

