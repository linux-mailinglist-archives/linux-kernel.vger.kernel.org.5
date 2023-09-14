Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A826A7A0839
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbjINO7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbjINO66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:58:58 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CA61FD5;
        Thu, 14 Sep 2023 07:58:53 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 53AA142476;
        Thu, 14 Sep 2023 19:58:51 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694703531; bh=GFz9gA2Jil0rMSV6BK6G7cBuVLLNcRsExuN57gZ1Gvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PeMpoyKRvb84SJ+kaOsMhyC/nIxvh6lc4xGuLUAOUD8ej8HY6N64BOhcbC0O96Md2
         Adisw6VxyRe9bIDl9NCzYz2ovoeQ87u/ZPJZgAEzf11QB5F4SCwK3eaDqyGsQ6/rvc
         NlZEsQ1UpimRm1E3efiJz0jZGl65X8/jCA/XUeMC1qeMDbvg2fDiAqgbIDE1UBfzGe
         nUzHbjm2bghLgargvkfeQ9pfAYgQ66BIF0e1FRkKObBQ/0Ud9IA6rxj13owii0lfrt
         94a0sOVJJtN3Jm5PqVO9aYOLMj8GGK/eefNxVQ1+pzCHxSN7/zT2TkcZqsqOIH7Qnz
         1MmsrMvn/2MpA==
MIME-Version: 1.0
Date:   Thu, 14 Sep 2023 19:58:50 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] power: supply: Add pm8916 VM-BMS support
In-Reply-To: <20230914143514.s7ty4ixeykiqehev@mercury.elektranox.org>
References: <20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru>
 <20230731-pm8916-bms-lbc-v2-3-82a4ebb39c16@trvn.ru>
 <20230914143514.s7ty4ixeykiqehev@mercury.elektranox.org>
Message-ID: <e1d1fae275f9544f8ba73245352797d2@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Reichel писал(а) 14.09.2023 19:35:
> Hi,
> 
> On Mon, Jul 31, 2023 at 10:06:26PM +0500, Nikita Travkin wrote:
>> This driver adds basic support for VM-BMS found in pm8916.
>>
>> VM-BMS is a very basic fuel-gauge hardware block that is, sadly,
>> incapable of any gauging. The hardware supports measuring OCV in
>> sleep mode, where the battery is not in use, or measuring average
>> voltage over time when the device is active.
>>
>> This driver implements basic value readout from this block.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>> v2: Get irq by name
>> ---
> 
> Thanks for the patch. I have a few small change requests.
> 
>>  drivers/power/supply/Kconfig         |  11 ++
>>  drivers/power/supply/Makefile        |   1 +
>>  drivers/power/supply/pm8916_bms_vm.c | 296 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 308 insertions(+)
>>
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index 663a1c423806..e93a5a4d03e2 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -629,6 +629,17 @@ config CHARGER_QCOM_SMBB
>>  	  documentation for more detail.  The base name for this driver is
>>  	  'pm8941_charger'.
>>
>> +config BATTERY_PM8916_BMS_VM
>> +	tristate "Qualcomm PM8916 BMS-VM support"
>> +	depends on MFD_SPMI_PMIC || COMPILE_TEST
>> +	help
>> +	  Say Y to add support for Voltage Mode BMS block found in some
>> +	  Qualcomm PMICs such as PM8916. This hardware block provides
>> +	  battery voltage monitoring for the system.
>> +
>> +	  To compile this driver as module, choose M here: the
>> +	  module will be called pm8916_bms_vm.
>> +
>>  config CHARGER_BQ2415X
>>  	tristate "TI BQ2415x battery charger driver"
>>  	depends on I2C
>> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
>> index a8a9fa6de1e9..fdf7916f80ed 100644
>> --- a/drivers/power/supply/Makefile
>> +++ b/drivers/power/supply/Makefile
>> @@ -84,6 +84,7 @@ obj-$(CONFIG_CHARGER_MP2629)	+= mp2629_charger.o
>>  obj-$(CONFIG_CHARGER_MT6360)	+= mt6360_charger.o
>>  obj-$(CONFIG_CHARGER_MT6370)	+= mt6370-charger.o
>>  obj-$(CONFIG_CHARGER_QCOM_SMBB)	+= qcom_smbb.o
>> +obj-$(CONFIG_BATTERY_PM8916_BMS_VM)	+= pm8916_bms_vm.o
>>  obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
>>  obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
>>  obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
>> diff --git a/drivers/power/supply/pm8916_bms_vm.c b/drivers/power/supply/pm8916_bms_vm.c
>> new file mode 100644
>> index 000000000000..6cf00bf1c466
>> --- /dev/null
>> +++ b/drivers/power/supply/pm8916_bms_vm.c
>> @@ -0,0 +1,296 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023, Nikita Travkin <nikita@trvn.ru>
>> + */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
> 
> You should be able to remove the of headers after my proposed
> changes.
> 

