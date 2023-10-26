Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6DB7D7A04
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjJZBQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZBQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:16:52 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD99A4;
        Wed, 25 Oct 2023 18:16:49 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7c011e113so2695127b3.1;
        Wed, 25 Oct 2023 18:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698283009; x=1698887809; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A2wsaM0SmHqn5TWEMRqujhoGNabKrWRt2oC99fqSph8=;
        b=LBVnOmw/9W0q5+SHOH4NB+KZ///t+J/LoLOT9RFVuyvLKR7UWZUuPqWgv356bCzcWb
         np8qNUybyLllG3cSVzcjPjHO905Xk873ey+CRC74v49ZcXjg4B0lA7ANJg4uzY836KXF
         w0XKc201skpfbD6bK3lRUcY9wWToUjFB63RsjF8TLif7atPn3SwDsG/c6Q+9+u4BYiYB
         rp3mAHLBX04L2JLGMhU7xgwxObMZIvIAfOmo3LETwteo3l00P0uenFoL+OyckgmQ5PoZ
         IfjeLdOKeaTsipQfdr5zpnNEWSDzXAt1P4BohprXHlaPHVmNMzwOie9nv/B3OgfNufFz
         ZzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698283009; x=1698887809;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2wsaM0SmHqn5TWEMRqujhoGNabKrWRt2oC99fqSph8=;
        b=fwrzA8GlymKixx48RDsk5RdhYPLhhLrGcCA+CYv7abYAIbZU16430il1s+SiHogkqx
         1ab3qcNkAjqpMz216/SjiRlX6PAJzsMGnNlk+QAVgleRRbmrbbCOKQ3xPDC6718dVK+P
         M/UcoNn4Oa66zz8R9TlriLFwz+hAv3XgyyJsdPZD4EAq0l0tFL2LpHNLCIaHNjcNi6ff
         +C25JyNNYIJIFcRy5Im5g+nXgkE4Vd+7ZA769mJdSivlpJmJf4y59KlWML0XAifFMuCY
         aGwxLN/gDqtJjIJVtMrJ0k138VJvZDossMQ0N15hh90cM+kjenYH54CbIGbRjjk+rph+
         H5iw==
X-Gm-Message-State: AOJu0YytLDZfAsh6G2q3v0W8X4+l3G7zYbOh5M5o0ijFjaz3ENzOyxDM
        8PuxzmgDAdjbSqZnRfXcvK0=
X-Google-Smtp-Source: AGHT+IH/OmPEMmzBcNISNouc/U8WTu4QHwO5nOlQY/lDtEaB6R2e8BuAzX4Kwq+UtCwY0OixEsCChQ==
X-Received: by 2002:a0d:d9cb:0:b0:570:2568:15e with SMTP id b194-20020a0dd9cb000000b005702568015emr17960173ywe.43.1698283008782;
        Wed, 25 Oct 2023 18:16:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m124-20020a0de382000000b0059b2be24f88sm5467144ywe.143.2023.10.25.18.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 18:16:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 18:16:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] drivers: hwmon: ltc2991: add driver support
Message-ID: <28f6e98c-de8d-4f1e-b16d-3eb9f9528368@roeck-us.net>
References: <20231012102954.103794-1-antoniu.miclaus@analog.com>
 <20231012102954.103794-2-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231012102954.103794-2-antoniu.miclaus@analog.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 01:29:36PM +0300, Antoniu Miclaus wrote:
