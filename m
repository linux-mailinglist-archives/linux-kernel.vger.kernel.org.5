Return-Path: <linux-kernel+bounces-4833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD61D8182AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31A31C2377C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1384B1172A;
	Tue, 19 Dec 2023 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XR8GUsal"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120411712
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702972556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+h83lLyn/5apLRr4X1Iml0TGvxqR5/pwpG6+wMVRoO8=;
	b=XR8GUsaluDchgruKmarqBEqjW3Wqmhwn4GplqLYMVIMv0CFAKTWmyjaZJ4QLKt6Y03shFw
	5SPz1ofzy3xk0tM53bvNAgaXdpVWJxzfVMba7MLpXt7SgdL9i/0dCMaKKz9fVEpw8TaBHi
	XD0l0+6cK3iff/FxWtQuYwIL0K3Oa2w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-78fty2BGN2uAAfrfPZNG0g-1; Tue,
 19 Dec 2023 02:55:53 -0500
X-MC-Unique: 78fty2BGN2uAAfrfPZNG0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 065E63C025C1;
	Tue, 19 Dec 2023 07:55:52 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 83B262026D66;
	Tue, 19 Dec 2023 07:55:40 +0000 (UTC)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org,
	Rik van Riel <riel@surriel.com>,
	linux-riscv@lists.infradead.org,
	Yang Shi <shy828301@gmail.com>,
	James Houghton <jthoughton@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	peterx@redhat.com,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH 00/13] mm/gup: Unify hugetlb, part 2
Date: Tue, 19 Dec 2023 15:55:25 +0800
Message-ID: <20231219075538.414708-1-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From: Peter Xu <peterx@redhat.com>

This is v1 of the series.  The series removes the hugetlb slow gup path
after a previous refactor work [1], so that slow gup now uses the exact
same path to handle all kinds of memory including hugetlb.

It's based on latest mm-unstalbe (c13bdc82ada9).

RFC->v1 (use old verion's patch index):
- Fix build for !THP and/or !HUGETLB
- Fix a bug in the hugepd path that can cause a loop
- patch 3:
  - Rename to "Make HPAGE_PXD_* macros visible even if !THP" [Christoph, MikeR]
- patch 5:
  - Posted separately as a devmap bugfix
- patch 6:
  - Add a comment above gup_huge_pd() explaining the file folio writeback
    issue, with references when anyone would extend hugepd to other types
    of file memories [Christoph]
- patch 7:
  - Keep parameter name as "page" in record_subpages(), modify the
    commit message by removing any assumption on head page. [Matthew]
- patch 12:
  - Rename to: "mm/gup: handle hugetlb in the generic follow_page_mask
    code" [Christoph]
- Added patch:
  - "mm/Kconfig: CONFIG_PGTABLE_HAS_HUGE_LEAVES", this helps to fix build
    for !THP and/or !HUGETLB
- Added patch
  - "mm/gup: Cache *pudp in follow_pud_mask()", as suggested by Christoph

For the long term, this is one small step towards merging hugetlb specific
codes into generic mm paths.  From that POV, this series removes one
reference to huge_pte_offset() out of many others.

To make it work, the generic code will need to at least understand hugepd,
which is already done like so in fast-gup.  Fortunately it seems that's the
only major thing I need to teach slow GUP to share the common path for now
besides normal huge PxD entries.  Non-gup can be more challenging, but
that's a question for later.

There's one major difference for slow-gup on cont_pte / cont_pmd handling,
currently supported on three architectures (aarch64, riscv, ppc).  Before
the series, slow gup will be able to recognize cont entries with the help
of huge_pte_offset().  Now it's gone but still working, by looking up
pgtable entries one by one.  It's not ideal, but hopefully this change
should not affect yet on major workloads.  There's some more information in
the commit message of the last patch.  If this would be a concern, we can
consider teaching slow gup to recognize cont pte/pmd entries, and that
should recover the lost performance.  But I doubt its necessity for now, so
I kept it as simple as it can be.

Test Done
=========

This v1 went through the normal GUP smoke tests over different memory
types on archs (using VM instances): x86_64, aarch64, ppc64le.  For
aarch64, tested over 64KB cont_pte huge pages.  For ppc64le, tested over
16MB hugepd entries (Power8 hash MMU on 4K base page size).

Patch layout
=============

Patch 1-7:    Preparation works, or cleanups in relevant code paths
Patch 8-12:   Teach slow gup with all kinds of huge entries (pXd, hugepd)
Patch 13:     Drop hugetlb_follow_page_mask()

More information can be found in the commit messages of each patch.  Any
comment will be welcomed.  Thanks.

[1] https://lore.kernel.org/all/20230628215310.73782-1-peterx@redhat.com

Peter Xu (13):
  mm/Kconfig: CONFIG_PGTABLE_HAS_HUGE_LEAVES
  mm/hugetlb: Declare hugetlbfs_pagecache_present() non-static
  mm: Provide generic pmd_thp_or_huge()
  mm: Make HPAGE_PXD_* macros even if !THP
  mm: Introduce vma_pgtable_walk_{begin|end}()
  mm/gup: Drop folio_fast_pin_allowed() in hugepd processing
  mm/gup: Refactor record_subpages() to find 1st small page
  mm/gup: Handle hugetlb for no_page_table()
  mm/gup: Cache *pudp in follow_pud_mask()
  mm/gup: Handle huge pud for follow_pud_mask()
  mm/gup: Handle huge pmd for follow_pmd_mask()
  mm/gup: Handle hugepd for follow_page()
  mm/gup: Handle hugetlb in the generic follow_page_mask code

 include/linux/huge_mm.h |  25 +--
 include/linux/hugetlb.h |  16 +-
 include/linux/mm.h      |   3 +
 include/linux/pgtable.h |   4 +
 mm/Kconfig              |   3 +
 mm/gup.c                | 362 ++++++++++++++++++++++++++++++++--------
 mm/huge_memory.c        | 133 +--------------
 mm/hugetlb.c            |  75 +--------
 mm/internal.h           |   7 +-
 mm/memory.c             |  12 ++
 10 files changed, 342 insertions(+), 298 deletions(-)

-- 
2.41.0


