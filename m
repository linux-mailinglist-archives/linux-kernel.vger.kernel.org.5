Return-Path: <linux-kernel+bounces-57514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3601684DA0D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53E51F227ED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5419A67E85;
	Thu,  8 Feb 2024 06:26:27 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5C767C40
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 06:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373586; cv=none; b=OXJ2G9IWi619Y0ctJtpUE+tpYo59qWyKmAxuE8vTG6iKKuWRZ2fN2Ginw+ppTVeDPH3tKcL0BYOaYYhPq66KGNi5OhRdJp7AyChxXCP15uXBFKeIr6RJR5x9OBk8c7/s3sPZYtmuslEj6qqOPPCXrGj0SyFWcutRpnTf4HTHdHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373586; c=relaxed/simple;
	bh=u2hBZ778Q7giCgxWegRKHfR++hY1eVL41r3d04Lf4EI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=i/eNCaWxdt1l6FH7bNbD0LrUaYwmlwZUD60vWUvxCbZtq1EXP8uXWARyAj2Q2e3XyUr1D8/Ff0sFp5i+TTI9UP0M8NtZ/bHSyW+Zi9rSeuVPuTchKjZ+xtrJBOnk2ZMZePZr0zpqLXG1crnd5D4PIZoDt9bh4Md7AIau2O+1uDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-6f-65c4740a77c5
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
Subject: [RESEND PATCH v7 0/8] Reduce TLB flushes by 94% by improving folio migration
Date: Thu,  8 Feb 2024 15:26:00 +0900
Message-Id: <20240208062608.44351-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsXC9ZZnkS53yZFUg7n3mCzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeL6roeMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6jj5KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfPY+svOo3HqNTaPz5vkPN7Nf8sWwB/FZZOS
	mpNZllqkb5fAlXFuxVbWgnVmFdsnT2ZuYDyj2cXIySEhYCJx9+UcZhj7xvGD7CA2m4C6xI0b
	P8HiIgJmEgdb/wDFuTiYBT4ySaz+3sECkhAWCJVYNmE6mM0ioCqx8eA1JhCbV8BU4s4miBoJ
	AXmJ1RsOMIM0Swi8ZpO43tHPCpGQlDi44gbLBEbuBYwMqxiFMvPKchMzc0z0MirzMiv0kvNz
	NzECA3xZ7Z/oHYyfLgQfYhTgYFTi4T1RfjhViDWxrLgy9xCjBAezkgiv2Y4DqUK8KYmVValF
	+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYW+827a2/oWQfeoDpinLQ
	pKrWB+f/ZH2O7tNf5sXcE2pV4XQ4Tk3F4l/xglc/WudYT57vzaxeqmClw/ZHyXayOJOK1DSP
	vzYOhYzLX27z93ph1y3VvbVFdanRXUc/g2Tem4zhxzbnW7M4iv57H72tPDr1zcI9ob2urpUf
	vr+Niizb9HLKjklKLMUZiYZazEXFiQCY6KQbbAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsXC5WfdrMtVciTVYOIMY4s569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUMfJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH4xQcmj62/7Dwap15j8/i8Sc7j
	3fy3bAECUVw2Kak5mWWpRfp2CVwZ51ZsZS1YZ1axffJk5gbGM5pdjJwcEgImEjeOH2QHsdkE
	1CVu3PjJDGKLCJhJHGz9AxTn4mAW+Mgksfp7BwtIQlggVGLZhOlgNouAqsTGg9eYQGxeAVOJ
	O5sgaiQE5CVWbzjAPIGRYwEjwypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzAcF1W+2fiDsYv
	l90PMQpwMCrx8J4oP5wqxJpYVlyZe4hRgoNZSYTXbMeBVCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQZGsaCclS8WcKWWp7s1/bM7q7TC+9H36ecPHZ/4
	Zh6vYu9NwZ5fXK+vPebbEXz8qZm7bXYi+2IR5uzdR6akxEdtKm5eKrns6/yrzue1b1dsNr0a
	N/Hczc7tB7898Z33+OTT1SlvfBgeS2mdt1g7UzCdeddC6dnnbBZ5mSczd4R78ncFsrZc3tf3
	TYmlOCPRUIu5qDgRAAbKCE1TAgAA
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


