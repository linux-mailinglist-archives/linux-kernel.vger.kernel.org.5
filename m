Return-Path: <linux-kernel+bounces-34896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 454C48388F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B16EFB21D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE1353812;
	Tue, 23 Jan 2024 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pXHintKM"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A92134C2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998750; cv=none; b=CaBsZdAL/VJGCC6G1ABAZM3mYqvZ18dzBYUmx3uFB79Td7wUbBkLYkPUpUiUyp5jLrLj5orVMK6QTT0oDeAVMH2Nl4ytrH4cAhZy1xmy1cGXh0N8rFkH7x3v9Lux/rXM7igNAwfGFtO9g2eqVzTPmNbqput8xSKjMdmYcC4cawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998750; c=relaxed/simple;
	bh=T6PbmXuTc2XnNqGgLEZCpmWnaOzMXXw64Ie7SzNqQfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAYGs8STSvN3GB4Vqm1WIHR3qeOvAypwR6ADZ3RwY7FbGFeEkOG9Ob0IzRsH8gqorRuaKHfuQX4uvOsTy5+yYUkv000q6g/XkxzLIo/isUS5+R7z2dBFFsnbf8C0EaRSIXNRwh2MtFae5kwS3rOkBU58Sn9a6qcbrJy3g3ZKcjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pXHintKM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dd80d3d419so89920b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705998749; x=1706603549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dab06sjdKIpTPjV6PQYmokEqjfInIDZyaKpkRpvx1vY=;
        b=pXHintKMNX52l5Mem3cO59llh1wuUdmzF98277E1BXY9iyQKunuMP5o1R3YfZJ0dyc
         L1W2Bshw+K3pfHJVL/sSclI92Mr3MP4l9E0rnMunFM6DaV96VOnunvmvEZmIF8fAmgP7
         jaeMiXKvXx9hgjythWVff3GMV9mTQ8yHjW5Rzb3gAUTrCCiRSTz+jhextWkBDbdiqiWJ
         CZIsu3g3kisEJ8hNzTU/KFxDJMq20DgsktW+7qKhUlRj+nK0TyRnmBocc+HQd6NbCgNb
         v0AXE3F5/6PwS2IEl7rcW3jJ5q69S5VdrNYduH50rn1rMdQsvdPgWk1Wjt3UZuCZ5U4J
         AVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705998749; x=1706603549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dab06sjdKIpTPjV6PQYmokEqjfInIDZyaKpkRpvx1vY=;
        b=FkROVcRDoQulLRcGFYdg757whOviT8puR3mD2eytEDHzQxoBCyNlBUOppcP1eWH5PM
         GfmqgXfrRx8AjlxMm39nb+alpsYkuodhmxYAY4SqPE+y2x+KWkn8JVlbOkFFkwuhppYR
         U3YD9C6fb+gQGtLULGb/TB9EEs6cYeQG2UhrYjPj0Yom/mS6KwmmYZd1NjjaR8ngLBg4
         uD0lqbZpvKbNsAH5xi9bT35/ymMQLI17CR2vBNbGUXA5ePQHPbYNIq3SXFtNwHa1Wm0I
         94RiXZQGS03HK2C3RSepT1Tqv9iyKt+2keLExuJhs7LsAUWpSx7eJ52bkvsXeT3p0f90
         vnyQ==
X-Gm-Message-State: AOJu0YykghNgMg4CxEICgefqviNXEz3LNCjLJN7hlt/GbDr0Nwd3n/NS
	0sN3QtmRJP67dlKZSowsb5VHEqEd+guG1zkjO8HJqoXbSqO+VPbAXUuw0z4K9ETcl7JpGRPHEJh
	/upFytlkE2iwSh57DgKQ/GS687s5dTjfdZ3g8HQ==
X-Google-Smtp-Source: AGHT+IFwICqS9Iu4ri6CaqLtLQMcaPt6zdoeXaQomzQUmB3UoxZyfyJzL6rwc3PLLb1X4rwH41vFFItzHFC0PQlMuKE=
X-Received: by 2002:a05:6a20:12d1:b0:19c:50e2:7a7 with SMTP id
 v17-20020a056a2012d100b0019c50e207a7mr1675120pzg.5.1705998748748; Tue, 23 Jan
 2024 00:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105222014.1025040-1-qyousef@layalina.io> <20240105222014.1025040-2-qyousef@layalina.io>
 <213f94df-cc36-4281-805d-9f56cbfef796@arm.com>
