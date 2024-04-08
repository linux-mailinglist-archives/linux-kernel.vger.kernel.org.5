Return-Path: <linux-kernel+bounces-134782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197BD89B6D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E08281A25
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CBF63AE;
	Mon,  8 Apr 2024 04:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhW3d4Ls"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0208D4C99
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 04:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712550300; cv=none; b=MUggI7S47RDfgXvLKx/SlV0+S3dTVCRRKFB1ykN91eCfpP5BYT8xQmYcPObDMTFmfhRPVpTWi9RjlGxsowEt1HlfbeX8JLgX+Po2cVprBvFXensdDYF03oZChKCXm2QGNZxCLc1uwVse5QwSIqtyvVx3JuH9ZKu9E3KO1OF/TZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712550300; c=relaxed/simple;
	bh=rrb7UodpYQZ+xSduh/JkbOfiJ7P1ZO2LYDamC0S+nVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZLl6pmQBPwhCfNnjhKgTnO+sepeJLXktFDHXDtrbZ7Uoy2a/OteTpBej/LE6qUG2gqCZIfvocvK9fU4wMzIxs/eKFbZsXy/26XiWPP/6YBn1sMNtafT+M/O9AT9SK3oGgIHzE2FtNYuxtZk0m3D7FFSlE3m3+8McJ2vHHIAWzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhW3d4Ls; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-221e1910c3bso2401193fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 21:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712550298; x=1713155098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oroWQXlDg9AflEXeqGQePfVQWizPK6mNCr8Aa/qNYjo=;
        b=AhW3d4LsYmx9o+IybnCHpUrQzfAbn4QRZs5nWuUzt1gx2XN7llPw9QapyTc3EerUx5
         yNheXZrwERTGuJzu/9XGPr4Da6zEAoWTPsGXp1F3ZtMFIpIKh9q1nBQWmFxP6+GAki0C
         7D6KVpIj+fSGPBxv8D8o1NnrxqcX6+ILInJSENUvqKNRMLnm8N8XmgGrXWa8wfPIPaCt
         zVBFpQCfvlEkZfHanWYMOAhUmwV3d1FbpxXlar0mqbf6LkNrTYXUJB0G3Mau2mH08MQL
         r2aDf6L9NEKu6YUSqSL6s/XL76+fvJOx3hAEH9LydhJckfkpbTwm938e1vkIiq/zvngi
         ZO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712550298; x=1713155098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oroWQXlDg9AflEXeqGQePfVQWizPK6mNCr8Aa/qNYjo=;
        b=PKmXdaUMbz/RQ7CPoTA71tb9Y6Sy6eKH1puT+/3St4BtrV1ukZHKjF2VrIQScQ5BfX
         O0M+Zdrdf8AODxROIixj5/Bqr3+ZX59dPJotZ/5pXKnnWPZBL5ecIk/dxtmTGg3qeiJQ
         ecCa+wznGUU2VVx8zcz8W7IdjXrAA0/ZJSUnTH3ncLy2f16QXbJURzAWVl1xIKzfVdc3
         BaT8MDjzm3geuYPgs3drt9T+3ME3ZLYNSBIoPR7TyWjz14bpntg3kuj5k0CJBQDK9COs
         oVeoT9RU9ldslbxSCn3KZM15swxRhLSATkdARN735R6qFRdCmc8Ye3GuG6zrW5ncJsAT
         MY4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCvNsGn8gZO9TQuNHmmATgX34V7MjW8gczI4VqqranUWht2I5Y2ArTEAPbWVSObGbbeKKHi8/0hbAb2X/JqIgS74YffBJ9dVB3y6D3
X-Gm-Message-State: AOJu0Yx6kbG2oGWoZFU78BWiptgj1xwqk2YvrpRqUDJ5e952eaMcwqjE
	lO3+/5lOYYQOgykSIyc7P6Qqtj40u5UOWvP4JWQD2RgDUu9TeT8B
