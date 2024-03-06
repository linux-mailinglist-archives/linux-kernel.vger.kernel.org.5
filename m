Return-Path: <linux-kernel+bounces-93594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C814873227
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB981C20B54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D67605A5;
	Wed,  6 Mar 2024 09:03:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37272604D4;
	Wed,  6 Mar 2024 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715813; cv=none; b=I/sZ7j78fB2ybM8CiBJ+nY6dDklEWwzNf0MNj6ft/7dfTHPU3nG0DdCVLp937iTUC4WB797ZNtYW6Bfd/LI0I+bpxGNTns/ETXNX95OljAODyay86GGF+/FGsewzu6jwE8+WlJBjRm4zQ3mI3ASPYZ4wDRZrDjuqxdxCi1qIFCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715813; c=relaxed/simple;
	bh=SkuOt8HDeOXMJqnKoeKpc3t5ONCW9ExudiStGvfLifE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKHU/h1+fDRhziHx/bgEszBCudiTry0rDmPtyIDD8YQraVZ8o6Ok3b1GZooNtAgoyBHa8M4zEKkX+qsx733TFUPuHSoyMGvVCN1Xbo9kMAOInJv67hzX6KBuw1lbZ7bLTcuIVS5ujIEc4NGNNj5VuZyC3j8mrnB0qybH8LThOdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85BA31FB;
	Wed,  6 Mar 2024 01:04:07 -0800 (PST)
