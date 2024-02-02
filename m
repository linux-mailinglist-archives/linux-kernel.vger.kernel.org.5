Return-Path: <linux-kernel+bounces-49411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ACD846A23
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2AA28A24E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2AE17C69;
	Fri,  2 Feb 2024 08:08:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E9C17BD8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861300; cv=none; b=VeRIp/u8GG0Ils4hVP5kKk9Dt4h3TWxSD7ynAElhbnPGmoLgmoKnUEND8U9HJ0Sf2dDW0NFNcTdu57Q5sdfxM/re+kz4PNlE0xKL94YjhCvBcDU5W3jZvSeGHprgYQDX5psjvm6ukCXOAuaNh775bplsAPpGdH0ASvp7Wt1J1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861300; c=relaxed/simple;
	bh=lV8MB0+GPyo997QjUt8OdK/qD7Kl+zkNkvofRyBp7xU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t4kvFncjTbeRidA6OvHuO9scKdfDITkMj7Dsa7vna2S7Tlakp8Q79joSoGODR/P/ElJt+QrCQ1hAyp1Sg6QG7K64UWVoLsigfl/J1d3yah5eEnNXBM7N9RNYWiesfcj2ja0b/FUbIoC8r4QE0i79Sjn0dh7ucYCkIsBFSAP3lNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA384DA7;
	Fri,  2 Feb 2024 00:08:58 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB8DB3F5A1;
	Fri,  2 Feb 2024 00:08:12 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/25] Transparent Contiguous PTEs for User Mappings
Date: Fri,  2 Feb 2024 08:07:31 +0000
Message-Id: <20240202080756.1453939-1-ryan.roberts@arm.com>
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
requirements. The change benefits arm64, but there is some minor refactoring for
x86 and powerpc to enable its integration with core-mm.

It is part of a wider effort to improve performance by allocating and mapping
variable-sized blocks of memory (folios). One aim is for the 4K kernel to
approach the performance of the 16K kernel, but without breaking compatibility
and without the associated increase in memory. Another aim is to benefit the 16K
and 64K kernels by enabling 2M THP, since this is the contpte size for those
kernels. We have good performance data that demonstrates both aims are being met
(see below).

Of course this is only one half of the change. We require the mapped physical
memory to be the correct size and alignment for this to actually be useful (i.e.
64K for 4K pages, or 2M for 16K/64K pages). Fortunately folios are solving this
problem for us. Filesystems that support it (XFS, AFS, EROFS, tmpfs, ...) will
allocate large folios up to the PMD size today, and more filesystems are coming.
And for anonymous memory, "multi-size THP" is now upstream.


Patch Layout
============

In this version, I've split the patches to better show each optimization:

  - 1-2:    mm prep: misc code and docs cleanups
  - 3-8:    mm,arm,arm64,powerpc,x86 prep: Replace pte_next_pfn() with more
            general pte_advance_pfn()
  - 9-18:   arm64 prep: Refactor ptep helpers into new layer
  - 19:     functional contpte implementation
  - 20-25:  various optimizations on top of the contpte implementation


Testing
=======

I've tested this series on both Ampere Altra (bare metal) and Apple M2 (VM):
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

baseline:                  mm-unstable (mTHP switched off)
mTHP:                      + enable 16K, 32K, 64K mTHP sizes "always"
mTHP + contpte:            + this series
mTHP + contpte + exefolio: + patch at [5], which series supports

Kernel Compilation with -j8 (negative is faster):

| kernel                    | real-time | kern-time | user-time |
|---------------------------|-----------|-----------|-----------|
| baseline                  |      0.0% |      0.0% |      0.0% |
| mTHP                      |     -5.0% |    -39.1% |     -0.7% |
| mTHP + contpte            |     -6.0% |    -41.4% |     -1.5% |
| mTHP + contpte + exefolio |     -7.8% |    -43.1% |     -3.4% |

Kernel Compilation with -j80 (negative is faster):

| kernel                    | real-time | kern-time | user-time |
|---------------------------|-----------|-----------|-----------|
| baseline                  |      0.0% |      0.0% |      0.0% |
| mTHP                      |     -5.0% |    -36.6% |     -0.6% |
| mTHP + contpte            |     -6.1% |    -38.2% |     -1.6% |
| mTHP + contpte + exefolio |     -7.4% |    -39.2% |     -3.2% |

