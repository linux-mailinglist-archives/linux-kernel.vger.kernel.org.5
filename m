Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C93180A27E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjLHLoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjLHLoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:44:23 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC7511D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:44:29 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-db538b07865so2273069276.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702035869; x=1702640669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XustoibYb7jZ112VBHJcFTHqwrwSxZE4Gta6N7Rgvsk=;
        b=HruYTDrlsSiTsQqNoC2rstY0VoQXoOTtA6SNjTbwszI6L8rRY09KHAGSBZbemuvApK
         IVmTUoezOoCWX/b6IMxstcQ+0cH5c4GM+Tc5/M8aDu9nJmFuc41UU6al9571vNpszzg4
         /tH0YGZtMVwL7bduLKVg7dEiyX0k1SnbxQnnluPuLmO4tjRnM1Q5I6H8Z7sahRDKd8hA
         8mEOib6PqrQ45m1l80iG1dFL/Dq7XxMbb0g5CAe83nPK7NESZeu7dyBWzB6Nftg/Pgnm
         12ePpMHu4qkR2JWsOkJ5ewkDVuI8jrm8Jlr9/i5agxEmBEzFLj3dapOE2upy/fQx/P2O
         HquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702035869; x=1702640669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XustoibYb7jZ112VBHJcFTHqwrwSxZE4Gta6N7Rgvsk=;
        b=l/aI9IdPKCc27YJkczfG4pDwpUCiW0ocdbX4oNxUJBiPvqjkL8FkNW0kGw3H3hSdDv
         mQpfe3N8WhkLxt/hfrtxz79nbUksAMRJx65kfjkDVD3p6s89oe59wrHbCml8HSlsDUkj
         HgRNr0cc1i5ACr/kMEaBpgOizrBeaE+smguGOdyxLK9mD/iQGZeuMRQWJ7jmXoxcedAq
         T13P13ifPuxjErzEOEnGyJ/9iS/cAhBinOT2KAV0/mgqTUlpFjqTbcChu2yLC+gQpYJc
         5d3ycdIsiomwqFq8viBbNMnfEqza2sjzcQzYq1bUijAUkdmx1joljQtmIbQqc2mn9+Lc
         foZA==
X-Gm-Message-State: AOJu0YydKC4dUJmHeXMv3RPKx0irdR8g1D5ZXraf9NLGy4Sx+tCAX33B
        Zqaqp9S7Tm9zhJ7AhYkgOTkSYHEGDnYfo1+7TomDBA==
X-Google-Smtp-Source: AGHT+IE6ALLhH1k654jYWCbrlhD/X7i139Ly4BPDxq1XcXtit7oJT0kaLgyma1vwYX6I18i9zNeuXYotNU4PMVF46Mk=
X-Received: by 2002:a25:ae41:0:b0:db5:3f82:8d1f with SMTP id
 g1-20020a25ae41000000b00db53f828d1fmr3671315ybe.36.1702035868831; Fri, 08 Dec
 2023 03:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20231208050641.32582-1-quic_abhinavk@quicinc.com> <20231208050641.32582-16-quic_abhinavk@quicinc.com>
In-Reply-To: <20231208050641.32582-16-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 8 Dec 2023 13:44:18 +0200
Message-ID: <CAA8EJpqfCfETawp1up76S6gryO+Q4KxPB3ThwZCe7DCkp=GkBQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] drm/msm/dpu: introduce separate wb2_format
 arrays for rgb and yuv
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 07:07, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Lets rename the existing wb2_formats array wb2_formats_rgb to indicate
> that it has only RGB formats and can be used on any chipset having a WB
> block.
>
> Introduce a new wb2_formats_rgb_yuv array to the catalog to
> indicate support for YUV formats to writeback in addition to RGB.
>
> Chipsets which have support for CDM block will use the newly added
> wb2_formats_rgb_yuv array.

This means that the catalog can go out of sync, if one adds a CDM
block but doesn't update wb_formats and vice versa.
Can we deduce the format list from the WB code? Is the format list
really static or does it change between platforms (please keep msm8996
/ msm8998 in mind).

