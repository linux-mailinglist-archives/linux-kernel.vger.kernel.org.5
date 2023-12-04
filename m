Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AF480411E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjLDVrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDVq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:46:58 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD7FCD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:47:02 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4F1B01FC57;
        Mon,  4 Dec 2023 22:46:57 +0100 (CET)
Date:   Mon, 4 Dec 2023 22:46:55 +0100
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
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] drm/msm/dsi: set video mode widebus enable bit
 when widebus is enabled
Message-ID: <ghozqqj3ka6ntbofbpol2zf6sa7lt5ppqnsmnqbvqr5nwgx4ox@5kndla2nf54n>
References: <20231114225857.19702-1-jonathan@marek.ca>
 <20231114225857.19702-3-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114225857.19702-3-jonathan@marek.ca>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-14 17:58:30, Jonathan Marek wrote:
> The value returned by msm_dsi_wide_bus_enabled() doesn't match what the
> driver is doing in video mode. Fix that by actually enabling widebus for
> video mode.
> 
> Fixes: efcbd6f9cdeb ("drm/msm/dsi: Enable widebus for DSI")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Conditional r-b assuming this will be submitted to mesa, otherwise it'll
disappear when the next person updates and regenerates these bindings.

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpu/drm/msm/dsi/dsi.xml.h  | 1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.xml.h b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> index 2a7d980e12c3..f0b3cdc020a1 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.xml.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> @@ -231,6 +231,7 @@ static inline uint32_t DSI_VID_CFG0_TRAFFIC_MODE(enum dsi_traffic_mode val)
>  #define DSI_VID_CFG0_HSA_POWER_STOP				0x00010000
>  #define DSI_VID_CFG0_HBP_POWER_STOP				0x00100000
>  #define DSI_VID_CFG0_HFP_POWER_STOP				0x01000000
> +#define DSI_VID_CFG0_DATABUS_WIDEN				0x02000000
>  #define DSI_VID_CFG0_PULSE_MODE_HSA_HE				0x10000000
>  
>  #define REG_DSI_VID_CFG1					0x0000001c
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index deeecdfd6c4e..f2c1cbd08d4d 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -745,6 +745,8 @@ static void dsi_ctrl_enable(struct msm_dsi_host *msm_host,
>  		data |= DSI_VID_CFG0_TRAFFIC_MODE(dsi_get_traffic_mode(flags));
>  		data |= DSI_VID_CFG0_DST_FORMAT(dsi_get_vid_fmt(mipi_fmt));
>  		data |= DSI_VID_CFG0_VIRT_CHANNEL(msm_host->channel);
> +		if (msm_dsi_host_is_wide_bus_enabled(&msm_host->base))
> +			data |= DSI_VID_CFG0_DATABUS_WIDEN;
>  		dsi_write(msm_host, REG_DSI_VID_CFG0, data);
>  
>  		/* Do not swap RGB colors */
> -- 
> 2.26.1
> 
