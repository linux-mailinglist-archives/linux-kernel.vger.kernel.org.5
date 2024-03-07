Return-Path: <linux-kernel+bounces-94989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF8D8747C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF70B22E0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A761BF20;
	Thu,  7 Mar 2024 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KA0rNkjx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271BA1C6B1;
	Thu,  7 Mar 2024 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709790658; cv=none; b=mUVmY4bCbaHgglSMCAiNldg3IXT53Girt4voyzAP0JWnh7/7wlDkvIzZT2HCdnYOyO/+ON7CbihGmj6V0KIpuH/I+I9trCS6wtYwDPFpRjEA4s/i3HWRt6LKRW2/qjigUT8eXNdI7ywSawOejllJYGw6d/NJ7gNlYN2QZsXoE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709790658; c=relaxed/simple;
	bh=AOYEIx+Z/N5GzUBtJ7PgfpiB0pb8WbmYPgvNTS/BmPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mS8dsYDk9WpL+zZ7d4xs2oH4Xck1OMj7MY1lg1lntWLIeLLaCpdZoMOPpGsaJBhrmo1jDrJwm2SlwSSfIgAas45aj9MgFmGAVmS2HH6WIQJdP6PTbaSHhgeGJXmfsS+DQwg4RYWheiQZodq2D9cSlo0DWv3fdoWAFB/4Cr3QRuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KA0rNkjx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709790656; x=1741326656;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=AOYEIx+Z/N5GzUBtJ7PgfpiB0pb8WbmYPgvNTS/BmPc=;
  b=KA0rNkjxTdPXbiheaPN1Sc4YMi20FLZKJnXcojIcJ6dv+XTLtkymosPP
   2oKvmxSLwZ51d+BCv/LnXF5PsgbCJb4UPP6c/ZZQFv69U5j/+2+mN97/Z
   z0pm7e9unRtLfMj0el//+ggd2BSy/L6o4eah1D9kioJu5QWcklJOCK9Ig
   wUmyXvciUP+abqfA8Hn9PdnoDcHGwjPfISU7+PLaZje4h6jqI8wJNop1x
   1xMFPmnOhJXlGocToPx56QC/cNpcvI9vm3jVnuZtApn1vo3eBfw9T/SfF
   PtN8oyVbiPnWRdI+Ljq42b/eDhd/gZGuPQEElSdWQNmlAo+EY2fsYWD8R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4565130"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="4565130"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 21:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="14692078"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 21:50:54 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@redhat.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
In-Reply-To: <86be68f5-546a-422f-8a46-e374d21203f4@arm.com> (Ryan Roberts's
	message of "Wed, 6 Mar 2024 09:03:25 +0000")
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
	<875xy0842q.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<86be68f5-546a-422f-8a46-e374d21203f4@arm.com>
Date: Thu, 07 Mar 2024 13:48:59 +0800
Message-ID: <87frx27fsk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 06/03/2024 02:52, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> There was previously a theoretical window where swapoff() could run and
>>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>>> running in another thread. This could cause, amongst other bad
>>> possibilities, swap_page_trans_huge_swapped() (called by
>>> free_swap_and_cache()) to access the freed memory for swap_map.
>>>
>>> This is a theoretical problem and I haven't been able to provoke it from
>>> a test case. But there has been agreement based on code review that this
>>> is possible (see link below).
>>>
>>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>>> swapoff(). There was an extra check in _swap_info_get() to confirm that
>>> the swap entry was valid. This wasn't present in get_swap_device() so
>>> I've added it. I couldn't find any existing get_swap_device() call sites
>>> where this extra check would cause any false alarms.
>>>
>>> Details of how to provoke one possible issue (thanks to David Hilenbrand
>>> for deriving this):
>>>
>>> --8<-----
>>>
>>> __swap_entry_free() might be the last user and result in
>>> "count == SWAP_HAS_CACHE".
>>>
>>> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
>>>
>>> So the question is: could someone reclaim the folio and turn
>>> si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().
>>>
>>> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
>>> still references by swap entries.
>>>
>>> Process 1 still references subpage 0 via swap entry.
>>> Process 2 still references subpage 1 via swap entry.
>>>
>>> Process 1 quits. Calls free_swap_and_cache().
>>> -> count == SWAP_HAS_CACHE
>>> [then, preempted in the hypervisor etc.]
>>>
>>> Process 2 quits. Calls free_swap_and_cache().
>>> -> count == SWAP_HAS_CACHE
>>>
>>> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
>>> __try_to_reclaim_swap().
>>>
>>> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
>>> put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
>>> swap_entry_free()->swap_range_free()->
>>> ...
>>> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>>
>>> What stops swapoff to succeed after process 2 reclaimed the swap cache
>>> but before process1 finished its call to swap_page_trans_huge_swapped()?
>>>
>>> --8<-----
>> 
>> I think that this can be simplified.  Even for a 4K folio, this could
>> happen.
>
> I'm not so sure...
>
>> 
>> CPU0                                     CPU1
>> ----                                     ----
>> 
>> zap_pte_range
>>   free_swap_and_cache
>>   __swap_entry_free
>>   /* swap count become 0 */
>>                                          swapoff
>>                                            try_to_unuse
>>                                              filemap_get_folio
>>                                              folio_free_swap
>>                                              /* remove swap cache */
>>                                            /* free si->swap_map[] */
>> 
>>   swap_page_trans_huge_swapped <-- access freed si->swap_map !!!
>
> I don't think si->inuse_pages is decremented until __try_to_reclaim_swap() is
> called (per David, above), which is called after swap_page_trans_huge_swapped()
> has executed. So in CPU1, try_to_unuse() wouldn't see si->inuse_pages being zero

