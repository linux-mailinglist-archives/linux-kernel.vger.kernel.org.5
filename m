Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BF17DAA1D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 01:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjJ1XNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 19:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjJ1XNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 19:13:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357D2CF
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6be0277c05bso2898763b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698534824; x=1699139624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4NRNhpDELMiOf33wYuzLfhwPwCzaIpnJue9EEzIQdY=;
        b=cYexk+t4MDdaGS9C/G7GEcnAquNdYT4h4DJmHyfN939k5hS/3v5peyIsTse7ItTDSN
         5cWTIjiFsIm23ptts5Lgkq3tYwc3QPfqB+rlm2QlYkLpYd50euh1FI5bLNAUZEKOqKQz
         g+VQJEeVs6c/2xakEfffs9xVHllio+LN8xZg1LXXcq13pSLHnG6WRXFq0IbJC+f8OSDR
         PuF9cu8ivJXUaojwfrjg6r/CWH5AF6SebaZ53xIsePzRyPr3ETdf5XZx684Vorh5nD3O
         694by1kg720Sz99E7eVFl7WwwwJyGM/rPIeikiGpJXD1raNdsZuNQpEBeXirFExd7alQ
         Jdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698534824; x=1699139624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4NRNhpDELMiOf33wYuzLfhwPwCzaIpnJue9EEzIQdY=;
        b=QiiTr8WfYK0032zI16vHpynfApRDKZnq4qmYluFbg4XzSmFSLAi0QcalTQoQWJnZJy
         bVSEzAEN1L0EbSl5AO8LU5hyIR/gALANo+al/+xTlpxORn7vASrYw4uEJntIkDJBnzKU
         rrzYacQQzaxXWR7dzyM7n16ZxPH3VDWgArgFD/itnaGmH74PRCiWgPeCT9LQ9Xtw+4wi
         jnJdL52k0qA2aacG+txyIGCgMwZFmTPI8AY2S0hMdThB5cI8g31YvwZJmriOuljp/XTu
         /8/NB0mjFDZ4TD/O6fujg05KtxJaVlLiKDZIAXaN8it3qruQH8mJZSUfDmqpnm3gzHGS
         wIZg==
X-Gm-Message-State: AOJu0YxGTn4MDkKwcd6wd1tP3gsA16oyJeCV7OPuA32+O9Vp+witCvJ3
        +8L9EchMKnBNTS1r0uw/YIit0A==
X-Google-Smtp-Source: AGHT+IHFtwqkvMLL8vTXw7lsMTaEWiNW/nYYuBPFSSXqkCgtp1/aoWCoS2LcxRJlFYSU2eWn0N2URQ==
X-Received: by 2002:a05:6a21:3b45:b0:16b:a5fb:eee5 with SMTP id zy5-20020a056a213b4500b0016ba5fbeee5mr5984191pzb.28.1698534824609;
        Sat, 28 Oct 2023 16:13:44 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001b8622c1ad2sm3679345ple.130.2023.10.28.16.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 16:13:43 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 02/11] riscv: Improve flush_tlb_range() for hugetlb pages
Date:   Sat, 28 Oct 2023 16:12:00 -0700
Message-ID: <20231028231339.3116618-3-samuel.holland@sifive.com>
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

flush_tlb_range() uses a fixed stride of PAGE_SIZE and in its current form,
when a hugetlb mapping needs to be flushed, flush_tlb_range() flushes the
whole tlb: so set a stride of the size of the hugetlb mapping in order to
only flush the hugetlb mapping. However, if the hugepage is a NAPOT region,
all PTEs that constitute this mapping must be invalidated, so the stride
size must actually be the size of the PTE.

Note that THPs are directly handled by flush_pmd_tlb_range().

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
[Samuel: Removed CONFIG_RISCV_ISA_SVNAPOT check]
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Rebase on Alexandre's "riscv: tlb flush improvements" series v5

 arch/riscv/mm/tlbflush.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index fa03289853d8..b6d712a82306 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -3,6 +3,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
+#include <linux/hugetlb.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
@@ -147,7 +148,33 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
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
+	}
+
+	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
 }
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
-- 
2.42.0

