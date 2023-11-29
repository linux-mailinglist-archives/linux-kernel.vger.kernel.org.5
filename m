Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A747FDD75
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjK2QmN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 11:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjK2QmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:42:11 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52ECA8;
        Wed, 29 Nov 2023 08:42:16 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6d815062598so2535a34.0;
        Wed, 29 Nov 2023 08:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701276136; x=1701880936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5kT24XoL9AcqmNQ3sMUkwK1uUxYMSl+VGTViMsnVOU=;
        b=FuiY10wMfiZl29tseLBvMcuDaC61JC4R9xIFImx7VUjGFUi6S1elKihnWLVq+Lqp/e
         BNchzmI0MzuNS5KxjVsztePSoPT9TyJM+Q6BLCiyVA1pY/uaytgWMeYT4FZ8mHMlUMAe
         kgdYLqlkGpsFd3a6jZJzODaqVe8GrI0av1O8Ptp/jELVdVBdv0fbmzFVg1A38X3Hntgj
         wOGBF1Apt3GfPdOzp8rVgJUht4HdTw2Hdf5piO2uwXIux+KoIM3rIxNQXqzIGABolbpo
         RpgX0O3ij3bYiG8RLog1N45YOOioqxqu1zxh86LKwASQUbXBlfwRSJRB2q14VkBvrOqX
         1eLw==
X-Gm-Message-State: AOJu0YzZx43TkshHTfahEN8JbeMO6CIDJraSAIQBU0DSpXy+C24fuiO1
        NzPlUQfjP+CAk0TdgrvC1Tk4JDPMQ+3ASCSKObA=
X-Google-Smtp-Source: AGHT+IFiBrxfEJDXSB4leLTaPctaykM6TLdA8N7tYcpl+NToxTP/8Jpu+FHPe5hshOn7lWovTKg2Dk3f42bagZoWw1g=
X-Received: by 2002:a4a:eb86:0:b0:58d:5302:5b18 with SMTP id
 d6-20020a4aeb86000000b0058d53025b18mr14706916ooj.1.1701276135794; Wed, 29 Nov
 2023 08:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20231117063839.17465-1-wyes.karny@amd.com>
In-Reply-To: <20231117063839.17465-1-wyes.karny@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Nov 2023 17:42:04 +0100
Message-ID: <CAJZ5v0jNSoL0ke1eT9PDQKqJ0qkVNsowaU5mrgGj2seSL654aA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Fix scaling_min_freq and
 scaling_max_freq update
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     rafael@kernel.org, ray.huang@amd.com, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.yuan@amd.com
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

