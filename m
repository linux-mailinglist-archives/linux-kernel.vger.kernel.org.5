Return-Path: <linux-kernel+bounces-3369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DCC816B94
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27A01C22B39
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EE519458;
	Mon, 18 Dec 2023 10:51:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0761F19442
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D387A1FB;
	Mon, 18 Dec 2023 02:52:02 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE40A3F738;
	Mon, 18 Dec 2023 02:51:14 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Yu Zhao <yuzhao@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/16] Transparent Contiguous PTEs for User Mappings
Date: Mon, 18 Dec 2023 10:50:44 +0000
Message-Id: <20231218105100.172635-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This is a series to opportunistically and transparently use contpte mappings
(set the contiguous bit in ptes) for user memory when those mappings meet the
requirements. It is part of a wider effort to improve performance by allocating
and mapping variable-sized blocks of memory (folios). One aim is for the 4K
kernel to approach the performance of the 16K kernel, but without breaking
compatibility and without the associated increase in memory. Another aim is to
benefit the 16K and 64K kernels by enabling 2M THP, since this is the contpte
size for those kernels. We have good performance data that demonstrates both
aims are being met (see below).

Of course this is only one half of the change. We require the mapped physical
memory to be the correct size and alignment for this to actually be useful (i.e.
64K for 4K pages, or 2M for 16K/64K pages). Fortunately folios are solving this
problem for us. Filesystems that support it (XFS, AFS, EROFS, tmpfs, ...) will
allocate large folios up to the PMD size today, and more filesystems are coming.
And the other half of my work, to enable "multi-size THP" (large folios) for
anonymous memory, makes contpte sized folios prevalent for anonymous memory too
[4].

Note that the first 3 patchs are for core-mm and provides the refactoring to
make some crucial optimizations possible - which are then implemented in patches
15 and 16. The remaining patches are arm64-specific.


Testing
=======

I've tested this series together with multi-size THP [4] on both Ampere Altra
(bare metal) and Apple M2 (VM):
  - mm selftests (inc new tests written for multi-size THP); no regressions
  - Speedometer Java script benchmark in Chromium web browser; no issues
  - Kernel compilation; no issues
  - Various tests under high memory pressure with swap enabled; no issues


Performance
===========

High Level Use Cases
~~~~~~~~~~~~~~~~~~~~

First some high level use cases (kernel compilation and speedometer JavaScript
benchmarks). These are running on Ampere Altra (I've seen similar improvements
on Android/Pixel 6).

baseline:                  mm-unstable (inc mTHP but switched off)
mTHP:                      enable 16K, 32K, 64K mTHP sizes "always"
mTHP + contpte:            + this series
mTHP + contpte + exefolio: + poc patch to always read executable memory from
                           file into 64K folio to enable contpte-mapping the
			   text

Kernel Compilation with -j8 (negative is faster):

| kernel                    | real-time | kern-time | user-time |
|---------------------------|-----------|-----------|-----------|
| baseline                  |      0.0% |      0.0% |      0.0% |
| mTHP                      |     -4.6% |    -38.0% |     -0.4% |
| mTHP + contpte            |     -5.4% |    -37.7% |     -1.3% |
| mTHP + contpte + exefolio |     -7.4% |    -39.5% |     -3.5% |

Kernel Compilation with -j80 (negative is faster):

| kernel                    | real-time | kern-time | user-time |
|---------------------------|-----------|-----------|-----------|
| baseline                  |      0.0% |      0.0% |      0.0% |
| mTHP                      |     -4.9% |    -36.1% |     -0.2% |
| mTHP + contpte            |     -5.8% |    -36.0% |     -1.2% |
| mTHP + contpte + exefolio |     -6.8% |    -37.0% |     -3.1% |

Speedometer (positive is faster):

| kernel                    | runs_per_min |
|:--------------------------|--------------|
| baseline                  |         0.0% |
| mTHP                      |         1.5% |
| mTHP + contpte            |         3.7% |
| mTHP + contpte + exefolio |         4.9% |

Micro Benchmarks
~~~~~~~~~~~~~~~~

Additionally for this version, I've done a significant amount of
microbenchmarking (and fixes!) to ensure the performance of fork(),
madvise(DONTNEED) and munmap() do not regress. Thanks to David for sharing his
benchmarks.

