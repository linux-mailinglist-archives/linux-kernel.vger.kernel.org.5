Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1847CE494
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjJRRai convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 13:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjJRR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:29:55 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699C63C0F;
        Wed, 18 Oct 2023 10:23:25 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-582050ce2d8so25812eaf.0;
        Wed, 18 Oct 2023 10:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697649804; x=1698254604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2lwiFW7v1x6wJxRpx1c+ObPtw/kHFVlH2vUJpoYMn0=;
        b=AyN+NoPAVB8NQ1Jq3z4mylGl6Ae++nsCqlUsiob5kMuKBv7h8JL+ye1HEMthG0tvb1
         NxmK0CS9Ig+jTtmNngI04vbRqXZKncEGAORkGmXGQWV6cJ8t52KSx4DpczqDZODYlZ8j
         q8KpPMO57QECLStv3uTuylzxo7WO4zyqRkrwquJ1RgeEod1AlyvBVhmpsCwp8WAn4Gl7
         ryg3szxmrA3upeE7VjSuXQBwurv8j82xozg24GgwO5VMhCRJp2LjO4siPR93S+izqBiI
         I6NlahBmucbrDjYBLn4+ED5ck6rht4ynj1LuXSL/2NhqpuCaqz3c25gcGzdQECUJWqn4
         ks6Q==
X-Gm-Message-State: AOJu0YxpHvf0ViJg46ESn432olLBgRBMlCVdIhw7L8jwL/U9+yRTvJ1r
        6ILbfEBG4dClBZy9ndSaay29+4N6Pr+C1uW4qpLnkQX7zf0=
X-Google-Smtp-Source: AGHT+IGnNjtcabtUMJyCpUS/Q8iadNabFO9ltoFIiy6KhS15PxlDuBSBbxZIY+SzIP5PAczSNxTThF+a9wJpw+QBaOQ=
X-Received: by 2002:a05:6820:180f:b0:581:f17d:5eb5 with SMTP id
 bn15-20020a056820180f00b00581f17d5eb5mr3255065oob.0.1697649804594; Wed, 18
 Oct 2023 10:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org> <20231018162540.667646-3-vincent.guittot@linaro.org>
In-Reply-To: <20231018162540.667646-3-vincent.guittot@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Oct 2023 19:23:13 +0200
Message-ID: <CAJZ5v0iu9AjZWNbMPQbwErYRTz8y0PEGDyh7CU_NwxGj6KXMOQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] cpufreq: use the fixed and coherent frequency for
 scaling capacity
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
> implies that the value could be different from the frequency that has been
> used to compute the capacity of a CPU.
>
> The new arch_scale_freq_ref() returns a fixed and coherent frequency
> that can be used to compute the capacity for a given frequency.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  include/linux/cpufreq.h   | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 60ed89000e82..8c4f9c2f9c44 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -454,7 +454,7 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
>
>         arch_set_freq_scale(policy->related_cpus,
>                             policy->cur,
> -                           policy->cpuinfo.max_freq);
> +                           arch_scale_freq_ref(policy->cpu));
>
>         spin_lock(&policy->transition_lock);
>         policy->transition_ongoing = false;
> @@ -2174,7 +2174,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>
>         policy->cur = freq;
>         arch_set_freq_scale(policy->related_cpus, freq,
> -                           policy->cpuinfo.max_freq);
> +                           arch_scale_freq_ref(policy->cpu));
>         cpufreq_stats_record_transition(policy, freq);
>
>         if (trace_cpu_frequency_enabled()) {
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 71d186d6933a..bbc483b4b6e5 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1211,6 +1211,15 @@ void arch_set_freq_scale(const struct cpumask *cpus,
>  {
>  }
>  #endif
> +
> +#ifndef arch_scale_freq_ref
> +static __always_inline
> +unsigned int arch_scale_freq_ref(int cpu)
> +{
> +       return 0;
> +}
> +#endif
> +
>  /* the following are really really optional */
>  extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
>  extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
> --
> 2.34.1
>
