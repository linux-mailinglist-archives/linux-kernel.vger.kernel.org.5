Return-Path: <linux-kernel+bounces-48246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE51845911
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D311F266A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB6E5B675;
	Thu,  1 Feb 2024 13:38:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C8F5B673
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794718; cv=none; b=p43nJzDMuCbJhQvD2A3bvokO2hx3B3TzaOORzirzxSZRErBnCHcWN2Cd7+1gbVaBal7b9Sl8niBbpGgIUVHHVf4favdyH+KUsTIS8c4YhIz9lyQ5a60uEFLl4BH4QVvnVz0xbdGlG8RLHIY4ptYqDjClZD3vmDLPHRW0OcOTrh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794718; c=relaxed/simple;
	bh=X9tQbZ9yvxPDfWJ55o6YpBbEpUW6srHSSVFo1eaHCPo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOYlKpYYpOR+UEYjFYGiSlIyJBrGh3cTOvfP5kFvemZJO0M+atj/57qr/wZbbkhxPBRRDxxbmiwgr3Ww2viZ6AY028e4mlaVGSTtstO3ayGgzn/uDb3LiCh7GHv6G8DU/QzZhiJenc+4/eAQ5AfqfsSBitpAK+ape0xjzCfI5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rVXGp-00072i-J5; Thu, 01 Feb 2024 14:38:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rVXGo-003rxh-Ve; Thu, 01 Feb 2024 14:38:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rVXGo-00D5be-2s;
	Thu, 01 Feb 2024 14:38:22 +0100
Date: Thu, 1 Feb 2024 14:38:19 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
	Florin Leotescu <florin.leotescu@nxp.com>,
	Cc@web.codeaurora.org:Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH] pwm: imx-tpm: reset module on probe
Message-ID: <vvldfzpthexjb7bir5imrdslgnnqztl2rdclfp6qiesj6hgiea@o53kcxs66mjr>
References: <20240201122242.1597601-1-viorel.suman@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ukipiczffi6d2rux"
Content-Disposition: inline
In-Reply-To: <20240201122242.1597601-1-viorel.suman@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ukipiczffi6d2rux
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Feb 01, 2024 at 02:22:42PM +0200, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
>=20
> Reset Timer PWM module on probe so that the module
> takes the default state after probe is finished.
>=20
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>

The order of Signed-off-lines is supposed to be in the order that people
touched the patch during submission. So your S-o-b line should be last
and it should ideally use the email address you use for sending out the
patch.

> ---
>  drivers/pwm/pwm-imx-tpm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> index 9fc290e647e1..27e6a5342693 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -33,6 +33,7 @@
>  #define PWM_IMX_TPM_CnV(n)	(0x24 + (n) * 0x8)
> =20
>  #define PWM_IMX_TPM_PARAM_CHAN			GENMASK(7, 0)
> +#define PWM_IMX_TPM_GLOBAL_RST			BIT(1)
> =20
>  #define PWM_IMX_TPM_SC_PS			GENMASK(2, 0)
>  #define PWM_IMX_TPM_SC_CMOD			GENMASK(4, 3)
> @@ -362,6 +363,10 @@ static int pwm_imx_tpm_probe(struct platform_device =
*pdev)
>  	val =3D readl(tpm->base + PWM_IMX_TPM_PARAM);
>  	tpm->chip.npwm =3D FIELD_GET(PWM_IMX_TPM_PARAM_CHAN, val);
> =20
> +	/* Resets all internal logic and registers */
> +	writel(PWM_IMX_TPM_GLOBAL_RST, tpm->base + PWM_IMX_TPM_GLOBAL);
> +	writel(0, tpm->base + PWM_IMX_TPM_GLOBAL);
> +

This opposes the use case that the bootloader setup the pwm-backlight to
show a splash screen that is simply taken over by Linux without
flickering, right?

Otherwise the commit log should motivate why "the module takes the
default state" is better than the status quo and what this default state
is.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ukipiczffi6d2rux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmW7nsoACgkQj4D7WH0S
/k48/wf/W46VTZssAxUHGfyUY9tw3M1faNYkpcVaouge3b57eskHm2TqUhVJha1k
pfBAm14bpFQRzaTemAx7EfzZqil5uOFYjpOftcZKPlK67+GKK88N9NyAvuCDAUM+
OM8R+z2M+9LTCsgOdWHFMrGDNRrmrHnmNIcSEhEbSdTqrbKNRliWfv4HiGPOASZ6
q/oQTiGYsaO7O/1msCdWWec0yKKDlQLzIPk1kuAJzxe9NwOpwWpCbn0/2GhPxnKp
nz5SVFB1/xh0UBCDJ2lyLTeNCP85mCBQdtP/UhY+gFI2eeycrBtQVQ4nnUGF5e7x
2lUTdT027Oj5k2gO/582vQ+ZWewnDg==
=2TeR
-----END PGP SIGNATURE-----

--ukipiczffi6d2rux--

