Return-Path: <linux-kernel+bounces-88698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4478986E587
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F0828272C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440F070CD6;
	Fri,  1 Mar 2024 16:27:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0BA1C33
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310462; cv=none; b=XB/PKe580VFSQ6Q89qgMVaMvKPlE4RswBbJACStcBkQSphV8XDmn8KuAAzuhbCpzwmWft0En+JHXdgaMzObESMwVjNKNmCe70cg0c/z5sIu5Vmdso23A71fhNHh9rsS0ZT05zEquzT/Sp5xoUePXjlQvcvbQKT0/LNrmS5gKLAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310462; c=relaxed/simple;
	bh=jxsdDdqvTdJPGgiXXNsppAPPDpV1z+PHZJz8iNpOySk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKW8gu1wX6Pu0acKMUL8J4xSSyyvkf1OdyrR1ZKg3ICVnFltklMCUE5xLUYDY8b5Y5rivsrkb97RkhhQ7b78oS2+MSF0CGQCjQ58BR4LcEU2s+jYvGEGI8BSQFumjFUTf5C0UGLyxQy+MtA1WUYb97rf3UVtzZDvh8jqJ6ugP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04DCF1FB;
	Fri,  1 Mar 2024 08:28:15 -0800 (PST)
Received: from [10.57.68.58] (unknown [10.57.68.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E37143F73F;
	Fri,  1 Mar 2024 08:27:34 -0800 (PST)
Message-ID: <5ebac77a-5c61-481f-8ac1-03bc4f4e2b1d@arm.com>
Date: Fri, 1 Mar 2024 16:27:32 +0000
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
 <4a73b16e-9317-477a-ac23-8033004b0637@arm.com>
 <1195531c-d985-47e2-b7a2-8895fbb49129@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <1195531c-d985-47e2-b7a2-8895fbb49129@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/02/2024 15:12, David Hildenbrand wrote:
> On 28.02.24 15:57, Ryan Roberts wrote:
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
>>
>> Yes in principle, but there are 4 places where free_swap_and_cache() is called,
>> and only 2 of those are really amenable to batching (zap_pte_range() and
>> madvise_free_pte_range()). So the other two users will still take the "slow"
>> path. Maybe those 2 callsites are the only ones that really matter? I can
>> certainly have a stab at this approach.
> 
> We can ignore the s390x one. That s390x code should only apply to KVM guest
> memory where ordinary THP are not even supported. (and nobody uses mTHP there yet).
> 
> Long story short: the VM can hint that some memory pages are now unused and the
> hypervisor can reclaim them. That's what that callback does (zap guest-provided
> guest memory). No need to worry about any batching for now.
> 
> Then, there is the shmem one in shmem_free_swap(). I really don't know how shmem
> handles THP+swapout.
> 
> But looking at shmem_writepage(), we split any large folios before moving them
> to the swapcache, so likely we don't care at all, because THP don't apply.
> 
>>
>>>
>>> There, we can then first decrement all the swap counts, and then try minimizing
>>> how often we actually have to try reclaiming swap space (lookup folio, see it's
>>> a large folio that we cannot reclaim or could reclaim, ...).
>>>
>>> Might need some fine-tuning in swap code to "advance" to the next entry to try
>>> freeing up, but we certainly can do better than what we would do right now.
>>
>> I'm not sure I've understood this. Isn't advancing just a matter of:
>>
>> entry = swp_entry(swp_type(entry), swp_offset(entry) + 1);
> 
> I was talking about the advancing swapslot processing after decrementing the
> swapcounts.
> 
> Assume you decremented 512 swapcounts and some of them went to 0. AFAIU, you'd
> have to start with the first swapslot that has now a swapcount=0 one and try to
> reclaim swap.
> 
> Assume you get a small folio, then you'll have to proceed with the next swap
> slot and try to reclaim swap.
> 
> Assume you get a large folio, then you can skip more swapslots (depending on
> offset into the folio etc).
> 
> If you get what I mean. :)
> 

I've implemented the batching as David suggested, and I'm pretty confident it's
correct. The only problem is that during testing I can't provoke the code to
take the path. I've been pouring through the code but struggling to figure out
under what situation you would expect the swap entry passed to
free_swap_and_cache() to still have a cached folio? Does anyone have any idea?

This is the original (unbatched) function, after my change, which caused David's
concern that we would end up calling __try_to_reclaim_swap() far too much:

int free_swap_and_cache(swp_entry_t entry)
{
	struct swap_info_struct *p;
	unsigned char count;

	if (non_swap_entry(entry))
		return 1;

	p = _swap_info_get(entry);
	if (p) {
		count = __swap_entry_free(p, entry);
		if (count == SWAP_HAS_CACHE)
			__try_to_reclaim_swap(p, swp_offset(entry),
					      TTRS_UNMAPPED | TTRS_FULL);
	}
	return p != NULL;
}

The trouble is, whenever its called, count is always 0, so
__try_to_reclaim_swap() never gets called.

My test case is allocating 1G anon memory, then doing madvise(MADV_PAGEOUT) over
it. Then doing either a munmap() or madvise(MADV_FREE), both of which cause this
function to be called for every PTE, but count is always 0 after
__swap_entry_free() so __try_to_reclaim_swap() is never called. I've tried for
order-0 as well as PTE- and PMD-mapped 2M THP.

I'm guessing the swapcache was already reclaimed as part of MADV_PAGEOUT? I'm
using a block ram device as my backing store - I think this does synchronous IO
so perhaps if I have a real block device with async IO I might have more luck?
Just a guess...

Or perhaps this code path is a corner case? In which case, perhaps its not worth
adding the batching optimization after all?

Thanks,
Ryan


