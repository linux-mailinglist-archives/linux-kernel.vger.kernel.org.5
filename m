Return-Path: <linux-kernel+bounces-150194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A5B8A9B88
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1C3283873
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249511649D3;
	Thu, 18 Apr 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQeGm5C6"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F481649A7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447897; cv=none; b=U8K+P/fHEr8syUPTgEu/JiwL0LgyIHrCR3Q6HeQcWxz8vV3v3JoLL4DdRkj0tghx+Fot78LSXORRpy9nSrVJ69HoX3vcULi3CyW+0wA68onsOS1Csc1LkVIwYO2kVr3BFz6dtQi3OAT6EhWsn6uqszMvcu+r40HVJFIhWmMLJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447897; c=relaxed/simple;
	bh=TeV6kOnPwbJywIxNf+Gh2TXpm1wrP6kxlJyxKo6iva0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a/EFKk02rqKVTPnaHdLja21GMHAcjgHYFzuH9lUam985GGW/WY6ReT3HjJQVEjwtCVOfFpkHm1D3pIuqnZGvEGJ76DFR9uWuD7IhChFCs5tmPxQMWA68MZw9xGcaKNt9ech9VQcK1Ar+bCtzqkOrKqsRXD49xIjRn/kge6MS/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQeGm5C6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e65b29f703so7466445ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447895; x=1714052695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bptmvyfGYVn+izLGYKs1uKRCf7NdX4woHvJn9zQskE=;
        b=DQeGm5C6oBiGyuho9X5b3r/rOjx1hpBJ/Qh1LjAal7/pxo0krhU9wz4s5AldDdOxSb
         ZustjUZ+G1UoqG2cMUoSrG1H46aCPknw5xkr2vX6HW0n4vxGkMMhwaKLhxDsQ7Ltx0D9
         4NC99SGb2X6LfW3V1uY9DflcVE3LA10PlEO2fEMZvOZ79WWYdai8BvwL/DLZOk2YnVNy
         7axO4enxp6cpQxl/Pj383DrKtrfqz/l+OJYnHvqKeumxHrlEkaNBBLUNM9ZvOXnbjAjr
         i0ZuYBrLt1zEL2P7Hi8f/rFGEAfnFuzpmo9rg6w7H6JwJ1Z3aFUa7SucWhqF256fSEtW
         sFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447895; x=1714052695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bptmvyfGYVn+izLGYKs1uKRCf7NdX4woHvJn9zQskE=;
        b=UcJBeuKGlUVMtrOXjspqI2XeSJIk4fGNLgyRdH1xkrPO4y+/l51mQbznctzpXNGcnj
         9hw6A7yUnfGep54IZZX4OSo1i4JDZVm59fFCinUn7TwYVG+PIeH+FiqjZ6+g2TB1I1nh
         C4utGkXW0xjeoFbNXvvdaDEjqARLNlkUDzib53arSjF6LOivOb5B5UjupC5pJYDJ3o/5
         SOB0dHOKt47u7Q/CsaSsqF3QrEEsbNJwem5khUGx67PVoFXit7Rl/Kq9yd3az2KVzj4t
         yobZPLDAclJPa40IfF2uOqcK7pb6rOY2FsfuDPHWeTp56m+BUKnacw5xDZQNGXBgt7oM
         PVjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQEU5qivaU7eNZd8xwvMcs47pd/a3BbBfAqugzkCMjOzCv0lnnQkijDpK7Jg14Uy0Siq2vxzo/MVdt7rLEsgO2/CyP4L2vWnovQ9Vo
X-Gm-Message-State: AOJu0YzlZZENBoT2FLeOBlfItS6i0bWpgCESPqYSPrPT0+PpXS0FdbUl
	v6gOJYbuRnhwZM/B2wwlCwI0J1dOCrEXUG4pvdDr7VRVd9jc9M+m
