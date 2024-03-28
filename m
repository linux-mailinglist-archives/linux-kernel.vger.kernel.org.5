Return-Path: <linux-kernel+bounces-122565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7F288F9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F0D2947B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BECE54679;
	Thu, 28 Mar 2024 08:06:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177C74645B;
	Thu, 28 Mar 2024 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613178; cv=none; b=qLUgnhlvDEcROjwntab8qMbNQI3dR/LCb8pYuOXYNyVY2J811vs4NSfPbQlpdxQOS9kluAZF33tuZoFz8Dxz0mZt8XFPYmG4rWBWxeVc9N/eEhn/IT1KttRX5AhzdoU7K93XD2C3djUGD05/Zdamw8NJ/1vKFsjyJ5hgtxVTEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613178; c=relaxed/simple;
	bh=OhxLny5ouqoUh402yVUwWKVNAn7UzL8QP3wDxdEi4LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbB18lQMLU00pn8+PiTFcLRMsTzfe4U4XDPzVHHin6kcOIy7SZWYPHhKp832t8fQ1cdy0CNjaVdxC2oM5H3Jj7eAnnS+IQgVtv049wctK5ma6JUDgcsLgSFKYla4JEq17iTqijeScG6capVkTxahXiAJBFZNga8HgbRAsY/VnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CDC82F4;
	Thu, 28 Mar 2024 01:06:49 -0700 (PDT)
Received: from [10.57.73.83] (unknown [10.57.73.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50AD83F64C;
	Thu, 28 Mar 2024 01:06:13 -0700 (PDT)
Message-ID: <dd73443d-d4fc-4dcb-8e68-6be11e134428@arm.com>
Date: Thu, 28 Mar 2024 08:06:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] cpufreq: scmi: Register for limit change
 notifications
Content-Language: en-US
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-kernel@lists.infradead.org, pierre.gondois@arm.com,
 dietmar.eggemann@arm.com, morten.rasmussen@arm.com, viresh.kumar@linaro.org,
 cristian.marussi@arm.com, linux-pm@vger.kernel.org, rafael@kernel.org,
 linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
 linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com
References: <20240328074131.2839871-1-quic_sibis@quicinc.com>
 <20240328074131.2839871-3-quic_sibis@quicinc.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240328074131.2839871-3-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/28/24 07:41, Sibi Sankar wrote:
> Register for limit change notifications if supported and use the throttled
> frequency from the notification to apply HW pressure.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v4:
> * Use a interim variable to show the khz calc. [Lukasz]
> * Use driver_data to pass on the handle and scmi_dev instead of using
>    global variables. Dropped Lukasz's Rb due to adding these minor
>    changes.
> 
>   drivers/cpufreq/scmi-cpufreq.c | 44 ++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 3b4f6bfb2f4c..d946b7a08258 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -21,11 +21,18 @@
>   #include <linux/types.h>
>   #include <linux/units.h>
>   
> +struct scmi_cpufreq_driver_data {
> +	struct scmi_device *sdev;
> +	const struct scmi_handle *handle;
> +};
> +
>   struct scmi_data {
>   	int domain_id;
>   	int nr_opp;
>   	struct device *cpu_dev;
> +	struct cpufreq_policy *policy;
>   	cpumask_var_t opp_shared_cpus;
> +	struct notifier_block limit_notify_nb;
>   };
>   
>   static struct scmi_protocol_handle *ph;
> @@ -174,6 +181,22 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
>   	NULL,
>   };
>   
> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
> +{
> +	struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
> +	struct scmi_perf_limits_report *limit_notify = data;
> +	struct cpufreq_policy *policy = priv->policy;
> +	unsigned int limit_freq_khz;
> +
> +	limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
> +
> +	policy->max = clamp(limit_freq_khz, policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
> +
> +	cpufreq_update_pressure(policy);
> +
> +	return NOTIFY_OK;
> +}
> +
>   static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>   {
>   	int ret, nr_opp, domain;
> @@ -181,6 +204,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>   	struct device *cpu_dev;
>   	struct scmi_data *priv;
>   	struct cpufreq_frequency_table *freq_table;
> +	struct scmi_cpufreq_driver_data *data = cpufreq_get_driver_data();
>   
>   	cpu_dev = get_cpu_device(policy->cpu);
>   	if (!cpu_dev) {
> @@ -294,6 +318,17 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>   		}
>   	}
>   
> +	priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
> +	ret = data->handle->notify_ops->devm_event_notifier_register(data->sdev, SCMI_PROTOCOL_PERF,
> +							SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
> +							&domain,
> +							&priv->limit_notify_nb);
> +	if (ret)
> +		dev_warn(cpu_dev,
> +			 "failed to register for limits change notifier for domain %d\n", domain);
> +
> +	priv->policy = policy;
> +
>   	return 0;
>   
>   out_free_opp:
> @@ -366,12 +401,21 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>   	int ret;
>   	struct device *dev = &sdev->dev;
>   	const struct scmi_handle *handle;
> +	struct scmi_cpufreq_driver_data *data;
>   
>   	handle = sdev->handle;
>   
>   	if (!handle)
>   		return -ENODEV;
>   
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->sdev = sdev;
> +	data->handle = handle;
> +	scmi_cpufreq_driver.driver_data = data;
> +
>   	perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
>   	if (IS_ERR(perf_ops))
>   		return PTR_ERR(perf_ops);

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

