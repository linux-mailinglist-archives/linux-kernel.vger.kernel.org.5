Return-Path: <linux-kernel+bounces-88158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1A586DDFB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD3B1F268E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6506A33D;
	Fri,  1 Mar 2024 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TWNV6pdP"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADB96A343
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284577; cv=none; b=pAUsHdXvXy/appQOQflEJsldHnGr4BvsAfclgInVQ4JDJ7SsYv5SjrTxvaRj0q9BnS8VgmczbB6SHjrrLf5zPR21C691FTKzZvFaUjLVmLbVF7eC/meZe78XCy7J//eg7DP0UyZ+/WK9Q9ghzI3ntPPoXbvMeErxLD44v2aecp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284577; c=relaxed/simple;
	bh=Grv+B1lXOvsgkugd0xHmI2otveFzl/ke8dkw8ikngxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X92Rv+2IkoUOFMlb9w71qOTsebw3CBtCBRpUmLICOA03KB7soNncpxVnk7Vt0m4NxdSIzuvcDZfOxMiZmuzwtEzuWwXEzcfC8fsfmVlNrSouta/kvMv1HYQCY5/Wku+vW0vLDC43divOMN9sgorDr/O3wcijay4rqPqB19TWVtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TWNV6pdP; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d33986dbc0so4495381fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 01:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709284573; x=1709889373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HmYMQ4fCaWre3Z0n4nCWU3axYoW5M2HfRVImcv9VqU=;
        b=TWNV6pdPdxvfH8VBVvwLB3dvscvb5F81aqw46QHY+ITfLjvUuxg/vX5G40pctmYBBP
         kirkrV7tv91wbL3B+O1kRZGOM49L1kgAxRL6duDbsMMJaqig8UpqbuLfEeNPfsIDH61N
         q82Mt09CWMcjmPLQDWvQgmbFOhB67FdPyCgoF8SwJHPSkpG9Ja2Hu4bKC/y7RFcDsFYA
         QQonDP2P0iGC7c/Vxp3PojU6SpzIqDW47EZcJfIInEUCPV9fFWqQnxO+Gy8mxkaixlNH
         hxy7mvZwyDgAvkGZFz7xROiwU4x5mJBV1FrGVKLSgO8Tfk7GTKTgsmJzgKPnCInaV8uj
         sLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709284573; x=1709889373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HmYMQ4fCaWre3Z0n4nCWU3axYoW5M2HfRVImcv9VqU=;
        b=vKtE2qoS9/rf2bH2qxenJiTlYUm1CXMMmO+Qeb9qztCvA6soQCSzQEWoksOXCrpS6I
         PqhP86+cVK7PkbVgSpTz7QtQbxhUN/+qacChU4v9kfyLiPldpLYoAPsf/j0fQ9uqlFXX
         8p8xPM+ZzWC3BAzRntMNDO6ayJpx6DPzpNruskN48d8fAInuZM93nh98jjMsOXTXAato
         InKpMBB4AaUG/W0mdJd1Ge/JaEawbQsyt/olSN9Ngo9mtgzQNd9LqMwECrgLZbXIJ984
         yW+0JMNkg09dsb62CyQxFApPI+6s+HGL+rq1OgTAyZKpKgbUUk5ioeEE8mw2jQQY7drH
         KUEA==
X-Forwarded-Encrypted: i=1; AJvYcCWplVYekc96ZFaFARt/pfjetckb3iXXmPfWZuL1UdebKGVPvlNbgyvKwCg6/gkh3c7SwPPgxwM6DfEQ1D82VrBvzJ3CmxvET1TjoRDx
X-Gm-Message-State: AOJu0Yzse3JbQZr9TchNmDt9VcVOjjARDVbGcyYgIxnP05Lkcn3MahkA
	nFzzL1UNz3kd7YaXqdoCNBTE+YjKsJUKhbMv4g/0n8fbp8kTO9oeyBAsyhiDHp8=
X-Google-Smtp-Source: AGHT+IHQVU7ZdAsKvA/XTSgIwwIMQlWsmY+5DOvluKjOjYHWuq3/2JdBJ53cUSY5g2ynNIYVyWu0Lg==
X-Received: by 2002:a05:651c:10cf:b0:2d2:eb8c:b3a6 with SMTP id l15-20020a05651c10cf00b002d2eb8cb3a6mr619531ljn.40.1709284573125;
        Fri, 01 Mar 2024 01:16:13 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bcb95000000b00410b0ce91b1sm7777825wmi.25.2024.03.01.01.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:16:12 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 1/9] riscv: Restore the pfn in a NAPOT pte when manipulated by core mm code
Date: Fri,  1 Mar 2024 10:14:47 +0100
Message-Id: <20240301091455.246686-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301091455.246686-1-alexghiti@rivosinc.com>
References: <20240301091455.246686-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core mm code expects to be able to extract the pfn from a pte. NAPOT
mappings work differently since its ptes actually point to the first pfn
of the mapping, the other bits being used to encode the size of the
mapping.

