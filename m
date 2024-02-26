Return-Path: <linux-kernel+bounces-80444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F5C86687D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258211F220FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71D415AC4;
	Mon, 26 Feb 2024 03:06:36 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD34FDF58
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916796; cv=none; b=S3XRRZePqDJyfYxBqrmKlLyvM4z223Dp1/TOl49c8cggun1fcJu1R5b9poSfYzTnzIOoswHTcMROR94Pq8ZfzWTBMQCfr6BDm737gpHJwwKhDk03PYb1KR88lUbA5+sKEUEtUjjOgK+wQxhFJ20qyMwSmqjZf+te6dAd9M0JBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916796; c=relaxed/simple;
	bh=FbC23IxQvaPYKs3D5Hr55D8OA23RjvqavkSZ1N60AM0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NKjPn6IIbmp8k3YVzdWoNvjfiEvzeXEbncWprV46BzbcctyZmvqogFTISZb402xC1CSIDQ34OhiZB49MBPG1mEhcbcPQDXaT/Up0qupl3ZMnptUEIb5vLprsjFyWrzQ8a+TFVp19jnZXf+ebMKxcBmWHtFeXuAYWBeiHWgQbQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-22-65dc002f9b3e
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
Subject: [RESEND PATCH v8 0/8] Reduce TLB flushes by 94% by improving folio migration
Date: Mon, 26 Feb 2024 12:06:05 +0900
Message-Id: <20240226030613.22366-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsXC9ZZnoa4+w51Ugw17DC3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	5P5ljAWzAyoOXp/N1sA4waaLkZNDQsBEYuaDfnYY+8/E+ywgNpuAusSNGz+ZQWwRATOJg61/
	wGqYBe4ySRzoZwOxhQVCJdo+ngGrYRFQldh/bjpYnFfAVGLLqZXMEDPlJVZvOABkcwHZt9kk
	vp85wwiRkJQ4uOIGywRG7gWMDKsYhTLzynITM3NM9DIq8zIr9JLzczcxAkN5We2f6B2Mny4E
	H2IU4GBU4uFd8OF2qhBrYllxZe4hRgkOZiUR3nCZm6lCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
	eY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGENP9NUxNb52EGO3t3E54Hc2huEaQ9TP9J7F/mf0
	wpp/r9x79/XcB+ySTsvYtghZ5ubsXyWt1tRVPrni4WMZloV/qnalHte9EtGZF/3PRHbxbztD
	4QNbI7V3WRzs/XK19Ebl0TqOgAVHZjbKTwmIz7szs/uMtfeZJ+ldDn83CDs8uG5g+5jXSIml
	OCPRUIu5qDgRACCaBBJhAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsXC5WfdrKvPcCfV4OIBFYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZUzuX8ZYMDug4uD12WwNjBNsuhg5OSQETCT+TLzPAmKzCahL3LjxkxnEFhEw
	kzjY+ocdxGYWuMskcaCfDcQWFgiVaPt4BqyGRUBVYv+56WBxXgFTiS2nVjJDzJSXWL3hAPME
	Ro4FjAyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAgNzWe2fiTsYv1x2P8QowMGoxMO74MPt
	VCHWxLLiytxDjBIczEoivOEyN1OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ83qFpyYICaQnlqRm
	p6YWpBbBZJk4OKUaGKNd2k3P3Zks+MVp2mLTz06rv5Snz6j4N/H3xdeKIaJfl4scflh8b+W1
	pdLPOjZNepm67s66x3piplwReiEvdSLdhL8dWlevlXj+8768365zJG1mnlho4/4lLOKFVF7m
	tmuCTS6SW08fDWKafFboS2bvjIv85ZNkmVuFVSy+tilE/LRSO2+us1SJpTgj0VCLuag4EQBe
	jiPtSAIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi everyone,

