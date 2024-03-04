Return-Path: <linux-kernel+bounces-90183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC7B86FB73
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAA71C20C35
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8559C179B8;
	Mon,  4 Mar 2024 08:15:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D2417748;
	Mon,  4 Mar 2024 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540137; cv=none; b=fYkmm8oujzcxJr3VqEGAPUlhb3UG0njSoeldMTrvxltx8a95oCdLUF2AVYFeB9xfWbS+Trpk4+O+sTfoUwBQndSpysgPWBDdHOOCjQ2lmy/lX/vAyO989LKN2SpyJkcmyKrOt9uzhx9efbhih+ab1n0ENpBpXFhbiRtEb8Ek3J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540137; c=relaxed/simple;
	bh=sIV4GFAFMe2hM+lUcfPmThwDZ5aRzv2IyHc/aTyBPug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iac1tmI1i33w+Gppl3mfa3XTBb4NsJa9rBPWylT9Ghh15m3JHlSfAC8JkwytAp5YFsKNJwYYuDDJ+Swkt0cEnLXtvcn92XPzRlrFjxKL/WSjzGZeFHlrskb/a4iQAhkhgkOErclA9BYv+2YzwHzFXvj3enQKpF8+OQox5ns9ycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB37B1FB;
	Mon,  4 Mar 2024 00:16:11 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 750153F762;
	Mon,  4 Mar 2024 00:15:33 -0800 (PST)
Date: Mon, 4 Mar 2024 08:15:31 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] cpufreq: scmi: Set transition_delay_us
Message-ID: <ZeWDI3_-s8fCmVJx@pluto>
References: <20240222135702.2005635-1-pierre.gondois@arm.com>
 <20240222135702.2005635-4-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222135702.2005635-4-pierre.gondois@arm.com>

On Thu, Feb 22, 2024 at 02:57:01PM +0100, Pierre Gondois wrote:
> Make use of the newly added callbacks:
> - rate_limit_get()
> - fast_switch_rate_limit()
> to populate policies's `transition_delay_us`, defined as the
> 'Preferred average time interval between consecutive
> invocations of the driver to set the frequency for this policy.'
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Hi,

> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 4ee23f4ebf4a..0b483bd0d3ca 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -144,6 +144,29 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
>  	return 0;
>  }
>  
> +static int
> +scmi_get_rate_limit(u32 domain, bool has_fast_switch)
> +{
> +	int ret, rate_limit;
> +
> +	if (has_fast_switch) {
> +		/*
> +		 * Fast channels are used whenever available,
> +		 * so use their rate_limit value if populated.
> +		 */
> +		ret = perf_ops->fast_switch_rate_limit(ph, domain,
> +						       &rate_limit);
> +		if (!ret && rate_limit)
> +			return rate_limit;
> +	}
> +
> +	ret = perf_ops->rate_limit_get(ph, domain, &rate_limit);
> +	if (ret)
> +		return 0;
> +
> +	return rate_limit;
> +}
> +
>  static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	int ret, nr_opp, domain;
> @@ -250,6 +273,9 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  	policy->fast_switch_possible =
>  		perf_ops->fast_switch_possible(ph, domain);
>  
> +	policy->transition_delay_us =
> +		scmi_get_rate_limit(domain, policy->fast_switch_possible);
> +
>  	return 0;
>  

As a second thought, I have just realized that now we have 2 ops to get the
rate_limit for a domain, one used in case of FCs and another in case of std
messaging w/out FCs, BUT given that we always use FCs when available, AND we
do not indeed have any way from perf_ops to explicitly request a set/get
ops NOT to use FCs when available, does it even make sense to expose such
2 functions ? Do we need such flexibility ?

Shouldn't we just expose one single rate_limit perf_ops and let the SCMI core
decide what to return depending on the presence or not of the FCs for that
domain ?

Maybe @Sudeep thinks differently.

Thanks,
Cristian


