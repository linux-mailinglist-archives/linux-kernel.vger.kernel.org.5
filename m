Return-Path: <linux-kernel+bounces-164172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3762E8B7A26
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BAA1C22FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F601802BC;
	Tue, 30 Apr 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VVNxdNl4"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04AE770F5;
	Tue, 30 Apr 2024 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487600; cv=none; b=jrUQ4kLAJYS1j6K99OxJNNxdkBgTGifJxxVP9z5clWh3pMcpK7sQWxIotMbDX3yU7g6ZwYty9GzzH08DQwtYjbpVq/izqOb4OLZ2oW02sxUEyUlGPtdIniElgloTg90TiN09/KnUp50S75NtQ7F0UA1P1Iv8im2vuj269rUlg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487600; c=relaxed/simple;
	bh=ZbofnJTeGEkJkkARV3RauUlYPiv2yoCrwKvOpKsZ05E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4gU7Lv3dlENVrO4ndDfHLzqdiFbv04XbN/hk6dtgRf9Qa9T3TTxcp4wb0lJE3umMrbwvBpLpnZus11i3ZMzm4+8XBoWEk2FrEhnISJTXfBinfVmxRhUpHwIyO4ujNkjrBYf8duRN+bmx2FZ+zvwL7HgbPAGkbPsL56GPDSPgfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VVNxdNl4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714487597;
	bh=ZbofnJTeGEkJkkARV3RauUlYPiv2yoCrwKvOpKsZ05E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVNxdNl4kQe39oj47b3+NyFvudFAZGW59n5BTUf1/DF2H3cviw3Tuiwcgc3kGQLpu
	 4aT/K0hOh42Fg2vK9bcCSngPs4kAJL8Rf8S29deXyTtgtp8jAuUo9beJ/VY35hNiL+
	 UphsRomofb7zdUW87scAWAWZDpisn7RdjkM5Afe/n9AWPRaqXWBSKfS2HeaDMGbNuY
	 QOSu8VFIpqhhzZf5Nf/AvcUa0eCoadqJYoJ8LpUFqhBHTRZF4GWMnN//BT1op4PzCR
	 gmhSVXEW+tJkp5f+PgTXDiJHlV4e0Un1PJJwlgcny3sFV1hNNGnVe6zvX3541yyvvA
	 QCgYVUzPdJ1+A==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2844E378212D;
	Tue, 30 Apr 2024 14:33:17 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id BB1B7106074C; Tue, 30 Apr 2024 16:33:16 +0200 (CEST)
Date: Tue, 30 Apr 2024 16:33:16 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ben Wolsieffer <benwolsieffer@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] power: supply: max8903: configure USUS as output
Message-ID: <ujpdv6fahceaatniy3w4z23dy7q4r5swfqzi2mc4dlarcdavo4@x5fvm5oklohx>
References: <20240417-max8903-v1-1-25d4dbf4ce9b@herrie.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="243jbcowuncudllz"
Content-Disposition: inline
In-Reply-To: <20240417-max8903-v1-1-25d4dbf4ce9b@herrie.org>


--243jbcowuncudllz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 17, 2024 at 03:35:00PM +0200, Herman van Hazendonk wrote:
> The USUS pin was mistakenly configured as an input, when it should be an
> output that specifies whether the USB power input is suspended. In additi=
on
> to fixing the pin mode, this patch also suspends the USB input when a DC
> charger is connected, which should result in a slight reduction in USB
> quiescent current.
>=20
> Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---

Thanks for your patch. I think this should get

Fixes: 50da8d04ee52 ("power: supply: max8903: Convert to GPIO descriptors")

