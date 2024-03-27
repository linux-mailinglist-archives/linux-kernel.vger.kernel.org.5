Return-Path: <linux-kernel+bounces-120306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C4988D58E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF2D1F2B91E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AFE1429E;
	Wed, 27 Mar 2024 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aRcCHUkY"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309C3DAC13
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515047; cv=none; b=nkYBa+H+SV3WzCr8tpyNqmjFluxFIP5kkMdVqCQ6V31b210g+l+scviOcXVKnMqXmLCERsLkKw9BKT9Vts8ntk+Uj8K4SqjNGc0/Rg6XhV1ByA9AfAmK1MaeLzvdwgtfoxONX27iNylBIYuMiMmHJwt+ELaKcEbQqQkcBP+GSbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515047; c=relaxed/simple;
	bh=9+kHQMgLvVcAI1DoTqT+nRSSAlZswillYYHPJoS2Qmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gf3N9ClwKwXznSyOkHERArSnqQA8n9O7WkW2zzkeYrvi1TAsbZiBx79kTrxWURDZagdJf0QFmnp3TCpVjXAtEheDtdGup1LXfYPXb9/gwwFFJU0rYHVAFg45ImdSssDWENWcxurs2IFIHZsUzKDa7X/Ofx2GHsXogsI7K2P9q08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=aRcCHUkY; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60a0599f631so55694567b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711515045; x=1712119845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6C+MSH7tzUf74TudLETMF5DBzv2rpp8bzfwEKTodUs=;
        b=aRcCHUkYDjv3SzmzA6Mx58hlY3XspN7E7LNvZG+ikjWwzvSsutzTVA90FzeQCHdWl0
         a6MVO8/T9Z4QaQQpjIFXrWWQJg6wPw2xbhfyg46PmZ1g8KPYj5MwC187jfq+Q/z85Z55
         Gik7L+COuIf6XOBHE51wmgTMbckOe9VVr7IyCUkpjG/r+nYsQC3Zb1ESMeLDKZ1RducT
         OsZM0teZyvyWLIgVKyhRhmFVUVI9gRqGSG9Az5HQ5qTwY0wIuYC7p/O2MmePN1CedxbA
         WeZKnt6YKGYTQD0iEPErQpqPJzedrHl9UwRoSuIEMb7lE81QZ+il0TXmSUASNsG4zQ5n
         Xhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515045; x=1712119845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6C+MSH7tzUf74TudLETMF5DBzv2rpp8bzfwEKTodUs=;
        b=TxNgWl0qFD8RGfgkmHdTqe4UQH0uWCwUNv2Jg7jguyOlxEkABrjXY+RzdfUyAPoSYC
         DRRTiTEGjSentUm/HWe78QyaLm1BXohKFcs1ygkHSNi+yl3msiku+uKVhRLOpqrzhaX3
         zqSzs7J9ayb1cOiSznKVJM8Lj0OSICdh2z6p88CW8P+QFW0Xr3vE9TNbbrcxlULpT+EA
         RVivPa5jNlxqjtMx16xosJJ10Ezp0q9eoqLQhlh/Tmobej1QxrR1j1uVgqlR20BafePt
         2o67B+qkZJBJ3giaWcpC8m/4tVQPC+qe1N9ISwW9uO6JpeZtvE6QRpdTx8Ru69EWw/cy
         fjAA==
X-Gm-Message-State: AOJu0Yxn1kW8m7lPVtEpxTMkzH+69sj1ZxXuht3mCFj/SHomr3Gk2m67
	xHYHhkgGMSbqpduJhvuLa8HqJCsEjg4ROA4ru/7ddqwNtOA75F1Tpc7wjaNarmA=
X-Google-Smtp-Source: AGHT+IH+jSoiPAnTh406w99fZLlqeG+exqQi31XclYwr8IOVXBgedOOFyirc6G8eGQn9SYpg/+yAIQ==
X-Received: by 2002:a81:8084:0:b0:611:9be5:4e17 with SMTP id q126-20020a818084000000b006119be54e17mr18863ywf.51.1711515044780;
        Tue, 26 Mar 2024 21:50:44 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e31-20020a63501f000000b005e4666261besm8351500pgb.50.2024.03.26.21.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:50:43 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH v6 03/13] riscv: Use IPIs for remote cache/TLB flushes by default
Date: Tue, 26 Mar 2024 21:49:44 -0700
Message-ID: <20240327045035.368512-4-samuel.holland@sifive.com>
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

An IPI backend is always required in an SMP configuration, but an SBI
implementation is not. For example, SBI will be unavailable when the
kernel runs in M mode. For this reason, consider IPI delivery of cache
and TLB flushes to be the base case, and any other implementation (such
as the SBI remote fence extension) to be an optimization.

Generally, if IPIs can be delivered without firmware assistance, they
are assumed to be faster than SBI calls due to the SBI context switch
overhead. However, when SBI is used as the IPI backend, then the context
switch cost must be paid anyway, and performing the cache/TLB flush
directly in the SBI implementation is more efficient than injecting an
interrupt to S-mode. This is the only existing scenario where
riscv_ipi_set_virq_range() is called with use_for_rfence set to false.

sbi_ipi_init() already checks riscv_ipi_have_virq_range(), so it only
calls riscv_ipi_set_virq_range() when no other IPI device is available.
This allows moving the static key and dropping the use_for_rfence
parameter. This decouples the static key from the irqchip driver probe
order.

Furthermore, the static branch only makes sense when CONFIG_RISCV_SBI is
enabled. Optherwise, IPIs must be used. Add a fallback definition of
riscv_use_sbi_for_rfence() which handles this case and removes the need
to check CONFIG_RISCV_SBI elsewhere, such as in cacheflush.c.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v6:
 - Clarify the commit message for patch 3 based on ML discussion

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
index b34587da8882..f52264304f77 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -8,6 +8,7 @@
 #define _ASM_RISCV_PGALLOC_H
 
 #include <linux/mm.h>
+#include <asm/sbi.h>
 #include <asm/tlb.h>
 
 #ifdef CONFIG_MMU
@@ -17,10 +18,10 @@
 
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
 
 static inline void pmd_populate_kernel(struct mm_struct *mm,
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
index bc61ee5975e4..d76fc73e594b 100644
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
index 893566e004b7..0435605b07d0 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -79,10 +79,10 @@ static void __ipi_flush_tlb_all(void *info)
 
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
@@ -103,7 +103,6 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
 			      unsigned long start, unsigned long size,
 			      unsigned long stride)
 {
-	struct flush_tlb_range_data ftd;
 	bool broadcast;
 
 	if (cpumask_empty(cmask))
@@ -119,20 +118,18 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
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


