Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C8A7AC9DA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjIXNvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjIXNvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:51:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE176AF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 06:51:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACB7C433C8;
        Sun, 24 Sep 2023 13:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695563489;
        bh=RxXeubu8HZNb+nNC5zpYLJUpzwqwfPy3at7NtESJSvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gHuDTISvBx1UwPZrt2pnXtQ+Ln0jEuukUEt4MEcRcP3YiwbpPNndfGzzxeRgwQrXJ
         7vy40Mj858jlRD3CxlMfHFNrX+BfnMf2XhleP31nRUnHwa62RM2z4HDSYojY4dHsCs
         dTSZQdRbW16cBTUBdyvbEEr7J95nYtKaLsiT7Cns6BvGBeALntv//YSax18bpwNcln
         +Mupy9TOv6tRgiZijESVJKJS+T427sneRwd5xFyeDSyxUY3Uvld1D877ar1rjp3xYp
         Vf2eVJdqvV9urb3jPyqMAVUiuVMbLgx90ZRZeUR2oYY/oyhnPwKgADAcSVbH0Xy0Hu
         3dIN4FmNHl3Qw==
Date:   Sun, 24 Sep 2023 21:51:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Josua Mayer <josua@solid-run.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marek Vasut <marex@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v5 4/4] arm64: dts: freescale: Add support for LX2162 SoM
 & Clearfog Board
Message-ID: <20230924135111.GJ7231@dragon>
References: <20230818111016.11271-1-josua@solid-run.com>
 <20230818111016.11271-5-josua@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818111016.11271-5-josua@solid-run.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 01:10:16PM +0200, Josua Mayer wrote:
> Add support for the SolidRun LX2162A System on Module (SoM), and the
> Clearfog evaluation board.
> 
> The SoM has few software-controllable features:
> - AR8035 Ethernet PHY
> - eMMC
> - SPI Flash
> - fan controller
> - various eeproms
> 
> The Clearfog evaluation board provides:
> - microSD connector
> - USB-A
> - 2x 10Gbps SFP+
> - 2x 25Gbps SFP+ with a retimer
> - 8x 2.5Gbps RJ45
> - 2x mPCI (assembly option / disables 2xRJ45)
> 
> The 8x RJ45 ports are connected with an 8-port PHY: Marvell 88E2580
> supporting up to 5Gbps, while SoC and magnetics are limited to 2.5Gbps.
> 
> However 2500 speed is untested due to documentation and drivier
> limitations. To avoid confusion the phy nodes have been explicitly
> limited to 1000 for now.
> 
> The PCI nodes are disabled, but explicitly added to mark that this board
> can have pci.
> It is expected that the bootloader will patch the status property
> "okay" and disable 2x RJ45 ports, according to active serdes configuration.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> V1 -> V2: reordered "compatible" and "reg" properties
> V1 -> V2: replaced chip-specific DT node names with generic ones
> V1 -> V2: removed dead code from fspi node
> V2 -> V3: dropped deprecated address-cells, address-size props from flash node
> V3 -> V4: reordered dt properties such that status is last
> V3 -> V4: changed ethernet-phy on som from /delete-node/ to disabled
> 
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/fsl-lx2162a-clearfog.dts    | 373 ++++++++++++++++++
>  .../dts/freescale/fsl-lx2162a-sr-som.dtsi     |  73 ++++
>  3 files changed, 447 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index a750be13ace8..9448d2effd8a 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -34,6 +34,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-honeycomb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-clearfog.dtb

Out of alphabetical order.

