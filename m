Return-Path: <linux-kernel+bounces-70656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF65859AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A100D281204
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F451FDB;
	Mon, 19 Feb 2024 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQzZ8HKs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458E1FA3;
	Mon, 19 Feb 2024 02:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708310155; cv=none; b=LZ/fvtST/TJTruYAudLsKXw7LiPr/yFmOb6qr9gsA3/gu2uLpeVtHKXBMH8HqZdR8Igt8zmn9i2cYDMXcz48YuR/mbSDeky1boskxQEoCK9MeKZDehYREU1aRu9UFtF2geQx0sVIqx9AxleL/uoiKwi+oqxmEL+pIqBJfLGJ08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708310155; c=relaxed/simple;
	bh=arryqPs7E+gDphJSVU2BYnHpg1ovsJt6GImFrXkhFIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y77AVQSoBxgSjV3/YOdpv8ceCOnV18n+Z69SRsMsKpJAFQ6iEjCIju4ajU1Wjim5DWpoJz1sLZ0g13y6gJAYtwnXHtumBXF6C/AAT/BEZKl3d+Zh6n/ngpVbP+xylI6Lb2DWPFnFHGNJgDiD/xd4CzFSee6D6RJirA5vJ9YBYzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQzZ8HKs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708310153; x=1739846153;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=arryqPs7E+gDphJSVU2BYnHpg1ovsJt6GImFrXkhFIU=;
  b=YQzZ8HKso+/zYarGDsirdquRHRWXT3vefVsAN1Ol6WKoWSzMqZfdLMwT
   LTh2Sna1kCE4jOk/L4Z3PFDeE/sVxQxO3s9XxA084MZXLy/cnP92Qzbho
   u+UMsC8XKVJBbOk7ZCtE63Bqe417VMmESWf7vNBB2XDwCktMoID3fhaDX
   0b+NEeEaYZA60cM1D3M4+5UpYQi02Kn7J2jn3if4YoDRBQX6bajQIw0YL
   ZuVHpgKTWSKjhxO76SwtlUXbrEFdFlikaPXoikChrflR8jNv548p4EogQ
   mXHJmpxIMjCD3e0fU3orsrP9zxFE0Qv/oaRRk3nw7E9vMQwPSQIALld1t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="19801713"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19801713"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 18:35:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="8975601"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 18:35:46 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  Chris
 Li <chrisl@kernel.org>,  Minchan Kim <minchan@kernel.org>,  Yu Zhao
 <yuzhao@google.com>,  Barry Song <v-songbaohua@oppo.com>,  SeongJae Park
 <sj@kernel.org>,  Hugh Dickins <hughd@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Matthew Wilcox <willy@infradead.org>,  Michal Hocko
 <mhocko@suse.com>,  Yosry Ahmed <yosryahmed@google.com>,  David
 Hildenbrand <david@redhat.com>,  stable@vger.kernel.org,
  linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
In-Reply-To: <87jzn1s2xe.fsf@yhuang6-desk2.ccr.corp.intel.com> (Ying Huang's
	message of "Mon, 19 Feb 2024 08:39:09 +0800")
References: <20240216095105.14502-1-ryncsn@gmail.com>
	<87wmr2rx4a.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7CArJDbEev3YR2OB4aZjE9n6PzuzC6WLmsxCKhwq-jb3Q@mail.gmail.com>
	<87jzn1s2xe.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date: Mon, 19 Feb 2024 10:33:51 +0800
Message-ID: <87frxprxm8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Huang, Ying" <ying.huang@intel.com> writes:

> Kairui Song <ryncsn@gmail.com> writes:
>
>> On Sun, Feb 18, 2024 at 4:34=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
>>>
>>> Kairui Song <ryncsn@gmail.com> writes:
>>>
>>> > From: Kairui Song <kasong@tencent.com>
>>> >
>>> > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
>>> > swapin the same entry at the same time, they get different pages (A, =
B).
>>> > Before one thread (T0) finishes the swapin and installs page (A)
>>> > to the PTE, another thread (T1) could finish swapin of page (B),
>>> > swap_free the entry, then swap out the possibly modified page
>>> > reusing the same entry. It breaks the pte_same check in (T0) because
>>> > PTE value is unchanged, causing ABA problem. Thread (T0) will
>>> > install a stalled page (A) into the PTE and cause data corruption.
>>> >
>>> > One possible callstack is like this:
>>> >
>>> > CPU0                                 CPU1
>>> > ----                                 ----
>>> > do_swap_page()                       do_swap_page() with same entry
>>> > <direct swapin path>                 <direct swapin path>
>>> > <alloc page A>                       <alloc page B>
>>> > swap_read_folio() <- read to page A  swap_read_folio() <- read to pag=
e B
>>> > <slow on later locks or interrupt>   <finished swapin first>
>>> > ...                                  set_pte_at()
>>> >                                      swap_free() <- entry is free
>>> >                                      <write to page B, now page A sta=
lled>
>>> >                                      <swap out page B to same swap en=
try>
>>> > pte_same() <- Check pass, PTE seems
>>> >               unchanged, but page A
>>> >               is stalled!
>>> > swap_free() <- page B content lost!
>>> > set_pte_at() <- staled page A installed!
>>> >
>>> > And besides, for ZRAM, swap_free() allows the swap device to discard
>>> > the entry content, so even if page (B) is not modified, if
>>> > swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
>>> > it may also cause data loss.
>>> >
>>> > To fix this, reuse swapcache_prepare which will pin the swap entry us=
ing
>>> > the cache flag, and allow only one thread to pin it. Release the pin
>>> > after PT unlocked. Racers will simply wait since it's a rare and very
>>> > short event. A schedule() call is added to avoid wasting too much CPU
>>> > or adding too much noise to perf statistics
>>> >
>>> > Other methods like increasing the swap count don't seem to be a good
>>> > idea after some tests, that will cause racers to fall back to use the
>>> > swap cache again. Parallel swapin using different methods leads to
>>> > a much more complex scenario.
>>>
>>> The swap entry may be put in swap cache by some parallel code path
>>> anyway.  So, we always need to consider that when reasoning the code.
>>>
>>> > Reproducer:
>>> >
>>> > This race issue can be triggered easily using a well constructed
>>> > reproducer and patched brd (with a delay in read path) [1]:
>>> >
>>> > With latest 6.8 mainline, race caused data loss can be observed easil=
y:
>>> > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>>> >   Polulating 32MB of memory region...
>>> >   Keep swapping out...
>>> >   Starting round 0...
>>> >   Spawning 65536 workers...
>>> >   32746 workers spawned, wait for done...
>>> >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
>>> >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
>>> >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
>>> >   Round 0 Failed, 15 data loss!
>>> >
>>> > This reproducer spawns multiple threads sharing the same memory region
>>> > using a small swap device. Every two threads updates mapped pages one=
 by
