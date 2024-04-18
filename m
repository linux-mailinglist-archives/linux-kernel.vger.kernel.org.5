Return-Path: <linux-kernel+bounces-150192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567208A9B86
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AF81C21603
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B09B1635B7;
	Thu, 18 Apr 2024 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za4/TxTW"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DD161912
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447889; cv=none; b=LaY9xcwcuCn+Wl2GnwEnO8k05WmIDoF3RBVdHWigmjvlrdHiBt9K379W/HmqENK1q3qXKNxkCgyW08mX5J7AjnsLHaU5jWrLSCwPheQfyjGxP2lQo1mkCbLKNFgRGiggOkUyMkaaFlZmfiQJ9sxAaB3zBLzMLSyYd4GE/1w2Uc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447889; c=relaxed/simple;
	bh=YS1E84UOxIjSnPESm8G/PnNhVqV2TAef9FqSYBszYkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xr90U158FMO9CtUjb935+ei5mYUY8vtaKy7EuibSVOaVurw3055IdQ1VyYF0rLchw4LboDWIidj5hbHOIW8CWK6NS6ne15tHPWOy1pdjJu7SnWboNttkVxwqaVyUX/uSH1RGHPYfrAb50Uw/dHQPiqnZfRZN+5+NyQUPyTkoR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Za4/TxTW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e4f341330fso7427265ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447887; x=1714052687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkdNcUi/cFtD91tOAv56m6RXgS21TIueDzxwluwn/Lw=;
        b=Za4/TxTWOepEKyGGfR0FHxnhf2XdyASegoAdc2nKQ+2RExImc/taLIT0k1Msa2C1vM
         c7WXRd2DtgCPN9qUv0UXj5ekDJZwOlqE6GF0l9VcRJriyQnt3N4wf6tBpsCFh5yiJbVj
         KDn0vnwxjWhZXTx5utzGWloemW+p83axogczbZ1C0bUM+t9GOZxshyqEjLfG/Z1oxF0J
         wgOjAyuVBTAYcEh3jo0VVzCuCCvh1jLX+hfbHipcEMG7cB1L4VD7ugrIZiYyYdPrAEdh
         P/7Ho8uMmQRAnGZ/HdfHXYm/lvaB8ykMvWVsvMXGDcIWxWQ8oVbtVj+OiBv1jOv8OIzL
         yWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447887; x=1714052687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkdNcUi/cFtD91tOAv56m6RXgS21TIueDzxwluwn/Lw=;
        b=CAZJRv1YGY7mXGU9n3LQ+r5Y68Ya5FQzuRaNm/lWZcFQjOqcctq+RfoijXcCGA/vnG
         kv81XqkReANTv08bsrhmzJYXy9QI7OQyKC4/UNNx8oRC7Al1dB8o0rF6crn3/kyBI5si
         BpcjPJ55EricNUxqUxaz/KlcsbZogtf4uXDIJfKsmCr0EKoaUs+mbIe6XFAsoIh93Qgb
         Yfuz7MUpbWmYK92zAEhQ0gMGTwK/g8Ij2Ch53R+ZTK0pDt1iFNMENBizX5dXlKQvKknv
         Hzh69ww8FSQDJDqQSRwLelMXRkLyfAgdCLZj3DnHSxE+AlhcgKXeL7VADaeBAzHSj4S2
         +rzg==
X-Forwarded-Encrypted: i=1; AJvYcCVD+f43iHiwu1njspxqs/9PRX4LRJ2OTvX+WIdAtzm3iWEoot1iwbRAaoxJMPP25NdTdDpJ2byVHDRvFUy3wRuiVepqw+3R0ojXoEuB
X-Gm-Message-State: AOJu0YzCPVJhrBHC7qp8MgJbcga2mwH00rdCpuBlyWEoF/KIjK/K/i6R
	untUZjsgSpSzGfmaiGx0qjPj002PCShTVVEN0NMeF9AKcdMpr3Pv
