Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6F3777BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjHJPNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjHJPNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:13:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D68790
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:13:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D467D75;
        Thu, 10 Aug 2023 08:14:25 -0700 (PDT)
Received: from [10.1.27.169] (XHFQ2J9959.cambridge.arm.com [10.1.27.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0668B3F64C;
        Thu, 10 Aug 2023 08:13:40 -0700 (PDT)
Message-ID: <fae40dbd-4d80-4058-83b3-c85c35093c87@arm.com>
Date:   Thu, 10 Aug 2023 16:13:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] variable-order, large folios for anonymous memory
Content-Language: en-GB
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230810142942.3169679-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 15:29, Ryan Roberts wrote:
> Hi All,
> 
> This is v5 of a series to implement variable order, large folios for anonymous
> memory. (currently called "LARGE_ANON_FOLIO", previously called "FLEXIBLE_THP").
> The objective of this is to improve performance by allocating larger chunks of
> memory during anonymous page faults:
> 
> 1) Since SW (the kernel) is dealing with larger chunks of memory than base
>    pages, there are efficiency savings to be had; fewer page faults, batched PTE
>    and RMAP manipulation, reduced lru list, etc. In short, we reduce kernel
>    overhead. This should benefit all architectures.
> 2) Since we are now mapping physically contiguous chunks of memory, we can take
>    advantage of HW TLB compression techniques. A reduction in TLB pressure
>    speeds up kernel and user space. arm64 systems have 2 mechanisms to coalesce
>    TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
> 
> This patch set deals with the SW side of things (1). (2) is being tackled in a
> separate series. The new behaviour is hidden behind a new Kconfig switch,
> LARGE_ANON_FOLIO, which is disabled by default. Although the eventual aim is to
> enable it by default.
> 
> My hope is that we are pretty much there with the changes at this point;
> hopefully this is sufficient to get an initial version merged so that we can
> scale up characterization efforts. Although they should not be merged until the
> prerequisites are complete. These are in progress and tracked at [5].
> 
> This series is based on mm-unstable (ad3232df3e41).
> 
> I'm going to be out on holiday from the end of today, returning on 29th
> August. So responses will likely be patchy, as I'm terrified of posting
> to list from my phone!
> 
> 
> Testing
> -------
> 
> This version adds patches to mm selftests so that the cow tests explicitly test
> large anon folios, in the same way that thp is tested. When enabled you should
> see something similar at the start of the test suite:
> 
>   # [INFO] detected large anon folio size: 32 KiB
> 
> Then the following results are expected. The fails and skips are due to existing
> issues in mm-unstable:
> 
>   # Totals: pass:207 fail:16 xfail:0 xpass:0 skip:85 error:0

Oops, the above are the results when running with SWAP disabled. This is what
you would normally see when SWAP is enabled:

    # Totals: pass:291 fail:16 xfail:0 xpass:0 skip:1 error:0

