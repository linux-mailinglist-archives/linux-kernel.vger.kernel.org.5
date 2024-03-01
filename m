Return-Path: <linux-kernel+bounces-88172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81C286DE22
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E500283C82
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3156A6A8A4;
	Fri,  1 Mar 2024 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="n+O+UU8o"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CAF1E886
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285065; cv=none; b=C7bJmZdDdGXV/rBakGDvLvI5ct0M2S9A7hVA1UdczbtRpMxR3mYvDaPqrcJUnGzMOA3F4H7maAD3L7qmTHLlOBLUFc6qyME061JyMhpRjgKp6NUDVeI1T5Dj2jWPd8YWjCPJgfPbfMoHo9pah/uCiUWWjpOeCBXTcuRNWDMus8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285065; c=relaxed/simple;
	bh=+ow+dOW9ypF4OLMK7/TVjfBm7JSrFvOpR9MHm14eflw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cBjv/khdDl0VYO0RGMfepZb+P3d+HUcZ84B+J0Bqa9QEEoQeN+pawPvPrm0/AyxIlx9Nqqu1IIVGtTepOIoW54WeGnPAN8o3qs5FVt1KFb6xscNnF0LjmnBBm8ypHvFvAVF0XmNm+vCCG2//Zr6xgblZZ7DmtH5/DcdZGbTXqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=n+O+UU8o; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d23d301452so19647331fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 01:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709285061; x=1709889861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K12kuYfal65hYkuTm7CnsK9zS+VdU7mNn9HZDxR8IYY=;
        b=n+O+UU8oiMMmL3XVwwEsvNJhjmmPr5FkZotyNPP9fovVMxnBxnHGfYrR993uR5YHQ0
         l6TMymD+AQ9P3RkN5p6nsvGJBJmGacGtjLJqno8co2Sc73krgleNqHYdIeN+RJ066mcU
         BFZ7M7Pp/v0WGUYrw9T8FlJzVVyIeWQrL4CwDiVN84/hKcE5spEYGq34noAqRbk9k4GU
         JiuWWL8Ndy4awE9wdjGnmH7d1zn+qn97VBout+3P4LP69KzJyMnoS9avltzlxq7N1Gco
         RHiDteBfr60Gr5PHV/TWuzUlVSmOyFppWQw3zOL4QB9zZYGlTYSj8RFvF4vvb1mnZ/M7
         zXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285061; x=1709889861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K12kuYfal65hYkuTm7CnsK9zS+VdU7mNn9HZDxR8IYY=;
        b=sCnmL0iDIQex7gA96P/LpseVl6X9xv0rsesefKy+XC+D3pi1IdjC8W+rTWkkFEqHJR
         whSvdTk+SdFnag1o5MfB2edRwPLJ06MAlixjhHtVa6kLX/+v1tOJaGQCsH3nrAl9yunP
         9AiDH0sMnxHaBROBdNZkjhvvxYabnss2oTB7LrE89U+ytY8Z77vYey5ik320uxvxP2MJ
         TcylS5YSqqhRROZPERH5Ajzu9njWguM9UmmdmpurgslWfYraWEYIUUWhSR37KdA0Oyw2
         DCDdGd9tMoB3kwOF0w5ySQPs1FDkye6pJzHy9qK6kJ+x7RuoJJzHwbfICaKl4JHdqmvi
         n3AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxiq0zx5LuhQqL3Sb0cvFlUHx5jcT2EMA2RUWvlbvXlPCiWeH5OwpVHejhUFM0xs9Fj9CBPaZYeDb33XwwueL3gABK5sGgNz07+w86
X-Gm-Message-State: AOJu0YyOAcA6FRkDivFv/ZkZ9cd3U45eNssHxsxtcfPJ+1OA2yX4oYb5
	S4t3jwP/Y9qNWMsxHWeylmiAUXm2dvriutb5g4xwatmr7iXd7f3nODvrUojYLOs=
X-Google-Smtp-Source: AGHT+IFt+kCs8abRI8MZlthQ5rKNhpeiYCQtIBul4mlcyfPmRwi1Z8kSKZm+NO/gjQvAypId4axWxw==
X-Received: by 2002:a2e:9909:0:b0:2d2:92a2:9a84 with SMTP id v9-20020a2e9909000000b002d292a29a84mr731669lji.43.1709285061585;
        Fri, 01 Mar 2024 01:24:21 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id w15-20020a05600c474f00b00412ca1dc2e4sm649267wmo.7.2024.03.01.01.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:24:21 -0800 (PST)
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
Subject: [PATCH 9/9] mm: Use common huge_ptep_clear_flush() function for riscv/arm64
Date: Fri,  1 Mar 2024 10:14:55 +0100
Message-Id: <20240301091455.246686-10-alexghiti@rivosinc.com>
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

