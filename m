Return-Path: <linux-kernel+bounces-9015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D5681BF48
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D361F248F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A8074087;
	Thu, 21 Dec 2023 19:57:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E11651AC;
	Thu, 21 Dec 2023 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dbb09061c0so208162a34.0;
        Thu, 21 Dec 2023 11:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703188639; x=1703793439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQyApPo3WHA9WK0JdlyYLGUay3XOd+TgnZOYmPZErh0=;
        b=a+iMOe38goYXZ63lHpP7KGSSeWa+dZ+BKeZ4QjJKDI06F5Bc6CUhGWNkkMZQ6vuDIx
         joOkYtyiP5wCRrHfycUxndLLxEzuMkIHakh50VhDzwrv4S1t91sWQXtTGyDgr+WQ1fE0
         w0wDG47UxqGMf62SyWp4eMQG0/KZWUVH6RcnZmTtWCFbSUgBKvPjeTDzti1khjd3rqQu
         cGCulBA7+j88QdZ0hSP0j2VjE0UHVoeTj000Av3HbDwvCuez7Qya+FY8BPtdbNlIbgh6
         gg6TER5Z5W7SaBLvt1kwWkRYeS6ADQ0qj8IoiGp5/95PG4gt9L2GkcFMR1XtOuF3iUGL
         MKZw==
X-Gm-Message-State: AOJu0Yw5fUG5Wj0ZSHWyOup1i4mTZdkaooHmZA6VvGvMn6hcqDsNSmGu
	E0wA6VCqqgp155FZr9EWm3fEE3CnWsLTuZ9IKRi6CyRM
X-Google-Smtp-Source: AGHT+IFbxgKuMTLxtgCb3LuZNckAkALMWFlfsK4xQp5rtqhYaPIWoMdg0+HnI3vNWFl4+2ln5EgM4TTRuzXaEWTxwKI=
X-Received: by 2002:a4a:dcd1:0:b0:591:4861:6b02 with SMTP id
 h17-20020a4adcd1000000b0059148616b02mr334797oou.1.1703188639115; Thu, 21 Dec
 2023 11:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221152407.436177-1-vincent.guittot@linaro.org> <20231221152407.436177-2-vincent.guittot@linaro.org>
In-Reply-To: <20231221152407.436177-2-vincent.guittot@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Dec 2023 20:57:08 +0100
Message-ID: <CAJZ5v0iU+nx_Tk_K74=dfeOuA7Lyvbq51UW=U1L4mZVEKy-+ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] cpufreq: Add a cpufreq pressure feedback for the scheduler
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com, 
	rafael@kernel.org, viresh.kumar@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, lukasz.luba@arm.com, rui.zhang@intel.com, 
	mhiramat@kernel.org, daniel.lezcano@linaro.org, amit.kachhap@gmail.com, 
	linux@armlinux.org.uk, corbet@lwn.net, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 4:24=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Provide to the scheduler a feedback about the temporary max available
> capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> filtered as the pressure will happen for dozens ms or more.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   | 10 ++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44db4f59c4cc..15bd41f9bb5e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2563,6 +2563,38 @@ int cpufreq_get_policy(struct cpufreq_policy *poli=
cy, unsigned int cpu)
>  }
>  EXPORT_SYMBOL(cpufreq_get_policy);
>
> +DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
> +
> +/**
> + * cpufreq_update_pressure() - Update cpufreq pressure for CPUs
> + * @policy: cpufreq policy of the CPUs.
> + *
> + * Update the value of cpufreq pressure for all @cpus in the policy.
> + */
> +static void cpufreq_update_pressure(struct cpufreq_policy *policy)
> +{
> +       unsigned long max_capacity, capped_freq, pressure;
> +       u32 max_freq;
> +       int cpu;
> +
> +       cpu =3D cpumask_first(policy->related_cpus);
> +       pressure =3D max_capacity =3D arch_scale_cpu_capacity(cpu);

I would prefer two separate statements instead of the above.

Other than this

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> +       capped_freq =3D policy->max;
> +       max_freq =3D arch_scale_freq_ref(cpu);
> +
> +       /*
> +        * Handle properly the boost frequencies, which should simply cle=
an
> +        * the thermal pressure value.
> +        */
> +       if (max_freq <=3D capped_freq)
> +               pressure -=3D max_capacity;
> +       else
> +               pressure -=3D mult_frac(max_capacity, capped_freq, max_fr=
eq);
> +
> +       for_each_cpu(cpu, policy->related_cpus)
> +               WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
> +}
> +
>  /**
>   * cpufreq_set_policy - Modify cpufreq policy parameters.
>   * @policy: Policy object to modify.
> @@ -2618,6 +2650,8 @@ static int cpufreq_set_policy(struct cpufreq_policy=
 *policy,
>         policy->max =3D __resolve_freq(policy, policy->max, CPUFREQ_RELAT=
ION_H);
>         trace_cpu_frequency_limits(policy);
>
> +       cpufreq_update_pressure(policy);
> +
>         policy->cached_target_freq =3D UINT_MAX;
>
>         pr_debug("new min and max freqs are %u - %u kHz\n",
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index afda5f24d3dd..b1d97edd3253 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -241,6 +241,12 @@ struct kobject *get_governor_parent_kobj(struct cpuf=
req_policy *policy);
>  void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
>  void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
>  bool has_target_index(void);
> +
> +DECLARE_PER_CPU(unsigned long, cpufreq_pressure);
> +static inline unsigned long cpufreq_get_pressure(int cpu)
> +{
> +       return per_cpu(cpufreq_pressure, cpu);
> +}
>  #else
>  static inline unsigned int cpufreq_get(unsigned int cpu)
>  {
> @@ -263,6 +269,10 @@ static inline bool cpufreq_supports_freq_invariance(=
void)
>         return false;
>  }
>  static inline void disable_cpufreq(void) { }
> +static inline unsigned long cpufreq_get_pressure(int cpu)
> +{
> +       return 0;
> +}
>  #endif
>
>  #ifdef CONFIG_CPU_FREQ_STAT
> --
> 2.34.1
>