So modify ptep_get() so that it returns a pte value that contains the
*real* pfn (which is then different from what the HW expects) and right
before storing the ptes to the page table, reset the pfn LSBs to the
size of the mapping.

And make sure that all NAPOT mappings are set using set_ptes().

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable-64.h |  11 +++
 arch/riscv/include/asm/pgtable.h    | 105 ++++++++++++++++++++++++++--
 arch/riscv/mm/hugetlbpage.c         |  38 +++++-----
 3 files changed, 128 insertions(+), 26 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index b42017d76924..a0f76c3071a9 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -106,6 +106,17 @@ enum napot_cont_order {
 #define napot_cont_mask(order)	(~(napot_cont_size(order) - 1UL))
 #define napot_pte_num(order)	BIT(order)
 
+static inline bool is_napot_order(unsigned int order)
+{
+	unsigned int napot_order;
+
+	for_each_napot_order(napot_order)
+		if (order == napot_order)
+			return true;
+
+	return false;
+}
+
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 #define HUGE_MAX_HSTATE		(2 + (NAPOT_ORDER_MAX - NAPOT_CONT_ORDER_BASE))
 #else
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 0c94260b5d0c..951f3ceb5529 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -303,6 +303,8 @@ static inline unsigned long pte_napot(pte_t pte)
 	return pte_val(pte) & _PAGE_NAPOT;
 }
 
+#define pte_valid_napot(pte)	(pte_present(pte) && pte_napot(pte))
+
 static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
 {
 	int pos = order - 1 + _PAGE_PFN_SHIFT;
@@ -312,6 +314,12 @@ static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
 	return __pte((pte_val(pte) & napot_mask) | napot_bit | _PAGE_NAPOT);
 }
 
+/* pte at entry must *not* encode the mapping size in the pfn LSBs. */
+static inline pte_t pte_clear_napot(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_NAPOT);
+}
+
 #else
 
 static __always_inline bool has_svnapot(void) { return false; }
@@ -321,17 +329,14 @@ static inline unsigned long pte_napot(pte_t pte)
 	return 0;
 }
 
+#define pte_valid_napot(pte)	false
+
 #endif /* CONFIG_RISCV_ISA_SVNAPOT */
 
 /* Yields the page frame number (PFN) of a page table entry */
 static inline unsigned long pte_pfn(pte_t pte)
 {
-	unsigned long res  = __page_val_to_pfn(pte_val(pte));
-
-	if (has_svnapot() && pte_napot(pte))
-		res = res & (res - 1UL);
-
-	return res;
+	return __page_val_to_pfn(pte_val(pte));
 }
 
 #define pte_page(x)     pfn_to_page(pte_pfn(x))
@@ -523,9 +528,91 @@ static inline void __set_pte_at(pte_t *ptep, pte_t pteval)
 	set_pte(ptep, pteval);
 }
 
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
+					      size_t *pgsize)
+{
+	pte_t __pte;
+
+	/* We must read the raw value of the pte to get the size of the mapping */
+	__pte = READ_ONCE(*ptep);
+
+	if (pgsize) {
+		if (size >= PGDIR_SIZE)
+			*pgsize = PGDIR_SIZE;
+		else if (size >= P4D_SIZE)
+			*pgsize = P4D_SIZE;
+		else if (size >= PUD_SIZE)
+			*pgsize = PUD_SIZE;
+		else if (size >= PMD_SIZE)
+			*pgsize = PMD_SIZE;
+		else
+			*pgsize = PAGE_SIZE;
+	}
+
+	/* Make sure __pte is not a swap entry */
+	if (pte_valid_napot(__pte))
+		return napot_pte_num(napot_cont_order(__pte));
+
+	return 1;
+}
+#endif
+
+static inline pte_t ptep_get(pte_t *ptep)
+{
+	pte_t pte = READ_ONCE(*ptep);
+
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+	/*
+	 * The pte we load has the N bit set and the size of the mapping in
+	 * the pfn LSBs: keep the N bit and replace the mapping size with
+	 * the *real* pfn since the core mm code expects to find it there.
+	 * The mapping size will be reset just before being written to the
+	 * page table in set_ptes().
+	 */
+	if (unlikely(pte_valid_napot(pte))) {
+		unsigned int order = napot_cont_order(pte);
+		int pos = order - 1 + _PAGE_PFN_SHIFT;
+		unsigned long napot_mask = ~GENMASK(pos, _PAGE_PFN_SHIFT);
+		pte_t *orig_ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * napot_pte_num(order));
+
+		pte = __pte((pte_val(pte) & napot_mask) + ((ptep - orig_ptep) << _PAGE_PFN_SHIFT));
+	}
+#endif
+
+	return pte;
+}
+#define ptep_get	ptep_get
+
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_t *ptep, pte_t pteval, unsigned int nr)
 {
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+	if (unlikely(pte_valid_napot(pteval))) {
+		unsigned int order = ilog2(nr);
+
+		if (!is_napot_order(order)) {
+			/*
+			 * Something's weird, we are given a NAPOT pte but the
+			 * size of the mapping is not a known NAPOT mapping
+			 * size, so clear the NAPOT bit and map this without
+			 * NAPOT support: core mm only manipulates pte with the
+			 * real pfn so we know the pte is valid without the N
+			 * bit.
+			 */
+			pr_err("Incorrect NAPOT mapping, resetting.\n");
+			pteval = pte_clear_napot(pteval);
+		} else {
+			/*
+			 * NAPOT ptes that arrive here only have the N bit set
+			 * and their pfn does not contain the mapping size, so
+			 * set that here.
+			 */
+			pteval = pte_mknapot(pteval, order);
+		}
+	}
+#endif
+
 	page_table_check_ptes_set(mm, ptep, pteval, nr);
 
 	for (;;) {
@@ -533,6 +620,12 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		if (--nr == 0)
 			break;
 		ptep++;
+
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+		if (unlikely(pte_valid_napot(pteval)))
+			continue;
+#endif
+
 		pte_val(pteval) += 1 << _PAGE_PFN_SHIFT;
 	}
 }
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 29c7606414d2..3d84fbc5c572 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -256,8 +256,7 @@ void set_huge_pte_at(struct mm_struct *mm,
 
 	clear_flush(mm, addr, ptep, pgsize, pte_num);
 
-	for (i = 0; i < pte_num; i++, ptep++, addr += pgsize)
-		set_pte_at(mm, addr, ptep, pte);
+	set_ptes(mm, addr, ptep, pte, pte_num);
 }
 
 int huge_ptep_set_access_flags(struct vm_area_struct *vma,
@@ -267,16 +266,16 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       int dirty)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long order;
+	size_t pgsize;
 	pte_t orig_pte;
