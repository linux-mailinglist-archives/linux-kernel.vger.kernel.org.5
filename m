Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5190277028C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjHDOGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjHDOGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:06:47 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F01B9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:06:46 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9FFC24E6;
        Fri,  4 Aug 2023 16:05:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691157939;
        bh=8LNzmHeeB+lW0wBZBacx/ttELqjRDfPORhidCw3qHAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y2TnL8iLvbI2V3wpNN6fAv3zG4Vvq33nlxPOujkiQHK2a+dWKmamTEHR1tagOIkDw
         +h4svtcyQECp2jvEOrufHWd9SDJzIMC9f952zetL2Sj9oisZX6HapqGOjSBxk1FDUa
         LEMR18iOMkSyYeWRxx56WtVk8558hdoN7iBvIfGA=
Date:   Fri, 4 Aug 2023 17:06:50 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/framebuffer: Fix use of uninitialized variable
Message-ID: <20230804140650.GH12951@pendragon.ideasonboard.com>
References: <20230804-uninit-fixes-v1-0-a60772c04db5@ideasonboard.com>
 <20230804-uninit-fixes-v1-2-a60772c04db5@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230804-uninit-fixes-v1-2-a60772c04db5@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 01:57:40PM +0300, Tomi Valkeinen wrote:
> smatch reports:
> 
> drivers/gpu/drm/drm_framebuffer.c:654 drm_mode_getfb2_ioctl() error: uninitialized symbol 'ret'.
> 
> 'ret' is possibly not set when there are no errors, causing the error
> above. I can't say if that ever happens in real-life, but in any case I
> think it is good to initialize 'ret' to 0.

I don't think it can happen in practice, but tools have no way to know
that.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/drm_framebuffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index aff3746dedfb..1955eaeba0ab 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -570,7 +570,7 @@ int drm_mode_getfb2_ioctl(struct drm_device *dev,
>  	struct drm_mode_fb_cmd2 *r = data;
>  	struct drm_framebuffer *fb;
>  	unsigned int i;
> -	int ret;
> +	int ret = 0;
>  
>  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
>  		return -EINVAL;
> 

-- 
Regards,

Laurent Pinchart
