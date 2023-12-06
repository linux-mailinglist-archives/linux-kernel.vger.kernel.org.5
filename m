Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C65806501
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjLFCeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFCee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:34:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D21183
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 18:34:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D35CC433C9;
        Wed,  6 Dec 2023 02:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701830080;
        bh=eOtQBTM2Kdc45YATziQT3LPLtwtktPj5VY0qE5Ruwhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmYFJqQx/qEisY6e11GQdJZaukYCvcCQCfU4gxLBiEaP7InDlhd2o60gwEr2hHbl8
         hMXMrJVensJMMsoji+W5gk1dk+tKRDWvFNNcCxENeJuv53iNwfIMHpqQSQ6gPv03Bv
         +YlzRzc7LOy1X9porIS7GUReo9onkFLA2QwbmqVvArHUTDD+n/2NDwKZCueHdoasnA
         5tkyqQ0vtZMVUR+fB9+Iz0x/ta38Dj5hxj+6T/0XcP2XredJay9FOi+ruq2u8uY21x
         94N9hDPeG6x5XKxKNCp7KSTZKz11G235R19ScA954YQ5X3LN5pD2Ts1AnGbLc80HRr
         A6hHj/wVkm58Q==
Date:   Wed, 6 Dec 2023 10:34:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 01/14] arm64: dts: imx8mm-kontron: Add support for
 display bridges on BL i.MX8MM
Message-ID: <20231206023434.GL236001@dragon>
References: <20231130161657.556483-1-frieder@fris.de>
 <20231130161657.556483-2-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130161657.556483-2-frieder@fris.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 05:16:01PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The Kontron Electronics BL i.MX8MM has oboard disply bridges for
> DSI->HDMI and DSI->LVDS conversion. The DSI interface is muxed by
> a GPIO-controlled switch to one of these two bridges.
> 
> By default the HDMI bridge is enabled. The LVDS bridge can be
> selected by loading an additional (panel-specific) overlay.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Changes for v2:
> * Rework DSI mux GPIO logic to be compatible with overlay
> * Switch from 4 to 2 DSI lanes for LVDS bridge to fix non-working display
> ---
>  .../boot/dts/freescale/imx8mm-kontron-bl.dts  | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
> index dcec57c20399e..0fb16b811461e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
> @@ -25,6 +25,17 @@ osc_can: clock-osc-can {
>  		clock-output-names = "osc-can";
>  	};
>  
> +	hdmi-out {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_in_conn: endpoint {
> +				remote-endpoint = <&bridge_out_conn>;
> +			};
> +		};
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  		pinctrl-names = "default";
> @@ -132,6 +143,102 @@ ethphy: ethernet-phy@0 {
>  	};
>  };
>  
> +&gpio4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpio4>;
> +
> +	dsi_mux_sel_hdmi: dsi-mux-sel-hdmi-hog {
> +		gpio-hog;
> +		gpios = <14 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "dsi-mux-sel";
> +		status = "okay";

Status "okay" is usually used to flip "disabled".

> +	};
> +
> +	dsi_mux_sel_lvds: dsi-mux-sel-lvds-hog {
> +		gpio-hog;
> +		gpios = <14 GPIO_ACTIVE_HIGH>;
> +		output-low;
> +		line-name = "dsi-mux-sel";
> +		status = "disabled";
> +	};
> +
> +	dsi-mux-oe-hog {
> +		gpio-hog;
> +		gpios = <15 GPIO_ACTIVE_LOW>;
> +		output-high;
> +		line-name = "dsi-mux-oe";
> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	hdmi: hdmi@39 {
> +		compatible = "adi,adv7535";
> +		reg = <0x39>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_adv7535>;
> +
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> +
> +		adi,dsi-lanes = <4>;
> +
> +		a2vdd-supply = <&reg_vdd_1v8>;
> +		avdd-supply = <&reg_vdd_1v8>;
> +		dvdd-supply = <&reg_vdd_1v8>;
> +		pvdd-supply = <&reg_vdd_1v8>;
> +		v1p2-supply = <&reg_vdd_1v8>;
> +		v3p3-supply = <&reg_vdd_3v3>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;

Have a newline between properties and child node.

Shawn

> +				bridge_in_dsi_hdmi: endpoint {
> +					remote-endpoint = <&dsi_out_bridge>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				bridge_out_conn: endpoint {
> +					remote-endpoint = <&hdmi_in_conn>;
> +				};
> +			};
> +		};
> +	};
> +
> +	lvds: bridge@2c {
> +		compatible = "ti,sn65dsi84";
> +		reg = <0x2c>;
> +		enable-gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_sn65dsi84>;
> +		status = "disabled";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				bridge_in_dsi_lvds: endpoint {
> +					remote-endpoint = <&dsi_out_bridge>;
> +					data-lanes = <1 2>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
>  &i2c4 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> @@ -144,6 +251,30 @@ rx8900: rtc@32 {
>  	};
>  };
>  
> +&lcdif {
> +	status = "okay";
> +};
> +
> +&mipi_dsi {
> +	samsung,esc-clock-frequency = <54000000>;
> +	/*
> +	 * Let the driver calculate an appropriate clock rate based on the pixel
> +	 * clock instead of using the fixed value from imx8mm.dtsi.
> +	 */
> +	/delete-property/ samsung,pll-clock-frequency;
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +
> +			dsi_out_bridge: endpoint {
> +				remote-endpoint = <&bridge_in_dsi_hdmi>;
> +			};
> +		};
> +	};
> +};
> +
>  &pwm2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_pwm2>;
> @@ -207,6 +338,12 @@ &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gpio>;
>  
> +	pinctrl_adv7535: adv7535grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI1_TXD4_GPIO4_IO16		0x19
> +		>;
> +	};
> +
>  	pinctrl_can: cangrp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19
> @@ -277,6 +414,20 @@ MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x19
>  		>;
>  	};
>  
> +	pinctrl_gpio4: gpio4grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14		0x19
> +			MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15		0x19
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x40000083
> +			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x40000083
> +		>;
> +	};
> +
>  	pinctrl_i2c4: i2c4grp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
> @@ -290,6 +441,13 @@ MX8MM_IOMUXC_SPDIF_RX_PWM2_OUT			0x19
>  		>;
>  	};
>  
> +	pinctrl_sn65dsi84: sn65dsi84grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI2_TXD0_GPIO4_IO26		0x19
> +			MX8MM_IOMUXC_SD2_WP_GPIO2_IO20			0x19
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x140
> -- 
> 2.43.0
> 
