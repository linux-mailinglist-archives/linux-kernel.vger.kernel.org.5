Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8551379C856
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjILHjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjILHjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:39:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B39E79
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:39:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D92C433C7;
        Tue, 12 Sep 2023 07:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694504375;
        bh=2/pCvglKl4/501OqfKFOIPZOlBK4HZAQFb+FilWHFBg=;
        h=From:To:Cc:Subject:Date:From;
        b=hYUqW9s1jOs6yftpCd2yKDguHWaEqScH05B3Gdt6NAPnA3UJzBK3jNCaERqGLcZAL
         /9Ee73Vg+LBox+Fo51pmKDkH7zoAxODhjDK5iu5HaifQ3sbfmarJTfHlciAmfOTZ4d
         bW/PpCOw3+mY0AkLEE9JtCaSgFTXXbN9hfhGBZPwSfmsYL1BDs3oLbaJ4RUKshP5I7
         S14dCGjfBRah14wvzgs2l8nq/db1BtBfJNP2AOydonhpDjtHzh2zLqaEs7lgUWgcFK
         8r8fvSBjRYmsuNON/jNCJ62B5to3RIZjt8NvaUmPPWQW4sTaE39psZkARScfRfm4K8
         6CuzPLhvvh4eg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: errata: thead: use riscv_nonstd_cache_ops for CMO
Date:   Tue, 12 Sep 2023 15:27:40 +0800
Message-Id: <20230912072740.2544-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we use alternative mechanism to dynamically patch
the CMO operations for THEAD C906/C910 during boot for performance
reason. But as pointed out by Arnd, "there is already a significant
cost in accessing the invalidated cache lines afterwards, which is
likely going to be much higher than the cost of an indirect branch".
And indeed, there's no performance difference with GMAC and EMMC per
my test on Sipeed Lichee Pi 4A board.

Use riscv_nonstd_cache_ops for THEAD C906/C910 CMO to simplify
the alternative code, and to acchieve Arnd's goal -- "I think
moving the THEAD ops at the same level as all nonstandard operations
makes sense, but I'd still leave CMO as an explicit fast path that
avoids the indirect branch. This seems like the right thing to do both
for readability and for platforms on which the indirect branch has a
noticeable overhead."

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig.errata            |  1 +
 arch/riscv/errata/thead/errata.c     | 76 +++++++++++++++++++++++++++-
 arch/riscv/include/asm/errata_list.h | 50 +++---------------
 3 files changed, 81 insertions(+), 46 deletions(-)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 566bcefeab50..d7972914f9de 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -78,6 +78,7 @@ config ERRATA_THEAD_CMO
 	bool "Apply T-Head cache management errata"
 	depends on ERRATA_THEAD && MMU
 	select RISCV_DMA_NONCOHERENT
+	select RISCV_NONSTANDARD_CACHE_OPS
 	default y
 	help
 	  This will apply the cache management errata to handle the
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 0554ed4bf087..1c320abfe446 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -12,8 +12,10 @@
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
+#include <asm/dma-noncoherent.h>
 #include <asm/errata_list.h>
 #include <asm/hwprobe.h>
+#include <asm/io.h>
 #include <asm/patch.h>
 #include <asm/vendorid_list.h>
 
@@ -33,6 +35,75 @@ static bool errata_probe_pbmt(unsigned int stage,
 	return false;
 }
 
