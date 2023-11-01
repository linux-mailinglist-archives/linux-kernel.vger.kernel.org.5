Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D317DE38A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344375AbjKAOWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbjKAOWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:22:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4105122
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:22:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 53F928D;
        Wed,  1 Nov 2023 15:21:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698848503;
        bh=n2rdYxd5Yv6fD7vS91tun0tk++E4eltMX2YMa/X3La0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fL09WS6WkMcLajJbn36rPPoSJMu8xoIgl4IE5IC9sxhIsLvyFuNvWlybFGpVNEF2j
         9IkPo4XtHNfcaOvtn384yd7CX5objcC4HG2hQxsvwyg/72kD0Ppneof/fkpjxQJjXs
         2ZX6X71Y4CKSsgRGZQTeExgRcv/xRPoWyETHiLas=
Date:   Wed, 1 Nov 2023 16:22:06 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] drm/tidss: Check for K2G in in dispc_softreset()
Message-ID: <20231101142206.GV12764@pendragon.ideasonboard.com>
References: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
 <20231101-tidss-probe-v1-6-45149e0f9415@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101-tidss-probe-v1-6-45149e0f9415@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Wed, Nov 01, 2023 at 11:17:43AM +0200, Tomi Valkeinen wrote:
> K2G doesn't have softreset feature. Instead of having every caller of
> dispc_softreset() check for K2G, move the check into dispc_softreset(),
> and make dispc_softreset() return 0 in case of K2G.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index cdbb88289082..f204a0701e9f 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -2707,6 +2707,10 @@ static int dispc_softreset(struct dispc_device *dispc)
>  	u32 val;
>  	int ret;
>  
> +	/* K2G display controller does not support soft reset */
> +	if (dispc->feat->subrev == DISPC_K2G)
> +		return 0;
> +
>  	/* Soft reset */
>  	REG_FLD_MOD(dispc, DSS_SYSCONFIG, 1, 1, 1);
>  	/* Wait for reset to complete */
> @@ -2831,12 +2835,9 @@ int dispc_init(struct tidss_device *tidss)
>  
>  	tidss->dispc = dispc;
>  
> -	/* K2G display controller does not support soft reset */
> -	if (feat->subrev != DISPC_K2G) {
> -		r = dispc_softreset(dispc);
> -		if (r)
> -			return r;
> -	}
> +	r = dispc_softreset(dispc);
> +	if (r)
> +		return r;
>  
>  	return 0;
>  }
> 

-- 
Regards,

Laurent Pinchart
