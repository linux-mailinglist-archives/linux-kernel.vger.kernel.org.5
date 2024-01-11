Return-Path: <linux-kernel+bounces-23705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2985582B07E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE261F2438E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039E23D0C1;
	Thu, 11 Jan 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PBCkNEvl"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86943C097
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2b9e2c9858so61371066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1704982751; x=1705587551; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSSxh+RPIUMZKMpTsr13zKkvmGosyi4C4sKFagTsfmM=;
        b=PBCkNEvlaoggykFyzmmiFHVFhWFA1u5d7W66bzdVAY1r8vxSruFM1TKGmFY3wlCxMD
         /+mQbPUBpMtla6UIHzdqPWUfnJTNYfC5kOrsZXGga8U7bLK1m0Iu/XFpj/gezGLyG1gz
         o0b7NN5h+ttpKpx5D9tGKPUm8/+G1D9S6+TvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704982751; x=1705587551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSSxh+RPIUMZKMpTsr13zKkvmGosyi4C4sKFagTsfmM=;
        b=ozanygOgO8cVjkadrSBnl4Fk1Gevy0IG/Af5aQl5TdNcja8ri5SMYdHYjrOkc6Drrb
         qhf2vf39GAA71RSZDR4t9ou0fpdwQ87ghRKjagJCoY9XYFgmn74pOD8owZ2v8PvnnzEr
         hoeZJmFkoGLXEH8HGfumAuidu4she9NJXROrCcDNoJ722omatFzyRC4Vly9BUulSr3am
         w6kxiucDzH2OWAeCYLLTGoz3eA34cl1sV+3uXsRQ70xO9Vn5Ff8jT3xrSt2p79bvCyz3
         UctSLYHOT0wazzvxDIKblLGjF19F5k45cp28IFzKZnFQTpmHNPGbEgM64jA7VgsRbf6g
         Q2Wg==
X-Gm-Message-State: AOJu0YzXjOEsxJxfM/EVhzmNjx6ohzO+UDTed2cia4CT+yQu/fsgQRAa
	I/KBWve9pr5s2/Fgf42Rs7FE5ro62R6yvw==
X-Google-Smtp-Source: AGHT+IGQ8fkDdCLHmesvwOHSP1dlFaJi+Z27VHbTiwHplTSFM3BRzT5PNoP5kBL6v+Aokke4yw99vQ==
X-Received: by 2002:a17:907:96a1:b0:a26:d233:80b0 with SMTP id hd33-20020a17090796a100b00a26d23380b0mr1600615ejc.0.1704982750749;
        Thu, 11 Jan 2024 06:19:10 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id mb3-20020a170906eb0300b00a28956cf75esm629228ejb.130.2024.01.11.06.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 06:19:10 -0800 (PST)
Date: Thu, 11 Jan 2024 15:19:08 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] Revert "drm/msm/gpu: Push gpu lock down past runpm"
Message-ID: <ZZ_43N6OtvgClc8Y@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240109182218.193804-1-robdclark@gmail.com>
 <ZZ52YNc-TkeG7PZO@phenom.ffwll.local>
 <CAF6AEGusfKGou-=4y4CDd99x6TgJ1ZhAmnKwQJs1k6s8Bu07SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGusfKGou-=4y4CDd99x6TgJ1ZhAmnKwQJs1k6s8Bu07SQ@mail.gmail.com>
X-Operating-System: Linux phenom 6.5.0-4-amd64 

