Return-Path: <linux-kernel+bounces-94975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3BC87476E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184C8286DED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269901B285;
	Thu,  7 Mar 2024 04:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QdwXMRqU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215D13FF5;
	Thu,  7 Mar 2024 04:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709786475; cv=none; b=SXQ7mXhzgCIUQz7LJ4zIIgUYZHMJrFZi0YktURi6Fg/HhNP21lPwanD+mJX0iGm8yhhC0jDsOZHQelhWKjtM8FdqXI0KVjm4aepSm2U7zP3s0b2m9kLqXhs4/NJrBDElPbwi7WX3n/rkkp3l5ZAArDArnXEaV897FBKVGuPrkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709786475; c=relaxed/simple;
	bh=XYbe7O1rnmoARPI/KbGn27Qyuj3Way4wqe09R1GltNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gu8UbeNSigOelZLNRk7Sknaxjqdv62JVOloDKhXJ58zYtrhTT6x12at/N/dRF/QG6sXy2h1CWdYGRMcveLpIv5n1gXnLJNC0zH9YemI/kcn89+WrDz3SRIi8JvOKaRUk+vwiQRqpi/zzGNPsXRJyigyDVCKXyvq3gEO2Iwm+6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QdwXMRqU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709786474; x=1741322474;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=XYbe7O1rnmoARPI/KbGn27Qyuj3Way4wqe09R1GltNI=;
  b=QdwXMRqUr+jdOhgJ5oukj5btxr1H3GBDmlJpXIFdXOAcQyCghmJCNtcM
   F8D1HjkoCJ8B1SYFK1VMGqJ6srN5YPF+yQWwU1pjAAVXE20P5y0hiGRi+
   DA9i++apz+QhA6K2WzfTDjn6WOXDLcYf6qNBfmHD8gGnrdTXkmo5pwEnr
   /uoOXTgVTHUf3dDndePm6a8R5ACAtIDdYFpzZF25FeOQYP3POIIufmYaP
   EoSK/xG17K1cqx+IqvXIrTrTAT867rjqAaXWnmpdlW9rNolqg8ty1SQpP
   ZO4X0dfEu2i1xYVZPYkTYNEjtqAd7+MXTjnEZWdTwrcUvQcCwp7ssS62h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4559109"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4559109"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 20:41:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="9965527"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 20:41:11 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@redhat.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
In-Reply-To: <c8fe62d0-78b8-527a-5bef-ee663ccdc37a@huawei.com> (Miaohe Lin's
	message of "Wed, 6 Mar 2024 16:51:22 +0800")
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
	<875xy0842q.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<c8fe62d0-78b8-527a-5bef-ee663ccdc37a@huawei.com>
Date: Thu, 07 Mar 2024 12:39:16 +0800
Message-ID: <87jzme7j0r.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2024/3/6 10:52, Huang, Ying wrote:
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
> Sorry for jumping the discussion here. IMHO, free_swap_and_cache is called with pte lock held.
> So synchronize_rcu (called by swapoff) will wait zap_pte_range to release the pte lock. So this
> theoretical problem can't happen. Or am I miss something?
>
> CPU0                                     CPU1
> ----                                     ----
>
> zap_pte_range
>   pte_offset_map_lock -- spin_lock is held.
>   free_swap_and_cache
>    __swap_entry_free
>    /* swap count become 0 */
>                                          swapoff
>                                            try_to_unuse
>                                              filemap_get_folio
>                                              folio_free_swap
>                                              /* remove swap cache */
> 					    percpu_ref_kill(&p->users);
>    swap_page_trans_huge_swapped
>   pte_unmap_unlock -- spin_lock is released.
> 					    synchronize_rcu();  --> Will wait pte_unmap_unlock to be called?
>                                            /* free si->swap_map[] */

I think that you are right.  We are safe if PTL is held.  Thanks a lot
for pointing this out!

--
Best Regards,
Huang, Ying

