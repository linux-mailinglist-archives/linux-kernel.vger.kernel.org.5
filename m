Return-Path: <linux-kernel+bounces-43043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E52840AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE169B226BA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337F8155314;
	Mon, 29 Jan 2024 15:59:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2C9154C0C;
	Mon, 29 Jan 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543997; cv=none; b=sOZpERoKoKJMus3x/z8RgSo74r52NRiS5JMBGG7TZclX2TzH5/st1S/Wz/8k8lJjhbItFqeAN6Ew1B0/XqgTlAGvAQmOhDnyRIQOCsPHDhmPWcS0IUWpn+4JrCKWL0ZXvobAQAVOA7CeJ8Ldi/0r/sodIu6E8CWTWbijQzyxGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543997; c=relaxed/simple;
	bh=iul6xK0e4EN46G8goBsLPgIN2sLhocsKXHQYJX65YiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOu5kS6s239JFuA/alf5GFD2mI2CV7/dp9DXrJ6AOZEbnlPiqoON84bygKtxjKE0sOEMvOOcrCGk4AJkjUFGMY7hxzxCRM3mp6ffO/ohzIxi6X7Ga1b5QXF7AOLKFa/dRBgM099xPHw7K1H18Fa3/yPTrPSTcBfRWq5fvmgDvyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0027ADA7;
	Mon, 29 Jan 2024 08:00:39 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22E3B3F738;
	Mon, 29 Jan 2024 07:59:53 -0800 (PST)
Date: Mon, 29 Jan 2024 15:59:50 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 4/4] cpufreq: scmi: Register for limit change
 notifications
Message-ID: <ZbfLdvi_sePXiVmM@pluto>
References: <20240117104116.2055349-1-quic_sibis@quicinc.com>
 <20240117104116.2055349-5-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117104116.2055349-5-quic_sibis@quicinc.com>

On Wed, Jan 17, 2024 at 04:11:16PM +0530, Sibi Sankar wrote:
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
>  drivers/cpufreq/scmi-cpufreq.c | 42 +++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 4ee23f4ebf4a..e0aa85764451 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -25,9 +25,13 @@ struct scmi_data {
>  	int domain_id;
>  	int nr_opp;
>  	struct device *cpu_dev;
> +	struct cpufreq_policy *policy;
>  	cpumask_var_t opp_shared_cpus;
> +	struct notifier_block limit_notify_nb;
>  };
>  
> +const struct scmi_handle *handle;
> +static struct scmi_device *scmi_dev;
>  static struct scmi_protocol_handle *ph;
>  static const struct scmi_perf_proto_ops *perf_ops;
>  
> @@ -144,6 +148,22 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
>  	return 0;
>  }
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
> +	cpufreq_update_pressure(policy);
> +
> +	return NOTIFY_OK;
> +}
> +
>  static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	int ret, nr_opp, domain;
> @@ -151,6 +171,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  	struct device *cpu_dev;
>  	struct scmi_data *priv;
>  	struct cpufreq_frequency_table *freq_table;
> +	struct scmi_perf_notify_info info = {};
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -250,6 +271,25 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  	policy->fast_switch_possible =
>  		perf_ops->fast_switch_possible(ph, domain);
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

Is there a reason to fail completely here if it was not possible to register
the notifier ? (even though expected to succeed given perf_limit_notify
was true...)

Maybe a big fat warn that the system perf could be degraded, but
carrying on ?

Or maybe you have in mind a good reason to fail like you did, so please
explain in that case in a comment.

Thanks,
Cristian

