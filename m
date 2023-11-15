Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF267EBEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 09:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343549AbjKOIyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 03:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjKOIyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 03:54:14 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C6B10D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:54:11 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7c08b7744so76092467b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700038450; x=1700643250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pbjo3TAguD6KXTLjuIu3/cGWUkxEw1wpK/hlHSFO3xI=;
        b=RdVhUjtjWAOIWhbILGuRKTqsjSOsDyDly2j97hOA5sKakHY2FTVpkaGPiRyv67wdXu
         XxhkI582JxhCTo4N2zLuPOvXRj5HMgslTbSq9pffZlz8sZ3g9mrfWH7IUS1mgAAUbT+v
         TpBaw7QIvJM45kGR3KfHKSvvb3x+2kaGTdaou40ShIpRFA3Msh5M/DajwzhdUOLSROZ/
         Wr9Fr8AFiNB4hXDml7DM3h8AbE3qAlf/BrNaUPYlw9y3p48EoadDL4AUstDwp/jTo6cZ
         Q+s+Br7le+1cgnw7qmkW3YR/ZuKpf4G4I8LO+rD9N90QOdhNKsPpdqKUvlRRN//fejam
         u4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700038450; x=1700643250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pbjo3TAguD6KXTLjuIu3/cGWUkxEw1wpK/hlHSFO3xI=;
        b=Ip/6WR5aI8M0HHOF8CNHiqNuJKUyN1IkQDB2RK9GMJneOM2u+9V637vL8gbbVJA6iu
         z1QImTdnlgfi0WfY/dnuhx/v8oNGh2iaEakFRmo4Qvob6fvv7uBqiL9vrEEcj/zoY3f/
         Ey1saYofDxh9VdWKM3JxeCKogmM0ncSsJSfVk3A06YIyiXzOx9s7aEe6xl1TnuiPrJeP
         b9OjUWrm6y8dRJp7GSaVjqz3ZJmIBwZIZb9S0DSGfMMsZKofPe5VRK9bDaeJgdhrjfJu
         eMa3f7n9Emih6svRiCI5T8h9E7E/g/FkEqBWVghqY7ukVtpz9rKPRqVjwLiqEWZZogMy
         i9mg==
X-Gm-Message-State: AOJu0Ywftv1kswOLzZJlWeDtTD7FA2gkOb2mV6J92JGc8RjBVVzOlHfu
        v3yd3uiy14MuFT9wOfNZVa6bBaQ350QkIFhrvHZ8Eg==
X-Google-Smtp-Source: AGHT+IEDMvHcwrOwIhCANMLXvIPUaFUum2/1YHpZwaESZfy2I2Os/5+HMHREWDFFhrgyeOeFEN55Ab6h3bYKn0zn45o=
X-Received: by 2002:a0d:f9c6:0:b0:5be:9a1e:5864 with SMTP id
 j189-20020a0df9c6000000b005be9a1e5864mr10921663ywf.10.1700038450409; Wed, 15
 Nov 2023 00:54:10 -0800 (PST)
MIME-Version: 1.0
References: <20231114225857.19702-1-jonathan@marek.ca> <20231114225857.19702-2-jonathan@marek.ca>
In-Reply-To: <20231114225857.19702-2-jonathan@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Nov 2023 10:53:59 +0200
Message-ID: <CAA8EJpp0OGkgf0P6LcwE-H6BVN9kbtF_eRCsef+7NgDFmJOZfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] drm/msm/dpu: fix video mode DSC for DSI
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnaud Vrac <rawoul@gmail.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 01:00, Jonathan Marek <jonathan@marek.ca> wrote:
>
> Add necessary DPU changes for DSC to work with DSI video mode.
>
> Note this changes the logic to enable HCTL to match downstream, it will
> now be enabled for the no-DSC no-widebus case.
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c         |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h    |  2 +-
>  .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c    | 11 +++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c         | 13 ++++++++++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h         |  1 +
>  5 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 1cf7ff6caff4..d745c8678b9d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -2477,7 +2477,7 @@ enum dpu_intf_mode dpu_encoder_get_intf_mode(struct drm_encoder *encoder)
>         return INTF_MODE_NONE;
>  }
>
> -unsigned int dpu_encoder_helper_get_dsc(struct dpu_encoder_phys *phys_enc)
> +unsigned int dpu_encoder_helper_get_dsc(const struct dpu_encoder_phys *phys_enc)

Why?

>  {
>         struct drm_encoder *encoder = phys_enc->parent;
>         struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(encoder);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> index 6f04c3d56e77..7e27a7da0887 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> @@ -332,7 +332,7 @@ static inline enum dpu_3d_blend_mode dpu_encoder_helper_get_3d_blend_mode(
>   *   used for this encoder.
>   * @phys_enc: Pointer to physical encoder structure
>   */
> -unsigned int dpu_encoder_helper_get_dsc(struct dpu_encoder_phys *phys_enc);
> +unsigned int dpu_encoder_helper_get_dsc(const struct dpu_encoder_phys *phys_enc);
>
>  /**
>   * dpu_encoder_helper_split_config - split display configuration helper function
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index a01fda711883..df10800a9615 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -100,6 +100,8 @@ static void drm_mode_to_intf_timing_params(
>         }
>
>         timing->wide_bus_en = dpu_encoder_is_widebus_enabled(phys_enc->parent);
> +       if (dpu_encoder_helper_get_dsc(phys_enc))
> +               timing->compression_en = true;
>
>         /*
>          * for DP, divide the horizonal parameters by 2 when
> @@ -112,6 +114,15 @@ static void drm_mode_to_intf_timing_params(
>                 timing->h_front_porch = timing->h_front_porch >> 1;
>                 timing->hsync_pulse_width = timing->hsync_pulse_width >> 1;
>         }
> +
> +       /*
> +        * for DSI, if compression is enabled, then divide the horizonal active
> +        * timing parameters by compression ratio.
> +        */
> +       if (phys_enc->hw_intf->cap->type != INTF_DP && timing->compression_en) {
> +               timing->width = timing->width / 3; /* XXX: don't assume 3:1 compression ratio */

Is this /3 from bpp / compressed_bpp?

> +               timing->xres = timing->width;
> +       }
>  }
>
>  static u32 get_horizontal_total(const struct dpu_hw_intf_timing_params *timing)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index e8b8908d3e12..d6fe45a6da2d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -166,10 +166,21 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>          * video timing. It is recommended to enable it for all cases, except
>          * if compression is enabled in 1 pixel per clock mode
>          */
> +       if (!p->compression_en || p->wide_bus_en)
> +               intf_cfg2 |= INTF_CFG2_DATA_HCTL_EN;
> +
>         if (p->wide_bus_en)
> -               intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN | INTF_CFG2_DATA_HCTL_EN;
> +               intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN;
>
>         data_width = p->width;
> +       if (p->wide_bus_en && !dp_intf)
> +               data_width = p->width >> 1;
> +
> +       if (p->compression_en)
> +               intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
> +
> +       if (p->compression_en && dp_intf)
> +               DPU_ERROR("missing adjustments for DSC+DP\n");
>
>         hsync_data_start_x = hsync_start_x;
>         hsync_data_end_x =  hsync_start_x + data_width - 1;

This should go into a separate commit with the proper justification.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> index c539025c418b..15a5fdadd0a0 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> @@ -33,6 +33,7 @@ struct dpu_hw_intf_timing_params {
>         u32 hsync_skew;
>
>         bool wide_bus_en;
> +       bool compression_en;
>  };
>
>  struct dpu_hw_intf_prog_fetch {
> --
> 2.26.1
>


-- 
With best wishes
Dmitry
