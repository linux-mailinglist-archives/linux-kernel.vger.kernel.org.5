Return-Path: <linux-kernel+bounces-28937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12848304E1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675341F253EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE7A1DFDF;
	Wed, 17 Jan 2024 12:05:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2834B1DFCF;
	Wed, 17 Jan 2024 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493118; cv=none; b=SnvHFmRKKPA/Ts50acE4GG7jqeekMNRYlaovd9pfFB73XQ4CaeBBxSEFxtFFo2oqmPRSjsMRPkfwhqGhpnBAT4gNW2MQ2Qs+bTBZpOsYR0r0zPUQx9cT7kSMslakLevIFiQ/SMzFzv787i78erCab+wyQ0YS9DL6BIl9DL9oxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493118; c=relaxed/simple;
	bh=Pmn8h/pdCxhnofqxr02aGCsKkLxC0a+7EXzpM4wIoQE=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=X1dYT4wKXj6XRF03E3IA0dpGuh0lV0GNfi/cIYX6wfFIjgT84g+RjvCKyoaHfcKAhPS2k321VzH1FNcnVL+rGzcqpM+5PEEbHw7IH11rOoL/68PePXA9P6AIsU2RsiCoTXtQmnwoDTue7BMeun6ygfoaENuz9JP92zAXCgwP/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6607911FB;
	Wed, 17 Jan 2024 04:06:01 -0800 (PST)
Received: from [10.57.78.6] (unknown [10.57.78.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EAD43F766;
	Wed, 17 Jan 2024 04:05:13 -0800 (PST)
Message-ID: <aaaa5a18-cef8-4de5-b45b-ab189e3ad228@arm.com>
Date: Wed, 17 Jan 2024 12:05:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/23] PM: EM: Find first CPU active while updating OPP
 efficiency
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 xuewen.yan94@gmail.com
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
 <20240117095714.1524808-4-lukasz.luba@arm.com>
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240117095714.1524808-4-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2024 09:56, Lukasz Luba wrote:
> The Energy Model might be updated at runtime and the energy efficiency
> for each OPP may change. Thus, there is a need to update also the
> cpufreq framework and make it aligned to the new values. In order to
> do that, use a first active CPU from the Performance Domain. This is
> needed since the first CPU in the cpumask might be offline when we
> run this code path.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   kernel/power/energy_model.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 42486674b834..aa7c89f9e115 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -243,12 +243,19 @@ em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
>   	struct em_perf_domain *pd = dev->em_pd;
>   	struct cpufreq_policy *policy;
>   	int found = 0;
> -	int i;
> +	int i, cpu;
>   
>   	if (!_is_cpu_device(dev) || !pd)
>   		return;
>   
> -	policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
> +	/* Try to get a CPU which is active and in this PD */
> +	cpu = cpumask_first_and(em_span_cpus(pd), cpu_active_mask);
> +	if (cpu >= nr_cpu_ids) {
> +		dev_warn(dev, "EM: No online CPU for CPUFreq policy\n");
> +		return;
> +	}
> +
> +	policy = cpufreq_cpu_get(cpu);
>   	if (!policy) {
>   		dev_warn(dev, "EM: Access to CPUFreq policy failed\n");
>   		return;

Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>

