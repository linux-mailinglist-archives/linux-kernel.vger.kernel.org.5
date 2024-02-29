Return-Path: <linux-kernel+bounces-87675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0E086D7A5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E084A1C215A9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB9F13E7FE;
	Thu, 29 Feb 2024 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZVsYrktr"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A9975815
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248939; cv=none; b=ePreVcJUeErL1qfVm3KKUD/2z2NgaAFzGq9kTF19sSM17+dEdFXpT8xydZSaQag0hwu3Io5rWW/kjy6ixzs9lMH2QUFrde2tPwjXEnUD3OIdwhUWt+U8R5bEhMpNshaharfdcHOCXj+EiLKLvKspKeTEy6rgKRiiSROS6IRwnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248939; c=relaxed/simple;
	bh=POwNoYcpvng6qPt5oFG0srd43nGliYjpqXmrjwOe5C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=go70LVeRiE84tAr16x1WokLo1WzuKBnv8LQW8zL9nPi51PZ1pYy3YtRJfASdkb6w6Pc3VnCoQ+9ptseCGYdU09awMmcQVK+r4gWAGTHPb+nPctVHfsoN4DomysU/6+smYYQgZKuq+Q8ikxGcYPyI66n+Kn0h8gMwN48ye0TMzIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZVsYrktr; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3652731b2b7so6019635ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709248936; x=1709853736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL3CU8jW9vVfZeENVgIQs2Z0lmYtCUXWU5kIlhxMA+M=;
        b=ZVsYrktrfxOF4ow9ec/phqqw8bbpPoKv0ww/8/GpeepsbGmuxuzaOUMPNURIFn/8r2
         fo/IIDHsqAdnNejCAdsRioXiD4YJjy0cD0wG/89HIXTwEPgzfggWLb2YcgAnJ+ntFlPZ
         MbLYJ7cCfeaFyD/x4YJbkIjPfilnFeQQUztBoyS8XTA2vvTUAdqGK3G5CRrbC94kpA2M
         +9ZfKRy12PUnvejRO7nl96dIPkaphzmJr4CjwpbVd/yQlU5bYBJl/UhEaO1rmLBv8Uv7
         8i4VN3RNQ0X+Fc6YNywhNnRKtF8UWt+pNKG8l9pvmwANttliGdH0EpJhuZXfqYscWlXA
         Y4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248936; x=1709853736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL3CU8jW9vVfZeENVgIQs2Z0lmYtCUXWU5kIlhxMA+M=;
        b=hOtQ/qYO6OyQ33eabhYs1DWMhs8f2pHBpGul/sediv538yA8pSNXmmEHIBKMRUKxGk
         zi4T6fX2y9FuyzTyks9sI+qMKah6sLqGCfwRaCZA/CXK31QWdUy8isJ5/PMs6U3QELqZ
         8GHUxex+9B0IzavOiOpZ4qxVbTQ6WV0RmfD70LV+rAsA3/3EyW0pnN/leP0sdp3Dvztt
         WXRCc1FX2KYW/aFt0Rfvt0yyPg1XRiOf7WcaEtdhoavFexlr3nJuZnxbwhmN6v6+SOpt
         iWUGnBf3QlWbzw9y2YxP8J0oNsmKAEMcVVmKWPf+NROZcl+6+17hkV8U6YOtjOXzJsEj
         xjjA==
X-Gm-Message-State: AOJu0Yx5lHbzJ2p6Jzu6Q08mJhB+mTEl1zh7lQmQGAIMKmXmXYycSq/i
	rIQibwJtlVUtlSRK6DA0hsHBWG/rSqUnoUhVsQUkZcpDTvM0FVD3/ZFteBhHbLI=
X-Google-Smtp-Source: AGHT+IEuQOuQ50R8qoZP0RbIoJTNSdVCKrs4lRWLzJ+znFdHc+eSLoYj/Ypw4BmFNiQ++vK2RkPm8w==
X-Received: by 2002:a05:6e02:1b8f:b0:365:ae26:5827 with SMTP id h15-20020a056e021b8f00b00365ae265827mr159548ili.5.1709248936255;
        Thu, 29 Feb 2024 15:22:16 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e55aa75d6csm1779719pfo.122.2024.02.29.15.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:22:15 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 03/13] riscv: Use IPIs for remote cache/TLB flushes by default
Date: Thu, 29 Feb 2024 15:21:44 -0800
Message-ID: <20240229232211.161961-4-samuel.holland@sifive.com>
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

