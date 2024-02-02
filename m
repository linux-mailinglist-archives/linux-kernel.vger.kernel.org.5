Return-Path: <linux-kernel+bounces-50199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C463A8475AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7630928D0AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B794714AD3A;
	Fri,  2 Feb 2024 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RSpUTje5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C20B1487D9;
	Fri,  2 Feb 2024 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893468; cv=none; b=l/1Fv94F1wKM5XDx2VrThXvLt5SsQJQtPeA6ceGbcMGhTxQURfnDj8o8jCOZnCungkZSy5eFY0XUf3mSTaLF3BjlwWr9fQzMYeUbgIzVjyyK+omPI8gAqR9IxJN2FnoIhSE9VSb7fIIV1fo6hWOWSYqvuBWwxOny0S536D00pM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893468; c=relaxed/simple;
	bh=MnvLEjR4ovDLXXBbq+Nz/JHsV5WbpDGbzzKIEnAHaGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f131WF5zLf+QtVhi4pE2tFkCDyw/ECAL4HfSomkMjZFsDhXMbccVnjXjLsnE/p45bljpvTBXva1ankr3KRo3FRv4l31rXQKn8wCb54qZ/QNLK/oqCZzWO30hnT/WK56GmU8ZQbv3eMUv7/SZSoC0xY8Zov5UWoPMOzMJwxS4C1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RSpUTje5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706893465;
	bh=MnvLEjR4ovDLXXBbq+Nz/JHsV5WbpDGbzzKIEnAHaGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSpUTje5YoTTrL+THcV1sFyefprReWs8nZZUn10e9gpQT4ZkXNnGvBuiBvV3EpDWy
	 asJ/P8gVWaaAo6NPSsxeKLSSThRdrbsfcxhGEbGUahShXeO58NOMETD78SLl+8AWvI
	 8z0AW7zpPzR9jeB59new8pHPazYMIetP0vUAAVBYH9YljpfkFLhNtbUdUIuR9v9q89
	 vQ6ORSjCj9QRQopTqgGoyfCYkg0345oL4ckDRyf2jvptH0UhD+YgxvvRCkKim52cbx
	 mw/Ek9lR+ZX17cM/RI2DQC/+ZkhpEpzlzOHOee+4emvH089CbAgqVqjU4f5NUKwMxr
	 mu4pMXt34LMnA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C53A03780A0B;
	Fri,  2 Feb 2024 17:04:24 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 0E96B10611A5; Fri,  2 Feb 2024 18:04:13 +0100 (CET)
Date: Fri, 2 Feb 2024 18:04:12 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Nishanth Menon <nm@ti.com>
Cc: Andrew Davis <afd@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 03/12] power: reset: Add TI-SCI reboot driver
Message-ID: <xdrdaasaosjagr35ftb56yszwlrcf5bzpsnui5crut2ii7nu7n@apxciqrwluwr>
References: <20240131221957.213717-1-afd@ti.com>
 <20240131221957.213717-4-afd@ti.com>
 <20240201211534.dv6qu7ila54vqykn@cheating>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pzni7lzp76a4ycxf"
Content-Disposition: inline
In-Reply-To: <20240201211534.dv6qu7ila54vqykn@cheating>


