Return-Path: <linux-kernel+bounces-120305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3676088D58D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A5D1C25599
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21DF510;
	Wed, 27 Mar 2024 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FzfRSZqK"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA5B67E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515045; cv=none; b=RHU5mYl94/tklzMG3cXtdXTWMNKmTaUiU1jV4/e71gsKZ9s1+JbEmQAPj61R4CG7OslO0mYo0KeYEXvGypxfGIDvBulFi395gbsl5xS1YHvjtRBzLSEir1yzr1nnY0OPd26acHTLl4kuLataET72VgUhvKFaOPxBVXweBCwCpK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515045; c=relaxed/simple;
	bh=PNo9fUUIIt9SGGQDqI5YlJUfPkSDmqOPYa4cRVAr/j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=js/L+gOHhxFwShxfl0xk8zfL1IZYMWv6mgTaeLy/ElRzd2TAGadV6snS7s/i2PCyiRfqQlK2dKKiCrCcK1hOZ3irvxqRVbtx4YMC60zqHgfMsW8v1Iuf29823IyH9cNbuE/SdC8W0G6NaAz2cnLQPWY3LaMuBXoLmUdO1cx249Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FzfRSZqK; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e50e8dcc72so2629172a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711515043; x=1712119843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tmp/TOSalTk1E9Om53lqcGFTwB3eFzfKle7hmp+7bao=;
        b=FzfRSZqKT+avHlzxgaXIOJ7UUuwHeo6s8whPqrsSsSxvLXFf8geB+CKvZReY1Y3rdt
         GRLh8KgXYGMjTs9I+cO1mQyEE8z/J2rPCv7r4R1nRen8gPflEX/fdyuZ36y7yJQc8LHu
         7LyEEKGYcDch9khG3sdYWwcI90mG8NwYfuWstbevpeKhZga0db2UoZikFcrlmBU/RE1F
         rperXo4BRTfdyTRhD1EI6aRLivTiWlEdPKL1wq0hKdvURo+15NtwX/l4VEtf/FO04xKk
         ewcoq2UpHdc7d33F6p6Qx8NSGCnoWK72KlS7HeKnWe0R/FhZsoPnHLiY+T9GE2Snx4W8
         ygsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515043; x=1712119843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tmp/TOSalTk1E9Om53lqcGFTwB3eFzfKle7hmp+7bao=;
        b=JmqjEfLuWqB7dqBBKICO0f3VPPhQNCAXxmoRSoPS/cjHYP3b8Mi56VQ3TRQVSC6J9b
         Db+aepbGMTzvnhzH7zeiH90u4OEp2C7Hfe7Vi+0NXTopzpVXv7KK6eI+2711LGkwK8w1
         w7zQNMrswm+53wUnwsqnthehyvlL0mkqUvKgcqx5mwXhcAmSEWdPYIGWYzZVdQ9a/DIU
         JXCaAtuWboPPkEhPqYvWgYw07mzw2F1yy+0OusgKotxkhONLRQ61yZubxKHcgvbwfVvO
         tJQrbqYUsknSEMDSfVC4tgVMu/Ts2hy75FnIGSv558tnntF2ElRCBBHpVZ9HBoa0eO0s
         ntTA==
X-Gm-Message-State: AOJu0YwVeOk58dXO7gzwbe0aiBrEgmugyLR9BcGQcGVgmz6j+wILqLjl
	e7qXnOCdXQiI3ELV5PMg2wx0jHjUM5nKzm1tjJGUPUBfX/WV27NAm8ncbC5o/Ss=
X-Google-Smtp-Source: AGHT+IFl3z8IwkcLePPXROsXhoQYUv/uXEkbIlJCNYH90sGzXXkCB+mcXoO2kI0LDgwvd8XvzM/1fA==
X-Received: by 2002:a05:6830:1bd5:b0:6e6:99da:8944 with SMTP id v21-20020a0568301bd500b006e699da8944mr3176474ota.26.1711515043004;
        Tue, 26 Mar 2024 21:50:43 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e31-20020a63501f000000b005e4666261besm8351500pgb.50.2024.03.26.21.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:50:42 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 02/13] riscv: Factor out page table TLB synchronization
Date: Tue, 26 Mar 2024 21:49:43 -0700
Message-ID: <20240327045035.368512-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327045035.368512-1-samuel.holland@sifive.com>
References: <20240327045035.368512-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic is the same for all page table levels. See commit 69be3fb111e7
("riscv: enable MMU_GATHER_RCU_TABLE_FREE for SMP && MMU").

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v6:
 - Move riscv_tlb_remove_ptdesc() definition to fix 32-bit build

Changes in v5:
 - New patch for v5

 arch/riscv/include/asm/pgalloc.h | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index deaf971253a2..b34587da8882 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -15,6 +15,14 @@
 #define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
+static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
+{
+	if (riscv_use_ipi_for_rfence())
+		tlb_remove_page_ptdesc(tlb, pt);
+	else
+		tlb_remove_ptdesc(tlb, pt);
+}
+
 static inline void pmd_populate_kernel(struct mm_struct *mm,
 	pmd_t *pmd, pte_t *pte)
 {
@@ -102,10 +110,7 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 		struct ptdesc *ptdesc = virt_to_ptdesc(pud);
 
 		pagetable_pud_dtor(ptdesc);
-		if (riscv_use_ipi_for_rfence())
-			tlb_remove_page_ptdesc(tlb, ptdesc);
-		else
-			tlb_remove_ptdesc(tlb, ptdesc);
+		riscv_tlb_remove_ptdesc(tlb, ptdesc);
 	}
 }
 
@@ -139,12 +144,8 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long addr)
 {
-	if (pgtable_l5_enabled) {
-		if (riscv_use_ipi_for_rfence())
-			tlb_remove_page_ptdesc(tlb, virt_to_ptdesc(p4d));
-		else
-			tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
-	}
+	if (pgtable_l5_enabled)
+		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
@@ -176,10 +177,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 
 	pagetable_pmd_dtor(ptdesc);
-	if (riscv_use_ipi_for_rfence())
-		tlb_remove_page_ptdesc(tlb, ptdesc);
-	else
-		tlb_remove_ptdesc(tlb, ptdesc);
+	riscv_tlb_remove_ptdesc(tlb, ptdesc);
 }
 
 #endif /* __PAGETABLE_PMD_FOLDED */
@@ -190,10 +188,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
 	pagetable_pte_dtor(ptdesc);
-	if (riscv_use_ipi_for_rfence())
-		tlb_remove_page_ptdesc(tlb, ptdesc);
-	else
-		tlb_remove_ptdesc(tlb, ptdesc);
+	riscv_tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif /* CONFIG_MMU */
 
-- 
2.43.1