X-Google-Smtp-Source: AGHT+IE3scd+wat1OlHnS4qTPnTZZAUaawzHkOTC4QsDjJKgI5Ib19QPA1D4Kw4obV7F7ntxrB3eAA==
X-Received: by 2002:a05:6870:1151:b0:22e:8a0c:ea26 with SMTP id 17-20020a056870115100b0022e8a0cea26mr6939786oag.44.1712550297985;
        Sun, 07 Apr 2024 21:24:57 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id p20-20020a056a000b5400b006eab6ac1f83sm5465628pfo.0.2024.04.07.21.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 21:24:57 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
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
Subject: [PATCH v5 1/2] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
Date: Mon,  8 Apr 2024 12:24:36 +0800
Message-Id: <20240408042437.10951-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240408042437.10951-1-ioworker0@gmail.com>
References: <20240408042437.10951-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
(Inspired by David Hildenbrand[2]). We aim to avoid unnecessary folio
splitting if the large folio is fully mapped within the target range.

If a large folio is locked or shared, or if we fail to split it, we just
leave it in place and advance to the next PTE in the range. But note that
the behavior is changed; previously, any failure of this sort would cause
the entire operation to give up. As large folios become more common,
sticking to the old way could result in wasted opportunities.

On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios of
the same size results in the following runtimes for madvise(MADV_FREE) in
seconds (shorter is better):

Folio Size |   Old    |   New    | Change
------------------------------------------
      4KiB | 0.590251 | 0.590259 |    0%
     16KiB | 2.990447 | 0.185655 |  -94%
     32KiB | 2.547831 | 0.104870 |  -95%
     64KiB | 2.457796 | 0.052812 |  -97%
    128KiB | 2.281034 | 0.032777 |  -99%
    256KiB | 2.230387 | 0.017496 |  -99%
    512KiB | 2.189106 | 0.010781 |  -99%
   1024KiB | 2.183949 | 0.007753 |  -99%
   2048KiB | 0.002799 | 0.002804 |    0%