Received: from [10.57.68.241] (unknown [10.57.68.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0959F3F762;
	Wed,  6 Mar 2024 01:03:27 -0800 (PST)
Message-ID: <86be68f5-546a-422f-8a46-e374d21203f4@arm.com>
Date: Wed, 6 Mar 2024 09:03:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
Content-Language: en-GB
To: "Huang, Ying" <ying.huang@intel.com>, Miaohe Lin <linmiaohe@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
 <875xy0842q.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <875xy0842q.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2024 02:52, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> There was previously a theoretical window where swapoff() could run and
>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>> running in another thread. This could cause, amongst other bad
>> possibilities, swap_page_trans_huge_swapped() (called by
>> free_swap_and_cache()) to access the freed memory for swap_map.
>>
>> This is a theoretical problem and I haven't been able to provoke it from
>> a test case. But there has been agreement based on code review that this
>> is possible (see link below).
>>
>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>> swapoff(). There was an extra check in _swap_info_get() to confirm that
>> the swap entry was valid. This wasn't present in get_swap_device() so
>> I've added it. I couldn't find any existing get_swap_device() call sites
>> where this extra check would cause any false alarms.
>>
>> Details of how to provoke one possible issue (thanks to David Hilenbrand
>> for deriving this):
>>
>> --8<-----
>>
>> __swap_entry_free() might be the last user and result in
>> "count == SWAP_HAS_CACHE".
>>
>> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
>>
>> So the question is: could someone reclaim the folio and turn
>> si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().
>>
>> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
>> still references by swap entries.
>>
>> Process 1 still references subpage 0 via swap entry.
>> Process 2 still references subpage 1 via swap entry.
>>
>> Process 1 quits. Calls free_swap_and_cache().
>> -> count == SWAP_HAS_CACHE
>> [then, preempted in the hypervisor etc.]
>>
>> Process 2 quits. Calls free_swap_and_cache().
>> -> count == SWAP_HAS_CACHE
>>
>> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
>> __try_to_reclaim_swap().
>>
>> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
>> put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
>> swap_entry_free()->swap_range_free()->
>> ...
>> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>
>> What stops swapoff to succeed after process 2 reclaimed the swap cache
>> but before process1 finished its call to swap_page_trans_huge_swapped()?
>>
>> --8<-----
> 
> I think that this can be simplified.  Even for a 4K folio, this could
> happen.

I'm not so sure...

> 
> CPU0                                     CPU1
> ----                                     ----
> 
> zap_pte_range
>   free_swap_and_cache
>   __swap_entry_free
>   /* swap count become 0 */
>                                          swapoff
>                                            try_to_unuse
>                                              filemap_get_folio
>                                              folio_free_swap
>                                              /* remove swap cache */
>                                            /* free si->swap_map[] */
> 
>   swap_page_trans_huge_swapped <-- access freed si->swap_map !!!

I don't think si->inuse_pages is decremented until __try_to_reclaim_swap() is
called (per David, above), which is called after swap_page_trans_huge_swapped()
has executed. So in CPU1, try_to_unuse() wouldn't see si->inuse_pages being zero
until after CPU0 has completed accessing si->swap_map, so if swapoff starts
where you have put it, it would get stalled waiting for the PTL which CPU0 has.

I'm sure there are other ways that this could be racy for 4K folios, but I don't
think this is one of them? e.g. if CPU0 does something with si after it has
decremented si->inuse_pages, then there is a problem.

> 
>> Fixes: 7c00bafee87c ("mm/swap: free swap slots in batch")
>> Closes: https://lore.kernel.org/linux-mm/65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com/
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> Applies on top of v6.8-rc6 and mm-unstable (b38c34939fe4).
>>
>> Thanks,
>> Ryan
>>
>>  mm/swapfile.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 2b3a2d85e350..f580e6abc674 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1281,7 +1281,9 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>>  	smp_rmb();
>>  	offset = swp_offset(entry);
>>  	if (offset >= si->max)
>> -		goto put_out;
>> +		goto bad_offset;
>> +	if (data_race(!si->swap_map[swp_offset(entry)]))
>> +		goto bad_free;
>>
>>  	return si;
>>  bad_nofile:
>> @@ -1289,9 +1291,14 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>>  out:
>>  	return NULL;
>>  put_out:
>> -	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
>>  	percpu_ref_put(&si->users);
>>  	return NULL;
>> +bad_offset:
>> +	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
>> +	goto put_out;
>> +bad_free:
>> +	pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
>> +	goto put_out;
>>  }
> 
> I don't think that it's a good idea to warn for bad free entries.
> get_swap_device() could be called without enough lock to prevent
> parallel swap operations on entry.  So, false positive is possible
> there.  I think that it's good to add more checks in general, for
> example, in free_swap_and_cache(), we can check more because we are sure
> the swap entry will not be freed by parallel swap operations.

Yes, agreed. Johannes also reported that he is seeing false alarms due to this.
I'm going to remove it and add it to free_swap_and_cache() as you suggest. This
also fits well for the batched version I'm working on where we want to check the
global si things once, but need to check !free for every entry in the loop
(aiming to post that this week).

  Just
> don't put the check in general get_swap_device().  We can add another
> helper to check that.
> 
> I found that there are other checks in get_swap_device() already.  I
> think that we may need to revert,
> 
> commit 23b230ba8ac3 ("mm/swap: print bad swap offset entry in get_swap_device")

Yes agree this should be reverted.

> 
> which introduces it.  And add check in appropriate places.

I'm not quite sure what the "appropriate places" are. Looking at the call sites
for get_swap_device(), it looks like they are all racy except
free_swap_and_cache() which is called with the PTL. So check should only really
go there?

But... free_swap_and_cache() is called without the PTL by shmem (in 2 places -
see shmem_free_swap() wrapper). It looks like in one of those places, the folio
lock is held, so I guess this has a similar effect to holding the PTL. But the
other shmem_free_swap() call site doesn't appear to have the folio lock. Am I
missing something, or does this mean that for this path, free_swap_and_cache()
is racy and therefore we shouldn't be doing either the `offset >= si->max` or
the `!swap_map[offset]` in free_swap_and_cache() either?

> 
> --
> Best Regards,
> Huang, Ying
> 
>>  static unsigned char __swap_entry_free(struct swap_info_struct *p,
>> @@ -1609,13 +1616,14 @@ int free_swap_and_cache(swp_entry_t entry)
>>  	if (non_swap_entry(entry))
>>  		return 1;
>>
>> -	p = _swap_info_get(entry);
>> +	p = get_swap_device(entry);
>>  	if (p) {
>>  		count = __swap_entry_free(p, entry);
>>  		if (count == SWAP_HAS_CACHE &&
>>  		    !swap_page_trans_huge_swapped(p, entry))
>>  			__try_to_reclaim_swap(p, swp_offset(entry),
>>  					      TTRS_UNMAPPED | TTRS_FULL);
>> +		put_swap_device(p);
>>  	}
>>  	return p != NULL;
>>  }
>> --
>> 2.25.1


