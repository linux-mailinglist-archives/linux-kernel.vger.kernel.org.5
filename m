Return-Path: <linux-kernel+bounces-38001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBDC83B983
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BD01F23CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B78510A1A;
	Thu, 25 Jan 2024 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PbUeXMHN"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E310A01
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706163676; cv=none; b=cfVXONAtK0Xu68jrSfw4T2l5bw6wOhlvsDlqVePG+kv5CC/mfjnfC3hT15ZnjK8oHwPMNPx6iFjKAjV++EsDuvIM3D25B3Dpj3kZYR1wBaeARhDi0AQ4t7lBPcJnY7T5ke7MUvgjkNmcy+qv47BTOBemu6kpq6cGSSFICLrSSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706163676; c=relaxed/simple;
	bh=WQ34X3WLZeHSGMgsLwMbbgFkRkuawngcwUJDVWNpEo8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=f4wKxMGTPXrmYBXQRiUFjCi++2JNh1bYES1XhyWDwkdt+o0MK8w+pK6SmEHNGAL7KdJgJric157Wus0QcjTtgaa/Ea0GQkJQdpCn0SloAaSfAPZ2D3ecJB+Jl9OK+VdrfLCdfFQo8NrTqj9dnKPVDZsQs7uxyvQfxj2BMCctRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PbUeXMHN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6daa89a6452so4535154b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706163673; x=1706768473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8deh7BuQ3ts/uLqk4/wq+JNmxtV0Ltxd2gA+4lq+yEo=;
        b=PbUeXMHNfbiU46ZcjvjTr5T8ASQ7HB7phPQvPcnHEo7yjKG6LeGe7HTL5RDVlGVFV1
         5iEpr0Ap5PS8E8aw/0zQD9L/JAswEbXpKA+D10xiL4lajuYqo1NTiftxb5A060sllDRF
         RPHJQnSCgxBv2AyqeAMxV62SCk2HSIqW8ZVzbs78TsyEryXP+/xfQdenfqRJmswAxbp+
         WbrCXvAHoDVs7TUxX0OyfELmJXYxutIXPAiymyTboSNBsDhdRsAfpOCGBHMm0NXCPkGN
         bIPI/Aw3+TRJyCGn4VUIUM9Cq8RrPMnAXBtYIlpDa6fLxbBuefqq3cP6c3I/ItjiJrBv
         XhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706163673; x=1706768473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8deh7BuQ3ts/uLqk4/wq+JNmxtV0Ltxd2gA+4lq+yEo=;
        b=QqU+EiiCtrdhV1u4X2CB5OmotZc4iRCLe7Mn5nhrG8C3ZfW1fa8YNmCh1iTM0LlFMs
         wdHhEVzX7KhVFDjvVWLLwqiLEz4oaFBsKfi9eR3+P0dyp47sJttKGwzK1BLdysZzqso/
         g57tAtC+lbsFUp89Aeh0uIqQrPhESLQgCmBjeLgJPq6pedvSljbjftuCnk3S0Ff+HyYw
         UILDnma061RPeHopl1852T8rZlyfWrF9eHbe/zjSmV1xJrr7WJMtqAMqP8oP9zIYohA7
         quSkB9rK2cVV6HpfksGbMESA3x0dzeoU0cOIikIKXjXHg3O8WHesYECBsiY8N/M0dtcX
         Salg==
X-Gm-Message-State: AOJu0YzCPRhbtdKG2pCus1dOANMSVvC42U4cGmZVjcxzK7DqmgHLkk/6
	11F6rYXui0gwmrs+GU0HjQAupqEZXsYGEzW+VjQS7zq0U5fJSXm0Umpd1eovhus=
X-Google-Smtp-Source: AGHT+IH46YRis6VxF4OPTBhmquFzd7OOMDXdftqgNuUXP+2HmAoBvyd9StGt2p3s+V98j2j3v1iekw==
X-Received: by 2002:a05:6a20:3caa:b0:19c:4ebc:126c with SMTP id b42-20020a056a203caa00b0019c4ebc126cmr490378pzj.86.1706163673232;
        Wed, 24 Jan 2024 22:21:13 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id ev7-20020a17090aeac700b0029105d49b2dsm701779pjb.20.2024.01.24.22.21.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Jan 2024 22:21:12 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	ajones@ventanamicro.com,
	mchitale@ventanamicro.com,
	dylan@andestech.com,
	cuiyunhui@bytedance.com,
	sergey.matyukevich@syntacore.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	jszhang@kernel.org,
	apatel@ventanamicro.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: add uniprocessor flush_tlb_range() support
Date: Thu, 25 Jan 2024 14:20:44 +0800
Message-Id: <20240125062044.63344-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for flush_tlb_range() to improve TLB performance for
UP systems. In order to avoid the mutual inclusion of tlbflush.h
and hugetlb.h, the UP part is also implemented in tlbflush.c.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/tlbflush.h |  61 ++++++----
 arch/riscv/mm/Makefile            |   2 +-
 arch/riscv/mm/tlbflush.c          | 195 ++++++++++++++++++------------
 3 files changed, 156 insertions(+), 102 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 928f096dca21..426f043fb450 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -10,12 +10,21 @@
 #include <linux/mm_types.h>
 #include <asm/smp.h>
 #include <asm/errata_list.h>
