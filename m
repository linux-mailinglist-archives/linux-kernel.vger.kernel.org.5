Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA59776BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjHIWJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjHIWJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:09:49 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEA9B9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:09:48 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b9c9944da8so271898a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691618988; x=1692223788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wgDVu8p3LAXBRMLjZ335uEuofYsZ1H4TbcKoyLUoLo=;
        b=pBH+yh35EtrJKvrb5fnLJvRLVaPCRGUT+7HvV1ZWoRkfAESNpFgDP7h54DHz9p4/r6
         a42WOpxmxSXlV07+ptDJs5MVekWkF+X5zFZqlIHm6lJYfFo8GxvjhGOCojqzOzy0nI34
         iYFp/PT+g1fAF95MVMeBHGOHnj/AZ3xZfKljJVBalSsAU0LqTCfPVKsnOwegpZY2VS9F
         2CgpUwUTP71Ex2B71oEmlOWAN4IfsVCFDXOJK2dIdpC7B/xgDoFoLDd8/m+fXTj4k99o
         ene6pQH7hMtdKATN1DDzHcdbmLD59ChvMCA1GUJDcKV8IOW5u0/iLIuykZGxayGiaaLH
         4h8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691618988; x=1692223788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wgDVu8p3LAXBRMLjZ335uEuofYsZ1H4TbcKoyLUoLo=;
        b=SunvrlfmwdcUf7YqDZt9EpFxVy6YTb1cEXkwIfMJVePN6gHNT9AsbNwc7H5TRnyaPM
         si/5RQZjU6pXztyGCKvNS5VBEnu2iaTioUPnD7PLqUBMWFIq2LROQt5rO7pZNv8b/TBE
         rYpzWLA+6lUid3B5N6tGwUbqSCBCO3YJc0ClLzWiYEy7H9IbuqHll8qEQJJ2z5Wyx/NE
         UaN2abLrwp89gBhjSq0rbaPH3FDr7DtjZXrjD1Juk27M6vXj0FaW2r339ofdp25IWvYC
         5AcqKPCBSGewn0LMPNK1og7DLHYKigT1IEPvF+r7zi+uuYp6hw/FP9akCSg6XTx3bn2H
         0hag==
X-Gm-Message-State: AOJu0YxdJHl4oSAoEQuSL97P+dvAU++nXlfBmXkNu2HDetkgc0FTm9rr
        DLnnC1ThWREpJrPu1PRbV/7twownqvWFPPg1nx0=
X-Google-Smtp-Source: AGHT+IGaFK09aQLRrcthM3O+uleFc4gf7oGBkgSQRy/BXP3AlJBxiNZU18R3ecPf1q5NWrORzYwZ8vWUHy/MM9WtzuY=
X-Received: by 2002:a05:6870:970e:b0:1bb:b025:3e87 with SMTP id
 n14-20020a056870970e00b001bbb0253e87mr688950oaq.58.1691618987999; Wed, 09 Aug
 2023 15:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230703150135.5784-1-ubizjak@gmail.com>
In-Reply-To: <20230703150135.5784-1-ubizjak@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 9 Aug 2023 18:09:36 -0400
Message-ID: <CADnq5_MCquO_Sh0RUVYATbLwS1+h2UrLHoUkCXYeF7=R4kZmDg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use local64_try_cmpxchg in amdgpu_perf_read
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jul 3, 2023 at 7:16=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> Use local64_try_cmpxchg instead of local64_cmpxchg (*ptr, old, new) =3D=
=3D old
> in amdgpu_perf_read.  x86 CMPXCHG instruction returns success in ZF flag,
> so this change saves a compare after cmpxchg (and related move instructio=
n
> in front of cmpxchg).
>
> Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
> fails. There is no need to re-read the value in the loop.
>
> No functional change intended.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_pmu.c
> index 71ee361d0972..6e91ea1de5aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -276,9 +276,8 @@ static void amdgpu_perf_read(struct perf_event *event=
)
>             (!pe->adev->df.funcs->pmc_get_count))
>                 return;
>
> +       prev =3D local64_read(&hwc->prev_count);
>         do {
> -               prev =3D local64_read(&hwc->prev_count);
> -
>                 switch (hwc->config_base) {
>                 case AMDGPU_PMU_EVENT_CONFIG_TYPE_DF:
>                 case AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI:
> @@ -289,7 +288,7 @@ static void amdgpu_perf_read(struct perf_event *event=
)
>                         count =3D 0;
>                         break;
>                 }
> -       } while (local64_cmpxchg(&hwc->prev_count, prev, count) !=3D prev=
);
> +       } while (!local64_try_cmpxchg(&hwc->prev_count, &prev, count));
>
>         local64_add(count - prev, &event->count);
>  }
> --
> 2.41.0
>
