Return-Path: <linux-kernel+bounces-82680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBDB86883D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09DB61C21DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C59451C5B;
	Tue, 27 Feb 2024 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F4Sm18lO"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61572B9A7;
	Tue, 27 Feb 2024 04:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008484; cv=none; b=ML6/ZVkEncOTUqmSYiYXGb7SfuJXhFjfJY8b/XRQ2nIGeh+uNZUcgwqt45/txgLChr6n67paJ1F4JGl78zlGS7OYfm445bmqlQgoHk4RgyUpGWkMCUs8sF9ZiL7bYhGFadhqbd6aLuDLiqNEJzgy3ws88RV4e1+YE0Bh3fwwneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008484; c=relaxed/simple;
	bh=cuj1qUMwkwqal3wJi++jUQc8HyxAwqdh0KK9n4dY4AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=elcdTtICWKRfCp63PmPcuySufg1D+YryrcglK1KXGDjtcuL2j9YNgMghAs4D8W8YbYI3+EDtTWutiJ6KeyugM1FSdnr/RKq/YVkiY8hsTZGFWyxJw9XvcM+F9mMaj7cqryWP5SHBvrB9BSP7fAhKBhm6Rk/tWnOLblnoRey8AMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=F4Sm18lO; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709008478;
	bh=ZubsrjAWW/NJzZZIwHM2+7xSQE59xmHAfiJ9B/Vsi7c=;
	h=Date:From:To:Cc:Subject:From;
	b=F4Sm18lO7JaX7OKKGNtETXD5g46ahQoOji04n8nkYoh5xLtpp9ECrB5cd7iIc/qw7
	 PoWbo0d+ZeZN/vZT8hLwFbfvTTAM+/uHantKCygN4bJrqmqgKWGiCdYkYGKCY/Hw1l
	 QP9L9AOKvraBoypBJFsKgd5qIonIsgIxdbi3x+TkM54gPkeuo9+qeT5pzwps6kua8r
	 3JpyzLreuYnfqONXR4APEEKKG9SME4aF/vsIanXcvsxYZnAKbhFHto9JhtRj0wFFw/
	 oru5SEqFkLtu9WtftLmBxJp+JDSJnGSRWd5PSo1aqhl2esjlrShGqHFdgcWhqJwtqZ
	 KvYUnC+VcGZzA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TkPld6jF6z4wb1;
	Tue, 27 Feb 2024 15:34:37 +1100 (AEDT)
Date: Tue, 27 Feb 2024 15:34:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Christian Brauner
 <brauner@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the scsi-mkp tree with the vfs-brauner
 tree
Message-ID: <20240227153436.33b48d59@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MeiyNFOgM8tiHX4pUpn/CjE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/MeiyNFOgM8tiHX4pUpn/CjE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  fs/iomap/buffered-io.c

between commits:

  dec3a7b3aa45 ("iomap: move the iomap_sector sector calculation out of iom=
ap_add_to_ioend")
  ae5535efd8c4 ("iomap: don't chain bios")

from the vfs-brauner tree and commit:

  449813515d3e ("block, fs: Restore the per-bio/request data lifetime field=
s")

from the scsi-mkp tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/iomap/buffered-io.c
index ae4e2026e59e,18e1fef53fbc..000000000000
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@@ -1687,11 -1666,11 +1687,12 @@@ static struct iomap_ioend *iomap_alloc_
  	bio =3D bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
  			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
  			       GFP_NOFS, &iomap_ioend_bioset);
 -	bio->bi_iter.bi_sector =3D sector;
 +	bio->bi_iter.bi_sector =3D iomap_sector(&wpc->iomap, pos);
 +	bio->bi_end_io =3D iomap_writepage_end_bio;
+ 	bio->bi_write_hint =3D inode->i_write_hint;
  	wbc_init_bio(wbc, bio);
 =20
 -	ioend =3D container_of(bio, struct iomap_ioend, io_inline_bio);
 +	ioend =3D iomap_ioend_from_bio(bio);
  	INIT_LIST_HEAD(&ioend->io_list);
  	ioend->io_type =3D wpc->iomap.type;
  	ioend->io_flags =3D wpc->iomap.flags;

--Sig_/MeiyNFOgM8tiHX4pUpn/CjE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXdZlwACgkQAVBC80lX
0GzcSgf/UxYFTALdqUp3ahMgXH5MFOhQKx3OQynlTtdxcjwy2bQjwMdnZIBOXwnN
ynd49GXuuJ9NeJF7ry8lUcq1FD+Hl6lEPU1tVI6wiID8R3zFdZ25t93NvyzwwyOv
dShK2WTlZyXgcd4oOZom2uRr19EZWJWu+99r7FhEWJ+/irsh22Z91r4vg7si5lLB
Np0XOuIdiIyu6yZW/U+TtJJ959hVpepHiv8/JobXXn7z6aXDyZq0tXZEr+D7mRDi
BjyOTDZ42k2Fwhc1GbNA+o4QxoQQuVrXV1GvDy/PCng9BAd2LuNZ4VLkQHKvZPMJ
1loVJ02lQ+5knNCK9U9kjVJWj0QJlA==
=1moF
-----END PGP SIGNATURE-----

--Sig_/MeiyNFOgM8tiHX4pUpn/CjE--

