Return-Path: <linux-kernel+bounces-46606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA24C8441E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DE5B2E4E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784078288E;
	Wed, 31 Jan 2024 14:29:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3136980C0F;
	Wed, 31 Jan 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711389; cv=none; b=nl0cayCRJM2Z1WPhvBZrk+FehynzWQHBJZBk9hqyXHj1/TICeANpwOJlzyUqaF9VPRMcXFW5/svM4s4df8wa4VdKPbLKLU1roANUPxfUzlt0QHMGmM9QfizmRRfIKc1z2OGUf9uzlKzLakND8JyYZ9B94eguH3jyaoCRFzHgXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711389; c=relaxed/simple;
	bh=S/jMeh1Aal/VzYnvxcTgPIKps4x8r9jVVeBusLeRDyk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tJY6bDMs7ziNxeLQZYtbDocVa/rluHkxf7oqmySD2HJ3MYmBVrBhbRl9PWfjPdUqEmC9Kgm9+CuiAEv2FVUFoDjJc3g/hlVUss8/IjlqQEch2bTtfOc6pzLGbIInkaNx9xmFxbRY7fMBxzhq8pe6xtIJFo0WvuYJzCJ0ggtVssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 963E5DA7;
	Wed, 31 Jan 2024 06:30:29 -0800 (PST)
Received: from [10.34.100.129] (e126645.nice.arm.com [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 362D23F738;
	Wed, 31 Jan 2024 06:29:44 -0800 (PST)
Message-ID: <e3abe1ab-064f-4a6a-a91d-fe8c91574600@arm.com>
Date: Wed, 31 Jan 2024 15:29:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Add support for marking certain
 frequencies as boost
To: Sibi Sankar <quic_sibis@quicinc.com>, cristian.marussi@arm.com
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com,
 sboyd@kernel.org, lukasz.luba@arm.com, dietmar.eggemann@arm.com,
 morten.rasmussen@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org, nm@ti.com
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
 <20240117110443.2060704-3-quic_sibis@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240117110443.2060704-3-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Sibi,

On 1/17/24 12:04, Sibi Sankar wrote:
> All opps above the sustained level/frequency are treated as boost, so mark
> them accordingly.
> 
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>   drivers/firmware/arm_scmi/perf.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index e286f04ee6e3..d3fb8c804b3d 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -811,7 +811,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
>   				     struct device *dev, u32 domain)
>   {
>   	int idx, ret;
> -	unsigned long freq;
> +	unsigned long freq, sustained_freq;
>   	struct dev_pm_opp_data data = {};
>   	struct perf_dom_info *dom;
>   
> @@ -819,12 +819,21 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
>   	if (IS_ERR(dom))
>   		return PTR_ERR(dom);
>   
> +	if (!dom->level_indexing_mode)
> +		sustained_freq = dom->sustained_perf_level * dom->mult_factor;
> +	else
> +		sustained_freq = dom->sustained_freq_khz * dom->mult_factor;
> +
>   	for (idx = 0; idx < dom->opp_count; idx++) {
>   		if (!dom->level_indexing_mode)
>   			freq = dom->opp[idx].perf * dom->mult_factor;
>   		else
>   			freq = dom->opp[idx].indicative_freq * dom->mult_factor;
>   
> +		/* All opps above the sustained level/frequency are treated as boost */
> +		if (sustained_freq && freq > sustained_freq)

It seems the sustained_freq is not optional since SCMI v1.0,
is it necessary to check that (sustained_freq != 0) ?

> +			data.turbo = true;
> +
>   		data.level = dom->opp[idx].perf;
>   		data.freq = freq;
>   

