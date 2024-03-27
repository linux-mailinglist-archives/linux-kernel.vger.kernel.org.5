Return-Path: <linux-kernel+bounces-120310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D6688D592
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99931C22D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADD921A0D;
	Wed, 27 Mar 2024 04:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fETlCPHt"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E032D1EB5E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515054; cv=none; b=sjPA7Ts771YXyFlyWFHzLzmBI94q37Gz8+AcwDrM2jMDKNyskExHadnvI6Rz0+Yy6vOQ2eTnb63zbYxFzkzEUiGJfqppaBIt8cAp2xvTvl5eXSaAYd/+/6XoDropqo4XkPihq5fsxdb8z8UF7gXEdDWGKEf7SZ4n0QGP3vN6lMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515054; c=relaxed/simple;
	bh=rWKHETzcUwKRgItYuayevEp2FgvSWRc2ekB7V6Se14w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmCyIPh1vS9VRHnrbqceF3x86o7TZ6L6qRVdCv8VX4EevrcK1hmhEPK6EVxuHFnRVk/V0QBitkVgSZ4/X5iBmlHc2yReMnZC1cNU+rNdGanJzi4/1uP+o2APbNTZfSWE9x+VWkEji3baXGw+en1OYPefafVMMtMrCtJAhm9R774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=fETlCPHt; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e6a5bd015dso2946637a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711515052; x=1712119852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHzKH2DTKf6Vc5BlA0YNBJTz56l+llAyGgYGMd65KTs=;
        b=fETlCPHtdNJxR8pqGTFAtCaLtDfQQP1DtouZ0HjzmOrJlp27fQMOR0oanT+WvNQz5i
         f9YCJL2OScRlPZ/VEerkJJZ/IaiO7c+Q7YB1uylVKphjf2jV+mYMSYynusHXeCwnwVs8
         gXaeWgVzu07vi2KXUX5GTKeXM/fUErVVFLroCKPbJa4CkgRG22U3cXu1FmH5/02pAwGQ
         CHlSdYOIEqbvkVPsqdjmejJ2iyCiP8SPIM+GVzPGECNBd0fSUFlVCEhuqFC3rpXh+t1T
         Y+z3vPr9femLY1r43tkz8JXOZiZuv1OQv3LYYOdC28hyog7HGKviwwxz6LxgoMjnAxv+
         aPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515052; x=1712119852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHzKH2DTKf6Vc5BlA0YNBJTz56l+llAyGgYGMd65KTs=;
        b=u5jKf05QAOsj9TqCuo1n5YJSiyjov87BA8fid3k4cD4/Z2ESE6vcOiPo3s7UuOR/MX
         OYjkpP8JmihMywzZCH84RbH1qSRz4wT/Heuge8BJptnYqmGvUrCL0j+GHkwcMlySjBHL
         SsUvz2lhO6T/5u1f8zsNzPr6pHDCxlecaqf592zzcPtwVFYMQlfFHN4ryet7dPqeq7G1
         Ay5c3mw1L5ZHWcVhQPs0kKXUlHAN2wfzsJyyeaYspqwyovxhQqM3WedHvY6HWGYLi2GA
         IguolVdndSJ2vZH+OgUyHIQ1Xfle3V5ZKU9dVMk3Xu21TYHGrVJa5AJlgia7AslJoCUY
         kDgg==
X-Gm-Message-State: AOJu0YyHhnfYKmqp0x+4obKcJ0m/3Hoe0/owATFCPA1gPjkFaZVryOHm
	9x4WHJNmh9kahTgtLgGiw8YrdUXaZC8kduygKQTY70549C4N+jhnzNvqc0+Oyps=
X-Google-Smtp-Source: AGHT+IFNZ9hbtEq1CmgyYTIu4vUTxuEiR33JD4yc+xyNKXepJuE48avCWWfj7WZgftYdmFVpAMAO4A==
X-Received: by 2002:a9d:6e0c:0:b0:6e6:b2ed:f12a with SMTP id e12-20020a9d6e0c000000b006e6b2edf12amr1764968otr.30.1711515052040;
        Tue, 26 Mar 2024 21:50:52 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e31-20020a63501f000000b005e4666261besm8351500pgb.50.2024.03.26.21.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:50:51 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 07/13] riscv: Apply SiFive CIP-1200 workaround to single-ASID sfence.vma
