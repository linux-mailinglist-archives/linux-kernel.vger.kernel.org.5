Return-Path: <linux-kernel+bounces-100199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DA6879374
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363EF2847DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBBB79DBF;
	Tue, 12 Mar 2024 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpvt6prC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3D79B98
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244706; cv=none; b=nk2hGJXiaJ8nLmHFmWqT3kXmhQxtine5uxmX0qxD5zGeAL5BKfQzcDJOYwLn54S8gqCEa4Gg574KzIVHjc/A+mpCe+Vfo/0daGk6oI3LfAx2EH1D403OaJKsRe7TIMJaFhAa/zKj7IXe7BN8Q9X+sGuL8ccyr19UAACNhoTJNbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244706; c=relaxed/simple;
	bh=5FCdoh0EXpHGc2+3Dhw2LPALVfDj6SdOefQjOUvm+ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryC72IJm1u9timLqF3GH5/4fZ56Ed37Q+zXBOY7xMOMIcX7cO9JVp3wJSNheVAO8ldTNTimh+AbHvxiicZuTN/ay6x3RGt12x30HQU3Yw1zhDCNJHD5jFOTjV2zYiZ8SLnnjscFZXWSeEX5FSQdtftqR9kOSa7bkIhTeQNrdu6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tpvt6prC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41329b6286bso11764865e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710244703; x=1710849503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKp0htl8d23a0PhO993HNxz3WKKW3EQtqTL+zri38Cc=;
        b=tpvt6prClsaQ8ToD8itK9TyHr7ERLB8SHD6g6yVzKYKxwAk8X9weoesdkuc0WtgjlU
         YSEGekgvsIaiO9jYsL5e7SmTLbCB3i1d4ziFPcoEJ5AX7qnXgwJE2UKj6IVxVwK5csKd
         rlu8CsqKqV6cHzCrWj+1IPl8n/+EscENNPjwWuLB70OSt5BIWziuVVEYGhi7TyQ15QKh
         xadVud/Viy8yPbWDQwCKYKU+PdOa5bIQwd7tzG+VQEa6LbcOZBs/WobZEU4j5of75X0X
         VryH84u8Y9Q8qAOsaURYblPFGayYw9c1FK1m/pl+q4ibThBxKNZQhplqTHilswv5PZI9
         FP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710244703; x=1710849503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKp0htl8d23a0PhO993HNxz3WKKW3EQtqTL+zri38Cc=;
        b=YRTugTwtJy0UWJyj3rc1EXnB/5WYhWmJZu6CyagR3sHAF7AnrC4juvofA6yZbHFZJN
         ko33rgDEhgDFZ8rcwNf5pwGvOYFWHDyg5gO9h3T+MUO/nxXjlvgsXju8UNPMSBgYUWX9
         LrBYmllBShp1bzz05QyFNbkm0wpenZrumyb/KcaKj5AMOOFAnzgLK7RZe5SE4cbbTYP6
         BjrFSvahvVrerHyQAI0vfc/aQGo9byba7yriRDy3ujMVLep3YDXVz4OxDhipwDXx29MO
         qSheAefHhXOWr4Ryz0G0t9cXwVfINH6eiPrBueWXtMccZknogUbIPwQP1PLdljme8tac
         4Irw==
X-Forwarded-Encrypted: i=1; AJvYcCU1EXXHR4GiE23n3tjV4xCsXg64TA0bfnJjwTQJ5VpqrKcGm/tTP6zMFnwhiSbJsy813qWHvneSoNKQf9g89xnVuPrfzynHkmscN1pF
X-Gm-Message-State: AOJu0YzP1yxajj04cYb06czAE4LJguW4/g+NRAIDAvF5eOlMfUa/dPG9
	SoSxl1rKy555P6HVpXxcitt9CBd6xQTdhUmDuZx8DxdblmdH9dfgYpk+MlD023E=
X-Google-Smtp-Source: AGHT+IGRGdSOtrKdBrsEcahBbNOfcWICN9EJlV8KOWPmNUkB4o/815uIYmWSXO1kRZ48Pu/hNmspEA==
X-Received: by 2002:a05:600c:19d0:b0:413:128a:403 with SMTP id u16-20020a05600c19d000b00413128a0403mr7677983wmq.1.1710244702698;
        Tue, 12 Mar 2024 04:58:22 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id bv10-20020a0560001f0a00b0033e033898c5sm8932661wrb.20.2024.03.12.04.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 04:58:22 -0700 (PDT)
Message-ID: <f62bbc98-12c1-48e1-8ebc-17dd5887026a@linaro.org>
Date: Tue, 12 Mar 2024 11:58:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] platform: arm64: Add Acer Aspire 1 embedded
 controller driver
