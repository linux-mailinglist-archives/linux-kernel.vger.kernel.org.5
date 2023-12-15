Return-Path: <linux-kernel+bounces-1220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B58F814BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA071C234D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C6C37179;
	Fri, 15 Dec 2023 15:37:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFD036AFF;
	Fri, 15 Dec 2023 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B94FEC15;
	Fri, 15 Dec 2023 07:38:32 -0800 (PST)
Received: from [10.57.85.151] (unknown [10.57.85.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D6883F5A1;
	Fri, 15 Dec 2023 07:37:43 -0800 (PST)
Message-ID: <e034144d-fff6-490f-889f-1114a2f779c6@arm.com>
Date: Fri, 15 Dec 2023 15:38:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] thermal/cpufreq: Remove
 arch_update_thermal_pressure()
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-4-vincent.guittot@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
 mhiramat@kernel.org, rui.zhang@intel.com,
 linux-trace-kernel@vger.kernel.org, vschneid@redhat.com, bristot@redhat.com,
 mgorman@suse.de, bsegall@google.com, rostedt@goodmis.org,
 dietmar.eggemann@arm.com, juri.lelli@redhat.com, peterz@infradead.org,
 mingo@redhat.com, konrad.dybcio@linaro.org, andersson@kernel.org,
 agross@kernel.org, viresh.kumar@linaro.org, sudeep.holla@arm.com,
 rafael@kernel.org, amit.kachhap@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231212142730.998913-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/23 14:27, Vincent Guittot wrote:
> arch_update_thermal_pressure() aims to update fast changing signal which
> should be averaged using PELT filtering before being provided to the
> scheduler which can't make smart use of fast changing signal.
> cpufreq now provides the maximum freq_qos pressure on the capacity to the
> scheduler, which includes cpufreq cooling device. Remove the call to
> arch_update_thermal_pressure() in cpufreq cooling device as this is
> handled by cpufreq_get_pressure().
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   drivers/thermal/cpufreq_cooling.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index e2cc7bd30862..e77d3b44903e 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -448,7 +448,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>   				 unsigned long state)
>   {
>   	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> -	struct cpumask *cpus;
>   	unsigned int frequency;
>   	int ret;
>   
> @@ -465,8 +464,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>   	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
>   	if (ret >= 0) {
>   		cpufreq_cdev->cpufreq_state = state;
> -		cpus = cpufreq_cdev->policy->related_cpus;
> -		arch_update_thermal_pressure(cpus, frequency);
>   		ret = 0;
>   	}
>   

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

