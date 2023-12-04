Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A05E803ECE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbjLDTxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDTw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:52:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0475FD2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:53:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FED91684;
        Mon,  4 Dec 2023 11:53:51 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DB4B3F5A1;
        Mon,  4 Dec 2023 11:53:02 -0800 (PST)
Message-ID: <993ea322-8cdb-4ab1-84d3-0a1cb40049c9@arm.com>
Date:   Mon, 4 Dec 2023 19:53:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/39] mm/rmap: interface overhaul
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231204142146.91437-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 14:21, David Hildenbrand wrote:
> Baed on mm-stable from a couple of days.
> 
> This series proposes an overhaul to our rmap interface, to get rid of the
> "bool compound" / RMAP_COMPOUND parameter with the goal of making the
> interface less error prone, more future proof, and more natural to extend
> to "batching". Also, this converts the interface to always consume
> folio+subpage, which speeds up operations on large folios.
> 
> Further, this series adds PTE-batching variants for 4 rmap functions,
> whereby only folio_add_anon_rmap_ptes() is used for batching in this series
> when PTE-remapping a PMD-mapped THP.

I certainly support the objective you have here; making the interfaces clearer,
more consistent and more amenable to batching. I'll try to find some time this
week to review.

> 
> Ryan has series where we would make use of folio_remove_rmap_ptes() [1]
> -- he carries his own batching variant right now -- and
> folio_try_dup_anon_rmap_ptes()/folio_dup_file_rmap_ptes() [2].

Note that the contpte series at [2] has a new patch in v3 (patch 2), which could
benefit from folio_remove_rmap_ptes() or equivalent. My plan was to revive [1]
on top of [2] once it is merged.

> 
> There is some overlap with both series (and some other work, like
> multi-size THP [3]), so that will need some coordination, and likely a
> stepwise inclusion.

Selfishly, I'd really like to get my stuff merged as soon as there is no
technical reason not to. I'd prefer not to add this as a dependency if we can
help it.

> 
> I got that started [4], but it made sense to show the whole picture. The
> patches of [4] are contained in here, with one additional patch added
> ("mm/rmap: introduce and use hugetlb_try_share_anon_rmap()") and some
> slight patch description changes.
> 
> In general, RMAP batching is an important optimization for PTE-mapped
> THP, especially once we want to move towards a total mapcount or further,
> as shown with my WIP patches on "mapped shared vs. mapped exclusively" [5].
> 
> The rmap batching part of [5] is also contained here in a slightly reworked
> fork [and I found a bug du to the "compound" parameter handling in these
> patches that should be fixed here :) ].
> 
> This series performs a lot of folio conversion, that could be separated
> if there is a good reason. Most of the added LOC in the diff are only due
> to documentation.
> 
> As we're moving to a pte/pmd interface where we clearly express the
> mapping granularity we are dealing with, we first get the remainder of
> hugetlb out of the way, as it is special and expected to remain special: it
> treats everything as a "single logical PTE" and only currently allows
> entire mappings.
> 
> Even if we'd ever support partial mappings, I strongly
> assume the interface and implementation will still differ heavily:
> hopefull we can avoid working on subpages/subpage mapcounts completely and
> only add a "count" parameter for them to enable batching.
> 
> 
> New (extended) hugetlb interface that operate on entire folio:
>  * hugetlb_add_new_anon_rmap() -> Already existed
>  * hugetlb_add_anon_rmap() -> Already existed
>  * hugetlb_try_dup_anon_rmap()
>  * hugetlb_try_share_anon_rmap()
>  * hugetlb_add_file_rmap()
>  * hugetlb_remove_rmap()
> 
> New "ordinary" interface for small folios / THP::
>  * folio_add_new_anon_rmap() -> Already existed
>  * folio_add_anon_rmap_[pte|ptes|pmd]()
>  * folio_try_dup_anon_rmap_[pte|ptes|pmd]()
>  * folio_try_share_anon_rmap_[pte|pmd]()
>  * folio_add_file_rmap_[pte|ptes|pmd]()
>  * folio_dup_file_rmap_[pte|ptes|pmd]()
>  * folio_remove_rmap_[pte|ptes|pmd]()

I'm not sure if there are official guidelines, but personally if we are
reworking the API, I'd take the opportunity to move "rmap" to the front of the
name, rather than having it burried in the middle as it is for some of these:

rmap_hugetlb_*()

rmap_folio_*()

I guess reading the patches will tell me, but what's the point of "ptes"? Surely
you're either mapping at pte or pmd level, and the number of pages is determined
by the folio size? (or presumably nr param passed in)

Thanks,
Ryan