>  
>  fsl-ls1028a-qds-13bb-dtbs := fsl-ls1028a-qds.dtb fsl-ls1028a-qds-13bb.dtbo
>  fsl-ls1028a-qds-65bb-dtbs := fsl-ls1028a-qds.dtb fsl-ls1028a-qds-65bb.dtbo
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
> new file mode 100644
> index 000000000000..ad57f4cca62d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
> @@ -0,0 +1,373 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree file for LX2162A Clearfog
> +//
> +// Copyright 2023 Josua Mayer <josua@solid-run.com>
> +
> +/dts-v1/;
> +
> +#include "fsl-lx2160a.dtsi"
> +#include "fsl-lx2162a-sr-som.dtsi"
> +
> +/ {
> +	model = "SolidRun LX2162A Clearfog";
> +	compatible = "solidrun,lx2162a-clearfog", "solidrun,lx2162a-som", "fsl,lx2160a";
> +
> +	aliases {
> +		crypto = &crypto;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c2;
> +		i2c2 = &i2c4;
> +		i2c3 = &sfp_i2c0;
> +		i2c4 = &sfp_i2c1;
> +		i2c5 = &sfp_i2c2;
> +		i2c6 = &sfp_i2c3;
> +		i2c7 = &mpcie1_i2c;
> +		i2c8 = &mpcie0_i2c;
> +		i2c9 = &pcieclk_i2c;
> +		mmc0 = &esdhc0;
> +		mmc1 = &esdhc1;
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
> +		led_sfp_at: led-sfp-at {
> +			gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* PROC_IRQ5 */
> +			default-state = "off";
> +		};

Have a newline between nodes.

> +		led_sfp_ab: led-sfp-ab {
> +			gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>; /* PROC_IRQ11 */
> +			default-state = "off";
> +		};
> +		led_sfp_bt: led-sfp-bt {
> +			gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>; /* EVT1_B */
> +			default-state = "off";
> +		};
> +		led_sfp_bb: led-sfp-bb {
> +			gpios = <&gpio2 14 GPIO_ACTIVE_HIGH>; /* EVT2_B */
> +			default-state = "off";
> +		};
> +	};
> +
> +	sfp_at: sfp-at {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&sfp_i2c0>;
> +		mod-def0-gpios = <&gpio2 16 GPIO_ACTIVE_LOW>; /* EVT4_B */
> +		maximum-power-milliwatt = <2000>;
> +	};
> +
> +	sfp_ab: sfp-ab {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&sfp_i2c1>;
> +		mod-def0-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>; /* PROC_IRQ1 */
> +		maximum-power-milliwatt = <2000>;
> +	};
> +
> +	sfp_bt: sfp-bt {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&sfp_i2c2>;
> +		mod-def0-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>; /* PROC_IRQ10 */
> +		maximum-power-milliwatt = <2000>;
> +	};
> +
> +	sfp_bb: sfp-bb {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&sfp_i2c3>;
> +		mod-def0-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>; /* EVT3_B */
> +		maximum-power-milliwatt = <2000>;
> +	};
> +};
> +
> +&i2c2 {

This label node seems out of alphabetical order.

> +	status = "okay";
> +
> +	/* retimer@18 */
> +
> +	i2c-mux@70 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x70>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		sfp_i2c0: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +
> +		sfp_i2c1: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +
> +		sfp_i2c2: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +
> +		sfp_i2c3: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +	};
> +
> +	i2c-mux@71 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x71>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		mpcie1_i2c: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +
> +		mpcie0_i2c: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +
> +		pcieclk_i2c: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +
> +			/* clock-controller@6b */
> +		};
> +	};
> +};
> +
> +&dpmac3 {
> +	sfp = <&sfp_at>;
> +	managed = "in-band-status";
> +	phys = <&serdes_1 7>;
> +};
> +
> +&dpmac4 {
> +	sfp = <&sfp_ab>;
> +	managed = "in-band-status";
> +	phys = <&serdes_1 6>;
> +};
> +
> +&dpmac5 {
> +	sfp = <&sfp_bt>;
> +	managed = "in-band-status";
> +	phys = <&serdes_1 5>;
> +};
> +
> +&dpmac6 {
> +	sfp = <&sfp_bb>;
> +	managed = "in-band-status";
> +	phys = <&serdes_1 4>;
> +};
> +
> +&dpmac11 {
> +	phys = <&serdes_2 0>;
> +	phy-handle = <&ethernet_phy3>;
> +	phy-connection-type = "sgmii";
> +	status = "okay";
> +};
> +
> +&dpmac12 {
> +	phys = <&serdes_2 1>;
> +	phy-handle = <&ethernet_phy1>;
> +	phy-connection-type = "sgmii";
> +	status = "okay";
> +};
> +
> +&dpmac13 {
> +	phys = <&serdes_2 6>;
> +	phy-handle = <&ethernet_phy6>;
> +	phy-connection-type = "sgmii";
> +	status = "okay";
> +};
> +
> +&dpmac14 {
> +	phys = <&serdes_2 7>;
> +	phy-handle = <&ethernet_phy8>;
> +	phy-connection-type = "sgmii";
> +	status = "okay";
> +};
> +
> +&dpmac15 {
> +	phys = <&serdes_2 4>;
> +	phy-handle = <&ethernet_phy4>;
> +	phy-connection-type = "sgmii";
> +	status = "okay";
> +};
> +
> +&dpmac16 {
> +	phys = <&serdes_2 5>;
> +	phy-handle = <&ethernet_phy2>;
> +	phy-connection-type = "sgmii";
> +	status = "okay";
> +};
> +
> +&dpmac17 {
> +	/* override connection to on-SoM phy */
> +	/delete-property/ phy-handle;
> +	/delete-property/ phy-connection-type;
> +
> +	phys = <&serdes_2 2>;
> +	phy-handle = <&ethernet_phy5>;
> +	phy-connection-type = "sgmii";
> +	status = "okay";
> +};
> +
> +&dpmac18 {
> +	phys = <&serdes_2 3>;
> +	phy-handle = <&ethernet_phy7>;
> +	phy-connection-type = "sgmii";
> +	status = "okay";
> +};
> +
> +&emdio1 {
> +	ethernet_phy1: ethernet-phy@8 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		reg = <8>;
> +		max-speed = <1000>;
> +	};
> +
> +	ethernet_phy2: ethernet-phy@9 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		reg = <9>;
> +		max-speed = <1000>;
> +	};
> +
> +	ethernet_phy3: ethernet-phy@10 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		reg = <10>;
> +		max-speed = <1000>;
> +	};
> +
> +	ethernet_phy4: ethernet-phy@11 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		reg = <11>;
> +		max-speed = <1000>;
> +	};
> +
> +	ethernet_phy5: ethernet-phy@12 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		reg = <12>;
> +		max-speed = <1000>;
> +	};
> +
> +	ethernet_phy6: ethernet-phy@13 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		reg = <13>;
> +		max-speed = <1000>;
> +	};
> +
> +	ethernet_phy7: ethernet-phy@14 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		reg = <14>;
> +		max-speed = <1000>;
> +	};
> +
> +	ethernet_phy8: ethernet-phy@15 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		reg = <15>;
> +		max-speed = <1000>;
> +	};
> +};
> +
> +&esdhc0 {
> +	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr12;
> +	status = "okay";
> +};
> +
> +&ethernet_phy0 {
> +	/*
> +	 * SoM has a phy at address 1 connected to SoC Ethernet Controller 1.
> +	 * It competes for WRIOP MAC17, and no connector has been wired.
> +	 */
> +	status = "disabled";
> +};
> +
> +&pcie3 {
> +	status = "disabled";
> +};
> +
> +&pcie4 {
> +	status = "disabled";
> +};
> +
> +&pcs_mdio3 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio4 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio5 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio6 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio11 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio12 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio13 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio14 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio15 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio16 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio17 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio18 {
> +	status = "okay";
> +};
> +
> +&serdes_1 {
> +	status = "okay";
> +};
> +
> +&serdes_2 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
> new file mode 100644
> index 000000000000..ac3f9bc60265
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree file for LX2162A-SOM
> +//
> +// Copyright 2021 Rabeeh Khoury <rabeeh@solid-run.com>
> +// Copyright 2023 Josua Mayer <josua@solid-run.com>
> +
> +&crypto {
> +	status = "okay";
> +};
> +
> +&dpmac17 {
> +	phy-handle = <&ethernet_phy0>;
> +	phy-connection-type = "rgmii-id";
> +};
> +
> +&emdio1 {
> +	status = "okay";
> +
> +	ethernet_phy0: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +};
> +
> +&esdhc1 {
> +	status = "okay";
> +	bus-width = <8>;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;

We usually have 'status' be the last property.

Shawn

> +};
> +
> +&fspi {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		m25p,fast-read;
> +		spi-max-frequency = <50000000>;
> +		/* The following setting enables 1-1-8 (CMD-ADDR-DATA) mode */
> +		spi-rx-bus-width = <8>;
> +		spi-tx-bus-width = <1>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	fan-controller@18 {
> +		compatible = "ti,amc6821";
> +		reg = <0x18>;
> +	};
> +
> +	ddr_spd: eeprom@51 {
> +		compatible = "st,24c02", "atmel,24c02";
> +		reg = <0x51>;
> +		read-only;
> +	};
> +
> +	config_eeprom: eeprom@57 {
> +		compatible = "st,24c02", "atmel,24c02";
> +		reg = <0x57>;
> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +
> +	variable_eeprom: eeprom@54 {
> +		compatible = "st,24c2048", "atmel,24c2048";
> +		reg = <0x54>;
> +	};
> +};
> -- 
> 2.35.3
> 
