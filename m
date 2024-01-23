Return-Path: <linux-kernel+bounces-34891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917E18388E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A517B24541
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D00C57312;
	Tue, 23 Jan 2024 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ra0ul0+B"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA42A56B72
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998419; cv=none; b=a5pPRdP4HAPRfI3dQLCpEQ6z7zxwLJzRKtstC/Z5l9K59avpmXnqfzZrADmm/xnuOuqeFwwq9+SBXJQLkQ7Jb3xVH4Dh0JtOs18XswZkOFpIAoBs9sU7ZIHXpOJIQZdr1s7cFRreqd7tdruBLX6XjOOc55R+8Hi1kUFfAnuL3xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998419; c=relaxed/simple;
	bh=o1I8ibN+d5rPW+LSRtV5Ef+a7HI53P+jJeFnrIDJLrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=To93NpS+jXSyV6crV3l007JqBJMT66yqQaYsrJArbksEfnnLWscBYSSM6O+ZwDKk85L17NgvVBQpvC1VdiD+C1EJX63/Aa1FaD7h3Z6h6nDf9F1PTKCDiinvB7h6Zqjy6fjWHpI1EHJrjZLN3ArX5L8Glvf6dvueW7/m1daUNDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ra0ul0+B; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d50d0c98c3so40293485ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705998417; x=1706603217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TMT7ZHJmo1AmS6alR5bT/yxXW3Y4npeI57sP/9HSTEo=;
        b=Ra0ul0+Bz3V4v6NGhNpdmD/cUz9AnVg0Og79yLVx2Pho3nKnUX0Lb4aWiW2uzutVTL
         gr2Q/ReVwrcacRCIEvPvTT6I8H9+j2XGWyCMpcuoRO7u76KDxKC19xbtAvKnnb2RZ3Ps
         Zde8+kljOYowMVRjmnjj62Yfj5P5cOCXdLr6tF1oXuCWxuFnVzifpGO7J7Jy6Nu3xNA1
         g132X9pWin1wVXkcSBz6SDRAUl6ywekOcvorVXTRokF/JCga2Yzm/ktMTa3vsqAuFOdi
         q17ZBGoMTjfLc3DiOsxKXT6Eln9xQqxQttA2UWlxY7zvNdq7SWZsR38dUxaskasrLACv
         BZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705998417; x=1706603217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMT7ZHJmo1AmS6alR5bT/yxXW3Y4npeI57sP/9HSTEo=;
        b=LAmM7t1QvPN4acgwRFSH00+g88Ke42px41XIFBDd4DEo1Z4CTeX2MSlDtgayJr8UQP
         sHqwN3fqGelaobY7LjpiqCgWRQQRyI+ruGdtYyCiC0QTjDP3BuHdytfUGu9dHx1YO0x2
         anLjF+oJ72RATAOZ00UQH2RgMLVDQ42z1uHQLrk3BSoQH5ZaLxVtLHM8Mq/45s4HvsFQ
         GE+jOozMK0XMaKsxwANw9xBDpl+vDbvW7w661/pbq0a4eEPaWZRYk03nXbsJfa7Z2Y0Z
         c9C2VFGN4URauemvaRcuAQPwjDhoQHnV4IFI5Vj0JnpShfO4oM4YMP5q8vU64R9N1Ewv
         RL7Q==
X-Gm-Message-State: AOJu0Yx1q0J1HpYMXAgARsdlcXYy9z/hWSqr7mdPJ9ClIWDA8M8n4uZi
	CctfKKhvjcgUoMH54QPZE9XROW3m8zO2d5zbMO2OBAdXyBe+08GiJrfahNbfj1goERiGbqsWUKP
	19drVkL/OVldYIAlpccw2WjdXhJ8Upz4Rpydc9Q==
