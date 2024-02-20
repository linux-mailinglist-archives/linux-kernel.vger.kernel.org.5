Return-Path: <linux-kernel+bounces-72166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD62285B03F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A4CB22317
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39DA1095B;
	Tue, 20 Feb 2024 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WeEdUPYJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5BF9F8;
	Tue, 20 Feb 2024 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708391468; cv=none; b=goIsY0Oi6C4k+Hi+priGYm2eDt9WrhBo3OtCskZ9D82DuyE2B4sx2CGsrboLepL+uwaFmGBgL/VuIWo0caNPMoXCL5Q+nzxdahwThbBbdWBQlP4xv6cct7vCgN5/GPn3fV9r2/5OIQXs578yNW2dEgfIBY76BII9hXO7jzJ52fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708391468; c=relaxed/simple;
	bh=zbwGqBLzRD3fZTXy/MlmyAoiH93kbhAQ+M07A+hLbNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LirGH95nDekrcsn93Kh6WM99g9AnSEO9DFxoN/SD5+zcsYyeDjHiXjuLCCD11PbMVvjWhnOZoc9p3dFxAneOWs/Hthq2Ff0xMuIsjjYtgJ8li0e5MOx/h2l5XxnntwM0JXA8VCjwbZYK5o7a6dOiDfM24xD1tKjvrAIona1WJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WeEdUPYJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708391465; x=1739927465;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=zbwGqBLzRD3fZTXy/MlmyAoiH93kbhAQ+M07A+hLbNU=;
  b=WeEdUPYJo+OSHrWu4M57Ijc8PIUbrij6xvH+ITlQYqfc7dsqotFYkq8U
   1VubpMFrdJHrizVqWHQO4W1niOuvqz9+ZA/Btuzngbx+kYflZueNtw+Nd
   wV6SFcqRRSFK/tV9vifVE2Z0vOvhuBhxPdH/b7FkKAzApUeAVxl6LuUys
   pWJuA92GCIqniNPVe8FJUKzwv2O7P9TJkkhsYK1xmqQN3u/YmGFZAyCov
   /3wggZ9BQXvQSoMoGq8UEHdUtgY0/nEGM4Ze3pglgPUl0zeILMgU2/YYg
   idIjXx21Zgucem51jFFIwNG+YdX+zT37Dkj2B4irnhR7vRXiJ5cBk8ayp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="6250887"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="6250887"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 17:11:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="27788054"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 17:10:59 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Kairui Song <kasong@tencent.com>,  linux-mm@kvack.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Minchan Kim
 <minchan@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Yu Zhao
 <yuzhao@google.com>,  SeongJae Park <sj@kernel.org>,  David Hildenbrand
 <david@redhat.com>,  Hugh Dickins <hughd@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Matthew Wilcox <willy@infradead.org>,  Michal Hocko
 <mhocko@suse.com>,  Yosry Ahmed <yosryahmed@google.com>,  Aaron Lu
 <aaron.lu@intel.com>,  stable@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/swap: fix race when skipping swapcache
