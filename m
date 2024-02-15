Return-Path: <linux-kernel+bounces-67796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1E68570D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF031F2311E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496D21420D4;
	Thu, 15 Feb 2024 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OwAgFTCP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3265D13AA23;
	Thu, 15 Feb 2024 22:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037918; cv=none; b=oM416ZYmt4FrtDA3YFyzvAGB2iOloiTTfqnhyiLoWLksLxGOzcs8j1RDzvOAOJ6diG3kWW5pzASlSvUGwZmrAEpI7B55oDrCMajDodpIwd05idG+2KxkMvuQ9PUuPSk/vjmwP5rw1ro+NbU3SMilF7s4Ib9oDj6w7OETMemPBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037918; c=relaxed/simple;
	bh=LKA/ClUmTfQI6DQT0IR/p+d0WUTkStXM03s4oe6WFx8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kutmmM/pdwoW60A3+I+Bul0C5pzTnuBdQWXKMWCCxHkcnWZ72I87c/4NOjSpOnq0xLtQt2VtcPtXrFKBdVUnNIqdo5W19l2ZTVLgYfbWM5ZVcYr5MPlLRPnTHyX0+uiTLRwUsvoUfVnYLLr5snKBYKhHBCnWuI+sq3krxfEDE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OwAgFTCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400E9C433C7;
	Thu, 15 Feb 2024 22:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708037917;
	bh=LKA/ClUmTfQI6DQT0IR/p+d0WUTkStXM03s4oe6WFx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OwAgFTCPc6Uk64NzZ6GhG8EtJnwxDjnbWjnDV6G447crYs2YFfsyzmavZQXar+sOn
	 CNknwea6X9YcvX/hNfVLJ//0OohAladfqIWc/EWQan6yTyeaNZNoWzLMtw6O/+L+Wm
	 XL4YGf3f8J++vDDGzp0OFjeJcDMSHP4Ba4pG/KcI=
Date: Thu, 15 Feb 2024 14:58:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Minchan Kim <minchan@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Kairui Song <ryncsn@gmail.com>,
 linux-mm@kvack.org, "Huang, Ying" <ying.huang@intel.com>, Chris Li
 <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>, Barry Song
 <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins
 <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox
 <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, Yosry Ahmed
 <yosryahmed@google.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
Message-Id: <20240215145836.6db8f62824e1547f0608591c@linux-foundation.org>
In-Reply-To: <Zc56L6oL4JmxqaFN@google.com>
References: <20240206182559.32264-1-ryncsn@gmail.com>
	<1d259a51-46e6-4d3b-9455-38dbcc17b168@redhat.com>
	<CAMgjq7Cy3njsQzGi5Wa_JaM4NaO4eDGO5D8cY+KEB0ERd_JrGw@mail.gmail.com>
	<4c651673-132f-4cd8-997e-175f586fd2e6@redhat.com>
	<Zc56L6oL4JmxqaFN@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 12:55:11 -0800 Minchan Kim <minchan@kernel.org> wrote:

> Only concern of the approach is that it would be harder to have the fix
> in the stable tree. If there isn't strong objection, I prefer the
> Kairui's orginal solution(with some tweak of scheduler if it's
> necessary) first and then pursue your idea on latest tree.

Do we agree that this fix is needed in -stable?  For some reason I
don't have a cc:stable in the changelog.

I'd like to move this patch into mm-hotfixes-stable in order to get it
upstream very soon.  Are we all agreeable with that?  I don't have an
Acked-by: David?

I have a note (which dates back to an earlier version) that Barry would
be performing runtime testing.  Has that occurred?

Thanks.


Here's what is presently in mm-hotfixes-unstable:



From: Kairui Song <kasong@tencent.com>
Subject: mm/swap: fix race when skipping swapcache
Date: Wed, 7 Feb 2024 02:25:59 +0800

When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
swapin the same entry at the same time, they get different pages (A, B). 
Before one thread (T0) finishes the swapin and installs page (A) to the
PTE, another thread (T1) could finish swapin of page (B), swap_free the
entry, then swap out the possibly modified page reusing the same entry. 
It breaks the pte_same check in (T0) because PTE value is unchanged,
causing ABA problem.  Thread (T0) will install a stalled page (A) into the
PTE and cause data corruption.

One possible callstack is like this:

CPU0                                 CPU1
----                                 ----
do_swap_page()                       do_swap_page() with same entry
<direct swapin path>                 <direct swapin path>
<alloc page A>                       <alloc page B>
swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
<slow on later locks or interrupt>   <finished swapin first>
..                                  set_pte_at()
                                     swap_free() <- entry is free
                                     <write to page B, now page A stalled>
                                     <swap out page B to same swap entry>
pte_same() <- Check pass, PTE seems
              unchanged, but page A
              is stalled!
