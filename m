Return-Path: <linux-kernel+bounces-93252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34411872D07
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F5FAB25D0C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF9CDDA6;
	Wed,  6 Mar 2024 02:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dwzv+QJu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D70863AC;
	Wed,  6 Mar 2024 02:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709693652; cv=none; b=nOiFTmCZugd+zZ/FtXqYLS3X/UQv652DV4CX0q+VOyxqJBK4OZTJBOZdafA8GRCS/ODXYqEz4jAc+d7fEG5X02k1lXug/ZX7XOv+VAQaX3l9Fqik6KshZ0ALjIAywmjDz/30knHscf+JbpQclRMk/YLIretxVAQTAB0tTObPI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709693652; c=relaxed/simple;
	bh=9WrgAkesKKlHGwX/3AxSFv+lcKYqyxJyA6ePn6zm5sM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pO01mB2VIxGaRUP9mUZIPvUlb92MHEc+UShpaIw5ZurcE5Bl9UWbmu0VEnwbCGoQLOLbQl+ite7W3St5OeoganDwEnHuhfEf9L2WPBT49BbssuAvOGMSEZ2g+2flReGKaHenULJ5Xr4+26qqT3RY4OaVP3oOLrchBwVSAa3ccNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dwzv+QJu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709693651; x=1741229651;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9WrgAkesKKlHGwX/3AxSFv+lcKYqyxJyA6ePn6zm5sM=;
  b=Dwzv+QJuMEshAYZ96gthVC6yuj7tnIQk2/qbetpJLb4UiCAIa/ZB91Wa
   fsh9Og/jv/qFv8pB86Wok2BaI0navPYrSLvS0y7zCaVPDZLl/JNtw9bbg
   n9gROF59g9YgMRMvv54IEFEVhMvS2OFZDT0Dw7AKsz+I2w9JDWcSwPBqM
   lIMme8qjobkzDN5MXqjgUvFqXVjkuUOjiw8X2v3kXMyt2FElvdPrNHMv3
   oHmxOBzoNICIFesasKNj9eXWT+CrO7EM6UvigM8y+GeqyON2Ms1qE/YBj
   HrUGBYTNAOwKkaDHRpMdxrY4PZqdZ/281rDqe1+/SrUqHVssbJk8a0o6H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4147264"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4147264"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 18:54:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9686980"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 18:54:08 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Miaohe Lin <linmiaohe@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@redhat.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <stable@vger.kernel.org>
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
In-Reply-To: <20240305151349.3781428-1-ryan.roberts@arm.com> (Ryan Roberts's
	message of "Tue, 5 Mar 2024 15:13:49 +0000")
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
Date: Wed, 06 Mar 2024 10:52:13 +0800
Message-ID: <875xy0842q.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> There was previously a theoretical window where swapoff() could run and
> teardown a swap_info_struct while a call to free_swap_and_cache() was
> running in another thread. This could cause, amongst other bad
> possibilities, swap_page_trans_huge_swapped() (called by
> free_swap_and_cache()) to access the freed memory for swap_map.
>
> This is a theoretical problem and I haven't been able to provoke it from
> a test case. But there has been agreement based on code review that this
> is possible (see link below).
>
> Fix it by using get_swap_device()/put_swap_device(), which will stall
> swapoff(). There was an extra check in _swap_info_get() to confirm that
> the swap entry was valid. This wasn't present in get_swap_device() so
> I've added it. I couldn't find any existing get_swap_device() call sites
> where this extra check would cause any false alarms.
>
> Details of how to provoke one possible issue (thanks to David Hilenbrand
> for deriving this):
>
> --8<-----
>
> __swap_entry_free() might be the last user and result in
> "count == SWAP_HAS_CACHE".
>
> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
>
> So the question is: could someone reclaim the folio and turn
> si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().
>
> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
> still references by swap entries.
>
> Process 1 still references subpage 0 via swap entry.
> Process 2 still references subpage 1 via swap entry.
>
> Process 1 quits. Calls free_swap_and_cache().
> -> count == SWAP_HAS_CACHE
> [then, preempted in the hypervisor etc.]
>
> Process 2 quits. Calls free_swap_and_cache().
> -> count == SWAP_HAS_CACHE
>
> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
> __try_to_reclaim_swap().
>
> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
> put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
> swap_entry_free()->swap_range_free()->
> ...
> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>
> What stops swapoff to succeed after process 2 reclaimed the swap cache
> but before process1 finished its call to swap_page_trans_huge_swapped()?
>
> --8<-----

I think that this can be simplified.  Even for a 4K folio, this could
happen.

CPU0                                     CPU1
----                                     ----

zap_pte_range
  free_swap_and_cache
  __swap_entry_free
  /* swap count become 0 */
                                         swapoff
                                           try_to_unuse
                                             filemap_get_folio
                                             folio_free_swap
                                             /* remove swap cache */
                                           /* free si->swap_map[] */

  swap_page_trans_huge_swapped <-- access freed si->swap_map !!!

> Fixes: 7c00bafee87c ("mm/swap: free swap slots in batch")
> Closes: https://lore.kernel.org/linux-mm/65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>
> Applies on top of v6.8-rc6 and mm-unstable (b38c34939fe4).
>
> Thanks,
> Ryan
>
>  mm/swapfile.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2b3a2d85e350..f580e6abc674 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1281,7 +1281,9 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>  	smp_rmb();
>  	offset = swp_offset(entry);
>  	if (offset >= si->max)
> -		goto put_out;
> +		goto bad_offset;
> +	if (data_race(!si->swap_map[swp_offset(entry)]))
> +		goto bad_free;
>
>  	return si;
>  bad_nofile:
> @@ -1289,9 +1291,14 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>  out:
>  	return NULL;
>  put_out:
> -	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
>  	percpu_ref_put(&si->users);
>  	return NULL;
> +bad_offset:
> +	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
> +	goto put_out;
> +bad_free:
> +	pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
> +	goto put_out;
>  }

I don't think that it's a good idea to warn for bad free entries.
get_swap_device() could be called without enough lock to prevent
parallel swap operations on entry.  So, false positive is possible
there.  I think that it's good to add more checks in general, for
example, in free_swap_and_cache(), we can check more because we are sure
the swap entry will not be freed by parallel swap operations.  Just
don't put the check in general get_swap_device().  We can add another
helper to check that.

I found that there are other checks in get_swap_device() already.  I
think that we may need to revert,

commit 23b230ba8ac3 ("mm/swap: print bad swap offset entry in get_swap_device")

which introduces it.  And add check in appropriate places.

--
Best Regards,
Huang, Ying

>  static unsigned char __swap_entry_free(struct swap_info_struct *p,
> @@ -1609,13 +1616,14 @@ int free_swap_and_cache(swp_entry_t entry)
>  	if (non_swap_entry(entry))
>  		return 1;
>
> -	p = _swap_info_get(entry);
> +	p = get_swap_device(entry);
>  	if (p) {
>  		count = __swap_entry_free(p, entry);
>  		if (count == SWAP_HAS_CACHE &&
>  		    !swap_page_trans_huge_swapped(p, entry))
>  			__try_to_reclaim_swap(p, swp_offset(entry),
>  					      TTRS_UNMAPPED | TTRS_FULL);
> +		put_swap_device(p);
>  	}
>  	return p != NULL;
>  }
> --
> 2.25.1

