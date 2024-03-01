Return-Path: <linux-kernel+bounces-88167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2468F86DE17
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87A6283DC1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E312B6A33C;
	Fri,  1 Mar 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="w8pbEbCM"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2EA1E886
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284943; cv=none; b=rUsiW9+9u1lM92mrVymojIIE5ZKzeMm28wJmtaNlMKwhOlOiyL3KcgSEOpB07niDNWqPF2Al3OIXZ3ajQ5t0/aIdXwIv9Fs/BL4fhuY4IAnU2ZgCs2qrqmChlxi13Sx3ZK2JQMV15ce2ySpTUjFBXUjUuGUcrwXo6cKjMg6fHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284943; c=relaxed/simple;
	bh=ewaz0+30TL4hNr+v/Sd93KkOOVe261sfJ+PpKwEwyfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WwRgUOv1+IEc/4PFEXBSAuZbYR31O0g7uR1JW63nInLzjNEOJyNhgGnFsxJUhwt19rMKNC5leSIkDv08RvyyfB/ug7tWiTp05XO0rQ8UXsZDI0Y2YHSOJwMNkBhBaUrfilQMi3BkTOPPYkd0YPnbaLiHVuEmf0Zqx1om3oOnavc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=w8pbEbCM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e17fc5aceso535686f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 01:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709284939; x=1709889739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHzJQXP5BEIeqfOJsZUcjaIxOTpiaXVWcZpI+r0iAkE=;
        b=w8pbEbCMWfcSnm2Ysd0YIf+XZOkFG9506GVk0bLQC9RueKznXYTf13pvdyeUM/GyRu
         umhWfLQvWuiesqLBMwcdx2nfkc4HXvyVZQfEXKiNXqCI6MD+MoQC/7cADCsbTisiuVuA
         H3gZCGCbe9EW/bcHox2HB9blbapN1SxBKFQXM09wJHJM7WAWkG5MURZR6gdxNJk5LNyy
         xrAhznTK7+zGrofTh+VGeq0qLJTawxrPOiJNmP14YfF4vZqW++NwT0VVkehu/KFCRKNW
         IyHRkm6EiTLbyK9/sm8svqG7rc6sMLb/pWIDSdFjF4QSNoqvuappKXDWnEHc6ImvoYFu
         GrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709284939; x=1709889739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHzJQXP5BEIeqfOJsZUcjaIxOTpiaXVWcZpI+r0iAkE=;
        b=JFp98gXG4iKxXWFg9/4ff1QJV7+bW2tRTvWX6I3pdpOhr5HDebWk5GhF5DvM1pUvsd
         ZW0wCVqySvOf9hiDwaUI9iUi3ucMq6Jz/zZUmDmhHOivpVrmlFQrKJDKFalLyF8on+L0
         MbHvDUtrHEniRryVLoJENZBlmbreytcQ3865z74OeoziwuqyA8S2MZ6wUPkfPPSKFBX9
         OFcLs2sy/mZpd+mxQieJIWvNL/NJp0lKTx+1L/BJXq6METkG5o9uCf3vU1aYdWIz1UtT
         ZjNkGpwvfIGrkyPzc07IQE3HNI7ZX85528z5yBEqvIuiGUYlquNX0OAxUfTyx7ySN6nK
         T/Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXtHx41ziMl5ANVaTRZbohS0wP+0r2QQA43QrGZeiM3gs3dMPEbMJgUEIa+WMMbX8y1u8Xl1etJ4XH30ujOJz4AoQjYjp/AMxucICBC
X-Gm-Message-State: AOJu0Yy6gNDPiE/7Hjzk5vlCO0Tc/wIVgbdSONUopSBsKOx6UtxpCRqe
	kA4225haHUgf0p77j/LZqMrClOClg4+Ed3WmLdPyZmL35FkoSm/EEHO670koZ3g=
X-Google-Smtp-Source: AGHT+IETq5VRJHPuwhCoVEqwX4u/EPRIvAhXp1XnZCRkR4LhBkbxP9zDwDTrac3tIekTrNx6Id8PTw==
X-Received: by 2002:adf:f84c:0:b0:33d:39db:a0f8 with SMTP id d12-20020adff84c000000b0033d39dba0f8mr1044349wrq.7.1709284939471;
        Fri, 01 Mar 2024 01:22:19 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d594d000000b0033e12b2e567sm3302518wri.35.2024.03.01.01.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:22:19 -0800 (PST)
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
Subject: [PATCH 7/9] mm: Use common huge_ptep_set_access_flags() function for riscv/arm64
Date: Fri,  1 Mar 2024 10:14:53 +0100
Message-Id: <20240301091455.246686-8-alexghiti@rivosinc.com>
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

