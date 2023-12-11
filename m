Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2654380D025
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344401AbjLKP46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344397AbjLKP44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:56:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D41AF1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gIYNTkt4lRg5dQRj6ZTd0KNVXXqltY+UcILlQ0Orr/Y=;
        b=DQr6R278h5b1+ulf157zwoBwRkowhyCrZka8t1gEMo4T8rgz6y0ghpxQPlUG477oOLYBYV
        +iv2p30GFrCOmLvAU4MCXYGWS+bW9V644EvcmMFheDI8qHmzDb047V273O5IprIX8x28d+
        D8I9NqxDFpwRlGHre7G0xOfnInoO1OY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-p_br7NpMPgawWyGWGkfahg-1; Mon, 11 Dec 2023 10:56:56 -0500
X-MC-Unique: p_br7NpMPgawWyGWGkfahg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB317185A789;
        Mon, 11 Dec 2023 15:56:55 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7596E1121312;
        Mon, 11 Dec 2023 15:56:53 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 00/39] mm/rmap: interface overhaul
Date:   Mon, 11 Dec 2023 16:56:13 +0100
Message-ID: <20231211155652.131054-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series overhauls the rmap interface, to get rid of the "bool compound"
/ RMAP_COMPOUND parameter with the goal of making the interface less error
prone, more future proof, and more natural to extend to "batching". Also,
this converts the interface to always consume folio+subpage, which speeds
up operations on large folios.

Further, this series adds PTE-batching variants for 4 rmap functions,
whereby only folio_add_anon_rmap_ptes() is used for batching in this series
when PTE-remapping a PMD-mapped THP. folio_remove_rmap_ptes(),
folio_try_dup_anon_rmap_ptes() and folio_dup_file_rmap_ptes() will soon
come in handy[1,2].

This series performs a lot of folio conversion along the way. Most of the
added LOC in the diff are only due to documentation.

As we're moving to a pte/pmd interface where we clearly express the
mapping granularity we are dealing with, we first get the remainder of
hugetlb out of the way, as it is special and expected to remain special: it
treats everything as a "single logical PTE" and only currently allows
entire mappings.

Even if we'd ever support partial mappings, I strongly assume the interface
and implementation will still differ heavily: hopefull we can avoid working
on subpages/subpage mapcounts completely and only add a "count" parameter
for them to enable batching.

New (extended) hugetlb interface that operates on entire folio:
 * hugetlb_add_new_anon_rmap() -> Already existed
 * hugetlb_add_anon_rmap() -> Already existed
 * hugetlb_try_dup_anon_rmap()
 * hugetlb_try_share_anon_rmap()
 * hugetlb_add_file_rmap()
 * hugetlb_remove_rmap()

New "ordinary" interface for small folios / THP::
 * folio_add_new_anon_rmap() -> Already existed
 * folio_add_anon_rmap_[pte|ptes|pmd]()
 * folio_try_dup_anon_rmap_[pte|ptes|pmd]()
 * folio_try_share_anon_rmap_[pte|pmd]()
 * folio_add_file_rmap_[pte|ptes|pmd]()
 * folio_dup_file_rmap_[pte|ptes|pmd]()
 * folio_remove_rmap_[pte|ptes|pmd]()

folio_add_new_anon_rmap() will always map at the largest granularity
possible (currently, a single PMD to cover a PMD-sized THP). Could be
extended if ever required.

In the future, we might want "_pud" variants and eventually "_pmds"
variants for batching.

I ran some simple microbenchmarks on an Intel(R) Xeon(R) Silver 4210R:
measuring munmap(), fork(), cow, MADV_DONTNEED on each PTE ... and PTE
remapping PMD-mapped THPs on 1 GiB of memory.

For small folios, there is barely a change (< 1%).

For PTE-mapped THP:
* PTE-remapping a PMD-mapped THP is more than 10% faster.
* fork() is more than 4% faster.
* MADV_DONTNEED is 2% faster
* COW when writing only a single byte on a COW-shared PTE is 1% faster
* munmap() barely changes (< 1%).

[1] https://lkml.kernel.org/r/20230810103332.3062143-1-ryan.roberts@arm.com
[2] https://lkml.kernel.org/r/20231204105440.61448-1-ryan.roberts@arm.com

---

Based on current mm/mm-unstable. Compile-tested with/wihout THP on x86-64
and with defconig on a bunch more. Tested on x86-64.

