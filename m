Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B209C75B382
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjGTPxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjGTPxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:53:05 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1EAE0;
        Thu, 20 Jul 2023 08:53:04 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56661fe27cbso617128eaf.3;
        Thu, 20 Jul 2023 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689868383; x=1690473183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdiXWN9VKG2RHkdnGg3Y/QnT3CJ4DL70qJz+8ZNiP54=;
        b=ZM5wJbg3Wn+ja0lqtno0iVgh1AmYW9DxRkviEsoD8YTZwYwMYukTSE/VS8zFwngr9X
         YfMkvKCkJYETPkZ5Rm/N5DsfnpQ58GCwLBsrdctdufSM6U2VsO5znvhLK+VCk8Rh2mUa
         g1rNlQvPJ98A7T5vQCjTXdIyvZ+OEZcgAUQ5ImStpu75ADYlnW0XW1L6CVQFB2gi6JFR
         qRJ8JxRlzN2JDjIL4St/1THgLHds4XyLq2k3QBzGn2GZHyu76gYQ9Jm4uAn4BWslEKrY
         m64dJHe2vB5hnkQDsBGbLWct/wQX7qxgKRcCVlSxMI37QxNZ8rAYy3cr1DmgFVyD94lt
         V6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868383; x=1690473183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdiXWN9VKG2RHkdnGg3Y/QnT3CJ4DL70qJz+8ZNiP54=;
        b=UmNxQyWfYt844724OY2AOThlY0qua4nYjfyPghSBa8S0jL/QIwvyEyoJAf6YcqDfQO
         j98HyGXG2zuwt+lVeHyprEpfJV3YuLSeZdFlwR5l3I+j3XvcBu6q1ZIOsmIDyJJsGyah
         1115jSTFoPI2o37T2HfSsmTTe1ds7d2OCLlP4WWDi+4R8im1DE2eUF7KkYlnWFLQhkNp
         wI8nKKXpmcsPZn23BniMqhWGtyokdxGsqd0/mCKGfhGFLBKd/HiHqxsBjePxR+4s7b+T
         zK84lRa90xDD8Aq3Ou904j5L+0FCS2aRYYbJuP82x3sUp9J6gBvMTx3UlJB2BgCm/+aD
         //bQ==
X-Gm-Message-State: ABy/qLYki6oFpdb7EJwK0CzKh7sM7flfxkxHvG+nlhHpsUV/mEWXICv/
        ALlZ3ZXxFhqpVmaJzL0PPx2xeA/6piahRLp8dAA=
X-Google-Smtp-Source: APBJJlH0lI6SV0q3uzQ5wOTHpuTe0kfahtkJlagRdNlL6AL+4u/QZBZy5f1g6Q0U2mTOSQZ3x0BPwFzPGYBhIDa25kg=
X-Received: by 2002:a05:6870:2112:b0:1b0:5218:cf07 with SMTP id
 f18-20020a056870211200b001b05218cf07mr2609444oae.5.1689868383463; Thu, 20 Jul
 2023 08:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230309222049.4180579-1-jorcrous@amazon.com> <d73f6733-e605-0cf8-7909-8cced6e3b70d@linaro.org>
In-Reply-To: <d73f6733-e605-0cf8-7909-8cced6e3b70d@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 20 Jul 2023 08:52:52 -0700
Message-ID: <CAF6AEGs89FRmFsENLkP-Dg1ZJN2LzCfxY2-+do9jH9b8L-XZxg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Check for the GPU IOMMU during bind
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jordan Crouse <jorcrous@amazon.com>,
        freedreno@lists.freedesktop.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 11:55=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 10/03/2023 00:20, Jordan Crouse wrote:
> > While booting with amd,imageon on a headless target the GPU probe was
> > failing with -ENOSPC in get_pages() from msm_gem.c.
> >
> > Investigation showed that the driver was using the default 16MB VRAM
> > carveout because msm_use_mmu() was returning false since headless devic=
es
> > use a dummy parent device. Avoid this by extending the existing is_a2xx
> > priv member to check the GPU IOMMU state on all platforms and use that
> > check in msm_use_mmu().
> >
> > This works for memory allocations but it doesn't prevent the VRAM carve=
out
> > from being created because that happens before we have a chance to chec=
k
> > the GPU IOMMU state in adreno_bind.
> >
> > There are a number of possible options to resolve this but none of them=
 are