Speedometer (positive is faster):

| kernel                    | runs_per_min |
|:--------------------------|--------------|
| baseline                  |         0.0% |
| mTHP                      |         1.5% |
| mTHP + contpte            |         3.2% |
| mTHP + contpte + exefolio |         4.5% |


Micro Benchmarks
~~~~~~~~~~~~~~~~

The following microbenchmarks are intended to demonstrate the performance of
fork() and munmap() do not regress. I'm showing results for order-0 (4K)
mappings, and for order-9 (2M) PTE-mapped THP. Thanks to David for sharing his
benchmarks.

baseline:                  mm-unstable + batch fork [6] and zap [7] series
contpte-basic:             + patches 0-19; functional contpte implementation
contpte-batch:             + patches 20-23; implement new batched APIs
contpte-inline:            + patch 24; __always_inline to help compiler
contpte-fold:              + patch 25; fold contpte mapping when sensible

Primary platform is Ampere Altra bare metal. I'm also showing results for M2 VM
(on top of MacOS) for reference, although experience suggests this might not be
the most reliable for performance numbers of this sort:

| FORK           |         order-0        |         order-9        |
| Ampere Altra   |------------------------|------------------------|
| (pte-map)      |       mean |     stdev |       mean |     stdev |
|----------------|------------|-----------|------------|-----------|
| baseline       |       0.0% |      2.7% |       0.0% |      0.2% |
| contpte-basic  |       6.3% |      1.4% |    1948.7% |      0.2% |
| contpte-batch  |       7.6% |      2.0% |      -1.9% |      0.4% |
| contpte-inline |       3.6% |      1.5% |      -1.0% |      0.2% |
| contpte-fold   |       4.6% |      2.1% |      -1.8% |      0.2% |

| MUNMAP         |         order-0        |         order-9        |
| Ampere Altra   |------------------------|------------------------|
| (pte-map)      |       mean |     stdev |       mean |     stdev |
|----------------|------------|-----------|------------|-----------|
| baseline       |       0.0% |      0.5% |       0.0% |      0.3% |
| contpte-basic  |       1.8% |      0.3% |    1104.8% |      0.1% |
| contpte-batch  |      -0.3% |      0.4% |       2.7% |      0.1% |
| contpte-inline |      -0.1% |      0.6% |       0.9% |      0.1% |
| contpte-fold   |       0.1% |      0.6% |       0.8% |      0.1% |

| FORK           |         order-0        |         order-9        |
| Apple M2 VM    |------------------------|------------------------|
| (pte-map)      |       mean |     stdev |       mean |     stdev |
|----------------|------------|-----------|------------|-----------|
| baseline       |       0.0% |      1.4% |       0.0% |      0.8% |
| contpte-basic  |       6.8% |      1.2% |     469.4% |      1.4% |
| contpte-batch  |      -7.7% |      2.0% |      -8.9% |      0.7% |
| contpte-inline |      -6.0% |      2.1% |      -6.0% |      2.0% |
| contpte-fold   |       5.9% |      1.4% |      -6.4% |      1.4% |

| MUNMAP         |         order-0        |         order-9        |
| Apple M2 VM    |------------------------|------------------------|
| (pte-map)      |       mean |     stdev |       mean |     stdev |
|----------------|------------|-----------|------------|-----------|
| baseline       |       0.0% |      0.6% |       0.0% |      0.4% |
| contpte-basic  |       1.6% |      0.6% |     233.6% |      0.7% |
| contpte-batch  |       1.9% |      0.3% |      -3.9% |      0.4% |
| contpte-inline |       2.2% |      0.8% |      -1.6% |      0.9% |
| contpte-fold   |       1.5% |      0.7% |      -1.7% |      0.7% |

Misc
~~~~

John Hubbard at Nvidia has indicated dramatic 10x performance improvements for
some workloads at [8], when using 64K base page kernel.

---
I'd really like to get this into v6.9; I've spoken with Catalin and he is happy
for this to go via the mm-unstable branch, once suitably acked by arm64 folks.
That makes most sense because the series depends on some changes from David at
[6] and [7], which in turn apply on top of mm-unstable as of a few days ago
(d162e170f118).