An IPI backend is always required in an SMP configuration, but an SBI
implementation is not. For example, SBI will be unavailable when the
kernel runs in M mode.

Generally, IPIs are assumed to be faster than SBI calls due to the SBI
context switch overhead. However, when SBI is used as the IPI backend,
then the context switch cost must be paid anyway, and performing the
cache/TLB flush directly in the SBI implementation is more efficient
than inserting an interrupt to the kernel. This is the only scenario
where riscv_ipi_set_virq_range()'s use_for_rfence parameter is false.

Thus, it makes sense for remote fences to use IPIs by default, and make
the SBI remote fence extension the special case.

sbi_ipi_init() already checks riscv_ipi_have_virq_range(), so it only
calls riscv_ipi_set_virq_range() when no other IPI device is available.
So we can move the static key and drop the use_for_rfence parameter.

Furthermore, the static branch only makes sense when CONFIG_RISCV_SBI is
enabled. Optherwise, IPIs must be used. Add a fallback definition of
riscv_use_sbi_for_rfence() which handles this case and removes the need
to check CONFIG_RISCV_SBI elsewhere, such as in cacheflush.c.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v5:
 - Also switch to riscv_use_sbi_for_rfence() in asm/pgalloc.h

Changes in v4:
 - New patch for v4

 arch/riscv/include/asm/pgalloc.h  |  7 ++++---
 arch/riscv/include/asm/sbi.h      |  4 ++++
 arch/riscv/include/asm/smp.h      | 15 ++-------------
 arch/riscv/kernel/sbi-ipi.c       | 11 ++++++++++-
 arch/riscv/kernel/smp.c           | 11 +----------
 arch/riscv/mm/cacheflush.c        |  5 ++---
 arch/riscv/mm/tlbflush.c          | 31 ++++++++++++++-----------------
 drivers/clocksource/timer-clint.c |  2 +-
 8 files changed, 38 insertions(+), 48 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 87468f67951a..6578054977ef 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -8,6 +8,7 @@
 #define _ASM_RISCV_PGALLOC_H
 
 #include <linux/mm.h>
+#include <asm/sbi.h>
 #include <asm/tlb.h>
 
 #ifdef CONFIG_MMU
@@ -90,10 +91,10 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 
 static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
 {
-	if (riscv_use_ipi_for_rfence())
-		tlb_remove_page_ptdesc(tlb, pt);
-	else
+	if (riscv_use_sbi_for_rfence())
 		tlb_remove_ptdesc(tlb, pt);
+	else
+		tlb_remove_page_ptdesc(tlb, pt);
 }
 
 #define pud_free pud_free
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6e68f8dff76b..ea84392ca9d7 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -375,8 +375,12 @@ unsigned long riscv_cached_marchid(unsigned int cpu_id);
 unsigned long riscv_cached_mimpid(unsigned int cpu_id);
 
 #if IS_ENABLED(CONFIG_SMP) && IS_ENABLED(CONFIG_RISCV_SBI)
+DECLARE_STATIC_KEY_FALSE(riscv_sbi_for_rfence);
+#define riscv_use_sbi_for_rfence() \
+	static_branch_unlikely(&riscv_sbi_for_rfence)
 void sbi_ipi_init(void);
 #else
+static inline bool riscv_use_sbi_for_rfence(void) { return false; }
 static inline void sbi_ipi_init(void) { }
 #endif
 
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 0d555847cde6..7ac80e9f2288 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -49,12 +49,7 @@ void riscv_ipi_disable(void);
 bool riscv_ipi_have_virq_range(void);
 
 /* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
-void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence);
-
-/* Check if we can use IPIs for remote FENCEs */
-DECLARE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
-#define riscv_use_ipi_for_rfence() \
-	static_branch_unlikely(&riscv_ipi_for_rfence)
+void riscv_ipi_set_virq_range(int virq, int nr);
 
 /* Check other CPUs stop or not */
 bool smp_crash_stop_failed(void);
@@ -104,16 +99,10 @@ static inline bool riscv_ipi_have_virq_range(void)
 	return false;
 }
 
-static inline void riscv_ipi_set_virq_range(int virq, int nr,
-					    bool use_for_rfence)
+static inline void riscv_ipi_set_virq_range(int virq, int nr)
 {
 }
 
-static inline bool riscv_use_ipi_for_rfence(void)
-{
-	return false;
-}
-
 #endif /* CONFIG_SMP */
 
 #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
