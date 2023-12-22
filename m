Return-Path: <linux-kernel+bounces-9595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9738A81C826
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87801C21A81
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C2614A86;
	Fri, 22 Dec 2023 10:30:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8F10A0C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGcno-0000Nh-RZ; Fri, 22 Dec 2023 11:30:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGcnm-000jYD-P4; Fri, 22 Dec 2023 11:30:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGcnn-001cg9-IX; Fri, 22 Dec 2023 11:30:47 +0100
Date: Fri, 22 Dec 2023 11:30:47 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11] pwm: bcm2835: Allow PWM driver to be used in atomic
 context
Message-ID: <fuku3b5ur6y4k4refd3vmeoenzjo6mwe3b3gtel34rhhhtvnsa@w4uktgbqsc3w>
References: <20231220142426.1275052-1-sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wbbmgda3zxkfauio"
Content-Disposition: inline
In-Reply-To: <20231220142426.1275052-1-sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--wbbmgda3zxkfauio
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Wed, Dec 20, 2023 at 02:24:25PM +0000, Sean Young wrote:
> @@ -151,8 +153,26 @@ static int bcm2835_pwm_probe(struct platform_device =
*pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
>  				     "clock not found\n");
> =20
> +	ret =3D clk_rate_exclusive_get(pc->clk);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "fail to get exclusive rate\n");
> +
> +	ret =3D devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclusive_pu=
t,
> +				       pc->clk);
> +	if (ret) {
> +		clk_rate_exclusive_put(pc->clk);

That clk_rate_exclusive_put() is wrong. If devm_add_action_or_reset()
fails that is already cared for.

Given that Thierry already applied this patch, getting this fixed in a
timely manner would be good.

> +		return ret;
> +	}
> +
> +	pc->rate =3D clk_get_rate(pc->clk);
> +	if (!pc->rate)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "failed to get clock rate\n");
> +
>  	pc->chip.dev =3D &pdev->dev;
>  	pc->chip.ops =3D &bcm2835_pwm_ops;
> +	pc->chip.atomic =3D true;
>  	pc->chip.npwm =3D 2;
> =20
>  	platform_set_drvdata(pdev, pc);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wbbmgda3zxkfauio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWFZVYACgkQj4D7WH0S
/k5AiAf+MDAha9sI61i2bW4wF4su3juJvzsZFHOeICwGN4crhKlvqBxAhUJryM5N
kfuRk/OpTWZ4ZT5dot57QGW3OlGqiYhiaOrsLJAxpAGTtn4D7frZm+DxTo9nWdl/
AQPxivTRLMCDr2fWYZmp99lQFVsEqso/D/NjwVxuhR/JQKman7XEiLiqHR+2P7Je
6DzcsfG8Y5NQI5JP9vLrngiT6wUGhwRAnJ9r5b9xYzHx/t/p6SW+VwRiCT1LrmXo
nXsPvFDA+G5nA4WAY9IeiR7Bi3sFTfrdk4yoeY11We2QcFsYPkQ+tZ+sEguuVwC6
VFtnj7oZOFbti7VwHGVwmI/EmT7a4g==
=Fh16
-----END PGP SIGNATURE-----

--wbbmgda3zxkfauio--

