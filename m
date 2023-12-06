Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19972807614
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442704AbjLFRIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442694AbjLFRIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:08:48 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA19C9;
        Wed,  6 Dec 2023 09:08:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54d048550dfso34698a12.0;
        Wed, 06 Dec 2023 09:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701882532; x=1702487332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F90E6ezWa81IqrXxI2Eyak+OrAR7RPFLzPfvvTuxnUc=;
        b=ZVgRo1AeVOBqr51kADNYNp1YCfVbgdjYvmbaSSmg+Q/1KJ8rbMwMVFudYh3YfFhsd4
         3DSAlS87g12fUpWHaYwIrYEPmbr2z1hA+TFXleYZPut3JR6piHeNDpAs22LY4aTMqiDb
         acNSaYoxBjLy1gjFqOOc3zyhxB3L/W1Mf7w8cfSYGyBi+qld8vT1G2zLSKg2CD0zZkEb
         bRcDMc6gZ/hkSITaFhOoDV2X8rh31uAAvPrd2nZENZZoNSpen5+8KiAHvO5vT6e/osdT
         KsN2Fx0b8Es1udLqPTFI3ZSkTZW43OaqucdmYZrYI+xRYIrKQvYTLovj1bRjqa8xvW+c
         JieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882532; x=1702487332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F90E6ezWa81IqrXxI2Eyak+OrAR7RPFLzPfvvTuxnUc=;
        b=o7oA4B/y7neRt+my8CnGzxjVUdaJJVk9ogOm5wr4x3EXzIJHhylwG61ueyOyoEqsG6
         XyRnyCTBQbe+Zf638oJwYeuZcpw5pAluYzaqP2odBccNrqfJclGGYVflFyrC3XUmeGhQ
         kBBB+E0tTqmGBw/EDjdzolSxdJp8vt8xtjmxZgTPwwcoJsNMcI01hPj2kOg4Q3bfyFa0
         RxQWdVFkn2KIZEinfxzBUP5igB7aSk3eQTB4Vulk/xcdGYtEysL1jyJoX5coWYSTmJ/x
         +HeYw4RwEH80RGJV2C0R1aGfRB2UmzP+fiieFcusuqC+hf319NxFVXSdP+wylxNIVeC5
         khTg==
X-Gm-Message-State: AOJu0Yxlmmxiw3mYdCsy7925omijQGUWf16UMetEmlhGZ1F4sFCXM3JF
        qdcvvtYQ9hbHpEmZwRgDYJki1XSYxjfhMoCAljlMxprs
X-Google-Smtp-Source: AGHT+IH5K6GW3OveseugsaEQHvJYlONM4/Tq3vZlRzYGmYN1L7t9n1he6jC11LdbXJ+sBG2zT/ELd7BYkfzZTVJgjHk=
X-Received: by 2002:a50:871d:0:b0:54c:22bd:2385 with SMTP id
 i29-20020a50871d000000b0054c22bd2385mr597119edb.4.1701882532026; Wed, 06 Dec
 2023 09:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20231205220526.417719-1-robdclark@gmail.com> <20231205220526.417719-2-robdclark@gmail.com>
 <19ca53ae-b180-4ec6-9294-dd45825af653@linaro.org>
