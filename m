Return-Path: <linux-kernel+bounces-32246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C6C83590D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BC21F22B76
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C14E17FF;
	Mon, 22 Jan 2024 01:01:05 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60C136B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705885264; cv=none; b=peGguu97AvGYO2XNXAlujtEFtKL5wE3Xwxn4/fPlVyFRmdCN+ubvMqR6JFg1QA82wvyUxldc5smYrzH8GWVX4xmAtBstJF22n/5h5M6XVaL3A9xUiqvH9G1hGX2k6nuVSeeJ/+mCidEudIpGkz/AuchGI9tkcAKQcYsNsWzm9yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705885264; c=relaxed/simple;
	bh=u2hBZ778Q7giCgxWegRKHfR++hY1eVL41r3d04Lf4EI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FAXiOJCSW9yCuu0mfSXqMfK5iNvX33+mOg8zN+fraaohmSvcEUBrL62QNsc17IHuvD00vHeKSDJ2m7Eqn1e40NgvyxfipnnqPZXAgYvRo58+LyKlt/cTATrMgxuC1iMEkFZUynk10VH9mZ+1r41IoC1KHixbaXkuW/gw+Tx3IxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-6a-65adbe4384b8
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
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
Subject: [PATCH v7 0/8] Reduce TLB flushes by 94% by improving folio migration
Date: Mon, 22 Jan 2024 10:00:32 +0900
Message-Id: <20240122010040.74346-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsXC9ZZnka7zvrWpBoc/SljMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK+Pciq2sBevMKrZPnszcwHhGs4uRk0NCwETi+IfvjDD2osvf2EBsNgF1iRs3
	fjKD2CICZhIHW/+wdzFycTALfGSSWP29gwUkISzgJzGp7ShYEYuAqsTUffvABvEKmEpMOHeJ
	DWKovMTqDQeYQZolBF6zSXz+coQVIiEpcXDFDZYJjNwLGBlWMQpl5pXlJmbmmOhlVOZlVugl
	5+duYgQG+LLaP9E7GD9dCD7EKMDBqMTD68C+NlWINbGsuDL3EKMEB7OSCC+/6qpUId6UxMqq
	1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYxFZgfmM65d/ZiJ488d
	3+WHH+74daNy7dpNniKhvK9XL3r2/HzQ1UcMP0o6GZe8vXLEasF9cTML7ssFkYKzqvJ3ND4z
	nlZcaOy/qqX+1+8/O8Q83zZ0H51t+yo4snidi9iH5myDHRcTgrqnb7B7sOP01t8Tyl1POOSe
	sn5WPv+icsvby0/+7r6cpsRSnJFoqMVcVJwIAB4qdWVsAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsXC5WfdrOu8b22qwcRuHos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUMfJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH4xQcmj62/7Dwap15j8/i8Sc7j
	3fy3bAECUVw2Kak5mWWpRfp2CVwZ51ZsZS1YZ1axffJk5gbGM5pdjJwcEgImEosuf2MDsdkE
	1CVu3PjJDGKLCJhJHGz9w97FyMXBLPCRSWL19w4WkISwgJ/EpLajYEUsAqoSU/ftYwSxeQVM
	JSacu8QGMVReYvWGA8wTGDkWMDKsYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAzXZbV/Ju5g
	/HLZ/RCjAAejEg+vA/vaVCHWxLLiytxDjBIczEoivPyqq1KFeFMSK6tSi/Lji0pzUosPMUpz
	sCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGAM9939SVChW1l8qVx+1VpHzyE7rsr73G5KW
	JZ+6vuru6YSpBeILzJukN24UKfum3WMr7rjn+ansy5d+z7PS7df+lGBj+naf8qs8vdzsiucx
	33gEWbPYYnyXNMufmNaqYXKt+03H+7SwxcYfGh++2mAktK80kP1N1ILbG9+7Tf6/uin19Iqa
	I0osxRmJhlrMRcWJAJs9vr5TAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi everyone,

While I'm working with CXL memory, I have been facing migration overhead
esp. TLB shootdown on promotion or demotion between different tiers.
Yeah.. most TLB shootdowns on migration through hinting fault can be
avoided thanks to Huang Ying's work, commit 4d4b6d66db ("mm,unmap: avoid
flushing TLB in batch if PTE is inaccessible"). See the following link:

https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/

However, it's only for ones using hinting fault. I thought it'd be much
better if we have a general mechanism to reduce the number of TLB
flushes and TLB misses, that we can apply to any type of migration. I
tried it only for tiering migration for now tho.

I'm suggesting a mechanism to reduce TLB flushes by keeping source and
destination of folios participated in the migrations until all TLB
flushes required are done, only if those folios are not mapped with
write permission PTE entries at all. I worked Based on v6.7.

I saw the number of iTLB full flush was reduced by 94%, iTLB miss was
reduced by 45.5% and the total runtime was reduced by 3.5% with the
workload I tested with, XSBench. However, I believe that it would help
more with other ones or any real ones. It'd be appreciated to let me
know if I'm missing something.

	Byungchul

---

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


