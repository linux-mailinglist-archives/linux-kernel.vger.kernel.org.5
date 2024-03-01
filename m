Return-Path: <linux-kernel+bounces-88161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3097C86DE07
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8431C20F5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B01B6A345;
	Fri,  1 Mar 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ejflXW0a"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222566A333
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284760; cv=none; b=Wqy9UvGZLMcxWTv1MD4O7VbgmYx9zzfto2qYJUw3XWzAFBq/klSoYNQewLuldeYpx12HDoin8cHFGBwEVcC7X5amaPzw2+ZoosE/QHSIPSxhSSD3M3s90SXd6QtB/k3RbNsMEEPJn1LRYJO22th8DEZtkPa3qNDe9LFEZ2qGFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284760; c=relaxed/simple;
	bh=TPDvPyDeHRlzYsRpYqIX0Abk+DqhasToPlBHcS6Cx1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THoz/ApxMaO9ymrkTIPQRUBBDTVswZTrcUSq3fX4IJUy11ezvz9JZi//3D9rrCcGkqshyl/DFo0k5xVX4xUSWPAycAa3Mkjkk4/IvvXUw+GnkYiN+eFDkFhWA44NqLoOBLWNfFbVpHtaCvw1buJnkzKiqgNAodFlKSvw7L5256A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ejflXW0a; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412bb23e5c5so10024395e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 01:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709284756; x=1709889556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mB8cpSFUHI2v28tFlR/YUHSb5lk45+n/9IYk3vd50wk=;
        b=ejflXW0aDakpiYCc9zCVhjuOgN1tIUIrY6Hpho7reJ995j1en7MED3b9huiuoFhqYY
         yHDfqLnp58s1uVUzhtfnJcAQX3cy/tA0SiFicwFFYy4XS1WKM5Ekv5arWS6nvgHocvHy
         TMRzhY75a26u22YhA0IXzKMKTGMIokolvt/wHQuMmniQ5KwFBtsAl16cDn+bO1KV5yQC
         IMRgxunwLY/8Ew6qSbUSZFtgzo+vFbGKyMe4zAZOV/3FaMzJ5oTR2pFG7o54gZIsds97
         pO8KJrhC36tjHqO0wtuZnw+LtJPRsu+bS7ubGz0wlvMYk+tV6K9Phb899yvHMgjF0SgD
         B6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709284756; x=1709889556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mB8cpSFUHI2v28tFlR/YUHSb5lk45+n/9IYk3vd50wk=;
        b=ADByS+jmxHtmAnmf0h/yMPvuWgHMQWz+qKv2M9OCB/wiOqrkUMT9W1kWuiNzxwHLXY
         R6Z5wnMEc/ixlouV/2Rw/EZV6DjwmVJXDXqbgVBZR0DnK4U7cVThaU9c92ak4NJpx2z4
         +KfLq/skcIEkn1JpAj+HNvrRKHBlavzHn3CRt7GarmRT+vt0MzncQFLKY5TpBZWdVZlu
         +W4tmi0b1eDoraX+Vq98u4Qki6J9V8ctXSXERA59FSsjfP8HDmfA6qddCvZ7qoEJ1A4l
         wTNkXSKl3BL/WSXzQnXYweYIlUKOE9mVXSjisrKdGXoABr2Z/J8rvYnwRI1RgJK1fZYj
         eB0A==
X-Forwarded-Encrypted: i=1; AJvYcCUHhtu93ZxmQokc/g0SALx9bubSCS2Q5kxJQSg5EqX9eazhkNv0y1/Usk6NiEBKR4L9mgSwIlRAdbvsv9Ki2izNevtiDglnWawHgOZn
X-Gm-Message-State: AOJu0YzyBdqKILKzdDMuPi6oJIKlP8mYYtSkb8AFbo0ptlMk+k7rDmri
	/AncnH8+8LKh6qG0LmFGPcCfmdCD8HMA28v9MoAdu7lqD5QwPTB0/TiYzk7SUVM=
X-Google-Smtp-Source: AGHT+IHpEyM7pTJk28YugLtMmnzHnlZqFOrfhIPrp2GM/yv98BwZmlX0jtBa8/Iqo86IkfuCuT/7uw==
X-Received: by 2002:adf:9dca:0:b0:33e:1a3f:44b4 with SMTP id q10-20020adf9dca000000b0033e1a3f44b4mr1239957wre.26.1709284756335;
        Fri, 01 Mar 2024 01:19:16 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id bv16-20020a0560001f1000b0033e0523b829sm4144440wrb.13.2024.03.01.01.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:19:16 -0800 (PST)
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
Subject: [PATCH 4/9] mm: Use common set_huge_pte_at() function for riscv/arm64
Date: Fri,  1 Mar 2024 10:14:50 +0100
Message-Id: <20240301091455.246686-5-alexghiti@rivosinc.com>
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
so move it to generic code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/pgtable.h | 16 ++++++---
 arch/arm64/mm/hugetlbpage.c      | 56 -----------------------------
 arch/riscv/include/asm/pgtable.h | 26 ++++++++++----
 arch/riscv/mm/hugetlbpage.c      | 62 --------------------------------
 mm/contpte.c                     | 58 ++++++++++++++++++++++++++++++
 5 files changed, 88 insertions(+), 130 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3003a10547de..437e9638b2b9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -341,9 +341,10 @@ static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
 		mte_sync_tags(pte, nr_pages);
 }
 
