Return-Path: <linux-kernel+bounces-87673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 559EC86D7A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73C81F212FC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00557134410;
	Thu, 29 Feb 2024 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="h/MyfBgN"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BA6D535
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248937; cv=none; b=fFkenk3+4PJIV/YHYe99bJJqbG+9KFsMD92uHtxJsqcCPn3RUCwYBA2DFV112hWdVFv1m3+1Y99AgEAeLrS/1NdcSKFvceVhm71CqAvG74x8cKnjvPBS/ztWw1wYJb4qkaUx8vtB4B/zHfn13uj/Ww3s360jWT1MDFtu4RFgJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248937; c=relaxed/simple;
	bh=AZIiAOFhR7ivzwD+1gH5VFDhXubgORx9r0fNtPydx90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSGfx67MWk/P+fNbt0+2/pr5VIBlSednVuj1g4/khSZbj9yNtmgE8vWi0dVGSENh0IyqRhYJQ6/BjK4vrBplqHwTfZf6ctfsZpCeWzN3B4LJSOuyRW4ahP+3a4AKhnfWrrP0XmC0a75AHVT2cWfcMZFYVij2dg8xY4yd2+RGh/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=h/MyfBgN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e581ba25e1so1204857b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709248935; x=1709853735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEa0bZw6X2PF+fvXkyrnyWuZOURSNgi5dGIyeM9k7ic=;
        b=h/MyfBgNZmwR2myHs7E6KXTLfy/zy1gfa3oxhsXQYIegsrJqrp4hzpBgLA+YjMO/RJ
         9lva7lenbVWleD/pau1Jvi9JO2ZQIr0o4SkAaDhT01LWrn20n0pVuRv3qIwdmrmQYOEI
         AV44QE89HoHSIa7tTRgg7pQIcpntzZ+3wq4NrvzR4Fw7HUoIiLCoZYDGLlXa4DvmQng6
         rcGfi6KVOeYbtFg+ySwZtfR7nwaWuQXirx6iv2NmpWMKsDjJ7OPylpJQZLwO8eUHRmOv
         gzUqsM2AYEilcIvQM1nKITXsQcmmXAi5kG9PTVVxRWDmDGK9Yzm1aPAfLXWvD06v9rvW
         Zcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248935; x=1709853735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEa0bZw6X2PF+fvXkyrnyWuZOURSNgi5dGIyeM9k7ic=;
        b=Hrg7qfypbqJSJODLlxLpbivMyPlKysyucR5hEZ03zgPoaZ7IaENg8QUxLMdphm7wCm
         OV8Cni8EhIh8DtVqvn6FDBEy7Uhs+iwmGeJh2/4udtbDd0XjBumOG2O9e52WVBQifSHc
         FPvv+snM0PJMmcR42YvN2cC2G/941Bv1nfsCcGR7ljUM5d6WeAoV2MLKH0UlehXwxjoa
         J4dCgY+FA3YZVL4C1NgWNYvXP00Km6Is3E3OEhli8sCEEJkPcQwDlQC7d8E8Jyjo0ZdY
         AFvmO2WXiY6JV1Cyb54rcR8AeNNFtEK9Ojuzr5ziamPdDb00EV7tIXuFjeRr4dZaaoPL
         fPSw==
X-Gm-Message-State: AOJu0YwIdF0Mubo5zP6Ou4ke4dLiDg2HQ6V7S0UsHirKBc5C/c9XkqHV
	7NaPvOZmQQmXeQHGaaKXicNk5bdSFlYMS2/9byKNssQqKTcz/lPZAAuoN3sSq98=
X-Google-Smtp-Source: AGHT+IFdgcTr06rQ4rVKFKQwHiCzNjuzvF9/zHzBzMpbTCozBAylfcba6wC7aAVCdn9otyCllPR9tg==
X-Received: by 2002:a05:6a00:2293:b0:6e5:599a:5252 with SMTP id f19-20020a056a00229300b006e5599a5252mr606918pfe.15.1709248935218;
        Thu, 29 Feb 2024 15:22:15 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e55aa75d6csm1779719pfo.122.2024.02.29.15.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:22:14 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 02/13] riscv: Factor out page table TLB synchronization
Date: Thu, 29 Feb 2024 15:21:43 -0800
Message-ID: <20240229232211.161961-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240229232211.161961-1-samuel.holland@sifive.com>
References: <20240229232211.161961-1-samuel.holland@sifive.com>
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

Changes in v5:
 - New patch for v5

 arch/riscv/include/asm/pgalloc.h | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index deaf971253a2..87468f67951a 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -88,6 +88,14 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 	return NULL;
 }
 
+static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
+{
+	if (riscv_use_ipi_for_rfence())
+		tlb_remove_page_ptdesc(tlb, pt);
+	else
+		tlb_remove_ptdesc(tlb, pt);
+}
+
 #define pud_free pud_free
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
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


