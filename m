Return-Path: <linux-kernel+bounces-120137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6010F88D2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D202E1B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F6A13E040;
	Tue, 26 Mar 2024 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n1iGFLV0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733FD6FE35;
	Tue, 26 Mar 2024 23:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711495877; cv=none; b=KSY4c8yEHpBmOhaKJxn060rSsf418AKIG73I2I+kSiTkM0LatoeN/Pv0pus/A5WKL3FYNdyr9KYBQITcRS+0kUkES/zrq+8s8BZYS6US6wu6BiIlfZ4Ar2i64yhWxHIU+2GPzQ/52xbgmi1t4U084JKCliGrabdsoRCVvO4vqeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711495877; c=relaxed/simple;
	bh=MTHbQxWWr82Pgl4Qpl4eCiscQ+kIVFbl12TUbUWZXfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCTp3OKuJcVIp428afAnCYFIFt4Z06XVo/t7LlSAJ50ycHW5prJZg+rEQe8tpSjFoxvJH1l/DOarLBsZrVJ2MGa3ZmGloyXRkNEkHWktQT5AgClq6hBGZMoEIqD4wI66qqGMTwmII/NnucZ3klaXVLM5MmvCjUklIZuriKjryOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n1iGFLV0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711495873;
	bh=MTHbQxWWr82Pgl4Qpl4eCiscQ+kIVFbl12TUbUWZXfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1iGFLV0hIJ00/P6UnGBL2sCMeGrkCpUMc8TrbTr4kT+yzDJfyKHTg/NYejkGg2ag
	 ONxhBfk1IIAJracIV3NFfmBk2OdTXMYO+BZrZ3pcmTZkJaLxJMIHxD4PCHquD5nTEH
	 zn2ofxsxNkFNzCKPx9zkAB5D9dU6SO6gdk6LGjfGbkx8G/sIOA37vFoDkWibxH0xqW
	 gBzYR4ZlNsNbTfsoPDoT6SxC108y6cC/3boom+1MmZ4bb9dDe2RDPOuMXcCFWsdSIn
	 ZSgTDwtApYRf/yyZKK8lGCoRYbzWHVqmijM/4EVKzWcUUA8X5SOP5LfBANfUNcrdrV
	 0oaTTLpm7k7pw==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 723BF37810C0;
	Tue, 26 Mar 2024 23:31:13 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id E8D2B10608D9; Wed, 27 Mar 2024 00:31:12 +0100 (CET)
Date: Wed, 27 Mar 2024 00:31:12 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: nikita.shubin@maquefel.me
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 05/38] power: reset: Add a driver for the ep93xx reset
Message-ID: <oxvj7wmugkxzeddmrzyowr6lxxahbo766sbip22a564qeczxoy@oagxcoathnsr>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
 <20240326-ep93xx-v9-5-156e2ae5dfc8@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bxlmjncesy7eix7u"
Content-Disposition: inline
In-Reply-To: <20240326-ep93xx-v9-5-156e2ae5dfc8@maquefel.me>


--bxlmjncesy7eix7u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 26, 2024 at 12:18:32PM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Implement the reset behaviour of the various EP93xx SoCS
> in drivers/power/reset.
>=20
> It used to be located in arch/arm/mach-ep93xx.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> ---

If another round is needed, please use devm_register_sys_off_handler()
instead of register_restart_handler().

Greetings,

-- Sebastian

