Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F6D777585
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjHJKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjHJKMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:12:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B95A83
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:11:58 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 736742CF;
        Thu, 10 Aug 2023 12:10:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691662247;
        bh=JLzx34SATwxcqWWL9wKiniqBwX1I2Wbwoo5F/RC7m6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfVQBT3kj2sf/7XTD879gx41bBPEHP0keGuFsu1pTVjYFhEQdvc8RHUVHO3dGKq3o
         3tSEghKm2dreXCH8S3HVzUdeXWW2ZKwEHvaAxP1/s7d/+cbF/lpT+CASxqfzjYAEXH
         5RTZeEfOoIIO+z+pu1q9f63tqQb0/UQorWkGGOw8=
Date:   Thu, 10 Aug 2023 13:12:03 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Qiang Yu <yuq825@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lima@lists.freedesktop.org, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 1/2] drm/bridge: adv7511: fix Wvoid-pointer-to-enum-cast
 warning
Message-ID: <20230810101203.GB402@pendragon.ideasonboard.com>
References: <20230810095923.123388-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810095923.123388-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the patch.

On Thu, Aug 10, 2023 at 11:59:22AM +0200, Krzysztof Kozlowski wrote:
> 'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
> causes:
> 
>   adv7511_drv.c:1214:19: error: cast to smaller integer type 'enum adv7511_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 2611afd2c1c1..0e284f379602 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1211,7 +1211,7 @@ static int adv7511_probe(struct i2c_client *i2c)
>  	adv7511->status = connector_status_disconnected;
>  
>  	if (dev->of_node)
> -		adv7511->type = (enum adv7511_type)of_device_get_match_data(dev);
> +		adv7511->type = (uintptr_t)of_device_get_match_data(dev);
>  	else
>  		adv7511->type = id->driver_data;
>  

-- 
Regards,

Laurent Pinchart