Will switch and drop this.

>> +#include <linux/platform_device.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/property.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +
>> +#define PM8916_PERPH_TYPE 0x04
>> +#define PM8916_BMS_VM_TYPE 0x020D
>> +
>> +#define PM8916_SEC_ACCESS 0xD0
>> +#define PM8916_SEC_MAGIC 0xA5
>> +
>> +#define PM8916_BMS_VM_STATUS1 0x08
>> +#define PM8916_BMS_VM_FSM_STATE(x) (((x) & 0b00111000) >> 3)
>> +#define PM8916_BMS_VM_FSM_STATE_S2 0x2
>> +
>> +#define PM8916_BMS_VM_MODE_CTL 0x40
>> +#define PM8916_BMS_VM_MODE_FORCE_S3 (BIT(0) | BIT(1))
>> +#define PM8916_BMS_VM_MODE_NORMAL (BIT(1) | BIT(3))
>> +
>> +#define PM8916_BMS_VM_EN_CTL 0x46
>> +#define PM8916_BMS_ENABLED BIT(7)
>> +
>> +#define PM8916_BMS_VM_FIFO_LENGTH_CTL 0x47
>> +#define PM8916_BMS_VM_S1_SAMPLE_INTERVAL_CTL 0x55
>> +#define PM8916_BMS_VM_S2_SAMPLE_INTERVAL_CTL 0x56
>> +#define PM8916_BMS_VM_S3_S7_OCV_DATA0 0x6A
>> +#define PM8916_BMS_VM_BMS_FIFO_REG_0_LSB 0xC0
>> +
>> +/* Using only 1 fifo is broken in hardware */
>> +#define PM8916_BMS_VM_FIFO_COUNT 2 /* 2 .. 8 */
>> +
>> +#define PM8916_BMS_VM_S1_SAMPLE_INTERVAL 10
>> +#define PM8916_BMS_VM_S2_SAMPLE_INTERVAL 10
>> +
>> +struct pm8916_bms_vm_battery {
>> +	struct device *dev;
>> +	struct power_supply *battery;
>> +	struct power_supply_battery_info *info;
>> +	struct regmap *regmap;
>> +	unsigned int reg;
>> +	unsigned int last_ocv;
>> +	unsigned int vbat_now;
>> +};
>> +
>> +static int pm8916_bms_vm_battery_get_property(struct power_supply *psy,
>> +					      enum power_supply_property psp,
>> +					      union power_supply_propval *val)
>> +{
>> +	struct pm8916_bms_vm_battery *bat = power_supply_get_drvdata(psy);
>> +	struct power_supply_battery_info *info = bat->info;
>> +	int supplied;
>> +
>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_STATUS:
>> +		supplied = power_supply_am_i_supplied(psy);
>> +
>> +		if (supplied < 0 && supplied != -ENODEV)
>> +			return supplied;
>> +		else if (supplied && supplied != -ENODEV)
>> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
>> +		else
>> +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>> +		return 0;
>> +
>> +	case POWER_SUPPLY_PROP_HEALTH:
>> +		if (bat->vbat_now < info->voltage_min_design_uv)
>> +			val->intval = POWER_SUPPLY_HEALTH_DEAD;
>> +		else if (bat->vbat_now > info->voltage_max_design_uv)
>> +			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
>> +		else
>> +			val->intval = POWER_SUPPLY_HEALTH_GOOD;
>> +		return 0;
>> +
>> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> +		val->intval = bat->vbat_now;
>> +		return 0;
>> +
>> +	case POWER_SUPPLY_PROP_VOLTAGE_BOOT:
>> +		/* Returning last known ocv value here - it changes after suspend. */
>> +		val->intval = bat->last_ocv;
>> +		return 0;
> 
> Returning OCV from last suspend is not the same as VOLTAGE_BOOT. How
> about exposing POWER_SUPPLY_PROP_VOLTAGE_OCV and returning -ENODATA
> if the value is older than 180 seconds?
> 

Hm, indeed, I didn't think of this as an option... Will implement
that instead.

Thanks,
Nikita

>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static enum power_supply_property pm8916_bms_vm_battery_properties[] = {
>> +	POWER_SUPPLY_PROP_STATUS,
>> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>> +	POWER_SUPPLY_PROP_VOLTAGE_BOOT,
>> +	POWER_SUPPLY_PROP_HEALTH,
>> +};
>> +
>> +static irqreturn_t pm8916_bms_vm_fifo_update_done_irq(int irq, void *data)
>> +{
>> +	struct pm8916_bms_vm_battery *bat = data;
>> +	u16 vbat_data[PM8916_BMS_VM_FIFO_COUNT];
>> +	int ret;
>> +
>> +	ret = regmap_bulk_read(bat->regmap, bat->reg + PM8916_BMS_VM_BMS_FIFO_REG_0_LSB,
>> +			       &vbat_data, PM8916_BMS_VM_FIFO_COUNT * 2);
>> +	if (ret)
>> +		return IRQ_HANDLED;
>> +
>> +	/*
>> +	 * The VM-BMS hardware only collects voltage data and the software
>> +	 * has to process it to calculate the OCV and SoC. Hardware provides
>> +	 * up to 8 averaged measurements for software to take in account.
>> +	 *
>> +	 * Just use the last measured value for now to report the current
>> +	 * battery voltage.
>> +	 */
>> +	bat->vbat_now = vbat_data[PM8916_BMS_VM_FIFO_COUNT - 1] * 300;
>> +
>> +	power_supply_changed(bat->battery);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static const struct power_supply_desc pm8916_bms_vm_battery_psy_desc = {
>> +	.name = "pm8916-bms-vm",
>> +	.type = POWER_SUPPLY_TYPE_BATTERY,
>> +	.properties = pm8916_bms_vm_battery_properties,
>> +	.num_properties = ARRAY_SIZE(pm8916_bms_vm_battery_properties),
>> +	.get_property = pm8916_bms_vm_battery_get_property,
>> +};
>> +
>> +static int pm8916_bms_vm_battery_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct pm8916_bms_vm_battery *bat;
>> +	struct power_supply_config psy_cfg = {};
>> +	int ret, irq;
>> +	unsigned int tmp;
>> +
>> +	bat = devm_kzalloc(dev, sizeof(*bat), GFP_KERNEL);
>> +	if (!bat)
>> +		return -ENOMEM;
>> +
>> +	bat->dev = dev;
>> +
>> +	bat->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +	if (!bat->regmap)
>> +		return -ENODEV;
>> +
>> +	of_property_read_u32(dev->of_node, "reg", &bat->reg);
> 
> device_property_read_u32(...)
> 
>> +	if (bat->reg < 0)
>> +		return -EINVAL;
>> +
>> +	irq = platform_get_irq_byname(pdev, "fifo");
>> +	if (irq < 0)
>> +		return irq;
>> +
>> +	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_bms_vm_fifo_update_done_irq,
>> +					IRQF_ONESHOT, "pm8916_vm_bms", bat);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_bulk_read(bat->regmap, bat->reg + PM8916_PERPH_TYPE, &tmp, 2);
>> +	if (ret)
>> +		goto comm_error;
>> +
>> +	if (tmp != PM8916_BMS_VM_TYPE)
>> +		return dev_err_probe(dev, -ENODEV, "Device reported wrong type: 0x%X\n", tmp);
>> +
>> +	ret = regmap_write(bat->regmap, bat->reg + PM8916_BMS_VM_S1_SAMPLE_INTERVAL_CTL,
>> +			   PM8916_BMS_VM_S1_SAMPLE_INTERVAL);
>> +	if (ret)
>> +		goto comm_error;
>> +	ret = regmap_write(bat->regmap, bat->reg + PM8916_BMS_VM_S2_SAMPLE_INTERVAL_CTL,
>> +			   PM8916_BMS_VM_S2_SAMPLE_INTERVAL);
>> +	if (ret)
>> +		goto comm_error;
>> +	ret = regmap_write(bat->regmap, bat->reg + PM8916_BMS_VM_FIFO_LENGTH_CTL,
>> +			   PM8916_BMS_VM_FIFO_COUNT << 4 | PM8916_BMS_VM_FIFO_COUNT);
>> +	if (ret)
>> +		goto comm_error;
>> +	ret = regmap_write(bat->regmap,
>> +			   bat->reg + PM8916_BMS_VM_EN_CTL, PM8916_BMS_ENABLED);
>> +	if (ret)
>> +		goto comm_error;
>> +
>> +	ret = regmap_bulk_read(bat->regmap,
>> +			       bat->reg + PM8916_BMS_VM_S3_S7_OCV_DATA0, &tmp, 2);
>> +	if (ret)
>> +		goto comm_error;
>> +
>> +	bat->last_ocv = tmp * 300;
>> +	bat->vbat_now = bat->last_ocv;
>> +
>> +	psy_cfg.drv_data = bat;
>> +	psy_cfg.of_node = dev->of_node;
>> +
>> +	bat->battery = devm_power_supply_register(dev, &pm8916_bms_vm_battery_psy_desc, &psy_cfg);
>> +	if (IS_ERR(bat->battery))
>> +		return dev_err_probe(dev, PTR_ERR(bat->battery), "Unable to register battery\n");
>> +
>> +	ret = power_supply_get_battery_info(bat->battery, &bat->info);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Unable to get battery info\n");
>> +
>> +	platform_set_drvdata(pdev, bat);
>> +
>> +	return 0;
>> +
>> +comm_error:
>> +	return dev_err_probe(dev, ret, "Unable to communicate with device\n");
>> +}
>> +
>> +static int pm8916_bms_vm_battery_suspend(struct platform_device *pdev, pm_message_t state)
>> +{
>> +	struct pm8916_bms_vm_battery *bat = platform_get_drvdata(pdev);
>> +	int ret;
>> +
>> +	/*
>> +	 * Due to a hardware quirk the FSM doesn't switch states normally.
>> +	 * Instead we unlock the debug registers and force S3 (Measure OCV/Sleep)
>> +	 * mode every time we suspend.
>> +	 */
>> +
>> +	ret = regmap_write(bat->regmap,
>> +			   bat->reg + PM8916_SEC_ACCESS, PM8916_SEC_MAGIC);
>> +	if (ret)
>> +		goto error;
>> +	ret = regmap_write(bat->regmap,
>> +			   bat->reg + PM8916_BMS_VM_MODE_CTL, PM8916_BMS_VM_MODE_FORCE_S3);
>> +	if (ret)
>> +		goto error;
>> +
>> +	return 0;
>> +
>> +error:
>> +	dev_err(bat->dev, "Failed to force S3 mode: %pe\n", ERR_PTR(ret));
>> +	return ret;
>> +}
>> +
>> +static int pm8916_bms_vm_battery_resume(struct platform_device *pdev)
>> +{
>> +	struct pm8916_bms_vm_battery *bat = platform_get_drvdata(pdev);
>> +	int ret;
>> +	unsigned int tmp;
>> +
>> +	ret = regmap_bulk_read(bat->regmap,
>> +			       bat->reg + PM8916_BMS_VM_S3_S7_OCV_DATA0, &tmp, 2);
>> +
>> +	bat->last_ocv = tmp * 300;
>> +
>> +	ret = regmap_write(bat->regmap,
>> +			   bat->reg + PM8916_SEC_ACCESS, PM8916_SEC_MAGIC);
>> +	if (ret)
>> +		goto error;
>> +	ret = regmap_write(bat->regmap,
>> +			   bat->reg + PM8916_BMS_VM_MODE_CTL, PM8916_BMS_VM_MODE_NORMAL);
>> +	if (ret)
>> +		goto error;
>> +
>> +	return 0;
>> +
>> +error:
>> +	dev_err(bat->dev, "Failed to return normal mode: %pe\n", ERR_PTR(ret));
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id pm8916_bms_vm_battery_of_match[] = {
>> +	{ .compatible = "qcom,pm8916-bms-vm", },
>> +	{ },
> 
> {}
> 
> (i.e. remove space and trailing , for terminator entry)
> 
>> +};
>> +MODULE_DEVICE_TABLE(of, pm8916_bms_vm_battery_of_match);
>> +
>> +static struct platform_driver pm8916_bms_vm_battery_driver = {
>> +	.driver = {
>> +		.name = "pm8916-bms-vm",
>> +		.of_match_table = of_match_ptr(pm8916_bms_vm_battery_of_match),
> 
> remove of_match_ptr().
> 
>> +	},
>> +	.probe = pm8916_bms_vm_battery_probe,
>> +	.suspend = pm8916_bms_vm_battery_suspend,
>> +	.resume = pm8916_bms_vm_battery_resume,
>> +};
>> +module_platform_driver(pm8916_bms_vm_battery_driver);
>> +
>> +MODULE_DESCRIPTION("pm8916 BMS-VM driver");
>> +MODULE_AUTHOR("Nikita Travkin <nikita@trvn.ru>");
>> +MODULE_LICENSE("GPL");
> 
> Otherwise LGTM,
> 
> -- Sebastian
