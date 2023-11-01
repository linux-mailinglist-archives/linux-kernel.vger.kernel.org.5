Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E035E7DE222
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjKANr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjKANr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:47:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642B210D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:47:50 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CDFAB8D;
        Wed,  1 Nov 2023 14:47:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698846452;
        bh=FPN8Dc91C03T+nlDMgTX3rWA1Ek2ie9ZO4kTgNKhUfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHwo8jD4u/RRMajIOxn9tjjvAfC3zGRbcA/Jx/1Pir6wV6kdK9VRGtac26bQPQzfQ
         Jfvo99wSnrOMix8WqcBhSA8hplwx7+ByCDh6ofjVmTHi4ApeedRBVP7wXFXu/xZxOY
         qzFoIdIc8flKPOy7enbxCq7tq7PHc3wlb+PvARv4=
Date:   Wed, 1 Nov 2023 15:47:55 +0200
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
Subject: Re: [PATCH 01/10] drm/tidss: Use pm_runtime_resume_and_get()
Message-ID: <20231101134755.GQ12764@pendragon.ideasonboard.com>
References: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
 <20231101-tidss-probe-v1-1-45149e0f9415@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101-tidss-probe-v1-1-45149e0f9415@ideasonboard.com>
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

On Wed, Nov 01, 2023 at 11:17:38AM +0200, Tomi Valkeinen wrote:
> Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync(), which
> will handle error situations better. Also fix the return, as there
> should be no reason for the current complex return.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

But I think we would be better off dropping the two small wrappers.

> ---
>  drivers/gpu/drm/tidss/tidss_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
> index 4d063eb9cd0b..f403db11b846 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.c
> +++ b/drivers/gpu/drm/tidss/tidss_drv.c
> @@ -32,9 +32,9 @@ int tidss_runtime_get(struct tidss_device *tidss)
>  
>  	dev_dbg(tidss->dev, "%s\n", __func__);
>  
> -	r = pm_runtime_get_sync(tidss->dev);
> +	r = pm_runtime_resume_and_get(tidss->dev);
>  	WARN_ON(r < 0);
> -	return r < 0 ? r : 0;
> +	return r;
>  }
>  
>  void tidss_runtime_put(struct tidss_device *tidss)
> 

-- 
Regards,

Laurent Pinchart
