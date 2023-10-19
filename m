Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18F77CFBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345932AbjJSOEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345858AbjJSOEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:04:14 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0572CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:04:12 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so98035851fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697724251; x=1698329051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ApwA47W5sfKWNkq2IymUPAqINYWJl4bGVtXFqY2oGI=;
        b=qgE4SeXWR6CDa0IIomrLXrozVcK608ca9OB63IxhfA+xwbDzfUAT7kGEAFMg0bQEeV
         EVHqMaYTivUkEV8aptjmHY/GOSfGT+/oCGLQFGdFOys+EFTINgsVFH5MvETwOJaw2Dws
         /TzhvtXzzQ+r2fdHsfXmL2WtMO4dl+Yv3x7gFKGNgSSiaGxuJGzDy5PhzTG1xw6tJbDJ
         PdDzOV4vs7mC8J8KDfYavVjnrHYFQAksx1rbsrfHiLMyuEGHonn2ExqGB1TbpqbRi9JT
         4e1vQX3PxcR06DXbKlrPDlvvezcVZHMfldiQSM1CrvezbylDP7GwxY5rYhzU8ms0aU/1
         M91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697724251; x=1698329051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ApwA47W5sfKWNkq2IymUPAqINYWJl4bGVtXFqY2oGI=;
        b=DGeWq+sg1MbDoHkYVeN/YeoKFIpa9NL/OWG60xm5rLyu2pSP5T88M7c0Aod2bbeI+f
         mswT6/KFlQf6HVTkgR621covciGOXRD/7pjnVmNuQ92LSRZXqCK49t0rxyf8gY3d0ej0
         uomhY7r/k9PB30g8rYbWY+mrPLhFh61lb1lhMcp6JnqV8qRdeqKO/1UTEqLg7Zgm+JEZ
         Cb15scfpcOabYLEVgjx02QbRQNcxKsSNbKZsgKLYdMRZbODpWU9YnPNms/WItFIZX0FD
         0EvheQAKiA4/SHiXhP8HrHWuDJZEFRtJXLfr7IL5DWOTmgWRsO25vcPXmrPsvJZO2vHe
         sOoQ==
X-Gm-Message-State: AOJu0YzCVy+7biwHgyNpObkDJ8XTs0SEtnfGnR1SSMdLuVlgFrypR0M7
        OmbAQdcYAetYIbmr+4oW+wfIFQ==
X-Google-Smtp-Source: AGHT+IEBYCq6FlJQnZX7dLdouPmrLmiH7GFteySmGUDpOnC8cPojpOsH5qTZKNPlCuCg8e75j80KCg==
X-Received: by 2002:a05:651c:1502:b0:2c5:1ad0:e2ff with SMTP id e2-20020a05651c150200b002c51ad0e2ffmr2017092ljf.39.1697724250744;
        Thu, 19 Oct 2023 07:04:10 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id az15-20020a05600c600f00b00406447b798bsm4543769wmb.37.2023.10.19.07.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:04:05 -0700 (PDT)
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
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 2/4] riscv: Improve flush_tlb_range() for hugetlb pages
Date:   Thu, 19 Oct 2023 16:01:49 +0200
Message-Id: <20231019140151.21629-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019140151.21629-1-alexghiti@rivosinc.com>
References: <20231019140151.21629-1-alexghiti@rivosinc.com>
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

flush_tlb_range() uses a fixed stride of PAGE_SIZE and in its current form,
when a hugetlb mapping needs to be flushed, flush_tlb_range() flushes the
whole tlb: so set a stride of the size of the hugetlb mapping in order to
only flush the hugetlb mapping. However, if the hugepage is a NAPOT region,
all PTEs that constitute this mapping must be invalidated, so the stride
size must actually be the size of the PTE.

Note that THPs are directly handled by flush_pmd_tlb_range().

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/tlbflush.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index fa03289853d8..5933744df91a 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -3,6 +3,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
+#include <linux/hugetlb.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
@@ -147,7 +148,35 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	__flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
+	unsigned long stride_size;
+
+	if (!is_vm_hugetlb_page(vma)) {
+		stride_size = PAGE_SIZE;
+	} else {
+		stride_size = huge_page_size(hstate_vma(vma));
+
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+		/*
+		 * As stated in the privileged specification, every PTE in a
+		 * NAPOT region must be invalidated, so reset the stride in that
+		 * case.
+		 */
+		if (has_svnapot()) {
+			if (stride_size >= PGDIR_SIZE)
+				stride_size = PGDIR_SIZE;
+			else if (stride_size >= P4D_SIZE)
+				stride_size = P4D_SIZE;
+			else if (stride_size >= PUD_SIZE)
+				stride_size = PUD_SIZE;
+			else if (stride_size >= PMD_SIZE)
+				stride_size = PMD_SIZE;
+			else
+				stride_size = PAGE_SIZE;
+		}
+#endif
+	}
+
+	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
 }
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
-- 
2.39.2

