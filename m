Return-Path: <linux-kernel+bounces-26460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9D882E13F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C481F22D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A5319470;
	Mon, 15 Jan 2024 20:06:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC34418E2A;
	Mon, 15 Jan 2024 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6BC02F4;
	Mon, 15 Jan 2024 12:06:52 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AA713F73F;
	Mon, 15 Jan 2024 12:06:03 -0800 (PST)
Message-ID: <781c567a-5af1-414e-844f-7312dd8b70ff@arm.com>
Date: Mon, 15 Jan 2024 21:06:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix frequency selection for non invariant
 case
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, wkarny@gmail.com, torvalds@linux-foundation.org,
 qyousef@layalina.io, tglx@linutronix.de, rafael@kernel.org,
 viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240114183600.135316-1-vincent.guittot@linaro.org>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240114183600.135316-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/01/2024 19:36, Vincent Guittot wrote:
> When frequency invariance is not enabled, get_capacity_ref_freq(policy)
> returns the current frequency and the performance margin applied by
> map_util_perf(), enabled the utilization to go above the maximum compute
> capacity and to select a higher frequency than the current one.
> 
> The performance margin is now applied earlier in the path to take into
> account some utilization clampings and we can't get an utilization higher
> than the maximum compute capacity.
> 
> We must use a frequency above the current frequency to get a chance to
> select a higher OPP when the current one becomes fully used. Apply
> the same margin and returns a frequency 25% higher than the current one in
> order to switch to the next OPP before we fully use the cpu at the current
> one.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Closes: https://lore.kernel.org/lkml/CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com/
> Reported-by: Wyes Karny <wkarny@gmail.com>
> Closes: https://lore.kernel.org/lkml/20240114091240.xzdvqk75ifgfj5yx@wyes-pc/
> Fixes: 9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: Wyes Karny <wkarny@gmail.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 95c3c097083e..d12e95d30e2e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -133,7 +133,11 @@ unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
>  	if (arch_scale_freq_invariant())
>  		return policy->cpuinfo.max_freq;
>  
> -	return policy->cur;
> +	/*
> +	 * Apply a 25% margin so that we select a higher frequency than
> +	 * the current one before the CPU is full busy
> +	 */
> +	return policy->cur + (policy->cur >> 2);
>  }
>  
>  /**

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

(on Intel Xeon CPU E5-2690 v2 with frequency invariance disabled)

