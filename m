Return-Path: <linux-kernel+bounces-121495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB62688E8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB8230847C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAA012F397;
	Wed, 27 Mar 2024 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Esbwt1vz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC51E12E1C2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553020; cv=none; b=tc7g9+Ua4J3xcLKfSI5QFpyRqnrp9+v/LhQ2anaPQ+wasFO+KvzpSxWtfaTsPSnuRnqtwKNq7n8Wrrsb3cZQ7XONUop5Xc2LdlIfOZ2bViwTcX3exL/XmoLjBZdgPzi3QeNxsKHKlH3me5cnKJFUjcvjsi5JqfzqL5amVY9DaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553020; c=relaxed/simple;
	bh=ow1Cpx65pYXkvLHQRFNBQDOaePjd5ZZTj/9w/oXKR+g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HjbgwSD96Puw5rfu2V1k8SJha+mqI2pjhfnbV5GCrVvVpXnRnTndwf+bUFAOwcX0VhegB0RZjtXuQQotlrc5zcTsCCXlliq8oJ6z3AwBVc6I7oFTAyfumSRVzZdKkCzh9HVhu4KN/MaIyVvhZIflKRrjGpTpNhpU2zMGq8sKaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Esbwt1vz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711553017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QY8+yIZm1ve5QuiynFE7MjMximJHpz8noDQuYnaNKN8=;
	b=Esbwt1vzoKiRbSwFeQA3mApmKG0xnUIYry3Aps1G9dmr9I5n14dmseAN9JrBQMFi4LKFsY
	D9L0PMo754iZAdXruU8CunaGwTexaO63iUH4ijBuidWwDP35a9ykck6nZl/ZJEsML/JrZ8
	bGFYXbD0fQ/xpD6gOJCHnDUZw6zzskA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-HRfmamJnNbqvMTQuYnCE6g-1; Wed, 27 Mar 2024 11:23:36 -0400
X-MC-Unique: HRfmamJnNbqvMTQuYnCE6g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69152af7760so25771906d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553016; x=1712157816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QY8+yIZm1ve5QuiynFE7MjMximJHpz8noDQuYnaNKN8=;
        b=KtpaZJnFji+6cArrWbJcKXeOm1rTbUtWZqPEUjtGijY2gUPRgcoU61uckpLydxoPpg
         sMJ8Cc86f/Kb1pc7Q+7rB0v6ojGf1FrlOPKkDo4xNuX2bppTK1gWADxj4HD1JAk3Ti5p
         6wEU8jIC4K3y+YOUFBE6LpH41kPXUZYVTJTaBN5pR1IGuqFUM/EmVJNxsXKmLFMXT7pC
         25wyQQFuXx/MZeDM/idJRZAa8xvNkZGStld9lWAUKFiSg6rTpYtFuyXDxcISmdGOu2Vo
         v1VZ8JgGcRbZg6GBLlqVXtQaTQv/2F8VBV1IF2LajyJC+dzb7l990ba2RgjAXL2D2tbH
         B3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWxtuQBnI9cYnLiY6w+4CdpAEJcy8ydxIpQeY+lf4lLm5zxT8B1KuCIIvClRjCjjw0k8VEJ3KvxMhYoCAcEYeKfoITAwBPuIsLoelVv
X-Gm-Message-State: AOJu0Yyh7m308py6PdM5gybp19HCutX1xT0QSIPMPu4921IsRiDMjIXn
	BmG6nP0bRo+SgbWqRGDKE/OzTafZeHHgVZr/K+keVOJSgJk8IUL0nVPAFvqJH7bpPakcIb+bmHo
	bxbhuNFeVOjyEMCIDKGc8YSqdxy843pZvsHhFkUvekUdpiyhVQP7nWzSLbZ5vzg==
X-Received: by 2002:a05:6214:4a07:b0:696:8ecc:c368 with SMTP id pg7-20020a0562144a0700b006968eccc368mr9338918qvb.5.1711553015493;
        Wed, 27 Mar 2024 08:23:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIDOc++LqI5apT0o+E9CespyQta03LCPOzKebS/1UvNBD/Rvzf0d7U/D6UOW074NAt3LtIIw==
X-Received: by 2002:a05:6214:4a07:b0:696:8ecc:c368 with SMTP id pg7-20020a0562144a0700b006968eccc368mr9338893qvb.5.1711553014922;
        Wed, 27 Mar 2024 08:23:34 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hu4-20020a056214234400b00690dd47a41csm6412639qvb.86.2024.03.27.08.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:23:34 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	peterx@redhat.com,
	Andrew Jones <andrew.jones@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v4 00/13] mm/gup: Unify hugetlb, part 2
Date: Wed, 27 Mar 2024 11:23:19 -0400
Message-ID: <20240327152332.950956-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

v4:
- Fix build issues, tested on more archs/configs ([x86_64, i386, arm, arm64,
  powerpc, riscv, s390] x [allno, alldef, allmod]).
  - Squashed the fixup series into v3, touched up commit messages [1]
  - Added the patch to fix pud_pfn() into the series [2]
  - Fixed one more build issue on arm+alldefconfig, where pgd_t is a
    two-item array.
- Manage R-bs: add some, remove some (due to the squashes above)
- Rebase to latest mm-unstable (2f6182cd23a7, March 26th)

