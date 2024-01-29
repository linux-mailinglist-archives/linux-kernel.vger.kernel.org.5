Return-Path: <linux-kernel+bounces-43040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28081840AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4FCB222CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5766D155318;
	Mon, 29 Jan 2024 15:53:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE210154BFA;
	Mon, 29 Jan 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543630; cv=none; b=SHNgbfpNtT2y1+EH/VRe7zOKS/S1g7ffuwp5tbwirH3KOwH00YoT5zbA4JmelVSeD4AnC27PxvUEzdOvbJ8XZBSMfYGHGSzFMDb+VbP/WWF5MC9f9jnYYx+U5OOvNTVI7wPDDmqZ0+7KRIapUoztjeuFCo5SQyAbfuEkkIOVw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543630; c=relaxed/simple;
	bh=yUOgoH/cgXK92lzIp6hdtAKfj0+wNYCgmkrU8wjD0Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBkjkU96qH/82o0rLz853+KNjQH7HQXn40GBStkmJ3Ess3tVG4stRXG6/Ttd46Ak7NDniT7fz4yUFxdlMxQiddLf1mBbMAT/U74OJqRTu1vxRaq9N6xvDjzZD7Zlh4UyrSaE7FWQ2bY0IfXAbf3jO+aRxGXO5UjDsOuftTCTUVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3735ADA7;
	Mon, 29 Jan 2024 07:54:32 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57C023F738;
	Mon, 29 Jan 2024 07:53:46 -0800 (PST)
Date: Mon, 29 Jan 2024 15:53:43 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 2/4] firmware: arm_scmi: Add perf_freq_xlate interface
Message-ID: <ZbfKB4M8FHfma0js@pluto>
References: <20240117104116.2055349-1-quic_sibis@quicinc.com>
 <20240117104116.2055349-3-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117104116.2055349-3-quic_sibis@quicinc.com>

On Wed, Jan 17, 2024 at 04:11:14PM +0530, Sibi Sankar wrote:
> Add a new perf_freq_xlate interface to the existing perf_ops to translate
> a given perf index to frequency.
> 
> This can be used by the cpufreq driver and framework to determine the
> throttled frequency from a given perf index and apply HW pressure
> accordingly.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v2:
> * Rename opp_xlate -> freq_xlate [Viresh]
> 
>  drivers/firmware/arm_scmi/perf.c | 21 +++++++++++++++++++++
>  include/linux/scmi_protocol.h    |  3 +++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index ae7681eda276..e286f04ee6e3 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -977,6 +977,26 @@ static int scmi_notify_support(const struct scmi_protocol_handle *ph, u32 domain
>  	return 0;
>  }
>  
> +static int scmi_perf_freq_xlate(const struct scmi_protocol_handle *ph, u32 domain,
> +				int idx, unsigned long *freq)
> +{
> +	struct perf_dom_info *dom;
> +
> +	dom = scmi_perf_domain_lookup(ph, domain);
> +	if (IS_ERR(dom))
> +		return PTR_ERR(dom);
> +
> +	if (idx >= dom->opp_count)
> +		return -ERANGE;
> +
> +	if (!dom->level_indexing_mode)
> +		*freq = dom->opp[idx].perf * dom->mult_factor;
> +	else
> +		*freq = dom->opp[idx].indicative_freq * dom->mult_factor;
> +
> +	return 0;
> +}

Potentially, once the dom info are exposed you can also drop this
accessor and move all of these checks/calculations in the the SCMI cpufreq
driver...but maybe Sudeep/Viresh prefer to keep this accessor exposed
like others.

Thanks,
Cristian

