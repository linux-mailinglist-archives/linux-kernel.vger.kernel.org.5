Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DB37DAA23
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 01:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjJ1XNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 19:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJ1XNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 19:13:49 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D104CF
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso17081865ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698534826; x=1699139626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwX4pskItPHUM4maFDdS5O3Er1CtrhdQQ55njchpgeM=;
        b=KCI56l7+q406XimDYx0gHIBqVZ7c1ibFjbheys2NVrylNMm2YNQibd2+ZgE+f8P5AV
         5H147MHBlgZJg/iASpblI4y1l+ESFSioxHF8JEl2xCRTwRLQJzzlHwPK5JbyT3duQqpY
         796veG/Tpm846iniT/lRWF2KT2WPED3/sXaTXnasfBl5MeW0QoQZ0nBilKFAAiJRb6hu
         eJ/lOonaRcy3i57mpLH2KTYeEvPhDFmOQikCRgnwuiOnEgQ0oaCfhkN9GWaOz3yKCCAx
         p+2IzgYHZ6O6NECKFBsTeYsmgF+uSu6+8y7XhnneRzA9fZfEaoLLVJvyCtv2XI+XRewe
         S9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698534826; x=1699139626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwX4pskItPHUM4maFDdS5O3Er1CtrhdQQ55njchpgeM=;
        b=RfEKWuIdW6B3P5RUHpIq9WderDs/5yjTR8bx/JKA3a2nRm67ZIX3tsXBSFAXuDrA2C
         2NYQhsobyz33cozLqlrQI41lUfHdYA1QTZOZjd383u0axHhqG5hFr2WvcqlAarFCx6Yo
         DAy5zd5UE5Om2LTRfAxb8Rrc2kAk9srKkoAeRumdpcd2QvtpRvvlzFtchbrErqwTZQPS
         SYHXHXRKgexIT2Wm1db2u+3rB2i1auDqXXd3q811nc5igi4xoRBovcytWd1ELO22tlI8
         3UbcDdAFXWWzatTIyQzcRwX0B7gih6C+U4ADHVDlOA9AeL+3G1M3CKSaUDe/8YfXE0R7
         aXtw==
X-Gm-Message-State: AOJu0Yy5B6qvzM7vI5YeNAFZYVcTym+RLzRJIgkvPuSdDTOwmZt03gH4
        svygVpHLw9rYoPmoaYNZybRb3A==
X-Google-Smtp-Source: AGHT+IEP1RLLbzkV6SDyhDMWypu6mUWTgp+BfL6QnGjrDAvgGu3DpZZT/BgKJhnh9HCZ+gZpZ5q05A==
X-Received: by 2002:a17:902:8c85:b0:1c9:c0fa:dfb7 with SMTP id t5-20020a1709028c8500b001c9c0fadfb7mr6367498plo.57.1698534825930;
        Sat, 28 Oct 2023 16:13:45 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001b8622c1ad2sm3679345ple.130.2023.10.28.16.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 16:13:45 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 03/11] riscv: Make __flush_tlb_range() loop over pte instead of flushing the whole tlb
Date:   Sat, 28 Oct 2023 16:12:01 -0700
Message-ID: <20231028231339.3116618-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231028231339.3116618-1-samuel.holland@sifive.com>
References: <20231028231339.3116618-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Ghiti <alexghiti@rivosinc.com>

Currently, when the range to flush covers more than one page (a 4K page or
a hugepage), __flush_tlb_range() flushes the whole tlb. Flushing the whole
tlb comes with a greater cost than flushing a single entry so we should
flush single entries up to a certain threshold so that:
threshold * cost of flushing a single entry < cost of flushing the whole
tlb.

Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # On RZ/Five SMARC
[Samuel: Fixed type of nr_ptes_in_range]
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Rebase on Alexandre's "riscv: tlb flush improvements" series v5

 arch/riscv/include/asm/sbi.h      |   3 -
 arch/riscv/include/asm/tlbflush.h |   3 +
 arch/riscv/kernel/sbi.c           |  32 +++------
 arch/riscv/mm/tlbflush.c          | 115 +++++++++++++++---------------
 4 files changed, 72 insertions(+), 81 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 5b4a1bf5f439..b79d0228144f 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -273,9 +273,6 @@ void sbi_set_timer(uint64_t stime_value);
 void sbi_shutdown(void);
 void sbi_send_ipi(unsigned int cpu);
 int sbi_remote_fence_i(const struct cpumask *cpu_mask);
