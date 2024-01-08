Return-Path: <linux-kernel+bounces-19852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F42F827553
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4449C1C229B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D4D53E13;
	Mon,  8 Jan 2024 16:35:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBAE54664;
	Mon,  8 Jan 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C484FEC;
	Mon,  8 Jan 2024 08:36:02 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9D683F64C;
	Mon,  8 Jan 2024 08:35:10 -0800 (PST)
Message-ID: <158a8c60-cb54-43c1-8232-6a0a46cc6d42@arm.com>
Date: Mon, 8 Jan 2024 17:35:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] cpufreq: Add a cpufreq pressure feedback for the
 scheduler
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
 rafael@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, lukasz.luba@arm.com, rui.zhang@intel.com,
 mhiramat@kernel.org, daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
 corbet@lwn.net, gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: qyousef@layalina.io
References: <20240108134843.429769-1-vincent.guittot@linaro.org>
 <20240108134843.429769-2-vincent.guittot@linaro.org>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240108134843.429769-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/01/2024 14:48, Vincent Guittot wrote:
> Provide to the scheduler a feedback about the temporary max available
> capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> filtered as the pressure will happen for dozens ms or more.

Is this then related to the 'medium pace system pressure' you mentioned
in your OSPM '23 talk?

> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   | 10 ++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44db4f59c4cc..fa2e2ea26f7f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2563,6 +2563,40 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
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
> +	unsigned long max_capacity, capped_freq, pressure;
> +	u32 max_freq;
> +	int cpu;
> +
> +	/*
> +	 * Handle properly the boost frequencies, which should simply clean
> +	 * the thermal pressure value.
               ^^^^^^^
IMHO, this is a copy & paste error from topology_update_thermal_pressure()?

> +	 */
> +	if (max_freq <= capped_freq) {

max_freq seems to be uninitialized.

> +		pressure = 0;

Is this x86 (turbo boost) specific? IMHO at arm we follow this max freq
(including boost) relates to 1024 in capacity? Or haven't we made this
discussion yet?

> +	} else {
> +		cpu = cpumask_first(policy->related_cpus);
> +		max_capacity = arch_scale_cpu_capacity(cpu);
> +		capped_freq = policy->max;
> +		max_freq = arch_scale_freq_ref(cpu);
> +
> +		pressure = max_capacity -
> +			   mult_frac(max_capacity, capped_freq, max_freq);
> +	}
> +
> +	for_each_cpu(cpu, policy->related_cpus)
> +		WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
> +}
> +

[...]


