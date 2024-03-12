Return-Path: <linux-kernel+bounces-100258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7547887942C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0184F285FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365AB4DA10;
	Tue, 12 Mar 2024 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JiESNIoE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8E8811;
	Tue, 12 Mar 2024 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246687; cv=none; b=Ufl3mNPbulP50ldgH8KgS5UDLKYuTVeVfJNikWGXZnZSpyYlrdoA1EQ1QQ2CHNIfAUKEHQZGGPr2jMP30WSga0OzkWIIVvmGJtkVCxdFnzxh4PZdnMAGkgsIVkfwHK5uPlfEWBTnNR4U5GzYuJL6JLEVA/Duq+N9RypH1CZUJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246687; c=relaxed/simple;
	bh=w/cyglwnPVOmiRZ7TIsw284OopOfcRNg/PqartzIFbI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uqs9yqdWt4kPXmEIfCmLT/Ffop6FCxxvHBhivBcR27SWBUFofTDu4zuLhLPRW463PUg7C6BJ/BgglYqLG42vHGBFqc94tj0bZ645bpbYmvokUrR5UbTWotANr02z3ifcjJnhFRTCYxleW/gEgtuLqZUpPuKLg105nRNmi7saN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JiESNIoE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710246686; x=1741782686;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=w/cyglwnPVOmiRZ7TIsw284OopOfcRNg/PqartzIFbI=;
  b=JiESNIoE3UtO+hKmJNWb82S9BSW1e+1uwIxhHcK7N8rSAsm0ST25MUZC
   MDXF4GWfZA+bqDHcbw1Pt5Dt4YElmJQXXW1FXmgTcavcJvku6hO0vpm6o
   5eO0ZlXt3MHCUoZY/mbQXSSBX7WQNCl9YxnJUjAbgvC2WuE8mHqIEr7TT
   UlgyCzuu5QJvr35pdVhVxgUwRW5qLzR62oHlZ8+2Bw2KNve1t2Kl5dckh
   hvZ3kGQknxtJy81oo+8jglmuZkRI7pwltoxQVktKGcKpeS2vooEqo9ROE
   F2rFbnVmXQZ79+lL0JMuP4H4ng3OOC2U1MGkeNKAqDKR7wuoxs/Pesj20
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="5085920"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5085920"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 05:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11449140"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.6])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 05:31:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Mar 2024 14:31:16 +0200 (EET)
To: Nikita Travkin <nikita@trvn.ru>
cc: Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>, 
    Rob Herring <robh+dt@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
    Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 3/4] platform: arm64: Add Acer Aspire 1 embedded
 controller driver
In-Reply-To: <20240312-aspire1-ec-v4-3-bd8e3eea212f@trvn.ru>
Message-ID: <6c6fe918-b2b1-a27c-8c94-a883547dd040@linux.intel.com>
References: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru> <20240312-aspire1-ec-v4-3-bd8e3eea212f@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 12 Mar 2024, Nikita Travkin wrote:

> Acer Aspire 1 is a Snapdragon 7c based laptop. It uses an embedded
> controller to perform a set of various functions, such as:
> 
> - Battery and charger monitoring;
> - Keyboard layout control (i.e. fn_lock settings);
> - USB Type-C DP alt mode HPD notifications;
> - Laptop lid status.
> 
> Unfortunately, while all this functionality is implemented in ACPI, it's
> currently not possible to use ACPI to boot Linux on such Qualcomm
> devices. To allow Linux to still support the features provided by EC,
> this driver reimplments the relevant ACPI parts. This allows us to boot
> the laptop with Device Tree and retain all the features.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  drivers/platform/arm64/Kconfig           |  16 +
>  drivers/platform/arm64/Makefile          |   2 +
>  drivers/platform/arm64/acer-aspire1-ec.c | 555 +++++++++++++++++++++++++++++++
>  3 files changed, 573 insertions(+)
> 
> diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
> index 644b83ede093..07d47879a9e3 100644
> --- a/drivers/platform/arm64/Kconfig
> +++ b/drivers/platform/arm64/Kconfig
> @@ -16,4 +16,20 @@ menuconfig ARM64_PLATFORM_DEVICES
>  
>  if ARM64_PLATFORM_DEVICES
>  
> +config EC_ACER_ASPIRE1
> +	tristate "Acer Aspire 1 Emedded Controller driver"
> +	depends on I2C
> +	depends on DRM
> +	depends on POWER_SUPPLY
> +	depends on INPUT
> +	help
> +	  Say Y here to enable the EC driver for the (Snapdragon-based)
> +	  Acer Aspire 1 laptop. The EC handles battery and charging
> +	  monitoring as well as some misc functions like the lid sensor
> +	  and USB Type-C DP HPD events.
> +
> +	  This driver provides battery and AC status support for the mentioned
> +	  laptop where this information is not properly exposed via the
> +	  standard ACPI devices.
> +
>  endif # ARM64_PLATFORM_DEVICES
> diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Makefile
> index f91cdc7155e2..4fcc9855579b 100644
> --- a/drivers/platform/arm64/Makefile
> +++ b/drivers/platform/arm64/Makefile
> @@ -4,3 +4,5 @@
>  #
>  # This dir should only include drivers for EC-like devices.
>  #
> +
> +obj-$(CONFIG_EC_ACER_ASPIRE1)	+= acer-aspire1-ec.o
> diff --git a/drivers/platform/arm64/acer-aspire1-ec.c b/drivers/platform/arm64/acer-aspire1-ec.c
> new file mode 100644
> index 000000000000..3941e24c5c7c
> --- /dev/null
> +++ b/drivers/platform/arm64/acer-aspire1-ec.c
> @@ -0,0 +1,555 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2023, Nikita Travkin <nikita@trvn.ru> */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/delay.h>
> +
> +#include <linux/usb/typec_mux.h>
> +#include <drm/drm_bridge.h>
> +
> +#define ASPIRE_EC_EVENT			0x05
> +
> +#define ASPIRE_EC_EVENT_WATCHDOG	0x20
> +#define ASPIRE_EC_EVENT_KBD_BKL_ON	0x57
> +#define ASPIRE_EC_EVENT_KBD_BKL_OFF	0x58
> +#define ASPIRE_EC_EVENT_LID_CLOSE	0x9b
> +#define ASPIRE_EC_EVENT_LID_OPEN	0x9c
> +#define ASPIRE_EC_EVENT_BKL_UNBLANKED	0x9d
> +#define ASPIRE_EC_EVENT_BKL_BLANKED	0x9e
> +#define ASPIRE_EC_EVENT_FG_INF_CHG	0x85
> +#define ASPIRE_EC_EVENT_FG_STA_CHG	0xc6
> +#define ASPIRE_EC_EVENT_HPD_DIS		0xa3
> +#define ASPIRE_EC_EVENT_HPD_CON		0xa4
> +
> +#define ASPIRE_EC_FG_DYNAMIC		0x07
> +#define ASPIRE_EC_FG_STATIC		0x08
> +
> +#define ASPIRE_EC_FG_FLAG_PRESENT	BIT(0)

Add #include <linux/bits.h>