Content-Language: en-US
To: Nikita Travkin <nikita@trvn.ru>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru>
 <20240312-aspire1-ec-v4-3-bd8e3eea212f@trvn.ru>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240312-aspire1-ec-v4-3-bd8e3eea212f@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/03/2024 08:42, Nikita Travkin wrote:
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
>   drivers/platform/arm64/Kconfig           |  16 +
>   drivers/platform/arm64/Makefile          |   2 +
>   drivers/platform/arm64/acer-aspire1-ec.c | 555 +++++++++++++++++++++++++++++++

You should be listing yourself as a maintainer for a driver you contribute.

Good work BTW.

>   3 files changed, 573 insertions(+)
> 
> diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
> index 644b83ede093..07d47879a9e3 100644
> --- a/drivers/platform/arm64/Kconfig
> +++ b/drivers/platform/arm64/Kconfig
> @@ -16,4 +16,20 @@ menuconfig ARM64_PLATFORM_DEVICES
>   
>   if ARM64_PLATFORM_DEVICES
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
>   endif # ARM64_PLATFORM_DEVICES
> diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Makefile
> index f91cdc7155e2..4fcc9855579b 100644
> --- a/drivers/platform/arm64/Makefile
> +++ b/drivers/platform/arm64/Makefile
> @@ -4,3 +4,5 @@
>   #
>   # This dir should only include drivers for EC-like devices.
>   #
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

2024

> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/delay.h>

This list should be alphabetised.

> +
> +#include <linux/usb/typec_mux.h>
> +#include <drm/drm_bridge.h>

Zap the newline and sort all of these headers alphabetically please.

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
> +};
> +
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
> +
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

You could stick this "* 1000" stuff in a macro

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
> +		else
> +			val->strval = "Unknown";
> +		break;
> +
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		if (sdat.vendor_id - 3 < ARRAY_SIZE(aspire_ec_bat_psy_battery_vendor))
> +			val->strval = aspire_ec_bat_psy_battery_vendor[sdat.vendor_id - 3];

How does this -3 offset not underflow ?

Seems a bit dodgy to me - can you add a comment to the code to explain ? 
Its not immediately obvious the -3 is OK.

Also could you take an index instead of replicating the -value stepdown 
each time ?

int myindex = sdat.model_id - 1;

if (myindex < someconstraint)
	strval = somearry[myindex];

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
> +
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

Don't you need input_unregister_device() in this case ? suggest a goto 
jump label to clean up down the end of your probe() function.

> +		return dev_err_probe(dev, ret, "Failed to create attribute group\n");
> +
> +	/* External Type-C display attach reports */
> +	fwnode = device_get_named_child_node(dev, "connector");
> +	if (fwnode) {
> +		INIT_WORK(&ec->work, aspire_ec_bridge_update_hpd_work);
> +		ec->bridge.funcs = &aspire_ec_bridge_funcs;
> +		ec->bridge.of_node = to_of_node(fwnode);
> +		ec->bridge.ops = DRM_BRIDGE_OP_HPD;
> +		ec->bridge.type = DRM_MODE_CONNECTOR_USB;
> +
> +		ret = devm_drm_bridge_add(dev, &ec->bridge);
> +		if (ret) {
> +			fwnode_handle_put(fwnode);
> +			return dev_err_probe(dev, ret, "Failed to register drm bridge\n");
> +		}
> +
> +		ec->bridge_configured = true;
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +					aspire_ec_irq_handler, IRQF_ONESHOT,
> +					dev_name(dev), ec);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request irq\n");
> +
> +	return 0;

jump label here for stuff that doens't just clean up

> +}
> +
> +static int aspire_ec_resume(struct device *dev)
> +{
> +	struct aspire_ec *ec = i2c_get_clientdata(to_i2c_client(dev));
> +	u8 tmp;
> +
> +	aspire_ec_ram_read(ec->client, ASPIRE_EC_RAM_LID_STATUS, &tmp, sizeof(tmp));
> +	input_report_switch(ec->idev, SW_LID, !!(tmp & ASPIRE_EC_LID_OPEN));
> +	input_sync(ec->idev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id aspire_ec_id[] = {
> +	{ "aspire1-ec", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, aspire_ec_id);
> +
> +static const struct of_device_id aspire_ec_of_match[] = {
> +	{ .compatible = "acer,aspire1-ec", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, aspire_ec_of_match);
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(aspire_ec_pm_ops, NULL, aspire_ec_resume);
> +
> +static struct i2c_driver aspire_ec_driver = {
> +	.driver = {
> +		.name = "aspire-ec",
> +		.of_match_table = aspire_ec_of_match,
> +		.pm = pm_sleep_ptr(&aspire_ec_pm_ops),
> +	},
> +	.probe = aspire_ec_probe,
> +	.id_table = aspire_ec_id,
> +};
> +module_i2c_driver(aspire_ec_driver);

Don't you need an exit function to clean up stuff that's not devm_ derived ?

input_unregister_device() ?

> +
> +MODULE_DESCRIPTION("Acer Aspire 1 embedded controller");
> +MODULE_AUTHOR("Nikita Travkin <nikita@trvn.ru>");
> +MODULE_LICENSE("GPL");
> 


