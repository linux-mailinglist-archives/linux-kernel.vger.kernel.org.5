Return-Path: <linux-kernel+bounces-90158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D2C86FB2A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3527228173C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02B7168D0;
	Mon,  4 Mar 2024 07:55:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6465814005;
	Mon,  4 Mar 2024 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538954; cv=none; b=TjeqCJP7hJ22w43BW2cStkGVMcwiJsJJEmgPcVO3qlihj7FcKYD9i0jCkW3OzwMk5felC141SEMzw0DY6l/IyHp7Y60ZUQ+inJ5G8qfNhFV51i8D0gb61m/TFu89gwJixHNJXyHrMFDEvpKPBWYH/9DvYb0DfoxE6WSktoX0r+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538954; c=relaxed/simple;
	bh=fPYouMsBga9m1IrfuiKGUred6KoYk00CuCfLztrBnjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUJ6gczgKqwMmitqoeyXbKmnFxME8Okt5sDiyzg5qn9x+vhrfeNCp2s6qle5yCTP2NCRSB+wkF7lp6Gl8YYBzYtYxPM1mGpG/f2+CCjfotSPcszxMpKAnC+2W+pY2UCrua4BNE+nz6Htyq2WqAx038shaRaJHMLStLBo7tIic2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8212B1FB;
	Sun,  3 Mar 2024 23:56:28 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A7473F762;
	Sun,  3 Mar 2024 23:55:50 -0800 (PST)
Date: Mon, 4 Mar 2024 07:55:47 +0000
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
Subject: Re: [PATCH 1/3] firmware: arm_scmi: Populate perf commands rate_limit
Message-ID: <ZeV-g6WR7IYNXEJX@pluto>
References: <20240222135702.2005635-1-pierre.gondois@arm.com>
 <20240222135702.2005635-2-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222135702.2005635-2-pierre.gondois@arm.com>

On Thu, Feb 22, 2024 at 02:56:59PM +0100, Pierre Gondois wrote:
> Arm SCMI spec. v3.2, s4.5.3.4 PERFORMANCE_DOMAIN_ATTRIBUTES
> defines a per-domain rate_limit for performance requests:
> """
> Rate Limit in microseconds, indicating the minimum time
> required between successive requests. A value of 0
> indicates that this field is not supported by the
> platform. This field does not apply to FastChannels.
> """"
> The field is first defined in SCMI v1.0.
> 
> Add support to fetch this value and advertise it through
> a rate_limit_get() callback.
> 

Hi,

LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/firmware/arm_scmi/perf.c | 21 +++++++++++++++++++++
>  include/linux/scmi_protocol.h    |  4 ++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 211e8e0aef2c..37c80376bd0a 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -153,6 +153,7 @@ struct perf_dom_info {
>  	bool perf_fastchannels;
>  	bool level_indexing_mode;
>  	u32 opp_count;
> +	u32 rate_limit_us;
>  	u32 sustained_freq_khz;
>  	u32 sustained_perf_level;
>  	unsigned long mult_factor;
> @@ -266,6 +267,8 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
>  		if (PROTOCOL_REV_MAJOR(version) >= 0x4)
>  			dom_info->level_indexing_mode =
>  				SUPPORTS_LEVEL_INDEXING(flags);
> +		dom_info->rate_limit_us = le32_to_cpu(attr->rate_limit_us) &
> +						GENMASK(19, 0);
>  		dom_info->sustained_freq_khz =
>  					le32_to_cpu(attr->sustained_freq_khz);
>  		dom_info->sustained_perf_level =
> @@ -855,6 +858,23 @@ scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
>  	return dom->opp[dom->opp_count - 1].trans_latency_us * 1000;
>  }
>  
> +static int
> +scmi_dvfs_rate_limit_get(const struct scmi_protocol_handle *ph,
> +			 u32 domain, u32 *rate_limit)
> +{
> +	struct perf_dom_info *dom;
> +
> +	if (!rate_limit)
> +		return -EINVAL;
> +
> +	dom = scmi_perf_domain_lookup(ph, domain);
> +	if (IS_ERR(dom))
> +		return PTR_ERR(dom);
> +
> +	*rate_limit = dom->rate_limit_us;
> +	return 0;
> +}
> +
>  static int scmi_dvfs_freq_set(const struct scmi_protocol_handle *ph, u32 domain,
>  			      unsigned long freq, bool poll)
>  {
> @@ -970,6 +990,7 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
>  	.level_set = scmi_perf_level_set,
>  	.level_get = scmi_perf_level_get,
>  	.transition_latency_get = scmi_dvfs_transition_latency_get,
> +	.rate_limit_get = scmi_dvfs_rate_limit_get,
>  	.device_opps_add = scmi_dvfs_device_opps_add,
>  	.freq_set = scmi_dvfs_freq_set,
>  	.freq_get = scmi_dvfs_freq_get,
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index f2f05fb42d28..acd956ffcb84 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -128,6 +128,8 @@ struct scmi_perf_domain_info {
>   * @level_set: sets the performance level of a domain
>   * @level_get: gets the performance level of a domain
>   * @transition_latency_get: gets the DVFS transition latency for a given device
> + * @rate_limit_get: gets the minimum time (us) required between successive
> + *	requests
>   * @device_opps_add: adds all the OPPs for a given device
>   * @freq_set: sets the frequency for a given device using sustained frequency
>   *	to sustained performance level mapping
> @@ -154,6 +156,8 @@ struct scmi_perf_proto_ops {
>  			 u32 *level, bool poll);
>  	int (*transition_latency_get)(const struct scmi_protocol_handle *ph,
>  				      u32 domain);
> +	int (*rate_limit_get)(const struct scmi_protocol_handle *ph,
> +			      u32 domain, u32 *rate_limit);
>  	int (*device_opps_add)(const struct scmi_protocol_handle *ph,
>  			       struct device *dev, u32 domain);
>  	int (*freq_set)(const struct scmi_protocol_handle *ph, u32 domain,
> -- 
> 2.25.1
> 

