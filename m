Return-Path: <linux-kernel+bounces-40170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 950CC83DB93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1530B1F23250
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4131C298;
	Fri, 26 Jan 2024 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkvhfYLz"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B2C1B7F2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278552; cv=none; b=ABokpp4a7DgxXopd1dwRSL04odGUWleJk+jwQANqsmVcyFr+3kiFrKacnskuFFzgYR7qb92X2cAGMQeVeln9yHstgmql8pJHjrimtxBcaa74u2vJu6VJDRgx1v61u5iDSe48IpR48Fzt1xqU66hQfc9aTBHYwoE8mv0JBynyVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278552; c=relaxed/simple;
	bh=tbTDx3U5Uxw1R6UK/gPIMpgoPjs0bTE6W24CmvzKbFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeRv6u9cA+GC7OVOCQtcpCTmdnFOGRZD1R5kyFNjbBHi0BDO9go3DDbs8BQEFuxbWpRTgphgdwPFCLNCx9leHMCdX0aFUc8ArNKJIdLR3Ds6vf/VHGp5ic+0oJrem2uEOIvxDqsyxx9OdGHYzwSD1k62ROuk77/iWDpCwrbd2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MkvhfYLz; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce74ea4bf2so252803a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706278550; x=1706883350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i1HpxNdRzxOmOcp1Tc5jcPtksKFkEnhSxsgErtMvPCc=;
        b=MkvhfYLz/JEYA+a7xZjuN4B11XiJLyeuJrG3d2+GmRTZdWRHn/NGgDjE6Yfqpbi/Oy
         Z3shOgEOp16KCJGcPLbtVjmlmdNihmhPIYVTZEsoV55CUphUpEddrh6axHFiHCdb5DH8
         IBrGcZ9c+SUFReU5kwQ2nJK3CtH4vIH/+JHQsPp3NQfWHaceC8BTH9/EcIq2L3KIgqJz
         j37LT0JtfHUfy3VeU4nUkBJ5fzQe2kKgXOemCQNPFmNUjMXK82LFpZPdzIYYFUmPAVLx
         oLhv3+JEw1HwHcSAwi8rjYQNAChcMcb3pLuxS3pHt4+oR2aYkVN7xFEn857MQr/YtFgk
         gltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706278550; x=1706883350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1HpxNdRzxOmOcp1Tc5jcPtksKFkEnhSxsgErtMvPCc=;
        b=BFAVv7oTZiSBP+xqna0mtTyUzr3D08NLVPJIWUmk7nInWFNzDew5Mp6HpSyaLqTLJA
         5T3BaHzgu79HCQNzbcKUheAzJ2+8EC/oZKUdHt7sG1YSxgs+8Xh/1m0CijMSnPpujoax
         oNDxGO+KGYS1Fe6khi9Un7Aun0x2OEJryxPGmaeLNEJMGuyGC74/yVuA5h18eewzTOMs
         9Gu1ovIAYp6JmkpWr00BRYj+RmgBVZC0mBwO5t6lJSigYr3Y6JSuDpQVIyasyxq8rTFv
         9EHW21bpv3xi+CIgmpJA/zlp2Hk+leOElKvgbpUd9Kei3JCfd7Dp9a8xmLhPc6o74Nzr
         CLVw==
X-Gm-Message-State: AOJu0Yxbxp/XVe2j1RlcI4s+l2HQw/2aJF+cWFodEhLqBVl9py4AjtjU
	IfYN6gXr71gwLUIKG0yF1izj1Hw4ZgXz2MqCQcXlKkwbPye1jGwJxxl/sxoTnndVyn5Uc2neCD1
	SPeBWClIi7coZASzZAIQ1/YT4fFgbRqDxQICOaA==
X-Google-Smtp-Source: AGHT+IFpvTdJowxVPxD423TWvR2zEuZTeLwsylJps8wTXO4SNqpGJW3NDnOKUpA/7+LX6Imb105sJu24JTBQNxgEeuk=
X-Received: by 2002:a17:90b:3796:b0:293:3edd:f289 with SMTP id
 mz22-20020a17090b379600b002933eddf289mr1360694pjb.2.1706278550166; Fri, 26
 Jan 2024 06:15:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105222014.1025040-1-qyousef@layalina.io> <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBTbudKM3Lxv0dQ4EXchLW9G8LszArzp6phzhND4O7XSw@mail.gmail.com>
 <20240124223842.zjsolwhp26w7vowu@airbuntu> <CAKfTPtAHQ9vJK_GZdpDC3GzHYWnzLc9USFNW9LSONcWVxybwrA@mail.gmail.com>
 <20240126020743.tca257nvnlpyya2y@airbuntu>
