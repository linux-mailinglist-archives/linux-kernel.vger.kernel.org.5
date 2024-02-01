Return-Path: <linux-kernel+bounces-47461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573C3844E40
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639B81C23422
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BA03FDB;
	Thu,  1 Feb 2024 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aANuj/m8"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A152114
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749561; cv=none; b=eN0j/YRHjA7aNPj5MClIy35Wsj5aADyJwNDxZUvh9SU+fA0ZrebSehQ0ozuS25dMjNKCo+6T1x2TKdFUhdapfPcEtU67VNKHtPTErtEK8zpsUqAGptzRgcYmBgwM1Op7jsbwS5TMK6G6yDRkNhT7jwPuiQzl0+bJOu0fyL79G5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749561; c=relaxed/simple;
	bh=jfAgTK4FWkM81+8lgHiaLuVDHEluyhg55DBX/mVWYUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQi/Vnwhgx5tBY4tc1Zsxx6SKa2WMixCn8Ld0XkyhVMAfCM76EOZJ3lzSVrpVlH9T9oBrXN+khFIUJbeDaqOxFmf9ZvlAaP7exzGHRDZBmsS6ZMSn06pUntkUmc6LqgaDdPNkkwJjedxZTnWn1+6HcG70AnTNTCm+d/2Y1g00sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aANuj/m8; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60412a23225so3972247b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706749558; x=1707354358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MiJfKuLh0ReoY4qt8Rcgd+MaO8ThKHNzK3ZyVm/U3ws=;
        b=aANuj/m8/5kGZRjqAIvAnwzFIlnHuIF1MQW2c2ZFCOJ0V6XpYoA9BGjue+1oSgrqyD
         goFTMeVhJzhE7B4pqOe19Nj3vRPdMRLh7liXLdAY2mYVr/7Iw05ALeFQYj85Mgl25i/5
         XcK+isr0qqtDVVQyWi5rUUrs5aKRr8nDo7LR2tJQ57qA2w7pIIcErHZo5aWYmuq5dkAF
         OrUhhjHhXN7utmUrzwayOgCkLD8yRpySJ6wmhSzrA7xq/wUbTuOpTQ1PRNgXwIko/7Cn
         bBPmWrpMPRSByn7/rG/m6B6IXYFpTgliQErt+0eO+ii1WEppSeCV9ucHpPrwyuRcnjh8
         2Fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706749558; x=1707354358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiJfKuLh0ReoY4qt8Rcgd+MaO8ThKHNzK3ZyVm/U3ws=;
        b=NwHi7HIyIG0yM/xInW6/R1lOHKfMQpsoUpATsOck83x0pfGI2ZYVx4iCpf+J6HJgSj
         m+vyLD8KoCI4M7R+Q1RDSTGe2K5UvPeJaOidVD6vC/hgnYM5xY5YWjmWG3q+oi1sfo9k
         Wlgo4D/ASufomqf5GTWAJCnzwUr4AqCch56AM+G+RATHSR9eup4qSIu966LDwWzvDfCM
         WHFuoqd5B1vI2lnDrNtNUoTDJcHcNMpO5EtOIFku7XxrgGJVGz5id07tXbfg7SAcJY6C
         U4gnALMcarRYg5X7KWK2hR9HHmu9xw0AKZmTRBwkgs/8S+hbIucUic8EN4n4tFrfGUBI
         j3rg==
X-Gm-Message-State: AOJu0YxP7SMjze8O8ekaBR2rDUDPBkDaeXLIJgh7aJTMjsTPpRdaP3WF
	55YKWRuY95jwYoQFYmmDIe1TBP23qgww64kO4U8livC9cBTlXEht+V3KKu25H423jXiowmZzH3B
	6Xtej2na59OBnOjhEOoPtGv4Ek1NAzCYBwWE1Fw==
X-Google-Smtp-Source: AGHT+IESNgSAKisM93yefyhvpq+nkBlr7eYYAtyVS7Xq+pTa0xcg9+3f75rHn9uaV33udWIAlqA0sRA0UBgZm5qqp6U=
X-Received: by 2002:a81:9bd4:0:b0:604:bf4:97df with SMTP id
 s203-20020a819bd4000000b006040bf497dfmr2977198ywg.52.1706749558318; Wed, 31
 Jan 2024 17:05:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201004737.2478-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20240201004737.2478-1-quic_abhinavk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 1 Feb 2024 03:05:47 +0200
