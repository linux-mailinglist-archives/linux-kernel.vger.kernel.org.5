Return-Path: <linux-kernel+bounces-99700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAAC878BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10D628242F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE7265C;
	Tue, 12 Mar 2024 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9/8N9vP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6164690;
	Tue, 12 Mar 2024 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710203376; cv=none; b=pdVZAmFC2/xL/B99hWUz+iPU1N3KEO57/UFj/UKPkhPn0XpvmTlStcz5oR6FgvKlzQno23yjt8mZNfjb1vpvF8qEJhVsKLWG1A7DtkJiAVDZYIXqFWqTbw9yH1GkOPXx2x+F6YU5aCLw8xO8QI3v6mG/BFbMMwBdx8hiF5WFlpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710203376; c=relaxed/simple;
	bh=sW+dADlfFW3sgJ2Rei1AseXsmQNC6ar3yV5n7ckvMsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eW5DwR3inRCSBI1+ap4BlI3503mfD1GZxaT9AeS1uGUKMEkWsZazSC/AuEMX+kyfOFP9i5l9zV3199Y86CjmbPEWl3YFbsO7ip64JT1bfbgfEXNvIVOlbJTcfnuQHLfyqth6hUmeMvgyBcgtb6vPlA8IZZrf5aZUMX20bnUDvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9/8N9vP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710203373; x=1741739373;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sW+dADlfFW3sgJ2Rei1AseXsmQNC6ar3yV5n7ckvMsI=;
  b=L9/8N9vPTPrbVxzdLQnhfXk4H7kUKKT/ZtcUajoMALgmleuOc4HJKpSp
   rLW/2SwNE5fkAws1CNel9xfl42OPFJiE1j9+NjEtNrKx4tIrZ56qVfWwd
   7pfH2fNGT3+jsS5QCcCmpUOUzA/X1aYj5RSXoQNelVE/4OptZaNO7SN+p
   WvXgwE64TpsqC/TwwNKEp43AQ7NY6J5vqRj9qHF4pc4PcI8fxKec4iAUS
   Nfb1nHmgRCqkS+lnTlyn8uXbsHQc0w1ZeVOJrOnDnjo1wrKvwewfP0djx
   VwbwhQ/wbBbdohoWl0OKq+H+GpsR/DbthC4cGVvZ6emzs/S7DkM0YQHjK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="16296337"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="16296337"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 17:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11791884"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 17:29:31 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  David Hildenbrand <david@redhat.com>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH -v3] mm: swap: fix race between free_swap_and_cache()
 and swapoff()
In-Reply-To: <1d27e93b-1c6b-4909-859f-e0756974a640@arm.com> (Ryan Roberts's
	message of "Mon, 11 Mar 2024 09:44:47 +0000")
References: <20240311084426.447164-1-ying.huang@intel.com>
	<1d27e93b-1c6b-4909-859f-e0756974a640@arm.com>
Date: Tue, 12 Mar 2024 08:27:36 +0800
Message-ID: <87v85s47lz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 11/03/2024 08:44, Huang Ying wrote:
>> From: Ryan Roberts <ryan.roberts@arm.com>
>> 
>> There was previously a theoretical window where swapoff() could run and
>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>> running in another thread.  This could cause, amongst other bad
>> possibilities, swap_page_trans_huge_swapped() (called by
>> free_swap_and_cache()) to access the freed memory for swap_map.
>> 
>> This is a theoretical problem and I haven't been able to provoke it from a
>> test case.  But there has been agreement based on code review that this is
>> possible (see link below).
>> 
>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>> swapoff().  There was an extra check in _swap_info_get() to confirm that
>> the swap entry was not free.  This isn't present in get_swap_device()
>> because it doesn't make sense in general due to the race between getting
>> the reference and swapoff.  So I've added an equivalent check directly in
>> free_swap_and_cache().
>> 
>> Details of how to provoke one possible issue:
>> 
>> --8<-----
>> 
>> CPU0                               CPU1
>> ----                               ----
>> shmem_undo_range
>>   shmem_free_swap
>>     xa_cmpxchg_irq
>>     free_swap_and_cache
>>       __swap_entry_free
>>       /* swap_count() become 0 */
>>                                    swapoff
>>                                      try_to_unuse
>>                                        shmem_unuse /* cannot find swap entry */
>>                                        find_next_to_unuse
>>                                        filemap_get_folio
>>                                        folio_free_swap
>>                                        /* remove swap cache */
>>                                        /* free si->swap_map[] */
>>       swap_page_trans_huge_swapped <-- access freed si->swap_map !!!
>> 
>> --8<-----
>> 
>> Link: https://lkml.kernel.org/r/20240306140356.3974886-1-ryan.roberts@arm.com
>> Closes: https://lore.kernel.org/linux-mm/8734t27awd.fsf@yhuang6-desk2.ccr.corp.intel.com/
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com> [patch description]
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>> Hi, Andrew,
>> 
>> If it's not too late.  Please replace v2 of this patch in mm-stable
>> with this version.
>
> Thanks for sorting this out, Huang, Ying! I saw your note asking if I could do
> it, and it was on my list, but I've been busy debugging other urgent issues in
> mm-stable. That should be solved now so unblocks me finishing the testing on my
> large folios swap-out v4 series. Hopefully that will be incomming in the next
> couple of days.

You are welcome!

> You did previously suggest you wanted some comments around synchronise_rcu() in
> swapoff(), but I don't see those here. I don't think that should hold this up
> though.

I will send a separate patch for that, including comments for
get_swap_device() and around synchronize_rcu() in swapoff().

--
Best Regards,
Huang, Ying

> Thanks,
> Ryan
>
>
>> 
>> Changes since v2:
>> 
>>  - Remove comments for get_swap_device() because it's not correct.
>>  - Revised patch description about the race condition description.
>> 
>> Changes since v1:
>> 
>>  - Added comments for get_swap_device() as suggested by David
>>  - Moved check that swap entry is not free from get_swap_device() to
>>    free_swap_and_cache() since there are some paths that legitimately call with
>>    a free offset.
>> 
>> Best Regards,
>> Huang, Ying
>> 
>>  mm/swapfile.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 2b3a2d85e350..9e0691276f5e 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1609,13 +1609,19 @@ int free_swap_and_cache(swp_entry_t entry)
>>  	if (non_swap_entry(entry))
>>  		return 1;
>>  
>> -	p = _swap_info_get(entry);
>> +	p = get_swap_device(entry);
>>  	if (p) {
>> +		if (WARN_ON(data_race(!p->swap_map[swp_offset(entry)]))) {
>> +			put_swap_device(p);
>> +			return 0;
>> +		}
>> +
>>  		count = __swap_entry_free(p, entry);
>>  		if (count == SWAP_HAS_CACHE &&
>>  		    !swap_page_trans_huge_swapped(p, entry))
>>  			__try_to_reclaim_swap(p, swp_offset(entry),
>>  					      TTRS_UNMAPPED | TTRS_FULL);
>> +		put_swap_device(p);
>>  	}
>>  	return p != NULL;
>>  }

