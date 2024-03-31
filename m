Return-Path: <linux-kernel+bounces-126384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CAF89365F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 01:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8E41F21CFA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 23:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AC21448E9;
	Sun, 31 Mar 2024 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXFokrFw"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A2148837
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 23:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711926696; cv=none; b=PUujRkBhLNGLaBsz2E7lRkTeI6Hw6n3kTD/4uYNYguFnIJfXJInfUnr0ObHanLQ8PUAtVA+upXsORPuTLM9zatnz7DNqcv0gWO3vMN6MOBlDlNWALLgaHUExnI/EkAb9VIZr3Vd6v60ufbRV24JYq4zv+OCA3jJnw7Hl6m/PVWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711926696; c=relaxed/simple;
	bh=iqS3MD8bbT3sDMiqOFM+Kcq4oJpkZNq+twM+/+Cezeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l21vOkGm3xFu3G70XK3GshZhLX/rEgnO4txa9UJpQiuj9d3hfpt8XTrmUCBDvwG8GsL1po9zt2EOton/xM5txNDUwZZaniyyoQWkOKGMTKKswBjs2Js/7g9DCi6NentTFBmp8TS0fRTKc6ThHScUutMaipyjmGf97VWhkfScPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXFokrFw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513da1c1f26so4195526e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711926691; x=1712531491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J764wdctUJlREHafL2LSknxkGZv8MQ0MIDf0ICMhx6s=;
        b=fXFokrFwLS25pM7vv/U3aOwdOxaN9zpdZHGyLatM6uzrP9jzNSWcn2uAR7EJ3HXe6R
         kzplNZNyOJMwNNZ+jk+qAEMhyRyajIQoa8NNYNyRNsWtIV5YUTykfVSOZ2bFWm/w1Le4
         9NPP94DVDQJcLzddohXfBMqWUA7VzXb5qtcsjdin0WfWobifTiy+vO2sH27ZK+YwAxdv
         g7f+NjiKdXC4Lv7jzRYqwfLIQi03QQeWV6OkMHxHEv/ZuYklvucCe6v389rWFILGxkZ6
         ATo8o2ErVSGX7EgR/1GmA0joAM1hFVnTb+JeVyzfaxnqZNrMrsN++6VyDDQZsPs7Qrtp
         SvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711926691; x=1712531491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J764wdctUJlREHafL2LSknxkGZv8MQ0MIDf0ICMhx6s=;
        b=u1oOtu7T4SsELCvW7W8LHGJJg041wO+5TQK1trB47PqQfeGHLbUWVNR4o6CaheI43P
         GgPJ+PUzvdTB/JTe8xyFGVVGEVsND1Ft39XjMk2+gEVubfd4eWq77sDHcLFoPWidqCHM
         StD+KnCGfRfhOQ/LCUgwEnRg2xRqWDyUJfs9cw9uVN3k7OigVzfB9ohWvnnQZLQ7MkhP
         lL2pz3PRf4crx2h8VKZ8emEkMZCdG0XZNqS2YRP3OJ97wzaOm4q609+NCeckCCW86FWx
         yigd3e8LlFiUVBo/x/ryH+7UY0hBWOrRLxBrAaCx+uzRchmmOS9PN6WADqYGlO/Ytv3g
         Ig3A==
X-Forwarded-Encrypted: i=1; AJvYcCXawtnYtAFUdDinzNl0SrGMbnGsV5GuMVph1lNmwt20pMnN518XRqMDT0KRH7PYH8aUlsEv/CEhy+Mt5Z1i+1sXEz6IcjF7/FM/d7uA
X-Gm-Message-State: AOJu0YwHy1+r6b0BPL033uI/tkJdeo9b/Ep8a3/gGWqSVNCkQX520acV
	RkaYIVj+hZz/asosUp76fagn2MRNdLY+AgcaUgQgb4YjehqSFvIg8Q1s4vC0ADdWLqVmLX7QmtK
	EU64=
X-Google-Smtp-Source: AGHT+IHjeEORtmrP/IjYZW53JTZxtP1wNxH2ASMBCEDwCkZnwounb/T8YBEh3ouLz6lTMCXVImaFAA==
X-Received: by 2002:a19:9117:0:b0:513:d49a:7a0d with SMTP id t23-20020a199117000000b00513d49a7a0dmr4803968lfd.42.1711926691180;
        Sun, 31 Mar 2024 16:11:31 -0700 (PDT)
Received: from [192.168.1.23] (67-60-142-46.pool.kielnet.net. [46.142.60.67])
        by smtp.gmail.com with ESMTPSA id dn21-20020a17090794d500b00a4588098c5esm4592371ejc.132.2024.03.31.16.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 16:11:30 -0700 (PDT)
Message-ID: <56b6b6e9-2830-40f0-b32e-c4a7cb5a7f0b@linaro.org>
Date: Mon, 1 Apr 2024 01:11:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] input/touchscreen: synaptics_tcm_oncell: add driver
To: Frieder Hannenheim <friederhannenheim@riseup.net>,
 dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240327214643.7055-1-friederhannenheim@riseup.net>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240327214643.7055-1-friederhannenheim@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thanks for working on this! I've been doing panel bringup for the 8T, 
it'll be great to get everything working.

I gave this a spin and hit a null pointer in the irq handler during 
probe about 50% of the time, so I think there's some kind of race 
condition going on here.

Please run checkpatch (and maybe some other linter like clang-format?).

I'd recommend giving this a read 
https://wiki.postmarketos.org/wiki/Submitting_Patches

In general, the way this driver was written by OnePlus is pretty 
unmaintainable imo. It does a poor job at modelling the hardware and 
seems to be pretty fragile and hard to follow.


