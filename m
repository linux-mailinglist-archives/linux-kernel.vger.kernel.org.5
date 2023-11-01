Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082DA7DE1FB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjKAN5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjKAN5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:57:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B7EA2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:57:44 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 45D1D8D;
        Wed,  1 Nov 2023 14:57:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698847046;
        bh=WdEnXxzZzV4vCDA6996OmVTFkq2J1CGwfST93FFdxPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QorMDBHMzluLEKY2CnKc2BPzuWsYlOgbNFg/XJ/C+eWA9uDyt7yWOOB6l9xIUfdVH
         fxCPV75RB7TaXtsTpl+wpUXxmuyDOK6+O+qjqyqdz/lRPWZsoeVmgaqkKjqyzkPzK2
         t52NgJyYWJ8FK/AvueuoJwZQm9Y2OZkd4PfRTRes=
Date:   Wed, 1 Nov 2023 15:57:49 +0200
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
Subject: Re: [PATCH 04/10] drm/tidss: Move reset to the end of dispc_init()
Message-ID: <20231101135749.GT12764@pendragon.ideasonboard.com>
References: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
 <20231101-tidss-probe-v1-4-45149e0f9415@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101-tidss-probe-v1-4-45149e0f9415@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Wed, Nov 01, 2023 at 11:17:41AM +0200, Tomi Valkeinen wrote:
> We do a DSS reset in the middle of the dispc_init(). While that happens
> to work now, we should really make sure that e..g the fclk, which is
> acquired only later in the function, is enabled when doing a reset. This
> will be handled in a later patch, but for now, let's move the
> dispc_softreset() call to the end of dispc_init(), which is a sensible
> place for it anyway.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

But do I understand correctly that the device isn't powered up at this
point ? That seems problematic.

I'm also not sure why we need to reset the device at probe time.

> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index ad7999434299..9430625e2d62 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -2777,10 +2777,6 @@ int dispc_init(struct tidss_device *tidss)
>  			return r;
>  	}
>  
> -	/* K2G display controller does not support soft reset */
> -	if (feat->subrev != DISPC_K2G)
> -		dispc_softreset(dispc);
> -
>  	for (i = 0; i < dispc->feat->num_vps; i++) {
>  		u32 gamma_size = dispc->feat->vp_feat.color.gamma_size;
>  		u32 *gamma_table;
> @@ -2831,5 +2827,9 @@ int dispc_init(struct tidss_device *tidss)
>  
>  	tidss->dispc = dispc;
>  
> +	/* K2G display controller does not support soft reset */
> +	if (feat->subrev != DISPC_K2G)
> +		dispc_softreset(dispc);
> +
>  	return 0;
>  }
> 

-- 
Regards,

Laurent Pinchart
