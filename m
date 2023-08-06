Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E08771499
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 13:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjHFLvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 07:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjHFLvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 07:51:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA04E13E;
        Sun,  6 Aug 2023 04:51:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so5976929e87.3;
        Sun, 06 Aug 2023 04:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691322698; x=1691927498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSegRepTwLPnXiUntiRa8X8cOH9xGOm2xw2wPMUtKGg=;
        b=mWYIoanLfnktzVBbEXpR8CNDx0mgUaNc4QdnR0Xrgls6h0+OKuhVMPOvGsJtbDSsTF
         RxLLF0KllFSvWwVfol0qvezBHiBlOak6mcBQ2FEqeXciM4g68mvgXhMNDYQS/EuUUTtM
         8E3UTo9T2Q1B1f37UFSIJ4rrpZyfu3Az3QmTSU+TDKQ0RL8GfQeQvfuR/BevCU07/FZb
         OafcEJ/EPkmWlC/Tp04BJ7H28x4F1gmdUIQBYmV08Y8ynhktQ9GC6aSFnwlyswhAWcKf
         X4c1WYEKfVeHUMllqUrrh6nUQWa313lTr/cekfopgZIirtRKUFfJHeZdHVVekaMFSmBy
         P3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691322698; x=1691927498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSegRepTwLPnXiUntiRa8X8cOH9xGOm2xw2wPMUtKGg=;
        b=lk+fNDzZ8+iumSxwLexsJ06Cfe9JlyvM6T6k/ZJNMSWVICWnzAuPQgrYLVYJ+hiI7G
         uMfF+y02NBLo+No5ZgX7dGECwmn6/pxkLoJ1t+UJSYndut2IdPvFOk+7zv3MIEfilLSH
         BI3lxTQEUXvxxZkh0d8vdQl/6FAW17sArXNf0njLoIP2ad4mfSAIsmW1CPPMI7J6pvvX
         JLkjumgIr7wdsmYS5VCqgEEd6y8X01jHWhSRpTynsFB1jSddFtrhSJDxczwNFRQdjEes
         tOwLF64/GnWfulSFEWj0T/NqxPwjAcV6Xp+KHCN8dOoEIAJYC3NGVAa0AId9uNdqkPRK
         Lv0A==
X-Gm-Message-State: AOJu0Yy2E6YpgxyotDnfCbi7jWJUE8l39SqHDo2grFjw2GsX4CmyAuqs
        NtthzH/ePbuGksViN9z1cks=
X-Google-Smtp-Source: AGHT+IEPlxMTuUEU7CB6rXL95xZ/zc5jRJORtE6U8tMI2zzQLoxtVWhNj6S7L+Tr/Bpu+DtoeCc9Eg==
X-Received: by 2002:a05:6512:34d2:b0:4f8:7513:8cac with SMTP id w18-20020a05651234d200b004f875138cacmr3451801lfr.48.1691322697578;
        Sun, 06 Aug 2023 04:51:37 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id g3-20020a50ee03000000b0052314366967sm3788421eds.80.2023.08.06.04.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 04:51:37 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Matthew Croughan <matthew.croughan@nix.how>
Cc:     Matthew Croughan <matthew.croughan@nix.how>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] arm64: dts: allwinner: h616: Add Mango Pi MQ-Quad DTS
Date:   Sun, 06 Aug 2023 13:51:36 +0200
Message-ID: <2151035.irdbgypaU6@jernej-laptop>
In-Reply-To: <20230805233715.1216456-3-matthew.croughan@nix.how>
References: <20230805233715.1216456-1-matthew.croughan@nix.how>
 <20230805233715.1216456-3-matthew.croughan@nix.how>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 06. avgust 2023 ob 01:34:56 CEST je Matthew Croughan napisal(a):