rfc: https://lore.kernel.org/r/20231116012908.392077-1-peterx@redhat.com
v1:  https://lore.kernel.org/r/20231219075538.414708-1-peterx@redhat.com
v2:  https://lore.kernel.org/r/20240103091423.400294-1-peterx@redhat.com
v3:  https://lore.kernel.org/r/20240321220802.679544-1-peterx@redhat.com

The series removes the hugetlb slow gup path after a previous refactor work
[1], so that slow gup now uses the exact same path to process all kinds of
memory including hugetlb.

For the long term, we may want to remove most, if not all, call sites of
huge_pte_offset().  It'll be ideal if that API can be completely dropped
from arch hugetlb API.  This series is one small step towards merging
hugetlb specific codes into generic mm paths.  From that POV, this series
removes one reference to huge_pte_offset() out of many others.

One goal of such a route is that we can reconsider merging hugetlb features
like High Granularity Mapping (HGM).  It was not accepted in the past
because it may add lots of hugetlb specific codes and make the mm code even
harder to maintain.  With a merged codeset, features like HGM can hopefully
share some code with THP, legacy (PMD+) or modern (continuous PTEs).

To make it work, the generic slow gup code will need to at least understand
hugepd, which is already done like so in fast-gup.  Due to the specialty of
hugepd to be software-only solution (no hardware recognizes the hugepd
format, so it's purely artificial structures), there's chance we can merge
some or all hugepd formats with cont_pte in the future.  That question is
yet unsettled from Power side to have an acknowledgement.  As of now for
this series, I kept the hugepd handling because we may still need to do so
before getting a clearer picture of the future of hugepd.  The other reason
is simply that we did it already for fast-gup and most codes are still
around to be reused.  It'll make more sense to keep slow/fast gup behave
the same before a decision is made to remove hugepd.

There's one major difference for slow-gup on cont_pte / cont_pmd handling,
currently supported on three architectures (aarch64, riscv, ppc).  Before
the series, slow gup will be able to recognize e.g. cont_pte entries with
the help of huge_pte_offset() when hstate is around.  Now it's gone but
still working, by looking up pgtable entries one by one.

It's not ideal, but hopefully this change should not affect yet on major
workloads.  There's some more information in the commit message of the last
patch.  If this would be a concern, we can consider teaching slow gup to
recognize cont pte/pmd entries, and that should recover the lost
performance.  But I doubt its necessity for now, so I kept it as simple as
it can be.

Test Done
=========

For x86_64, tested full gup_test matrix over 2MB huge pages. For aarch64,
tested the same over 64KB cont_pte huge pages.

One note is that this v3 didn't go through any ppc test anymore, as finding
such system can always take time.  It's based on the fact that it was
tested in previous versions, and this version should have zero change
regarding to hugepd sections.

If anyone (Christophe?) wants to give it a shot on PowerPC, please do and I
would appreciate it: "./run_vmtests.sh -a -t gup_test" should do well
enough (please consider [2] applied if hugepd is <1MB), as long as we're
sure the hugepd pages are touched as expected.

Patch layout
=============

Patch 1-8:    Preparation works, or cleanups in relevant code paths
Patch 9-11:   Teach slow gup with all kinds of huge entries (pXd, hugepd)
Patch 12:     Drop hugetlb_follow_page_mask()

More information can be found in the commit messages of each patch.  Any
comment will be welcomed.  Thanks.

[1] https://lore.kernel.org/all/20230628215310.73782-1-peterx@redhat.com
[2] https://lore.kernel.org/r/20240321215047.678172-1-peterx@redhat.com

Peter Xu (13):
  mm/Kconfig: CONFIG_PGTABLE_HAS_HUGE_LEAVES
  mm/hugetlb: Declare hugetlbfs_pagecache_present() non-static
  mm: Make HPAGE_PXD_* macros even if !THP
  mm: Introduce vma_pgtable_walk_{begin|end}()
  mm/arch: Provide pud_pfn() fallback
  mm/gup: Drop folio_fast_pin_allowed() in hugepd processing
  mm/gup: Refactor record_subpages() to find 1st small page
  mm/gup: Handle hugetlb for no_page_table()
  mm/gup: Cache *pudp in follow_pud_mask()
  mm/gup: Handle huge pud for follow_pud_mask()
  mm/gup: Handle huge pmd for follow_pmd_mask()
  mm/gup: Handle hugepd for follow_page()
  mm/gup: Handle hugetlb in the generic follow_page_mask code

 arch/riscv/include/asm/pgtable.h    |   1 +
 arch/s390/include/asm/pgtable.h     |   1 +
 arch/sparc/include/asm/pgtable_64.h |   1 +
 arch/x86/include/asm/pgtable.h      |   1 +
 include/linux/huge_mm.h             |  37 +-
 include/linux/hugetlb.h             |  16 +-
 include/linux/mm.h                  |   3 +
 include/linux/pgtable.h             |  10 +
 mm/Kconfig                          |   6 +
 mm/gup.c                            | 518 ++++++++++++++++++++--------
 mm/huge_memory.c                    | 133 +------
 mm/hugetlb.c                        |  75 +---
 mm/internal.h                       |   7 +-
 mm/memory.c                         |  12 +
 14 files changed, 441 insertions(+), 380 deletions(-)

-- 
2.44.0


