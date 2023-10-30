Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BBC7DBAE4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjJ3NfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjJ3NfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:35:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657D4D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:35:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32d849cc152so3092663f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698672908; x=1699277708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+Voqb64JUu/S+my4bjKiePrsxn/AGTGcWHZA6URcLY=;
        b=Qm7vCUUc94Idnrp6qQfnhr/2sFdAuPC9lUVLPRh82z4Wn0NNwPqTLVIwWXvoXHXv7k
         vvt9LJU8qjpOeoTDpZsWDwNEUC9EVjl0fTDq67qFCkKbjYWN0Hf/rARptmeStCFeMnqo
         kbc5AafEU7JHXxmQC2UbMdoT4VRn4TI7JpPakT7W8iVs7chpe6Zz+4aJbFZVjm/Ig1FX
         r4MstO3ox06p+/BfLlQ2iA1azLsjlkZL91+XMJZp2OJHEgw2n8KVSYLJXDtX4oZ7mps6
         N8QAURtEhes3xzggWVKcq47aSn7lRbVgsJx4iUc0OES1ePqC5SH7WhwIdgGpewH94/p3
         lieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698672908; x=1699277708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+Voqb64JUu/S+my4bjKiePrsxn/AGTGcWHZA6URcLY=;
        b=GeWI5lBpiWd+eILUKqvQm4vkttSG70PBLsn/pb5grGO+BhtRGTYdSqk7mrqKR7rHQR
         9sncy5dbXqvKB/ljHnMCf7RD8IUGoV+HUqq8d5bwV9LGHlDT5TVcnRhAvJjUNk89XEg+
         uC1itD9v2R7Fd/udRZmm5PzIE0sFvw6p94cYCRgmbC50o5fL/i+FbWWFVBnozsBTvQZO
         Z4aE1WuY5m/7N/k9SbiuGYm38cehcjPs9QQBfiP88xk8Dk4OkrPLnd83O37PrfsOZFKT
         /JAfYl/tmM1zbun9GMJAOfbFaHNJM0PoHSY0hA7hMemKi9fefVAaJabO54iEcPOFsAjw
         GRAg==
X-Gm-Message-State: AOJu0YznToUzUAUPEpH2Jr8ybcC2yYrgSjiynsOp6JpC+rEVFsUEMPYi
        x4XMqIaaQRRSeSfyGrfSXUumrA==
X-Google-Smtp-Source: AGHT+IHEw6T+OK2cXmEQUaFlVp9JTsP+3ENAfV/VP4H/l3hIJec/QWwZbGuNwmLLAlaAsmBtrNDznA==
X-Received: by 2002:a05:6000:1882:b0:32f:7f03:9a with SMTP id a2-20020a056000188200b0032f7f03009amr4279324wri.55.1698672907709;
        Mon, 30 Oct 2023 06:35:07 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id o12-20020a056000010c00b003232f167df5sm8252241wrx.108.2023.10.30.06.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:35:07 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 4/4] riscv: Improve flush_tlb_kernel_range()
Date:   Mon, 30 Oct 2023 14:30:28 +0100
Message-Id: <20231030133027.19542-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030133027.19542-1-alexghiti@rivosinc.com>
References: <20231030133027.19542-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function used to simply flush the whole tlb of all harts, be more
subtile and try to only flush the range.

The problem is that we can only use PAGE_SIZE as stride since we don't know
the size of the underlying mapping and then this function will be improved
only if the size of the region to flush is < threshold * PAGE_SIZE.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # On RZ/Five SMARC
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>
---
 arch/riscv/include/asm/tlbflush.h | 11 +++++-----
 arch/riscv/mm/tlbflush.c          | 34 ++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 170a49c531c6..8f3418c5f172 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -40,6 +40,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end);
+void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
@@ -56,15 +57,15 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
 	local_flush_tlb_all();
 }
 
-#define flush_tlb_mm(mm) flush_tlb_all()
-#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
-#endif /* !CONFIG_SMP || !CONFIG_MMU */
-
 /* Flush a range of kernel pages */
 static inline void flush_tlb_kernel_range(unsigned long start,
 	unsigned long end)
 {
-	flush_tlb_all();
+	local_flush_tlb_all();
 }
 
+#define flush_tlb_mm(mm) flush_tlb_all()
+#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
+#endif /* !CONFIG_SMP || !CONFIG_MMU */
+
 #endif /* _ASM_RISCV_TLBFLUSH_H */
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index e46fefc70927..e6659d7368b3 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -97,20 +97,27 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 			      unsigned long size, unsigned long stride)
 {
 	struct flush_tlb_range_data ftd;
-	struct cpumask *cmask = mm_cpumask(mm);
+	const struct cpumask *cmask;
 	unsigned long asid = FLUSH_TLB_NO_ASID;
-	unsigned int cpuid;
 	bool broadcast;
 
-	if (cpumask_empty(cmask))
-		return;
+	if (mm) {
+		unsigned int cpuid;
+
+		cmask = mm_cpumask(mm);
+		if (cpumask_empty(cmask))
+			return;
 
-	cpuid = get_cpu();
-	/* check if the tlbflush needs to be sent to other CPUs */
-	broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
+		cpuid = get_cpu();
+		/* check if the tlbflush needs to be sent to other CPUs */
+		broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
 
-	if (static_branch_unlikely(&use_asid_allocator))
-		asid = atomic_long_read(&mm->context.id) & asid_mask;
+		if (static_branch_unlikely(&use_asid_allocator))
+			asid = atomic_long_read(&mm->context.id) & asid_mask;
+	} else {
+		cmask = cpu_online_mask;
+		broadcast = true;
+	}
 
 	if (broadcast) {
 		if (riscv_use_ipi_for_rfence()) {
@@ -128,7 +135,8 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 		local_flush_tlb_range_asid(start, size, stride, asid);
 	}
 
-	put_cpu();
+	if (mm)
+		put_cpu();
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
@@ -179,6 +187,12 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
 }
+
+void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	__flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end)
-- 
2.39.2

