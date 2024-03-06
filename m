Return-Path: <linux-kernel+bounces-93333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07CF872E25
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928281F25F81
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49EA17BBB;
	Wed,  6 Mar 2024 04:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LiHnLMQ/"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60175381;
	Wed,  6 Mar 2024 04:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709701117; cv=none; b=BKYKgokqtwnY5IcP4M2p6mkElHkk9uIBVmTkKJIyVajcouFk55TXJ3eFMpjMiTR6hl1/dS6+lXxhbd6L2CquRNFYoeKYAxLgvr2TD7cBT5k6vl/i7toBZpXNmfYp14uOY3HePTVeDE6hBqHn3a9Qsjd5NfUINnWYIb0kRWrR0+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709701117; c=relaxed/simple;
	bh=Ng4yCDJUFf7AsA+mW7MYhLdiv+ODMuRw3ugn5yMdrGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlNeXzuwRnm/5j4hZFfO2yQhKUDg5X81SB2DYPhG6+lJQh7NuaZjMrPqzZzK/nHpLBcvsNpQaIGJbZdTlVwVyUkjZo3MPGA1OdWrZiuah1dxVMkF6QFMruuS+dHEOeTj6LAeiykpeyhHmINHV4QRC21OmfkfxC7ukV1o5J3n3Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LiHnLMQ/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709701112;
	bh=rYzytA2EULgmi8e25mqyeKqvjpQhuWt3ra9rU0+8Z5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LiHnLMQ/cDjoVf2SgFXDoBQ/KoWNpQR5FhdQcrJvDcnJZr3FPu6p+bmG0q+VhxER7
	 DBsFoS0mrtdZ/Ldg+pM3osmNVWlXYOsGhqae6QgJAZM3pBnAR9rWr3GijgJkgnGzkM
	 AdoGLpffiORyvNwOqjr0O4xD6vh7uzkjB4oXhgYW8tpUZ2JomSzxZUtyoEZBgb2bgT
	 qR9z6FL87SuywlvSHBge1cU6Qxj+sKnzhPp4ZZZ8Ks50dzeco2lFK2nWcKo8vAvYIZ
	 3MKzuy7JBDsmqR7qzOkz1ItT3Z608luRro3er5iAyj9Cd6jfZfkcAhMmW0h+R+YzMa
	 BnuQDiZu/yLRQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqKvW4p6Qz4wc4;
	Wed,  6 Mar 2024 15:58:31 +1100 (AEDT)
Date: Wed, 6 Mar 2024 15:58:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Tong Tiangen
 <tongtiangen@huawei.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the vfs-brauner tree
Message-ID: <20240306155830.78bd7895@canb.auug.org.au>
In-Reply-To: <20240306153703.499661d2@canb.auug.org.au>
References: <20240306105150.06a456da@canb.auug.org.au>
	<CAHk-=whdTCEDaUPTMHUQXPQHuM8dhBi8yWbNAL11yE_ODqR_uA@mail.gmail.com>
	<20240306153703.499661d2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z7LM7vHarhCNmirND9+5NCJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Z7LM7vHarhCNmirND9+5NCJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 6 Mar 2024 15:37:03 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Tue, 5 Mar 2024 18:48:30 -0800 Linus Torvalds <torvalds@linux-foundati=
on.org> wrote:
> >
> > On Tue, 5 Mar 2024 at 15:51, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote: =20
> > >
> > > fs/coredump.c: In function 'dump_user_range':
> > > fs/coredump.c:923:40: warning: left-hand operand of comma expression =
has no effect [-Wunused-value]
> > >   923 | #define dump_page_copy(src, dst) ((dst), (src))
> > >       |                                        ^
> > > fs/coredump.c:948:58: note: in expansion of macro 'dump_page_copy'
> > >   948 |                         int stop =3D !dump_emit_page(cprm, du=
mp_page_copy(page, dump_page));
> > >       |                                                          ^~~~=
~~~~~~~~~~
> > >
> > > Introduced by commit
> > >
> > >   4630f2caafcd ("coredump: get machine check errors early rather than=
 during iov_iter")   =20
> >=20
> > Bah. If comes from that
> >=20
> >   #define dump_page_copy(src,dst) ((dst),(src))
> >=20
> > and I did it that way because I wanted to avoid *another* warning,
> > namely the "dst not used" thing.
> >=20
> > But it would have probably been better to either make it an inline
> > function, or maybe an explicit cast, eg
> >=20
> >   #define dump_page_copy(src,dst) ((void)(dst),(src))
> >=20
> > or whatever. =20
>=20
> This became a build failure for my i386 defconfig build, so I did this:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 6 Mar 2024 15:28:12 +1100
> Subject: [PATCH] fix up for "coredump: get machine check errors early rat=
her
>  than during iov_iter"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/coredump.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/coredump.c b/fs/coredump.c
> index ea155ffee14c..5353b7ac67f2 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -920,7 +920,10 @@ static struct page *dump_page_copy(struct page *src,=
 struct page *dst)
> =20
>  #define dump_page_alloc() ((struct page *)8) // Not NULL
>  #define dump_page_free(x) do { } while (0)
> -#define dump_page_copy(src, dst) ((dst), (src))
> +static struct page *dump_page_copy(struct page *src, struct page *dst)
> +{
> +        return NULL;
> +}
> =20
>  #endif

On second thoughts I made it return "src" instead of "NULL";

--=20
Cheers,
Stephen Rothwell

--Sig_/Z7LM7vHarhCNmirND9+5NCJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXn9/YACgkQAVBC80lX
0Gx/6gf+O7V6/wSdScZBIivSYD+Tzu6hgfZJ9BVhcjZLOkVFXsaw5y/uIeeVijLR
Ow0i2z1j/adrryXeTPXTqiqqqBIW0jPKY7DV9NBdpdpWCoQ29hG9+smsjGVRwqdh
r4qQoCxm4XTgvBfJDkgIJh8vDA+FBwZ1B7m4THLli4wuy4QKzqGpHMijtIynmqpe
KRDivVglIyZqhGDV2ev3DxKHUonDBdOulKYCELE9gdsclTj0nwAt9agE5evnm/ds
7sLabpyiuk/IYDcnGPQLca8uDMl9qymac65HtSmSC3Y5jMhnRbK4dEqfS2sr822S
q4dOfWlhsjaJ69VfR0BcqwFPIg4Axg==
=54Ps
-----END PGP SIGNATURE-----

--Sig_/Z7LM7vHarhCNmirND9+5NCJ--

