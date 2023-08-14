Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3177B409
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjHNIYG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 04:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjHNIXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:23:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8556A19AD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:23:19 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qVSqN-0002iR-RI; Mon, 14 Aug 2023 10:22:31 +0200
Message-ID: <c08784a0a1412d5843cf97b992efb17e1dc602b7.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: Fix SDMA2/3 clocks
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 14 Aug 2023 10:22:30 +0200
In-Reply-To: <20230813162906.22640-1-aford173@gmail.com>
References: <20230813162906.22640-1-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 13.08.2023 um 11:29 -0500 schrieb Adam Ford:
> A previous patch to remove the Audio clocks from the main clock node
> was intended to force people to setup the audio PLL clocks per board
> instead of having a common set of rates since not all boards may use
> the various audio PLL clocks for audio devices.
> 
> Unfortunately, with this parenting removed, the SDMA2 and SDMA3
> clocks were slowed to 24MHz because the SDMA2/3 clocks are controlled
> via the audio_blk_ctrl which is clocked from IMX8MP_CLK_AUDIO_ROOT,
> and that clock is enabled by pgc_audio.
> 
> Per the TRM, "The SDMA2/3 target frequency is 400MHz IPG and 400MHz
> AHB, always 1:1 mode, to make sure there is enough throughput for all
> the audio use cases."
> 
> Instead of cluttering the clock node, place the clock rate and parent
> information into the pgc_audio node.
> 
> With the parenting and clock rates restored for  IMX8MP_CLK_AUDIO_AHB,
> and IMX8MP_CLK_AUDIO_AXI_SRC, it appears the SDMA2 and SDMA3 run at
> 400MHz again.
> 
Note that 800MHz for the AXI clock is overdrive mode for the chip. For
other i.MX8M* chips we tried to have the nominal drive rates as
assigned rates in DT. With the i.MX8MP it's currently a wild mix and
most of the AXI clocks are set to OD rates, so I won't reject this
patch based on this.

Most boards run the DRAM at DDR4-4000, which already requires OD
voltages, so there isn't much point in trying to stick to ND rates on
those boards. We should probably do some consolidation here and come up
with a proper policy for the i.MX8MP soon.

> Fixes: 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks from CCM node")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 6f2f50e1639c..408b0c4ec4f8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -790,6 +790,12 @@ pgc_audio: power-domain@5 {
>  						reg = <IMX8MP_POWER_DOMAIN_AUDIOMIX>;
>  						clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
>  							 <&clk IMX8MP_CLK_AUDIO_AXI>;
> +						assigned-clocks = <&clk IMX8MP_CLK_AUDIO_AHB>,
> +								  <&clk IMX8MP_CLK_AUDIO_AXI_SRC>;
> +						assigned-clock-parents =  <&clk IMX8MP_SYS_PLL1_800M>,
> +									  <&clk IMX8MP_SYS_PLL1_800M>;
> +						assigned-clock-rates = <400000000>,
> +								       <800000000>;
>  					};
>  
>  					pgc_gpu2d: power-domain@6 {

