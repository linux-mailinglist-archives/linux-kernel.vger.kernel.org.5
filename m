Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD57784AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjHVUBn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 16:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjHVUBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:01:41 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2581FCE6;
        Tue, 22 Aug 2023 13:01:40 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-570c1364e5eso367301eaf.0;
        Tue, 22 Aug 2023 13:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692734499; x=1693339299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGp/1KbTUz+Ui/4a8BwzMWjLiVQYdfk0/9ww8lHSVlY=;
        b=Nb6EG2grWEoXzUS8fbMpA0cjpTXrOfX6mop60y98lgIrDBQf3zJ8YWJQr5NzQiZTJo
         /Z759Pc0kpNp6/NzTuOkK0tVwUvqADwrRLyegyE6Khwtoqm6WyynNZVY1APrWxi6if4d
         BqsoOPy01zVXZeh6SGXgaRO2jHKkiL9+DQStExh+3DV4BAbPo0sJohP19jPCHwaP+Ygp
         9qIl9wGeKkixskXsudE8eY/bPNOPdytXaDAeNcw1MB6bP/CfGd8MdvKL9W7aiNzSmWbG
         loeaXw/r2MHXeD1C7YeFJwBDSrhpRgK/TuC+WFUaFKRtLZ0bcpkAEUOuK/S9F6cB4OwC
         wamw==
X-Gm-Message-State: AOJu0YzcmXZqLi3THfQKcoESIIsal2xCmkn1khqtDQIOOkAwe1gbS4KE
        YXXRAdOc6bu7RuxFrIF1ZvNGzsq799g9T7KUH0k=
X-Google-Smtp-Source: AGHT+IEN3EP7ULYKFEMxVyXQg5v3UbYhCP0pdirUGKy9Z0d0es7y+MVsQmWXP9+FgCa35mj0vPNkIQRuHc80WmUQLGc=
X-Received: by 2002:a4a:bc82:0:b0:569:a08a:d9c5 with SMTP id
 m2-20020a4abc82000000b00569a08ad9c5mr9291442oop.0.1692734499240; Tue, 22 Aug
 2023 13:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230808111325.8600-1-TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20230808111325.8600-1-TonyWWang-oc@zhaoxin.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 22:01:28 +0200
Message-ID: <CAJZ5v0h8M-hNJfRTSxtVmfmpF09h9zmNmG-e=iMemzPwsK50Zg@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: ACPI: add ITMT support when CPPC enabled
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com,
        LindaChai@zhaoxin.com
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

On Tue, Aug 8, 2023 at 1:13 PM Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> wrote:
>
> The _CPC method can get per-core highest frequency.

Well, not exactly.  A more precise way to say this would be "The
per-core highest frequency can be obtained via CPPC."

> The highest frequency may varies between cores which mean cores can

"may vary" and "which means"

> running at different max frequency, so can use it as a core priority

"can run", but it would be better to say "may run".

> and give a hint to scheduler in order to put critical task to the
> higher priority core.

Well, roughly speaking ...

You should really talk about ITMT and how it can be hooked up to this.

> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
> v1->v2: Fix build errors reported by kernel test robot
>
>  arch/x86/kernel/itmt.c         |  2 ++
>  drivers/cpufreq/acpi-cpufreq.c | 59 ++++++++++++++++++++++++++++++----
>  2 files changed, 54 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
> index ee4fe8cdb857..b49ac8ecbbd6 100644
> --- a/arch/x86/kernel/itmt.c
> +++ b/arch/x86/kernel/itmt.c
> @@ -122,6 +122,7 @@ int sched_set_itmt_support(void)
>
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(sched_set_itmt_support);

This requires an ACK from the x86 maintainers.

