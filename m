Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AEE80AB9A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574549AbjLHSGr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Dec 2023 13:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjLHSGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:06:44 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDB090;
        Fri,  8 Dec 2023 10:06:50 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1fb6cbacf9aso265694fac.0;
        Fri, 08 Dec 2023 10:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702058810; x=1702663610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4xTGFAIp30c2C+iNKcAQyofR6J2/l8xMVBA8C0RN1Y=;
        b=IS7KThKaP+cYilkuh89dYw9VL89K71B/H0TtT5Bys29Zn5zWgnXtmd0asK9CO8mQdo
         b4wVuugKaryIw+47LR5ITf36DCH/gFPW/h8zLq9c7JXMSkyJa2bTIDyahqDPIXewMfYD
         P/AmiSY3INv+7Gxbb+sNCZU/UKmIRAGhQvjTKZ/uCOPqxqDEyoMDjvkgzGUtd+g1vqw0
         RACpo7Tt2m43336/exDGWdFLXimxji95F/kwWIMTuwuy8ihgrvC0PSgWt+z3Cb1HDUsY
         2RhGcI6dKZCxzysJYnPI0zZjncjquI8H+CpR2EcB/YvFuaehzF2BOOW3CFc7BIFzuqxW
         3w3g==
X-Gm-Message-State: AOJu0YwgiqjeClfvuW1LuMhqcoAgDIhJFdgs3Ntlvlscja87/7IdLsnx
        wHEkrVjfJYP3wx+azyafW7cG2ZIuJVAWhGdXo3E=
X-Google-Smtp-Source: AGHT+IFp3Obw3fvviTYikCGFv6XRCivk+HYOYcZ0GwOtUK/NgAhrHos5S+iJd+7GLoUMW/jtAt3uumEHWoOnchGHQb4=
X-Received: by 2002:a05:6870:41cd:b0:1fa:f195:e3b4 with SMTP id
 z13-20020a05687041cd00b001faf195e3b4mr1015112oac.2.1702058809957; Fri, 08 Dec
 2023 10:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20231208002342.367117-1-qyousef@layalina.io> <20231208002342.367117-8-qyousef@layalina.io>
In-Reply-To: <20231208002342.367117-8-qyousef@layalina.io>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Dec 2023 19:06:37 +0100
Message-ID: <CAJZ5v0iYUY-LrL3LNdMqxyMntBij_pkpETB2esYPraPekqtbhw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] sched/schedutil: Add a new tunable to dictate
 response time
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 1:24 AM Qais Yousef <qyousef@layalina.io> wrote:
>
> The new tunable, response_time_ms,  allow us to speed up or slow down
> the response time of the policy to meet the perf, power and thermal
> characteristic desired by the user/sysadmin. There's no single universal
> trade-off that we can apply for all systems even if they use the same
> SoC. The form factor of the system, the dominant use case, and in case
> of battery powered systems, the size of the battery and presence or
> absence of active cooling can play a big role on what would be best to
> use.
>
> The new tunable provides sensible defaults, but yet gives the power to
> control the response time to the user/sysadmin, if they wish to.
>
> This tunable is applied before we apply the DVFS headroom.
>
> The default behavior of applying 1.25 headroom can be re-instated easily
> now. But we continue to keep the min required headroom to overcome
> hardware limitation in its speed to change DVFS. And any additional
> headroom to speed things up must be applied by userspace to match their
> expectation for best perf/watt as it dictates a type of policy that will
> be better for some systems, but worse for others.
>
> There's a whitespace clean up included in sugov_start().
>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>

I thought that there was an agreement to avoid adding any new tunables
to schedutil.

