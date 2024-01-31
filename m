Return-Path: <linux-kernel+bounces-46605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B718441DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88EA1F228BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6A28288C;
	Wed, 31 Jan 2024 14:29:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57CB80C0F;
	Wed, 31 Jan 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711373; cv=none; b=rq9myz91hbkOOUPAexL/0SURx4yYB5dPUHkaZv7o28PPM15XzEUQNBZG3hNl+YMbR+Ytb3ltLFTn1kBXLIvoi3hU5V31A9j7rWJ4CqfXd5vmYbB0rGo/iBVM0rsJtjy3dRxpdudJw/zDh2H53Rqjdc+oLb2UbFL/w32uQjjJzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711373; c=relaxed/simple;
	bh=Zh6sTYWQ9wDJX1zZ4Ep9vNshtgdiaKLCJBYBTnHLGt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZ1g5rIt4+RsuYkzbJRO/xcm75R88wslT+k+oRJWJPXc5jMDlCXUJ6dGsXyNCiV2JaYitBKm0Wi6KhGfTcOe2SVY5U27WZ87T3RndyeK1PIU0LS79GUPbsIaV0OowWL7dUcjisL6X3d5CX1XJWg7bAhE/O5Ucfbqx9pWNwKKQdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F6E5DA7;
	Wed, 31 Jan 2024 06:30:13 -0800 (PST)
Received: from [10.34.100.129] (e126645.nice.arm.com [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6948D3F738;
	Wed, 31 Jan 2024 06:29:28 -0800 (PST)
Message-ID: <512d7296-2706-4779-b475-fbf2d208e282@arm.com>
Date: Wed, 31 Jan 2024 15:29:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/4] cpufreq: scmi: Register for limit change
 notifications
Content-Language: en-US
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com,
 linux-pm@vger.kernel.org, cristian.marussi@arm.com,
 linux-kernel@vger.kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
 quic_mdtipton@quicinc.com, lukasz.luba@arm.com,
 linux-arm-msm@vger.kernel.org, dietmar.eggemann@arm.com,
 morten.rasmussen@arm.com
References: <20240117104116.2055349-1-quic_sibis@quicinc.com>
 <20240117104116.2055349-5-quic_sibis@quicinc.com>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240117104116.2055349-5-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Sibi,

On 1/17/24 11:41, Sibi Sankar wrote:
> Register for limit change notifications if supported with the help of
> perf_notify_support interface and determine the throttled frequency
> using the perf_freq_xlate to apply HW pressure.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v2:
> * Export cpufreq_update_pressure and use it directly [Lukasz]
> 
>   drivers/cpufreq/scmi-cpufreq.c | 42 +++++++++++++++++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 4ee23f4ebf4a..e0aa85764451 100644
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
> +	if (perf_ops->perf_freq_xlate(ph, priv->domain_id, limit_notify->range_max, &freq_hz))
> +		return NOTIFY_OK;
> +
> +	policy->max = freq_hz / HZ_PER_KHZ;

Maybe 'policy->max' should be checked. The limits received by SCMI is blindly
trusted. This might be ok, but could also lead to some inconsistency.

The scmi_cpufreq_driver's verify() callback could be used.

---

I think there might also be corner cases where the SCP might advertise
the maximum boosted frequency as the max limit, but boosting might not
be enabled on the kernel side.
So I think this should be checked when setting 'policy->max',

Regards,
Pierre

> +	cpufreq_update_pressure(policy);
> +
> +	return NOTIFY_OK;
> +}
> +
>   static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>   {
>   	int ret, nr_opp, domain;
> @@ -151,6 +171,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>   	struct device *cpu_dev;
>   	struct scmi_data *priv;
>   	struct cpufreq_frequency_table *freq_table;
> +	struct scmi_perf_notify_info info = {};
>   
>   	cpu_dev = get_cpu_device(policy->cpu);
>   	if (!cpu_dev) {
> @@ -250,6 +271,25 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>   	policy->fast_switch_possible =
>   		perf_ops->fast_switch_possible(ph, domain);
>   
> +	ret = perf_ops->perf_notify_support(ph, domain, &info);
> +	if (ret)
> +		dev_warn(cpu_dev, "failed to get supported notifications: %d\n", ret);
> +
> +	if (info.perf_limit_notify) {
> +		priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
> +		ret = handle->notify_ops->devm_event_notifier_register(scmi_dev, SCMI_PROTOCOL_PERF,
> +							SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
> +							&domain,
> +							&priv->limit_notify_nb);
> +		if (ret) {
> +			dev_err(cpu_dev, "Error in registering limit change notifier for domain %d\n",
> +				domain);
> +			return ret;
> +		}
> +	}
> +
> +	priv->policy = policy;
> +
>   	return 0;
>   
>   out_free_opp:
> @@ -321,8 +361,8 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>   {
>   	int ret;
>   	struct device *dev = &sdev->dev;
> -	const struct scmi_handle *handle;
>   
> +	scmi_dev = sdev;
>   	handle = sdev->handle;
>   
>   	if (!handle)

