Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1DE76D80F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjHBTjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjHBTjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:39:41 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F76198B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 12:39:39 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A10863EF48;
        Wed,  2 Aug 2023 21:39:36 +0200 (CEST)
Date:   Wed, 2 Aug 2023 21:39:35 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] drm/msm/dpu: Enable widebus for DSI INTF
Message-ID: <ujgfclphym2ezd6g4uw43tp3ciswhuon2qfp77uwqcbwrtqwqe@inybwaln3q5u>
References: <20230802-add-widebus-support-v3-0-2661706be001@quicinc.com>
 <20230802-add-widebus-support-v3-2-2661706be001@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802-add-widebus-support-v3-2-2661706be001@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-02 11:08:49, Jessica Zhang wrote:
> DPU supports a data-bus widen mode for DSI INTF.
> 
> Enable this mode for all supported chipsets if widebus is enabled for DSI.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c          | 11 ++++++++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  4 +++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          |  3 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h          |  1 +
>  drivers/gpu/drm/msm/msm_drv.h                        |  6 +++++-
>  5 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 3dcd37c48aac..de08aad39e15 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1196,15 +1196,20 @@ static void dpu_encoder_virt_atomic_enable(struct drm_encoder *drm_enc,
>  	struct drm_display_mode *cur_mode = NULL;
>  	struct msm_drm_private *priv = drm_enc->dev->dev_private;
>  	struct msm_display_info *disp_info;
> +	int index;
>  
>  	dpu_enc = to_dpu_encoder_virt(drm_enc);
>  	disp_info = &dpu_enc->disp_info;
>  
> +	disp_info = &dpu_enc->disp_info;
> +	index = disp_info->h_tile_instance[0];
> +
>  	dpu_enc->dsc = dpu_encoder_get_dsc_config(drm_enc);
>  
> -	if (disp_info->intf_type == INTF_DP)
> -		dpu_enc->wide_bus_en = msm_dp_wide_bus_available(
> -				priv->dp[disp_info->h_tile_instance[0]]);
> +	if (disp_info->intf_type == INTF_DSI)
> +		dpu_enc->wide_bus_en = msm_dsi_is_widebus_enabled(priv->dsi[index]);
> +	else if (disp_info->intf_type == INTF_DP)
> +		dpu_enc->wide_bus_en = msm_dp_wide_bus_available(priv->dp[index]);

This inconsistency really is killing.  wide_bus vs widebus, and one
function has an is_ while the other does not.

>  
>  	mutex_lock(&dpu_enc->enc_lock);
>  	cur_mode = &dpu_enc->base.crtc->state->adjusted_mode;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> index df88358e7037..dace6168be2d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> @@ -69,8 +69,10 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
>  				phys_enc->hw_intf,
>  				phys_enc->hw_pp->idx);
>  
> -	if (intf_cfg.dsc != 0)
> +	if (intf_cfg.dsc != 0) {
>  		cmd_mode_cfg.data_compress = true;
> +		cmd_mode_cfg.wide_bus_en = dpu_encoder_is_widebus_enabled(phys_enc->parent);
> +	}
>  
>  	if (phys_enc->hw_intf->ops.program_intf_cmd_cfg)
>  		phys_enc->hw_intf->ops.program_intf_cmd_cfg(phys_enc->hw_intf, &cmd_mode_cfg);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 8ec6505d9e78..dc6f3febb574 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -521,6 +521,9 @@ static void dpu_hw_intf_program_intf_cmd_cfg(struct dpu_hw_intf *ctx,
>  	if (cmd_mode_cfg->data_compress)
>  		intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
>  
> +	if (cmd_mode_cfg->wide_bus_en)
> +		intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN;
> +
>  	DPU_REG_WRITE(&ctx->hw, INTF_CONFIG2, intf_cfg2);
>  }
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> index 77f80531782b..c539025c418b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> @@ -50,6 +50,7 @@ struct dpu_hw_intf_status {
>  
>  struct dpu_hw_intf_cmd_mode_cfg {
>  	u8 data_compress;	/* enable data compress between dpu and dsi */
> +	u8 wide_bus_en;		/* enable databus widen mode */

Any clue why these weren't just bool types?  These suffix-comments also
aren't adhering to the kerneldoc format, or is there a different
variant?

>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 9d9d5e009163..e4f706b16aad 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -344,6 +344,7 @@ void msm_dsi_snapshot(struct msm_disp_state *disp_state, struct msm_dsi *msm_dsi
>  bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi);
>  bool msm_dsi_is_bonded_dsi(struct msm_dsi *msm_dsi);
>  bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi);
> +bool msm_dsi_is_widebus_enabled(struct msm_dsi *msm_dsi);
>  struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi);
>  #else
>  static inline void __init msm_dsi_register(void)
> @@ -373,7 +374,10 @@ static inline bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi)
>  {
>  	return false;
>  }
> -
> +static inline bool msm_dsi_is_widebus_enabled(struct msm_dsi *msm_dsi)
> +{
> +	return false;
> +}

Only this default inline implementation is defined, but the function is
declared in this commit.  Since there's no real functional
implementation yet your commit should clarify that it comes later (in a
followup commit in the same series?  I can't know because I am reviewing
this series linearly from start to finish...) or reorder the patches so
that this lack of clarity is circumvented entirely.

- Marijn

>  static inline struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
>  {
>  	return NULL;
> 
> -- 
> 2.41.0
> 
