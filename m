Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9444278E3B9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbjHaAGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbjHaAGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:06:53 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF56ACCF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:06:50 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-570e005c480so208928eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693440410; x=1694045210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9DxU0ht48yqHP10Qw8l/djALIpoGzHmCLS1fvFvSy7A=;
        b=qgp7cqpFcrZZOJyzOFZnPoJHTcspPfotVZtwWU9j4DJqA5aAGSb0BJewdMF5faDwVy
         GPaulvKR5LqCZIyn/8NpyBA7eyENwoA0lfZghmIgzJFTm8G6pNAc+q+SBQYWQPBfe8IZ
         IajUy4lJRuT6yVrmO575Qpfxt4PMXC/D1rEdKe86ozmpJ2jObrFmOTxD+TlppnaHyf7R
         e8JoVhPh+9/Vlo8F/oBXWABsl4FYU901yMNK0zID1EVRzJC8+sbTWiC/pTAeK37hHoxC
         MuZMTjtWzuiPWeJprCKCko7kh1sCGO3Ofs2GastKv4pKGEFtyM3rckpzv2RSIK+OFbwE
         hH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693440410; x=1694045210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DxU0ht48yqHP10Qw8l/djALIpoGzHmCLS1fvFvSy7A=;
        b=N8FF11td563/37r1AjH0vncuHsL6WG3n2hHlprvAbG5JbRRnfopG44I5yQuyEsSUKc
         B6Gb3IO3shNUNvzGhlHlCFwa4ufIzRJ2zw4o0iD8laPckhalbxNDAJln49xc/ZnARSSr
         /QyfiVgXpy8yHSDMMCDmrwea3laBKl0+pNJKQA2GZl7A+Yz1SikGZjOfBFbFWAr8ChEK
         mHGMWlCiPl1yEBTTYX8L3WhUkGVKubCsOsDNPgZDCzF2gRQcLK87C6hbQ4kESth7C0vl
         YkO3IiIYUR2nrXQfIKRQK6qLtGiPhkXV12gM9WmsL3VxGQvlhia1ANnxgAfzRWWxibNc
         fu7g==
X-Gm-Message-State: AOJu0Yz3ToT2JOhYPBFIZQ1eJ4hlXQd468v3co31f999IK0xp6KeNc28
        uTak0jAPPecf6OKeJygdMlVa2UDA6HNrbCIJ8rARvw==
X-Google-Smtp-Source: AGHT+IGvlB2nE9Ks9HzVwilx3FixuPm+1K5NBqlv0K9dMaVCk1T3KdaSLfWY+Vx2/EpUDdNGAHP3MppXz0S8hhIBvw4=
X-Received: by 2002:a05:6358:7e0f:b0:134:cd32:3565 with SMTP id
 o15-20020a0563587e0f00b00134cd323565mr3238453rwm.31.1693440409878; Wed, 30
 Aug 2023 17:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230830224910.8091-1-quic_abhinavk@quicinc.com> <20230830224910.8091-9-quic_abhinavk@quicinc.com>
In-Reply-To: <20230830224910.8091-9-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Aug 2023 03:06:38 +0300
Message-ID: <CAA8EJporcrBikTob9xJe8_96AJSP1vDJNYPkt1za73PAcg1+Bw@mail.gmail.com>
Subject: Re: [PATCH 08/16] drm/msm/dpu: add support to allocate CDM from RM
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, quic_khsieh@quicinc.com,
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

On Thu, 31 Aug 2023 at 01:50, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Even though there is usually only one CDM block, it can be
> used by either HDMI, DisplayPort OR Writeback interfaces.
>
> Hence its allocation needs to be tracked properly by the
> resource manager to ensure appropriate availability of the
> block.

It almost feels like an overkill, as up to now there is at most one CDM block.

