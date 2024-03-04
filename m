Return-Path: <linux-kernel+bounces-90161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8642586FB3E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E1C1F22A17
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8FD171A2;
	Mon,  4 Mar 2024 08:00:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FA714A8C;
	Mon,  4 Mar 2024 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709539223; cv=none; b=H0fOFXGCrzVhmWvc1xGM0mvofw+uXPtmp5jjyRh2YFO1pSP39fPWd+slr2JKrAW6Wpbb+g/21byiCkEvtn2LoorXzckBYJbbtd3M/tyMVF+2P/lQ5mN1EZ76M4tZSkQswRbhYEzpA27fv4AJzuxXfIgnwNNJ2e9mctCyGiQcp4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709539223; c=relaxed/simple;
	bh=Ua8b1ZWHmeVoMLH8CMKQ0vyoTyjiCGIEd+L6GpOdqow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q53QVD2zi3kIIC3XHPOH3IlxtZn2KV3PegOmXkoq3jYKEeuH4ptyxVN4C6zq3+oFcZG1fkXrTdIJ3JG1x0X1IkxJxlejn8K6yok/yo8pofJQ7BHemUsqy0QoAVvyguMEgSpa4zcIQ2Yr0/AL/6WVM9g9lIP88I0t//8+BbrQxr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1098D1FB;
	Mon,  4 Mar 2024 00:00:58 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D16A93F762;
	Mon,  4 Mar 2024 00:00:19 -0800 (PST)
Date: Mon, 4 Mar 2024 08:00:17 +0000
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
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Populate fast channel rate_limit
Message-ID: <ZeV_kdcPSb-MFesS@pluto>
References: <20240222135702.2005635-1-pierre.gondois@arm.com>
 <20240222135702.2005635-3-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222135702.2005635-3-pierre.gondois@arm.com>

On Thu, Feb 22, 2024 at 02:57:00PM +0100, Pierre Gondois wrote:
> Arm SCMI spec. v3.2, s4.5.3.12 PERFORMANCE_DESCRIBE_FASTCHANNEL
> defines a per-domain rate_limit for performance requests:
> """
> Rate Limit in microseconds, indicating the minimum time
> required between successive requests. A value of 0
> indicates that this field is not applicable or supported
> on the platform.
> """"
> The field is first defined in SCMI v2.0.
> 
> Add support to fetch this value and advertise it through
> a fast_switch_rate_limit() callback.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Hi,

LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

