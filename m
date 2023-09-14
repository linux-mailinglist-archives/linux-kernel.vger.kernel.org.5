Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531727A0740
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbjINO0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240003AbjINO0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:26:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A5299;
        Thu, 14 Sep 2023 07:26:02 -0700 (PDT)
Received: from mercury (dyndsl-091-248-132-131.ewe-ip-backbone.de [91.248.132.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BDC3D66003AF;
        Thu, 14 Sep 2023 15:26:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694701560;
        bh=okg0371M8FWm/p6FHT8qOvxKdPNwasi3albOHTHqsxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ko49n5vgJZIUU0g7ivxAx5hBqkQmX3SN1eHZ5jVoc6f4rq6gDuKI0FNs84Daxen5O
         /GyGwtmrZarYfZisjnU5btQ0OdxxFnKexiLp1CnV/QtA9mIHTgMfvggFx13MIuY1mD
         Fo3Tzv4jPW9Xmhe8Me1YKkYl+sCAQ4/I5ihSGg1J+rutrRXcihlTrm5jtQwHfyoJIE
         oly+/9G29+fEAK9mBG8Fbb5PW8T4wLT84qgCrxAH5HDtCuBpxjF4bdzmPhYzuNepvO
         x4Hvl+ldVgNMtK/af/Y8MrK9qNbA0/ynwRnjdqdyt2oCxwNb5j/40rkK1EoYBcK7bf
         /rIocoNlSBONQ==
Received: by mercury (Postfix, from userid 1000)
        id 87724106098B; Thu, 14 Sep 2023 16:25:58 +0200 (CEST)
Date:   Thu, 14 Sep 2023 16:25:58 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] power: supply: Add driver for pm8916 lbc
Message-ID: <20230914142558.4pvwxneyz7hg4hhp@mercury.elektranox.org>
References: <20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru>
 <20230731-pm8916-bms-lbc-v2-4-82a4ebb39c16@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vhqpdutryql3dikf"
Content-Disposition: inline
In-Reply-To: <20230731-pm8916-bms-lbc-v2-4-82a4ebb39c16@trvn.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vhqpdutryql3dikf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 31, 2023 at 10:06:27PM +0500, Nikita Travkin wrote:
> pm8916 LBC is a Linear Battery Charger hardware block in pm8916 PMIC.
>=20
> This block implements simple CC/CV charging for Li-Po batteries.
> The hardware has internal state machine to switch between modes and
> works mostly autonomously, only needing the limits and targets to be
> set to operate.
>=20
> This driver allows setting limits and enabling the LBC block, monitoring
> it's state.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
> v2: Fix missed warnings, get irq by name
> ---

Looks mostly good, but I have a few small requests.

>  drivers/power/supply/Kconfig      |  11 ++
>  drivers/power/supply/Makefile     |   1 +
>  drivers/power/supply/pm8916_lbc.c | 383 ++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 395 insertions(+)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e93a5a4d03e2..a2ea249a57c6 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -640,6 +640,17 @@ config BATTERY_PM8916_BMS_VM
>  	  To compile this driver as module, choose M here: the
>  	  module will be called pm8916_bms_vm.
> =20
> +config CHARGER_PM8916_LBC
> +	tristate "Qualcomm PM8916 Linear Battery Charger support"
> +	depends on MFD_SPMI_PMIC || COMPILE_TEST
> +	help
> +	  Say Y here to add support for Linear Battery Charger block
> +	  found in some Qualcomm PMICs such as PM8916. This hardware
> +	  blokc provides simple CC/CV battery charger.
> +
> +	  To compile this driver as module, choose M here: the
> +	  module will be called pm8916_lbc.
> +
>  config CHARGER_BQ2415X
>  	tristate "TI BQ2415x battery charger driver"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index fdf7916f80ed..e4bd9eb1261b 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_CHARGER_MT6360)	+=3D mt6360_charger.o
>  obj-$(CONFIG_CHARGER_MT6370)	+=3D mt6370-charger.o
>  obj-$(CONFIG_CHARGER_QCOM_SMBB)	+=3D qcom_smbb.o
>  obj-$(CONFIG_BATTERY_PM8916_BMS_VM)	+=3D pm8916_bms_vm.o
> +obj-$(CONFIG_CHARGER_PM8916_LBC)	+=3D pm8916_lbc.o
>  obj-$(CONFIG_CHARGER_BQ2415X)	+=3D bq2415x_charger.o
>  obj-$(CONFIG_CHARGER_BQ24190)	+=3D bq24190_charger.o
>  obj-$(CONFIG_CHARGER_BQ24257)	+=3D bq24257_charger.o
> diff --git a/drivers/power/supply/pm8916_lbc.c b/drivers/power/supply/pm8=
916_lbc.c
> new file mode 100644
> index 000000000000..490cb7064dbf
> --- /dev/null
> +++ b/drivers/power/supply/pm8916_lbc.c
> @@ -0,0 +1,383 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Nikita Travkin <nikita@trvn.ru>
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

