Return-Path: <linux-kernel+bounces-148657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBFD8A85A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221BC28203C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E0A1411DC;
	Wed, 17 Apr 2024 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLxrC3NH"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C091411C3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363094; cv=none; b=IcgAXUL1MA0Dk0DSv+U6xg8ihcC6KxTzBc9Op+Drgwl/f6ur4SeOHcQLc/sNEdCeH7HWBnIjTeVHgPyx44y8MVv55BDG3g5SUm4DzChmLdym6GPzg42k+SxgNvj/4lH5d5WtoznAoQMqb0saOkFyTQv1/JEvIBvUi01htCnkOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363094; c=relaxed/simple;
	bh=WAkUwDCazUflR68F3S1NAKD6oDa/XvjFSCJtt+0KndM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B1ebNZYE6VbFo1uSqTIrgTq0+D46Yc9naov2gnVEDDceXSikHflnrEF945YtigPhYRk1FG8BNvvTAzL4k9mv2VRUL4cF2R7IaeLBHUfR/eYB6q534N9y4Ebe/gw57qvgzbSZyViLGgU7PKpbNTq7bad/ON0ai2FvQ89e/kE74xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLxrC3NH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e2178b2cf2so51001555ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713363092; x=1713967892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WOyzFWDhjtqDpZ8eiPXvRnBmlOv37Y/sWaQ3gyeQkVE=;
        b=GLxrC3NHbzt44/FU0L8Gn1IR7sOJFebiJJovKvIK2WBx4+d439l+JYetBogrYQOhwF
         RQ3SNRiEpJzMF1wR4dgu5cp8Fw+BEA86kf/WSYG9KB+opySSErfQzM9eCWoWACS5KNNz
         r/SXIGL+rTabfKnH42CBQ3oh5L83W1IEOOziDwg1vlyXQbpjPmFjINkU8IJ+3FnHt4J8
         9Z6UJ4vpLZtup+g/D8/TwC1rfudpHAXmy28xfs5ZevMkTuiohmy39DrxXOv9TTm2YFMb
         mVPZllx9KPhPgwouZHl/0FfoAANWH0mZK08JvBqKq0qwosFTjm/Gsp6Eg6NFIJKvdpKz
         Pg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713363092; x=1713967892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOyzFWDhjtqDpZ8eiPXvRnBmlOv37Y/sWaQ3gyeQkVE=;
        b=rplmrwnC2CP6thnloJHCH+CUZjWPqWAQL8xwK61cFq9aJKWm98E0KStefkmCjwWCVF
         80NitYNZ1HA+gqFTJKHNZXhOpDF0EsBVLo5oI2V/sj8WHgyCrXJ8e8YtGmv94uEmPg2K
         BKi2EAx294FmtPQeEjU//HE+0gRZLetweLQ/tyltJeY4ZwcdLUWokXmQfXk5L0BsafUL
         PCKTBt8wwxkcZleOjXRvlmIfBGIq7hFgmWOq6jArUlAi/4KGpAlvcBieTwkJP6pBF4Im
         fXimRlLVsaEZvLb8LLkcpnw4YMRWxIv6Oqf68fN6njiROf1k7SUDCznZ8F7ip6Q7x9PC
         kEDw==
X-Forwarded-Encrypted: i=1; AJvYcCUQME3vqbp6BZ6otmTKs/C/yNPaB0tdvcTdNlRbpeRMVGX/6Lsrn4JEoTXMy76sJeplUFGuJLn05OWTGjfKlhTMQM1mKLSawfSFNuJ9
X-Gm-Message-State: AOJu0YzvuIoZabQsK1sBnhSYmdq0IPyL04oKmb5DWyfEPwxbWfajbcYS
	6nAq8tHb9nUti9bb5TD14EEYkQ5syq+LVwdFN4GinhKJALV1eYGR
X-Google-Smtp-Source: AGHT+IET3LK55hdttEvsXHzIZ5l9WR+u3/sJNRuAzlaYshciPv8sL0N3ZYenqgEV4MTlku+xLcvGhg==
X-Received: by 2002:a17:902:a705:b0:1de:e47e:116c with SMTP id w5-20020a170902a70500b001dee47e116cmr14382321plq.39.1713363092309;
        Wed, 17 Apr 2024 07:11:32 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id bi5-20020a170902bf0500b001e3e0a6e76csm11542318plb.99.2024.04.17.07.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:11:31 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	maskray@google.com,
	ziy@nvidia.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH 1/1] mm/vmscan: avoid split PMD-mapped THP during shrink_folio_list()
Date: Wed, 17 Apr 2024 22:11:11 +0800
Message-Id: <20240417141111.77855-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the user no longer requires the pages, they would use madvise(madv_free)
to mark the pages as lazy free. IMO, they would not typically rewrite to the
given range.

At present, a PMD-mapped THP marked as lazyfree during shrink_folio_list()
is unconditionally split, which may be unnecessary. If the THP is exclusively
mapped and clean, and the PMD associated with it is also clean, then we can
attempt to remove the PMD mapping from it. This change will improve the
efficiency of memory reclamation in this case.

