Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7F87857F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjHWMjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjHWMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:39:14 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840C3E40;
        Wed, 23 Aug 2023 05:39:11 -0700 (PDT)
Received: from i53875a83.versanet.de ([83.135.90.131] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qYn8T-0003UY-66; Wed, 23 Aug 2023 14:38:57 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakob Unterwurzacher <jakobunt@gmail.com>
Cc:     jakob.unterwurzacher@theobroma-systems.com,
        Ermin Sunj <ermin.sunj@theobroma-systems.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] TSD: arm64: dts: rockchip: use codec as clock master
Date:   Wed, 23 Aug 2023 14:38:56 +0200
Message-ID: <3763479.7s5MMGUR32@diego>
In-Reply-To: <20230823122000.585787-1-jakob.unterwurzacher@theobroma-systems.com>
References: <20230823122000.585787-1-jakob.unterwurzacher@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakob,

the change itself looks ok, but there are some logistic changes needed.

For one, please drop the local TSD prefix from patches submitted upstream.
The patch subject should be something like

	arm64: dts: rockchip: use codec as clock master on px30-ringneck

Am Mittwoch, 23. August 2023, 14:19:59 CEST schrieb Jakob Unterwurzacher:
> From: Ermin Sunj <ermin.sunj@theobroma-systems.com>
> 
> If the codec is not the clock master, the MCLK needs to be
> synchronous to both I2S_SCL ans I2S_LRCLK. We do not have that
> on Haikou, causing distorted audio.
> 
> Before:
> 
>  Running audioloopback.py script on Ringneck, 1kHz
>  output sine wave is not stable and shows distortion.
> 
> After:
> 
>  10h stress tests audioloopback.py failed only one time.
>  That is 0.00014% failure rate.
> 
> Signed-off-by: Ermin Sunj <ermin.sunj@theobroma-systems.com>

As sender of the patch you need to add another Signed-off-by line
of your own. With this you indicate that you were allowed to submit
the patch. So this needs two SOB-lines, one for Ermin as the original
author and one for you as the submitter.

Probably same for the second patch.


Thanks
Heiko

> ---
>  arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
> index 3a447d03e2a8..dafeef0c2dab 100644
> --- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
> +++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
> @@ -68,8 +68,10 @@ i2s0-sound {
>  		simple-audio-card,format = "i2s";
>  		simple-audio-card,name = "Haikou,I2S-codec";
>  		simple-audio-card,mclk-fs = <512>;
> +		simple-audio-card,frame-master = <&sgtl5000_codec>;
> +		simple-audio-card,bitclock-master = <&sgtl5000_codec>;
>  
> -		simple-audio-card,codec {
> +		sgtl5000_codec: simple-audio-card,codec {
>  			clocks = <&sgtl5000_clk>;
>  			sound-dai = <&sgtl5000>;
>  		};
> 




