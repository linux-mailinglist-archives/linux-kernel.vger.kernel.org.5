Return-Path: <linux-kernel+bounces-23085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E824782A781
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786781F237F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E651A568D;
	Thu, 11 Jan 2024 06:23:21 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E0D5663
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-da-659f85c789e9
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
	xhao@linux.alibaba.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Subject: [v5 0/7] Reduce TLB flushes by 94% by improving folio migration
Date: Thu, 11 Jan 2024 15:07:50 +0900
Message-Id: <20240111060757.13563-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC9ZZnoe6J1vmpBg8WslrMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	2LxpKrPF7x9AdXOmWFmcnDWZxUHA43trH4vHgk2lHptXaHks3vOSyWPTqk42j02fJrF7vDt3
	jt3jxIzfLB47H1p6zDsZ6PF+31U2j62/7Dw+b5LzeDf/LVsAXxSXTUpqTmZZapG+XQJXxqyr
	FQWrDCs6zx9ka2Dcr9rFyMEhIWAicX1SchcjJ5i5enUnK4jNJqAucePGT2YQW0TATOJg6x/2
	LkYuDmaBB0wSc9+uYARJCAt4SLzpbWMHsVkEVCVaLzwFi/MKmEp8eH6ICWKovMTqDQeYQZol
	BG6zSXRPnccCkZCUOLjiBssERu4FjAyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQKDeFntn+gd
	jJ8uBB9iFOBgVOLhfbBoXqoQa2JZcWXuIUYJDmYlEV6Fz3NShXhTEiurUovy44tKc1KLDzFK
	c7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTCmc/9U/y/Oyjk3qun+6bSZH8Sercn7x2cv
	KcvAySuW1b367/Ibd45x5mjYsPNIV1/zuzn9Mcu5urYbTZPzlubcUt12yq/YLX7v/LlOYuVJ
	NqHT3qT9+V73+8fx9wsOdsVYPV98t6Oie8/T3ylb1Z+3b+ZXOmQSMt3EYWNdpOaPq1emb6lz
	mPJEiaU4I9FQi7moOBEAcRM/6V4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsXC5WfdrHu8dX6qwYKfJhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGSxedNUZovfP4Dq5kyxsjg5azKLg6DH99Y+Fo8Fm0o9Nq/Q8li85yWTx6ZVnWwemz5N
	Yvd4d+4cu8eJGb9ZPHY+tPSYdzLQ4/2+q2wei198YPLY+svO4/MmOY9389+yBfBHcdmkpOZk
	lqUW6dslcGXMulpRsMqwovP8QbYGxv2qXYycHBICJhKrV3eygthsAuoSN278ZAaxRQTMJA62
	/mHvYuTiYBZ4wCQx9+0KRpCEsICHxJveNnYQm0VAVaL1wlOwOK+AqcSH54eYIIbKS6zecIB5
	AiPHAkaGVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIFBuaz2z8QdjF8uux9iFOBgVOLhNXg5
	L1WINbGsuDL3EKMEB7OSCK/C5zmpQrwpiZVVqUX58UWlOanFhxilOViUxHm9wlMThATSE0tS
	s1NTC1KLYLJMHJxSDYzz1dzPaOVFFv22i5E8Kv7eVzxRl98hWSXbXWLTralz3lYeEluzikV+
	Z4LNBpGSv5Yntz36/zTBjePJutN3V09JUZ79ri7RN+ZMt/zdRWVHV9zyj7qonxHyefEEHS+b
	+pQVgT4eG8pjEk5ErJjZvyhUdNar/JQjqu9CEl71RO6W+dlnwX3zkpsSS3FGoqEWc1FxIgD7
	AFVfRgIAAA==
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
 arch/x86/mm/tlb.c                 |   7 +
 include/linux/mm.h                |  23 ++
 include/linux/mmzone.h            |   5 +
 include/linux/sched.h             |   7 +
 mm/internal.h                     |  84 +++++++
 mm/memory.c                       |   8 +
 mm/migrate.c                      | 381 +++++++++++++++++++++++++-----
 mm/page_alloc.c                   |  34 ++-
 mm/rmap.c                         |  37 ++-
 mm/swap.c                         |   7 +
 12 files changed, 574 insertions(+), 56 deletions(-)

-- 
2.17.1


