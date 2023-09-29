Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FD17B3197
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjI2Loh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Log (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:44:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B23EEE7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:44:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE1401FB;
        Fri, 29 Sep 2023 04:45:11 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9E693F59C;
        Fri, 29 Sep 2023 04:44:30 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Date:   Fri, 29 Sep 2023 12:44:11 +0100
Message-Id: <20230929114421.3761121-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is v6 of a series to implement variable order, large folios for anonymous
memory. (previously called "ANON_LARGE_FOLIO", "LARGE_ANON_FOLIO",
"FLEXIBLE_THP", but now exposed as an extension to THP; "small-order THP"). The
objective of this is to improve performance by allocating larger chunks of
memory during anonymous page faults:

1) Since SW (the kernel) is dealing with larger chunks of memory than base
   pages, there are efficiency savings to be had; fewer page faults, batched PTE
   and RMAP manipulation, reduced lru list, etc. In short, we reduce kernel
   overhead. This should benefit all architectures.
2) Since we are now mapping physically contiguous chunks of memory, we can take
   advantage of HW TLB compression techniques. A reduction in TLB pressure
   speeds up kernel and user space. arm64 systems have 2 mechanisms to coalesce
   TLB entries; "the contiguous bit" (architectural) and HPA (uarch).

The major change in this revision is the addition of sysfs controls to allow
this "small-order THP" to be enabled/disabled/configured independently of
PMD-order THP. The approach I've taken differs a bit from previous discussions;
instead of creating a whole new interface ("large_folio"), I'm extending THP. I
personally think this makes things clearer and more extensible. See [6] for
detailed rationale.

Because we now have runtime enable/disable control, I've removed the compile
time Kconfig switch. It still defaults to runtime-disabled.

NOTE: These changes should not be merged until the prerequisites are complete.
These are in progress and tracked at [7].

This series is based on mm-hotfixes-unstable (f9911db48293).


Testing
=======

This version adds patches to mm selftests so that the cow tests explicitly test
small-order THP, in the same way that PMD-order THP is tested. The new tests all
pass, and no regressions are observed in the mm selftest suite.


Performance
===========

The below tables show performance and memory data for selected workloads, with
different small-order THPs enabled. All configs are compared to a 4k page kernel
with small-order THP disabled. 16k and 64k (with small-order THP disabled)
kernels are included to aid the comparison. All kernels built from the same
source; mm-hotfixes-unstable (f9911db48293) + this series.

4k-page-16k-folio: 16k (order-2) THP enabled
4k-page-32k-folio: 32k+16k (order-3, order-2) THP enabled
4k-page-64k-folio: 64k+32k+16k (order-4, order-3, order-2) THP enabled

Running on Ampere Altra with 1 NUMA node enabled, Ubuntu 22.04, XFS filesystem
20 repeats across 5 reboots (with 1 warmup run after each reboot)
Run in its own cgroup and read memory.peak after completion


Kernel Compilation with 8 jobs: (make defconfig && make -s -j8 Image)
(smaller is better):

| kernel            |   real-time |   kern-time |   user-time | memory |
|:------------------|------------:|------------:|------------:|-------:|
| baseline-4k-page  |        0.0% |        0.0% |        0.0% |   0.0% |
| 16k-page          |       -9.0% |      -49.7% |       -4.0% |   6.2% |
| 64k-page          |      -11.9% |      -66.5% |       -5.0% |  28.3% |
| 4k-page-16k-folio |       -2.8% |      -23.0% |       -0.3% |   0.0% |
| 4k-page-32k-folio |       -4.0% |      -32.0% |       -0.6% |   0.1% |
| 4k-page-64k-folio |       -4.6% |      -37.9% |       -0.5% |   0.1% |


Kernel Compilation with 80 jobs: (make defconfig && make -s -j80 Image)
(smaller is better):

| kernel            |   real-time |   kern-time |   user-time | memory |
|:------------------|------------:|------------:|------------:|:-------|
| baseline-4k-page  |        0.0% |        0.0% |        0.0% |   0.0% |
| 16k-page          |       -9.2% |      -52.1% |       -3.6% |   4.6% |
| 64k-page          |      -11.4% |      -66.4% |       -3.0% |  12.6% |
| 4k-page-16k-folio |       -3.2% |      -22.8% |       -0.3% |   2.7% |
| 4k-page-32k-folio |       -4.8% |      -37.1% |       -0.5% |   2.9% |
| 4k-page-64k-folio |       -5.0% |      -42.1% |       -0.3% |   3.4% |


Speedometer 2.0: Running on Chromium automated with Selenium
(bigger is better for runs_per_min, smaller is better for memory):

| kernel            |   runs_per_min | memory |
|:------------------|---------------:|-------:|
| baseline-4k-page  |           0.0% |   0.0% |
| 16k-page          |           5.9% |  10.6% |
| 4k-page-16k-folio |           1.0% |  -0.6% |
| 4k-page-32k-folio |           1.3% |   3.5% |
| 4k-page-64k-folio |           1.3% |   6.4% |


Changes since v5 [5]
====================

  - Added accounting for PTE-mapped THPs (patch 3)
  - Added runtime control mechanism via sysfs as extension to THP (patch 4)
  - Minor refactoring of alloc_anon_folio() to integrate with runtime controls
  - Stripped out hardcoded policy for allocation order; its now all user space
    controlled (although user space can request "recommend" which will configure
    the HW-preferred order)


