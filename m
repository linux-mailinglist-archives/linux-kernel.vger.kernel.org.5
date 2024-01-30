Return-Path: <linux-kernel+bounces-44265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC495841FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C431F24121
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4106605D6;
	Tue, 30 Jan 2024 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvtB9UgC"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38DE57867
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607316; cv=none; b=HiFwptQobbidgj/T+wVipvNzgxeBmTlkPY7gX/I42kwfxkgFVDBH+NGV8sstG72XkZt11caumHtpYxQym7LO37fcWdRZOka0aVwSSXQYHKZA4z0FHq5EenJlAKIlevcK55B4bac60HR0kiO4YzKKKvEW4Qu+GTjxPnYnyRBJAyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607316; c=relaxed/simple;
	bh=xE/vntbbuy6p5OfgtC9YuRGGm0FcRDT9fUPZI0X+cgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msNrDKm/5JHShSA4f8ei7vSUGm3kD9uQix49JxOc3/Mc5wj0o1H4oCYqNEj8pZUevy1oZQNBZR6ERsa6b5SwRyveYAKN4GG1lwpIzBScxC8Nz8hnyE12Wu0+oEiXPweoJuzgORaQQHjQ5LkwIdXxuwi+VYWT9Yzz3IsHqIP0ZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jvtB9UgC; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso2284460a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706607314; x=1707212114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ssAP4GXw0NA5D6Sg+UOqnY2sAyLSd3co6iPypnFNYU=;
        b=jvtB9UgCGXpeUikTdpbtu7slJFLPv9qBv/mQvoLQqEKJUza967VQUqa+tcDnduizBT
         MzEtR44ZUAVK+yQN8W2rH8QS+g5dZwrfvSgiVa/3/wF/mLB8dfEi+dXO1KTpUZPIaBJM
         ya8/Wb6GLpPAJWV9Wiy3UskG2v5Cx77HwzLELVbMOtQeq8X/B0K4iF+Cybys0FLOp4tQ
         2fnQi/Of/GE5FPpYOzbEvLE5gm76bmNa3/zJyULWVQoMqicEQiRe1UzfjZjj4yDUc+7/
         SgYa2Hz/QbSDox/H+Sc4XAGEF5OxYfXTPm2AjNcAvsJJy22aTk+3diJ7yWr63a1l9blW
         0kTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706607314; x=1707212114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ssAP4GXw0NA5D6Sg+UOqnY2sAyLSd3co6iPypnFNYU=;
        b=N1hob9UsOm91NwLWf1A8p2g/DR3ET5eCbciC5wXAdmWUhcxqP/hJfifWN/yUsmEwc+
         1rtsqP3upkPRnfQmD8q8JmrUqkgYxd9C9+bETdv9zPDREhKvvCQ40jcA1NRG6lH9O6ID
         raLbO7tMEnqTV3o37NUeR2DS6GGkLVOqvOpv43IgTpAJZ+rp81PYxbh2LwBAjef5SSoV
         8CIom4m7AM9P5O2uSmYV2egGXvCmtERhlJaNPjKCql6Py5MJo4lRlyZgy7maYK6x9RlC
         ovO5QkbqzjVXi84UX04iiKhdKjytFhbkIetp8oxs/MmcDSVvKyd9t4ksN1j7RaT4H42t
         QQZg==
X-Gm-Message-State: AOJu0YyNqto69JOGc8pJDmk4ntWq9Piu30DZNCd/G6xJAf2YIyxumgEU
	KEhBdS0kezzqacdPNlt3HeAnLOHHPWnKA+9XfCKfBNfR7rbbWYbsxVqOOb/Evaav/hiiD/Iz6tz
	bmvQryYSpvDdK++Y+JP5GgQBrDfNQREha2RNrrA==
X-Google-Smtp-Source: AGHT+IE+dWeTwNF4Xqq97nlKGrO5mFy+t85DwqQIMzYf1e+Q2+wujA7UfYrxfGpEZCzkUhLBeywawTAX1LelmzsL1T0=
X-Received: by 2002:a05:6a20:9391:b0:19c:aa78:7551 with SMTP id
 x17-20020a056a20939100b0019caa787551mr4848944pzh.19.1706607314180; Tue, 30
 Jan 2024 01:35:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109164655.626085-1-vincent.guittot@linaro.org>
 <20240109164655.626085-3-vincent.guittot@linaro.org> <20240130002652.ipdyqs3sjy6qqt6t@airbuntu>
 <20240130005028.vbqg27ctmanxsej6@airbuntu>