> Add support for LTC2991 Octal I2C Voltage, Current, and Temperature
> Monitor.
> 
> The LTC2991 is used to monitor system temperatures, voltages and
> currents. Through the I2C serial interface, the eight monitors can
> individually measure supply voltages and can be paired for
> differential measurements of current sense resistors or temperature
> sensing transistors. Additional measurements include internal
> temperature and internal VCC.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
>  - rework ltc2991_read_reg
>  - remove labels
>  - rework channel exposure according to datasheet part typical apllications
>  - avoid division by 0 by checking property value
>  Documentation/hwmon/index.rst   |   1 +
>  Documentation/hwmon/ltc2991.rst |  43 ++++
>  MAINTAINERS                     |   8 +
>  drivers/hwmon/Kconfig           |  11 +
>  drivers/hwmon/Makefile          |   1 +
>  drivers/hwmon/ltc2991.c         | 437 ++++++++++++++++++++++++++++++++
>  6 files changed, 501 insertions(+)
>  create mode 100644 Documentation/hwmon/ltc2991.rst
>  create mode 100644 drivers/hwmon/ltc2991.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 88dadea85cfc..0ec96abe3f7d 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -121,6 +121,7 @@ Hardware Monitoring Kernel Drivers
>     ltc2947
>     ltc2978
>     ltc2990
> +   ltc2991
>     ltc3815
>     ltc4151
>     ltc4215
> diff --git a/Documentation/hwmon/ltc2991.rst b/Documentation/hwmon/ltc2991.rst
> new file mode 100644
> index 000000000000..9ab29dd85012
> --- /dev/null
> +++ b/Documentation/hwmon/ltc2991.rst
> @@ -0,0 +1,43 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver ltc2991
> +=====================
> +
> +Supported chips:
> +
> +  * Analog Devices LTC2991
> +
> +    Prefix: 'ltc2991'
> +
> +    Addresses scanned: I2C 0x48 - 0x4f
> +
> +    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2991ff.pdf
> +
> +Authors:
> +
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +
> +Description
> +-----------
> +
> +This driver supports hardware monitoring for Analog Devices LTC2991 Octal I2C
> +Voltage, Current and Temperature Monitor.
> +
> +The LTC2991 is used to monitor system temperatures, voltages and currents.
> +Through the I2C serial interface, the eight monitors can individually measure
> +supply voltages and can be paired for differential measurements of current sense
> +resistors or temperature sensing transistors. Additional measurements include
> +internal temperatureand internal VCC.
> +
> +
> +sysfs-Interface
> +-------------
> +
> +The following attributes are supported. Limits are read-only.
> +
> +=============== =================
> +inX_input:      voltage input
> +currX_input:    current input
> +tempX_input:    temperature input
> +=============== =================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c4cce45a09d..edfa49c42848 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12449,6 +12449,14 @@ F:	drivers/hwmon/ltc2947-i2c.c
>  F:	drivers/hwmon/ltc2947-spi.c
>  F:	drivers/hwmon/ltc2947.h
>  
> +LTC2991 HARDWARE MONITOR DRIVER
> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
> +F:	drivers/hwmon/ltc2991.c
> +
>  LTC2983 IIO TEMPERATURE DRIVER
>  M:	Nuno Sá <nuno.sa@analog.com>
>  L:	linux-iio@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index ec38c8892158..818a67328fcd 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -932,6 +932,17 @@ config SENSORS_LTC2990
>  	  This driver can also be built as a module. If so, the module will
>  	  be called ltc2990.
>  
> +config SENSORS_LTC2991
> +	tristate "Analog Devices LTC2991"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Analog Devices LTC2991
> +	  Octal I2C Voltage, Current, and Temperature Monitor. The LTC2991
> +	  supports a combination of voltage, current and temperature monitoring.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called ltc2991.
> +
>  config SENSORS_LTC2992
>  	tristate "Linear Technology LTC2992"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 4ac9452b5430..f324d057535a 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -127,6 +127,7 @@ obj-$(CONFIG_SENSORS_LTC2947)	+= ltc2947-core.o
>  obj-$(CONFIG_SENSORS_LTC2947_I2C) += ltc2947-i2c.o
>  obj-$(CONFIG_SENSORS_LTC2947_SPI) += ltc2947-spi.o
>  obj-$(CONFIG_SENSORS_LTC2990)	+= ltc2990.o
> +obj-$(CONFIG_SENSORS_LTC2991)	+= ltc2991.o
>  obj-$(CONFIG_SENSORS_LTC2992)	+= ltc2992.o
>  obj-$(CONFIG_SENSORS_LTC4151)	+= ltc4151.o
>  obj-$(CONFIG_SENSORS_LTC4215)	+= ltc4215.o
> diff --git a/drivers/hwmon/ltc2991.c b/drivers/hwmon/ltc2991.c
> new file mode 100644
> index 000000000000..4f3d73bc494a
> --- /dev/null
> +++ b/drivers/hwmon/ltc2991.c
> @@ -0,0 +1,437 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Analog Devices, Inc.
> + * Author: Antoniu Miclaus <antoniu.miclaus@analog.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>

I don't see why this include file would be needed.

> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <asm/unaligned.h>

There are no unaligned accesses, so it appears
that this include is not needed either.

