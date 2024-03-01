Return-Path: <linux-kernel+bounces-88983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2CB86E8F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BB6285930
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD78A3BB25;
	Fri,  1 Mar 2024 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb+ThjlN"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450D39AE3;
	Fri,  1 Mar 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319511; cv=none; b=SI2g9bx+BsbWebvMBENRztM0fKe8e8Qs7w2DGkNJp5wJ32g7xsBrCoQ+C+p+hu9sWZgmvlWkitPa7p4aQW0FrV2dPifvA+Fb+waan2rJvKzI+NwbHDdp8zwNMFCCQgurcJPXCefVG2Lvg9FmpLSAIa4P0QwQvN0070LGOAf+Mlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319511; c=relaxed/simple;
	bh=jTbniporEY54eLsxzwCrhpuzbKhcjr7PNHBdNAB83SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wbb3/QRmrJrxu1PTKm5yQc4zOhfAcFZRExUEdw9m4KbgMsBbGAd+A14HcUZZuartr9TRBC1vZuAqOLWO8zmAUxXnwYbMg6YdJVhV5sPt7inpB765Khdhb8SxaMHUAzClfaicRQwzGEWXKjMIiwLkZKAb2zevDT1BLWiD9Ugm4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb+ThjlN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so4214773a12.0;
        Fri, 01 Mar 2024 10:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709319507; x=1709924307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpeyW3c/lwqw/i+hkeuehGCnk9+JZlz3NYt5Cg0he1I=;
        b=Bb+ThjlNVWARLUg0kWNdi05pkaGG9qjdLTF4CoxaJynTqCTUcXbKPZjmOyYfd67av5
         NXSHCDIIIFJdgaZc4N+IT5jXarNSj76PNGggcmKoxrunzMUn9vFWLlDOUm6+cBm3fIwp
         AC93xh2hPm2Rbf4ha528lhSZXaKop4l+FGUhGfPVvBOpDCKyqmkH0mvH6lJ+F1dAV+JP
         dZYtj/qh6B7C7dudx2NuDV0bJG1Z+HIpxxGf+xlOtaOmmWe3LCxrjpV1SqPMvDXDibg9
         DYD5j7P5Yy3pLgYQIHzCTWmf3DyqADptHsnSDEWtrzjdrxVEgkGZeDPQvXZDLoLjjqeI
         wToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319507; x=1709924307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpeyW3c/lwqw/i+hkeuehGCnk9+JZlz3NYt5Cg0he1I=;
        b=FEUq42QB6eLCtycGPMMEhEOFDiFgKCSYrgGSI5hQaTBxDIdjIS5Tan/eTUhwX9M8MB
         eZHUBMjPZQ5TL5DJi/reXsMoSFMII5XFIyuj882xopvEJvmdML41Onoy+YfpjbXngDMs
         VPaXmb7lJRU5A9qEmbqZ+/ayolGWZgjiLi+XhmB7bV9g/Y0aG4Yy3GwqBFw+pvW3EC/L
         Pj7OAx1+iDNA0kh/5pfBeXGSysBfAuw4k+vcbawA/YthcOLkvHTWB3SE8IMCCq0SM1lm
         62ERcv6UdxL8cIuxijZ9VhsAHqtwHy3XYwEvq2wv4o/31JQv4MSMii8HeaGdZr/RQ8kr
         fRMA==
X-Forwarded-Encrypted: i=1; AJvYcCWfhUBE2DHvARFrlzvuAXMvltBqPDJC/JSsTpiDgQDIgWaHjGI5lfpBpWQVs5ccrK9/ctm4JeBbOTjqls5zWJgg8j0HMUKBXlT9RWBK
X-Gm-Message-State: AOJu0YzTnQROVwXxkWHeva6Q0FpKqNmQ98sqdUZjGgBIU8c1eIWM7Djd
	gE+9gFeQoohN0gGQMkeK3phDrNqgfTw2f5LS+aaHaozRt/Gj3J6Z68ntB9+ODXK1YFjXq7v9S4p
	hl/4g2qYIf8+9MGndafQlUPUuL4I=
X-Google-Smtp-Source: AGHT+IFJcbQHM3EMHfhG6M/q0JRaJJg3kLu4NYM30xjAapTo4vrYSxnym7Gq3ilXDK/hWVGog809eWjqK3SFNVb2c3A=
X-Received: by 2002:a05:6402:5106:b0:566:1952:afc4 with SMTP id
 m6-20020a056402510600b005661952afc4mr2887755edd.6.1709319507241; Fri, 01 Mar
 2024 10:58:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301185346.10412-1-robdclark@gmail.com>
