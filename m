Return-Path: <linux-kernel+bounces-88165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8349A86DE13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA218B26B80
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBDA6A33F;
	Fri,  1 Mar 2024 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="B+bGAjCR"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B501E886
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284882; cv=none; b=udl+0h5CwjTZVwrgj/myukeV5mmcDM/rCEDmfkLvR28bau8KY/LskGnKzWX362mHujAkjxFmuMpGgLSsl4/yhGrBzV03pWiL5i0fzSl+ljRKI0pde3zG4nlW02qgPjqX41Gve+6KF+utiCqftBw1NlmlwVpJRxqF+mShL4kLGl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284882; c=relaxed/simple;
	bh=nZL7SCApwbfJRaEZ1HgnD4H5WYTWB5+0lXq/w41ioHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDsSiZ0MccZf68pqnJfvjbYut2RFK3ELFXWk1R0BCKhQduo0metp0X2TcwundVB+KyaqcAK26bmDRRyvzXJ0iGZhM5Kn0KM4Erd34v0B2+3+jJ8XMmpFHfPbQ3Dd6Ipd7AGFqBS676kLB2H2GbzXvEcxOB9dvd9Uu7WlpHOdP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=B+bGAjCR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e1207bba1so1028381f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 01:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709284878; x=1709889678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roMginZSvi1o0fjo+EUJOo1pu0LVGawrxcxtyn24YPc=;
        b=B+bGAjCRErv1emgAe/JcKQ1GGvaqUR+dsTusu5hD2SOMGq/RZr3XUvkIvOHsPOrEfQ
         AsP0+D52Bl+lFqE1rAZv0zGh5FiKmz651UKdddD5btszA1LYWRQOmTnF4EcO3/g3LpXk
         WcKt6/0qQVeRU2LXTW7ZIkW6XLsCYyJTFyxfEHxTR+wxNu/0784n//j6ct2VdowVSETh
         XBWDrAivJly6dVWOzOw//frAyw64iDJ4jcOJNu67L2VWCx59kGeCgVyJu9UegbtB+SC6
         Fm4ZF3lakbW1Qjfla+cDIHAH+J8ML2yX22f0+B+k0cpSE1ZsYFi97UoKVQ3OBAyQwJJF
         KoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709284878; x=1709889678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roMginZSvi1o0fjo+EUJOo1pu0LVGawrxcxtyn24YPc=;
        b=RFAwZI54FvuG8RP+XeoTPrTeWLZsMfP/OvM2TXJ7gf9zIc4l/IBNKqwckimnrpRtGr
         LQ1ckLtmtZfRYzJkzgET8IrIeps0rE5F2VM9yxSwPd6cIYw74xUcnY7V42RuD+QkCX+j
         blrayYon/26WQm4vozgNPwC/I8utVSN1/v8ZHwCunwf6AhWV8xvxFxdpSRRrqf5Yuz6L
         m+1eRsTuReJxrE5LAPrB/Du3Ym+dA4c3Lj3CaPHnUcUM6/7ixuJON9gLX6ClV2IHM3A8
         Lwp0s/Sjc9WUmg0cFfUPE7KFgBcWloQ9Kuu/dIU/Rq7gei0SdqpyK6JmsniI2K3ggi+h
         WTjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzQbdHKuaagd/0fHCJ3p5pG5j+tlEfZfdpLhZ1ACc7AfZtYwKr3HjMcaDZROhJHN2r4970WlDYc+ZA8UtcMLj9h0MjAbaSsyhxNi/K
X-Gm-Message-State: AOJu0YzJ7gZSa78Tde3csVrCK6pwxX0gB1hXP42ijtZmjhGF8Sr8UAjo
	uqo/DRMMtNZJtXhY32m74P2sr2yzNHFGGK2EibLjwDZUUvhBppY99LsbIk2qyrA=
X-Google-Smtp-Source: AGHT+IHE36Cx0pzkf7/PwROG0sFnOnPILtKg/5tjC2XGRavDiE3m4OmzpuOVj7dxMVbSTb8/7tKiwA==
X-Received: by 2002:adf:f24e:0:b0:33d:c5c5:9bc6 with SMTP id b14-20020adff24e000000b0033dc5c59bc6mr893274wrp.54.1709284878472;
        Fri, 01 Mar 2024 01:21:18 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id i6-20020adfb646000000b0033e033898c5sm4044660wre.20.2024.03.01.01.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:21:18 -0800 (PST)
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
Subject: [PATCH 6/9] mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
Date: Fri,  1 Mar 2024 10:14:52 +0100
Message-Id: <20240301091455.246686-7-alexghiti@rivosinc.com>
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

Note that get_clear_contig() function is duplicated in the generic and
the arm64 code because it is still used by some arm64 functions that
will, in the next commits, be moved to the generic code. Once all have
been moved, the arm64 version will be removed.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/pgtable.h | 14 +++++++++-
 arch/arm64/mm/hugetlbpage.c      | 19 ++-----------
 arch/riscv/include/asm/pgtable.h |  4 ++-
 arch/riscv/mm/hugetlbpage.c      | 21 ++------------
 mm/contpte.c                     | 48 ++++++++++++++++++++++++++++++--
 5 files changed, 66 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 437e9638b2b9..b5caf7a9d03f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1131,11 +1131,23 @@ extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
 				    unsigned long addr, pte_t *ptep,
 				    pte_t old_pte, pte_t new_pte);
 