--pzni7lzp76a4ycxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 01, 2024 at 03:15:34PM -0600, Nishanth Menon wrote:
> On 16:19-20240131, Andrew Davis wrote:
> > This reboot driver calls into firmware using TI-SCI to reboot the syste=
m.
> > We register the handler with low priority as we want PSCI to remain the
> > main way these devices are rebooted. This driver acts as a fallback if
> > PSCI is not able to reboot the system.
> >=20
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > ---
> >  MAINTAINERS                         |  1 +
> >  drivers/power/reset/Kconfig         |  7 ++++
> >  drivers/power/reset/Makefile        |  1 +
> >  drivers/power/reset/ti-sci-reboot.c | 63 +++++++++++++++++++++++++++++
> >  4 files changed, 72 insertions(+)
> >  create mode 100644 drivers/power/reset/ti-sci-reboot.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 45983bb174fe4..ee67ea497fc56 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -21758,6 +21758,7 @@ F:	drivers/clk/keystone/sci-clk.c
> >  F:	drivers/firmware/ti_sci*
> >  F:	drivers/irqchip/irq-ti-sci-inta.c
> >  F:	drivers/irqchip/irq-ti-sci-intr.c
> > +F:	drivers/power/reset/ti-sci-reboot.c
> >  F:	drivers/reset/reset-ti-sci.c
> >  F:	drivers/soc/ti/ti_sci_inta_msi.c
> >  F:	drivers/pmdomain/ti/ti_sci_pm_domains.c
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index fece990af4a75..d3e91e54cae24 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -205,6 +205,13 @@ config POWER_RESET_ST
> >  	help
> >  	  Reset support for STMicroelectronics boards.
> > =20
> > +config POWER_RESET_TI_SCI
> > +	tristate "TI System Control Interface (TI-SCI) reboot driver"
> > +	depends on TI_SCI_PROTOCOL
> > +	help
> > +	  This enables the reboot driver support over TI System Control
> > +	  Interface available on some TI's SoCs.
> > +
> >  config POWER_RESET_TPS65086
> >  	bool "TPS65086 restart driver"
> >  	depends on MFD_TPS65086
> > diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> > index a95d1bd275d18..881ca58a43b9c 100644
> > --- a/drivers/power/reset/Makefile
> > +++ b/drivers/power/reset/Makefile
> > @@ -23,6 +23,7 @@ obj-$(CONFIG_POWER_RESET_QNAP) +=3D qnap-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_REGULATOR) +=3D regulator-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_RESTART) +=3D restart-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_ST) +=3D st-poweroff.o
> > +obj-$(CONFIG_POWER_RESET_TI_SCI) +=3D ti-sci-reboot.o
> >  obj-$(CONFIG_POWER_RESET_TPS65086) +=3D tps65086-restart.o
> >  obj-$(CONFIG_POWER_RESET_VERSATILE) +=3D arm-versatile-reboot.o
> >  obj-$(CONFIG_POWER_RESET_VEXPRESS) +=3D vexpress-poweroff.o
> > diff --git a/drivers/power/reset/ti-sci-reboot.c b/drivers/power/reset/=
ti-sci-reboot.c
> > new file mode 100644
> > index 0000000000000..400bd5d740f8b
> > --- /dev/null
> > +++ b/drivers/power/reset/ti-sci-reboot.c
> > @@ -0,0 +1,63 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Texas Instrument's System Control Interface (TI-SCI) reboot driver
> > + *
> > + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.=
com/
> > + *	Andrew Davis <afd@ti.com>
> > + */
> > +
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reboot.h>
> > +
> > +#include <linux/soc/ti/ti_sci_protocol.h>
> > +
> > +static int ti_sci_reboot_handler(struct sys_off_data *data)
> > +{
> > +	const struct ti_sci_handle *sci =3D data->cb_data;
> > +	const struct ti_sci_core_ops *core_ops =3D &sci->ops.core_ops;
> > +
> > +	core_ops->reboot_device(sci);
> > +
> > +	return NOTIFY_DONE;
> > +}
> > +
> > +static int ti_sci_reboot_probe(struct platform_device *pdev)
> > +{
> > +	const struct ti_sci_handle *sci;
> > +	int err;
> > +
> > +	sci =3D devm_ti_sci_get_handle(&pdev->dev);
> > +	if (IS_ERR(sci))
> > +		return PTR_ERR(sci);
> > +
> > +	err =3D devm_register_sys_off_handler(&pdev->dev,
> > +					    SYS_OFF_MODE_RESTART,
> > +					    SYS_OFF_PRIO_LOW,
> > +					    ti_sci_reboot_handler,
> > +					    (void *)sci);
> > +	if (err)
> > +		return dev_err_probe(&pdev->dev, err, "Cannot register restart handl=
er\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id ti_sci_reboot_of_match[] =3D {
> > +	{ .compatible =3D "ti,sci-reboot", },
> > +	{ /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, ti_sci_reboot_of_match);
> > +
> > +static struct platform_driver ti_sci_reboot_driver =3D {
> > +	.probe =3D ti_sci_reboot_probe,
> > +	.driver =3D {
> > +		.name =3D "ti-sci-reboot",
> > +		.of_match_table =3D ti_sci_reboot_of_match,
> > +	},
> > +};
> > +module_platform_driver(ti_sci_reboot_driver);
> > +
> > +MODULE_AUTHOR("Andrew Davis <afd@ti.com>");
> > +MODULE_DESCRIPTION("TI System Control Interface (TI SCI) Reboot driver=
");
> > +MODULE_LICENSE("GPL");
> > --=20
> > 2.39.2
>=20
> Will assume the patch to go via Sebastien. Will be good for the dts to
> go via SoC tree. So hoping Sebastien will just pick the driver and
> bindings.

I will wait for the DT binding discussion to have settled. The
driver itself LGTM.

-- Sebastian

--pzni7lzp76a4ycxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmW9IIMACgkQ2O7X88g7
+poPVhAAhZtyxfQ0GDuYExpKNvR0PJYXbvA6n9jzOfg5v8ocwQoWCAEHxB0Stujq
W/hnOMJqQ7mPtDTmX3YAvGjak0ZZO8uBU4duj2ygS7szoJ0cOaOGSyDjDgvV2OnH
Tq+dv1s4P/Ex7bvs+jedaz8HFNK+Bq9YGyc58liCEv8OBWQ9dIkuQ37sA8Bf3HnL
V32FKMfW/Y640MIJ7J4EvteQPNWgb/UnobKLLQdoXgMHCkdoze3y0RNbDgdbuFvy
Amo+d/Y5Sachm21BoKKgrrw9/cVjiYl6LDcmPZoRCfNDA39d1HEI2gYovx8oet1z
eJAkLIA7nYPEKRPYYNObfeYFDSmxlYqE+mx1CGkieDh9qrlYo20bHxrZcjuWhTDV
ThMUw1wTAw0TwJZPgO4F2X53mmFf5bO5yebayCq0wUawVFqUdePj/KIjZRJCdVjL
dyhR1djDstBSdOwUCyv1KXltvFDhwrUx4GOFn7HUEmXqwM4kfuy0DeKZKFoagrdY
RnZaTcXKHof60XZJhkorunklTGMQAese+v8KKlaO+2GvyfD91Cm5BHtecL4nUt1n
ZVa5mPy+gYX6QcFjQYfwHn5RtApsX195b62wCV6fsZ0m5HxScyvDaClNEaGGqCdH
2k+f4aNCSyRb52HdgRAf7bajqWe3o6PTfLvxFsnJpIb1s+7RhZw=
=Qr8y
-----END PGP SIGNATURE-----

--pzni7lzp76a4ycxf--

