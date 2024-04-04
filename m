Return-Path: <linux-kernel+bounces-131435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C0B8987E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC40B21F16
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7140B86243;
	Thu,  4 Apr 2024 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFSPtpq2"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11514DA1F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233869; cv=none; b=KzzzASInpUqwLIq/W9f3Byc/oIWKZ5JCOUVqCSlVoZuw+KXuJSfCjJh7kx/WUlMBy/CpBDYqCmBXB+pWDVArzK4lPV6y+XP9h1WVd/b9v/e9UkMGqItxKHNzkXRDeB5s45SUnO3krEGMz8yMveq2/QLiM7H6epSJdra5ovK+BG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233869; c=relaxed/simple;
	bh=P4zqcMdCmYtHPZyKMMeFgFdqcBROEcKl7hbGgQZIJDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KI6M7zLXNO8GORuSTGZgTsZdffYejIpfFdkKbHQbO55oRoTpjYwmE7LqRfyEj3n6hyWSkpoiQA4pAr8cAxvQQ2gxjFDwGWGOYCGPU8iX21/mtEqMostogwWurIsHqXjJ1KRdN3qGaI7NyDcLOSEzZ2ehrKqtGaTrb0wigWBccas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFSPtpq2; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso1102268a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712233866; x=1712838666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IwmRgdEPnj6cEnpM8t1VttTnz3a23m0KMK2QPuZLz0=;
        b=cFSPtpq2Yg0ep1r4qTrgO6XbYE/dkc8Hi/WPZAc3SZaSXs8auWem+dwzdYV9ZZNRX3
         yskYQ3mSTErzQw9aRwi6/f3hAHZFUxi+kvrRrYb/SwVLrGbBnEER6Yw/2ihG6rHxwF2f
         VfIVoDBUnwGtPoPN5EJTSsVVKITkhEM+ZGK5qjBMTw5gVLOoJSIFnFgbaSMDVWxntVqi
         ieclvCp2tcc+1ITzvQPKrzsL2mP/15srWtisRLTjADWZHnmmLDQW90kwU45JVNAflnTM
         IaUj6UuqoGHruw6TdfhRFCG2W+TMKdvF5eTlJSz1rP+L775VlV8SIMkKLfNJr0w3dznu
         4Jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233866; x=1712838666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IwmRgdEPnj6cEnpM8t1VttTnz3a23m0KMK2QPuZLz0=;
        b=nFUIAnSkLtidO190/vxbjtrJvd5zrctNK8YkUge2v9u/lwyP7cA7P0fd/fSetFV19Q
         tDbkCLkFTc76k94YOPKojoRkL2mK1hnli/kFbO4wLwliMNREnH4aNYd0qQYBwYqg5AFc
         iBJDK6qMNsFC99KJ2t1mMbsCxLzOEIctepRk2DBMImKKm7nLFmNb3+2CU5vvKpOWVCI5
         efXTwVhVnpn8pDD6SsefEfmWlHjpL2SJn8wQudOAmimX+4oT51K/g2V07xkROxGUoe6R
         amW7AQ5NiCKYGkWQJK+1h9ek5tF+jEoWcv3rx8YiBcPzGh6uZb/81pxUqelIa3flLQ7l
         VueA==
X-Forwarded-Encrypted: i=1; AJvYcCWueqZGlpSju+zIi/h9Uz66Fw8SQ9r8N6c7HTlAoAdgZYpm1Yt5tVLzxYpc2HwY3jHfKaZ05FIZJWhVY5/dcsKwOR+k0jo9YH4bLHBK
X-Gm-Message-State: AOJu0YygWavBToo43hv4TwmRciKj2XQcvnEhEampkYfNArFo0S0E1K2c
	entFbs/mgawEfTrxHEjqL20+B8H9YdMC74RlgO9sTYlNRAHD1zMM4j9KVFIx4VInqhrUxGX6LD/
	vdYJQ0F3yqUIEukUaNO7Q/S2ycC0=
