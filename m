Return-Path: <linux-kernel+bounces-127958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807B18953AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D8C1C22827
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50B484A49;
	Tue,  2 Apr 2024 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKl7d7np"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0084A21
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061644; cv=none; b=bhCKfkaXrm5BV1R53DXZf4FZmpVfkqSuTB51fG5emrY9dW+zbT4DafHQmt2hxgN6l9PJcGEuzFcjcBrq2ekgt7/aO3BC2w5Nlnm8a+yXgML41/fnLC617ld9MLcUUWKzPbo/3rO7qPplurhdnzY/61JBHwmSDIwDxayxEuA6AIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061644; c=relaxed/simple;
	bh=kcVZAefIeir+f1KOLqSns9GBpww0qSa62nhT/bqFbHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XNxH7Pig4GZUbEr2vCZe+udLvh5KzwRDJQKqJLVF0HiXIPo5gn7me8eiJ9mLwYYNLUoMfY/wtEk4D5CBwCfvL6c9FvUTVv+AO4rIq7w9apnwaqmLdlImXlkqkziO7eORYF0qbgQxHEXgY/fa4X2cRcd80TNpRN6tmzDSgXgMqXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKl7d7np; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6b729669bso4370352b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712061642; x=1712666442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SLRrUoatbOMxRSqAUzYjv3kxNJrInRhmdCDhk/HGpw=;
        b=iKl7d7npCv4IBSkP3Jf7IgTOTWaz/5QdGpMuxsLUBj9sFF2hhRuFnWgDcNo83lxcNP
         lvQfpjjbaO1n4y7TiFENmD8aKTb0iFZUcipkp8isw9le4nvD5gQJ67lFcym8tWi7xWUv
         o8GgvY+FSGz6w1c7XZZVxUflwfT9wgJciJaRz3v6PQzsEQQydBYsz9fFjzOQYR8IQROK
         on3BuTJgej7Px2IXkBogxsYtD8kODozMcuNE9YiGOjbcOLFo6vTEonSP/NveMt83zgUS
         cN41ijnkHslfkoCMxXIEUZIiOqWRVxcfB793dp4GIoPCCF1/lulIKvbUhTOZYaZpA8TX
         PHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061642; x=1712666442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SLRrUoatbOMxRSqAUzYjv3kxNJrInRhmdCDhk/HGpw=;
        b=AgpHc2AMh4rPwOS6LojxluWTKxuioXn9DP2Rpm9chc4Mo1L4duJinsqJuZWjkjT5jF
         k6Yk1LNAAX/QrNJTixY04YPot0PhP/ban0sb9ChKw7E4KotfiwSdfSYK0a9oTcxOb/j+
         cy4ROq18bWiw7MfMVP8x2GWx7oBQKEWtskEDNRL7uKwSUqJ1EfWYUurQ4K2Tt9majHAN
         xl/UgAJSos5tLp7kki0n2NxEm/3kVtr8XG3pno2Dn2YQyi5Z50AEQm4Aju3NhEYXVRdP
         yHvcpFTZe/GA83qRlovxTkAh5ZtrPOzxMWRIol0fqYnKBQfLXCcGBzvZfv9VAjChuzx1
         Inrg==
X-Forwarded-Encrypted: i=1; AJvYcCW+nRN795KHUxIVmkZ24Cd3+Jfp0tOeNeBqxpOwOv8oSV/K2+riqJEIKOppb7KIuYHICiGzoA9nCgDKA7hNvbd8eqKv1HXcm3Jn7Xdp
X-Gm-Message-State: AOJu0Yxj6DTyzsJhy4CXMSP2c4dazLSuBJvuTZH3bC1pEgRSArunZCSV
	VOLzIGCVOtobpLpu2j9niR7XUqZif/zqQbqOHs8KQ9qxxnmT8/2D
X-Google-Smtp-Source: AGHT+IFKWkuIBM1Aj0ChduZSzbmJ78sI/uhS5RIdZ7rqHTmgijXUTzIkIb5KcmhxMEPmKX6nCpXloQ==
X-Received: by 2002:a05:6a20:d90f:b0:1a7:f15:16a with SMTP id jd15-20020a056a20d90f00b001a70f15016amr9929114pzb.18.1712061642455;
        Tue, 02 Apr 2024 05:40:42 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.9])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b006e664031f10sm9708232pfn.51.2024.04.02.05.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:40:42 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: zokeefe@google.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	shy828301@gmail.com,
	david@redhat.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	xiehuan09@gmail.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v4 1/2] mm/madvise: introduce mkold_clean_ptes() batch helper
Date: Tue,  2 Apr 2024 20:40:28 +0800
Message-Id: <20240402124029.47846-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240402124029.47846-1-ioworker0@gmail.com>
References: <20240402124029.47846-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the code that clears young and dirty bits from the PTEs to use
ptep_get_and_clear_full() and set_pte_at(), via the new mkold_clean_ptes()
batch helper function.