On 27/03/2024 22:39, Frieder Hannenheim wrote:
> This is a bit of a stripped down and partially reworked driver for the
> synaptics_tcm_oncell touchscreen. I based my work off the driver in the
> LineageOS kernel found at
> https://github.com/LineageOS/android_kernel_oneplus_sm8250 branch
> lineage-20. The code was originally written by OnePlus developers but
> I'm not sure how to credit them correctly.
> 
> Currently the driver is in a pretty good shape, the only thing that is
> not working is setting a report config. To me it looks like some data is
> sent by the touchscreen firmware after setting the report config that is
> making the irq handler crash. Sadly I haven't been able to test out why.
> The driver works fine also with the default touch report config so maybe
> we can just use that and not set our own.
> 
> Signed-off-by: Frieder Hannenheim <friederhannenheim@riseup.net>
> ---
>   .../input/touchscreen/syna,s3908.yaml         |   63 +
>   drivers/input/touchscreen/Kconfig             |   11 +
>   drivers/input/touchscreen/Makefile            |    1 +
>   .../input/touchscreen/synaptics_tcm_oncell.c  | 1104 +++++++++++++++++
>   4 files changed, 1179 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/input/touchscreen/syna,s3908.yaml
>   create mode 100644 drivers/input/touchscreen/synaptics_tcm_oncell.c
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/syna,s3908.yaml b/Documentation/devicetree/bindings/input/touchscreen/syna,s3908.yaml
> new file mode 100644
> index 000000000000..1a85747e2f52
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/syna,s3908.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/synaptics,s3908.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synaptics s3908 touchscreen controller
> +
> +maintainers:
> +  - Frieder Hannenheim <frieder.hannenheim@riseup.net>
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: syna,s3908
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: reset gpio the chip is connected to.
> +
> +  vdd-supply: true
> +  vcc-supply: true
> +
> +  max-objects: true
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +  - vdd-supply
> +  - vcc-supply
> +  - max-objects
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        touchscreen@48 {
> +            compatible = "syna,s3908";
> +            reg = <0x48>;
> +            interrupt-parent = <&gpa1>;
> +            interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
> +            reset-gpios = <38 0>;
> +            vdd-supply = <&ldo30_reg>;
> +            vcc-supply = <&ldo31_reg>;
> +
> +            max-objects = <10>;
> +        };
> +    };
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 1f8b33c2b03d..eba31ae27391 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -502,6 +502,17 @@ config TOUCHSCREEN_S6SY761
>   
>   	  To compile this driver as module, choose M here: the
>   	  module will be called s6sy761.
> +	
> +config TOUCHSCREEN_SYNA_TCM_ONCELL
> +	tristate "Synaptics TCM Oncell Touchscreen driver"
> +	depends on I2C
> +	help
> +	  Say Y if you have the Synaptics TCM Oncell driver
> +
> +	  If unsure, say N
> +
> +	  To compile this driver as module, choose M here: the
> +	  module will be called synaptics_tcm_oncell.
>   
>   config TOUCHSCREEN_GUNZE
>   	tristate "Gunze AHL-51S touchscreen"
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 7d52592f4290..f5395ccf09d5 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -86,6 +86,7 @@ obj-$(CONFIG_TOUCHSCREEN_STMPE)		+= stmpe-ts.o
>   obj-$(CONFIG_TOUCHSCREEN_SUN4I)		+= sun4i-ts.o
>   obj-$(CONFIG_TOUCHSCREEN_SUR40)		+= sur40.o
>   obj-$(CONFIG_TOUCHSCREEN_SURFACE3_SPI)	+= surface3_spi.o
> +obj-$(CONFIG_TOUCHSCREEN_SYNA_TCM_ONCELL)	+= synaptics_tcm_oncell.o
>   obj-$(CONFIG_TOUCHSCREEN_TI_AM335X_TSC)	+= ti_am335x_tsc.o
>   obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
>   obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
> diff --git a/drivers/input/touchscreen/synaptics_tcm_oncell.c b/drivers/input/touchscreen/synaptics_tcm_oncell.c
> new file mode 100644
> index 000000000000..b874287f37af
> --- /dev/null
> +++ b/drivers/input/touchscreen/synaptics_tcm_oncell.c
> @@ -0,0 +1,1104 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Driver for Synaptics TCM Oncell Touchscreens
> + *
> + *  Copyright (c) 2024 Frieder Hannenheim <friederhannenheim@riseup.net>

You should keep the previous "oplus" copyright and just add yours below it.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <asm/unaligned.h>
> +#include <linux/delay.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/of_gpio.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +
> +/* Meta Information */