-int sbi_remote_sfence_vma(const struct cpumask *cpu_mask,
-			   unsigned long start,
-			   unsigned long size);
 
 int sbi_remote_sfence_vma_asid(const struct cpumask *cpu_mask,
 				unsigned long start,
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index f5c4fb0ae642..170a49c531c6 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -11,6 +11,9 @@
 #include <asm/smp.h>
 #include <asm/errata_list.h>
 
+#define FLUSH_TLB_MAX_SIZE      ((unsigned long)-1)
+#define FLUSH_TLB_NO_ASID       ((unsigned long)-1)
+
 #ifdef CONFIG_MMU
 extern unsigned long asid_mask;
 
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index c672c8ba9a2a..5a62ed1da453 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -11,6 +11,7 @@
 #include <linux/reboot.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
+#include <asm/tlbflush.h>
 
 /* default SBI version is 0.1 */
 unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
@@ -376,32 +377,15 @@ int sbi_remote_fence_i(const struct cpumask *cpu_mask)
 }
 EXPORT_SYMBOL(sbi_remote_fence_i);
 
-/**
- * sbi_remote_sfence_vma() - Execute SFENCE.VMA instructions on given remote
- *			     harts for the specified virtual address range.
- * @cpu_mask: A cpu mask containing all the target harts.
- * @start: Start of the virtual address
- * @size: Total size of the virtual address range.
- *
- * Return: 0 on success, appropriate linux error code otherwise.
- */
-int sbi_remote_sfence_vma(const struct cpumask *cpu_mask,
-			   unsigned long start,
-			   unsigned long size)
-{
-	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
-			    cpu_mask, start, size, 0, 0);
-}
-EXPORT_SYMBOL(sbi_remote_sfence_vma);
-
 /**
  * sbi_remote_sfence_vma_asid() - Execute SFENCE.VMA instructions on given
- * remote harts for a virtual address range belonging to a specific ASID.
+ * remote harts for a virtual address range belonging to a specific ASID or not.
  *
  * @cpu_mask: A cpu mask containing all the target harts.
  * @start: Start of the virtual address
  * @size: Total size of the virtual address range.
- * @asid: The value of address space identifier (ASID).
+ * @asid: The value of address space identifier (ASID), or FLUSH_TLB_NO_ASID
+ * for flushing all address spaces.
  *
  * Return: 0 on success, appropriate linux error code otherwise.
  */
@@ -410,8 +394,12 @@ int sbi_remote_sfence_vma_asid(const struct cpumask *cpu_mask,
 				unsigned long size,
 				unsigned long asid)
 {
-	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
-			    cpu_mask, start, size, asid, 0);
+	if (asid == FLUSH_TLB_NO_ASID)
+		return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
+				    cpu_mask, start, size, 0, 0);
+	else
+		return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
+				    cpu_mask, start, size, asid, 0);
 }
 EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
 
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index b6d712a82306..e46fefc70927 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -9,28 +9,50 @@
 
 static inline void local_flush_tlb_all_asid(unsigned long asid)
 {
-	__asm__ __volatile__ ("sfence.vma x0, %0"
-			:
-			: "r" (asid)
-			: "memory");
+	if (asid != FLUSH_TLB_NO_ASID)
+		__asm__ __volatile__ ("sfence.vma x0, %0"
+				:
+				: "r" (asid)
+				: "memory");
+	else
+		local_flush_tlb_all();
 }
 
 static inline void local_flush_tlb_page_asid(unsigned long addr,
 		unsigned long asid)
 {
-	__asm__ __volatile__ ("sfence.vma %0, %1"
-			:
-			: "r" (addr), "r" (asid)
-			: "memory");
+	if (asid != FLUSH_TLB_NO_ASID)
+		__asm__ __volatile__ ("sfence.vma %0, %1"
+				:
+				: "r" (addr), "r" (asid)
+				: "memory");
+	else
+		local_flush_tlb_page(addr);
 }
 
