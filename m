Return-Path: <linux-kernel+bounces-43185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B7A840D42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A853B25C12
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3760415AAAA;
	Mon, 29 Jan 2024 17:07:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404166166D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548072; cv=none; b=u4Vo0nLI+Die/w/fQFSDI0v1tdjJ2MAAGry1JXIZ+6eUJjLhCvLccF5/g3nKG/RbykJcJXb5ZLbo6eqfP7fYaPOHHx8AA6EUWw1pE35mNSsB/jSj66UQAJKriNNANql3FqrSKZlwfcRMMTrOZS2IS2Lq7G2pJ8IVOqgKpCSZxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548072; c=relaxed/simple;
	bh=ztUZhYu4cJ+2Ais77SXBMRY7jNrgEZe37F6IuGLKA14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg08vNf4Z8N0p+MEnM41gqXUnuNMEJcakuTpE0TCzDYxvzoJlOxNf5B4PqV1HrO42nIf0WdPAjZD0UokZVGbMPbEXRJk/iXiPHxu8DlRpQq8HjHB7wQyUqCqKRpbAR83mEhL5DqsTj3b9uuppfgmc8FKhdXMhryKiFeoVJyuUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E1B8DA7;
	Mon, 29 Jan 2024 09:08:33 -0800 (PST)
Received: from [10.57.77.253] (unknown [10.57.77.253])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 330813F738;
	Mon, 29 Jan 2024 09:07:48 -0800 (PST)
Message-ID: <154b01c4-2ce3-4b85-abb6-b3baffe4f272@arm.com>
Date: Mon, 29 Jan 2024 17:07:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf/arm-cmn: Enable support for tertiary match group
Content-Language: en-GB
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240126221215.1537377-1-ilkka@os.amperecomputing.com>
 <20240126221215.1537377-4-ilkka@os.amperecomputing.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240126221215.1537377-4-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-26 10:12 pm, Ilkka Koskinen wrote:
