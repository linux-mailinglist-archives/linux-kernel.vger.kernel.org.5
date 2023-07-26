Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131547632DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjGZJwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjGZJwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:52:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5233A26B9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:52:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EDDC1692;
        Wed, 26 Jul 2023 02:52:42 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61A1B3F67D;
        Wed, 26 Jul 2023 02:51:57 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/5] variable-order, large folios for anonymous memory
Date:   Wed, 26 Jul 2023 10:51:41 +0100
Message-Id: <20230726095146.2826796-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is v4 of a series to implement variable order, large folios for anonymous
memory. (currently called "LARGE_ANON_FOLIO", previously called "FLEXIBLE_THP").
The objective of this is to improve performance by allocating larger chunks of
memory during anonymous page faults:

1) Since SW (the kernel) is dealing with larger chunks of memory than base
   pages, there are efficiency savings to be had; fewer page faults, batched PTE
   and RMAP manipulation, reduced lru list, etc. In short, we reduce kernel
   overhead. This should benefit all architectures.
2) Since we are now mapping physically contiguous chunks of memory, we can take
   advantage of HW TLB compression techniques. A reduction in TLB pressure
   speeds up kernel and user space. arm64 systems have 2 mechanisms to coalesce
   TLB entries; "the contiguous bit" (architectural) and HPA (uarch).

This patch set deals with the SW side of things (1). (2) is being tackled in a
separate series. The new behaviour is hidden behind a new Kconfig switch,
LARGE_ANON_FOLIO, which is disabled by default. Although the eventual aim is to
enable it by default.

The "arm64: mm: Override arch_wants_pte_order()" patch is for arm64 to
explicitly override the default arch_wants_pte_order() and is intended as an
example. If this series is accepted I suggest ignoring this patch which I will
take through the arm64 tree separately. Neither has any build dependency on the
other.

My hope is that we are pretty much there with the changes at this point.
Although they should not be merged until the prerequisites are complete. These
are in progress and tracked at [4].

The patches are based on top of v6.5-rc3. I have a branch at [5].


Testing
-------

This version adds patches to mm selftests so that the cow tests explicitly test
large anon folios, in the same way that thp is tested. When enabled you should
see something similar at the start of the test suite:

  # [INFO] detected large anon folio size: 64 KiB

Then the following results are expected. The fails and skips are due to existing
issues:

  # Totals: pass:263 fail:16 xfail:0 xpass:0 skip:29 error:0

Existing mm selftests reveal 1 regression in khugepaged tests when
LARGE_ANON_FOLIO is enabled:

  Run test: collapse_max_ptes_none (khugepaged:anon)
  Maybe collapse with max_ptes_none exceeded.... Fail
  Unexpected huge page

I believe this is because khugepaged currently skips non-order-0 pages when
looking for collapse opportunities and should get fixed with the help of
DavidH's work to create a mechanism to precisely determine shared vs exclusive
pages.


Changes since v3 [3]
--------------------

  - Renamed feature from FLEXIBLE_THP to LARGE_ANON_FOLIO.
  - Removed `flexthp_unhinted_max` boot parameter. Discussion concluded that a
    sysctl is preferable but we will wait until real workload needs it.
  - Fixed uninitialized `addr` on read fault path in do_anonymous_page().
  - Added mm selftests for large anon folios in cow test suite.


Changes since v2 [2]
--------------------

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
--------------------

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


Performance
-----------

Kernel compilation with 8 jobs:
| kernel                     |   real-time |   kern-time |   user-time |
|:---------------------------|------------:|------------:|------------:|
| baseline-v6.5-rc3          |        0.0% |        0.0% |        0.0% |
| anonfolio-v4               |       -4.9% |      -38.2% |       -0.7% |

Kernel compilation with 80 jobs:
| kernel                     |   real-time |   kern-time |   user-time |
|:---------------------------|------------:|------------:|------------:|
| baseline-v6.5-rc3          |        0.0% |        0.0% |        0.0% |
| anonfolio-v4               |       -5.1% |      -42.3% |       -0.4% |

Speedometer:
| kernel                     |   runs_per_min |
|:---------------------------|---------------:|
| baseline-v6.5-rc3          |           0.0% |
| anonfolio-v4               |           0.6% |


[1] https://lore.kernel.org/linux-mm/20230626171430.3167004-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20230703135330.1865927-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/linux-mm/20230714160407.4142030-1-ryan.roberts@arm.com/
[4] https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/
[5] https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/granule_perf/anonfolio-for_lkml_v4

Thanks,
Ryan


Ryan Roberts (5):
  mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
  mm: LARGE_ANON_FOLIO for improved performance
  arm64: mm: Override arch_wants_pte_order()
  selftests/mm/cow: Generalize do_run_with_thp() helper
  selftests/mm/cow: Add large anon folio tests

 arch/arm64/include/asm/pgtable.h |   6 +
 include/linux/pgtable.h          |  13 ++
 mm/Kconfig                       |  10 ++
 mm/memory.c                      | 166 +++++++++++++++++++---
 mm/rmap.c                        |  27 +++-
 tools/testing/selftests/mm/cow.c | 229 ++++++++++++++++++++++---------
 6 files changed, 365 insertions(+), 86 deletions(-)

--
2.25.1

