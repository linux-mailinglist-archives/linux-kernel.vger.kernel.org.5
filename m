Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5467DE218
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjKANyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjKANyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:54:07 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3939883
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:54:01 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D953D8D;
        Wed,  1 Nov 2023 14:53:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698846823;
        bh=umd36ZH9/8B0MzVnTORCG6HOMVV7hcOEiqUo9JtmjcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1KOm7VV3uZjtjNlXMR4pg1tx0mUa8ziTZ8aXVn4dCHc+FqmR3wzmkrOc/reHG2Zy
         Ep72AygN+Ez+WGmY6Tth0UMsvO2klG60j8uUF53lf1Z0+vUS2hpkR9h7IDVogWAVyp
         xmBWW4X6TuRDwzW+uCf3C0XtyBqOhUNks7BHVt8U=
Date:   Wed, 1 Nov 2023 15:54:06 +0200
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
Subject: Re: [PATCH 02/10] drm/tidss: Use PM autosuspend
Message-ID: <20231101135406.GR12764@pendragon.ideasonboard.com>
References: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
 <20231101-tidss-probe-v1-2-45149e0f9415@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101-tidss-probe-v1-2-45149e0f9415@ideasonboard.com>
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

On Wed, Nov 01, 2023 at 11:17:39AM +0200, Tomi Valkeinen wrote:
> Use runtime PM autosuspend feature, with 1s timeout, to avoid
> unnecessary suspend-resume cycles when, e.g. the userspace temporarily
> turns off the crtcs when configuring the outputs.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/tidss/tidss_drv.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
> index f403db11b846..64914331715a 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.c
> +++ b/drivers/gpu/drm/tidss/tidss_drv.c
> @@ -43,7 +43,9 @@ void tidss_runtime_put(struct tidss_device *tidss)
>  
>  	dev_dbg(tidss->dev, "%s\n", __func__);
>  
> -	r = pm_runtime_put_sync(tidss->dev);
> +	pm_runtime_mark_last_busy(tidss->dev);
> +
> +	r = pm_runtime_put_autosuspend(tidss->dev);
>  	WARN_ON(r < 0);
>  }
>  
> @@ -144,6 +146,9 @@ static int tidss_probe(struct platform_device *pdev)
>  
>  	pm_runtime_enable(dev);
>  
> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_use_autosuspend(dev);
> +
>  #ifndef CONFIG_PM
>  	/* If we don't have PM, we need to call resume manually */
>  	dispc_runtime_resume(tidss->dispc);

By the way, there's a way to handle this without any ifdef:

	dispc_runtime_resume(tidss->dispc);

	pm_runtime_set_active(dev);
	pm_runtime_get_noresume(dev);
	pm_runtime_enable(dev);
	pm_runtime_set_autosuspend_delay(dev, 1000);
	pm_runtime_use_autosuspend(dev);

Then, in the error path,

	pm_runtime_dont_use_autosuspend(dev);
	pm_runtime_disable(dev);
	pm_runtime_put_noidle(dev);

	dispc_runtime_suspend(tidss->dispc);

And in remove:

	pm_runtime_dont_use_autosuspend(dev);
	pm_runtime_disable(dev);
	if (!pm_runtime_status_suspended(dev))
		dispc_runtime_suspend(tidss->dispc);
	pm_runtime_set_suspended(dev);

And yes, runtime PM is a horrible API.

> @@ -215,6 +220,7 @@ static void tidss_remove(struct platform_device *pdev)
>  	/* If we don't have PM, we need to call suspend manually */
>  	dispc_runtime_suspend(tidss->dispc);
>  #endif
> +	pm_runtime_dont_use_autosuspend(dev);

This also needs to be done in the probe error path.

>  	pm_runtime_disable(dev);
>  
>  	/* devm allocated dispc goes away with the dev so mark it NULL */
> 

-- 
Regards,

Laurent Pinchart