On Wed, Jan 10, 2024 at 06:54:53AM -0800, Rob Clark wrote:
> On Wed, Jan 10, 2024 at 2:50 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Tue, Jan 09, 2024 at 10:22:17AM -0800, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > This reverts commit abe2023b4cea192ab266b351fd38dc9dbd846df0.
> > >
> > > Changing the locking order means that scheduler/msm_job_run() can race
> > > with the recovery kthread worker, with the result that the GPU gets an
> > > extra runpm get when we are trying to power it off.  Leaving the GPU in
> > > an unrecovered state.
> >
> > The recovery kthread is supposed to stop all the relevant schedulers,
> > which should remove any possible race conditions. So unless there's more
> > going on, or you have your own recovery kthread (don't, reuse the one from
> > the scheduler with your own work items, that's why you can provide that)
> > this looks like an incomplete/incorrect explanation ... ?
> >
> > Slightly confused
> 
> msm still uses it's own recovery, which pre-dates the scheduler
> conversion.  At one point (a yr or two back?) I started looking at
> integrating recovery w/ scheduler.. at the time I think you talked me
> out of it, but I don't remember the reason

hm ... most scheduler discussions I remember was around the "allocate your
own workqueue and hand that to scheduler to avoid races/deadlocks". Which
iirc Boris implemented a while ago. Once you have that workqueue you can
then also process any other error condition on there with the exact same
locking design (like hw error or page faults or whatever), not just
drm/sched tdr.

I don't remember anything else that ever came up at least at a fundamental
level ...

So if that discussion was older than 78efe21b6f8e ("drm/sched: Allow using
a dedicated workqueue for the timeout/fault tdr") you should be covered.
Fingers crossed :-)

Meanwhile if you do not use drm/sched tdr at all then doing the exact same
design but just on your own workqueue should also work. The critical thing
is really only:
- have one single-thread workqueue for all gpu recover
- bracket each handler in there with drm_sched_stop/start for all affected
  engines

No more races!

Cheers, Sima

> 
> BR,
> -R
> 
> > -Sima
> >
> > >
> > > I'll need to come up with a different scheme for appeasing lockdep.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >  drivers/gpu/drm/msm/msm_gpu.c        | 11 +++++------
> > >  drivers/gpu/drm/msm/msm_ringbuffer.c |  7 +++++--
> > >  2 files changed, 10 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> > > index 095390774f22..655002b21b0d 100644
> > > --- a/drivers/gpu/drm/msm/msm_gpu.c
> > > +++ b/drivers/gpu/drm/msm/msm_gpu.c
> > > @@ -751,12 +751,14 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
> > >       struct msm_ringbuffer *ring = submit->ring;
> > >       unsigned long flags;
> > >
> > > -     pm_runtime_get_sync(&gpu->pdev->dev);
> > > +     WARN_ON(!mutex_is_locked(&gpu->lock));
> > >
> > > -     mutex_lock(&gpu->lock);
> > > +     pm_runtime_get_sync(&gpu->pdev->dev);
> > >
> > >       msm_gpu_hw_init(gpu);
> > >
> > > +     submit->seqno = submit->hw_fence->seqno;
> > > +
> > >       update_sw_cntrs(gpu);
> > >
> > >       /*
> > > @@ -781,11 +783,8 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
> > >       gpu->funcs->submit(gpu, submit);
> > >       gpu->cur_ctx_seqno = submit->queue->ctx->seqno;
> > >
> > > -     hangcheck_timer_reset(gpu);
> > > -
> > > -     mutex_unlock(&gpu->lock);
> > > -
> > >       pm_runtime_put(&gpu->pdev->dev);
> > > +     hangcheck_timer_reset(gpu);
> > >  }
> > >
> > >  /*
> > > diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
> > > index e0ed27739449..548f5266a7d3 100644
> > > --- a/drivers/gpu/drm/msm/msm_ringbuffer.c
> > > +++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
> > > @@ -21,8 +21,6 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
> > >
> > >       msm_fence_init(submit->hw_fence, fctx);
> > >
> > > -     submit->seqno = submit->hw_fence->seqno;
> > > -
> > >       mutex_lock(&priv->lru.lock);
> > >
> > >       for (i = 0; i < submit->nr_bos; i++) {
> > > @@ -35,8 +33,13 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
> > >
> > >       mutex_unlock(&priv->lru.lock);
> > >
> > > +     /* TODO move submit path over to using a per-ring lock.. */
> > > +     mutex_lock(&gpu->lock);
> > > +
> > >       msm_gpu_submit(gpu, submit);
> > >
> > > +     mutex_unlock(&gpu->lock);
> > > +
> > >       return dma_fence_get(submit->hw_fence);
> > >  }
> > >
> > > --
> > > 2.43.0
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

