Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84127B3C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjI2ViX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjI2ViO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:38:14 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BE51BE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:38:11 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-116-43-nat.elisa-mobile.fi [85.76.116.43])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 21DEC844;
        Fri, 29 Sep 2023 23:36:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1696023386;
        bh=EVzNApoD3AOoyuoMhFWMBQeyLIuJ2jjPmfo+8wSbqvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rui7dFDOE9xIdZ2kM3Ff4A2QvcEvOSPekvBIoA4/xhGwZSnYtTwD9ezO/7CKUovfc
         dqZl2mj8ZLbyVsYcISjVFmBcA0ewO9r2drMjf9ul4rMCQF3zlS3gYr7BxCtjQc9SCR
         0FdNWW04GJoEFNFahnY1qPXq7rtOFbfs3+j815zg=
Date:   Sat, 30 Sep 2023 00:38:17 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: adv7511: Convert to use maple tree register
 cache
Message-ID: <20230929213817.GB28737@pendragon.ideasonboard.com>
References: <20230929-drm-adv7511-v1-1-b871b28ee594@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230929-drm-adv7511-v1-1-b871b28ee594@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thank you for the patch.

On Fri, Sep 29, 2023 at 02:54:19PM +0200, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.

I trust on your this statement.

> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Out of curiosity, is this part of an effort to drop the rbtree cache ?

> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 2611afd2c1c1..d518de88b5c3 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -121,7 +121,7 @@ static const struct regmap_config adv7511_regmap_config = {
>  	.val_bits = 8,
>  
>  	.max_register = 0xff,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>  	.reg_defaults_raw = adv7511_register_defaults,
>  	.num_reg_defaults_raw = ARRAY_SIZE(adv7511_register_defaults),
>  
> @@ -1068,7 +1068,7 @@ static const struct regmap_config adv7511_cec_regmap_config = {
>  	.val_bits = 8,
>  
>  	.max_register = 0xff,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>  	.volatile_reg = adv7511_cec_register_volatile,
>  };
>  
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230929-drm-adv7511-2d592921f8a2

-- 
Regards,

Laurent Pinchart
