Return-Path: <linux-kernel+bounces-122511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4F488F8E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE34296DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5964E1CF;
	Thu, 28 Mar 2024 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KYSgCwiR"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636A739FC6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611526; cv=none; b=TmZF4m1RDe3EQHESnx/VjOZphrtiBhtTlnaOFex25b4qiecdj5d+zaPIH7kVRzBL0Rn/Ye9womYfVp4Hcm2hhTqIuRs4mlpxBK/TEKxnvWIZzIXHAIE6xPPUgmMSTYLGBkk3eUvAaHCKIJULIDcZ34wB99DGWFcMKMdn71R1pPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611526; c=relaxed/simple;
	bh=ABUfe9xcZbpulJDNDjDQZLgxK+gqUTLOAwW6dE1RhgU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=isiTCHHgWykkh42gLD0MGlVK8je8KxDjqF3NYguMk2tuB2F/+DVKBiFxVaiCoJf+gKZE/p1H1xXgfafMZI/J83SJVHhoUVcKfyV/hk7PsuHnsEmzMwYs9CPJb0SOX7sPpVkUuNazTTBi482b9/nunwEIQ9/C7QWvVdLME7qFtpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KYSgCwiR; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d228a132acso7144861fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711611521; x=1712216321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fPLIncRw2+PuZW9Omz7FzGCNHvO8e2LeyJVag/haJag=;
        b=KYSgCwiRMN/oOvSNxjLTPSJr9foAlxMnUYxr0KAXlstYaghhxffh1gQVVTleULUEoO
         4Gc8c2/xPhLMC/hTYQWIxuGFiebIAKjxi1VSo0Sx4ogyqSs2hnUH4ZhoO3G2f1NKIHPg
         ZUcQ+C2PZ/Xw/+tKfM2ayZn6Dqir8ZF0Hm+UoVgVxO3fQSPvW1/EboTnsrDGJDEx7OVL
         IHm0V02xtq+G4yA5xPM+tgCOppiSy4GK0TBS1D9H+pkyAVMM9FI68qZ/Wqhcjwb8VwP4
         yVto1+TcN5yUfiC7pG+WltbmHBAInRskcE7z1wGbMWMcVA8nz4/cjmKBr7bUpyGl/VzF
         p4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711611521; x=1712216321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPLIncRw2+PuZW9Omz7FzGCNHvO8e2LeyJVag/haJag=;
        b=aerGwK9dwtLB4qqieAj4IVZebRMLEPp8Q8DHQ/Szed8GwmxyLuVVK4FY9hiGb6yIw9
         m6DLpvpGdPj0ZFkoTR+FzbwIJ8PwD6YcqgF7yLvhF7xKf9acwgxS9PQE38hLKfFOIYwa
         68SP7Cz2XHWKTBqunhX/wvkoX79gtWWs3zoAmph4RTzRG5uZ7QTL3/B6gTCBIujorn1P
         XsxBA9L1rEvs9q44GB8kA6s34IzTDQUSmM4Z5flTKmgps4VRZsjEj3LQBpncdsxtNGRn
         BQEVmIlseiHGhxAEoYATrdiFpnzlmUig3I6i6HFq4TRCfEqbpeTTLCsczg73Y5CeBdRA
         QHmA==
X-Forwarded-Encrypted: i=1; AJvYcCVCw2qDEPkyRef/vzAGYCvzUVy6ip2hi4FfhiV4E2X3BA1pcFPgyw3jn4oh2vDLiWWrPc3V/qdTgMyaK8xxdXs1ysDplMfpu+L+m4uh
X-Gm-Message-State: AOJu0YzfJHSp906En/Rh/B7aKtdzs2hxc7b25Jx+L1HW9qwkg5+j+QQg
	oKcW0Dc/KUfkHqjxVpv7Ci/0UXDCbk3YQwIhBwa+dnqyjZ1RoGyxnOR5pUDOuE8=
X-Google-Smtp-Source: AGHT+IFd/4meCvAsnvSLu4U6ayqsOQ6K+Buq7tZPS/mDr1Y/tbxrxjDdT/lg+/xLeoD+YX8SRtIN5A==
X-Received: by 2002:a2e:a0ca:0:b0:2d2:206a:2f2a with SMTP id f10-20020a2ea0ca000000b002d2206a2f2amr1651907ljm.17.1711611521459;
        Thu, 28 Mar 2024 00:38:41 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c154a00b004154596db0esm878248wmg.19.2024.03.28.00.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 00:38:41 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2] riscv: Call secondary mmu notifier when flushing the tlb
Date: Thu, 28 Mar 2024 08:38:38 +0100
Message-Id: <20240328073838.8776-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is required to allow the IOMMU driver to correctly flush its own
TLB.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

Changes in v2:
- Rebase on top of 6.9-rc1

 arch/riscv/mm/tlbflush.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 893566e004b7..854d984deb07 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -4,6 +4,7 @@
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
+#include <linux/mmu_notifier.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
@@ -99,11 +100,19 @@ static void __ipi_flush_tlb_range_asid(void *info)
 	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
 }
 
-static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
+static inline unsigned long get_mm_asid(struct mm_struct *mm)
+{
+	return (mm && static_branch_unlikely(&use_asid_allocator)) ?
+			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
+}
+
+static void __flush_tlb_range(struct mm_struct *mm,
+			      struct cpumask *cmask,
 			      unsigned long start, unsigned long size,
 			      unsigned long stride)
 {
 	struct flush_tlb_range_data ftd;
+	unsigned long asid = get_mm_asid(mm);
 	bool broadcast;
 
 	if (cpumask_empty(cmask))
@@ -137,31 +146,26 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
 
 	if (cmask != cpu_online_mask)
 		put_cpu();
-}
 
-static inline unsigned long get_mm_asid(struct mm_struct *mm)
-{
-	return static_branch_unlikely(&use_asid_allocator) ?
-			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
+	if (mm)
+		mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, start + size);
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
-			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
+	__flush_tlb_range(mm, mm_cpumask(mm), 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
 }
 
 void flush_tlb_mm_range(struct mm_struct *mm,
 			unsigned long start, unsigned long end,
 			unsigned int page_size)
 {
-	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
-			  start, end - start, page_size);
+	__flush_tlb_range(mm, mm_cpumask(mm), start, end - start, page_size);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
 			  addr, PAGE_SIZE, PAGE_SIZE);
 }
 
@@ -194,13 +198,13 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		}
 	}
 
-	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
 			  start, end - start, stride_size);
 }
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	__flush_tlb_range((struct cpumask *)cpu_online_mask, FLUSH_TLB_NO_ASID,
+	__flush_tlb_range(NULL, (struct cpumask *)cpu_online_mask,
 			  start, end - start, PAGE_SIZE);
 }
 
@@ -208,7 +212,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end)
 {
-	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
 			  start, end - start, PMD_SIZE);
 }
 #endif
@@ -222,7 +226,10 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
 			       struct mm_struct *mm,
 			       unsigned long uaddr)
 {
+	unsigned long start = uaddr & PAGE_MASK;
+
 	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
+	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, start + PAGE_SIZE);
 }
 
 void arch_flush_tlb_batched_pending(struct mm_struct *mm)
@@ -232,7 +239,7 @@ void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
-	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
-			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
+	__flush_tlb_range(NULL, &batch->cpumask,
+			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
 	cpumask_clear(&batch->cpumask);
 }
-- 
2.39.2


