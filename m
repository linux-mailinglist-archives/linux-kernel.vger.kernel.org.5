Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF3D7E26C3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjKFO0d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 09:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjKFO03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:26:29 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E8DF;
        Mon,  6 Nov 2023 06:26:25 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b2d9a9c824so873761b6e.0;
        Mon, 06 Nov 2023 06:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699280785; x=1699885585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b56u0WaEQeITXS0hleeBCMhAKd5IZuufQZDWVLUnIEI=;
        b=Ik4Z5idXOD4Xbi+xZIcVdafkHx1pqI93XQO9ULRURoJJ+4MYfCvHadL2rM1cBAm0M7
         j+2npgEBWS/H0wM/1KowJfl47apyCdrtq3llijwprhs2GXjmnoB45tOi+PcWHllLWE/I
         xFJxBaWZ0dI3KyBDX9aKyTKUA949P1z5c0n78IwRFEgk8yoz9FUvOpqkrWItx5ihP1pC
         J2R2gQr7f8z7Ev3GyugRxsnGI1cE5F4mIZzJb4vo0Vy4nGXabwg8Y8uLT0rMxJ6S/lLP
         PLmiwIJA9gB+4XCdd/qduSJFcBnER0sLyUdTRtA+HCcwRhWwRqqon0QPdkgw2YDdX0c4
         gTdw==
X-Gm-Message-State: AOJu0Yx+4TuN2iH6V4x+9PaFSK3K1rYa0CriCPuZefTSHyjnPFUbW8BV
        trwKkis3xQ1yyauPTuwYyN8U9FIDxF9BpfnILAF34jWM
X-Google-Smtp-Source: AGHT+IFfaJW3GERgkYJsdiLf7B/IDjTeXsuU75TeeNUYD+P7/0OmNuYaTH2Gec1TGE3TQVgxCzNT1+NT9fzGUpvzn60=
X-Received: by 2002:a05:6808:1b11:b0:3b2:efd3:e78c with SMTP id
 bx17-20020a0568081b1100b003b2efd3e78cmr34018633oib.1.1699280784738; Mon, 06
 Nov 2023 06:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20231104105907.1365392-1-vincent.guittot@linaro.org> <20231104105907.1365392-6-vincent.guittot@linaro.org>
In-Reply-To: <20231104105907.1365392-6-vincent.guittot@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Nov 2023 15:26:13 +0100
Message-ID: <CAJZ5v0iShk--0LJQRrpnAx_Bf-MKvpN9qKy_3UqebHuC-xJKmQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}
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
        pierre.gondois@arm.com, beata.michalska@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 4, 2023 at 11:59 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Move and rename cppc_cpufreq_perf_to_khz and cppc_cpufreq_khz_to_perf to
