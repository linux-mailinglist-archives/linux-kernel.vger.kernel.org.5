Return-Path: <linux-kernel+bounces-160045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736CF8B3841
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B86A283EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2872E1474AF;
	Fri, 26 Apr 2024 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zPeqWAJg"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2CE824B3;
	Fri, 26 Apr 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137788; cv=none; b=k/bI6iG7DyDshhLliTxx0SkCtZOO7ByxXBT/TKigocuDgfW79ZDH8LfjSnjE5O8jqAN/GwLMiKclkR/hr+GzlDxNR2kynO1ToOBHVePxrxPsdYs9vVyv16KULust4/0aWHJCVmoEnVwIFaNEH7omzp98PwPruatR4SyaxY4T2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137788; c=relaxed/simple;
	bh=Cl9NW7oML0g58ahEk1LK0RkW9f4fod9Lg6NgycD8gxQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM+kUrYqX/XuQQIFfIgS2TxgOGF4Lvsi1oixi4RQ8dZQ9iNGT2b7pG5gFz86cp3dMyYo9QagZgmOIV48YjZv9fGvb5z96K5U2FDICuHCAa6zPMxgrtZ42fZ6jMa+Bq5BDmjubGujqjdk2GClXh7bfigPbg3hJZS2wDfYceentJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zPeqWAJg; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QDMwYJ055233;
	Fri, 26 Apr 2024 08:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714137778;
	bh=A4zfzGA/NXNlIf1cfElMKm2V644iTJ/IQl+LROo5Wwo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=zPeqWAJg0mSR6DlhFFI4qOPhss5D/VfpsjemJLAJGkPQHuxQ+K9DFP95iDUAX6YDF
	 50lkSo+EKplOVJAtecWVyZbqIFln7qMK78mKyp94gDIKcNmBZQ9FOE7Es++Aawhxhz
	 FF7Z/0QZbKaqUFgHEu2TnSODfERBes796VsacMMM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QDMw7V119497
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 08:22:58 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 08:22:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 08:22:58 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QDMwh0032811;
	Fri, 26 Apr 2024 08:22:58 -0500
Date: Fri, 26 Apr 2024 08:22:58 -0500
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Andrew Davis <afd@ti.com>,
        Jared McArthur
	<j-mcarthur@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Deepak Khatri
	<lorforlinux@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
Message-ID: <20240426132258.oe5kif4yoca2yujh@jaunt>
References: <20240425162829.2370614-1-robertcnelson@gmail.com>
 <20240425162829.2370614-2-robertcnelson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240425162829.2370614-2-robertcnelson@gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 11:28-20240425, Robert Nelson wrote:
> BeagleBoard.org BeagleY-AI is an easy to use, affordable open source
> hardware single board computer based on the Texas Instruments AM67A,
> which features a quad-core 64-bit Arm CPU subsystem, 2 general-purpose
> digital-signal-processors (DSP) and matrix-multiply-accelerators (MMA),
> GPU, vision and deep learning accelerators, and multiple Arm Cortex-R5
> cores for low-power, low-latency GPIO control.
> 
> https://beagley-ai.org/
> https://openbeagle.org/beagley-ai/beagley-ai
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Andrew Davis <afd@ti.com>
> CC: Nishanth Menon <nm@ti.com>
> CC: Jared McArthur <j-mcarthur@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Deepak Khatri <lorforlinux@beagleboard.org>
> CC: Drew Fustini <drew@beagleboard.org>
> ---

A few cosmetic comments to fix up for the next rev:

