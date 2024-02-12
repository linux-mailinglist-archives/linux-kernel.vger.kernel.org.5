Return-Path: <linux-kernel+bounces-62096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E4851B62
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F8F1F2295A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF373F9D8;
	Mon, 12 Feb 2024 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5UokIcr"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884363F9D3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758843; cv=none; b=Y2qAj+mZHyrIWbHOVzjD0+wdJrfNI/3+A1iONJyL/6z8rjKhSU3folNhwV+RQiZbg7xvG5C04g53Risxwjcs51MfO1t2gHvdl/AeU7uYhSRfqnI8aY7nSrt13kYtF0v4xVmV85lCKORWAhrpGeBu/EJOhirw011ZLDRGr+75rKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758843; c=relaxed/simple;
	bh=EbrCtbxGASx4rmHE82yByLbhMVvv4bD9R+HQzmqjc8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iI6dbZzwpTcAwHFatLNQnMWCjFybfghGKBAdgYQg/p4HUxp0vxLQrLsbsoK+W8dbIB5O7hGqr24UfYkPHBoECNSdEXXFUtJv22RsuJySFChjk9RhOmLsj9xG6lpgjzoUMEvg5LoRmThZa5AsXV+nOxh3p1sFwWaQcQlLllsWbbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H5UokIcr; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso3246563a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707758841; x=1708363641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dgfonkTYGzRTfqAixAE72BysPlAhLbczGFkU+Dae3fg=;
        b=H5UokIcrH/SVRNEzh/M5/bH9lA8qr29A7V2lRws7Cz9HpZXmZ1mX5hiGkomX4xeEoc
         aM1S+9vEK66OOPVHxSNx8qzkHA57cVlkAtE6m4dQGE4k0K3b6GjuY06X2ljNK4Oz5D54
         XB0L9/rJrBkji8iPX38FQSTu5eMPTulHrUm4a1lg1c+Y7RCbOBgPY9641O86+DSd2Vx+
         72PI3H0tG7IVTohrAyON3SKU7CtErvCyBE7akH+C/8ALZw3mRf9OAHPVN+79510Uj9OA
         2qPkWe5jSFlKQUx39QrMaU9zt/LlqF8vRj/FeDGWw3b8RkfiLLahrW8kgKL6MwgT/r7j
         GM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707758841; x=1708363641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgfonkTYGzRTfqAixAE72BysPlAhLbczGFkU+Dae3fg=;
        b=BdJXgKdUdEHM+ZjEt3Wl6zlqt6uFKRSD9J84B4fKx2GlLmZmKkLtI8hBqLiIEy9hDX
         qZg0Z/wP42l9UlXsunu5zjPC0BCBrAre2jdn3yPBqV+q7YM02glVdp6BAS28XEFNY9DT
         gGcDy2CFvmhLK8q5SxrNgXWBAhE6PTprFjecD3TsR/ZbuFn3n34gsBzTIH4HzWKf/7bj
         drtpB8ztSfa46dsM9+aJkg/wLZDJuNNdR3kjc3OdrMirC64DsL40cJg8jMqvsWgn+Ydp
         oP15LMZohbXV2rnaUTgNCeOYEX1mN+RUk8IeU1iMwIVGcrh3g+g+BZW/mTOesTmtBj/F
         5+UA==
X-Gm-Message-State: AOJu0YxhBz1SObUPA41/oJkFTmaeMuw1jbWtYfiaYzuD89pca1z8qOG+
	GhNF0tab+hYLNehe3YJ8450xC3ZDQLdg9HjIOVx/QQA4FUKMTXnwP89syeUSn7mkNTHgILzi24N
	a2nPuMyAuoH7HPGnO+yKb0FhVEzdmJ3LNxTSifw==
X-Google-Smtp-Source: AGHT+IHWWNH8Vmk3v9UGkaops4wF88R5hwSQV+2La3gw7myGc/9Ki7O/8uJP5EeEtJOKz51Yrqkf8NvO25re57Ma2NQ=
X-Received: by 2002:a17:90a:d504:b0:293:d50c:b704 with SMTP id
 t4-20020a17090ad50400b00293d50cb704mr3758257pju.19.1707758840834; Mon, 12 Feb
 2024 09:27:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205021123.2225933-1-qyousef@layalina.io> <20240205021123.2225933-3-qyousef@layalina.io>
