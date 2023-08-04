Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48066770873
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjHDTDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjHDTDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:03:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD055241;
        Fri,  4 Aug 2023 12:03:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe4b95c371so4755945e9.1;
        Fri, 04 Aug 2023 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691175780; x=1691780580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loRKlRWq6rbsTVyoPRxGZ/mQukOWBbnOG2yJPLsoG/g=;
        b=CHRlAXVnlwTvkwXZdPJme0g9IXdvEhGSo3q8JOk5oTWsZepbqCx3Fm2p19+Py9gM7W
         dpJ2BMYlOHVskuBKClYUd5D0fBe9dXaFpfnHhqE7fHkw8qKMjpzBoSM1zgENtwWOujuX
         XtkdaLXuhiix/H4kpXp4hxx3NLLYev2Om6qOtOX8s/J/vSATXj2QwuK830+/V0UNSfm2
         MwoxatPKggipPGstpRl9sdEEydvjD2/IbznVbzNo79iWbqLM1ICjKVWiwyEkUPVdsgaU
         0seRuVfTciNolv01P7gtx152qEE66UH1p8srWHYmU0t/zJ+y322DjAOUmP+1vRd3ypG/
         Q/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691175780; x=1691780580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loRKlRWq6rbsTVyoPRxGZ/mQukOWBbnOG2yJPLsoG/g=;
        b=SZzz6FbpmZOqUn8PWGQ/AgobDnERpUWogXt+LJmeadxdVP5Xwb6wzYpKdJgZ897Z+P
         8MTYRIWULGNRFV7sNApZlxHvyoInrNakeqUJZGx5CG5zXjgwydenzIQvWCEow7NStaqQ
         QEQYahF+0WzPN+Ae9EwXrcnI1fZQTCX1ip+h5ZdzRh5NWqm9ZFz0EyFzUqkAoRgVZUoD
         yX6ryt8wUOEnAIdXxQNz5VXW/kJuFWv+tTkZYOpOuIs8jYxH1UwRekR381SKgQ75blS0
         TXZWN9O2FOhIih6arOfgREb4i5LLYA6SsPN5yg614fdUrdXAMqtEudxW7zQfInRkcaJ1
         SLZQ==
X-Gm-Message-State: AOJu0YzltXLETwKRYPpEeFoUISMEpr7EyLIpUKnVfWLWHWO35dHKwVEf
        Mml/6bQLVyv2l5hlXbinoNWqFWFiOPIQPA==
X-Google-Smtp-Source: AGHT+IGb/2YftRp45hWredSCou0kGp6yuLcNRiIhxm4N4DBj7uCxgTgQoSCo9Vpggw6Lse5819/GVQ==
X-Received: by 2002:a05:600c:a2a3:b0:3fa:91d0:8ddb with SMTP id hu35-20020a05600ca2a300b003fa91d08ddbmr414600wmb.14.1691175779832;
        Fri, 04 Aug 2023 12:02:59 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4204000000b003143867d2ebsm3153306wrq.63.2023.08.04.12.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 12:02:59 -0700 (PDT)
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
Subject: Re: [PATCH v2 1/3] arm64: dts: allwinner: h616: Split Orange Pi Zero 2 DT
Date:   Fri, 04 Aug 2023 21:02:58 +0200
Message-ID: <2691030.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230804170856.1237202-2-andre.przywara@arm.com>
References: <20230804170856.1237202-1-andre.przywara@arm.com>
 <20230804170856.1237202-2-andre.przywara@arm.com>
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

