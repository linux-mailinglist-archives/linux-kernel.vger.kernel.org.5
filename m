Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2334B76215C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjGYSbp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 14:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjGYSbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:31:43 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0502126;
        Tue, 25 Jul 2023 11:31:41 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6bb086bd510so440458a34.1;
        Tue, 25 Jul 2023 11:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690309900; x=1690914700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEfRwOZyV2KRi/hnXCf8xoSZdvJnVbt1ZHx/GNCOZgI=;
        b=WtUESew298HJMfz0n52OOahnfxz5fDogXaRAfYNQxETy8wLYUn3azLD0VUli+maMAg
         WVr8ebGK8xVA2VDJ+lCSwRNfKDwHFNb74seIvSnEpRUQN7bD7uVaQ/N0vROgHo08CYxB
         2poHfhZRCFRUwL36SYiuvcTjBPPxeYQgG7RRVoM30vO1DbVoeWoPLUzDB0mJ0caiBeCt
         VL3DeNaQA2sLt+Afs176AWvHk7cGGATpbuGNEd5nZyYGNqprBNPgNx+WA8xWlEEBQBjx
         dCP7MLjE3PHpdUN+akiIc3uLYkHzWeKuGAwFpZ4NzUdxizuhFDqslQXOfvFlAGgwOpp2
         yrQQ==
X-Gm-Message-State: ABy/qLZRuehZ7EmXKW1M7+4lzp4PUvB2TBCtQS8CTif0JkzzbDKalBL5
        vgL8yVBedi53TTIqL9SBc7pUzcGGZ1CS1OHm1Vs=
X-Google-Smtp-Source: APBJJlExpupGrvjjN6gJ4j+0/t7oEoBtCkKjgSPc/h6zspKwEuIeGbeF/B0xOcIW7yQysMS2DyrPvh2jw2cOCL278rI=
X-Received: by 2002:a4a:e7c8:0:b0:566:6984:c44 with SMTP id
 y8-20020a4ae7c8000000b0056669840c44mr8297795oov.1.1690309900552; Tue, 25 Jul
 2023 11:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <006901d9be8c$f4439930$dccacb90$@telus.net>
In-Reply-To: <006901d9be8c$f4439930$dccacb90$@telus.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jul 2023 20:31:29 +0200
Message-ID: <CAJZ5v0hqPb1+tzGiOCSKr=4QcjnRKT5Gd8FcNbD_Gz5CnAw8tw@mail.gmail.com>
Subject: Re: [PATCH] x86/aperfmperf: Make stale CPU frequency response within limits.
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, yang.jie@linux.intel.com,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 2:14 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> Currently, when the CPU frequency is stale the nominal clock frequency
> is returned by calls to arch_freq_get_on_cpu(). Some users are
> confused by the high reported frequency when their system is idle
> and/or it is above a reduced maximum they set.
>
> This patch will return the policy minimum as the stale frequency reply
> from arch_freq_get_on_cpu().
>
> Reported-by: Yang Jie <yang.jie@linux.intel.com>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=217597
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  arch/x86/kernel/cpu/aperfmperf.c | 13 +++++--------
>  drivers/cpufreq/cpufreq.c        | 18 ++++++++++++++++++
>  include/linux/cpufreq.h          |  5 +++++
>  3 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> index fdbb5f07448f..44cc96864d94 100644
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -418,9 +418,10 @@ unsigned int arch_freq_get_on_cpu(int cpu)
>         unsigned long last;
>         u64 acnt, mcnt;
>
> -       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> -               goto fallback;
> -
> +       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF)){
> +               freq = cpufreq_quick_get(cpu);
> +               return freq ? freq : cpufreq_quick_get_min(cpu);
> +       }
>         do {
>                 seq = raw_read_seqcount_begin(&s->seq);
>                 last = s->last_update;
> @@ -433,13 +434,9 @@ unsigned int arch_freq_get_on_cpu(int cpu)
>          * which covers idle and NOHZ full CPUs.
>          */
>         if (!mcnt || (jiffies - last) > MAX_SAMPLE_AGE)
> -               goto fallback;
> +               return cpufreq_quick_get_min(cpu);
>
>         return div64_u64((cpu_khz * acnt), mcnt);
> -
> -fallback:
> -       freq = cpufreq_quick_get(cpu);
> -       return freq ? freq : cpu_khz;

It looks to me like modifying cpufreq_quick_get) to return policy->min
if policy->cur is 0 would work in a similar way, wouldn't it?

>  }
>
>  static int __init bp_init_aperfmperf(void)
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 50bbc969ffe5..a0b24f61a5b0 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1796,6 +1796,24 @@ unsigned int cpufreq_quick_get_max(unsigned int cpu)
>  }
>  EXPORT_SYMBOL(cpufreq_quick_get_max);
>
> +/**
> + * cpufreq_quick_get_min - return the min frequency for a given CPU
> + * @cpu: CPU number
> + */
> +unsigned int cpufreq_quick_get_min(unsigned int cpu)
> +{
> +       struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +       unsigned int ret_freq = 0;
> +
> +       if (policy) {
> +               ret_freq = policy->min;
> +               cpufreq_cpu_put(policy);
> +       }
> +
> +       return ret_freq;
> +}
> +EXPORT_SYMBOL(cpufreq_quick_get_min);
> +
>  /**
>   * cpufreq_get_hw_max_freq - get the max hardware frequency of the CPU
>   * @cpu: CPU number
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 172ff51c1b2a..c74dcb5f9263 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -220,6 +220,7 @@ static inline bool policy_is_shared(struct cpufreq_policy *policy)
>  unsigned int cpufreq_get(unsigned int cpu);
>  unsigned int cpufreq_quick_get(unsigned int cpu);
>  unsigned int cpufreq_quick_get_max(unsigned int cpu);
> +unsigned int cpufreq_quick_get_min(unsigned int cpu);
>  unsigned int cpufreq_get_hw_max_freq(unsigned int cpu);
>  void disable_cpufreq(void);
>
> @@ -250,6 +251,10 @@ static inline unsigned int cpufreq_quick_get_max(unsigned int cpu)
>  {
>         return 0;
>  }
> +static inline unsigned int cpufreq_quick_get_min(unsigned int cpu)
> +{
> +       return 0;
> +}
>  static inline unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
>  {
>         return 0;
> --
> 2.25.1
>
>