> use them outside cppc_cpufreq in topology_init_cpu_capacity_cppc().
>
> Modify the interface to use struct cppc_perf_caps *caps instead of
> struct cppc_cpudata *cpu_data as we only use the fields of cppc_perf_caps.
>
> cppc_cpufreq was converting the lowest and nominal freq from MHz to kHz
> before using them. We move this conversion inside cppc_perf_to_khz and
> cppc_khz_to_perf to make them generic and usable outside cppc_cpufreq.
>
> No functional change
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/acpi/cppc_acpi.c       | 104 ++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 139 ++++-----------------------------
>  include/acpi/cppc_acpi.h       |   2 +
>  3 files changed, 123 insertions(+), 122 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..d155a86a8614 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -39,6 +39,9 @@
>  #include <linux/rwsem.h>
>  #include <linux/wait.h>
>  #include <linux/topology.h>
> +#include <linux/dmi.h>
> +#include <linux/units.h>
> +#include <asm/unaligned.h>
>
>  #include <acpi/cppc_acpi.h>
>
> @@ -1760,3 +1763,104 @@ unsigned int cppc_get_transition_latency(int cpu_num)
>         return latency_ns;
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_transition_latency);
> +
> +/* Minimum struct length needed for the DMI processor entry we want */
> +#define DMI_ENTRY_PROCESSOR_MIN_LENGTH 48
> +
> +/* Offset in the DMI processor structure for the max frequency */
> +#define DMI_PROCESSOR_MAX_SPEED                0x14
> +
> +/* Callback function used to retrieve the max frequency from DMI */
> +static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
> +{
> +       const u8 *dmi_data = (const u8 *)dm;
> +       u16 *mhz = (u16 *)private;
> +
> +       if (dm->type == DMI_ENTRY_PROCESSOR &&
> +           dm->length >= DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
> +               u16 val = (u16)get_unaligned((const u16 *)
> +                               (dmi_data + DMI_PROCESSOR_MAX_SPEED));
> +               *mhz = val > *mhz ? val : *mhz;
> +       }
> +}
> +
> +/* Look up the max frequency in DMI */
> +static u64 cppc_get_dmi_max_khz(void)
> +{
> +       u16 mhz = 0;
> +
> +       dmi_walk(cppc_find_dmi_mhz, &mhz);
> +
> +       /*
> +        * Real stupid fallback value, just in case there is no
> +        * actual value set.
> +        */
> +       mhz = mhz ? mhz : 1;
> +
> +       return KHZ_PER_MHZ * mhz;
> +}
> +
> +/*
> + * If CPPC lowest_freq and nominal_freq registers are exposed then we can
> + * use them to convert perf to freq and vice versa. The conversion is
> + * extrapolated as an affine function passing by the 2 points:
> + *  - (Low perf, Low freq)
> + *  - (Nominal perf, Nominal freq)
> + */
> +unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf)
> +{
> +       s64 retval, offset = 0;
> +       static u64 max_khz;
> +       u64 mul, div;
> +
> +       if (caps->lowest_freq && caps->nominal_freq) {
> +               mul = caps->nominal_freq - caps->lowest_freq;
> +               mul *= KHZ_PER_MHZ;
> +               div = caps->nominal_perf - caps->lowest_perf;
> +               offset = caps->nominal_freq * KHZ_PER_MHZ -
> +                        div64_u64(caps->nominal_perf * mul, div);
> +       } else {
> +               if (!max_khz)
> +                       max_khz = cppc_get_dmi_max_khz();
> +               mul = max_khz;
> +               div = caps->highest_perf;
> +       }
> +
> +       retval = offset + div64_u64(perf * mul, div);
> +       if (retval >= 0)
> +               return retval;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_perf_to_khz);
> +
> +unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq)
> +{
> +       s64 retval, offset = 0;
> +       static u64 max_khz;
> +       u64  mul, div;
> +
> +       if (caps->lowest_freq && caps->nominal_freq) {
> +               mul = caps->nominal_perf - caps->lowest_perf;
> +               div = caps->nominal_freq - caps->lowest_freq;
> +               /*
> +                * We don't need to convert to kHz for computing offset and can
> +                * directly use nominal_freq and lowest_freq as the div64_u64
> +                * will remove the frequency unit.
> +                */
> +               offset = caps->nominal_perf -
> +                        div64_u64(caps->nominal_freq * mul, div);
> +               /* But we need it for computing the perf level. */
> +               div *= KHZ_PER_MHZ;
> +       } else {
> +               if (!max_khz)
> +                       max_khz = cppc_get_dmi_max_khz();
> +               mul = caps->highest_perf;
> +               div = max_khz;
> +       }
> +
> +       retval = offset + div64_u64(freq * mul, div);
> +       if (retval >= 0)
> +               return retval;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_khz_to_perf);
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index fe08ca419b3d..64420d9cfd1e 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -16,7 +16,6 @@
>  #include <linux/delay.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> -#include <linux/dmi.h>
>  #include <linux/irq_work.h>
>  #include <linux/kthread.h>
>  #include <linux/time.h>
> @@ -27,12 +26,6 @@
>
>  #include <acpi/cppc_acpi.h>
>
> -/* Minimum struct length needed for the DMI processor entry we want */
> -#define DMI_ENTRY_PROCESSOR_MIN_LENGTH 48
> -
> -/* Offset in the DMI processor structure for the max frequency */
> -#define DMI_PROCESSOR_MAX_SPEED                0x14
> -
>  /*
>   * This list contains information parsed from per CPU ACPI _CPC and _PSD
>   * structures: e.g. the highest and lowest supported performance, capabilities,
> @@ -291,97 +284,9 @@ static inline void cppc_freq_invariance_exit(void)
>  }
>  #endif /* CONFIG_ACPI_CPPC_CPUFREQ_FIE */
>
> -/* Callback function used to retrieve the max frequency from DMI */
> -static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
> -{
> -       const u8 *dmi_data = (const u8 *)dm;
> -       u16 *mhz = (u16 *)private;
> -
> -       if (dm->type == DMI_ENTRY_PROCESSOR &&
> -           dm->length >= DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
> -               u16 val = (u16)get_unaligned((const u16 *)
> -                               (dmi_data + DMI_PROCESSOR_MAX_SPEED));
> -               *mhz = val > *mhz ? val : *mhz;
> -       }
> -}
> -
> -/* Look up the max frequency in DMI */
> -static u64 cppc_get_dmi_max_khz(void)
> -{
> -       u16 mhz = 0;
> -
> -       dmi_walk(cppc_find_dmi_mhz, &mhz);
> -
> -       /*
> -        * Real stupid fallback value, just in case there is no
> -        * actual value set.
> -        */
> -       mhz = mhz ? mhz : 1;
> -
> -       return (1000 * mhz);
> -}
> -
> -/*
> - * If CPPC lowest_freq and nominal_freq registers are exposed then we can
> - * use them to convert perf to freq and vice versa. The conversion is
> - * extrapolated as an affine function passing by the 2 points:
> - *  - (Low perf, Low freq)
> - *  - (Nominal perf, Nominal perf)
> - */
> -static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu_data,
> -                                            unsigned int perf)
> -{
> -       struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> -       s64 retval, offset = 0;
> -       static u64 max_khz;
> -       u64 mul, div;
> -
> -       if (caps->lowest_freq && caps->nominal_freq) {
> -               mul = caps->nominal_freq - caps->lowest_freq;
> -               div = caps->nominal_perf - caps->lowest_perf;
> -               offset = caps->nominal_freq - div64_u64(caps->nominal_perf * mul, div);
> -       } else {
> -               if (!max_khz)
> -                       max_khz = cppc_get_dmi_max_khz();
> -               mul = max_khz;
> -               div = caps->highest_perf;
> -       }
> -
> -       retval = offset + div64_u64(perf * mul, div);
> -       if (retval >= 0)
> -               return retval;
> -       return 0;
> -}
> -
> -static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
> -                                            unsigned int freq)
> -{
> -       struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> -       s64 retval, offset = 0;
> -       static u64 max_khz;
> -       u64  mul, div;
> -
> -       if (caps->lowest_freq && caps->nominal_freq) {
> -               mul = caps->nominal_perf - caps->lowest_perf;
> -               div = caps->nominal_freq - caps->lowest_freq;
> -               offset = caps->nominal_perf - div64_u64(caps->nominal_freq * mul, div);
> -       } else {
> -               if (!max_khz)
> -                       max_khz = cppc_get_dmi_max_khz();
> -               mul = caps->highest_perf;
> -               div = max_khz;
> -       }
> -
> -       retval = offset + div64_u64(freq * mul, div);
> -       if (retval >= 0)
> -               return retval;
> -       return 0;
> -}
> -
>  static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>                                    unsigned int target_freq,
>                                    unsigned int relation)
> -
>  {
>         struct cppc_cpudata *cpu_data = policy->driver_data;
>         unsigned int cpu = policy->cpu;
> @@ -389,7 +294,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>         u32 desired_perf;
>         int ret = 0;
>
> -       desired_perf = cppc_cpufreq_khz_to_perf(cpu_data, target_freq);
> +       desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
>         /* Return if it is exactly the same perf */
>         if (desired_perf == cpu_data->perf_ctrls.desired_perf)
>                 return ret;
> @@ -417,7 +322,7 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>         u32 desired_perf;
>         int ret;
>
> -       desired_perf = cppc_cpufreq_khz_to_perf(cpu_data, target_freq);
> +       desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
>         cpu_data->perf_ctrls.desired_perf = desired_perf;
>         ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>
> @@ -530,7 +435,7 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
>         min_step = min_cap / CPPC_EM_CAP_STEP;
>         max_step = max_cap / CPPC_EM_CAP_STEP;
>
> -       perf_prev = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
> +       perf_prev = cppc_khz_to_perf(perf_caps, *KHz);
>         step = perf_prev / perf_step;
>
>         if (step > max_step)
> @@ -550,8 +455,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
>                         perf = step * perf_step;
>         }
>
> -       *KHz = cppc_cpufreq_perf_to_khz(cpu_data, perf);
> -       perf_check = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
> +       *KHz = cppc_perf_to_khz(perf_caps, perf);
> +       perf_check = cppc_khz_to_perf(perf_caps, *KHz);
>         step_check = perf_check / perf_step;
>
>         /*
> @@ -561,8 +466,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
>          */
>         while ((*KHz == prev_freq) || (step_check != step)) {
>                 perf++;
> -               *KHz = cppc_cpufreq_perf_to_khz(cpu_data, perf);
> -               perf_check = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
> +               *KHz = cppc_perf_to_khz(perf_caps, perf);
> +               perf_check = cppc_khz_to_perf(perf_caps, *KHz);
>                 step_check = perf_check / perf_step;
>         }
>
> @@ -591,7 +496,7 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
>         perf_caps = &cpu_data->perf_caps;
>         max_cap = arch_scale_cpu_capacity(cpu_dev->id);
>
> -       perf_prev = cppc_cpufreq_khz_to_perf(cpu_data, KHz);
> +       perf_prev = cppc_khz_to_perf(perf_caps, KHz);
>         perf_step = CPPC_EM_CAP_STEP * perf_caps->highest_perf / max_cap;
>         step = perf_prev / perf_step;
>
> @@ -679,10 +584,6 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>                 goto free_mask;
>         }
>
> -       /* Convert the lowest and nominal freq from MHz to KHz */
> -       cpu_data->perf_caps.lowest_freq *= 1000;
> -       cpu_data->perf_caps.nominal_freq *= 1000;
> -
>         list_add(&cpu_data->node, &cpu_data_list);
>
>         return cpu_data;
> @@ -724,20 +625,16 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>          * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
>          * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
>          */
> -       policy->min = cppc_cpufreq_perf_to_khz(cpu_data,
> -                                              caps->lowest_nonlinear_perf);
> -       policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
> -                                              caps->nominal_perf);
> +       policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
> +       policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
>
>         /*
>          * Set cpuinfo.min_freq to Lowest to make the full range of performance
>          * available if userspace wants to use any perf between lowest & lowest
>          * nonlinear perf
>          */
> -       policy->cpuinfo.min_freq = cppc_cpufreq_perf_to_khz(cpu_data,
> -                                                           caps->lowest_perf);
> -       policy->cpuinfo.max_freq = cppc_cpufreq_perf_to_khz(cpu_data,
> -                                                           caps->nominal_perf);
> +       policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
> +       policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
>
>         policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
>         policy->shared_type = cpu_data->shared_type;
> @@ -773,7 +670,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>                 boost_supported = true;
>
>         /* Set policy->cur to max now. The governors will adjust later. */
> -       policy->cur = cppc_cpufreq_perf_to_khz(cpu_data, caps->highest_perf);
> +       policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>         cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>
>         ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> @@ -863,7 +760,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>         delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>                                                &fb_ctrs_t1);
>
> -       return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
> +       return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
>  }
>
>  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> @@ -878,11 +775,9 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>         }
>
>         if (state)
> -               policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
> -                                                      caps->highest_perf);
> +               policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
>         else
> -               policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
> -                                                      caps->nominal_perf);
> +               policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
>         policy->cpuinfo.max_freq = policy->max;
>
>         ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> @@ -937,7 +832,7 @@ static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
>         if (ret < 0)
>                 return -EIO;
>
> -       return cppc_cpufreq_perf_to_khz(cpu_data, desired_perf);
> +       return cppc_perf_to_khz(&cpu_data->perf_caps, desired_perf);
>  }
>
>  static void cppc_check_hisi_workaround(void)
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 6126c977ece0..3a0995f8bce8 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -144,6 +144,8 @@ extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_set_enable(int cpu, bool enable);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
>  extern bool cppc_perf_ctrs_in_pcc(void);
> +extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf);
> +extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq);
>  extern bool acpi_cpc_valid(void);
>  extern bool cppc_allow_fast_switch(void);
>  extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
> --
> 2.34.1
>