X-Google-Smtp-Source: AGHT+IG2GVYbLpKp4yUNNUcOXfACY+2bHpA67aILzi27vexy/CeFyGpA5xeZ5gYV+u3w513tsrVcFA==
X-Received: by 2002:a17:902:c94e:b0:1e7:b775:64bd with SMTP id i14-20020a170902c94e00b001e7b77564bdmr3953276pla.53.1713447887193;
        Thu, 18 Apr 2024 06:44:47 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902b70800b001e4fdcf67desm1504837pls.299.2024.04.18.06.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:44:46 -0700 (PDT)
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
Subject: [PATCH v10 1/4] mm/madvise: introduce clear_young_dirty_ptes() batch helper
Date: Thu, 18 Apr 2024 21:44:32 +0800
Message-Id: <20240418134435.6092-2-ioworker0@gmail.com>
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

This commit introduces clear_young_dirty_ptes() to replace mkold_ptes().
By doing so, we can use the same function for both use cases
(madvise_pageout and madvise_free), and it also provides the flexibility
to only clear the dirty flag in the future if needed.

Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/mm_types.h |  9 +++++
 include/linux/pgtable.h  | 74 ++++++++++++++++++++++++----------------
 mm/madvise.c             |  3 +-
 3 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index db0adf5721cc..24323c7d0bd4 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1368,6 +1368,15 @@ enum fault_flag {
 
 typedef unsigned int __bitwise zap_flags_t;
 
+/* Flags for clear_young_dirty_ptes(). */
+typedef int __bitwise cydp_t;
+
+/* Clear the access bit */
+#define CYDP_CLEAR_YOUNG		((__force cydp_t)BIT(0))
+
+/* Clear the dirty bit */
+#define CYDP_CLEAR_DIRTY		((__force cydp_t)BIT(1))
+
 /*
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
  * other. Here is what they mean, and how to use them:
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e2f45e22a6d1..18019f037bae 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -361,36 +361,6 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 }
 #endif
 
-#ifndef mkold_ptes
-/**
- * mkold_ptes - Mark PTEs that map consecutive pages of the same folio as old.
- * @vma: VMA the pages are mapped into.
- * @addr: Address the first page is mapped at.
- * @ptep: Page table pointer for the first entry.
- * @nr: Number of entries to mark old.
- *
- * May be overridden by the architecture; otherwise, implemented as a simple
- * loop over ptep_test_and_clear_young().
- *
- * Note that PTE bits in the PTE range besides the PFN can differ. For example,
- * some PTEs might be write-protected.
- *
- * Context: The caller holds the page table lock.  The PTEs map consecutive
- * pages that belong to the same folio.  The PTEs are all in the same PMD.
- */
-static inline void mkold_ptes(struct vm_area_struct *vma, unsigned long addr,
-		pte_t *ptep, unsigned int nr)
-{
-	for (;;) {
-		ptep_test_and_clear_young(vma, addr, ptep);
-		if (--nr == 0)
-			break;
-		ptep++;
-		addr += PAGE_SIZE;
-	}
-}
-#endif
-
 #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
@@ -489,6 +459,50 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 }
 #endif
 
+#ifndef clear_young_dirty_ptes
+/**
+ * clear_young_dirty_ptes - Mark PTEs that map consecutive pages of the
+ *		same folio as old/clean.
+ * @mm: Address space the pages are mapped into.
+ * @addr: Address the first page is mapped at.
+ * @ptep: Page table pointer for the first entry.
+ * @nr: Number of entries to mark old/clean.
+ * @flags: Flags to modify the PTE batch semantics.
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
+static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
+					  unsigned long addr, pte_t *ptep,
+					  unsigned int nr, cydp_t flags)
+{
+	pte_t pte;
+
+	for (;;) {
+		if (flags == CYDP_CLEAR_YOUNG)
+			ptep_test_and_clear_young(vma, addr, ptep);
+		else {
+			pte = ptep_get_and_clear(vma->vm_mm, addr, ptep);
+			if (flags & CYDP_CLEAR_YOUNG)
+				pte = pte_mkold(pte);
+			if (flags & CYDP_CLEAR_DIRTY)
+				pte = pte_mkclean(pte);
+			set_pte_at(vma->vm_mm, addr, ptep, pte);
+		}
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
diff --git a/mm/madvise.c b/mm/madvise.c
index 4b869b682fd5..f5e3699e7b54 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -507,7 +507,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			continue;
 
 		if (!pageout && pte_young(ptent)) {
-			mkold_ptes(vma, addr, pte, nr);
+			clear_young_dirty_ptes(vma, addr, pte, nr,
+					       CYDP_CLEAR_YOUNG);
 			tlb_remove_tlb_entries(tlb, pte, nr, addr);
 		}
 
-- 
2.33.1