X-Google-Smtp-Source: AGHT+IETa7eilRYg5Y9zUhLi3sU/C9hg7AHUP2APVSNJT8KU7TPwO4zk3TrN86ComgfhKrwthCS+ouSEaNvdFDlvaDI=
X-Received: by 2002:a50:8e5d:0:b0:56b:dd3c:7df8 with SMTP id
 29-20020a508e5d000000b0056bdd3c7df8mr1324314edx.19.1712233865834; Thu, 04 Apr
 2024 05:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401212002.1191549-1-nunes.erico@gmail.com> <20240401212002.1191549-2-nunes.erico@gmail.com>
In-Reply-To: <20240401212002.1191549-2-nunes.erico@gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Thu, 4 Apr 2024 20:30:53 +0800
Message-ID: <CAKGbVbtbhJEyP_ovvD6ZGrh-PBdC-SfY=DaxCk32C44Un+XpRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/lima: add mask irq callback to gp and pp
To: Erico Nunes <nunes.erico@gmail.com>
Cc: anarsoul@gmail.com, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	christian.koenig@amd.com, megi@xff.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 5:20=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com> =
wrote:
>
> This is needed because we want to reset those devices in device-agnostic
> code such as lima_sched.
> In particular, masking irqs will be useful before a hard reset to
> prevent race conditions.
>
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> ---
>  drivers/gpu/drm/lima/lima_bcast.c | 12 ++++++++++++
>  drivers/gpu/drm/lima/lima_bcast.h |  3 +++
>  drivers/gpu/drm/lima/lima_gp.c    |  8 ++++++++
>  drivers/gpu/drm/lima/lima_pp.c    | 18 ++++++++++++++++++
>  drivers/gpu/drm/lima/lima_sched.c |  2 ++
>  drivers/gpu/drm/lima/lima_sched.h |  1 +
>  6 files changed, 44 insertions(+)
>
> diff --git a/drivers/gpu/drm/lima/lima_bcast.c b/drivers/gpu/drm/lima/lim=
a_bcast.c
> index fbc43f243c54..6d000504e1a4 100644
> --- a/drivers/gpu/drm/lima/lima_bcast.c
> +++ b/drivers/gpu/drm/lima/lima_bcast.c
> @@ -43,6 +43,18 @@ void lima_bcast_suspend(struct lima_ip *ip)
>
>  }
>
> +int lima_bcast_mask_irq(struct lima_ip *ip)
> +{
> +       bcast_write(LIMA_BCAST_BROADCAST_MASK, 0);
> +       bcast_write(LIMA_BCAST_INTERRUPT_MASK, 0);
> +       return 0;
> +}
> +
> +int lima_bcast_reset(struct lima_ip *ip)
> +{
> +       return lima_bcast_hw_init(ip);
> +}
> +
>  int lima_bcast_init(struct lima_ip *ip)
>  {
>         int i;
> diff --git a/drivers/gpu/drm/lima/lima_bcast.h b/drivers/gpu/drm/lima/lim=
a_bcast.h
> index 465ee587bceb..cd08841e4787 100644
> --- a/drivers/gpu/drm/lima/lima_bcast.h
> +++ b/drivers/gpu/drm/lima/lima_bcast.h
> @@ -13,4 +13,7 @@ void lima_bcast_fini(struct lima_ip *ip);
>
>  void lima_bcast_enable(struct lima_device *dev, int num_pp);
>
> +int lima_bcast_mask_irq(struct lima_ip *ip);
> +int lima_bcast_reset(struct lima_ip *ip);
> +
>  #endif
> diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_g=
p.c
> index 6b354e2fb61d..e15295071533 100644
> --- a/drivers/gpu/drm/lima/lima_gp.c
> +++ b/drivers/gpu/drm/lima/lima_gp.c
> @@ -233,6 +233,13 @@ static void lima_gp_task_mmu_error(struct lima_sched=
_pipe *pipe)
>         lima_sched_pipe_task_done(pipe);
>  }
>
> +static void lima_gp_task_mask_irq(struct lima_sched_pipe *pipe)
> +{
> +       struct lima_ip *ip =3D pipe->processor[0];
> +
> +       gp_write(LIMA_GP_INT_MASK, 0);
> +}
> +
>  static int lima_gp_task_recover(struct lima_sched_pipe *pipe)
>  {
>         struct lima_ip *ip =3D pipe->processor[0];
> @@ -365,6 +372,7 @@ int lima_gp_pipe_init(struct lima_device *dev)
>         pipe->task_error =3D lima_gp_task_error;
>         pipe->task_mmu_error =3D lima_gp_task_mmu_error;
>         pipe->task_recover =3D lima_gp_task_recover;
> +       pipe->task_mask_irq =3D lima_gp_task_mask_irq;
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_p=
p.c
> index d0d2db0ef1ce..a4a2ffe6527c 100644
> --- a/drivers/gpu/drm/lima/lima_pp.c
> +++ b/drivers/gpu/drm/lima/lima_pp.c
> @@ -429,6 +429,9 @@ static void lima_pp_task_error(struct lima_sched_pipe=
 *pipe)
>
>                 lima_pp_hard_reset(ip);
>         }
> +
> +       if (pipe->bcast_processor)
> +               lima_bcast_reset(pipe->bcast_processor);
>  }
>
>  static void lima_pp_task_mmu_error(struct lima_sched_pipe *pipe)
> @@ -437,6 +440,20 @@ static void lima_pp_task_mmu_error(struct lima_sched=
_pipe *pipe)
>                 lima_sched_pipe_task_done(pipe);
>  }
>
> +static void lima_pp_task_mask_irq(struct lima_sched_pipe *pipe)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < pipe->num_processor; i++) {
> +               struct lima_ip *ip =3D pipe->processor[i];
> +
> +               pp_write(LIMA_PP_INT_MASK, 0);
> +       }
> +
> +       if (pipe->bcast_processor)
> +               lima_bcast_mask_irq(pipe->bcast_processor);
> +}
> +
>  static struct kmem_cache *lima_pp_task_slab;
>  static int lima_pp_task_slab_refcnt;
>
> @@ -468,6 +485,7 @@ int lima_pp_pipe_init(struct lima_device *dev)
>         pipe->task_fini =3D lima_pp_task_fini;
>         pipe->task_error =3D lima_pp_task_error;
>         pipe->task_mmu_error =3D lima_pp_task_mmu_error;
> +       pipe->task_mask_irq =3D lima_pp_task_mask_irq;
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lim=
a_sched.c
> index 00b19adfc888..66841503a618 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -422,6 +422,8 @@ static enum drm_gpu_sched_stat lima_sched_timedout_jo=
b(struct drm_sched_job *job
>          */
>         for (i =3D 0; i < pipe->num_processor; i++)
>                 synchronize_irq(pipe->processor[i]->irq);
> +       if (pipe->bcast_processor)
> +               synchronize_irq(pipe->bcast_processor->irq);
Better split this into another patch as it does not match the commit commen=
t.

>
>         if (dma_fence_is_signaled(task->fence)) {
>                 DRM_WARN("%s unexpectedly high interrupt latency\n", lima=
_ip_name(ip));
> diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/lim=
a_sched.h
> index 6bd4f3b70109..85b23ba901d5 100644
> --- a/drivers/gpu/drm/lima/lima_sched.h
> +++ b/drivers/gpu/drm/lima/lima_sched.h
> @@ -80,6 +80,7 @@ struct lima_sched_pipe {
>         void (*task_error)(struct lima_sched_pipe *pipe);
>         void (*task_mmu_error)(struct lima_sched_pipe *pipe);
>         int (*task_recover)(struct lima_sched_pipe *pipe);
> +       void (*task_mask_irq)(struct lima_sched_pipe *pipe);
>
>         struct work_struct recover_work;
>  };
> --
> 2.44.0
>

