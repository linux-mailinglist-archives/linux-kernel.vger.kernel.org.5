Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5586180434C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbjLEAYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjLEAXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:23:55 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C077109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:24:00 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5c8c26cf056so56841977b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 16:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701735839; x=1702340639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v0NP0jfMsyr98tpUvVX6lqxC4v77woduELRRX6RJhZw=;
        b=y9MVfanxcOJ1S/0AahMXLtuUwWzdPcanbL0h5e1t46TxvuGbRTu/YxcLlvnbei4CjH
         hV9s+Zz79NzaCc2I6cy3VQ3leZQv6gHb/yJfXChBK7Dlv6a4oEexxKnY63PiG79thpWU
         mK8H6nFVSckYlGZq4ZRf8dNADeJRC5PTdc3zlnykudDab7xIAAiOdB8d5iTYU4ZoEath
         xnST7BS94g0yF8kLe29IINJibvfgAgs00Ye6Z6Xp3WNZjsEK1zwDJPgSao2+UWpopwuO
         IL3UGDjZbM3T8/FtxgMBLyIV7xnxOiKCZimITu5yzpily8C2ornrgqxjPA0PxCOmGoHi
         UwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735839; x=1702340639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0NP0jfMsyr98tpUvVX6lqxC4v77woduELRRX6RJhZw=;
        b=tx/X0lPqfhL+dgmifO8YTGU4TaRv+sVxll8X7nPk8D7kBLVJ/08//JU1esYP898SSw
         FIDhyRx0MmOibPHlOQ7GKCEWaZ6f64t7RXUzc5/B4+ccO04j9dLG1qNQtLbEfUZmf6VM
         8DMDervb7dRcet6OlhdngsuJD1h+jWcn7KiBsqAXP7aQ984YVWvRLinc6ERYPj5b/qn7
         lPoJ8JLIlMMagw+1iRjpTCFg6Ox7PFs5WeG+FIIijSyp3txJr/9aYAoBJKAq9QxAjIBD
         8fXW/2LoE5KNX6q7YIPpAz6maapkPBWJSnuqKPBsd09GFXlW4tyL2kwAQ65NziFOPCIg
         dU9Q==
X-Gm-Message-State: AOJu0YzlswQq2QCbHImuye0QyvFAVE3sxgRCfuiGdLuXjwoi1ig5aVQ/
        6qF2fZognZ3paHGoxYyu/7zsx03N0JSNWX5k6T5O0UXPQz7B4AcKO1U=
X-Google-Smtp-Source: AGHT+IHMXI4RGZ1bAdcEfm7t00uhBMe9TrLZewoiKXhadhBndCCAjZKUf26WKJ3ffJhP/ABnN4I/z8AZJybaG46iWcI=
X-Received: by 2002:a0d:ce01:0:b0:5cd:9f20:966c with SMTP id
 q1-20020a0dce01000000b005cd9f20966cmr3613871ywd.45.1701735839431; Mon, 04 Dec
 2023 16:23:59 -0800 (PST)
MIME-Version: 1.0
References: <1701734134-7816-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1701734134-7816-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 5 Dec 2023 02:23:48 +0200
Message-ID: <CAA8EJprgES1tA1E=17Bnrz8n7mX1COpkx=w-vhWge4ywZ1E0ZQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dpu: improve DSC allocation
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 5 Dec 2023 at 01:55, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> A DCE (Display Compression Engine) contains two DSC hard slice
> encoders. Each DCE start with even DSC encoder index followed by
> an odd DSC encoder index. Each encoder can work independently.
> But Only two DSC encoders from same DCE can be paired to work
> together to support merge mode. In addition, the DSC with even
> index have to mapping to even pingpong index and DSC with odd
> index have to mapping to odd pingpong index at its data path.
> This patch improve DSC allocation mechanism with consideration
> of above factors.
>
> Changes in V2:
> -- split _dpu_rm_reserve_dsc() into _dpu_rm_reserve_dsc_single() and
>    _dpu_rm_reserve_dsc_pair()

Please don't send the new iteration of the patch if the discussion is ongoing.

Quoting v1 review:

Are the limitations (odd:odd, allocation in pairs, etc) applicable to
v1.1 encoders?