In-Reply-To: <20240301185346.10412-1-robdclark@gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 1 Mar 2024 10:58:15 -0800
Message-ID: <CAF6AEGvCC=CHQ79w3H1VjYbqXsR3EmrBUj9CHot-v-wekBQZ3A@mail.gmail.com>
Subject: Re: [RFC] drm/msm: Add GPU memory traces
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Clark <robdclark@chromium.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 10:53=E2=80=AFAM Rob Clark <robdclark@gmail.com> wro=
te:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Perfetto can use these traces to track global and per-process GPU memory
> usage.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> I realized the tracepoint that perfetto uses to show GPU memory usage
> globally and per-process was already upstream, but with no users.
>
> This overlaps a bit with fdinfo, but ftrace is a lighter weight
> mechanism and fits better with perfetto (plus is already supported in
> trace_processor and perfetto UI, whereas something fdinfo based would
> require new code to be added in perfetto.

Side-note, I'm also investigating mesa based perfetto memory traces,
which can give a more granular view (ie. breakdown of memory used for
image/buffer/cmdstream/cache/etc), but not a global view.  And the
userspace based traces have the unfortunate design decision to trace
incremental rather than absolute total values, so results can be
incorrect if traces are dropped.  So neither userspace based nor
kernel based gpu memory traces are an adequate replacement for the
other.

BR,
-R

> We could probably do this more globally (ie. drm_gem_get/put_pages() and
> drm_gem_handle_create_tail()/drm_gem_object_release_handle() if folks
> prefer.  Not sure where that leaves the TTM drivers.
>
>  drivers/gpu/drm/msm/Kconfig   |  1 +
>  drivers/gpu/drm/msm/msm_drv.h |  5 +++++
>  drivers/gpu/drm/msm/msm_gem.c | 37 +++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/msm_gpu.h |  8 ++++++++
>  4 files changed, 51 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index f202f26adab2..e4c912fcaf22 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -33,6 +33,7 @@ config DRM_MSM
>         select PM_OPP
>         select NVMEM
>         select PM_GENERIC_DOMAINS
> +       select TRACE_GPU_MEM
>         help
>           DRM/KMS driver for MSM/snapdragon.
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.=
h
> index 16a7cbc0b7dd..cb8f7e804b5b 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -137,6 +137,11 @@ struct msm_drm_private {
>         struct msm_rd_state *hangrd;   /* debugfs to dump hanging submits=
 */
>         struct msm_perf_state *perf;
>
> +       /**
> +        * total_mem: Total/global amount of memory backing GEM objects.
> +        */
> +       atomic64_t total_mem;
> +
>         /**
>          * List of all GEM objects (mainly for debugfs, protected by obj_=
lock
>          * (acquire before per GEM object lock)
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.=
c
> index 175ee4ab8a6f..e04c4af5d154 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -12,6 +12,9 @@
>  #include <linux/pfn_t.h>
>
>  #include <drm/drm_prime.h>
> +#include <drm/drm_file.h>
> +
> +#include <trace/events/gpu_mem.h>
>
>  #include "msm_drv.h"
>  #include "msm_fence.h"
> @@ -33,6 +36,34 @@ static bool use_pages(struct drm_gem_object *obj)
>         return !msm_obj->vram_node;
>  }
>
> +static void update_device_mem(struct msm_drm_private *priv, ssize_t size=
)
> +{
> +       uint64_t total_mem =3D atomic64_add_return(size, &priv->total_mem=
);
> +       trace_gpu_mem_total(0, 0, total_mem);
> +}
> +
> +static void update_ctx_mem(struct drm_file *file, ssize_t size)
> +{
> +       struct msm_file_private *ctx =3D file->driver_priv;
> +       uint64_t ctx_mem =3D atomic64_add_return(size, &ctx->ctx_mem);
> +
> +       rcu_read_lock(); /* Locks file->pid! */
> +       trace_gpu_mem_total(0, pid_nr(file->pid), ctx_mem);
> +       rcu_read_unlock();
> +
> +}
> +
> +static int msm_gem_open(struct drm_gem_object *obj, struct drm_file *fil=
e)
> +{
> +       update_ctx_mem(file, obj->size);
> +       return 0;
> +}
> +
> +static void msm_gem_close(struct drm_gem_object *obj, struct drm_file *f=
ile)
> +{
> +       update_ctx_mem(file, -obj->size);
> +}
> +
>  /*
>   * Cache sync.. this is a bit over-complicated, to fit dma-mapping
>   * API.  Really GPU cache is out of scope here (handled on cmdstream)
> @@ -156,6 +187,8 @@ static struct page **get_pages(struct drm_gem_object =
*obj)
>                         return p;
>                 }
>
> +               update_device_mem(dev->dev_private, obj->size);
> +
>                 msm_obj->pages =3D p;
>
>                 msm_obj->sgt =3D drm_prime_pages_to_sg(obj->dev, p, npage=
s);
> @@ -209,6 +242,8 @@ static void put_pages(struct drm_gem_object *obj)
>                         msm_obj->sgt =3D NULL;
>                 }
>
> +               update_device_mem(obj->dev->dev_private, -obj->size);
> +
>                 if (use_pages(obj))
>                         drm_gem_put_pages(obj, msm_obj->pages, true, fals=
e);
>                 else
> @@ -1118,6 +1153,8 @@ static const struct vm_operations_struct vm_ops =3D=
 {
>
>  static const struct drm_gem_object_funcs msm_gem_object_funcs =3D {
>         .free =3D msm_gem_free_object,
> +       .open =3D msm_gem_open,
> +       .close =3D msm_gem_close,
>         .pin =3D msm_gem_prime_pin,
>         .unpin =3D msm_gem_prime_unpin,
>         .get_sg_table =3D msm_gem_prime_get_sg_table,
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.=
h
> index 2bfcb222e353..f7d2a7d6f8cc 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -428,6 +428,14 @@ struct msm_file_private {
>          * level.
>          */
>         struct drm_sched_entity *entities[NR_SCHED_PRIORITIES * MSM_GPU_M=
AX_RINGS];
> +
> +       /**
> +        * ctx_mem:
> +        *
> +        * Total amount of memory of GEM buffers with handles attached fo=
r
> +        * this context.
> +        */
> +       atomic64_t ctx_mem;
>  };
>
>  /**
> --
> 2.44.0
>

