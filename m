Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C015A7A0770
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbjINOfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjINOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:35:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5D41A2;
        Thu, 14 Sep 2023 07:35:18 -0700 (PDT)
Received: from mercury (dyndsl-091-248-132-131.ewe-ip-backbone.de [91.248.132.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1382266003AF;
        Thu, 14 Sep 2023 15:35:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694702117;
        bh=RoBwj43qBwQz9PVVhY6Q30zMfBOlOy6y4/MKrUwz4PE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mRs+RV1bKzpVXECbknDcfgl5t65LVlUCbUTUab5PD+WHNNAcrnBzlYsxOWw32AUfU
         SbQa9pGoqPz87QEnsg+2GsJcazJOjHaEYXII2uSIkVqsaXWL/+pXxYYmqqS7V6kvzI
         cjdpYEbpDGfv1/+VJgpIMmuh4GespDO79udnraRrutz6AXF+CLHm/kGHuTGQ2RT0lx
         o7ZKx/vAyWiOn2ghAOHiGVfosTFa0TJTi6vnqLZNdoNTUd+g1NAoSW4K1aokzJQzCE
         sS0t8V7hXvM30y/1WFkxL6I87uuYu0Lc9qdMLglJLAXp1skUFK0CrbxwHAGsn300m5
         5ADrAIxv5UY9A==
Received: by mercury (Postfix, from userid 1000)
        id C0393106098B; Thu, 14 Sep 2023 16:35:14 +0200 (CEST)
Date:   Thu, 14 Sep 2023 16:35:14 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] power: supply: Add pm8916 VM-BMS support
Message-ID: <20230914143514.s7ty4ixeykiqehev@mercury.elektranox.org>
References: <20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru>
 <20230731-pm8916-bms-lbc-v2-3-82a4ebb39c16@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i6f3fresuytr3q2t"
Content-Disposition: inline
In-Reply-To: <20230731-pm8916-bms-lbc-v2-3-82a4ebb39c16@trvn.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i6f3fresuytr3q2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 31, 2023 at 10:06:26PM +0500, Nikita Travkin wrote:
> This driver adds basic support for VM-BMS found in pm8916.
>=20
> VM-BMS is a very basic fuel-gauge hardware block that is, sadly,
> incapable of any gauging. The hardware supports measuring OCV in
> sleep mode, where the battery is not in use, or measuring average
> voltage over time when the device is active.
>=20
> This driver implements basic value readout from this block.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
> v2: Get irq by name
> ---

Thanks for the patch. I have a few small change requests.

>  drivers/power/supply/Kconfig         |  11 ++
>  drivers/power/supply/Makefile        |   1 +
>  drivers/power/supply/pm8916_bms_vm.c | 296 +++++++++++++++++++++++++++++=
++++++
>  3 files changed, 308 insertions(+)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 663a1c423806..e93a5a4d03e2 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -629,6 +629,17 @@ config CHARGER_QCOM_SMBB
>  	  documentation for more detail.  The base name for this driver is
>  	  'pm8941_charger'.
> =20
> +config BATTERY_PM8916_BMS_VM
> +	tristate "Qualcomm PM8916 BMS-VM support"
> +	depends on MFD_SPMI_PMIC || COMPILE_TEST
> +	help
> +	  Say Y to add support for Voltage Mode BMS block found in some
> +	  Qualcomm PMICs such as PM8916. This hardware block provides
> +	  battery voltage monitoring for the system.
> +
> +	  To compile this driver as module, choose M here: the
> +	  module will be called pm8916_bms_vm.
> +
>  config CHARGER_BQ2415X
>  	tristate "TI BQ2415x battery charger driver"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index a8a9fa6de1e9..fdf7916f80ed 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_CHARGER_MP2629)	+=3D mp2629_charger.o
>  obj-$(CONFIG_CHARGER_MT6360)	+=3D mt6360_charger.o
>  obj-$(CONFIG_CHARGER_MT6370)	+=3D mt6370-charger.o
>  obj-$(CONFIG_CHARGER_QCOM_SMBB)	+=3D qcom_smbb.o
> +obj-$(CONFIG_BATTERY_PM8916_BMS_VM)	+=3D pm8916_bms_vm.o
>  obj-$(CONFIG_CHARGER_BQ2415X)	+=3D bq2415x_charger.o
>  obj-$(CONFIG_CHARGER_BQ24190)	+=3D bq24190_charger.o
>  obj-$(CONFIG_CHARGER_BQ24257)	+=3D bq24257_charger.o
> diff --git a/drivers/power/supply/pm8916_bms_vm.c b/drivers/power/supply/=
pm8916_bms_vm.c
> new file mode 100644
> index 000000000000..6cf00bf1c466
> --- /dev/null
> +++ b/drivers/power/supply/pm8916_bms_vm.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Nikita Travkin <nikita@trvn.ru>
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