> > very clean. The easiest way is to likely specify vram=3D0 as module par=
ameter
> > on headless devices so that the memory doesn't get wasted.
>
> This patch was on my plate for quite a while, please excuse me for
> taking it so long.
>
> I see the following problem with the current code. We have two different
> instances than can access memory: MDP/DPU and GPU. And each of them can
> either have or miss the MMU.
>
> For some time I toyed with the idea of determining whether the allocated
> BO is going to be used by display or by GPU, but then I abandoned it. We
> can have display BOs being filled by GPU, so handling it this way would
> complicate things a lot.

There is MSM_BO_SCANOUT .. but it wouldn't completely surprise me if
it isn't used in some place where it should somewhere or other.  But
that is the hint that contiguous allocation should be used if the
display doesn't support some sort of iommu.  (Using a GPU without some
sort of mmu/iommu isn't something sane to do.. the only reason the
support for that exists at all is to aid bringup.  I wouldn't call
that a "supported" configuration.)

> This actually rings a tiny bell in my head with the idea of splitting
> the display and GPU parts to two different drivers, but I'm not sure
> what would be the overall impact.

Userspace does have better support for split display/gpu these days
than it did when drm/msm was first merged.  It _might_ just work if
one device only advertised DRIVER_RENDER and the other
MODESET/ATOMIC.. but I'd be a bit concerned about breaking things.  I
guess you could try some sort of kconfig knob to have two "msm"
devices and see what breaks, but I'm a bit skeptical that we could
make this the default anytime soon.

For now, just addressing the only-display and only-gpu cases
(continuing with the single device arrangement when you have both
display and gpu), maybe split up drm_dev_alloc() and drm_dev_init() so
that we could use drm_device::driver_features to mask out
DRIVER_RENDER if needed.

BR,
-R

> More on the msm_use_mmu() below.
>
> >
> > Signed-off-by: Jordan Crouse <jorcrous@amazon.com>
> > ---
> >
> >   drivers/gpu/drm/msm/adreno/adreno_device.c | 6 +++++-
> >   drivers/gpu/drm/msm/msm_drv.c              | 7 +++----
> >   drivers/gpu/drm/msm/msm_drv.h              | 2 +-
> >   3 files changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/d=
rm/msm/adreno/adreno_device.c
> > index 36f062c7582f..4f19da28f80f 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -539,7 +539,11 @@ static int adreno_bind(struct device *dev, struct =
device *master, void *data)
> >       DBG("Found GPU: %u.%u.%u.%u", config.rev.core, config.rev.major,
> >               config.rev.minor, config.rev.patchid);
> >
> > -     priv->is_a2xx =3D config.rev.core =3D=3D 2;
> > +     /*
> > +      * A2xx has a built in IOMMU and all other IOMMU enabled targets =
will
> > +      * have an ARM IOMMU attached
> > +      */
> > +     priv->has_gpu_iommu =3D config.rev.core =3D=3D 2 || device_iommu_=
mapped(dev);
> >       priv->has_cached_coherent =3D config.rev.core >=3D 6;
> >
> >       gpu =3D info->init(drm);
> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_dr=
v.c
> > index aca48c868c14..a125a351ec90 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > @@ -318,11 +318,10 @@ bool msm_use_mmu(struct drm_device *dev)
> >       struct msm_drm_private *priv =3D dev->dev_private;
> >
> >       /*
> > -      * a2xx comes with its own MMU
> > -      * On other platforms IOMMU can be declared specified either for =
the
> > -      * MDP/DPU device or for its parent, MDSS device.
> > +      * Return true if the GPU or the MDP/DPU or parent MDSS device ha=
s an
> > +      * IOMMU
> >        */
> > -     return priv->is_a2xx ||
> > +     return priv->has_gpu_iommu ||
> >               device_iommu_mapped(dev->dev) ||
> >               device_iommu_mapped(dev->dev->parent);
>
> I have a generic feeling that both old an new code is not fully correct.
> Please correct me if I'm wrong:
>
> We should be using VRAM, if either of the blocks can not use remapped
> memory. So this should have been:
>
> bool msm_use_mmu()
> {
>   if (!gpu_has_iommu)
>     return false;
>
>   if (have_display_part && !display_has_mmu())
>     return false;
>
>   return true;
> }
>
> What do you think.
>
> >   }
> > diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_dr=
v.h
> > index 9f0c184b02a0..f33f94acd1b9 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.h
> > +++ b/drivers/gpu/drm/msm/msm_drv.h
> > @@ -126,7 +126,7 @@ struct msm_drm_private {
> >       struct msm_gpu *gpu;
> >
> >       /* gpu is only set on open(), but we need this info earlier */
> > -     bool is_a2xx;
> > +     bool has_gpu_iommu;
> >       bool has_cached_coherent;
> >
> >       struct drm_fb_helper *fbdev;
>
> --
> With best wishes
> Dmitry
>
