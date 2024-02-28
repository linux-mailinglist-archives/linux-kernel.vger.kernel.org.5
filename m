Return-Path: <linux-kernel+bounces-85087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB6186B03C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329161F25B98
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58EC14C5B6;
	Wed, 28 Feb 2024 13:24:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F77145351;
	Wed, 28 Feb 2024 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126684; cv=none; b=dE06TRSule9g1O6AGg3YtKbMpXzSIWwZ1/OjbyyK9RLIPHY+YbNhJrt2+t67USfXIu41WNP0MoOR6gveUNrb2tV99XvcadVdv3BReq93TEb1/1M1otVB85PGFjNzwAzMWrt3+bm+gKgYcYEwiZloHsUrInJt6UdMhRFeKBr7AV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126684; c=relaxed/simple;
	bh=XDFj5ej2ly05jyaCAesq3QNALGY6izh4ir1ndq5BHhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2ycsSuJEg9/yTfd2brF9yv8gTI0kJqt1kaFLePourRfa/Fk8kvuc6swFgQ1ts6XT1HpxCgKUdlczD3YqCAxZildh4wtZEMBsG7aiUMuymDdOHSyILkeT+k4smg5Xl4ltaC9yQzHB0pQKKvbTBERyjlCsaVG0toMMXzacGvsEH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78C53C15;
	Wed, 28 Feb 2024 05:25:19 -0800 (PST)
Received: from [10.57.11.244] (unknown [10.57.11.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 187A53F762;
	Wed, 28 Feb 2024 05:24:36 -0800 (PST)
Message-ID: <f8bfc666-c216-44d5-a63b-99f04ff3b8ef@arm.com>
Date: Wed, 28 Feb 2024 13:24:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] cpufreq: scmi: Register for limit change
 notifications
Content-Language: en-US
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-kernel@lists.infradead.org, pierre.gondois@arm.com,
 dietmar.eggemann@arm.com, morten.rasmussen@arm.com, viresh.kumar@linaro.org,
 rafael@kernel.org, cristian.marussi@arm.com, sudeep.holla@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org
References: <20240227181632.659133-1-quic_sibis@quicinc.com>
 <20240227181632.659133-3-quic_sibis@quicinc.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240227181632.659133-3-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/24 18:16, Sibi Sankar wrote:
> Register for limit change notifications if supported and use the throttled
> frequency from the notification to apply HW pressure.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v3:
> * Sanitize range_max received from the notifier. [Pierre]
> * Update commit message.
> 
>   drivers/cpufreq/scmi-cpufreq.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 76a0ddbd9d24..78b87b72962d 100644
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
>   static struct cpufreq_driver scmi_cpufreq_driver;
> @@ -151,6 +155,20 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
>   	NULL,
>   };
>   
> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event, void *data)
> +{
> +	struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
> +	struct scmi_perf_limits_report *limit_notify = data;
> +	struct cpufreq_policy *policy = priv->policy;
> +
> +	policy->max = clamp(limit_notify->range_max_freq/HZ_PER_KHZ, policy->cpuinfo.min_freq,
> +			    policy->cpuinfo.max_freq);

Please take the division operation out of this clamp() call, somewhere
above. Currently it 'blurs' these stuff, while it's important convertion
to khz. You can call it e.g.:

limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;

then use in clamp(limit_freq_khz, ...)

> +
> +	cpufreq_update_pressure(policy);
> +
> +	return NOTIFY_OK;
> +}
> +
>   static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>   {
>   	int ret, nr_opp, domain;
> @@ -269,6 +287,15 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>   		}
>   	}
>   
> +	priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
> +	ret = handle->notify_ops->devm_event_notifier_register(scmi_dev, SCMI_PROTOCOL_PERF,
> +							SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
> +							&domain,
> +							&priv->limit_notify_nb);
> +	if (ret)
> +		dev_warn(cpu_dev,
> +			 "failed to register for limits change notifier for domain %d\n", domain);
> +
>   	priv->policy = policy;
>   
>   	return 0;
> @@ -342,8 +369,8 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>   {
>   	int ret;
>   	struct device *dev = &sdev->dev;
> -	const struct scmi_handle *handle;

It should be a compilation error...

>   
> +	scmi_dev = sdev;
>   	handle = sdev->handle;

due to usage here, wasn't it?

>   
>   	if (!handle)

