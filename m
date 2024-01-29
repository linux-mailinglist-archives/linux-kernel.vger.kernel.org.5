Return-Path: <linux-kernel+bounces-43292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4118411D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEB51C22167
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18366F06C;
	Mon, 29 Jan 2024 18:14:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389523F9E0;
	Mon, 29 Jan 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552043; cv=none; b=CM1emZ1Zyq8LfPrlCtzwbrXJWcZeRx1jFENDUrf+iRGbt0vZyU+y+K8JA3XU3a86nc0DJ/rhfEUBwFA+h8IVbWgKikxjgXCwcqD4x1OGimX6NUDcgrAk43XSeH0xITswaQaUO1ATiRPW8WOJ1t8wR3SuJcD922lPQpVb/b/1stQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552043; c=relaxed/simple;
	bh=cJiIMyH6ByLjeu1fDCTdotCd+B6NSDemcnSR3KKmT8M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bucGZDhzBZllJ13fUF02MNocu5MylMMIVCFxeu9LbcmGzA7mwuf+I+qiJ2l8/U3yQiFFUpF5O8mZyUdHkK5E7IPvOLqLDq42Vrhp5b4C74rkPEQt4CFfDBwRbhdmlc3Je6NfV85UvMX6aRPv3BN1MBfC2QWVuk9UdAUg0XCkvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 511AADA7;
	Mon, 29 Jan 2024 10:14:44 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 945F03F738;
	Mon, 29 Jan 2024 10:13:57 -0800 (PST)
Message-ID: <ba1e8112-c82e-458d-b7f7-9a308295d260@arm.com>
Date: Mon, 29 Jan 2024 19:13:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v7 13/23] PM: EM: Add performance field to struct
 em_perf_state and optimize
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 xuewen.yan94@gmail.com
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
 <20240117095714.1524808-14-lukasz.luba@arm.com>
Content-Language: en-US
In-Reply-To: <20240117095714.1524808-14-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 09:57, Lukasz Luba wrote:

[...]

>  include/linux/energy_model.h | 24 ++++++++++++------------
>  kernel/power/energy_model.c  | 27 +++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 5ebe9dbec8e1..689d71f6b56f 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -13,6 +13,7 @@
>  
>  /**
>   * struct em_perf_state - Performance state of a performance domain
> + * @performance:	CPU performance (capacity) at a given frequency

I guess this is what we called the 'current CPU capacity' in older
Android versions.

[...]

> @@ -260,26 +262,24 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  	/*
>  	 * In order to predict the performance state, map the utilization of
>  	 * the most utilized CPU of the performance domain to a requested 
> -	 * frequency, like schedutil. Take also into account that the real
> -	 * frequency might be set lower (due to thermal capping). Thus, clamp
> +	 * performance, like schedutil. Take also into account that the real
> +	 * performance might be set lower (due to thermal capping). Thus, clamp
>  	 * max utilization to the allowed CPU capacity before calculating
> -	 * effective frequency.
> +	 * effective performance.
>  	 */
>  	cpu = cpumask_first(to_cpumask(pd->cpus));
>  	scale_cpu = arch_scale_cpu_capacity(cpu);
> -	ref_freq = arch_scale_freq_ref(cpu);
>  
>  	max_util = map_util_perf(max_util);

Didn't apply cleanly on tip sched/code for me.

Looks like it's missing:

9c0b4bb7f630 - sched/cpufreq: Rework schedutil governor performance
estimation (2023-11-23 Vincent Guittot)

>  	max_util = min(max_util, allowed_cpu_cap);
> -	freq = map_util_freq(max_util, ref_freq, scale_cpu);

Since you're removing this here, shouldn't you also remove

* In order to predict the performance state, map the utilization of
* the most utilized CPU of the performance domain to a requested

Looks like with 9c0b4bb7f630 there is no mapping anymore?

[...]

>  static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>  			    struct em_data_callback *cb, int nr_states,
>  			    unsigned long flags)
> @@ -318,6 +343,8 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  		table[i].frequency = prev_freq = freq;
>  	}
>  
> +	em_init_performance(dev, pd, table, nr_states);

Looks like pd already has 'pd->nr_perf_states' initialized. so just
passing pd seems to be sufficient. Like for em_table_alloc() and
em_create_perf_table().

[...]