> 
> folio_add_new_anon_rmap() will always map at the biggest granularity
> possible (currently, a single PMD to cover a PMD-sized THP). Could be
> extended if ever required.
> 
> In the future, we might want "_pud" variants and eventually "_pmds" variants
> for batching. Further, if hugepd is ever a thing outside hugetlb code,
> we might want some variants for that. All stuff for the distant future.
> 
> 
> I ran some simple microbenchmarks from [5] on an Intel(R) Xeon(R) Silver
> 4210R: munmap(), fork(), cow, MADV_DONTNEED on each PTE ... and PTE
> remapping PMD-mapped THPs on 1 GiB of memory.
> 
> For small folios, there is barely a change (< 1 % performance improvement),
> whereby fork() still stands out with 0.74% performance improvement, but
> it might be just some noise. Folio optimizations don't help that much
> with small folios.
> 
> For PTE-mapped THP:
> * PTE-remapping a PMD-mapped THP is more than 10% faster.
>   -> RMAP batching
> * fork() is more than 4% faster.
>   -> folio conversion
> * MADV_DONTNEED is 2% faster
>   -> folio conversion
> * COW by writing only a single byte on a COW-shared PTE
>   -> folio conversion
> * munmap() is only slightly faster (< 1%).
> 
> [1] https://lkml.kernel.org/r/20230810103332.3062143-1-ryan.roberts@arm.com
> [2] https://lkml.kernel.org/r/20231204105440.61448-1-ryan.roberts@arm.com
> [3] https://lkml.kernel.org/r/20231204102027.57185-1-ryan.roberts@arm.com
> [4] https://lkml.kernel.org/r/20231128145205.215026-1-david@redhat.com
> [5] https://lkml.kernel.org/r/20231124132626.235350-1-david@redhat.com
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Peter Xu <peterx@redhat.com>
> 
> David Hildenbrand (39):
>   mm/rmap: rename hugepage_add* to hugetlb_add*
>   mm/rmap: introduce and use hugetlb_remove_rmap()
>   mm/rmap: introduce and use hugetlb_add_file_rmap()
>   mm/rmap: introduce and use hugetlb_try_dup_anon_rmap()
>   mm/rmap: introduce and use hugetlb_try_share_anon_rmap()
>   mm/rmap: add hugetlb sanity checks
>   mm/rmap: convert folio_add_file_rmap_range() into
>     folio_add_file_rmap_[pte|ptes|pmd]()
>   mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()
>   mm/huge_memory: page_add_file_rmap() -> folio_add_file_rmap_pmd()
>   mm/migrate: page_add_file_rmap() -> folio_add_file_rmap_pte()
>   mm/userfaultfd: page_add_file_rmap() -> folio_add_file_rmap_pte()
>   mm/rmap: remove page_add_file_rmap()
>   mm/rmap: factor out adding folio mappings into __folio_add_rmap()
>   mm/rmap: introduce folio_add_anon_rmap_[pte|ptes|pmd]()
>   mm/huge_memory: batch rmap operations in __split_huge_pmd_locked()
>   mm/huge_memory: page_add_anon_rmap() -> folio_add_anon_rmap_pmd()
>   mm/migrate: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
>   mm/ksm: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
>   mm/swapfile: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
>   mm/memory: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
>   mm/rmap: remove page_add_anon_rmap()
>   mm/rmap: remove RMAP_COMPOUND
>   mm/rmap: introduce folio_remove_rmap_[pte|ptes|pmd]()
>   kernel/events/uprobes: page_remove_rmap() -> folio_remove_rmap_pte()
>   mm/huge_memory: page_remove_rmap() -> folio_remove_rmap_pmd()
>   mm/khugepaged: page_remove_rmap() -> folio_remove_rmap_pte()
>   mm/ksm: page_remove_rmap() -> folio_remove_rmap_pte()
>   mm/memory: page_remove_rmap() -> folio_remove_rmap_pte()
>   mm/migrate_device: page_remove_rmap() -> folio_remove_rmap_pte()
>   mm/rmap: page_remove_rmap() -> folio_remove_rmap_pte()
>   Documentation: stop referring to page_remove_rmap()
>   mm/rmap: remove page_remove_rmap()
>   mm/rmap: convert page_dup_file_rmap() to
>     folio_dup_file_rmap_[pte|ptes|pmd]()
>   mm/rmap: introduce folio_try_dup_anon_rmap_[pte|ptes|pmd]()
>   mm/huge_memory: page_try_dup_anon_rmap() ->
>     folio_try_dup_anon_rmap_pmd()
>   mm/memory: page_try_dup_anon_rmap() -> folio_try_dup_anon_rmap_pte()
>   mm/rmap: remove page_try_dup_anon_rmap()
>   mm: convert page_try_share_anon_rmap() to
>     folio_try_share_anon_rmap_[pte|pmd]()
>   mm/rmap: rename COMPOUND_MAPPED to ENTIRELY_MAPPED
> 
>  Documentation/mm/transhuge.rst       |   4 +-
>  Documentation/mm/unevictable-lru.rst |   4 +-
>  include/linux/mm.h                   |   6 +-
>  include/linux/rmap.h                 | 380 +++++++++++++++++++-----
>  kernel/events/uprobes.c              |   2 +-
>  mm/gup.c                             |   2 +-
>  mm/huge_memory.c                     |  85 +++---
>  mm/hugetlb.c                         |  21 +-
>  mm/internal.h                        |  12 +-
>  mm/khugepaged.c                      |  17 +-
>  mm/ksm.c                             |  15 +-
>  mm/memory-failure.c                  |   4 +-
>  mm/memory.c                          |  60 ++--
>  mm/migrate.c                         |  12 +-
>  mm/migrate_device.c                  |  41 +--
>  mm/mmu_gather.c                      |   2 +-
>  mm/rmap.c                            | 422 ++++++++++++++++-----------
>  mm/swapfile.c                        |   2 +-
>  mm/userfaultfd.c                     |   2 +-
>  19 files changed, 709 insertions(+), 384 deletions(-)
> 

