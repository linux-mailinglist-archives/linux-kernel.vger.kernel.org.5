Return-Path: <linux-kernel+bounces-90890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E6E870672
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967ED1F28021
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A01D482DA;
	Mon,  4 Mar 2024 16:04:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EF145BFD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568240; cv=none; b=ciVTYqPXHZcok/HtVJF0hdcybqlzE8+EkIbsfmxZf8VFMEq8F9B6nRqLyXxxRcjoy9ojfJBMlpBn8/fcsxgy1hkH7o5gE0exv/1LasPjtq5IGALDZE+IotRWYigk43J2Wy8dEdkjYgZ9Gk+NRjWK7d3zLeZRP4pDg5pEZKFy2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568240; c=relaxed/simple;
	bh=oEcirPU6Hl14sSXYPX5Jx9oja/EinwImeUB5SopFd2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtDvY9qmiTKZPfV+/9lz+0ML96NBwq8KwebbaalIdNQfMw2IRTltTcfuuNyzACeme8aan7mrblfIDPyoN77EzESJUQgX486Iu7nDijVFS7Vj+xMQvAn6qG1nVcWKW8lSyDKh8EnfYabwNWTqNuQTxSVDeSwwhSwv7DHUU++58hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C586E1FB;
	Mon,  4 Mar 2024 08:04:34 -0800 (PST)
Received: from [10.57.68.92] (unknown [10.57.68.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13BA23F73F;
	Mon,  4 Mar 2024 08:03:54 -0800 (PST)
Message-ID: <b642c7ff-c452-4066-ac12-dbf05e215cb9@arm.com>
Date: Mon, 4 Mar 2024 16:03:53 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d2fbfdd0-ad61-4fe2-a976-4dac7427bfc9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/02/2024 12:12, David Hildenbrand wrote:
>>> How relevant is it? Relevant enough that someone decided to put that
>>> optimization in? I don't know :)
>>
>> I'll have one last go at convincing you: Huang Ying (original author) commented
>> "I believe this should be OK.  Better to compare the performance too." at [1].
>> That implies to me that perhaps the optimization wasn't in response to a
>> specific problem after all. Do you have any thoughts, Huang?
> 
> Might make sense to include that in the patch description!
> 
>> OK so if we really do need to keep this optimization, here are some ideas:
>>
>> Fundamentally, we would like to be able to figure out the size of the swap slot
>> from the swap entry. Today swap supports 2 sizes; PAGE_SIZE and PMD_SIZE. For
>> PMD_SIZE, it always uses a full cluster, so can easily add a flag to the cluster
>> to mark it as PMD_SIZE.
>>
>> Going forwards, we want to support all sizes (power-of-2). Most of the time, a
>> cluster will contain only one size of THPs, but this is not the case when a THP
>> in the swapcache gets split or when an order-0 slot gets stolen. We expect these
>> cases to be rare.
>>
>> 1) Keep the size of the smallest swap entry in the cluster header. Most of the
>> time it will be the full size of the swap entry, but sometimes it will cover
>> only a portion. In the latter case you may see a false negative for
>> swap_page_trans_huge_swapped() meaning we take the slow path, but that is rare.
>> There is one wrinkle: currently the HUGE flag is cleared in put_swap_folio(). We
>> wouldn't want to do the equivalent in the new scheme (i.e. set the whole cluster
>> to order-0). I think that is safe, but haven't completely convinced myself yet.
>>
>> 2) allocate 4 bits per (small) swap slot to hold the order. This will give
>> precise information and is conceptually simpler to understand, but will cost
>> more memory (half as much as the initial swap_map[] again).
>>
>> I still prefer to avoid this at all if we can (and would like to hear Huang's
>> thoughts). But if its a choice between 1 and 2, I prefer 1 - I'll do some
>> prototyping.
> 
> Taking a step back: what about we simply batch unmapping of swap entries?
> 
> That is, if we're unmapping a PTE range, we'll collect swap entries (under PT
> lock) that reference consecutive swap offsets in the same swap file.
> 
> There, we can then first decrement all the swap counts, and then try minimizing
> how often we actually have to try reclaiming swap space (lookup folio, see it's
> a large folio that we cannot reclaim or could reclaim, ...).
> 
> Might need some fine-tuning in swap code to "advance" to the next entry to try
> freeing up, but we certainly can do better than what we would do right now.
> 

Hi,

I'm struggling to convince myself that free_swap_and_cache() can't race with
with swapoff(). Can anyone explain that this is safe?

I *think* they are both serialized by the PTL, since all callers of
free_swap_and_cache() (except shmem) have the PTL, and swapoff() calls
try_to_unuse() early on, which takes the PTL as it iterates over every vma in
every mm. It looks like shmem is handled specially by a call to shmem_unuse(),
but I can't see the exact serialization mechanism.

I've implemented a batching function, as David suggested above, but I'm trying
to convince myself that it is safe for it to access si->swap_map[] without a
lock (i.e. that swapoff() can't concurrently free it). But I think
free_swap_and_cache() as it already exists depends on being able to access the
si without an explicit lock, so I'm assuming the same mechanism will protect my
new changes. But I want to be sure I understand the mechanism...


This is the existing free_swap_and_cache(). I think _swap_info_get() would break
if this could race with swapoff(), and __swap_entry_free() looks up the cluster
from an array, which would also be freed by swapoff if racing:

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


This is my new function. I want to be sure that it's safe to do the
READ_ONCE(si->swap_info[...]):

void free_swap_and_cache_nr(swp_entry_t entry, int nr)
{
	unsigned long end = swp_offset(entry) + nr;
	unsigned type = swp_type(entry);
	struct swap_info_struct *si;
	unsigned long offset;

	if (non_swap_entry(entry))
		return;

	si = _swap_info_get(entry);
	if (!si || end > si->max)
		return;

	/*
	 * First free all entries in the range.
	 */
	for (offset = swp_offset(entry); offset < end; offset++) {
		VM_WARN_ON(data_race(!si->swap_map[offset]));
		__swap_entry_free(si, swp_entry(type, offset));
	}

	/*
	 * Now go back over the range trying to reclaim the swap cache. This is
	 * more efficient for large folios because we will only try to reclaim
	 * the swap once per folio in the common case. If we do
	 * __swap_entry_free() and __try_to_reclaim_swap() in the same loop, the
	 * latter will get a reference and lock the folio for every individual
	 * page but will only succeed once the swap slot for every subpage is
	 * zero.
	 */
	for (offset = swp_offset(entry); offset < end; offset += nr) {
		nr = 1;
		if (READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) { << HERE
			/*
			 * Folios are always naturally aligned in swap so
			 * advance forward to the next boundary. Zero means no
			 * folio was found for the swap entry, so advance by 1
			 * in this case. Negative value means folio was found
			 * but could not be reclaimed. Here we can still advance
			 * to the next boundary.
			 */
			nr = __try_to_reclaim_swap(si, offset,
					      TTRS_UNMAPPED | TTRS_FULL);
			if (nr == 0)
				nr = 1;
			else if (nr < 0)
				nr = -nr;
			nr = ALIGN(offset + 1, nr) - offset;
		}
	}
}

Thanks,
Ryan