I assume that at least 'allocate two consecutive DSC for DSC merge' is
not applicable, since there are no separate DCE units.

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 171 ++++++++++++++++++++++++++++++---
>  1 file changed, 156 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index 17ecf23..dafe1ee 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -470,33 +470,174 @@ static int _dpu_rm_reserve_ctls(
>         return 0;
>  }
>
> -static int _dpu_rm_reserve_dsc(struct dpu_rm *rm,
> +static int _dpu_rm_reserve_dsc_single(struct dpu_rm *rm,
>                                struct dpu_global_state *global_state,
> -                              struct drm_encoder *enc,
> +                              uint32_t enc_id,
>                                const struct msm_display_topology *top)
>  {
> -       int num_dsc = top->num_dsc;
> -       int i;
> +       int num_dsc = 0;
> +       int i, pp_idx;
> +       int dsc_idx[DSC_MAX - DSC_0];
> +       uint32_t pp_to_enc_id[PINGPONG_MAX - PINGPONG_0];
> +       int pp_max = PINGPONG_MAX - PINGPONG_0;
> +
> +       for (i = 0; i < DSC_MAX - DSC_0; i++)
> +               dsc_idx[i] = 0;
> +
> +       /* fill working copy with pingpong list */
> +       memcpy(pp_to_enc_id, global_state->pingpong_to_enc_id, sizeof(pp_to_enc_id));
> +
> +       for (i = 0; i < ARRAY_SIZE(rm->dsc_blks) && num_dsc >= top->num_dsc; i++) {
> +               if (!rm->dsc_blks[i])
> +                       continue;
>
> -       /* check if DSC required are allocated or not */
> -       for (i = 0; i < num_dsc; i++) {
> -               if (!rm->dsc_blks[i]) {
> -                       DPU_ERROR("DSC %d does not exist\n", i);
> -                       return -EIO;
> +               if (global_state->dsc_to_enc_id[i])     /* used */
> +                       continue;
> +
> +               /*
> +                * find the pingpong index which had been reserved
> +                * previously at layer mixer allocation
> +                */
> +               for (pp_idx = 0; pp_idx < pp_max; pp_idx++) {
> +                       if (pp_to_enc_id[pp_idx] == enc_id)
> +                               break;
>                 }
>
> -               if (global_state->dsc_to_enc_id[i]) {
> -                       DPU_ERROR("DSC %d is already allocated\n", i);
> -                       return -EIO;
> +               /*
> +                * dsc even index must map to pingpong even index
> +                * dsc odd index must map to pingpong odd index
> +                */
> +               if ((i & 0x01) != (pp_idx & 0x01))
> +                       continue;
> +
> +               dsc_idx[num_dsc++] = i + 1;     /* found, start from 1 */
> +       }
> +
> +       if (num_dsc < top->num_dsc) {
> +               DPU_ERROR("DSC allocation failed num_dsc=%d required=%d\n",
> +                                               num_dsc, top->num_dsc);
> +               return -ENAVAIL;
> +       }
> +
> +       /* reserve dsc */
> +       for (i = 0; i < top->num_dsc; i++) {
> +               int j;
> +
> +               j = dsc_idx[i];
> +               if (j)
> +                       global_state->dsc_to_enc_id[j-1] = enc_id;
> +       }
> +
> +       return 0;
> +}
> +
> +static int _dpu_rm_reserve_dsc_pair(struct dpu_rm *rm,
> +                              struct dpu_global_state *global_state,
> +                              uint32_t enc_id,
> +                              const struct msm_display_topology *top)
> +{
> +       int num_dsc = 0;
> +       int i, pp_idx;
> +       int dsc_idx[DSC_MAX - DSC_0];
> +       uint32_t pp_to_enc_id[PINGPONG_MAX - PINGPONG_0];
> +       int pp_max = PINGPONG_MAX - PINGPONG_0;
> +
> +       for (i = 0; i < DSC_MAX - DSC_0; i++)
> +               dsc_idx[i] = 0;
> +
> +       /* fill working copy with pingpong list */
> +       memcpy(pp_to_enc_id, global_state->pingpong_to_enc_id, sizeof(pp_to_enc_id));
> +
> +       for (i = 0; i < ARRAY_SIZE(rm->dsc_blks) && num_dsc >= top->num_dsc; i++) {
> +               if (!rm->dsc_blks[i])
> +                       continue;
> +
> +               if (global_state->dsc_to_enc_id[i]) {   /* used */
> +                       /* consective dsc index to be paired */
> +                       if (num_dsc) {  /* already start pairing, re start search */
> +                               num_dsc = 0;
> +                               /* fill working copy with pingpong list */
> +                               memcpy(pp_to_enc_id, global_state->pingpong_to_enc_id,
> +                                                               sizeof(pp_to_enc_id));
> +                       }
> +                       continue;
> +               }
> +
> +               /* odd index can not become start of pairing */
> +               if (i & 0x01 && !num_dsc)
> +                       continue;
> +
> +               /*
> +                * find the pingpong index which had been reserved
> +                * previously at layer mixer allocation
> +                */
> +               for (pp_idx = 0; pp_idx < pp_max; pp_idx++) {
> +                       if (pp_to_enc_id[pp_idx] == enc_id)
> +                               break;
>                 }
> +
> +               /*
> +                * dsc even index must map to pingpong even index
> +                * dsc odd index must map to pingpong odd index
> +                */
> +               if ((i & 0x01) != (pp_idx & 0x01))
> +                       continue;
> +
> +               /*
> +                * delete pp_idx so that next pp_idx can be paired with
> +                * next dsc_idx
> +                */
> +               pp_to_enc_id[pp_idx] = 0xffff;
> +
> +               dsc_idx[num_dsc++] = i + 1;     /* found, start from 1 */
>         }
>
> -       for (i = 0; i < num_dsc; i++)
> -               global_state->dsc_to_enc_id[i] = enc->base.id;
> +       if (num_dsc < top->num_dsc) {
> +               DPU_ERROR("DSC allocation failed num_dsc=%d required=%d\n",
> +                                               num_dsc, top->num_dsc);
> +               return -ENAVAIL;
> +       }
> +
> +       /* reserve dsc */
> +       for (i = 0; i < top->num_dsc; i++) {
> +               int j;
> +
> +               j = dsc_idx[i];
> +               if (j)
> +                       global_state->dsc_to_enc_id[j-1] = enc_id;
> +       }
>
>         return 0;
>  }
>
> +static int _dpu_rm_reserve_dsc(struct dpu_rm *rm,
> +                              struct dpu_global_state *global_state,
> +                              uint32_t enc_id,
> +                              const struct msm_display_topology *top)
> +{
> +       if (!top->num_dsc || !top->num_intf)
> +               return 0;
> +
> +       /*
> +        * Truth:
> +        * 1) every layer mixer only connects to one pingpong
> +        * 2) no pingpong split -- which is two layer mixers shared one pingpong
> +        * 3) each DSC engine contains two dsc encoders
> +        *    -- index(0,1), index (2,3),... etc

Does this apply to v1.1 encoders?

> +        * 4) dsc pair can only happens with same DSC engine
> +        * 5) odd pingpong connect to odd dsc
> +        * 6) even pingpong connect to even dsc
> +        * 7) pair: encoder +--> pp_idx_0 --> dsc_idx_0
> +                           +--> pp_idx_1 --> dsc_idx_1
> +        */
> +
> +       /* num_dsc should be either 1, 2 or 4 */
> +       if (top->num_dsc > top->num_intf)       /* merge mode */
> +               return _dpu_rm_reserve_dsc_pair(rm, global_state, enc_id, top);
> +       else
> +               return _dpu_rm_reserve_dsc_single(rm, global_state, enc_id, top);
> +}
> +
>  static int _dpu_rm_make_reservation(
>                 struct dpu_rm *rm,
>                 struct dpu_global_state *global_state,
> @@ -518,7 +659,7 @@ static int _dpu_rm_make_reservation(
>                 return ret;
>         }
>
> -       ret  = _dpu_rm_reserve_dsc(rm, global_state, enc, &reqs->topology);
> +       ret  = _dpu_rm_reserve_dsc(rm, global_state, enc->base.id, &reqs->topology);
>         if (ret)
>                 return ret;
>
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