X-Google-Smtp-Source: AGHT+IFF3gVncyN3TR7hbP07PirPfqqnSr7IxJxLr9POXIPSQcFBSJypWZU1PP2Je3jZ98XwlW4btg==
X-Received: by 2002:a17:902:f687:b0:1e4:3e67:2bbb with SMTP id l7-20020a170902f68700b001e43e672bbbmr2797169plg.48.1713447895139;
        Thu, 18 Apr 2024 06:44:55 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902b70800b001e4fdcf67desm1504837pls.299.2024.04.18.06.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:44:54 -0700 (PDT)
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
Subject: [PATCH v10 3/4] mm/memory: add any_dirty optional pointer to folio_pte_batch()
Date: Thu, 18 Apr 2024 21:44:34 +0800
Message-Id: <20240418134435.6092-4-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240418134435.6092-1-ioworker0@gmail.com>
References: <20240418134435.6092-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the any_dirty pointer as an optional parameter to
folio_pte_batch() function. By using both the any_young and any_dirty pointers,
madvise_free can make smarter decisions about whether to clear the PTEs when
marking large folios as lazyfree.

Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/internal.h | 12 ++++++++++--
 mm/madvise.c  | 19 ++++++++++++++-----
 mm/memory.c   |  4 ++--
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index c6483f73ec13..daa59cef85d7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -134,6 +134,8 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
  *		  first one is writable.
  * @any_young: Optional pointer to indicate whether any entry except the
  *		  first one is young.
+ * @any_dirty: Optional pointer to indicate whether any entry except the
+ *		  first one is dirty.
  *
  * Detect a PTE batch: consecutive (present) PTEs that map consecutive
  * pages of the same large folio.
@@ -149,18 +151,20 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
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
@@ -176,6 +180,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 			writable = !!pte_write(pte);
 		if (any_young)
 			young = !!pte_young(pte);
+		if (any_dirty)
+			dirty = !!pte_dirty(pte);
 		pte = __pte_batch_clear_ignored(pte, flags);
 
 		if (!pte_same(pte, expected_pte))
@@ -193,6 +199,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 			*any_writable |= writable;
 		if (any_young)
 			*any_young |= young;
+		if (any_dirty)
+			*any_dirty |= dirty;
 
 		nr = pte_batch_hint(ptep, pte);
 		expected_pte = pte_advance_pfn(expected_pte, nr);
diff --git a/mm/madvise.c b/mm/madvise.c
index f5e3699e7b54..4597a3568e7e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -321,6 +321,18 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
+static inline int madvise_folio_pte_batch(unsigned long addr, unsigned long end,
+					  struct folio *folio, pte_t *ptep,
+					  pte_t pte, bool *any_young,
+					  bool *any_dirty)
+{
+	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
+	int max_nr = (end - addr) / PAGE_SIZE;
+
+	return folio_pte_batch(folio, addr, ptep, pte, max_nr, fpb_flags, NULL,
+			       any_young, any_dirty);
+}
+
 static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct mm_walk *walk)
@@ -456,13 +468,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		 * next pte in the range.
 		 */
 		if (folio_test_large(folio)) {
-			const fpb_t fpb_flags = FPB_IGNORE_DIRTY |
-						FPB_IGNORE_SOFT_DIRTY;
-			int max_nr = (end - addr) / PAGE_SIZE;
 			bool any_young;
 
-			nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
-					     fpb_flags, NULL, &any_young);
+			nr = madvise_folio_pte_batch(addr, end, folio, pte,
+						     ptent, &any_young, NULL);
 			if (any_young)
 				ptent = pte_mkyoung(ptent);
 
diff --git a/mm/memory.c b/mm/memory.c
index 33d87b64d15d..9e07d1b9020c 100644
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
@@ -1558,7 +1558,7 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
 	 */
 	if (unlikely(folio_test_large(folio) && max_nr != 1)) {
 		nr = folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_flags,
-				     NULL, NULL);
+				     NULL, NULL, NULL);
 
 		zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, nr,
 				       addr, details, rss, force_flush,
-- 
2.33.1