-static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
+int find_num_contig(struct mm_struct *mm, unsigned long addr,
+		    pte_t *ptep, size_t *pgsize);
+
+static inline int arch_contpte_get_num_contig(struct mm_struct *mm,
+					      unsigned long addr,
+					      pte_t *ptep, unsigned long size,
 					      size_t *pgsize)
 {
 	int contig_ptes = 0;
 
+	/*
+	 * If the size is not passed, we need to go through the page table to
+	 * find out the number of contiguous ptes.
+	 */
+	if (size == 0)
+		return find_num_contig(mm, addr, ptep, pgsize);
+
 	*pgsize = size;
 
 	switch (size) {
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 09b55bac8c7c..a2d33cbc7da5 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -100,8 +100,8 @@ int pud_huge(pud_t pud)
 #endif
 }
 
-static int find_num_contig(struct mm_struct *mm, unsigned long addr,
-			   pte_t *ptep, size_t *pgsize)
+int find_num_contig(struct mm_struct *mm, unsigned long addr,
+		    pte_t *ptep, size_t *pgsize)
 {
 	pgd_t *pgdp = pgd_offset(mm, addr);
 	p4d_t *p4dp;
@@ -284,21 +284,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep)
-{
-	int ncontig;
-	size_t pgsize;
-	pte_t orig_pte = ptep_get(ptep);
-
-	if (!pte_cont(orig_pte))
-		return ptep_get_and_clear(mm, addr, ptep);
-
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
-
-	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
-}
-
 /*
  * huge_ptep_set_access_flags will update access flags (dirty, accesssed)
  * and write permission.
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 03f8ced8b26a..1cb877f0d0ce 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -530,7 +530,9 @@ static inline void __set_pte_at(pte_t *ptep, pte_t pteval)
 }
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
-static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
+static inline int arch_contpte_get_num_contig(struct mm_struct *mm,
+					      unsigned long addr,
+					      pte_t *ptep, unsigned long size,
 					      size_t *pgsize)
 {
 	unsigned long hugepage_shift;
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 01b1403dd4cb..4c441664db8a 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -187,7 +187,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	if (!pte_napot(pte))
 		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 
-	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
+	pte_num = arch_contpte_get_num_contig(vma->vm_mm, addr, ptep, 0, &pgsize);
 
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
@@ -202,21 +202,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	return true;
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr,
-			      pte_t *ptep)
-{
-	pte_t orig_pte = ptep_get(ptep);
-	int pte_num;
-
-	if (!pte_napot(orig_pte))
-		return ptep_get_and_clear(mm, addr, ptep);
-
-	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
-
-	return get_clear_contig(mm, addr, ptep, pte_num);
-}
-
 void huge_ptep_set_wrprotect(struct mm_struct *mm,
 			     unsigned long addr,
 			     pte_t *ptep)
@@ -231,7 +216,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 		return;
 	}
 
-	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
+	pte_num = arch_contpte_get_num_contig(mm, addr, ptep, 0, &pgsize);
 
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 	orig_pte = pte_wrprotect(orig_pte);
@@ -249,7 +234,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 	if (!pte_napot(pte))
 		return ptep_clear_flush(vma, addr, ptep);
 
-	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
+	pte_num = arch_contpte_get_num_contig(vma->vm_mm, addr, ptep, 0, NULL);
 
 	return get_clear_contig_flush(vma->vm_mm, addr, ptep, pte_num);
 }
diff --git a/mm/contpte.c b/mm/contpte.c
index 5200c234404d..8d2ab391e0d8 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -20,6 +20,7 @@
  * huge_ptep_get()
  * set_huge_pte_at()
  * huge_pte_clear()
+ * huge_ptep_get_and_clear()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -31,7 +32,7 @@ pte_t huge_ptep_get(pte_t *ptep)
 	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
 		return orig_pte;
 
-	ncontig = arch_contpte_get_num_contig(ptep,
+	ncontig = arch_contpte_get_num_contig(NULL, 0, ptep,
 					      page_size(pte_page(orig_pte)),
 					      &pgsize);
 
@@ -85,7 +86,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	int i;
 	int ncontig;
 
-	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
+	ncontig = arch_contpte_get_num_contig(mm, addr, ptep, sz, &pgsize);
 
 	if (!pte_present(pte)) {
 		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
@@ -109,8 +110,49 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 	int i, ncontig;
 	size_t pgsize;
 
-	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
+	ncontig = arch_contpte_get_num_contig(mm, addr, ptep, sz, &pgsize);
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		pte_clear(mm, addr, ptep);
 }
+
+static pte_t get_clear_contig(struct mm_struct *mm,
+			      unsigned long addr,
+			      pte_t *ptep,
+			      unsigned long pgsize,
+			      unsigned long ncontig)
+{
+	pte_t orig_pte = ptep_get(ptep);
+	unsigned long i;
+
+	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
+		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
+
+		/*
+		 * If HW_AFDBM (arm64) or svadu (riscv) is enabled, then the HW
+		 * could turn on the dirty or accessed bit for any page in the
+		 * set, so check them all.
+		 */
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+	return orig_pte;
+}
+
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+			      unsigned long addr, pte_t *ptep)
+{
+	int ncontig;
+	size_t pgsize;
+	pte_t orig_pte = ptep_get(ptep);
+
+	if (!pte_cont(orig_pte))
+		return ptep_get_and_clear(mm, addr, ptep);
+
+	ncontig = arch_contpte_get_num_contig(mm, addr, ptep, 0, &pgsize);
+
+	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
+}
-- 
2.39.2


