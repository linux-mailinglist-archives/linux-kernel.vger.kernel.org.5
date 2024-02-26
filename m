Return-Path: <linux-kernel+bounces-80751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB9B866C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CA31F23AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C381CA91;
	Mon, 26 Feb 2024 08:25:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7B1C6A3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935907; cv=none; b=QJ6ylM8CbDlFAzqx3DSkL08PomoGxD5cWKiDvaoaCCXbibyv3D23/hfXnu7ngutxSk7BWLGVs2osnDhwv61fedBaT/wfDTmTd4FamWGpzHPD5HTxTeBH7RUkmUjbwizIy3mCKty0tj1FlsNy8GGUcjaFZsKy46K5O1PgzoTMNzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935907; c=relaxed/simple;
	bh=ILUzmi0yWEnHp6QLN0s99nRQRgTcB6WDFt8VQe6DRwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJsglSFe6uY75dZUzk4wAv9l9mAiq326/UGWmQKsXx8qAev6OVfkGxUzFhzxUTI+xcQ3d+3ZLiPXHV9DsK/owSxL2FqP23zOEihiAIdvbTe+Abuvf9qH69NM4sjqs0oi9vo+GlOnZlhFhOC7cbroaDJ9kYBk4b0A4CYQrQMDs88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1reWIE-0001Gf-H9; Mon, 26 Feb 2024 09:24:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1reWID-002xJH-M7; Mon, 26 Feb 2024 09:24:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1reWID-00BVMf-1u;
	Mon, 26 Feb 2024 09:24:57 +0100
Date: Mon, 26 Feb 2024 09:24:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Leif Middelschulte <leif.middelschulte@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Leif Middelschulte <Leif.Middelschulte@klsmartin.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] pwm: imx27: fix race condition .apply,.get_state
Message-ID: <jm73itlefa5dmqxhe35tbzohg3vr7pog6kt7ieuiw3a2q2p6ml@ngwtwz2aawyn>
References: <20230906154215.4ikrrbx4xgx2nmu5@pengutronix.de>
 <20240224112902.55539-1-Leif.Middelschulte@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c5aqstpagj445og2"
Content-Disposition: inline
In-Reply-To: <20240224112902.55539-1-Leif.Middelschulte@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--c5aqstpagj445og2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Leif,

thanks for this new round addressing the identified issues.

On Sat, Feb 24, 2024 at 12:29:00PM +0100, Leif Middelschulte wrote:
> From: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>
>=20
> With CONFIG_PWM_DEBUG=3Dy after writing a value to the PWMSAR
> register in .apply(), the register is read in .get_state().
> Unless a period completed in the meantime, this read yields the
> previously used duty cycle configuration. As the PWM_DEBUG code
> applies the read out configuration for testing purposes this
> effectively undoes the intended effect by rewriting the previous
> hardware state.
>=20
> Note that this change merely implements a sensible heuristic.
> The i.MX has a 4 slot FIFO to configure the duty cycle. This FIFO
> cannot be read back in its entirety. The "write x then read back
> x from hw" semantics are therefore not easily applicable.
> With this change, the .get_state() function tries to wait for some
> stabilization in the FIFO (empty state). In this state it keeps
> applying the last value written to the sample register.
>=20
> Signed-off-by: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>
> ---
>  drivers/pwm/pwm-imx27.c | 55 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 7d9bc43f12b0..cb564460b79c 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -75,6 +75,7 @@
>  						   (x)) + 1)
> =20
>  #define MX3_PWM_SWR_LOOP		5
> +#define MX3_PWM_FIFOAV_EMPTY_LOOP	4

This looks like a register definition, but it's only a number that
defines the iterations waiting for the FIFO to empty. (The same critic
applies to MX3_PWM_SWR_LOOP, though.)

>  /* PWMPR register value of 0xffff has the same effect as 0xfffe */
>  #define MX3_PWMPR_MAX			0xfffe
> @@ -118,6 +119,31 @@ static void pwm_imx27_clk_disable_unprepare(struct p=
wm_imx27_chip *imx)
>  	clk_disable_unprepare(imx->clk_ipg);
>  }
> =20
> +static int pwm_imx27_wait_fifo_empty(struct pwm_chip *chip,
> +				     struct pwm_device *pwm)
> +{
> +	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
> +	struct device *dev =3D chip->dev;
> +	unsigned int period_ms =3D DIV_ROUND_UP_ULL(pwm->state.period, NSEC_PER=
_MSEC);

Given that waiting here is unfortunate it would be nice so reduce the
waiting as much as possible. So it might make sense to read the actual
period from the hardware and use that as it might be smaller that
pwm->state.period.

> +	int tries =3D MX3_PWM_FIFOAV_EMPTY_LOOP;
> +	int fifoav, previous_fifoav =3D INT_MAX;
> +	u32 sr;

Most variables can go into the while loop.

> +	while (tries--) {
> +		sr =3D readl(imx->mmio_base + MX3_PWMSR);
> +		fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);
> +		if (fifoav =3D=3D MX3_PWMSR_FIFOAV_EMPTY)
> +			return 0;
> +		/* if the FIFO value does not decrease, there is another problem */
> +		if (previous_fifoav =3D=3D fifoav)
> +			break;
> +		previous_fifoav =3D fifoav;
> +		msleep(period_ms);
> +	}

I wonder if a loop is necessary at all. Why not use
msleep(FIELD_GET(MX3_PWMSR_FIFOAV, sr) * period_ms)?

Maybe take PWMCNR into account to shorten the sleep a bit.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--c5aqstpagj445og2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXcStgACgkQj4D7WH0S
/k4LJQf8C6hwy1sFY7yKjt5wCPoZpghfOG/zBrFyrz3Jqvu7i20/owaMN0m6BB+C
r97/XMyUd/fCzXjrY0cFiwKHki35Q77xRGfHlpx317t4MnjHQ+RQf7L5sfhpbf3p
1JCsDNp0Y3GJTgY5YsLzgfLIjdZyzcsN0Gsa2/5tW95Yg1Je0gDEToFTH8usggxp
ijJ38OBCkf4qRpvNRRIVEmu2VEsS+5dLVgfS7dnX8CzRdWfo4Yhwlex58awCQZLw
MT9DriSKhkPZXSClCkv7s3HdWRt6EQdWi0NIdsmKJsY1zZREvYDbtnSQrqW7/5xt
D0/hgkLI8bIORFVZpF4Vi14glnLF1A==
=TplP
-----END PGP SIGNATURE-----

--c5aqstpagj445og2--