Dne petek, 04. avgust 2023 ob 19:08:54 CEST je Andre Przywara napisal(a):
> The Orange Pi Zero 2 got a successor (Zero 3), which shares quite some
> DT nodes with the Zero 2, but comes with a different PMIC.
> 
> Move the common parts (except the PMIC) into a new shared file, and
> include that from the existing board .dts file.
> 
> No functional change, the generated DTB is the same, except for some
> phandle numbering differences.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../allwinner/sun50i-h616-orangepi-zero.dtsi  | 134 ++++++++++++++++++
>  .../allwinner/sun50i-h616-orangepi-zero2.dts  | 119 +---------------
>  2 files changed, 135 insertions(+), 118 deletions(-)
>  create mode 100644
> arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi new file
> mode 100644
> index 0000000000000..8788c129b2887
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2020 Arm Ltd.
> + *
> + * DT nodes common between Orange Pi Zero 2 and Orange Pi Zero 3.
> + * Excludes PMIC nodes and properties, since they are different between the
> two. + */
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	aliases {
> +		ethernet0 = &emac0;
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
> +			function = LED_FUNCTION_POWER;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12 
*/
> +			default-state = "on";
> +		};
> +
> +		led-1 {
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
> +	reg_usb1_vbus: regulator-usb1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb1-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&reg_vcc5v>;
> +		enable-active-high;
> +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
> +	};
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +/* USB 2 & 3 are on headers only. */
> +
> +&emac0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ext_rgmii_pins>;
> +	phy-mode = "rgmii";
> +	phy-handle = <&ext_rgmii_phy>;
> +	allwinner,rx-delay-ps = <3100>;
> +	allwinner,tx-delay-ps = <700>;
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	ext_rgmii_phy: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;
> +	};
> +};
> +
> +&mmc0 {
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&spi0  {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_pins>, <&spi0_cs0_pin>;
> +
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;
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
> +	usb1_vbus-supply = <&reg_usb1_vbus>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts index
> cb8600d0ea1ef..d6e732b12c52d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> @@ -5,95 +5,19 @@
> 
>  /dts-v1/;
> 
> -#include "sun50i-h616.dtsi"
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/leds/common.h>
> +#include "sun50i-h616-orangepi-zero.dtsi"
> 
>  / {
>  	model = "OrangePi Zero2";
>  	compatible = "xunlong,orangepi-zero2", "allwinner,sun50i-h616";
> -
> -	aliases {
> -		ethernet0 = &emac0;
> -		serial0 = &uart0;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -
> -		led-0 {
> -			function = LED_FUNCTION_POWER;
> -			color = <LED_COLOR_ID_RED>;
> -			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* 
PC12 */
> -			default-state = "on";
> -		};
> -
> -		led-1 {
> -			function = LED_FUNCTION_STATUS;
> -			color = <LED_COLOR_ID_GREEN>;
> -			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* 
PC13 */
> -		};
> -	};
> -
> -	reg_vcc5v: vcc5v {
> -		/* board wide 5V supply directly from the USB-C socket 
*/
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc-5v";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		regulator-always-on;
> -	};
> -
> -	reg_usb1_vbus: regulator-usb1-vbus {
> -		compatible = "regulator-fixed";
> -		regulator-name = "usb1-vbus";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&reg_vcc5v>;
> -		enable-active-high;
> -		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>; /* PC16 */
> -	};
>  };
> 
> -&ehci1 {
> -	status = "okay";
> -};
> -
> -/* USB 2 & 3 are on headers only. */
> -
>  &emac0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&ext_rgmii_pins>;
> -	phy-mode = "rgmii";
> -	phy-handle = <&ext_rgmii_phy>;
>  	phy-supply = <&reg_dcdce>;
> -	allwinner,rx-delay-ps = <3100>;
> -	allwinner,tx-delay-ps = <700>;
> -	status = "okay";
> -};
> -
> -&mdio0 {
> -	ext_rgmii_phy: ethernet-phy@1 {
> -		compatible = "ethernet-phy-ieee802.3-c22";
> -		reg = <1>;
> -	};
>  };
> 
>  &mmc0 {
>  	vmmc-supply = <&reg_dcdce>;
> -	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> -	bus-width = <4>;
> -	status = "okay";
> -};
> -
> -&ohci1 {
> -	status = "okay";
>  };
> 
>  &r_rsb {
> @@ -211,44 +135,3 @@ &pio {
>  	vcc-ph-supply = <&reg_aldo1>;
>  	vcc-pi-supply = <&reg_aldo1>;
>  };
> -
> -&spi0  {
> -	status = "okay";
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi0_pins>, <&spi0_cs0_pin>;
> -
> -	flash@0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -		spi-max-frequency = <40000000>;
> -	};
> -};
> -
> -&uart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart0_ph_pins>;
> -	status = "okay";
> -};
> -
> -&usbotg {
> -	/*
> -	 * PHY0 pins are connected to a USB-C socket, but a role switch
> -	 * is not implemented: both CC pins are pulled to GND.
> -	 * The VBUS pins power the device, so a fixed peripheral mode
> -	 * is the best choice.
> -	 * The board can be powered via GPIOs, in this case port0 *can*
> -	 * act as a host (with a cable/adapter ignoring CC), as VBUS is
> -	 * then provided by the GPIOs. Any user of this setup would
> -	 * need to adjust the DT accordingly: dr_mode set to "host",
> -	 * enabling OHCI0 and EHCI0.
> -	 */
> -	dr_mode = "peripheral";
> -	status = "okay";
> -};
> -
> -&usbphy {
> -	usb1_vbus-supply = <&reg_usb1_vbus>;
> -	status = "okay";
> -};




