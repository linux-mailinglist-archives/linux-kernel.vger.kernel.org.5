Return-Path: <linux-kernel+bounces-46377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6B6843EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15BF1F229DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0E8768FA;
	Wed, 31 Jan 2024 11:46:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACB274E0D;
	Wed, 31 Jan 2024 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701564; cv=none; b=Vbvq78Dqx42QDSFL6rpn+9shglxCvyRA8+eXelvaHZ7qfVYWfw/vcb3IUqFkbK0xtwVC83lRt0GJV+ijWtyANWgGb5m2WB7uVxRL0EdN3pn07mA5WxxzhMq/9nVqcgbLZ5lgkqHX+DsPvPPooplMzuJytr4DfbOSqj9Q6nYfUIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701564; c=relaxed/simple;
	bh=YKwxxEVjTT8reMyzHc/tCez2ZRFnGM3A7kBKxL9R2ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV0jB37YqGTwG07YsLxKICypEJ5Ry0I0z7dmfesBV7Ela7rVrcpWGgmNjjCgFzTAxq2UmG0toGIYl7xnICwjOBPDjklOodKxtDm0+iS6pTl900mfhWAj58wCbj0i2JDQJqHpHTm/d84clJfrwQvSpJxHYNEb3cGcSQE8Zb1EtjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF5BCDA7;
	Wed, 31 Jan 2024 03:46:43 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AD343F762;
	Wed, 31 Jan 2024 03:45:58 -0800 (PST)
Date: Wed, 31 Jan 2024 11:45:47 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 2/4] firmware: arm_scmi: Add perf_freq_xlate interface
Message-ID: <Zboy64oByO-BlG6z@pluto>
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

As said elsewhere the plan would be to change slightly the SCMI core to
avoid the need for this patch and the previous one (while NOT exposing
too much Perf info)...

.. anyway just looking at the above freq calc logic in this patch, be
aware that as it stands it seems to me broken, since the idx you use to
peek into the opp array comes (in the next patch) from the range_max
carried by the notification and that can be, indeed, a perf_level OR a
perf_index BUT it is absolutely NOT guaranteed to be an index into the
opp[] array...so it may work in your case if you have a platform
defining level or indexes matching the opp[] indexes BUT it is not true
in general. (but as said, this will be handled by the core and possibly
this patch dropped...)

Thanks,
Cristian