Message-ID: <CAA8EJpqG8C=ydpE_w7mWN-PJoAcOyZjQ5J1e7QoVY=MBUkWMxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: fix the programming of INTF_CFG2_DATA_HCTL_EN
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, dri-devel@lists.freedesktop.org, 
	seanpaul@chromium.org, quic_jesszhan@quicinc.com, quic_parellan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 02:48, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Currently INTF_CFG2_DATA_HCTL_EN is coupled with the enablement
> of widebus but this is incorrect because we should be enabling
> this bit independent of widebus except for cases where compression
> is enabled in one pixel per clock mode.
>
> Fix this by making the condition checks more explicit and enabling
> INTF_CFG2_DATA_HCTL_EN for all other cases when supported by DPU.
>
> Fixes: 3309a7563971 ("drm/msm/dpu: revise timing engine programming to support widebus feature")
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Thank you!

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

For the reference: although it is marked as a fix, I'd prefer if this
patch undergoes a full cycle through msm-next rather than
fast-tracking through msm-fixes. This would allow us to catch possible
issues. WDYT?

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c       |  7 +++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h       |  7 +++++++
>  .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |  1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c       | 15 +++++++++------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h       |  1 +
>  5 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 83380bc92a00..467f874979d5 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -230,6 +230,13 @@ bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc)
>         return dpu_enc->wide_bus_en;
>  }
>
> +bool dpu_encoder_is_dsc_enabled(const struct drm_encoder *drm_enc)
> +{
> +       const struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
> +
> +       return dpu_enc->dsc ? true : false;
> +}
> +
>  int dpu_encoder_get_crc_values_cnt(const struct drm_encoder *drm_enc)
>  {
>         struct dpu_encoder_virt *dpu_enc;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index 4c05fd5e9ed1..fe6b1d312a74 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -158,6 +158,13 @@ int dpu_encoder_get_vsync_count(struct drm_encoder *drm_enc);
>
>  bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc);
>
> +/**
> + * dpu_encoder_is_dsc_enabled - indicate whether dsc is enabled
> + *                             for the encoder.
> + * @drm_enc:    Pointer to previously created drm encoder structure
> + */
> +bool dpu_encoder_is_dsc_enabled(const struct drm_encoder *drm_enc);
> +
>  /**
>   * dpu_encoder_get_crc_values_cnt - get number of physical encoders contained
>   *     in virtual encoder that can collect CRC values
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index d0f56c5c4cce..f562beb6f797 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -102,6 +102,7 @@ static void drm_mode_to_intf_timing_params(
>         }
>
>         timing->wide_bus_en = dpu_encoder_is_widebus_enabled(phys_enc->parent);
> +       timing->compression_en = dpu_encoder_is_dsc_enabled(phys_enc->parent);
>
>         /*
>          * for DP, divide the horizonal parameters by 2 when
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 6bba531d6dc4..965692ef7892 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -163,13 +163,8 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>         hsync_ctl = (hsync_period << 16) | p->hsync_pulse_width;
>         display_hctl = (hsync_end_x << 16) | hsync_start_x;
>
> -       /*
> -        * DATA_HCTL_EN controls data timing which can be different from
> -        * video timing. It is recommended to enable it for all cases, except
> -        * if compression is enabled in 1 pixel per clock mode
> -        */
>         if (p->wide_bus_en)
> -               intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN | INTF_CFG2_DATA_HCTL_EN;
> +               intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN;
>
>         data_width = p->width;
>
> @@ -229,6 +224,14 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>         DPU_REG_WRITE(c, INTF_CONFIG, intf_cfg);
>         DPU_REG_WRITE(c, INTF_PANEL_FORMAT, panel_format);
>         if (ctx->cap->features & BIT(DPU_DATA_HCTL_EN)) {
> +               /*
> +                * DATA_HCTL_EN controls data timing which can be different from
> +                * video timing. It is recommended to enable it for all cases, except
> +                * if compression is enabled in 1 pixel per clock mode
> +                */
> +               if (!(p->compression_en && !p->wide_bus_en))
> +                       intf_cfg2 |= INTF_CFG2_DATA_HCTL_EN;
> +
>                 DPU_REG_WRITE(c, INTF_CONFIG2, intf_cfg2);
>                 DPU_REG_WRITE(c, INTF_DISPLAY_DATA_HCTL, display_data_hctl);
>                 DPU_REG_WRITE(c, INTF_ACTIVE_DATA_HCTL, active_data_hctl);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> index 0bd57a32144a..6f4c87244f94 100644
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
> 2.40.1
>


-- 
With best wishes
Dmitry

