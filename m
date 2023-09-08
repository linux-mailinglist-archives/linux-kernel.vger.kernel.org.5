Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0A07992A7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbjIHXG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbjIHXGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:06:53 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500251FE0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 16:06:49 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d80089712e5so2548505276.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 16:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694214408; x=1694819208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=86RlDu4KqfPGl13CQGEE6BLG6WN5cGi5lzDtXCFU4ls=;
        b=r7w3TDQMrqMMm6jNPinJolxytVAWvezxH60AMEb1v5BqRgq1IuAu0UMOkd+n96IyhO
         53GFvvJMCselXzu+B2mzg1Q0wm2FEVAO7EAM8WkyNFa7tgqnrB1WkZo6lfNPTE4Wxvf7
         +BaqjQwjZZSHPzsRCkYNVw30Z8eLe7482BgiAFy2EV1YweZGKylMzZ11HFRnezMR0+Qc
         ISGCpVSZSoVYNNbvCm9xx1PVZppgR2FiBhMdy/fw2LYBWZXYizi/0f7n2gPNJQvWiwLT
         5oH6LdRU73KFr55fP5Gawf308PYYOzict7ro9P/0b1cEnnBu38h1wCdx9HNxeeXgujsH
         O7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694214408; x=1694819208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86RlDu4KqfPGl13CQGEE6BLG6WN5cGi5lzDtXCFU4ls=;
        b=IM1Zs6GkcXvbQPqmHmEslc5SVCECx0tOm/XoOUHtu1fapks77ZyCVNjH4rVR/sH/iR
         EjiiXv9Q5rugnqSOpbt+VyYrgBDL/Yz3eubZhcFoSI77v3STPue0KKsMfoYnC/0dESKn
         B1oO/5uyBafRowk/nzC6ru9rQ6+pOFyuzuvDmb30DUTbNU+eAvGAchAxfriA3HfHsfxP
         LEvO4matdoNQQdg16lc+Y+zft2kE5uLghZmLG8QNuTZL8ENLITFN4EpDwLXtRLDT+q7P
         RHG/Wwjx0s9+dLo4XbB95XqFTodOucOY11/+6csTKOO0G9TEAGRmIonmgW8K0gDi3eBR
         TbHw==
X-Gm-Message-State: AOJu0YyhmEQmIHap8bkAX3Crj1yEltrV/qrK5bxSH3V44sOahHA9phU+
        ZS7JKCi6xduRxtXUFqaAKyGVx3562py7AmYY8IqFcw==
X-Google-Smtp-Source: AGHT+IFGUWQMquiV1p5Biddee7eFZ8X4Ye5n5mZrkJXgfPJ2Z7XVNhyb5TswwcnVancJAh6r2Fz3DqTPsR37P4YgODY=
X-Received: by 2002:a25:73c1:0:b0:d78:477e:442d with SMTP id
 o184-20020a2573c1000000b00d78477e442dmr5044363ybc.8.1694214407734; Fri, 08
 Sep 2023 16:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230908185427.29026-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20230908185427.29026-1-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 9 Sep 2023 02:06:36 +0300
Message-ID: <CAA8EJprD4nJ=wGZ3XUoxAXi0ybPsGPUOg22FwXVg+dzAmJ8v1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm/dpu: fail dpu_plane_atomic_check() based on
 mdp clk limits
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, nespera@igalia.com,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sept 2023 at 21:56, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Currently, dpu_plane_atomic_check() does not check whether the
> plane can process the image without exceeding the per chipset
> limits for MDP clock. This leads to underflow issues because the
> SSPP is not able to complete the processing for the data rate of
> the display.
>
> Fail the dpu_plane_atomic_check() if the SSPP cannot process the
> image without exceeding the MDP clock limits.
>
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 98c1b22e9bca..62dd9f9b4dce 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -733,9 +733,11 @@ static int dpu_plane_check_inline_rotation(struct dpu_plane *pdpu,
>  static int dpu_plane_atomic_check_pipe(struct dpu_plane *pdpu,
>                 struct dpu_sw_pipe *pipe,
>                 struct dpu_sw_pipe_cfg *pipe_cfg,
> -               const struct dpu_format *fmt)
> +               const struct dpu_format *fmt,
> +               const struct drm_display_mode *mode)
>  {
>         uint32_t min_src_size;
> +       struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
>
>         min_src_size = DPU_FORMAT_IS_YUV(fmt) ? 2 : 1;
>
> @@ -774,6 +776,12 @@ static int dpu_plane_atomic_check_pipe(struct dpu_plane *pdpu,
>                 return -EINVAL;
>         }
>
> +       /* max clk check */
> +       if (_dpu_plane_calc_clk(mode, pipe_cfg) > kms->perf.max_core_clk_rate) {
> +               DPU_DEBUG_PLANE(pdpu, "plane exceeds max mdp core clk limits\n");
> +               return -E2BIG;
> +       }
> +
>         return 0;
>  }
>
> @@ -899,12 +907,13 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
>                 r_pipe_cfg->dst_rect.x1 = pipe_cfg->dst_rect.x2;
>         }
>
> -       ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg, fmt);
> +       ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg, fmt, &crtc_state->mode);
>         if (ret)
>                 return ret;
>
>         if (r_pipe->sspp) {
> -               ret = dpu_plane_atomic_check_pipe(pdpu, r_pipe, r_pipe_cfg, fmt);
> +               ret = dpu_plane_atomic_check_pipe(pdpu, r_pipe, r_pipe_cfg, fmt,
> +                                                 &crtc_state->mode);

I think this should be adjusted_mode. In the end, according to the
docs CRTC should be programmed with the adjusted_mode, while the
state->mode is the mode at the end of the pipeline (if I got it
correct).

So e.g. if we add DS to the picture, state->mode will be screen
resolution, while adjusted_moe will be pre-scale resolution, which is
the one that matters from the bandwidth point of view.


-- 
With best wishes
Dmitry