-static inline void local_flush_tlb_range(unsigned long start,
-		unsigned long size, unsigned long stride)
+/*
+ * Flush entire TLB if number of entries to be flushed is greater
+ * than the threshold below.
+ */
+static unsigned long tlb_flush_all_threshold __read_mostly = 64;
+
+static void local_flush_tlb_range_threshold_asid(unsigned long start,
+						 unsigned long size,
+						 unsigned long stride,
+						 unsigned long asid)
 {
-	if (size <= stride)
-		local_flush_tlb_page(start);
-	else
-		local_flush_tlb_all();
+	unsigned long nr_ptes_in_range = DIV_ROUND_UP(size, stride);
+	int i;
+
+	if (nr_ptes_in_range > tlb_flush_all_threshold) {
+		local_flush_tlb_all_asid(asid);
+		return;
+	}
+
+	for (i = 0; i < nr_ptes_in_range; ++i) {
+		local_flush_tlb_page_asid(start, asid);
+		start += stride;
+	}
 }
 
 static inline void local_flush_tlb_range_asid(unsigned long start,
@@ -38,8 +60,10 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
 {
 	if (size <= stride)
 		local_flush_tlb_page_asid(start, asid);
-	else
+	else if (size == FLUSH_TLB_MAX_SIZE)
 		local_flush_tlb_all_asid(asid);
+	else
+		local_flush_tlb_range_threshold_asid(start, size, stride, asid);
 }
 
 static void __ipi_flush_tlb_all(void *info)
@@ -52,7 +76,7 @@ void flush_tlb_all(void)
 	if (riscv_use_ipi_for_rfence())
 		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
 	else
-		sbi_remote_sfence_vma(NULL, 0, -1);
+		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
 }
 
 struct flush_tlb_range_data {
@@ -69,18 +93,12 @@ static void __ipi_flush_tlb_range_asid(void *info)
 	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
 }
 
-static void __ipi_flush_tlb_range(void *info)
-{
-	struct flush_tlb_range_data *d = info;
-
-	local_flush_tlb_range(d->start, d->size, d->stride);
-}
-
 static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 			      unsigned long size, unsigned long stride)
 {
 	struct flush_tlb_range_data ftd;
 	struct cpumask *cmask = mm_cpumask(mm);
+	unsigned long asid = FLUSH_TLB_NO_ASID;
 	unsigned int cpuid;
 	bool broadcast;
 
@@ -90,39 +108,24 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 	cpuid = get_cpu();
 	/* check if the tlbflush needs to be sent to other CPUs */
 	broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
-	if (static_branch_unlikely(&use_asid_allocator)) {
-		unsigned long asid = atomic_long_read(&mm->context.id) & asid_mask;
-
-		if (broadcast) {
-			if (riscv_use_ipi_for_rfence()) {
-				ftd.asid = asid;
-				ftd.start = start;
-				ftd.size = size;
-				ftd.stride = stride;
-				on_each_cpu_mask(cmask,
-						 __ipi_flush_tlb_range_asid,
-						 &ftd, 1);
-			} else
-				sbi_remote_sfence_vma_asid(cmask,
-							   start, size, asid);
-		} else {
-			local_flush_tlb_range_asid(start, size, stride, asid);
-		}
+
+	if (static_branch_unlikely(&use_asid_allocator))
+		asid = atomic_long_read(&mm->context.id) & asid_mask;
+
+	if (broadcast) {
+		if (riscv_use_ipi_for_rfence()) {
+			ftd.asid = asid;
+			ftd.start = start;
+			ftd.size = size;
+			ftd.stride = stride;
+			on_each_cpu_mask(cmask,
+					 __ipi_flush_tlb_range_asid,
+					 &ftd, 1);
+		} else
+			sbi_remote_sfence_vma_asid(cmask,
+						   start, size, asid);
 	} else {
-		if (broadcast) {
-			if (riscv_use_ipi_for_rfence()) {
-				ftd.asid = 0;
-				ftd.start = start;
-				ftd.size = size;
-				ftd.stride = stride;
-				on_each_cpu_mask(cmask,
-						 __ipi_flush_tlb_range,
-						 &ftd, 1);
-			} else
-				sbi_remote_sfence_vma(cmask, start, size);
-		} else {
-			local_flush_tlb_range(start, size, stride);
-		}
+		local_flush_tlb_range_asid(start, size, stride, asid);
 	}
 
 	put_cpu();
@@ -130,7 +133,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	__flush_tlb_range(mm, 0, -1, PAGE_SIZE);
+	__flush_tlb_range(mm, 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
 }
 
 void flush_tlb_mm_range(struct mm_struct *mm,
-- 
2.42.0