> 
> Existing mm selftests reveal 1 regression in khugepaged tests when
> LARGE_ANON_FOLIO is enabled:
> 
>   Run test: collapse_max_ptes_none (khugepaged:anon)
>   Maybe collapse with max_ptes_none exceeded.... Fail
>   Unexpected huge page
> 
> I believe this is because khugepaged currently skips non-order-0 pages when
> looking for collapse opportunities and should get fixed with the help of
> DavidH's work to create a mechanism to precisely determine shared vs exclusive
> pages.
> 
> 
> Changes since v4 [4]
> --------------------
> 
>   - Removed "arm64: mm: Override arch_wants_pte_order()" patch; arm64
>     now uses the default order-3 size. I have moved this patch over to
>     the contpte series.
>   - Added "mm: Allow deferred splitting of arbitrary large anon folios" back
>     into series. I originally removed this at v2 to add to a separate series,
>     but that series has transformed significantly and it no longer fits, so
>     bringing it back here.
>   - Reintroduced dependency on set_ptes(); Originally dropped this at v2, but
>     set_ptes() is in mm-unstable now.
>   - Updated policy for when to allocate LAF; only fallback to order-0 if
>     MADV_NOHUGEPAGE is present or if THP disabled via prctl; no longer rely on
>     sysfs's never/madvise/always knob.
>   - Fallback to order-0 whenever uffd is armed for the vma, not just when
>     uffd-wp is set on the pte.
>   - alloc_anon_folio() now returns `strucxt folio *`, where errors are encoded
>     with ERR_PTR().
> 
>   The last 3 changes were proposed by Yu Zhao - thanks!
> 
> 
> Changes since v3 [3]
> --------------------
> 
>   - Renamed feature from FLEXIBLE_THP to LARGE_ANON_FOLIO.
>   - Removed `flexthp_unhinted_max` boot parameter. Discussion concluded that a
>     sysctl is preferable but we will wait until real workload needs it.
>   - Fixed uninitialized `addr` on read fault path in do_anonymous_page().
>   - Added mm selftests for large anon folios in cow test suite.
> 
> 
> Changes since v2 [2]
> --------------------
> 
>   - Dropped commit "Allow deferred splitting of arbitrary large anon folios"
>       - Huang, Ying suggested the "batch zap" work (which I dropped from this
>         series after v1) is a prerequisite for merging FLXEIBLE_THP, so I've
>         moved the deferred split patch to a separate series along with the batch
>         zap changes. I plan to submit this series early next week.
>   - Changed folio order fallback policy
>       - We no longer iterate from preferred to 0 looking for acceptable policy
>       - Instead we iterate through preferred, PAGE_ALLOC_COSTLY_ORDER and 0 only
>   - Removed vma parameter from arch_wants_pte_order()
>   - Added command line parameter `flexthp_unhinted_max`
>       - clamps preferred order when vma hasn't explicitly opted-in to THP
>   - Never allocate large folio for MADV_NOHUGEPAGE vma (or when THP is disabled
>     for process or system).
>   - Simplified implementation and integration with do_anonymous_page()
>   - Removed dependency on set_ptes()
> 
> 
> Changes since v1 [1]
> --------------------
> 
>   - removed changes to arch-dependent vma_alloc_zeroed_movable_folio()
>   - replaced with arch-independent alloc_anon_folio()
>       - follows THP allocation approach
>   - no longer retry with intermediate orders if allocation fails
>       - fallback directly to order-0
>   - remove folio_add_new_anon_rmap_range() patch
>       - instead add its new functionality to folio_add_new_anon_rmap()
>   - remove batch-zap pte mappings optimization patch
>       - remove enabler folio_remove_rmap_range() patch too
>       - These offer real perf improvement so will submit separately
>   - simplify Kconfig
>       - single FLEXIBLE_THP option, which is independent of arch
>       - depends on TRANSPARENT_HUGEPAGE
>       - when enabled default to max anon folio size of 64K unless arch
>         explicitly overrides
>   - simplify changes to do_anonymous_page():
>       - no more retry loop
> 
> 
> [1] https://lore.kernel.org/linux-mm/20230626171430.3167004-1-ryan.roberts@arm.com/
> [2] https://lore.kernel.org/linux-mm/20230703135330.1865927-1-ryan.roberts@arm.com/
> [3] https://lore.kernel.org/linux-mm/20230714160407.4142030-1-ryan.roberts@arm.com/
> [4] https://lore.kernel.org/linux-mm/20230726095146.2826796-1-ryan.roberts@arm.com/
> [5] https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/
> 
> 
> Thanks,
> Ryan
> 
> Ryan Roberts (5):
>   mm: Allow deferred splitting of arbitrary large anon folios
>   mm: Non-pmd-mappable, large folios for folio_add_new_anon_rmap()
>   mm: LARGE_ANON_FOLIO for improved performance
>   selftests/mm/cow: Generalize do_run_with_thp() helper
>   selftests/mm/cow: Add large anon folio tests
> 
>  include/linux/pgtable.h          |  13 ++
>  mm/Kconfig                       |  10 ++
>  mm/memory.c                      | 144 +++++++++++++++++--
>  mm/rmap.c                        |  31 +++--
>  tools/testing/selftests/mm/cow.c | 229 ++++++++++++++++++++++---------
>  5 files changed, 347 insertions(+), 80 deletions(-)
> 
> --
> 2.25.1
> 