On Fri, Nov 17, 2023 at 7:39 AM Wyes Karny <wyes.karny@amd.com> wrote:
>
> When amd_pstate is running, writing to scaling_min_freq and
> scaling_max_freq has no effect. These values are only passed to the
> policy level, but not to the platform level. This means that the
> platform does not know about the frequency limits set by the user. To
> fix this, update the min_perf and max_perf values at the platform level
> whenever the user changes the scaling_min_freq and scaling_max_freq
> values.
>
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> Acked-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
> Changelog:
> v1 -> v2:
> - Rebase
> - Pick up ack from Ray
> - Add fixes tag
>
>  drivers/cpufreq/amd-pstate.c | 60 ++++++++++++++++++++++++++++--------
>  include/linux/amd-pstate.h   |  4 +++
>  2 files changed, 51 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..4839cdd2715e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -307,11 +307,11 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
>                 highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
>
>         WRITE_ONCE(cpudata->highest_perf, highest_perf);
> -
> +       WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
>         WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
>         WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
>         WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
> -
> +       WRITE_ONCE(cpudata->min_limit_perf, AMD_CPPC_LOWEST_PERF(cap1));
>         return 0;
>  }
>
> @@ -329,11 +329,12 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
>                 highest_perf = cppc_perf.highest_perf;
>
>         WRITE_ONCE(cpudata->highest_perf, highest_perf);
> -
> +       WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
>         WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>         WRITE_ONCE(cpudata->lowest_nonlinear_perf,
>                    cppc_perf.lowest_nonlinear_perf);
>         WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> +       WRITE_ONCE(cpudata->min_limit_perf, cppc_perf.lowest_perf);
>
>         if (cppc_state == AMD_PSTATE_ACTIVE)
>                 return 0;
> @@ -432,6 +433,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>         u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>         u64 value = prev;
>
> +       min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
> +                       cpudata->max_limit_perf);
> +       max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
> +                       cpudata->max_limit_perf);
>         des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>
>         if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
> @@ -470,6 +475,22 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
>         return 0;
>  }
>
> +static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
> +{
> +       u32 max_limit_perf, min_limit_perf;
> +       struct amd_cpudata *cpudata = policy->driver_data;
> +
> +       max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
> +       min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
> +
> +       WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
> +       WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
> +       WRITE_ONCE(cpudata->max_limit_freq, policy->max);
> +       WRITE_ONCE(cpudata->min_limit_freq, policy->min);
> +
> +       return 0;
> +}
> +
>  static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>                                   unsigned int target_freq, bool fast_switch)
>  {
> @@ -480,6 +501,9 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>         if (!cpudata->max_freq)
>                 return -ENODEV;
>
> +       if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
> +               amd_pstate_update_min_max_limit(policy);
> +
>         cap_perf = READ_ONCE(cpudata->highest_perf);
>         min_perf = READ_ONCE(cpudata->lowest_perf);
>         max_perf = cap_perf;
> @@ -532,6 +556,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>         struct amd_cpudata *cpudata = policy->driver_data;
>         unsigned int target_freq;
>
> +       if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
> +               amd_pstate_update_min_max_limit(policy);
> +
> +
>         cap_perf = READ_ONCE(cpudata->highest_perf);
>         lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
>         max_freq = READ_ONCE(cpudata->max_freq);
> @@ -745,6 +773,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>         /* Initial processor data capability frequencies */
>         cpudata->max_freq = max_freq;
>         cpudata->min_freq = min_freq;
> +       cpudata->max_limit_freq = max_freq;
> +       cpudata->min_limit_freq = min_freq;
>         cpudata->nominal_freq = nominal_freq;
>         cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
>
> @@ -1183,16 +1213,25 @@ static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>         return 0;
>  }
>
> -static void amd_pstate_epp_init(unsigned int cpu)
> +static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  {
> -       struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>         struct amd_cpudata *cpudata = policy->driver_data;
> -       u32 max_perf, min_perf;
> +       u32 max_perf, min_perf, min_limit_perf, max_limit_perf;
>         u64 value;
>         s16 epp;
>
>         max_perf = READ_ONCE(cpudata->highest_perf);
>         min_perf = READ_ONCE(cpudata->lowest_perf);
> +       max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
> +       min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
> +
> +       max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
> +                       cpudata->max_limit_perf);
> +       min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
> +                       cpudata->max_limit_perf);
> +
> +       WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
> +       WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
>
>         value = READ_ONCE(cpudata->cppc_req_cached);
>
> @@ -1210,9 +1249,6 @@ static void amd_pstate_epp_init(unsigned int cpu)
>         value &= ~AMD_CPPC_DES_PERF(~0L);
>         value |= AMD_CPPC_DES_PERF(0);
>
> -       if (cpudata->epp_policy == cpudata->policy)
> -               goto skip_epp;
> -
>         cpudata->epp_policy = cpudata->policy;
>
>         /* Get BIOS pre-defined epp value */
> @@ -1222,7 +1258,7 @@ static void amd_pstate_epp_init(unsigned int cpu)
>                  * This return value can only be negative for shared_memory
>                  * systems where EPP register read/write not supported.
>                  */
> -               goto skip_epp;
> +               return;
>         }
>
>         if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> @@ -1236,8 +1272,6 @@ static void amd_pstate_epp_init(unsigned int cpu)
>
>         WRITE_ONCE(cpudata->cppc_req_cached, value);
>         amd_pstate_set_epp(cpudata, epp);
> -skip_epp:
> -       cpufreq_cpu_put(policy);
>  }
>
>  static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
> @@ -1252,7 +1286,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>
>         cpudata->policy = policy->policy;
>
> -       amd_pstate_epp_init(policy->cpu);
> +       amd_pstate_epp_update_limit(policy);
>
>         return 0;
>  }
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 446394f84606..6ad02ad9c7b4 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -70,6 +70,10 @@ struct amd_cpudata {
>         u32     nominal_perf;
>         u32     lowest_nonlinear_perf;
>         u32     lowest_perf;
> +       u32     min_limit_perf;
> +       u32     max_limit_perf;
> +       u32     min_limit_freq;
> +       u32     max_limit_freq;
>
>         u32     max_freq;
>         u32     min_freq;
> --

Applied as 6.7-rc material, thanks!
