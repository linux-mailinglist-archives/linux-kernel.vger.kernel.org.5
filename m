Return-Path: <linux-kernel+bounces-164800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F68B8314
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63443284CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF1F1C0DDC;
	Tue, 30 Apr 2024 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VWi7EKM4"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD5C17BB03;
	Tue, 30 Apr 2024 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714520557; cv=none; b=oA9+sVzymwHdEuoJTiA0C6U/T6eYdVoN51OadA7fUjc2/FMvepRgnRdY5TzLVSrnRPtIbNv9e+/gzitEzRv5OuiPqWrNegfehMvHMSTJn0yfos9iBKtq2OZyD1WTIDjyjqyPAklFy3fAZXUFD+orSW4pJqtmv6v9tnBeY1epbuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714520557; c=relaxed/simple;
	bh=c6byu4HPPJHiJZcQambXKTMqQJaSgmyKOamKTer2ty4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=U8KNB7vBPFFwJS4QX7qt/tl2y0V0byhvM11i5tx+Cl4Ccyf6UEM0uLxrYSjWVnFYlwMVHs6jv1Ui5fiEEfD42DOD269KZshPtiG4RWtmiHzKa3SpWBQSoMCToyL9SAQTG4pqCvSEr4ui+Kw40P2Nb/Q4sYiJ5riramaprjX+c5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=VWi7EKM4; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714520551;
	bh=xbunJ5OcIDonnVpVTL2J5YIyoWMJuay5GJpZGead/zw=;
	h=Date:From:To:Cc:Subject:From;
	b=VWi7EKM4DrctmgJtaiOyDXSCHJhwlVEs1a8ur2YVIimrFOccyCAEVBoo7SIG8ABSU
	 7Qz6Pbkbl6Y4rWH8HLmUSmoeIZ6Cg6a5VQ3otzqhP8P8Gv3t5x9ycOtWZOC5MYrbWH
	 xztJJv/OVorqXm221pa9uXQzzk7ozr5QaNDuiszfUONcHZNTKHX+oa/Upe2mng9uzz
	 8tC4IGg+8NF3zpZUozIZWdAWKuylc7XY5F+rXD6JhuKj+hhBL+pQKw5+STZ2mlPtYT
	 IHQ3sdrA1v4yIwbaM24NV+HGu2nPwBvWL0GPMnU5Qy2MY5iSjLTC073C3oLtxHjAhA
	 U5E7LgNY65/9Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VTcF22zGpz4wxf;
	Wed,  1 May 2024 09:42:30 +1000 (AEST)
Date: Wed, 1 May 2024 09:42:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.cz>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20240501094229.4f501d69@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pI5tsj8iZQnUAS7mr21D3sz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/pI5tsj8iZQnUAS7mr21D3sz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/btrfs/disk-io.c

between commit:

  5c855642bbb9 ("btrfs: Use a folio in wait_dev_supers()")

from the btrfs tree and commit:

  db3102368e1b ("use ->bd_mapping instead of ->bd_inode->i_mapping")

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

diff --cc fs/btrfs/disk-io.c
index 6b3720b13939,f10e894b0bf5..000000000000
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@@ -3739,9 -3738,10 +3739,9 @@@ static int write_dev_supers(struct btrf
  			    struct btrfs_super_block *sb, int max_mirrors)
  {
  	struct btrfs_fs_info *fs_info =3D device->fs_info;
- 	struct address_space *mapping =3D device->bdev->bd_inode->i_mapping;
+ 	struct address_space *mapping =3D device->bdev->bd_mapping;
  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
  	int i;
 -	int errors =3D 0;
  	int ret;
  	u64 bytenr, bytenr_orig;
 =20
@@@ -3855,19 -3855,29 +3855,19 @@@ static int wait_dev_supers(struct btrfs
  		    device->commit_total_bytes)
  			break;
 =20
- 		folio =3D filemap_get_folio(device->bdev->bd_inode->i_mapping,
 -		page =3D find_get_page(device->bdev->bd_mapping,
++		folio =3D filemap_get_folio(device->bdev->bd_mapping,
  				     bytenr >> PAGE_SHIFT);
 -		if (!page) {
 -			errors++;
 -			if (i =3D=3D 0)
 -				primary_failed =3D true;
 +		/* If the folio has been removed, then we know it completed */
 +		if (IS_ERR(folio))
  			continue;
 -		}
 -		/* Page is submitted locked and unlocked once the IO completes */
 -		wait_on_page_locked(page);
 -		if (PageError(page)) {
 -			errors++;
 -			if (i =3D=3D 0)
 -				primary_failed =3D true;
 -		}
 -
 -		/* Drop our reference */
 -		put_page(page);
 -
 -		/* Drop the reference from the writing run */
 -		put_page(page);
 +		/* Folio is unlocked once the IO completes */
 +		folio_wait_locked(folio);
 +		folio_put(folio);
  	}
 =20
 +	errors +=3D atomic_read(&device->sb_wb_errors);
 +	if (errors >=3D BTRFS_DEV_PRIMARY_ERROR)
 +		primary_failed =3D true;
  	/* log error, force error return */
  	if (primary_failed) {
  		btrfs_err(device->fs_info, "error writing primary super block to device=
 %llu",

--Sig_/pI5tsj8iZQnUAS7mr21D3sz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYxgeUACgkQAVBC80lX
0Gxt2QgAlgu1lR9qVNZ8CIfvpJUsePvvuiktyXZTb0FfbQhJM/1oCil7wpa3N/hU
fuOduwWh+KG68KYoBkb5+Wo/xarEPWDc6gIBt9PDGp4FviJsonjtX+cVeZRS1Vza
F036T+K1pYKwXsuikTY5oaRrC5pu6zgcKGt5mXCy86wsXmU8GNmT7fEse3RdNcFs
itIw47i8wBm+G8h1sDupm+5nPSVswd3IKoRmRAVyndF4NJuM2m5PgA/JOtZcfOAg
qlJNlgzwGP00MvoliBVlHSP5FBGdSbq5x0ss05uVGWoKeNKxFqiZZmx47FI9Sgx0
ASz8FXjsoBKmMRlUqoChzmwYk9N3FQ==
=88yt
-----END PGP SIGNATURE-----

--Sig_/pI5tsj8iZQnUAS7mr21D3sz--

