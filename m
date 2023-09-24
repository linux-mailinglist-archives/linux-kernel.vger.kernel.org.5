Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333627AC823
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 14:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjIXMrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 08:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjIXMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 08:47:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6005106;
        Sun, 24 Sep 2023 05:47:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD85C433C8;
        Sun, 24 Sep 2023 12:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695559624;
        bh=uYDw7caeln0FE8YZ0R4Znc7FgE+rD8pGLZ2Fc9rKI3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EHqwBAXiXCUH9ykTbb0MTUF/PMGUmFZBUnid9zNYIU6+jUiHLI4TsroGwPKQPAFJx
         Fc4kdKrYSW3174uAaC4eA/tPaMd2NnwjVGY2jjyEIDNqB3uAyaoqRDV4PS5wyG/3e4
         f2SlyocrDXLZo4ZHAL4gvfQd+9lfvzNtKrcKTPgoRXd63x5JD8GUSCCUY2q6OtiySI
         bGxJhUuTtslZ22g9IFWf0FimwjUp3hSIo7AEGE05Aa7jbuMK0RmG83110SmUFTRwPZ
         efy1asMpQQVDS0llyYEQrgkqLysqHVe6LawO8MvjUpDioEBf6MwBj4jiE/+u6pMeun
         hH+46nlkAQ7NQ==
Date:   Sun, 24 Sep 2023 20:46:50 +0800
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: imx8mp-beacon: Configure 100MHz PCIe Ref
 Clk
Message-ID: <20230924124650.GD7231@dragon>
References: <20230813164003.23665-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813164003.23665-1-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 11:40:03AM -0500, Adam Ford wrote:
> There is a I2C controlled 100MHz Reference clock used by the PCIe
> controller. Configure this clock's DIF1 output to be used by
> the PCIe.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  Remove the pcie0_refclk clock that the new one replaces.
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> index acd265d8b58e..a8ccde678c33 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> @@ -23,6 +23,12 @@ chosen {
>  		stdout-path = &uart2;
>  	};
>  
> +	clk_xtal25: clk-xtal25 {

clock-xtal25 for the node name?

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +	};
> +
>  	connector {
>  		compatible = "usb-c-connector";
>  		label = "USB-C";
> @@ -112,12 +118,6 @@ led-3 {
>  		};
>  	};
>  
> -	pcie0_refclk: clock-pcie {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <100000000>;
> -	};
> -
>  	reg_audio: regulator-wm8962 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "3v3_aud";
> @@ -246,6 +246,13 @@ pca6416_3: gpio@20 {
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
>  	};
> +
> +	pcieclk: clk@68 {

clock-generator in the bindings example seems a better node name to me.

Shawn

> +		compatible = "renesas,9fgv0241";
> +		reg = <0x68>;
> +		clocks = <&clk_xtal25>;
> +		#clock-cells = <1>;
> +	};
>  };
>  
>  &i2c3 {
> @@ -372,8 +379,9 @@ &pcie {
>  };
>  
>  &pcie_phy {
> +	fsl,clkreq-unsupported;
>  	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
> -	clocks = <&pcie0_refclk>;
> +	clocks = <&pcieclk 1>;
>  	clock-names = "ref";
>  	status = "okay";
>  };
> -- 
> 2.39.2
> 
