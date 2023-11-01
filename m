Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B104B7DE3A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjKAO5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjKAO47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:56:59 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C63FD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:56:53 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CF44D8D;
        Wed,  1 Nov 2023 15:56:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698850595;
        bh=5XFw4kIPXXZ2DwgwHP3vUbhDMgLtjcVtiOsJfOvp0J8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b7mPDl0zzBSqxli5xbl7IZiKaJCRg3QqU6qWhsHDKBU+MY5OBLYRSWD/aKjU9Ki88
         PaP01nmHfBQ/1CdNHzbejaKyEBDuR2Ey+js+tiyYGowNsSbEzu8NTB2PoIKcSNjqgW
         ObZlTG/XgMSzADCVuknTSnvYAq1oWWeI5/4ydigU=
Date:   Wed, 1 Nov 2023 16:56:58 +0200
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
Subject: Re: [PATCH 10/10] drm/tidss: Fix atomic_flush check
Message-ID: <20231101145658.GZ12764@pendragon.ideasonboard.com>
References: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
 <20231101-tidss-probe-v1-10-45149e0f9415@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101-tidss-probe-v1-10-45149e0f9415@ideasonboard.com>
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

On Wed, Nov 01, 2023 at 11:17:47AM +0200, Tomi Valkeinen wrote:
> tidss_crtc_atomic_flush() checks if the crtc is enabled, and if not,
> returns immediately as there's no reason to do any register changes.
> 
> However, the code checks for 'crtc->state->enable', which does not
> reflect the actual HW state. We should instead look at the
> 'crtc->state->active' flag.
> 
> This causes the tidss_crtc_atomic_flush() to proceed with the flush even
> if the active state is false, which then causes us to hit the
> WARN_ON(!crtc->state->event) check.
> 
> Fix this by checking the active flag, and while at it, fix the related
> debug print which had "active" and "needs modeset" wrong way.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/tidss/tidss_crtc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
> index 5e5e466f35d1..4c7009a5d643 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
> @@ -169,13 +169,12 @@ static void tidss_crtc_atomic_flush(struct drm_crtc *crtc,
>  	struct tidss_device *tidss = to_tidss(ddev);
>  	unsigned long flags;
>  
> -	dev_dbg(ddev->dev,
> -		"%s: %s enabled %d, needs modeset %d, event %p\n", __func__,
> -		crtc->name, drm_atomic_crtc_needs_modeset(crtc->state),
> -		crtc->state->enable, crtc->state->event);
> +	dev_dbg(ddev->dev, "%s: %s active %d, needs modeset %d, event %p\n",
> +		__func__, crtc->name, crtc->state->active,
> +		drm_atomic_crtc_needs_modeset(crtc->state), crtc->state->event);

While at it, how about this ?

	dev_dbg(ddev->dev, "%s: %s is %sactive, %s modeset, event %p\n",
		__func__, crtc->name, crtc->state->active ? "" : "not ",
		drm_atomic_crtc_needs_modeset(crtc->state) ? "needs", "doesn't need",
		crtc->state->event);

>  
>  	/* There is nothing to do if CRTC is not going to be enabled. */
> -	if (!crtc->state->enable)
> +	if (!crtc->state->active)

I think the drm_atomic_helper_commit_planes() helper will handle this if
you pass it the DRM_PLANE_COMMIT_ACTIVE_ONLY flag.

>  		return;
>  
>  	/*

-- 
Regards,

Laurent Pinchart
