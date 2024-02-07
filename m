Return-Path: <linux-kernel+bounces-55839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1AA84C246
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2373A1F28281
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0443DDB7;
	Wed,  7 Feb 2024 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyYS1oEl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBCEDDB3;
	Wed,  7 Feb 2024 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707271852; cv=none; b=lDuT915eaMcIFY/JpdFj4dD1o8M+AM0mmWpgOuAe893AioX2J8U6AMr6JCzXXivDSvqfNW4hbd2167em1xoT/VzbuTSTDvg10GE7UwFh2H2hrVbyPZ3ArgwkFv5ZZPzZO/ep95Vv4MDB5MhEdJLX1O3lCdBrB/g6bMViie3c+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707271852; c=relaxed/simple;
	bh=wlR15foNqth8/8BSNdAdwtfvkeX+1SMi7T/b+TU+0bE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sUrAx8Ym94c1RmTVtYTLctnNM134tWihCSFuDP1k1gChaaA4L/geK3K1SHxAP+qxXeVrLFf9w4s18unTXM6l8vJ/NEZtG5SxLjAuIdBHWLZHtIp7mcx7qdHjUQLM+IZK4eqIDT5xpajre7oFwTgjBZGfFusonYHEN5Mf3PvPnJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyYS1oEl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707271851; x=1738807851;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=wlR15foNqth8/8BSNdAdwtfvkeX+1SMi7T/b+TU+0bE=;
  b=DyYS1oElX6KYVqDuY+qpN8ZNmxPVeosPsyTQ/H5GCWg0CGsa3RnBoYuL
   9D6y38qXqLd7t9BFEak42Xq900Zswa6lsB73PFG6GlJhj9Dp7ruTpONwp
   4kptikuJ+reUvM6bhitjj1ISJ9Obd0cNDwdjQ/1qKZDEVuobt2w+3qyGt
   AbuZE74moiM387qAYGWbEYfhcZSTAR3o5ecynOgE450lvenRABoBlKnv8
   5fETmVXOrgumrJMf9YEpbjdg2Svelcgg023wTcTPItGdHw5RkkpMdZi/e
   d3bVh2JyH97bt17kch2Ls5zFQv7fL70pAYV2J232Yx11iWS46lOTABx2E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="18309820"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="18309820"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 18:10:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1508747"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 18:10:45 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Chris Li <chrisl@kernel.org>,  Kairui Song <kasong@tencent.com>,
  linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  Minchan
 Kim <minchan@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Barry Song
 <v-songbaohua@oppo.com>,  SeongJae Park <sj@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,
  stable@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