X-Google-Smtp-Source: AGHT+IHA8crE6dZ2iVL8qp6PNISQCPxMdb9HFpaDZD544frAQZYLzjHpMm8zf28bhYCPlpUcOWdRxUwTBX44dXr352s=
X-Received: by 2002:a17:90a:5d92:b0:290:21d7:aecb with SMTP id
 t18-20020a17090a5d9200b0029021d7aecbmr7761202pji.35.1705998417010; Tue, 23
 Jan 2024 00:26:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105222014.1025040-1-qyousef@layalina.io> <20240105222014.1025040-2-qyousef@layalina.io>
In-Reply-To: <20240105222014.1025040-2-qyousef@layalina.io>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 23 Jan 2024 09:26:45 +0100
Message-ID: <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 23:20, Qais Yousef <qyousef@layalina.io> wrote:
>
> From: Qais Yousef <qais.yousef@arm.com>
>
> If a misfit task is affined to a subset of the possible cpus, we need to
> verify that one of these cpus can fit it. Otherwise the load balancer
> code will continuously trigger needlessly leading the balance_interval
> to increase in return and eventually end up with a situation where real
> imbalances take a long time to address because of this impossible
> imbalance situation.

If your problem is about increasing balance_interval, it would be
better to not increase the interval is such case.
I mean that we are able to detect misfit_task conditions for the
periodic load balance so we should be able to not increase the
interval in such cases.

If I'm not wrong, your problem only happens when the system is
overutilized and we have disable EAS

