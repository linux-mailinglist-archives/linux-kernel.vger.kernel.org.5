Return-Path: <linux-kernel+bounces-28523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4782FFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C471AB2407E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B556AD6;
	Wed, 17 Jan 2024 05:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTX7gLJU"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C76119
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 05:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705467752; cv=none; b=TUK/uKEO1+oXIqi0UagUHbhba8DxT+HD1AJ0y0gf4xE4Ws7QuWfWBkdFhzZ40PGMbqaykvaKw7R07n7ctdNuCtRr4D1PCdcqUFzA7iJxU56DOl80sol4vPEB8wMfdMgaqct3KRQuGbCKOvE+bP6F4sxzx7FqnJuRU4JDBrzJh9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705467752; c=relaxed/simple;
	bh=IgApnOrZlunFElQRj5rnb7BNeFgvxtu7LY//05yPmO8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=Cx4DrIUqqWWtzZgqtOsMfHwnHUXgMTdjN/lxXHlAKNDgjpHhIcEg8nvfNjLnbHVDGZic1/4H0EWO1i51enVfEWDU1UBy7Uq/zrnTVtM0BY3noUSxxChTfo+8e4jBWNlee7Uv9Dy+t+Y9iQB+GZxEYsU8tFUxsJ8jbCor5LP9aHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTX7gLJU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9344f30caso7148196b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705467750; x=1706072550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h2SD/ZB9hyvxmELXiJlpaJswjBRbcf9qVmQmE+9c0FM=;
        b=dTX7gLJUkoHj7sz0ISI0k7QnO+OA+X1EQMpupAnLACU0V0WEFXevMEdhAQBFmPlMMX
         HGuUwU0JYzg2eWqLSkqgQBLQeryKVbd2PwJiDulJeTLypstvMx2jY4WbnRZEH/pHZ4+1
         xkCH7GX5lYiFyQmM1vCriKxwoMe4qWW7xeUUdt52MR1+58n41cau5TBxaD0UaZ4go33S
         ZK1IphAVb5/8+9dJrzghYScU7+COAmocyspFOWVY28q2OhFHv5ovbWrC3l5zij2hE0O3
         hO9lRDxm9mKzYeVmgDXqhTnfKqGMcouR0M5Dpre7b8gxsuCIrggviK9sMOMlw5Z5I/f3
         GVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705467750; x=1706072550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2SD/ZB9hyvxmELXiJlpaJswjBRbcf9qVmQmE+9c0FM=;
        b=XoOPDwUOa4Z3S+g0bJ0iUyanrtlTkmmBFvIR3UXkitOmh19GCP0PpAIH9Bxh35tdq0
         kYfi/anVxXfFbLTJOqvUuuum1trI3PlA0UWwpJLE+uRq5E70yYuZ7Jw2Qad/8BYKcE/b
         qfjwlwR20qgoTFWnfJJQOXwEdittYvCxNQbeKSUOdhuBUsM1ZXC8UZhcs4YnTQsUFuPI
         mmzuQBmIBPmgShVf+VsSnNdCqmiowuFLqNtuuMKUu4MEhmBXBi0mvIhj0DG0UQq+XzaS
         rqAqR2s5UMrGbwNrTnghQ+NWHAdV/5VvrBjymH0OT6c1NwHwSLyPF4BvDtsfQlG1K7KH
         kEAQ==
X-Gm-Message-State: AOJu0YwQ5h+Eiqeqx07qvZ3rIaaH3KX7U2FTh9elIG2sXmfppZc7lqey
	cfwgieOs8BPtS+7NUldti+Fn7YQc9TDlO81113WUXLk34ZSeyH7S
X-Google-Smtp-Source: AGHT+IHcKAqQvampqci54cc3hmGnGsP4UOJ5frDjQzMW+NmxUhvBgsSiOlM+LDxCyB4qu67WXnYG8Q==
X-Received: by 2002:a05:6a20:6f02:b0:19b:68d6:47eb with SMTP id gt2-20020a056a206f0200b0019b68d647ebmr452478pzb.12.1705467750190;
        Tue, 16 Jan 2024 21:02:30 -0800 (PST)
Received: from LancedeMBP.lan ([112.10.240.24])
        by smtp.gmail.com with ESMTPSA id i63-20020a638742000000b005b458aa0541sm10751495pge.15.2024.01.16.21.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 21:02:29 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: zokeefe@google.com,
	songmuchun@bytedance.com,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v1 1/2] mm/madvise: introduce MADV_TRY_COLLAPSE for attempted synchronous hugepage collapse
Date: Wed, 17 Jan 2024 13:02:16 +0800
Message-Id: <20240117050217.43610-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This idea was inspired by MADV_COLLAPSE introduced by Zach O'Keefe[1].

Introduce a new madvise mode, MADV_TRY_COLLAPSE, that allows users to
make a least-effort attempt at a synchronous collapse of memory at
their own expense.

The only difference from MADV_COLLAPSE is that the new hugepage allocation
avoids direct reclaim and/or compaction, quickly failing on allocation errors.

The benefits of this approach are:

* CPU is charged to the process that wants to spend the cycles for the THP
* Avoid unpredictable timing of khugepaged collapse
* Prevent unpredictable stalls caused by direct reclaim and/or compaction

Semantics

This call is independent of the system-wide THP sysfs settings, but will
fail for memory marked VM_NOHUGEPAGE.  If the ranges provided span
multiple VMAs, the semantics of the collapse over each VMA is independent
from the others.  This implies a hugepage cannot cross a VMA boundary.  If
collapse of a given hugepage-aligned/sized region fails, the operation may
continue to attempt collapsing the remainder of memory specified.

The memory ranges provided must be page-aligned, but are not required to
be hugepage-aligned.  If the memory ranges are not hugepage-aligned, the
start/end of the range will be clamped to the first/last hugepage-aligned
address covered by said range.  The memory ranges must span at least one
hugepage-sized region.

All non-resident pages covered by the range will first be
swapped/faulted-in, before being internally copied onto a freshly
allocated hugepage.  Unmapped pages will have their data directly
initialized to 0 in the new hugepage.  However, for every eligible
hugepage aligned/sized region to-be collapsed, at least one page must
currently be backed by memory (a PMD covering the address range must
already exist).

Allocation for the new hugepage will not enter direct reclaim and/or
compaction, quickly failing if allocation fails. When the system has
multiple NUMA nodes, the hugepage will be allocated from the node providing
the most native pages. This operation operates on the current state of the
specified process and makes no persistent changes or guarantees on how pages
will be mapped, constructed, or faulted in the future.

Return Value

If all hugepage-sized/aligned regions covered by the provided range were
either successfully collapsed, or were already PMD-mapped THPs, this
operation will be deemed successful.  On success, madvise(2) returns 0.
Else, -1 is returned and errno is set to indicate the error for the
most-recently attempted hugepage collapse.  Note that many failures might
have occurred, since the operation may continue to collapse in the event a
single hugepage-sized/aligned region fails.

        ENOMEM  Memory allocation failed or VMA not found
        EBUSY   Memcg charging failed
        EAGAIN  Required resource temporarily unavailable.  Try again
                might succeed.
        EINVAL  Other error: No PMD found, subpage doesn't have Present
                bit set, "Special" page no backed by struct page, VMA
                incorrectly sized, address not page-aligned, ...

Use Cases

An immediate user of this new functionality is the Go runtime heap allocator
that manages memory in hugepage-sized chunks. In the past, whether it was a
newly allocated chunk through mmap() or a reused chunk released by
madvise(MADV_DONTNEED), the allocator attempted to eagerly back memory with
huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPSE)[3]
respectively. However, both approaches resulted in performance issues; for
both scenarios, there could be entries into direct reclaim and/or compaction,
leading to unpredictable stalls[4]. Now, the allocator can confidently use
madvise(MADV_TRY_COLLAPSE) to attempt the allocation of huge pages.

[1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec56404faca29a82689c77
[2] https://github.com/golang/go/commit/8fa9e3beee8b0e6baa7333740996181268b60a3a
[3] https://github.com/golang/go/commit/9f9bb26880388c5bead158e9eca3be4b3a9bd2af
[4] https://github.com/golang/go/issues/63334
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 arch/alpha/include/uapi/asm/mman.h           |  1 +
 arch/mips/include/uapi/asm/mman.h            |  1 +
 arch/parisc/include/uapi/asm/mman.h          |  1 +
 arch/xtensa/include/uapi/asm/mman.h          |  1 +
 include/linux/huge_mm.h                      |  5 +++--
 include/uapi/asm-generic/mman-common.h       |  1 +
 mm/khugepaged.c                              | 19 ++++++++++++++++---
 mm/madvise.c                                 |  8 +++++++-
 tools/include/uapi/asm-generic/mman-common.h |  1 +
 9 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 763929e814e9..44aa1f57a982 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -77,6 +77,7 @@
 #define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
+#define MADV_TRY_COLLAPSE	26	/* Similar to COLLAPSE, but avoids direct reclaim and/or compaction */
 
 /* compatibility flags */
 #define MAP_FILE	0
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index c6e1fc77c996..1ae16e5d7dfc 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -104,6 +104,7 @@
 #define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
+#define MADV_TRY_COLLAPSE	26	/* Similar to COLLAPSE, but avoids direct reclaim and/or compaction */
 
 /* compatibility flags */
 #define MAP_FILE	0
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 68c44f99bc93..f8d016ee1f98 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -71,6 +71,7 @@
 #define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
+#define MADV_TRY_COLLAPSE	26	/* Similar to COLLAPSE, but avoids direct reclaim and/or compaction */
 
 #define MADV_HWPOISON     100		/* poison a page for testing */
 #define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index 1ff0c858544f..c495d1b39c83 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -112,6 +112,7 @@
 #define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
+#define MADV_TRY_COLLAPSE	26	/* Similar to COLLAPSE, but avoids direct reclaim and/or compaction */
 
 /* compatibility flags */
 #define MAP_FILE	0
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5adb86af35fc..e1af75aa18fb 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -303,7 +303,7 @@ int hugepage_madvise(struct vm_area_struct *vma, unsigned long *vm_flags,
 		     int advice);
 int madvise_collapse(struct vm_area_struct *vma,
 		     struct vm_area_struct **prev,
-		     unsigned long start, unsigned long end);
+		     unsigned long start, unsigned long end, bool is_try);
 void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long start,
 			   unsigned long end, long adjust_next);
 spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma);