+#include <asm/tlbbatch.h>
 
 #define FLUSH_TLB_MAX_SIZE      ((unsigned long)-1)
 #define FLUSH_TLB_NO_ASID       ((unsigned long)-1)
 
 #ifdef CONFIG_MMU
 extern unsigned long asid_mask;
+DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
+
+struct flush_tlb_range_data {
+	unsigned long asid;
+	unsigned long start;
+	unsigned long size;
+	unsigned long stride;
+};
 
 static inline void local_flush_tlb_all(void)
 {
@@ -27,12 +36,40 @@ static inline void local_flush_tlb_page(unsigned long addr)
 {
 	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
 }
+
+static inline void local_flush_tlb_all_asid(unsigned long asid)
+{
+	if (asid != FLUSH_TLB_NO_ASID)
+		__asm__ __volatile__ ("sfence.vma x0, %0"
+				:
+				: "r" (asid)
+				: "memory");
+	else
+		local_flush_tlb_all();
+}
+
+static inline void local_flush_tlb_page_asid(unsigned long addr,
+		unsigned long asid)
+{
+	if (asid != FLUSH_TLB_NO_ASID)
+		__asm__ __volatile__ ("sfence.vma %0, %1"
+				:
+				: "r" (addr), "r" (asid)
+				: "memory");
+	else
+		local_flush_tlb_page(addr);
+}
+
+static inline unsigned long get_mm_asid(struct mm_struct *mm)
+{
+	return static_branch_unlikely(&use_asid_allocator) ?
+			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
+}
 #else /* CONFIG_MMU */
 #define local_flush_tlb_all()			do { } while (0)
 #define local_flush_tlb_page(addr)		do { } while (0)
 #endif /* CONFIG_MMU */
 
-#if defined(CONFIG_SMP) && defined(CONFIG_MMU)
 void flush_tlb_all(void);
 void flush_tlb_mm(struct mm_struct *mm);
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
@@ -55,26 +92,4 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
 void arch_flush_tlb_batched_pending(struct mm_struct *mm);
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
-#else /* CONFIG_SMP && CONFIG_MMU */
-
-#define flush_tlb_all() local_flush_tlb_all()
-#define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
-
-static inline void flush_tlb_range(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end)
-{
-	local_flush_tlb_all();
-}
-
-/* Flush a range of kernel pages */
-static inline void flush_tlb_kernel_range(unsigned long start,
-	unsigned long end)
-{
-	local_flush_tlb_all();
-}
-
-#define flush_tlb_mm(mm) flush_tlb_all()
-#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
-#endif /* !CONFIG_SMP || !CONFIG_MMU */
-
 #endif /* _ASM_RISCV_TLBFLUSH_H */
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 2c869f8026a8..7c6c4c858a6b 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -19,7 +19,7 @@ obj-y += context.o
 obj-y += pmem.o
 
 ifeq ($(CONFIG_MMU),y)
-obj-$(CONFIG_SMP) += tlbflush.o
+obj-y += tlbflush.o
 endif
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 8d12b26f5ac3..4765603fa08a 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -6,28 +6,36 @@
 #include <linux/hugetlb.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
+#include <asm/tlbflush.h>
 
-static inline void local_flush_tlb_all_asid(unsigned long asid)
+static unsigned long get_stride_size(struct vm_area_struct *vma)
 {
-	if (asid != FLUSH_TLB_NO_ASID)
-		__asm__ __volatile__ ("sfence.vma x0, %0"
-				:
-				: "r" (asid)
-				: "memory");
-	else
-		local_flush_tlb_all();
-}
+	unsigned long stride_size;
 
-static inline void local_flush_tlb_page_asid(unsigned long addr,
-		unsigned long asid)
-{
-	if (asid != FLUSH_TLB_NO_ASID)
-		__asm__ __volatile__ ("sfence.vma %0, %1"
-				:
-				: "r" (addr), "r" (asid)
-				: "memory");
-	else
-		local_flush_tlb_page(addr);
+	if (!is_vm_hugetlb_page(vma))
+		return PAGE_SIZE;
+
+	stride_size = huge_page_size(hstate_vma(vma));
+
+	/*
+	 * As stated in the privileged specification, every PTE in a
+	 * NAPOT region must be invalidated, so reset the stride in that
+	 * case.
+	 */
+	if (has_svnapot()) {
+		if (stride_size >= PGDIR_SIZE)
+			stride_size = PGDIR_SIZE;
+		else if (stride_size >= P4D_SIZE)
+			stride_size = P4D_SIZE;
+		else if (stride_size >= PUD_SIZE)
+			stride_size = PUD_SIZE;
+		else if (stride_size >= PMD_SIZE)
+			stride_size = PMD_SIZE;
+		else
+			stride_size = PAGE_SIZE;
+	}
+
+	return stride_size;
 }
 
 /*
@@ -66,31 +74,12 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
 		local_flush_tlb_range_threshold_asid(start, size, stride, asid);
 }
 
-void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
-{
-	local_flush_tlb_range_asid(start, end, PAGE_SIZE, FLUSH_TLB_NO_ASID);
-}
-
+#ifdef CONFIG_SMP
 static void __ipi_flush_tlb_all(void *info)
 {
 	local_flush_tlb_all();
 }
 
-void flush_tlb_all(void)
-{
-	if (riscv_use_ipi_for_rfence())
-		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
-	else
-		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
-}
-
-struct flush_tlb_range_data {
-	unsigned long asid;
-	unsigned long start;
-	unsigned long size;
-	unsigned long stride;
-};
-
 static void __ipi_flush_tlb_range_asid(void *info)
 {
 	struct flush_tlb_range_data *d = info;
@@ -138,10 +127,18 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
 		put_cpu();
 }
 
-static inline unsigned long get_mm_asid(struct mm_struct *mm)
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	return static_branch_unlikely(&use_asid_allocator) ?
-			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
+	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+			  addr, PAGE_SIZE, PAGE_SIZE);
+}
+
+void flush_tlb_all(void)
+{
+	if (riscv_use_ipi_for_rfence())
+		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
+	else
+		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
@@ -158,41 +155,12 @@ void flush_tlb_mm_range(struct mm_struct *mm,
 			  start, end - start, page_size);
 }
 
-void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
-{
-	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
-			  addr, PAGE_SIZE, PAGE_SIZE);
-}
-
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
 	unsigned long stride_size;
 
-	if (!is_vm_hugetlb_page(vma)) {
-		stride_size = PAGE_SIZE;
-	} else {
-		stride_size = huge_page_size(hstate_vma(vma));
-
-		/*
-		 * As stated in the privileged specification, every PTE in a
-		 * NAPOT region must be invalidated, so reset the stride in that
-		 * case.
-		 */
-		if (has_svnapot()) {
-			if (stride_size >= PGDIR_SIZE)
-				stride_size = PGDIR_SIZE;
-			else if (stride_size >= P4D_SIZE)
-				stride_size = P4D_SIZE;
-			else if (stride_size >= PUD_SIZE)
-				stride_size = PUD_SIZE;
-			else if (stride_size >= PMD_SIZE)
-				stride_size = PMD_SIZE;
-			else
-				stride_size = PAGE_SIZE;
-		}
-	}
-
+	stride_size = get_stride_size(vma);
 	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
 			  start, end - start, stride_size);
 }