> Add support for tertiary match group.
 >
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   drivers/perf/arm-cmn.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index dc6370396ad0..ce9fbdcf6144 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -91,10 +91,13 @@
>   #define CMN600_WPn_CONFIG_WP_COMBINE	BIT(6)
>   #define CMN600_WPn_CONFIG_WP_EXCLUSIVE	BIT(5)
>   #define CMN_DTM_WPn_CONFIG_WP_GRP	GENMASK_ULL(5, 4)
> +#define CMN600_WPn_CONFIG_WP_GRP	BIT(4)
>   #define CMN_DTM_WPn_CONFIG_WP_CHN_SEL	GENMASK_ULL(3, 1)
>   #define CMN_DTM_WPn_CONFIG_WP_DEV_SEL	BIT(0)
>   #define CMN_DTM_WPn_VAL(n)		(CMN_DTM_WPn(n) + 0x08)
>   #define CMN_DTM_WPn_MASK(n)		(CMN_DTM_WPn(n) + 0x10)
> +#define CMN_DTM_WP_CHN_SEL_REQ_VC	0
> +#define CMN_DTM_WP_GRP_TERTIARY		0x2
>   
>   #define CMN_DTM_PMU_CONFIG		0x210
>   #define CMN__PMEVCNT0_INPUT_SEL		GENMASK_ULL(37, 32)
> @@ -175,8 +178,8 @@
>   #define CMN_CONFIG_WP_DEV_SEL		GENMASK_ULL(50, 48)
>   #define CMN_CONFIG_WP_CHN_SEL		GENMASK_ULL(55, 51)
>   /* Note that we don't yet support the tertiary match group on newer IPs */
> -#define CMN_CONFIG_WP_GRP		BIT_ULL(56)
> -#define CMN_CONFIG_WP_EXCLUSIVE		BIT_ULL(57)
> +#define CMN_CONFIG_WP_GRP		GENMASK_ULL(57, 56)
> +#define CMN_CONFIG_WP_EXCLUSIVE		BIT_ULL(58)
>   #define CMN_CONFIG1_WP_VAL		GENMASK_ULL(63, 0)
>   #define CMN_CONFIG2_WP_MASK		GENMASK_ULL(63, 0)
>   
> @@ -1298,7 +1301,9 @@ static struct attribute *arm_cmn_format_attrs[] = {
>   
>   	CMN_FORMAT_ATTR(CMN_ANY, wp_dev_sel, CMN_CONFIG_WP_DEV_SEL),
>   	CMN_FORMAT_ATTR(CMN_ANY, wp_chn_sel, CMN_CONFIG_WP_CHN_SEL),
> -	CMN_FORMAT_ATTR(CMN_ANY, wp_grp, CMN_CONFIG_WP_GRP),
> +	CMN_FORMAT_ATTR(CMN600, wp_grp, CMN600_WPn_CONFIG_WP_GRP),

Perhaps an easy confusion, but 4 != 56: CMN_CONFIG_WP_* represent 
perf_event->config{,1,2} attribute fields per the CMN_CONFIG_* pattern, 
whereas CMN*_WPn_CONFIG_* are hardware register fields where "config" is 
just annoygingly part of the register name.

> +	CMN_FORMAT_ATTR(NOT_CMN600, wp_grp, CMN_CONFIG_WP_GRP),

Hmm, I'm sure last time I tried something like this, sysfs wouldn't let 
two attributes with the same name exist, regardless of whether one was 
meant to be hidden :/

TBH I think that either we change ABI for everyone consistently, or we 
extend the field in a backwards-compatible way. If you think an ABI 
break would affect existing CMN-600 users, then surely at stands to 
affect existing CMN-650 and CMN-700 users just as much?

> +
>   	CMN_FORMAT_ATTR(CMN_ANY, wp_exclusive, CMN_CONFIG_WP_EXCLUSIVE),
>   	CMN_FORMAT_ATTR(CMN_ANY, wp_combine, CMN_CONFIG_WP_COMBINE),
>   
> @@ -1398,8 +1403,11 @@ static u32 arm_cmn_wp_config(struct perf_event *event)
>   
>   	config = FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL, dev) |
>   		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_CHN_SEL, chn) |
> -		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_GRP, grp) |
>   		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL2, dev >> 1);
> +
> +	if (grp)
> +		config |= is_cmn600 ? CMN600_WPn_CONFIG_WP_GRP :
> +				      FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_GRP, grp);

FWIW I think something more like "if (is_cmn600) grp &= 1;" before the 
existing assignent might be clearer. Note that that *is* effectively how 
this works already since CMN_DTM_WPn_CONFIG_WP_GRP was updated, it's 
just currently implicit in CMN_EVENT_WP_GRP().

>   	if (exc)
>   		config |= is_cmn600 ? CMN600_WPn_CONFIG_WP_EXCLUSIVE :
>   				      CMN_DTM_WPn_CONFIG_WP_EXCLUSIVE;

You've missed the "(combine && !grp)" logic below this point, which also 
needs to get rather more involved if a combined match across groups 1 
and 2 is going to work correctly.

> @@ -1764,6 +1772,13 @@ static int arm_cmn_event_init(struct perf_event *event)
>   		/* ...and we need a "real" direction */
>   		if (eventid != CMN_WP_UP && eventid != CMN_WP_DOWN)
>   			return -EINVAL;
> +
> +		if (cmn->part != PART_CMN600)
> +			if (CMN_EVENT_WP_GRP(event) > CMN_DTM_WP_GRP_TERTIARY ||
> +			    (CMN_EVENT_WP_GRP(event) == CMN_DTM_WP_GRP_TERTIARY &&
> +			     CMN_EVENT_WP_CHN_SEL(event) != CMN_DTM_WP_CHN_SEL_REQ_VC))
> +				return -EINVAL;
> +

We already don't attempt to sanity-check watchpoint arguments (e.g. 
chn>3 or chn=1,grp=1), so I'm not really inclined to start. The aim here 
has always been not to try to understand watchpoints at all, and 
effectively just pass through the register interface to the user.

Thanks,
Robin.

>   		/* ...but the DTM may depend on which port we're watching */
>   		if (cmn->multi_dtm)
>   			hw->dtm_offset = CMN_EVENT_WP_DEV_SEL(event) / 2;

