Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B15D78C7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbjH2OgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjH2Ofd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:35:33 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A977798
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:35:29 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-564af0ac494so2192592a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693319729; x=1693924529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C8A+TZcdpH/rDhEh19aLmzCkwCiivExgomPzw9XBkLE=;
        b=nGRBNwYbFByFviDSecfw0kZfkA38xibyaMxS1JR+QYceglp1t+0ecdlQBAPWKjEbOK
         YTsdq66ZRsNhFR4krlUcrpUexmbINn55ds/dysWUP41kCpSmqSpIxz3dEoXDQuF10zqR
         4sjsQuwUK+WQ1/ZXFnTkX8W5za+vCyuTLaikmGAI9pGGL92a7crJxn3Rl/4x7EeHipas
         myv92H8XYenJXU0aaxqIRbamn89qi8Nuepqd+y6l0h/KXSNtflQC1fD8xOIz0n4hkPSl
         srRDoMe1oky9y8rzS9hhvIYLBxFK0CK3c5g+wnmp3HT5ecEpHJsPqgz4DpY7ZMUqYv/0
         cAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693319729; x=1693924529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8A+TZcdpH/rDhEh19aLmzCkwCiivExgomPzw9XBkLE=;
        b=CnqAnu5PSLAPfVfdVtHOz06U+YLDY45K3n9En9N6z64Sx68xTOI8ucxVupiV/MVuqo
         WXfnKHHKbbZZ/nVKbQOrCqw+XK9FWjJIe1k9almIkIACJyT9PO0vosVfrntyO3fXKySe
         xLdp97UfDm4alEPtSl4r6yCWiGSNF5ikNzRgR5W5Nm6828ZL3hMndBq8jtGVzfLsZl88
         FYVQEGuKLIAVhjZvASO+lkVqacv968gLiFhij1ctKX2BhjyvrY3ZEpv+I2ztUfa6Sty2
         8Z3ZOwHE1biGjcsdrgUHqGt8kVU44Td/JcQAiYNoXQwO3yU4hUJFTmj46AynbggkhskH
         59PQ==
X-Gm-Message-State: AOJu0YwATSQIptJBCnCvxtIFjuZNoWjFII8XNqVwkTEpR/mDq+Przn3k
        tri5qkFASfTr0PcI0Lrf7VlstUi1qeSiDiLP6k0WCw==
X-Google-Smtp-Source: AGHT+IGql+8pGXmEXmxQKl+OTJ978JcG2Q+mwmJl0VS48/fUJTTkld59V7EeiLdAgAYG5l0RiRo4oyJqepQb4msqrv4=
X-Received: by 2002:a17:90b:e84:b0:269:1abd:3ba6 with SMTP id
 fv4-20020a17090b0e8400b002691abd3ba6mr23446008pjb.28.1693319728803; Tue, 29
 Aug 2023 07:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230820210640.585311-1-qyousef@layalina.io> <20230820210640.585311-3-qyousef@layalina.io>
In-Reply-To: <20230820210640.585311-3-qyousef@layalina.io>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 29 Aug 2023 16:35:17 +0200
Message-ID: <CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
To:     Qais Yousef <qyousef@layalina.io>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2023 at 23:08, Qais Yousef <qyousef@layalina.io> wrote:
>
> DVFS headroom is applied after we calculate the effective_cpu_util()
> which is where we honour uclamp constraints. It makes more sense to
> apply the headroom there once and let all users naturally get the right
> thing without having to sprinkle the call around in various places.

You have to take care of not mixing scheduler and cpufreq constraint and policy.

uclamp is a scheduler feature to highlight that the utilization
requirement of a task can't go above a level.

dvfs head room is a cpufreq decision to anticipate either hw
limitation and responsiveness problem or performance hints.

they come from different sources and rational and this patch mixed
them which i'm not sure is a correct thing to do

>
> Before this fix running
>
>         uclampset -M 800 cat /dev/zero > /dev/null
>
> Will cause the test system to run at max freq of 2.8GHz. After the fix
> it runs at 2.2GHz instead which is the correct value that matches the
> capacity of 800.

So a task with an utilization of 800 will run at higher freq than a
task clamped to 800 by uclamp ? Why should they run at different freq
for the same utilization ?

>
> Note that similar problem exist for uclamp_min. If util was 50, and
> uclamp_min is 100. Since we apply_dvfs_headroom() after apply uclamp
> constraints, we'll end up with util of 125 instead of 100. IOW, we get
> boosted twice, first time by uclamp_min, and second time by dvfs
> headroom.
>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  include/linux/energy_model.h     |  1 -
>  kernel/sched/core.c              | 11 ++++++++---
>  kernel/sched/cpufreq_schedutil.c |  5 ++---
>  3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 6ebde4e69e98..adec808b371a 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -243,7 +243,6 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>         scale_cpu = arch_scale_cpu_capacity(cpu);
>         ps = &pd->table[pd->nr_perf_states - 1];
>
> -       max_util = apply_dvfs_headroom(max_util);
>         max_util = min(max_util, allowed_cpu_cap);
>         freq = map_util_freq(max_util, ps->frequency, scale_cpu);
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index efe3848978a0..441d433c83cd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7439,8 +7439,10 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
>          * frequency will be gracefully reduced with the utilization decay.
>          */
>         util = util_cfs + cpu_util_rt(rq);
> -       if (type == FREQUENCY_UTIL)
> +       if (type == FREQUENCY_UTIL) {
> +               util = apply_dvfs_headroom(util);

This is not the same as before because utilization has not being
scaled by irq steal time yet

>                 util = uclamp_rq_util_with(rq, util, p);
> +       }
>
>         dl_util = cpu_util_dl(rq);
>
> @@ -7471,9 +7473,12 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
>          *              max - irq
>          *   U' = irq + --------- * U
>          *                 max
> +        *
> +        * We only need to apply dvfs headroom to irq part since the util part
> +        * already had it applied.
>          */
>         util = scale_irq_capacity(util, irq, max);
> -       util += irq;
> +       util += type ==  FREQUENCY_UTIL ? apply_dvfs_headroom(irq) : irq;
>
>         /*
>          * Bandwidth required by DEADLINE must always be granted while, for
> @@ -7486,7 +7491,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
>          * an interface. So, we only do the latter for now.
>          */
>         if (type == FREQUENCY_UTIL)
> -               util += cpu_bw_dl(rq);
> +               util += apply_dvfs_headroom(cpu_bw_dl(rq));

If we follow your reasoning with uclamp on the dl bandwidth, should we
not skip this as well ?

>
>         return min(max, util);
>  }
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 916c4d3d6192..0c7565ac31fb 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -143,7 +143,6 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>         unsigned int freq = arch_scale_freq_invariant() ?
>                                 policy->cpuinfo.max_freq : policy->cur;
>
> -       util = apply_dvfs_headroom(util);
>         freq = map_util_freq(util, freq, max);
>
>         if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> @@ -406,8 +405,8 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>             sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
>                 sg_cpu->util = prev_util;
>
> -       cpufreq_driver_adjust_perf(sg_cpu->cpu, apply_dvfs_headroom(sg_cpu->bw_dl),
> -                                  apply_dvfs_headroom(sg_cpu->util), max_cap);
> +       cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_dl,
> +                                  sg_cpu->util, max_cap);
>
>         sg_cpu->sg_policy->last_freq_update_time = time;
>  }
> --
> 2.34.1
>