In-Reply-To: <20240126020743.tca257nvnlpyya2y@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 26 Jan 2024 15:15:39 +0100
Message-ID: <CAKfTPtAincvMD8GGJsk32-chXCsvgMrPikf=z97kRy=5R-kXgA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 03:07, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/25/24 18:50, Vincent Guittot wrote:
> > On Wed, 24 Jan 2024 at 23:38, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 01/23/24 18:22, Vincent Guittot wrote:
> > >
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index bcea3d55d95d..0830ceb7ca07 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -5065,17 +5065,61 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> > > > >
> > > > >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> > > > >  {
> > > > > +       unsigned long uclamp_min, uclamp_max;
> > > > > +       unsigned long util, cpu_cap;
> > > > > +       int cpu = cpu_of(rq);
> > > > > +
> > > > >         if (!sched_asym_cpucap_active())
> > > > >                 return;
> > > > >
> > > > > -       if (!p || p->nr_cpus_allowed == 1) {
> > > > > -               rq->misfit_task_load = 0;
> > > > > -               return;
> > > > > -       }
> > > > > +       if (!p || p->nr_cpus_allowed == 1)
> > > > > +               goto out;
> > > > >
> > > > > -       if (task_fits_cpu(p, cpu_of(rq))) {
> > > > > -               rq->misfit_task_load = 0;
> > > > > -               return;
> > > > > +       cpu_cap = arch_scale_cpu_capacity(cpu);
> > > > > +
> > > > > +       /* If we can't fit the biggest CPU, that's the best we can ever get. */
> > > > > +       if (cpu_cap == SCHED_CAPACITY_SCALE)
> > > > > +               goto out;
> > > > > +
> > > > > +       uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> > > > > +       uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> > > > > +       util = task_util_est(p);
> > > > > +
> > > > > +       if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0)
> > > > > +               goto out;
> > > > > +
> > > > > +       /*
> > > > > +        * If the task affinity is not set to default, make sure it is not
> > > > > +        * restricted to a subset where no CPU can ever fit it. Triggering
> > > > > +        * misfit in this case is pointless as it has no where better to move
> > > > > +        * to. And it can lead to balance_interval to grow too high as we'll
> > > > > +        * continuously fail to move it anywhere.
> > > > > +        */
> > > > > +       if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
> > > > > +               unsigned long clamped_util = clamp(util, uclamp_min, uclamp_max);
> > > > > +               bool has_fitting_cpu = false;
> > > > > +               struct asym_cap_data *entry;
> > > > > +
> > > > > +               rcu_read_lock();
> > > > > +               list_for_each_entry_rcu(entry, &asym_cap_list, link) {
> > > >
> > > > Do we really want to potentially do this loop at every pick_next task ?
> > >
> > > The common case should return quickly as the biggest CPU should be present
> > > in every task by default. And after sorting the biggest CPU will be the first
> > > entry and we should return after one check.
> > >
> > > Could we move the update to another less expensive location instead?
> >
> > TBH, I don't know. I would need time to think about this...
> > May be when we set the new affinity of the task
>
> I was thinking to actually call update_misfit_status() from another less
> expensive location.
>
> We can certainly do something to help the check less expensive if we must do it
> in pick_next_task(). For example set a flag if the task belongs to a single
> capacity value; and store the highest capacity its affinity belongs too. But
> with cpuset v1, v2 and hotplug I am wary that might get messy.

I think it worth looking at such solution as this would mean parsing
the possible max capacity for the task only once per affinity change

>
> >
> > >
> > > We could try to do better tracking for CPUs that has their affinity changed,
> > > but I am not keen on sprinkling more complexity else where to deal with this.
> > >
> > > We could keep the status quouo and just prevent the misfit load balancing from
> > > increment nr_failed similar to newidle_balance too. I think this should have
> >
> > One main advantage is that we put the complexity out of the fast path
>
> How about when we update_load_avg()? After all it's the util the decides if we
> become misfit. So it makes sense to do the check when we update the util for
> the task.
>
> Which reminds me of another bug. We need to call update_misfit_status() when
> uclamp values change too.
>
> >
> > > a similar effect. Not ideal but if this is considered too expensive still
> > > I can't think of other options that don't look ugly to me FWIW.
> > >
> > >
> > > Thanks
> > >
> > > --
> > > Qais Yousef

