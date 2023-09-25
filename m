Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C084B7ACD83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjIYBPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjIYBPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:15:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A30FB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 18:15:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EDDC433C8;
        Mon, 25 Sep 2023 01:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695604508;
        bh=OoTH/z7nJRsjocyuzHaS3i7q/qJKfFeyOBG9EcrBcPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joo4UVaG71XsA8rVr0xsLwun4AUIm0EYEba5zZDra7qr/cKm69w5yn7TDqm99io0z
         QATvZbDjvztYeY42GNCDrC06aRplIxVkjKw2PlIpSHvkRvAvy6AplCdJ0EEIOQa+KB
         TChpvcsJIjOzTHiEMUyDYhVbSeA2kfmK3uPenfzE36qLpO0mIMnCkoirwj9WkaO7qy
         W0vf9mTkiSmoWkrm4cesEVEjK6MvDfyewmQ5WKRf/dJB2CH3sKqbTU3Dn42KJcVDkS
         GBBmtO9klvu81t6GgeUtZ0iZT4DpKkefoGkRmjLliYBC1IdwAS+E3YKRBb6G78S3zx
         rpVojpL8aMydQ==
Date:   Mon, 25 Sep 2023 09:14:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: imx8mm-beacon: Add DMIC support
Message-ID: <20230925011457.GE7231@dragon>
References: <20230831115128.254226-1-aford173@gmail.com>
 <20230831115128.254226-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831115128.254226-2-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 06:51:26AM -0500, Adam Ford wrote:
> The baseboard has a connector for a pulse density microphone.
> This is connected via the micfil interface and uses the DMIC
> audio codec with the simple-audio-card.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> index 313e93663d6f..d0dd4c81a557 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> @@ -6,6 +6,13 @@
>  #include <dt-bindings/phy/phy-imx8-pcie.h>
>  
>  / {
> +
> +	dmic_codec: dmic-codec {
> +		compatible = "dmic-codec";
> +		num-channels = <1>;
> +		#sound-dai-cells = <0>;
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  
> @@ -98,6 +105,22 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  		enable-active-high;
>  	};
>  
> +	sound-dmic {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "dmic";
> +		simple-audio-card,format = "pdm";
> +		simple-audio-card,bitclock-master = <&dailink_master>;
> +		simple-audio-card,frame-master = <&dailink_master>;
> +
> +		dailink_master: simple-audio-card,cpu {
> +			sound-dai = <&micfil>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&dmic_codec>;
> +		};
> +	};
> +
>  	sound-wm8962 {
>  		compatible = "simple-audio-card";
>  		simple-audio-card,name = "wm8962";
> @@ -228,6 +251,16 @@ pca6416_1: gpio@21 {
>  	};
>  };
>  
> +&micfil {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pdm>;
> +	assigned-clocks = <&clk IMX8MM_CLK_PDM>;
> +	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <49152000>;
> +	status = "okay";

We usually end property list with 'status'.

Shawn

> +	#sound-dai-cells = <0>;
> +};
> +
>  &mipi_csi {
>  	status = "okay";
>  	ports {
> @@ -365,6 +398,13 @@ MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
>  		>;
>  	};
>  
> +	pinctrl_pdm: pdmgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI5_RXC_PDM_CLK	0xd6
> +			MX8MM_IOMUXC_SAI5_RXD0_PDM_DATA0	0xd6
> +		>;
> +	};
> +
>  	pinctrl_reg_usb_otg1: usbotg1grp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29     0x19
> -- 
> 2.39.2
> 