> Mango Pi MQ Quad is a H616 based SBC, add basic support for the board
> and its peripherals
> 
> Signed-off-by: Matthew Croughan <matthew.croughan@nix.how>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../allwinner/sun50i-h616-mangopi-mq-quad.dts | 187 ++++++++++++++++++
>  2 files changed, 188 insertions(+)
>  create mode 100644
> arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> b/arch/arm64/boot/dts/allwinner/Makefile index 6a96494a2e0a..06c5b97dbfc3
> 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-mangopi-mq-quad.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts new file
> mode 100644
> index 000000000000..6121c14bc66b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts
> @@ -0,0 +1,187 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> + * Copyright (C) 2020 Arm Ltd.
> + *
> + * Copyright (C) 2023 Matthew Croughan <matthew.croughan@nix.how>
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "MangoPi MQ-Quad";
> +	compatible = "widora,mangopi-mq-quad", "allwinner,sun50i-h616";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13 
*/
> +		};
> +	};
> +
> +	reg_vcc5v: vcc5v {
> +		/* board wide 5V supply directly from the USB-C socket 
*/
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_vcc3v3: vcc3v3 {
> +		/* board wide 3V3 supply directly from SY8008 regulator 
*/
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	wifi_pwrseq: wifi-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
> +	};
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&pio {
> +	vcc-pc-supply = <&reg_vcc3v3>;
> +	vcc-pg-supply = <&reg_vcc3v3>;
> +	vcc-pi-supply = <&reg_vcc3v3>;
> +};
> +
> +/* USB 2 & 3 are on headers only. */
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_vcc3v3>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&mmc1 {
> +	bus-width = <4>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	non-removable;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	vqmmc-supply = <&reg_vcc3v3>;
> +	pinctrl-0 = <&mmc1_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	rtl8723ds: wifi@1 {
> +		reg = <1>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <6 15 IRQ_TYPE_LEVEL_LOW>; /* PG15 */
> +		interrupt-names = "host-wake";

There is no point having device node with properties but without compatible. 
You also don't provide any ethernet alias, which would allow U-Boot to add MAC 
property.

In any case, rtw88 driver now supports rtl8723ds, but it's loaded based on 
SDIO ID. It doesn't take any info from DT yet.

I suggest that you drop it for now and if/when rtw88 driver gains support for 
taking GPIO property for host wakeup, it's added then.

Best regards,
Jernej

> +	};
> +};
> +
> +
> +&uart1 {
> +	uart-has-rtscts;
> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "realtek,rtl8723ds-bt";
> +		device-wake-gpios = <&pio 6 17 GPIO_ACTIVE_HIGH>; /* 
PG17 */
> +		enable-gpios = <&pio 6 19 GPIO_ACTIVE_HIGH>; /* PG19 */
> +		host-wake-gpios = <&pio 6 16 GPIO_ACTIVE_HIGH>; /* PG16 
*/
> +	};
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&r_i2c {
> +	status = "okay";
> +
> +	axp313a: pmic@36 {
> +		compatible = "x-powers,axp313a";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x36>;
> +		regulators {
> +			/*
> +			 * ALDO1 is feeding both VCC-PLL and VCC-
DCXO, always-on is required,
> +			 * as removing power would cut the 1.8v 
supply for the RAM
> +			 */
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<1800000>;
> +				regulator-max-microvolt = 
<1800000>;
> +				regulator-name = "vcc-1v8";
> +			};
> +
> +			reg_dcdc1: dcdc1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<810000>;
> +				regulator-max-microvolt = 
<990000>;
> +				regulator-name = "vdd-gpu-sys";
> +			};
> +
> +			reg_dcdc2: dcdc2 {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<810000>;
> +				regulator-max-microvolt = 
<1100000>;
> +				regulator-name = "vdd-cpu";
> +			};
> +
> +			reg_dcdc3: dcdc3 {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<1500000>;
> +				regulator-max-microvolt = 
<1500000>;
> +				regulator-name = "vdd-dram";
> +			};
> +
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	/*
> +	 * PHY0 pins are connected to a USB-C socket, but a role switch
> +	 * is not implemented: both CC pins are pulled to GND.
> +	 * The VBUS pins power the device, so a fixed peripheral mode
> +	 * is the best choice.
> +	 * The board can be powered via GPIOs, in this case port0 *can*
> +	 * act as a host (with a cable/adapter ignoring CC), as VBUS is
> +	 * then provided by the GPIOs. Any user of this setup would
> +	 * need to adjust the DT accordingly: dr_mode set to "host",
> +	 * enabling OHCI0 and EHCI0.
> +	 */
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	usb1_vbus-supply = <&reg_vcc5v>;
> +	status = "okay";
> +};




