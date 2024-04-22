Return-Path: <linux-kernel+bounces-152762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73A68AC3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED63280D90
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEFD18645;
	Mon, 22 Apr 2024 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msK2pxjM"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A73A1862F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713765190; cv=none; b=ORAl68xmPeAbW4Fq9hjUkrQiw4U71qhE488hvAxW1LoDYV87jIe0sc5sHszjjYrPa+2bo1zQ7HJfd7Fo9Af7BMUE2SmNeTZC5e0Y3ULOV530foTI/RAyMsN2EPMiNdRn4DRoNjsBJzDF8gWrLI7fZOia6BBxpwUSGLWbFHDLKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713765190; c=relaxed/simple;
	bh=dnx0WYtiQseJRSCGKExzZP8MBF6Gal7CVn6PZmQbVL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X7sGphFSao/vwXRIwLJlDz/0pAmhjYDMQSGww6Te+1U/ZdKx9S1eLcm9/7b+uyL+MnOBIzmWftJqNKj8GS+0fKn/qs6goXTmao0+SVQA2pWVjP9/2ttJrdyIbeOTARnqVO7EMwceWJzvQTCW8/6Tpc2w18DrSI6XHZs39frWWhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msK2pxjM; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c74ff209f6so1285527b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 22:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713765188; x=1714369988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANRmJnAxIwQezObQ0dI8wX/f7ITBK7dK8gAwvMFlXEE=;
        b=msK2pxjMA4llY0H0iIOmaj4fL35M/SzPkJ3yRq/kFM0T5XjZg8ybrE3hJ4aKosTH18
         qspnHCj91Appdtwvs4O6AT7r3/j6eAwQnUvWPq87byeh7aQpIIQF62R9lxtotD98bNIs
         coxfJ75LwV7z3MIh35VCkXbO94uIT6qK+hSrgGhhl4kpHYp2DZFp889OLmtgybHYH7NF
         x7EJgG1S9em3E84SXl5Qf15167kwK1lVYBijmBrmWpkvS6Xg9zaSmfadFIEkivTCCxBf
         jDlpLaEk+tgJgZMx6Fmg3XhwbFx8tj7UTKBA9LHfdhL2N9UL09nnRBwAZlOYUzVDzIQ2
         eXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713765188; x=1714369988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANRmJnAxIwQezObQ0dI8wX/f7ITBK7dK8gAwvMFlXEE=;
        b=bm0jIOUlPJ+wewLnxbCexGEh0QnV/XXSDh9Ec9lvyBMY0vuqn4tjGc/cu4oh8bqu0p
         0ieTm6pMbfNlPxmedEMZPQeVmRuwuX65PLqAtYkhifzkJlMFBIiwxRe1uttj0UMz71Pc
         ZP9ztvoVUu3F3j1IUPWGl4+Jv+rM5AZUBBd2bV0zI2asjcPGi5Ha5N9hRbOSiUveOsA4
         BjEq9hpJDedf74i0sYMF4hpl3fXP7SdiPhBR6bgoTvNHIMFwfek3ueq/1qnFpC6ok/ay
         jAXWhQ/B1X54OWfgDJCj8b5j29Om+RpcmplGun88aSkoUS8lqmqDPBpHzAhuMIjE3P5u
         H0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjmkS/Tc7rECzyRyHzggG0ifrxGhBD26xHjgNtI42rHG9bM5RzK231QuUYpnKcsPGTuwpurSTIvSuuwSCTKpkjlHEFX+LxNnE+5D6/
X-Gm-Message-State: AOJu0YxBnMwnShFJgnZPVwX4/5UQXBX65MVLnOwJghnzydNgN49mDZZm
	jtt6DJ+H6lN91kCdUC+NIe0xHlDRqFBpCSyk+shWQU0lZ03ngz92
X-Google-Smtp-Source: AGHT+IFCKr+EDfn2W3NT7eXCuWDO7acGSq4KTmc8e2yJzNF19TulYYrOAc2+O4d0o09+SEDQQMmpfA==
X-Received: by 2002:a05:6808:124a:b0:3c7:51f:156c with SMTP id o10-20020a056808124a00b003c7051f156cmr12931072oiv.29.1713765188129;
        Sun, 21 Apr 2024 22:53:08 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id i6-20020aa787c6000000b006e6b52eb59asm7020927pfo.126.2024.04.21.22.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 22:53:07 -0700 (PDT)
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
Subject: [PATCH v2 1/1] mm/vmscan: avoid split PMD-mapped THP during shrink_folio_list()
Date: Mon, 22 Apr 2024 13:52:13 +0800
Message-Id: <20240422055213.60231-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the user no longer requires the pages, they would use
madvise(MADV_FREE) to mark the pages as lazy free. IMO, they would not
typically rewrite to the given range.