> ---
>  drivers/firmware/arm_scmi/driver.c    |  5 ++++-
>  drivers/firmware/arm_scmi/perf.c      | 32 +++++++++++++++++++++++----
>  drivers/firmware/arm_scmi/powercap.c  | 12 ++++++----
>  drivers/firmware/arm_scmi/protocols.h |  4 +++-
>  include/linux/scmi_protocol.h         |  4 ++++
>  5 files changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 3ea64b22cf0d..1d38ecfafc59 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -1617,7 +1617,7 @@ static void
>  scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
>  			     u8 describe_id, u32 message_id, u32 valid_size,
>  			     u32 domain, void __iomem **p_addr,
> -			     struct scmi_fc_db_info **p_db)
> +			     struct scmi_fc_db_info **p_db, u32 *rate_limit)
>  {
>  	int ret;
>  	u32 flags;
> @@ -1661,6 +1661,9 @@ scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
>  		goto err_xfer;
>  	}
>  
> +	if (rate_limit)
> +		*rate_limit = le32_to_cpu(resp->rate_limit) & GENMASK(19, 0);
> +
>  	phys_addr = le32_to_cpu(resp->chan_addr_low);
>  	phys_addr |= (u64)le32_to_cpu(resp->chan_addr_high) << 32;
>  	addr = devm_ioremap(ph->dev, phys_addr, size);
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 37c80376bd0a..fbcbd703198a 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -789,23 +789,27 @@ static void scmi_perf_domain_init_fc(const struct scmi_protocol_handle *ph,
>  
>  	ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
>  				   PERF_LEVEL_GET, 4, dom->id,
> -				   &fc[PERF_FC_LEVEL].get_addr, NULL);
> +				   &fc[PERF_FC_LEVEL].get_addr, NULL,
> +				   &fc[PERF_FC_LEVEL].rate_limit);
>  
>  	ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
>  				   PERF_LIMITS_GET, 8, dom->id,
> -				   &fc[PERF_FC_LIMIT].get_addr, NULL);
> +				   &fc[PERF_FC_LIMIT].get_addr, NULL,
> +				   &fc[PERF_FC_LIMIT].rate_limit);
>  
>  	if (dom->info.set_perf)
>  		ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
>  					   PERF_LEVEL_SET, 4, dom->id,
>  					   &fc[PERF_FC_LEVEL].set_addr,
> -					   &fc[PERF_FC_LEVEL].set_db);
> +					   &fc[PERF_FC_LEVEL].set_db,
> +					   &fc[PERF_FC_LEVEL].rate_limit);
>  
>  	if (dom->set_limits)
>  		ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
>  					   PERF_LIMITS_SET, 8, dom->id,
>  					   &fc[PERF_FC_LIMIT].set_addr,
> -					   &fc[PERF_FC_LIMIT].set_db);
> +					   &fc[PERF_FC_LIMIT].set_db,
> +					   &fc[PERF_FC_LIMIT].rate_limit);
>  
>  	dom->fc_info = fc;
>  }
> @@ -974,6 +978,25 @@ static bool scmi_fast_switch_possible(const struct scmi_protocol_handle *ph,
>  	return dom->fc_info && dom->fc_info[PERF_FC_LEVEL].set_addr;
>  }
>  
> +static int scmi_fast_switch_rate_limit(const struct scmi_protocol_handle *ph,
> +				       u32 domain, u32 *rate_limit)
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
> +	if (!dom->fc_info)
> +		return -EINVAL;
> +
> +	*rate_limit = dom->fc_info[PERF_FC_LEVEL].rate_limit;
> +	return 0;
> +}
> +
>  static enum scmi_power_scale
>  scmi_power_scale_get(const struct scmi_protocol_handle *ph)
>  {
> @@ -996,6 +1019,7 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
>  	.freq_get = scmi_dvfs_freq_get,
>  	.est_power_get = scmi_dvfs_est_power_get,
>  	.fast_switch_possible = scmi_fast_switch_possible,
> +	.fast_switch_rate_limit = scmi_fast_switch_rate_limit,
>  	.power_scale_get = scmi_power_scale_get,
>  };
>  
> diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
> index a4c6cd4716fe..604184c044ff 100644
> --- a/drivers/firmware/arm_scmi/powercap.c
> +++ b/drivers/firmware/arm_scmi/powercap.c
> @@ -703,20 +703,24 @@ static void scmi_powercap_domain_init_fc(const struct scmi_protocol_handle *ph,
>  	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
>  				   POWERCAP_CAP_SET, 4, domain,
>  				   &fc[POWERCAP_FC_CAP].set_addr,
> -				   &fc[POWERCAP_FC_CAP].set_db);
> +				   &fc[POWERCAP_FC_CAP].set_db,
> +				   &fc[POWERCAP_FC_CAP].rate_limit);
>  
>  	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
>  				   POWERCAP_CAP_GET, 4, domain,
> -				   &fc[POWERCAP_FC_CAP].get_addr, NULL);
> +				   &fc[POWERCAP_FC_CAP].get_addr, NULL,
> +				   &fc[POWERCAP_FC_CAP].rate_limit);
>  
>  	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
>  				   POWERCAP_PAI_SET, 4, domain,
>  				   &fc[POWERCAP_FC_PAI].set_addr,
> -				   &fc[POWERCAP_FC_PAI].set_db);
> +				   &fc[POWERCAP_FC_PAI].set_db,
> +				   &fc[POWERCAP_FC_PAI].rate_limit);
>  
>  	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
>  				   POWERCAP_PAI_GET, 4, domain,
> -				   &fc[POWERCAP_FC_PAI].get_addr, NULL);
> +				   &fc[POWERCAP_FC_PAI].get_addr, NULL,
> +				   &fc[POWERCAP_PAI_GET].rate_limit);
>  
>  	*p_fc = fc;
>  }
> diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
> index e683c26f24eb..8b5d9ce4a33a 100644
> --- a/drivers/firmware/arm_scmi/protocols.h
> +++ b/drivers/firmware/arm_scmi/protocols.h
> @@ -234,6 +234,7 @@ struct scmi_fc_info {
>  	void __iomem *set_addr;
>  	void __iomem *get_addr;
>  	struct scmi_fc_db_info *set_db;
> +	u32 rate_limit;
>  };
>  
>  /**
> @@ -268,7 +269,8 @@ struct scmi_proto_helpers_ops {
>  				 u8 describe_id, u32 message_id,
>  				 u32 valid_size, u32 domain,
>  				 void __iomem **p_addr,
> -				 struct scmi_fc_db_info **p_db);
> +				 struct scmi_fc_db_info **p_db,
> +				 u32 *rate_limit);
>  	void (*fastchannel_db_ring)(struct scmi_fc_db_info *db);
>  };
>  
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index acd956ffcb84..fafedb3b6604 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -139,6 +139,8 @@ struct scmi_perf_domain_info {
>   *	at a given frequency
>   * @fast_switch_possible: indicates if fast DVFS switching is possible or not
>   *	for a given device
> + * @fast_switch_rate_limit: gets the minimum time (us) required between
> + *	successive fast_switching requests
>   * @power_scale_mw_get: indicates if the power values provided are in milliWatts
>   *	or in some other (abstract) scale
>   */
> @@ -168,6 +170,8 @@ struct scmi_perf_proto_ops {
>  			     unsigned long *rate, unsigned long *power);
>  	bool (*fast_switch_possible)(const struct scmi_protocol_handle *ph,
>  				     u32 domain);
> +	int (*fast_switch_rate_limit)(const struct scmi_protocol_handle *ph,
> +				      u32 domain, u32 *rate_limit);
>  	enum scmi_power_scale (*power_scale_get)(const struct scmi_protocol_handle *ph);
>  };
>  
> -- 
> 2.25.1
> 

