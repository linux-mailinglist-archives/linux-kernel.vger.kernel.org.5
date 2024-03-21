Return-Path: <linux-kernel+bounces-110726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735298862F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF055B22DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3D4136655;
	Thu, 21 Mar 2024 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQFPxs5I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C165931758
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058890; cv=none; b=r2ZzpNUj1+w0uyVB9uSvssUCwoNWtmHwbSzRVKkjXUpPIDbwpT0OjCbXvqeA6g9XPBprWoxVjcF9CCOo9Kbg7TrPcofTkpcV2NlnRSrCnlQmESd/tR5yqjhTMH3sgEKltjBZVxrH3rRa3qL/vXWmqWtqq/GAoQB3MhHf9USh5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058890; c=relaxed/simple;
	bh=ec65ezZ8jhnTY6xgmdhM4W5H8+OlNPqUocdNhS4LT48=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A95uATUu4oRctKE0RzD8VEsLQCv07WGYuHzT5y9q6aXR7Xt2tLb8QdPApI67Y7iXjI0wjbC2dSrqF2FTVYYsZTqXqhwNCCyNn0wFPEaaxINxq0TdUf0qbJXHHrBRZd5ix1t6VvDarMzZwR/tDV97nbr0h22CyIJrFcxu9P0mzWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQFPxs5I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711058887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qBwIOGN4e8d3gKHF9DSbgwYKpkkiYBwtwtMI0MG6X/U=;
	b=hQFPxs5Iqa8oOYU8tRI2nlJB0QOmVFUok4HpsJXkFgyakHkcrZTS/NKYw+xy2UuwBsHRX8
	BRGTwRqrNPHGYwzEqGl/EHCdIbmWh0tkIKbxRIM3JTQR6dhRCjC6t6cjlIZm8Os3r5Ci/p
	ivIlWX1DQekKCR1MHNFekxacTkFnb4w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-bAd0ZgQ4PYCy6tEt_kBcTA-1; Thu, 21 Mar 2024 18:08:06 -0400
X-MC-Unique: bAd0ZgQ4PYCy6tEt_kBcTA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69152af7760so3924486d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058886; x=1711663686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBwIOGN4e8d3gKHF9DSbgwYKpkkiYBwtwtMI0MG6X/U=;
        b=SWQVoz0N7dEU3JsojXOh0+sUobaBkB+rFAIX92LOI/9Vk/jV4uQZDd9V4hx7cYeM1R
         IYcAra1e63vmjHVFsuJzLqQNEIInOY5+NeJL1NpSkI/NZw3kastHbG0EA/Z0Gnue4Y7E
         fq3Ddow2LLeCKPUfxMmNpztLryCOv4Gh+B/j5KOUml9dUinvkWVQ9EqlDUN4Ew6VR8aD
         cFV9qKvjWaiuziEqHRuYE26vKs6dQdMaVF3IITTEY7Zqw+rxn2N6aiiE4ysZWvCj3GnZ
         qsIxSNigCR+tLnrLjwyR1aELMCBWc9bdnDVhaj3bMSohZY7fpGcF8YatJBywp4QwGrkL
         8W0g==
X-Forwarded-Encrypted: i=1; AJvYcCUrmW2CmDP0ZnNQaXahWTuHu8b4CojYDo8un40RR1ofV7xRPz9AWZbqdCt7E6Q13WorVCdzK23k6oVUR9r+Ut9qaxGfgN4G1R9yk85z
X-Gm-Message-State: AOJu0YyJhv6/UT/VZDWKKTTL3n306VznGJxZMhT79+Yxe3ukndyVrToG
	1hTHqhz/u7UsPfMr3XyzEz/jnSxuPKwELqRMVZLFgsLkrxUPzJ/2HIDDDaOx1wlTljqoxHY7HBl
	W9A0STVnA4tp01AFTXozTgh2dTgDreqGZa9E2G1i8G2B8jgF6ZvSoUBklJ8jHjQ==
X-Received: by 2002:a05:6214:4198:b0:695:c55d:fdf8 with SMTP id ld24-20020a056214419800b00695c55dfdf8mr219303qvb.1.1711058885669;
        Thu, 21 Mar 2024 15:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjJcDDJC7HZiortxxZHWVHGJUJGwG79NEWr9Sr06E8nvFXSb1um5gXNtJQjx6vxfyzbm5MLg==
X-Received: by 2002:a05:6214:4198:b0:695:c55d:fdf8 with SMTP id ld24-20020a056214419800b00695c55dfdf8mr219273qvb.1.1711058885190;
        Thu, 21 Mar 2024 15:08:05 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id o6-20020a0562140e4600b00690baf5cde9sm351663qvc.118.2024.03.21.15.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:08:04 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	peterx@redhat.com,
	Yang Shi <shy828301@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Andrew Jones <andrew.jones@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	linux-riscv@lists.infradead.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 00/12] mm/gup: Unify hugetlb, part 2
Date: Thu, 21 Mar 2024 18:07:50 -0400
Message-ID: <20240321220802.679544-1-peterx@redhat.com>
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

v3:
- Rebased to latest mm-unstalbe (a824831a082f, of March 21th)
- Dropped patch to introduce pmd_thp_or_huge(), replace such uses (and also
  pXd_huge() users) with pXd_leaf() [Jason]
- Add a comment for CONFIG_PGTABLE_HAS_HUGE_LEAVES [Jason]
- Use IS_ENABLED() in follow_huge_pud() [Jason]
- Remove redundant none pud check in follow_pud_mask() [Jason]

rfc: https://lore.kernel.org/r/20231116012908.392077-1-peterx@redhat.com
v1:  https://lore.kernel.org/r/20231219075538.414708-1-peterx@redhat.com
v2:  https://lore.kernel.org/r/20240103091423.400294-1-peterx@redhat.com

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

Peter Xu (12):
  mm/Kconfig: CONFIG_PGTABLE_HAS_HUGE_LEAVES
  mm/hugetlb: Declare hugetlbfs_pagecache_present() non-static
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
 mm/Kconfig              |   6 +
 mm/gup.c                | 354 +++++++++++++++++++++++++++++++++-------
 mm/huge_memory.c        | 133 +--------------
 mm/hugetlb.c            |  75 +--------
 mm/internal.h           |   7 +-
 mm/memory.c             |  12 ++
 9 files changed, 337 insertions(+), 294 deletions(-)

-- 
2.44.0