-static inline void set_ptes(struct mm_struct *mm,
-			    unsigned long __always_unused addr,
-			    pte_t *ptep, pte_t pte, unsigned int nr)
+static inline void __set_ptes(struct mm_struct *mm,
+			      unsigned long __always_unused addr,
+			      pte_t *ptep, pte_t pte, unsigned int nr,
+			      unsigned long pgsize)
 {
 	page_table_check_ptes_set(mm, ptep, pte, nr);
 	__sync_cache_and_tags(pte, nr);
@@ -354,10 +355,15 @@ static inline void set_ptes(struct mm_struct *mm,
 		if (--nr == 0)
 			break;
 		ptep++;
-		pte_val(pte) += PAGE_SIZE;
+		pte_val(pte) += pgsize;
 	}
 }
-#define set_ptes set_ptes
+
+#define set_ptes(mm, addr, ptep, pte, nr)				\
+			__set_ptes(mm, addr, ptep, pte, nr, PAGE_SIZE)
+
+#define set_contptes(mm, addr, ptep, pte, nr, pgsize)			\
+			__set_ptes(mm, addr, ptep, pte, nr, pgsize)
 
 /*
  * Huge pte definitions.
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 6b61714d7726..4da951e81bde 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -166,62 +166,6 @@ static pte_t get_clear_contig_flush(struct mm_struct *mm,
 	return orig_pte;
 }
 
-/*
- * Changing some bits of contiguous entries requires us to follow a
- * Break-Before-Make approach, breaking the whole contiguous set
- * before we can change any entries. See ARM DDI 0487A.k_iss10775,
- * "Misprogramming of the Contiguous bit", page D4-1762.
- *
- * This helper performs the break step for use cases where the
- * original pte is not needed.
- */
-static void clear_flush(struct mm_struct *mm,
-			     unsigned long addr,
-			     pte_t *ptep,
-			     unsigned long pgsize,
-			     unsigned long ncontig)
-{
-	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
-	unsigned long i, saddr = addr;
-
-	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
-		ptep_clear(mm, addr, ptep);
-
-	flush_tlb_range(&vma, saddr, addr);
-}
-
-void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-			    pte_t *ptep, pte_t pte, unsigned long sz)
-{
-	size_t pgsize;
-	int i;
-	int ncontig;
-	unsigned long pfn, dpfn;
-	pgprot_t hugeprot;
-
-	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
-
-	if (!pte_present(pte)) {
-		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
-			set_pte_at(mm, addr, ptep, pte);
-		return;
-	}
-
-	if (!pte_cont(pte)) {
-		set_pte_at(mm, addr, ptep, pte);
-		return;
-	}
-
-	pfn = pte_pfn(pte);
-	dpfn = pgsize >> PAGE_SHIFT;
-	hugeprot = pte_pgprot(pte);
-
-	clear_flush(mm, addr, ptep, pgsize, ncontig);
-
-	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
-}
-
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, unsigned long sz)
 {
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ddff4a56e12d..03f8ced8b26a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -533,29 +533,39 @@ static inline void __set_pte_at(pte_t *ptep, pte_t pteval)
 static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
 					      size_t *pgsize)
 {
+	unsigned long hugepage_shift;
 	pte_t __pte;
 
 	/* We must read the raw value of the pte to get the size of the mapping */
 	__pte = READ_ONCE(*ptep);
 
-	if (pgsize) {
-		if (size >= PGDIR_SIZE)
+	if (size >= PGDIR_SIZE) {
+		if (pgsize)
 			*pgsize = PGDIR_SIZE;
-		else if (size >= P4D_SIZE)
+		hugepage_shift = PGDIR_SHIFT;
+	} else if (size >= P4D_SIZE) {
+		if (pgsize)
 			*pgsize = P4D_SIZE;
-		else if (size >= PUD_SIZE)
+		hugepage_shift = P4D_SHIFT;
+	} else if (size >= PUD_SIZE) {
+		if (pgsize)
 			*pgsize = PUD_SIZE;
-		else if (size >= PMD_SIZE)
+		hugepage_shift = PUD_SHIFT;
+	} else if (size >= PMD_SIZE) {
+		if (pgsize)
 			*pgsize = PMD_SIZE;
-		else
+		hugepage_shift = PMD_SHIFT;
+	} else {
+		if (pgsize)
 			*pgsize = PAGE_SIZE;
+		hugepage_shift = PAGE_SHIFT;
 	}
 
 	/* Make sure __pte is not a swap entry */
 	if (pte_valid_napot(__pte))
 		return napot_pte_num(napot_cont_order(__pte));
 
-	return 1;
+	return size >> hugepage_shift;
 }
 #endif
 
@@ -631,6 +641,8 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	}
 }
 #define set_ptes set_ptes