baseline:                  mm-unstable (inc mTHP but switched off)
contpte-dis:               + this series with ARM64_CONTPTE disabled at
                           compile-time (to show impact of the core-mm changes)
contpte-ena:               + ARM64_CONTPTE enabled at compile-time (to show
                           impact of arm64-specific changes)

I'm showing the collated results summary here. See individual patch commit logs
for commentary:

| Apple M2 VM   |       fork        |      dontneed     |       munmap      |
| order-0       |-------------------|-------------------|-------------------|
| (pte-map)     |    mean |   stdev |    mean |   stdev |    mean |   stdev |
|---------------|---------|---------|---------|---------|---------|---------|
| baseline      |    0.0% |    1.1% |    0.0% |    7.5% |    0.0% |    3.8% |
| contpte-dis   |   -1.0% |    2.0% |   -9.6% |    3.1% |   -1.9% |    0.2% |
| contpte-ena   |    2.6% |    1.7% |  -10.2% |    1.6% |    1.9% |    0.7% |

| Apple M2 VM   |       fork        |      dontneed     |       munmap      |
| order-9       |-------------------|-------------------|-------------------|
| (pte-map)     |    mean |   stdev |    mean |   stdev |    mean |   stdev |
|---------------|---------|---------|---------|---------|---------|---------|
| baseline      |    0.0% |    1.2% |    0.0% |    7.9% |    0.0% |    6.4% |
| contpte-dis   |   -0.1% |    1.1% |   -4.9% |    8.1% |   -4.7% |    0.8% |
| contpte-ena   |  -25.4% |    1.9% |   -9.9% |    0.9% |   -6.0% |    1.4% |

| Ampere Altra  |       fork        |      dontneed     |       munmap      |
| order-0       |-------------------|-------------------|-------------------|
| (pte-map)     |    mean |   stdev |    mean |   stdev |    mean |   stdev |
|---------------|---------|---------|---------|---------|---------|---------|
| baseline      |    0.0% |    1.0% |    0.0% |    0.1% |    0.0% |    0.9% |
| contpte-dis   |   -0.1% |    1.2% |   -0.2% |    0.1% |   -0.2% |    0.6% |
| contpte-ena   |    1.8% |    0.7% |    1.3% |    0.0% |    2.0% |    0.4% |

| Ampere Altra  |       fork        |      dontneed     |       munmap      |
| order-9       |-------------------|-------------------|-------------------|
| (pte-map)     |    mean |   stdev |    mean |   stdev |    mean |   stdev |
|---------------|---------|---------|---------|---------|---------|---------|
| baseline      |    0.0% |    0.1% |    0.0% |    0.0% |    0.0% |    0.1% |
| contpte-dis   |   -0.1% |    0.1% |   -0.1% |    0.0% |   -3.2% |    0.2% |
| contpte-ena   |   -6.7% |    0.1% |   14.1% |    0.0% |   -0.6% |    0.2% |

Misc
~~~~

John Hubbard at Nvidia has indicated dramatic 10x performance improvements for
some workloads at [5], when using 64K base page kernel.

---
All dependencies listed against v1 are now resolved; This series applies cleanly
against v6.7-rc1 and against mm-unstable as of a few days ago (3ecae30dda24).

Changes since v3 [3]
====================

  - Added v3#1 to batch set_ptes() when splitting a huge pmd to ptes; avoids
    need to fold contpte blocks for perf improvement
  - Separated the clear_ptes() fast path into its own inline function (Alistair)
  - Reworked core-mm changes to copy_present_ptes() and zap_pte_range() to
    remove overhead when memory is all order-0 folios (for arm64 and !arm64)
  - Significant optimization of arm64 backend fork operations (set_ptes_full()
    and set_wrprotects()) to ensure no regression when memory is order-0 folios.
  - fixed local variable declarations to be reverse xmas tree. - Added
    documentation for the new backend APIs (pte_batch_remaining(),
    set_ptes_full(), clear_ptes(), ptep_set_wrprotects())
  - Renamed tlb_get_guaranteed_space() -> tlb_reserve_space() and pass requested
    number of slots. Avoids allocating memory when not needed; perf improvement.


