Return-Path: <linux-kernel+bounces-94968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AF487475B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2F28B23027
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9815F134BD;
	Thu,  7 Mar 2024 04:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="an00fWQX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156663CF;
	Thu,  7 Mar 2024 04:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709786351; cv=none; b=FDuT/K00Bxg3ceFQLds9tCFS2JqnOenG1FEjO+2N1CUEQ8rAi8aKrpkzjzU2DaPYTKAD/4kQUxc6OYe1m2XmV5DOlpkLvsIDsqcHxcpnZ+HJ94TswC6FIvGEbG74Jok0oXduKLamtaEV8oRsEsl7trPpmfriwxDXAydleX+7dAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709786351; c=relaxed/simple;
	bh=d23Iig9hJmHScc/rMODy/liRKbgEi8K7tGamUjUBsGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bLrFAEviaOd6X+bOU+M2QecH1I93JlqjYHET7d07T8xSwrHECSeJWezQqERz0kaEyCyTuzuk062U3ob+qPQOiEX5hkivBWzJ/QDmW5h0IoEDUefcEW9wfRHWA9QPQiPDeAnkSAL1EogDS8ZKsxlb1JQ9c71Il7h8BYPZjbDEo8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=an00fWQX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709786349; x=1741322349;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=d23Iig9hJmHScc/rMODy/liRKbgEi8K7tGamUjUBsGE=;
  b=an00fWQXKU2ZJOaoCCs7UsJH3YI/xZNQvwgkpGvr2Ajwr2/rTQ37LmuF
   t7Rytcs4XVnobZTZpTNZ4uY1lsoMCWqwwSKb6tua9t9+uV6hjw/cY5+Rj
   d3mpwr+7HJ5/V5FqHgdOVHqgpTvhuT7HbZd8soJ2F2jE+9V3o6bQ0iJLB
   0XwDwBtyBicQYAJlWan9PvCjg1nGeizFkpI+nR/TJ6YExXC9evh8RmkW9
   v2YNF4dOtkY1VUJ8BKZ4BZDAE3mPH2YYJ+c4hG7BN1I1T4IQXmGqvWzQ9
   zx4vQ+AA9p+aG/OmBASU0G2NeTV9/Kh3B4PDFhF7eGgH+Rfiw7qUZKP1X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4285651"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4285651"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 20:39:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="10410969"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 20:39:06 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@redhat.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
In-Reply-To: <af11bbca-3f6a-4db5-916c-b0d5b942352b@arm.com> (Ryan Roberts's
	message of "Wed, 6 Mar 2024 09:31:01 +0000")
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
	<875xy0842q.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<c8fe62d0-78b8-527a-5bef-ee663ccdc37a@huawei.com>
	<af11bbca-3f6a-4db5-916c-b0d5b942352b@arm.com>
