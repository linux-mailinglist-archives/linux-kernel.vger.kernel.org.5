Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27A17B3FBE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjI3JjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjI3JjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:39:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438CA1A5;
        Sat, 30 Sep 2023 02:39:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F32C433C8;
        Sat, 30 Sep 2023 09:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696066746;
        bh=Q0JZczSYb8IZ3ZaIjrDmyo/SCG/lFxNpe9cqL4DbR9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+k2A1eNMfAUeB5DhoWwL0EcXnfvkO3LYkHPCNZ6AaOWavJXdXi9qgXvIrPkgG4TH
         Lm2oItzKRv/D3E1Des2qSA4uhu7blxdjCoTGBA1YT+Chx+jqKS8/rBqbH6Cnb2WPol
         bg4eVvmc6tGtD4BhUy2dM5ivJHif4D72tG5Y7ZHpI/xz8V177BZacFljJPmCwfXDhf
         sLyuLxt8gVz7pohq8ri9EJj6b4IW9VxMOaDz4VEZVnKvmWiI0k0hY8iX2DEknPwaaa
         ahPmvj+62FRuaRb0pqCLVsnpo5I49mnRT5vysMOrRHaQDKporyTcHWpg1tBpshN4mH
         tqBED0oKI406w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qmWRI-0001Ou-0P;
        Sat, 30 Sep 2023 11:39:08 +0200
Date:   Sat, 30 Sep 2023 11:39:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: gcc-sc8280xp: Don't keep display AHB
 clocks always-on
Message-ID: <ZRfsvAJIdlmOWjf2@hovoldconsulting.com>
References: <20230929-topic-8280_ahbdisp-v1-0-72bdc38309b9@linaro.org>
 <20230929-topic-8280_ahbdisp-v1-2-72bdc38309b9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929-topic-8280_ahbdisp-v1-2-72bdc38309b9@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 03:38:53PM +0200, Konrad Dybcio wrote:
> These clocks are consumed by the dispcc[01] clock controllers, so there's
> no reason to keep them on from gcc probe. Remove that hack.

Eh, how did you test this patch?

The GCC_DISP_AHB_CLK clocks are not modelled by the clock driver
currently so nothing is guaranteeing them to be enabled if we were to
apply this patch. They just happen to be left on by the bootloader on
some machines currently (well at least one of them is on one machine).

So this series is broken and should not be applied.

NAK.

Also, please CC me on sc8280xp and X13s related patches.
 
> Fixes: d65d005f9a6c ("clk: qcom: add sc8280xp GCC driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/gcc-sc8280xp.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index bfb77931e868..bf95f82a3818 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -7545,18 +7545,16 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
>  
>  	/*
>  	 * Keep the clocks always-ON
> -	 * GCC_CAMERA_AHB_CLK, GCC_CAMERA_XO_CLK, GCC_DISP_AHB_CLK,
> +	 * GCC_CAMERA_AHB_CLK, GCC_CAMERA_XO_CLK,
>  	 * GCC_DISP_XO_CLK, GCC_GPU_CFG_AHB_CLK, GCC_VIDEO_AHB_CLK,
> -	 * GCC_VIDEO_XO_CLK, GCC_DISP1_AHB_CLK, GCC_DISP1_XO_CLK
> +	 * GCC_VIDEO_XO_CLK, GCC_DISP1_XO_CLK
>  	 */
>  	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
>  	regmap_update_bits(regmap, 0x26020, BIT(0), BIT(0));
> -	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
>  	regmap_update_bits(regmap, 0x27028, BIT(0), BIT(0));
>  	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
>  	regmap_update_bits(regmap, 0x28004, BIT(0), BIT(0));
>  	regmap_update_bits(regmap, 0x28028, BIT(0), BIT(0));
> -	regmap_update_bits(regmap, 0xbb004, BIT(0), BIT(0));
>  	regmap_update_bits(regmap, 0xbb028, BIT(0), BIT(0));

Johan