RFC -> v1:
* Rebased on top of mm-unstable (containing mTHP)
* Use switch()-case and _always_inline for helper functions
* Fixed some (intermittend) compile issues and some smaller stuff
* folio_try_dup_anon_rmap_[pte|ptes|pmd]() rewrite
* Pass nr_pages consistently as "int"
* Simplify sanity checks
* Added RBs

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Peter Xu <peterx@redhat.com>


David Hildenbrand (39):
  mm/rmap: rename hugepage_add* to hugetlb_add*
  mm/rmap: introduce and use hugetlb_remove_rmap()
  mm/rmap: introduce and use hugetlb_add_file_rmap()
  mm/rmap: introduce and use hugetlb_try_dup_anon_rmap()
  mm/rmap: introduce and use hugetlb_try_share_anon_rmap()
  mm/rmap: add hugetlb sanity checks
  mm/rmap: convert folio_add_file_rmap_range() into
    folio_add_file_rmap_[pte|ptes|pmd]()
  mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()
  mm/huge_memory: page_add_file_rmap() -> folio_add_file_rmap_pmd()
  mm/migrate: page_add_file_rmap() -> folio_add_file_rmap_pte()
  mm/userfaultfd: page_add_file_rmap() -> folio_add_file_rmap_pte()
  mm/rmap: remove page_add_file_rmap()
  mm/rmap: factor out adding folio mappings into __folio_add_rmap()
  mm/rmap: introduce folio_add_anon_rmap_[pte|ptes|pmd]()
  mm/huge_memory: batch rmap operations in __split_huge_pmd_locked()
  mm/huge_memory: page_add_anon_rmap() -> folio_add_anon_rmap_pmd()
  mm/migrate: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
  mm/ksm: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
  mm/swapfile: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
  mm/memory: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
  mm/rmap: remove page_add_anon_rmap()
  mm/rmap: remove RMAP_COMPOUND
  mm/rmap: introduce folio_remove_rmap_[pte|ptes|pmd]()
  kernel/events/uprobes: page_remove_rmap() -> folio_remove_rmap_pte()
  mm/huge_memory: page_remove_rmap() -> folio_remove_rmap_pmd()
  mm/khugepaged: page_remove_rmap() -> folio_remove_rmap_pte()
  mm/ksm: page_remove_rmap() -> folio_remove_rmap_pte()
  mm/memory: page_remove_rmap() -> folio_remove_rmap_pte()
  mm/migrate_device: page_remove_rmap() -> folio_remove_rmap_pte()
  mm/rmap: page_remove_rmap() -> folio_remove_rmap_pte()
  Documentation: stop referring to page_remove_rmap()
  mm/rmap: remove page_remove_rmap()
  mm/rmap: convert page_dup_file_rmap() to
    folio_dup_file_rmap_[pte|ptes|pmd]()
  mm/rmap: introduce folio_try_dup_anon_rmap_[pte|ptes|pmd]()
  mm/huge_memory: page_try_dup_anon_rmap() ->
    folio_try_dup_anon_rmap_pmd()
  mm/memory: page_try_dup_anon_rmap() -> folio_try_dup_anon_rmap_pte()
  mm/rmap: remove page_try_dup_anon_rmap()
  mm: convert page_try_share_anon_rmap() to
    folio_try_share_anon_rmap_[pte|pmd]()
  mm/rmap: rename COMPOUND_MAPPED to ENTIRELY_MAPPED

 Documentation/mm/transhuge.rst       |   4 +-
 Documentation/mm/unevictable-lru.rst |   4 +-
 include/linux/mm.h                   |   6 +-
 include/linux/rmap.h                 | 398 +++++++++++++++++++-----
 kernel/events/uprobes.c              |   2 +-
 mm/filemap.c                         |  10 +-
 mm/gup.c                             |   2 +-
 mm/huge_memory.c                     |  85 +++---
 mm/hugetlb.c                         |  21 +-
 mm/internal.h                        |  12 +-
 mm/khugepaged.c                      |  17 +-
 mm/ksm.c                             |  15 +-
 mm/memory-failure.c                  |   4 +-
 mm/memory.c                          |  60 ++--
 mm/migrate.c                         |  12 +-
 mm/migrate_device.c                  |  41 +--
 mm/mmu_gather.c                      |   2 +-
 mm/rmap.c                            | 433 ++++++++++++++++-----------
 mm/swapfile.c                        |   2 +-
 mm/userfaultfd.c                     |   2 +-
 20 files changed, 740 insertions(+), 392 deletions(-)

-- 
2.43.0