Date: Thu, 07 Mar 2024 12:37:10 +0800
Message-ID: <87plw67j49.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 06/03/2024 08:51, Miaohe Lin wrote:
>> On 2024/3/6 10:52, Huang, Ying wrote:
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>>> There was previously a theoretical window where swapoff() could run and
>>>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>>>> running in another thread. This could cause, amongst other bad
>>>> possibilities, swap_page_trans_huge_swapped() (called by
>>>> free_swap_and_cache()) to access the freed memory for swap_map.
>>>>
>>>> This is a theoretical problem and I haven't been able to provoke it from
>>>> a test case. But there has been agreement based on code review that this
>>>> is possible (see link below).
>>>>
>>>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>>>> swapoff(). There was an extra check in _swap_info_get() to confirm that
>>>> the swap entry was valid. This wasn't present in get_swap_device() so
>>>> I've added it. I couldn't find any existing get_swap_device() call sites
>>>> where this extra check would cause any false alarms.
>>>>
>>>> Details of how to provoke one possible issue (thanks to David Hilenbrand
>>>> for deriving this):
>>>>
>>>> --8<-----
>>>>
>>>> __swap_entry_free() might be the last user and result in
>>>> "count == SWAP_HAS_CACHE".
>>>>
>>>> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
>>>>
>>>> So the question is: could someone reclaim the folio and turn
>>>> si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().
>>>>
>>>> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
>>>> still references by swap entries.
>>>>
>>>> Process 1 still references subpage 0 via swap entry.
>>>> Process 2 still references subpage 1 via swap entry.
>>>>
>>>> Process 1 quits. Calls free_swap_and_cache().
>>>> -> count == SWAP_HAS_CACHE
>>>> [then, preempted in the hypervisor etc.]
>>>>
>>>> Process 2 quits. Calls free_swap_and_cache().
>>>> -> count == SWAP_HAS_CACHE
>>>>
>>>> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
>>>> __try_to_reclaim_swap().
>>>>
>>>> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
>>>> put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
>>>> swap_entry_free()->swap_range_free()->
>>>> ...
>>>> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>>>
>>>> What stops swapoff to succeed after process 2 reclaimed the swap cache
>>>> but before process1 finished its call to swap_page_trans_huge_swapped()?
>>>>
>>>> --8<-----
>>>
>>> I think that this can be simplified.  Even for a 4K folio, this could
>>> happen.
>>>
>>> CPU0                                     CPU1
>>> ----                                     ----
>>>
>>> zap_pte_range
>>>   free_swap_and_cache
>>>   __swap_entry_free
>>>   /* swap count become 0 */
>>>                                          swapoff
>>>                                            try_to_unuse
>>>                                              filemap_get_folio
>>>                                              folio_free_swap
>>>                                              /* remove swap cache */
>>>                                            /* free si->swap_map[] */
>>>
>>>   swap_page_trans_huge_swapped <-- access freed si->swap_map !!!
>> 
>> Sorry for jumping the discussion here. IMHO, free_swap_and_cache is called with pte lock held.
>
> I don't beleive it has the PTL when called by shmem.

Yes, we don't hold PTL there.

After checking the code again.  I think that there may be race condition
as above without PTL.  But I may miss something, again.

>> So synchronize_rcu (called by swapoff) will wait zap_pte_range to release the pte lock. So this
>> theoretical problem can't happen. Or am I miss something?
>
> For Huang Ying's example, I agree this can't happen because try_to_unuse() will
> be waiting for the PTL (see the reply I just sent).
>
>> 
>> CPU0                                     CPU1
>> ----                                     ----
>> 
>> zap_pte_range
>>   pte_offset_map_lock -- spin_lock is held.
>>   free_swap_and_cache
>>    __swap_entry_free
>>    /* swap count become 0 */
>>                                          swapoff
>>                                            try_to_unuse
>>                                              filemap_get_folio
>>                                              folio_free_swap
>>                                              /* remove swap cache */
>> 					    percpu_ref_kill(&p->users);
>>    swap_page_trans_huge_swapped
>>   pte_unmap_unlock -- spin_lock is released.
>> 					    synchronize_rcu();  --> Will wait pte_unmap_unlock to be called?
>
> Perhaps you can educate me here; I thought that synchronize_rcu() will only wait
> for RCU critical sections to complete. The PTL is a spin lock, so why would
> synchronize_rcu() wait for the PTL to become unlocked?

Please take a look at the following link,

https://www.kernel.org/doc/html/next/RCU/whatisRCU.html#rcu-read-lock

"
Note that anything that disables bottom halves, preemption, or
interrupts also enters an RCU read-side critical section. Acquiring a
spinlock also enters an RCU read-side critical sections, even for
spinlocks that do not disable preemption, as is the case in kernels
built with CONFIG_PREEMPT_RT=y. Sleeplocks do not enter RCU read-side
critical sections.
"

--
Best Regards,
Huang, Ying

>
>>                                            /* free si->swap_map[] */
>> 
>> Thanks.
>> 
>> 

