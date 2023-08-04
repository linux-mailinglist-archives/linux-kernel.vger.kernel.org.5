Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89ABE77024A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjHDNup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjHDNuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:50:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E841FF0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:50:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C72722E4;
        Fri,  4 Aug 2023 15:49:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691156963;
        bh=PzI4mzdQbBo7dqgyXhXRYV0kIZNKcUK5DdEZVp1gg1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwnZSx2cwso4DOSftqjTWgl9+XQlM0Kj4HYaMGACN+HhVb8W/7DjF33x68VfRYKMP
         w1Z+hXa2GLoUP8LSC2hhk7USsZiXlm8d9+UDxYAf4AwQWXB+8YcD34Gvm3ykTH99lq
         ST/63o/yLnXNdlqdAh2VFoCt+/Y3L4Vn9r79JALc=
Date:   Fri, 4 Aug 2023 16:50:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/drm_file: fix use of uninitialized variable
Message-ID: <20230804135032.GG12951@pendragon.ideasonboard.com>
References: <20230804-uninit-fixes-v1-0-a60772c04db5@ideasonboard.com>
 <20230804-uninit-fixes-v1-1-a60772c04db5@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230804-uninit-fixes-v1-1-a60772c04db5@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 01:57:39PM +0300, Tomi Valkeinen wrote:
> smatch reports:
> 
> drivers/gpu/drm/drm_file.c:967 drm_show_memory_stats() error: uninitialized symbol 'supported_status'.
> 
> 'supported_status' is only set in one code path. I'm not familiar with
> the code to say if that path will always be ran in real life, but
> whether that is the case or not, I think it is good to initialize
> 'supported_status' to 0 to silence the warning (and possibly fix a bug).
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/drm_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 883d83bc0e3d..cc06e1836bf5 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -924,7 +924,7 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
>  {
>  	struct drm_gem_object *obj;
>  	struct drm_memory_stats status = {};
> -	enum drm_gem_object_status supported_status;
> +	enum drm_gem_object_status supported_status = 0;
>  	int id;
>  
>  	spin_lock(&file->table_lock);
> 

-- 
Regards,

Laurent Pinchart