It should be fine to remove the of headers after my proposed
changes.

> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/extcon-provider.h>
> +
> +/* Two bytes: type + subtype */
> +#define PM8916_PERPH_TYPE 0x04
> +#define PM8916_LBC_CHGR_TYPE 0x1502
> +#define PM8916_LBC_BAT_IF_TYPE 0x1602
> +#define PM8916_LBC_USB_TYPE 0x1702
> +#define PM8916_LBC_MISC_TYPE 0x1802
> +
> +#define PM8916_LBC_CHGR_CHG_OPTION 0x08
> +#define PM8916_LBC_CHGR_PMIC_CHARGER BIT(7)
> +
> +#define PM8916_LBC_CHGR_CHG_STATUS 0x09
> +
> +#define PM8916_INT_RT_STS 0x10
> +
> +#define PM8916_LBC_USB_USBIN_VALID BIT(1)
> +
> +#define PM8916_LBC_CHGR_VDD_MAX 0x40
> +#define PM8916_LBC_CHGR_VDD_SAFE 0x41
> +#define PM8916_LBC_CHGR_IBAT_MAX 0x44
> +#define PM8916_LBC_CHGR_IBAT_SAFE 0x45
> +
> +#define PM8916_LBC_CHGR_TCHG_MAX_EN 0x60
> +#define PM8916_LBC_CHGR_TCHG_MAX_ENABLED BIT(7)
> +#define PM8916_LBC_CHGR_TCHG_MAX 0x61
> +
> +#define PM8916_LBC_CHGR_CHG_CTRL 0x49
> +#define PM8916_LBC_CHGR_CHG_EN BIT(7)
> +#define PM8916_LBC_CHGR_PSTG_EN BIT(5)
> +
> +#define PM8916_LBC_CHGR_MIN_CURRENT 90000
> +#define PM8916_LBC_CHGR_MAX_CURRENT 1440000
> +
> +#define PM8916_LBC_CHGR_MIN_VOLTAGE 4000000
> +#define PM8916_LBC_CHGR_MAX_VOLTAGE 4775000
> +#define PM8916_LBC_CHGR_VOLTAGE_STEP 25000
> +
> +#define PM8916_LBC_CHGR_MIN_TIME 4
> +#define PM8916_LBC_CHGR_MAX_TIME 256
> +
> +struct pm8916_lbc_charger {
> +	struct device *dev;
> +	struct extcon_dev *edev;
> +	struct power_supply *charger;
> +	struct power_supply_battery_info *info;
> +	struct regmap *regmap;
> +	unsigned int reg[4];
> +	bool online;
> +	unsigned int charge_voltage_max;
> +	unsigned int charge_voltage_safe;
> +	unsigned int charge_current_max;
> +	unsigned int charge_current_safe;
> +};
> +
> +static const unsigned int pm8916_lbc_charger_cable[] =3D {
> +	EXTCON_USB,
> +	EXTCON_NONE,
> +};
> +
> +enum {
> +	LBC_CHGR =3D 0,
> +	LBC_BAT_IF,
> +	LBC_USB,
> +	LBC_MISC,
> +};
> +
> +static int pm8916_lbc_charger_configure(struct pm8916_lbc_charger *chg)
> +{
> +	int ret =3D 0;
> +	unsigned int tmp;
> +
> +	chg->charge_voltage_max =3D clamp_t(u32, chg->charge_voltage_max,
> +					  PM8916_LBC_CHGR_MIN_VOLTAGE, chg->charge_voltage_safe);
> +
> +	tmp =3D chg->charge_voltage_max - PM8916_LBC_CHGR_MIN_VOLTAGE;
> +	tmp /=3D PM8916_LBC_CHGR_VOLTAGE_STEP;
> +	chg->charge_voltage_max =3D PM8916_LBC_CHGR_MIN_VOLTAGE + tmp * PM8916_=
LBC_CHGR_VOLTAGE_STEP;
> +
> +	ret =3D regmap_write(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_=
VDD_MAX, tmp);
> +	if (ret)
> +		goto error;
> +
> +	chg->charge_current_max =3D min(chg->charge_current_max, chg->charge_cu=
rrent_safe);
> +
> +	tmp =3D clamp_t(u32, chg->charge_current_max,
> +		      PM8916_LBC_CHGR_MIN_CURRENT, PM8916_LBC_CHGR_MAX_CURRENT);
> +
> +	tmp =3D chg->charge_current_max / PM8916_LBC_CHGR_MIN_CURRENT - 1;
> +	chg->charge_current_max =3D (tmp + 1) * PM8916_LBC_CHGR_MIN_CURRENT;
> +
> +	ret =3D regmap_write(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_=
IBAT_MAX, tmp);
> +	if (ret)
> +		goto error;
> +
> +	ret =3D regmap_write(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_=
CHG_CTRL,
> +			   PM8916_LBC_CHGR_CHG_EN | PM8916_LBC_CHGR_PSTG_EN);
> +	if (ret)
> +		goto error;
> +
> +	return ret;
> +
> +error:
> +	dev_err(chg->dev, "Failed to configure charging: %pe\n", ERR_PTR(ret));
> +	return ret;
> +}
> +
> +static int pm8916_lbc_charger_get_property(struct power_supply *psy,
> +					   enum power_supply_property psp,
> +					   union power_supply_propval *val)
> +{
> +	struct pm8916_lbc_charger *chg =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D chg->online;
> +		return 0;
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		val->intval =3D chg->charge_voltage_max;
> +		return 0;
> +
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		val->intval =3D chg->charge_current_max;
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	};
> +}
> +
> +static int pm8916_lbc_charger_set_property(struct power_supply *psy,
> +					   enum power_supply_property prop,
> +					   const union power_supply_propval *val)
> +{
> +	struct pm8916_lbc_charger *chg =3D power_supply_get_drvdata(psy);
> +
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		chg->charge_current_max =3D val->intval;
> +		return pm8916_lbc_charger_configure(chg);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int pm8916_lbc_charger_property_is_writeable(struct power_supply =
*psy,
> +						    enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static enum power_supply_property pm8916_lbc_charger_properties[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +};

POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT is about the charger input,
e.g. 500mA limit for a USB based charger. The variable names you are
using suggests, that you want to expose
POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT instead.

> +static irqreturn_t pm8916_lbc_charger_state_changed_irq(int irq, void *d=
ata)
> +{
> +	struct pm8916_lbc_charger *chg =3D data;
> +	unsigned int tmp;
> +	int ret;
> +
> +	ret =3D regmap_read(chg->regmap, chg->reg[LBC_USB] + PM8916_INT_RT_STS,=
 &tmp);
> +	if (ret)
> +		return IRQ_HANDLED;
> +
> +	chg->online =3D !!(tmp & PM8916_LBC_USB_USBIN_VALID);
> +	extcon_set_state_sync(chg->edev, EXTCON_USB, chg->online);
> +
> +	power_supply_changed(chg->charger);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pm8916_lbc_charger_probe_dt(struct pm8916_lbc_charger *chg)
> +{
> +	struct device *dev =3D chg->dev;
> +	struct device_node *np =3D dev->of_node;
> +	int ret =3D 0;
> +	unsigned int tmp;
> +
> +	ret =3D of_property_read_u32(np, "qcom,fast-charge-safe-voltage", &chg-=
>charge_voltage_safe);

device_property_read_u32(...)

> +	if (ret)
> +		return ret;
> +	if (chg->charge_voltage_safe < PM8916_LBC_CHGR_MIN_VOLTAGE)
> +		return -EINVAL;
> +
> +	chg->charge_voltage_safe =3D clamp_t(u32, chg->charge_voltage_safe,
> +					PM8916_LBC_CHGR_MIN_VOLTAGE, PM8916_LBC_CHGR_MAX_VOLTAGE);
> +
> +	tmp =3D chg->charge_voltage_safe - PM8916_LBC_CHGR_MIN_VOLTAGE;
> +	tmp /=3D PM8916_LBC_CHGR_VOLTAGE_STEP;
> +	ret =3D regmap_write(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_=
VDD_SAFE, tmp);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D of_property_read_u32(np, "qcom,fast-charge-safe-current", &chg-=
>charge_current_safe);

device_property_read_u32(...)

> +	if (ret)
> +		return ret;
> +	if (chg->charge_current_safe < PM8916_LBC_CHGR_MIN_CURRENT)
> +		return -EINVAL;
> +
> +	chg->charge_current_safe =3D clamp_t(u32, chg->charge_current_safe,
> +					PM8916_LBC_CHGR_MIN_CURRENT, PM8916_LBC_CHGR_MAX_CURRENT);
> +
> +	chg->charge_current_max =3D chg->charge_current_safe;
> +
> +	tmp =3D chg->charge_current_safe / PM8916_LBC_CHGR_MIN_CURRENT - 1;
> +	ret =3D regmap_write(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_=
IBAT_SAFE, tmp);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable charger timeout. */
> +	ret =3D regmap_write(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_=
TCHG_MAX_EN, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +}
> +
> +static const struct power_supply_desc pm8916_lbc_charger_psy_desc =3D {
> +	.name =3D "pm8916-lbc-chgr",
> +	.type =3D POWER_SUPPLY_TYPE_USB,
> +	.properties =3D pm8916_lbc_charger_properties,
> +	.num_properties =3D ARRAY_SIZE(pm8916_lbc_charger_properties),
> +	.get_property =3D pm8916_lbc_charger_get_property,
> +	.set_property =3D pm8916_lbc_charger_set_property,
> +	.property_is_writeable =3D pm8916_lbc_charger_property_is_writeable,
> +};
> +
> +static int pm8916_lbc_charger_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct pm8916_lbc_charger *chg;
> +	struct power_supply_config psy_cfg =3D {};
> +	int ret, len, irq;
> +	unsigned int tmp;
> +
> +	chg =3D devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return -ENOMEM;
> +
> +	chg->dev =3D dev;
> +
> +	chg->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!chg->regmap)
> +		return -ENODEV;
> +
> +	len =3D of_property_count_u32_elems(dev->of_node, "reg");

device_property_count_u32(...)

> +	if (len < 0)
> +		return len;
> +	if (len !=3D 4)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Wrong amount of reg values: %d (4 expected)\n", len);
> +
> +	irq =3D platform_get_irq_byname(pdev, "usb_vbus");
> +	if (irq < 0)
> +		return irq;
> +
> +	ret =3D devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_st=
ate_changed_irq,
> +					IRQF_ONESHOT, "pm8916_lbc", chg);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D of_property_read_u32_array(dev->of_node, "reg", chg->reg, len);

device_property_read_u32_array(...)

> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_bulk_read(chg->regmap, chg->reg[LBC_CHGR] + PM8916_PERPH=
_TYPE, &tmp, 2);
> +	if (ret)
> +		goto comm_error;
> +	if (tmp !=3D PM8916_LBC_CHGR_TYPE)
> +		goto type_error;
> +
> +	ret =3D regmap_bulk_read(chg->regmap, chg->reg[LBC_BAT_IF] + PM8916_PER=
PH_TYPE, &tmp, 2);
> +	if (ret)
> +		goto comm_error;
> +	if (tmp !=3D PM8916_LBC_BAT_IF_TYPE)
> +		goto type_error;
> +
> +	ret =3D regmap_bulk_read(chg->regmap, chg->reg[LBC_USB] + PM8916_PERPH_=
TYPE, &tmp, 2);
> +	if (ret)
> +		goto comm_error;
> +	if (tmp !=3D PM8916_LBC_USB_TYPE)
> +		goto type_error;
> +
> +	ret =3D regmap_bulk_read(chg->regmap, chg->reg[LBC_MISC] + PM8916_PERPH=
_TYPE, &tmp, 2);
> +	if (ret)
> +		goto comm_error;
> +	if (tmp !=3D PM8916_LBC_MISC_TYPE)
> +		goto type_error;
> +
> +	ret =3D regmap_read(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_C=
HG_OPTION, &tmp);
> +	if (ret)
> +		goto comm_error;
> +	if (tmp !=3D PM8916_LBC_CHGR_PMIC_CHARGER)
> +		dev_err_probe(dev, -ENODEV, "The system is using an external charger\n=
");
> +
> +	ret =3D pm8916_lbc_charger_probe_dt(chg);
> +	if (ret)
> +		dev_err_probe(dev, ret, "Error while parsing device tree\n");
> +
> +	psy_cfg.drv_data =3D chg;
> +	psy_cfg.of_node =3D dev->of_node;
> +
> +	chg->charger =3D devm_power_supply_register(dev, &pm8916_lbc_charger_ps=
y_desc, &psy_cfg);
> +	if (IS_ERR(chg->charger))
> +		return dev_err_probe(dev, PTR_ERR(chg->charger), "Unable to register c=
harger\n");
> +
> +	ret =3D power_supply_get_battery_info(chg->charger, &chg->info);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to get battery info\n");
> +
> +	chg->edev =3D devm_extcon_dev_allocate(dev, pm8916_lbc_charger_cable);
> +	if (IS_ERR(chg->edev))
> +		return PTR_ERR(chg->edev);
> +
> +	ret =3D devm_extcon_dev_register(dev, chg->edev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to register extcon device\n");
> +
> +	ret =3D regmap_read(chg->regmap, chg->reg[LBC_USB] + PM8916_INT_RT_STS,=
 &tmp);
> +	if (ret)
> +		goto comm_error;
> +
> +	chg->online =3D !!(tmp & PM8916_LBC_USB_USBIN_VALID);
> +	extcon_set_state_sync(chg->edev, EXTCON_USB, chg->online);
> +
> +	chg->charge_voltage_max =3D chg->info->voltage_max_design_uv;
> +	ret =3D pm8916_lbc_charger_configure(chg);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +
> +comm_error:
> +	return dev_err_probe(dev, ret, "Unable to communicate with device\n");
> +
> +type_error:
> +	return dev_err_probe(dev, -ENODEV, "Device reported wrong type: 0x%X\n"=
, tmp);
> +}
> +
> +static const struct of_device_id pm8916_lbc_charger_of_match[] =3D {
> +	{ .compatible =3D "qcom,pm8916-lbc", },
> +	{ },

{},

(i.e. remove space and trailing, for the terminator entry)

> +};
> +MODULE_DEVICE_TABLE(of, pm8916_lbc_charger_of_match);
> +
> +static struct platform_driver pm8916_lbc_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D "pm8916-lbc",
> +		.of_match_table =3D of_match_ptr(pm8916_lbc_charger_of_match),

=2Eof_match_table =3D pm8916_lbc_charger_of_match,

> +	},
> +	.probe =3D pm8916_lbc_charger_probe,
> +};
> +module_platform_driver(pm8916_lbc_charger_driver);
> +
> +MODULE_DESCRIPTION("pm8916 LBC driver");
> +MODULE_AUTHOR("Nikita Travkin <nikita@trvn.ru>");
> +MODULE_LICENSE("GPL");

Thanks and sorry for the slow review.

-- Sebastian

--vhqpdutryql3dikf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUDF+oACgkQ2O7X88g7
+pqRNBAApHTUnFipMeD35yFJtCY+FHZuI+BIyyMdMhEYah54hR8tovg9Brmhr9HN
9pWoC4mQuYUlfgD6tRhsB3+boL7s6uqY2AsvlzZr8QSRpzN5OalvC8J44J17ezpy
2G1fLQnBoIl5dtL9BHn4PCFXQfrjCEXZKMpZW0qPa0NlztiZgOuhkVu43iffUjjO
uy+Wre/vCpY9M6WBRpNSPbU6AQT/Nsd5okmdqjRDPlX7BKL9LpVtmx8xd417E95J
bDrXSbmutJQRqtxGzfXwQqi7IvgxeHUO2dJw9VF3nTS6mkdMP5v6tOUpDG9TmASI
idDREMTLm8bKyudksntXBhQrnvaPOG2Siv6MMhWNpZvb7x8l3Tpy6MOQSM/ajr8x
LromGxaHqKFmieYD51gGMq1Z7KOGyZopotEC8HV71sU0EBd1ba9rxJgenCbaBbiB
makcfzUUo85YT7OrdOYSAI46/SiPC3ekxTRbxX6uYtl6NQ0Fwc593rEDc/U5iDou
PWeuwLkTnNCXUvkvRJXGV0mpLmL/H8cXl5hQwAPf5NilV6Ajc04aYDXMaddwbFwG
F9D9467vQrKetTin6ClAedtncajgwxByTVEohDbR02t8GmBejw3NYfAG7t8DT7YQ
pk9RFnBI/tk6WAuj2KBo/BfPG7cKLJ5KrX82bHtoElHB+v3w56I=
=4xwR
-----END PGP SIGNATURE-----

--vhqpdutryql3dikf--