try_to_unuse() can decrease si->inuse_pages by itself via the following
loop,

	while (READ_ONCE(si->inuse_pages) &&
	       !signal_pending(current) &&
	       (i = find_next_to_unuse(si, i)) != 0) {

		entry = swp_entry(type, i);
		folio = filemap_get_folio(swap_address_space(entry), i);
		if (IS_ERR(folio))
			continue;

		/*
		 * It is conceivable that a racing task removed this folio from
		 * swap cache just before we acquired the page lock. The folio
		 * might even be back in swap cache on another swap area. But
		 * that is okay, folio_free_swap() only removes stale folios.
		 */
		folio_lock(folio);
		folio_wait_writeback(folio);
		folio_free_swap(folio);
		folio_unlock(folio);
		folio_put(folio);
	}

Then it can proceed to swapoff.  But as Miaohe pointed out, PTL to
prevent swapoff to free data structures later via synchronize_rcu().

> until after CPU0 has completed accessing si->swap_map, so if swapoff starts
> where you have put it, it would get stalled waiting for the PTL which CPU0 has.
>
> I'm sure there are other ways that this could be racy for 4K folios, but I don't
> think this is one of them? e.g. if CPU0 does something with si after it has
> decremented si->inuse_pages, then there is a problem.
>
>> 
>>> Fixes: 7c00bafee87c ("mm/swap: free swap slots in batch")
>>> Closes: https://lore.kernel.org/linux-mm/65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com/
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>
>>> Applies on top of v6.8-rc6 and mm-unstable (b38c34939fe4).
>>>
>>> Thanks,
>>> Ryan
>>>
>>>  mm/swapfile.c | 14 +++++++++++---
>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index 2b3a2d85e350..f580e6abc674 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -1281,7 +1281,9 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>>>  	smp_rmb();
>>>  	offset = swp_offset(entry);
>>>  	if (offset >= si->max)
>>> -		goto put_out;
>>> +		goto bad_offset;
>>> +	if (data_race(!si->swap_map[swp_offset(entry)]))
>>> +		goto bad_free;
>>>
>>>  	return si;
>>>  bad_nofile:
>>> @@ -1289,9 +1291,14 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>>>  out:
>>>  	return NULL;
>>>  put_out:
>>> -	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
>>>  	percpu_ref_put(&si->users);
>>>  	return NULL;
>>> +bad_offset:
>>> +	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
>>> +	goto put_out;
>>> +bad_free:
>>> +	pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
>>> +	goto put_out;
>>>  }
>> 
>> I don't think that it's a good idea to warn for bad free entries.
>> get_swap_device() could be called without enough lock to prevent
>> parallel swap operations on entry.  So, false positive is possible
>> there.  I think that it's good to add more checks in general, for
>> example, in free_swap_and_cache(), we can check more because we are sure
>> the swap entry will not be freed by parallel swap operations.
>
> Yes, agreed. Johannes also reported that he is seeing false alarms due to this.
> I'm going to remove it and add it to free_swap_and_cache() as you suggest. This
> also fits well for the batched version I'm working on where we want to check the
> global si things once, but need to check !free for every entry in the loop
> (aiming to post that this week).
>
>   Just
>> don't put the check in general get_swap_device().  We can add another
>> helper to check that.
>> 
>> I found that there are other checks in get_swap_device() already.  I
>> think that we may need to revert,
>> 
>> commit 23b230ba8ac3 ("mm/swap: print bad swap offset entry in get_swap_device")
>
> Yes agree this should be reverted.
>
>> 
>> which introduces it.  And add check in appropriate places.
>
> I'm not quite sure what the "appropriate places" are. Looking at the call sites
> for get_swap_device(), it looks like they are all racy except
> free_swap_and_cache() which is called with the PTL. So check should only really
> go there?
>
> But... free_swap_and_cache() is called without the PTL by shmem (in 2 places -
> see shmem_free_swap() wrapper). It looks like in one of those places, the folio
> lock is held, so I guess this has a similar effect to holding the PTL. But the
> other shmem_free_swap() call site doesn't appear to have the folio lock. Am I
> missing something, or does this mean that for this path, free_swap_and_cache()
> is racy and therefore we shouldn't be doing either the `offset >= si->max` or
> the `!swap_map[offset]` in free_swap_and_cache() either?

In shmem_free_swap(), xa_cmpxchg_irq() is used to get the swap entry and
clear the original mapping.  So, no other code path can free the swap
count held by mapping.  But, after dropping the swap count, it appears
that it's not safe.

--
Best Regards,
Huang, Ying

>> 
>> --
>> Best Regards,
>> Huang, Ying
>> 
>>>  static unsigned char __swap_entry_free(struct swap_info_struct *p,
>>> @@ -1609,13 +1616,14 @@ int free_swap_and_cache(swp_entry_t entry)
>>>  	if (non_swap_entry(entry))
>>>  		return 1;
>>>
>>> -	p = _swap_info_get(entry);
>>> +	p = get_swap_device(entry);
>>>  	if (p) {
>>>  		count = __swap_entry_free(p, entry);
>>>  		if (count == SWAP_HAS_CACHE &&
>>>  		    !swap_page_trans_huge_swapped(p, entry))
>>>  			__try_to_reclaim_swap(p, swp_offset(entry),
>>>  					      TTRS_UNMAPPED | TTRS_FULL);
>>> +		put_swap_device(p);
>>>  	}
>>>  	return p != NULL;
>>>  }
>>> --
>>> 2.25.1

