Return-Path: <linux-kernel+bounces-91118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47C48709BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EC61C20F75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500B778B50;
	Mon,  4 Mar 2024 18:38:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BF870044
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577520; cv=none; b=oPUsAUV+bTqJFT7plbACYOpxm+SoMl05Ijgf5IvuESxY3x1Va1R3CcShBsMm3bqmSRFkpbhFoqLWVoErCQqBF5OYrNa56bogssJRP4FyKOWvysB/xrXq4EUXXgSMLlQLR1fjskoTym2kDp+vZM8wLRuUeCT3snkj9iUwTtdl3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577520; c=relaxed/simple;
	bh=s+mVNg+GLebii572qE6sol1/EZNPwnxKAwAdcjSOfxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mloOP7OpiH4QVgM0O47oo1bSPqWbFj+9IFW+M/VjXVdywbn004vLpQ3qG4NehOgNA8cZxMjKqwYFtIsaUfSmqVuVFck9YdN/N9Kc4QRpFg0VqqnXVbaT27n/0KodctCzUxHTbHE2yPn9nWPalpPWeVm1+EOmM5XVA03gvz15OHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D6AB2F4;
	Mon,  4 Mar 2024 10:39:14 -0800 (PST)
Received: from [10.57.68.92] (unknown [10.57.68.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B73A23F738;
	Mon,  4 Mar 2024 10:38:35 -0800 (PST)
Message-ID: <9ed743a7-0c5d-49d9-b8b2-d58364df1f5f@arm.com>
Date: Mon, 4 Mar 2024 18:38:33 +0000
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
 <049818ca-e656-44e4-b336-934992c16028@arm.com>
 <d2fbfdd0-ad61-4fe2-a976-4dac7427bfc9@redhat.com>
 <b642c7ff-c452-4066-ac12-dbf05e215cb9@arm.com>
 <949b6c22-d737-4060-9ca1-a69d8e986d90@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <949b6c22-d737-4060-9ca1-a69d8e986d90@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/03/2024 17:30, David Hildenbrand wrote:
> On 04.03.24 17:03, Ryan Roberts wrote:
>> On 28/02/2024 12:12, David Hildenbrand wrote:
>>>>> How relevant is it? Relevant enough that someone decided to put that
>>>>> optimization in? I don't know :)
>>>>
>>>> I'll have one last go at convincing you: Huang Ying (original author) commented
>>>> "I believe this should be OK.  Better to compare the performance too." at [1].
>>>> That implies to me that perhaps the optimization wasn't in response to a
>>>> specific problem after all. Do you have any thoughts, Huang?
>>>
>>> Might make sense to include that in the patch description!
>>>
>>>> OK so if we really do need to keep this optimization, here are some ideas:
>>>>
>>>> Fundamentally, we would like to be able to figure out the size of the swap slot
>>>> from the swap entry. Today swap supports 2 sizes; PAGE_SIZE and PMD_SIZE. For
>>>> PMD_SIZE, it always uses a full cluster, so can easily add a flag to the
>>>> cluster
>>>> to mark it as PMD_SIZE.
>>>>
>>>> Going forwards, we want to support all sizes (power-of-2). Most of the time, a
>>>> cluster will contain only one size of THPs, but this is not the case when a THP
>>>> in the swapcache gets split or when an order-0 slot gets stolen. We expect
>>>> these
>>>> cases to be rare.
>>>>
>>>> 1) Keep the size of the smallest swap entry in the cluster header. Most of the
>>>> time it will be the full size of the swap entry, but sometimes it will cover
>>>> only a portion. In the latter case you may see a false negative for
>>>> swap_page_trans_huge_swapped() meaning we take the slow path, but that is rare.
>>>> There is one wrinkle: currently the HUGE flag is cleared in
>>>> put_swap_folio(). We
>>>> wouldn't want to do the equivalent in the new scheme (i.e. set the whole
>>>> cluster
>>>> to order-0). I think that is safe, but haven't completely convinced myself yet.
>>>>
>>>> 2) allocate 4 bits per (small) swap slot to hold the order. This will give
>>>> precise information and is conceptually simpler to understand, but will cost
>>>> more memory (half as much as the initial swap_map[] again).
>>>>
>>>> I still prefer to avoid this at all if we can (and would like to hear Huang's
>>>> thoughts). But if its a choice between 1 and 2, I prefer 1 - I'll do some
>>>> prototyping.
>>>
>>> Taking a step back: what about we simply batch unmapping of swap entries?
>>>
>>> That is, if we're unmapping a PTE range, we'll collect swap entries (under PT
>>> lock) that reference consecutive swap offsets in the same swap file.
>>>
>>> There, we can then first decrement all the swap counts, and then try minimizing
>>> how often we actually have to try reclaiming swap space (lookup folio, see it's
>>> a large folio that we cannot reclaim or could reclaim, ...).
>>>
>>> Might need some fine-tuning in swap code to "advance" to the next entry to try
>>> freeing up, but we certainly can do better than what we would do right now.
>>>
>>
>> Hi,
>>
>> I'm struggling to convince myself that free_swap_and_cache() can't race with
>> with swapoff(). Can anyone explain that this is safe?
>>
>> I *think* they are both serialized by the PTL, since all callers of
>> free_swap_and_cache() (except shmem) have the PTL, and swapoff() calls
>> try_to_unuse() early on, which takes the PTL as it iterates over every vma in
>> every mm. It looks like shmem is handled specially by a call to shmem_unuse(),
>> but I can't see the exact serialization mechanism.
> 
> As get_swap_device() documents:
> 
> "if there aren't some other ways to prevent swapoff, such as the folio in swap
> cache is locked, page table lock is held, etc., the swap entry may become
> invalid because of swapoff"
> 
> PTL it is, in theory. But I'm afraid that's half the story.