In-Reply-To: <19ca53ae-b180-4ec6-9294-dd45825af653@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 6 Dec 2023 09:08:40 -0800
Message-ID: <CAF6AEGtL5B3QrrsTiU9x8h4L7z0mjdw-WeAqoSEb-Xu+Q14fXQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/msm/adreno: Split up giant device table
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, Dec 6, 2023 at 4:29=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro.=
org> wrote:
>
>
>
> On 12/5/23 23:03, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Split into a separate table per generation, in preparation to move each
> > gen's device table to it's own file.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/msm/adreno/adreno_device.c | 59 +++++++++++++++++++--=
-
> >   1 file changed, 51 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/d=
rm/msm/adreno/adreno_device.c
> > index 41b13dec9bef..36392801f929 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -20,7 +20,7 @@ bool allow_vram_carveout =3D false;
> >   MODULE_PARM_DESC(allow_vram_carveout, "Allow using VRAM Carveout, in =
place of IOMMU");
> >   module_param_named(allow_vram_carveout, allow_vram_carveout, bool, 06=
00);
> >
> > -static const struct adreno_info gpulist[] =3D {
> > +static const struct adreno_info a2xx_gpus[] =3D {
> >       {
> >               .chip_ids =3D ADRENO_CHIP_IDS(0x02000000),
> >               .family =3D ADRENO_2XX_GEN1,
> > @@ -55,6 +55,12 @@ static const struct adreno_info gpulist[] =3D {
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> >               .init  =3D a2xx_gpu_init,
> >       }, {
> > +             /* sentinal */
> sentinel?
>
> > +     }
> > +};
> > +
> > +static const struct adreno_info a3xx_gpus[] =3D {
> > +     {
> >               .chip_ids =3D ADRENO_CHIP_IDS(
> >                       0x03000512,
> >                       0x03000520
> > @@ -110,6 +116,12 @@ static const struct adreno_info gpulist[] =3D {
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> >               .init  =3D a3xx_gpu_init,
> >       }, {
> > +             /* sentinal */
> > +     }
> > +};
> > +
> > +static const struct adreno_info a4xx_gpus[] =3D {
> > +     {
> >               .chip_ids =3D ADRENO_CHIP_IDS(0x04000500),
> >               .family =3D ADRENO_4XX,
> >               .revn  =3D 405,
> > @@ -143,6 +155,12 @@ static const struct adreno_info gpulist[] =3D {
> >               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> >               .init  =3D a4xx_gpu_init,
> >       }, {
> > +             /* sentinal */
> > +     }
> > +};
> > +
> > +static const struct adreno_info a5xx_gpus[] =3D {
> > +     {
> >               .chip_ids =3D ADRENO_CHIP_IDS(0x05000600),
> >               .family =3D ADRENO_5XX,
> >               .revn =3D 506,
> > @@ -268,6 +286,12 @@ static const struct adreno_info gpulist[] =3D {
> >               .init =3D a5xx_gpu_init,
> >               .zapfw =3D "a540_zap.mdt",
> >       }, {
> > +             /* sentinal */
> > +     }
> > +};
> > +
> > +static const struct adreno_info a6xx_gpus[] =3D {
> > +     {
> >               .chip_ids =3D ADRENO_CHIP_IDS(0x06010000),
> >               .family =3D ADRENO_6XX_GEN1,
> >               .revn =3D 610,
> > @@ -493,6 +517,12 @@ static const struct adreno_info gpulist[] =3D {
> >               .hwcg =3D a690_hwcg,
> >               .address_space_size =3D SZ_16G,
> >       }, {
> > +             /* sentinal */
> > +     }
> > +};
> > +
> > +static const struct adreno_info a7xx_gpus[] =3D {
> > +     {
> >               .chip_ids =3D ADRENO_CHIP_IDS(0x07030001),
> >               .family =3D ADRENO_7XX_GEN1,
> >               .fw =3D {
> > @@ -522,7 +552,18 @@ static const struct adreno_info gpulist[] =3D {
> >               .zapfw =3D "a740_zap.mdt",
> >               .hwcg =3D a740_hwcg,
> >               .address_space_size =3D SZ_16G,
> > -     },
> > +     }, {
> > +             /* sentinal */
> > +     }
> > +};
> > +
> > +static const struct adreno_info *gpulist[] =3D {
> > +     a2xx_gpus,
> > +     a3xx_gpus,
> > +     a4xx_gpus,
> > +     a5xx_gpus,
> > +     a6xx_gpus,
> > +     a7xx_gpus,
> >   };
> >
> >   MODULE_FIRMWARE("qcom/a300_pm4.fw");
> > @@ -557,12 +598,14 @@ static const struct adreno_info *adreno_info(uint=
32_t chip_id)
> >   {
> >       /* identify gpu: */
> >       for (int i =3D 0; i < ARRAY_SIZE(gpulist); i++) {
> > -             const struct adreno_info *info =3D &gpulist[i];
> > -             if (info->machine && !of_machine_is_compatible(info->mach=
ine))
> > -                     continue;
> > -             for (int j =3D 0; info->chip_ids[j]; j++)
> I'm not sure using sentinels here is a good idea, it adds a
> whole lot of stack size. Perhaps gpulist could be a struct
> of array pointers and an array of sizes?

I guess you meant text size..

But with 30 devices currently, that array would be (30 + 7) * 8 =3D 296
bytes.. each sentinel is ~112 bytes (and arguably we could move a bit
more out of adreno_info).  So it isn't that big of a difference.

Being able to have aNxx_info subclass adreno_effort might be a more
compelling reason to go for an array of pointers.  I'd have to see how
awkward that looks.

BR,
-R