In-Reply-To: <20240130005028.vbqg27ctmanxsej6@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 30 Jan 2024 10:35:02 +0100
Message-ID: <CAKfTPtCJ9TXRRrCPsTam=uReDtay7dRqBpZCWQkOsbieWTuMbw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] sched: Take cpufreq feedback into account
To: Qais Yousef <qyousef@layalina.io>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org, 
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, lukasz.luba@arm.com, 
	rui.zhang@intel.com, mhiramat@kernel.org, daniel.lezcano@linaro.org, 
	amit.kachhap@gmail.com, corbet@lwn.net, gregkh@linuxfoundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 01:50, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/30/24 00:26, Qais Yousef wrote:
> > On 01/09/24 17:46, Vincent Guittot wrote:
> > > Aggregate the different pressures applied on the capacity of CPUs and
> > > create a new function that returns the actual capacity of the CPU:
> > >   get_actual_cpu_capacity()
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> > > ---
> > >  kernel/sched/fair.c | 45 +++++++++++++++++++++++++--------------------
> > >  1 file changed, 25 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 9cc20855dc2b..e54bbf8b4936 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4910,13 +4910,22 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> > >     trace_sched_util_est_se_tp(&p->se);
> > >  }
> > >
> > > +static inline unsigned long get_actual_cpu_capacity(int cpu)
> > > +{
> > > +   unsigned long capacity = arch_scale_cpu_capacity(cpu);
> > > +
> > > +   capacity -= max(thermal_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
> >
> > Does cpufreq_get_pressure() reflect thermally throttled frequency, or just the
> > policy->max being capped by user etc? I didn't see an update to cpufreq when we
> > topology_update_hw_pressure(). Not sure if it'll go through another path.
>
> It is done via the cooling device. And assume any limitations on freq due to
> power etc are assumed to always to cause the policy->max to change.
>
> (sorry if I missed earlier discussions about this)

I assume that you have answered all your questions.

We have now 2 distinct signals:
- hw high freq update which is averaged with PELT and go through
topology_update_hw_pressure
- cpufreq pressure which is not averaged (including cpufreq cooling
device with patch 3)

>
> >
> > maxing with thermal_load_avg() will change the behavior below where we used to
> > compare against instantaneous pressure. The concern was that it not just can
> > appear quickly, but disappear quickly too. thermal_load_avg() will decay
> > slowly, no?  This means we'll lose a lot of opportunities for better task
> > placement until this decays which can take relatively long time.
> >
> > So maxing handles the direction where a pressure suddenly appears. But it
> > doesn't handle where it disappears.
> >
> > I suspect your thoughts are that if it was transient then thermal_load_avg()
> > should be small anyway - which I think makes sense.
> >
> > I think we need a comment to explain these nuance differences.
> >
> > > +
> > > +   return capacity;
> > > +}
> > > +
> > >  static inline int util_fits_cpu(unsigned long util,
> > >                             unsigned long uclamp_min,
> > >                             unsigned long uclamp_max,
> > >                             int cpu)
> > >  {
> > > -   unsigned long capacity_orig, capacity_orig_thermal;
> > >     unsigned long capacity = capacity_of(cpu);
> > > +   unsigned long capacity_orig;
> > >     bool fits, uclamp_max_fits;
> > >
> > >     /*
> > > @@ -4948,7 +4957,6 @@ static inline int util_fits_cpu(unsigned long util,
> > >      * goal is to cap the task. So it's okay if it's getting less.
> > >      */
> > >     capacity_orig = arch_scale_cpu_capacity(cpu);
> > > -   capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> > >
> > >     /*
> > >      * We want to force a task to fit a cpu as implied by uclamp_max.
> > > @@ -5023,7 +5031,8 @@ static inline int util_fits_cpu(unsigned long util,
> > >      * handle the case uclamp_min > uclamp_max.
> > >      */
> > >     uclamp_min = min(uclamp_min, uclamp_max);
> > > -   if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
> > > +   if (fits && (util < uclamp_min) &&
> > > +       (uclamp_min > get_actual_cpu_capacity(cpu)))
> > >             return -1;
> > >
> > >     return fits;
> > > @@ -7404,7 +7413,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> > >              * Look for the CPU with best capacity.
> > >              */
> > >             else if (fits < 0)
> > > -                   cpu_cap = arch_scale_cpu_capacity(cpu) - thermal_load_avg(cpu_rq(cpu));
> > > +                   cpu_cap = get_actual_cpu_capacity(cpu);
> > >
> > >             /*
> > >              * First, select CPU which fits better (-1 being better than 0).
> > > @@ -7897,8 +7906,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >     struct root_domain *rd = this_rq()->rd;
> > >     int cpu, best_energy_cpu, target = -1;
> > >     int prev_fits = -1, best_fits = -1;
> > > -   unsigned long best_thermal_cap = 0;
> > > -   unsigned long prev_thermal_cap = 0;
> > > +   unsigned long best_actual_cap = 0;
> > > +   unsigned long prev_actual_cap = 0;
> > >     struct sched_domain *sd;
> > >     struct perf_domain *pd;
> > >     struct energy_env eenv;
> > > @@ -7928,7 +7937,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >
> > >     for (; pd; pd = pd->next) {
> > >             unsigned long util_min = p_util_min, util_max = p_util_max;
> > > -           unsigned long cpu_cap, cpu_thermal_cap, util;
> > > +           unsigned long cpu_cap, cpu_actual_cap, util;
> > >             long prev_spare_cap = -1, max_spare_cap = -1;
> > >             unsigned long rq_util_min, rq_util_max;
> > >             unsigned long cur_delta, base_energy;
> > > @@ -7940,18 +7949,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >             if (cpumask_empty(cpus))
> > >                     continue;
> > >
> > > -           /* Account thermal pressure for the energy estimation */
> > > +           /* Account external pressure for the energy estimation */
> > >             cpu = cpumask_first(cpus);
> > > -           cpu_thermal_cap = arch_scale_cpu_capacity(cpu);
> > > -           cpu_thermal_cap -= arch_scale_thermal_pressure(cpu);
> > > +           cpu_actual_cap = get_actual_cpu_capacity(cpu);
> > >
> > > -           eenv.cpu_cap = cpu_thermal_cap;
> > > +           eenv.cpu_cap = cpu_actual_cap;
> > >             eenv.pd_cap = 0;
> > >
> > >             for_each_cpu(cpu, cpus) {
> > >                     struct rq *rq = cpu_rq(cpu);
> > >
> > > -                   eenv.pd_cap += cpu_thermal_cap;
> > > +                   eenv.pd_cap += cpu_actual_cap;
> > >
> > >                     if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
> > >                             continue;
> > > @@ -8022,7 +8030,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >                     if (prev_delta < base_energy)
> > >                             goto unlock;
> > >                     prev_delta -= base_energy;
> > > -                   prev_thermal_cap = cpu_thermal_cap;
> > > +                   prev_actual_cap = cpu_actual_cap;
> > >                     best_delta = min(best_delta, prev_delta);
> > >             }
> > >
> > > @@ -8037,7 +8045,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >                      * but best energy cpu has better capacity.
> > >                      */
> > >                     if ((max_fits < 0) &&
> > > -                       (cpu_thermal_cap <= best_thermal_cap))
> > > +                       (cpu_actual_cap <= best_actual_cap))
> > >                             continue;
> > >
> > >                     cur_delta = compute_energy(&eenv, pd, cpus, p,
> > > @@ -8058,14 +8066,14 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >                     best_delta = cur_delta;
> > >                     best_energy_cpu = max_spare_cap_cpu;
> > >                     best_fits = max_fits;
> > > -                   best_thermal_cap = cpu_thermal_cap;
> > > +                   best_actual_cap = cpu_actual_cap;
> > >             }
> > >     }
> > >     rcu_read_unlock();
> > >
> > >     if ((best_fits > prev_fits) ||
> > >         ((best_fits > 0) && (best_delta < prev_delta)) ||
> > > -       ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
> > > +       ((best_fits < 0) && (best_actual_cap > prev_actual_cap)))
> > >             target = best_energy_cpu;
> > >
> > >     return target;
> > > @@ -9441,8 +9449,8 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
> > >
> > >  static unsigned long scale_rt_capacity(int cpu)
> > >  {
> > > +   unsigned long max = get_actual_cpu_capacity(cpu);
> > >     struct rq *rq = cpu_rq(cpu);
> > > -   unsigned long max = arch_scale_cpu_capacity(cpu);
> > >     unsigned long used, free;
> > >     unsigned long irq;
> > >
> > > @@ -9454,12 +9462,9 @@ static unsigned long scale_rt_capacity(int cpu)
> > >     /*
> > >      * avg_rt.util_avg and avg_dl.util_avg track binary signals
> > >      * (running and not running) with weights 0 and 1024 respectively.
> > > -    * avg_thermal.load_avg tracks thermal pressure and the weighted
> > > -    * average uses the actual delta max capacity(load).
> > >      */
> > >     used = READ_ONCE(rq->avg_rt.util_avg);
> > >     used += READ_ONCE(rq->avg_dl.util_avg);
> > > -   used += thermal_load_avg(rq);
> > >
> > >     if (unlikely(used >= max))
> > >             return 1;
> > > --
> > > 2.34.1
> > >

