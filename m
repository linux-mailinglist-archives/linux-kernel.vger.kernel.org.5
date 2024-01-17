Return-Path: <linux-kernel+bounces-29315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E74830CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E8EB20FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087D822F0B;
	Wed, 17 Jan 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVKYpiFJ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CE22EE0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516025; cv=none; b=AlJ0rStqArWdvYSWgEZlCQzRJ0tEFiL7Nqka57AZH2dW17GIvLU+8kiejgQDXhs8lOgV2ZnoeyQhEjlc1l+7itGuepbsIdPTQNmaafobujI8uYlYqzh0DwKqAV10Tm3qIklrZ/VYdx4StahvfjCr3H41vpN56xyX66BEsPKhFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516025; c=relaxed/simple;
	bh=NKRHrSpmwu1CWflJUUX9OhR3Z+lO3CHJlLyiMlQ2Ms4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=AzszYJfBxS1CdePM3Ewb2ZGYR4l2r68LKZIJ5XQbeJ+to2bcdL/cg0zIIl1JEDp4sWfFfI2GgLhrR0eORFbvQqJCLB/EN++HnzqDDE72FhOo1nK/B6ZmLYWb+45amJp1nkPZ9zzsm4YLcEl4lH4No+1cKBiMrEJBn7pZw778rpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVKYpiFJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33728f82a71so2413506f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705516022; x=1706120822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zQWgPbfKp6YM9aUfoUkYrRudM52sOmWJm/p3sD772Y=;
        b=PVKYpiFJq+zmwpI+/UqSCgEWU/MvusfHIw92upmpsKvkGyiWreYJ+S1aqrJoMVooFB
         6uag8Ts7SPGCEuS84A4B9NQs1NPAkUR0Bn2x0H/QQzBv7VNqT96zFAABT05azmEimJt4
         LcTPOk9CE3SjHhRtWYkL8YSvBSZIfxb3CsqiRT0EoxsydpGM6V/bsglHT0K9h4mflw0O
         niVzpovDJ5l1FQBPdCKVntpD/XG0OKrf28qpoYmcFGm4vcHQAfSYHPPxvlNiGwgQ0SDr
         5egiTTWdvyuvWpZVrTBHcOB/5uGDRYcAVW0GFjuRkH8o0sGT9WTKf5Oi3XOg25bXCvbr
         rlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705516022; x=1706120822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zQWgPbfKp6YM9aUfoUkYrRudM52sOmWJm/p3sD772Y=;
        b=KWjIKTWuzMPxzppq1ZR50mXaeP42vQcJvGxIh/0nXCJU46hLene6UOYm60mClZnV/E
         iM/keQ5WxiB3LbS6Tgsi81OBa91z4sZZVV+GWuGe+7yD8DsUK+RnyJs4bun/n8wZr/fe
         Pxwo1Ia1cxl6EiWDKJoTGDwQSxBDYpLkoBlfRKPCaxu2rGYZRb4Q105tANVTM90734JQ
         /j2MZY7b1wtlM53QIfZ8FJWHiiEXRxPl6dHkSbdSGxqY/v7Ov5xz+wuK/MCaP0QE4IVz
         Cf86EPj+hZ9KsDI34vIJxNDNwFeC/8SRCWPaN1KOFxqLyKVyEzEviUiO+WH1KRhGKmND
         cCQw==
X-Gm-Message-State: AOJu0Yyl69xxGoAPIbtKgt4oZeG4J0+gjIgwXW8oloM+ExhtEnrGMCmM
	6Q9IobgWP5eoJXvbb/9OzvKraR0xG8LZ2QowVvo=
X-Google-Smtp-Source: AGHT+IFdnC0bev8FKCUUagV9fb50fuvyKdfakd6ZW2v7kea9CH61+ePpb4Manrk974u1JjOoEErUW2Z0nZYBQvx7hpE=
X-Received: by 2002:adf:f48a:0:b0:337:c536:8516 with SMTP id
 l10-20020adff48a000000b00337c5368516mr159173wro.6.1705516021817; Wed, 17 Jan
 2024 10:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com> <20240117031212.1104034-5-nunes.erico@gmail.com>
In-Reply-To: <20240117031212.1104034-5-nunes.erico@gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Wed, 17 Jan 2024 10:26:35 -0800
Message-ID: <CA+E=qVeWi_RwLUOZJTAa6_Tx3pPTbym5_JtWYJetBiFUXnDQgw@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] drm/lima: handle spurious timeouts due to high irq latency
To: Erico Nunes <nunes.erico@gmail.com>
Cc: Qiang Yu <yuq825@gmail.com>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 7:12=E2=80=AFPM Erico Nunes <nunes.erico@gmail.com>=
 wrote:
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
Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>

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
> +
>         /* pipe fence */
>         struct dma_fence *fence;
>  };
> --
> 2.43.0
>

