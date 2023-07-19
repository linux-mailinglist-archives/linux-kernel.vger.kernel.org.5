Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F9D759606
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGSM5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGSM5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:57:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEE7113
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 05:57:31 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qM6k8-0001Bb-Kg; Wed, 19 Jul 2023 14:57:24 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qM6k7-0001Kp-NP; Wed, 19 Jul 2023 14:57:23 +0200
Date:   Wed, 19 Jul 2023 14:57:23 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v1 1/2] arm64: dts: freescale: verdin-imx8mp: dahlia: add
 sound card
Message-ID: <20230719125723.34e5zrq2oyibqbeo@pengutronix.de>
References: <20230719125430.249644-1-francesco@dolcini.it>
 <20230719125430.249644-2-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719125430.249644-2-francesco@dolcini.it>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-19, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add WM8904 based analog sound card to Dahlia carrier board.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../dts/freescale/imx8mp-verdin-dahlia.dtsi   | 56 ++++++++++++++++++-
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
> index 56b0e4b865c9..7e9e4b13b5c5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
> @@ -3,7 +3,36 @@
>   * Copyright 2022 Toradex
>   */
>  
> -/* TODO: Audio Codec */
> +/ {
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,bitclock-master = <&codec_dai>;
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&codec_dai>;
> +		simple-audio-card,mclk-fs = <256>;
> +		simple-audio-card,name = "imx8mp-wm8904";
> +		simple-audio-card,routing =
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"IN2L", "Line In Jack",
> +			"IN2R", "Line In Jack",
> +			"Headphone Jack", "MICBIAS",
> +			"IN1L", "Headphone Jack";
> +		simple-audio-card,widgets =
> +			"Microphone", "Headphone Jack",
> +			"Headphone", "Headphone Jack",
> +			"Line", "Line In Jack";
> +
> +		codec_dai: simple-audio-card,codec {
> +			clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1>;

Nit: since the audio-codec node is using the same clock you can drop it
here.

Regards,
  Marco

> +			sound-dai = <&wm8904_1a>;
> +		};
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai1>;
> +		};
> +	};
> +};
>  
>  &backlight {
>  	power-supply = <&reg_3p3v>;
> @@ -64,7 +93,21 @@ &i2c3 {
>  &i2c4 {
>  	status = "okay";
>  
> -	/* TODO: Audio Codec */
> +	/* Audio Codec */
> +	wm8904_1a: audio-codec@1a {
> +		compatible = "wlf,wm8904";
> +		reg = <0x1a>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_sai1>;
> +		#sound-dai-cells = <0>;
> +		clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1>;
> +		clock-names = "mclk";
> +		AVDD-supply = <&reg_1p8v>;
> +		CPVDD-supply = <&reg_1p8v>;
> +		DBVDD-supply = <&reg_1p8v>;
> +		DCVDD-supply = <&reg_1p8v>;
> +		MICVDD-supply = <&reg_1p8v>;
> +	};
>  };
>  
>  /* Verdin PCIE_1 */
> @@ -95,7 +138,14 @@ &reg_usdhc2_vmmc {
>  	vin-supply = <&reg_3p3v>;
>  };
>  
> -/* TODO: Verdin I2S_1 */
> +/* Verdin I2S_1 */
> +&sai1 {
> +	assigned-clocks = <&clk IMX8MP_CLK_SAI1>;
> +	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
>  
>  /* Verdin UART_1 */
>  &uart1 {
> -- 
> 2.25.1
> 
> 
> 