In-Reply-To: <20240205021123.2225933-3-qyousef@layalina.io>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 12 Feb 2024 18:27:09 +0100
Message-ID: <CAKfTPtAsij+_=n9JCxHw==j3-wC9rYZHEJyVmyBJsx_-Udhzgw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 03:11, Qais Yousef <qyousef@layalina.io> wrote:
>
> If a misfit task is affined to a subset of the possible cpus, we need to
> verify that one of these cpus can fit it. Otherwise the load balancer
> code will continuously trigger needlessly leading the balance_interval
> to increase in return and eventually end up with a situation where real
> imbalances take a long time to address because of this impossible
> imbalance situation.
>
> This can happen in Android world where it's common for background tasks
> to be restricted to little cores.
>
> Similarly if we can't fit the biggest core, triggering misfit is
> pointless as it is the best we can ever get on this system.
>
> To be able to detect that; we use asym_cap_list to iterate through
> capacities in the system to see if the task is able to run at a higher
> capacity level based on its p->cpus_ptr. We do that when the affinity
> change, a fair task is forked, or when a task switched to fair policy.
> We store the max_allowed_capacity in task_struct to allow for cheap
> comparison in the fast path.
>
> Improve check_misfit_status() function to be more readable. At one
> iteration of the patch it was thought we can drop one of the checks. The
> current form hopefully should make it more obvious what is being checked
> and why.
>
> Test:
> =====
>
> Add
>
>         trace_printk("balance_interval = %lu\n", interval)
>
> in get_sd_balance_interval().
>
> run
>         if [ "$MASK" != "0" ]; then
>                 adb shell "taskset -a $MASK cat /dev/zero > /dev/null"
>         fi
>         sleep 10
>         // parse ftrace buffer counting the occurrence of each valaue
>
> Where MASK is either:
>
>         * 0: no busy task running
>         * 1: busy task is pinned to 1 cpu; handled today to not cause
>           misfit
>         * f: busy task pinned to little cores, simulates busy background
>           task, demonstrates the problem to be fixed
>
> Results:
> ========
>
> Note how occurrence of balance_interval = 128 overshoots for MASK = f.
>
> BEFORE
> ------
>
>         MASK=0
>
>                    1 balance_interval = 175
>                  120 balance_interval = 128
>                  846 balance_interval = 64
>                   55 balance_interval = 63
>                  215 balance_interval = 32
>                    2 balance_interval = 31
>                    2 balance_interval = 16
>                    4 balance_interval = 8
>                 1870 balance_interval = 4
>                   65 balance_interval = 2
>
>         MASK=1
>
>                   27 balance_interval = 175
>                   37 balance_interval = 127
>                  840 balance_interval = 64
>                  167 balance_interval = 63
>                  449 balance_interval = 32
>                   84 balance_interval = 31
>                  304 balance_interval = 16
>                 1156 balance_interval = 8
>                 2781 balance_interval = 4
>                  428 balance_interval = 2
>
>         MASK=f
>
>                    1 balance_interval = 175
>                 1328 balance_interval = 128
>                   44 balance_interval = 64
>                  101 balance_interval = 63
>                   25 balance_interval = 32
>                    5 balance_interval = 31
>                   23 balance_interval = 16
>                   23 balance_interval = 8
>                 4306 balance_interval = 4
>                  177 balance_interval = 2
>
> AFTER
> -----
>
> Note how the high values almost disappear for all MASK values. The
> system has background tasks that could trigger the problem without
> simulate it even with MASK=0.
>
>         MASK=0
>
>                  103 balance_interval = 63
>                   19 balance_interval = 31
>                  194 balance_interval = 8
>                 4827 balance_interval = 4
>                  179 balance_interval = 2
>
>         MASK=1
>
>                  131 balance_interval = 63
>                    1 balance_interval = 31
>                   87 balance_interval = 8
>                 3600 balance_interval = 4
>                    7 balance_interval = 2
>
>         MASK=f
>
>                    8 balance_interval = 127
>                  182 balance_interval = 63
>                    3 balance_interval = 31
>                    9 balance_interval = 16
>                  415 balance_interval = 8
>                 3415 balance_interval = 4
>                   21 balance_interval = 2
>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  include/linux/sched.h |  1 +
>  init/init_task.c      |  1 +
>  kernel/sched/fair.c   | 84 +++++++++++++++++++++++++++++++++----------
>  3 files changed, 68 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 03bfe9ab2951..1e7bf52de607 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -827,6 +827,7 @@ struct task_struct {
>  #endif
>
>         unsigned int                    policy;
> +       unsigned long                   max_allowed_capacity;
>         int                             nr_cpus_allowed;
>         const cpumask_t                 *cpus_ptr;
>         cpumask_t                       *user_cpus_ptr;
> diff --git a/init/init_task.c b/init/init_task.c
> index 5727d42149c3..01b3199d4cde 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -82,6 +82,7 @@ struct task_struct init_task
>         .cpus_ptr       = &init_task.cpus_mask,
>         .user_cpus_ptr  = NULL,
>         .cpus_mask      = CPU_MASK_ALL,
> +       .max_allowed_capacity   = SCHED_CAPACITY_SCALE,
>         .nr_cpus_allowed= NR_CPUS,
>         .mm             = NULL,
>         .active_mm      = &init_mm,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b803030c3a03..8b8035f5c8f6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5092,24 +5092,36 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
>
>  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>  {
> +       unsigned long cpu_cap;
> +       int cpu = cpu_of(rq);
> +
>         if (!sched_asym_cpucap_active())
>                 return;
>
> -       if (!p || p->nr_cpus_allowed == 1) {
> -               rq->misfit_task_load = 0;
> -               return;
> -       }
> +       if (!p || p->nr_cpus_allowed == 1)
> +               goto out;
>
> -       if (task_fits_cpu(p, cpu_of(rq))) {
> -               rq->misfit_task_load = 0;
> -               return;
> -       }
> +       cpu_cap = arch_scale_cpu_capacity(cpu);
> +
> +       /* If we can't fit the biggest CPU, that's the best we can ever get. */
> +       if (cpu_cap == rq->rd->max_cpu_capacity)

Isn't the condition above also covered by the condition below and
becomes now useless ?

> +               goto out;
> +
> +       /* Affinity allows us to go somewhere higher? */
> +       if (cpu_cap == p->max_allowed_capacity)
> +               goto out;
> +
> +       if (task_fits_cpu(p, cpu))
> +               goto out;
>
>         /*
>          * Make sure that misfit_task_load will not be null even if
>          * task_h_load() returns 0.
>          */
>         rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
> +       return;
> +out:
> +       rq->misfit_task_load = 0;
>  }
>
>  #else /* CONFIG_SMP */
> @@ -8241,6 +8253,36 @@ static void task_dead_fair(struct task_struct *p)
>         remove_entity_load_avg(&p->se);
>  }
>
> +/*
> + * Check the max capacity the task is allowed to run at for misfit detection.
> + */
> +static void set_task_max_allowed_capacity(struct task_struct *p)
> +{
> +       struct asym_cap_data *entry;
> +
> +       if (!sched_asym_cpucap_active())
> +               return;
> +
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(entry, &asym_cap_list, link) {
> +               cpumask_t *cpumask;
> +
> +               cpumask = cpu_capacity_span(entry);
> +               if (!cpumask_intersects(p->cpus_ptr, cpumask))
> +                       continue;
> +
> +               p->max_allowed_capacity = entry->capacity;
> +               break;
> +       }
> +       rcu_read_unlock();
> +}
> +
> +static void set_cpus_allowed_fair(struct task_struct *p, struct affinity_context *ctx)
> +{
> +       set_cpus_allowed_common(p, ctx);
> +       set_task_max_allowed_capacity(p);
> +}
> +
>  static int
>  balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
> @@ -9601,16 +9643,18 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
>                                 (arch_scale_cpu_capacity(cpu_of(rq)) * 100));
>  }
>
> -/*
> - * Check whether a rq has a misfit task and if it looks like we can actually
> - * help that task: we can migrate the task to a CPU of higher capacity, or
> - * the task's current CPU is heavily pressured.
> - */
> -static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> +/* Check if the rq has a misfit task */
> +static inline bool check_misfit_status(struct rq *rq, struct sched_domain *sd)
>  {
> -       return rq->misfit_task_load &&
> -               (arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
> -                check_cpu_capacity(rq, sd));
> +       if (!rq->misfit_task_load)
> +               return false;

I think that only the above is enough ...

> +
> +       /* Can we migrate to a CPU with higher capacity? */
> +       if (arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity)

because rq->misfit_task_load is set to 0 if
arch_scale_cpu_capacity(rq->cpu) == rq->rd->max_cpu_capacity

That would also mean that we don't need to keep and set
rd->max_cpu_capacity anymore as we remove the 2 uses of it

> +               return true;
> +
> +       /* Is the task's CPU being heavily pressured? */
> +       return check_cpu_capacity(rq, sd);

and this one has already been tested in nohz_balancer_kick() before
calling check_misfit_status()

>  }
>
>  /*
> @@ -12647,6 +12691,8 @@ static void task_fork_fair(struct task_struct *p)
>         rq_lock(rq, &rf);
>         update_rq_clock(rq);
>
> +       set_task_max_allowed_capacity(p);
> +
>         cfs_rq = task_cfs_rq(current);
>         curr = cfs_rq->curr;
>         if (curr)
> @@ -12770,6 +12816,8 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
>  {
>         attach_task_cfs_rq(p);
>
> +       set_task_max_allowed_capacity(p);
> +
>         if (task_on_rq_queued(p)) {
>                 /*
>                  * We were most likely switched from sched_rt, so
> @@ -13154,7 +13202,7 @@ DEFINE_SCHED_CLASS(fair) = {
>         .rq_offline             = rq_offline_fair,
>
>         .task_dead              = task_dead_fair,
> -       .set_cpus_allowed       = set_cpus_allowed_common,
> +       .set_cpus_allowed       = set_cpus_allowed_fair,
>  #endif
>
>         .task_tick              = task_tick_fair,
> --
> 2.34.1
>

