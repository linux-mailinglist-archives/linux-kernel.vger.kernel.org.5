Return-Path: <linux-kernel+bounces-7525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A3D81A948
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3ACA283FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F114A9B9;
	Wed, 20 Dec 2023 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxajV6ve"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8E22066
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SXpRjUwOAApTFQs7VGlgFv1h+kk8wlkxw5XJ/yaTDVw=;
	b=CxajV6vedhJHyndtBQ3jgEk2XjFoZFgnWhlQA6YwAibm4RCZ7tCj7m1346DM9ixIdUIOJP
	zMD1pN3eALw8Eqo0F9r2mKdgCrtVJno9DON8QnN0VOTMio6LC8L1+/ZJrWBwf2LApgjhol
	jy5I0y3UsMm8WyKXrD9s0VFhHSU5JQc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-a7cLD810Mbink02RtMBusA-1; Wed, 20 Dec 2023 17:45:08 -0500
X-MC-Unique: a7cLD810Mbink02RtMBusA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00E52185A780;
	Wed, 20 Dec 2023 22:45:08 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53D4240C6EB9;
	Wed, 20 Dec 2023 22:45:05 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 00/40] mm/rmap: interface overhaul
Date: Wed, 20 Dec 2023 23:44:24 +0100
Message-ID: <20231220224504.646757-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

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

For small folios, there is barely a change (< 1% improvement for me).

For PTE-mapped THP:
* PTE-remapping a PMD-mapped THP is more than 10% faster.
* fork() is more than 4% faster.
* MADV_DONTNEED is 2% faster
* COW when writing only a single byte on a COW-shared PTE is 1% faster
* munmap() barely changes (< 1%).

[1] https://lkml.kernel.org/r/20230810103332.3062143-1-ryan.roberts@arm.com
[2] https://lkml.kernel.org/r/20231204105440.61448-1-ryan.roberts@arm.com

---

If we pull this into mm/unstable in 2023, I'll have my notebook ready to
debug next to the Christmas tree. ;)

Based on current mm/mm-unstable. Compile-tested with/wihout THP on x86-64
and with defconig on a bunch more. Tested on x86-64.

v1 -> v2:
* Rebased on top of mm-unstable (minor conflicts)
* Move some sanity checks from #6 into #2 -> #5 and leave the remainder in
  #6
* Call it "rmap_level" instead of "rmap_mode".
* Consistently use "int" instead of "unsigned int" in rmap code
* Drop some stale comments
* Minor comment/description fixups + additions
* Spotted one last comment leftover, addressed in the (new) last patch
* Added RBs

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

David Hildenbrand (40):
  mm/rmap: rename hugepage_add* to hugetlb_add*
  mm/rmap: introduce and use hugetlb_remove_rmap()
  mm/rmap: introduce and use hugetlb_add_file_rmap()
  mm/rmap: introduce and use hugetlb_try_dup_anon_rmap()
  mm/rmap: introduce and use hugetlb_try_share_anon_rmap()
  mm/rmap: add hugetlb sanity checks for anon rmap handling
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
  mm: remove one last reference to page_add_*_rmap()

 Documentation/mm/transhuge.rst       |   4 +-
 Documentation/mm/unevictable-lru.rst |   4 +-
 include/linux/mm.h                   |   6 +-
 include/linux/rmap.h                 | 397 +++++++++++++++++++-----
 kernel/events/uprobes.c              |   2 +-
 mm/filemap.c                         |  10 +-
 mm/gup.c                             |   2 +-
 mm/huge_memory.c                     |  85 +++---
 mm/hugetlb.c                         |  21 +-
 mm/internal.h                        |  14 +-
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
 20 files changed, 739 insertions(+), 394 deletions(-)


base-commit: 2072407a394d0b3a3056f78a5630903da9471db0
-- 
2.43.0