After some adjustments, both architectures have the same implementation
so move it to the generic code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/mm/hugetlbpage.c | 61 -------------------------------------
 arch/riscv/mm/hugetlbpage.c | 51 -------------------------------
 mm/contpte.c                | 15 +++++++++
 3 files changed, 15 insertions(+), 112 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index d6ddaf282a94..8a273b9816d7 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -119,53 +119,6 @@ int find_num_contig(struct mm_struct *mm, unsigned long addr,
 	return CONT_PTES;
 }
 
-/*
- * Changing some bits of contiguous entries requires us to follow a
- * Break-Before-Make approach, breaking the whole contiguous set
- * before we can change any entries. See ARM DDI 0487A.k_iss10775,
- * "Misprogramming of the Contiguous bit", page D4-1762.
- *
- * This helper performs the break step.
- */
-static pte_t get_clear_contig(struct mm_struct *mm,
-			     unsigned long addr,
-			     pte_t *ptep,
-			     unsigned long pgsize,
-			     unsigned long ncontig)
-{
-	pte_t orig_pte = ptep_get(ptep);
-	unsigned long i;
-
-	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
-		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
-
-		/*
-		 * If HW_AFDBM is enabled, then the HW could turn on
-		 * the dirty or accessed bit for any page in the set,
-		 * so check them all.
-		 */
-		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
-
-		if (pte_young(pte))
-			orig_pte = pte_mkyoung(orig_pte);
-	}
-	return orig_pte;
-}
-
-static pte_t get_clear_contig_flush(struct mm_struct *mm,
-				    unsigned long addr,
-				    pte_t *ptep,
-				    unsigned long pgsize,
-				    unsigned long ncontig)
-{
-	pte_t orig_pte = get_clear_contig(mm, addr, ptep, pgsize, ncontig);
-	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
-
-	flush_tlb_range(&vma, addr, addr + (pgsize * ncontig));
-	return orig_pte;
-}
-
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, unsigned long sz)
 {
@@ -284,20 +237,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
-			    unsigned long addr, pte_t *ptep)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	size_t pgsize;
-	int ncontig;
-
-	if (!pte_cont(READ_ONCE(*ptep)))
-		return ptep_clear_flush(vma, addr, ptep);
-
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
-	return get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
-}
-
 static int __init hugetlbpage_init(void)
 {
 	if (pud_sect_supported())
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index e6cbb6fb2904..caf1db6f8f20 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -121,42 +121,6 @@ unsigned long hugetlb_mask_last_page(struct hstate *h)
 	return 0UL;
 }
 
-static pte_t get_clear_contig(struct mm_struct *mm,
-			      unsigned long addr,
-			      pte_t *ptep,
-			      unsigned long pte_num)
-{
-	pte_t orig_pte = ptep_get(ptep);
-	unsigned long i;
-
-	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++) {
-		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
-
-		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
-
-		if (pte_young(pte))
-			orig_pte = pte_mkyoung(orig_pte);
-	}
-
-	return orig_pte;
-}
-
-static pte_t get_clear_contig_flush(struct mm_struct *mm,
-				    unsigned long addr,
-				    pte_t *ptep,
-				    unsigned long pte_num)
-{
-	pte_t orig_pte = get_clear_contig(mm, addr, ptep, pte_num);
-	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
-	bool valid = !pte_none(orig_pte);
-
-	if (valid)
-		flush_tlb_range(&vma, addr, addr + (PAGE_SIZE * pte_num));
-
-	return orig_pte;
-}
-
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 {
 	unsigned long order;
@@ -173,21 +137,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
-			    unsigned long addr,
-			    pte_t *ptep)
-{
-	pte_t pte = ptep_get(ptep);
-	int pte_num;
-
-	if (!pte_napot(pte))
-		return ptep_clear_flush(vma, addr, ptep);
-
-	pte_num = arch_contpte_get_num_contig(vma->vm_mm, addr, ptep, 0, NULL);
-
-	return get_clear_contig_flush(vma->vm_mm, addr, ptep, pte_num);
-}
-
 static bool is_napot_size(unsigned long size)
 {
 	unsigned long order;
diff --git a/mm/contpte.c b/mm/contpte.c
index f7f26d2cfa23..445e5ebe46b4 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -23,6 +23,7 @@
  * huge_ptep_get_and_clear()
  * huge_ptep_set_access_flags()
  * huge_ptep_set_wrprotect()
+ * huge_ptep_clear_flush()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -251,3 +252,17 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 
 	set_contptes(mm, addr, ptep, pte, ncontig, pgsize);
 }
+
+pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+			    unsigned long addr, pte_t *ptep)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	size_t pgsize;
+	int ncontig;
+
+	if (!pte_cont(ptep_get(ptep)))
+		return ptep_clear_flush(vma, addr, ptep);
+
+	ncontig = arch_contpte_get_num_contig(mm, addr, ptep, 0, &pgsize);
+	return get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
+}
-- 
2.39.2


