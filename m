Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4053B790DC3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 21:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242482AbjICTf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 15:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbjICTf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 15:35:28 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A3E94;
        Sun,  3 Sep 2023 12:35:23 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2360920091;
        Sun,  3 Sep 2023 21:35:19 +0200 (CEST)
Date:   Sun, 3 Sep 2023 21:35:17 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] drm/msm/dsi: Enable widebus for DSI
Message-ID: <3jpcldlzrrsy6v3rco7jdx2hqv4sl5qkmi77gpppm2ifccnc77@chj5gcjrfivu>
References: <20230822-add-widebus-support-v4-0-9dc86083d6ea@quicinc.com>
 <20230822-add-widebus-support-v4-4-9dc86083d6ea@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822-add-widebus-support-v4-4-9dc86083d6ea@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-22 10:42:07, Jessica Zhang wrote:
> DSI 6G v2.5.x+ supports a data-bus widen mode that allows DSI to send
> 48 bits of compressed data instead of 24.
> 
> Enable this mode whenever DSC is enabled for supported chipsets.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi.c      |  2 +-
>  drivers/gpu/drm/msm/dsi/dsi.h      |  1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 31 +++++++++++++++++++++++++++----
>  3 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
> index 4cf424b3509f..7327bfc06a84 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
> @@ -19,7 +19,7 @@ struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
>  
>  bool msm_dsi_wide_bus_enabled(struct msm_dsi *msm_dsi)
>  {
> -	return false;
> +	return msm_dsi_host_is_widebus_enabled(msm_dsi->host);
>  }
>  
>  static int dsi_get_phy(struct msm_dsi *msm_dsi)
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
> index bd3763a5d723..a557d2c1aaff 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.h
> @@ -134,6 +134,7 @@ int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
>  void msm_dsi_host_snapshot(struct msm_disp_state *disp_state, struct mipi_dsi_host *host);
>  void msm_dsi_host_test_pattern_en(struct mipi_dsi_host *host);
>  struct drm_dsc_config *msm_dsi_host_get_dsc_config(struct mipi_dsi_host *host);
> +bool msm_dsi_host_is_widebus_enabled(struct mipi_dsi_host *host);
>  
>  /* dsi phy */
>  struct msm_dsi_phy;
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 645927214871..267c7fda8854 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -710,6 +710,15 @@ static void dsi_ctrl_disable(struct msm_dsi_host *msm_host)
>  	dsi_write(msm_host, REG_DSI_CTRL, 0);
>  }
>  
> +bool msm_dsi_host_is_widebus_enabled(struct mipi_dsi_host *host)

I thought you settled on wide_bus?

> +{
> +	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
> +
> +	return msm_host->dsc &&
> +		(msm_host->cfg_hnd->major == MSM_DSI_VER_MAJOR_6G &&
> +		 msm_host->cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V2_5_0);
> +}
> +
>  static void dsi_ctrl_enable(struct msm_dsi_host *msm_host,
>  			struct msm_dsi_phy_shared_timings *phy_shared_timings, struct msm_dsi_phy *phy)
>  {
> @@ -753,10 +762,16 @@ static void dsi_ctrl_enable(struct msm_dsi_host *msm_host,
>  		data |= DSI_CMD_CFG1_INSERT_DCS_COMMAND;
>  		dsi_write(msm_host, REG_DSI_CMD_CFG1, data);
>  
> -		if (msm_host->cfg_hnd->major == MSM_DSI_VER_MAJOR_6G &&
> -		    msm_host->cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V1_3) {
> +		if (cfg_hnd->major == MSM_DSI_VER_MAJOR_6G) {
>  			data = dsi_read(msm_host, REG_DSI_CMD_MODE_MDP_CTRL2);
> -			data |= DSI_CMD_MODE_MDP_CTRL2_BURST_MODE;
> +
> +			if (cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V1_3)
> +				data |= DSI_CMD_MODE_MDP_CTRL2_BURST_MODE;
> +
> +			/* TODO: Allow for video-mode support once tested/fixed */
> +			if (msm_dsi_host_is_widebus_enabled(&msm_host->base))
> +				data |= DSI_CMD_MODE_MDP_CTRL2_DATABUS_WIDEN;
> +
>  			dsi_write(msm_host, REG_DSI_CMD_MODE_MDP_CTRL2, data);
>  		}
>  	}
> @@ -894,6 +909,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  	u32 hdisplay = mode->hdisplay;
>  	u32 wc;
>  	int ret;
> +	bool widebus_enabled = msm_dsi_host_is_widebus_enabled(&msm_host->base);
>  
>  	DBG("");
>  
> @@ -914,6 +930,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  
>  	if (msm_host->dsc) {
>  		struct drm_dsc_config *dsc = msm_host->dsc;
> +		u32 bytes_per_pclk;
>  
>  		/* update dsc params with timing params */
>  		if (!dsc || !mode->hdisplay || !mode->vdisplay) {
> @@ -937,7 +954,13 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  		 * pulse width same
>  		 */
>  		h_total -= hdisplay;
> -		hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), 3);
> +		if (widebus_enabled && !(msm_host->mode_flags & MIPI_DSI_MODE_VIDEO))
> +			bytes_per_pclk = 6;
> +		else
> +			bytes_per_pclk = 3;
> +
> +		hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), bytes_per_pclk);
> +
>  		h_total += hdisplay;
>  		ha_end = ha_start + hdisplay;
>  	}
> 
> -- 
> 2.42.0
> 
