Return-Path: <linux-kernel+bounces-165029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F18B86D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C08C2858D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8FB4F605;
	Wed,  1 May 2024 08:21:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89792EED6;
	Wed,  1 May 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714551693; cv=none; b=VYqXikMNizsW2gdvsBdYVXmuulIvhlrxSdUNh/BfkjQff0a7Kq1oqWiPKuXJYbIFQoflOzF+X5G4mc8L9eVIrV7V50stxhTJ2GYY6VdfifnrSyirNr1SCG4gHrIBwHACO9KNFx/HvRuv6J+bfs9iMYxFca2a7P0s0doxgCrpo2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714551693; c=relaxed/simple;
	bh=X8qLkIyTCQ2AZcwKN+u61pO82R+Ot2jZEQ76Gaar5C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+nDvJuTQcZbIba8YofN/3BERRzUK/+F419u0o/yB4PAp2UcCtNLTBd7AcKwDHhCyamWndfIsqKDesfqMg5Aupdlj50daVU1wj0c0gxChczZHYBDirEIuDiWDz/puMpAAaNu/93Tv9qKoo0VjPHGHuo7uhMYQHCEg3oXIGlLS4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46DF12F4;
	Wed,  1 May 2024 01:21:56 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CA3C3F793;
	Wed,  1 May 2024 01:21:28 -0700 (PDT)
Date: Wed, 1 May 2024 09:21:25 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, pierre.gondois@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V4 2/2] cpufreq: scmi: Register for limit change
 notifications
Message-ID: <ZjH7hWnKFcpQ-TXH@pluto>
References: <20240328074131.2839871-1-quic_sibis@quicinc.com>
 <20240328074131.2839871-3-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328074131.2839871-3-quic_sibis@quicinc.com>

On Thu, Mar 28, 2024 at 01:11:31PM +0530, Sibi Sankar wrote:
> Register for limit change notifications if supported and use the throttled
> frequency from the notification to apply HW pressure.
> 

Hi Sibi,

a bit late on this, sorry.

Just a couple of nitpicks down below.

> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v4:
> * Use a interim variable to show the khz calc. [Lukasz]
> * Use driver_data to pass on the handle and scmi_dev instead of using
>   global variables. Dropped Lukasz's Rb due to adding these minor
>   changes.
> 
>  drivers/cpufreq/scmi-cpufreq.c | 44 ++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 3b4f6bfb2f4c..d946b7a08258 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -21,11 +21,18 @@
>  #include <linux/types.h>
>  #include <linux/units.h>
>  
> +struct scmi_cpufreq_driver_data {
> +	struct scmi_device *sdev;
> +	const struct scmi_handle *handle;
> +};
> +
>  struct scmi_data {
>  	int domain_id;
>  	int nr_opp;
>  	struct device *cpu_dev;
> +	struct cpufreq_policy *policy;
>  	cpumask_var_t opp_shared_cpus;
> +	struct notifier_block limit_notify_nb;
>  };
>  
>  static struct scmi_protocol_handle *ph;
> @@ -174,6 +181,22 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
>  	NULL,
>  };
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
>  static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	int ret, nr_opp, domain;
> @@ -181,6 +204,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  	struct device *cpu_dev;
>  	struct scmi_data *priv;
>  	struct cpufreq_frequency_table *freq_table;
> +	struct scmi_cpufreq_driver_data *data = cpufreq_get_driver_data();
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -294,6 +318,17 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  		}
>  	}
>  
> +	priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
> +	ret = data->handle->notify_ops->devm_event_notifier_register(data->sdev, SCMI_PROTOCOL_PERF,
> +							SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
> +							&domain,
> +							&priv->limit_notify_nb);
> +	if (ret)
> +		dev_warn(cpu_dev,

or &data->sdev->dev which refers to this driver ? which is more informational ? no strong opinion just a question...

> +			 "failed to register for limits change notifier for domain %d\n", domain);
> +
> +	priv->policy = policy;
> +
>  	return 0;
>  
>  out_free_opp:
> @@ -366,12 +401,21 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>  	int ret;
>  	struct device *dev = &sdev->dev;
>  	const struct scmi_handle *handle;
> +	struct scmi_cpufreq_driver_data *data;
>  
>  	handle = sdev->handle;

	^^^ ....
>  
>  	if (!handle)
>  		return -ENODEV;
>  
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->sdev = sdev;
> +	data->handle = handle;

	^^^ ... you dont need to pass around handle AND sdev really
                since you can access the handle from sdev.

> +	scmi_cpufreq_driver.driver_data = data;

This is slightly better, but, as said, does not solve the multi-instance issue...
..the scmi cpufreq driver remains a driver that works only if instantiated (probed)
once, given how the CPUFreq core handles cpufreq_driver registration itself...

..just a note about something to work on in the future...NOT a concern for this series.

In general,

LGTM.

Thanks,
Cristian


