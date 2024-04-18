Return-Path: <linux-kernel+bounces-149558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4B28A92DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6E5282298
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648D66E5EF;
	Thu, 18 Apr 2024 06:15:54 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761773399B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420953; cv=none; b=KnM2kRYDuWyGl0oWN24cbmEtGgvBHPECWopxOmSYrUKPPoXfY7nT4/u0D2tTObp+7dWgQ0qT2W05mebiO+jMauPVh/WOhQJ7JXhffmjOoBgZ/X9sNSiM0AAW0LYwkNeNMKaM7F1OgjC2g/APPYSct/EipFIzwRwBslrd58Wmpqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420953; c=relaxed/simple;
	bh=qRiTuxcF30p5/EQGOP4Frm2Uk/oLYQ75RwnrA2E97Yw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kBTmOr231vwBIYfuWfaCZSjlwBks1qlpC+8hHAatnTR8DmSH4QyRHlGq8n1A/sqiAWsJFnmih5cHaR3wktqrkJyIvp/GObdk/5smYCDaFhowaKOAHoEsZhr9qQUy2D4fmu41dOdL9cSP9IRqTkrvK01BtSkI0ZaJX/0TEn9TOks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-f8-6620ba92fce0
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v9 rebase on mm-unstable 0/8] Reduce tlb and interrupt numbers over 90% by improving folio migration
Date: Thu, 18 Apr 2024 15:15:28 +0900
Message-Id: <20240418061536.11645-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC9ZZnoe6kXQppBjMfGlnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	N6/bmQtOhFds6o9sYHzp0MXIySEhYCJx/+QZRhj7wasGZhCbTUBd4saNn2C2iICZxMHWP+wg
	NrPAXSaJA/1sILawQInEzxvdTCA2i4CqxIHVE8DqeQVMJRa9PcgCMVNeYvWGA0BxLiD7OpvE
	tjPbmSESkhIHV9xgmcDIvYCRYRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZGYCAvq/0TvYPx04Xg
	Q4wCHIxKPLwnD8inCbEmlhVX5h5ilOBgVhLhbRGWTRPiTUmsrEotyo8vKs1JLT7EKM3BoiTO
	a/StPEVIID2xJDU7NbUgtQgmy8TBKdXAKClz9Uq38SXj2sdfrk7W/7x9XtWfj/J6uz68mn+q
	gPHDjZuGXw93KahFGFQflWZ2+5e4Kk/ng8qlkzm1VRkq+ffMeZ6LrekJ1K/ysZQKsrQymjxD
	YccVtp9WjgGbS/xXbONaanTt5p9dfxMLnf5NmPrH/tDloKxLz20yFBasspy7+HLoNc6iCCWW
	4oxEQy3mouJEAHYngtpgAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsXC5WfdrDtpl0KawYv1ahZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgynjzup254ER4xab+yAbGlw5djJwcEgImEg9eNTCD2GwC6hI3bvwEs0UEzCQO
	tv5hB7GZBe4ySRzoZwOxhQVKJH7e6GYCsVkEVCUOrJ4AVs8rYCqx6O1BFoiZ8hKrNxxgnsDI
	sYCRYRWjSGZeWW5iZo6pXnF2RmVeZoVecn7uJkZgWC6r/TNxB+OXy+6HGAU4GJV4eE8ckE8T
	Yk0sK67MPcQowcGsJMLbIiybJsSbklhZlVqUH19UmpNafIhRmoNFSZzXKzw1QUggPbEkNTs1
	tSC1CCbLxMEp1cAoJqSl6LR3ycTcK3eeLM8qu3f5w8zHmaFi7fvi+7YJMZluOWQas3xhXsmq
	+rXHjl7kqFD64sSV3cR/YUlt3Pq2l2ICxqzFdet1k6UD7/JyVR6dV2x7Knb58RN5Brf2xJ4z
	9p/o6fN90WsmvcL3hqmtOy72hBlqTjAM+JGtI2wq1e1XzlTorqvEUpyRaKjFXFScCAAtjWsW
	RwIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi everyone,

While I'm working with a tiered memory system e.g. CXL memory, I have
been facing migration overhead esp. tlb shootdown on promotion or
demotion between different tiers.  Yeah..  most tlb shootdowns on
migration through hinting fault can be avoided thanks to Huang Ying's
work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
is inaccessible").  See the following link for more information:

https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/

However, it's only for ones using hinting fault.  I thought it'd be much
better if we have a general mechanism to reduce all tlb numbers that we
can ultimately apply to any type of migration.

I'm suggesting a mechanism called MIGRC that stands for 'Migration Read
Copy', to reduce tlb numbers by deferring tlb flush until the source
folios at migration actually become used, of course, only if the target
PTE don't have write permission.

To achieve that:

   1. For the folios that map only to non-writable tlb entries, prevent
      tlb flush during migration but perform it just before the source
      folios actually become used out of buddy or pcp.

   2. When any non-writable tlb entry changes to writable e.g. through
      fault handler, give up migrc mechanism and perform tlb flush
      required right away.

