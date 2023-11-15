Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE247EC394
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343871AbjKON2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343686AbjKON2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:28:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E72668F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:27:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C07BDA7;
        Wed, 15 Nov 2023 05:28:43 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 769C23F7B4;
        Wed, 15 Nov 2023 05:27:54 -0800 (PST)
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
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/10] Small-sized THP for anonymous memory
Date:   Wed, 15 Nov 2023 13:27:24 +0000
Message-Id: <20231115132734.931023-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is v7 of a series to implement small-sized THP for anonymous memory
(previously called "large anonymous folios"). The objective of this is to
improve performance by allocating larger chunks of memory during anonymous page
faults:

1) Since SW (the kernel) is dealing with larger chunks of memory than base
   pages, there are efficiency savings to be had; fewer page faults, batched PTE
   and RMAP manipulation, reduced lru list, etc. In short, we reduce kernel
   overhead. This should benefit all architectures.
2) Since we are now mapping physically contiguous chunks of memory, we can take
   advantage of HW TLB compression techniques. A reduction in TLB pressure
   speeds up kernel and user space. arm64 systems have 2 mechanisms to coalesce
   TLB entries; "the contiguous bit" (architectural) and HPA (uarch).

The major change in this revision is the migration to a new sysfs interface as
recommended by David Hildenbrand - thanks to David for the suggestion! This
interface is inspired by the existing per-hugepage-size sysfs interface used by
hugetlb, provides full backwards compatibility with the existing PMD-size THP
interface, and provides a base for future extensibility. See [7] for detailed
discussion of the interface.

By default, the existing behaviour (and performance) is maintained. The user
must explicitly enable small-sized THP to see the performance benefit.

The series has also become heavy with mm selftest changes: These all relate to
enlightenment of cow and khugepaged tests to explicitly test with small-sized
THP.

This series is based on mm-unstable (60df8b4235f5).


Prerequisites
=============

Some work items identified as being prerequisites are listed on page 3 at [8].
The summary is:

| item                          | status                  |
|:------------------------------|:------------------------|
| mlock                         | In mainline (v6.7)      |
| madvise                       | In mainline (v6.6)      |
| compaction                    | v1 posted [9]           |
| numa balancing                | Investigated: see below |
| user-triggered page migration | In mainline (v6.7)      |
| khugepaged collapse           | In mainline (NOP)       |

On NUMA balancing, which currently ignores any PTE-mapped THPs it encounters,
John Hubbard has investigated this and concluded that it is A) not clear at the
moment what a better policy might be for PTE-mapped THP and B) questions whether
this should really be considered a prerequisite given no regression is caused
for the default "small-sized THP disabled" case, and there is no correctness
issue when it is enabled - its just a potential for non-optimal performance.
(John please do elaborate if I haven't captured this correctly!)

If there are no disagreements about removing numa balancing from the list, then
that just leaves compaction which is in review on list at the moment.

I really would like to get this series (and its remaining comapction
prerequisite) in for v6.8. I accept that it may be a bit optimistic at this
point, but lets see where we get to with review?


Testing
=======

The series includes patches for mm selftests to enlighten the cow and khugepaged
tests to explicitly test with small-order THP, in the same way that PMD-order
THP is tested. The new tests all pass, and no regressions are observed in the mm
selftest suite. I've also run my usual kernel compilation and java script
benchmarks without any issues.

Refer to my performance numbers posted with v6 [6]. (These are for small-sized
THP only - they do not include the arm64 contpte follow-on series).

John Hubbard at Nvidia has indicated dramatic 10x performance improvements for
some workloads at [10]. (Observed using v6 of this series as well as the arm64
contpte series).

Kefeng Wang at Huawei has also indicated he sees improvements at [11] although
there are some latency regressions also.


Changes since v6 [6]
====================

  - Refactored vmf_pte_range_changed() to remove uffd special-case (suggested by
    JohnH)
  - Dropped accounting patch (#3 in v6) (suggested by DavidH)
      - Continue to account *PMD-sized* THP only for now
      - Can add more counters in future if needed
      - Page cache large folios haven't needed any new counters yet
  - Pivot to sysfs ABI proposed by DavidH
      - per-size directories in a similar shape to that used by hugetlb
  - Dropped "recommend" keyword patch (#6 in v6) (suggested by DavidH, Yu Zhou)
      - For now, users need to understand implicitly which sizes are beneficial
        to their HW/SW
  - Dropped arch_wants_pte_order() patch (#7 in v6)
      - No longer needed due to dropping patch "recommend" keyword patch
  - Enlightened khugepaged mm selftest to explicitly test with small-size THP
  - Scrubbed commit logs to use "small-sized THP" consistently (suggested by
    DavidH)


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
[6] https://lore.kernel.org/linux-mm/20230929114421.3761121-1-ryan.roberts@arm.com/
[7] https://lore.kernel.org/linux-mm/6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com/
[8] https://drive.google.com/file/d/1GnfYFpr7_c1kA41liRUW5YtCb8Cj18Ud/view?usp=sharing&resourcekey=0-U1Mj3-RhLD1JV6EThpyPyA
[9] https://lore.kernel.org/linux-mm/20231113170157.280181-1-zi.yan@sent.com/
[10] https://lore.kernel.org/linux-mm/c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com/
[11] https://lore.kernel.org/linux-mm/479b3e2b-456d-46c1-9677-38f6c95a0be8@huawei.com/


Thanks,
Ryan

Ryan Roberts (10):
  mm: Allow deferred splitting of arbitrary anon large folios
  mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
  mm: thp: Introduce per-size thp sysfs interface
  mm: thp: Support allocation of anonymous small-sized THP
  selftests/mm/kugepaged: Restore thp settings at exit
  selftests/mm: Factor out thp settings management
  selftests/mm: Support small-sized THP interface in thp_settings
  selftests/mm/khugepaged: Enlighten for small-sized THP
  selftests/mm/cow: Generalize do_run_with_thp() helper
  selftests/mm/cow: Add tests for anonymous small-sized THP

 Documentation/admin-guide/mm/transhuge.rst |  74 +++-
 Documentation/filesystems/proc.rst         |   6 +-
 fs/proc/task_mmu.c                         |   3 +-
 include/linux/huge_mm.h                    | 102 +++--
 mm/huge_memory.c                           | 263 +++++++++++--
 mm/khugepaged.c                            |  16 +-
 mm/memory.c                                | 112 +++++-
 mm/page_vma_mapped.c                       |   3 +-
 mm/rmap.c                                  |  32 +-
 tools/testing/selftests/mm/Makefile        |   4 +-
 tools/testing/selftests/mm/cow.c           | 215 +++++++----
 tools/testing/selftests/mm/khugepaged.c    | 410 ++++-----------------
 tools/testing/selftests/mm/run_vmtests.sh  |   2 +
 tools/testing/selftests/mm/thp_settings.c  | 349 ++++++++++++++++++
 tools/testing/selftests/mm/thp_settings.h  |  80 ++++
 15 files changed, 1160 insertions(+), 511 deletions(-)
 create mode 100644 tools/testing/selftests/mm/thp_settings.c
 create mode 100644 tools/testing/selftests/mm/thp_settings.h

--
2.25.1