Changes since v4 [4]
====================

  - Removed "arm64: mm: Override arch_wants_pte_order()" patch; arm64
    now uses the default order-3 size. I have moved this patch over to
    the contpte series.
  - Added "mm: Allow deferred splitting of arbitrary large anon folios" back
    into series. I originally removed this at v2 to add to a separate series,
    but that series has transformed significantly and it no longer fits, so
    bringing it back here.
  - Reintroduced dependency on set_ptes(); Originally dropped this at v2, but
    set_ptes() is in mm-unstable now.
  - Updated policy for when to allocate LAF; only fallback to order-0 if
    MADV_NOHUGEPAGE is present or if THP disabled via prctl; no longer rely on
    sysfs's never/madvise/always knob.
  - Fallback to order-0 whenever uffd is armed for the vma, not just when
    uffd-wp is set on the pte.
  - alloc_anon_folio() now returns `struct folio *`, where errors are encoded
    with ERR_PTR().

  The last 3 changes were proposed by Yu Zhao - thanks!


Changes since v3 [3]
====================

  - Renamed feature from FLEXIBLE_THP to LARGE_ANON_FOLIO.
  - Removed `flexthp_unhinted_max` boot parameter. Discussion concluded that a
    sysctl is preferable but we will wait until real workload needs it.
  - Fixed uninitialized `addr` on read fault path in do_anonymous_page().
  - Added mm selftests for large anon folios in cow test suite.


Changes since v2 [2]
====================

  - Dropped commit "Allow deferred splitting of arbitrary large anon folios"
      - Huang, Ying suggested the "batch zap" work (which I dropped from this
        series after v1) is a prerequisite for merging FLXEIBLE_THP, so I've
        moved the deferred split patch to a separate series along with the batch
        zap changes. I plan to submit this series early next week.
  - Changed folio order fallback policy
      - We no longer iterate from preferred to 0 looking for acceptable policy
      - Instead we iterate through preferred, PAGE_ALLOC_COSTLY_ORDER and 0 only
  - Removed vma parameter from arch_wants_pte_order()
  - Added command line parameter `flexthp_unhinted_max`
      - clamps preferred order when vma hasn't explicitly opted-in to THP
  - Never allocate large folio for MADV_NOHUGEPAGE vma (or when THP is disabled
    for process or system).
  - Simplified implementation and integration with do_anonymous_page()
  - Removed dependency on set_ptes()


Changes since v1 [1]
====================

  - removed changes to arch-dependent vma_alloc_zeroed_movable_folio()
  - replaced with arch-independent alloc_anon_folio()
      - follows THP allocation approach
  - no longer retry with intermediate orders if allocation fails
      - fallback directly to order-0
  - remove folio_add_new_anon_rmap_range() patch
      - instead add its new functionality to folio_add_new_anon_rmap()
  - remove batch-zap pte mappings optimization patch
      - remove enabler folio_remove_rmap_range() patch too
      - These offer real perf improvement so will submit separately
  - simplify Kconfig
      - single FLEXIBLE_THP option, which is independent of arch
      - depends on TRANSPARENT_HUGEPAGE
      - when enabled default to max anon folio size of 64K unless arch
        explicitly overrides
  - simplify changes to do_anonymous_page():
      - no more retry loop


[1] https://lore.kernel.org/linux-mm/20230626171430.3167004-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20230703135330.1865927-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/linux-mm/20230714160407.4142030-1-ryan.roberts@arm.com/
[4] https://lore.kernel.org/linux-mm/20230726095146.2826796-1-ryan.roberts@arm.com/
[5] https://lore.kernel.org/linux-mm/20230810142942.3169679-1-ryan.roberts@arm.com/
[6] https://lore.kernel.org/linux-mm/1b03f4d6-634d-4786-81a0-5a104799b125@arm.com/
[7] https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/


Thanks,
Ryan


Ryan Roberts (9):
  mm: Allow deferred splitting of arbitrary anon large folios
  mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
  mm: thp: Account pte-mapped anonymous THP usage
  mm: thp: Introduce anon_orders and anon_always_mask sysfs files
  mm: thp: Extend THP to allocate anonymous large folios
  mm: thp: Add "recommend" option for anon_orders
  arm64/mm: Override arch_wants_pte_order()
  selftests/mm/cow: Generalize do_run_with_thp() helper
  selftests/mm/cow: Add tests for small-order anon THP

 Documentation/ABI/testing/procfs-smaps_rollup |   1 +
 .../admin-guide/cgroup-v1/memory.rst          |   5 +-
 Documentation/admin-guide/cgroup-v2.rst       |   6 +-
 Documentation/admin-guide/mm/transhuge.rst    |  96 ++++++-
 Documentation/filesystems/proc.rst            |  20 +-
 arch/arm64/include/asm/pgtable.h              |  10 +
 drivers/base/node.c                           |   2 +
 fs/proc/meminfo.c                             |   2 +
 fs/proc/task_mmu.c                            |   7 +-
 include/linux/huge_mm.h                       |  95 +++++--
 include/linux/mmzone.h                        |   1 +
 include/linux/pgtable.h                       |  13 +
 mm/huge_memory.c                              | 172 ++++++++++--
 mm/khugepaged.c                               |  18 +-
 mm/memcontrol.c                               |   8 +
 mm/memory.c                                   | 114 +++++++-
 mm/page_vma_mapped.c                          |   3 +-
 mm/rmap.c                                     |  42 ++-
 mm/show_mem.c                                 |   2 +
 mm/vmstat.c                                   |   1 +
 tools/testing/selftests/mm/cow.c              | 244 +++++++++++++-----
 21 files changed, 696 insertions(+), 166 deletions(-)

--
2.25.1