No matter what type of workload is used for performance evaluation, the
result would be positive thanks to the unconditional reduction of tlb
flushes, tlb misses and interrupts.  For the test, I picked up XSBench
that is widely used for performance analysis on high performance
computing architectures - https://github.com/ANL-CESAR/XSBench.

The result would depend on memory latency and how often reclaim runs,
which implies tlb miss overhead and how many times migration happens.
The slower the memory is and the more reclaim runs, the better migrc
works so as to obtain the better result.  In my system, the result
shows:

   1. itlb flushes are reduced over 90%.
   2. itlb misses are reduced over 30%.
   3. All the other tlb numbers also get enhanced.
   4. tlb shootdown interrupts are reduced over 90%.
   5. The test program runtime is reduced over 5%.

The test envitonment:

   Architecture - x86_64
   QEMU - kvm enabled, host cpu
   Numa - 2 nodes (16 CPUs 1GB, no CPUs 99GB)
   Linux Kernel - v6.9-rc4, numa balancing tiering on, demotion enabled

< measurement: raw data - tlb and interrupt numbers >

   $ perf stat -a \
           -e itlb.itlb_flush \
           -e tlb_flush.dtlb_thread \
           -e tlb_flush.stlb_any \
           -e dtlb-load-misses \
           -e dtlb-store-misses \
           -e itlb-load-misses \
           XSBench -t 16 -p 50000000

   $ grep "TLB shootdowns" /proc/interrupts

   BEFORE
   ------
   40417078     itlb.itlb_flush
   234852566    tlb_flush.dtlb_thread
   153192357    tlb_flush.stlb_any
   119001107892 dTLB-load-misses
   307921167    dTLB-store-misses
   1355272118   iTLB-load-misses

   TLB: 1364803    1303670    1333921    1349607
        1356934    1354216    1332972    1342842
        1350265    1316443    1355928    1360793
        1298239    1326358    1343006    1340971
        TLB shootdowns

   AFTER
   -----
   3316495      itlb.itlb_flush
   138912511    tlb_flush.dtlb_thread
   115199341    tlb_flush.stlb_any
   117610390021 dTLB-load-misses
   198042233    dTLB-store-misses
   840066984    iTLB-load-misses

   TLB: 117257     119219     117178     115737
        117967     118948     117508     116079
        116962     117266     117320     117215
        105808     103934     115672     117610
        TLB shootdowns

< measurement: user experience - runtime >

   $ time XSBench -t 16 -p 50000000

   BEFORE
   ------
   Threads:     16
   Runtime:     968.783 seconds
   Lookups:     1,700,000,000
   Lookups/s:   1,754,778

   15208.91s user 141.44s system 1564% cpu 16:20.98 total

   AFTER
   -----
   Threads:     16
   Runtime:     913.210 seconds
   Lookups:     1,700,000,000
   Lookups/s:   1,861,565

   14351.69s user 138.23s system 1565% cpu 15:25.47 total

---

Changes from v8:
	1. Rebase on akpm/mm.git mm-unstable as of April 18, 2024.
	2. Supplement comments and commit message.
	3. Change the candidate to apply migrc mechnism:

	   BEFORE - The source folios at demotion and promotion.
	   AFTER  - The souce folios at any type of migration.

	4. Change how migrc mechanism works:

	   BEFORE - Reduce tlb flushes by deferring folio_free() for
	            source folios during demotion and promotion.
	   AFTER  - Reduce tlb flushes by deferring tlb flush until they
	            actually become used, out of pcp or buddy. The
		    current version of migrc does *not* defer calling
	            folio_free() but let it go as it is as the same as
		    vanilla kernel, with the folios marked kind of 'need
		    to tlb flush'. And then handle the flush when the
		    page exits from pcp or buddy so as to prevent
		    changing vm stats e.g. free pages.

Changes from v7:
	1. Rewrite cover letter to explain what 'migrc' mechasism is.
	   (feedbacked by Andrew Morton)
	2. Supplement the commit message of a patch 'mm: Add APIs to
	   free a folio directly to the buddy bypassing pcp'.
	   (feedbacked by Andrew Morton)

Changes from v6:
	1. Fix build errors in case of
	   CONFIG_ARCH_WANT_BATCHED_UNMAP_tlb_FLUSH disabled by moving
	   migrc_flush_{start,end}() calls from arch code to
	   try_to_unmap_flush() in mm/rmap.c.

Changes from v5:
	1. Fix build errors in case of CONFIG_MIGRATION disabled or
	   CONFIG_HWPOISON_INJECT moduled. (feedbacked by kernel test
	   bot and Raymond Jay Golo)
	2. Organize migrc code with two kconfigs, CONFIG_MIGRATION and
	   CONFIG_ARCH_WANT_BATCHED_UNMAP_tlb_FLUSH.

Changes from v4:

	1. Rebase on v6.7.
	2. Fix build errors in arm64 that is doing nothing for tlb flush
	   but has CONFIG_ARCH_WANT_BATCHED_UNMAP_tlb_FLUSH. (reported
	   by kernel test robot)
	3. Don't use any page flag. So the system would give up migrc
	   mechanism more often but it's okay. The final improvement is
	   good enough.
	4. Instead, optimize full tlb flush(arch_tlbbatch_flush()) by
	   avoiding redundant CPUs from tlb flush.