In-Reply-To: <CAGsJ_4zF+U5JG8XYANe2x0VbjovokFCirf=YLHOfO3E-U8b4sg@mail.gmail.com>
	(Barry Song's message of "Wed, 7 Feb 2024 07:40:12 +0800")
References: <20240206182559.32264-1-ryncsn@gmail.com>
	<CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
	<CAGsJ_4zF+U5JG8XYANe2x0VbjovokFCirf=YLHOfO3E-U8b4sg@mail.gmail.com>
Date: Wed, 07 Feb 2024 10:08:49 +0800
Message-ID: <87sf25yqj2.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Wed, Feb 7, 2024 at 7:18=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>>
>> Hi Kairui,
>>
>> Sorry replying to your patch V1 late, I will reply on the V2 thread.
>>
>> On Tue, Feb 6, 2024 at 10:28=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
>> >
>> > From: Kairui Song <kasong@tencent.com>
>> >
>> > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
>> > swapin the same entry at the same time, they get different pages (A, B=
).
>> > Before one thread (T0) finishes the swapin and installs page (A)
>> > to the PTE, another thread (T1) could finish swapin of page (B),
>> > swap_free the entry, then swap out the possibly modified page
>> > reusing the same entry. It breaks the pte_same check in (T0) because
>> > PTE value is unchanged, causing ABA problem. Thread (T0) will
>> > install a stalled page (A) into the PTE and cause data corruption.
>> >
>> > One possible callstack is like this:
>> >
>> > CPU0                                 CPU1
>> > ----                                 ----
>> > do_swap_page()                       do_swap_page() with same entry
>> > <direct swapin path>                 <direct swapin path>
>> > <alloc page A>                       <alloc page B>
>> > swap_read_folio() <- read to page A  swap_read_folio() <- read to page=
 B
>> > <slow on later locks or interrupt>   <finished swapin first>
>> > ...                                  set_pte_at()
>> >                                      swap_free() <- entry is free
>> >                                      <write to page B, now page A stal=
led>
>> >                                      <swap out page B to same swap ent=
ry>
>> > pte_same() <- Check pass, PTE seems
>> >               unchanged, but page A
>> >               is stalled!
>> > swap_free() <- page B content lost!
>> > set_pte_at() <- staled page A installed!
>> >
>> > And besides, for ZRAM, swap_free() allows the swap device to discard
>> > the entry content, so even if page (B) is not modified, if
>> > swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
>> > it may also cause data loss.
>> >
>> > To fix this, reuse swapcache_prepare which will pin the swap entry usi=
ng
>> > the cache flag, and allow only one thread to pin it. Release the pin
>> > after PT unlocked. Racers will simply busy wait since it's a rare
>> > and very short event.
>> >
>> > Other methods like increasing the swap count don't seem to be a good
>> > idea after some tests, that will cause racers to fall back to use the
>> > swap cache again. Parallel swapin using different methods leads to
>> > a much more complex scenario.
>> >
>> > Reproducer:
>> >
>> > This race issue can be triggered easily using a well constructed
>> > reproducer and patched brd (with a delay in read path) [1]:
>> >
>> > With latest 6.8 mainline, race caused data loss can be observed easily:
>> > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>> >   Polulating 32MB of memory region...
>> >   Keep swapping out...
>> >   Starting round 0...
>> >   Spawning 65536 workers...
>> >   32746 workers spawned, wait for done...
>> >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
>> >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
>> >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
>> >   Round 0 Failed, 15 data loss!
>> >
>> > This reproducer spawns multiple threads sharing the same memory region
>> > using a small swap device. Every two threads updates mapped pages one =
by
>> > one in opposite direction trying to create a race, with one dedicated
>> > thread keep swapping out the data out using madvise.
>> >
>> > The reproducer created a reproduce rate of about once every 5 minutes,
>> > so the race should be totally possible in production.
>> >
>> > After this patch, I ran the reproducer for over a few hundred rounds
>> > and no data loss observed.
>> >
>> > Performance overhead is minimal, microbenchmark swapin 10G from 32G
>> > zram:
>> >
>> > Before:     10934698 us
>> > After:      11157121 us
>> > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>> >
>> > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchrono=
us device")
>> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
>> > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.c=
cr.corp.intel.com/
>> > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stre=
ss-race [1]
>> > Signed-off-by: Kairui Song <kasong@tencent.com>
>> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> > Acked-by: Yu Zhao <yuzhao@google.com>
>> >
>> > ---
>> > Update from V1:
>> > - Add some words on ZRAM case, it will discard swap content on swap_fr=
ee so the race window is a bit different but cure is the same. [Barry Song]
>> > - Update comments make it cleaner [Huang, Ying]
>> > - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJae P=
ark]
>> > - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO i=
nstead of "direct swapin path" [Yu Zhao]
>> > - Update commit message.
>> > - Collect Review and Acks.
>> >
>> >  include/linux/swap.h |  5 +++++
>> >  mm/memory.c          | 15 +++++++++++++++
>> >  mm/swap.h            |  5 +++++
>> >  mm/swapfile.c        | 13 +++++++++++++
>> >  4 files changed, 38 insertions(+)
>> >
>> > diff --git a/include/linux/swap.h b/include/linux/swap.h
>> > index 4db00ddad261..8d28f6091a32 100644
>> > --- a/include/linux/swap.h
>> > +++ b/include/linux/swap.h
>> > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
>> >         return 0;
>> >  }
>> >
>> > +static inline int swapcache_prepare(swp_entry_t swp)
>> > +{
>> > +       return 0;
>> > +}
>> > +
>> >  static inline void swap_free(swp_entry_t swp)
>> >  {
>> >  }
>> > diff --git a/mm/memory.c b/mm/memory.c
>> > index 7e1f4849463a..1749c700823d 100644
>> > --- a/mm/memory.c
>> > +++ b/mm/memory.c
>> > @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >         if (!folio) {
>> >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>> >                     __swap_count(entry) =3D=3D 1) {
>> > +                       /*
>> > +                        * Prevent parallel swapin from proceeding with
>> > +                        * the cache flag. Otherwise, another thread m=
ay
>> > +                        * finish swapin first, free the entry, and sw=
apout
>> > +                        * reusing the same entry. It's undetectable as
>> > +                        * pte_same() returns true due to entry reuse.
>> > +                        */
>> > +                       if (swapcache_prepare(entry))
>> > +                               goto out;
>> > +
>>
>> I am puzzled by this "goto out". If I understand this correctly, you
>> have two threads CPU1 and CPU2 racing to set the flag SWAP_HAS_CACHE.
>> The CPU1 will succeed in adding the flag and  the CPU2 will get
>> "-EEXIST" from "swapcache_prepare(entry)".  Am I understanding it
>> correctly so far?
>>
>> Then the goto out seems wrong to me. For the CPU2, the page fault will
>> return *unhandled*. Even worse, the "-EEXIST" error is not preserved,
>> CPU2 does not even know the page fault is not handled, it will resume
>> from the page fault instruction, possibly generate another page fault
>> at the exact same location. That page fault loop will repeat until
>> CPU1 install the new pte on that faulting virtual address and pick up
>> by CPU2.
>>
>> Am I missing something obvious there?
>
> I feel you are right. any concurrent page faults at the same pte
> will increase the count of page faults for a couple of times now.
>
>>
>> I just re-read your comment: "Racers will simply busy wait since it's
>> a rare and very short event." That might be referring to the above
>> CPU2 page fault looping situation. I consider the page fault looping
>> on CPU2 not acceptable. For one it will mess up the page fault
>> statistics.
>> In my mind, having an explicit loop for CPU2 waiting for the PTE to
>> show up is still better than this page fault loop. You can have more
>> CPU power friendly loops.
>
> I assume you mean something like
>
> while(!pte_same())
>    cpu_relax();
>
> then we still have a chance to miss the change of B.
>
> For example, another thread is changing pte to A->B->A, our loop can
> miss B. Thus we will trap into an infinite loop. this is even worse.
>
> is it possible to loop for the success of swapcache_prepare(entry)
> instead?

This doesn't work too.  The swap count can increase to > 1 and be put in
swap cache for long time.

Another possibility is to move swapcache_prepare() after
vma_alloc_folio() to reduce the race window.

--
Best Regards,
Huang, Ying

>>
>> This behavior needs more discussion.
>>
>> Chris
>>
>>
>> Chris
>>
>>
>> >                         /* skip swapcache */
>> >                         folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE=
, 0,
>> >                                                 vma, vmf->address, fal=
se);
>> > @@ -4116,6 +4126,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >  unlock:
>> >         if (vmf->pte)
>> >                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>> > +       /* Clear the swap cache pin for direct swapin after PTL unlock=
 */
