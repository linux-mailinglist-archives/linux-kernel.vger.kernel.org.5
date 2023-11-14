Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2917EB67B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjKNSh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjKNShY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:37:24 -0500
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Nov 2023 10:37:20 PST
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1229E11D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:37:20 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id BE5CD3F893;
        Tue, 14 Nov 2023 19:28:41 +0100 (CET)
Date:   Tue, 14 Nov 2023 19:28:38 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Doug Anderson <dianders@chromium.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] drm/msm/dsi: fix DSC for the bonded DSI case
Message-ID: <eanx45rnasj7lu3r2tfhtg4qkqkcidd6zctsz6ci6jlklu4fgi@3nf73w2ka4li>
References: <20231114174218.19765-1-jonathan@marek.ca>
 <20231114174218.19765-4-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114174218.19765-4-jonathan@marek.ca>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On what hardware have you been testing this?  Dmitry and I have a stack of
patches to resolve support for Active CTL programming on newer hardware (DPU
5.0+ IIRC), where a single CTL is responsible for programming multiple INTF and
DSC blocks as used in bonded DSI.

On 2023-11-14 12:42:16, Jonathan Marek wrote:
> For the bonded DSI case, DSC pic_width and timing calculations should use
> the width of a single panel instead of the total combined width.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/dsi/dsi.h         |  3 ++-
>  drivers/gpu/drm/msm/dsi/dsi_host.c    | 20 +++++++++++---------
>  drivers/gpu/drm/msm/dsi/dsi_manager.c |  2 +-
>  3 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
> index 28379b1af63f..3a641e69447c 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.h
> @@ -93,7 +93,8 @@ int msm_dsi_host_power_off(struct mipi_dsi_host *host);
>  int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
>  				  const struct drm_display_mode *mode);
>  enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
> -					    const struct drm_display_mode *mode);
> +					    const struct drm_display_mode *mode,
> +					    bool is_bonded_dsi);
>  unsigned long msm_dsi_host_get_mode_flags(struct mipi_dsi_host *host);
>  int msm_dsi_host_register(struct mipi_dsi_host *host);
>  void msm_dsi_host_unregister(struct mipi_dsi_host *host);
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 7284346ab787..a6286eb9d006 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -938,8 +938,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  			       mode->hdisplay, mode->vdisplay);
>  			return;
>  		}
> -
> -		dsc->pic_width = mode->hdisplay;
> +		dsc->pic_width = hdisplay;

In my testing and debugging on CMDmode panels downstream this value/register
was always programmed to the _full_ width of the bonded panel.  Is that maybe
different for video mode?

>  		dsc->pic_height = mode->vdisplay;
>  		DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);
>  
> @@ -950,6 +949,11 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  		if (ret)
>  			return;
>  
> +		if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO)
> +			dsi_update_dsc_timing(msm_host, false, hdisplay);
> +		else
> +			dsi_update_dsc_timing(msm_host, true, hdisplay);
> +

Such cleanups (which appear unrelated) should probably be posted as separate
patches.

- Marijn

>  		/* Divide the display by 3 but keep back/font porch and
>  		 * pulse width same
>  		 */
> @@ -966,9 +970,6 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  	}
>  
>  	if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) {
> -		if (msm_host->dsc)
> -			dsi_update_dsc_timing(msm_host, false, mode->hdisplay);
> -
>  		dsi_write(msm_host, REG_DSI_ACTIVE_H,
>  			DSI_ACTIVE_H_START(ha_start) |
>  			DSI_ACTIVE_H_END(ha_end));
> @@ -987,9 +988,6 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  			DSI_ACTIVE_VSYNC_VPOS_START(vs_start) |
>  			DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
>  	} else {		/* command mode */
> -		if (msm_host->dsc)
> -			dsi_update_dsc_timing(msm_host, true, mode->hdisplay);
> -
>  		/* image data and 1 byte write_memory_start cmd */
>  		if (!msm_host->dsc)
>  			wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
> @@ -2487,7 +2485,8 @@ int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
>  }
>  
>  enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
> -					    const struct drm_display_mode *mode)
> +					    const struct drm_display_mode *mode,
> +					    bool is_bonded_dsi)
>  {
>  	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>  	struct drm_dsc_config *dsc = msm_host->dsc;
> @@ -2497,6 +2496,9 @@ enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
>  	if (!msm_host->dsc)
>  		return MODE_OK;
>  
> +	if (is_bonded_dsi)
> +		pic_width = mode->hdisplay / 2;
> +
>  	if (pic_width % dsc->slice_width) {
>  		pr_err("DSI: pic_width %d has to be multiple of slice %d\n",
>  		       pic_width, dsc->slice_width);
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index 896f369fdd53..2ca1a7ca3659 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -455,7 +455,7 @@ static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,
>  			return MODE_ERROR;
>  	}
>  
> -	return msm_dsi_host_check_dsc(host, mode);
> +	return msm_dsi_host_check_dsc(host, mode, IS_BONDED_DSI());
>  }
>  
>  static const struct drm_bridge_funcs dsi_mgr_bridge_funcs = {
> -- 
> 2.26.1
> 
