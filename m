Return-Path: <linux-kernel+bounces-29668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C1E83117E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708CC2865A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FFB53B5;
	Thu, 18 Jan 2024 02:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGljgCUi"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1523D8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705546021; cv=none; b=Hdq/m0CzrkE8UvqsH/MvNF/QF/J16G64vt7BMkbS8UnQ7MSf3c3lf36I+75trmnUFt+qIsm4W3hqif2tIhjWrhvIDoL7ECnXlKLXv196EdzOJCWWBGwGWCKqJ4286iOdN4rS0sZUOpE6vOPJZBt4MDINK04ZbY0HVEcc7D51nkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705546021; c=relaxed/simple;
	bh=pFliK5BAQ9UGQWjbO0hdtlLaVjgDtiuX8rlirBqgYnk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ppCoaqA3S/qC8uLIhvbHDSIRuwXnT5yzQV12fUlCyLWsJqbC+4VdMq512qG991rdn/c5GiWWc3FLv0GIo2DSyJ1xpnmmeP1owLP2E1V/nFfWGXGtRHxS1TT8/jNn2mIynPYwHE0cJAHxgNb/vMwbEwAtceECVHC/KL1YeAwfc0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGljgCUi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-557ad92cabbso11800519a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705546018; x=1706150818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHmomQH38paTE5xCI3dpwn2LAG3AYq1xzdGV557xeOg=;
        b=aGljgCUiLQDQE64n/WLnSlR4S+kHEfvORC1jJPpj4P4PlqQVtFtyzPUjsp4fxTjssw
         1iYh/Qu+Vs8n4lfJ8kHe61e6HPIhX5h6Y9+Va5WcJUsuoP3pcqbkCNzkeEPpOCIwvV9A
         iC/ic0DG93oLPNOo+6Guin0DG4lA4arQOBYgEgHG3aPfj5aNN/xnyzy2GTRNhSL6YUKB
         gjcJHLKAC3DEPiSk/YDCwd0kAOJq/7TScS/VoAn3vnIXyiFNL8RsUXf//3PLRy8vWsYy
         vDNkdK8KGBi1W2FjnIqwjO2VdoO6nq5v6nRcFAHd1yTFr5Yd0PYxLNf6jB8qwyNSPGXe
         NJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705546018; x=1706150818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHmomQH38paTE5xCI3dpwn2LAG3AYq1xzdGV557xeOg=;
        b=F6+Xo3sjRQckEZfl9yMvYiYnMEIaaHzyaIWxfMR7uhX23DtQ4XIbf7m1UK2Ei7LRdn
         /CujLodc7K2LCVILVEI6auxafQHxmEn+/wZbXrLe6H1wC6Mzy0GH/EMYruNtp5OqwGjQ
         iccYiuU3RKvToCfILmMLKIhNKYEZ8TaDCsV+vfyn6Io17/gUYjn7M8JP/gHhp2psNc8r
         ULhs4rm0yDxSCmQ8TRY+XUTZ3fEjyKo1ccN0z9qEwMS6y3+9Pfdn8Ae7k48v5KPbNCAH
         2u0JViCbHTfJn0NJqFivRwHAxUUMlOKLfvSdq933UUvkV7zH8nrSi/3UJU7qpDbktU1M
         3oSQ==
X-Gm-Message-State: AOJu0YyvJOS/2iMn0z3+L2EIsHj1e9h2gPRpASGwL3Thx/Xg8zbvTbgo
	j1WfCYdZpovvunMgjam6egOjMUZpVEyLzb+LYUl1PqbaputJQegkuOVB+/5obaIlIBYhLCtV8aS
	yN7Y8T61++3/Hn2nJFStWltniQU4=
X-Google-Smtp-Source: AGHT+IGq7Rt3gmWSJ2cc0HSvFnvqmxggQFLvea2EmHBIRixEzzXhYjmh0FInWbQDnltu4393Q2WBCljfYusiK531JVM=
X-Received: by 2002:a50:fe97:0:b0:559:2e01:3b75 with SMTP id
 d23-20020a50fe97000000b005592e013b75mr51053edt.63.1705546018440; Wed, 17 Jan
 2024 18:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com> <20240117031212.1104034-5-nunes.erico@gmail.com>
In-Reply-To: <20240117031212.1104034-5-nunes.erico@gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Thu, 18 Jan 2024 10:46:46 +0800
Message-ID: <CAKGbVbsYJ7dusKREwpMVsxi+ryh+1ieshhwfJ72XVQ8b3x5OaA@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] drm/lima: handle spurious timeouts due to high irq latency
To: Erico Nunes <nunes.erico@gmail.com>
Cc: dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	anarsoul@gmail.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:12=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com=
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
>  drivers/gpu/drm/lima/lima_sched.c | 32 ++++++++++++++++++++++++++-----
>  drivers/gpu/drm/lima/lima_sched.h |  2 ++
>  2 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lim=
a_sched.c
> index 66317296d831..9449b81bcd5b 100644
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
> @@ -223,10 +224,7 @@ static struct dma_fence *lima_sched_run_job(struct d=
rm_sched_job *job)
>
>         task->fence =3D &fence->base;
>
> -       /* for caller usage of the fence, otherwise irq handler
> -        * may consume the fence before caller use it
> -        */
> -       dma_fence_get(task->fence);
> +       task->done_fence =3D dma_fence_get(task->fence);
>
>         pipe->current_task =3D task;
>
> @@ -401,9 +399,33 @@ static enum drm_gpu_sched_stat lima_sched_timedout_j=
ob(struct drm_sched_job *job
>         struct lima_sched_pipe *pipe =3D to_lima_pipe(job->sched);
>         struct lima_sched_task *task =3D to_lima_task(job);
>         struct lima_device *ldev =3D pipe->ldev;
> +       struct lima_ip *ip =3D pipe->processor[0];
> +
> +       /*
> +        * If the GPU managed to complete this jobs fence, the timeout is
> +        * spurious. Bail out.
> +        */
> +       if (dma_fence_is_signaled(task->done_fence)) {
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
> +       synchronize_irq(ip->irq);
> +
> +       if (dma_fence_is_signaled(task->done_fence)) {
> +               DRM_WARN("%s unexpectedly high interrupt latency\n", lima=
_ip_name(ip));
> +               return DRM_GPU_SCHED_STAT_NOMINAL;
> +       }
>
>         if (!pipe->error)
> -               DRM_ERROR("lima job timeout\n");
> +               DRM_ERROR("%s lima job timeout\n", lima_ip_name(ip));
>
>         drm_sched_stop(&pipe->base, &task->base);
>
> diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/lim=
a_sched.h
> index 6a11764d87b3..34050facb110 100644
> --- a/drivers/gpu/drm/lima/lima_sched.h
> +++ b/drivers/gpu/drm/lima/lima_sched.h
> @@ -29,6 +29,8 @@ struct lima_sched_task {
>         bool recoverable;
>         struct lima_bo *heap;
>
> +       struct dma_fence *done_fence;
This is same as the following fence, do we really need a duplicated one?

> +
>         /* pipe fence */
>         struct dma_fence *fence;
>  };
> --
> 2.43.0
>