Unfortunately, the per-pte get_and_clear/modify/set approach would result
in unfolding/refolding for contpte mappings on arm64. So we need to
override mkold_clean_ptes() for arm64 to avoid it.

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Barry Song <21cnbao@gmail.com>
Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 arch/arm64/include/asm/pgtable.h | 36 ++++++++++++++++++++++++++++++++
 arch/arm64/mm/contpte.c          | 10 +++++++++
 include/linux/pgtable.h          | 30 ++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 9fd8613b2db2..b032c107090c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1086,6 +1086,27 @@ static inline bool pud_user_accessible_page(pud_t pud)
 }
 #endif
 
+static inline void __mkold_clean_pte(struct vm_area_struct *vma,
+				    unsigned long addr, pte_t *ptep)
+{
+	pte_t old_pte, pte;
+
+	pte = __ptep_get(ptep);
+	do {
+		old_pte = pte;
+		pte = pte_mkclean(pte_mkold(pte));
+		pte_val(pte) = cmpxchg_relaxed(&pte_val(*ptep),
+					       pte_val(old_pte), pte_val(pte));
+	} while (pte_val(pte) != pte_val(old_pte));
+}
+
+static inline void mkold_clean_ptes(struct vm_area_struct *vma,
+				    unsigned long addr, pte_t *ptep, unsigned int nr, int full)
+{
+	for (; nr-- > 0; ptep++, addr += PAGE_SIZE)
+		__mkold_clean_pte(vma, addr, ptep);
+}
+
 /*
  * Atomic pte/pmd modifications.
  */
@@ -1379,6 +1400,8 @@ extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep,
 				pte_t entry, int dirty);
+extern void contpte_ptep_mkold_clean(struct vm_area_struct *vma,
+				unsigned long addr, pte_t *ptep);
 
 static __always_inline void contpte_try_fold(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep, pte_t pte)
@@ -1603,6 +1626,18 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 	return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirty);
 }
 
+#define mkold_clean_ptes mkold_clean_ptes
+static inline void mkold_clean_ptes(struct vm_area_struct *vma,
+				    unsigned long addr, pte_t *ptep, unsigned int nr, int full)
+{
+	pte_t orig_pte = __ptep_get(ptep);
+
+	if (likely(!pte_valid_cont(orig_pte)))
+		return __mkold_clean_ptes(vma, addr, ptep, nr, full);
+
+	return contpte_ptep_mkold_clean(vma, addr, ptep);
+}
+
 #else /* CONFIG_ARM64_CONTPTE */
 
 #define ptep_get				__ptep_get
@@ -1622,6 +1657,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 #define wrprotect_ptes				__wrprotect_ptes
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags			__ptep_set_access_flags
+#define mkold_clean_ptes			__mkold_clean_ptes
 
 #endif /* CONFIG_ARM64_CONTPTE */
 
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 1b64b4c3f8bf..560622cfb2a9 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -322,6 +322,16 @@ int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL_GPL(contpte_ptep_test_and_clear_young);
 
+void contpte_ptep_mkold_clean(struct vm_area_struct *vma, unsigned long addr,
+			      pte_t *ptep)
+{
+	ptep = contpte_align_down(ptep);
+	addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
+
+	__mkold_clean_ptes(vma, addr, ptep, CONT_PTES, 0);
+}
+EXPORT_SYMBOL_GPL(contpte_ptep_mkold_clean);
+
 int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep)
 {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index fa8f92f6e2d7..fd30779fe487 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -391,6 +391,36 @@ static inline void mkold_ptes(struct vm_area_struct *vma, unsigned long addr,
 }
 #endif
 
+#ifndef mkold_clean_ptes
+/**
+ * mkold_clean_ptes - Mark PTEs that map consecutive pages of the same folio
+ *		as old and clean.
+ * @vma: VMA the pages are mapped into.
+ * @addr: Address the first page is mapped at.
+ * @ptep: Page table pointer for the first entry.
+ * @nr: Number of entries to mark old and clean.
+ *
+ * May be overridden by the architecture; otherwise, implemented as a simple
+ * loop over ptep_get_and_clear_full().
+ *
+ * Note that PTE bits in the PTE range besides the PFN can differ. For example,
+ * some PTEs might be write-protected.
+ *
+ * Context: The caller holds the page table lock.  The PTEs map consecutive
+ * pages that belong to the same folio.  The PTEs are all in the same PMD.
+ */
+static inline void mkold_clean_ptes(struct vm_area_struct *vma,
+				    unsigned long addr, pte_t *ptep, unsigned int nr, int full)
+{
+	pte_t pte;
+
+	for (; nr-- > 0; ptep++, addr += PAGE_SIZE) {
+		pte = ptep_get_and_clear_full(vma->vm_mm, addr, ptep, full);
+		set_pte_at(vma->vm_mm, addr, ptep, pte_mkclean(pte_mkold(pte)));
+	}
+}
+#endif
+
 #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-- 
2.33.1


