Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07F17EBE44
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjKOHzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:55:15 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBD5D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:55:12 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5afbdbf3a19so74434557b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700034911; x=1700639711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=15PRWbRTiCU1VNIlXZWdSysxSpbXy5GgKNCUAYG7W5w=;
        b=kYVIOtXsduV0G6R73xeKydwmue26qOc3V94V0DtkpqkS6xKwLVsnD2vOuDc7VSJRo5
         Pkx4w/YDBPRx0lkQiUcF5Sg9YOR/9A87JQZCKjzpvrk/39gkjJzkRHyagaMymnnmfoHP
         pV2iehewqEkXV13Xvm26JW+eTA28naUyFPZkFO8aZhZ730+GIIc1izzoQHXAHdPJEpXd
         zrB5b3bCgtDlwfAAxKxGsb8sSiaoJQb4AfvbOHxxjvQZ3uVPg1GmQMTYB22hqmmpI2H1
         BC4LeCXUMXP2LGa1rvheW/0hD2v/p0+4tTCDD4J1OY71kgBStn40wyedjCnpn60Dmr82
         7mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700034911; x=1700639711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15PRWbRTiCU1VNIlXZWdSysxSpbXy5GgKNCUAYG7W5w=;
        b=WDd8IZdnWcKYJkOvfBkHgGQq4cyJdxk/tHrIF/0NGYtOwmKPM6yzq78cFNFhq1zGZH
         IZIYrHkF5av6UPVB42z8kGyUC7Mkuk+At5k5ZKtkUkIcAG5eVNTUItLxIzCHjshE1Nes
         xwH+R1FSIhV7yaRsK4lkMQLeWJ6shDhnh5n9g+bt61DqYpFf43deKm/2R9DEutC+5Uqg
         IljH3LoDe6O1AVceUs03oena1z7Um344XquBCgiSRlrZbUefn2eUbaRrybPvuR9gAZp1
         nhua4s85wQit60rYikRckQFh+w+RhqRpmshm9ovmYmyEhKyVIw/92NMqbIIQcET9k6d2
         kR4A==
X-Gm-Message-State: AOJu0YxRGWoRHsheECbflGA0xr9x53p2M8mUHxl4rBX88y3wKNFz5xny
        sFRBmBM7qYsekl6freXX4/d+rfqbxrdZMFt2Lmb/3g==
X-Google-Smtp-Source: AGHT+IGF0QFxsq04qkcDH1xFplg+U57Jq/Gcno4gH3SYxLIhnKNkUwuqZj7ahhye+SflHFUwIXeq6RwbBxjolai3xoI=
X-Received: by 2002:a81:4f12:0:b0:59a:f131:50fa with SMTP id
 d18-20020a814f12000000b0059af13150famr13475836ywb.47.1700034911416; Tue, 14
 Nov 2023 23:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20231114225857.19702-1-jonathan@marek.ca> <20231114225857.19702-7-jonathan@marek.ca>
In-Reply-To: <20231114225857.19702-7-jonathan@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Nov 2023 09:55:00 +0200
Message-ID: <CAA8EJpr8DhKncsGV3hdtJk9DoTTyhi2x6+o55jTcVUFadfcMbg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/msm/dsi: fix DSC for the bonded DSI case
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Doug Anderson <dianders@chromium.org>,
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
> For the bonded DSI case, DSC pic_width and timing calculations should use
> the width of a single panel instead of the total combined width.
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Fixes tag?

I'll wait for the Tested-by by Marijn, otherwise LGTM.

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
>                                   const struct drm_display_mode *mode);
>  enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
> -                                           const struct drm_display_mode *mode);
> +                                           const struct drm_display_mode *mode,
> +                                           bool is_bonded_dsi);
>  unsigned long msm_dsi_host_get_mode_flags(struct mipi_dsi_host *host);
>  int msm_dsi_host_register(struct mipi_dsi_host *host);
>  void msm_dsi_host_unregister(struct mipi_dsi_host *host);
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 892a463a7e03..cf06736e5a60 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -940,8 +940,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>                                mode->hdisplay, mode->vdisplay);
>                         return;
>                 }
> -

Nit: keep it please.

> -               dsc->pic_width = mode->hdisplay;
> +               dsc->pic_width = hdisplay;
>                 dsc->pic_height = mode->vdisplay;
>                 DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);
>
> @@ -952,6 +951,11 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>                 if (ret)
>                         return;
>
> +               if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO)
> +                       dsi_update_dsc_timing(msm_host, false, hdisplay);
> +               else
> +                       dsi_update_dsc_timing(msm_host, true, hdisplay);
> +
>                 /* Divide the display by 3 but keep back/font porch and
>                  * pulse width same
>                  */
> @@ -968,9 +972,6 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>         }
>
>         if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) {
> -               if (msm_host->dsc)
> -                       dsi_update_dsc_timing(msm_host, false, mode->hdisplay);
> -
>                 dsi_write(msm_host, REG_DSI_ACTIVE_H,
>                         DSI_ACTIVE_H_START(ha_start) |
>                         DSI_ACTIVE_H_END(ha_end));
> @@ -989,9 +990,6 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>                         DSI_ACTIVE_VSYNC_VPOS_START(vs_start) |
>                         DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
>         } else {                /* command mode */
> -               if (msm_host->dsc)
> -                       dsi_update_dsc_timing(msm_host, true, mode->hdisplay);
> -
>                 /* image data and 1 byte write_memory_start cmd */
>                 if (!msm_host->dsc)
>                         wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
> @@ -2479,7 +2477,8 @@ int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
>  }
>
>  enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
> -                                           const struct drm_display_mode *mode)
> +                                           const struct drm_display_mode *mode,
> +                                           bool is_bonded_dsi)
>  {
>         struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>         struct drm_dsc_config *dsc = msm_host->dsc;
> @@ -2489,6 +2488,9 @@ enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
>         if (!msm_host->dsc)
>                 return MODE_OK;
>
> +       if (is_bonded_dsi)
> +               pic_width = mode->hdisplay / 2;
> +
>         if (pic_width % dsc->slice_width) {
>                 pr_err("DSI: pic_width %d has to be multiple of slice %d\n",
>                        pic_width, dsc->slice_width);
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index 896f369fdd53..2ca1a7ca3659 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -455,7 +455,7 @@ static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,
>                         return MODE_ERROR;
>         }
>
> -       return msm_dsi_host_check_dsc(host, mode);
> +       return msm_dsi_host_check_dsc(host, mode, IS_BONDED_DSI());
>  }
>
>  static const struct drm_bridge_funcs dsi_mgr_bridge_funcs = {
> --
> 2.26.1
>


-- 
With best wishes
Dmitry
