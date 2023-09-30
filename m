Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B922E7B4124
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjI3Ou3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjI3Ou2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:50:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76BFC5;
        Sat, 30 Sep 2023 07:50:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (lfbn-idf1-1-343-200.w86-195.abo.wanadoo.fr [86.195.61.200])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5E5954DA;
        Sat, 30 Sep 2023 16:48:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1696085318;
        bh=0YqXD3+eosGItzd6UoevtWRB5iXyw47u0+mzSfkk8OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lu/s6Pk3+5+wlQNXrGF+KamnzoFxnCp0+nR1rbVwdgkC2vj7wm7HuEBnFvyG4Nsd1
         joAE/wMKA1VsOPKxbdKr+eUktOnRQjaF9VY/KAgpH0M4sZ3R1RURV6Dhte3rdEfR6/
         vONkz129ed6k+z/3OEP2RgDrZRsULZC1NpNLlmtI=
Date:   Sat, 30 Sep 2023 17:50:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alexandra Diupina <adiupina@astralinux.ru>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] drm: rcar-du: turn rcar_du_group_get() into void and
 remove its return value check
Message-ID: <20230930145032.GD31829@pendragon.ideasonboard.com>
References: <169383224922.277971.15400887308406098634@ping.linuxembedded.co.uk>
 <20230927104438.30628-1-adiupina@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927104438.30628-1-adiupina@astralinux.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandra,

On Wed, Sep 27, 2023 at 01:44:38PM +0300, Alexandra Diupina wrote:
> rcar_du_group_get() never returns a negative
> error code (always returns 0), so change the comment
> about returned value, turn function into void (return
> code of rcar_du_group_get has been redundant for a
> long time, so perhaps it's just not required) and
> remove redundant error path handling in rcar_du_crtc_get()
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Using tools to find issues is fine in principle, but not even
compile-testing the resulting patch before submitting it is not.

> Fixes: 0bb63534fdf3 ("drm: rcar-du: Perform the initial CRTC setup from rcar_du_crtc_get()")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
> v2: rcar_du_group_get() is turned into void and its return 
> value check is removed in rcar_du_crtc_get()
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c  | 6 +-----
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c | 5 +----
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
> index 7e175dbfd892..2be7c6e64d72 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
> @@ -565,17 +565,13 @@ static int rcar_du_crtc_get(struct rcar_du_crtc *rcrtc)
>  	if (ret < 0)
>  		goto error_clock;
>  
> -	ret = rcar_du_group_get(rcrtc->group);
> -	if (ret < 0)
> -		goto error_group;
> +	rcar_du_group_get(rcrtc->group);
>  
>  	rcar_du_crtc_setup(rcrtc);
>  	rcrtc->initialized = true;
>  
>  	return 0;
>  
> -error_group:
> -	clk_disable_unprepare(rcrtc->extclock);
>  error_clock:
>  	clk_disable_unprepare(rcrtc->clock);
>  	return ret;
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c
> index 2ccd2581f544..7113025dabff 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c
> @@ -199,10 +199,8 @@ static void rcar_du_group_setup(struct rcar_du_group *rgrp)
>   * before accessing any hardware registers.
>   *
>   * This function must be called with the DRM mode_config lock held.
> - *
> - * Return 0 in case of success or a negative error code otherwise.
>   */
> -int rcar_du_group_get(struct rcar_du_group *rgrp)
> +void rcar_du_group_get(struct rcar_du_group *rgrp)
>  {
>  	if (rgrp->use_count)
>  		goto done;
> @@ -211,7 +209,6 @@ int rcar_du_group_get(struct rcar_du_group *rgrp)
>  
>  done:
>  	rgrp->use_count++;
> -	return 0;
>  }
>  
>  /*

-- 
Regards,

Laurent Pinchart
