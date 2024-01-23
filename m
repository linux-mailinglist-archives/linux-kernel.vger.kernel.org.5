Return-Path: <linux-kernel+bounces-35759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF6D839617
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E4428CDB0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42F77FBB6;
	Tue, 23 Jan 2024 17:14:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7EC7F7DE;
	Tue, 23 Jan 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030073; cv=none; b=DGsemnoy3GyaVWepd+dEJOL3J5LWsduP5d4iLoIi0M2j6eWS/QH8rkbXFPnHET/yYfcKLa+YiKOyAvpVCWijjpltuyhh026lNKrNr/RqPScYRQl+qjuJlgUne4+ST4yYxU4z4LklcLHPgrixl1BB2oCqTBxV2/pM54TZlSuB97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030073; c=relaxed/simple;
	bh=75op/UILW8qXFGBuR14WbnKN2oEjWm2tsZZHmguGNIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YegcNmQ74g3nLhe6S5ZR0xmc03RV91qmFtiw73vVslbxiRSqldlcysVei/ITbqzCrnkrUHevkf5oRWfv8DsnJ8gdK4TBs0bIjmrkalLuiUnCjo2RZPiT5q0WRAyZsL2HI5xLs+k3lJjdR6rRtxE6XrKASwgUzzaPQzXpsbOPaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 563861FB;
	Tue, 23 Jan 2024 09:15:15 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E84063F5A1;
	Tue, 23 Jan 2024 09:14:28 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Yang Shi <shy828301@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] mm: thp_get_unmapped_area must honour topdown preference
Date: Tue, 23 Jan 2024 17:14:20 +0000
Message-Id: <20240123171420.3970220-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The addition of commit efa7df3e3bb5 ("mm: align larger anonymous
mappings on THP boundaries") caused the "virtual_address_range" mm
selftest to start failing on arm64. Let's fix that regression.

There were 2 visible problems when running the test; 1) it takes much
longer to execute, and 2) the test fails. Both are related:

The (first part of the) test allocates as many 1GB anonymous blocks as
it can in the low 256TB of address space, passing NULL as the addr hint
to mmap. Before the faulty patch, all allocations were abutted and
contained in a single, merged VMA. However, after this patch, each
allocation is in its own VMA, and there is a 2M gap between each VMA.
This causes the 2 problems in the test: 1) mmap becomes MUCH slower
because there are so many VMAs to check to find a new 1G gap. 2) mmap
fails once it hits the VMA limit (/proc/sys/vm/max_map_count). Hitting
this limit then causes a subsequent calloc() to fail, which causes the
test to fail.

The problem is that arm64 (unlike x86) selects
ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT. But __thp_get_unmapped_area()
allocates len+2M then always aligns to the bottom of the discovered gap.
That causes the 2M hole.

Fix this by detecting cases where we can still achive the alignment goal
when moved to the top of the allocated area, if configured to prefer
top-down allocation.

While we are at it, fix thp_get_unmapped_area's use of pgoff, which
should always be zero for anonymous mappings. Prior to the faulty
change, while it was possible for user space to pass in pgoff!=0, the
old mm->get_unmapped_area() handler would not use it.
thp_get_unmapped_area() does use it, so let's explicitly zero it before
calling the handler. This should also be the correct behavior for arches
that define their own get_unmapped_area() handler.

Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
Closes: https://lore.kernel.org/linux-mm/1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com/
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

Applies on top of v6.8-rc1. Would be good to get this into the next -rc.

Thanks,
Ryan

 mm/huge_memory.c | 10 ++++++++--
 mm/mmap.c        |  6 ++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94ef5c02b459..8c66f88e71e9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -809,7 +809,7 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 {
 	loff_t off_end = off + len;
 	loff_t off_align = round_up(off, size);
-	unsigned long len_pad, ret;
+	unsigned long len_pad, ret, off_sub;

 	if (off_end <= off_align || (off_end - off_align) < size)
 		return 0;
@@ -835,7 +835,13 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 	if (ret == addr)
 		return addr;

-	ret += (off - ret) & (size - 1);
+	off_sub = (off - ret) & (size - 1);
+
+	if (current->mm->get_unmapped_area == arch_get_unmapped_area_topdown &&
+	    !off_sub)
+		return ret + size;
+
+	ret += off_sub;
 	return ret;
 }

diff --git a/mm/mmap.c b/mm/mmap.c
index b78e83d351d2..d89770eaab6b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1825,15 +1825,17 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		/*
 		 * mmap_region() will call shmem_zero_setup() to create a file,
 		 * so use shmem's get_unmapped_area in case it can be huge.
-		 * do_mmap() will clear pgoff, so match alignment.
 		 */
-		pgoff = 0;
 		get_area = shmem_get_unmapped_area;
 	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 		/* Ensures that larger anonymous mappings are THP aligned. */
 		get_area = thp_get_unmapped_area;
 	}

+	/* Always treat pgoff as zero for anonymous memory. */
+	if (!file)
+		pgoff = 0;
+
 	addr = get_area(file, addr, len, pgoff, flags);
 	if (IS_ERR_VALUE(addr))
 		return addr;
--
2.25.1