> +#define ASPIRE_EC_FG_FLAG_FULL		BIT(1)
> +#define ASPIRE_EC_FG_FLAG_DISCHARGING	BIT(2)
> +#define ASPIRE_EC_FG_FLAG_CHARGING	BIT(3)
> +
> +#define ASPIRE_EC_RAM_READ		0x20
> +#define ASPIRE_EC_RAM_WRITE		0x21
> +
> +#define ASPIRE_EC_RAM_WATCHDOG		0x19
> +#define ASPIRE_EC_RAM_KBD_MODE		0x43
> +
> +#define ASPIRE_EC_RAM_KBD_FN_EN		BIT(0)
> +#define ASPIRE_EC_RAM_KBD_MEDIA_ON_TOP	BIT(5)
> +#define ASPIRE_EC_RAM_KBD_ALWAYS_SET	BIT(6)
> +#define ASPIRE_EC_RAM_KBD_NUM_LAYER_EN	BIT(7)
> +
> +#define ASPIRE_EC_RAM_KBD_MODE_2	0x60
> +
> +#define ASPIRE_EC_RAM_KBD_MEDIA_NOTIFY	BIT(3)
> +
> +#define ASPIRE_EC_RAM_HPD_STATUS	0xf4
> +#define ASPIRE_EC_HPD_CONNECTED		0x03
> +
> +#define ASPIRE_EC_RAM_LID_STATUS	0x4c
> +#define ASPIRE_EC_LID_OPEN		BIT(6)
> +
> +#define ASPIRE_EC_RAM_ADP		0x40
> +#define ASPIRE_EC_AC_STATUS		BIT(0)
> +
> +struct aspire_ec {
> +	struct i2c_client *client;
> +	struct power_supply *bat_psy;
> +	struct power_supply *adp_psy;
> +	struct input_dev *idev;
> +
> +	bool bridge_configured;
> +	struct drm_bridge bridge;
> +	struct work_struct work;

Include missing.

> +static int aspire_ec_ram_read(struct i2c_client *client, u8 off, u8 *data, u8 data_len)
> +{
> +	i2c_smbus_write_byte_data(client, ASPIRE_EC_RAM_READ, off);
> +	i2c_smbus_read_i2c_block_data(client, ASPIRE_EC_RAM_READ, data_len, data);
> +	return 0;
> +}
> +
> +static int aspire_ec_ram_write(struct i2c_client *client, u8 off, u8 data)
> +{
> +	u8 tmp[2] = {off, data};
> +
> +	i2c_smbus_write_i2c_block_data(client, ASPIRE_EC_RAM_WRITE, sizeof(tmp), tmp);
> +	return 0;
> +}
> +
> +static irqreturn_t aspire_ec_irq_handler(int irq, void *data)
> +{
> +	struct aspire_ec *ec = data;
> +	int id;
> +	u8 tmp;
> +
> +	/*
> +	 * The original ACPI firmware actually has a small sleep in the handler.
> +	 *
> +	 * It seems like in most cases it's not needed but when the device
> +	 * just exits suspend, our i2c driver has a brief time where data
> +	 * transfer is not possible yet. So this delay allows us to suppress
> +	 * quite a bunch of spurious error messages in dmesg. Thus it's kept.
> +	 */
> +	usleep_range(15000, 30000);
> +
> +	id = i2c_smbus_read_byte_data(ec->client, ASPIRE_EC_EVENT);
> +	if (id < 0) {
> +		dev_err(&ec->client->dev, "Failed to read event id: %pe\n", ERR_PTR(id));
> +		return IRQ_HANDLED;
> +	}
> +
> +	switch (id) {
> +	case 0x0: /* No event */
> +		break;
> +
> +	case ASPIRE_EC_EVENT_WATCHDOG:
> +		/*
> +		 * Here acpi responds to the event and clears some bit.
> +		 * Notify (\_SB.I2C3.BAT1, 0x81) // Information Change
> +		 * Notify (\_SB.I2C3.ADP1, 0x80) // Status Change
> +		 */
> +		aspire_ec_ram_read(ec->client, ASPIRE_EC_RAM_WATCHDOG, &tmp, sizeof(tmp));
> +		aspire_ec_ram_write(ec->client, ASPIRE_EC_RAM_WATCHDOG, tmp & 0xbf);

Magic 0xbf? Is this a clear bit operation which should use
	tmp & ~DEFINEDNAME
?

> +		break;
> +
> +	case ASPIRE_EC_EVENT_LID_CLOSE:
> +		/* Notify (\_SB.LID0, 0x80) // Status Change */
> +		input_report_switch(ec->idev, SW_LID, 1);
> +		input_sync(ec->idev);
> +		break;
> +
> +	case ASPIRE_EC_EVENT_LID_OPEN:
> +		/* Notify (\_SB.LID0, 0x80) // Status Change */
> +		input_report_switch(ec->idev, SW_LID, 0);
> +		input_sync(ec->idev);
> +		break;
> +
> +	case ASPIRE_EC_EVENT_FG_INF_CHG:
> +		/* Notify (\_SB.I2C3.BAT1, 0x81) // Information Change */

fallthrough;

I'm not 100% sure if it's needed because you only have a comment there but 
it surely doesn't hurt to have it.

> +	case ASPIRE_EC_EVENT_FG_STA_CHG:
> +		/* Notify (\_SB.I2C3.BAT1, 0x80) // Status Change */
> +		power_supply_changed(ec->bat_psy);
> +		power_supply_changed(ec->adp_psy);
> +		break;
> +
> +	case ASPIRE_EC_EVENT_HPD_DIS:
> +		if (ec->bridge_configured)
> +			drm_bridge_hpd_notify(&ec->bridge, connector_status_disconnected);
> +		break;
> +
> +	case ASPIRE_EC_EVENT_HPD_CON:
> +		if (ec->bridge_configured)
> +			drm_bridge_hpd_notify(&ec->bridge, connector_status_connected);
> +		break;
> +
> +	case ASPIRE_EC_EVENT_BKL_BLANKED:
> +	case ASPIRE_EC_EVENT_BKL_UNBLANKED:
> +		/* Display backlight blanked on FN+F6. No action needed. */
> +		break;
> +
> +	case ASPIRE_EC_EVENT_KBD_BKL_ON:
> +	case ASPIRE_EC_EVENT_KBD_BKL_OFF:
> +		/*
> +		 * There is a keyboard backlight connector on Aspire 1 that is
> +		 * controlled by FN+F8. There is no kb backlight on the device though.
> +		 * Seems like this is used on other devices like Acer Spin 7.
> +		 * No action needed.
> +		 */
> +		break;
> +
> +	default:
> +		dev_warn(&ec->client->dev, "Unknown event id=0x%x\n", id);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Power supply.
> + */
> +
> +struct aspire_ec_bat_psy_static_data {
> +	u8 unk1;
> +	u8 flags;
> +	__le16 unk2;
> +	__le16 voltage_design;
> +	__le16 capacity_full;
> +	__le16 unk3;
> +	__le16 serial;
> +	u8 model_id;
> +	u8 vendor_id;
> +} __packed;
> +
> +static const char * const aspire_ec_bat_psy_battery_model[] = {
> +	"AP18C4K",
> +	"AP18C8K",
> +	"AP19B8K",
> +	"AP16M4J",
> +	"AP16M5J",
> +};
> +
> +static const char * const aspire_ec_bat_psy_battery_vendor[] = {
> +	"SANYO",
> +	"SONY",
> +	"PANASONIC",
> +	"SAMSUNG",
> +	"SIMPLO",
> +	"MOTOROLA",
> +	"CELXPERT",
> +	"LGC",
> +	"GETAC",
> +	"MURATA",
> +};
> +
> +struct aspire_ec_bat_psy_dynamic_data {
> +	u8 unk1;
> +	u8 flags;
> +	u8 unk2;
> +	__le16 capacity_now;
> +	__le16 voltage_now;
> +	__le16 current_now;
> +	__le16 unk3;
> +	__le16 unk4;
> +} __packed;

What are the ARM64 rules when it comes to unaligned access? If it's not 
always supported, you need to use get_unaligned_le16() for accessing those 
__le16 fields.

> +static int aspire_ec_bat_psy_get_property(struct power_supply *psy,
> +				      enum power_supply_property psp,
> +				      union power_supply_propval *val)
> +{
> +	struct aspire_ec *ec = power_supply_get_drvdata(psy);
> +	struct aspire_ec_bat_psy_static_data sdat;
> +	struct aspire_ec_bat_psy_dynamic_data ddat;
> +
> +	i2c_smbus_read_i2c_block_data(ec->client, ASPIRE_EC_FG_STATIC, sizeof(sdat), (u8 *)&sdat);
> +	i2c_smbus_read_i2c_block_data(ec->client, ASPIRE_EC_FG_DYNAMIC, sizeof(ddat), (u8 *)&ddat);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
> +		if (ddat.flags & ASPIRE_EC_FG_FLAG_CHARGING)
> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +		else if (ddat.flags & ASPIRE_EC_FG_FLAG_DISCHARGING)
> +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +		else if (ddat.flags & ASPIRE_EC_FG_FLAG_FULL)
> +			val->intval = POWER_SUPPLY_STATUS_FULL;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval = le16_to_cpu(ddat.voltage_now) * 1000;

linux/units.h provides something that can often be used instead of 10^n 
literals.

> +		break;
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		val->intval = le16_to_cpu(sdat.voltage_design) * 1000;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		val->intval = le16_to_cpu(ddat.capacity_now) * 1000;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		val->intval = le16_to_cpu(sdat.capacity_full) * 1000;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		val->intval = le16_to_cpu(ddat.capacity_now) * 100;
> +		val->intval /= le16_to_cpu(sdat.capacity_full);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		val->intval = (s16)le16_to_cpu(ddat.current_now) * 1000;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval = !!(ddat.flags & ASPIRE_EC_FG_FLAG_PRESENT);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_SCOPE:
> +		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		if (sdat.model_id - 1 < ARRAY_SIZE(aspire_ec_bat_psy_battery_model))
> +			val->strval = aspire_ec_bat_psy_battery_model[sdat.model_id - 1];

Underflow handling (also here, the other place was mentioned already)?

> +		else
> +			val->strval = "Unknown";
> +		break;
> +
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		if (sdat.vendor_id - 3 < ARRAY_SIZE(aspire_ec_bat_psy_battery_vendor))
> +			val->strval = aspire_ec_bat_psy_battery_vendor[sdat.vendor_id - 3];
> +		else
> +			val->strval = "Unknown";
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property aspire_ec_bat_psy_props[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_SCOPE,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +static const struct power_supply_desc aspire_ec_bat_psy_desc = {
> +	.name		= "aspire-ec-bat",
> +	.type		= POWER_SUPPLY_TYPE_BATTERY,
> +	.get_property	= aspire_ec_bat_psy_get_property,
> +	.properties	= aspire_ec_bat_psy_props,
> +	.num_properties	= ARRAY_SIZE(aspire_ec_bat_psy_props),
> +};
> +
> +static int aspire_ec_adp_psy_get_property(struct power_supply *psy,
> +				      enum power_supply_property psp,
> +				      union power_supply_propval *val)
> +{
> +	struct aspire_ec *ec = power_supply_get_drvdata(psy);
> +	u8 tmp;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		aspire_ec_ram_read(ec->client, ASPIRE_EC_RAM_ADP, &tmp, sizeof(tmp));
> +		val->intval = !!(tmp & ASPIRE_EC_AC_STATUS);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property aspire_ec_adp_psy_props[] = {
> +	POWER_SUPPLY_PROP_ONLINE,
> +};
> +
> +static const struct power_supply_desc aspire_ec_adp_psy_desc = {
> +	.name		= "aspire-ec-adp",
> +	.type		= POWER_SUPPLY_TYPE_MAINS,
> +	.get_property	= aspire_ec_adp_psy_get_property,
> +	.properties	= aspire_ec_adp_psy_props,
> +	.num_properties	= ARRAY_SIZE(aspire_ec_adp_psy_props),
> +};
> +
> +/*
> + * USB-C DP Alt mode HPD.
> + */
> +
> +static int aspire_ec_bridge_attach(struct drm_bridge *bridge, enum drm_bridge_attach_flags flags)
> +{
> +	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
> +}
> +
> +static void aspire_ec_bridge_update_hpd_work(struct work_struct *work)
> +{
> +	struct aspire_ec *ec = container_of(work, struct aspire_ec, work);
> +	u8 tmp;
> +
> +	aspire_ec_ram_read(ec->client, ASPIRE_EC_RAM_HPD_STATUS, &tmp, sizeof(tmp));
> +	if (tmp == ASPIRE_EC_HPD_CONNECTED)
> +		drm_bridge_hpd_notify(&ec->bridge, connector_status_connected);
> +	else
> +		drm_bridge_hpd_notify(&ec->bridge, connector_status_disconnected);
> +}
> +
> +static void aspire_ec_bridge_hpd_enable(struct drm_bridge *bridge)
> +{
> +	struct aspire_ec *ec = container_of(bridge, struct aspire_ec, bridge);
> +
> +	schedule_work(&ec->work);
> +}
> +
> +static const struct drm_bridge_funcs aspire_ec_bridge_funcs = {
> +	.hpd_enable = aspire_ec_bridge_hpd_enable,
> +	.attach = aspire_ec_bridge_attach,
> +};
> +
> +/*
> + * Sysfs attributes.
> + */
> +
> +static ssize_t fn_lock_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct aspire_ec *ec = i2c_get_clientdata(to_i2c_client(dev));
> +	u8 tmp;
> +
> +	aspire_ec_ram_read(ec->client, ASPIRE_EC_RAM_KBD_MODE, &tmp, sizeof(tmp));
> +
> +	return sysfs_emit(buf, "%d\n", !(tmp & ASPIRE_EC_RAM_KBD_MEDIA_ON_TOP));

%u

> +}
> +
> +static ssize_t fn_lock_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	struct aspire_ec *ec = i2c_get_clientdata(to_i2c_client(dev));
> +	u8 tmp;
> +
> +	bool state;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &state);
> +	if (ret)
> +		return ret;
> +
> +	aspire_ec_ram_read(ec->client, ASPIRE_EC_RAM_KBD_MODE, &tmp, sizeof(tmp));
> +
> +	if (state)
> +		tmp &= ~ASPIRE_EC_RAM_KBD_MEDIA_ON_TOP;
> +	else
> +		tmp |= ASPIRE_EC_RAM_KBD_MEDIA_ON_TOP;
> +
> +	aspire_ec_ram_write(ec->client, ASPIRE_EC_RAM_KBD_MODE, tmp);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(fn_lock);
> +
> +static struct attribute *aspire_ec_attributes[] = {
> +	&dev_attr_fn_lock.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group aspire_ec_attribute_group = {
> +	.attrs = aspire_ec_attributes
> +};
> +
> +static int aspire_ec_probe(struct i2c_client *client)
> +{
> +	struct power_supply_config psy_cfg = {0};
> +	struct device *dev = &client->dev;
> +	struct fwnode_handle *fwnode;
> +	struct aspire_ec *ec;
> +	int ret;
> +	u8 tmp;
> +
> +	ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
> +	if (!ec)
> +		return -ENOMEM;
> +
> +	ec->client = client;
> +	i2c_set_clientdata(client, ec);
> +
> +	/* Battery status reports */
> +	psy_cfg.drv_data = ec;
> +	ec->bat_psy = devm_power_supply_register(dev, &aspire_ec_bat_psy_desc, &psy_cfg);
> +	if (IS_ERR(ec->bat_psy))
> +		return dev_err_probe(dev, PTR_ERR(ec->bat_psy),
> +				     "Failed to register battery power supply\n");
> +
> +	ec->adp_psy = devm_power_supply_register(dev, &aspire_ec_adp_psy_desc, &psy_cfg);
> +	if (IS_ERR(ec->adp_psy))
> +		return dev_err_probe(dev, PTR_ERR(ec->adp_psy),
> +				     "Failed to register ac power supply\n");

AC

> +	/* Lid switch */
> +	ec->idev = devm_input_allocate_device(dev);
> +	if (!ec->idev)
> +		return -ENOMEM;
> +
> +	ec->idev->name = "aspire-ec";
> +	ec->idev->phys = "aspire-ec/input0";
> +	input_set_capability(ec->idev, EV_SW, SW_LID);
> +
> +	ret = input_register_device(ec->idev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Input device register failed\n");
> +
> +	/* Enable the keyboard fn keys */
> +	tmp = ASPIRE_EC_RAM_KBD_FN_EN | ASPIRE_EC_RAM_KBD_ALWAYS_SET;
> +	tmp |= ASPIRE_EC_RAM_KBD_MEDIA_ON_TOP;
> +	aspire_ec_ram_write(client, ASPIRE_EC_RAM_KBD_MODE, tmp);
> +
> +	aspire_ec_ram_read(client, ASPIRE_EC_RAM_KBD_MODE_2, &tmp, sizeof(tmp));
> +	tmp |= ASPIRE_EC_RAM_KBD_MEDIA_NOTIFY;
> +	aspire_ec_ram_write(client, ASPIRE_EC_RAM_KBD_MODE_2, tmp);
> +
> +	ret = devm_device_add_group(dev, &aspire_ec_attribute_group);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to create attribute group\n");

Can't you just .dev_groups ?


In general, this felt to be in a quite good shape already, good work!

-- 
 i.