You should be able to remove the of headers after my proposed
changes.

> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +
> +#define PM8916_PERPH_TYPE 0x04
> +#define PM8916_BMS_VM_TYPE 0x020D
> +
> +#define PM8916_SEC_ACCESS 0xD0
> +#define PM8916_SEC_MAGIC 0xA5
> +
> +#define PM8916_BMS_VM_STATUS1 0x08
> +#define PM8916_BMS_VM_FSM_STATE(x) (((x) & 0b00111000) >> 3)
> +#define PM8916_BMS_VM_FSM_STATE_S2 0x2
> +
> +#define PM8916_BMS_VM_MODE_CTL 0x40
> +#define PM8916_BMS_VM_MODE_FORCE_S3 (BIT(0) | BIT(1))
> +#define PM8916_BMS_VM_MODE_NORMAL (BIT(1) | BIT(3))
> +
> +#define PM8916_BMS_VM_EN_CTL 0x46
> +#define PM8916_BMS_ENABLED BIT(7)
> +
> +#define PM8916_BMS_VM_FIFO_LENGTH_CTL 0x47
> +#define PM8916_BMS_VM_S1_SAMPLE_INTERVAL_CTL 0x55
> +#define PM8916_BMS_VM_S2_SAMPLE_INTERVAL_CTL 0x56
> +#define PM8916_BMS_VM_S3_S7_OCV_DATA0 0x6A
> +#define PM8916_BMS_VM_BMS_FIFO_REG_0_LSB 0xC0
> +
> +/* Using only 1 fifo is broken in hardware */
> +#define PM8916_BMS_VM_FIFO_COUNT 2 /* 2 .. 8 */
> +
> +#define PM8916_BMS_VM_S1_SAMPLE_INTERVAL 10
> +#define PM8916_BMS_VM_S2_SAMPLE_INTERVAL 10
> +
> +struct pm8916_bms_vm_battery {
> +	struct device *dev;
> +	struct power_supply *battery;
> +	struct power_supply_battery_info *info;
> +	struct regmap *regmap;
> +	unsigned int reg;
> +	unsigned int last_ocv;
> +	unsigned int vbat_now;
> +};
> +
> +static int pm8916_bms_vm_battery_get_property(struct power_supply *psy,
> +					      enum power_supply_property psp,
> +					      union power_supply_propval *val)
> +{
> +	struct pm8916_bms_vm_battery *bat =3D power_supply_get_drvdata(psy);
> +	struct power_supply_battery_info *info =3D bat->info;
> +	int supplied;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		supplied =3D power_supply_am_i_supplied(psy);
> +
> +		if (supplied < 0 && supplied !=3D -ENODEV)
> +			return supplied;
> +		else if (supplied && supplied !=3D -ENODEV)
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		else
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		return 0;
> +
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		if (bat->vbat_now < info->voltage_min_design_uv)
> +			val->intval =3D POWER_SUPPLY_HEALTH_DEAD;
> +		else if (bat->vbat_now > info->voltage_max_design_uv)
> +			val->intval =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		else
> +			val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> +		return 0;
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval =3D bat->vbat_now;
> +		return 0;
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_BOOT:
> +		/* Returning last known ocv value here - it changes after suspend. */
> +		val->intval =3D bat->last_ocv;
> +		return 0;

Returning OCV from last suspend is not the same as VOLTAGE_BOOT. How
about exposing POWER_SUPPLY_PROP_VOLTAGE_OCV and returning -ENODATA
if the value is older than 180 seconds?

> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static enum power_supply_property pm8916_bms_vm_battery_properties[] =3D=
 {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_BOOT,
> +	POWER_SUPPLY_PROP_HEALTH,
> +};
> +
> +static irqreturn_t pm8916_bms_vm_fifo_update_done_irq(int irq, void *dat=
a)
> +{
> +	struct pm8916_bms_vm_battery *bat =3D data;
> +	u16 vbat_data[PM8916_BMS_VM_FIFO_COUNT];
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(bat->regmap, bat->reg + PM8916_BMS_VM_BMS_FIFO=
_REG_0_LSB,
> +			       &vbat_data, PM8916_BMS_VM_FIFO_COUNT * 2);
> +	if (ret)
> +		return IRQ_HANDLED;
> +
> +	/*
> +	 * The VM-BMS hardware only collects voltage data and the software
> +	 * has to process it to calculate the OCV and SoC. Hardware provides
> +	 * up to 8 averaged measurements for software to take in account.
> +	 *
> +	 * Just use the last measured value for now to report the current
> +	 * battery voltage.
> +	 */
> +	bat->vbat_now =3D vbat_data[PM8916_BMS_VM_FIFO_COUNT - 1] * 300;
> +
> +	power_supply_changed(bat->battery);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct power_supply_desc pm8916_bms_vm_battery_psy_desc =3D=
 {
> +	.name =3D "pm8916-bms-vm",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D pm8916_bms_vm_battery_properties,
> +	.num_properties =3D ARRAY_SIZE(pm8916_bms_vm_battery_properties),
> +	.get_property =3D pm8916_bms_vm_battery_get_property,
> +};
> +
> +static int pm8916_bms_vm_battery_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct pm8916_bms_vm_battery *bat;
> +	struct power_supply_config psy_cfg =3D {};
> +	int ret, irq;
> +	unsigned int tmp;
> +
> +	bat =3D devm_kzalloc(dev, sizeof(*bat), GFP_KERNEL);
> +	if (!bat)
> +		return -ENOMEM;
> +
> +	bat->dev =3D dev;
> +
> +	bat->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!bat->regmap)
> +		return -ENODEV;
> +
> +	of_property_read_u32(dev->of_node, "reg", &bat->reg);

device_property_read_u32(...)

> +	if (bat->reg < 0)
> +		return -EINVAL;
> +
> +	irq =3D platform_get_irq_byname(pdev, "fifo");
> +	if (irq < 0)
> +		return irq;
> +
> +	ret =3D devm_request_threaded_irq(dev, irq, NULL, pm8916_bms_vm_fifo_up=
date_done_irq,
> +					IRQF_ONESHOT, "pm8916_vm_bms", bat);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_bulk_read(bat->regmap, bat->reg + PM8916_PERPH_TYPE, &tm=
p, 2);
> +	if (ret)
> +		goto comm_error;
> +
> +	if (tmp !=3D PM8916_BMS_VM_TYPE)
> +		return dev_err_probe(dev, -ENODEV, "Device reported wrong type: 0x%X\n=
", tmp);
> +
> +	ret =3D regmap_write(bat->regmap, bat->reg + PM8916_BMS_VM_S1_SAMPLE_IN=
TERVAL_CTL,
> +			   PM8916_BMS_VM_S1_SAMPLE_INTERVAL);
> +	if (ret)
> +		goto comm_error;
> +	ret =3D regmap_write(bat->regmap, bat->reg + PM8916_BMS_VM_S2_SAMPLE_IN=
TERVAL_CTL,
> +			   PM8916_BMS_VM_S2_SAMPLE_INTERVAL);
> +	if (ret)
> +		goto comm_error;
> +	ret =3D regmap_write(bat->regmap, bat->reg + PM8916_BMS_VM_FIFO_LENGTH_=
CTL,
> +			   PM8916_BMS_VM_FIFO_COUNT << 4 | PM8916_BMS_VM_FIFO_COUNT);
> +	if (ret)
> +		goto comm_error;
> +	ret =3D regmap_write(bat->regmap,
> +			   bat->reg + PM8916_BMS_VM_EN_CTL, PM8916_BMS_ENABLED);
> +	if (ret)
> +		goto comm_error;
> +
> +	ret =3D regmap_bulk_read(bat->regmap,
> +			       bat->reg + PM8916_BMS_VM_S3_S7_OCV_DATA0, &tmp, 2);
> +	if (ret)
> +		goto comm_error;
> +
> +	bat->last_ocv =3D tmp * 300;
> +	bat->vbat_now =3D bat->last_ocv;
> +
> +	psy_cfg.drv_data =3D bat;
> +	psy_cfg.of_node =3D dev->of_node;
> +
> +	bat->battery =3D devm_power_supply_register(dev, &pm8916_bms_vm_battery=
_psy_desc, &psy_cfg);
> +	if (IS_ERR(bat->battery))
> +		return dev_err_probe(dev, PTR_ERR(bat->battery), "Unable to register b=
attery\n");
> +
> +	ret =3D power_supply_get_battery_info(bat->battery, &bat->info);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to get battery info\n");
> +
> +	platform_set_drvdata(pdev, bat);
> +
> +	return 0;
> +
> +comm_error:
> +	return dev_err_probe(dev, ret, "Unable to communicate with device\n");
> +}
> +
> +static int pm8916_bms_vm_battery_suspend(struct platform_device *pdev, p=
m_message_t state)
> +{
> +	struct pm8916_bms_vm_battery *bat =3D platform_get_drvdata(pdev);
> +	int ret;
> +
> +	/*
> +	 * Due to a hardware quirk the FSM doesn't switch states normally.
> +	 * Instead we unlock the debug registers and force S3 (Measure OCV/Slee=
p)
> +	 * mode every time we suspend.
> +	 */
> +
> +	ret =3D regmap_write(bat->regmap,
> +			   bat->reg + PM8916_SEC_ACCESS, PM8916_SEC_MAGIC);
> +	if (ret)
> +		goto error;
> +	ret =3D regmap_write(bat->regmap,
> +			   bat->reg + PM8916_BMS_VM_MODE_CTL, PM8916_BMS_VM_MODE_FORCE_S3);
> +	if (ret)
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	dev_err(bat->dev, "Failed to force S3 mode: %pe\n", ERR_PTR(ret));
> +	return ret;
> +}
> +
> +static int pm8916_bms_vm_battery_resume(struct platform_device *pdev)
> +{
> +	struct pm8916_bms_vm_battery *bat =3D platform_get_drvdata(pdev);
> +	int ret;
> +	unsigned int tmp;
> +
> +	ret =3D regmap_bulk_read(bat->regmap,
> +			       bat->reg + PM8916_BMS_VM_S3_S7_OCV_DATA0, &tmp, 2);
> +
> +	bat->last_ocv =3D tmp * 300;
> +
> +	ret =3D regmap_write(bat->regmap,
> +			   bat->reg + PM8916_SEC_ACCESS, PM8916_SEC_MAGIC);
> +	if (ret)
> +		goto error;
> +	ret =3D regmap_write(bat->regmap,
> +			   bat->reg + PM8916_BMS_VM_MODE_CTL, PM8916_BMS_VM_MODE_NORMAL);
> +	if (ret)
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	dev_err(bat->dev, "Failed to return normal mode: %pe\n", ERR_PTR(ret));
> +	return ret;
> +}
> +
> +static const struct of_device_id pm8916_bms_vm_battery_of_match[] =3D {
> +	{ .compatible =3D "qcom,pm8916-bms-vm", },
> +	{ },

{}

(i.e. remove space and trailing , for terminator entry)

> +};
> +MODULE_DEVICE_TABLE(of, pm8916_bms_vm_battery_of_match);
> +
> +static struct platform_driver pm8916_bms_vm_battery_driver =3D {
> +	.driver =3D {
> +		.name =3D "pm8916-bms-vm",
> +		.of_match_table =3D of_match_ptr(pm8916_bms_vm_battery_of_match),

remove of_match_ptr().

> +	},
> +	.probe =3D pm8916_bms_vm_battery_probe,
> +	.suspend =3D pm8916_bms_vm_battery_suspend,
> +	.resume =3D pm8916_bms_vm_battery_resume,
> +};
> +module_platform_driver(pm8916_bms_vm_battery_driver);
> +
> +MODULE_DESCRIPTION("pm8916 BMS-VM driver");
> +MODULE_AUTHOR("Nikita Travkin <nikita@trvn.ru>");
> +MODULE_LICENSE("GPL");

Otherwise LGTM,

-- Sebastian

--i6f3fresuytr3q2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUDGiIACgkQ2O7X88g7
+poOhw/+K6Mb+raEgrn49XPTOJLWVw4K6B35g/UCAedSb5ojhCtktJxk3ORPOKKF
gWiHZM0vMmncEWNiFN18tMOED5mXhfvi8rjdHkckoh5gT4ARcRDahSnqhNC5muMF
/S4RXVJjDAA5WJkotoGf7fo16SQoEQhqt8s4XwxhODG7Vby+ACtL6smeaV4m9AxA
sxN8pW+K5FM98daAzQzboBkqWJPo6TX4cWttYcxb9tbO4RlYK4+x9rWocbOo+Tl8
fiWmTnM9qN+A93omhLnNqi1L09w5CU//nsJF1Zkg+GZat8ReCpP+TX1nde3FSUI+
AMkSJjAXVwno7u2x3QjzRdg/rit4kbPTPGYxkvjjP444KQkTFeP8xyrHpZSGVDIG
H42eA4J9y/cJg+D93kKSJJbSmZ7XZxVeyIo5RYEvhMiguGcstAZcMygTIdvIeek3
4Euof0GVEM5g+QKc+r2NczfT0RqBB04r7UMAnmgx7tgv+c3my82+vpO+9RKeipi6
SHYD8KXfMoh6znq+OHW2DO4eNkUHc1Re6dVDJfWSjck+VCoP97/ChtDIPkZxVTbo
lJnv7OXxnxUJwZfseyoubUMSwylmRLwreHktywpGqVhvFeAwazdYu+UJ064JGqiW
Pxdbyk4PxfCN2iLCYtF2V/wQCQ2eDLIrlC3D1EJvZVcZa2HO4iE=
=CvTf
-----END PGP SIGNATURE-----

--i6f3fresuytr3q2t--
