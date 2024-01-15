Return-Path: <linux-kernel+bounces-25713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC2582D4EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B80B1F2196F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481656AA2;
	Mon, 15 Jan 2024 08:20:10 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A435C98
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-70-65a4eab4c743
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
Subject: [PATCH v6 0/7] Reduce TLB flushes by 94% by improving folio migration
Date: Mon, 15 Jan 2024 17:19:46 +0900
Message-Id: <20240115081953.2521-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsXC9ZZnoe6WV0tSDWb857SYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovrux4yWhzvPcBk
	Mf/eZzaLzZumMlscnzKV0eL3D6COk7MmszgIenxv7WPx2DnrLrvHgk2lHptXaHks3vOSyWPT
	qk42j02fJrF7vDt3jt3jxIzfLB7zTgZ6vN93lc1j6y87j8ap19g8Pm+S83g3/y1bAH8Ul01K
	ak5mWWqRvl0CV8bL8zuZCy6YVvx+cpS1gbFVs4uRk0NCwESiu2sLM4z96vEqMJtNQF3ixo2f
	YLaIgJnEwdY/7F2MXBzMAh+ZJFZ/72DpYuTgEBbwk1i+OACkhkVAVeLbj1OsIDYv0JxZHT+Y
	IGbKS6zecIAZpFdC4D2bxOxTm6CWSUocXHGDZQIj9wJGhlWMQpl5ZbmJmTkmehmVeZkVesn5
	uZsYgeG9rPZP9A7GTxeCDzEKcDAq8fD++Ls4VYg1say4MvcQowQHs5IIb/WdJalCvCmJlVWp
	RfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGBdn3Wzq/3lO3/u8LE/w
	weaXZ31qRANkTU4fduRusfjAc+zRkpV7Sxmn1jy58O/LtN4TR68u7ony970kz/DsvsWthNsa
	B6JOcHP1p95afWrOZN6CPOs1C3L1fnyLKs/c6LlQhXvDryMGvr+vfO53l0ir6C65+rHpXX2N
	1qf1GZblvanFIU/D3JVYijMSDbWYi4oTAduM0C5rAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAwFSAq39CAMSvwMaCGludGVybmFsIgYKBApOO4Mts+qkZTCJzTo4nK+sBjjz
	sP4GOOiwhwE49a/6Azjl8o4EOMOdyQU407qcBjjerP8FOM+6rQU4uKW+AjjSwKACONe64QE4
	x43AAjif3vMGOLOylQM4x5SVATj7+JwGOMmakwRAEkj3hY4ESLma3QdIoLJ1SLOoKkijvOkC
	SLKqiQZIsvKSB0juzs4HSMiY+wRInslRSO++1QZIo+jwAki1+j5IgZXWBkjzsh5I7p/tBlAQ
	Wgo8ZGVsaXZlci8+YApo6c+5A3DQNXj75MUFgAGFKYoBCQgYEDQY6uOqA4oBCQgGECcY2Nj5
	A4oBCQgUEDYYwYX8B4oBCggDEPECGKv3iASKAQgIExBOGKejUIoBCQgEECUY9vjKBYoBCQgN
	EDQYmoj4AooBCQgYEB8Yq7DAA5ABCKABAKoBFGludm1haWw1LnNraHluaXguY29tsgEGCgSm
	ffyRuAH000fCARAIASIMDfj9o2USBWF2c3ltwgEYCAMiFA173KRlEg1kYXl6ZXJvX3J1bGVz
	wgEbCAQiFw1KV2VgEhBnYXRla2VlcGVyX3J1bGVzwgECCAkagAFiNwb4xjxd+MxzjdvSwkot
	7+UbekBkQPEOn2wwTJSVHR5J2E/cUfDXUIn3yI2bQzD+pKNSnd/5v+1ObvNjBakGkyqvzcsw
	XzbkQEsEeY0YffYH4O1FTtdLH0mP/4HqS8EAO9MV4O6R1uvmG4lfc29FufaOphfnuvOyMCW/
	cgsQvCIEc2hhMSoDcnNhw3hrcVICAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

I'm sorry for the spam-like consecutive posting. I introduced build
errors in v5, in case of CONFIG_MIGRATION disabled or
CONFIG_HWPOISON_INJECT moduled. I'm reposting the fixed version.

--->8---

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

Byungchul Park (7):
  x86/tlb: Add APIs manipulating tlb batch's arch data
  arm64: tlbflush: Add APIs manipulating tlb batch's arch data
  mm/rmap: Recognize read-only TLB entries during batched TLB flush
  mm: Separate move/undo doing on folio list from migrate_pages_batch()
  mm: Add APIs to free a folio directly to the buddy bypassing pcp
  mm: Defer TLB flush by keeping both src and dst folios at migration
  mm: Pause migrc mechanism at high memory pressure

 arch/arm64/include/asm/tlbflush.h |  19 ++
 arch/x86/include/asm/tlbflush.h   |  18 ++
 arch/x86/mm/tlb.c                 |   4 +
 include/linux/mm.h                |  31 +++
 include/linux/mmzone.h            |   7 +
 include/linux/sched.h             |   9 +
 mm/internal.h                     |  74 ++++++
 mm/memory.c                       |   8 +
 mm/migrate.c                      | 411 ++++++++++++++++++++++++++----
 mm/page_alloc.c                   |  34 ++-
 mm/rmap.c                         |  37 ++-
 mm/swap.c                         |   7 +
 12 files changed, 602 insertions(+), 57 deletions(-)


base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.17.1


