Return-Path: <linux-kernel+bounces-70820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9CD859CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0D31C20D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4E720DD8;
	Mon, 19 Feb 2024 07:22:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C720DC5
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327358; cv=none; b=A8SeKGhs+PEkqX45duJcLRNtBMa6nXIr6mCRFzpkxwe6iY346npkZsv6KmLIWHpNYDsDg1VujiiPUnu+qKfxDK6gm+u5cXzKXSbzpt6+ONOcp2iIeXhba5B1bM9zLwar4c+/+B4KJV8zblTE0+U8Ry1MxNeCg5W0A+hhqFpN6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327358; c=relaxed/simple;
	bh=UP1nq5CRx3BtEKG76frDqPHJU12i2jRZco/i+UQSPTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSDK7Yb65XC/iDzkNOLThbj4XX1g+jPxQvhow4kC2I/4S0sj6dUzHO5lOaVELMvqz4JOSQoBD4sqC4AQRFIomY6hdJTtwJixJEU6XSaGA+illTISIqISBcsYZ3aLaEAbLN4Do7YnWAjAV4I+OBCEUJxw59SsLIZXU4eZiinTKw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbxyi-0007Ri-Va; Mon, 19 Feb 2024 08:22:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbxyh-001bBt-SQ; Mon, 19 Feb 2024 08:22:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbxyh-007apT-2W;
	Mon, 19 Feb 2024 08:22:15 +0100
Date: Mon, 19 Feb 2024 08:22:15 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Raag Jadav <raag.jadav@intel.com>
Cc: jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, lakshmi.sowjanya.d@intel.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] pwm: dwc: Fix PM regression
Message-ID: <luewujhgmgypcpnngyriv4trklznrkzngxe7syvfp2dontorwf@3xoooabwfitg>
References: <20240219033835.11369-1-raag.jadav@intel.com>
 <20240219033835.11369-2-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lujspconz4o5yy2y"
Content-Disposition: inline
In-Reply-To: <20240219033835.11369-2-raag.jadav@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--lujspconz4o5yy2y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Raag,

On Mon, Feb 19, 2024 at 09:08:32AM +0530, Raag Jadav wrote:
> While preparing dwc driver for devm_pwmchip_alloc() usage, commit
> df41cd8bbcad ("pwm: dwc: Prepare removing pwm_chip from driver data")
> modified ->suspend() handle to use the pwm_chip as driver_data for
> accessing struct dwc_pwm, but didn't modify ->resume() handle with
> relevant changes. This results into illegal memory access during
> device wakeup and causes a PM regression.
>=20
> Fix this by correctly accessing struct dwc_pwm in ->resume() handle.
>=20
> Fixes: df41cd8bbcad ("pwm: dwc: Prepare removing pwm_chip from driver dat=
a")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/pwm/pwm-dwc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> index 8ca1c20a6aaf..c0e586688e57 100644
> --- a/drivers/pwm/pwm-dwc.c
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -95,7 +95,8 @@ static int dwc_pwm_suspend(struct device *dev)
> =20
>  static int dwc_pwm_resume(struct device *dev)
>  {
> -	struct dwc_pwm *dwc =3D dev_get_drvdata(dev);
> +	struct pwm_chip *chip =3D dev_get_drvdata(dev);
> +	struct dwc_pwm *dwc =3D to_dwc_pwm(chip);
>  	int i;
> =20
>  	for (i =3D 0; i < DWC_TIMERS_TOTAL; i++) {

If you're ok I'd squash this into df41cd8bbcad adding

	Thanks to Raag Jadav for providing a hunk of this patch that Uwe
	missed during creation of this patch.

to the commit log.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lujspconz4o5yy2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXTAaYACgkQj4D7WH0S
/k4Qmgf8D5jnORguDQnPQg6OUPdRe46RfOY6+BkDi+smMqEj5pksoJ5s3pRZBZYL
u2eOV4vh3Oxrb017HAOIEMNcuAvNE4O+vbLEX1ppIZNcFj6o3I/P7ctTLfqLNBcj
b3VAYNNlxm3ZH6j5wh9xpD5U+HVBPadFY70WK9tS3kzgQlzzX1dWDSxDKuiaL9KO
ZIdmjyygZdTLYCxixnzQQTbzI13wlhLGd1vf7294v0ZFRNxPPrTmfZZzuLdHoQsy
BTFGxuuBtidfYdWEw8ptkSFbDYAQDgCXFeKJy8j+RoyKkSMywQTKgTTPXmyHQVT6
hPGk4G4ws89YdtUiUTbAwc/O8XD3Ig==
=SIJf
-----END PGP SIGNATURE-----

--lujspconz4o5yy2y--