Date: Tue, 26 Mar 2024 21:49:48 -0700
Message-ID: <20240327045035.368512-8-samuel.holland@sifive.com>
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

commit 3f1e782998cd ("riscv: add ASID-based tlbflushing methods") added
calls to the sfence.vma instruction with rs2 != x0. These single-ASID
instruction variants are also affected by SiFive errata CIP-1200.

Until now, the errata workaround was not needed for the single-ASID
sfence.vma variants, because they were only used when the ASID allocator
was enabled, and the affected SiFive platforms do not support multiple
ASIDs. However, we are going to start using those sfence.vma variants
regardless of ASID support, so now we need alternatives covering them.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - Rebase on Alexandre's "riscv: tlb flush improvements" series v5

 arch/riscv/include/asm/errata_list.h | 12 +++++++++++-
 arch/riscv/include/asm/tlbflush.h    | 19 ++++++++++++++++++-
 arch/riscv/mm/tlbflush.c             | 23 -----------------------
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 1f2dbfb8a8bf..35ce26899960 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -43,11 +43,21 @@ ALTERNATIVE(__stringify(RISCV_PTR do_page_fault),			\
 	    CONFIG_ERRATA_SIFIVE_CIP_453)
 #else /* !__ASSEMBLY__ */
 
-#define ALT_FLUSH_TLB_PAGE(x)						\
+#define ALT_SFENCE_VMA_ASID(asid)					\
+asm(ALTERNATIVE("sfence.vma x0, %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
+		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
+		: : "r" (asid) : "memory")
+
+#define ALT_SFENCE_VMA_ADDR(addr)					\
 asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
 		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
 		: : "r" (addr) : "memory")
 
+#define ALT_SFENCE_VMA_ADDR_ASID(addr, asid)				\
+asm(ALTERNATIVE("sfence.vma %0, %1", "sfence.vma", SIFIVE_VENDOR_ID,	\
+		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
+		: : "r" (addr), "r" (asid) : "memory")
+
 /*
  * _val is marked as "will be overwritten", so need to set it to 0
  * in the default case.
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 4f86424b1ba5..463b615d7728 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -22,10 +22,27 @@ static inline void local_flush_tlb_all(void)
 	__asm__ __volatile__ ("sfence.vma" : : : "memory");
 }
 
+static inline void local_flush_tlb_all_asid(unsigned long asid)
+{
+	if (asid != FLUSH_TLB_NO_ASID)
+		ALT_SFENCE_VMA_ASID(asid);
+	else
+		local_flush_tlb_all();
+}
+
 /* Flush one page from local TLB */
 static inline void local_flush_tlb_page(unsigned long addr)
 {
-	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
+	ALT_SFENCE_VMA_ADDR(addr);
+}
+
+static inline void local_flush_tlb_page_asid(unsigned long addr,
+					     unsigned long asid)
+{
+	if (asid != FLUSH_TLB_NO_ASID)
+		ALT_SFENCE_VMA_ADDR_ASID(addr, asid);
+	else
+		local_flush_tlb_page(addr);
 }
 
 void flush_tlb_all(void);
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 0901aa47b58f..ad7bdcfcc219 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -7,29 +7,6 @@
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
-static inline void local_flush_tlb_all_asid(unsigned long asid)
-{
-	if (asid != FLUSH_TLB_NO_ASID)
-		__asm__ __volatile__ ("sfence.vma x0, %0"
-				:
-				: "r" (asid)
-				: "memory");
-	else
-		local_flush_tlb_all();
-}
-
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
-}
-
 /*
  * Flush entire TLB if number of entries to be flushed is greater
  * than the threshold below.
-- 
2.43.1


