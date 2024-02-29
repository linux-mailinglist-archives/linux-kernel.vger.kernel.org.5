Return-Path: <linux-kernel+bounces-87678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC84186D7A8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418FE1F22FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F7C143747;
	Thu, 29 Feb 2024 23:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="T/6413Kz"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4213E7FD
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248941; cv=none; b=Fb7kQiW6/87WMaBk7Rn52vVM77ZNXfCG5kjiYpJniqYzqNenWydmsBSn4o7hwup7wKssUTDaIc3kx8J5JC/4F3q+PoF7zRboLU6uAdMcO1MTJ4+lxo37JQJuKERzFD/hvUIC56mlSh23iMP7n8vKKP8iNIr2TpOO5Av4QT1G2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248941; c=relaxed/simple;
	bh=a4goP/+lcARBu1PHrcIVBscDySvDXJckpo1nEsaZBxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZSNeBvbrxx4Pm8PRz7meBacG8pmFqlrWtb0c6DFaiHZh72zDtC7waFryFdcC2q3tE6TFNWPedGY2mXgy+EoiAb+PHNoOiRWWLXBj1FCmaILo/PyUCQvtUndet7HIGU5SQN5McuhRGfCjucCIwK/cYXQsn7eBl2SWLso4NldTPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=T/6413Kz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e558a67f70so1504583b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709248939; x=1709853739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLB9vlYe9JfwQMhDb14nNgv57tMyr8X6yVrB4e0zcQU=;
        b=T/6413KzX+8h2XvpIH5v6dAupdJp9nBlSmldX5ofq7vIevhizsmcZcHduKAW5H3ahf
         6Oyf9Sb2ae4Crq6iEPW33X9w1sr/hDMAIlkdqIu67a9OKb4Ao7RWVKlxRqO1emaGmxeM
         zjJpdNQwp1NdazZI8idHbGY1Auv5AqybsrkC5NyzbC2P2csGYNOWZZR5Lvnq8cqlg5im
         9tY8BKKufyGRGcB9XZSk/ENFLD5a9pbTzx7kIiI5qJD3Vpoq4P9NCkubUc+rfVopLG/B
         +DO20kKFjrOaGOAgjxbdayLO4Mye5aheHHdcGvFa1DFyO6kvedlRT3tgC3/6OKIQh1Ai
         ADig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248939; x=1709853739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLB9vlYe9JfwQMhDb14nNgv57tMyr8X6yVrB4e0zcQU=;
        b=m7XaQcPRpKWkcsufoJlTxY6FyUO62TC1fL2L5QRhx08rJJn1oscxNYA7vYmGt8H0WV
         XbnejA8cofNoZhQyCItSa8cOga1rQ5MIfyclTGcPDR+MuODFwgvhWZKVuClsrqSA1ch/
         dzbm3sN/F1aPJS9BvzFARZZ1b/tvJ3Fr1vqJYPGzo5L6c13Io1Gntzk1cczbNrOe6X5+
         yxGKUntYZSrS+I9eEXFdpw+6a55lkTqgS5SmJD7CqHRQ2Ts9sh1BGkq0n/JNXTxCfqZP
         16DmLaaSI8yWhs84dYWlBgaueGahUybNC/5HcrN6KdOtM8NmeIX02aBGnEQDuC7T9JrN
         vqfA==
X-Gm-Message-State: AOJu0YxLAALlXQSZlJ4v4wqxLMSCRIBAGeOT7lOBW28W/iXsL0rbNzpT
	i2B2ENa4Xu3OlkQtJUlmCDUPtlHbQg0WXKTNq0cUn2+Ap3UZRwCybmBoUkGi5YI=
X-Google-Smtp-Source: AGHT+IFNMqThgNRh63sPPm1+a+RZC7oBqAsJKeQJ9ncYhwlwuRqR+WMAL4ZrZQk20TebpNdIS4mveg==
X-Received: by 2002:a05:6a00:2354:b0:6e5:80a4:2ff2 with SMTP id j20-20020a056a00235400b006e580a42ff2mr152068pfj.30.1709248939492;
        Thu, 29 Feb 2024 15:22:19 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e55aa75d6csm1779719pfo.122.2024.02.29.15.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:22:19 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 06/13] riscv: mm: Combine the SMP and UP TLB flush code
Date: Thu, 29 Feb 2024 15:21:47 -0800
Message-ID: <20240229232211.161961-7-samuel.holland@sifive.com>
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
 arch/riscv/include/asm/tlbflush.h | 30 +++---------------------------
 arch/riscv/mm/Makefile            |  5 +----
 3 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0bfcfec67ed5..de9b6f2279ff 100644
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
index 928f096dca21..4f86424b1ba5 100644
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
@@ -54,27 +49,8 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
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


