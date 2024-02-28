Return-Path: <linux-kernel+bounces-84777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E11386AB72
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF212840E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1A12E635;
	Wed, 28 Feb 2024 09:37:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829E32D054
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113034; cv=none; b=jk/TCWglphAAe5f2PQxU59kxrfka6aIdyU50BJFvpncK4uWRUrnM/7o2JoohHCa6mwHQTuwB5hVw9TI+WyQIe1QDQ0NKbJhzmcXoXvoJKLbDIZ1qmlYUBRq1rs1JV4j8HI1PklWSbRuJZ9NNbRteEhDFjlJLciPRGcAl30O6a08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113034; c=relaxed/simple;
	bh=bLlJUeiMggHhQeyotaPXhZna+Tl8qrG+wqhxIdOlvrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdkfUyk8ipouqoBhNrwYfBhbpxtd77l31vlvpMVtpnuvxiOCFLE8pJRvLU0Vcc+vnAFfQAnZeQGb2Tb5DAFP3qXmvo7TLVN+YWwafiYCbhvRmvGsTTmk0RJ1uCATQHmQbV+K00KsAMGVl3rcMJTWfwYALS11ux04qsvCTN98rTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4BDBC15;
	Wed, 28 Feb 2024 01:37:48 -0800 (PST)
Received: from [10.57.67.95] (unknown [10.57.67.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CA1C3F6C4;
	Wed, 28 Feb 2024 01:37:07 -0800 (PST)
Message-ID: <049818ca-e656-44e4-b336-934992c16028@arm.com>
Date: Wed, 28 Feb 2024 09:37:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20231025144546.577640-2-ryan.roberts@arm.com>
 <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
 <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
 <ba9101ae-a618-4afc-9515-a61f25376390@arm.com>
 <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David, Huang,


On 27/02/2024 19:17, David Hildenbrand wrote:
> On 27.02.24 18:10, Ryan Roberts wrote:
>> Hi David,
>>
>> On 26/02/2024 17:41, Ryan Roberts wrote:
>>> On 22/02/2024 10:20, David Hildenbrand wrote:
>>>> On 22.02.24 11:19, David Hildenbrand wrote:
>>>>> On 25.10.23 16:45, Ryan Roberts wrote:
>>>>>> As preparation for supporting small-sized THP in the swap-out path,
>>>>>> without first needing to split to order-0, Remove the CLUSTER_FLAG_HUGE,
>>>>>> which, when present, always implies PMD-sized THP, which is the same as
>>>>>> the cluster size.
>>>>>>
>>>>>> The only use of the flag was to determine whether a swap entry refers to
>>>>>> a single page or a PMD-sized THP in swap_page_trans_huge_swapped().
>>>>>> Instead of relying on the flag, we now pass in nr_pages, which
>>>>>> originates from the folio's number of pages. This allows the logic to
>>>>>> work for folios of any order.
>>>>>>
>>>>>> The one snag is that one of the swap_page_trans_huge_swapped() call
>>>>>> sites does not have the folio. But it was only being called there to
>>>>>> avoid bothering to call __try_to_reclaim_swap() in some cases.
>>>>>> __try_to_reclaim_swap() gets the folio and (via some other functions)
>>>>>> calls swap_page_trans_huge_swapped(). So I've removed the problematic
>>>>>> call site and believe the new logic should be equivalent.
>>>>>
>>>>> That is the  __try_to_reclaim_swap() -> folio_free_swap() ->
>>>>> folio_swapped() -> swap_page_trans_huge_swapped() call chain I assume.
>>>>>
>>>>> The "difference" is that you will now (1) get another temporary
>>>>> reference on the folio and (2) (try)lock the folio every time you
>>>>> discard a single PTE of a (possibly) large THP.
>>>>>
>>>>
>>>> Thinking about it, your change will not only affect THP, but any call to
>>>> free_swap_and_cache().
>>>>
>>>> Likely that's not what we want. :/
>>>>
>>>
>>> Is folio_trylock() really that expensive given the code path is already locking
>>> multiple spinlocks, and I don't think we would expect the folio lock to be very
>>> contended?
>>>
>>> I guess filemap_get_folio() could be a bit more expensive, but again, is this
>>> really a deal-breaker?
>>>
>>>
>>> I'm just trying to refamiliarize myself with this series, but I think I ended up
>>> allocating a cluster per cpu per order. So one potential solution would be to
>>> turn the flag into a size and store it in the cluster info. (In fact I think I
>>> was doing that in an early version of this series - will have to look at why I
>>> got rid of that). Then we could avoid needing to figure out nr_pages from the
>>> folio.
>>
>> I ran some microbenchmarks to see if these extra operations cause a performance
>> issue - it all looks OK to me.
> 
> Sorry, I'm drowning in reviews right now. I was hoping to get some of my own
> stuff figured out today ... maybe tomorrow.

No need to apologise - as always I appreciate whatever time you can spare.

> 
>>
>> I modified your "pte-mapped-folio-benchmarks" to add a "munmap-swapped-forked"
>> mode, which prepares the 1G memory mapping by first paging it out with
>> MADV_PAGEOUT, then it forks a child (and keeps that child alive) so that the
>> swap slots have 2 references, then it measures the duration of munmap() in the
>> parent on the entire range. The idea is that free_swap_and_cache() is called for
>> each PTE during munmap(). Prior to my change, swap_page_trans_huge_swapped()
>> will return true, due to the child's references, and __try_to_reclaim_swap() is
>> not called. After my change, we no longer have this short cut.
>>
>> In both cases the results are within 1% (confirmed across multiple runs of 20
>> seconds each):
>>
>> mm-stable: Average: 0.004997
>>   + change: Average: 0.005037
>>
>> (these numbers are for Ampere Altra. I also tested on M2 VM - no regression
>> their either).
>>
>> Do you still have a concern about this change?
> 
> The main concern I had was not about overhead due to atomic operations in the
> non-concurrent case that you are measuring.
> 
> We might now unnecessarily be incrementing the folio refcount and taking
> the folio lock. That will affects large folios in the swapcache now IIUC.
> Small folios should be unaffected.

Yes I think you are right, because `count == SWAP_HAS_CACHE` is already checking
the small page is not swapped. So my perf tests weren't actually doing what I
thought they were.

> 
> The side effects of that can be:
> * Code checking for additional folio reference could now detect some and
>   back out. (the "mapcount + swapcache*folio_nr_pages != folio_refcount"
>   stuff)
> * Code that might really benefit from trylocking the folio might fail to
>   do so.
> 
> For example, splitting a large folio might now fail more often simply
> because some process zaps a swap entry and the additional reference+page
> lock were optimized out previously.

Understood. Of course this is the type of fuzzy reasoning that is very dificult
to test objectively :). But it makes sense and I suppose I'll have to come up
with an alternative approach (see below).

> 
> How relevant is it? Relevant enough that someone decided to put that
> optimization in? I don't know :)

I'll have one last go at convincing you: Huang Ying (original author) commented
"I believe this should be OK.  Better to compare the performance too." at [1].
That implies to me that perhaps the optimization wasn't in response to a
specific problem after all. Do you have any thoughts, Huang?

[1]
https://lore.kernel.org/linux-mm/87v8bdfvtj.fsf@yhuang6-desk2.ccr.corp.intel.com/

> 
> Arguably, zapping a present PTE also leaves the refcount elevated for a while
> until the mapcount was freed. But here, it could be avoided.
> 
> Digging a bit, it was introduced in:
> 
> commit e07098294adfd03d582af7626752255e3d170393
> Author: Huang Ying <ying.huang@intel.com>
> Date:   Wed Sep 6 16:22:16 2017 -0700
> 
>     mm, THP, swap: support to reclaim swap space for THP swapped out
>         The normal swap slot reclaiming can be done when the swap count reaches
>     SWAP_HAS_CACHE.  But for the swap slot which is backing a THP, all swap
>     slots backing one THP must be reclaimed together, because the swap slot
>     may be used again when the THP is swapped out again later.  So the swap
>     slots backing one THP can be reclaimed together when the swap count for
>     all swap slots for the THP reached SWAP_HAS_CACHE.  In the patch, the
>     functions to check whether the swap count for all swap slots backing one
>     THP reached SWAP_HAS_CACHE are implemented and used when checking
>     whether a swap slot can be reclaimed.
>         To make it easier to determine whether a swap slot is backing a THP, a
>     new swap cluster flag named CLUSTER_FLAG_HUGE is added to mark a swap
>     cluster which is backing a THP (Transparent Huge Page).  Because THP
>     swap in as a whole isn't supported now.  After deleting the THP from the
>     swap cache (for example, swapping out finished), the CLUSTER_FLAG_HUGE
>     flag will be cleared.  So that, the normal pages inside THP can be
>     swapped in individually.

Thanks. I did this same archaeology, but found nothing pointing to the rationale
for this optimization, so decided that if its undocumented, then it probably
wasn't critical.

> 
> 
> With your change, if we have a swapped out THP with 512 entries and exit(), we
> would now 512 times in a row grab a folio reference and trylock the folio. In the
> past, we would have done that at most once.
> 
> That doesn't feel quite right TBH ... so I'm wondering if there are any low-hanging
> fruits to avoid that.
> 

OK so if we really do need to keep this optimization, here are some ideas:

Fundamentally, we would like to be able to figure out the size of the swap slot
from the swap entry. Today swap supports 2 sizes; PAGE_SIZE and PMD_SIZE. For
PMD_SIZE, it always uses a full cluster, so can easily add a flag to the cluster
to mark it as PMD_SIZE.

Going forwards, we want to support all sizes (power-of-2). Most of the time, a
cluster will contain only one size of THPs, but this is not the case when a THP
in the swapcache gets split or when an order-0 slot gets stolen. We expect these
cases to be rare.

1) Keep the size of the smallest swap entry in the cluster header. Most of the
time it will be the full size of the swap entry, but sometimes it will cover
only a portion. In the latter case you may see a false negative for
swap_page_trans_huge_swapped() meaning we take the slow path, but that is rare.
There is one wrinkle: currently the HUGE flag is cleared in put_swap_folio(). We
wouldn't want to do the equivalent in the new scheme (i.e. set the whole cluster
to order-0). I think that is safe, but haven't completely convinced myself yet.

2) allocate 4 bits per (small) swap slot to hold the order. This will give
precise information and is conceptually simpler to understand, but will cost
more memory (half as much as the initial swap_map[] again).

I still prefer to avoid this at all if we can (and would like to hear Huang's
thoughts). But if its a choice between 1 and 2, I prefer 1 - I'll do some
prototyping.

Thanks,
Ryan