@@ -203,6 +171,12 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 			  start, end - start, PAGE_SIZE);
 }
 
+void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
+{
+	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
+			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end)
@@ -212,6 +186,77 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 }
 #endif
 
+#else
+static void __flush_tlb_range_up(struct mm_struct *mm, unsigned long start,
+				 unsigned long size, unsigned long stride)
+{
+	unsigned long asid = FLUSH_TLB_NO_ASID;
+
+	if (mm)
+		asid = get_mm_asid(mm);
+
+	local_flush_tlb_range_asid(start, size, stride, asid);
+}
+
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
+{
+	local_flush_tlb_page(addr);
+}
+
+void flush_tlb_all(void)
+{
+	local_flush_tlb_all();
+}
+
+void flush_tlb_mm(struct mm_struct *mm)
+{
+	__flush_tlb_range_up(mm, 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
+}
+
+void flush_tlb_mm_range(struct mm_struct *mm,
+			unsigned long start, unsigned long end,
+			unsigned int page_size)
+{
+	__flush_tlb_range_up(mm, start, end - start, page_size);
+}
+
+void flush_tlb_range(struct vm_area_struct *vma,
+		unsigned long start, unsigned long end)
+{
+	unsigned long stride_size;
+
+	stride_size = get_stride_size(vma);
+	__flush_tlb_range_up(vma->vm_mm, start, end - start, stride_size);
+}
+
+/* Flush a range of kernel pages */
+void flush_tlb_kernel_range(unsigned long start,
+	unsigned long end)
+{
+	__flush_tlb_range_up(NULL, start, end - start, PAGE_SIZE);
+}
+
+void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
+{
+	__flush_tlb_range_up(NULL, 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end)
+{
+	__flush_tlb_range_up(vma->vm_mm, start, end - start, PMD_SIZE);
+}
+#endif
+
+#endif
+
+void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	local_flush_tlb_range_asid(start, end - start, PAGE_SIZE,
+				   FLUSH_TLB_NO_ASID);
+}
+
 bool arch_tlbbatch_should_defer(struct mm_struct *mm)
 {
 	return true;
@@ -228,9 +273,3 @@ void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 {
 	flush_tlb_mm(mm);
 }
-
-void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
-{
-	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
-			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
-}
-- 
2.20.1


