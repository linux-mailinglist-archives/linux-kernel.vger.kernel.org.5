Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216BC80DF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbjLKXEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345166AbjLKXEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:04:54 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A408D2;
        Mon, 11 Dec 2023 15:05:00 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1e116f2072so1036550366b.0;
        Mon, 11 Dec 2023 15:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702335899; x=1702940699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jQYYFfWpf7CH1ngpQ1NcqsuXdIAKOgOrjyMZygJ2rc=;
        b=S8dVs2fBXhB/9vVPRaCCj5uC/ZgiUpBLiJCwMZbrODWH73Ps4NF5ETjSKCOpgPzys8
         w+Y0jzodYt/1UmyB0UFu45a1ggu2ol+FO6cRAswrqzO5FCxHWykYBZOR1alp3rGUAoyK
         ocQ+kCknCyB5OC49qxPdsxhf161fjv56m3wxXeFSLrsKYlu9EtEFGPvvmhTdYJH88Z7e
         7ABRraq3d++SlOLIK0XNrW60fFWoKVF7yJqQEhi5ZlBqYftqxl36dRAiTqzajLSaJsph
         jt17Y8NT1qgmja6CY3ctM7ooYCLmep60M8p70rNFlr1rvyYHP3ckDBZaA14Xn3368I3v
         eDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335899; x=1702940699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jQYYFfWpf7CH1ngpQ1NcqsuXdIAKOgOrjyMZygJ2rc=;
        b=YSBLCIJ4Y28BTwBGoNpCm6vpV4cmyb3XCmG0brOdT14sNGLueHnH1TCAM5PbmLbBPh
         hxpJSNoYIKNWGLR38FCdms0g9bKwjTNwr4jqvqqpTFQMowRUv27n6sNDZKCFAVob3Jp6
         NBykwGGX+DSvCC+S+7xCvlRFZTlIssSnl/oAdFNgzaEd+Sua75aKQ72cVqPzmR7ARuz+
         AG5LlbyjbVXYkpS7Nlty7kZGXlVau+HQAZ0Y3AL4igOFZN0KZeS5R698hMfYC635pudt
         0okLoH9FX18NA+GvOGmyeSONqeARHjmC3J5W2yGqe9QEXP88AlNRU+3ptqLyjCwVVDuC
         0ZYA==
X-Gm-Message-State: AOJu0Yxvb9v9WWv3MQ4TRhF1f3cIEXILViAZRFrCtlF0fumnSITfHsD1
        WpXJlqFkK5cSi/+lycHWkkvD36jAPqIWG1nDA2Q=
X-Google-Smtp-Source: AGHT+IGv1cLz0t866ueXVHy5ghVNbgQJzgAl2BxW5r/d50wmAbeYk9+UMuBO56nOEw9vyXo96C9trllOkQcn66jNQj8=
X-Received: by 2002:a17:907:a087:b0:a1f:6ec8:2f6f with SMTP id
 hu7-20020a170907a08700b00a1f6ec82f6fmr5419382ejc.28.1702335898650; Mon, 11
 Dec 2023 15:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20231211182000.218088-1-robdclark@gmail.com> <lcsqjcqwvmhys3tzrznyqhlmk3p4wbv2rcu77tecbsioscxbal@3s4qeztkktx5>
In-Reply-To: <lcsqjcqwvmhys3tzrznyqhlmk3p4wbv2rcu77tecbsioscxbal@3s4qeztkktx5>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 11 Dec 2023 15:04:46 -0800
Message-ID: <CAF6AEGtrA=ay_xT17HrLaecKUnMkUKrDn7DHS=_tibsDR8WRbA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Ratelimit framedone timeout msgs
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 2:09=E2=80=AFPM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2023-12-11 10:19:55, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > When we start getting these, we get a *lot*.  So ratelimit it to not
> > flood dmesg.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >
> > dpu should probably stop rolling it's own trace macros, but that would
> > be a larger cleanup.
>
> That would be lovely, use is currently all over the place.
>
> Should this patch also ratelimit the corresponding:
>
>         [drm:dpu_encoder_phys_cmd_prepare_for_kickoff] *ERROR* failed wai=
t_for_idle: id:31 ret:-110 pp:0
>
> On CMD-mode panels?

Probably it should for consistency.  But I think you normally wouldn't
get this error at 60Hz with a cmd mode panel, so probably ok to make
it ratelimited for cmd mode later.

BR,
-R

> Note that this is a prime example of using DRM_ERROR over DPU_ERROR*, res=
ulting
> in unnecessary divergence (and un-readability) between error messages and=
 the
> code (DPU_DEBUG_CMDENC, which has a corresponding DPU_ERROR variant, is a=
lso
> used within that function...)
>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 5 ++++-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h     | 1 +
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/=
drm/msm/disp/dpu1/dpu_encoder.c
> > index 82538844614b..7c22235d0eba 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> > @@ -39,6 +39,9 @@
> >  #define DPU_ERROR_ENC(e, fmt, ...) DPU_ERROR("enc%d " fmt,\
> >               (e) ? (e)->base.base.id : -1, ##__VA_ARGS__)
> >
> > +#define DPU_ERROR_ENC_RATELIMITED(e, fmt, ...) DPU_ERROR_RATELIMITED("=
enc%d " fmt,\
> > +             (e) ? (e)->base.base.id : -1, ##__VA_ARGS__)
> > +
> >  /*
> >   * Two to anticipate panels that can do cmd/vid dynamic switching
> >   * plan is to create all possible physical encoder types, and switch b=
etween
> > @@ -2339,7 +2342,7 @@ static void dpu_encoder_frame_done_timeout(struct=
 timer_list *t)
> >               return;
> >       }
> >
> > -     DPU_ERROR_ENC(dpu_enc, "frame done timeout\n");
> > +     DPU_ERROR_ENC_RATELIMITED(dpu_enc, "frame done timeout\n");
> >
> >       event =3D DPU_ENCODER_FRAME_EVENT_ERROR;
> >       trace_dpu_enc_frame_done_timeout(DRMID(drm_enc), event);
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/=
msm/disp/dpu1/dpu_kms.h
> > index b6f53ca6e962..f5473d4dea92 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> > @@ -51,6 +51,7 @@
> >       } while (0)
> >
> >  #define DPU_ERROR(fmt, ...) pr_err("[dpu error]" fmt, ##__VA_ARGS__)
> > +#define DPU_ERROR_RATELIMITED(fmt, ...) pr_err_ratelimited("[dpu error=
]" fmt, ##__VA_ARGS__)
> >
> >  /**
> >   * ktime_compare_safe - compare two ktime structures
> > --
> > 2.43.0
> >
