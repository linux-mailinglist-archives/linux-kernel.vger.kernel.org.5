Return-Path: <linux-kernel+bounces-108412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FEB880A33
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B0F4B229A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E13E11C92;
	Wed, 20 Mar 2024 03:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LXzxLUT/"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BBE111AA;
	Wed, 20 Mar 2024 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906340; cv=none; b=NZOFm6nrRTnD54CpmzsxpUc5FvvZsrtRnugiy4e1Rii+g/mSObMvRupX59rAyMADSGo0gahsOhJQrPKeybxqYVxOGeUWvhZfAlLQBS+SUfYYMYDQwuxYo4ql2bZ3ZJT0vIUE+5bNCNPvbkKX+H4Yr3fQSG1njxbX/U/OVUFgEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906340; c=relaxed/simple;
	bh=9B+4hshcFckMEGWpcEnVtr4t0J2t6/ex9MYdj5oM1a4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nm4y792rjSmi6bapbmlewC6nTFmCJaUplmf5B/Pj3ZgtaBiMHEnWRWX+Sf1RxnvejD44sHzMdUkj8ZLZHd4A70knj6V/5E6vkiH3xxC71JTiNFpRXtBwLx4yGJfiDDcPpOidv5KYmMCD/t0CzqWunupR5bIAGjyiVasketI3ts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LXzxLUT/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710906332;
	bh=bR++7yPqt97FJl7Jg2JDn+hhtKQHx1x0+E2M0WcRl9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LXzxLUT/yzHx7/wlY07PpNPali9zPrM6dbUZTrZEce2r+ZOma1aWVtvDokWr33X3U
	 STer9Tmq4aJASu2m7zy+fp77+IgqzyfxsIJ7ymQQDs5DBhVkLsdDEuDEsht+7+OK9O
	 Xbd0B3VhWufMH03piI7hXtQGTGXEcpJ5tP/9WESdHyHO75psZxTCHeURaIb0yA6jch
	 ckN0tPHemQGr3DZoK22f15nov+y98rNO2MiBGJqRWNQ+hlarfF2675bFMg9VtVg+Hj
	 44v0q3X6klirlvbOSmawBpPyDiuKLYEdLbO7GGXL4hmj0IKsABi+hnoWD0JGPaKwuy
	 awIw2j2QdPjZQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tzvcr014Hz4wbp;
	Wed, 20 Mar 2024 14:45:31 +1100 (AEDT)
Date: Wed, 20 Mar 2024 14:45:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, Andrew
 Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Huacai
 Chen <chenhuacai@loongson.cn>, Herbert Xu <herbert@gondor.apana.org.au>,
 Guenter Roeck <linux@roeck-us.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] Documentation: coding-style: ask function-like macros
 to evaluate parameters
Message-ID: <20240320144530.4852845b@canb.auug.org.au>
In-Reply-To: <CAGsJ_4zpXwVEhsdffoZVBVWiwT4Lw2qEMrW-X92ib=kv=9Yx9g@mail.gmail.com>
References: <20240320001656.10075-1-21cnbao@gmail.com>
	<20240320124207.0c127947@canb.auug.org.au>
	<CAGsJ_4zpXwVEhsdffoZVBVWiwT4Lw2qEMrW-X92ib=kv=9Yx9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TO1BZgkbiVYW.I8uMU2NSDG";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/TO1BZgkbiVYW.I8uMU2NSDG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Barry,

On Wed, 20 Mar 2024 16:24:30 +1300 Barry Song <21cnbao@gmail.com> wrote:
>
> On Wed, Mar 20, 2024 at 2:42=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.o=
rg.au> wrote:
> >
> > On Wed, 20 Mar 2024 13:16:56 +1300 Barry Song <21cnbao@gmail.com> wrote=
: =20
> > >
> > > diff --git a/Documentation/process/coding-style.rst b/Documentation/p=
rocess/coding-style.rst
> > > index 9c7cf7347394..8065747fddff 100644
> > > --- a/Documentation/process/coding-style.rst
> > > +++ b/Documentation/process/coding-style.rst
> > > @@ -827,6 +827,13 @@ Macros with multiple statements should be enclos=
ed in a do - while block:
> > >                               do_this(b, c);          \
> > >               } while (0)
> > >
> > > +Function-like macros should evaluate their parameters, for unused pa=
rameters,
> > > +cast them to void:
> > > +
> > > +.. code-block:: c
> > > +
> > > +     #define macrofun(a) do { (void) (a); } while (0)
> > > + =20
> >
> > Maybe add some comment about using a static inline function for these
> > simple versions instead, if at all possible, (it is suggested just
> > above this section) since that will still type check arguments. =20
>=20
> right, what about adding the below section together with the above (void)=
 cast?
>=20
> +Another approach could involve utilizing a static inline function to rep=
lace
> +the macro.:
> +
> +.. code-block:: c
> +
> +       static inline void fun(struct foo *foo)
> +       {
> +       }
> +

Looks good to me.

--=20
Cheers,
Stephen Rothwell

--Sig_/TO1BZgkbiVYW.I8uMU2NSDG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX6W9oACgkQAVBC80lX
0Gyhhgf9H0RNoO9xgy7+XrcwZ2zfiLubuD4oRaT2LODstAcOZQEKvdZgCun5V7SV
dNLWDGUkILR7hHHhPSkfFz7qmJXheUxXmkNvbyovSoVQpKCfIJtVwO9AKnwdcafL
LMBPvD4Fp/b00pLJ8rfETSorRwbE20gD5+NwesE6EtXPuwODDn4zKRwWLJHEl4Wa
PCZto1uEF+6oO50pfHDTjI/e0YM73MtNDY0H/FnevXBJqvotvRJn78k4lF9vCe5x
12t/CiOLK8igzbmRH76Em3soUscClwwnPm8U54BEm4hf3Yn72+rFpJRFKjwejFcW
ErErslr5cReDA7sSPZfE/cJOjqQcmQ==
=8E06
-----END PGP SIGNATURE-----

--Sig_/TO1BZgkbiVYW.I8uMU2NSDG--