[1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm.com
[2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redhat.com

Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/pgtable.h |  34 +++++++++
 mm/internal.h           |  12 +++-
 mm/madvise.c            | 149 ++++++++++++++++++++++------------------
 mm/memory.c             |   4 +-
 4 files changed, 129 insertions(+), 70 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 0f4b2faa1d71..4dd442787420 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -489,6 +489,40 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 }
 #endif
 
+#ifndef mkold_clean_ptes
+/**
+ * mkold_clean_ptes - Mark PTEs that map consecutive pages of the same folio
+ *		as old and clean.
+ * @mm: Address space the pages are mapped into.
+ * @addr: Address the first page is mapped at.
+ * @ptep: Page table pointer for the first entry.
+ * @nr: Number of entries to mark old and clean.
+ *
+ * May be overridden by the architecture; otherwise, implemented by
+ * get_and_clear/modify/set for each pte in the range.
+ *
+ * Note that PTE bits in the PTE range besides the PFN can differ. For example,
+ * some PTEs might be write-protected.
+ *
+ * Context: The caller holds the page table lock.  The PTEs map consecutive
+ * pages that belong to the same folio.  The PTEs are all in the same PMD.
+ */
+static inline void mkold_clean_ptes(struct mm_struct *mm, unsigned long addr,
+				    pte_t *ptep, unsigned int nr)
+{
+	pte_t pte;
+
+	for (;;) {
+		pte = ptep_get_and_clear(mm, addr, ptep);
+		set_pte_at(mm, addr, ptep, pte_mkclean(pte_mkold(pte)));
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+	}
+}
+#endif
+
 static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep)
 {
diff --git a/mm/internal.h b/mm/internal.h
index 57c1055d5568..792a9baf0d14 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -132,6 +132,8 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
  *		  first one is writable.
  * @any_young: Optional pointer to indicate whether any entry except the
  *		  first one is young.
+ * @any_dirty: Optional pointer to indicate whether any entry except the
+ *		  first one is dirty.
  *
  * Detect a PTE batch: consecutive (present) PTEs that map consecutive
  * pages of the same large folio.
@@ -147,18 +149,20 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
  */
 static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
-		bool *any_writable, bool *any_young)
+		bool *any_writable, bool *any_young, bool *any_dirty)
 {
 	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
 	const pte_t *end_ptep = start_ptep + max_nr;
 	pte_t expected_pte, *ptep;
-	bool writable, young;
+	bool writable, young, dirty;
 	int nr;
 
 	if (any_writable)
 		*any_writable = false;
 	if (any_young)
 		*any_young = false;
+	if (any_dirty)
+		*any_dirty = false;
 
 	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
 	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
@@ -174,6 +178,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 			writable = !!pte_write(pte);
 		if (any_young)
 			young = !!pte_young(pte);
+		if (any_dirty)
+			dirty = !!pte_dirty(pte);
 		pte = __pte_batch_clear_ignored(pte, flags);
 
 		if (!pte_same(pte, expected_pte))
@@ -191,6 +197,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 			*any_writable |= writable;
 		if (any_young)
 			*any_young |= young;
+		if (any_dirty)
+			*any_dirty |= dirty;
 
 		nr = pte_batch_hint(ptep, pte);
 		expected_pte = pte_advance_pfn(expected_pte, nr);
diff --git a/mm/madvise.c b/mm/madvise.c
index bf26cf2b7715..0777df2e3691 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -321,6 +321,39 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
+static inline int madvise_folio_pte_batch(unsigned long addr, unsigned long end,
+					  struct folio *folio, pte_t *ptep,
+					  pte_t pte, bool *any_young,
+					  bool *any_dirty)
+{
+	int max_nr = (end - addr) / PAGE_SIZE;
+	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
+
+	return folio_pte_batch(folio, addr, ptep, pte, max_nr, fpb_flags, NULL,
+			       any_young, any_dirty);
+}
+
+static inline bool madvise_pte_split_folio(struct mm_struct *mm, pmd_t *pmd,
+					   unsigned long addr,
+					   struct folio *folio, pte_t **pte,
+					   spinlock_t **ptl)
+{
+	int err;
+
+	if (!folio_trylock(folio))
+		return false;
+
+	folio_get(folio);
+	pte_unmap_unlock(*pte, *ptl);
+	err = split_folio(folio);
+	folio_unlock(folio);
+	folio_put(folio);
+
+	*pte = pte_offset_map_lock(mm, pmd, addr, ptl);
+
+	return err == 0;
+}
+
 static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct mm_walk *walk)
@@ -456,41 +489,29 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		 * next pte in the range.
 		 */
 		if (folio_test_large(folio)) {
-			const fpb_t fpb_flags = FPB_IGNORE_DIRTY |
-						FPB_IGNORE_SOFT_DIRTY;
-			int max_nr = (end - addr) / PAGE_SIZE;
 			bool any_young;
-
-			nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
-					     fpb_flags, NULL, &any_young);
-			if (any_young)
-				ptent = pte_mkyoung(ptent);
+			nr = madvise_folio_pte_batch(addr, end, folio, pte,
+						     ptent, &any_young, NULL);
 
 			if (nr < folio_nr_pages(folio)) {
-				int err;
-
 				if (folio_likely_mapped_shared(folio))
 					continue;
 				if (pageout_anon_only_filter && !folio_test_anon(folio))
 					continue;
-				if (!folio_trylock(folio))
-					continue;
-				folio_get(folio);
+
 				arch_leave_lazy_mmu_mode();
-				pte_unmap_unlock(start_pte, ptl);
-				start_pte = NULL;
-				err = split_folio(folio);
-				folio_unlock(folio);
-				folio_put(folio);
-				start_pte = pte =
-					pte_offset_map_lock(mm, pmd, addr, &ptl);
+				if (madvise_pte_split_folio(mm, pmd, addr,
+							    folio, &start_pte, &ptl))
+					nr = 0;
 				if (!start_pte)
 					break;
+				pte = start_pte;
 				arch_enter_lazy_mmu_mode();
-				if (!err)
-					nr = 0;
 				continue;
 			}
