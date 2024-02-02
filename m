Return-Path: <linux-kernel+bounces-50215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF6C8475E3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE111B2EF29
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B82C14C584;
	Fri,  2 Feb 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R7WIfiT3"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6A14A4E1;
	Fri,  2 Feb 2024 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893825; cv=none; b=XZjnVHhEyCA3L8l2RKLaPiytXjUrclYiLi4yWr8gvpzkWgl90CSJZx+v4BEF/EsqqQkO7bFGeKtVjvp2Ue5rFX9Aiey/JBnKLuKpZX04DVfQyTUTeC3B8me/4ypKVNv693QbSeK0vN5/FYpdP21okhZ9gMMyM8ACWPH3wbH9QzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893825; c=relaxed/simple;
	bh=NsymF12kY+Og1r4+dTagzA26/g43/CAX4kdg17HDB0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CCMf1U1AgFIspGzx25TAOgqh8fDeP3qH9py2Nm89lbMuJ/qWShBM+lUlKJ4PZOXP+06yZkCan67DzZqkhhr0nmaQ43QjjqNOd6D7D+2PPknT85NSglKw34P5Pxf1F0l3sKd3RQEJ5+NLd+Q37z6rL/+XY7UPM+JVr+e5AJYEfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R7WIfiT3; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 412H9rEX022225;
	Fri, 2 Feb 2024 11:09:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706893793;
	bh=O5ttPdPVJfKJx3h8WkLF5JFWkBeX/o5nXNxfRxoySs4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=R7WIfiT3O4t7R8rt2QWg5hcZIDaKoXZ02B5ne6ezEcf5r/g1U5BUVZ+cOoYyE43up
	 uN6ZCvz1WyrUQhQLtGOVPvavkRuPCKTuPp/G81d6jqiDjZaXAy/XCC7f26oFII5dra
	 BuSGLYBdURtoddh6cb+HW+EAwk+TVCLsnr8hxp2I=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 412H9r5I020073
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 Feb 2024 11:09:53 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 11:09:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 11:09:53 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 412H9qu8051980;
	Fri, 2 Feb 2024 11:09:52 -0600
Message-ID: <6b457759-9a2d-44a7-a1a4-7c7ac42aedae@ti.com>
Date: Fri, 2 Feb 2024 11:09:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] arm64: dts: add description for solidrun am642 som
 and evaluation board
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>
References: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
 <20240202-add-am64-som-v4-4-5f8b12af5e71@solid-run.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240202-add-am64-som-v4-4-5f8b12af5e71@solid-run.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/2/24 10:10 AM, Josua Mayer wrote:
> Add description for the SolidRun AM642 SoM, and HummingBoard-T
> evaluation board.
> 
> The SoM features:
> - 1x cpsw ethernet with phy
> - 2x pru ethernet with phy
> - eMMC
> - spi flash (assembly option)
> 
> Additionally microSD and usb-2.0 otg are included in the SoM
> description as they are supported boot sources for the SOC boot-rom.
> 
> The Carrier provides:
> - 3x RJ45 connector
> - 2x M.2 connector
> - USB-2.0 Hub
> - USB-A Connector
> - LEDs
> - 2x CAN transceiver
> - 1x RS485 transceiver
> - sensors
> 
> The M.2 connectors support either USB-3.1 or PCI-E depending on status
> of a mux. By default the mux is switched off.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile                    |   1 +
>   arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 292 ++++++++++
>   arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        | 592 +++++++++++++++++++++
>   3 files changed, 885 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 77a347f9f47d..041c3b71155e 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
>   
>   # Boards with AM64x SoC
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
> new file mode 100644
> index 000000000000..ebaf281e1e1e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts
> @@ -0,0 +1,292 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
> + *
> + * DTS for SolidRun AM642 HummingBoard-T,
> + * running on Cortex A53.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/phy/phy.h>
> +
> +#include "k3-am642.dtsi"
> +#include "k3-am642-sr-som.dtsi"
> +
> +/ {
> +	model = "SolidRun AM642 HummingBoard-T";
> +	compatible = "solidrun,am642-hummingboard-t", "solidrun,am642-sr-som", "ti,am642";
> +
> +	aliases {
> +		serial5 = &main_uart3;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&leds_pins_default>;
> +
> +		/* D24 */
> +		led1: led-1 {
> +			label = "led1";
> +			gpios = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_GREEN>;
> +		};
> +
> +		/* D25 */
> +		led2: led-2 {
> +			label = "led2";
> +			gpios = <&main_gpio0 30 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_GREEN>;
> +		};
> +
> +		/* D26 */
> +		led3: led-3 {
> +			label = "led3";
> +			gpios = <&main_gpio0 33 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_GREEN>;
> +		};
> +	};
> +
> +	regulator-m2-3v3 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&regulator_pcie_3v3_pins_default>;
> +		regulator-name = "m2-3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&main_gpio1 17 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	regulator-vpp-1v8 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&regulator_vpp_1v8_pins_default>;
> +		regulator-name = "vpp-1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		gpio = <&main_gpio1 78 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	serdes_mux: mux-controller {
> +		compatible = "gpio-mux";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&serdes_mux_pins_default>;
> +		#mux-control-cells = <0>;
> +		/*
> +		 * Mux has 2 IOs:
> +		 * - select: 0 = USB-3 (M2); 1 = PCIE (M1)
> +		 * - shutdown: 0 = active; 1 = disabled (high impedance)
> +		 */
> +		mux-gpios = <&main_gpio1 40 GPIO_ACTIVE_HIGH>, <&main_gpio1 41 GPIO_ACTIVE_HIGH>;
> +		/* default disabled */
> +		idle-state = <2>;
> +	};
> +};
> +
> +&main_gpio0 {
> +	m2-reset-hog {
> +		gpio-hog;
> +		gpios = <12 GPIO_ACTIVE_LOW>;
> +		output-low; /* deasserted */
> +		line-name = "m2-reset";
> +	};
> +
> +	m1-m2-w-disable1-hog {
> +		gpio-hog;
> +		gpios = <32 GPIO_ACTIVE_LOW>;
> +		output-low; /* deasserted */
> +		line-name = "m1-m2-pcie-w-disable1";
> +	};
> +
> +	m1-m2-w-disable2-hog {
> +		gpio-hog;
> +		gpios = <34 GPIO_ACTIVE_LOW>;
> +		output-low; /* deasserted */
> +		line-name = "m1-m2-pcie-w-disable2";
> +	};
> +};
> +
> +&main_gpio1 {
> +	m1-pcie-clkreq0-hog {
> +		gpio-hog;
> +		gpios = <11 GPIO_ACTIVE_LOW>;
> +		input;
> +		line-name = "m1-pcie-clkreq0";
> +	};
> +
> +	m2-pcie-clkreq-hog {
> +		gpio-hog;
> +		gpios = <35 GPIO_ACTIVE_LOW>;
> +		input;
> +		line-name = "m2-pcie-clkreq";
> +	};
> +};
> +
> +&main_i2c0 {
> +	pinctrl-0 = <&main_i2c0_pins_default>, <&main_i2c0_int_pins_default>;
> +
> +	humidity-sensor@41 {
> +		compatible = "ti,hdc2010";
> +		reg = <0x41>;
> +		interrupt-parent = <&main_gpio0>;
> +		interrupts = <37 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +
> +	light-sensor@44 {
> +		compatible = "ti,opt3001";
> +		reg = <0x44>;
> +		interrupt-parent = <&main_gpio0>;
> +		interrupts = <37 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +
> +	/* charger@6a */
> +};
> +
> +&main_i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c1_pins_default>;
> +	status = "okay";
> +
> +	rtc@69 {
> +		compatible = "abracon,abx80x";
> +		reg = <0x69>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rtc_int_pins_default>;
> +		abracon,tc-diode = "schottky";
> +		abracon,tc-resistor = <3>;
> +		interrupt-parent = <&main_gpio0>;
> +		interrupts = <44 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +};
> +
> +&main_mcan0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan0_pins_default>;
> +	status = "okay";
> +
> +	can-transceiver {
> +		max-bitrate = <8000000>;
> +	};
> +};
> +
> +&main_mcan1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan1_pins_default>;
> +	status = "okay";
> +
> +	can-transceiver {
> +		max-bitrate = <8000000>;
> +	};
> +};
> +
> +&main_pmx0 {
> +	leds_pins_default: leds-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0074, PIN_OUTPUT, 7)	/* GPMC0_AD14.GPIO0_29 */
> +			AM64X_IOPAD(0x0078, PIN_OUTPUT, 7)	/* GPMC0_AD15.GPIO0_30 */
> +			AM64X_IOPAD(0x0088, PIN_OUTPUT, 7)	/* GPMC0_OEn_REn.GPIO0_33 */
> +		>;
> +	};
> +
> +	main_i2c0_int_pins_default: main-i2c0-pins-int-default {
> +		pinctrl-single,pins = <
> +			/* external pull-up on Carrier */
> +			AM64X_IOPAD(0x0098, PIN_INPUT, 7)	/* GPMC0_WAIT0.GPIO0_37 */
> +		>;
> +	};
> +
> +	main_i2c1_pins_default: main-i2c1-pins-default {
> +		pinctrl-single,pins = <
> +			/* external pull-up on SoM */
> +			AM64X_IOPAD(0x0268, PIN_INPUT, 0)	/* I2C1_SCL.I2C1_SCL */
> +			AM64X_IOPAD(0x026c, PIN_INPUT, 0)	/* I2C1_SDA.I2C1_SDA */
> +		>;
> +	};
> +
> +	main_mcan0_pins_default: main-mcan0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0254, PIN_INPUT, 0)	/* MCAN0_RX.MCAN0_RX */
> +			AM64X_IOPAD(0x0250, PIN_OUTPUT, 0)	/* MCAN0_TX.MCAN0_TX */
> +		>;
> +	};
> +
> +	main_mcan1_pins_default: main-mcan1-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x025c, PIN_INPUT, 0)	/* MCAN1_RX.MCAN1_RX */
> +			AM64X_IOPAD(0x0258, PIN_OUTPUT, 0)	/* MCAN1_TX.MCAN1_TX */
> +		>;
> +	};
> +
> +	main_uart3_pins_default: main-uart3-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x016c, PIN_INPUT, 10)	/* PRG0_PRU0_GPO3.UART3_CTSn */
> +			AM64X_IOPAD(0x0170, PIN_OUTPUT, 10)	/* PRG0_PRU0_GPO4.UART3_TXD */
> +			AM64X_IOPAD(0x0174, PIN_OUTPUT, 10)	/* PRG0_PRU0_GPO5.UART3_RTSn */
> +			AM64X_IOPAD(0x01ac, PIN_INPUT, 10)	/* PRG0_PRU0_GPO19.UART3_RXD */
> +		>;
> +	};
> +
> +	pcie0_pins_default: pcie0-pins-default {
> +		pinctrl-single,pins = <
> +			/* connector M2 RESET */
> +			AM64X_IOPAD(0x0030, PIN_OUTPUT, 7)	/* OSPI0_CSn1.GPIO0_12 */
> +			/* connectors M1 & M2 W_DISABLE1 */
> +			AM64X_IOPAD(0x0084, PIN_OUTPUT, 7)	/* GPMC0_ADVN_ALE.GPIO0_32 */
> +			/* connectors M1 & M2 W_DISABLE2 */
> +			AM64X_IOPAD(0x008c, PIN_OUTPUT, 7)	/* GPMC0_WEN.GPIO0_34 */
> +			/* connectors M1 & M2 PERST0 (PCI Reset) */
> +			AM64X_IOPAD(0x019c, PIN_OUTPUT, 7)	/* PRG0_PRU0_GPO15.GPIO1_15 */
> +			/* connector M1 CLKREQ0 */
> +			AM64X_IOPAD(0x018c, PIN_INPUT, 7)	/* PRG0_PRU0_GPO11.GPIO1_11 */
> +			/* connector M2 CLKREQ0 */
> +			AM64X_IOPAD(0x01ec, PIN_INPUT, 7)	/* PRG0_PRU1_GPO15.GPIO1_35 */
> +		>;
> +	};
> +
> +	regulator_pcie_3v3_pins_default: regulator-pcie-3v3-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x01a4, PIN_OUTPUT, 7)	/* PRG0_PRU0_GPO17.GPIO1_17 */
> +		>;
> +	};
> +
> +	regulator_vpp_1v8_pins_default: regulator-vpp-1v8-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x029c, PIN_OUTPUT, 7)	/* MMC1_SDWP.GPIO1_78 */
> +		>;
> +	};
> +
> +	rtc_int_pins_default: rtc-int-pins-default {
> +		pinctrl-single,pins = <
> +			/* external pull-up on Carrier */
> +			AM64X_IOPAD(0x00b4, PIN_INPUT, 7)	/* GPMC0_CSn3.GPIO0_44 */
> +		>;
> +	};
> +
> +	serdes_mux_pins_default: serdes-mux-pins-default {
> +		pinctrl-single,pins = <
> +			/* SEL, 10k pull-down on carrier, 2.2k pullup on SoM */
> +			AM64X_IOPAD(0x0200, PIN_OUTPUT, 7)	/* PRG0_MDIO0_MDIO.GPIO1_40 */
> +			/* EN */
> +			AM64X_IOPAD(0x0204, PIN_OUTPUT, 7)	/* PRG0_MDIO0_MDC.GPIO1_41 */
> +		>;
> +	};
> +};
> +
> +&main_uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart3_pins_default>;
> +	uart-has-rtscts;
> +	rs485-rts-active-low;
> +	linux,rs485-enabled-at-boot-time;
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	dr_mode = "host";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> new file mode 100644
> index 000000000000..83b73d433508
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
> @@ -0,0 +1,592 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
> + *
> + */
> +
> +#include <dt-bindings/net/ti-dp83869.h>
> +
> +/ {
> +	model = "SolidRun AM642 SoM";
> +	compatible = "solidrun,am642-sr-som", "ti,am642";
> +
> +	aliases {
> +		ethernet0 = &cpsw_port1;
> +		ethernet1 = &icssg1_emac0;
> +		ethernet2 = &icssg1_emac1;
> +		mmc0 = &sdhci0;
> +		mmc1 = &sdhci1;
> +		serial2 = &main_uart0;
> +	};
> +
> +	chosen {
> +		/* SoC default UART console */
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	/* PRU Ethernet Controller */
> +	ethernet {
> +		compatible = "ti,am642-icssg-prueth";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pru_rgmii1_pins_default>, <&pru_rgmii2_pins_default>;
> +
> +		sram = <&oc_sram>;
> +		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
> +		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
> +				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
> +
> +		/* configure internal pinmux for mii mode */
> +		ti,pruss-gp-mux-sel = <2>, <2>, <2>, <2>, <2>, <2>;
> +
> +		ti,mii-g-rt = <&icssg1_mii_g_rt>;
> +		ti,mii-rt = <&icssg1_mii_rt>;
> +		ti,iep = <&icssg1_iep0>, <&icssg1_iep1>;
> +
> +		/*
> +		 * Configure icssg interrupt controller to map pru-internal
> +		 * interrupts 8/9 via channels 0/1 to host interrupts 0/1.
> +		 *
> +		 * For details see interrupt controller documentation:
> +		 * Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
> +		 */
> +		interrupt-parent = <&icssg1_intc>;
> +		interrupts = <24 0 2>, <25 1 3>;
> +		interrupt-names = "tx_ts0", "tx_ts1";
> +
> +		dmas = <&main_pktdma 0xc200 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc201 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc202 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc203 15>, /* egress slice 0 */
> +		       <&main_pktdma 0xc204 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc205 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc206 15>, /* egress slice 1 */
> +		       <&main_pktdma 0xc207 15>, /* egress slice 1 */
> +		       <&main_pktdma 0x4200 15>, /* ingress slice 0 */
> +		       <&main_pktdma 0x4201 15>; /* ingress slice 1 */
> +		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
> +			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
> +			    "rx0", "rx1";
> +
> +		ethernet-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			icssg1_emac0: port@0 {
> +				reg = <0>;
> +				ti,syscon-rgmii-delay = <&main_conf 0x4110>;
> +				/* Filled in by bootloader */
> +				local-mac-address = [00 00 00 00 00 00];
> +				phy-handle = <&ethernet_phy2>;
> +				phy-mode = "rgmii-id";
> +			};
> +
> +			icssg1_emac1: port@1 {
> +				reg = <1>;
> +				ti,syscon-rgmii-delay = <&main_conf 0x4114>;
> +				/* Filled in by bootloader */
> +				local-mac-address = [00 00 00 00 00 00];
> +				phy-handle = <&ethernet_phy1>;
> +				phy-mode = "rgmii-id";
> +			};
> +		};
> +	};
> +
> +	/* DDR16SS0:
> +	 * - Bank 1 @ 0x080000000-0x0FFFFFFFF: max. 2GB in 32-bit address space
> +	 * - Bank 2 @ 0x880000000-0x9FFFFFFFF: max. 6GB in 64-bit address space
> +	 */
> +	memory@80000000 {
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> +		      <0x00000008 0x80000000 0x00000001 0x80000000>;
> +		device_type = "memory";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> +			no-map;
> +		};
> +
> +		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa0000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa0100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa1000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa1100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa2000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa2100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa3000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa3100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +	};
> +
> +	vdd_mmc0: regulator-vdd-mmc0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd-mmc0";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&cpsw3g {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii1_pins_default>;
> +};
> +
> +&cpsw3g_mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mdio0_pins_default>;
> +	status = "okay";
> +
> +	ethernet_phy0: ethernet-phy@0 {
> +		compatible = "ethernet-phy-id2000.a0f1";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ethernet_phy0_pins_default>;
> +		ti,clk-output-sel = <DP83869_CLK_O_SEL_REF_CLK>;
> +		ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>;
> +		/*
> +		 * Disable interrupts because ISR never clears 0x0040
> +		 *
> +		 * interrupt-parent = <&main_gpio1>;
> +		 * interrupts = <70 IRQ_TYPE_LEVEL_LOW>;
> +		 */
> +		/*
> +		 * Disable HW Reset because clock signal is daisy-chained
> +		 *
> +		 * reset-gpios = <&main_gpio0 84 GPIO_ACTIVE_LOW>;
> +		 * reset-assert-us = <1>;
> +		 * reset-deassert-us = <30>;
> +		 */
> +	};
> +};
> +
> +&cpsw_port1 {
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy0>;
> +};
> +
> +&cpsw_port2 {
> +	status = "disabled";
> +};
> +
> +&icssg1_mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pru1_mdio0_pins_default>;
> +	status = "okay";
> +
> +	ethernet_phy1: ethernet-phy@3 {
> +		compatible = "ethernet-phy-id2000.a0f1";
> +		reg = <3>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ethernet_phy1_pins_default>;
> +		ti,clk-output-sel = <DP83869_CLK_O_SEL_REF_CLK>;
> +		ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>;
> +		/*
> +		 * Disable interrupts because ISR never clears 0x0040
> +		 *
> +		 * interrupt-parent = <&main_gpio1>;
> +		 * interrupts = <70 IRQ_TYPE_LEVEL_LOW>;
> +		 */
> +		/*
> +		 * Disable HW Reset because clock signal is daisy-chained
> +		 *
> +		 * reset-gpios = <&main_gpio0 20 GPIO_ACTIVE_LOW>;
> +		 * reset-assert-us = <1>;
> +		 * reset-deassert-us = <30>;
> +		 */
> +	};
> +
> +	ethernet_phy2: ethernet-phy@f {
> +		compatible = "ethernet-phy-id2000.a0f1";
> +		reg = <0xf>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ethernet_phy2_pins_default>;
> +		ti,op-mode = <DP83869_RGMII_COPPER_ETHERNET>;
> +		/*
> +		 * Disable interrupts because ISR never clears 0x0040
> +		 *
> +		 * interrupt-parent = <&main_gpio1>;
> +		 * interrupts = <70 IRQ_TYPE_LEVEL_LOW>;
> +		 */
> +		/*
> +		 * Disable HW Reset because clock signal is daisy-chained
> +		 *
> +		 * reset-gpios = <&main_gpio0 52 GPIO_ACTIVE_LOW>;
> +		 * reset-assert-us = <1>;
> +		 * reset-deassert-us = <30>;
> +		 */
> +	};
> +};
> +
> +&mailbox0_cluster2 {
> +	status = "okay";
> +
> +	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
> +		ti,mbox-rx = <0 0 2>;
> +		ti,mbox-tx = <1 0 2>;
> +	};
> +
> +	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
> +		ti,mbox-rx = <2 0 2>;
> +		ti,mbox-tx = <3 0 2>;
> +	};
> +};
> +
> +&mailbox0_cluster4 {
> +	status = "okay";
> +
> +	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
> +		ti,mbox-rx = <0 0 2>;
> +		ti,mbox-tx = <1 0 2>;
> +	};
> +
> +	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
> +		ti,mbox-rx = <2 0 2>;
> +		ti,mbox-tx = <3 0 2>;
> +	};
> +};
> +
> +&main_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c0_pins_default>;
> +	status = "okay";
> +
> +	som_eeprom: eeprom@50 {
> +		compatible = "atmel,24c01";
> +		reg = <0x50>;
> +		pagesize = <8>;
> +	};
> +};
> +
> +&main_pmx0 {
> +	/* hog global functions */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ethernet_phy_pins_default>;
> +
> +	ethernet_phy_pins_default: ethernet-phy-pins-default {
> +		pinctrl-single,pins = <
> +			/* interrupt / power-down, external pull-up on SoM */
> +			AM64X_IOPAD(0x0278, PIN_INPUT, 7)	/* EXTINTn.GPIO1_70 */
> +		>;
> +	};
> +
> +	ethernet_phy0_pins_default: ethernet-phy0-pins-default {
> +		pinctrl-single,pins = <
> +			/* reset */
> +			AM64X_IOPAD(0x0154, PIN_OUTPUT, 7)	/* PRG1_PRU1_GPO19.GPIO0_84 */
> +			/* reference clock */
> +			AM64X_IOPAD(0x0274, PIN_OUTPUT, 5)	/* EXT_REFCLK1.CLKOUT0 */
> +		>;
> +	};
> +
> +	ethernet_phy1_pins_default: ethernet-phy1-pins-default {
> +		pinctrl-single,pins = <
> +			/* reset */
> +			AM64X_IOPAD(0x0150, PIN_OUTPUT, 7)	/* PRG1_PRU1_GPO18.GPIO0_20 */
> +			/* led0, external pull-down on SoM */
> +			AM64X_IOPAD(0x0128, PIN_INPUT, 7)	/* PRG1_PRU1_GPO8.GPIO0_73 */
> +			/* led1/rxer */
> +			AM64X_IOPAD(0x011c, PIN_INPUT, 7)	/* PRG1_PRU1_GPO5.GPIO0_70 */
> +		>;
> +	};
> +
> +	ethernet_phy2_pins_default: ethernet-phy2-pins-default {
> +		pinctrl-single,pins = <
> +			/* reset */
> +			AM64X_IOPAD(0x00d4, PIN_OUTPUT, 7)	/* PRG1_PRU0_GPO7.GPIO0_52 */
> +			/* led0, external pull-down on SoM */
> +			AM64X_IOPAD(0x00d8, PIN_INPUT, 7)	/* PRG1_PRU0_GPO8.GPIO0_53 */
> +			/* led1/rxer */
> +			AM64X_IOPAD(0x00cc, PIN_INPUT, 7)	/* PRG1_PRU0_GPO5.GPIO0_50 */
> +		>;
> +	};
> +
> +	main_i2c0_pins_default: main-i2c0-pins-default {
> +		pinctrl-single,pins = <
> +			/* external pull-up on SoM */
> +			AM64X_IOPAD(0x0260, PIN_INPUT, 0)	/* I2C0_SCL.I2C0_SCL */
> +			AM64X_IOPAD(0x0264, PIN_INPUT, 0)	/* I2C0_SDA.I2C0_SDA */
> +		>;
> +	};
> +
> +	/*
> +	 * main_mmc0_pins_default: main-mmc0-pins-default
> +	 *
> +	 * MMC0_CMD: no padconfig
> +	 * MMC0_CLK: no padconfig, external pull-up on SoM
> +	 * MMC0_DAT0: no padconfig
> +	 * MMC0_DAT1: no padconfig
> +	 * MMC0_DAT2: no padconfig
> +	 * MMC0_DAT3: no padconfig
> +	 * MMC0_DAT4: no padconfig
> +	 * MMC0_DAT5: no padconfig
> +	 * MMC0_DAT6: no padconfig
> +	 * MMC0_DAT7: no padconfig
> +	 * MMC0_DS: no padconfig, external pull-down on SoM
> +	 */
> +
> +	main_mmc1_pins_default: main-mmc1-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0294, PIN_INPUT_PULLUP, 0)	/* (J19) MMC1_CMD */
> +			AM64X_IOPAD(0x028c, PIN_INPUT, 0)		/* MMC1_CLK.MMC1_CLK */
> +			AM64X_IOPAD(0x0288, PIN_INPUT_PULLUP, 0)	/* MMC1_DAT0.MMC1_DAT0 */
> +			AM64X_IOPAD(0x0284, PIN_INPUT_PULLUP, 0)	/* MMC1_DAT1.MMC1_DAT1 */
> +			AM64X_IOPAD(0x0280, PIN_INPUT_PULLUP, 0)	/* MMC1_DAT2.MMC1_DAT2 */
> +			AM64X_IOPAD(0x027c, PIN_INPUT_PULLUP, 0)	/* MMC1_DAT3.MMC1_DAT3 */
> +			/* external pull-down on SoM & Carrier */
> +			AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0)	/* MMC1_SDCD.MMC1_SDCD */
> +			AM64X_IOPAD(0x0290, PIN_INPUT, 0)		/* MMC1_CLKLB: clock loopback */
> +		>;
> +	};
> +
> +	main_uart0_pins_default: main-uart0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0230, PIN_INPUT, 0)		/* UART0_RXD.UART0_RXD */
> +			AM64X_IOPAD(0x0234, PIN_OUTPUT, 0)		/* UART0_TXD.UART0_TXD */
> +		>;
> +	};
> +
> +	mdio0_pins_default: mdio0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4)		/* PRG0_PRU1_GPO19.MDIO0_MDC */
> +			AM64X_IOPAD(0x01f8, PIN_INPUT, 4)		/* PRG0_PRU1_GPO18.MDIO0_MDIO */
> +		>;
> +	};
> +
> +	ospi0_pins_default: ospi0-pins-default {
> +		pinctrl-single,pins = <
> +			/* external pull-down on SoM */
> +			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0)		/* OSPI0_CLK.OSPI0_CLK */
> +			AM64X_IOPAD(0x0008, PIN_OUTPUT, 0)		/* OSPI0_DQS.OSPI0_DQS */
> +			/* external pull-up on SoM */
> +			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0)		/* OSPI0_CSn0.OSPI0_CSn0 */
> +			AM64X_IOPAD(0x000c, PIN_INPUT, 0)		/* OSPI0_D0.OSPI0_D0 */
> +			AM64X_IOPAD(0x0010, PIN_INPUT, 0)		/* OSPI0_D1.OSPI0_D1 */
> +			AM64X_IOPAD(0x0014, PIN_INPUT, 0)		/* OSPI0_D2.OSPI0_D2 */
> +			AM64X_IOPAD(0x0018, PIN_INPUT, 0)		/* OSPI0_D3.OSPI0_D3 */
> +			AM64X_IOPAD(0x001c, PIN_INPUT, 0)		/* OSPI0_D4.OSPI0_D4 */
> +			AM64X_IOPAD(0x0020, PIN_INPUT, 0)		/* OSPI0_D5.OSPI0_D5 */
> +			AM64X_IOPAD(0x0024, PIN_INPUT, 0)		/* OSPI0_D6.OSPI0_D6 */
> +			AM64X_IOPAD(0x0028, PIN_INPUT, 0)		/* OSPI0_D7.OSPI0_D7 */
> +		>;
> +	};
> +
> +	ospi0_flash0_pins_default: ospi0-flash0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0034, PIN_OUTPUT, 7)		/* OSPI0_CSn2.GPIO0_13 */
> +			AM64X_IOPAD(0x0038, PIN_INPUT, 7)		/* OSPI0_CSn3.GPIO0_14 */
> +		>;
> +	};
> +
> +	pru1_mdio0_pins_default: pru1-mdio0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x015c, PIN_OUTPUT, 0)		/* PRG1_MDIO0_MDC.PRG1_MDIO0_MDC */
> +			AM64X_IOPAD(0x0158, PIN_INPUT, 0)		/* PRG1_MDIO0_MDIO.PRG1_MDIO0_MDIO */
> +		>;
> +	};
> +
> +	pru_rgmii1_pins_default: pru-rgmii1-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x00b8, PIN_INPUT, 2)		/* (Y7) PRG1_PRU0_GPO0.PRG1_RGMII1_RD0 */
> +			AM64X_IOPAD(0x00bc, PIN_INPUT, 2)		/* (U8) PRG1_PRU0_GPO1.PRG1_RGMII1_RD1 */
> +			AM64X_IOPAD(0x00c0, PIN_INPUT, 2)		/* (W8) PRG1_PRU0_GPO2.PRG1_RGMII1_RD2 */
> +			AM64X_IOPAD(0x00c4, PIN_INPUT, 2)		/* (V8) PRG1_PRU0_GPO3.PRG1_RGMII1_RD3 */
> +			AM64X_IOPAD(0x00d0, PIN_INPUT, 2)		/* (AA7) PRG1_PRU0_GPO6.PRG1_RGMII1_RXC */
> +			AM64X_IOPAD(0x00c8, PIN_INPUT, 2)		/* (Y8) PRG1_PRU0_GPO4.PRG1_RGMII1_RX_CTL */
> +			AM64X_IOPAD(0x00e4, PIN_OUTPUT, 2)		/* (AA8) PRG1_PRU0_GPO11.PRG1_RGMII1_TD0 */
> +			AM64X_IOPAD(0x00e8, PIN_OUTPUT, 2)		/* (U9) PRG1_PRU0_GPO12.PRG1_RGMII1_TD1 */
> +			AM64X_IOPAD(0x00ec, PIN_OUTPUT, 2)		/* (W9) PRG1_PRU0_GPO13.PRG1_RGMII1_TD2 */
> +			AM64X_IOPAD(0x00f0, PIN_OUTPUT, 2)		/* (AA9) PRG1_PRU0_GPO14.PRG1_RGMII1_TD3 */
> +			AM64X_IOPAD(0x00f8, PIN_INPUT, 2)		/* (V9) PRG1_PRU0_GPO16.PRG1_RGMII1_TXC */
> +			AM64X_IOPAD(0x00f4, PIN_OUTPUT, 2)		/* (Y9) PRG1_PRU0_GPO15.PRG1_RGMII1_TX_CTL */
> +		>;
> +	};
> +
> +	pru_rgmii2_pins_default: pru-rgmii2-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0108, PIN_INPUT, 2)		/* PRG1_PRU1_GPO0.RGMII2_RD0 */
> +			AM64X_IOPAD(0x010c, PIN_INPUT, 2)		/* PRG1_PRU1_GPO1.RGMII2_RD1 */
> +			AM64X_IOPAD(0x0110, PIN_INPUT, 2)		/* PRG1_PRU1_GPO2.RGMII2_RD2 */
> +			AM64X_IOPAD(0x0114, PIN_INPUT, 2)		/* PRG1_PRU1_GPO3.RGMII2_RD3 */
> +			AM64X_IOPAD(0x0120, PIN_INPUT, 2)		/* PRG1_PRU1_GPO6.RGMII2_RXC */
> +			AM64X_IOPAD(0x0118, PIN_INPUT, 2)		/* PRG1_PRU1_GPO4.RGMII2_RX_CTL */
> +			AM64X_IOPAD(0x0134, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO11.RGMII2_TD0 */
> +			AM64X_IOPAD(0x0138, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO12.RGMII2_TD1 */
> +			AM64X_IOPAD(0x013c, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO13.RGMII2_TD2 */
> +			AM64X_IOPAD(0x0140, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO14.RGMII2_TD3 */
> +			AM64X_IOPAD(0x0148, PIN_INPUT, 2)		/* PRG1_PRU1_GPO16.RGMII2_TXC */
> +			AM64X_IOPAD(0x0144, PIN_OUTPUT, 2)		/* PRG1_PRU1_GPO15.RGMII2_TX_CTL */
> +		>;
> +	};
> +
> +	rgmii1_pins_default: rgmii1-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x01cc, PIN_INPUT, 4)		/* PRG0_PRU1_GPO7.RGMII1_RD0 */
> +			AM64X_IOPAD(0x01d4, PIN_INPUT, 4)		/* PRG0_PRU1_GPO9.RGMII1_RD1 */
> +			AM64X_IOPAD(0x01d8, PIN_INPUT, 4)		/* PRG0_PRU1_GPO10.RGMII1_RD2 */
> +			AM64X_IOPAD(0x01f4, PIN_INPUT, 4)		/* PRG0_PRU1_GPO17.RGMII1_RD3 */
> +			AM64X_IOPAD(0x0188, PIN_INPUT, 4)		/* PRG0_PRU0_GPO10.RGMII1_RXC */
> +			AM64X_IOPAD(0x0184, PIN_INPUT, 4)		/* PRG0_PRU0_GPO9.RGMII1_RX_CTL */
> +			AM64X_IOPAD(0x0124, PIN_OUTPUT, 4)		/* PRG1_PRU1_GPO7.RGMII1_TD0 */
> +			AM64X_IOPAD(0x012c, PIN_OUTPUT, 4)		/* PRG1_PRU1_GPO9.RGMII1_TD1 */
> +			AM64X_IOPAD(0x0130, PIN_OUTPUT, 4)		/* PRG1_PRU1_GPO10.RGMII1_TD2 */
> +			AM64X_IOPAD(0x014c, PIN_OUTPUT, 4)		/* PRG1_PRU1_GPO17.RGMII1_TD3 */
> +			AM64X_IOPAD(0x00e0, PIN_INPUT, 4)		/* PRG1_PRU0_GPO10.RGMII1_TXC */
> +			AM64X_IOPAD(0x00dc, PIN_OUTPUT, 4)		/* PRG1_PRU0_GPO9.RGMII1_TX_CTL */
> +		>;
> +	};
> +
> +	usb0_pins_default: usb0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0)		/* USB0_DRVVBUS.USB0_DRVVBUS */
> +		>;
> +	};
> +};
> +
> +&main_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
> +	memory-region = <&main_r5fss0_core0_dma_memory_region>,
> +			<&main_r5fss0_core0_memory_region>;
> +};
> +
> +&main_r5fss0_core1 {
> +	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
> +	memory-region = <&main_r5fss0_core1_dma_memory_region>,
> +			<&main_r5fss0_core1_memory_region>;
> +};
> +
> +&main_r5fss1_core0 {
> +	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
> +	memory-region = <&main_r5fss1_core0_dma_memory_region>,
> +			<&main_r5fss1_core0_memory_region>;
> +};
> +
> +&main_r5fss1_core1 {
> +	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
> +	memory-region = <&main_r5fss1_core1_dma_memory_region>,
> +			<&main_r5fss1_core1_memory_region>;
> +};
> +
> +/* SoC default UART console */
> +&main_uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart0_pins_default>;
> +	status = "okay";
> +};
> +
> +&ospi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ospi0_pins_default>;
> +	num-cs = <1>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ospi0_flash0_pins_default>;
> +		spi-tx-bus-width = <8>;
> +		spi-rx-bus-width = <8>;
> +		spi-max-frequency = <200000000>;
> +		cdns,tshsl-ns = <50>;
> +		cdns,tsd2d-ns = <50>;
> +		cdns,tchsh-ns = <4>;
> +		cdns,tslch-ns = <4>;
> +		cdns,read-delay = <0>;
> +		interrupt-parent = <&main_gpio0>;
> +		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios = <&main_gpio0 13 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&sdhci0 {

These sdhci* nodes are disabled by default, you might
want to status = "okay" here. Rule of thumb is if you
needed to add info to the node here in the board file
it probably needs to be enabled here too.

Otherwise LGTM,

Reviewed-by: Andrew Davis <afd@ti.com>

> +	/* mmc0 pins have no padconfig */
> +	bus-width = <8>;
> +	ti,driver-strength-ohm = <50>;
> +	disable-wp;
> +	non-removable;
> +	cap-mmc-hw-reset;
> +	no-sd;
> +	/*
> +	 * MMC controller supports switching between 1.8V and 3.3V signalling.
> +	 * However MMC0 (unlike MMC1) does not integrate an LDO.
> +	 * Explicitly link a regulator node for indicating to the driver which
> +	 * voltages are actually usable.
> +	 */
> +	vqmmc-supply = <&vdd_mmc0>;
> +};
> +
> +/*
> + * microSD is on carrier - however since SoC can boot from it,
> + * configure it just in case.
> + */
> +&sdhci1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mmc1_pins_default>;
> +	bus-width = <4>;
> +	ti,driver-strength-ohm = <50>;
> +	disable-wp;
> +};
> +
> +/*
> + * USB settings are a carrier choice - however since SoC can boot from it,
> + * configure as USB-2.0 OTG here, keeping USB-3 serdes disabled.
> + */
> +&usb0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_pins_default>;
> +	dr_mode = "otg";
> +	maximum-speed = "high-speed";
> +};
> +
> +&usbss0 {
> +	ti,vbus-divider;
> +	ti,usb2-only;
> +};
> 