>
> This can happen in Android world where it's common for background tasks
> to be restricted to little cores.
>
> Similarly if we can't fit the biggest core, triggering misfit is
> pointless as it is the best we can ever get on this system.
>
> To be able to detect that; we use asym_cap_list to iterate through
> capacities in the system to see if the task is able to run at a higher
> capacity level based on its p->cpus_ptr. To do so safely, we convert the
> list to be RCU protected.
>
> To be able to iterate through capacity levels, export asym_cap_list to
> allow for fast traversal of all available capacity levels in the system.
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
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/fair.c     | 65 ++++++++++++++++++++++++++++++++++-------
>  kernel/sched/sched.h    | 14 +++++++++
>  kernel/sched/topology.c | 29 ++++++++----------
>  3 files changed, 81 insertions(+), 27 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bcea3d55d95d..0830ceb7ca07 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5065,17 +5065,61 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
>
>  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>  {
> +       unsigned long uclamp_min, uclamp_max;
> +       unsigned long util, cpu_cap;
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
> +       cpu_cap = arch_scale_cpu_capacity(cpu);
> +
> +       /* If we can't fit the biggest CPU, that's the best we can ever get. */
> +       if (cpu_cap == SCHED_CAPACITY_SCALE)
> +               goto out;
> +
> +       uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> +       uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> +       util = task_util_est(p);
> +
> +       if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0)
> +               goto out;
> +
> +       /*
> +        * If the task affinity is not set to default, make sure it is not
> +        * restricted to a subset where no CPU can ever fit it. Triggering
> +        * misfit in this case is pointless as it has no where better to move
> +        * to. And it can lead to balance_interval to grow too high as we'll
> +        * continuously fail to move it anywhere.
> +        */
> +       if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
> +               unsigned long clamped_util = clamp(util, uclamp_min, uclamp_max);
> +               bool has_fitting_cpu = false;
> +               struct asym_cap_data *entry;
> +
> +               rcu_read_lock();
> +               list_for_each_entry_rcu(entry, &asym_cap_list, link) {
> +                       if (entry->capacity > cpu_cap) {
> +                               cpumask_t *cpumask;
> +
> +                               if (clamped_util > entry->capacity)
> +                                       continue;
> +
> +                               cpumask = cpu_capacity_span(entry);
> +                               if (!cpumask_intersects(p->cpus_ptr, cpumask))
> +                                       continue;
> +
> +                               has_fitting_cpu = true;
> +                               break;
> +                       }
> +               }
> +               rcu_read_unlock();
> +
> +               if (!has_fitting_cpu)
> +                       goto out;
>         }
>
>         /*
> @@ -5083,6 +5127,9 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>          * task_h_load() returns 0.
>          */
>         rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
> +       return;
> +out:
> +       rq->misfit_task_load = 0;
>  }
>
>  #else /* CONFIG_SMP */
> @@ -9583,9 +9630,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
>   */
>  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
>  {
> -       return rq->misfit_task_load &&
> -               (arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
> -                check_cpu_capacity(rq, sd));
> +       return rq->misfit_task_load && check_cpu_capacity(rq, sd);
>  }
>
>  /*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e58a54bda77d..a653017a1b9b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -109,6 +109,20 @@ extern int sysctl_sched_rt_period;
>  extern int sysctl_sched_rt_runtime;
>  extern int sched_rr_timeslice;
>
> +/*
> + * Asymmetric CPU capacity bits
> + */
> +struct asym_cap_data {
> +       struct list_head link;
> +       struct rcu_head rcu;
> +       unsigned long capacity;
> +       unsigned long cpus[];
> +};
> +
> +extern struct list_head asym_cap_list;
> +
> +#define cpu_capacity_span(asym_data) to_cpumask((asym_data)->cpus)
> +
>  /*
>   * Helpers for converting nanosecond timing to jiffy resolution
>   */
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 10d1391e7416..ba4a0b18ae25 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1329,24 +1329,13 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
>         update_group_capacity(sd, cpu);
>  }
>
> -/*
> - * Asymmetric CPU capacity bits
> - */
> -struct asym_cap_data {
> -       struct list_head link;
> -       unsigned long capacity;
> -       unsigned long cpus[];
> -};
> -
>  /*
>   * Set of available CPUs grouped by their corresponding capacities
>   * Each list entry contains a CPU mask reflecting CPUs that share the same
>   * capacity.
>   * The lifespan of data is unlimited.
>   */
> -static LIST_HEAD(asym_cap_list);
> -
> -#define cpu_capacity_span(asym_data) to_cpumask((asym_data)->cpus)
> +LIST_HEAD(asym_cap_list);
>
>  /*
>   * Verify whether there is any CPU capacity asymmetry in a given sched domain.
> @@ -1386,6 +1375,12 @@ asym_cpu_capacity_classify(const struct cpumask *sd_span,
>
>  }
>
> +static void free_asym_cap_entry(struct rcu_head *head)
> +{
> +       struct asym_cap_data *entry = container_of(head, struct asym_cap_data, rcu);
> +       kfree(entry);
> +}
> +
>  static inline void asym_cpu_capacity_update_data(int cpu)
>  {
>         unsigned long capacity = arch_scale_cpu_capacity(cpu);
> @@ -1400,7 +1395,7 @@ static inline void asym_cpu_capacity_update_data(int cpu)
>         if (WARN_ONCE(!entry, "Failed to allocate memory for asymmetry data\n"))
>                 return;
>         entry->capacity = capacity;
> -       list_add(&entry->link, &asym_cap_list);
> +       list_add_rcu(&entry->link, &asym_cap_list);
>  done:
>         __cpumask_set_cpu(cpu, cpu_capacity_span(entry));
>  }
> @@ -1423,8 +1418,8 @@ static void asym_cpu_capacity_scan(void)
>
>         list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
>                 if (cpumask_empty(cpu_capacity_span(entry))) {
> -                       list_del(&entry->link);
> -                       kfree(entry);
> +                       list_del_rcu(&entry->link);
> +                       call_rcu(&entry->rcu, free_asym_cap_entry);
>                 }
>         }
>
> @@ -1434,8 +1429,8 @@ static void asym_cpu_capacity_scan(void)
>          */
>         if (list_is_singular(&asym_cap_list)) {
>                 entry = list_first_entry(&asym_cap_list, typeof(*entry), link);
> -               list_del(&entry->link);
> -               kfree(entry);
> +               list_del_rcu(&entry->link);
> +               call_rcu(&entry->rcu, free_asym_cap_entry);
>         }
>  }
>
> --
> 2.34.1
>