you can remove all the comments like ("meta comments?")
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Frieder Hannenheim");
> +MODULE_DESCRIPTION("A driver for Synaptics TCM Oncell Touchpanels");
> +
> +#define TOUCHPANEL_DEVICE "syna-tcm"
> +
> +#define POWERUP_TO_RESET_TIME 10
> +#define RESET_TO_NORMAL_TIME 80
> +
> +#define RESPONSE_TIMEOUT_MS 1000
> +
> +#define MESSAGE_HEADER_SIZE 4
> +#define MESSAGE_MARKER 0xA5
> +#define MESSAGE_PADDING 0x5A
> +
> +#define READ_LENGTH 9
> +#define MAX_I2C_RETRY_TIME 4
> +
> +#define RD_CHUNK_SIZE 0 /* read length limit in bytes, 0 = unlimited */
> +#define WR_CHUNK_SIZE 0 /* write length limit in bytes, 0 = unlimited */
> +
> +#define APP_STATUS_POLL_MS 100
> +#define TOUCH_REPORT_CONFIG_SIZE 128
> +
> +enum command {
> +	CMD_NONE = 0x00,
> +	CMD_CONTINUE_WRITE = 0x01,
> +	CMD_IDENTIFY = 0x02,
> +	CMD_RESET = 0x04,
> +	CMD_ENABLE_REPORT = 0x05,
> +	CMD_DISABLE_REPORT = 0x06,
> +	CMD_GET_BOOT_INFO = 0x10,
> +	CMD_ERASE_FLASH = 0x11,
> +	CMD_WRITE_FLASH = 0x12,
> +	CMD_READ_FLASH = 0x13,
> +	CMD_RUN_APPLICATION_FIRMWARE = 0x14,
> +	CMD_SPI_MASTER_WRITE_THEN_READ = 0x15,
> +	CMD_REBOOT_TO_ROM_BOOTLOADER = 0x16,
> +	CMD_RUN_BOOTLOADER_FIRMWARE = 0x1f,
> +	CMD_GET_APPLICATION_INFO = 0x20,
> +	CMD_GET_STATIC_CONFIG = 0x21,
> +	CMD_SET_STATIC_CONFIG = 0x22,
> +	CMD_GET_DYNAMIC_CONFIG = 0x23,
> +	CMD_SET_DYNAMIC_CONFIG = 0x24,
> +	CMD_GET_TOUCH_REPORT_CONFIG = 0x25,
> +	CMD_SET_TOUCH_REPORT_CONFIG = 0x26,
> +	CMD_REZERO = 0x27,
> +	CMD_COMMIT_CONFIG = 0x28,
> +	CMD_DESCRIBE_DYNAMIC_CONFIG = 0x29,
> +	CMD_PRODUCTION_TEST = 0x2a,
> +	CMD_SET_CONFIG_ID = 0x2b,
> +	CMD_ENTER_DEEP_SLEEP = 0x2c,
> +	CMD_EXIT_DEEP_SLEEP = 0x2d,
> +	CMD_GET_TOUCH_INFO = 0x2e,
> +	CMD_GET_DATA_LOCATION = 0x2f,
> +	CMD_DOWNLOAD_CONFIG = 0xc0,
> +	CMD_GET_NSM_INFO = 0xc3,
> +	CMD_EXIT_ESD = 0xc4,
> +};
> +
> +enum touch_report_code {
> +	TOUCH_END = 0,
> +	TOUCH_FOREACH_ACTIVE_OBJECT = 1,
> +	TOUCH_FOREACH_OBJECT = 2,
> +	TOUCH_FOREACH_END = 3,
> +	TOUCH_PAD_TO_NEXT_BYTE = 4,
> +	TOUCH_TIMESTAMP = 5,
> +	TOUCH_OBJECT_N_INDEX = 6,
> +	TOUCH_OBJECT_N_CLASSIFICATION = 7,
> +	TOUCH_OBJECT_N_X_POSITION = 8,
> +	TOUCH_OBJECT_N_Y_POSITION = 9,
> +	TOUCH_OBJECT_N_Z = 10,
> +	TOUCH_OBJECT_N_X_WIDTH = 11,
> +	TOUCH_OBJECT_N_Y_WIDTH = 12,
> +	TOUCH_OBJECT_N_TX_POSITION_TIXELS = 13,
> +	TOUCH_OBJECT_N_RX_POSITION_TIXELS = 14,
> +	TOUCH_0D_BUTTONS_STATE = 15,
> +	TOUCH_GESTURE_DOUBLE_TAP = 16,
> +	TOUCH_FRAME_RATE = 17,
> +	TOUCH_POWER_IM = 18,
> +	TOUCH_CID_IM = 19,
> +	TOUCH_RAIL_IM = 20,
> +	TOUCH_CID_VARIANCE_IM = 21,
> +	TOUCH_NSM_FREQUENCY = 22,
> +	TOUCH_NSM_STATE = 23,
> +	TOUCH_NUM_OF_ACTIVE_OBJECTS = 23,
> +	TOUCH_NUM_OF_CPU_CYCLES_USED_SINCE_LAST_FRAME = 24,
> +	TOUCH_TUNING_GAUSSIAN_WIDTHS = 0x80,
> +	TOUCH_TUNING_SMALL_OBJECT_PARAMS = 0x81,
> +	TOUCH_TUNING_0D_BUTTONS_VARIANCE = 0x82,
> +	TOUCH_REPORT_GESTURE_SWIPE = 193,
> +	TOUCH_REPORT_GESTURE_CIRCLE = 194,
> +	TOUCH_REPORT_GESTURE_UNICODE = 195,
> +	TOUCH_REPORT_GESTURE_VEE = 196,
> +	TOUCH_REPORT_GESTURE_TRIANGLE = 197,
> +	TOUCH_REPORT_GESTURE_INFO = 198,
> +	TOUCH_REPORT_GESTURE_COORDINATE = 199,
> +	TOUCH_REPORT_CUSTOMER_GRIP_INFO = 203,
> +};
> +
> +enum touch_status {
> +	LIFT = 0,
> +	FINGER = 1,
> +	GLOVED_FINGER = 2,
> +	NOP = -1,
> +};
> +
> +enum status_code {
> +	STATUS_IDLE = 0x00,
> +	STATUS_OK = 0x01,
> +	STATUS_BUSY = 0x02,
> +	STATUS_CONTINUED_READ = 0x03,
> +	STATUS_RECEIVE_BUFFER_OVERFLOW = 0x0c,
> +	STATUS_PREVIOUS_COMMAND_PENDING = 0x0d,
> +	STATUS_NOT_IMPLEMENTED = 0x0e,
> +	STATUS_ERROR = 0x0f,
> +	STATUS_INVALID = 0xff,
> +};
> +
> +enum report_type {
> +	REPORT_IDENTIFY = 0x10,
> +	REPORT_TOUCH = 0x11,
> +	REPORT_DELTA = 0x12,
> +	REPORT_RAW = 0x13,
> +	REPORT_DEBUG = 0x14,
> +	REPORT_LOG = 0x1d,
> +	REPORT_TOUCH_HOLD = 0x20,
> +};
> +
> +enum syna_tcm_oncell_regulators {
> +	SYNA_TCM_ONCELL_REGULATOR_VDD,
> +	SYNA_TCM_ONCELL_REGULATOR_VCC,
> +};
> +
> +enum boot_mode {
> +	MODE_APPLICATION = 0x01,
> +	MODE_HOST_DOWNLOAD = 0x02,
> +	MODE_BOOTLOADER = 0x0b,
> +	MODE_TDDI_BOOTLOADER = 0x0c,
> +};
> +
> +enum app_status {
> +	APP_STATUS_OK = 0x00,
> +	APP_STATUS_BOOTING = 0x01,
> +	APP_STATUS_UPDATING = 0x02,
> +	APP_STATUS_BAD_APP_CONFIG = 0xff,
> +};
> +
> +struct syna_tcm_app_info {
> +	unsigned char version[2];
> +	unsigned char status[2];
> +	unsigned char static_config_size[2];
> +	unsigned char dynamic_config_size[2];
> +	unsigned char app_config_start_write_block[2];
> +	unsigned char app_config_size[2];
> +	unsigned char max_touch_report_config_size[2];
> +	unsigned char max_touch_report_payload_size[2];
> +	unsigned char customer_config_id[16];
> +	unsigned char max_x[2];
> +	unsigned char max_y[2];
> +	unsigned char max_objects[2];
> +	unsigned char num_of_buttons[2];
> +	unsigned char num_of_image_rows[2];
> +	unsigned char num_of_image_cols[2];
> +	unsigned char has_hybrid_data[2];
> +};
> +
> +struct syna_tcm_identification {
> +	unsigned char version;
> +	unsigned char mode;
> +	unsigned char part_number[16];
> +	unsigned char build_id[4];
> +	unsigned char max_write_size[2];
> +};
> +
> +struct syna_tcm_message_header {
> +	unsigned char marker;
> +	unsigned char code;
> +	unsigned char length[2];
> +};
> +
> +struct touch_data {
> +	unsigned char status;
> +	unsigned int x_pos;
> +	unsigned int y_pos;
> +	unsigned int x_width;
> +	unsigned int y_width;
> +	unsigned int z;
> +};
> +
> +struct syna_tcm_data {
> +	struct i2c_client *client;
> +	struct regulator_bulk_data regulators[2];
> +	struct input_dev *input;
> +	struct gpio_desc *reset_gpio;
> +	struct touchscreen_properties prop;
> +	struct syna_tcm_identification id_info;
> +	struct syna_tcm_app_info app_info;
> +
> +	unsigned char *response_buf;
> +	unsigned int response_length; // Response length including header
> +
> +	unsigned int app_status;
> +
> +	unsigned char *report_config;
> +	unsigned int report_size;
> +
> +	bool initialize_done;

This value is never read.
> +
> +	unsigned int touchpanel_max_objects;
> +};
> +
> +DECLARE_COMPLETION(response_complete);
> +
> +static inline unsigned int le2_to_uint(const unsigned char *src)
> +{
> +	return (unsigned int)src[0] + (unsigned int)src[1] * 0x100;

Shouldn't this just be a cast?
> +}
> +
> +static inline unsigned int ceil_div(unsigned int dividend, unsigned int divisor)
> +{
> +	return (dividend + divisor - 1) / divisor;
> +}
> +
> +static int touch_i2c_continue_read(struct i2c_client *client,
> +				   unsigned char *data, unsigned short length)
> +{
> +	int retval;
> +	unsigned char retry;
> +	struct i2c_msg msg;
> +
> +	msg.addr = client->addr;
> +	msg.flags = I2C_M_RD;
> +	msg.len = length;
> +	msg.buf = data;
> +
> +	for (retry = 0; retry < MAX_I2C_RETRY_TIME; retry++) {
> +		if (i2c_transfer(client->adapter, &msg, 1) == 1) {
> +			retval = length;
> +			break;
> +		}
> +		msleep(20);
> +	}
> +	if (retry == MAX_I2C_RETRY_TIME) {
> +		pr_warn("%s: I2C read over retry limit\n", __func__);
> +		retval = -EIO;
> +	}
> +	return retval;
> +}
> +
> +static int touch_i2c_continue_write(struct i2c_client *client,
> +				    unsigned char *data, unsigned short length)
> +{
> +	int retval;
> +	unsigned char retry;
> +	struct i2c_msg msg;
> +
> +	msg.addr = client->addr;
> +	msg.flags = 0;
> +	msg.buf = data;
> +	msg.len = length;
> +
> +	for (retry = 0; retry < MAX_I2C_RETRY_TIME; retry++) {
> +		if (i2c_transfer(client->adapter, &msg, 1) == 1) {
> +			retval = length;
> +			break;
> +		}
> +		msleep(20);
> +	}
> +	if (retry == MAX_I2C_RETRY_TIME) {
> +		pr_warn("%s: I2C write over retry limit\n", __func__);
> +		retval = -EIO;
> +	}
> +	return retval;
> +}
> +
> +static int syna_tcm_continued_read(struct syna_tcm_data *tcm_info,

continue_write and continueD_read, please make these consistent.
> +				   unsigned int payload_length,
> +				   unsigned char *message_buffer)
> +{
> +	int retval = 0;
> +	unsigned char marker = 0, code = 0;
> +	unsigned int total_length = 0, remaining_length = 0;
> +	unsigned char *temp_buffer;
> +
> +	total_length = MESSAGE_HEADER_SIZE + payload_length + 1;
> +	remaining_length = total_length - READ_LENGTH;
> +
> +	temp_buffer = kmalloc(remaining_length + 2, GFP_KERNEL);
> +	if (!temp_buffer)
> +		return -ENOMEM;
> +
> +	retval = touch_i2c_continue_read(tcm_info->client, temp_buffer,
> +					 remaining_length + 2);
> +	if (retval < 0) {
> +		pr_warn("touch_i2c_continue_read failed");
dev_err??
> +		return retval;
> +	}
> +
> +	marker = temp_buffer[0];
> +	code = temp_buffer[1];
> +
> +	if (marker != MESSAGE_MARKER) {
> +		pr_warn("incorrect header marker (0x%02x)\n", marker);
> +		return -EIO;
> +	}
> +
> +	if (code != STATUS_CONTINUED_READ) {
> +		pr_warn("incorrect header code (0x%02x)\n", code);
> +		return -EIO;
> +	}
> +
> +	memcpy(&message_buffer[READ_LENGTH], &temp_buffer[2], remaining_length);
> +	message_buffer[total_length - 1] = MESSAGE_PADDING;
> +	kfree(temp_buffer);
> +
> +	return 0;
> +}
> +
> +/**
> + * syna_tcm_raw_write() - write command/data to device without receiving
> + * response
> + *
> + * @tcm_info: handle of core module
> + * @command: command to send to device
> + * @data: data to send to device
> + * @length: length of data in bytes
> + * @add_length: wether the length of the message should be added after the command
> + *
> + * A command and its data, if any, are sent to the device.
> + */
> +static int syna_tcm_raw_write(struct syna_tcm_data *tcm_info,
> +			      unsigned char command, unsigned char *data,
> +			      unsigned int length, bool add_length)
> +{
> +	int retval = 0;
> +	unsigned char *out_buf;
> +
> +	unsigned int header_size = add_length && length ? 3 : 1;
> +
> +	out_buf = kmalloc(length + header_size, GFP_KERNEL);
> +	if (retval < 0)
> +		return retval;
> +
> +	out_buf[0] = command;
> +	if (add_length && length) {
> +		out_buf[1] = (unsigned char)length;
> +		out_buf[2] = (unsigned char)(length >> 8);
> +	}
> +
> +	if (length)
> +		memcpy(&out_buf[header_size], data, length);
> +
> +	retval = touch_i2c_continue_write(tcm_info->client, out_buf,
> +					  length + header_size);
> +	if (retval < 0) {
> +		kfree(out_buf);
> +		return retval;
> +	}
> +
> +	kfree(out_buf);
> +	return 0;
> +}
> +
> +/**
> + * syna_tcm_read_message() - read message from device
> + *
> + * @tcm_info: handle of core module
> + * @length: length of data in bytes in raw read mode
> + */
> +static int syna_tcm_read_message(struct syna_tcm_data *tcm_info,
> +				 unsigned int length)
> +{
> +	int retval = 0;
> +	unsigned int total_length = 0, payload_length = 0;
> +	unsigned char *message_buffer;
> +	struct syna_tcm_message_header *header = NULL;
> +
> +	message_buffer = kmalloc(READ_LENGTH, GFP_KERNEL);
> +	if (!message_buffer)
> +		return -ENOMEM;
> +
> +	retval = touch_i2c_continue_read(tcm_info->client, message_buffer,
> +					 READ_LENGTH);
> +	if (retval < 0)
> +		return retval;
> +
> +	header = (struct syna_tcm_message_header *)message_buffer;
> +	if (header->marker != MESSAGE_MARKER) {
> +		pr_warn("wrong header marker:0x%02x\n", header->marker);
> +		return -ENXIO;
> +	}
> +
> +	unsigned char report_code = header->code;
> +
> +	payload_length = le2_to_uint(header->length);
> +
> +	if (report_code <= STATUS_ERROR || report_code == STATUS_INVALID) {
> +		switch (report_code) {
> +		case STATUS_OK:
> +			break;
> +		case STATUS_CONTINUED_READ:
> +		case STATUS_IDLE:
> +		case STATUS_BUSY:
> +			payload_length = 0;
> +			kfree(message_buffer);
> +			return 0;
> +		default:
> +			if (report_code != STATUS_ERROR) {
> +				pr_warn("IO ERROR");
> +				kfree(message_buffer);
> +				return -EIO;
> +			}
> +		}
> +	}
> +
> +	total_length = MESSAGE_HEADER_SIZE + payload_length + 1;
> +
> +	unsigned char *temp_buffer = message_buffer;
> +
> +	message_buffer = kmalloc(total_length, GFP_KERNEL);
> +	if (!message_buffer)
> +		return -ENOMEM;
> +
> +	// Copy data already read to message_buffer
> +	memcpy(message_buffer, temp_buffer, READ_LENGTH);
> +	kfree(temp_buffer);
> +
> +	if (payload_length == 0) {
> +		message_buffer[total_length - 1] = MESSAGE_PADDING;
> +		goto check_padding;
> +	}
> +
> +	if (MESSAGE_HEADER_SIZE + payload_length > READ_LENGTH) {
> +		retval = syna_tcm_continued_read(tcm_info, payload_length,
> +						 message_buffer);
> +		if (retval < 0) {
> +			pr_warn("failed to do continued read\n");
> +			return retval;
> +		};
> +	}
> +
> +check_padding:
> +	if (message_buffer[total_length - 1] != MESSAGE_PADDING) {
> +		pr_warn("missing message padding");
> +		return -EIO;
> +	}
> +
> +	if (tcm_info->response_buf != NULL)
> +		kfree(tcm_info->response_buf);
> +
> +	tcm_info->response_buf = message_buffer;
> +	tcm_info->response_length = total_length;
> +
> +	return 0;
> +}
> +
> +static int syna_tcm_write_message(struct syna_tcm_data *tcm_info,
> +				  unsigned char command, unsigned char *payload,
> +				  unsigned int length, unsigned char **resp_buf,
> +				  unsigned int *resp_length)
> +{
> +	int retval = 0;
> +
> +	if (resp_buf == NULL) {
> +		retval = syna_tcm_raw_write(tcm_info, command, payload, length,
> +					    false);
> +		goto exit;
> +	}
> +	reinit_completion(&response_complete);
> +
> +	tcm_info->response_buf = *resp_buf;
> +	tcm_info->response_length = *resp_length;
> +
> +	// Here write command to device

Please follow kernel comment style (/* ... */)
> +	retval = syna_tcm_raw_write(tcm_info, command, payload, length, true);
> +	if (retval != 0)
> +		goto exit;
> +
> +	retval = wait_for_completion_timeout(&response_complete,
> +					     RESPONSE_TIMEOUT_MS);
> +	if (retval == 0) {
> +		pr_warn("timed out waiting for response (command 0x%02x)\n",
> +			command);
> +		retval = -EIO;
> +	}
> +
> +exit:
> +	if (tcm_info->response_length < 0)
> +		return -1;
> +	if (resp_buf != NULL) {
> +		*resp_buf = tcm_info->response_buf;
> +		*resp_length = tcm_info->response_length;
> +	}
> +
> +	return retval;
> +}
> +
> +static int syna_tcm_set_normal_report_config(struct syna_tcm_data *tcm_info)