Changes since v2 [2]
====================

  - Removed contpte_ptep_get_and_clear_full() optimisation for exit() (v2#14),
    and replaced with a batch-clearing approach using a new arch helper,
    clear_ptes() (v3#2 and v3#15) (Alistair and Barry)
  - (v2#1 / v3#1)
      - Fixed folio refcounting so that refcount >= mapcount always (DavidH)
      - Reworked batch demarcation to avoid pte_pgprot() (DavidH)
      - Reverted return semantic of copy_present_page() and instead fix it up in
        copy_present_ptes() (Alistair)
      - Removed page_cont_mapped_vaddr() and replaced with simpler logic
        (Alistair)
      - Made batch accounting clearer in copy_pte_range() (Alistair)
  - (v2#12 / v3#13)
      - Renamed contpte_fold() -> contpte_convert() and hoisted setting/
        clearing CONT_PTE bit to higher level (Alistair)


Changes since v1 [1]
====================

  - Export contpte_* symbols so that modules can continue to call inline
    functions (e.g. ptep_get) which may now call the contpte_* functions (thanks
    to JohnH)
  - Use pte_valid() instead of pte_present() where sensible (thanks to Catalin)
  - Factor out (pte_valid() && pte_cont()) into new pte_valid_cont() helper
    (thanks to Catalin)
  - Fixed bug in contpte_ptep_set_access_flags() where TLBIs were missed (thanks
    to Catalin)
  - Added ARM64_CONTPTE expert Kconfig (enabled by default) (thanks to Anshuman)
  - Simplified contpte_ptep_get_and_clear_full()
  - Improved various code comments


[1] https://lore.kernel.org/linux-arm-kernel/20230622144210.2623299-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/20231115163018.1303287-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/linux-arm-kernel/20231204105440.61448-1-ryan.roberts@arm.com/
[4] https://lore.kernel.org/linux-arm-kernel/20231204102027.57185-1-ryan.roberts@arm.com/
[5] https://lore.kernel.org/linux-mm/c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com/


Thanks,
Ryan

Ryan Roberts (16):
  mm: thp: Batch-collapse PMD with set_ptes()
  mm: Batch-copy PTE ranges during fork()
  mm: Batch-clear PTE ranges during zap_pte_range()
  arm64/mm: set_pte(): New layer to manage contig bit
  arm64/mm: set_ptes()/set_pte_at(): New layer to manage contig bit
  arm64/mm: pte_clear(): New layer to manage contig bit
  arm64/mm: ptep_get_and_clear(): New layer to manage contig bit
  arm64/mm: ptep_test_and_clear_young(): New layer to manage contig bit
  arm64/mm: ptep_clear_flush_young(): New layer to manage contig bit
  arm64/mm: ptep_set_wrprotect(): New layer to manage contig bit
  arm64/mm: ptep_set_access_flags(): New layer to manage contig bit
  arm64/mm: ptep_get(): New layer to manage contig bit
  arm64/mm: Split __flush_tlb_range() to elide trailing DSB
  arm64/mm: Wire up PTE_CONT for user mappings
  arm64/mm: Implement new helpers to optimize fork()
  arm64/mm: Implement clear_ptes() to optimize exit, munmap, dontneed

 arch/arm64/Kconfig                |  10 +-
 arch/arm64/include/asm/pgtable.h  | 384 +++++++++++++++++++++---
 arch/arm64/include/asm/tlbflush.h |  13 +-
 arch/arm64/kernel/efi.c           |   4 +-
 arch/arm64/kernel/mte.c           |   2 +-
 arch/arm64/kvm/guest.c            |   2 +-
 arch/arm64/mm/Makefile            |   1 +
 arch/arm64/mm/contpte.c           | 480 ++++++++++++++++++++++++++++++
 arch/arm64/mm/fault.c             |  12 +-
 arch/arm64/mm/fixmap.c            |   4 +-
 arch/arm64/mm/hugetlbpage.c       |  40 +--
 arch/arm64/mm/kasan_init.c        |   6 +-
 arch/arm64/mm/mmu.c               |  16 +-
 arch/arm64/mm/pageattr.c          |   6 +-
 arch/arm64/mm/trans_pgd.c         |   6 +-
 include/asm-generic/tlb.h         |  11 +
 include/linux/pgtable.h           | 123 ++++++++
 mm/huge_memory.c                  |  59 ++--
 mm/memory.c                       | 156 ++++++----
 mm/mmu_gather.c                   |  15 +
 20 files changed, 1182 insertions(+), 168 deletions(-)
 create mode 100644 arch/arm64/mm/contpte.c

--
2.25.1


