Return-Path: <linux-kernel+bounces-21831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746D58294F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99BB2870E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E68E3E478;
	Wed, 10 Jan 2024 08:25:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CCD3C461;
	Wed, 10 Jan 2024 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBF482F4;
	Wed, 10 Jan 2024 00:25:50 -0800 (PST)
Received: from [10.57.87.179] (unknown [10.57.87.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38B753F73F;
	Wed, 10 Jan 2024 00:25:03 -0800 (PST)
Message-ID: <94aad654-4f20-4b82-b978-77f1f9376dab@arm.com>
Date: Wed, 10 Jan 2024 08:26:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cpufreq: scmi: Register for limit change
 notifications
Content-Language: en-US
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-kernel@lists.infradead.org, viresh.kumar@linaro.org,
 rafael@kernel.org, cristian.marussi@arm.com, sudeep.holla@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20240108140118.1596-1-quic_sibis@quicinc.com>
 <20240108140118.1596-4-quic_sibis@quicinc.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240108140118.1596-4-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sibi,

+ Morten and Dietmar on CC

On 1/8/24 14:01, Sibi Sankar wrote:
> Register for limit change notifications if supported with the help of
> perf_notify_support interface and determine the throttled frequency
> using the perf_opp_xlate to apply HW pressure.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>   drivers/cpufreq/scmi-cpufreq.c | 42 +++++++++++++++++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 4ee23f4ebf4a..53bc8868455d 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -25,9 +25,13 @@ struct scmi_data {
>   	int domain_id;
>   	int nr_opp;
>   	struct device *cpu_dev;
> +	struct cpufreq_policy *policy;
>   	cpumask_var_t opp_shared_cpus;
> +	struct notifier_block limit_notify_nb;
>   };
>   
> +const struct scmi_handle *handle;
> +static struct scmi_device *scmi_dev;
>   static struct scmi_protocol_handle *ph;
>   static const struct scmi_perf_proto_ops *perf_ops;
>   
> @@ -144,6 +148,22 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
>   	return 0;
>   }
>   
> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
> +{
> +	unsigned long freq_hz;
> +	struct scmi_perf_limits_report *limit_notify = data;
> +	struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
> +	struct cpufreq_policy *policy = priv->policy;
> +
> +	if (perf_ops->perf_opp_xlate(ph, priv->domain_id, limit_notify->range_max, &freq_hz))
> +		return NOTIFY_OK;
> +
> +	/* Update HW pressure (the boost frequencies are accepted) */
> +	arch_update_hw_pressure(policy->related_cpus, (freq_hz / HZ_PER_KHZ));

This is wrong. The whole idea of the new HW pressure was that I wanted
to get rid of the 'signal smoothing' mechanism in order to get
instantaneous value from FW to task scheduler. Vincent created
2 interfaces in that new HW pressure:
1. cpufreq_update_pressure(policy) - raw variable
2. arch_update_hw_pressure(policy->related_cpus, (freq_hz / HZ_PER_KHZ))
    - smoothing PELT mechanism, good for raw IRQ in drivers

In our SCMI cpufreq driver we need the 1st one:
cpufreq_update_pressure(policy)

The FW will do the 'signal smoothing or filtering' and won't
flood the kernel with hundreds of notifications.

So, please change that bit and add me, Morten and Dietmar on CC.
I would like to review it.

Regards,
Lukasz