> Changes since v1:
>  - fixed incorrect vdd-3v3-sd-pins-default name
>  - updated hdmi VDD_1V2 regulator for production pcb
>  - switched device tree name from k3-j722s-beagley-ai to k3-am67a-beagley-ai
>  - removed cpsw_port2 node
>  - enable UHS support for MMCSD
> ---
>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>  .../arm64/boot/dts/ti/k3-am67a-beagley-ai.dts | 369 ++++++++++++++++++
>  2 files changed, 370 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 9a722c2473fb..a61e8902a23d 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -95,6 +95,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
>  
>  # Boards with J722s SoC
> +dtb-$(CONFIG_ARCH_K3) += k3-am67a-beagley-ai.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
>  
>  # Boards with J784s4 SoC
> diff --git a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
> new file mode 100644
> index 000000000000..cffa1c9ba00d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
> @@ -0,0 +1,369 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * https://beagley-ai.org/
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2024 Robert Nelson, BeagleBoard.org Foundation
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/net/ti-dp83867.h>
> +#include "k3-j722s.dtsi"
> +
> +/ {
> +	compatible = "beagle,am67a-beagley-ai", "ti,j722s";
> +	model = "BeagleBoard.org BeagleY-AI";
> +
> +	aliases {
> +		serial0 = &wkup_uart0;
> +		serial2 = &main_uart0;
> +		mmc0 = &sdhci1;
> +	};
> +
> +	chosen {
> +		stdout-path = &main_uart0;
> +	};
> +
> +	memory@80000000 {
> +		/* 4G RAM */
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> +		      <0x00000008 0x80000000 0x00000000 0x80000000>;
> +		device_type = "memory";
> +		bootph-pre-ram;
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_tfa_ddr: tfa@9e780000 {
> +			reg = <0x00 0x9e780000 0x00 0x80000>;
> +			no-map;
> +		};
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_memory_region: r5f-memory@a0100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa0100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +	};
> +
> +	vsys_5v0: regulator-1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		bootph-all;
> +	};
> +
> +	vdd_3v3: regulator-2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vsys_5v0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vdd_mmc1: regulator-mmc1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_mmc1";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_3v3_sd_pins_default>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpio = <&main_gpio1 50 GPIO_ACTIVE_HIGH>;
> +		bootph-all;
> +	};
> +
> +	vdd_sd_dv: regulator-TLV71033 {
> +		compatible = "regulator-gpio";
> +		regulator-name = "tlv71033";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_sd_dv_pins_default>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		vin-supply = <&vsys_5v0>;
> +		gpios = <&main_gpio1 49 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0>,
> +			 <3300000 0x1>;

you will need bootph-all; here.

> +	};
> +
> +	vsys_io_1v8: regulator-vsys-io-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_io_1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_io_1v2: regulator-vsys-io-1v2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_io_1v2";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&main_pmx0 {
> +
> +	main_i2c0_pins_default: main-i2c0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (D23) I2C0_SCL */
> +			J722S_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (B22) I2C0_SDA */
> +		>;
> +		bootph-all;
> +	};
> +
> +	main_uart0_pins_default: main-uart0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x01c8, PIN_INPUT, 0)	/* (A22) UART0_RXD */
> +			J722S_IOPAD(0x01cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
> +		>;
> +		bootph-all;
> +	};
> +
> +	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x0244, PIN_OUTPUT, 7) /* (A24) MMC1_SDWP.GPIO1_49 */
> +		>;
> +		bootph-all;
> +	};
> +
> +	main_mmc1_pins_default: main-mmc1-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x023c, PIN_INPUT, 0) /* (H22) MMC1_CMD */
> +			J722S_IOPAD(0x0234, PIN_OUTPUT, 0) /* (H24) MMC1_CLK */
> +			J722S_IOPAD(0x0230, PIN_INPUT, 0) /* (H23) MMC1_DAT0 */
> +			J722S_IOPAD(0x022c, PIN_INPUT_PULLUP, 0) /* (H20) MMC1_DAT1 */
> +			J722S_IOPAD(0x0228, PIN_INPUT_PULLUP, 0) /* (J23) MMC1_DAT2 */
> +			J722S_IOPAD(0x0224, PIN_INPUT_PULLUP, 0) /* (H25) MMC1_DAT3 */
> +			J722S_IOPAD(0x0240, PIN_INPUT, 0) /* (B24) MMC1_SDCD */

I suggest using GPIO mode 7 here. (and see below):
		J722S_IOPAD(0x0240, PIN_INPUT, 7) /* (B24) MMC1_SDCD */

you can optionally enable debounce as well if that is useful.

> +		>;
> +		bootph-all;
> +	};
> +
> +	mdio_pins_default: mdio-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AC24) MDIO0_MDC */
> +			J722S_IOPAD(0x015c, PIN_INPUT, 0) /* (AD25) MDIO0_MDIO */
> +		>;
> +	};
> +
> +	rgmii1_pins_default: rgmii1-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x014c, PIN_INPUT, 0) /* (AC25) RGMII1_RD0 */
> +			J722S_IOPAD(0x0150, PIN_INPUT, 0) /* (AD27) RGMII1_RD1 */
> +			J722S_IOPAD(0x0154, PIN_INPUT, 0) /* (AE24) RGMII1_RD2 */
> +			J722S_IOPAD(0x0158, PIN_INPUT, 0) /* (AE26) RGMII1_RD3 */
> +			J722S_IOPAD(0x0148, PIN_INPUT, 0) /* (AE27) RGMII1_RXC */
> +			J722S_IOPAD(0x0144, PIN_INPUT, 0) /* (AD23) RGMII1_RX_CTL */
> +			J722S_IOPAD(0x0134, PIN_OUTPUT, 0) /* (AF27) RGMII1_TD0 */
> +			J722S_IOPAD(0x0138, PIN_OUTPUT, 0) /* (AE23) RGMII1_TD1 */
> +			J722S_IOPAD(0x013c, PIN_OUTPUT, 0) /* (AG25) RGMII1_TD2 */
> +			J722S_IOPAD(0x0140, PIN_OUTPUT, 0) /* (AF24) RGMII1_TD3 */
> +			J722S_IOPAD(0x0130, PIN_OUTPUT, 0) /* (AG26) RGMII1_TXC */
> +			J722S_IOPAD(0x012c, PIN_OUTPUT, 0) /* (AF25) RGMII1_TX_CTL */
> +		>;
> +	};
> +
> +	pmic_irq_pins_default: pmic-irq-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x01f4, PIN_INPUT_PULLUP, 0) /* (B23) EXTINTn */
> +		>;
> +	};
> +
> +	vdd_3v3_sd_pins_default: vdd-3v3-sd-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x0254, PIN_OUTPUT, 7) /* (E25) USB0_DRVVBUS.GPIO1_50 */
> +		>;
> +	};
> +};
> +
> +&cpsw3g {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii1_pins_default>, <&gbe_pmx_obsclk>;
> +
> +	assigned-clocks = <&k3_clks 227 0>;
> +	assigned-clock-parents = <&k3_clks 227 6>;

Here and elsewhere: status is last in the list. Please follow the
recommendations in:

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

> +};
> +
> +&cpsw3g_mdio {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mdio_pins_default>;

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

> +
> +	cpsw3g_phy0: ethernet-phy@0 {
> +		reg = <0>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,min-output-impedance;
> +	};
> +};
> +
> +&cpsw_port1 {
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&cpsw3g_phy0>;
> +	status = "okay";
> +};
> +
> +&main_gpio1 {
> +	status = "okay";
> +};
> +
> +&main_uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart0_pins_default>;
> +	status = "okay";
> +	bootph-all;

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

