Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4547754B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjHIICW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjHIICJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:02:09 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDBC1FD0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 01:02:04 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RLMwC5KMGz9srx;
        Wed,  9 Aug 2023 10:02:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jZ-lLv-6tlX0; Wed,  9 Aug 2023 10:02:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RLMwC4f56z9srj;
        Wed,  9 Aug 2023 10:02:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9BEC18B76C;
        Wed,  9 Aug 2023 10:02:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 21PfbvjQUeuT; Wed,  9 Aug 2023 10:02:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B7518B763;
        Wed,  9 Aug 2023 10:02:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 379822Hb1471517
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 10:02:02 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3798214G1471508;
        Wed, 9 Aug 2023 10:02:01 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc/radix: Move some functions into #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
Date:   Wed,  9 Aug 2023 10:01:43 +0200
Message-ID: <3d72efd39f986ee939d068af69fdce28bd600766.1691568093.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691568102; l=11264; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=oJDAkrXbo4dtPcABi+32As/6Db4/i1QfIXRL7mdHxvM=; b=eDMdq5+enFzHISsk2mQaE1enewh/RzZhQo1kz0qyHIM/HxzZzV6ce2PzamWiAqk1jJq6zFIhu yEJ8ma8wfrMAAYNqKKbARuBpkOiViC6m6/CFnf2Ige69gdr9xfQ8r+L
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With skiboot_defconfig, Clang reports:

  CC      arch/powerpc/mm/book3s64/radix_tlb.o
arch/powerpc/mm/book3s64/radix_tlb.c:419:20: error: unused function '_tlbie_pid_lpid' [-Werror,-Wunused-function]
static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
                   ^
arch/powerpc/mm/book3s64/radix_tlb.c:663:20: error: unused function '_tlbie_va_range_lpid' [-Werror,-Wunused-function]
static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
                   ^

This is because those functions are only called from functions
enclosed in a #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE

