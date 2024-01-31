Return-Path: <linux-kernel+bounces-46341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E9D843E40
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E847F1F28248
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0553974E24;
	Wed, 31 Jan 2024 11:25:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2B067A16;
	Wed, 31 Jan 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700315; cv=none; b=DTnn6mis1Zg5B9zsEi3SZ1wsKTn5E0Z4/eolcqht96qESl7n8al1ADd6dBHWTp+z+uEA33bngBRot4Jf0X+QiAA0F28BnryGaDlGPhLgo7Qs8uNpnGToXtGNPAvCsb5gN9WWEVudEmifTF7xfQyQXDG6EJt7J9WbKuksZJ8jjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700315; c=relaxed/simple;
	bh=wzS1Y1fbKl5youA8h5qmv/jE996pLnUuHtJcrrtwbRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVWibhaiQXfAtdlMQUQalRAkAilOabDTEP3HaC4Iv9/n8vXcfKIM3IgUYuR4Zg9gQ8nWzBdmCsGvZXHFAqsh56r9LWjl6Y2BKkjgeHt6ZjOGDuJiJQt3jBTft93T8oABPzTuqiB8ZgJ1PwKUDnARcYk9KX5rml3Wirg8W6nE8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42C65DA7;
	Wed, 31 Jan 2024 03:25:56 -0800 (PST)
Received: from bogus (unknown [10.57.78.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 123C53F762;
	Wed, 31 Jan 2024 03:25:09 -0800 (PST)
Date: Wed, 31 Jan 2024 11:25:07 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: cristian.marussi@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	Sudeep Holla <sudeep.holla@arm.com>, morten.rasmussen@arm.com,
	dietmar.eggemann@arm.com, lukasz.luba@arm.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Add support for marking certain
 frequencies as boost
Message-ID: <20240131112507.fu355wnolbsoiqxn@bogus>
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
 <20240117110443.2060704-3-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117110443.2060704-3-quic_sibis@quicinc.com>

On Wed, Jan 17, 2024 at 04:34:42PM +0530, Sibi Sankar wrote:
> All opps above the sustained level/frequency are treated as boost, so mark
> them accordingly.
> 
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  drivers/firmware/arm_scmi/perf.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index e286f04ee6e3..d3fb8c804b3d 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -811,7 +811,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
>  				     struct device *dev, u32 domain)
>  {
>  	int idx, ret;
> -	unsigned long freq;
> +	unsigned long freq, sustained_freq;
>  	struct dev_pm_opp_data data = {};
>  	struct perf_dom_info *dom;
>  
> @@ -819,12 +819,21 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
>  	if (IS_ERR(dom))
>  		return PTR_ERR(dom);
>  
> +	if (!dom->level_indexing_mode)
> +		sustained_freq = dom->sustained_perf_level * dom->mult_factor;
> +	else
> +		sustained_freq = dom->sustained_freq_khz * dom->mult_factor;
> +

Can't we just use dom->sustained_freq_khz * 1000UL in both the cases ?

Other than that this series looks good to me but it would be good to
explain how you would use this. Since it is enabled by default, do you
plan to disable boost at time and when ? If it is for thermal reasons,
why your other series handling thermal and limits notification from the
firmware not sufficient.

-- 
Regards,
Sudeep