>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  .../msm/disp/dpu1/catalog/dpu_10_0_sm8650.h   |  4 +-
>  .../msm/disp/dpu1/catalog/dpu_6_0_sm8250.h    |  4 +-
>  .../msm/disp/dpu1/catalog/dpu_6_2_sc7180.h    |  4 +-
>  .../msm/disp/dpu1/catalog/dpu_7_2_sc7280.h    |  4 +-
>  .../msm/disp/dpu1/catalog/dpu_9_0_sm8550.h    |  4 +-
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 37 ++++++++++++++++++-
>  6 files changed, 46 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
> index 04d2a73dd942..eb5dfff2ec4f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
> @@ -341,8 +341,8 @@ static const struct dpu_wb_cfg sm8650_wb[] = {
>                 .name = "wb_2", .id = WB_2,
>                 .base = 0x65000, .len = 0x2c8,
>                 .features = WB_SM8250_MASK,
> -               .format_list = wb2_formats,
> -               .num_formats = ARRAY_SIZE(wb2_formats),
> +               .format_list = wb2_formats_rgb,
> +               .num_formats = ARRAY_SIZE(wb2_formats_rgb),
>                 .xin_id = 6,
>                 .vbif_idx = VBIF_RT,
>                 .maxlinewidth = 4096,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
> index 58b0f50518c8..a57d50b1f028 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
> @@ -336,8 +336,8 @@ static const struct dpu_wb_cfg sm8250_wb[] = {
>                 .name = "wb_2", .id = WB_2,
>                 .base = 0x65000, .len = 0x2c8,
>                 .features = WB_SM8250_MASK,
> -               .format_list = wb2_formats,
> -               .num_formats = ARRAY_SIZE(wb2_formats),
> +               .format_list = wb2_formats_rgb_yuv,
> +               .num_formats = ARRAY_SIZE(wb2_formats_rgb_yuv),
>                 .clk_ctrl = DPU_CLK_CTRL_WB2,
>                 .xin_id = 6,
>                 .vbif_idx = VBIF_RT,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
> index bcfedfc8251a..7382ebb6e5b2 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
> @@ -157,8 +157,8 @@ static const struct dpu_wb_cfg sc7180_wb[] = {
>                 .name = "wb_2", .id = WB_2,
>                 .base = 0x65000, .len = 0x2c8,
>                 .features = WB_SM8250_MASK,
> -               .format_list = wb2_formats,
> -               .num_formats = ARRAY_SIZE(wb2_formats),
> +               .format_list = wb2_formats_rgb,
> +               .num_formats = ARRAY_SIZE(wb2_formats_rgb),
>                 .clk_ctrl = DPU_CLK_CTRL_WB2,
>                 .xin_id = 6,
>                 .vbif_idx = VBIF_RT,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> index 19c2b7454796..2f153e0b5c6a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
> @@ -169,8 +169,8 @@ static const struct dpu_wb_cfg sc7280_wb[] = {
>                 .name = "wb_2", .id = WB_2,
>                 .base = 0x65000, .len = 0x2c8,
>                 .features = WB_SM8250_MASK,
> -               .format_list = wb2_formats,
> -               .num_formats = ARRAY_SIZE(wb2_formats),
> +               .format_list = wb2_formats_rgb_yuv,
> +               .num_formats = ARRAY_SIZE(wb2_formats_rgb_yuv),
>                 .clk_ctrl = DPU_CLK_CTRL_WB2,
>                 .xin_id = 6,
>                 .vbif_idx = VBIF_RT,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> index bf56265967c0..ad48defa154f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> @@ -315,8 +315,8 @@ static const struct dpu_wb_cfg sm8550_wb[] = {
>                 .name = "wb_2", .id = WB_2,
>                 .base = 0x65000, .len = 0x2c8,
>                 .features = WB_SM8250_MASK,
> -               .format_list = wb2_formats,
> -               .num_formats = ARRAY_SIZE(wb2_formats),
> +               .format_list = wb2_formats_rgb,
> +               .num_formats = ARRAY_SIZE(wb2_formats_rgb),
>                 .xin_id = 6,
>                 .vbif_idx = VBIF_RT,
>                 .maxlinewidth = 4096,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 1be3156cde05..c52cac7a2288 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -202,7 +202,7 @@ static const u32 rotation_v2_formats[] = {
>         /* TODO add formats after validation */
>  };
>
> -static const uint32_t wb2_formats[] = {
> +static const uint32_t wb2_formats_rgb[] = {
>         DRM_FORMAT_RGB565,
>         DRM_FORMAT_BGR565,
>         DRM_FORMAT_RGB888,
> @@ -236,6 +236,41 @@ static const uint32_t wb2_formats[] = {
>         DRM_FORMAT_XBGR4444,
>  };
>
> +static const uint32_t wb2_formats_rgb_yuv[] = {
> +       DRM_FORMAT_RGB565,
> +       DRM_FORMAT_BGR565,
> +       DRM_FORMAT_RGB888,
> +       DRM_FORMAT_ARGB8888,
> +       DRM_FORMAT_RGBA8888,
> +       DRM_FORMAT_ABGR8888,
> +       DRM_FORMAT_XRGB8888,
> +       DRM_FORMAT_RGBX8888,
> +       DRM_FORMAT_XBGR8888,
> +       DRM_FORMAT_ARGB1555,
> +       DRM_FORMAT_RGBA5551,
> +       DRM_FORMAT_XRGB1555,
> +       DRM_FORMAT_RGBX5551,
> +       DRM_FORMAT_ARGB4444,
> +       DRM_FORMAT_RGBA4444,
> +       DRM_FORMAT_RGBX4444,
> +       DRM_FORMAT_XRGB4444,
> +       DRM_FORMAT_BGR565,
> +       DRM_FORMAT_BGR888,
> +       DRM_FORMAT_ABGR8888,
> +       DRM_FORMAT_BGRA8888,
> +       DRM_FORMAT_BGRX8888,
> +       DRM_FORMAT_XBGR8888,
> +       DRM_FORMAT_ABGR1555,
> +       DRM_FORMAT_BGRA5551,
> +       DRM_FORMAT_XBGR1555,
> +       DRM_FORMAT_BGRX5551,
> +       DRM_FORMAT_ABGR4444,
> +       DRM_FORMAT_BGRA4444,
> +       DRM_FORMAT_BGRX4444,
> +       DRM_FORMAT_XBGR4444,
> +       DRM_FORMAT_NV12,
> +};
> +
>  /*************************************************************
>   * SSPP sub blocks config
>   *************************************************************/
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