In-Reply-To: <213f94df-cc36-4281-805d-9f56cbfef796@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 23 Jan 2024 09:32:17 +0100
Message-ID: <CAKfTPtCfYcD_zPr7PqgL5hRYny=n3KW8hr6GY8q7zkoyRN7gQg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 10:59, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 05/01/2024 23:20, Qais Yousef wrote:
> > From: Qais Yousef <qais.yousef@arm.com>
> >
> > If a misfit task is affined to a subset of the possible cpus, we need to
> > verify that one of these cpus can fit it. Otherwise the load balancer
> > code will continuously trigger needlessly leading the balance_interval
> > to increase in return and eventually end up with a situation where real
> > imbalances take a long time to address because of this impossible
> > imbalance situation.
> >
> > This can happen in Android world where it's common for background tasks
> > to be restricted to little cores.
> >
> > Similarly if we can't fit the biggest core, triggering misfit is
> > pointless as it is the best we can ever get on this system.
> >
> > To be able to detect that; we use asym_cap_list to iterate through
> > capacities in the system to see if the task is able to run at a higher
> > capacity level based on its p->cpus_ptr. To do so safely, we convert the
> > list to be RCU protected.
> >
> > To be able to iterate through capacity levels, export asym_cap_list to
> > allow for fast traversal of all available capacity levels in the system.
> >
> > Test:
> > =====
> >
> > Add
> >
> >       trace_printk("balance_interval = %lu\n", interval)
> >
> > in get_sd_balance_interval().
> >
> > run
> >       if [ "$MASK" != "0" ]; then
> >               adb shell "taskset -a $MASK cat /dev/zero > /dev/null"
> >       fi
> >       sleep 10
> >       // parse ftrace buffer counting the occurrence of each valaue
> >
> > Where MASK is either:
> >
> >       * 0: no busy task running
>
> ... no busy task stands for no misfit scenario?
>
> >       * 1: busy task is pinned to 1 cpu; handled today to not cause
> >         misfit
> >       * f: busy task pinned to little cores, simulates busy background
> >         task, demonstrates the problem to be fixed
> >
>
> [...]
>
> > +     /*
> > +      * If the task affinity is not set to default, make sure it is not
> > +      * restricted to a subset where no CPU can ever fit it. Triggering
> > +      * misfit in this case is pointless as it has no where better to move
> > +      * to. And it can lead to balance_interval to grow too high as we'll
> > +      * continuously fail to move it anywhere.
> > +      */
> > +     if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
>
> Shouldn't this be cpu_active_mask ?
>
> include/linux/cpumask.h
>
>  * cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
>  * cpu_present_mask - has bit 'cpu' set iff cpu is populated
>  * cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
>  * cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
>
>
> > +             unsigned long clamped_util = clamp(util, uclamp_min, uclamp_max);
> > +             bool has_fitting_cpu = false;
> > +             struct asym_cap_data *entry;
> > +
> > +             rcu_read_lock();
> > +             list_for_each_entry_rcu(entry, &asym_cap_list, link) {
> > +                     if (entry->capacity > cpu_cap) {
> > +                             cpumask_t *cpumask;
> > +
> > +                             if (clamped_util > entry->capacity)
> > +                                     continue;
> > +
> > +                             cpumask = cpu_capacity_span(entry);
> > +                             if (!cpumask_intersects(p->cpus_ptr, cpumask))
> > +                                     continue;
> > +
> > +                             has_fitting_cpu = true;
> > +                             break;
> > +                     }
> > +             }
>
> What happen when we hotplug out all CPUs of one CPU capacity value?
> IMHO, we don't call asym_cpu_capacity_scan() with !new_topology
> (partition_sched_domains_locked()).
>
> > +             rcu_read_unlock();
> > +
> > +             if (!has_fitting_cpu)
> > +                     goto out;
> >       }
> >
> >       /*
> > @@ -5083,6 +5127,9 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> >        * task_h_load() returns 0.
> >        */
> >       rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
> > +     return;
> > +out:
> > +     rq->misfit_task_load = 0;
> >  }
> >
> >  #else /* CONFIG_SMP */
> > @@ -9583,9 +9630,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
> >   */
> >  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> >  {
> > -     return rq->misfit_task_load &&
> > -             (arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
> > -              check_cpu_capacity(rq, sd));
> > +     return rq->misfit_task_load && check_cpu_capacity(rq, sd);
>
> You removed 'arch_scale_cpu_capacity(rq->cpu) <
> rq->rd->max_cpu_capacity' here. Why? I can see that with the standard
> setup (max CPU capacity equal 1024) which is what we probably use 100%
> of the time now. It might get useful again when Vincent will introduce
> his 'user space system pressure' implementation?

That's interesting because I'm doing the opposite in the user space
system pressure that I'm preparing:
I keep something similar to (arch_scale_cpu_capacity(rq->cpu) <
rq->rd->max_cpu_capacity but I remove check_cpu_capacity(rq, sd) which
seems to be useless because it's already used earlier in
nohz_balancer_kick()

>
> >  }
>
> [...]
>
> > @@ -1423,8 +1418,8 @@ static void asym_cpu_capacity_scan(void)
> >
> >       list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
> >               if (cpumask_empty(cpu_capacity_span(entry))) {
> > -                     list_del(&entry->link);
> > -                     kfree(entry);
> > +                     list_del_rcu(&entry->link);
> > +                     call_rcu(&entry->rcu, free_asym_cap_entry);
>
> Looks like there could be brief moments in which one CPU capacity group
> of CPUs could be twice in asym_cap_list. I'm thinking about initial
> startup + max CPU frequency related adjustment of CPU capacity
> (init_cpu_capacity_callback()) for instance. Not sure if this is really
> an issue?
>
> [...]
>

