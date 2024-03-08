Return-Path: <linux-kernel+bounces-97170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D74876669
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950E91F21F47
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CC115C0;
	Fri,  8 Mar 2024 14:35:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DD6173
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709908530; cv=none; b=OUUKQxpAH3vmFps/BE0g0WQKdjdOukxqHFo2waO1wj/UYbj9dgFQKV0XsDBftMq/74PSyE5FhvVc3IUUdsnr3fzhGmMtnjpjcN0vaMIzKyjgcVrxcP+yHySW1wJewaY/hFvMMi37RdbB/AaR1HB+1Ec9SW6WNwIk0y/l3wlU4Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709908530; c=relaxed/simple;
	bh=tiZgRPvv5ifPMDFoSoxniNnRD69FMqc6ynWQztCFga4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrZFdNu+za6Pl25Vg4iYgY98UhLn0UMULE4R5B7ecSYb7M6XYIthXOFWAdJeKJhMgnhyOSOi2MIM1/ij/DkrHE+9bYkKqA5IirugtqK110s7ZBfYL/mS3QYJKHb/oTgRIO5XqqfqML0aIwomarZIj9EpvL6sLHj3R/G7vmiDBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F951C15;
	Fri,  8 Mar 2024 06:36:04 -0800 (PST)
Received: from [10.57.68.92] (unknown [10.57.68.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 609DB3F762;
	Fri,  8 Mar 2024 06:35:26 -0800 (PST)
Message-ID: <69a17eff-5338-44a5-a53e-4b8142c21bf1@arm.com>
Date: Fri, 8 Mar 2024 14:35:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf/arm-cmn: Decouple wp_config registers from
 filter group number
Content-Language: en-GB
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240307230929.6233-1-ilkka@os.amperecomputing.com>
 <20240307230929.6233-2-ilkka@os.amperecomputing.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240307230929.6233-2-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-07 11:09 pm, Ilkka Koskinen wrote:
> Previously, wp_config0/2 registers were used for primary match group and
> wp_config1/3 registers for secondary match group. In order to support
> tertiary match group, this patch decouples the registers and the groups.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   drivers/perf/arm-cmn.c | 125 ++++++++++++++++++++++++++++++++++-------
>   1 file changed, 105 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 7e3aa7e2345f..29d46e0cf1cd 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -589,6 +589,13 @@ struct arm_cmn_hw_event {
>   	s8 dtc_idx[CMN_MAX_DTCS];
>   	u8 num_dns;
>   	u8 dtm_offset;
> +
> +	/*
> +	 * WP config registers are divided to UP and DOWN events. We need to
> +	 * keep to track only one of them.
> +	 */
> +	DECLARE_BITMAP(wp_cfg, 2 * CMN_MAX_XPS);

What I had in mind was a wp_idx field which works the same way as 
dtm_idx, i.e. we just store the allocated index per relevant DN, since a 
single event can never use *both* watchpoints on a single XP. Each index 
then need only be 0 or 1 since they're already scoped by the watchpoint 
direction of the base event, thus we should only need one bit per XP.

> +
>   	bool wide_sel;
>   	enum cmn_filter_select filter_sel;
>   };
> @@ -1335,9 +1342,51 @@ static const struct attribute_group *arm_cmn_attr_groups[] = {
>   	NULL
>   };
>   
> -static int arm_cmn_wp_idx(struct perf_event *event)
> +static inline unsigned int arm_cmn_get_xp_idx(struct arm_cmn *cmn,
> +					      struct arm_cmn_node *xp)
>   {
> -	return CMN_EVENT_EVENTID(event) + CMN_EVENT_WP_GRP(event);
> +	return  ((unsigned long) xp - (unsigned long) cmn->xps) / sizeof(struct arm_cmn_node);
> +}
> +
> +static int arm_cmn_find_free_wp_idx(struct arm_cmn *cmn, struct arm_cmn_dtm *dtm,
> +				   struct perf_event *event)
> +{
> +	int wp_idx = CMN_EVENT_EVENTID(event);
> +
> +	if (dtm->wp_event[wp_idx] >= 0)
> +		if (dtm->wp_event[++wp_idx] >= 0)
> +			return -ENOSPC;
> +
> +	return wp_idx;
> +}
> +
> +static int arm_cmn_get_assigned_wp_idx(struct arm_cmn *cmn,
> +				       struct arm_cmn_node *xp,
> +				       struct perf_event *event,
> +				       struct arm_cmn_hw_event *hw)
> +{
> +	int xp_idx = arm_cmn_get_xp_idx(cmn, xp);
> +
> +	if (test_bit(2 * xp_idx, hw->wp_cfg))
> +		return CMN_EVENT_EVENTID(event);
> +	else if (test_bit(2 * xp_idx + 1, hw->wp_cfg))
> +		return CMN_EVENT_EVENTID(event) + 1;
> +
> +	dev_err(cmn->dev, "Could't find the assigned wp_cfg\n");
> +	return -EINVAL;
> +}

..and so for this we would only need more of a mild tweak to the 
existing design, something like:

static int arm_cmn_get_wp_idx(struct perf_event *event, int pos)
{
	struct arm_cmn_hw_event *hw = to_cmn_hw(event);

	return CMN_EVENT_EVENTID(event) + test_bit(&hw->wp_idx, pos);
}

> +
> +static void arm_cmn_claim_wp_idx(struct arm_cmn *cmn,
> +				    struct arm_cmn_dtm *dtm,
> +				    struct perf_event *event,
> +				    struct arm_cmn_node *xp,
> +				    int wp_idx, unsigned int dtc)
> +{
> +	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
> +	int xp_idx = arm_cmn_get_xp_idx(cmn, xp);
> +
> +	dtm->wp_event[wp_idx] = hw->dtc_idx[dtc];
> +	set_bit(2 * xp_idx + (wp_idx & 1), hw->wp_cfg);

This is recalculating way more than it needs to. It's only ever used 
within for_each_hw_dn(), which already has all the information to hand 
already - again, look at how hw->dtm_idx is managed. Furthermore I'd 
also prefer to similarly not conflate management of the per-event state 
with that of the DTM state (i.e. just have an arm_cmn_set_wp_idx() for 
updating the event data).

>   }
>   
>   static u32 arm_cmn_wp_config(struct perf_event *event)
> @@ -1519,12 +1568,16 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
>   		writeq_relaxed(CMN_CC_INIT, cmn->dtc[i].base + CMN_DT_PMCCNTR);
>   		cmn->dtc[i].cc_active = true;
>   	} else if (type == CMN_TYPE_WP) {
> -		int wp_idx = arm_cmn_wp_idx(event);
>   		u64 val = CMN_EVENT_WP_VAL(event);
>   		u64 mask = CMN_EVENT_WP_MASK(event);
>   
>   		for_each_hw_dn(hw, dn, i) {
>   			void __iomem *base = dn->pmu_base + CMN_DTM_OFFSET(hw->dtm_offset);
> +			int wp_idx;
> +
> +			wp_idx = arm_cmn_get_assigned_wp_idx(cmn, dn, event, hw);
> +			if (wp_idx < 0)
> +				return;
>   
>   			writeq_relaxed(val, base + CMN_DTM_WPn_VAL(wp_idx));
>   			writeq_relaxed(mask, base + CMN_DTM_WPn_MASK(wp_idx));
> @@ -1549,10 +1602,13 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
>   		i = hw->dtc_idx[0];
>   		cmn->dtc[i].cc_active = false;
>   	} else if (type == CMN_TYPE_WP) {
> -		int wp_idx = arm_cmn_wp_idx(event);
> -
>   		for_each_hw_dn(hw, dn, i) {
>   			void __iomem *base = dn->pmu_base + CMN_DTM_OFFSET(hw->dtm_offset);
> +			int wp_idx;
> +
> +			wp_idx = arm_cmn_get_assigned_wp_idx(cmn, dn, event, hw);
> +			if (wp_idx < 0)
> +				continue;
>   
>   			writeq_relaxed(0, base + CMN_DTM_WPn_MASK(wp_idx));
>   			writeq_relaxed(~0ULL, base + CMN_DTM_WPn_VAL(wp_idx));
> @@ -1574,8 +1630,20 @@ struct arm_cmn_val {
>   	bool cycles;
>   };
>   
> -static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
> -				  struct perf_event *event)
> +static int arm_cmn_val_find_free_wp_config(struct perf_event *event,
> +					  struct arm_cmn_val *val, int dtm)
> +{
> +	int wp_idx = CMN_EVENT_EVENTID(event);
> +
> +	if (val->wp[dtm][wp_idx])
> +		if (val->wp[dtm][++wp_idx])
> +			return -ENOSPC;
> +
> +	return wp_idx;
> +}
> +
> +static int arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
> +				 struct perf_event *event)

This must never fail - the purpose of val_add_event is to fill in the 
val structure with the combination of leader and sibling events which 
have *already* passed their own event_init calls been declared valid as 
a group. The body of validate_group then does the "what if?" version to 
test whether the group would remain valid if the *current* event were to 
be added.

The trick with the offset combine value relies on direct indexing to 
work, so I think we need to rejig the structure slightly to track 
distinct wp_count and wp_combine values (per direction) - that then 
becomes nicely consistent with the relationship between dtm_count and 
occupid, too.

>   {
>   	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
>   	struct arm_cmn_node *dn;
> @@ -1583,12 +1651,12 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
>   	int i;
>   
>   	if (is_software_event(event))
> -		return;
> +		return 0;
>   
>   	type = CMN_EVENT_TYPE(event);
>   	if (type == CMN_TYPE_DTC) {
>   		val->cycles = true;
> -		return;
> +		return 0;
>   	}
>   
>   	for_each_hw_dtc_idx(hw, dtc, idx)
> @@ -1605,9 +1673,14 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
>   		if (type != CMN_TYPE_WP)
>   			continue;
>   
> -		wp_idx = arm_cmn_wp_idx(event);
> +		wp_idx = arm_cmn_val_find_free_wp_config(event, val, dtm);
> +		if (wp_idx < 0)
> +			return -ENOSPC;
> +
>   		val->wp[dtm][wp_idx] = CMN_EVENT_WP_COMBINE(event) + 1;
>   	}
> +
> +	return 0;
>   }
>   
>   static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
> @@ -1629,9 +1702,15 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
>   	if (!val)
>   		return -ENOMEM;
>   
> -	arm_cmn_val_add_event(cmn, val, leader);
> -	for_each_sibling_event(sibling, leader)
> -		arm_cmn_val_add_event(cmn, val, sibling);
> +	ret = arm_cmn_val_add_event(cmn, val, leader);
> +	if (ret)
> +		goto done;
> +
> +	for_each_sibling_event(sibling, leader) {
> +		ret = arm_cmn_val_add_event(cmn, val, sibling);
> +		if (ret)
> +			goto done;
> +	}
>   
>   	type = CMN_EVENT_TYPE(event);
>   	if (type == CMN_TYPE_DTC) {
> @@ -1656,8 +1735,8 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
>   		if (type != CMN_TYPE_WP)
>   			continue;
>   
> -		wp_idx = arm_cmn_wp_idx(event);
> -		if (val->wp[dtm][wp_idx])
> +		wp_idx = arm_cmn_val_find_free_wp_config(event, val, dtm);
> +		if (wp_idx < 0)
>   			goto done;
>   
>   		wp_cmb = val->wp[dtm][wp_idx ^ 1];
> @@ -1772,8 +1851,11 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
>   		struct arm_cmn_dtm *dtm = &cmn->dtms[hw->dn[i].dtm] + hw->dtm_offset;
>   		unsigned int dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
>   
> -		if (type == CMN_TYPE_WP)
> -			dtm->wp_event[arm_cmn_wp_idx(event)] = -1;
> +		if (type == CMN_TYPE_WP) {
> +			int wp_idx = arm_cmn_get_assigned_wp_idx(cmn, &hw->dn[i], event, hw);
> +
> +			dtm->wp_event[wp_idx] = -1;
> +		}
>   
>   		if (hw->filter_sel > SEL_NONE)
>   			hw->dn[i].occupid[hw->filter_sel].count--;
> @@ -1782,6 +1864,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
>   		writel_relaxed(dtm->pmu_config_low, dtm->base + CMN_DTM_PMU_CONFIG);
>   	}
>   	memset(hw->dtm_idx, 0, sizeof(hw->dtm_idx));
> +	bitmap_zero(hw->wp_cfg, 2 * CMN_MAX_XPS);

Nit: I'd rather do this in terms of sizeof() so it's harder to break in 
future. And since it's going to end up being a memset() anyway I'd then 
probably just open-code that rather than mucking about with 
bytes-to-bits calculations.

>   	for_each_hw_dtc_idx(hw, j, idx)
>   		cmn->dtc[j].counters[idx] = NULL;
> @@ -1835,10 +1918,11 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
>   		if (type == CMN_TYPE_XP) {
>   			input_sel = CMN__PMEVCNT0_INPUT_SEL_XP + dtm_idx;
>   		} else if (type == CMN_TYPE_WP) {
> -			int tmp, wp_idx = arm_cmn_wp_idx(event);
> +			int tmp, wp_idx;
>   			u32 cfg = arm_cmn_wp_config(event);
>   
> -			if (dtm->wp_event[wp_idx] >= 0)
> +			wp_idx = arm_cmn_find_free_wp_idx(cmn, dtm, event);
> +			if (wp_idx < 0)

TBH I'm not convinced it's even worth factoring out the "allocator" 
here, since inline it can be as simple as:

	int tmp, wp_idx = CMN_EVENT_EVENTID(event);
	...
	if (dtm->wp_event[wp_idx] && dtm->wp_event[++wp_idx])

(or perhaps follow the same while/if shape as for dtm_idx further up, if 
you think it's worth being more clear than concise)

Thanks,
Robin.

>   				goto free_dtms;
>   
>   			tmp = dtm->wp_event[wp_idx ^ 1];
> @@ -1847,7 +1931,8 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
>   				goto free_dtms;
>   
>   			input_sel = CMN__PMEVCNT0_INPUT_SEL_WP + wp_idx;
> -			dtm->wp_event[wp_idx] = hw->dtc_idx[d];
> +
> +			arm_cmn_claim_wp_idx(cmn, dtm, event, dn, wp_idx, d);
>   			writel_relaxed(cfg, dtm->base + CMN_DTM_WPn_CONFIG(wp_idx));
>   		} else {
>   			struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);