While I'm working with a tiered memory system e.g. CXL memory, I have
been facing migration overhead esp. TLB shootdown on promotion or
demotion between different tiers. Yeah.. most TLB shootdowns on
migration through hinting fault can be avoided thanks to Huang Ying's
work, commit 4d4b6d66db ("mm,unmap: avoid flushing TLB in batch if PTE
is inaccessible"). See the following link:

https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/

However, it's only for ones using hinting fault. I thought it'd be much
better if we have a general mechanism to reduce the number of TLB
flushes and TLB misses, that we can ultimately apply to any type of
migration, I tried it only for tiering for now tho.

I'm suggesting a mechanism called MIGRC that stands for 'Migration Read
Copy', to reduce TLB flushes by keeping source and destination of folios
participated in the migrations until all TLB flushes required are done,
only if those folios are not mapped with write permission PTE entries.

To achieve that:

   1. For the folios that map only to non-writable TLB entries, prevent
      TLB flush at migration by keeping both source and destination
      folios, which will be handled later at a better time.

   2. When any non-writable TLB entry changes to writable e.g. through
      fault handler, give up migrc mechanism so as to perform TLB flush
      required right away.

I observed a big improvement of TLB flushes # and TLB misses # at the
following evaluation using XSBench like:

   1. itlb flush was reduced by 93.9%.
   2. dtlb thread was reduced by 43.5%.
   3. stlb flush was reduced by 24.9%.
   4. dtlb store misses was reduced by 34.2%.
   5. itlb load misses was reduced by 45.5%.
   6. The runtime was reduced by 3.5%.

I believe that it would help more with any real cases.

---

The measurement result:

   Architecture - x86_64
   QEMU - kvm enabled, host cpu
   Numa - 2 nodes (16 CPUs 1GB, no CPUs 8GB)
   Linux Kernel - v6.7, numa balancing tiering on, demotion enabled
   Benchmark - XSBench -p 100000000 (-p option makes the runtime longer)

   run 'perf stat' using events:
      1) itlb.itlb_flush
      2) tlb_flush.dtlb_thread
      3) tlb_flush.stlb_any
      4) dTLB-load-misses
      5) dTLB-store-misses
      6) iTLB-load-misses

   run 'cat /proc/vmstat' and pick:
      1) numa_pages_migrated
      2) pgmigrate_success
      3) nr_tlb_remote_flush
      4) nr_tlb_remote_flush_received
      5) nr_tlb_local_flush_all
      6) nr_tlb_local_flush_one

   BEFORE - mainline v6.7
   ----------------------
   $ perf stat -a \
	   -e itlb.itlb_flush \
	   -e tlb_flush.dtlb_thread \
	   -e tlb_flush.stlb_any \
	   -e dTLB-load-misses \
	   -e dTLB-store-misses \
	   -e iTLB-load-misses \
	   ./XSBench -p 100000000

   Performance counter stats for 'system wide':

      85647229          itlb.itlb_flush
      480981504         tlb_flush.dtlb_thread
      323937200         tlb_flush.stlb_any
      238381632579      dTLB-load-misses
      601514255         dTLB-store-misses
      2974157461        iTLB-load-misses

   2252.883892112 seconds time elapsed

   $ cat /proc/vmstat

   ...
   numa_pages_migrated 12790664
   pgmigrate_success 26835314
   nr_tlb_remote_flush 3031412
   nr_tlb_remote_flush_received 45234862
   nr_tlb_local_flush_all 216584
   nr_tlb_local_flush_one 740940
   ...

   AFTER - mainline v6.7 + migrc
   -----------------------------
   $ perf stat -a \
	   -e itlb.itlb_flush \
	   -e tlb_flush.dtlb_thread \
	   -e tlb_flush.stlb_any \
	   -e dTLB-load-misses \
	   -e dTLB-store-misses \
	   -e iTLB-load-misses \
	   ./XSBench -p 100000000

   Performance counter stats for 'system wide':

      5240261           itlb.itlb_flush
      271581774         tlb_flush.dtlb_thread
      243149389         tlb_flush.stlb_any
      234502983364      dTLB-load-misses
      395673680         dTLB-store-misses
      1620215163        iTLB-load-misses

   2172.283436287 seconds time elapsed

   $ cat /proc/vmstat

   ...
   numa_pages_migrated 14897064
   pgmigrate_success 30825530
   nr_tlb_remote_flush 198290
   nr_tlb_remote_flush_received 2820156
   nr_tlb_local_flush_all 92048
   nr_tlb_local_flush_one 741401
   ...

---

Changes from v7:
	1. Rewrite cover letter to explain what 'migrc' mechasism is.
	   (feedbacked by Andrew Morton)
	2. Supplement the commit message of a patch 'mm: Add APIs to
	   free a folio directly to the buddy bypassing pcp'.
	   (feedbacked by Andrew Morton)

Changes from v6:
	1. Fix build errors in case of
	   CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH disabled by moving
	   migrc_flush_{start,end}() calls from arch code to
	   try_to_unmap_flush() in mm/rmap.c.

Changes from v5:
	1. Fix build errors in case of CONFIG_MIGRATION disabled or
	   CONFIG_HWPOISON_INJECT moduled. (feedbacked by kernel test
	   bot and Raymond Jay Golo)
	2. Organize migrc code with two kconfigs, CONFIG_MIGRATION and
	   CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH.

Changes from v4:

	1. Rebase on v6.7.
	2. Fix build errors in arm64 that is doing nothing for TLB flush
	   but has CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH. (reported
	   by kernel test robot)
	3. Don't use any page flag. So the system would give up migrc
	   mechanism more often but it's okay. The final improvement is
	   good enough.
	4. Instead, optimize full TLB flush(arch_tlbbatch_flush()) by
	   avoiding redundant CPUs from TLB flush.

Changes from v3:

	1. Don't use the kconfig, CONFIG_MIGRC, and remove sysctl knob,
	   migrc_enable. (feedbacked by Nadav)
	2. Remove the optimization skipping CPUs that have already
	   performed TLB flushes needed by any reason when performing
	   TLB flushes by migrc because I can't tell the performance
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
	8. Add TLB miss improvement in commit message.
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
  x86/tlb: Add APIs manipulating tlb batch's arch data
  arm64: tlbflush: Add APIs manipulating tlb batch's arch data
  mm/rmap: Recognize read-only TLB entries during batched TLB flush
  x86/tlb, mm/rmap: Separate arch_tlbbatch_clear() out of
    arch_tlbbatch_flush()
  mm: Separate move/undo doing on folio list from migrate_pages_batch()
  mm: Add APIs to free a folio directly to the buddy bypassing pcp
  mm: Defer TLB flush by keeping both src and dst folios at migration
  mm: Pause migrc mechanism at high memory pressure

 arch/arm64/include/asm/tlbflush.h |  19 ++
 arch/x86/include/asm/tlbflush.h   |  18 ++
 arch/x86/mm/tlb.c                 |   2 -
 include/linux/mm.h                |  23 ++
 include/linux/mmzone.h            |   7 +
 include/linux/sched.h             |   9 +
 mm/internal.h                     |  78 ++++++
 mm/memory.c                       |   8 +
 mm/migrate.c                      | 411 ++++++++++++++++++++++++++----
 mm/page_alloc.c                   |  34 ++-
 mm/rmap.c                         |  40 ++-
 mm/swap.c                         |   7 +
 12 files changed, 597 insertions(+), 59 deletions(-)


base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.17.1


