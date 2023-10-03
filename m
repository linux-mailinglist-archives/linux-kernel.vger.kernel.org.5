Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B207B6D59
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbjJCPmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjJCPmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:42:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB795;
        Tue,  3 Oct 2023 08:42:05 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so1978519a12.0;
        Tue, 03 Oct 2023 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696347723; x=1696952523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwcIH/MJaknxI2AysetsnqfxTchI6FhcS9I0JiipDi8=;
        b=NafNyDbW4LYIC4mTlMAlyMsl2RrVU0FiJ2lmx3jrFSswj3BTQrYa0BwvjKMx90HenC
         o5/zAXeHFlgHtnalBkjykABThIjv7JFbb7yonWEyifK6Vf+yX10FktvD+vYo+qtm/Cmr
         tnTEXPYL5dlLwCpksYw1SbJ3dVyvCCboxzxcsMZ4zjogas7L0Rs5DnHARY9xqccJ3NKU
         wxh8MZvLtXlvUgESXpRez1sgFXSDXy8sHA6zSCm+x9P2Yno1syV1M/RXDa5H4YXSe+fC
         wV3OW6LUtCcDRKg+Q5vn7FcUKNj8HNyMRFJKbvCeX+x3/uBCw4xxVdqyARuiKAj+xVXD
         Qsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696347723; x=1696952523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwcIH/MJaknxI2AysetsnqfxTchI6FhcS9I0JiipDi8=;
        b=BUGfi4eBfSll6ZL03n69zrf7U8kDaIIPaiRuLm8/SE3b2el60mqvuP5hIZnty4S56o
         9Ad7FAPNMQLLSPlyOx7zbApFF0jSBG5xw9YBBMTMPwxaOjhmOVSe23pt3o1gR/bOLrO1
         obgEjOtfdz5N2n5vB5CC74GdLWmukjs8S1O79F5xPuluBXszHvsnJ2g8S9BXjBHhTtUP
         UXn1RfPZyUBcabQvK0yNNLxtNMB8aCLPesFk2E8KGsnPS2R6iasxm2tmepGzqGx2Vaf3
         pA8NpjmCyfXAJwAx2XyKYMnyP/O4T9ymIVzza1QdE+ZIlp3t+Baou5ldoW42fFhU66Y9
         omUw==
X-Gm-Message-State: AOJu0YxH1ItrcvPYjqlHgPRnbQ1+FjkklgG5jq0VDY2yCPE7HMSYEP/V
        r1wuOnhNMUm6W99rbGip0wdOsxUSlfX3XwltLcnYMFu2
X-Google-Smtp-Source: AGHT+IFfYq7iZhbGBkD+298cNE5AGyY/ae4vqG/gUVjcZgH8FPFdolrszeguKhwmL4VBTmQ0KiloX9AVBu/Hy81fRBA=
X-Received: by 2002:a05:6402:d0:b0:530:ccf7:37af with SMTP id
 i16-20020a05640200d000b00530ccf737afmr12920690edu.12.1696347722588; Tue, 03
 Oct 2023 08:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230929181616.2769345-1-adrian.larumbe@collabora.com> <20230929181616.2769345-5-adrian.larumbe@collabora.com>
In-Reply-To: <20230929181616.2769345-5-adrian.larumbe@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 3 Oct 2023 08:41:49 -0700
Message-ID: <CAF6AEGuQEi8piaw60ySOqfQpjr-cvR0cw8U78=kG3UyMv-NQYg@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] drm/drm_file: Add DRM obj's RSS reporting function
 for fdinfo
To:     =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, healych@amazon.com,
        kernel@collabora.com, tvrtko.ursulin@linux.intel.com,
        boris.brezillon@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:16=E2=80=AFAM Adri=C3=A1n Larumbe
<adrian.larumbe@collabora.com> wrote:
>
> Some BO's might be mapped onto physical memory chunkwise and on demand,
> like Panfrost's tiler heap. In this case, even though the
> drm_gem_shmem_object page array might already be allocated, only a very
> small fraction of the BO is currently backed by system memory, but
> drm_show_memory_stats will then proceed to add its entire virtual size to
> the file's total resident size regardless.
>
> This led to very unrealistic RSS sizes being reckoned for Panfrost, where
> said tiler heap buffer is initially allocated with a virtual size of 128
> MiB, but only a small part of it will eventually be backed by system memo=
ry
> after successive GPU page faults.
>
> Provide a new DRM object generic function that would allow drivers to
> return a more accurate RSS and purgeable sizes for their BOs.
>
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/drm_file.c | 8 +++++---
>  include/drm/drm_gem.h      | 9 +++++++++
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 883d83bc0e3d..9a1bd8d0d785 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -930,6 +930,8 @@ void drm_show_memory_stats(struct drm_printer *p, str=
uct drm_file *file)
>         spin_lock(&file->table_lock);
>         idr_for_each_entry (&file->object_idr, obj, id) {
>                 enum drm_gem_object_status s =3D 0;
> +               size_t add_size =3D (obj->funcs && obj->funcs->rss) ?
> +                       obj->funcs->rss(obj) : obj->size;
>
>                 if (obj->funcs && obj->funcs->status) {
>                         s =3D obj->funcs->status(obj);
> @@ -944,7 +946,7 @@ void drm_show_memory_stats(struct drm_printer *p, str=
uct drm_file *file)
>                 }
>
>                 if (s & DRM_GEM_OBJECT_RESIDENT) {
> -                       status.resident +=3D obj->size;
> +                       status.resident +=3D add_size;
>                 } else {
>                         /* If already purged or not yet backed by pages, =
don't
>                          * count it as purgeable:
> @@ -953,14 +955,14 @@ void drm_show_memory_stats(struct drm_printer *p, s=
truct drm_file *file)
>                 }
>
>                 if (!dma_resv_test_signaled(obj->resv, dma_resv_usage_rw(=
true))) {
> -                       status.active +=3D obj->size;
> +                       status.active +=3D add_size;
>
>                         /* If still active, don't count as purgeable: */
>                         s &=3D ~DRM_GEM_OBJECT_PURGEABLE;
>                 }
>
>                 if (s & DRM_GEM_OBJECT_PURGEABLE)
> -                       status.purgeable +=3D obj->size;
> +                       status.purgeable +=3D add_size;
>         }
>         spin_unlock(&file->table_lock);
>
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index bc9f6aa2f3fe..16364487fde9 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -208,6 +208,15 @@ struct drm_gem_object_funcs {
>          */
>         enum drm_gem_object_status (*status)(struct drm_gem_object *obj);
>
> +       /**
> +        * @rss:
> +        *
> +        * Return resident size of the object in physical memory.
> +        *
> +        * Called by drm_show_memory_stats().
> +        */
> +       size_t (*rss)(struct drm_gem_object *obj);
> +
>         /**
>          * @vm_ops:
>          *
> --
> 2.42.0
>
