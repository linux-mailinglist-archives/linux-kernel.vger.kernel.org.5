Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3627CE476
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjJRR3D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 13:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjJRR24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:28:56 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6F426BF;
        Wed, 18 Oct 2023 10:22:53 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-57f137dffa5so1006595eaf.1;
        Wed, 18 Oct 2023 10:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697649772; x=1698254572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGquFH/+a1RdzcZc8K6W68eVVi5OATd0jI25tQHlZv8=;
        b=LPHeetMzg/ILxOYIK9wyAxfSZnS+4zcqkRAKzCKSXPhptbNRcF+fUvytUMwX3MjShH
         +5rrxNob2d/BZZO59Uo/FqEhnxngyIrL3TcODribDkl6Oga6whJtQOdY/H1wA0pS6tUU
         wxNkC0gIcjgISK4Rnr7aJrDE4es/AEFT3IKeWqZNxRuvr4o0JYA1R/KIISL5kIpTqD1q
         GardMiSxPKcO3S+a9Z7IO3WBm3om5txBmetKnsUqXJQx+Nv1IaLQCEXyqlEWw6oAQvPU
         2cd7Lg64rEA1g6T7PnxrLiNwQSijCGSHnvPCTnkOXFysgDtfBI2zFYvsc+C42WxRrpY4
         6+XA==
X-Gm-Message-State: AOJu0YzYaTGEVjRAIurAw43EOcE2TRrR6Bwu3nwTV2nB7xcI/nCq7vmu
        ZRU7pR8StG+MpVAGMhHj7bifyCi1MunWtAkxHe5ODQSC
X-Google-Smtp-Source: AGHT+IGnmJUfeSri+TMV3NErQyfjji4f2m97Lkw8D0KsSEf0XFZvd7HfD1x/izKkVXkF2hgHtKhj59ftsHemFTzqGXM=
X-Received: by 2002:a4a:e1cd:0:b0:581:feb5:ac87 with SMTP id
 n13-20020a4ae1cd000000b00581feb5ac87mr2078567oot.1.1697649771877; Wed, 18 Oct
 2023 10:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org> <20231018162540.667646-4-vincent.guittot@linaro.org>
In-Reply-To: <20231018162540.667646-4-vincent.guittot@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Oct 2023 19:22:40 +0200
Message-ID: <CAJZ5v0i58HLmgp=JYCbq5B6LUe0tEAhd9Ed9WKqkkHjVEO_W6A@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] cpufreq/schedutil: use a fixed reference frequency
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 6:25 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> cpuinfo.max_freq can change at runtime because of boost as an example. This
> implies that the value could be different than the one that has been
> used when computing the capacity of a CPU.
>
> The new arch_scale_freq_ref() returns a fixed and coherent reference
> frequency that can be used when computing a frequency based on utilization.
>
> Use this arch_scale_freq_ref() when available and fallback to
> policy otherwise.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

>
> ---
>  kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 458d359f5991..6e4030482ae8 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -114,6 +114,28 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
>         }
>  }
>
> +/**
> + * cpufreq_get_capacity_ref_freq - get the reference frequency of a given CPU that
> + * has been used to correlate frequency and compute capacity.
> + * @policy: the cpufreq policy of the CPU in question.
> + * @use_current: Fallback to current freq instead of policy->cpuinfo.max_freq.
> + *
> + * Return: the reference CPU frequency to compute a capacity.
> + */
> +static __always_inline
> +unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> +{
> +       unsigned int freq = arch_scale_freq_ref(policy->cpu);
> +
> +       if (freq)
> +               return freq;
> +
> +       if (arch_scale_freq_invariant())
> +               return policy->cpuinfo.max_freq;
> +
> +       return policy->cur;
> +}
> +
>  /**
>   * get_next_freq - Compute a new frequency for a given cpufreq policy.
>   * @sg_policy: schedutil policy object to compute the new frequency for.
> @@ -140,10 +162,10 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>                                   unsigned long util, unsigned long max)
>  {
>         struct cpufreq_policy *policy = sg_policy->policy;
> -       unsigned int freq = arch_scale_freq_invariant() ?
> -                               policy->cpuinfo.max_freq : policy->cur;
> +       unsigned int freq;
>
>         util = map_util_perf(util);
> +       freq = get_capacity_ref_freq(policy);
>         freq = map_util_freq(util, freq, max);
>
>         if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> --
> 2.34.1
>