Both architectures have almost the same implementation:
__cont_access_flags_changed() is also correct on riscv and brings the
same benefits (ie don't do anything if the flags are unchanged).

As in the previous commit, get_clear_contig_flush() is duplicated in both
the arch and the generic codes, it will be removed from the arch code when
the last reference there gets moved to the generic code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/mm/hugetlbpage.c | 65 --------------------------------
 arch/riscv/mm/hugetlbpage.c | 29 ---------------
 mm/contpte.c                | 74 +++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 94 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index a2d33cbc7da5..b8abbd5ace4f 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -284,71 +284,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-/*
- * huge_ptep_set_access_flags will update access flags (dirty, accesssed)
- * and write permission.
- *
- * For a contiguous huge pte range we need to check whether or not write
- * permission has to change only on the first pte in the set. Then for
- * all the contiguous ptes we need to check whether or not there is a
- * discrepancy between dirty or young.
- */
-static int __cont_access_flags_changed(pte_t *ptep, pte_t pte, int ncontig)
-{
-	int i;
-
-	if (pte_write(pte) != pte_write(ptep_get(ptep)))
-		return 1;
-
-	for (i = 0; i < ncontig; i++) {
-		pte_t orig_pte = ptep_get(ptep + i);
-
-		if (pte_dirty(pte) != pte_dirty(orig_pte))
-			return 1;
-
-		if (pte_young(pte) != pte_young(orig_pte))
-			return 1;
-	}
-
-	return 0;
-}
-
-int huge_ptep_set_access_flags(struct vm_area_struct *vma,
-			       unsigned long addr, pte_t *ptep,
-			       pte_t pte, int dirty)
-{
-	int ncontig, i;
-	size_t pgsize = 0;
-	unsigned long pfn = pte_pfn(pte), dpfn;
-	struct mm_struct *mm = vma->vm_mm;
-	pgprot_t hugeprot;
-	pte_t orig_pte;
-
-	if (!pte_cont(pte))
-		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
-
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
-	dpfn = pgsize >> PAGE_SHIFT;
-
-	if (!__cont_access_flags_changed(ptep, pte, ncontig))
-		return 0;
-
-	orig_pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
-
-	/* Make sure we don't lose the dirty or young state */
-	if (pte_dirty(orig_pte))
-		pte = pte_mkdirty(pte);
-
-	if (pte_young(orig_pte))
-		pte = pte_mkyoung(pte);
-
-	hugeprot = pte_pgprot(pte);
-	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
-
-	return 1;
-}
-
 void huge_ptep_set_wrprotect(struct mm_struct *mm,
 			     unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 4c441664db8a..fdb633844d4b 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -173,35 +173,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-int huge_ptep_set_access_flags(struct vm_area_struct *vma,
-			       unsigned long addr,
-			       pte_t *ptep,
-			       pte_t pte,
-			       int dirty)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	size_t pgsize;
-	pte_t orig_pte;
-	int pte_num;
-
-	if (!pte_napot(pte))
-		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
-
-	pte_num = arch_contpte_get_num_contig(vma->vm_mm, addr, ptep, 0, &pgsize);
-
-	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
-
-	if (pte_dirty(orig_pte))
-		pte = pte_mkdirty(pte);
-
-	if (pte_young(orig_pte))
-		pte = pte_mkyoung(pte);
-
-	set_ptes(mm, addr, ptep, pte, pte_num);
-
-	return true;
-}
-
 void huge_ptep_set_wrprotect(struct mm_struct *mm,
 			     unsigned long addr,
 			     pte_t *ptep)
diff --git a/mm/contpte.c b/mm/contpte.c
index 8d2ab391e0d8..3b65c49c6d4b 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -21,6 +21,7 @@
  * set_huge_pte_at()
  * huge_pte_clear()
  * huge_ptep_get_and_clear()
+ * huge_ptep_set_access_flags()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -156,3 +157,76 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 
 	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
 }
+
+/*
+ * huge_ptep_set_access_flags will update access flags (dirty, accesssed)
+ * and write permission.
+ *
+ * For a contiguous huge pte range we need to check whether or not write
+ * permission has to change only on the first pte in the set. Then for
+ * all the contiguous ptes we need to check whether or not there is a
+ * discrepancy between dirty or young.
+ */
+static int __cont_access_flags_changed(pte_t *ptep, pte_t pte, int ncontig)
+{
+	int i;
+
+	if (pte_write(pte) != pte_write(ptep_get(ptep)))
+		return 1;
+
+	for (i = 0; i < ncontig; i++) {
+		pte_t orig_pte = ptep_get(ptep + i);
+
+		if (pte_dirty(pte) != pte_dirty(orig_pte))
+			return 1;
+
+		if (pte_young(pte) != pte_young(orig_pte))
+			return 1;
+	}
+
+	return 0;
+}
+
+static pte_t get_clear_contig_flush(struct mm_struct *mm,
+				    unsigned long addr,
+				    pte_t *ptep,
+				    unsigned long pgsize,
+				    unsigned long ncontig)
+{
+	pte_t orig_pte = get_clear_contig(mm, addr, ptep, pgsize, ncontig);
+	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+
+	flush_tlb_range(&vma, addr, addr + (pgsize * ncontig));
+	return orig_pte;
+}
+
+int huge_ptep_set_access_flags(struct vm_area_struct *vma,
+			       unsigned long addr, pte_t *ptep,
+			       pte_t pte, int dirty)
+{
+	int ncontig;
+	size_t pgsize = 0;
+	struct mm_struct *mm = vma->vm_mm;
+	pte_t orig_pte;
+
+	if (!pte_cont(pte))
+		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
+
+	ncontig = arch_contpte_get_num_contig(vma->vm_mm, addr, ptep, 0, &pgsize);
+
+	if (!__cont_access_flags_changed(ptep, pte, ncontig))
+		return 0;
+
+	orig_pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
+
+	/* Make sure we don't lose the dirty or young state */
+	if (pte_dirty(orig_pte))
+		pte = pte_mkdirty(pte);
+
+	if (pte_young(orig_pte))
+		pte = pte_mkyoung(pte);
+
+	set_contptes(mm, addr, ptep, pte, ncontig, pgsize);
+
+	return 1;
+}
-- 
2.39.2