> +
> +#define LTC2991_STATUS_LOW		0x00
> +#define LTC2991_CH_EN_TRIGGER		0x01
> +#define LTC2991_V1_V4_CTRL		0x06
> +#define LTC2991_V5_V8_CTRL		0x07
> +#define LTC2991_PWM_TH_LSB_T_INT	0x08
> +#define LTC2991_PWM_TH_MSB		0x09
> +#define LTC2991_CHANNEL_V_MSB(x)	(0x0A + ((x) * 2))
> +#define LTC2991_CHANNEL_T_MSB(x)	(0x0A + ((x) * 4))
> +#define LTC2991_CHANNEL_C_MSB(x)	(0x0C + ((x) * 4))
> +#define LTC2991_T_INT_MSB		0x1A
> +#define LTC2991_VCC_MSB			0x1C
> +
> +#define LTC2991_V7_V8_EN		BIT(7)
> +#define LTC2991_V5_V6_EN		BIT(6)
> +#define LTC2991_V3_V4_EN		BIT(5)
> +#define LTC2991_V1_V2_EN		BIT(4)
> +#define LTC2991_T_INT_VCC_EN		BIT(3)
> +
> +#define LTC2991_V3_V4_FILT_EN		BIT(7)
> +#define LTC2991_V3_V4_TEMP_EN		BIT(5)
> +#define LTC2991_V3_V4_DIFF_EN		BIT(4)
> +#define LTC2991_V1_V2_FILT_EN		BIT(3)
> +#define LTC2991_V1_V2_TEMP_EN		BIT(1)
> +#define LTC2991_V1_V2_DIFF_EN		BIT(0)
> +
> +#define LTC2991_V7_V8_FILT_EN		BIT(7)
> +#define LTC2991_V7_V8_TEMP_EN		BIT(5)
> +#define LTC2991_V7_V8_DIFF_EN		BIT(4)
> +#define LTC2991_V5_V6_FILT_EN		BIT(7)
> +#define LTC2991_V5_V6_TEMP_EN		BIT(5)
> +#define LTC2991_V5_V6_DIFF_EN		BIT(4)
> +
> +#define LTC2991_REPEAT_ACQ_EN		BIT(4)
> +#define LTC2991_T_INT_FILT_EN		BIT(3)
> +
> +#define LTC2991_MAX_CHANNEL		4
> +#define LTC2991_T_INT_CH_NR		4
> +#define LTC2991_VCC_CH_NR		0
> +
> +struct ltc2991_state {
> +	struct i2c_client	*client;

This is only used in the init function, and each time it is used
it is derefernced as &st->client->dev. Just pass dev as parameter
and be done with it.

> +	struct regmap		*regmap;
> +	u32			r_sense_uohm[LTC2991_MAX_CHANNEL];
> +	bool			temp_en[LTC2991_MAX_CHANNEL];
> +};
> +
> +static int ltc2991_read_reg(struct ltc2991_state *st, u8 addr, u8 reg_len,
> +			    int *val)
> +{
> +	__be16 regvals;
> +	int ret;
> +
> +	if (reg_len < 2)
> +		return regmap_read(st->regmap, addr, val);
> +
> +	ret = regmap_bulk_read(st->regmap, addr, &regvals, reg_len);
> +	if (ret)
> +		return ret;
> +
> +	*val = be16_to_cpu(regvals);
> +
> +	return 0;
> +}
> +
> +static int ltc2991_get_voltage(struct ltc2991_state *st, u32 reg, long *val)
> +{
> +	int reg_val, ret, offset = 0;
> +
> +	ret = ltc2991_read_reg(st, reg, 2, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	if (reg == LTC2991_VCC_MSB)
> +		/* Vcc 2.5V offset */
> +		offset = 2500;
> +
> +	/* Vx, 305.18uV/LSB */
> +	*val = DIV_ROUND_CLOSEST(sign_extend32(reg_val, 14) * 30518,
> +				 1000 * 100) + offset;
> +
> +	return 0;
> +}
> +
> +static int ltc2991_read_in(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	struct ltc2991_state *st = dev_get_drvdata(dev);
> +	u32 reg;
> +
> +	switch (attr) {
> +	case hwmon_in_input:
> +		if (channel == LTC2991_VCC_CH_NR)
> +			reg = LTC2991_VCC_MSB;
> +		else
> +			reg = LTC2991_CHANNEL_V_MSB(channel - 1);
> +
> +		return ltc2991_get_voltage(st, reg, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int ltc2991_get_curr(struct ltc2991_state *st, u32 reg, int channel,
> +			    long *val)
> +{
> +	int reg_val, ret;
> +
> +	ret = ltc2991_read_reg(st, reg, 2, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Vx-Vy, 19.075uV/LSB */
> +	*val = DIV_ROUND_CLOSEST(sign_extend32(reg_val, 14) * 19075, 1000)
> +				 / (st->r_sense_uohm[channel] / 1000);

If st->r_sense_uohm[channel] < 1000, the divide operation will
result in a division by zero error. Also, there is a loss of
accuracy because the sense resistor is rounded to mOhm before
being used.

> +
> +	return 0;
> +}
> +
> +static int ltc2991_read_curr(struct device *dev, u32 attr, int channel,
> +			     long *val)
> +{
> +	struct ltc2991_state *st = dev_get_drvdata(dev);
> +	u32 reg;
> +
> +	switch (attr) {
> +	case hwmon_curr_input:
> +		reg = LTC2991_CHANNEL_C_MSB(channel);
> +		return ltc2991_get_curr(st, reg, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int ltc2991_get_temp(struct ltc2991_state *st, u32 reg, int channel,
> +			    long *val)
> +{
> +	int reg_val, ret;
> +
> +	ret = ltc2991_read_reg(st, reg, 2, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Temp LSB = 0.0625 Degrees */
> +	*val = DIV_ROUND_CLOSEST(sign_extend32(reg_val, 12) * 1000, 16);
> +
> +	return 0;
> +}
> +
> +static int ltc2991_read_temp(struct device *dev, u32 attr, int channel,
> +			     long *val)
> +{
> +	struct ltc2991_state *st = dev_get_drvdata(dev);
> +	u32 reg;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		if (channel == LTC2991_T_INT_CH_NR)
> +			reg = LTC2991_T_INT_MSB;
> +		else
> +			reg = LTC2991_CHANNEL_T_MSB(channel);
> +
> +		return ltc2991_get_temp(st, reg, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int ltc2991_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_in:
> +		return ltc2991_read_in(dev, attr, channel, val);
> +	case hwmon_curr:
> +		return ltc2991_read_curr(dev, attr, channel, val);
> +	case hwmon_temp:
> +		return ltc2991_read_temp(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t ltc2991_is_visible(const void *data,
> +				  enum hwmon_sensor_types type, u32 attr,
> +				  int channel)
> +{
> +	const struct ltc2991_state *st = data;
> +
> +	switch (type) {
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			if (channel == LTC2991_VCC_CH_NR)
> +				return 0444;
> +			if (st->temp_en[(channel - 1) / 2])
> +				break;
> +			if (channel % 2)
> +				return 0444;
> +			if (!st->r_sense_uohm[(channel - 1) / 2])
> +				return 0444;
> +		}
> +		break;
> +	case hwmon_curr:
> +		switch (attr) {
> +		case hwmon_curr_input:
> +			if (st->r_sense_uohm[channel])
> +				return 0444;
> +			break;
> +		}
> +		break;
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			if (st->temp_en[channel] ||
> +			    channel == LTC2991_T_INT_CH_NR)
> +				return 0444;
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops ltc2991_hwmon_ops = {
> +	.is_visible = ltc2991_is_visible,
> +	.read = ltc2991_read,
> +};
> +
> +static const struct hwmon_channel_info *ltc2991_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT,
> +			   HWMON_T_INPUT,
> +			   HWMON_T_INPUT,
> +			   HWMON_T_INPUT,
> +			   HWMON_T_INPUT
> +			   ),
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT,
> +			   HWMON_C_INPUT,
> +			   HWMON_C_INPUT,
> +			   HWMON_C_INPUT
> +			   ),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT,
> +			   HWMON_I_INPUT,
> +			   HWMON_I_INPUT,
> +			   HWMON_I_INPUT,
> +			   HWMON_I_INPUT,
> +			   HWMON_I_INPUT,
> +			   HWMON_I_INPUT,
> +			   HWMON_I_INPUT,
> +			   HWMON_I_INPUT
> +			   ),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info ltc2991_chip_info = {
> +	.ops = &ltc2991_hwmon_ops,
> +	.info = ltc2991_info,
> +};
> +
> +static const struct regmap_config ltc2991_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x1D,
> +};
> +
> +static int ltc2991_init(struct ltc2991_state *st)
> +{
> +	struct fwnode_handle *child;
> +	int ret;
> +	u32 val, addr;
> +	u8 v5_v8_reg_data = 0, v1_v4_reg_data = 0;
> +
> +	ret = devm_regulator_get_enable(&st->client->dev, "vcc");
> +	if (ret)
> +		return dev_err_probe(&st->client->dev, ret,
> +				     "failed to enable regulator\n");
> +
> +	device_for_each_child_node(&st->client->dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &addr);
> +		if (ret < 0) {
> +			fwnode_handle_put(child);
> +			return ret;
> +		}
> +
> +		if (addr > 3) {
> +			fwnode_handle_put(child);
> +			return -EINVAL;
> +		}
> +
> +		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms", &val);
> +		if (!ret) {
> +			if (!val)
> +				return dev_err_probe(&st->client->dev, -EINVAL,
> +						     "shunt resistor value cannot be zero\n");
> +
> +			st->r_sense_uohm[addr] = val;
> +
> +			switch (addr) {
> +			case 0:
> +				v1_v4_reg_data |= LTC2991_V1_V2_DIFF_EN;
> +				break;
> +			case 1:
> +				v1_v4_reg_data |= LTC2991_V3_V4_DIFF_EN;
> +				break;
> +			case 2:
> +				v5_v8_reg_data |= LTC2991_V5_V6_DIFF_EN;
> +				break;
> +			case 3:
> +				v5_v8_reg_data |= LTC2991_V7_V8_DIFF_EN;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +
> +		ret = fwnode_property_read_bool(child, "adi,temperature-enable");
> +		if (ret) {
> +			st->temp_en[addr] = ret;
> +
> +			switch (addr) {
> +			case 0:
> +				v1_v4_reg_data |= LTC2991_V1_V2_TEMP_EN;
> +				break;
> +			case 1:
> +				v1_v4_reg_data |= LTC2991_V3_V4_TEMP_EN;
> +				break;
> +			case 2:
> +				v5_v8_reg_data |= LTC2991_V5_V6_TEMP_EN;
> +				break;
> +			case 3:
> +				v5_v8_reg_data |= LTC2991_V7_V8_TEMP_EN;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +	}
> +
> +	ret = regmap_write(st->regmap, LTC2991_V5_V8_CTRL, v5_v8_reg_data);
> +	if (ret)
> +		return dev_err_probe(&st->client->dev, ret,
> +				     "Error: Failed to set V5-V8 CTRL reg.\n");
> +
> +	ret = regmap_write(st->regmap, LTC2991_V1_V4_CTRL, v1_v4_reg_data);
> +	if (ret)
> +		return dev_err_probe(&st->client->dev, ret,
> +				     "Error: Failed to set V1-V4 CTRL reg.\n");
> +
> +	ret = regmap_write(st->regmap, LTC2991_PWM_TH_LSB_T_INT,
> +			   LTC2991_REPEAT_ACQ_EN);
> +	if (ret)
> +		return dev_err_probe(&st->client->dev, ret,
> +				     "Error: Failed to set contiuous mode.\n");
> +
> +	/* Enable all channels and trigger conversions */
> +	return regmap_write(st->regmap, LTC2991_CH_EN_TRIGGER,
> +			    LTC2991_V7_V8_EN | LTC2991_V5_V6_EN |
> +			    LTC2991_V3_V4_EN | LTC2991_V1_V2_EN |
> +			    LTC2991_T_INT_VCC_EN);
> +}
> +
> +static int ltc2991_i2c_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	struct device *hwmon_dev;
> +	struct ltc2991_state *st;
> +
> +	st = devm_kzalloc(&client->dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	st->client = client;
> +	st->regmap = devm_regmap_init_i2c(client, &ltc2991_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	ret = ltc2991_init(st);
> +	if (ret)
> +		return ret;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&client->dev,
> +							 client->name, st,
> +							 &ltc2991_chip_info,
> +							 NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct of_device_id ltc2991_of_match[] = {
> +	{ .compatible = "adi,ltc2991" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ltc2991_of_match);
> +
> +static const struct i2c_device_id ltc2991_i2c_id[] = {
> +	{ "ltc2991", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ltc2991_i2c_id);
> +
> +static struct i2c_driver ltc2991_i2c_driver = {
> +	.driver = {
> +		.name = "ltc2991",
> +		.of_match_table = ltc2991_of_match,
> +	},
> +	.probe = ltc2991_i2c_probe,
> +	.id_table = ltc2991_i2c_id,
> +};
> +
> +module_i2c_driver(ltc2991_i2c_driver);
> +
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices LTC2991 HWMON Driver");
> +MODULE_LICENSE("GPL");
