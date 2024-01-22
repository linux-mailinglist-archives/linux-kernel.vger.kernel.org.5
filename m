Return-Path: <linux-kernel+bounces-32406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A774E835B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C701C212C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E6FDF70;
	Mon, 22 Jan 2024 07:03:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033EFD304
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907024; cv=none; b=rQzRszhQGr0Qp3rr/QtSWkpfo2D/zpEAl3TGuhd/REazO0XD5hml1Ccyx2L2EgeVqQ//En4riXYO59/3XwxnyemAhopAQQK0OqikjXGWotz5zPxG7ZWh/gHW3EPq9iG+bWY13Tc2crXMNPHWQ3T7X2bUorAQrfgThqsxbkFGnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907024; c=relaxed/simple;
	bh=rzud68lYImSBZGAdjSKStx7SsEtIebtGlt/awI8vQXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb5e/KU78+kldkZ8yibw88KhyT3M/V/A7wrYabYsxXhYCBD67HibrTUbibT5LZ4Y01mYOKaKzP5lO+1ZpN+huNJdzKM5RT60Hq9bgDiAL2RAEdqrbikoQC/qj90EQ+tU6K2Gt8yAToVzRgPwUg9hMmWdSu6CkrF+ItfkLbgqzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRoKv-0001Kj-Pb; Mon, 22 Jan 2024 08:03:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRoKt-001X1U-Jg; Mon, 22 Jan 2024 08:03:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRoKt-0055nr-1T;
	Mon, 22 Jan 2024 08:03:11 +0100
Date: Mon, 22 Jan 2024 07:56:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Erick Archer <erick.archer@gmx.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Heiko Stuebner <heiko@sntech.de>, Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Nick Alcock <nick.alcock@oracle.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] clk: hisilicon: Use devm_kcalloc() instead of
 devm_kzalloc()
Message-ID: <ikfbonqfodfiq2hpqibb23ctaq6nxwynjjytfygonpncdkcfct@ygfjvunzkn7c>
References: <20240121142946.2796-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ssqmcul6zy7posmr"
Content-Disposition: inline
In-Reply-To: <20240121142946.2796-1-erick.archer@gmx.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ssqmcul6zy7posmr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 03:29:46PM +0100, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
>=20
> So, use the purpose specific devm_kcalloc() function instead of the
> argument size * count in the devm_kzalloc() function.
>=20
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-c=
oded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
>  drivers/clk/hisilicon/clk-hi3559a.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/=
clk-hi3559a.c
> index ff4ca0edce06..da476f940326 100644
> --- a/drivers/clk/hisilicon/clk-hi3559a.c
> +++ b/drivers/clk/hisilicon/clk-hi3559a.c
> @@ -461,8 +461,7 @@ static void hisi_clk_register_pll(struct hi3559av100_=
pll_clock *clks,
>  	struct clk_init_data init;
>  	int i;
>=20
> -	p_clk =3D devm_kzalloc(dev, sizeof(*p_clk) * nums, GFP_KERNEL);
> -
> +	p_clk =3D devm_kcalloc(dev, nums, sizeof(*p_clk), GFP_KERNEL);
>  	if (!p_clk)
>  		return;

Looks good,

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

My first impulse was to ask why hisi_clk_register_pll doesn't return an
error if the allocation fails, but I guess that happens so early that no
sensible error handling is possible?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ssqmcul6zy7posmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWuEZEACgkQj4D7WH0S
/k5Whgf+IryHEKthLbUXpxCs9TrkdjTk2tWZpkoZoz0Hk+Fzyp1PTLnzYoRkBCr2
AdqbpkeTvpfg9++BZu61V5OBCk0SnfaLgBFi/hUa7tOpcEMbrriJxgZNrb4x2HK0
g5RQWR4Yxj1zdkdGHu1ErYLLDBUg+DhpsIFLZGhLR2f6B2yEGFXT3EgKoUP59xpP
hNbEoARWh2N135qifza2toHuMVju9X9anph73dq2a+FWup+oKFyL2j7zKgEtJkO1
fX/c2c/oFZoDXFmQOAHEpeihL9DFyOBlBp4rQktixbyzIDLjqbK7VjK/dx7DBUCw
8omlOgsxwtmAuO6r7A6eNlLpzFbK4g==
=p4Xd
-----END PGP SIGNATURE-----

--ssqmcul6zy7posmr--

