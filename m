Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348F67531CA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbjGNGL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbjGNGLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:11:23 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E320271F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:11:21 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36E6BAhO115963;
        Fri, 14 Jul 2023 01:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689315070;
        bh=2vAhJx66rHvckNcSApzgwU33k1lw4bSihtSG2sdoJWw=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=wZNOvYD5VtRWtJmT7mDU/CbY2lqeU61WOZHcxMgwI6rMCV8O++x4XgZKeMqCEn9EI
         JON4GG+8fzsycqTz4dQ4pJ65KpoTAuCXxQjxH+h7/lsKqlOiqqSEwpaQyUz4Ty9hQq
         lnLxwMrmQZJSrbIsfXh5+tQkx7RdAcg7FitfE/f8=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36E6BA7t007649
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Jul 2023 01:11:10 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jul 2023 01:11:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jul 2023 01:11:09 -0500
Received: from [172.24.227.9] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36E6B7C5112738;
        Fri, 14 Jul 2023 01:11:07 -0500
Message-ID: <c9947c45-09e8-e2e1-ea0f-6b6f2fd15594@ti.com>
Date:   Fri, 14 Jul 2023 11:41:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
CC:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] phy: ti: gmii-sel: Allow parent to not be syscon node
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Vinod Koul <vkoul@kernel.org>
References: <20230713200957.134480-1-afd@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230713200957.134480-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/23 01:39, Andrew Davis wrote:
> If the parent node is not a syscon type, then fallback and check
> if we can get a regmap from our own node. This no longer forces
> us to make the parent of this node a syscon node when that might
> not be appropriate.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

> ---
> 
> Changes from v1:
>  - Rebased on v6.5-rc1
> 
>  drivers/phy/ti/phy-gmii-sel.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
> index 6286cf25a4264..555b323f45da1 100644
> --- a/drivers/phy/ti/phy-gmii-sel.c
> +++ b/drivers/phy/ti/phy-gmii-sel.c
> @@ -465,9 +465,12 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
>  
>  	priv->regmap = syscon_node_to_regmap(node->parent);
>  	if (IS_ERR(priv->regmap)) {
> -		ret = PTR_ERR(priv->regmap);
> -		dev_err(dev, "Failed to get syscon %d\n", ret);
> -		return ret;
> +		priv->regmap = device_node_to_regmap(node);
> +		if (IS_ERR(priv->regmap)) {
> +			ret = PTR_ERR(priv->regmap);
> +			dev_err(dev, "Failed to get syscon %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
>  	ret = phy_gmii_sel_init_ports(priv);

-- 
Regards,
Siddharth.