>
>  /**
>   * sched_clear_itmt_support() - Revoke platform's support of ITMT
> @@ -181,3 +182,4 @@ void sched_set_itmt_core_prio(int prio, int cpu)
>  {
>         per_cpu(sched_core_priority, cpu) = prio;
>  }
> +EXPORT_SYMBOL_GPL(sched_set_itmt_core_prio);

And same here.

> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index b2f05d27167e..5733323e04ac 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -628,28 +628,35 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
>  #endif
>
>  #ifdef CONFIG_ACPI_CPPC_LIB
> -static u64 get_max_boost_ratio(unsigned int cpu)
> +static void cpufreq_get_core_perf(int cpu, u64 *highest_perf, u64 *nominal_perf)

This is not a cpufreq core function, so please use a different prefix
in its name.

>  {
>         struct cppc_perf_caps perf_caps;
> -       u64 highest_perf, nominal_perf;
>         int ret;
>
>         if (acpi_pstate_strict)
> -               return 0;
> +               return;
>
>         ret = cppc_get_perf_caps(cpu, &perf_caps);
>         if (ret) {
>                 pr_debug("CPU%d: Unable to get performance capabilities (%d)\n",
>                          cpu, ret);
> -               return 0;
> +               return;
>         }
>
>         if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> -               highest_perf = amd_get_highest_perf();
> +               *highest_perf = amd_get_highest_perf();
>         else
> -               highest_perf = perf_caps.highest_perf;
> +               *highest_perf = perf_caps.highest_perf;
> +
> +       *nominal_perf = perf_caps.nominal_perf;
> +       return;
> +}
>
> -       nominal_perf = perf_caps.nominal_perf;
> +static u64 get_max_boost_ratio(unsigned int cpu)
> +{
> +       u64 highest_perf, nominal_perf;
> +
> +       cpufreq_get_core_perf(cpu, &highest_perf, &nominal_perf);
>
>         if (!highest_perf || !nominal_perf) {
>                 pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
> @@ -663,8 +670,44 @@ static u64 get_max_boost_ratio(unsigned int cpu)
>
>         return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
>  }
> +
> +static void cpufreq_sched_itmt_work_fn(struct work_struct *work)

A similar comment applies here.

> +{
> +       sched_set_itmt_support();
> +}
> +
> +static DECLARE_WORK(sched_itmt_work, cpufreq_sched_itmt_work_fn);
> +
> +static void cpufreq_set_itmt_prio(int cpu)
> +{
> +       u64 highest_perf, nominal_perf;
> +       static u32 max_highest_perf = 0, min_highest_perf = U32_MAX;
> +
> +       cpufreq_get_core_perf(cpu, &highest_perf, &nominal_perf);
> +
> +       sched_set_itmt_core_prio(highest_perf, cpu);
> +
> +       if (max_highest_perf <= min_highest_perf) {
> +               if (highest_perf > max_highest_perf)
> +                       max_highest_perf = highest_perf;
> +
> +               if (highest_perf < min_highest_perf)
> +                       min_highest_perf = highest_perf;
> +
> +               if (max_highest_perf > min_highest_perf) {
> +                       /*
> +                        * This code can be run during CPU online under the
> +                        * CPU hotplug locks, so sched_set_itmt_support()
> +                        * cannot be called from here.  Queue up a work item
> +                        * to invoke it.
> +                        */
> +                       schedule_work(&sched_itmt_work);
> +               }

This potentially runs before ITMT priorities are set for all CPUs.
Isn't it a problem?

> +       }
> +}
>  #else
>  static inline u64 get_max_boost_ratio(unsigned int cpu) { return 0; }
> +static void cpufreq_set_itmt_prio(int cpu) { return; }
>  #endif
>
>  static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> @@ -870,6 +913,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>         /* notify BIOS that we exist */
>         acpi_processor_notify_smm(THIS_MODULE);
>
> +       cpufreq_set_itmt_prio(cpu);
> +
>         pr_debug("CPU%u - ACPI performance management activated.\n", cpu);
>         for (i = 0; i < perf->state_count; i++)
>                 pr_debug("     %cP%d: %d MHz, %d mW, %d uS\n",
> --
