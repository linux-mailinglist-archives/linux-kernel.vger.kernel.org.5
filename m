Return-Path: <linux-kernel+bounces-165091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A868B87A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7A9B21397
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2493B51033;
	Wed,  1 May 2024 09:26:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9E51E498;
	Wed,  1 May 2024 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555610; cv=none; b=JyY8Nbk55ddVVJDu7psMovBHfRgySHj+VWpaCSTVmml7RqvWcoCpkkF0ZvZJcEVHL0lE3VVCSHy56M1DjboBGnWUjJWhbuEakzMZ9fS4BUxgipHbSBpMuYtbqwzCljOS2hFdlFI8dlAIWwtwtCo2J6MwkGLW71J9JIV5kLPjYfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555610; c=relaxed/simple;
	bh=nzPyu2YiZD1yrE0VDN4oac8WQMHoMssmVIZQ+8dHAoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkYJxAt14sdV3+OJD5ykBfVMbnf9NCNWxhx5GhAg+lDewMglHsXKv7GblHmJVwPDo/x1j6CdIwjZw8/vUuIfOhtsZglf0MU+nRGvJs1UqvarYop6l6heNW6GkCB0+PFZyYUQk90xOgAzazlCyrMMyovqrq1xsKIx6hxWVSKcCmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79F022F4;
	Wed,  1 May 2024 02:27:13 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC4C73F793;
	Wed,  1 May 2024 02:26:45 -0700 (PDT)
Date: Wed, 1 May 2024 10:26:43 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com, linux-samsung-soc@vger.kernel.org,
	rafael@kernel.org, viresh.kumar@linaro.org, quic_sibis@quicinc.com
Subject: Re: [PATCH 2/2] cpufreq: scmi: Update Energy Model with allowed
 performance limits
Message-ID: <ZjIK0-7ixgp0WQ4x@pluto>
References: <20240403162315.1458337-1-lukasz.luba@arm.com>
 <20240403162315.1458337-3-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403162315.1458337-3-lukasz.luba@arm.com>

On Wed, Apr 03, 2024 at 05:23:15PM +0100, Lukasz Luba wrote:
> The Energy Model (EM) supports performance limits updates. Use the SCMI
> notifications to get information from FW about allowed frequency scope for
> the CPUs.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index d946b7a082584..90c8448578cb1 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -185,12 +185,25 @@ static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event,
>  {
>  	struct scmi_data *priv = container_of(nb, struct scmi_data, limit_notify_nb);
>  	struct scmi_perf_limits_report *limit_notify = data;
> +	unsigned int limit_freq_max_khz, limit_freq_min_khz;
>  	struct cpufreq_policy *policy = priv->policy;
> -	unsigned int limit_freq_khz;
> +	struct em_perf_domain *pd;
> +	int ret;
> +
> +	limit_freq_max_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
> +	limit_freq_min_khz = limit_notify->range_min_freq / HZ_PER_KHZ;

Note that these values could be zeroed if the notification is good but
the range_min/range_max values could NOT be mapped to a frequency
equivalent (due to some FW errors).

I would probably have to add a warn about this error in the core SCMI
notification path (or drop the notif as a whole); if not here you could
end-up just setting max/min to 0 if the fw has messed up the
notification range_min/range_max.

Or is it just that, especially max_feq = 0 is NOT plausible value and you
will need anyway to check it here ?

>  
> -	limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
> +	pd = em_cpu_get(policy->cpu);
> +	if (pd) {
> +		ret = em_update_performance_limits(pd, limit_freq_min_khz,
> +						   limit_freq_max_khz);
> +		if (ret)
> +			dev_warn(priv->cpu_dev,
> +				 "EM perf limits update failed\n");
> +	}
>  
> -	policy->max = clamp(limit_freq_khz, policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
> +	policy->max = clamp(limit_freq_max_khz, policy->cpuinfo.min_freq,
> +			    policy->cpuinfo.max_freq);

FWIW, regarding the SCMI bits.

LGTM.
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

