Return-Path: <linux-kernel+bounces-36996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B8683A9F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DB61F2158E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8175776918;
	Wed, 24 Jan 2024 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHAu8Hmq"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1627560DEB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099898; cv=none; b=RKrqsxGpmCKaZUgmJVBc8do0I1sF/WzxhnqNd1USboXViGb+bIMym0mRq3/6EYhYnGVIvAriek2jk0YAEzUFlXQtbOHSC9EWAU0GMCFtrSPs0jW/KOypid5GN+kRZVkldGuAE8ZmL1ybo22N/lDnKtiEsSWCnZuyJDH17VhqzdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099898; c=relaxed/simple;
	bh=8Zc24ITyAV1zmWXgXlmMvA9ZdP5saiA23otnifF1yGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfV5lJzPDJqFexGhvSylTwVx2yV80VC87nnzfTS4w2Y9KgdW31QAXN8znjCxoyOhVNKM25jVGDMEM/HxX05GkF3M2uEwwbwfM9wiZka06toidpV8DlUbuDL6Ywz+eBAGaS1OyWy4SS/bb6ISSYtp1/i5lwSfYBnk5I7A3uKvIDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHAu8Hmq; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a3a875f7fso5976413a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706099895; x=1706704695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlopjC0q6gXyAjmdtqD86mRjd9mpn+cocTVW6/0rIOs=;
        b=IHAu8HmqFjEPlACYDftlyZP5T20hJho1WzZ4p0253dIu5uVcZO7zJPH0xkxR3qAKDZ
         JtKy4zWoYXf4Llvr7ZyJAdUcUVcoKI/fRWVVKRVCudTi/rZJ/GbHmMQSCH4T5jiewVb+
         IvElbpbtMzEHM23y0cZHQ8XYQ9B3DVNmK3MUM+EF3IPnWOZUdyxLZKwOfKV0glF0QbuL
         dIHWM7GFStcf1sT16WSvUX3gh0szvOHa6fkGu4OVxo7NOCdJDNcHqHf5KGOlR8/gkY1W
         D9vDLC51zov+WB4meDqLU0ZAcxzL9w7vSoxy5UCYoP0CH0Z1HPUmPIhjNfvbNM7ylFd9
         d1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099895; x=1706704695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlopjC0q6gXyAjmdtqD86mRjd9mpn+cocTVW6/0rIOs=;
        b=YVV8YFFuZuPp0fz09e6PBcAYUZv2xH6ey3rU32XSlEn9IWTY5tLETFdsnXttDpQZZr
         Z86Y44J8cU0CAimIrmmIAudcdUN2YF+/0A8weMTr8d1YiGlS6akLgdyeXcdl6V5TDQT1
         jRZSje1mW3nXlKq5QLrllqJAR1sKcgv/0Uuym/Z5wbAhyfe9zwdKTM7+U6NmK50Nf6Lw
         YAFRuu+KoEXrf7j04xKVMS9jCW+/R9mMmeYsYr2cMuH0SdeqlTLFvflLEaEVSxRNKD9t
         6Mx8RlZXP/iW21vIARNGTazz2tKi/rstg32yrKT35kgnCtRWEwsiKSqdLuRf0GyTSCBa
         60Rw==
X-Gm-Message-State: AOJu0YyGqw/d3v8TZDdB/kPn/YaIXP+YjLMzA6cD3jC5NnSPAvkHxhBo
	A0K1eUxPRtI2QGVWLmJ8f0PPZR9iA2ouDa40rxCCYyC4nxQ0r/7iFd75bTIl/+s/rN5pH6wvHxu
	n5ydqeMTPQ593eSmmkGQaRT6InLo=
X-Google-Smtp-Source: AGHT+IF8foS+5EcfCkQar6U3K3HFHH63zXr30/hlkj0LOBnxNGf2IpLJdLKhSHgYKfQPDO8Lu3tvb0Vzs4snbUtvQ08=
X-Received: by 2002:a17:906:5a51:b0:a23:6c9c:d4ce with SMTP id
 my17-20020a1709065a5100b00a236c9cd4cemr770213ejc.116.1706099895001; Wed, 24
 Jan 2024 04:38:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124025947.2110659-1-nunes.erico@gmail.com> <20240124025947.2110659-6-nunes.erico@gmail.com>
