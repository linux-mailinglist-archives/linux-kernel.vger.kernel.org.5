Return-Path: <linux-kernel+bounces-3247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79288169DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7437C282447
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223B811CB7;
	Mon, 18 Dec 2023 09:31:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6797A11CAA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rF9yM-00008N-3x; Mon, 18 Dec 2023 10:31:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rF9yL-00GfSI-5C; Mon, 18 Dec 2023 10:31:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rF9yK-0059f2-Rz; Mon, 18 Dec 2023 10:31:36 +0100
Date: Mon, 18 Dec 2023 10:31:36 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 5/6] pwm: bcm2835: Allow PWM driver to be used in
 atomic context
Message-ID: <eicw7ppqj5dubskhmeh7iwdaoixv27qw2zqaljkddt2rwosogt@6aftnwt6p5ek>
References: <cover.1702890244.git.sean@mess.org>
 <5249bb5d6c067692e4cd09573ced2df58966693b.1702890244.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yreug3ipg4bt5kq6"
Content-Disposition: inline
In-Reply-To: <5249bb5d6c067692e4cd09573ced2df58966693b.1702890244.git.sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--yreug3ipg4bt5kq6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Mon, Dec 18, 2023 at 09:06:46AM +0000, Sean Young wrote:
> @@ -151,16 +146,40 @@ static int bcm2835_pwm_probe(struct platform_device=
 *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
>  				     "clock not found\n");
> =20
> +	ret =3D clk_rate_exclusive_get(pc->clk);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "fail to get exclusive rate\n");

If Maxime didn't object to my series at
https://lore.kernel.org/linux-clk/cover.1702400947.git.u.kleine-koenig@peng=
utronix.de/,
I'd ask you to not do error checking here. With the objection I hesitate
to ask for that and just mention it.

> +	pc->rate =3D clk_get_rate(pc->clk);
> +	if (!pc->rate) {
> +		clk_rate_exclusive_put(pc->clk);
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "failed to get clock rate\n");
> +	}
> +
>  	pc->chip.dev =3D &pdev->dev;
>  	pc->chip.ops =3D &bcm2835_pwm_ops;
> +	pc->chip.atomic =3D true;
>  	pc->chip.npwm =3D 2;
> =20
>  	platform_set_drvdata(pdev, pc);
> =20
>  	ret =3D devm_pwmchip_add(&pdev->dev, &pc->chip);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		clk_rate_exclusive_put(pc->clk);
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "failed to add pwmchip\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int bcm2835_pwm_remove(struct platform_device *pdev)
> +{
> +	struct bcm2835_pwm *pc =3D platform_get_drvdata(pdev);
> +
> +	clk_rate_exclusive_put(pc->clk);

The ugly thing here is that now clk_rate_exclusive_put() happens before
pwmchip_remove(). Maybe register a devm cleanup which also gets rid of
the two clk_rate_exclusive_put() in probe's error path?

>  	return 0;
>  }
> @@ -197,6 +216,7 @@ static struct platform_driver bcm2835_pwm_driver =3D {
>  		.pm =3D pm_ptr(&bcm2835_pwm_pm_ops),
>  	},
>  	.probe =3D bcm2835_pwm_probe,
> +	.remove =3D bcm2835_pwm_remove,

Please use .remove_new

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yreug3ipg4bt5kq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWAEXcACgkQj4D7WH0S
/k5t1ggAr2ILVcBzlWHGfg/TgkgTIZ5LtQYjXW5Bk9UFDSSdxt1WCu4lTf7aakUD
L9wqph54ff/Gywj++5qXt3qGEm9Wv1yR/yoWVL7TISqibdE8lo21nQijQLqdAU6G
4lvuIvF8V5zEsCj1hrkzYbwm8hnWLeadT5DDJkK2NwAsrUu7MJiMH3PzHjeYE9kb
mZ8G7Ss9pSHkXFFhLpBTEIxlJPUSEj+ErVYomlrHe7MDTUPsNRH+vy8AZrIOy/49
/uPZwoO/qbone0XC9uzIiCSdOoXRFZYs52vaTr+pE3SDmyxmbl4yBPZc/CflnBmQ
xnAW21PTZownjRYM5BJzeEh1XlQEbg==
=vw1H
-----END PGP SIGNATURE-----

--yreug3ipg4bt5kq6--