Changes since v4 [4]
====================

  - Rebased onto David's generic fork [6] and zap [8] batching work
      - I had an implementation similar to this prior to v4, but ditched it
        because I couldn't make it reliably provide a speedup; David succeeded.
      - roughly speaking, a few functions get renamed compared to v4:
          - pte_batch_remaining() -> pte_batch_hint()
	  - set_wrprotects() -> wrprotect_ptes()
          - clear_ptes() -> [get_and_]clear_full_ptes()
      - Had to convert pte_next_pfn() to pte_advance_pfn()
      - Integration into core-mm is simpler because most has been done by
        David's work
  - Reworked patches to better show the progression from basic implementation to
    the various optimizations.
  - Removed the 'full' flag that I added to set_ptes() and set_wrprotects() in
    v4: I've been able to make up most of the performance in other ways, so this
    keeps the interface simpler.
  - Simplified contpte_set_ptes(nr > 1): Observed that set_ptes(nr > 1) is only
    called for ptes that are initially not present. So updated the spec to
    require that, and no longer need to check if any ptes are initially present
    when applying a contpte mapping.


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
[4] https://lore.kernel.org/lkml/20231218105100.172635-1-ryan.roberts@arm.com/
[5] https://lore.kernel.org/lkml/08c16f7d-f3b3-4f22-9acc-da943f647dc3@arm.com/
[6] https://lore.kernel.org/lkml/20240129124649.189745-1-david@redhat.com/
[7] https://lore.kernel.org/lkml/20240129143221.263763-1-david@redhat.com/
[8] https://lore.kernel.org/linux-mm/c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com/


Thanks,
Ryan

Ryan Roberts (25):
  mm: Clarify the spec for set_ptes()
  mm: thp: Batch-collapse PMD with set_ptes()
  mm: Make pte_next_pfn() a wrapper around pte_advance_pfn()
  arm/mm: Convert pte_next_pfn() to pte_advance_pfn()
  arm64/mm: Convert pte_next_pfn() to pte_advance_pfn()
  powerpc/mm: Convert pte_next_pfn() to pte_advance_pfn()
  x86/mm: Convert pte_next_pfn() to pte_advance_pfn()
  mm: Remove pte_next_pfn() and replace with pte_advance_pfn()
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
  arm64/mm: Implement new wrprotect_ptes() batch API
  arm64/mm: Implement new [get_and_]clear_full_ptes() batch APIs
  mm: Add pte_batch_hint() to reduce scanning in folio_pte_batch()
  arm64/mm: Implement pte_batch_hint()
  arm64/mm: __always_inline to improve fork() perf
  arm64/mm: Automatically fold contpte mappings

 arch/arm/mm/mmu.c                 |   2 +-
 arch/arm64/Kconfig                |   9 +
 arch/arm64/include/asm/pgtable.h  | 404 ++++++++++++++++++++++++++----
 arch/arm64/include/asm/tlbflush.h |  13 +-
 arch/arm64/kernel/efi.c           |   4 +-
 arch/arm64/kernel/mte.c           |   2 +-
 arch/arm64/kvm/guest.c            |   2 +-
 arch/arm64/mm/Makefile            |   1 +
 arch/arm64/mm/contpte.c           | 399 +++++++++++++++++++++++++++++
 arch/arm64/mm/fault.c             |  12 +-
 arch/arm64/mm/fixmap.c            |   4 +-
 arch/arm64/mm/hugetlbpage.c       |  40 +--
 arch/arm64/mm/kasan_init.c        |   6 +-
 arch/arm64/mm/mmu.c               |  16 +-
 arch/arm64/mm/pageattr.c          |   6 +-
 arch/arm64/mm/trans_pgd.c         |   6 +-
 arch/powerpc/mm/pgtable.c         |   2 +-
 arch/x86/include/asm/pgtable.h    |   8 +-
 include/linux/pgtable.h           |  29 ++-
 mm/huge_memory.c                  |  58 +++--
 mm/memory.c                       |  20 +-
 21 files changed, 906 insertions(+), 137 deletions(-)
 create mode 100644 arch/arm64/mm/contpte.c

--
2.25.1