On an Intel i5 CPU, reclaiming 1GiB of PMD-mapped THPs using
mem_cgroup_force_empty() results in the following runtimes in seconds
(shorter is better):

--------------------------------------------
|     Old       |      New       |  Change  |
--------------------------------------------
|   0.683426    |    0.049197    |  -92.80% |
--------------------------------------------

Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/huge_mm.h |  1 +
 include/linux/rmap.h    |  1 +
 mm/huge_memory.c        |  2 +-
 mm/rmap.c               | 81 +++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c             |  7 ++++
 5 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7cd07b83a3d0..02a71c05f68a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -36,6 +36,7 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
 		    unsigned long cp_flags);
+inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd);
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0f906dc6d280..8c2f45713351 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -100,6 +100,7 @@ enum ttu_flags {
 					 * do a final flush if necessary */
 	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
 					 * caller holds it */
+	TTU_LAZYFREE_THP	= 0x100, /* avoid split PMD-mapped THP */
 };
 
 #ifdef CONFIG_MMU
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 58f2c4745d80..309fba9624c2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1801,7 +1801,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	return ret;
 }
 
-static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
+inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
 {
 	pgtable_t pgtable;
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 2608c40dffad..4994f9e402d4 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -77,6 +77,7 @@
 #include <linux/mm_inline.h>
 
 #include <asm/tlbflush.h>
+#include <asm/tlb.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/tlb.h>
@@ -1606,6 +1607,80 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+static bool __try_to_unmap_lazyfree_thp(struct vm_area_struct *vma,
+					     unsigned long address,
+					     struct folio *folio)
+{
+	spinlock_t *ptl;
+	pmd_t *pmdp, orig_pmd;
+	struct mmu_notifier_range range;
+	struct mmu_gather tlb;
+	struct mm_struct *mm = vma->vm_mm;
+	struct page *page;
+	bool ret = false;
+
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+	VM_WARN_ON_FOLIO(folio_test_swapbacked(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
+
+	/*
+	 * If we encounter a PMD-mapped THP that marked as lazyfree, we
+	 * will try to unmap it without splitting.
+	 *
+	 * The folio exclusively mapped should only have two refs:
+	 * one from the isolation and one from the rmap.
+	 */
+	if (folio_entire_mapcount(folio) != 1 || folio_test_dirty(folio) ||
+	    folio_ref_count(folio) != 2)
+		return false;
+
+	pmdp = mm_find_pmd(mm, address);
+	if (unlikely(!pmdp))
+		return false;
+	if (pmd_dirty(*pmdp))
+		return false;
+
+	tlb_gather_mmu(&tlb, mm);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
+				address & HPAGE_PMD_MASK,
+				(address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+
+	ptl = pmd_lock(mm, pmdp);
+	orig_pmd = *pmdp;
+	if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd)))
+		goto out;
+
+	page = pmd_page(orig_pmd);
+	if (unlikely(page_folio(page) != folio))
+		goto out;
+
+	orig_pmd = pmdp_huge_get_and_clear(mm, address, pmdp);
+	tlb_remove_pmd_tlb_entry(&tlb, pmdp, address);
+	/*
+	 * There is a race between the first check of the dirty bit
+	 * for the PMD and the TLB entry flush. If the PMD is re-dirty
+	 * at this point, we will return to try_to_unmap_one() to call
+	 * split_huge_pmd_address() to split it.
+	 */
+	if (pmd_dirty(orig_pmd))
+		set_pmd_at(mm, address, pmdp, orig_pmd);
+	else {
+		folio_remove_rmap_pmd(folio, page, vma);
+		zap_deposited_table(mm, pmdp);
+		add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
+		folio_put(folio);
+		ret = true;
+	}
+
+out:
+	spin_unlock(ptl);
+	mmu_notifier_invalidate_range_end(&range);
+
+	return ret;
+}
+
 /*
  * @arg: enum ttu_flags will be passed to this argument
  */
@@ -1631,6 +1706,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	if (flags & TTU_SYNC)
 		pvmw.flags = PVMW_SYNC;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (flags & TTU_LAZYFREE_THP)
+		if (__try_to_unmap_lazyfree_thp(vma, address, folio))
+			return true;
+#endif
+
 	if (flags & TTU_SPLIT_HUGE_PMD)
 		split_huge_pmd_address(vma, address, false, folio);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 49bd94423961..2358b1cff8bf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1277,6 +1277,13 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 			if (folio_test_pmd_mappable(folio))
 				flags |= TTU_SPLIT_HUGE_PMD;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			if (folio_test_anon(folio) && !was_swapbacked &&
+			    flags & TTU_SPLIT_HUGE_PMD)
+				flags |= TTU_LAZYFREE_THP;
+#endif
+
 			/*
 			 * Without TTU_SYNC, try_to_unmap will only begin to
 			 * hold PTL from the first present PTE within a large
-- 
2.33.1


