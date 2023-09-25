Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B15A7ACD1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjIYAdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIYAde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:33:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A502CCF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:33:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D8AC433C7;
        Mon, 25 Sep 2023 00:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695602008;
        bh=YOabgbAw23v6Lo5+imY7xlOKOFQFR3ooh03BmYV8U9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wb++vxCUecfenACiqdgN5n2xfXnyjrhLxmEzSyhZevgqqlB1nkZMLJbct+HDzuxZj
         W98iE20anXGk0fyY+a1fpxv2iLCiJV7j2alTvJ6LhrG7e2qzUkRg/u2uYf2mkiV8Gi
         APqCFn3/77GCSr/7nu0Pq8vL6CmgNIvZ+jTuGGm5x5E/HmckI8ttBH615RFiPeSg7d
         PB1/PjeJR4QtBQMXA0W5rRJn3mg/UK+zI64papvfSX8E4T+p35BdVq015qVQPvA+TL
         M0WRxcfh408UZAGAT/K9Jwxt02Gk1KrOajYszAkuZ54bG+2wUtqPqAwEzq+Ibm+u1y
         ZN897/jcdWIYA==
Date:   Mon, 25 Sep 2023 08:33:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shenwei.wang@nxp.com,
        sherry.sun@nxp.com
Subject: Re: [PATCH 1/3] arm64: dts: imx93: add edma1 and edma2
Message-ID: <20230925003314.GV7231@dragon>
References: <20230823180055.2605191-1-Frank.Li@nxp.com>
 <20230823180055.2605191-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823180055.2605191-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 02:00:53PM -0400, Frank Li wrote:
> Add edma<n> nodes.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 116 +++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 6f85a05ee7e1..acdca18673b7 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -185,6 +185,46 @@ aips1: bus@44000000 {
>  			#size-cells = <1>;
>  			ranges;
>  
> +			edma1: dma-controller@44000000{
> +				compatible = "fsl,imx93-edma3";
> +				reg = <0x44000000 0x200000>;
> +				#dma-cells = <3>;
> +				dma-channels = <31>;
> +				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,  //  0: Reserved
> +					     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,  //  1: CANFD1
> +					     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,  //  2: Reserved
> +					     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,  //  3: GPIO1 CH0
> +					     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,  //  4: GPIO1 CH1
> +					     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>, //  5: I3C1 TO Bus
> +					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>, //  6: I3C1 From Bus
> +					     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>, //  7: LPI2C1 M TX
> +					     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, //  8: LPI2C1 S TX
> +					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>, //  9: LPI2C2 M RX
> +					     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>, // 10: LPI2C2 S RX
> +					     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>, // 11: LPSPI1 TX
> +					     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>, // 12: LPSPI1 RX
> +					     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, // 13: LPSPI2 TX
> +					     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>, // 14: LPSPI2 RX
> +					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>, // 15: LPTMR1
> +					     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>, // 16: LPUART1 TX
> +					     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>, // 17: LPUART1 RX
> +					     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, // 18: LPUART2 TX
> +					     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>, // 19: LPUART2 RX
> +					     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>, // 20: S400
> +					     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>, // 21: SAI TX
> +					     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>, // 22: SAI RX
> +					     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, // 23: TPM1 CH0/CH2
> +					     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>, // 24: TPM1 CH1/CH3
> +					     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>, // 25: TPM1 Overflow
> +					     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>, // 26: TMP2 CH0/CH2
> +					     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>, // 27: TMP2 CH1/CH3
> +					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, // 28: TMP2 Overflow
> +					     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>, // 29: PDM
> +					     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>; // 30: ADC1
> +				clocks = <&clk IMX93_CLK_EDMA1_GATE>;
> +				clock-names = "dma";
> +			};
> +
>  			anomix_ns_gpr: syscon@44210000 {
>  				compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
>  				reg = <0x44210000 0x1000>;
> @@ -423,6 +463,82 @@ aips2: bus@42000000 {
>  			#size-cells = <1>;
>  			ranges;
>  
> +			edma2: dma-controller@42000000{
> +				compatible = "fsl,imx93-edma4";
> +				reg = <0x42000000 0x210000>;
> +				#dma-cells = <3>;
> +				shared-interrupt;
> +				dma-channels = <64>;
> +				interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX93_CLK_EDMA2_GATE>;
> +				clock-names = "dma";
> +				fsl,edma-axi;

I do not find this property in bindings doc.

> +				status = "okay";

Unnecessary 'status'.

Shawn

> +			};
> +
>  			wakeupmix_gpr: syscon@42420000 {
>  				compatible = "fsl,imx93-wakeupmix-syscfg", "syscon";
>  				reg = <0x42420000 0x1000>;
> -- 
> 2.34.1
> 
