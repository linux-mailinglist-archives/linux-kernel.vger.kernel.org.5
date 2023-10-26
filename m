Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FA97D8218
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbjJZL4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjJZL4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:56:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF42C1A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:56:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AAFC433C7;
        Thu, 26 Oct 2023 11:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698321378;
        bh=CENzIntdOf++JKgYOeR0qhTw1BcWJXALH8MVjPWUNDE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GUCkR0XemaTpB6vkMIzYXnE9fxKRgoiYG+fJWmXlPTursvmoOiHfmeAN9CuBtS6ud
         GRwn4zNyW1Jruxx2dmg8tisROH5/YwccbrbDrXIISqD8Z+t2AZflKgI811bCVX8cpa
         ie5YAGHeWk0C5OUc3ydTGBIcvK1Hxh6YgSykDEunn4X9fPRwjCo6RPCW3tB2XRw8Sc
         4sbfkYtvJrRK/g0pxLG6ZXTQTbbYbzJ8jfC5XCSyEDXtPgWeP1RJztutu7o4S3hJ1D
         rbd02d/wePI5LE0GYOzzOjQm/WTc6F62/HpkKzXfY1YuKP3ZpgptlDmM4Nvf1Jkwad
         13YsEn22x84og==
Message-ID: <f09e7aab-f446-478f-b52e-0bb71b9fe2b3@kernel.org>
Date:   Thu, 26 Oct 2023 14:56:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: ti: gmii-sel: Fix register offset when parent is not
 a syscon node
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231025143302.1265633-1-afd@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231025143302.1265633-1-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/2023 17:33, Andrew Davis wrote:
> When the node for this phy selector is a child node of a syscon node then the
> property 'reg' is used as an offset into the parent regmap. When the node
> is standalone and gets its own regmap this offset is pre-applied. So we need
> to track which method was used to get the regmap and not apply the offset
> in the standalone case.
> 
> Fixes: 1fdfa7cccd35 ("phy: ti: gmii-sel: Allow parent to not be syscon node")
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/phy/ti/phy-gmii-sel.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
> index 555b323f45da1..bc847d3879f79 100644
> --- a/drivers/phy/ti/phy-gmii-sel.c
> +++ b/drivers/phy/ti/phy-gmii-sel.c
> @@ -64,6 +64,7 @@ struct phy_gmii_sel_priv {
>  	u32 num_ports;
>  	u32 reg_offset;
>  	u32 qsgmii_main_ports;
> +	bool no_offset;
>  };
>  
>  static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
> @@ -402,7 +403,8 @@ static int phy_gmii_sel_init_ports(struct phy_gmii_sel_priv *priv)
>  		priv->num_ports = size / sizeof(u32);
>  		if (!priv->num_ports)
>  			return -EINVAL;
> -		priv->reg_offset = __be32_to_cpu(*offset);

nit: new line before new 'if' block please.

> +		if (!priv->no_offset)
> +			priv->reg_offset = __be32_to_cpu(*offset);
>  	}
>  
>  	if_phys = devm_kcalloc(dev, priv->num_ports,
> @@ -471,6 +473,7 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
>  			dev_err(dev, "Failed to get syscon %d\n", ret);
>  			return ret;
>  		}
> +		priv->no_offset = true;
>  	}
>  
>  	ret = phy_gmii_sel_init_ports(priv);


Reviewed-by: Roger Quadros <rogerq@kernel.org>
