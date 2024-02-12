Return-Path: <linux-kernel+bounces-61031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802FB850C77
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 01:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AC51C20B62
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4A2EC5;
	Mon, 12 Feb 2024 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YKJabCZw"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43D0193;
	Mon, 12 Feb 2024 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707696895; cv=none; b=GNaYn/81JfAVj1HdIVb8aGsHOkC95rwxa91PkIjdLHJST1q15vtqfZ+OndaKtnBAKRmHElxO5XYsiqOPcpTE6drUWkYFUgJAWMVTLfrMzfTXawMedc3+RQlCbd2RnCk5o3hwQ18gYAF5cj/d6ggrYXgU+QJDcgURYHY68mjwDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707696895; c=relaxed/simple;
	bh=PLATnBGsWoCebjYRmGv8TO2TlmS2PIzupiGRftsCx7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q89OB/GY9l8ChkxXC7mzbY5Ef7AFHEWWl1E+EUdd1zk/wB+Bzl/3HqzkwLsMsLa9R/0XZVani+4N5i1A+JfxhNKCjfbaywpH3Zsor2RGwpU7NmEMaqx0xAA0v0kA80n25I+9l1Y2vTwzm7v+IoBKWKtDCsTRqfzRZ+GyG4aZy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YKJabCZw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707696892;
	bh=PLATnBGsWoCebjYRmGv8TO2TlmS2PIzupiGRftsCx7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKJabCZwVYqubsLG9IkiH+9PdraZbOHyky2MQwIoURF0l/H081Wv2ekbK81xLYoyM
	 T4tKs3WIkY5kHtSFCtHE0pYbUjoYRV5rul0UstN7XEIwUqrjBQXYvMfNBS9futFnRw
	 n5bnd7J7mSm+EH4PwcgYkr3ZdjDKGjOxmGhBAO/wgeTdP4Ly1WId9P/YgA6yHQQexa
	 HK/4m9Qd6OxMHK60uyp1/Hh7NZKt+OXCHAHEZvtJWnfbX/Sl5m07QiTrefqJT8Pr9i
	 SpfYv5hjBHbPcYywx5OtQbetdOQRMwNupiRExfLbJ4skTyKdAu05/Rr/IASisndmnB
	 PDIc9QR2/ERbg==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D56BB37810EF;
	Mon, 12 Feb 2024 00:14:51 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 2B4EF106043F; Mon, 12 Feb 2024 01:14:51 +0100 (CET)
Date: Mon, 12 Feb 2024 01:14:50 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] power: supply: Add STC3117 fuel gauge unit driver
Message-ID: <eccj4u6ewr33mlp4xqwx5medeysrjuwof7ntwhm6vypmmkss73@qjbpyw5hj3t7>
References: <20240205051321.4079933-1-bhavin.sharma@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="53rtivfpmxpcamhc"
Content-Disposition: inline
In-Reply-To: <20240205051321.4079933-1-bhavin.sharma@siliconsignals.io>


--53rtivfpmxpcamhc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 05, 2024 at 10:43:17AM +0530, Bhavin Sharma wrote:
> Adding minimal support for stc3117 fuel gauge driver
> to read battery voltage level

Why only voltage?
It should be easy to support more data exposed by the chip.

> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---
> Changelogs :
>=20
> v2 -> v3
> - Resolved kernel test robot build warnings
> - Aligned included header files in alphabetical order
> - Removed unused header files
> - Removed unnecessary blank lines
> - Aligned all the macros in alphabetical order
> - Changed macro LSB_VALUE to VOLTAGE_LSB_VALUE
> - Dropped function prototypes and arranged the code accordingly
> - Used macros instead of static numbers for array declaration
> - Removed redundant code
> - Replaced 'power_supply_register' with 'devm_power_supply_register' and =
'pr_err' with 'dev_err'
> - Removed global variables
>=20
> v1 -> v2
> - No change
> ---
>  drivers/power/supply/Kconfig              |   7 ++
>  drivers/power/supply/Makefile             |   1 +
>  drivers/power/supply/stc3117_fuel_gauge.c | 107 ++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index f21cb05815ec..e2e3af4bcd5f 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -875,6 +875,13 @@ config FUEL_GAUGE_SC27XX
>  	  Say Y here to enable support for fuel gauge with SC27XX
>  	  PMIC chips.
> =20
> +config FUEL_GAUGE_STC3117
> +        tristate "STMicroelectronics STC3117 fuel gauge driver"
> +        depends on I2C
> +        help
> +          Say Y here to enable support for fuel gauge with STC3117
> +          PMIC chips.
> +
>  config CHARGER_UCS1002
>  	tristate "Microchip UCS1002 USB Port Power Controller"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 58b567278034..be8961661bd1 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -104,6 +104,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+=3D cros_usbpd-char=
ger.o
>  obj-$(CONFIG_CHARGER_CROS_PCHG)	+=3D cros_peripheral_charger.o
>  obj-$(CONFIG_CHARGER_SC2731)	+=3D sc2731_charger.o
>  obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+=3D sc27xx_fuel_gauge.o
> +obj-$(CONFIG_FUEL_GAUGE_STC3117)        +=3D stc3117_fuel_gauge.o
>  obj-$(CONFIG_CHARGER_UCS1002)	+=3D ucs1002_power.o
>  obj-$(CONFIG_CHARGER_BD99954)	+=3D bd99954-charger.o
>  obj-$(CONFIG_CHARGER_WILCO)	+=3D wilco-charger.o
> diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/su=
pply/stc3117_fuel_gauge.c
> new file mode 100644
> index 000000000000..29eb00b44e21
> --- /dev/null
> +++ b/drivers/power/supply/stc3117_fuel_gauge.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
> + *
> + * Copyright (c) 2024 Silicon Signals Pvt Ltd.
> + * Author:      Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> + *              Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.=
com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/power_supply.h>
> +
> +#define VOLTAGE_DATA_SIZE	2		// in bytes
> +#define VOLTAGE_LSB_VALUE	2200		// in micro-volts
> +#define VOLTAGE_REG_ADDR	0x08
> +#define VOLTAGE_REG_ADDR_SIZE	1		// in bytes
> +
> +static int stc3117_get_batt_volt(const struct i2c_client *stc_client)
> +{
> +	int ret, volt =3D 0;
> +	char i2c_tx =3D VOLTAGE_REG_ADDR, i2c_rx[VOLTAGE_DATA_SIZE] =3D {0};
> +
> +	ret =3D i2c_master_send(stc_client, &i2c_tx, VOLTAGE_REG_ADDR_SIZE);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D i2c_master_recv(stc_client, i2c_rx, VOLTAGE_DATA_SIZE);
> +	if (ret < 0)
> +		return ret;
> +
> +	volt =3D (i2c_rx[1] << 8) + i2c_rx[0];
> +	volt *=3D VOLTAGE_LSB_VALUE;
> +
> +	return volt;
> +}