Move below functions inside that #ifdef
* __tlbie_pid_lpid(unsigned long pid,
* __tlbie_va_lpid(unsigned long va, unsigned long pid,
* fixup_tlbie_pid_lpid(unsigned long pid, unsigned long lpid)
* _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
* fixup_tlbie_va_range_lpid(unsigned long va,
* __tlbie_va_range_lpid(unsigned long start, unsigned long end,
* _tlbie_va_range_lpid(unsigned long start, unsigned long end,

Fixes: f0c6fbbb9050 ("KVM: PPC: Book3S HV: Add support for H_RPT_INVALIDATE")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307260802.Mjr99P5O-lkp@intel.com/
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s64/radix_tlb.c | 240 ++++++++++++++-------------
 1 file changed, 121 insertions(+), 119 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index ce804b7bf84e..867ce8c463ee 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -127,21 +127,6 @@ static __always_inline void __tlbie_pid(unsigned long pid, unsigned long ric)
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
-static __always_inline void __tlbie_pid_lpid(unsigned long pid,
-					     unsigned long lpid,
-					     unsigned long ric)
-{
-	unsigned long rb, rs, prs, r;
-
-	rb = PPC_BIT(53); /* IS = 1 */
-	rs = (pid << PPC_BITLSHIFT(31)) | (lpid & ~(PPC_BITMASK(0, 31)));
-	prs = 1; /* process scoped */
-	r = 1;   /* radix format */
-
-	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
-		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
-	trace_tlbie(0, 0, rb, rs, ric, prs, r);
-}
 static __always_inline void __tlbie_lpid(unsigned long lpid, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
@@ -202,23 +187,6 @@ static __always_inline void __tlbie_va(unsigned long va, unsigned long pid,
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
-static __always_inline void __tlbie_va_lpid(unsigned long va, unsigned long pid,
-					    unsigned long lpid,
-					    unsigned long ap, unsigned long ric)
-{
-	unsigned long rb, rs, prs, r;
-
-	rb = va & ~(PPC_BITMASK(52, 63));
-	rb |= ap << PPC_BITLSHIFT(58);
-	rs = (pid << PPC_BITLSHIFT(31)) | (lpid & ~(PPC_BITMASK(0, 31)));
-	prs = 1; /* process scoped */
-	r = 1;   /* radix format */
-
-	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
-		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
-	trace_tlbie(0, 0, rb, rs, ric, prs, r);
-}
-
 static __always_inline void __tlbie_lpid_va(unsigned long va, unsigned long lpid,
 					    unsigned long ap, unsigned long ric)
 {
@@ -264,22 +232,6 @@ static inline void fixup_tlbie_va_range(unsigned long va, unsigned long pid,
 	}
 }
 
-static inline void fixup_tlbie_va_range_lpid(unsigned long va,
-					     unsigned long pid,
-					     unsigned long lpid,
-					     unsigned long ap)
-{
-	if (cpu_has_feature(CPU_FTR_P9_TLBIE_ERAT_BUG)) {
-		asm volatile("ptesync" : : : "memory");
-		__tlbie_pid_lpid(0, lpid, RIC_FLUSH_TLB);
-	}
-
-	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
-		asm volatile("ptesync" : : : "memory");
-		__tlbie_va_lpid(va, pid, lpid, ap, RIC_FLUSH_TLB);
-	}
-}
-
 static inline void fixup_tlbie_pid(unsigned long pid)
 {
 	/*
@@ -299,26 +251,6 @@ static inline void fixup_tlbie_pid(unsigned long pid)
 	}
 }
 
-static inline void fixup_tlbie_pid_lpid(unsigned long pid, unsigned long lpid)
-{
-	/*
-	 * We can use any address for the invalidation, pick one which is
-	 * probably unused as an optimisation.
-	 */
-	unsigned long va = ((1UL << 52) - 1);
-
-	if (cpu_has_feature(CPU_FTR_P9_TLBIE_ERAT_BUG)) {
-		asm volatile("ptesync" : : : "memory");
-		__tlbie_pid_lpid(0, lpid, RIC_FLUSH_TLB);
-	}
-
-	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
-		asm volatile("ptesync" : : : "memory");
-		__tlbie_va_lpid(va, pid, lpid, mmu_get_ap(MMU_PAGE_64K),
-				RIC_FLUSH_TLB);
-	}
-}
-
 static inline void fixup_tlbie_lpid_va(unsigned long va, unsigned long lpid,
 				       unsigned long ap)
 {
@@ -416,31 +348,6 @@ static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
-static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
-				   unsigned long ric)
-{
-	asm volatile("ptesync" : : : "memory");
-
-	/*
-	 * Workaround the fact that the "ric" argument to __tlbie_pid
-	 * must be a compile-time contraint to match the "i" constraint
-	 * in the asm statement.
-	 */
-	switch (ric) {
-	case RIC_FLUSH_TLB:
-		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_TLB);
-		fixup_tlbie_pid_lpid(pid, lpid);
-		break;
-	case RIC_FLUSH_PWC:
-		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
-		break;
-	case RIC_FLUSH_ALL:
-	default:
-		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_ALL);
-		fixup_tlbie_pid_lpid(pid, lpid);
-	}
-	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
-}
 struct tlbiel_pid {
 	unsigned long pid;
 	unsigned long ric;
@@ -566,20 +473,6 @@ static inline void __tlbie_va_range(unsigned long start, unsigned long end,
 	fixup_tlbie_va_range(addr - page_size, pid, ap);
 }
 
-static inline void __tlbie_va_range_lpid(unsigned long start, unsigned long end,
-					 unsigned long pid, unsigned long lpid,
-					 unsigned long page_size,
-					 unsigned long psize)
-{
-	unsigned long addr;
-	unsigned long ap = mmu_get_ap(psize);
-
-	for (addr = start; addr < end; addr += page_size)
-		__tlbie_va_lpid(addr, pid, lpid, ap, RIC_FLUSH_TLB);
-
-	fixup_tlbie_va_range_lpid(addr - page_size, pid, lpid, ap);
-}
-
 static __always_inline void _tlbie_va(unsigned long va, unsigned long pid,
 				      unsigned long psize, unsigned long ric)
 {
@@ -660,18 +553,6 @@ static inline void _tlbie_va_range(unsigned long start, unsigned long end,
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
-static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
-					unsigned long pid, unsigned long lpid,
-					unsigned long page_size,
-					unsigned long psize, bool also_pwc)
-{
-	asm volatile("ptesync" : : : "memory");
-	if (also_pwc)
-		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
-	__tlbie_va_range_lpid(start, end, pid, lpid, page_size, psize);
-	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
-}
-
 static inline void _tlbiel_va_range_multicast(struct mm_struct *mm,
 				unsigned long start, unsigned long end,
 				unsigned long pid, unsigned long page_size,
@@ -1478,6 +1359,127 @@ void radix__flush_tlb_all(void)
 }
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+static __always_inline void __tlbie_pid_lpid(unsigned long pid,
+					     unsigned long lpid,
+					     unsigned long ric)
+{
+	unsigned long rb, rs, prs, r;
+
+	rb = PPC_BIT(53); /* IS = 1 */
+	rs = (pid << PPC_BITLSHIFT(31)) | (lpid & ~(PPC_BITMASK(0, 31)));
+	prs = 1; /* process scoped */
+	r = 1;   /* radix format */
+
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	trace_tlbie(0, 0, rb, rs, ric, prs, r);
+}
+
+static __always_inline void __tlbie_va_lpid(unsigned long va, unsigned long pid,
+					    unsigned long lpid,
+					    unsigned long ap, unsigned long ric)
+{
+	unsigned long rb, rs, prs, r;
+
+	rb = va & ~(PPC_BITMASK(52, 63));
+	rb |= ap << PPC_BITLSHIFT(58);
+	rs = (pid << PPC_BITLSHIFT(31)) | (lpid & ~(PPC_BITMASK(0, 31)));
+	prs = 1; /* process scoped */
+	r = 1;   /* radix format */
+
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	trace_tlbie(0, 0, rb, rs, ric, prs, r);
+}
+
+static inline void fixup_tlbie_pid_lpid(unsigned long pid, unsigned long lpid)
+{
+	/*
+	 * We can use any address for the invalidation, pick one which is
+	 * probably unused as an optimisation.
+	 */
+	unsigned long va = ((1UL << 52) - 1);
+
+	if (cpu_has_feature(CPU_FTR_P9_TLBIE_ERAT_BUG)) {
+		asm volatile("ptesync" : : : "memory");
+		__tlbie_pid_lpid(0, lpid, RIC_FLUSH_TLB);
+	}
+
+	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
+		asm volatile("ptesync" : : : "memory");
+		__tlbie_va_lpid(va, pid, lpid, mmu_get_ap(MMU_PAGE_64K),
+				RIC_FLUSH_TLB);
+	}
+}
+
+static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
+				   unsigned long ric)
+{
+	asm volatile("ptesync" : : : "memory");
+
+	/*
+	 * Workaround the fact that the "ric" argument to __tlbie_pid
+	 * must be a compile-time contraint to match the "i" constraint
+	 * in the asm statement.
+	 */
+	switch (ric) {
+	case RIC_FLUSH_TLB:
+		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_TLB);
+		fixup_tlbie_pid_lpid(pid, lpid);
+		break;
+	case RIC_FLUSH_PWC:
+		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
+		break;
+	case RIC_FLUSH_ALL:
+	default:
+		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_ALL);
+		fixup_tlbie_pid_lpid(pid, lpid);
+	}
+	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
+}
+
+static inline void fixup_tlbie_va_range_lpid(unsigned long va,
+					     unsigned long pid,
+					     unsigned long lpid,
+					     unsigned long ap)
+{
+	if (cpu_has_feature(CPU_FTR_P9_TLBIE_ERAT_BUG)) {
+		asm volatile("ptesync" : : : "memory");
+		__tlbie_pid_lpid(0, lpid, RIC_FLUSH_TLB);
+	}
+
+	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
+		asm volatile("ptesync" : : : "memory");
+		__tlbie_va_lpid(va, pid, lpid, ap, RIC_FLUSH_TLB);
+	}
+}
+
+static inline void __tlbie_va_range_lpid(unsigned long start, unsigned long end,
+					 unsigned long pid, unsigned long lpid,
+					 unsigned long page_size,
+					 unsigned long psize)
+{
+	unsigned long addr;
+	unsigned long ap = mmu_get_ap(psize);
+
+	for (addr = start; addr < end; addr += page_size)
+		__tlbie_va_lpid(addr, pid, lpid, ap, RIC_FLUSH_TLB);
+
+	fixup_tlbie_va_range_lpid(addr - page_size, pid, lpid, ap);
+}
+
+static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
+					unsigned long pid, unsigned long lpid,
+					unsigned long page_size,
+					unsigned long psize, bool also_pwc)
+{
+	asm volatile("ptesync" : : : "memory");
+	if (also_pwc)
+		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
+	__tlbie_va_range_lpid(start, end, pid, lpid, page_size, psize);
+	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
+}
+
 /*
  * Performs process-scoped invalidations for a given LPID
  * as part of H_RPT_INVALIDATE hcall.
-- 
2.41.0

