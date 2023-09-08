Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA17992D7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345263AbjIHXaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242373AbjIHXaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:30:22 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7F818E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 16:30:18 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d776e1f181bso2300372276.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 16:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694215817; x=1694820617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PY75H1jflFjdwbxljuQ1fV6R6iCKvsQ0y9zdUNKFhfE=;
        b=p1DU6jt7ZZEORLJ0++qKRbOMtCemtkBDRBMupn6R4EunLIezSLm8dSLpx5qx2gy+BT
         okDO5dcT8Q7ijDqm3AWbHZO3ctVV1/ME8Q7qL5XRQv25saoSLknZKMjgUidLd38Wo/d6
         fHTsy4NHBN6AO3xBaVfcqCRl0E+4wvDTzkzLwTHMGXCbSGj//1CCSgb2EYWYyOk/ddve
         MblbbK6hnL73m985uH536MQghLpXQh7eZaDnx+JCO2HrLyYMAk5SEFjf28ZKKmSugJ1R
         08TP2u0SZGhABYsSrqSPb6gsgGxhu8OynZ0BwQsISDBiK1/aCywAe2IYbNDTlN3yoXPk
         PcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694215817; x=1694820617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PY75H1jflFjdwbxljuQ1fV6R6iCKvsQ0y9zdUNKFhfE=;
        b=ozmsMTO3Sjfha6nchIR1OLyYYKaHNaNngoUqriFYf2fTA7aSYYY/JLvWLlQZx807jp
         C9n2tFiDmwb+jpwAsxXvHJQFiKPZw4TZ8/Os7h4QrkL+xpZR37E5UKbDyoaSMhi3vamo
         feMCf2cdQiM8fjI69Z9BBILN61D6jEmdi/2gWXiD5hChwsloOCjNFOVWlmyM8nzHbX9d
         GxGWS+xYQo/HlElRHywawjTYpVVagvummGyTdFeaSFlZVL7cmrCSaeZ9k/8HqqiXcEBh
         WQbVNslXDiilrYUVc/3pBO/wG4SiVHGfu4X6SVhyoufNbYYYRl+e5vuwmwX3PeZ5Cgbn
         G70Q==
X-Gm-Message-State: AOJu0YxPJU6QmrQV+Y29WEj6VuHW/JJcN93hhO5TrwxZ34d1bo5UB/iA
        42K6PreG9gkA3wp/celyFbKbpmeEmVsy7s0iQClVVw==
X-Google-Smtp-Source: AGHT+IFf/w3Ll2Vi98yCb/MLhf+vlwG+jwysyimZL9ykydnejFlmX6x8jbG6nmN39VVCN6dQagU++csT2yUv+wExVNk=
X-Received: by 2002:a25:d050:0:b0:d78:2967:93ea with SMTP id
 h77-20020a25d050000000b00d78296793eamr3687368ybg.1.1694215817318; Fri, 08 Sep
 2023 16:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230908185427.29026-1-quic_abhinavk@quicinc.com> <20230908185427.29026-2-quic_abhinavk@quicinc.com>
In-Reply-To: <20230908185427.29026-2-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 9 Sep 2023 02:30:05 +0300
Message-ID: <CAA8EJppj+JTA8iZ6+Ui8JkD-kP54YKObRDK2_Oh+Wpn4XjU-4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm/dpu: try multirect based on mdp clock limits
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, nespera@igalia.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sept 2023 at 21:55, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> It's certainly possible that for large resolutions a single DPU SSPP
> cannot process the image without exceeding the MDP clock limits but
> it can still process it in multirect mode because the source rectangles
> will get divided and can fall within the MDP clock limits.
>
> If the SSPP cannot process the image even in multirect mode, then it
> will be rejected in dpu_plane_atomic_check_pipe().
>
> Hence try using multirect for resolutions which cannot be processed
> by a single SSPP without exceeding the MDP clock limits.
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 62dd9f9b4dce..85072328cd53 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -792,6 +792,7 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
>                                                                                  plane);
>         int ret = 0, min_scale;
>         struct dpu_plane *pdpu = to_dpu_plane(plane);
> +       struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
>         struct dpu_plane_state *pstate = to_dpu_plane_state(new_plane_state);
>         struct dpu_sw_pipe *pipe = &pstate->pipe;
>         struct dpu_sw_pipe *r_pipe = &pstate->r_pipe;
> @@ -860,7 +861,8 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
>
>         max_linewidth = pdpu->catalog->caps->max_linewidth;
>
> -       if (drm_rect_width(&pipe_cfg->src_rect) > max_linewidth) {
> +       if ((drm_rect_width(&pipe_cfg->src_rect) > max_linewidth) ||
> +            _dpu_plane_calc_clk(&crtc_state->mode, pipe_cfg) > kms->perf.max_core_clk_rate) {

First, I think this should be an adjusted_mode too. And this probably
needs some more attention in the next few lines of code, since .e.g
the UBWC case also needs to be adjusted.

>                 /*
>                  * In parallel multirect case only the half of the usual width
>                  * is supported for tiled formats. If we are here, we know that
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