+
+			if (any_young)
+				ptent = pte_mkyoung(ptent);
 		}
 
 		/*
@@ -687,47 +708,54 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			continue;
 
 		/*
-		 * If pmd isn't transhuge but the folio is large and
-		 * is owned by only this process, split it and
-		 * deactivate all pages.
+		 * If we encounter a large folio, only split it if it is not
+		 * fully mapped within the range we are operating on. Otherwise
+		 * leave it as is so that it can be marked as lazyfree. If we
+		 * fail to split a folio, leave it in place and advance to the
+		 * next pte in the range.
 		 */
 		if (folio_test_large(folio)) {
-			int err;
+			bool any_young, any_dirty;
+			nr = madvise_folio_pte_batch(addr, end, folio, pte,
+						     ptent, &any_young, &any_dirty);
 
-			if (folio_likely_mapped_shared(folio))
-				break;
-			if (!folio_trylock(folio))
-				break;
-			folio_get(folio);
-			arch_leave_lazy_mmu_mode();
-			pte_unmap_unlock(start_pte, ptl);
-			start_pte = NULL;
-			err = split_folio(folio);
+			if (nr < folio_nr_pages(folio)) {
+				if (folio_likely_mapped_shared(folio))
+					continue;
+
+				arch_leave_lazy_mmu_mode();
+				if (madvise_pte_split_folio(mm, pmd, addr,
+							    folio, &start_pte, &ptl))
+					nr = 0;
+				if (!start_pte)
+					break;
+				pte = start_pte;
+				arch_enter_lazy_mmu_mode();
+				continue;
+			}
+
+			if (any_young)
+				ptent = pte_mkyoung(ptent);
+			if (any_dirty)
+				ptent = pte_mkdirty(ptent);
+		}
+
+		if (!folio_trylock(folio))
+			continue;
+		/*
+		 * If we have a large folio at this point, we know it is fully mapped
+		 * so if its mapcount is the same as its number of pages, it must be
+		 * exclusive.
+		 */
+		if (folio_mapcount(folio) != folio_nr_pages(folio)) {
 			folio_unlock(folio);
-			folio_put(folio);
-			if (err)
-				break;
-			start_pte = pte =
-				pte_offset_map_lock(mm, pmd, addr, &ptl);
-			if (!start_pte)
-				break;
-			arch_enter_lazy_mmu_mode();
-			pte--;
-			addr -= PAGE_SIZE;
 			continue;
 		}
+		folio_unlock(folio);
 
 		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
 			if (!folio_trylock(folio))
 				continue;
-			/*
-			 * If folio is shared with others, we mustn't clear
-			 * the folio's dirty flag.
-			 */
-			if (folio_mapcount(folio) != 1) {
-				folio_unlock(folio);
-				continue;
-			}
 
 			if (folio_test_swapcache(folio) &&
 			    !folio_free_swap(folio)) {
@@ -740,19 +768,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		}
 
 		if (pte_young(ptent) || pte_dirty(ptent)) {
-			/*
-			 * Some of architecture(ex, PPC) don't update TLB
-			 * with set_pte_at and tlb_remove_tlb_entry so for
-			 * the portability, remap the pte with old|clean
-			 * after pte clearing.
-			 */
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
-
-			ptent = pte_mkold(ptent);
-			ptent = pte_mkclean(ptent);
-			set_pte_at(mm, addr, pte, ptent);
-			tlb_remove_tlb_entry(tlb, pte, addr);
+			mkold_clean_ptes(mm, addr, pte, nr);
+			tlb_remove_tlb_entries(tlb, pte, nr, addr);
 		}
 		folio_mark_lazyfree(folio);
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 1723c8ddf9cb..fe9d4d64c627 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -989,7 +989,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 			flags |= FPB_IGNORE_SOFT_DIRTY;
 
 		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr, flags,
-				     &any_writable, NULL);
+				     &any_writable, NULL, NULL);
 		folio_ref_add(folio, nr);
 		if (folio_test_anon(folio)) {
 			if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,
@@ -1559,7 +1559,7 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
 	 */
 	if (unlikely(folio_test_large(folio) && max_nr != 1)) {
 		nr = folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_flags,
-				     NULL, NULL);
+				     NULL, NULL, NULL);
 
 		zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, nr,
 				       addr, details, rss, force_flush,
-- 
2.33.1


