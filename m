Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0686B7DE3E0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344467AbjKAOcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344282AbjKAOcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:32:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B48B83
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:32:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6D08E8D;
        Wed,  1 Nov 2023 15:32:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698849128;
        bh=a3lw8C+NZXOzSs8DpQrjBo8cXJrv3VFEkvITYoVoJFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2KGzq6Vz51m8RMXprOhYxgkj6ZNkaYFKtRK15/cjNdkDti5CyhVt6dwn63Hyb+7i
         bSNPayJeEn3FPkffZlZsucFS9EPyPf399G2BNb2aP1rBMxiLXmDtT7HZLmc0a9pVMY
         DrsbngOa+UUej0hyCEGJoCaT0pruEVFuPX7QStZQ=
Date:   Wed, 1 Nov 2023 16:32:31 +0200
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
Subject: Re: [PATCH 08/10] drm/tidss: Add dispc_is_idle()
Message-ID: <20231101143231.GX12764@pendragon.ideasonboard.com>
References: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
 <20231101-tidss-probe-v1-8-45149e0f9415@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101-tidss-probe-v1-8-45149e0f9415@ideasonboard.com>
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

On Wed, Nov 01, 2023 at 11:17:45AM +0200, Tomi Valkeinen wrote:
> Add a helper function, dispc_is_idle(), which returns whether the DSS is
> idle (i.e. is any video port enabled).
> 
> For now we add a call to it in the suspend and resume callbacks, and
> print a warning if in either place the DSS is not idle.

Could you please explain here why these checks are needed/useful ? Why
would the dispc not be idle ?

> In the future
> this can be used to detect if the bootloader had enabled the DSS, and
> the driver can act on that.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 13db062892e3..a527c28c8833 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -2603,10 +2603,18 @@ void dispc_vp_setup(struct dispc_device *dispc, u32 hw_videoport,
>  	dispc_vp_set_color_mgmt(dispc, hw_videoport, state, newmodeset);
>  }
>  
> +static bool dispc_is_idle(struct dispc_device *dispc)
> +{
> +	return REG_GET(dispc, DSS_SYSSTATUS, 9, 9);
> +}
> +
>  int dispc_runtime_suspend(struct dispc_device *dispc)
>  {
>  	dev_dbg(dispc->dev, "suspend\n");
>  
> +	if (!dispc_is_idle(dispc))
> +		dev_warn(dispc->dev, "Bad HW state: DSS not idle when suspending");
> +
>  	dispc->is_enabled = false;
>  
>  	clk_disable_unprepare(dispc->fclk);
> @@ -2620,6 +2628,9 @@ int dispc_runtime_resume(struct dispc_device *dispc)
>  
>  	clk_prepare_enable(dispc->fclk);
>  
> +	if (!dispc_is_idle(dispc))
> +		dev_warn(dispc->dev, "Bad HW state: DSS not idle when resuming");
> +
>  	if (REG_GET(dispc, DSS_SYSSTATUS, 0, 0) == 0)
>  		dev_warn(dispc->dev, "DSS FUNC RESET not done!\n");
>  

-- 
Regards,

Laurent Pinchart