At present, PMD-mapped THPs that are marked as lazyfree during
shrink_folio_list() are unconditionally split, which may be unnecessary.
If the THP is clean, its PMD is also clean, and there are no unexpected
references, then we can attempt to remove the PMD mapping from it. This
change will improve the efficiency of memory reclamation in this case.

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
v1 -> v2:
 - Update the changelog
 - Follow the exact same logic as in try_to_unmap_one() (per David Hildenbrand)
 - Remove the extra code from rmap.c (per Matthew Wilcox)
 - https://lore.kernel.org/linux-mm/20240417141111.77855-1-ioworker0@gmail.com

 include/linux/huge_mm.h |  2 +
 include/linux/rmap.h    |  2 +
 mm/huge_memory.c        | 88 +++++++++++++++++++++++++++++++++++++++++
 mm/rmap.c               |  6 +++
 mm/vmscan.c             |  7 ++++
 5 files changed, 105 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7cd07b83a3d0..56c7ea73090b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -36,6 +36,8 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
 		    unsigned long cp_flags);
+bool discard_trans_pmd(struct vm_area_struct *vma, unsigned long addr,
+		       struct folio *folio);
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0f906dc6d280..670218f762c8 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -100,6 +100,8 @@ enum ttu_flags {
 					 * do a final flush if necessary */
 	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
 					 * caller holds it */
+	TTU_LAZYFREE_THP	= 0x100, /* avoid splitting PMD-mapped THPs
+					  * that are marked as lazyfree. */
 };
 
 #ifdef CONFIG_MMU
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 824eff9211db..63de1445feab 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1810,6 +1810,94 @@ static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
 	mm_dec_nr_ptes(mm);
 }
 
+bool discard_trans_pmd(struct vm_area_struct *vma, unsigned long addr,
+		       struct folio *folio)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_notifier_range range;
+	int ref_count, map_count;
+	struct mmu_gather tlb;
+	pmd_t *pmdp, orig_pmd;
+	struct page *page;
+	bool ret = false;
+	spinlock_t *ptl;
+
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_FOLIO(folio_test_swapbacked(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
+
+	/* Perform best-effort early checks before acquiring the PMD lock */
+	if (folio_ref_count(folio) != folio_mapcount(folio) + 1 ||
+	    folio_test_dirty(folio))
+		return false;
+
+	pmdp = mm_find_pmd(mm, addr);
+	if (unlikely(!pmdp))
+		return false;
+	if (pmd_dirty(*pmdp))
+		return false;
+
+	tlb_gather_mmu(&tlb, mm);
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
+				addr & HPAGE_PMD_MASK,
+				(addr & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE);
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
+	orig_pmd = pmdp_huge_get_and_clear(mm, addr, pmdp);
+	tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);
+
+	/*
+	 * Syncing against concurrent GUP-fast:
+	 * - clear PMD; barrier; read refcount
+	 * - inc refcount; barrier; read PMD
+	 */
+	smp_mb();
+
+	ref_count = folio_ref_count(folio);
+	map_count = folio_mapcount(folio);
+
+	/*
+	 * Order reads for folio refcount and dirty flag
+	 * (see comments in __remove_mapping()).
+	 */
+	smp_rmb();
+
+	/*
+	 * If the PMD or folio is redirtied at this point, or if there are
+	 * unexpected references, we will give up to discard this folio
+	 * and remap it.
+	 *
+	 * The only folio refs must be one from isolation plus the rmap(s).
+	 */
+	if (ref_count != map_count + 1 || folio_test_dirty(folio) ||
+	    pmd_dirty(orig_pmd)) {
+		set_pmd_at(mm, addr, pmdp, orig_pmd);
+		goto out;
+	}
+
+	folio_remove_rmap_pmd(folio, page, vma);
+	zap_deposited_table(mm, pmdp);
+	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
+	folio_put(folio);
+	ret = true;
+
+out:
+	spin_unlock(ptl);
+	mmu_notifier_invalidate_range_end(&range);
+
+	return ret;
+}
+
 int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 pmd_t *pmd, unsigned long addr)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index 2608c40dffad..a7913a454028 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1631,6 +1631,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	if (flags & TTU_SYNC)
 		pvmw.flags = PVMW_SYNC;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (flags & TTU_LAZYFREE_THP)
+		if (discard_trans_pmd(vma, address, folio))
+			return true;
+#endif
+
 	if (flags & TTU_SPLIT_HUGE_PMD)
 		split_huge_pmd_address(vma, address, false, folio);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 49bd94423961..e2686cc0c037 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1277,6 +1277,13 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 			if (folio_test_pmd_mappable(folio))
 				flags |= TTU_SPLIT_HUGE_PMD;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			if (folio_test_anon(folio) && !was_swapbacked &&
+			    (flags & TTU_SPLIT_HUGE_PMD))
+				flags |= TTU_LAZYFREE_THP;
+#endif
+
 			/*
 			 * Without TTU_SYNC, try_to_unmap will only begin to
 			 * hold PTL from the first present PTE within a large
-- 
2.33.1