This prints a warning on every compile because it's unused. Add the 
__maybe_unused attribute and a comment explaining what it does and why 
it's not used if it's really useful to have it here, or just remove it 
from this version of the driver.
> +{
> +	int retval;
> +	unsigned int idx = 0;
> +	unsigned int length;
> +
> +	length = le2_to_uint(tcm_info->app_info.max_touch_report_config_size);
> +
> +	if (length < TOUCH_REPORT_CONFIG_SIZE) {
> +		pr_warn("invalid maximum touch report config size: %d\n",
> +			length);
> +		return -EINVAL;
> +	}
> +
> +	unsigned char *report_buf = kmalloc(length, GFP_KERNEL);
> +
> +	if (!report_buf)
> +		return -ENOMEM;
> +
> +	report_buf[idx++] = TOUCH_FOREACH_ACTIVE_OBJECT;
> +	report_buf[idx++] = TOUCH_OBJECT_N_INDEX;
> +	report_buf[idx++] = 4;
> +	report_buf[idx++] = TOUCH_OBJECT_N_CLASSIFICATION;
> +	report_buf[idx++] = 4;
> +	report_buf[idx++] = TOUCH_OBJECT_N_X_POSITION;
> +	report_buf[idx++] = 16;
> +	report_buf[idx++] = TOUCH_OBJECT_N_Y_POSITION;
> +	report_buf[idx++] = 16;
> +	report_buf[idx++] = TOUCH_OBJECT_N_X_WIDTH;
> +	report_buf[idx++] = 12;
> +	report_buf[idx++] = TOUCH_OBJECT_N_Y_WIDTH;
> +	report_buf[idx++] = 12;
> +	report_buf[idx++] = TOUCH_FOREACH_END;
> +	report_buf[idx++] = TOUCH_END;
> +
> +	unsigned char *resp_buf = NULL;
> +	unsigned int resp_length = 0;
> +
> +	retval = syna_tcm_write_message(tcm_info, CMD_SET_TOUCH_REPORT_CONFIG,
> +					report_buf, length, &resp_buf,
> +					&resp_length);
> +	if (retval < 0) {
> +		pr_warn("failed to set report config");
> +		return retval;
> +	}
> +
> +	kfree(resp_buf);
> +
> +	return retval;
> +}
> +
> +static int syna_tcm_get_report_config(struct syna_tcm_data *tcm_info)
> +{
> +	int retval;
> +	unsigned char *resp_buf = NULL;
> +	unsigned int resp_length = 0;
> +
> +	retval = syna_tcm_write_message(tcm_info, CMD_GET_TOUCH_REPORT_CONFIG,
> +					NULL, 0, &resp_buf, &resp_length);
> +	if (retval < 0) {
> +		pr_warn("failed to write command 0x%02x\n",
> +			CMD_GET_TOUCH_REPORT_CONFIG);
> +		return retval;
> +	}
> +
> +	tcm_info->report_size = resp_length - MESSAGE_HEADER_SIZE - 1;
> +
> +	kfree(tcm_info->report_config);
> +	tcm_info->report_config = kmalloc(tcm_info->report_size, GFP_KERNEL);
> +
> +	memcpy(tcm_info->report_config, &resp_buf[MESSAGE_HEADER_SIZE],
> +	       tcm_info->report_size);
> +
> +	return 0;
> +}
> +
> +static int syna_tcm_get_app_info(struct syna_tcm_data *tcm_info)
> +{
> +	int retval = 0;
> +	unsigned char *resp_buf = NULL;
> +	unsigned int resp_length = 0;
> +	unsigned int timeout = RESPONSE_TIMEOUT_MS;
> +
> +get_app_info:
> +	retval = syna_tcm_write_message(tcm_info, CMD_GET_APPLICATION_INFO,
> +					NULL, 0, &resp_buf, &resp_length);
> +	if (retval < 0) {
> +		pr_warn("failed to write command 0x%02x\n",
> +			CMD_GET_APPLICATION_INFO);
> +		goto exit;
> +	}
> +
> +	memcpy(&tcm_info->app_info, &resp_buf[MESSAGE_HEADER_SIZE],
> +	       sizeof(tcm_info->app_info));
> +
> +	tcm_info->app_status = le2_to_uint(tcm_info->app_info.status);
> +
> +	if (tcm_info->app_status == APP_STATUS_BOOTING ||
> +	    tcm_info->app_status == APP_STATUS_UPDATING) {
> +		if (timeout > 0) {
> +			msleep(APP_STATUS_POLL_MS);
> +			timeout -= APP_STATUS_POLL_MS;
> +			goto get_app_info;
> +		}
> +	}
> +
> +	retval = 0;
> +
> +exit:
> +	kfree(resp_buf);
> +
> +	return retval;
> +}
> +
> +static int syna_tcm_identify(struct syna_tcm_data *tcm_info)
> +{
> +	int retval = 0;
> +	unsigned char *resp_buf = NULL;
> +	unsigned int resp_length = 0;
> +
> +	retval = syna_tcm_write_message(tcm_info, CMD_IDENTIFY, NULL, 0,
> +					&resp_buf, &resp_length);
> +	if (retval < 0)
> +		goto exit;
> +
> +	memcpy(&tcm_info->id_info, &resp_buf[MESSAGE_HEADER_SIZE],
> +	       sizeof(tcm_info->id_info));
> +
> +	if (tcm_info->id_info.mode == MODE_APPLICATION)
> +		retval = syna_tcm_get_app_info(tcm_info);
> +
> +exit:
> +	kfree(resp_buf);
> +
> +	return retval;
> +}
> +
> +static int syna_tcm_run_application_firmware(struct syna_tcm_data *tcm_info)
> +{
> +	int retval = 0;
> +	unsigned int retry = 3;
> +	unsigned char *resp_buf = NULL;
> +	unsigned int resp_length = 0;
> +
> +retry:
> +	retval = syna_tcm_write_message(tcm_info, CMD_RUN_APPLICATION_FIRMWARE,
> +					NULL, 0, &resp_buf, &resp_length);
> +
> +	if (retval < 0) {
> +		if (retry--)
> +			goto retry;
> +		goto exit;
> +	}
> +
> +	retval = syna_tcm_identify(tcm_info);
> +	if (retval < 0) {
> +		if (retry--)
> +			goto retry;
> +		goto exit;
> +	}
> +
> +	pr_info("syna_tcm: boot_mode: 0x%02x", tcm_info->id_info.mode);
> +
> +	if (tcm_info->id_info.mode != MODE_APPLICATION) {
> +		if (retry--)
> +			goto retry;
> +		retval = -EINVAL;
> +		goto exit;
> +	} else if (tcm_info->app_status != APP_STATUS_OK) {
> +		pr_warn("syna_tcm: application status = 0x%02x\n",
> +			tcm_info->app_status);
> +		if (retry--)
> +			goto retry;
> +	}
> +
> +	retval = 0;
> +
> +exit:
> +	kfree(resp_buf);
> +
> +	return retval;
> +}
> +
> +/*
> + * syna_get_report_data - Retrieve data from touch report
> + *
> + * @tcm_info: handle of tcm module
> + * @offset: start bit of retrieved data
> + * @bits: total bits of retrieved data
> + * @data: pointer of data, at most 4 byte
> + * Retrieve data from the touch report based on the bit offset and bit length
> + * information from the touch report configuration.
> + */
> +static int syna_tcm_get_report_data(unsigned char *report_buf,
> +				    unsigned int report_buf_length,
> +				    unsigned int offset, unsigned int num_bits,
> +				    unsigned int *data)
> +{
> +	unsigned char mask = 0;
> +	unsigned char byte_data = 0;
> +	unsigned int output_data = 0;
> +	unsigned int bit_offset = offset % 8;
> +	unsigned int byte_offset = offset / 8;
> +	unsigned int data_bits = 0;
> +	unsigned int available_bits = 0;
> +	unsigned int remaining_bits = num_bits;
> +
> +	if (num_bits == 0 || num_bits > 32) {
> +		pr_warn("report value larger than 32 bits: %d\n", num_bits);
> +		memcpy(data, &report_buf[byte_offset], num_bits / 8);
> +		return 0;
> +	}
> +
> +	if ((offset + num_bits) > report_buf_length * 8) {
> +		pr_warn("report: offset and bits beyond total read length: %d vs %d bits",
> +			offset + num_bits, report_buf_length * 8);
> +		*data = 0;
> +		return -1;
> +	}
> +
> +	while (remaining_bits) {
> +		byte_data = report_buf[byte_offset];
> +		byte_data >>= bit_offset;
> +
> +		available_bits = 8 - bit_offset;
> +		data_bits = available_bits < remaining_bits ? available_bits :
> +							      remaining_bits;
> +		mask = 0xff >> (8 - data_bits);
> +
> +		byte_data &= mask;
> +
> +		output_data |= byte_data << (num_bits - remaining_bits);
> +
> +		bit_offset = 0;
> +		byte_offset += 1;
> +		remaining_bits -= data_bits;
> +	}
> +
> +	*data = output_data;
> +
> +	return 0;
> +}
> +
> +static int syna_tcm_parse_touch_report(struct syna_tcm_data *tcm_info)
> +{
> +	int config_data_pointer = 0, obj = 0, foreach_start = 0, foreach_end,
> +	    retval;
> +	unsigned int offset = 0, num_bits, data = 0;
> +	unsigned char *report_config = tcm_info->report_config;
> +	unsigned int config_size = tcm_info->report_size;
> +
> +	unsigned char *report = &tcm_info->response_buf[MESSAGE_HEADER_SIZE];
> +	unsigned int report_size =
> +		tcm_info->response_length - MESSAGE_HEADER_SIZE - 1;
> +	unsigned char code;
> +
> +	struct touch_data *touch_data =
> +		kmalloc(sizeof(touch_data) * tcm_info->touchpanel_max_objects,
> +			GFP_KERNEL);

Calling kmalloc in the hot patch for every single touch event is not 
great, we have IRQF_ONESHOT so it's fine to have a buffer allocated once 
and re-use it here, you don't need any locking.
> +	memset(touch_data, 0,
> +	       sizeof(touch_data) * tcm_info->touchpanel_max_objects);
> +
> +	while (config_data_pointer < config_size) {
> +		code = report_config[config_data_pointer++];
> +		switch (code) {
> +		case TOUCH_END:
> +			goto exit;
> +		case TOUCH_FOREACH_ACTIVE_OBJECT:
> +			obj = 0;
> +			foreach_start = config_data_pointer;
> +			if (offset >= report_size * 8)
> +				goto exit;
> +			break;
> +		case TOUCH_FOREACH_END:
> +			foreach_end = config_data_pointer;
> +			if (offset < report_size * 8)
> +				config_data_pointer = foreach_start;
> +			break;
> +		// Ignored
> +		case TOUCH_OBJECT_N_TX_POSITION_TIXELS:
> +		case TOUCH_OBJECT_N_RX_POSITION_TIXELS:
> +		case TOUCH_FRAME_RATE:
> +		case TOUCH_0D_BUTTONS_STATE:
> +		case 30: // I don't know what command 30 is and it isn't in the downstream driver. After it comes a length of 8 bits and this is ignored
> +			num_bits = report_config[config_data_pointer++];
> +			offset += num_bits;
> +			break;
> +		case TOUCH_PAD_TO_NEXT_BYTE:
> +			offset = ceil_div(offset, 8) * 8;
> +			break;
> +		case TOUCH_OBJECT_N_INDEX:
> +			num_bits = report_config[config_data_pointer++];
> +			retval = syna_tcm_get_report_data(
> +				report, report_size, offset, num_bits, &obj);
> +			if (retval < 0) {
> +				pr_warn("failed to get object index\n");
> +				return retval;
> +			}
> +			offset += num_bits;
> +			break;
> +		case TOUCH_OBJECT_N_CLASSIFICATION:
> +			num_bits = report_config[config_data_pointer++];
> +			retval = syna_tcm_get_report_data(
> +				report, report_size, offset, num_bits, &data);
> +			if (retval < 0) {
> +				pr_warn("failed to get object classification\n");
> +				return retval;
> +			}
> +			if (obj >= tcm_info->touchpanel_max_objects) {
> +				pr_warn("too many objects\n");
> +				return -1;
> +			}
> +			touch_data[obj].status = data;
> +			offset += num_bits;
> +			break;
> +		case TOUCH_OBJECT_N_X_POSITION:
> +			num_bits = report_config[config_data_pointer++];
> +			retval = syna_tcm_get_report_data(
> +				report, report_size, offset, num_bits, &data);
> +			if (retval < 0) {
> +				pr_warn("failed to get object x position\n");
> +				return retval;
> +			}
> +			touch_data[obj].x_pos = data;
> +			offset += num_bits;
> +			break;
> +		case TOUCH_OBJECT_N_Y_POSITION:
> +			num_bits = report_config[config_data_pointer++];
> +			retval = syna_tcm_get_report_data(
> +				report, report_size, offset, num_bits, &data);
> +			if (retval < 0) {
> +				pr_warn("failed to get object y position\n");
> +				return retval;
> +			}
> +			touch_data[obj].y_pos = data;
> +			offset += num_bits;
> +			break;
> +		case TOUCH_OBJECT_N_Z:
> +			num_bits = report_config[config_data_pointer++];
> +			retval = syna_tcm_get_report_data(
> +				report, report_size, offset, num_bits, &data);
> +			if (retval < 0) {
> +				pr_warn("failed to get object z\n");
> +				return retval;
> +			}
> +			touch_data[obj].z = data;
> +			offset += num_bits;
> +			break;
> +		case TOUCH_OBJECT_N_X_WIDTH:
> +			num_bits = report_config[config_data_pointer++];
> +			retval = syna_tcm_get_report_data(
> +				report, report_size, offset, num_bits, &data);
> +			if (retval < 0) {
> +				pr_warn("failed to get object x width\n");
> +				return retval;
> +			}
> +			touch_data[obj].x_width = data;
> +			offset += num_bits;
> +			break;
> +		case TOUCH_OBJECT_N_Y_WIDTH:
> +			num_bits = report_config[config_data_pointer++];
> +			retval = syna_tcm_get_report_data(
> +				report, report_size, offset, num_bits, &data);
> +			if (retval < 0) {
> +				pr_warn("failed to get object y width\n");
> +				return retval;
> +			}
> +			touch_data[obj].y_width = data;
> +			offset += num_bits;
> +			break;
> +		default:
> +			pr_notice("unrecognized touch report config code: %d",
> +				  code);

This should be a debug print
> +		}
> +	}
> +
> +exit:
> +	for (int i = 0; i < tcm_info->touchpanel_max_objects; i++) {
> +		if (touch_data[i].status == NOP)
> +			continue;
> +
> +		bool lift = touch_data[i].status == LIFT ? true : false;
> +
> +		input_mt_slot(tcm_info->input, i);
> +		input_mt_report_slot_state(tcm_info->input, MT_TOOL_FINGER,
> +					   !lift);
> +
> +		int x_width = touch_data[i].x_width;
> +		int y_width = touch_data[i].y_width;
> +		int major_width = x_width > y_width ? x_width : y_width;
> +		int minor_width = x_width > y_width ? y_width : x_width;
> +		int x_is_major = x_width > y_width ? true : false;
> +
> +		if (!lift) {
> +			input_report_abs(tcm_info->input, ABS_MT_POSITION_X,
> +					 touch_data[i].x_pos);
> +			input_report_abs(tcm_info->input, ABS_MT_POSITION_Y,
> +					 touch_data[i].y_pos);
> +			input_report_abs(tcm_info->input, ABS_MT_TOUCH_MAJOR,
> +					 major_width);
> +			input_report_abs(tcm_info->input, ABS_MT_TOUCH_MINOR,
> +					 minor_width);
> +			input_report_abs(tcm_info->input, ABS_MT_ORIENTATION,
> +					 x_is_major);
> +			input_report_abs(tcm_info->input, ABS_MT_PRESSURE,
> +					 touch_data[i].z);
> +		}
> +
> +		input_sync(tcm_info->input);
> +	}
> +
> +	kfree(touch_data);
> +	return 0;
> +}
> +
> +static irqreturn_t syna_irq_handler(int irq, void *dev)
> +{
> +	int retval;
> +	struct syna_tcm_data *tcm_info = dev;
> +
> +	retval = syna_tcm_read_message(tcm_info, 0);
> +	if (retval < 0) {
> +		tcm_info->response_length = -1;
> +		goto exit;
> +	}
> +
> +	if (tcm_info->response_buf[1] == REPORT_TOUCH)

Aha, found your bug... I see places where response_buf gets free'd 
(why??) and I guess you're hitting this codepath after it's free. The 
null pointer is actually address 0x1.
> +		syna_tcm_parse_touch_report(tcm_info);
> +
> +exit:
> +	if (tcm_info->response_buf[1] <= REPORT_IDENTIFY)

Or here...
> +		complete(&response_complete);

I'll leave it here for now, I'd appreciate it if you CC me in the next 
revision (and the other lists as Krzyzstof said -- don't forget 
phone-devel!).

Kind regards,
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int syna_tcm_power_on(struct syna_tcm_data *tcm_info)
> +{
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(tcm_info->regulators),
> +				    tcm_info->regulators);
> +	if (ret)
> +		return ret;
> +
> +	gpiod_set_value(tcm_info->reset_gpio, false);
> +	msleep(POWERUP_TO_RESET_TIME);
> +	gpiod_set_value(tcm_info->reset_gpio, true);
> +	msleep(RESET_TO_NORMAL_TIME);
> +
> +	return 0;
> +}
> +
> +static int syna_tcm_probe(struct i2c_client *client)
> +{
> +	struct syna_tcm_data *tcm_info;
> +	int err;
> +
> +	pr_info("starting probe for syna_tcm_oncell touchscreen");
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_I2C | I2C_FUNC_SMBUS_BYTE_DATA |
> +					     I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return -ENODEV;
> +
> +	tcm_info = devm_kzalloc(&client->dev, sizeof(*tcm_info), GFP_KERNEL);
> +	if (!tcm_info)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, tcm_info);
> +	tcm_info->client = client;
> +	tcm_info->response_buf = NULL;
> +
> +	of_property_read_u32(client->dev.of_node, "max-objects",
> +			     &tcm_info->touchpanel_max_objects);
> +
> +	tcm_info->reset_gpio =
> +		gpiod_get_index(&client->dev, "reset", 0, GPIOD_OUT_HIGH);
> +
> +	tcm_info->regulators[SYNA_TCM_ONCELL_REGULATOR_VDD].supply = "vdd";
> +	tcm_info->regulators[SYNA_TCM_ONCELL_REGULATOR_VCC].supply = "vcc";
> +	err = devm_regulator_bulk_get(&client->dev,
> +				      ARRAY_SIZE(tcm_info->regulators),
> +				      tcm_info->regulators);
> +	if (err)
> +		return err;
> +
> +	// TODO: uncomment once syna_tcm_power_off is implemented
> +	// err = devm_add_action_or_reset(&client->dev, syna_tcm_oncell_power_off, tcm_info);
> +	// if (err)
> +	//     return err;
> +
> +	err = syna_tcm_power_on(tcm_info);
> +	if (err < 0)
> +		return err;
> +
> +	// This needs to happen before the first write to the device
> +	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					syna_irq_handler,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					"syna_tcm_oncell_irq", tcm_info);
> +	if (err)
> +		return err;
> +
> +	err = syna_tcm_run_application_firmware(tcm_info);
> +	if (err < 0)
> +		return err;
> +
> +	// err = syna_tcm_set_normal_report_config(tcm_info);
> +	// if (err < 0)
> +		// pr_err("syna_tcm: failed to set normal touch report config")
> +
> +	err = syna_tcm_get_report_config(tcm_info);
> +	if (err < 0)
> +		return err;
> +
> +	tcm_info->input = devm_input_allocate_device(&client->dev);
> +	if (!tcm_info->input)
> +		return -ENOMEM;
> +
> +	tcm_info->input->name = TOUCHPANEL_DEVICE;
> +	tcm_info->input->id.bustype = BUS_I2C;
> +
> +	input_set_abs_params(tcm_info->input, ABS_MT_POSITION_X, 0,
> +			     le2_to_uint(tcm_info->app_info.max_x), 0, 0);
> +	input_set_abs_params(tcm_info->input, ABS_MT_POSITION_Y, 0,
> +			     le2_to_uint(tcm_info->app_info.max_y), 0, 0);
> +	input_set_abs_params(tcm_info->input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +	input_set_abs_params(tcm_info->input, ABS_MT_TOUCH_MINOR, 0, 255, 0, 0);
> +	input_set_abs_params(tcm_info->input, ABS_MT_PRESSURE, 0, 255, 0, 0);
> +
> +	touchscreen_parse_properties(tcm_info->input, true, &tcm_info->prop);
> +
> +	err = input_mt_init_slots(tcm_info->input,
> +				  tcm_info->touchpanel_max_objects,
> +				  INPUT_MT_DIRECT);
> +	if (err)
> +		return err;
> +
> +	input_set_drvdata(tcm_info->input, tcm_info);
> +
> +	err = input_register_device(tcm_info->input);
> +	if (err)
> +		return err;
> +
> +	pr_info("syna_tcm: probe done");
> +	tcm_info->initialize_done = true;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id syna_driver_ids[] = {
> +	{
> +		.compatible = "syna,s3908",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, syna_driver_ids);
> +
> +static const struct i2c_device_id syna_i2c_ids[] = { { TOUCHPANEL_DEVICE, 0 },
> +						     {} };
> +MODULE_DEVICE_TABLE(i2c, syna_i2c_ids);
> +
> +// static const struct dev_pm_ops syna_pm_ops = {
> +//     .suspend = syna_i2c_suspend,
> +//     .resume = syna_i2c_resume,
> +// };
> +
> +static struct i2c_driver syna_i2c_driver = {
> +	.probe	= syna_tcm_probe,
> +	// .remove	   = syna_i2c_remove,
> +	// .shutdown   = syna_tp_shutdown,
> +	.id_table	= syna_i2c_ids,
> +	.driver	= {
> +	.name	= TOUCHPANEL_DEVICE,
> +	.of_match_table = syna_driver_ids,
> +		// .pm = &syna_pm_ops,
> +	},
> +};
> +
> +module_i2c_driver(syna_i2c_driver);

-- 
// Caleb (they/them)

