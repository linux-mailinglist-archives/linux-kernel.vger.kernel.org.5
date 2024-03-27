Return-Path: <linux-kernel+bounces-120309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED388D591
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F6A1C21A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072205258;
	Wed, 27 Mar 2024 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gjmlZvCC"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B120C1DA21
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515053; cv=none; b=rO9Xl1OxmN4hDUbLR+SsD8R6tiDhDOoM/9BAZvuqwRSJKg07I3vgLlTrPa8fA7LvhREOOvIAmZ4/R1/afc0ZwmCiY/tbcrLXOOCWT4gNY0zqtbEsVEcboB4UcuI2xRUDl79j6wA1RVoouYdBRDqB/w7texDW/I+eVcMoFMKMWQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515053; c=relaxed/simple;
	bh=mRY/IQDj/i6mPg/qYecdh9eDZwLkEM+YLCus0ff2B10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeDvHZUnGQDhyeVtj9FUG16WMCDiIThHWTRdL8oh1PAn3yrp6ORBvmlMbWbeSc+ewN0KikATQ9MvVQiJ2bxAPy8URmP0RSKstSj1tvNVEEEWzSYXpXJL9u1pLbmP9g3EySpeOM2S0xXONok8JALkS7RCOzhdeC79oQa9XpFRErw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gjmlZvCC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e73e8bdea2so5252904b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711515051; x=1712119851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nL2m+hLarkGQvecSEd0KAq0QtYwqUItfZBnVAx3yeI=;
        b=gjmlZvCCdiOp8Uq0kVfrm8sXXwopEDQ5DxYHvzKX15vXD9+27lQ3PwPQ4488t6MGyG
         v5H3Vwv0z2cD1uGKEXdzxblbXYcdVg84u6uGSU9pfyLhtkaSuFk8F/TLhCqo3nxRutH4
         XXyofF+dLT38TDTf9H+5fCOyGS0j+fdT1KPeU4eTSRkym6fa3hswfsg14+MkWOIFStUm
         CoohVQkX+zDbR3RKs+gag9rC9Y+eE3PQ1aT43TIp43PbwD9WdwFksBFGP2caeKighcuA
         tjstoXutVPYqbpIUQtwL0VaaRJGetJ7JylnNvp2Zf8b4uAmdFLOZN0mpdDSIXvS/eilo
         fzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515051; x=1712119851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nL2m+hLarkGQvecSEd0KAq0QtYwqUItfZBnVAx3yeI=;
        b=m1I33sm+3lEfRR8nF6FzysqJTofTm0o6QQVFawD70YwvQOoZ8mWJ6QVGm1GU0FPYlU
         /rghyf3uI4uQ8Of2/VCZjNonvKZsNA1JZsyWOKY5JTolIEevQt19leOOiyfbWFFwyhXM
         Ibt5Ms3R4R3suwnok1ZFAeI60LCkrkuzcRF4vYVuweA/NIoXgKRfc2D+N/3wCYmFvaBW
         B4wgFXTH5FZYeUHwkHFRMrhm7wx/RgJ8KlXxJ09HHTcM/T84AhkPurT/IAiiylHIfQYU
         uhCT3gDcIZ/Endzz17kNypuB2bJzdNzyTCA2l1JOpl+Ag6YLUg9PV9mYTf9AGsTX1ggr
         SgIg==
X-Gm-Message-State: AOJu0Yx+kry2es7gVqHOn9C9XJZspdUXUO4PUlpniGunt7MlucnFmNyN
	/oXyQtIjR7cXXECmMRlm3BKIYUygMZ39ir5t44vZVRrYhP5zGJ1n99+W5gN9lF8=
X-Google-Smtp-Source: AGHT+IGyz4xXUqNq5aXCdK4lWIBgBxDZJLK6nH/Xm7w+Te1ce++GEK9gbqC/aCbf24OJ2Eh82pVCjA==
X-Received: by 2002:a05:6a00:13a2:b0:6ea:8e89:7eca with SMTP id t34-20020a056a0013a200b006ea8e897ecamr1940335pfg.32.1711515050263;
        Tue, 26 Mar 2024 21:50:50 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e31-20020a63501f000000b005e4666261besm8351500pgb.50.2024.03.26.21.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:50:49 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 06/13] riscv: mm: Combine the SMP and UP TLB flush code
Date: Tue, 26 Mar 2024 21:49:47 -0700
Message-ID: <20240327045035.368512-7-samuel.holland@sifive.com>
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

In SMP configurations, all TLB flushing narrower than flush_tlb_all()
goes through __flush_tlb_range(). Do the same in UP configurations.

This allows UP configurations to take advantage of recent improvements
to the code in tlbflush.c, such as support for huge pages and flushing
multiple-page ranges.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v4)

Changes in v4:
 - Merge the two copies of __flush_tlb_range() and rely on the compiler
   to optimize out the broadcast path (both clang and gcc do this)
 - Merge the two copies of flush_tlb_all() and rely on constant folding

Changes in v2:
 - Move the SMP/UP merge earlier in the series to avoid build issues
 - Make a copy of __flush_tlb_range() instead of adding ifdefs inside
 - local_flush_tlb_all() is the only function used on !MMU (smpboot.c)

 arch/riscv/Kconfig                |  2 +-
 arch/riscv/include/asm/tlbflush.h | 31 +++----------------------------
 arch/riscv/mm/Makefile            |  5 +----
 3 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..442532819a44 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -60,7 +60,7 @@ config RISCV
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USES_CFI_TRAPS if CFI_CLANG
-	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
+	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if MMU
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 4112cc8d1d69..4f86424b1ba5 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -27,12 +27,7 @@ static inline void local_flush_tlb_page(unsigned long addr)
 {
 	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
 }
-#else /* CONFIG_MMU */
-#define local_flush_tlb_all()			do { } while (0)
-#define local_flush_tlb_page(addr)		do { } while (0)
-#endif /* CONFIG_MMU */
 
-#if defined(CONFIG_SMP) && defined(CONFIG_MMU)
 void flush_tlb_all(void);
 void flush_tlb_mm(struct mm_struct *mm);
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
@@ -54,28 +49,8 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
 			       unsigned long uaddr);
 void arch_flush_tlb_batched_pending(struct mm_struct *mm);
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
-
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
-#define local_flush_tlb_kernel_range(start, end) flush_tlb_all()
-#endif /* !CONFIG_SMP || !CONFIG_MMU */
+#else /* CONFIG_MMU */
+#define local_flush_tlb_all()			do { } while (0)
+#endif /* CONFIG_MMU */
 
 #endif /* _ASM_RISCV_TLBFLUSH_H */
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 2c869f8026a8..cbe4d775ef56 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -13,14 +13,11 @@ endif
 KCOV_INSTRUMENT_init.o := n
 
 obj-y += init.o
-obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o pgtable.o
+obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o pgtable.o tlbflush.o
 obj-y += cacheflush.o
 obj-y += context.o
 obj-y += pmem.o
 
-ifeq ($(CONFIG_MMU),y)
-obj-$(CONFIG_SMP) += tlbflush.o
-endif
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_KASAN)   += kasan_init.o
-- 
2.43.1


