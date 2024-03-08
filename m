Return-Path: <linux-kernel+bounces-97456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6399A876ABE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181A7282E6B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8F65788F;
	Fri,  8 Mar 2024 18:27:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA5954792;
	Fri,  8 Mar 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922425; cv=none; b=AJ/i/3FJKGi5IKuAM78dth3RfZeO+i+e/mYJYV/889VvOXQZJGOZCuUTQbYnGucuYsjDjjGaADIHgGZRtMfO7stXyehkbmXFnD3UQTfRlB9CKGXch77PrsbvIBoSDw0evqhXrdAOKdTH5nFjqUifUhCs8/eFQy2FIKV1rhTdwbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922425; c=relaxed/simple;
	bh=s5b1azrAudYZ5DSM3rTJNg53hbvc+UesOYbnPqfEu7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPN6/vNKFico7pKc1M9Yn3EQCnBmSa8D3uRoIT1mJKDg0k+pTss3d/vXYz3fCcqhRE2UXA4TKUk+GV8U5aYY8URnyJb3YR+WvK+0lEs7VmjenOaMS5ARJ+KinMy6svDDx0smjZqJ65+nlHzq13ZhZyYFd1MqzPwjnbSqWlLHx5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A80CC15;
	Fri,  8 Mar 2024 10:27:38 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59A9A3F738;
	Fri,  8 Mar 2024 10:26:58 -0800 (PST)
Message-ID: <26f23ba4-4ca5-41f6-b920-08515f494ae5@arm.com>
Date: Fri, 8 Mar 2024 18:26:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] x86/resctrl: Pass domain to target CPU
Content-Language: en-GB
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Babu Moger <babu.moger@amd.com>,
 Randy Dunlap <rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 patches@lists.linux.dev
References: <20240228112215.8044-tony.luck@intel.com>
 <20240228193717.8170-1-tony.luck@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <20240228193717.8170-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tony,

On 28/02/2024 19:36, Tony Luck wrote:
> reset_all_ctrls() and resctrl_arch_update_domains() use on_each_cpu_mask()
> to call rdt_ctrl_update() on potentially one CPU from each domain.
> 
> But this means rdt_ctrl_update() needs to figure out which domain to
> apply changes to. Doing so requires a search of all domains in a resource,
> which can only be done safely if cpus_lock is held. Both callers do hold
> this lock, but there isn't a way for a function called on another CPU
> via IPI to verify this.
> 
> Commit c0d848fcb09d ("x86/resctrl: Remove lockdep annotation that triggers
> false positive") removed the incorrect assertions.
> 
> Add the target domain to the msr_param structure and
> call rdt_ctrl_update() for each domain separately using
> smp_call_function_single(). This means that rdt_ctrl_update() doesn't
> need to search for the domain and get_domain_from_cpu() can safely assert
> that the cpus_lock is held since the remaining callers do not use IPI.

> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 83e40341583e..acf52aa185e0 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -362,6 +362,8 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
>  {
>  	struct rdt_domain *d;
>  
> +	lockdep_assert_cpus_held();


(Huzzah!)


>  	list_for_each_entry(d, &r->domains, list) {
>  		/* Find the domain that contains this CPU */
>  		if (cpumask_test_cpu(cpu, &d->cpu_mask))

> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 7997b47743a2..a3a0fd80daa8 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -315,27 +300,27 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)

[..]

> -	msr_param.res = NULL;
>  	list_for_each_entry(d, &r->domains, list) {
>  		hw_dom = resctrl_to_arch_dom(d);
> +		msr_param.res = NULL;
> +		msr_param.dom = d;
>  		for (t = 0; t < CDP_NUM_TYPES; t++) {
>  			cfg = &hw_dom->d_resctrl.staged_config[t];
>  			if (!cfg->have_new_ctrl)
>  				continue;
>  
>  			idx = get_config_index(closid, t);
> -			if (!apply_config(hw_dom, cfg, idx, cpu_mask))
> +			if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
>  				continue;
> +			hw_dom->ctrl_val[idx] = cfg->new_ctrl;
> +			cpu = cpumask_any(&d->cpu_mask);

If this CPU is part of the domain, then cpumask_any() could chose a different CPU leading
to an IPI, where this CPU could have done the work itself.
smp_call_function_any() has the logic to try and run on this CPU if possible.

As d->cpu_mask is still valid when you call smp_call_function_single(), could we use
smp_call_function_any() instead?


>  			if (!msr_param.res) {
>  				msr_param.low = idx;
> @@ -346,17 +331,10 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>  				msr_param.high = max(msr_param.high, idx + 1);
>  			}
>  		}
> +		if (msr_param.res)
> +			smp_call_function_single(cpu, rdt_ctrl_update, &msr_param, 1);
>  	}

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 011e17efb1a6..da4f13db4161 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2813,16 +2813,13 @@ static int reset_all_ctrls(struct rdt_resource *r)
> @@ -2834,17 +2831,14 @@ static int reset_all_ctrls(struct rdt_resource *r)
>  	 */
>  	list_for_each_entry(d, &r->domains, list) {
>  		hw_dom = resctrl_to_arch_dom(d);
> -		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
> +		cpu = cpumask_any(&d->cpu_mask);

Same comment about picking an unlucky CPU here, smp_call_function_any() can improve our
chances.


>  		for (i = 0; i < hw_res->num_closid; i++)
>  			hw_dom->ctrl_val[i] = r->default_ctrl;
> +		msr_param.dom = d;
> +		smp_call_function_single(cpu, rdt_ctrl_update, &msr_param, 1);
>  	}

Still:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks!

James


