Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9177877FB6E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353436AbjHQQBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353430AbjHQQBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:01:18 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4595BF2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:01:17 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-564b326185bso4801709a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692288077; x=1692892877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B2X7CsNJ1XIHQIAFvP0L8mpbOrFjG7U4cylxz5W9a4o=;
        b=gW9MS8oYjKQXJa7o3HJoTcnS9dN/7Ivm25qQg8k/zrKFFqcP4Rx2HGqrw6NEEtyX5B
         ZSTdHUdsyJok7fLZ2f3STVZNRZ5WA4TEtB7cerYnS5oeszL3JYzsHBFcJTTEKwUOOlm9
         DavmBowiIcUpQOKhTcD9Q6Cd2eXlUiMApxal0A8c6WA4csE8h9z0CwOSlBmD+Fr4kFAH
         UaGmEkT023uSJl9qKMwWmAeZduHIzO2Gxklmc0GSNRbGoNqHFulVVpO8ykZEL8VVfnwr
         Wuw2lXif76dqcsCKria+adNQX+2ojJZC61uJUfhr1kGMTOhjK9TMe6pVIhaqgHEshpw7
         uZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692288077; x=1692892877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2X7CsNJ1XIHQIAFvP0L8mpbOrFjG7U4cylxz5W9a4o=;
        b=finCo7FKTy8Aiogwq9sEcwLP5PpNgWkm/Ka2CKEJnwHuHQVRfQv6EPXJI1fXW/A/X/
         nXsteqmSQ3SZMYa8sldErIFiwIlq4Q8r2+7GSA/Vz0PUzx8KsNUBMxy0wGqfrYETbzeh
         Fg3zZ4Wf68L26igsKfYv/ueiglp8PQJ0bxT/uNim4Qeq1LyVNyBG874kuytPzsRd3Pv6
         WsqDKwjMDyYuVzWNzMkj6Y82g1uy1S+VuWaoS+1DP5xo1b9P3dmGT+CQrlIOvl/vJlFV
         goiG63cdEVRnHYxhjaoFj1uGlR87i+dhWsGZ2FEGcc3DMc8R+IdW4IdNch/gLvLhNaT3
         6I1g==
X-Gm-Message-State: AOJu0YxFlI997QkmI+cHSkuOvR+tIECJ6trQtpWAqQfnuD8dXLDBSDvA
        MmsyCMPWhy7Vh607OM4kN82svFcKz4QF0eT81WD31g==
X-Google-Smtp-Source: AGHT+IFtKszpE/DEARQZw42hrT6B4DGNuhd4tdbSvm5elQtpzV5iYoYWhooGgxb44e9zGHETDh1SyLj3Whyj40choN8=
X-Received: by 2002:a05:6a20:548e:b0:13e:da98:966a with SMTP id
 i14-20020a056a20548e00b0013eda98966amr222447pzk.5.1692288076631; Thu, 17 Aug
 2023 09:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230817153515.143932-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20230817153515.143932-1-mathieu.desnoyers@efficios.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 17 Aug 2023 18:01:05 +0200