> +};
> +
> +&mcu_pmx0 {
> +
> +	wkup_uart0_pins_default: wkup-uart0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C7) WKUP_UART0_CTSn */
> +			J722S_MCU_IOPAD(0x030, PIN_OUTPUT, 0)	/* (C6) WKUP_UART0_RTSn */
> +			J722S_MCU_IOPAD(0x024, PIN_INPUT, 0)	/* (D8) WKUP_UART0_RXD */
> +			J722S_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (D7) WKUP_UART0_TXD */
> +		>;
> +		bootph-all;
> +	};
> +
> +	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_MCU_IOPAD(0x04c, PIN_INPUT_PULLUP, 0)	/* (C7) WKUP_I2C0_SCL */
> +			J722S_MCU_IOPAD(0x050, PIN_INPUT_PULLUP, 0)	/* (C6) WKUP_I2C1_SDA */
> +		>;
> +		bootph-all;
> +	};
> +
> +	gbe_pmx_obsclk: gbe-pmx-obsclk-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_MCU_IOPAD(0x0004, PIN_OUTPUT, 1) /* (A10) MCU_SPI0_CS1.MCU_OBSCLK0 */
> +		>;
> +	};
> +};
> +
> +&wkup_uart0 {
> +	/* WKUP UART0 is used by Device Manager firmware */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_uart0_pins_default>;
> +	status = "reserved";
> +	bootph-all;

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

> +};
> +
> +&wkup_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +	bootph-all;

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

> +
> +	tps65219: pmic@30 {
> +		bootph-all;
https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

> +		compatible = "ti,tps65219";
> +		reg = <0x30>;
> +		buck1-supply = <&vsys_5v0>;
> +		buck2-supply = <&vsys_5v0>;
> +		buck3-supply = <&vsys_5v0>;
> +		ldo1-supply = <&vdd_3v3>;
> +		ldo3-supply = <&vdd_3v3>;
> +		ldo4-supply = <&vdd_3v3>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_irq_pins_default>;
> +		interrupt-parent = <&gic500>;
> +		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		system-power-controller;
> +		ti,power-button;
> +
> +		regulators {
> +			buck1_reg: buck1 {
> +				regulator-name = "VDD_3V3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck2_reg: buck2 {
> +				regulator-name = "VDD_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck3_reg: buck3 {
> +				/* Regulator is left as is unused */
> +			};
> +
> +			ldo1_reg: ldo1 {
> +				regulator-name = "VDDSHV5_SDIO";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-allow-bypass;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2_reg: ldo2 {
> +				regulator-name = "VDD_1V2";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3_reg: ldo3 {
> +				regulator-name = "VDDA_PHY_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4_reg: ldo4 {
> +				regulator-name = "VDDA_PLL_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&sdhci1 {
> +	/* SD/MMC */
> +	vmmc-supply = <&vdd_mmc1>;
> +	vqmmc-supply = <&vdd_sd_dv>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mmc1_pins_default>;
> +	ti,driver-strength-ohm = <50>;
> +	disable-wp;
> +	status = "okay";
> +	bootph-all;
https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

Also add:
cd-gpios = <&main_gpio1 48 GPIO_ACTIVE_LOW>;
cd-debounce-delay-ms = <100>;
ti,fails-without-test-cd;

With this, you will actually have runtime PM working properly for SD
card while booting off some other interface (e.g. nvme or others) and
card detect will work since GPIO based wake sequence will still be
valid.

> +};
> -- 
> 2.39.2
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

