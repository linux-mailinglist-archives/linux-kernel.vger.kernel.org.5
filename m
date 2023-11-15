Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077127EBE3A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjKOHui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:50:37 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B47EB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:50:31 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7fb84f6ceso67583057b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700034605; x=1700639405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=szNzf3TziCDjn07w7Co5x4GuOTJZ147mPXn70ydV0Fc=;
        b=H2tevRuhUg8rZ3mh2QJISuMPyLP3zm0s1dS9myFgCb5aH/MPS57GSlB/7Ugdgwl1hz
         aQUa0YCMUKlpc7L6j+8YrZ0YNg2cpSg1VfT05RBZUKg2suRG/oAFr4krJ2Rs0CR18j9Z
         9ZX6E5EONYCGwF/2sYY8c/JfwM3uSS7Rzk+/1p1u+elHTchZnpH13OWkKhislekrxsp6
         0D+Naxz2VxVum2a5TYSe0YjbUoh5M1QfdQ2CwBc82JPj0SkY/GLPnsDVvUJFMwtux4tK
         JgL4z/yv0OSuQtGmQ4q8Y8Spwobax+WoYNnrfU7Nep0HoKhYOSCZWvo4nVFgvnrhoK8w
         BhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700034605; x=1700639405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szNzf3TziCDjn07w7Co5x4GuOTJZ147mPXn70ydV0Fc=;
        b=m+x1UUTpHjD0OUuKw+L5+/0hRClPluQ5e4lZGACkZS7r7N7pbp8iAd/JuTCyW0QNTk
         3VE1VOrZByAkDpf0V7nxf2ucW9kvEyeIcdgBRK5UXcodw2dnxmbVxstdTJ9otJS4rH9G
         MOAXKLpSU1R2g0GeCKETxzBDEwUZ1CK+jwSAS2D2K8pvONLXuY2Q2BT+1xZ7ESDtWnUa
         4vHKlo35KV1QvSwILzEY8Q9WRWgRD7WQwkrDN5uZC2xCQnUKOPnFp0A5CpEpcPIU7Kav
         cYM/uEUmMM1zOECB3Lt2LvaQbeki/SjpDDeV1fPVycrArt8+fOGLqd8udHbU30XUtF6T
         1joQ==
X-Gm-Message-State: AOJu0YwOlrsWstSy0y0k3sXqkDfNN/em8iTT9vPmDPcpLurfaEZG9OYm
        VZvQhtBwQh38jVjOs2NSvfRm+599CYZE892IVzWOyQ==
X-Google-Smtp-Source: AGHT+IEc0IFGiK/VHdrtUp2bYG5Nd+RNP50AF9G1vJZw1swnpfCR6PG3rbrYblbH8j939AdgT7mcBftCJHWCRtrOUS0=
X-Received: by 2002:a81:8ac5:0:b0:5a8:22bc:1867 with SMTP id
 a188-20020a818ac5000000b005a822bc1867mr9183960ywg.26.1700034604843; Tue, 14
 Nov 2023 23:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20231114225857.19702-1-jonathan@marek.ca> <20231114225857.19702-6-jonathan@marek.ca>
In-Reply-To: <20231114225857.19702-6-jonathan@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Nov 2023 09:49:53 +0200
Message-ID: <CAA8EJpr7Qx356OM7W+3iumwgBqXyjM3_zuKnEGqM85JZ+BsE6A@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 01:00, Jonathan Marek <jonathan@marek.ca> wrote:
>
> Add a dsc_slice_per_pkt field to mipi_dsi_device struct and the necessary
> changes to msm driver to support this field.
>
> Note that the removed "pkt_per_line = slice_per_intf * slice_per_pkt"
> comment is incorrect.
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 25 ++++++++++---------------
>  include/drm/drm_mipi_dsi.h         |  1 +
>  2 files changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 842765063b1b..892a463a7e03 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -161,6 +161,7 @@ struct msm_dsi_host {
>
>         struct drm_display_mode *mode;
>         struct drm_dsc_config *dsc;
> +       unsigned int dsc_slice_per_pkt;
>
>         /* connected device info */
>         unsigned int channel;
> @@ -857,17 +858,10 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>         slice_per_intf = msm_dsc_get_slices_per_intf(dsc, hdisplay);
>
>         total_bytes_per_intf = dsc->slice_chunk_size * slice_per_intf;
> -       bytes_per_pkt = dsc->slice_chunk_size; /* * slice_per_pkt; */
> +       bytes_per_pkt = dsc->slice_chunk_size * msm_host->dsc_slice_per_pkt;
>
>         eol_byte_num = total_bytes_per_intf % 3;
> -
> -       /*
> -        * Typically, pkt_per_line = slice_per_intf * slice_per_pkt.
> -        *
> -        * Since the current driver only supports slice_per_pkt = 1,
> -        * pkt_per_line will be equal to slice per intf for now.
> -        */
> -       pkt_per_line = slice_per_intf;
> +       pkt_per_line = slice_per_intf / msm_host->dsc_slice_per_pkt;
>
>         if (is_cmd_mode) /* packet data type */
>                 reg = DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE(MIPI_DSI_DCS_LONG_WRITE);
> @@ -1004,12 +998,8 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>                 else
>                         /*
>                          * When DSC is enabled, WC = slice_chunk_size * slice_per_pkt + 1.
> -                        * Currently, the driver only supports default value of slice_per_pkt = 1
> -                        *
> -                        * TODO: Expand mipi_dsi_device struct to hold slice_per_pkt info
> -                        *       and adjust DSC math to account for slice_per_pkt.
>                          */
> -                       wc = msm_host->dsc->slice_chunk_size + 1;
> +                       wc = msm_host->dsc->slice_chunk_size * msm_host->dsc_slice_per_pkt + 1;
>
>                 dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL,
>                         DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |
> @@ -1636,8 +1626,13 @@ static int dsi_host_attach(struct mipi_dsi_host *host,
>         msm_host->lanes = dsi->lanes;
>         msm_host->format = dsi->format;
>         msm_host->mode_flags = dsi->mode_flags;
> -       if (dsi->dsc)
> +       if (dsi->dsc) {
>                 msm_host->dsc = dsi->dsc;
> +               msm_host->dsc_slice_per_pkt = dsi->dsc_slice_per_pkt;
> +               /* for backwards compatibility, assume 1 if not set */
> +               if (!msm_host->dsc_slice_per_pkt)
> +                       msm_host->dsc_slice_per_pkt = 1;
> +       }
>
>         /* Some gpios defined in panel DT need to be controlled by host */
>         ret = dsi_host_init_panel_gpios(msm_host, &dsi->dev);
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index c9df0407980c..3e32fa52d94b 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -193,6 +193,7 @@ struct mipi_dsi_device {
>         unsigned long hs_rate;
>         unsigned long lp_rate;
>         struct drm_dsc_config *dsc;
> +       unsigned int dsc_slice_per_pkt;

Missing documentation. Also maybe this chunk should go into a separate
patch so that it can gain more attention from DRM maintainers?

>  };
>
>  #define MIPI_DSI_MODULE_PREFIX "mipi-dsi:"
> --
> 2.26.1
>


-- 
With best wishes
Dmitry