In-Reply-To: <20240124025947.2110659-6-nunes.erico@gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Wed, 24 Jan 2024 20:38:02 +0800
Message-ID: <CAKGbVbsjNdnoNW2JnxCiyZg-wjU0UK+jgsG18OFaHjdkdOWRQA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] drm/lima: handle spurious timeouts due to high irq latency
To: Erico Nunes <nunes.erico@gmail.com>
Cc: anarsoul@gmail.com, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 11:00=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com=
> wrote:
>
> There are several unexplained and unreproduced cases of rendering
> timeouts with lima, for which one theory is high IRQ latency coming from
> somewhere else in the system.
> This kind of occurrence may cause applications to trigger unnecessary
> resets of the GPU or even applications to hang if it hits an issue in
> the recovery path.
> Panfrost already does some special handling to account for such
> "spurious timeouts", it makes sense to have this in lima too to reduce
> the chance that it hit users.
>
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> ---
>  drivers/gpu/drm/lima/lima_sched.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lim=
a_sched.c
> index c3bf8cda8498..814428564637 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0 OR MIT
>  /* Copyright 2017-2019 Qiang Yu <yuq825@gmail.com> */
>
> +#include <linux/hardirq.h>
>  #include <linux/iosys-map.h>
>  #include <linux/kthread.h>
>  #include <linux/slab.h>
> @@ -401,9 +402,35 @@ static enum drm_gpu_sched_stat lima_sched_timedout_j=
ob(struct drm_sched_job *job
>         struct lima_sched_pipe *pipe =3D to_lima_pipe(job->sched);
>         struct lima_sched_task *task =3D to_lima_task(job);
>         struct lima_device *ldev =3D pipe->ldev;
> +       struct lima_ip *ip =3D pipe->processor[0];
> +       int i;
> +
> +       /*
> +        * If the GPU managed to complete this jobs fence, the timeout is
> +        * spurious. Bail out.
> +        */
> +       if (dma_fence_is_signaled(task->fence)) {
> +               DRM_WARN("%s spurious timeout\n", lima_ip_name(ip));
> +               return DRM_GPU_SCHED_STAT_NOMINAL;
> +       }
> +
> +       /*
> +        * Lima IRQ handler may take a long time to process an interrupt
> +        * if there is another IRQ handler hogging the processing.
> +        * In order to catch such cases and not report spurious Lima job
> +        * timeouts, synchronize the IRQ handler and re-check the fence
> +        * status.
> +        */
> +       for (i =3D 0; i < pipe->num_processor; i++)
> +               synchronize_irq(pipe->processor[i]->irq);
> +
I have a question, this timeout handler will be called when GP/PP error IRQ=
.
If we call synchronize_irq() in the IRQ handler, will we block ourselves he=
re?

> +       if (dma_fence_is_signaled(task->fence)) {
> +               DRM_WARN("%s unexpectedly high interrupt latency\n", lima=
_ip_name(ip));
> +               return DRM_GPU_SCHED_STAT_NOMINAL;
> +       }
>
>         if (!pipe->error)
> -               DRM_ERROR("lima job timeout\n");
> +               DRM_ERROR("%s job timeout\n", lima_ip_name(ip));
>
>         drm_sched_stop(&pipe->base, &task->base);
>
> @@ -417,8 +444,6 @@ static enum drm_gpu_sched_stat lima_sched_timedout_jo=
b(struct drm_sched_job *job
>         if (pipe->bcast_mmu)
>                 lima_mmu_page_fault_resume(pipe->bcast_mmu);
>         else {
> -               int i;
> -
>                 for (i =3D 0; i < pipe->num_mmu; i++)
>                         lima_mmu_page_fault_resume(pipe->mmu[i]);
>         }
> --
> 2.43.0
>

