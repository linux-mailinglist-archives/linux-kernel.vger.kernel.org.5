Return-Path: <linux-kernel+bounces-46760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AA78443B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9651F27A70
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53FA12AADC;
	Wed, 31 Jan 2024 16:08:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA3884A2D;
	Wed, 31 Jan 2024 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717337; cv=none; b=X5dM1BfwUPAt68qWuEqD1FiHbYrL2nfMfRxS4I69E54cxNAW4Rn9KPQbVIWDQJKEXjuvUiT4YklvIO9k/MotSvn8DySKxXn2X2Os6R6gA7n3OWo7YsXVVqjnddklN8xuHrU/Hdc/3CjOE771b4BYr9z1BqHp+GxGkAN0nt0SUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717337; c=relaxed/simple;
	bh=MSYUWffMJFbDudCRxBvDmOdHQFu/qboKRVvrratEScw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKPmpMdWFsUYj57ir2GLWEN4FI1UkfgdktMjCtNaSLBv4cNlDSAFvBpeDalkF/giiHorW234mFPhvn6fYHPlu4lQhmlse7XP5DV7t71q7jFYdhGWB0DKNIDj8/8wltxiQ3xbzgP1wK9Y9jszYiWQbnw8A4UPW3UqxaWPrUeTxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16949DA7;
	Wed, 31 Jan 2024 08:09:37 -0800 (PST)
Received: from bogus (unknown [10.57.78.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD4A03F762;
	Wed, 31 Jan 2024 08:08:50 -0800 (PST)
Date: Wed, 31 Jan 2024 16:08:48 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, cristian.marussi@arm.com,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, sboyd@kernel.org,
	lukasz.luba@arm.com, dietmar.eggemann@arm.com,
	morten.rasmussen@arm.com, viresh.kumar@linaro.org,
	rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Add support for marking certain
 frequencies as boost
Message-ID: <20240131160848.662dhaoiov3trt4i@bogus>
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
 <20240117110443.2060704-3-quic_sibis@quicinc.com>
 <e3abe1ab-064f-4a6a-a91d-fe8c91574600@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3abe1ab-064f-4a6a-a91d-fe8c91574600@arm.com>

On Wed, Jan 31, 2024 at 03:29:43PM +0100, Pierre Gondois wrote:
> Hello Sibi,
> 
> On 1/17/24 12:04, Sibi Sankar wrote:
> > All opps above the sustained level/frequency are treated as boost, so mark
> > them accordingly.
> > 
> > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > ---
> >   drivers/firmware/arm_scmi/perf.c | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> > index e286f04ee6e3..d3fb8c804b3d 100644
> > --- a/drivers/firmware/arm_scmi/perf.c
> > +++ b/drivers/firmware/arm_scmi/perf.c
> > @@ -811,7 +811,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
> >   				     struct device *dev, u32 domain)
> >   {
> >   	int idx, ret;
> > -	unsigned long freq;
> > +	unsigned long freq, sustained_freq;
> >   	struct dev_pm_opp_data data = {};
> >   	struct perf_dom_info *dom;
> > @@ -819,12 +819,21 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
> >   	if (IS_ERR(dom))
> >   		return PTR_ERR(dom);
> > +	if (!dom->level_indexing_mode)
> > +		sustained_freq = dom->sustained_perf_level * dom->mult_factor;
> > +	else
> > +		sustained_freq = dom->sustained_freq_khz * dom->mult_factor;
> > +
> >   	for (idx = 0; idx < dom->opp_count; idx++) {
> >   		if (!dom->level_indexing_mode)
> >   			freq = dom->opp[idx].perf * dom->mult_factor;
> >   		else
> >   			freq = dom->opp[idx].indicative_freq * dom->mult_factor;
> > +		/* All opps above the sustained level/frequency are treated as boost */
> > +		if (sustained_freq && freq > sustained_freq)
>
> It seems the sustained_freq is not optional since SCMI v1.0,
> is it necessary to check that (sustained_freq != 0) ?
>

Technically correct, we don't have to. But since day 1, we checked and
handled 0 for perf_level specifically to avoid division by zero. I am
just worried if there are any platforms in the wild with these values as
0. We can start without the check and add it if someone complains perhaps ?

-- 
Regards,
Sudeep