>  drivers/power/reset/Kconfig          | 10 +++++
>  drivers/power/reset/Makefile         |  1 +
>  drivers/power/reset/ep93xx-restart.c | 84 ++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 95 insertions(+)
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index fece990af4a7..389d5a193e5d 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -75,6 +75,16 @@ config POWER_RESET_BRCMSTB
>  	  Say Y here if you have a Broadcom STB board and you wish
>  	  to have restart support.
> =20
> +config POWER_RESET_EP93XX
> +	bool "Cirrus EP93XX reset driver" if COMPILE_TEST
> +	depends on MFD_SYSCON
> +	default ARCH_EP93XX
> +	help
> +	  This driver provides restart support for Cirrus EP93XX SoC.
> +
> +	  Say Y here if you have a Cirrus EP93XX SoC and you wish
> +	  to have restart support.
> +
>  config POWER_RESET_GEMINI_POWEROFF
>  	bool "Cortina Gemini power-off driver"
>  	depends on ARCH_GEMINI || COMPILE_TEST
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index a95d1bd275d1..10782d32e1da 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_POWER_RESET_ATC260X) +=3D atc260x-poweroff.o
>  obj-$(CONFIG_POWER_RESET_AXXIA) +=3D axxia-reset.o
>  obj-$(CONFIG_POWER_RESET_BRCMKONA) +=3D brcm-kona-reset.o
>  obj-$(CONFIG_POWER_RESET_BRCMSTB) +=3D brcmstb-reboot.o
> +obj-$(CONFIG_POWER_RESET_EP93XX) +=3D ep93xx-restart.o
>  obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) +=3D gemini-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
> diff --git a/drivers/power/reset/ep93xx-restart.c b/drivers/power/reset/e=
p93xx-restart.c
> new file mode 100644
> index 000000000000..57cfb8620faf
> --- /dev/null
> +++ b/drivers/power/reset/ep93xx-restart.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Cirrus EP93xx SoC reset driver
> + *
> + * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/container_of.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/notifier.h>
> +#include <linux/reboot.h>
> +#include <linux/slab.h>
> +
> +#include <linux/soc/cirrus/ep93xx.h>
> +
> +#define EP93XX_SYSCON_DEVCFG		0x80
> +#define EP93XX_SYSCON_DEVCFG_SWRST	BIT(31)
> +
> +struct ep93xx_restart {
> +	struct ep93xx_regmap_adev *aux_dev;
> +	struct notifier_block restart_handler;
> +};
> +
> +static int ep93xx_restart_handle(struct notifier_block *this,
> +				 unsigned long mode, void *cmd)
> +{
> +	struct ep93xx_restart *priv =3D
> +		container_of(this, struct ep93xx_restart, restart_handler);
> +	struct ep93xx_regmap_adev *aux =3D priv->aux_dev;
> +
> +	/* Issue the reboot */
> +	aux->update_bits(aux->map, aux->lock, EP93XX_SYSCON_DEVCFG,
> +			 EP93XX_SYSCON_DEVCFG_SWRST, EP93XX_SYSCON_DEVCFG_SWRST);
> +	aux->update_bits(aux->map, aux->lock, EP93XX_SYSCON_DEVCFG,
> +			 EP93XX_SYSCON_DEVCFG_SWRST, 0);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int ep93xx_reboot_probe(struct auxiliary_device *adev,
> +			       const struct auxiliary_device_id *id)
> +{
> +	struct ep93xx_regmap_adev *rdev =3D to_ep93xx_regmap_adev(adev);
> +	struct device *dev =3D &adev->dev;
> +	struct ep93xx_restart *priv;
> +	int err;
> +
> +	if (!rdev->update_bits)
> +		return -ENODEV;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->aux_dev =3D rdev;
> +
> +	priv->restart_handler.notifier_call =3D ep93xx_restart_handle;
> +	priv->restart_handler.priority =3D 128;
> +
> +	err =3D register_restart_handler(&priv->restart_handler);
> +	if (err)
> +		return dev_err_probe(dev, err, "can't register restart notifier\n");
> +
> +	return 0;
> +}
> +
> +static const struct auxiliary_device_id ep93xx_reboot_ids[] =3D {
> +	{
> +		.name =3D "soc_ep93xx.reset-ep93xx",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, ep93xx_reboot_ids);
> +
> +static struct auxiliary_driver ep93xx_reboot_driver =3D {
> +	.probe		=3D ep93xx_reboot_probe,
> +	.id_table	=3D ep93xx_reboot_ids,
> +};
> +module_auxiliary_driver(ep93xx_reboot_driver);
>=20
> --=20
> 2.41.0
>=20
>=20

--bxlmjncesy7eix7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYDWrwACgkQ2O7X88g7
+ppn2A/7BgKXlLfayzxDGsLA+7oVEcxwjQwTAffSwpyYzOUL4p+nfQLNMPUJ5G+o
bchGTHW9eGaWN8sL/bXyTtJZSIPisxtd0qKwGKLJH+kPY4ZFK7UAm+kxzeygXRbk
JhHksfeuhefcbpZRGWOJaXamMRLWa5o2Mj+O/5+fK/p2bJuQUCyBuRNbvdnFfUmu
E4cOcgnT4OlBH4REKwiQCtXIFmdv+BIJoFSW2qpqH4efjd9H14eZ75DSzFdANaQc
2WqfGBccwOx1oYlkkocxlzMPwlEaKLpj3XtpyGwCD2uIhGSFRapud+i4h5hDB0fE
0nYi4/orD91lWJpxg5awMlw7BiKyDnwH2OBFuWXmF+FVerLO49f4/OO9T89PbXzz
ECQNWg35sMqA7Y8p2YhkeDH5Fa8CFtbFyAivuBM4pbFTwJrsW8+iaSI5dVW/ATVx
CvzSPogVyiwzawupz00TMvlVPOgF3dxYA+hgh0GVRT2Wdo8YCWj2WGl9pUKW1/XZ
nROizDuPIAYxrheZnCbSQuiBnWDzlypMzXLX/pP0w/yS1cUEa4teAdVE+ZJbqn2y
yPaZ5KCJTNk30JoGMaSXAe1NbeFisVhtDCIb3W5/vTLTMRmnrk4JT5FuacWLDQZM
/Cq5IfTTg4ougV87UZcz/Cn37z2733DRNZgjrmSQULhVRh8QkLM=
=Q8qH
-----END PGP SIGNATURE-----

--bxlmjncesy7eix7u--