>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h     |  1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 45 +++++++++++++++++++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h      |  4 +-
>  5 files changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 6cf6597148fd..582680804016 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -663,7 +663,7 @@ static int dpu_encoder_virt_atomic_check(
>
>                 if (!crtc_state->active_changed || crtc_state->enable)
>                         ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
> -                                       drm_enc, crtc_state, topology);
> +                                       drm_enc, crtc_state, topology, false);
>         }
>
>         trace_dpu_enc_atomic_check_flags(DRMID(drm_enc), adj_mode->flags);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> index 34f943102499..07f75f295844 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -98,6 +98,7 @@ enum dpu_hw_blk_type {
>         DPU_HW_BLK_DSPP,
>         DPU_HW_BLK_MERGE_3D,
>         DPU_HW_BLK_DSC,
> +       DPU_HW_BLK_CDM,
>         DPU_HW_BLK_MAX,
>  };
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> index b6f53ca6e962..61aa58643fda 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> @@ -136,6 +136,7 @@ struct dpu_global_state {
>         uint32_t ctl_to_enc_id[CTL_MAX - CTL_0];
>         uint32_t dspp_to_enc_id[DSPP_MAX - DSPP_0];
>         uint32_t dsc_to_enc_id[DSC_MAX - DSC_0];
> +       uint32_t cdm_to_enc_id;
>  };
>
>  struct dpu_global_state
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index 7b6444a3fcb1..e7d4beb4661e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -29,10 +29,12 @@ static inline bool reserved_by_other(uint32_t *res_map, int idx,
>  /**
>   * struct dpu_rm_requirements - Reservation requirements parameter bundle
>   * @topology:  selected topology for the display
> + * @needs_cdm: whether the display needs a CDM block for the current mode
>   * @hw_res:       Hardware resources required as reported by the encoders
>   */
>  struct dpu_rm_requirements {
>         struct msm_display_topology topology;
> +       bool needs_cdm;
>  };
>
>  int dpu_rm_destroy(struct dpu_rm *rm)
> @@ -505,6 +507,26 @@ static int _dpu_rm_reserve_dsc(struct dpu_rm *rm,
>         return 0;
>  }
>
> +static int _dpu_rm_reserve_cdm(struct dpu_rm *rm,
> +                              struct dpu_global_state *global_state,
> +                              struct drm_encoder *enc)
> +{
> +       /* try allocating only one CDM block */
> +       if (!rm->cdm_blk) {
> +               DPU_ERROR("CDM block does not exist\n");
> +               return -EIO;
> +       }
> +
> +       if (global_state->cdm_to_enc_id) {
> +               DPU_ERROR("CDM_0 is already allocated\n");
> +               return -EIO;
> +       }
> +
> +       global_state->cdm_to_enc_id = enc->base.id;
> +
> +       return 0;
> +}
> +
>  static int _dpu_rm_make_reservation(
>                 struct dpu_rm *rm,
>                 struct dpu_global_state *global_state,
> @@ -530,15 +552,25 @@ static int _dpu_rm_make_reservation(
>         if (ret)
>                 return ret;
>
> +       if (reqs->needs_cdm) {
> +               ret = _dpu_rm_reserve_cdm(rm, global_state, enc);
> +               if (ret) {
> +                       DPU_ERROR("unable to find CDM blk\n");
> +                       return ret;
> +               }
> +       }
> +
>         return ret;
>  }
>
>  static int _dpu_rm_populate_requirements(
>                 struct drm_encoder *enc,
>                 struct dpu_rm_requirements *reqs,
> -               struct msm_display_topology req_topology)
> +               struct msm_display_topology req_topology,
> +               bool needs_cdm)

Push it to the topology, please. It is a part of the topology at some
point of view.

>  {
>         reqs->topology = req_topology;
> +       reqs->needs_cdm = needs_cdm;
>
>         DRM_DEBUG_KMS("num_lm: %d num_dsc: %d num_intf: %d\n",
>                       reqs->topology.num_lm, reqs->topology.num_dsc,
> @@ -571,6 +603,7 @@ void dpu_rm_release(struct dpu_global_state *global_state,
>                 ARRAY_SIZE(global_state->dsc_to_enc_id), enc->base.id);
>         _dpu_rm_clear_mapping(global_state->dspp_to_enc_id,
>                 ARRAY_SIZE(global_state->dspp_to_enc_id), enc->base.id);
> +       _dpu_rm_clear_mapping(&global_state->cdm_to_enc_id, 1, enc->base.id);
>  }
>
>  int dpu_rm_reserve(
> @@ -578,7 +611,8 @@ int dpu_rm_reserve(
>                 struct dpu_global_state *global_state,
>                 struct drm_encoder *enc,
>                 struct drm_crtc_state *crtc_state,
> -               struct msm_display_topology topology)
> +               struct msm_display_topology topology,
> +               bool needs_cdm)
>  {
>         struct dpu_rm_requirements reqs;
>         int ret;
> @@ -595,7 +629,7 @@ int dpu_rm_reserve(
>         DRM_DEBUG_KMS("reserving hw for enc %d crtc %d\n",
>                       enc->base.id, crtc_state->crtc->base.id);
>
> -       ret = _dpu_rm_populate_requirements(enc, &reqs, topology);
> +       ret = _dpu_rm_populate_requirements(enc, &reqs, topology, needs_cdm);
>         if (ret) {
>                 DPU_ERROR("failed to populate hw requirements\n");
>                 return ret;
> @@ -644,6 +678,11 @@ int dpu_rm_get_assigned_resources(struct dpu_rm *rm,
>                 hw_to_enc_id = global_state->dsc_to_enc_id;
>                 max_blks = ARRAY_SIZE(rm->dsc_blks);
>                 break;
> +       case DPU_HW_BLK_CDM:
> +               hw_blks = &rm->cdm_blk;
> +               hw_to_enc_id = &global_state->cdm_to_enc_id;
> +               max_blks = 1;
> +               break;
>         default:
>                 DPU_ERROR("blk type %d not managed by rm\n", type);
>                 return 0;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> index 29b221491926..74262d3cb6c3 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> @@ -69,13 +69,15 @@ int dpu_rm_destroy(struct dpu_rm *rm);
>   * @drm_enc: DRM Encoder handle
>   * @crtc_state: Proposed Atomic DRM CRTC State handle
>   * @topology: Pointer to topology info for the display
> + * @needs_cdm: bool to indicate whether current encoder needs CDM
>   * @Return: 0 on Success otherwise -ERROR
>   */
>  int dpu_rm_reserve(struct dpu_rm *rm,
>                 struct dpu_global_state *global_state,
>                 struct drm_encoder *drm_enc,
>                 struct drm_crtc_state *crtc_state,
> -               struct msm_display_topology topology);
> +               struct msm_display_topology topology,
> +               bool needs_cdm);
>
>  /**
>   * dpu_rm_reserve - Given the encoder for the display chain, release any
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