index a4559695ce62..1026e22955cc 100644
--- a/arch/riscv/kernel/sbi-ipi.c
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -13,6 +13,9 @@
 #include <linux/irqdomain.h>
 #include <asm/sbi.h>
 
+DEFINE_STATIC_KEY_FALSE(riscv_sbi_for_rfence);
+EXPORT_SYMBOL_GPL(riscv_sbi_for_rfence);
+
 static int sbi_ipi_virq;
 
 static void sbi_ipi_handle(struct irq_desc *desc)
@@ -72,6 +75,12 @@ void __init sbi_ipi_init(void)
 			  "irqchip/sbi-ipi:starting",
 			  sbi_ipi_starting_cpu, NULL);
 
-	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE, false);
+	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
 	pr_info("providing IPIs using SBI IPI extension\n");
+
+	/*
+	 * Use the SBI remote fence extension to avoid
+	 * the extra context switch needed to handle IPIs.
+	 */
+	static_branch_enable(&riscv_sbi_for_rfence);
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 45dd4035416e..8e6eb64459af 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -171,10 +171,7 @@ bool riscv_ipi_have_virq_range(void)
 	return (ipi_virq_base) ? true : false;
 }
 
-DEFINE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
-EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
-
-void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
+void riscv_ipi_set_virq_range(int virq, int nr)
 {
 	int i, err;
 
@@ -197,12 +194,6 @@ void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
 
 	/* Enabled IPIs for boot CPU immediately */
 	riscv_ipi_enable();
-
-	/* Update RFENCE static key */
-	if (use_for_rfence)
-		static_branch_enable(&riscv_ipi_for_rfence);
-	else
-		static_branch_disable(&riscv_ipi_for_rfence);
 }
 
 static const char * const ipi_names[] = {
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 55a34f2020a8..47c485bc7df0 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -21,7 +21,7 @@ void flush_icache_all(void)
 {
 	local_flush_icache_all();
 
-	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
+	if (riscv_use_sbi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
@@ -69,8 +69,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		 * with flush_icache_deferred().
 		 */
 		smp_mb();
-	} else if (IS_ENABLED(CONFIG_RISCV_SBI) &&
-		   !riscv_use_ipi_for_rfence()) {
+	} else if (riscv_use_sbi_for_rfence()) {
 		sbi_remote_fence_i(&others);
 	} else {
 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 8d12b26f5ac3..0373661bd1c4 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -78,10 +78,10 @@ static void __ipi_flush_tlb_all(void *info)
 
 void flush_tlb_all(void)
 {
-	if (riscv_use_ipi_for_rfence())
-		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
-	else
+	if (riscv_use_sbi_for_rfence())
 		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
+	else
+		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
 }
 
 struct flush_tlb_range_data {
@@ -102,7 +102,6 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
 			      unsigned long start, unsigned long size,
 			      unsigned long stride)
 {
-	struct flush_tlb_range_data ftd;
 	bool broadcast;
 
 	if (cpumask_empty(cmask))
@@ -118,20 +117,18 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
 		broadcast = true;
 	}
 
-	if (broadcast) {
-		if (riscv_use_ipi_for_rfence()) {
-			ftd.asid = asid;
-			ftd.start = start;
-			ftd.size = size;
-			ftd.stride = stride;
-			on_each_cpu_mask(cmask,
-					 __ipi_flush_tlb_range_asid,
-					 &ftd, 1);
-		} else
-			sbi_remote_sfence_vma_asid(cmask,
-						   start, size, asid);
-	} else {
+	if (!broadcast) {
 		local_flush_tlb_range_asid(start, size, stride, asid);
+	} else if (riscv_use_sbi_for_rfence()) {
+		sbi_remote_sfence_vma_asid(cmask, start, size, asid);
+	} else {
+		struct flush_tlb_range_data ftd;
+
+		ftd.asid = asid;
+		ftd.start = start;
+		ftd.size = size;
+		ftd.stride = stride;
+		on_each_cpu_mask(cmask, __ipi_flush_tlb_range_asid, &ftd, 1);
 	}
 
 	if (cmask != cpu_online_mask)
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 09fd292eb83d..0bdd9d7ec545 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -251,7 +251,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
 	}
 
 	irq_set_chained_handler(clint_ipi_irq, clint_ipi_interrupt);
-	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE, true);
+	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE);
 	clint_clear_ipi();
 #endif
 
-- 
2.43.1


