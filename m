Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDDE753F74
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbjGNQEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbjGNQE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:04:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9177A3595
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:04:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54ACA1576;
        Fri, 14 Jul 2023 09:05:05 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06F163F740;
        Fri, 14 Jul 2023 09:04:20 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 0/4] variable-order, large folios for anonymous memory
Date:   Fri, 14 Jul 2023 17:04:03 +0100
Message-Id: <20230714160407.4142030-1-ryan.roberts@arm.com>
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

This is v3 of a series to implement variable order, large folios for anonymous
memory. (currently called "FLEXIBLE_THP") The objective of this is to improve
performance by allocating larger chunks of memory during anonymous page faults.
See [1] and [2] for background.

There has been quite a bit more rework and simplification, mainly based on
feedback from Yu Zhao. Additionally, I've added a command line parameter,
flexthp_unhinted_max, the idea for which came from discussion with David
Hildenbrand (thanks for all your feedback!).

The last patch is for arm64 to explicitly override the default
arch_wants_pte_order() and is intended as an example. If this series is accepted
I suggest taking the first 3 patches through the mm tree and the arm64 change
could be handled through the arm64 tree separately. Neither has any build
dependency on the other.

The patches are based on top of v6.5-rc1. I have a branch at [3].


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


Performance
-----------

Performance is still similar to v2; see cover letter at [2].


Opens
-----

  - Feature name: FLEXIBLE_THP or LARGE_ANON_FOLIO?
      - Given the closer policy ties to THP, I prefer FLEXIBLE_THP
  - Prerequisits for merging
      - Sounds like there is a concensus that we should wait until exisitng
        features are improved to place nicely with large folios.


[1] https://lore.kernel.org/linux-mm/20230626171430.3167004-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20230703135330.1865927-1-ryan.roberts@arm.com/
[3] https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/granule_perf/anonfolio-lkml_v3


Thanks,
Ryan


Ryan Roberts (4):
  mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
  mm: Default implementation of arch_wants_pte_order()
  mm: FLEXIBLE_THP for improved performance
  arm64: mm: Override arch_wants_pte_order()

 .../admin-guide/kernel-parameters.txt         |  10 +
 arch/arm64/include/asm/pgtable.h              |   6 +
 include/linux/pgtable.h                       |  13 ++
 mm/Kconfig                                    |  10 +
 mm/memory.c                                   | 187 ++++++++++++++++--
 mm/rmap.c                                     |  28 ++-
 6 files changed, 230 insertions(+), 24 deletions(-)

--
2.25.1