>> > +       if (folio && !swapcache)
>> > +               swapcache_clear(si, entry);
>> >  out:
>> >         if (si)
>> >                 put_swap_device(si);
>> > @@ -4124,6 +4137,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>> >         if (vmf->pte)
>> >                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>> >  out_page:
>> > +       if (!swapcache)
>> > +               swapcache_clear(si, entry);
>> >         folio_unlock(folio);
>> >  out_release:
>> >         folio_put(folio);
>> > diff --git a/mm/swap.h b/mm/swap.h
>> > index 758c46ca671e..fc2f6ade7f80 100644
>> > --- a/mm/swap.h
>> > +++ b/mm/swap.h
>> > @@ -41,6 +41,7 @@ void __delete_from_swap_cache(struct folio *folio,
>> >  void delete_from_swap_cache(struct folio *folio);
>> >  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>> >                                   unsigned long end);
>> > +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
>> >  struct folio *swap_cache_get_folio(swp_entry_t entry,
>> >                 struct vm_area_struct *vma, unsigned long addr);
>> >  struct folio *filemap_get_incore_folio(struct address_space *mapping,
>> > @@ -97,6 +98,10 @@ static inline int swap_writepage(struct page *p, st=
ruct writeback_control *wbc)
>> >         return 0;
>> >  }
>> >
>> > +static inline void swapcache_clear(struct swap_info_struct *si, swp_e=
ntry_t entry)
>> > +{
>> > +}
>> > +
>> >  static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
>> >                 struct vm_area_struct *vma, unsigned long addr)
>> >  {
>> > diff --git a/mm/swapfile.c b/mm/swapfile.c
>> > index 556ff7347d5f..746aa9da5302 100644
>> > --- a/mm/swapfile.c
>> > +++ b/mm/swapfile.c
>> > @@ -3365,6 +3365,19 @@ int swapcache_prepare(swp_entry_t entry)
>> >         return __swap_duplicate(entry, SWAP_HAS_CACHE);
>> >  }
>> >
>> > +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
>> > +{
>> > +       struct swap_cluster_info *ci;
>> > +       unsigned long offset =3D swp_offset(entry);
>> > +       unsigned char usage;
>> > +
>> > +       ci =3D lock_cluster_or_swap_info(si, offset);
>> > +       usage =3D __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
>> > +       unlock_cluster_or_swap_info(si, ci);
>> > +       if (!usage)
>> > +               free_swap_slot(entry);
>> > +}
>> > +
>> >  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
>> >  {
>> >         return swap_type_to_swap_info(swp_type(entry));
>> > --
>> > 2.43.0
>
> Thanks
> Barry

