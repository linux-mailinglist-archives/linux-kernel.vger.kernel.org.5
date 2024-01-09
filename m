Return-Path: <linux-kernel+bounces-21132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6ED828A6E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862BCB22369
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C7A3A8EA;
	Tue,  9 Jan 2024 16:49:56 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CBF38DFE;
	Tue,  9 Jan 2024 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5958b9cda7aso104906eaf.0;
        Tue, 09 Jan 2024 08:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704818993; x=1705423793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=No8KMU8qZ/MBPmmYQ2D3vNYLw4T9zvu4iu2lUnnwn8g=;
        b=B04inhgZA6LJiRY9ci3vYBs7VaBMmrXH8K3nEX7hbYQEOT2BIgbqNsiQceEeLj+IeG
         7Vo+4HSQQaQHlZy0CRcsFEK0h8Z2QM6oXGcZkOCyY5HRBBnLxxLAsesdwYysmxZrs+YT
         qWd06F4XHQLRHLNVSzFaaFJ6UgwOKqBsV9mFp7U1HNGiVG8pNxY3fFsXDU3EqU2iqJAb
         m6+3NbEiPFwOMy2n8uFNZpiLYmcEjx3uoCrbyG4Bp/8ShSq7iWU3/FVlCsMvVD+KXl6c
         gMMspuk9TyjbQgmPjAW5FGr/65DBRI3/GEOzUY4stZloOatldxL4YHY6SGl4EUWYfgfV
         Xhpg==
X-Gm-Message-State: AOJu0Yz6YhBFySeLAn10QHTjv9c1SlGILJuKMGuh/wkYg4P0k2eBkH8N
	3h5OcABRITMyxYJGpfkhxCs7rT2ieiTBxEbh7Qw=
X-Google-Smtp-Source: AGHT+IG3BVad80XxuD9TpPjaf5THqmwVW6ufT7pdCFhKkFasMPugtZYNRedyhvTcfTGxohP1l8YdxUf3QX57jacTy58=
X-Received: by 2002:a05:6820:d0a:b0:598:8d98:286d with SMTP id
 ej10-20020a0568200d0a00b005988d98286dmr818427oob.0.1704818993639; Tue, 09 Jan
 2024 08:49:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109164655.626085-1-vincent.guittot@linaro.org> <20240109164655.626085-2-vincent.guittot@linaro.org>
In-Reply-To: <20240109164655.626085-2-vincent.guittot@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jan 2024 17:49:42 +0100
Message-ID: <CAJZ5v0ixmEiOhwBHkDqH8QNtchiszAEi0rY2pDCGHXiWHob0NA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] cpufreq: Add a cpufreq pressure feedback for the scheduler
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org, 
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, lukasz.luba@arm.com, 
	rui.zhang@intel.com, mhiramat@kernel.org, daniel.lezcano@linaro.org, 
	amit.kachhap@gmail.com, corbet@lwn.net, gregkh@linuxfoundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 5:47=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Provide to the scheduler a feedback about the temporary max available
> capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> filtered as the pressure will happen for dozens ms or more.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

and I think I've given the tag on this patch already.

> ---
>  drivers/cpufreq/cpufreq.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   | 10 ++++++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44db4f59c4cc..f4eee3d107f1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2563,6 +2563,40 @@ int cpufreq_get_policy(struct cpufreq_policy *poli=
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
> +       max_freq =3D arch_scale_freq_ref(cpu);
> +       capped_freq =3D policy->max;
> +
> +       /*
> +        * Handle properly the boost frequencies, which should simply cle=
an
> +        * the cpufreq pressure value.
> +        */
> +       if (max_freq <=3D capped_freq) {
> +               pressure =3D 0;
> +       } else {
> +               max_capacity =3D arch_scale_cpu_capacity(cpu);
> +               pressure =3D max_capacity -
> +                          mult_frac(max_capacity, capped_freq, max_freq)=
;
> +       }
> +
> +       for_each_cpu(cpu, policy->related_cpus)
> +               WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
> +}
> +
>  /**
>   * cpufreq_set_policy - Modify cpufreq policy parameters.
>   * @policy: Policy object to modify.
> @@ -2618,6 +2652,8 @@ static int cpufreq_set_policy(struct cpufreq_policy=
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