> ---
>  Documentation/admin-guide/pm/cpufreq.rst |  17 +++-
>  drivers/cpufreq/cpufreq.c                |   4 +-
>  include/linux/cpufreq.h                  |   3 +
>  kernel/sched/cpufreq_schedutil.c         | 115 ++++++++++++++++++++++-
>  4 files changed, 132 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> index 6adb7988e0eb..fa0d602a920e 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -417,7 +417,7 @@ is passed by the scheduler to the governor callback which causes the frequency
>  to go up to the allowed maximum immediately and then draw back to the value
>  returned by the above formula over time.
>
> -This governor exposes only one tunable:
> +This governor exposes two tunables:
>
>  ``rate_limit_us``
>         Minimum time (in microseconds) that has to pass between two consecutive
> @@ -427,6 +427,21 @@ This governor exposes only one tunable:
>         The purpose of this tunable is to reduce the scheduler context overhead
>         of the governor which might be excessive without it.
>
> +``respone_time_ms``
> +       Amount of time (in milliseconds) required to ramp the policy from
> +       lowest to highest frequency. Can be decreased to speed up the
> +       responsiveness of the system, or increased to slow the system down in
> +       hope to save power. The best perf/watt will depend on the system
> +       characteristics and the dominant workload you expect to run. For
> +       userspace that has smart context on the type of workload running (like
> +       in Android), one can tune this to suite the demand of that workload.
> +
> +       Note that when slowing the response down, you can end up effectively
> +       chopping off the top frequencies for that policy as the util is capped
> +       to 1024. On HMP systems this chopping effect will only occur on the
> +       biggest core whose capacity is 1024. Don't rely on this behavior as
> +       this is a limitation that can hopefully be improved in the future.
> +
>  This governor generally is regarded as a replacement for the older `ondemand`_
>  and `conservative`_ governors (described below), as it is simpler and more
>  tightly integrated with the CPU scheduler, its overhead in terms of CPU context
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 9875284ca6e4..15c397ce3252 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -533,8 +533,8 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
>
> -static unsigned int __resolve_freq(struct cpufreq_policy *policy,
> -               unsigned int target_freq, unsigned int relation)
> +unsigned int __resolve_freq(struct cpufreq_policy *policy,
> +                           unsigned int target_freq, unsigned int relation)
>  {
>         unsigned int idx;
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 1c5ca92a0555..29c3723653a3 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -613,6 +613,9 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
>  int __cpufreq_driver_target(struct cpufreq_policy *policy,
>                                    unsigned int target_freq,
>                                    unsigned int relation);
> +unsigned int __resolve_freq(struct cpufreq_policy *policy,
> +                           unsigned int target_freq,
> +                           unsigned int relation);
>  unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>                                          unsigned int target_freq);
>  unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy);
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 1d4d6025c15f..788208becc13 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -8,9 +8,12 @@
>
>  #define IOWAIT_BOOST_MIN       (SCHED_CAPACITY_SCALE / 8)
>
> +DEFINE_PER_CPU_READ_MOSTLY(unsigned long, response_time_mult);
> +
>  struct sugov_tunables {
>         struct gov_attr_set     attr_set;
>         unsigned int            rate_limit_us;
> +       unsigned int            response_time_ms;
>  };
>
>  struct sugov_policy {
> @@ -22,6 +25,7 @@ struct sugov_policy {
>         raw_spinlock_t          update_lock;
>         u64                     last_freq_update_time;
>         s64                     freq_update_delay_ns;
> +       unsigned int            freq_response_time_ms;
>         unsigned int            next_freq;
>         unsigned int            cached_raw_freq;
>
> @@ -59,6 +63,70 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>
>  /************************ Governor internals ***********************/
>
> +static inline u64 sugov_calc_freq_response_ms(struct sugov_policy *sg_policy)
> +{
> +       int cpu = cpumask_first(sg_policy->policy->cpus);
> +       unsigned long cap = arch_scale_cpu_capacity(cpu);
> +       unsigned int max_freq, sec_max_freq;
> +
> +       max_freq = sg_policy->policy->cpuinfo.max_freq;
> +       sec_max_freq = __resolve_freq(sg_policy->policy,
> +                                     max_freq - 1,
> +                                     CPUFREQ_RELATION_H);
> +
> +       /*
> +        * We will request max_freq as soon as util crosses the capacity at
> +        * second highest frequency. So effectively our response time is the
> +        * util at which we cross the cap@2nd_highest_freq.
> +        */
> +       cap = sec_max_freq * cap / max_freq;
> +
> +       return approximate_runtime(cap + 1);
> +}
> +
> +static inline void sugov_update_response_time_mult(struct sugov_policy *sg_policy)
> +{
> +       unsigned long mult;
> +       int cpu;
> +
> +       if (unlikely(!sg_policy->freq_response_time_ms))
> +               sg_policy->freq_response_time_ms = sugov_calc_freq_response_ms(sg_policy);
> +
> +       mult = sg_policy->freq_response_time_ms * SCHED_CAPACITY_SCALE;
> +       mult /= sg_policy->tunables->response_time_ms;
> +
> +       if (SCHED_WARN_ON(!mult))
> +               mult = SCHED_CAPACITY_SCALE;
> +
> +       for_each_cpu(cpu, sg_policy->policy->cpus)
> +               per_cpu(response_time_mult, cpu) = mult;
> +}
> +
> +/*
> + * Shrink or expand how long it takes to reach the maximum performance of the
> + * policy.
> + *
> + * sg_policy->freq_response_time_ms is a constant value defined by PELT
> + * HALFLIFE and the capacity of the policy (assuming HMP systems).
> + *
> + * sg_policy->tunables->response_time_ms is a user defined response time. By
> + * setting it lower than sg_policy->freq_response_time_ms, the system will
> + * respond faster to changes in util, which will result in reaching maximum
> + * performance point quicker. By setting it higher, it'll slow down the amount
> + * of time required to reach the maximum OPP.
> + *
> + * This should be applied when selecting the frequency.
> + */
> +static inline unsigned long
> +sugov_apply_response_time(unsigned long util, int cpu)
> +{
> +       unsigned long mult;
> +
> +       mult = per_cpu(response_time_mult, cpu) * util;
> +
> +       return mult >> SCHED_CAPACITY_SHIFT;
> +}
> +
>  static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  {
>         s64 delta_ns;
> @@ -156,7 +224,10 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>                                  unsigned long min,
>                                  unsigned long max)
>  {
> -       /* Add dvfs headroom to actual utilization */
> +       /*
> +        * Speed up/slow down response timee first then apply DVFS headroom.
> +        */
> +       actual = sugov_apply_response_time(actual, cpu);
>         actual = apply_dvfs_headroom(actual, cpu);
>         /* Actually we don't need to target the max performance */
>         if (actual < max)
> @@ -555,8 +626,42 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
>
>  static struct governor_attr rate_limit_us = __ATTR_RW(rate_limit_us);
>
> +static ssize_t response_time_ms_show(struct gov_attr_set *attr_set, char *buf)
> +{
> +       struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
> +
> +       return sprintf(buf, "%u\n", tunables->response_time_ms);
> +}
> +
> +static ssize_t
> +response_time_ms_store(struct gov_attr_set *attr_set, const char *buf, size_t count)
> +{
> +       struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
> +       struct sugov_policy *sg_policy;
> +       unsigned int response_time_ms;
> +
> +       if (kstrtouint(buf, 10, &response_time_ms))
> +               return -EINVAL;
> +
> +       /* XXX need special handling for high values? */
> +
> +       tunables->response_time_ms = response_time_ms;
> +
> +       list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook) {
> +               if (sg_policy->tunables == tunables) {
> +                       sugov_update_response_time_mult(sg_policy);
> +                       break;
> +               }
> +       }
> +
> +       return count;
> +}
> +
> +static struct governor_attr response_time_ms = __ATTR_RW(response_time_ms);
> +
>  static struct attribute *sugov_attrs[] = {
>         &rate_limit_us.attr,
> +       &response_time_ms.attr,
>         NULL
>  };
>  ATTRIBUTE_GROUPS(sugov);
> @@ -744,11 +849,13 @@ static int sugov_init(struct cpufreq_policy *policy)
>                 goto stop_kthread;
>         }
>
> -       tunables->rate_limit_us = cpufreq_policy_transition_delay_us(policy);
> -
>         policy->governor_data = sg_policy;
>         sg_policy->tunables = tunables;
>
> +       tunables->rate_limit_us = cpufreq_policy_transition_delay_us(policy);
> +       tunables->response_time_ms = sugov_calc_freq_response_ms(sg_policy);
> +       sugov_update_response_time_mult(sg_policy);
> +
>         ret = kobject_init_and_add(&tunables->attr_set.kobj, &sugov_tunables_ktype,
>                                    get_governor_parent_kobj(policy), "%s",
>                                    schedutil_gov.name);
> @@ -808,7 +915,7 @@ static int sugov_start(struct cpufreq_policy *policy)
>         void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
>         unsigned int cpu;
>
> -       sg_policy->freq_update_delay_ns = sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
> +       sg_policy->freq_update_delay_ns         = sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
>         sg_policy->last_freq_update_time        = 0;
>         sg_policy->next_freq                    = 0;
>         sg_policy->work_in_progress             = false;
> --
> 2.34.1
>