@@ -450,7 +450,8 @@ static inline int hugepage_madvise(struct vm_area_struct *vma,
 
 static inline int madvise_collapse(struct vm_area_struct *vma,
 				   struct vm_area_struct **prev,
-				   unsigned long start, unsigned long end)
+				   unsigned long start, unsigned long end,
+				   bool is_try)
 {
 	return -EINVAL;
 }
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..a9e5273db5f6 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -78,6 +78,7 @@
 #define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
+#define MADV_TRY_COLLAPSE	26	/* Similar to COLLAPSE, but avoids direct reclaim and/or compaction */
 
 /* compatibility flags */
 #define MAP_FILE	0
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2b219acb528e..c22703155b6e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -96,6 +96,7 @@ static struct kmem_cache *mm_slot_cache __ro_after_init;
 
 struct collapse_control {
 	bool is_khugepaged;
+	bool is_try;
 
 	/* Num pages scanned per node */
 	u32 node_load[MAX_NUMNODES];
@@ -1058,10 +1059,14 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
 			      struct collapse_control *cc)
 {
-	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
-		     GFP_TRANSHUGE);
 	int node = hpage_collapse_find_target_node(cc);
 	struct folio *folio;
+	gfp_t gfp;
+
+	if (cc->is_khugepaged)
+		gfp = alloc_hugepage_khugepaged_gfpmask();
+	else
+		gfp = cc->is_try ? GFP_TRANSHUGE_LIGHT : GFP_TRANSHUGE;
 
 	if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_nmask)) {
 		*hpage = NULL;
@@ -2697,7 +2702,7 @@ static int madvise_collapse_errno(enum scan_result r)
 }
 
 int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
-		     unsigned long start, unsigned long end)
+		     unsigned long start, unsigned long end, bool is_try)
 {
 	struct collapse_control *cc;
 	struct mm_struct *mm = vma->vm_mm;
@@ -2718,6 +2723,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	if (!cc)
 		return -ENOMEM;
 	cc->is_khugepaged = false;
+	cc->is_try = is_try;
 
 	mmgrab(mm);
 	lru_add_drain_all();
@@ -2773,6 +2779,13 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 			result = collapse_pte_mapped_thp(mm, addr, true);
 			mmap_read_unlock(mm);
 			goto handle_result;
+		/* MADV_TRY_COLLAPSE: fail quickly */
+		case SCAN_ALLOC_HUGE_PAGE_FAIL:
+		case SCAN_CGROUP_CHARGE_FAIL:
+			if (cc->is_try) {
+				last_fail = result;
+				goto out_maybelock;
+			}
 		/* Whitelisted set of results where continuing OK */
 		case SCAN_PMD_NULL:
 		case SCAN_PTE_NON_PRESENT:
diff --git a/mm/madvise.c b/mm/madvise.c
index 912155a94ed5..5a359bcd286c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -60,6 +60,7 @@ static int madvise_need_mmap_write(int behavior)
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
 	case MADV_COLLAPSE:
+	case MADV_TRY_COLLAPSE:
 		return 0;
 	default:
 		/* be safe, default to 1. list exceptions explicitly */
@@ -1082,8 +1083,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		if (error)
 			goto out;
 		break;
+	case MADV_TRY_COLLAPSE:
+		return madvise_collapse(vma, prev, start, end, true);
 	case MADV_COLLAPSE:
-		return madvise_collapse(vma, prev, start, end);
+		return madvise_collapse(vma, prev, start, end, false);
 	}
 
 	anon_name = anon_vma_name(vma);
@@ -1178,6 +1181,7 @@ madvise_behavior_valid(int behavior)
 	case MADV_HUGEPAGE:
 	case MADV_NOHUGEPAGE:
 	case MADV_COLLAPSE:
+	case MADV_TRY_COLLAPSE:
 #endif
 	case MADV_DONTDUMP:
 	case MADV_DODUMP:
@@ -1368,6 +1372,8 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
  *		transparent huge pages so the existing pages will not be
  *		coalesced into THP and new pages will not be allocated as THP.
  *  MADV_COLLAPSE - synchronously coalesce pages into new THP.
+ *  MADV_TRY_COLLAPSE - similar to COLLAPSE, but avoids direct reclaim
+ *		and/or compaction.
  *  MADV_DONTDUMP - the application wants to prevent pages in the given range
  *		from being included in its core dump.
  *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..a9e5273db5f6 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -78,6 +78,7 @@
 #define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
+#define MADV_TRY_COLLAPSE	26	/* Similar to COLLAPSE, but avoids direct reclaim and/or compaction */
 
 /* compatibility flags */
 #define MAP_FILE	0
-- 
2.33.1