Also what's going on with the Signed-off-by? Did you forward the
patch from Ben Wolsieffer (i.e. the author is wrong) or did you
co-develop it (so there should be a "Co-developed-by: Ben Wolsieffer
<benwolsieffer@gmail.com>" tag)?

>  drivers/power/supply/max8903_charger.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/max8903_charger.c b/drivers/power/suppl=
y/max8903_charger.c
> index e65d0141f260..15dc3a5239e2 100644
> --- a/drivers/power/supply/max8903_charger.c
> +++ b/drivers/power/supply/max8903_charger.c
> @@ -102,6 +102,10 @@ static irqreturn_t max8903_dcin(int irq, void *_data)
>  	if (data->dcm)
>  		gpiod_set_value(data->dcm, ta_in);
> =20
> +	/* Set USB-Suspend 1:Suspended 0:Active */
> +	if (data->usus)
> +		gpiod_set_value(data->usus, ta_in);
> +
>  	/* Charger Enable / Disable */
>  	if (data->cen) {
>  		int val;
> @@ -310,7 +314,15 @@ static int max8903_setup_gpios(struct platform_devic=
e *pdev)
>  				     "failed to get FLT GPIO");
>  	gpiod_set_consumer_name(data->flt, data->psy_desc.name);
> =20
> -	data->usus =3D devm_gpiod_get_optional(dev, "usus", GPIOD_IN);
> +	/*
> +	 * Suspend the USB input if the DC charger is connected.
> +	 *
> +	 * The USUS line should be marked GPIO_ACTIVE_HIGH in the
> +	 * device tree. Driving it low will enable the USB charger
> +	 * input.

I think the above 3 lines should be dropped. They added more
confusion to me than actually helping and the information is
already in the DT binding file.

Greetings,

-- Sebastian

> +	 */
> +	flags =3D ta_in ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> +	data->usus =3D devm_gpiod_get_optional(dev, "usus", flags);
>  	if (IS_ERR(data->usus))
>  		return dev_err_probe(dev, PTR_ERR(data->usus),
>  				     "failed to get USUS GPIO");
>=20
> ---
> base-commit: 96fca68c4fbf77a8185eb10f7557e23352732ea2
> change-id: 20240417-max8903-ace97d7d3407
>=20
> Best regards,
> --=20
> Herman van Hazendonk <github.com@herrie.org>
>=20

--243jbcowuncudllz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYxASAACgkQ2O7X88g7
+po8UxAAp2+KFGesRHzAkUVrYxiu1Exye2LwzJjQdFD69x3N1cchUiGVaebshxIU
73MwfOssQndZMS/ice/Ed71XJTtb93EA7MtuHkQQ8MEelEoC5T4N0VER+S1q/Irb
FXHteDS4WDm7pYd6Pf9XQW7eI/WrhqQ2vJMn9BjbQrh79J6XT9GdLCF5XrNgcDdL
nGUZIlCtnE+xce8Q4vpPZ5t3LNqFrkJTMWBOGFZtl1hOaaPqHS3cuJ40mangaZ3u
EGBL3yck5fJVFiUz8e1zibFrDow00j6zXI/7aU6c4sFGadTPea2QmCCPUO0gRMSt
9vTruWzmidtXIIOckrhfcGAlNmN54NFPrl6wibmOdINJ/a/AMixZg3qi33TKHYp5
xNYxc2KEbw9kELlqABBHVw7fdulS+YCVh+iC8iYmNH3SeoKKAStFlUhgog0Ba4JE
ZaWkFxcnIBjmJoAkVZDEAJLigV0xaKDJfECal/EXqREBvtfmX9Y8FLJqXSBdLax2
7QpvmzabW9CRqEGTTBUHinJT4LMuaNuDPdjOlYj0BCALs7is59dVxG4Nc2sCmWL6
2lHWBssg/IOBFp8OqnOsjEe3aq2fBASE2urGreXFpRCMaBVV5vHXm4xLrUQZ9NF+
ypqvN/8GcuGc7B7SnjFAXLeZTMFuNhrrU8/DOlF3g9qsDEd7iZg=
=VF7a
-----END PGP SIGNATURE-----

--243jbcowuncudllz--

