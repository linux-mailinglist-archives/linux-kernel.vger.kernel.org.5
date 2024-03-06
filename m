Return-Path: <linux-kernel+bounces-93509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60BE8730D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A8F1C2242A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF605D49C;
	Wed,  6 Mar 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FiHAlf9U"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445B3717C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714139; cv=none; b=SNhl2hV65/Mbpz4RaDymGfbKTc1fB16XyQE4ld51rhY8JFuEM0CwKj3sepJzEsI6uT3Dbbi9xWVawwWlXoBSAx0kPEQckly89qub1GvM80zI2URwKRR52R9D0ZwhRN2lqRKSknSLWvI5PXxgIMm4q3J78/2ojF3VjcsQryXrgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714139; c=relaxed/simple;
	bh=/zr+nlOLoKkQZHEZxMv8AAnkpzitAkfbt4UPgrYjYAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knnjjoAD5sBCMIsPiz4E6437pB16t/ooBjs9NmuF8imQPAY+Lkryvvx2DDa0mul5tFW2OwfkpG8mKLnShRBBxrUe80R4VDeQLsHLGKIkwcnxVs2t8HKl+Jfuxte3lM6nVKZuRcydqXdCEWwv+BIVlhUqLCI3d9R6g1EPQ+MVF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FiHAlf9U; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709714128; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Vl0gQbnZXGNiKyFtfyQ7GeBCGUn8kVJwcHSVyAumDv0=;
	b=FiHAlf9UBSHwcEta+OnDlkfZdn/u5GM1f3+AbXlpT9RA5nT7yoBj13YmNqt3J6rp+cV3OZ3eiam4bWDkDgPRX3O1fa7fOHDUx5yFaJkc12zpSlbi4BnIh1IlF/CI510le2W9TJ98osuNveWCCNadA6umeD4sWWU3IgUP0i96WQY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1wtLBh_1709714126;
Received: from 30.97.56.47(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W1wtLBh_1709714126)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 16:35:27 +0800
Message-ID: <3eda72bd-25ad-4518-b38e-b63f75e5e94d@linux.alibaba.com>
Date: Wed, 6 Mar 2024 16:35:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm: hugetlb: make the hugetlb migration strategy
 consistent
To: Oscar Salvador <osalvador@suse.de>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
 linmiaohe@huawei.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1709041586.git.baolin.wang@linux.alibaba.com>
 <bdca97e6c59f1b58f09e18defac0c47d1e38f44b.1709041586.git.baolin.wang@linux.alibaba.com>
 <Zd38_AYtr9QKp-F6@localhost.localdomain>
 <8d35b8ae-b8d8-4237-bfcf-ed63c0bb4223@linux.alibaba.com>
 <Zd7xnrzGb_8QiqcE@localhost.localdomain>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Zd7xnrzGb_8QiqcE@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/28 16:41, Oscar Salvador wrote:
> On Wed, Feb 28, 2024 at 03:40:08PM +0800, Baolin Wang wrote:
>>
>>
>> On 2024/2/27 23:17, Oscar Salvador wrote:
>>> On Tue, Feb 27, 2024 at 09:52:26PM +0800, Baolin Wang wrote:
>>>
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -2567,13 +2567,38 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
>>>>    }
>>>>    static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mask,
>>>> -				     int nid, nodemask_t *nmask)
>>>> +				     int nid, nodemask_t *nmask, int reason)
>>>
>>> I still dislike taking the reason argument this far, and I'd rather have
>>> this as a boolean specifing whether we allow fallback on other nodes.
>>> That would mean parsing the reason in alloc_migration_target().
>>> If we don't add a new helper e.g: gfp_allow_fallback(), we can just do
>>> it right there an opencode it with a e.g: macro etc.
>>>
>>> Although doing it in an inline helper might help hiding these details.
>>>
>>> That's my take on this, but let's see what others have to say.
>>
>> Sure. I also expressed my preference for hiding these details within the
>> hugetlb core as much as possible.
>>
>> Muchun, what do you think? Thanks.
> 
> JFTR: I'm talking about https://lore.kernel.org/linux-mm/ZdxXLTDZn8fD3pEn@localhost.localdomain/
> or maybe something cleaner which doesn't need a new helper (we could if
> we want though):
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index c1ee640d87b1..ddd794e861e6 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -73,6 +73,16 @@ struct resv_map {
>   #endif
>   };
> 
> +#define MIGRATE_MEMORY_HOTPLUG	1UL << MR_MEMORY_HOTPLUG
> +#define MIGRATE_MEMORY_FAILURE	1UL << MR_MEMORY_FAILURE
> +#define MIGRATE_SYSCALL		1UL << MR_SYSCALL
> +#define MIGRATE_MBIND		1UL << MR_MEMPOLICY_MBIND
> +#define HTLB_ALLOW_FALLBACK	(MIGRATE_MEMORY_HOTPLUG| \
> +				 MIGRATE_MEMORY_FAILURE| \
> +				 MIGRATE_SYSCALL| \
> +				 MIGRATE_MBIND)
> +
> +
>   /*
>    * Region tracking -- allows tracking of reservations and instantiated pages
>    *                    across the pages in a mapping.
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ed1581b670d4..7e8d6b5885d6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2619,7 +2619,7 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
> 
>   /* folio migration callback function */
>   struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
> -		nodemask_t *nmask, gfp_t gfp_mask)
> +		nodemask_t *nmask, gfp_t gfp_mask, bool allow_fallback)
>   {
>   	spin_lock_irq(&hugetlb_lock);
>   	if (available_huge_pages(h)) {
> @@ -2634,6 +2634,12 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
>   	}
>   	spin_unlock_irq(&hugetlb_lock);
> 
> +	/*
> +	 * We cannot fallback to other nodes, as we could break the per-node pool
> +	 */
> +	if (!allow_fallback)
> +		gfp_mask |= GFP_THISNODE; > +
>   	return alloc_migrate_hugetlb_folio(h, gfp_mask, preferred_nid, nmask);
>   }
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index cc9f2bcd73b4..c1f1d011629d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2016,10 +2016,15 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
> 
>   	if (folio_test_hugetlb(src)) {
>   		struct hstate *h = folio_hstate(src);
> +		bool allow_fallback = false;
> +
> +		if ((1UL << reason) & HTLB_ALLOW_FALLBACK)
> +			allow_fallback = true;

IMHO, users also should not be aware of these hugetlb logics.

> 
>   		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
>   		return alloc_hugetlb_folio_nodemask(h, nid,
> -						mtc->nmask, gfp_mask);
> +						mtc->nmask, gfp_mask,
> +						allow_fallback);

'allow_fallback' can be confusing, that means it is 'allow_fallback' for 
a new temporary hugetlb allocation, but not 'allow_fallback' for an 
available hugetlb allocation in alloc_hugetlb_folio_nodemask().