+/*
+ * dcache.ipa rs1 (invalidate, physical address)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01010      rs1       000      00000  0001011
+ * dache.iva rs1 (invalida, virtual address)
+ *   0000001    00110      rs1       000      00000  0001011
+ *
+ * dcache.cpa rs1 (clean, physical address)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01001      rs1       000      00000  0001011
+ * dcache.cva rs1 (clean, virtual address)
+ *   0000001    00101      rs1       000      00000  0001011
+ *
+ * dcache.cipa rs1 (clean then invalidate, physical address)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000001    01011      rs1       000      00000  0001011
+ * dcache.civa rs1 (... virtual address)
+ *   0000001    00111      rs1       000      00000  0001011
+ *
+ * sync.s (make sure all cache operations finished)
+ * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *   0000000    11001     00000      000      00000  0001011
+ */
+#define THEAD_inval_A0	".long 0x0265000b"
+#define THEAD_clean_A0	".long 0x0255000b"
+#define THEAD_flush_A0	".long 0x0275000b"
+#define THEAD_SYNC_S	".long 0x0190000b"
+
+#define THEAD_CMO_OP(_op, _start, _size, _cachesize)			\
+asm volatile("mv a0, %1\n\t"						\
+	     "j 2f\n\t"							\
+	     "3:\n\t"							\
+	     THEAD_##_op##_A0 "\n\t"					\
+	     "add a0, a0, %0\n\t"					\
+	     "2:\n\t"							\
+	     "bltu a0, %2, 3b\n\t"					\
+	     THEAD_SYNC_S						\
+	     : : "r"(_cachesize),					\
+		 "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
+		 "r"((unsigned long)(_start) + (_size))			\
+	     : "a0")
+
+static void thead_errata_cache_inv(phys_addr_t paddr, size_t size)
+{
+	void *vaddr = phys_to_virt(paddr);
+
+	THEAD_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
+}
+
+static void thead_errata_cache_wback(phys_addr_t paddr, size_t size)
+{
+	void *vaddr = phys_to_virt(paddr);
+
+	THEAD_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+}
+
+static void thead_errata_cache_wback_inv(phys_addr_t paddr, size_t size)
+{
+	void *vaddr = phys_to_virt(paddr);
+
+	THEAD_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+}
+
+static const struct riscv_nonstd_cache_ops thead_errata_cmo_ops = {
+	.wback = &thead_errata_cache_wback,
+	.inv = &thead_errata_cache_inv,
+	.wback_inv = &thead_errata_cache_wback_inv,
+};
+
 static bool errata_probe_cmo(unsigned int stage,
 			     unsigned long arch_id, unsigned long impid)
 {
@@ -48,6 +119,8 @@ static bool errata_probe_cmo(unsigned int stage,
 	if (stage == RISCV_ALTERNATIVES_BOOT) {
 		riscv_cbom_block_size = L1_CACHE_BYTES;
 		riscv_noncoherent_supported();
+		if (IS_ENABLED(CONFIG_RISCV_NONSTANDARD_CACHE_OPS))
+			riscv_noncoherent_register_cache_ops(&thead_errata_cmo_ops);
 	}
 
 	return true;
@@ -77,8 +150,7 @@ static u32 thead_errata_probe(unsigned int stage,
 	if (errata_probe_pbmt(stage, archid, impid))
 		cpu_req_errata |= BIT(ERRATA_THEAD_PBMT);
 
-	if (errata_probe_cmo(stage, archid, impid))
-		cpu_req_errata |= BIT(ERRATA_THEAD_CMO);
+	errata_probe_cmo(stage, archid, impid);
 
 	if (errata_probe_pmu(stage, archid, impid))
 		cpu_req_errata |= BIT(ERRATA_THEAD_PMU);
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index b55b434f0059..ea33288f8a25 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -24,9 +24,8 @@
 
 #ifdef CONFIG_ERRATA_THEAD
 #define	ERRATA_THEAD_PBMT 0
-#define	ERRATA_THEAD_CMO 1
-#define	ERRATA_THEAD_PMU 2
-#define	ERRATA_THEAD_NUMBER 3
+#define	ERRATA_THEAD_PMU 1
+#define	ERRATA_THEAD_NUMBER 2
 #endif
 
 #ifdef __ASSEMBLY__
@@ -94,54 +93,17 @@ asm volatile(ALTERNATIVE(						\
 #define ALT_THEAD_PMA(_val)
 #endif
 
-/*
- * dcache.ipa rs1 (invalidate, physical address)
- * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
- *   0000001    01010      rs1       000      00000  0001011
- * dache.iva rs1 (invalida, virtual address)
- *   0000001    00110      rs1       000      00000  0001011
- *
- * dcache.cpa rs1 (clean, physical address)
- * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
- *   0000001    01001      rs1       000      00000  0001011
- * dcache.cva rs1 (clean, virtual address)
- *   0000001    00101      rs1       000      00000  0001011
- *
- * dcache.cipa rs1 (clean then invalidate, physical address)
- * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
- *   0000001    01011      rs1       000      00000  0001011
- * dcache.civa rs1 (... virtual address)
- *   0000001    00111      rs1       000      00000  0001011
- *
- * sync.s (make sure all cache operations finished)
- * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
- *   0000000    11001     00000      000      00000  0001011
- */
-#define THEAD_inval_A0	".long 0x0265000b"
-#define THEAD_clean_A0	".long 0x0255000b"
-#define THEAD_flush_A0	".long 0x0275000b"
-#define THEAD_SYNC_S	".long 0x0190000b"
-
 #define ALT_CMO_OP(_op, _start, _size, _cachesize)			\
-asm volatile(ALTERNATIVE_2(						\
-	__nops(6),							\
+asm volatile(ALTERNATIVE(						\
+	__nops(5),							\
 	"mv a0, %1\n\t"							\
 	"j 2f\n\t"							\
 	"3:\n\t"							\
 	CBO_##_op(a0)							\
 	"add a0, a0, %0\n\t"						\
 	"2:\n\t"							\
-	"bltu a0, %2, 3b\n\t"						\
-	"nop", 0, RISCV_ISA_EXT_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,	\
-	"mv a0, %1\n\t"							\
-	"j 2f\n\t"							\
-	"3:\n\t"							\
-	THEAD_##_op##_A0 "\n\t"						\
-	"add a0, a0, %0\n\t"						\
-	"2:\n\t"							\
-	"bltu a0, %2, 3b\n\t"						\
-	THEAD_SYNC_S, THEAD_VENDOR_ID,					\
-			ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)	\
+	"bltu a0, %2, 3b\n\t",						\
+	0, RISCV_ISA_EXT_ZICBOM, CONFIG_RISCV_ISA_ZICBOM)		\
 	: : "r"(_cachesize),						\
 	    "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
 	    "r"((unsigned long)(_start) + (_size))			\
-- 
2.40.1