-	int i, pte_num;
+	int pte_num;
 
 	if (!pte_napot(pte))
 		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 
-	order = napot_cont_order(pte);
-	pte_num = napot_pte_num(order);
-	ptep = huge_pte_offset(mm, addr, napot_cont_size(order));
+	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
+	ptep = huge_pte_offset(mm, addr, pte_num * pgsize);
+
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
 	if (pte_dirty(orig_pte))
@@ -285,8 +284,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	if (pte_young(orig_pte))
 		pte = pte_mkyoung(pte);
 
-	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++)
-		set_pte_at(mm, addr, ptep, pte);
+	set_ptes(mm, addr, ptep, pte, pte_num);
 
 	return true;
 }
@@ -301,7 +299,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 	if (!pte_napot(orig_pte))
 		return ptep_get_and_clear(mm, addr, ptep);
 
-	pte_num = napot_pte_num(napot_cont_order(orig_pte));
+	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
 
 	return get_clear_contig(mm, addr, ptep, pte_num);
 }
@@ -311,24 +309,23 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 			     pte_t *ptep)
 {
 	pte_t pte = ptep_get(ptep);
-	unsigned long order;
+	size_t pgsize;
 	pte_t orig_pte;
-	int i, pte_num;
+	int pte_num;
 
 	if (!pte_napot(pte)) {
 		ptep_set_wrprotect(mm, addr, ptep);
 		return;
 	}
 
-	order = napot_cont_order(pte);
-	pte_num = napot_pte_num(order);
-	ptep = huge_pte_offset(mm, addr, napot_cont_size(order));
+	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
+	ptep = huge_pte_offset(mm, addr, pte_num * pgsize);
+
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
 	orig_pte = pte_wrprotect(orig_pte);
 
-	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++)
-		set_pte_at(mm, addr, ptep, orig_pte);
+	set_ptes(mm, addr, ptep, orig_pte, pte_num);
 }
 
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
@@ -341,7 +338,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 	if (!pte_napot(pte))
 		return ptep_clear_flush(vma, addr, ptep);
 
-	pte_num = napot_pte_num(napot_cont_order(pte));
+	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
 
 	return get_clear_contig_flush(vma->vm_mm, addr, ptep, pte_num);
 }
@@ -351,6 +348,7 @@ void huge_pte_clear(struct mm_struct *mm,
 		    pte_t *ptep,
 		    unsigned long sz)
 {
+	size_t pgsize;
 	pte_t pte = ptep_get(ptep);
 	int i, pte_num;
 
@@ -359,8 +357,8 @@ void huge_pte_clear(struct mm_struct *mm,
 		return;
 	}
 
-	pte_num = napot_pte_num(napot_cont_order(pte));
-	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++)
+	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
+	for (i = 0; i < pte_num; i++, addr += pgsize, ptep++)
 		pte_clear(mm, addr, ptep);
 }
 
-- 
2.39.2