Please use regmap.

> +static int stc3117_get_property(struct power_supply *psy,
> +	enum power_supply_property psp, union power_supply_propval *val)
> +{
> +	struct i2c_client *client =3D to_i2c_client(psy->dev.parent);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval =3D stc3117_get_batt_volt(client);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static enum power_supply_property stc3117_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +};
> +
> +static const struct power_supply_desc stc3117_battery_desc =3D {
> +	.name =3D "stc3117-battery",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.get_property =3D stc3117_get_property,
> +	.properties =3D stc3117_battery_props,
> +	.num_properties =3D ARRAY_SIZE(stc3117_battery_props),
> +};
> +
> +static int stc3117_probe(struct i2c_client *client)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct device *dev;
> +	struct power_supply *stc_sply;
> +
> +	dev =3D &client->dev;

Just initialize this at declaration time.

> +	psy_cfg.of_node =3D dev->of_node;
> +
> +	stc_sply =3D devm_power_supply_register(dev, &stc3117_battery_desc, &ps=
y_cfg);
> +	if (IS_ERR(stc_sply))
> +		dev_err(dev, "failed to register battery\n");

return dev_err_probe(dev, PTR_ERR(stc_sply), "failed to register battery\n"=
);

> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id stc3117_id[] =3D {
> +	{"stc3117", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, stc3117_id);
> +
> +static const struct of_device_id stc3117_of_match[] =3D {
> +	{ .compatible =3D "st,stc3117" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, stc3117_of_match);
> +
> +static struct i2c_driver stc3117_i2c_driver =3D {
> +	.driver =3D {
> +		.name =3D "stc3117_i2c_driver",
> +		.of_match_table =3D stc3117_of_match,
> +	},
> +	.probe =3D stc3117_probe,
> +	.id_table =3D stc3117_id,
> +};
> +
> +module_i2c_driver(stc3117_i2c_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
> +MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.i=
o>");
> +MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");

Greetings,

-- Sebastian

--53rtivfpmxpcamhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXJYvMACgkQ2O7X88g7
+pq+Fg/+KmAWqIxr7oIl56n2nZTrUKRlAzVL1pVtSTjPEZSa+DZchDJmRbxTxLxR
tfkCPToIy2O6xKYCj5ILAZJ1gp7nqXd2OTwzlwfAtjdwv68GlJufa5tP1L4xJjJg
MChkZoksGK3QK4fgHj2hmzEnKO5GJU/87cUvOKYCSJ8XsYtoQyF6EM+zxI/tfC6W
VqPtxAuDExgQuI0aS30WGJcBN5xDNzlklhLtHTrpic14SYxE77wDEziU1kt97uMS
WN4VoIRuF3IeZrhmOuOc+XdB7eziPOxjQcGfsTucBVP8DwLQCllfSOyej0f9xxJF
bSs8Mdon4JYJui3W1lNdaFkGPCVidx8GY6jmu1enAHDAiSQt0H5587yr6ZGDOvpi
P3h4CNmvR0+e/BsWUsaP6YqjstriM9WICTw0A32uqb6YIbX82HN6pZwrhLPj7Pz+
KVj6pV889Af/YZ3SE7BMHlqTnFRYn2roRw6bHJuL4FtarLXIP1+M5JZX+NAPdheN
uA6B4Pjc3RJqQTAUD47aPIFg89BI+6CWz9uktK4sIZUKp/l6G2uS5krH8tTp2S1O
/xwxZPCDuVZQ/Q1oMeueH2C8FVnWxVs2Ic46R6cfYBeUABbu6KzGjaOHY7z1ehae
/Lx9qs1h9b7HBnrmrm9NZSl/vqCDNL+oSrWbEoOpdmtAwlQQQm0=
=aNtg
-----END PGP SIGNATURE-----

--53rtivfpmxpcamhc--