Message-ID: <CAKfTPtCavFCk+1cJe2=zFa7WfiX4XGMdc5AsA_2r4xqsk+4v7Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] sched: ttwu_queue_cond: perform queued wakeups
 across different L2 caches
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 at 17:34, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Skipping queued wakeups for all logical CPUs sharing an LLC means that
> on a 192 cores AMD EPYC 9654 96-Core Processor (over 2 sockets), groups
> of 8 cores (16 hardware threads) end up grabbing runqueue locks of other
> runqueues within the same group for each wakeup, causing contention on
> the runqueue locks.
>
> Improve this by only considering hardware threads sharing an L2 cache as
> candidates for skipping use of the queued wakeups.
>
> This results in the following benchmark improvements:
>
>     hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
>
> from 49s to 34s. (30% speedup)
>
> And similarly with perf bench:
>
>     perf bench sched messaging -g 32 -p -t -l 100000
>
> from 10.9s to 7.4s (32% speedup)
>
> This was developed as part of the investigation into a weird regression
> reported by AMD where adding a raw spinlock in the scheduler context
> switch accelerated hackbench. It turned out that changing this raw
> spinlock for a loop of 10000x cpu_relax within do_idle() had similar
> benefits.
>
> This patch achieves a similar effect without busy waiting nor changing
> anything about runqueue selection on wakeup. It considers that only
> hardware threads sharing an L2 cache should skip the queued
> try-to-wakeup and directly grab the target runqueue lock, rather than
> allowing all hardware threads sharing an LLC to do so.
>
> I would be interested to hear feedback about performance impact of this
> patch (improvement or regression) on other workloads and hardware,
> especially for Intel CPUs. One thing that we might want to empirically
> figure out from the topology is whether there is a maximum number of
> hardware threads within an LLC below which it would make sense to use
> the LLC rather than L2 as group within which queued wakeups can be
> skipped.
>
> [ Only tested on AMD CPUs so far. ]
>
> Link: https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
> Link: https://lore.kernel.org/lkml/20230725193048.124796-1-mathieu.desnoyers@efficios.com/
> Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
> Cc: Aaron Lu <aaron.lu@intel.com>
> Cc: x86@kernel.org
> ---
>  arch/Kconfig                   |  6 ++++++
>  arch/x86/Kconfig               |  1 +
>  drivers/base/Kconfig           |  1 +
>  include/linux/sched/topology.h |  3 ++-
>  kernel/sched/core.c            | 26 +++++++++++++++++++++++---
>  5 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 205fd23e0cad..e5aac1741712 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -340,6 +340,12 @@ config HAVE_ASM_MODVERSIONS
>           <asm/asm-prototypes.h> to support the module versioning for symbols
>           exported from assembly code.
>
> +config HAVE_CLUSTERGROUP
> +       bool
> +       help
> +         This symbol should be selected by an architecture if it
> +         implements CPU clustergroup.
> +
>  config HAVE_REGS_AND_STACK_ACCESS_API
>         bool
>         help
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index cb1031018afa..07813a1a9a58 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -299,6 +299,7 @@ config X86
>         select FUNCTION_ALIGNMENT_4B
>         imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>         select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> +       select HAVE_CLUSTERGROUP
>
>  config INSTRUCTION_DECODER
>         def_bool y
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 2b8fd6bb7da0..408aaf7a4bd1 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -218,6 +218,7 @@ config DMA_FENCE_TRACE
>
>  config GENERIC_ARCH_TOPOLOGY
>         bool
> +       select HAVE_CLUSTERGROUP
>         help
>           Enable support for architectures common topology code: e.g., parsing
>           CPU capacity information from DT, usage of such information for
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 816df6cc444e..714386070463 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -178,7 +178,8 @@ extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>  cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
>  void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
>
> -bool cpus_share_cache(int this_cpu, int that_cpu);
> +bool cpus_share_cluster(int this_cpu, int that_cpu);   /* Share L2. */
> +bool cpus_share_cache(int this_cpu, int that_cpu);     /* Share LLC. */

I think that Yicong is doing what you want with
cpus_share_lowest_cache() which points to cluster when available or
LLC otherwise
https://lore.kernel.org/lkml/20220720081150.22167-1-yangyicong@hisilicon.com/t/#m0ab9fa0fe0c3779b9bbadcfbc1b643dce7cb7618

>
>  typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
>  typedef int (*sched_domain_flags_f)(void);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a68d1276bab0..ce3402b81e5e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3904,13 +3904,33 @@ void wake_up_if_idle(int cpu)
>         rcu_read_unlock();
>  }
>
> +/*
> + * Query whether CPUs share LLC.
> + */
>  bool cpus_share_cache(int this_cpu, int that_cpu)
> +{
> +       return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
> +}
> +
> +#ifdef CONFIG_HAVE_CLUSTERGROUP
> +/*
> + * Query whether CPUs share L2 cache.
> + */
> +bool cpus_share_cluster(int this_cpu, int that_cpu)
>  {
>         if (this_cpu == that_cpu)
>                 return true;
> -
> -       return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
> +       return cpumask_test_cpu(that_cpu, cpu_clustergroup_mask(this_cpu));
> +}
> +#else
> +/*
> + * Fall-back on querying whether CPUs share LLC.
> + */
> +bool cpus_share_cluster(int this_cpu, int that_cpu)
> +{
> +       return cpus_share_cache(this_cpu, that_cpu);
>  }
> +#endif
>
>  static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
>  {
> @@ -3929,7 +3949,7 @@ static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
>          * If the CPU does not share cache, then queue the task on the
>          * remote rqs wakelist to avoid accessing remote data.
>          */
> -       if (!cpus_share_cache(smp_processor_id(), cpu))
> +       if (!cpus_share_cluster(smp_processor_id(), cpu))
>                 return true;
>
>         if (cpu == smp_processor_id())
> --
> 2.39.2
>
