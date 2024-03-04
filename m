Return-Path: <linux-kernel+bounces-90598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA4E8701FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC731C225E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5347F3D540;
	Mon,  4 Mar 2024 13:03:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5322D3D3B3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557424; cv=none; b=sjdmzQ5zCTbARx95Q6Fd0ZpwroW90xQl9ysNoY04vLxJLXgAbua9McQ3J+e4dJMTGWHBR1Nbmtc1ZThvcj+4AX8I4ore5yyV/b1b2xC3Vpai/bFN3HlzDtdOiLLgFoZNK+GJYSq5+7V3XrfcCuVqZum9jTwYEZ+mnEBVtaIYHN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557424; c=relaxed/simple;
	bh=7cl4FPNqOQXj1RabGbRHyLtu3H/T0pm8uuwUVWGp47M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTN7HxPdpaYyFV+ffN9o/ht4rW8Tyk3xTT8Nv0nCNkl8rLeujMnymtBnE3GSvn+4zl4c1fl8h5GbJkZ/8bmQIQ9rPXP3+BWCeLODRrtC8/m0h7l8UetgRPY1rUabqiGPuBbs0z0bEDwTl6nRDyT+pwHiV3GvEZGBMsTTJWwl0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F0481FB;
	Mon,  4 Mar 2024 05:04:18 -0800 (PST)
Received: from [10.57.68.92] (unknown [10.57.68.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91A453F738;
	Mon,  4 Mar 2024 05:03:38 -0800 (PST)
Message-ID: <10f9542e-f3d8-42b0-9de4-9867cab997b9@arm.com>
Date: Mon, 4 Mar 2024 13:03:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: chrisl@kernel.org, yuzhao@google.com, hanchuanhua@oppo.com,
 linux-kernel@vger.kernel.org, willy@infradead.org, ying.huang@intel.com,
 xiang@kernel.org, mhocko@suse.com, shy828301@gmail.com,
 wangkefeng.wang@huawei.com, Barry Song <v-songbaohua@oppo.com>,
 Hugh Dickins <hughd@google.com>
References: <20240304103757.235352-1-21cnbao@gmail.com>
 <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
 <37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/03/2024 12:41, David Hildenbrand wrote:
> On 04.03.24 13:20, Ryan Roberts wrote:
>> Hi Barry,
>>
>> On 04/03/2024 10:37, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> page_vma_mapped_walk() within try_to_unmap_one() races with other
>>> PTEs modification such as break-before-make, while iterating PTEs
>>> of a large folio, it will only begin to acquire PTL after it gets
>>> a valid(present) PTE. break-before-make intermediately sets PTEs
>>> to pte_none. Thus, a large folio's PTEs might be partially skipped
>>> in try_to_unmap_one().
>>
>> I just want to check my understanding here - I think the problem occurs for
>> PTE-mapped, PMD-sized folios as well as smaller-than-PMD-size large folios? Now
>> that I've had a look at the code and have a better understanding, I think that
>> must be the case? And therefore this problem exists independently of my work to
>> support swap-out of mTHP? (From your previous report I was under the impression
>> that it only affected mTHP).
>>
>> Its just that the problem is becoming more pronounced because with mTHP,
>> PTE-mapped large folios are much more common?
> 
> That is my understanding.
> 
>>
>>> For example, for an anon folio, after try_to_unmap_one(), we may
>>> have PTE0 present, while PTE1 ~ PTE(nr_pages - 1) are swap entries.
>>> So folio will be still mapped, the folio fails to be reclaimed.
>>> What’s even more worrying is, its PTEs are no longer in a unified
>>> state. This might lead to accident folio_split() afterwards. And
>>> since a part of PTEs are now swap entries, accessing them will
>>> incur page fault - do_swap_page.
>>> It creates both anxiety and more expense. While we can't avoid
>>> userspace's unmap to break up unified PTEs such as CONT-PTE for
>>> a large folio, we can indeed keep away from kernel's breaking up
>>> them due to its code design.
>>> This patch is holding PTL from PTE0, thus, the folio will either
>>> be entirely reclaimed or entirely kept. On the other hand, this
>>> approach doesn't increase PTL contention. Even w/o the patch,
>>> page_vma_mapped_walk() will always get PTL after it sometimes
>>> skips one or two PTEs because intermediate break-before-makes
>>> are short, according to test. Of course, even w/o this patch,
>>> the vast majority of try_to_unmap_one still can get PTL from
>>> PTE0. This patch makes the number 100%.
>>> The other option is that we can give up in try_to_unmap_one
>>> once we find PTE0 is not the first entry we get PTL, we call
>>> page_vma_mapped_walk_done() to end the iteration at this case.
>>> This will keep the unified PTEs while the folio isn't reclaimed.
>>> The result is quite similar with small folios with one PTE -
>>> either entirely reclaimed or entirely kept.
>>> Reclaiming large folios by holding PTL from PTE0 seems a better
>>> option comparing to giving up after detecting PTL begins from
>>> non-PTE0.
>>>
> 
> I'm sure that wall of text can be formatted in a better way :) . Also, I think
> we can drop some of the details,
> 
> If you need some inspiration, I can give it a shot.
> 
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>
>> Do we need a Fixes tag?
>>
> 
> What would be the description of the problem we are fixing?
> 
> 1) failing to unmap?
> 
> That can happen with small folios as well IIUC.
> 
> 2) Putting the large folio on the deferred split queue?
> 
> That sounds more reasonable.

Isn't the real problem today that we can end up writng a THP to the swap file
(so 2M more IO and space used) but we can't remove it from memory, so no actual
reclaim happens? Although I guess your (2) is really just another way of saying
that.

> 
>>> ---
>>>   mm/vmscan.c | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 0b888a2afa58..e4722fbbcd0c 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -1270,6 +1270,17 @@ static unsigned int shrink_folio_list(struct list_head
>>> *folio_list,
>>>                 if (folio_test_pmd_mappable(folio))
>>>                   flags |= TTU_SPLIT_HUGE_PMD;
>>> +            /*
>>> +             * if page table lock is not held from the first PTE of
>>> +             * a large folio, some PTEs might be skipped because of
>>> +             * races with break-before-make, for example, PTEs can
>>> +             * be pte_none intermediately, thus one or more PTEs
>>> +             * might be skipped in try_to_unmap_one, we might result
>>> +             * in a large folio is partially mapped and partially
>>> +             * unmapped after try_to_unmap
>>> +             */
>>> +            if (folio_test_large(folio))
>>> +                flags |= TTU_SYNC;
>>
>> This looks sensible to me after thinking about it for a while. But I also have a
>> gut feeling that there might be some more subtleties that are going over my
>> head, since I'm not expert in this area. So will leave others to provide R-b :)
>>
> 
> As we are seeing more such problems with lockless PT walks, maybe we really want
> some other special value (nonswap entry?) to indicate that a PTE this is
> currently ondergoing protection changes. So we'd avoid the pte_none()
> temporarily, if possible.
> 
> Without that, TTU_SYNC feels like the right thing to do.
> 


