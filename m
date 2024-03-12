Return-Path: <linux-kernel+bounces-99805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F2D878DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5CA1C21725
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C05BA26;
	Tue, 12 Mar 2024 03:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nBCE5odc"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1947BB651;
	Tue, 12 Mar 2024 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710215799; cv=none; b=QqcGIwux/CaXedBt2sCUhGFRefGwFTXsnWZFOkHNXMeLbSQEikv+tJAthaMXejSI14+Q8orKzQq+o8MABT2BlQ7ixIxRqQtvr6SHT/kcKBzON+a4V7mS9V/8IVAhNeoQ2HBS/gVc2sNakHsMvKyztW5F3nsH6SYzMaWwgOku5Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710215799; c=relaxed/simple;
	bh=P0HDXkEnXueZ/a9Cb4L4ZUX2gXNIBJoBJexeV69BvUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJnJ/hV1A86XDkfOn03hCroZp6UIDlHIyLOK2c+PWiOUaiVdzGNueuIN3oStaHCqjj2Ka5AxAwGXC6SJ5Y3+LGCDVLzUTvxv/05/H340O3s+PefQup1RNbnxE8hU2a4DkoLM9E8/dMrttJFBdpTW6dlREcQf91uUFjUjUW7S0dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nBCE5odc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710215793;
	bh=ZRfEgYuhOLeU8FcKbJbjpYSIYzHWtA6IwB6nv6WHwIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nBCE5odcc7lymLs7g4LeF+fitUtTJDQT3FAEzGEcq/Uwj2t7bcDPgbo2zuJyo/gTw
	 1CBrbpUN4hmSBJ0eR7hL1Hh5yp6KxFPP8uNFV5BwAlQJI6aAzQzg3DyWcMh80VaneK
	 oEm5uORoayggKJjeqs0V2mI0jTlAkQx48/Sn0AQnrR2WLJHCKN1s0Xr1eKtTWn52C5
	 BMUsOiFEKg0eQlh96L4aC1gK6oi3yNiwm761pIRzljhedKT3qzCb/VtIwLPg2rJ0mq
	 3C1SO3BPBBsOja0Hc8i3x6YEmRIi4IBzTsJkI0KKbf3td6G4l/fDdSwQCcFaKhCKnH
	 pmGavn35GCBsg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tv0FF2WxNz4wqN;
	Tue, 12 Mar 2024 14:56:33 +1100 (AEDT)
Date: Tue, 12 Mar 2024 14:56:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Kent Overstreet
 <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 bcachefs tree
Message-ID: <20240312145632.61aa94b3@canb.auug.org.au>
In-Reply-To: <20240226111257.2784c310@canb.auug.org.au>
References: <20240226111257.2784c310@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U_7LVwMzTdyk8yZ7idQwKOz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/U_7LVwMzTdyk8yZ7idQwKOz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 26 Feb 2024 11:12:57 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>=20
>   fs/bcachefs/super-io.c
>=20
> between commit:
>=20
>   2881c58d14b6 ("bcachefs: bch2_print_opts()")
>=20
> from the bcachefs tree and commit:
>=20
>   9f2f767f5ef8 ("bcachefs: port block device access to file")
>=20
> from the vfs-brauner tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc fs/bcachefs/super-io.c
> index 38a5073202c5,bd64eb68e84a..000000000000
> --- a/fs/bcachefs/super-io.c
> +++ b/fs/bcachefs/super-io.c
> @@@ -715,12 -715,11 +715,12 @@@ retry
>   			opt_set(*opts, nochanges, true);
>   	}
>  =20
> - 	if (IS_ERR(sb->bdev_handle)) {
> - 		ret =3D PTR_ERR(sb->bdev_handle);
> + 	if (IS_ERR(sb->s_bdev_file)) {
> + 		ret =3D PTR_ERR(sb->s_bdev_file);
>  +		prt_printf(&err, "error opening %s: %s", path, bch2_err_str(ret));
>   		goto err;
>   	}
> - 	sb->bdev =3D sb->bdev_handle->bdev;
> + 	sb->bdev =3D file_bdev(sb->s_bdev_file);
>  =20
>   	ret =3D bch2_sb_realloc(sb, 0);
>   	if (ret) {

This is now a conflict between the bcachefs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/U_7LVwMzTdyk8yZ7idQwKOz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXv0nAACgkQAVBC80lX
0Gx3dgf+J1fXi/0QYbYQm3UOTItL8pNhwwACtf5m+5MqJr+hx1aGzew4M9wRpFQp
x3zaoHNUNFQIRi9jg1gW5wLs0WycH4HyS62sgsDFTL3kgtUvibrHPTTrJVakNwXM
3vvMZmCY7djwdHzF4qqsgNgu3z/dRJLrD1eG9P/fzhlvcdGEH596IwxDq82bHRMe
wHZ4Y8pDHJi5iLd6Ioxn0gfkV5cpAyY+ZfbN+7FMlKhR1b6Y92xrLiAHTZLmlKbY
Q+OeW9wkdRoWbvOQPaZqRsuwHYfNRQq8gtjbEYgM1vqW6X6yoYx8bPlyYqbHmeKw
Xg1sN+QOg9C5AMjRlzUe766w0sjW2Q==
=Zo91
-----END PGP SIGNATURE-----

--Sig_/U_7LVwMzTdyk8yZ7idQwKOz--