Changes from v3:

	1. Don't use the kconfig, CONFIG_MIGRC, and remove sysctl knob,
	   migrc_enable. (feedbacked by Nadav)
	2. Remove the optimization skipping CPUs that have already
	   performed tlb flushes needed by any reason when performing
	   tlb flushes by migrc because I can't tell the performance
	   difference between w/ the optimization and w/o that.
	   (feedbacked by Nadav)
	3. Minimize arch-specific code. While at it, move all the migrc
           declarations and inline functions from include/linux/mm.h to
           mm/internal.h (feedbacked by Dave Hansen, Nadav)
	4. Separate a part making migrc paused when the system is in
	   high memory pressure to another patch. (feedbacked by Nadav)
	5. Rename:
	      a. arch_tlbbatch_clean() to arch_tlbbatch_clear(),
	      b. tlb_ubc_nowr to tlb_ubc_ro,
	      c. migrc_try_flush_free_folios() to migrc_flush_free_folios(),
	      d. migrc_stop to migrc_pause.
	   (feedbacked by Nadav)
	6. Use ->lru list_head instead of introducing a new llist_head.
	   (feedbacked by Nadav)
	7. Use non-atomic operations of page-flag when it's safe.
	   (feedbacked by Nadav)
	8. Use stack instead of keeping a pointer of 'struct migrc_req'
	   in struct task, which is for manipulating it locally.
	   (feedbacked by Nadav)
	9. Replace a lot of simple functions to inline functions placed
	   in a header, mm/internal.h. (feedbacked by Nadav)
	10. Add additional sufficient comments. (feedbacked by Nadav)
	11. Remove a lot of wrapper functions. (feedbacked by Nadav)

Changes from RFC v2:

	1. Remove additional occupation in struct page. To do that,
	   unioned with lru field for migrc's list and added a page
	   flag. I know page flag is a thing that we don't like to add
	   but no choice because migrc should distinguish folios under
	   migrc's control from others. Instead, I force migrc to be
	   used only on 64 bit system to mitigate you guys from getting
	   angry.
	2. Remove meaningless internal object allocator that I
	   introduced to minimize impact onto the system. However, a ton
	   of tests showed there was no difference.
	3. Stop migrc from working when the system is in high memory
	   pressure like about to perform direct reclaim. At the
	   condition where the swap mechanism is heavily used, I found
	   the system suffered from regression without this control.
	4. Exclude folios that pte_dirty() == true from migrc's interest
	   so that migrc can work simpler.
	5. Combine several patches that work tightly coupled to one.
	6. Add sufficient comments for better review.
	7. Manage migrc's request in per-node manner (from globally).
	8. Add tlb miss improvement in commit message.
	9. Test with more CPUs(4 -> 16) to see bigger improvement.

Changes from RFC:

	1. Fix a bug triggered when a destination folio at the previous
	   migration becomes a source folio at the next migration,
	   before the folio gets handled properly so that the folio can
	   play with another migration. There was inconsistency in the
	   folio's state. Fixed it.
	2. Split the patch set into more pieces so that the folks can
	   review better. (Feedbacked by Nadav Amit)
	3. Fix a wrong usage of barrier e.g. smp_mb__after_atomic().
	   (Feedbacked by Nadav Amit)
	4. Tried to add sufficient comments to explain the patch set
	   better. (Feedbacked by Nadav Amit)

Byungchul Park (8):
  x86/tlb: add APIs manipulating tlb batch's arch data
  arm64: tlbflush: add APIs manipulating tlb batch's arch data
  mm/rmap: recognize read-only tlb entries during batched tlb flush
  x86/tlb, mm/rmap: separate arch_tlbbatch_clear() out of
    arch_tlbbatch_flush()
  mm: separate move/undo parts from migrate_pages_batch()
  mm: buddy: make room for a new variable, mgen, in struct page
  mm: add folio_put_mgen() to deliver migrc's generation number to pcp
    or buddy
  mm: defer tlb flush until the source folios at migration actually get
    used

 arch/arm64/include/asm/tlbflush.h |  18 ++
 arch/x86/include/asm/tlbflush.h   |  18 ++
 arch/x86/mm/tlb.c                 |   2 -
 include/linux/mm.h                |  22 ++
 include/linux/mm_types.h          |  39 ++-
 include/linux/sched.h             |  10 +
 mm/compaction.c                   |  10 +
 mm/internal.h                     |  85 +++++-
 mm/memory.c                       |   8 +
 mm/migrate.c                      | 487 ++++++++++++++++++++++++++----
 mm/page_alloc.c                   | 155 ++++++++--
 mm/page_isolation.c               |   6 +
 mm/page_reporting.c               |  10 +
 mm/rmap.c                         |  40 ++-
 mm/swap.c                         |  20 +-
 15 files changed, 826 insertions(+), 104 deletions(-)


base-commit: f52bcd4a9f6058704a6f6b6b50418f579defd4fe
-- 
2.17.1