swap_free() <- page B content lost!
set_pte_at() <- staled page A installed!

And besides, for ZRAM, swap_free() allows the swap device to discard the
entry content, so even if page (B) is not modified, if swap_read_folio()
on CPU0 happens later than swap_free() on CPU1, it may also cause data
loss.

To fix this, reuse swapcache_prepare which will pin the swap entry using
the cache flag, and allow only one thread to pin it.  Release the pin
after PT unlocked.  Racers will simply busy wait since it's a rare and
very short event.

Other methods like increasing the swap count don't seem to be a good idea
after some tests, that will cause racers to fall back to use the swap
cache again.  Parallel swapin using different methods leads to a much more
complex scenario.

Reproducer:

This race issue can be triggered easily using a well constructed
reproducer and patched brd (with a delay in read path) [1]:

With latest 6.8 mainline, race caused data loss can be observed easily:
$ gcc -g -lpthread test-thread-swap-race.c && ./a.out
  Polulating 32MB of memory region...
  Keep swapping out...
  Starting round 0...
  Spawning 65536 workers...
  32746 workers spawned, wait for done...
  Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
  Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
  Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
  Round 0 Failed, 15 data loss!

This reproducer spawns multiple threads sharing the same memory region
using a small swap device. Every two threads updates mapped pages one by
one in opposite direction trying to create a race, with one dedicated
thread keep swapping out the data out using madvise.

The reproducer created a reproduce rate of about once every 5 minutes,
so the race should be totally possible in production.

After this patch, I ran the reproducer for over a few hundred rounds
and no data loss observed.

Performance overhead is minimal, microbenchmark swapin 10G from 32G
zram:

Before:     10934698 us
After:      11157121 us
Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)

Link: https://lkml.kernel.org/r/20240206182559.32264-1-ryncsn@gmail.com
Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous device")
Reported-by: "Huang, Ying" <ying.huang@intel.com>
Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: Yu Zhao <yuzhao@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Barry Song <21cnbao@gmail.com>
Cc: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/swap.h |    5 +++++
 mm/memory.c          |   15 +++++++++++++++
 mm/swap.h            |    5 +++++
 mm/swapfile.c        |   13 +++++++++++++
 4 files changed, 38 insertions(+)

--- a/include/linux/swap.h~mm-swap-fix-race-when-skipping-swapcache
+++ a/include/linux/swap.h
@@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_ent
 	return 0;
 }
 
+static inline int swapcache_prepare(swp_entry_t swp)
+{
+	return 0;
+}
+
 static inline void swap_free(swp_entry_t swp)
 {
 }
--- a/mm/memory.c~mm-swap-fix-race-when-skipping-swapcache
+++ a/mm/memory.c
@@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
+			/*
+			 * Prevent parallel swapin from proceeding with
+			 * the cache flag. Otherwise, another thread may
+			 * finish swapin first, free the entry, and swapout
+			 * reusing the same entry. It's undetectable as
+			 * pte_same() returns true due to entry reuse.
+			 */
+			if (swapcache_prepare(entry))
+				goto out;
+
 			/* skip swapcache */
 			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
 						vma, vmf->address, false);
@@ -4116,6 +4126,9 @@ vm_fault_t do_swap_page(struct vm_fault
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+	/* Clear the swap cache pin for direct swapin after PTL unlock */
+	if (folio && !swapcache)
+		swapcache_clear(si, entry);
 out:
 	if (si)
 		put_swap_device(si);
@@ -4124,6 +4137,8 @@ out_nomap:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out_page:
+	if (!swapcache)
+		swapcache_clear(si, entry);
 	folio_unlock(folio);
 out_release:
 	folio_put(folio);
--- a/mm/swapfile.c~mm-swap-fix-race-when-skipping-swapcache
+++ a/mm/swapfile.c
@@ -3365,6 +3365,19 @@ int swapcache_prepare(swp_entry_t entry)
 	return __swap_duplicate(entry, SWAP_HAS_CACHE);
 }
 
+void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+{
+	struct swap_cluster_info *ci;
+	unsigned long offset = swp_offset(entry);
+	unsigned char usage;
+
+	ci = lock_cluster_or_swap_info(si, offset);
+	usage = __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
+	unlock_cluster_or_swap_info(si, ci);
+	if (!usage)
+		free_swap_slot(entry);
+}
+
 struct swap_info_struct *swp_swap_info(swp_entry_t entry)
 {
 	return swap_type_to_swap_info(swp_type(entry));
--- a/mm/swap.h~mm-swap-fix-race-when-skipping-swapcache
+++ a/mm/swap.h
@@ -41,6 +41,7 @@ void __delete_from_swap_cache(struct fol
 void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
+void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
@@ -97,6 +98,10 @@ static inline int swap_writepage(struct
 	return 0;
 }
 
+static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+{
+}
+
 static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr)
 {
_


