Return-Path: <linux-kernel+bounces-157676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503008B1464
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9F52829B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8029A13DB8C;
	Wed, 24 Apr 2024 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdW7u1jz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470F1EB30;
	Wed, 24 Apr 2024 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989948; cv=none; b=lwhxseaODYWzZ0HXOTlU1KZp0e34Uan/pqvpa8nGE3Q/Ov1ywll0aZiux1bAz2LfjcR7r/3RFlDkwmyYDqbvivlCKZF4uqXl2er0wqxu/o/IzqAQkSB2Me3Ufq0y2HOtlWWqwSGXqo22WWSa6TbOJYgOTnwMHSddiXzNwsiHVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989948; c=relaxed/simple;
	bh=63hZPOmkSg+IK89rduMeX1CZgesVdUrWtwIPoEX0wx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2KLbRX3tRTEBzFSYukzKs0V8X1O77DPyL+LeM6haEv5gf1RYJpArUV7pOwTnjPzy2qvN6d0k32TjNoVm384wDgaf0H+4rVrMVpg90EPkTSsPJax0OBvjRtvWUU5oka9LQRf+LoPysP23Li9ebOadTPiNAT1TQpqM3BnZy7JvVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdW7u1jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CDFC113CD;
	Wed, 24 Apr 2024 20:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713989948;
	bh=63hZPOmkSg+IK89rduMeX1CZgesVdUrWtwIPoEX0wx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FdW7u1jzxAWuLqFr++Z5rwBUKGJKPRkGswnMGsR/iCqFctDOhNzWCIc/6iJw0CCBS
	 n/+rOibvY434+ZwL5uW15xDCcyFNfsmIBog8CnRpPnVPILZVhgxNehzvN6bBFu0aur
	 a3vJGoJhdyE42nR7hYu2kwKfMUIKdvMKprt5Cwm3mmIobl9kiDYzI1we4eY677dv4G
	 pZ4aes1aAviH4dpvMkL03Zwryw8/xQy52vOvJASrQBH4akfZrG5DrJRZCDinG+efHp
	 j7W5tt9JHJJEM7czNa0I3PK2cSQa48OBFPNnehePSbI6wDoOWc6pKVlp7oR+UzquKD
	 CcV3JBDWDME4Q==
Date: Wed, 24 Apr 2024 21:19:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clock, reset: microchip: move all mpfs reset code to
 the reset subsystem
Message-ID: <20240424-glazing-handsaw-4c303fef4f7e@spud>
References: <20240424-strangle-sharpener-34755c5e6e3e@spud>
 <722f31da34e5e1cfef05fb966f6c8c96.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rh9OexgCGdhps0bi"
Content-Disposition: inline
In-Reply-To: <722f31da34e5e1cfef05fb966f6c8c96.sboyd@kernel.org>


--rh9OexgCGdhps0bi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 11:33:32AM -0700, Stephen Boyd wrote:
> Quoting Conor Dooley (2024-04-24 01:42:08)
> > diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
> > index 7f3fb2d472f4..710f9c1676f9 100644
> > --- a/drivers/reset/reset-mpfs.c
> > +++ b/drivers/reset/reset-mpfs.c
> > @@ -121,11 +135,15 @@ static int mpfs_reset_probe(struct auxiliary_devi=
ce *adev,
> >  {
> >         struct device *dev =3D &adev->dev;
> >         struct reset_controller_dev *rcdev;
> > +       struct mpfs_reset *rst;
> > =20
> > -       rcdev =3D devm_kzalloc(dev, sizeof(*rcdev), GFP_KERNEL);
> > -       if (!rcdev)
> > +       rst =3D devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
> > +       if (!rst)
> >                 return -ENOMEM;
> > =20
> > +       rst->base =3D (void __iomem *)adev->dev.platform_data;
>=20
> Can use dev_get_platdata() here?
>=20
> 	rst->base =3D (void __iomem *)dev_get_platdata(dev);
>=20
> That's sad that a cast is necessary. Does it need __force as well? An
> alternative would be to make a container struct for auxiliary_device and
> put the pointer there.


Ye, I dunno if it was sparse that yelled at me, but either it or the
compiler didn't approve. I don't really like the casting in and out, but
the alternative I don't find elegant either, so I picked the one I deemed
simpler. I'm happy to go with whichever you prefer.

And re: __force, AFAIU that's only required while discarding the
__iomem, so the cast into the platform_data has one:
	adev->dev.platform_data =3D (__force void *)base;


--rh9OexgCGdhps0bi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZilpOAAKCRB4tDGHoIJi
0vP+AP9lEnMw5y7fvCuYaADjE2y57zzff3jp+ioyFjTJxoliCgEAyxCg4Pv3Ek/D
Z4HW5TKPA2SEiWITrZbN9BnGFAfHOwg=
=uuLw
-----END PGP SIGNATURE-----

--rh9OexgCGdhps0bi--

