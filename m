Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41955770890
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjHDTGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjHDTGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:06:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF94EED;
        Fri,  4 Aug 2023 12:05:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe2bc2701bso22529135e9.2;
        Fri, 04 Aug 2023 12:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691175940; x=1691780740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RImfxtxvGtLO2n9zPJtV/vphcAvXDGCdvAZ0GbDbKrk=;
        b=sQ/fQqqtQOaPptev4nG45CWIPf3ZJmox/dXbVk/wnAnyPSDQgvEB1sGCfzREKDHyxz
         uMrYsS5yWsVqKOPLEszFO9lH4VE65Cz9c9p05HnHvakq7AtBEsNPBj+M3wcyozDNPTAw
         9ubz1s2RBijzpI+vuzs1rnn0LgZGWXogRuLqMRHPRb3Cvs2Gsu8E8J4a/sj91PF4kYGG
         3PWdbW553UZUYx3DOf/uixvEkElav2rbAZfXMs4KPDV0M/L02RuFEv5lZC7ik+N/8M/L
         SdPl4NuUYkX2WGrRwF/Y656nfT6EiwhJjrpygWVd18YE9kgd9BpeBnW0tCpGG5q7dVNZ
         UrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691175940; x=1691780740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RImfxtxvGtLO2n9zPJtV/vphcAvXDGCdvAZ0GbDbKrk=;
        b=W+7Hj9qL06sYLfmLbatDukSz8P3Ci36d20IM5CajmUUQHOpQFCM7xzTAr558mML9kr
         kP5w5/4Tl+J1/GqEjUxBrLz4LUh1uR03shBN+JqBfMb5rkyp0Sgs6ux4fI+FEwIqZnKY
         FTGJxoXZKL+1ozAW5cO4oFpTg9jQdD+tib01svCfhTdrGhAEIEn1VqlniPQ2U8a2RIcr
         fRdpVzyjJzjwE9AJ5zqGl3xRjNvfu8Y3q8JjK1JJnqcReGCE6vVP04vTUSJvVjEUG7AF
         tG1Zci7HEi2Dm/mB4BLJfJIrVe3hKFt6JZDINvMIG0OtuVPOA+1yFd4NwdC/XTmqpHh1
         h+vQ==
X-Gm-Message-State: AOJu0YwBeKaH54mV0W347x0Mf7DSehYHWUU2MCLc6UbX8DnrVVBtEMEk
        TasKJAVQBFtcEqIUjcIdBF4=
X-Google-Smtp-Source: AGHT+IEn1aXb9mEpqN8jQUJqVtnlCntlV7okng3mYJc7tFxDGgv2efEXqCJ0/u4COACFPhXcJalyeA==
X-Received: by 2002:a7b:cc87:0:b0:3fe:4e4e:bedb with SMTP id p7-20020a7bcc87000000b003fe4e4ebedbmr172426wma.4.1691175939761;
        Fri, 04 Aug 2023 12:05:39 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c22d600b003fe2de3f94fsm3063043wmg.12.2023.08.04.12.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 12:05:38 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: allwinner: h616: Add OrangePi Zero 3 board
 support
Date:   Fri, 04 Aug 2023 21:05:36 +0200
Message-ID: <4500165.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20230804170856.1237202-4-andre.przywara@arm.com>
References: <20230804170856.1237202-1-andre.przywara@arm.com>
 <20230804170856.1237202-4-andre.przywara@arm.com>
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

Dne petek, 04. avgust 2023 ob 19:08:56 CEST je Andre Przywara napisal(a):
> The OrangePi Zero 3 is a development board based on the Allwinner H618 SoC,
> which seems to be just an H616 with more L2 cache. The board itself is a
> slightly updated version of the Orange Pi Zero 2. It features:
> - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
> - 1/1.5/2/4 GiB LPDDR4 DRAM SKUs (only up to 1GB on the Zero2)
> - AXP313a PMIC (more capable AXP305 on the Zero2)
> - Raspberry-Pi-1 compatible GPIO header
> - extra 13 pin expansion header, exposing pins for 2x USB 2.0 ports
> - 1 USB 2.0 host port
> - 1 USB 2.0 type C port (power supply + OTG)
> - MicroSD slot
> - on-board 16MiB bootable SPI NOR flash (only 2MB on the Zero2)
> - 1Gbps Ethernet port (via Motorcomm YT8531 PHY) (RTL8211 on the Zero2)
> - micro-HDMI port
> - (yet) unsupported Allwinner WiFi/BT chip
> 
> Add the devicetree file describing the currently supported features,
> namely LEDs, SD card, PMIC, SPI flash, USB. Ethernet seems unstable at
> the moment, though the basic functionality works.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
>  .../allwinner/sun50i-h618-orangepi-zero3.dts  | 94 +++++++++++++++++++
>  2 files changed, 95 insertions(+)
>  create mode 100644
> arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> b/arch/arm64/boot/dts/allwinner/Makefile index 6a96494a2e0a3..3b0ad54062381
> 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -40,3 +40,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero3.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts new file
> mode 100644
> index 0000000000000..96a6851728111
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2023 Arm Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616-orangepi-zero.dtsi"
> +
> +/ {
> +	model = "OrangePi Zero3";
> +	compatible = "xunlong,orangepi-zero3", "allwinner,sun50i-h618";
> +};
> +
> +&emac0 {
> +	phy-supply = <&reg_dldo1>;
> +};
> +
> +&ext_rgmii_phy {
> +	motorcomm,clk-out-frequency-hz = <125000000>;
> +};
> +
> +&mmc0 {
> +	/*
> +	 * The schematic shows the card detect pin wired up to PF6, via an
> +	 * inverter, but it just doesn't work.
> +	 */
> +	broken-cd;
> +	vmmc-supply = <&reg_dldo1>;
> +};
> +
> +&r_i2c {
> +	status = "okay";
> +
> +	axp313: pmic@36 {
> +		compatible = "x-powers,axp313a";
> +		reg = <0x36>;
> +		#interrupt-cells = <1>;
> +		interrupt-controller;
> +		interrupt-parent = <&pio>;
> +		interrupts = <2 9 IRQ_TYPE_LEVEL_LOW>;	/* PC9 */
> +
> +		vin1-supply = <&reg_vcc5v>;
> +		vin2-supply = <&reg_vcc5v>;
> +		vin3-supply = <&reg_vcc5v>;
> +
> +		regulators {
> +			/* Supplies VCC-PLL, so needs to be always 
on. */
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<1800000>;
> +				regulator-max-microvolt = 
<1800000>;
> +				regulator-name = "vcc1v8";
> +			};
> +
> +			/* Supplies VCC-IO, so needs to be always on. 
*/
> +			reg_dldo1: dldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<3300000>;
> +				regulator-max-microvolt = 
<3300000>;
> +				regulator-name = "vcc3v3";
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

Is it safe to change sys voltage when system is running?

Best regards,
Jernej

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
<1100000>;
> +				regulator-max-microvolt = 
<1100000>;
> +				regulator-name = "vdd-dram";
> +			};
> +		};
> +	};
> +};
> +
> +&pio {
> +	vcc-pc-supply = <&reg_dldo1>;
> +	vcc-pf-supply = <&reg_dldo1>;
> +	vcc-pg-supply = <&reg_aldo1>;
> +	vcc-ph-supply = <&reg_dldo1>;
> +	vcc-pi-supply = <&reg_dldo1>;
> +};