>>> > one in opposite direction trying to create a race, with one dedicated
>>> > thread keep swapping out the data out using madvise.
>>> >
>>> > The reproducer created a reproduce rate of about once every 5 minutes,
>>> > so the race should be totally possible in production.
>>> >
>>> > After this patch, I ran the reproducer for over a few hundred rounds
>>> > and no data loss observed.
>>> >
>>> > Performance overhead is minimal, microbenchmark swapin 10G from 32G
>>> > zram:
>>> >
>>> > Before:     10934698 us
>>> > After:      11157121 us
>>> > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>>> >
>>> > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchron=
ous device")
>>> > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-str=
ess-race [1]
>>> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
>>> > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.=
ccr.corp.intel.com/
>>> > Signed-off-by: Kairui Song <kasong@tencent.com>
>>> > Cc: stable@vger.kernel.org
>>> >
>>> > ---
>>> > Update from V2:
>>> > - Add a schedule() if raced to prevent repeated page faults wasting C=
PU
>>> >   and add noise to perf statistics.
>>> > - Use a bool to state the special case instead of reusing existing
>>> >   variables fixing error handling [Minchan Kim].
>>> >
>>> > V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.c=
om/
>>> >
>>> > Update from V1:
>>> > - Add some words on ZRAM case, it will discard swap content on swap_f=
ree so the race window is a bit different but cure is the same. [Barry Song]
>>> > - Update comments make it cleaner [Huang, Ying]
>>> > - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJae =
Park]
>>> > - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO =
instead of "direct swapin path" [Yu Zhao]
>>> > - Update commit message.
>>> > - Collect Review and Acks.
>>> >
>>> > V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.co=
m/
>>> >
>>> >  include/linux/swap.h |  5 +++++
>>> >  mm/memory.c          | 20 ++++++++++++++++++++
>>> >  mm/swap.h            |  5 +++++
>>> >  mm/swapfile.c        | 13 +++++++++++++
>>> >  4 files changed, 43 insertions(+)
>>> >
>>> > diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> > index 4db00ddad261..8d28f6091a32 100644
>>> > --- a/include/linux/swap.h
>>> > +++ b/include/linux/swap.h
>>> > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
>>> >       return 0;
>>> >  }
>>> >
>>> > +static inline int swapcache_prepare(swp_entry_t swp)
>>> > +{
>>> > +     return 0;
>>> > +}
>>> > +
>>> >  static inline void swap_free(swp_entry_t swp)
>>> >  {
>>> >  }
>>> > diff --git a/mm/memory.c b/mm/memory.c
>>> > index 7e1f4849463a..7059230d0a54 100644
>>> > --- a/mm/memory.c
>>> > +++ b/mm/memory.c
>>> > @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>> >       struct page *page;
>>> >       struct swap_info_struct *si =3D NULL;
>>> >       rmap_t rmap_flags =3D RMAP_NONE;
>>> > +     bool need_clear_cache =3D false;
>>> >       bool exclusive =3D false;
>>> >       swp_entry_t entry;
>>> >       pte_t pte;
>>> > @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>> >       if (!folio) {
>>> >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>>> >                   __swap_count(entry) =3D=3D 1) {
>>> > +                     /*
>>> > +                      * Prevent parallel swapin from proceeding with
>>> > +                      * the cache flag. Otherwise, another thread may
>>> > +                      * finish swapin first, free the entry, and swa=
pout
>>> > +                      * reusing the same entry. It's undetectable as
>>> > +                      * pte_same() returns true due to entry reuse.
>>> > +                      */
>>> > +                     if (swapcache_prepare(entry)) {
>>> > +                             /* Relax a bit to prevent rapid repeate=
d page faults */
>>> > +                             schedule();
>>>
>>> The current task may be chosen in schedule().  So, I think that we
>>> should use cond_resched() here.
>>>
>>
>> I think if we are worried about current task got chosen again we can
>> use schedule_timeout_uninterruptible(1) here. Isn't cond_resched still
>> __schedule() and and it can even get omitted, so it should be "weaker"
>> IIUC.
>
> schedule_timeout_uninterruptible(1) will introduce 1ms latency for the
> second task.  That may kill performance of some workloads.

Just found that the cond_sched() in __read_swap_cache_async() has been
changed to schedule_timeout_uninterruptible(1) to fix some live lock.
Details are in the description of commit 029c4628b2eb ("mm: swap: get
rid of livelock in swapin readahead").  I think the similar issue may
happen here too.  So, we must use schedule_timeout_uninterruptible(1)
here until some other better idea becomes available.

--
Best Regards,
Huang, Ying

