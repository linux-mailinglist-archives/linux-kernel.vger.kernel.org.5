Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192A57EBDC7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjKOHVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:21:15 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8123D1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:21:11 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5bf5d6eaf60so68888327b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700032871; x=1700637671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0vD1Bck5HDYUM72yjoV0Q8qgtg6QFL0VXndDmXOf70I=;
        b=vGTOeYXkXO7B5xaZcJzyfPyusCnJ3iFNzHKCmrYZpCAwqvBFF48WmoRFWP3L4paAUx
         JyTF1/QksxnKvzRIwsqNoEWEC09+2duksCi/Aj8g2SbcDEDtm2LtlNl0/7UzC/pcnHog
         tP73IDVf0iahAJbzv5V1zG0hMXfYTIapZLYs142UuodfN6GYzdagRJG/n6ms8UWro5/i
         BrwsW0/UI3hxoXiVa4zarTW0kIs0LWB6jPDy7HOQUOSQv4nz6wvK3AZPx45ZrRw2gx3H
         kcFO5E7PCZPmABXz2zUojPEEvRjrMDKPrnuCjBzIDNvxC0dnLD3qRUvHV7PzhDqmBBs5
         lhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700032871; x=1700637671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vD1Bck5HDYUM72yjoV0Q8qgtg6QFL0VXndDmXOf70I=;
        b=DCvdHwlFOLj+ndWYr2GbYDkjg7UjsimktVuLHECXTf63ahhik+OVrtqIcWUgdLvrEP
         LsNtOIEEmbsFeGFqwliNzcrvg7HNha2dcgxoWH9OtqkPllpKVbQ/URtACKxqlTIi1rP7
         MjBE2WTy9yeGngLEJvFQOVbLbUVdUDIq25BSxZNxAPh+U0sp30NPXPPHnEOyjnoEkJgo
         5LUNKECOOJXd0mASIKnpB1aCI8zb48QbRBU97OpfteHkPS/VnrkI98F6crV69qNMoL1M
         67FfV0cj1thN8nCt9C5CLeqtrwVVYqsUgNFTQeyHBuaVSh48zFbYVYvyCMHGGt3pVUkT
         H8aQ==
X-Gm-Message-State: AOJu0YwBKAf7bhL8xAsMV4TWNaU3SAnK5gSym2kQLyCkwrjHftI8ACyF
        qQmAycsYGsSs5SoPMILQseUFbUnJIo1rJ8ITOjy7eg==
X-Google-Smtp-Source: AGHT+IEULgD391byZsXPtXNbPcw0yCylBtdnLApeQVAUxwBDpohA/yg4/aHXgsob+pZ1sRHJYNKdu3NZUuCiQiUASW8=
X-Received: by 2002:a25:107:0:b0:d81:89e9:9f48 with SMTP id
 7-20020a250107000000b00d8189e99f48mr10803617ybb.63.1700032871066; Tue, 14 Nov
 2023 23:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20231114225857.19702-1-jonathan@marek.ca> <20231114225857.19702-3-jonathan@marek.ca>
In-Reply-To: <20231114225857.19702-3-jonathan@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Nov 2023 09:20:59 +0200
Message-ID: <CAA8EJprADPYpJBUkq_TA381xntkfHbBVMm5h4qwwg+vM7GzzRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] drm/msm/dsi: set video mode widebus enable bit
 when widebus is enabled
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 01:00, Jonathan Marek <jonathan@marek.ca> wrote:
>
> The value returned by msm_dsi_wide_bus_enabled() doesn't match what the
> driver is doing in video mode. Fix that by actually enabling widebus for
> video mode.
>
> Fixes: efcbd6f9cdeb ("drm/msm/dsi: Enable widebus for DSI")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/dsi/dsi.xml.h  | 1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
>  2 files changed, 3 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