Ahh I didn't notice that comment - thanks!

> 
>>
>> I've implemented a batching function, as David suggested above, but I'm trying
>> to convince myself that it is safe for it to access si->swap_map[] without a
>> lock (i.e. that swapoff() can't concurrently free it). But I think
>> free_swap_and_cache() as it already exists depends on being able to access the
>> si without an explicit lock, so I'm assuming the same mechanism will protect my
>> new changes. But I want to be sure I understand the mechanism...
> 
> Very valid concern.
> 
>>
>>
>> This is the existing free_swap_and_cache(). I think _swap_info_get() would break
>> if this could race with swapoff(), and __swap_entry_free() looks up the cluster
>> from an array, which would also be freed by swapoff if racing:
>>
>> int free_swap_and_cache(swp_entry_t entry)
>> {
>>     struct swap_info_struct *p;
>>     unsigned char count;
>>
>>     if (non_swap_entry(entry))
>>         return 1;
>>
>>     p = _swap_info_get(entry);
>>     if (p) {
>>         count = __swap_entry_free(p, entry);
> 
> If count dropped to 0 and
> 
>>         if (count == SWAP_HAS_CACHE)
> 
> 
> count is now SWAP_HAS_CACHE, there is in fact no swap entry anymore. We removed
> it. That one would have to be reclaimed asynchronously.
> 
> The existing code we would call swap_page_trans_huge_swapped() with the SI it
> obtained via _swap_info_get().
> 
> I also don't see what should be left protecting the SI. It's not locked anymore,
> the swapcounts are at 0. We don't hold the folio lock.
> 
> try_to_unuse() will stop as soon as si->inuse_pages is at 0. Hm ...

But, assuming the caller of free_swap_and_cache() acquires the PTL first, I
think this all works out ok? While free_swap_and_cache() is running,
try_to_unuse() will wait for the PTL. Or if try_to_unuse() runs first, then
free_swap_and_cache() will never be called because the swap entry will have been
removed from the PTE?

That just leaves shmem... I suspected there might be some serialization between
shmem_unuse() (called from try_to_unuse()) and the shmem free_swap_and_cache()
callsites, but I can't see it. Hmm...

> 
> Would performing the overall operation under lock_cluster_or_swap_info help? Not
> so sure :(

No - that function relies on being able to access the cluster from the array in
the swap_info and lock it. And I think that array has the same lifetime as
swap_map, so same problem. You'd need get_swap_device()/put_swap_device() and a
bunch of refactoring for the internals not to take the locks, I guess. I think
its doable, just not sure if neccessary...



