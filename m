Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B1476D3E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjHBQmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHBQma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:42:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CF21269A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:42:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90C41113E;
        Wed,  2 Aug 2023 09:43:10 -0700 (PDT)
Received: from [10.57.77.90] (unknown [10.57.77.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 359D63F6C4;
        Wed,  2 Aug 2023 09:42:25 -0700 (PDT)
Message-ID: <b308fbb3-73a1-f8b4-3b08-ed5da044b2a9@arm.com>
Date:   Wed, 2 Aug 2023 17:42:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 0/3] Optimize large folio interaction with deferred
 split
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230727141837.3386072-1-ryan.roberts@arm.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230727141837.3386072-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

After discussion about this in Matthew's THP Cabal, we have decided to take a
different approach with this patch set. Could you therefore remove it from
mm-unstable, please? Sorry about the noise.

I'm going to try 2 different approaches:
 - avoid the split lock contention by using mmu gather (suggested by Kirill)
 - expand the zap pte batching to also cover file folios (as requested by Yu).

Thanks,
Ryan



On 27/07/2023 15:18, Ryan Roberts wrote:
> Hi All,
> 
> This is v4 of a small series in support of my work to enable the use of large
> folios for anonymous memory (known as "FLEXIBLE_THP" or "LARGE_ANON_FOLIO") [5].
> It first makes it possible to add large, non-pmd-mappable folios to the deferred
> split queue. Then it modifies zap_pte_range() to batch-remove spans of
> physically contiguous pages from the rmap, which means that in the common case,
> we elide the need to ever put the folio on the deferred split queue, thus
> reducing lock contention and improving performance.
> 
> This becomes more visible once we have lots of large anonymous folios in the
> system, and Huang Ying has suggested solving this needs to be a prerequisit for
> merging the main FLEXIBLE_THP/LARGE_ANON_FOLIO work.
> 
> The series applies on top of v6.5-rc3 and a branch is available at [4].
> 
> NOTE: v3 is currently in mm-unstable and has a bug that affects s390, which this
> version fixes.
> 
> 
> Changes since v3 [3]
> --------------------
> 
> - Fixed bug reported on s390 [6]
>     - Since s390 enables MMU_GATHER_NO_GATHER, __tlb_remove_page() causes a ref
>       to be dropped on the page, but we were still using the page after that
>       function call.
>     - Fix by using folio_get()/folio_put() to guarrantee lifetime of page
>     - Thanks to Nathan Chancellor for the bug report and helping me get set up
>       with s390!
> - Don't use batch path if folio is not large
> 
> 
> Changes since v2 [2]
> --------------------
> 
> - patch 2: Reworked at Yu Zhou's request to reduce duplicated code.
>     - page_remove_rmap() now forwards to folio_remove_rmap_range() for the
>       !compound (PMD mapped) case.
>     - Both page_remove_rmap() and folio_remove_rmap_range() share common
>       epilogue via new helper function __remove_rmap_finish().
>     - As a result of the changes, I've removed the previous Reviewed-bys.
> - other 2 patches are unchanged.
> 
> 
> Changes since v1 [1]
> --------------------
> 
> - patch 2: Modified doc comment for folio_remove_rmap_range()
> - patch 2: Hoisted _nr_pages_mapped manipulation out of page loop so its now
>   modified once per folio_remove_rmap_range() call.
> - patch 2: Added check that page range is fully contained by folio in
>   folio_remove_rmap_range()
> - patch 2: Fixed some nits raised by Huang, Ying for folio_remove_rmap_range()
> - patch 3: Support batch-zap of all anon pages, not just those in anon vmas
> - patch 3: Renamed various functions to make their use clear
> - patch 3: Various minor refactoring/cleanups
> - Added Reviewed-By tags - thanks!
> 
> 
> [1] https://lore.kernel.org/linux-mm/20230717143110.260162-1-ryan.roberts@arm.com/
> [2] https://lore.kernel.org/linux-mm/20230719135450.545227-1-ryan.roberts@arm.com/
> [3] https://lore.kernel.org/linux-mm/20230720112955.643283-1-ryan.roberts@arm.com/
> [4] https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/granule_perf/deferredsplit-lkml_v4
> [5] https://lore.kernel.org/linux-mm/20230714160407.4142030-1-ryan.roberts@arm.com/
> [6] https://lore.kernel.org/linux-mm/20230726161942.GA1123863@dev-arch.thelio-3990X/
> 
> Thanks,
> Ryan
> 
> 
> Ryan Roberts (3):
>   mm: Allow deferred splitting of arbitrary large anon folios
>   mm: Implement folio_remove_rmap_range()
>   mm: Batch-zap large anonymous folio PTE mappings
> 
>  include/linux/rmap.h |   2 +
>  mm/memory.c          | 132 +++++++++++++++++++++++++++++++++++++++++++
>  mm/rmap.c            | 125 ++++++++++++++++++++++++++++++----------
>  3 files changed, 229 insertions(+), 30 deletions(-)
> 
> --
> 2.25.1
> 