+#define set_contptes(mm, addr, ptep, pte, nr, pgsize)			\
+			set_ptes(mm, addr, ptep, pte, nr)
 
 static inline void pte_clear(struct mm_struct *mm,
 	unsigned long addr, pte_t *ptep)
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 51ec80cf2028..ebc735f5d325 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -173,68 +173,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-static void clear_flush(struct mm_struct *mm,
-			unsigned long addr,
-			pte_t *ptep,
-			unsigned long pgsize,
-			unsigned long ncontig)
-{
-	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
-	unsigned long i, saddr = addr;
-
-	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
-		ptep_get_and_clear(mm, addr, ptep);
-
-	flush_tlb_range(&vma, saddr, addr);
-}
-
-/*
- * When dealing with NAPOT mappings, the privileged specification indicates that
- * "if an update needs to be made, the OS generally should first mark all of the
- * PTEs invalid, then issue SFENCE.VMA instruction(s) covering all 4 KiB regions
- * within the range, [...] then update the PTE(s), as described in Section
- * 4.2.1.". That's the equivalent of the Break-Before-Make approach used by
- * arm64.
- */
-void set_huge_pte_at(struct mm_struct *mm,
-		     unsigned long addr,
-		     pte_t *ptep,
-		     pte_t pte,
-		     unsigned long sz)
-{
-	unsigned long hugepage_shift, pgsize;
-	int i, pte_num;
-
-	if (sz >= PGDIR_SIZE)
-		hugepage_shift = PGDIR_SHIFT;
-	else if (sz >= P4D_SIZE)
-		hugepage_shift = P4D_SHIFT;
-	else if (sz >= PUD_SIZE)
-		hugepage_shift = PUD_SHIFT;
-	else if (sz >= PMD_SIZE)
-		hugepage_shift = PMD_SHIFT;
-	else
-		hugepage_shift = PAGE_SHIFT;
-
-	pte_num = sz >> hugepage_shift;
-	pgsize = 1 << hugepage_shift;
-
-	if (!pte_present(pte)) {
-		for (i = 0; i < pte_num; i++, ptep++, addr += pgsize)
-			set_ptes(mm, addr, ptep, pte, 1);
-		return;
-	}
-
-	if (!pte_napot(pte)) {
-		set_ptes(mm, addr, ptep, pte, 1);
-		return;
-	}
-
-	clear_flush(mm, addr, ptep, pgsize, pte_num);
-
-	set_ptes(mm, addr, ptep, pte, pte_num);
-}
-
 int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       unsigned long addr,
 			       pte_t *ptep,
diff --git a/mm/contpte.c b/mm/contpte.c
index c3f4b8039b19..f7bfa861c6a1 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -12,11 +12,13 @@
  * * contpte macros
  *   - pte_cont()
  *   - arch_contpte_get_num_contig()
+ *   - set_contptes()
  */
 
 /*
  * This file implements the following contpte aware API:
  * huge_ptep_get()
+ * set_huge_pte_at()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -43,3 +45,59 @@ pte_t huge_ptep_get(pte_t *ptep)
 	}
 	return orig_pte;
 }
+
+/*
+ * ARM64: Changing some bits of contiguous entries requires us to follow a
+ * Break-Before-Make approach, breaking the whole contiguous set
+ * before we can change any entries. See ARM DDI 0487A.k_iss10775,
+ * "Misprogramming of the Contiguous bit", page D4-1762.
+ *
+ * RISCV: When dealing with NAPOT mappings, the privileged specification
+ * indicates that "if an update needs to be made, the OS generally should first
+ * mark all of the PTEs invalid, then issue SFENCE.VMA instruction(s) covering
+ * all 4 KiB regions within the range, [...] then update the PTE(s), as
+ * described in Section 4.2.1.". That's the equivalent of the Break-Before-Make
+ * approach used by arm64.
+ *
+ * This helper performs the break step for use cases where the
+ * original pte is not needed.
+ */
+static void clear_flush(struct mm_struct *mm,
+			unsigned long addr,
+			pte_t *ptep,
+			unsigned long pgsize,
+			unsigned long ncontig)
+{
+	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+	unsigned long i, saddr = addr;
+
+	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
+		ptep_clear(mm, addr, ptep);
+
+	flush_tlb_range(&vma, saddr, addr);
+}
+
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+		     pte_t *ptep, pte_t pte, unsigned long sz)
+{
+	size_t pgsize;
+	int i;
+	int ncontig;
+
+	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
+
+	if (!pte_present(pte)) {
+		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
+			set_pte_at(mm, addr, ptep, pte);
+		return;
+	}
+
+	if (!pte_cont(pte)) {
+		set_pte_at(mm, addr, ptep, pte);
+		return;
+	}
+
+	clear_flush(mm, addr, ptep, pgsize, ncontig);
+
+	set_contptes(mm, addr, ptep, pte, ncontig, pgsize);
+}
-- 
2.39.2


