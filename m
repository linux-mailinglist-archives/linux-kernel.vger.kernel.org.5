Return-Path: <linux-kernel+bounces-43181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F84840CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984011C23C27
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46082157048;
	Mon, 29 Jan 2024 17:06:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFD1157031
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547966; cv=none; b=Dyb4NHtjKfM71s8BP8ElVZR5N/03oE8hbihmQ8mvWHJMpZpI0aRtC9YHFraboYt0r7luYxGoLKnabYORpJpygsPBeZyB3H23Randr7VqlNh9s8kXkBz/x1rQzptj18LgBS3zqJ4eeWWChGIZroUvPWvNkqoKUsBSfXaAI7JUiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547966; c=relaxed/simple;
	bh=iL5sXDcZk4kdZ8AV43Aqv8EC1cACpXKwfhD/aYXOgUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7JmD/DsWzQdzQtWT+WkQs0kqDxRT7JuVYjzxOf2As3lsE4AhJ1IOiPE0FHOPRIKqb0M3MWjU/OXvOTYMY1gYekIGX+AW6se5sE+V+Hk3yvdAtygpd2q+Zsz6r8ekV42yBjvVyt8z7J2qdHCyyru7LKpn+90bqLwAQ5J9UDZpz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 425A0DA7;
	Mon, 29 Jan 2024 09:06:47 -0800 (PST)
Received: from [10.57.77.253] (unknown [10.57.77.253])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82DDD3F738;
	Mon, 29 Jan 2024 09:06:02 -0800 (PST)
Message-ID: <41299a7b-d0be-4647-8b78-c347bf931d26@arm.com>
Date: Mon, 29 Jan 2024 17:06:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf/arm-cmn: Decouple wp_config registers from
 filter group number
Content-Language: en-GB
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240126221215.1537377-1-ilkka@os.amperecomputing.com>
 <20240126221215.1537377-2-ilkka@os.amperecomputing.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240126221215.1537377-2-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ilkka,

On 2024-01-26 10:12 pm, Ilkka Koskinen wrote:
> Previously, wp_config0/2 registers were used for primary match group and
> wp_config1/3 registers for secondary match group. In order to support
> tertiary match group, this patch decouples the registers and the groups.

Happy to see you having a stab at this, however I fear I you're in for a 
fair dose of "if it were this simple I might have already done it" :)

> Allocation is changed to dynamic but it's still per mesh instance rather
> than per node.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   drivers/perf/arm-cmn.c | 52 ++++++++++++++++++++++++++++++++++--------
>   1 file changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index c584165b13ba..93eb47ea7e25 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -591,6 +591,7 @@ struct arm_cmn_hw_event {
>   	u8 dtm_offset;
>   	bool wide_sel;
>   	enum cmn_filter_select filter_sel;
> +	int wp_idx;
>   };
>   
>   #define for_each_hw_dn(hw, dn, i) \
> @@ -1337,7 +1338,35 @@ static const struct attribute_group *arm_cmn_attr_groups[] = {
>   
>   static int arm_cmn_wp_idx(struct perf_event *event)
>   {
> -	return CMN_EVENT_EVENTID(event) + CMN_EVENT_WP_GRP(event);
> +	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
> +
> +	return hw->wp_idx;

Sorry, this breaks group validation.

> +}
> +
> +static int arm_cmn_wp_idx_unused(struct perf_event *event, struct arm_cmn_dtm *dtm,
> +	struct arm_cmn_dtc *dtc)
> +{
> +	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
> +	int idx, tmp, direction = CMN_EVENT_EVENTID(event);
> +
> +	/*
> +	 * Examine wp 0 & 1 for the up direction,
> +	 * examine wp 2 & 3 for the down direction
> +	 */
> +	for (idx = direction; idx < direction + 2; idx++)
> +		if (dtm->wp_event[idx] < 0)
> +			break;
> +
> +	if (idx == direction + 2)
> +		return -ENOSPC;
> +
> +	tmp = dtm->wp_event[idx ^ 1];
> +	if (tmp >= 0 && CMN_EVENT_WP_COMBINE(event) !=
> +	    CMN_EVENT_WP_COMBINE(dtc->counters[tmp]))
> +		return -ENOSPC;
> +
> +	hw->wp_idx = idx;

I don't really get this logic either - we can allocate a potentially 
different index for every DTM, but only store the most recent one?

> +	return hw->wp_idx;
>   }
>   
>   static u32 arm_cmn_wp_config(struct perf_event *event)
> @@ -1785,6 +1814,8 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
>   
>   	for_each_hw_dtc_idx(hw, j, idx)
>   		cmn->dtc[j].counters[idx] = NULL;
> +
> +	hw->wp_idx = -1;
>   }
>   
>   static int arm_cmn_event_add(struct perf_event *event, int flags)
> @@ -1794,6 +1825,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
>   	struct arm_cmn_node *dn;
>   	enum cmn_node_type type = CMN_EVENT_TYPE(event);
>   	unsigned int input_sel, i = 0;
> +	int wp_idx;
>   
>   	if (type == CMN_TYPE_DTC) {
>   		while (cmn->dtc[i].cycles)
> @@ -1822,6 +1854,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
>   	}
>   
>   	/* ...then the local counters to feed them */
> +	wp_idx = -1;

Oh, I guess this trying to avoid some of that issue, but I still don't 
think it works - say we add an event targeted to XP B, which sees WP0 is 
free on DTM B so allocates index 0; then we add another event 
aggregating across XPs A and B, which sees WP0 is free on DTM A, 
allocates index 0, then goes on to stomp WP0 on DTM B as well - oops.

I don't think it's going to be feasible to do this without tracking the 
full allocation state with a wp_idx bitmap in the hw_event - at least it 
only needs to be half the size of dtm_idx, so I think there's still room.

Thanks,
Robin.

>   	for_each_hw_dn(hw, dn, i) {
>   		struct arm_cmn_dtm *dtm = &cmn->dtms[dn->dtm] + hw->dtm_offset;
>   		unsigned int dtm_idx, shift, d = max_t(int, dn->dtc, 0);
> @@ -1835,16 +1868,17 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
>   		if (type == CMN_TYPE_XP) {
>   			input_sel = CMN__PMEVCNT0_INPUT_SEL_XP + dtm_idx;
>   		} else if (type == CMN_TYPE_WP) {
> -			int tmp, wp_idx = arm_cmn_wp_idx(event);
>   			u32 cfg = arm_cmn_wp_config(event);
>   
> -			if (dtm->wp_event[wp_idx] >= 0)
> -				goto free_dtms;
> -
> -			tmp = dtm->wp_event[wp_idx ^ 1];
> -			if (tmp >= 0 && CMN_EVENT_WP_COMBINE(event) !=
> -					CMN_EVENT_WP_COMBINE(cmn->dtc[d].counters[tmp]))
> -				goto free_dtms;
> +			/*
> +			 * wp_config register index is currently allocated per
> +			 * mesh instance rather than per node.
> +			 */
> +			if (wp_idx < 0) {
> +				wp_idx = arm_cmn_wp_idx_unused(event, dtm, &cmn->dtc[d]);
> +				if (wp_idx < 0)
> +					goto free_dtms;
> +			}
>   
>   			input_sel = CMN__PMEVCNT0_INPUT_SEL_WP + wp_idx;
>   			dtm->wp_event[wp_idx] = hw->dtc_idx[d];