In-Reply-To: <CAGsJ_4xX+K=f_4g2c7NcpYqWH0_bvQshxgz_YoDscqeHwWpM0w@mail.gmail.com>
	(Barry Song's message of "Tue, 20 Feb 2024 11:10:03 +1300")
References: <20240219082040.7495-1-ryncsn@gmail.com>
	<CAGsJ_4xX+K=f_4g2c7NcpYqWH0_bvQshxgz_YoDscqeHwWpM0w@mail.gmail.com>
Date: Tue, 20 Feb 2024 09:09:03 +0800
Message-ID: <87frxoq6vk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Mon, Feb 19, 2024 at 9:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
>>
>> From: Kairui Song <kasong@tencent.com>
>>
>> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
>> swapin the same entry at the same time, they get different pages (A, B).
>> Before one thread (T0) finishes the swapin and installs page (A)
>> to the PTE, another thread (T1) could finish swapin of page (B),
>> swap_free the entry, then swap out the possibly modified page
>> reusing the same entry. It breaks the pte_same check in (T0) because
>> PTE value is unchanged, causing ABA problem. Thread (T0) will
>> install a stalled page (A) into the PTE and cause data corruption.
>>
>> One possible callstack is like this:
>>
>> CPU0                                 CPU1
>> ----                                 ----
>> do_swap_page()                       do_swap_page() with same entry
>> <direct swapin path>                 <direct swapin path>
>> <alloc page A>                       <alloc page B>
>> swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
>> <slow on later locks or interrupt>   <finished swapin first>
>> ..                                  set_pte_at()
>>                                      swap_free() <- entry is free
>>                                      <write to page B, now page A stalle=
d>
>>                                      <swap out page B to same swap entry>
>> pte_same() <- Check pass, PTE seems
>>               unchanged, but page A
>>               is stalled!
>> swap_free() <- page B content lost!
>> set_pte_at() <- staled page A installed!
>>
>> And besides, for ZRAM, swap_free() allows the swap device to discard
>> the entry content, so even if page (B) is not modified, if
>> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
>> it may also cause data loss.
>>
>> To fix this, reuse swapcache_prepare which will pin the swap entry using
>> the cache flag, and allow only one thread to swap it in, also prevent
>> any parallel code from putting the entry in the cache. Release the pin
>> after PT unlocked.
>>
>> Racers just loop and wait since it's a rare and very short event.
>> A schedule_timeout_uninterruptible(1) call is added to avoid repeated
>> page faults wasting too much CPU, causing livelock or adding too much
>> noise to perf statistics. A similar livelock issue was described in
>> commit 029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead")
>>
>> Reproducer:
>>
>> This race issue can be triggered easily using a well constructed
>> reproducer and patched brd (with a delay in read path) [1]:
>>
>> With latest 6.8 mainline, race caused data loss can be observed easily:
>> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>>   Polulating 32MB of memory region...
>>   Keep swapping out...
>>   Starting round 0...
>>   Spawning 65536 workers...
>>   32746 workers spawned, wait for done...
>>   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
>>   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
>>   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
>>   Round 0 Failed, 15 data loss!
>>
>> This reproducer spawns multiple threads sharing the same memory region
>> using a small swap device. Every two threads updates mapped pages one by
>> one in opposite direction trying to create a race, with one dedicated
>> thread keep swapping out the data out using madvise.
>>
>> The reproducer created a reproduce rate of about once every 5 minutes,
>> so the race should be totally possible in production.
>>
>> After this patch, I ran the reproducer for over a few hundred rounds
>> and no data loss observed.
>>
>> Performance overhead is minimal, microbenchmark swapin 10G from 32G
>> zram:
>>
>> Before:     10934698 us
>> After:      11157121 us
>> Cached:     13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>>
>> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous=
 device")
>> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress=
-race [1]
>> Reported-by: "Huang, Ying" <ying.huang@intel.com>
>> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr=
corp.intel.com/
>> Signed-off-by: Kairui Song <kasong@tencent.com>
>> Cc: stable@vger.kernel.org
>>
>> ---
>> V3: https://lore.kernel.org/all/20240216095105.14502-1-ryncsn@gmail.com/
>> Update from V3:
>> - Use schedule_timeout_uninterruptible(1) for now instead of schedule() =
to
>>   prevent the busy faulting task holds CPU and livelocks [Huang, Ying]
>>
>> V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com/
>> Update from V2:
>> - Add a schedule() if raced to prevent repeated page faults wasting CPU
>>   and add noise to perf statistics.
>> - Use a bool to state the special case instead of reusing existing
>>   variables fixing error handling [Minchan Kim].
>>
>> V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
>> Update from V1:
>> - Add some words on ZRAM case, it will discard swap content on swap_free
>>   so the race window is a bit different but cure is the same. [Barry Son=
g]
>> - Update comments make it cleaner [Huang, Ying]
>> - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJae Par=
k]
>> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO
>>   instead of "direct swapin path" [Yu Zhao]
>> - Update commit message.
>> - Collect Review and Acks.
>>
>>  include/linux/swap.h |  5 +++++
>>  mm/memory.c          | 20 ++++++++++++++++++++
>>  mm/swap.h            |  5 +++++
>>  mm/swapfile.c        | 13 +++++++++++++
>>  4 files changed, 43 insertions(+)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 4db00ddad261..8d28f6091a32 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
>>         return 0;
>>  }
>>
>> +static inline int swapcache_prepare(swp_entry_t swp)
>> +{
>> +       return 0;
>> +}
>> +
>>  static inline void swap_free(swp_entry_t swp)
>>  {
>>  }
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 7e1f4849463a..a99f5e7be9a5 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>         struct page *page;
>>         struct swap_info_struct *si =3D NULL;
>>         rmap_t rmap_flags =3D RMAP_NONE;
>> +       bool need_clear_cache =3D false;
>>         bool exclusive =3D false;
>>         swp_entry_t entry;
>>         pte_t pte;
>> @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>         if (!folio) {
>>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>>                     __swap_count(entry) =3D=3D 1) {
>> +                       /*
>> +                        * Prevent parallel swapin from proceeding with
>> +                        * the cache flag. Otherwise, another thread may
>> +                        * finish swapin first, free the entry, and swap=
out
>> +                        * reusing the same entry. It's undetectable as
>> +                        * pte_same() returns true due to entry reuse.
>> +                        */
>> +                       if (swapcache_prepare(entry)) {
>> +                               /* Relax a bit to prevent rapid repeated=
 page faults */
>> +                               schedule_timeout_uninterruptible(1);
>
> Not a ideal model, imaging two tasks,
>
> task A  - low priority running on a LITTLE core
> task B - high priority and have real-time requirements such as audio,
>               graphics running on a big core.
>
> The original code will make B win even if it is a bit later than A as its=
 CPU is
> much faster to finish swap_read_folio for example from zRAM. task B's
> swap-in can finish very soon.
>
> With the patch, B will wait a tick and its real-time performance will be
> negatively affected from time to time once low priority and high priority
> tasks fault in the same PTE and high priority tasks are a bit later than
> low priority tasks. This is a kind of priority inversion.
>
> When we support large folio swap-in, things can get worse. For example,
> to swap-in 16 or even more pages in one do_swap_page, the chance for
> task A and task B located in the same range of 16 PTEs will increase
> though they are not located in the same PTE.
>
> Please consider this is not a blocker for this patch. But I will put the =
problem
> in my list and run some real tests on Android phones later.

Yes.  This may hurt performance.  But this is necessary to solve a
livelock problem similar as commit 029c4628b2eb ("mm: swap: get rid of
livelock in swapin readahead").  Please consider that too.

--
Best Regards,
Huang, Ying

>> +                               goto out;
>> +                       }
>> +                       need_clear_cache =3D true;
>> +
>>                         /* skip swapcache */
>>                         folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, =
0,
>>                                                 vma, vmf->address, false=
);
>> @@ -4117,6 +4132,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>         if (vmf->pte)
>>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>>  out:
>> +       /* Clear the swap cache pin for direct swapin after PTL unlock */
>> +       if (need_clear_cache)
>> +               swapcache_clear(si, entry);
>>         if (si)
>>                 put_swap_device(si);
>>         return ret;
>> @@ -4131,6 +4149,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>                 folio_unlock(swapcache);
>>                 folio_put(swapcache);
>>         }
>> +       if (need_clear_cache)
>> +               swapcache_clear(si, entry);
>>         if (si)
>>                 put_swap_device(si);
>>         return ret;
>> diff --git a/mm/swap.h b/mm/swap.h
>> index 758c46ca671e..fc2f6ade7f80 100644
>> --- a/mm/swap.h
>> +++ b/mm/swap.h
>> @@ -41,6 +41,7 @@ void __delete_from_swap_cache(struct folio *folio,
>>  void delete_from_swap_cache(struct folio *folio);
>>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>>                                   unsigned long end);
>> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
>>  struct folio *swap_cache_get_folio(swp_entry_t entry,
>>                 struct vm_area_struct *vma, unsigned long addr);
>>  struct folio *filemap_get_incore_folio(struct address_space *mapping,
>> @@ -97,6 +98,10 @@ static inline int swap_writepage(struct page *p, stru=
ct writeback_control *wbc)
>>         return 0;
>>  }
>>
>> +static inline void swapcache_clear(struct swap_info_struct *si, swp_ent=
ry_t entry)
>> +{
>> +}
>> +
>>  static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
>>                 struct vm_area_struct *vma, unsigned long addr)
>>  {
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 556ff7347d5f..746aa9da5302 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -3365,6 +3365,19 @@ int swapcache_prepare(swp_entry_t entry)
>>         return __swap_duplicate(entry, SWAP_HAS_CACHE);
>>  }
>>
>> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
>> +{
>> +       struct swap_cluster_info *ci;
>> +       unsigned long offset =3D swp_offset(entry);
>> +       unsigned char usage;
>> +
>> +       ci =3D lock_cluster_or_swap_info(si, offset);
>> +       usage =3D __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
>> +       unlock_cluster_or_swap_info(si, ci);
>> +       if (!usage)
>> +               free_swap_slot(entry);
>> +}
>> +
>>  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
>>  {
>>         return swap_type_to_swap_info(swp_type(entry));
>> --
>> 2.43.0
>>
>>
>
> Thanks
> Barry

