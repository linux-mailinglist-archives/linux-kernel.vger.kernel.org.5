Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14CC78DFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbjH3TO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245312AbjH3PId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:08:33 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 08:08:23 PDT
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2591A4;
        Wed, 30 Aug 2023 08:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8930DB81F70;
        Wed, 30 Aug 2023 15:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A83C433C7;
        Wed, 30 Aug 2023 15:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693407773;
        bh=U27Rv0epOUH8+qiOigR9+nljdBBr822cMiHH97tk3t4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FS1q7i3howYNNM1C0I33SQrPatECavk51gnfYM9RGKkjgtusiWmRhN3cVPxWypvnT
         52inx82eM91Nh8hxbweHSqXWXoAAHwpVBMTxnHLIXHJ0i+pQCeFnLnNqr4czvYv2/i
         vlPRcKpURvTOxVKclzjgpKDRGTLLZc5Q3efXZmbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.293
Date:   Wed, 30 Aug 2023 17:02:43 +0200
Message-ID: <2023083043-blurt-mummify-27f6@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023083043-preface-compel-9b05@gregkh>
References: <2023083043-preface-compel-9b05@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index fcd6a9b17301..5965df0393fd 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 292
+SUBLEVEL = 293
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 4e2ee743088f..51faee420745 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -111,7 +111,24 @@
 #define cpu_has_tx39_cache	__opt(MIPS_CPU_TX39_CACHE)
 #endif
 #ifndef cpu_has_octeon_cache
-#define cpu_has_octeon_cache	0
+#define cpu_has_octeon_cache						\
+({									\
+	int __res;							\
+									\
+	switch (boot_cpu_type()) {					\
+	case CPU_CAVIUM_OCTEON:						\
+	case CPU_CAVIUM_OCTEON_PLUS:					\
+	case CPU_CAVIUM_OCTEON2:					\
+	case CPU_CAVIUM_OCTEON3:					\
+		__res = 1;						\
+		break;							\
+									\
+	default:							\
+		__res = 0;						\
+	}								\
+									\
+	__res;								\
+})
 #endif
 /* Don't override `cpu_has_fpu' to 1 or the "nofpu" option won't work.  */
 #ifndef cpu_has_fpu
@@ -332,7 +349,7 @@
 ({									\
 	int __res;							\
 									\
-	switch (current_cpu_type()) {					\
+	switch (boot_cpu_type()) {					\
 	case CPU_M14KC:							\
 	case CPU_74K:							\
 	case CPU_1074K:							\
diff --git a/arch/mips/include/asm/dec/prom.h b/arch/mips/include/asm/dec/prom.h
index 09538ff5e924..6f0405ba27d6 100644
--- a/arch/mips/include/asm/dec/prom.h
+++ b/arch/mips/include/asm/dec/prom.h
@@ -74,7 +74,7 @@ static inline bool prom_is_rex(u32 magic)
  */
 typedef struct {
 	int pagesize;
-	unsigned char bitmap[0];
+	unsigned char bitmap[];
 } memmap;
 
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f0e09d5f0bed..3be56d857d57 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -181,6 +181,7 @@ config PPC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_CBPF_JIT			if !PPC64
+	select HAVE_STACKPROTECTOR		if $(cc-option,-mstack-protector-guard=tls) && PPC32
 	select HAVE_CONTEXT_TRACKING		if PPC64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_STACKOVERFLOW
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 923b3b794d13..1f54bb93b5cc 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -368,10 +368,6 @@ config PPC_PTDUMP
 
 	  If you are unsure, say N.
 
-config PPC_HTDUMP
-	def_bool y
-	depends on PPC_PTDUMP && PPC_BOOK3S_64
-
 config PPC_FAST_ENDIAN_SWITCH
 	bool "Deprecated fast endian-switch syscall"
         depends on DEBUG_KERNEL && PPC_BOOK3S_64
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index b2e0fd873562..daddada1a390 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -113,6 +113,9 @@ KBUILD_LDFLAGS	+= -m elf$(BITS)$(LDEMULATION)
 KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
 endif
 
+cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard=tls
+cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-reg=r2
+
 LDFLAGS_vmlinux-y := -Bstatic
 LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
@@ -419,9 +422,12 @@ archclean:
 
 archprepare: checkbin
 
-# Use the file '.tmp_gas_check' for binutils tests, as gas won't output
-# to stdout and these checks are run even on install targets.
-TOUT	:= .tmp_gas_check
+ifdef CONFIG_STACKPROTECTOR
+prepare: stack_protector_prepare
+
+stack_protector_prepare: prepare0
+	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TASK_CANARY") print $$3;}' include/generated/asm-offsets.h))
+endif
 
 # Check toolchain versions:
 # - gcc-4.6 is the minimum kernel-wide version so nothing required.
@@ -433,7 +439,11 @@ checkbin:
 		echo -n '*** Please use a different binutils version.' ; \
 		false ; \
 	fi
-
-
-CLEAN_FILES += $(TOUT)
-
+	@if test "x${CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT}" = "xy" -a \
+		"x${CONFIG_LD_IS_BFD}" = "xy" -a \
+		"${CONFIG_LD_VERSION}" = "23700" ; then \
+		echo -n '*** binutils 2.37 drops unused section symbols, which recordmcount ' ; \
+		echo 'is unable to handle.' ; \
+		echo '*** Please use a different binutils version.' ; \
+		false ; \
+	fi
diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index e38c91388c40..958b18cecc96 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -34,14 +34,20 @@
 #define BAT_PHYS_ADDR(x) ((u32)((x & 0x00000000fffe0000ULL) | \
 				((x & 0x0000000e00000000ULL) >> 24) | \
 				((x & 0x0000000100000000ULL) >> 30)))
+#define PHYS_BAT_ADDR(x) (((u64)(x) & 0x00000000fffe0000ULL) | \
+			  (((u64)(x) << 24) & 0x0000000e00000000ULL) | \
+			  (((u64)(x) << 30) & 0x0000000100000000ULL))
 #else
 #define BAT_PHYS_ADDR(x) (x)
+#define PHYS_BAT_ADDR(x) ((x) & 0xfffe0000)
 #endif
 
 struct ppc_bat {
 	u32 batu;
 	u32 batl;
 };
+
+typedef struct page *pgtable_t;
 #endif /* !__ASSEMBLY__ */
 
 /*
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 9c8c669a6b6a..488e7ed07e96 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_MMU_H_
 #define _ASM_POWERPC_BOOK3S_64_MMU_H_
 
+#include <asm/page.h>
+
 #ifndef __ASSEMBLY__
 /*
  * Page size definition
@@ -24,6 +26,13 @@ struct mmu_psize_def {
 };
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 
+/*
+ * For BOOK3s 64 with 4k and 64K linux page size
+ * we want to use pointers, because the page table
+ * actually store pfn
+ */
+typedef pte_t *pgtable_t;
+
 #endif /* __ASSEMBLY__ */
 
 /* 64-bit classic hash table MMU */
diff --git a/arch/powerpc/include/asm/mmu-40x.h b/arch/powerpc/include/asm/mmu-40x.h
deleted file mode 100644
index 74f4edb5916e..000000000000
--- a/arch/powerpc/include/asm/mmu-40x.h
+++ /dev/null
@@ -1,68 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_MMU_40X_H_
-#define _ASM_POWERPC_MMU_40X_H_
-
-/*
- * PPC40x support
- */
-
-#define PPC40X_TLB_SIZE 64
-
-/*
- * TLB entries are defined by a "high" tag portion and a "low" data
- * portion.  On all architectures, the data portion is 32-bits.
- *
- * TLB entries are managed entirely under software control by reading,
- * writing, and searchoing using the 4xx-specific tlbre, tlbwr, and tlbsx
- * instructions.
- */
-
-#define	TLB_LO          1
-#define	TLB_HI          0
-
-#define	TLB_DATA        TLB_LO
-#define	TLB_TAG         TLB_HI
-
-/* Tag portion */
-
-#define TLB_EPN_MASK    0xFFFFFC00      /* Effective Page Number */
-#define TLB_PAGESZ_MASK 0x00000380
-#define TLB_PAGESZ(x)   (((x) & 0x7) << 7)
-#define   PAGESZ_1K		0
-#define   PAGESZ_4K             1
-#define   PAGESZ_16K            2
-#define   PAGESZ_64K            3
-#define   PAGESZ_256K           4
-#define   PAGESZ_1M             5
-#define   PAGESZ_4M             6
-#define   PAGESZ_16M            7
-#define TLB_VALID       0x00000040      /* Entry is valid */
-
-/* Data portion */
-
-#define TLB_RPN_MASK    0xFFFFFC00      /* Real Page Number */
-#define TLB_PERM_MASK   0x00000300
-#define TLB_EX          0x00000200      /* Instruction execution allowed */
-#define TLB_WR          0x00000100      /* Writes permitted */
-#define TLB_ZSEL_MASK   0x000000F0
-#define TLB_ZSEL(x)     (((x) & 0xF) << 4)
-#define TLB_ATTR_MASK   0x0000000F
-#define TLB_W           0x00000008      /* Caching is write-through */
-#define TLB_I           0x00000004      /* Caching is inhibited */
-#define TLB_M           0x00000002      /* Memory is coherent */
-#define TLB_G           0x00000001      /* Memory is guarded from prefetch */
-
-#ifndef __ASSEMBLY__
-
-typedef struct {
-	unsigned int	id;
-	unsigned int	active;
-	unsigned long	vdso_base;
-} mm_context_t;
-
-#endif /* !__ASSEMBLY__ */
-
-#define mmu_virtual_psize	MMU_PAGE_4K
-#define mmu_linear_psize	MMU_PAGE_256M
-
-#endif /* _ASM_POWERPC_MMU_40X_H_ */
diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
deleted file mode 100644
index 295b3dbb2698..000000000000
--- a/arch/powerpc/include/asm/mmu-44x.h
+++ /dev/null
@@ -1,153 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_MMU_44X_H_
-#define _ASM_POWERPC_MMU_44X_H_
-/*
- * PPC440 support
- */
-
-#include <asm/asm-const.h>
-
-#define PPC44x_MMUCR_TID	0x000000ff
-#define PPC44x_MMUCR_STS	0x00010000
-
-#define	PPC44x_TLB_PAGEID	0
-#define	PPC44x_TLB_XLAT		1
-#define	PPC44x_TLB_ATTRIB	2
-
-/* Page identification fields */
-#define PPC44x_TLB_EPN_MASK	0xfffffc00      /* Effective Page Number */
-#define	PPC44x_TLB_VALID	0x00000200      /* Valid flag */
-#define PPC44x_TLB_TS		0x00000100	/* Translation address space */
-#define PPC44x_TLB_1K		0x00000000	/* Page sizes */
-#define PPC44x_TLB_4K		0x00000010
-#define PPC44x_TLB_16K		0x00000020
-#define PPC44x_TLB_64K		0x00000030
-#define PPC44x_TLB_256K		0x00000040
-#define PPC44x_TLB_1M		0x00000050
-#define PPC44x_TLB_16M		0x00000070
-#define	PPC44x_TLB_256M		0x00000090
-
-/* Translation fields */
-#define PPC44x_TLB_RPN_MASK	0xfffffc00      /* Real Page Number */
-#define	PPC44x_TLB_ERPN_MASK	0x0000000f
-
-/* Storage attribute and access control fields */
-#define PPC44x_TLB_ATTR_MASK	0x0000ff80
-#define PPC44x_TLB_U0		0x00008000      /* User 0 */
-#define PPC44x_TLB_U1		0x00004000      /* User 1 */
-#define PPC44x_TLB_U2		0x00002000      /* User 2 */
-#define PPC44x_TLB_U3		0x00001000      /* User 3 */
-#define PPC44x_TLB_W		0x00000800      /* Caching is write-through */
-#define PPC44x_TLB_I		0x00000400      /* Caching is inhibited */
-#define PPC44x_TLB_M		0x00000200      /* Memory is coherent */
-#define PPC44x_TLB_G		0x00000100      /* Memory is guarded */
-#define PPC44x_TLB_E		0x00000080      /* Memory is little endian */
-
-#define PPC44x_TLB_PERM_MASK	0x0000003f
-#define PPC44x_TLB_UX		0x00000020      /* User execution */
-#define PPC44x_TLB_UW		0x00000010      /* User write */
-#define PPC44x_TLB_UR		0x00000008      /* User read */
-#define PPC44x_TLB_SX		0x00000004      /* Super execution */
-#define PPC44x_TLB_SW		0x00000002      /* Super write */
-#define PPC44x_TLB_SR		0x00000001      /* Super read */
-
-/* Number of TLB entries */
-#define PPC44x_TLB_SIZE		64
-
-/* 47x bits */
-#define PPC47x_MMUCR_TID	0x0000ffff
-#define PPC47x_MMUCR_STS	0x00010000
-
-/* Page identification fields */
-#define PPC47x_TLB0_EPN_MASK	0xfffff000      /* Effective Page Number */
-#define PPC47x_TLB0_VALID	0x00000800      /* Valid flag */
-#define PPC47x_TLB0_TS		0x00000400	/* Translation address space */
-#define PPC47x_TLB0_4K		0x00000000
-#define PPC47x_TLB0_16K		0x00000010
-#define PPC47x_TLB0_64K		0x00000030
-#define PPC47x_TLB0_1M		0x00000070
-#define PPC47x_TLB0_16M		0x000000f0
-#define PPC47x_TLB0_256M	0x000001f0
-#define PPC47x_TLB0_1G		0x000003f0
-#define PPC47x_TLB0_BOLTED_R	0x00000008	/* tlbre only */
-
-/* Translation fields */
-#define PPC47x_TLB1_RPN_MASK	0xfffff000      /* Real Page Number */
-#define PPC47x_TLB1_ERPN_MASK	0x000003ff
-
-/* Storage attribute and access control fields */
-#define PPC47x_TLB2_ATTR_MASK	0x0003ff80
-#define PPC47x_TLB2_IL1I	0x00020000      /* Memory is guarded */
-#define PPC47x_TLB2_IL1D	0x00010000      /* Memory is guarded */
-#define PPC47x_TLB2_U0		0x00008000      /* User 0 */
-#define PPC47x_TLB2_U1		0x00004000      /* User 1 */
-#define PPC47x_TLB2_U2		0x00002000      /* User 2 */
-#define PPC47x_TLB2_U3		0x00001000      /* User 3 */
-#define PPC47x_TLB2_W		0x00000800      /* Caching is write-through */
-#define PPC47x_TLB2_I		0x00000400      /* Caching is inhibited */
-#define PPC47x_TLB2_M		0x00000200      /* Memory is coherent */
-#define PPC47x_TLB2_G		0x00000100      /* Memory is guarded */
-#define PPC47x_TLB2_E		0x00000080      /* Memory is little endian */
-#define PPC47x_TLB2_PERM_MASK	0x0000003f
-#define PPC47x_TLB2_UX		0x00000020      /* User execution */
-#define PPC47x_TLB2_UW		0x00000010      /* User write */
-#define PPC47x_TLB2_UR		0x00000008      /* User read */
-#define PPC47x_TLB2_SX		0x00000004      /* Super execution */
-#define PPC47x_TLB2_SW		0x00000002      /* Super write */
-#define PPC47x_TLB2_SR		0x00000001      /* Super read */
-#define PPC47x_TLB2_U_RWX	(PPC47x_TLB2_UX|PPC47x_TLB2_UW|PPC47x_TLB2_UR)
-#define PPC47x_TLB2_S_RWX	(PPC47x_TLB2_SX|PPC47x_TLB2_SW|PPC47x_TLB2_SR)
-#define PPC47x_TLB2_S_RW	(PPC47x_TLB2_SW | PPC47x_TLB2_SR)
-#define PPC47x_TLB2_IMG		(PPC47x_TLB2_I | PPC47x_TLB2_M | PPC47x_TLB2_G)
-
-#ifndef __ASSEMBLY__
-
-extern unsigned int tlb_44x_hwater;
-extern unsigned int tlb_44x_index;
-
-typedef struct {
-	unsigned int	id;
-	unsigned int	active;
-	unsigned long	vdso_base;
-} mm_context_t;
-
-#endif /* !__ASSEMBLY__ */
-
-#ifndef CONFIG_PPC_EARLY_DEBUG_44x
-#define PPC44x_EARLY_TLBS	1
-#else
-#define PPC44x_EARLY_TLBS	2
-#define PPC44x_EARLY_DEBUG_VIRTADDR	(ASM_CONST(0xf0000000) \
-	| (ASM_CONST(CONFIG_PPC_EARLY_DEBUG_44x_PHYSLOW) & 0xffff))
-#endif
-
-/* Size of the TLBs used for pinning in lowmem */
-#define PPC_PIN_SIZE	(1 << 28)	/* 256M */
-
-#if defined(CONFIG_PPC_4K_PAGES)
-#define PPC44x_TLBE_SIZE	PPC44x_TLB_4K
-#define PPC47x_TLBE_SIZE	PPC47x_TLB0_4K
-#define mmu_virtual_psize	MMU_PAGE_4K
-#elif defined(CONFIG_PPC_16K_PAGES)
-#define PPC44x_TLBE_SIZE	PPC44x_TLB_16K
-#define PPC47x_TLBE_SIZE	PPC47x_TLB0_16K
-#define mmu_virtual_psize	MMU_PAGE_16K
-#elif defined(CONFIG_PPC_64K_PAGES)
-#define PPC44x_TLBE_SIZE	PPC44x_TLB_64K
-#define PPC47x_TLBE_SIZE	PPC47x_TLB0_64K
-#define mmu_virtual_psize	MMU_PAGE_64K
-#elif defined(CONFIG_PPC_256K_PAGES)
-#define PPC44x_TLBE_SIZE	PPC44x_TLB_256K
-#define mmu_virtual_psize	MMU_PAGE_256K
-#else
-#error "Unsupported PAGE_SIZE"
-#endif
-
-#define mmu_linear_psize	MMU_PAGE_256M
-
-#define PPC44x_PGD_OFF_SHIFT	(32 - PGDIR_SHIFT + PGD_T_LOG2)
-#define PPC44x_PGD_OFF_MASK_BIT	(PGDIR_SHIFT - PGD_T_LOG2)
-#define PPC44x_PTE_ADD_SHIFT	(32 - PGDIR_SHIFT + PTE_SHIFT + PTE_T_LOG2)
-#define PPC44x_PTE_ADD_MASK_BIT	(32 - PTE_T_LOG2 - PTE_SHIFT)
-
-#endif /* _ASM_POWERPC_MMU_44X_H_ */
diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
deleted file mode 100644
index 193f53116c7a..000000000000
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ /dev/null
@@ -1,244 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_MMU_8XX_H_
-#define _ASM_POWERPC_MMU_8XX_H_
-/*
- * PPC8xx support
- */
-
-/* Control/status registers for the MPC8xx.
- * A write operation to these registers causes serialized access.
- * During software tablewalk, the registers used perform mask/shift-add
- * operations when written/read.  A TLB entry is created when the Mx_RPN
- * is written, and the contents of several registers are used to
- * create the entry.
- */
-#define SPRN_MI_CTR	784	/* Instruction TLB control register */
-#define MI_GPM		0x80000000	/* Set domain manager mode */
-#define MI_PPM		0x40000000	/* Set subpage protection */
-#define MI_CIDEF	0x20000000	/* Set cache inhibit when MMU dis */
-#define MI_RSV4I	0x08000000	/* Reserve 4 TLB entries */
-#define MI_PPCS		0x02000000	/* Use MI_RPN prob/priv state */
-#define MI_IDXMASK	0x00001f00	/* TLB index to be loaded */
-#define MI_RESETVAL	0x00000000	/* Value of register at reset */
-
-/* These are the Ks and Kp from the PowerPC books.  For proper operation,
- * Ks = 0, Kp = 1.
- */
-#define SPRN_MI_AP	786
-#define MI_Ks		0x80000000	/* Should not be set */
-#define MI_Kp		0x40000000	/* Should always be set */
-
-/*
- * All pages' PP data bits are set to either 001 or 011 by copying _PAGE_EXEC
- * into bit 21 in the ITLBmiss handler (bit 21 is the middle bit), which means
- * respectively NA for All or X for Supervisor and no access for User.
- * Then we use the APG to say whether accesses are according to Page rules or
- * "all Supervisor" rules (Access to all)
- * Therefore, we define 2 APG groups. lsb is _PMD_USER
- * 0 => No user => 01 (all accesses performed according to page definition)
- * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
- * We define all 16 groups so that all other bits of APG can take any value
- */
-#define MI_APG_INIT	0x44444444
-
-/* The effective page number register.  When read, contains the information
- * about the last instruction TLB miss.  When MI_RPN is written, bits in
- * this register are used to create the TLB entry.
- */
-#define SPRN_MI_EPN	787
-#define MI_EPNMASK	0xfffff000	/* Effective page number for entry */
-#define MI_EVALID	0x00000200	/* Entry is valid */
-#define MI_ASIDMASK	0x0000000f	/* ASID match value */
-					/* Reset value is undefined */
-
-/* A "level 1" or "segment" or whatever you want to call it register.
- * For the instruction TLB, it contains bits that get loaded into the
- * TLB entry when the MI_RPN is written.
- */
-#define SPRN_MI_TWC	789
-#define MI_APG		0x000001e0	/* Access protection group (0) */
-#define MI_GUARDED	0x00000010	/* Guarded storage */
-#define MI_PSMASK	0x0000000c	/* Mask of page size bits */
-#define MI_PS8MEG	0x0000000c	/* 8M page size */
-#define MI_PS512K	0x00000004	/* 512K page size */
-#define MI_PS4K_16K	0x00000000	/* 4K or 16K page size */
-#define MI_SVALID	0x00000001	/* Segment entry is valid */
-					/* Reset value is undefined */
-
-/* Real page number.  Defined by the pte.  Writing this register
- * causes a TLB entry to be created for the instruction TLB, using
- * additional information from the MI_EPN, and MI_TWC registers.
- */
-#define SPRN_MI_RPN	790
-#define MI_SPS16K	0x00000008	/* Small page size (0 = 4k, 1 = 16k) */
-
-/* Define an RPN value for mapping kernel memory to large virtual
- * pages for boot initialization.  This has real page number of 0,
- * large page size, shared page, cache enabled, and valid.
- * Also mark all subpages valid and write access.
- */
-#define MI_BOOTINIT	0x000001fd
-
-#define SPRN_MD_CTR	792	/* Data TLB control register */
-#define MD_GPM		0x80000000	/* Set domain manager mode */
-#define MD_PPM		0x40000000	/* Set subpage protection */
-#define MD_CIDEF	0x20000000	/* Set cache inhibit when MMU dis */
-#define MD_WTDEF	0x10000000	/* Set writethrough when MMU dis */
-#define MD_RSV4I	0x08000000	/* Reserve 4 TLB entries */
-#define MD_TWAM		0x04000000	/* Use 4K page hardware assist */
-#define MD_PPCS		0x02000000	/* Use MI_RPN prob/priv state */
-#define MD_IDXMASK	0x00001f00	/* TLB index to be loaded */
-#define MD_RESETVAL	0x04000000	/* Value of register at reset */
-
-#define SPRN_M_CASID	793	/* Address space ID (context) to match */
-#define MC_ASIDMASK	0x0000000f	/* Bits used for ASID value */
-
-
-/* These are the Ks and Kp from the PowerPC books.  For proper operation,
- * Ks = 0, Kp = 1.
- */
-#define SPRN_MD_AP	794
-#define MD_Ks		0x80000000	/* Should not be set */
-#define MD_Kp		0x40000000	/* Should always be set */
-
-/*
- * All pages' PP data bits are set to either 000 or 011 or 001, which means
- * respectively RW for Supervisor and no access for User, or RO for
- * Supervisor and no access for user and NA for ALL.
- * Then we use the APG to say whether accesses are according to Page rules or
- * "all Supervisor" rules (Access to all)
- * Therefore, we define 2 APG groups. lsb is _PMD_USER
- * 0 => No user => 01 (all accesses performed according to page definition)
- * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
- * We define all 16 groups so that all other bits of APG can take any value
- */
-#define MD_APG_INIT	0x44444444
-
-/* The effective page number register.  When read, contains the information
- * about the last instruction TLB miss.  When MD_RPN is written, bits in
- * this register are used to create the TLB entry.
- */
-#define SPRN_MD_EPN	795
-#define MD_EPNMASK	0xfffff000	/* Effective page number for entry */
-#define MD_EVALID	0x00000200	/* Entry is valid */
-#define MD_ASIDMASK	0x0000000f	/* ASID match value */
-					/* Reset value is undefined */
-
-/* The pointer to the base address of the first level page table.
- * During a software tablewalk, reading this register provides the address
- * of the entry associated with MD_EPN.
- */
-#define SPRN_M_TWB	796
-#define	M_L1TB		0xfffff000	/* Level 1 table base address */
-#define M_L1INDX	0x00000ffc	/* Level 1 index, when read */
-					/* Reset value is undefined */
-
-/* A "level 1" or "segment" or whatever you want to call it register.
- * For the data TLB, it contains bits that get loaded into the TLB entry
- * when the MD_RPN is written.  It is also provides the hardware assist
- * for finding the PTE address during software tablewalk.
- */
-#define SPRN_MD_TWC	797
-#define MD_L2TB		0xfffff000	/* Level 2 table base address */
-#define MD_L2INDX	0xfffffe00	/* Level 2 index (*pte), when read */
-#define MD_APG		0x000001e0	/* Access protection group (0) */
-#define MD_GUARDED	0x00000010	/* Guarded storage */
-#define MD_PSMASK	0x0000000c	/* Mask of page size bits */
-#define MD_PS8MEG	0x0000000c	/* 8M page size */
-#define MD_PS512K	0x00000004	/* 512K page size */
-#define MD_PS4K_16K	0x00000000	/* 4K or 16K page size */
-#define MD_WT		0x00000002	/* Use writethrough page attribute */
-#define MD_SVALID	0x00000001	/* Segment entry is valid */
-					/* Reset value is undefined */
-
-
-/* Real page number.  Defined by the pte.  Writing this register
- * causes a TLB entry to be created for the data TLB, using
- * additional information from the MD_EPN, and MD_TWC registers.
- */
-#define SPRN_MD_RPN	798
-#define MD_SPS16K	0x00000008	/* Small page size (0 = 4k, 1 = 16k) */
-
-/* This is a temporary storage register that could be used to save
- * a processor working register during a tablewalk.
- */
-#define SPRN_M_TW	799
-
-#ifdef CONFIG_PPC_MM_SLICES
-#include <asm/nohash/32/slice.h>
-#define SLICE_ARRAY_SIZE	(1 << (32 - SLICE_LOW_SHIFT - 1))
-#endif
-
-#ifndef __ASSEMBLY__
-struct slice_mask {
-	u64 low_slices;
-	DECLARE_BITMAP(high_slices, 0);
-};
-
-typedef struct {
-	unsigned int id;
-	unsigned int active;
-	unsigned long vdso_base;
-#ifdef CONFIG_PPC_MM_SLICES
-	u16 user_psize;		/* page size index */
-	unsigned char low_slices_psize[SLICE_ARRAY_SIZE];
-	unsigned char high_slices_psize[0];
-	unsigned long slb_addr_limit;
-	struct slice_mask mask_base_psize; /* 4k or 16k */
-# ifdef CONFIG_HUGETLB_PAGE
-	struct slice_mask mask_512k;
-	struct slice_mask mask_8m;
-# endif
-#endif
-} mm_context_t;
-
-#define PHYS_IMMR_BASE (mfspr(SPRN_IMMR) & 0xfff80000)
-#define VIRT_IMMR_BASE (__fix_to_virt(FIX_IMMR_BASE))
-
-/* Page size definitions, common between 32 and 64-bit
- *
- *    shift : is the "PAGE_SHIFT" value for that page size
- *    penc  : is the pte encoding mask
- *
- */
-struct mmu_psize_def {
-	unsigned int	shift;	/* number of bits */
-	unsigned int	enc;	/* PTE encoding */
-	unsigned int    ind;    /* Corresponding indirect page size shift */
-	unsigned int	flags;
-#define MMU_PAGE_SIZE_DIRECT	0x1	/* Supported as a direct size */
-#define MMU_PAGE_SIZE_INDIRECT	0x2	/* Supported as an indirect size */
-};
-
-extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
-
-static inline int shift_to_mmu_psize(unsigned int shift)
-{
-	int psize;
-
-	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize)
-		if (mmu_psize_defs[psize].shift == shift)
-			return psize;
-	return -1;
-}
-
-static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
-{
-	if (mmu_psize_defs[mmu_psize].shift)
-		return mmu_psize_defs[mmu_psize].shift;
-	BUG();
-}
-
-#endif /* !__ASSEMBLY__ */
-
-#if defined(CONFIG_PPC_4K_PAGES)
-#define mmu_virtual_psize	MMU_PAGE_4K
-#elif defined(CONFIG_PPC_16K_PAGES)
-#define mmu_virtual_psize	MMU_PAGE_16K
-#else
-#error "Unsupported PAGE_SIZE"
-#endif
-
-#define mmu_linear_psize	MMU_PAGE_8M
-
-#endif /* _ASM_POWERPC_MMU_8XX_H_ */
diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
deleted file mode 100644
index e20072972e35..000000000000
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ /dev/null
@@ -1,313 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_MMU_BOOK3E_H_
-#define _ASM_POWERPC_MMU_BOOK3E_H_
-/*
- * Freescale Book-E/Book-3e (ISA 2.06+) MMU support
- */
-
-/* Book-3e defined page sizes */
-#define BOOK3E_PAGESZ_1K	0
-#define BOOK3E_PAGESZ_2K	1
-#define BOOK3E_PAGESZ_4K	2
-#define BOOK3E_PAGESZ_8K	3
-#define BOOK3E_PAGESZ_16K	4
-#define BOOK3E_PAGESZ_32K	5
-#define BOOK3E_PAGESZ_64K	6
-#define BOOK3E_PAGESZ_128K	7
-#define BOOK3E_PAGESZ_256K	8
-#define BOOK3E_PAGESZ_512K	9
-#define BOOK3E_PAGESZ_1M	10
-#define BOOK3E_PAGESZ_2M	11
-#define BOOK3E_PAGESZ_4M	12
-#define BOOK3E_PAGESZ_8M	13
-#define BOOK3E_PAGESZ_16M	14
-#define BOOK3E_PAGESZ_32M	15
-#define BOOK3E_PAGESZ_64M	16
-#define BOOK3E_PAGESZ_128M	17
-#define BOOK3E_PAGESZ_256M	18
-#define BOOK3E_PAGESZ_512M	19
-#define BOOK3E_PAGESZ_1GB	20
-#define BOOK3E_PAGESZ_2GB	21
-#define BOOK3E_PAGESZ_4GB	22
-#define BOOK3E_PAGESZ_8GB	23
-#define BOOK3E_PAGESZ_16GB	24
-#define BOOK3E_PAGESZ_32GB	25
-#define BOOK3E_PAGESZ_64GB	26
-#define BOOK3E_PAGESZ_128GB	27
-#define BOOK3E_PAGESZ_256GB	28
-#define BOOK3E_PAGESZ_512GB	29
-#define BOOK3E_PAGESZ_1TB	30
-#define BOOK3E_PAGESZ_2TB	31
-
-/* MAS registers bit definitions */
-
-#define MAS0_TLBSEL_MASK	0x30000000
-#define MAS0_TLBSEL_SHIFT	28
-#define MAS0_TLBSEL(x)		(((x) << MAS0_TLBSEL_SHIFT) & MAS0_TLBSEL_MASK)
-#define MAS0_GET_TLBSEL(mas0)	(((mas0) & MAS0_TLBSEL_MASK) >> \
-			MAS0_TLBSEL_SHIFT)
-#define MAS0_ESEL_MASK		0x0FFF0000
-#define MAS0_ESEL_SHIFT		16
-#define MAS0_ESEL(x)		(((x) << MAS0_ESEL_SHIFT) & MAS0_ESEL_MASK)
-#define MAS0_NV(x)		((x) & 0x00000FFF)
-#define MAS0_HES		0x00004000
-#define MAS0_WQ_ALLWAYS		0x00000000
-#define MAS0_WQ_COND		0x00001000
-#define MAS0_WQ_CLR_RSRV       	0x00002000
-
-#define MAS1_VALID		0x80000000
-#define MAS1_IPROT		0x40000000
-#define MAS1_TID(x)		(((x) << 16) & 0x3FFF0000)
-#define MAS1_IND		0x00002000
-#define MAS1_TS			0x00001000
-#define MAS1_TSIZE_MASK		0x00000f80
-#define MAS1_TSIZE_SHIFT	7
-#define MAS1_TSIZE(x)		(((x) << MAS1_TSIZE_SHIFT) & MAS1_TSIZE_MASK)
-#define MAS1_GET_TSIZE(mas1)	(((mas1) & MAS1_TSIZE_MASK) >> MAS1_TSIZE_SHIFT)
-
-#define MAS2_EPN		(~0xFFFUL)
-#define MAS2_X0			0x00000040
-#define MAS2_X1			0x00000020
-#define MAS2_W			0x00000010
-#define MAS2_I			0x00000008
-#define MAS2_M			0x00000004
-#define MAS2_G			0x00000002
-#define MAS2_E			0x00000001
-#define MAS2_WIMGE_MASK		0x0000001f
-#define MAS2_EPN_MASK(size)		(~0 << (size + 10))
-#define MAS2_VAL(addr, size, flags)	((addr) & MAS2_EPN_MASK(size) | (flags))
-
-#define MAS3_RPN		0xFFFFF000
-#define MAS3_U0			0x00000200
-#define MAS3_U1			0x00000100
-#define MAS3_U2			0x00000080
-#define MAS3_U3			0x00000040
-#define MAS3_UX			0x00000020
-#define MAS3_SX			0x00000010
-#define MAS3_UW			0x00000008
-#define MAS3_SW			0x00000004
-#define MAS3_UR			0x00000002
-#define MAS3_SR			0x00000001
-#define MAS3_BAP_MASK		0x0000003f
-#define MAS3_SPSIZE		0x0000003e
-#define MAS3_SPSIZE_SHIFT	1
-
-#define MAS4_TLBSEL_MASK	MAS0_TLBSEL_MASK
-#define MAS4_TLBSELD(x) 	MAS0_TLBSEL(x)
-#define MAS4_INDD		0x00008000	/* Default IND */
-#define MAS4_TSIZED(x)		MAS1_TSIZE(x)
-#define MAS4_X0D		0x00000040
-#define MAS4_X1D		0x00000020
-#define MAS4_WD			0x00000010
-#define MAS4_ID			0x00000008
-#define MAS4_MD			0x00000004
-#define MAS4_GD			0x00000002
-#define MAS4_ED			0x00000001
-#define MAS4_WIMGED_MASK	0x0000001f	/* Default WIMGE */
-#define MAS4_WIMGED_SHIFT	0
-#define MAS4_VLED		MAS4_X1D	/* Default VLE */
-#define MAS4_ACMD		0x000000c0	/* Default ACM */
-#define MAS4_ACMD_SHIFT		6
-#define MAS4_TSIZED_MASK	0x00000f80	/* Default TSIZE */
-#define MAS4_TSIZED_SHIFT	7
-
-#define MAS5_SGS		0x80000000
-
-#define MAS6_SPID0		0x3FFF0000
-#define MAS6_SPID1		0x00007FFE
-#define MAS6_ISIZE(x)		MAS1_TSIZE(x)
-#define MAS6_SAS		0x00000001
-#define MAS6_SPID		MAS6_SPID0
-#define MAS6_SIND 		0x00000002	/* Indirect page */
-#define MAS6_SIND_SHIFT		1
-#define MAS6_SPID_MASK		0x3fff0000
-#define MAS6_SPID_SHIFT		16
-#define MAS6_ISIZE_MASK		0x00000f80
-#define MAS6_ISIZE_SHIFT	7
-
-#define MAS7_RPN		0xFFFFFFFF
-
-#define MAS8_TGS		0x80000000 /* Guest space */
-#define MAS8_VF			0x40000000 /* Virtualization Fault */
-#define MAS8_TLPID		0x000000ff
-
-/* Bit definitions for MMUCFG */
-#define MMUCFG_MAVN	0x00000003	/* MMU Architecture Version Number */
-#define MMUCFG_MAVN_V1	0x00000000	/* v1.0 */
-#define MMUCFG_MAVN_V2	0x00000001	/* v2.0 */
-#define MMUCFG_NTLBS	0x0000000c	/* Number of TLBs */
-#define MMUCFG_PIDSIZE	0x000007c0	/* PID Reg Size */
-#define MMUCFG_TWC	0x00008000	/* TLB Write Conditional (v2.0) */
-#define MMUCFG_LRAT	0x00010000	/* LRAT Supported (v2.0) */
-#define MMUCFG_RASIZE	0x00fe0000	/* Real Addr Size */
-#define MMUCFG_LPIDSIZE	0x0f000000	/* LPID Reg Size */
-
-/* Bit definitions for MMUCSR0 */
-#define MMUCSR0_TLB1FI	0x00000002	/* TLB1 Flash invalidate */
-#define MMUCSR0_TLB0FI	0x00000004	/* TLB0 Flash invalidate */
-#define MMUCSR0_TLB2FI	0x00000040	/* TLB2 Flash invalidate */
-#define MMUCSR0_TLB3FI	0x00000020	/* TLB3 Flash invalidate */
-#define MMUCSR0_TLBFI	(MMUCSR0_TLB0FI | MMUCSR0_TLB1FI | \
-			 MMUCSR0_TLB2FI | MMUCSR0_TLB3FI)
-#define MMUCSR0_TLB0PS	0x00000780	/* TLB0 Page Size */
-#define MMUCSR0_TLB1PS	0x00007800	/* TLB1 Page Size */
-#define MMUCSR0_TLB2PS	0x00078000	/* TLB2 Page Size */
-#define MMUCSR0_TLB3PS	0x00780000	/* TLB3 Page Size */
-
-/* MMUCFG bits */
-#define MMUCFG_MAVN_NASK	0x00000003
-#define MMUCFG_MAVN_V1_0	0x00000000
-#define MMUCFG_MAVN_V2_0	0x00000001
-#define MMUCFG_NTLB_MASK	0x0000000c
-#define MMUCFG_NTLB_SHIFT	2
-#define MMUCFG_PIDSIZE_MASK	0x000007c0
-#define MMUCFG_PIDSIZE_SHIFT	6
-#define MMUCFG_TWC		0x00008000
-#define MMUCFG_LRAT		0x00010000
-#define MMUCFG_RASIZE_MASK	0x00fe0000
-#define MMUCFG_RASIZE_SHIFT	17
-#define MMUCFG_LPIDSIZE_MASK	0x0f000000
-#define MMUCFG_LPIDSIZE_SHIFT	24
-
-/* TLBnCFG encoding */
-#define TLBnCFG_N_ENTRY		0x00000fff	/* number of entries */
-#define TLBnCFG_HES		0x00002000	/* HW select supported */
-#define TLBnCFG_IPROT		0x00008000	/* IPROT supported */
-#define TLBnCFG_GTWE		0x00010000	/* Guest can write */
-#define TLBnCFG_IND		0x00020000	/* IND entries supported */
-#define TLBnCFG_PT		0x00040000	/* Can load from page table */
-#define TLBnCFG_MINSIZE		0x00f00000	/* Minimum Page Size (v1.0) */
-#define TLBnCFG_MINSIZE_SHIFT	20
-#define TLBnCFG_MAXSIZE		0x000f0000	/* Maximum Page Size (v1.0) */
-#define TLBnCFG_MAXSIZE_SHIFT	16
-#define TLBnCFG_ASSOC		0xff000000	/* Associativity */
-#define TLBnCFG_ASSOC_SHIFT	24
-
-/* TLBnPS encoding */
-#define TLBnPS_4K		0x00000004
-#define TLBnPS_8K		0x00000008
-#define TLBnPS_16K		0x00000010
-#define TLBnPS_32K		0x00000020
-#define TLBnPS_64K		0x00000040
-#define TLBnPS_128K		0x00000080
-#define TLBnPS_256K		0x00000100
-#define TLBnPS_512K		0x00000200
-#define TLBnPS_1M 		0x00000400
-#define TLBnPS_2M 		0x00000800
-#define TLBnPS_4M 		0x00001000
-#define TLBnPS_8M 		0x00002000
-#define TLBnPS_16M		0x00004000
-#define TLBnPS_32M		0x00008000
-#define TLBnPS_64M		0x00010000
-#define TLBnPS_128M		0x00020000
-#define TLBnPS_256M		0x00040000
-#define TLBnPS_512M		0x00080000
-#define TLBnPS_1G		0x00100000
-#define TLBnPS_2G		0x00200000
-#define TLBnPS_4G		0x00400000
-#define TLBnPS_8G		0x00800000
-#define TLBnPS_16G		0x01000000
-#define TLBnPS_32G		0x02000000
-#define TLBnPS_64G		0x04000000
-#define TLBnPS_128G		0x08000000
-#define TLBnPS_256G		0x10000000
-
-/* tlbilx action encoding */
-#define TLBILX_T_ALL			0
-#define TLBILX_T_TID			1
-#define TLBILX_T_FULLMATCH		3
-#define TLBILX_T_CLASS0			4
-#define TLBILX_T_CLASS1			5
-#define TLBILX_T_CLASS2			6
-#define TLBILX_T_CLASS3			7
-
-#ifndef __ASSEMBLY__
-#include <asm/bug.h>
-
-extern unsigned int tlbcam_index;
-
-typedef struct {
-	unsigned int	id;
-	unsigned int	active;
-	unsigned long	vdso_base;
-} mm_context_t;
-
-/* Page size definitions, common between 32 and 64-bit
- *
- *    shift : is the "PAGE_SHIFT" value for that page size
- *    penc  : is the pte encoding mask
- *
- */
-struct mmu_psize_def
-{
-	unsigned int	shift;	/* number of bits */
-	unsigned int	enc;	/* PTE encoding */
-	unsigned int    ind;    /* Corresponding indirect page size shift */
-	unsigned int	flags;
-#define MMU_PAGE_SIZE_DIRECT	0x1	/* Supported as a direct size */
-#define MMU_PAGE_SIZE_INDIRECT	0x2	/* Supported as an indirect size */
-};
-extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
-
-static inline int shift_to_mmu_psize(unsigned int shift)
-{
-	int psize;
-
-	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize)
-		if (mmu_psize_defs[psize].shift == shift)
-			return psize;
-	return -1;
-}
-
-static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
-{
-	if (mmu_psize_defs[mmu_psize].shift)
-		return mmu_psize_defs[mmu_psize].shift;
-	BUG();
-}
-
-/* The page sizes use the same names as 64-bit hash but are
- * constants
- */
-#if defined(CONFIG_PPC_4K_PAGES)
-#define mmu_virtual_psize	MMU_PAGE_4K
-#else
-#error Unsupported page size
-#endif
-
-extern int mmu_linear_psize;
-extern int mmu_vmemmap_psize;
-
-struct tlb_core_data {
-	/*
-	 * Per-core spinlock for e6500 TLB handlers (no tlbsrx.)
-	 * Must be the first struct element.
-	 */
-	u8 lock;
-
-	/* For software way selection, as on Freescale TLB1 */
-	u8 esel_next, esel_max, esel_first;
-};
-
-#ifdef CONFIG_PPC64
-extern unsigned long linear_map_top;
-extern int book3e_htw_mode;
-
-#define PPC_HTW_NONE	0
-#define PPC_HTW_IBM	1
-#define PPC_HTW_E6500	2
-
-/*
- * 64-bit booke platforms don't load the tlb in the tlb miss handler code.
- * HUGETLB_NEED_PRELOAD handles this - it causes huge_ptep_set_access_flags to
- * return 1, indicating that the tlb requires preloading.
- */
-#define HUGETLB_NEED_PRELOAD
-
-#define mmu_cleanup_all NULL
-
-#endif
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* _ASM_POWERPC_MMU_BOOK3E_H_ */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 13ea441ac531..2b396de45e9e 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -326,18 +326,8 @@ static inline void mmu_early_init_devtree(void) { }
 #if defined(CONFIG_PPC_STD_MMU_32)
 /* 32-bit classic hash table MMU */
 #include <asm/book3s/32/mmu-hash.h>
-#elif defined(CONFIG_40x)
-/* 40x-style software loaded TLB */
-#  include <asm/mmu-40x.h>
-#elif defined(CONFIG_44x)
-/* 44x-style software loaded TLB */
-#  include <asm/mmu-44x.h>
-#elif defined(CONFIG_PPC_BOOK3E_MMU)
-/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
-#  include <asm/mmu-book3e.h>
-#elif defined (CONFIG_PPC_8xx)
-/* Motorola/Freescale 8xx software loaded TLB */
-#  include <asm/mmu-8xx.h>
+#elif defined(CONFIG_PPC_MMU_NOHASH)
+#include <asm/nohash/mmu.h>
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-40x.h b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
new file mode 100644
index 000000000000..74f4edb5916e
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/32/mmu-40x.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_MMU_40X_H_
+#define _ASM_POWERPC_MMU_40X_H_
+
+/*
+ * PPC40x support
+ */
+
+#define PPC40X_TLB_SIZE 64
+
+/*
+ * TLB entries are defined by a "high" tag portion and a "low" data
+ * portion.  On all architectures, the data portion is 32-bits.
+ *
+ * TLB entries are managed entirely under software control by reading,
+ * writing, and searchoing using the 4xx-specific tlbre, tlbwr, and tlbsx
+ * instructions.
+ */
+
+#define	TLB_LO          1
+#define	TLB_HI          0
+
+#define	TLB_DATA        TLB_LO
+#define	TLB_TAG         TLB_HI
+
+/* Tag portion */
+
+#define TLB_EPN_MASK    0xFFFFFC00      /* Effective Page Number */
+#define TLB_PAGESZ_MASK 0x00000380
+#define TLB_PAGESZ(x)   (((x) & 0x7) << 7)
+#define   PAGESZ_1K		0
+#define   PAGESZ_4K             1
+#define   PAGESZ_16K            2
+#define   PAGESZ_64K            3
+#define   PAGESZ_256K           4
+#define   PAGESZ_1M             5
+#define   PAGESZ_4M             6
+#define   PAGESZ_16M            7
+#define TLB_VALID       0x00000040      /* Entry is valid */
+
+/* Data portion */
+
+#define TLB_RPN_MASK    0xFFFFFC00      /* Real Page Number */
+#define TLB_PERM_MASK   0x00000300
+#define TLB_EX          0x00000200      /* Instruction execution allowed */
+#define TLB_WR          0x00000100      /* Writes permitted */
+#define TLB_ZSEL_MASK   0x000000F0
+#define TLB_ZSEL(x)     (((x) & 0xF) << 4)
+#define TLB_ATTR_MASK   0x0000000F
+#define TLB_W           0x00000008      /* Caching is write-through */
+#define TLB_I           0x00000004      /* Caching is inhibited */
+#define TLB_M           0x00000002      /* Memory is coherent */
+#define TLB_G           0x00000001      /* Memory is guarded from prefetch */
+
+#ifndef __ASSEMBLY__
+
+typedef struct {
+	unsigned int	id;
+	unsigned int	active;
+	unsigned long	vdso_base;
+} mm_context_t;
+
+#endif /* !__ASSEMBLY__ */
+
+#define mmu_virtual_psize	MMU_PAGE_4K
+#define mmu_linear_psize	MMU_PAGE_256M
+
+#endif /* _ASM_POWERPC_MMU_40X_H_ */
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-44x.h b/arch/powerpc/include/asm/nohash/32/mmu-44x.h
new file mode 100644
index 000000000000..295b3dbb2698
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/32/mmu-44x.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_MMU_44X_H_
+#define _ASM_POWERPC_MMU_44X_H_
+/*
+ * PPC440 support
+ */
+
+#include <asm/asm-const.h>
+
+#define PPC44x_MMUCR_TID	0x000000ff
+#define PPC44x_MMUCR_STS	0x00010000
+
+#define	PPC44x_TLB_PAGEID	0
+#define	PPC44x_TLB_XLAT		1
+#define	PPC44x_TLB_ATTRIB	2
+
+/* Page identification fields */
+#define PPC44x_TLB_EPN_MASK	0xfffffc00      /* Effective Page Number */
+#define	PPC44x_TLB_VALID	0x00000200      /* Valid flag */
+#define PPC44x_TLB_TS		0x00000100	/* Translation address space */
+#define PPC44x_TLB_1K		0x00000000	/* Page sizes */
+#define PPC44x_TLB_4K		0x00000010
+#define PPC44x_TLB_16K		0x00000020
+#define PPC44x_TLB_64K		0x00000030
+#define PPC44x_TLB_256K		0x00000040
+#define PPC44x_TLB_1M		0x00000050
+#define PPC44x_TLB_16M		0x00000070
+#define	PPC44x_TLB_256M		0x00000090
+
+/* Translation fields */
+#define PPC44x_TLB_RPN_MASK	0xfffffc00      /* Real Page Number */
+#define	PPC44x_TLB_ERPN_MASK	0x0000000f
+
+/* Storage attribute and access control fields */
+#define PPC44x_TLB_ATTR_MASK	0x0000ff80
+#define PPC44x_TLB_U0		0x00008000      /* User 0 */
+#define PPC44x_TLB_U1		0x00004000      /* User 1 */
+#define PPC44x_TLB_U2		0x00002000      /* User 2 */
+#define PPC44x_TLB_U3		0x00001000      /* User 3 */
+#define PPC44x_TLB_W		0x00000800      /* Caching is write-through */
+#define PPC44x_TLB_I		0x00000400      /* Caching is inhibited */
+#define PPC44x_TLB_M		0x00000200      /* Memory is coherent */
+#define PPC44x_TLB_G		0x00000100      /* Memory is guarded */
+#define PPC44x_TLB_E		0x00000080      /* Memory is little endian */
+
+#define PPC44x_TLB_PERM_MASK	0x0000003f
+#define PPC44x_TLB_UX		0x00000020      /* User execution */
+#define PPC44x_TLB_UW		0x00000010      /* User write */
+#define PPC44x_TLB_UR		0x00000008      /* User read */
+#define PPC44x_TLB_SX		0x00000004      /* Super execution */
+#define PPC44x_TLB_SW		0x00000002      /* Super write */
+#define PPC44x_TLB_SR		0x00000001      /* Super read */
+
+/* Number of TLB entries */
+#define PPC44x_TLB_SIZE		64
+
+/* 47x bits */
+#define PPC47x_MMUCR_TID	0x0000ffff
+#define PPC47x_MMUCR_STS	0x00010000
+
+/* Page identification fields */
+#define PPC47x_TLB0_EPN_MASK	0xfffff000      /* Effective Page Number */
+#define PPC47x_TLB0_VALID	0x00000800      /* Valid flag */
+#define PPC47x_TLB0_TS		0x00000400	/* Translation address space */
+#define PPC47x_TLB0_4K		0x00000000
+#define PPC47x_TLB0_16K		0x00000010
+#define PPC47x_TLB0_64K		0x00000030
+#define PPC47x_TLB0_1M		0x00000070
+#define PPC47x_TLB0_16M		0x000000f0
+#define PPC47x_TLB0_256M	0x000001f0
+#define PPC47x_TLB0_1G		0x000003f0
+#define PPC47x_TLB0_BOLTED_R	0x00000008	/* tlbre only */
+
+/* Translation fields */
+#define PPC47x_TLB1_RPN_MASK	0xfffff000      /* Real Page Number */
+#define PPC47x_TLB1_ERPN_MASK	0x000003ff
+
+/* Storage attribute and access control fields */
+#define PPC47x_TLB2_ATTR_MASK	0x0003ff80
+#define PPC47x_TLB2_IL1I	0x00020000      /* Memory is guarded */
+#define PPC47x_TLB2_IL1D	0x00010000      /* Memory is guarded */
+#define PPC47x_TLB2_U0		0x00008000      /* User 0 */
+#define PPC47x_TLB2_U1		0x00004000      /* User 1 */
+#define PPC47x_TLB2_U2		0x00002000      /* User 2 */
+#define PPC47x_TLB2_U3		0x00001000      /* User 3 */
+#define PPC47x_TLB2_W		0x00000800      /* Caching is write-through */
+#define PPC47x_TLB2_I		0x00000400      /* Caching is inhibited */
+#define PPC47x_TLB2_M		0x00000200      /* Memory is coherent */
+#define PPC47x_TLB2_G		0x00000100      /* Memory is guarded */
+#define PPC47x_TLB2_E		0x00000080      /* Memory is little endian */
+#define PPC47x_TLB2_PERM_MASK	0x0000003f
+#define PPC47x_TLB2_UX		0x00000020      /* User execution */
+#define PPC47x_TLB2_UW		0x00000010      /* User write */
+#define PPC47x_TLB2_UR		0x00000008      /* User read */
+#define PPC47x_TLB2_SX		0x00000004      /* Super execution */
+#define PPC47x_TLB2_SW		0x00000002      /* Super write */
+#define PPC47x_TLB2_SR		0x00000001      /* Super read */
+#define PPC47x_TLB2_U_RWX	(PPC47x_TLB2_UX|PPC47x_TLB2_UW|PPC47x_TLB2_UR)
+#define PPC47x_TLB2_S_RWX	(PPC47x_TLB2_SX|PPC47x_TLB2_SW|PPC47x_TLB2_SR)
+#define PPC47x_TLB2_S_RW	(PPC47x_TLB2_SW | PPC47x_TLB2_SR)
+#define PPC47x_TLB2_IMG		(PPC47x_TLB2_I | PPC47x_TLB2_M | PPC47x_TLB2_G)
+
+#ifndef __ASSEMBLY__
+
+extern unsigned int tlb_44x_hwater;
+extern unsigned int tlb_44x_index;
+
+typedef struct {
+	unsigned int	id;
+	unsigned int	active;
+	unsigned long	vdso_base;
+} mm_context_t;
+
+#endif /* !__ASSEMBLY__ */
+
+#ifndef CONFIG_PPC_EARLY_DEBUG_44x
+#define PPC44x_EARLY_TLBS	1
+#else
+#define PPC44x_EARLY_TLBS	2
+#define PPC44x_EARLY_DEBUG_VIRTADDR	(ASM_CONST(0xf0000000) \
+	| (ASM_CONST(CONFIG_PPC_EARLY_DEBUG_44x_PHYSLOW) & 0xffff))
+#endif
+
+/* Size of the TLBs used for pinning in lowmem */
+#define PPC_PIN_SIZE	(1 << 28)	/* 256M */
+
+#if defined(CONFIG_PPC_4K_PAGES)
+#define PPC44x_TLBE_SIZE	PPC44x_TLB_4K
+#define PPC47x_TLBE_SIZE	PPC47x_TLB0_4K
+#define mmu_virtual_psize	MMU_PAGE_4K
+#elif defined(CONFIG_PPC_16K_PAGES)
+#define PPC44x_TLBE_SIZE	PPC44x_TLB_16K
+#define PPC47x_TLBE_SIZE	PPC47x_TLB0_16K
+#define mmu_virtual_psize	MMU_PAGE_16K
+#elif defined(CONFIG_PPC_64K_PAGES)
+#define PPC44x_TLBE_SIZE	PPC44x_TLB_64K
+#define PPC47x_TLBE_SIZE	PPC47x_TLB0_64K
+#define mmu_virtual_psize	MMU_PAGE_64K
+#elif defined(CONFIG_PPC_256K_PAGES)
+#define PPC44x_TLBE_SIZE	PPC44x_TLB_256K
+#define mmu_virtual_psize	MMU_PAGE_256K
+#else
+#error "Unsupported PAGE_SIZE"
+#endif
+
+#define mmu_linear_psize	MMU_PAGE_256M
+
+#define PPC44x_PGD_OFF_SHIFT	(32 - PGDIR_SHIFT + PGD_T_LOG2)
+#define PPC44x_PGD_OFF_MASK_BIT	(PGDIR_SHIFT - PGD_T_LOG2)
+#define PPC44x_PTE_ADD_SHIFT	(32 - PGDIR_SHIFT + PTE_SHIFT + PTE_T_LOG2)
+#define PPC44x_PTE_ADD_MASK_BIT	(32 - PTE_T_LOG2 - PTE_SHIFT)
+
+#endif /* _ASM_POWERPC_MMU_44X_H_ */
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
new file mode 100644
index 000000000000..193f53116c7a
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -0,0 +1,244 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_MMU_8XX_H_
+#define _ASM_POWERPC_MMU_8XX_H_
+/*
+ * PPC8xx support
+ */
+
+/* Control/status registers for the MPC8xx.
+ * A write operation to these registers causes serialized access.
+ * During software tablewalk, the registers used perform mask/shift-add
+ * operations when written/read.  A TLB entry is created when the Mx_RPN
+ * is written, and the contents of several registers are used to
+ * create the entry.
+ */
+#define SPRN_MI_CTR	784	/* Instruction TLB control register */
+#define MI_GPM		0x80000000	/* Set domain manager mode */
+#define MI_PPM		0x40000000	/* Set subpage protection */
+#define MI_CIDEF	0x20000000	/* Set cache inhibit when MMU dis */
+#define MI_RSV4I	0x08000000	/* Reserve 4 TLB entries */
+#define MI_PPCS		0x02000000	/* Use MI_RPN prob/priv state */
+#define MI_IDXMASK	0x00001f00	/* TLB index to be loaded */
+#define MI_RESETVAL	0x00000000	/* Value of register at reset */
+
+/* These are the Ks and Kp from the PowerPC books.  For proper operation,
+ * Ks = 0, Kp = 1.
+ */
+#define SPRN_MI_AP	786
+#define MI_Ks		0x80000000	/* Should not be set */
+#define MI_Kp		0x40000000	/* Should always be set */
+
+/*
+ * All pages' PP data bits are set to either 001 or 011 by copying _PAGE_EXEC
+ * into bit 21 in the ITLBmiss handler (bit 21 is the middle bit), which means
+ * respectively NA for All or X for Supervisor and no access for User.
+ * Then we use the APG to say whether accesses are according to Page rules or
+ * "all Supervisor" rules (Access to all)
+ * Therefore, we define 2 APG groups. lsb is _PMD_USER
+ * 0 => No user => 01 (all accesses performed according to page definition)
+ * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
+ * We define all 16 groups so that all other bits of APG can take any value
+ */
+#define MI_APG_INIT	0x44444444
+
+/* The effective page number register.  When read, contains the information
+ * about the last instruction TLB miss.  When MI_RPN is written, bits in
+ * this register are used to create the TLB entry.
+ */
+#define SPRN_MI_EPN	787
+#define MI_EPNMASK	0xfffff000	/* Effective page number for entry */
+#define MI_EVALID	0x00000200	/* Entry is valid */
+#define MI_ASIDMASK	0x0000000f	/* ASID match value */
+					/* Reset value is undefined */
+
+/* A "level 1" or "segment" or whatever you want to call it register.
+ * For the instruction TLB, it contains bits that get loaded into the
+ * TLB entry when the MI_RPN is written.
+ */
+#define SPRN_MI_TWC	789
+#define MI_APG		0x000001e0	/* Access protection group (0) */
+#define MI_GUARDED	0x00000010	/* Guarded storage */
+#define MI_PSMASK	0x0000000c	/* Mask of page size bits */
+#define MI_PS8MEG	0x0000000c	/* 8M page size */
+#define MI_PS512K	0x00000004	/* 512K page size */
+#define MI_PS4K_16K	0x00000000	/* 4K or 16K page size */
+#define MI_SVALID	0x00000001	/* Segment entry is valid */
+					/* Reset value is undefined */
+
+/* Real page number.  Defined by the pte.  Writing this register
+ * causes a TLB entry to be created for the instruction TLB, using
+ * additional information from the MI_EPN, and MI_TWC registers.
+ */
+#define SPRN_MI_RPN	790
+#define MI_SPS16K	0x00000008	/* Small page size (0 = 4k, 1 = 16k) */
+
+/* Define an RPN value for mapping kernel memory to large virtual
+ * pages for boot initialization.  This has real page number of 0,
+ * large page size, shared page, cache enabled, and valid.
+ * Also mark all subpages valid and write access.
+ */
+#define MI_BOOTINIT	0x000001fd
+
+#define SPRN_MD_CTR	792	/* Data TLB control register */
+#define MD_GPM		0x80000000	/* Set domain manager mode */
+#define MD_PPM		0x40000000	/* Set subpage protection */
+#define MD_CIDEF	0x20000000	/* Set cache inhibit when MMU dis */
+#define MD_WTDEF	0x10000000	/* Set writethrough when MMU dis */
+#define MD_RSV4I	0x08000000	/* Reserve 4 TLB entries */
+#define MD_TWAM		0x04000000	/* Use 4K page hardware assist */
+#define MD_PPCS		0x02000000	/* Use MI_RPN prob/priv state */
+#define MD_IDXMASK	0x00001f00	/* TLB index to be loaded */
+#define MD_RESETVAL	0x04000000	/* Value of register at reset */
+
+#define SPRN_M_CASID	793	/* Address space ID (context) to match */
+#define MC_ASIDMASK	0x0000000f	/* Bits used for ASID value */
+
+
+/* These are the Ks and Kp from the PowerPC books.  For proper operation,
+ * Ks = 0, Kp = 1.
+ */
+#define SPRN_MD_AP	794
+#define MD_Ks		0x80000000	/* Should not be set */
+#define MD_Kp		0x40000000	/* Should always be set */
+
+/*
+ * All pages' PP data bits are set to either 000 or 011 or 001, which means
+ * respectively RW for Supervisor and no access for User, or RO for
+ * Supervisor and no access for user and NA for ALL.
+ * Then we use the APG to say whether accesses are according to Page rules or
+ * "all Supervisor" rules (Access to all)
+ * Therefore, we define 2 APG groups. lsb is _PMD_USER
+ * 0 => No user => 01 (all accesses performed according to page definition)
+ * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
+ * We define all 16 groups so that all other bits of APG can take any value
+ */
+#define MD_APG_INIT	0x44444444
+
+/* The effective page number register.  When read, contains the information
+ * about the last instruction TLB miss.  When MD_RPN is written, bits in
+ * this register are used to create the TLB entry.
+ */
+#define SPRN_MD_EPN	795
+#define MD_EPNMASK	0xfffff000	/* Effective page number for entry */
+#define MD_EVALID	0x00000200	/* Entry is valid */
+#define MD_ASIDMASK	0x0000000f	/* ASID match value */
+					/* Reset value is undefined */
+
+/* The pointer to the base address of the first level page table.
+ * During a software tablewalk, reading this register provides the address
+ * of the entry associated with MD_EPN.
+ */
+#define SPRN_M_TWB	796
+#define	M_L1TB		0xfffff000	/* Level 1 table base address */
+#define M_L1INDX	0x00000ffc	/* Level 1 index, when read */
+					/* Reset value is undefined */
+
+/* A "level 1" or "segment" or whatever you want to call it register.
+ * For the data TLB, it contains bits that get loaded into the TLB entry
+ * when the MD_RPN is written.  It is also provides the hardware assist
+ * for finding the PTE address during software tablewalk.
+ */
+#define SPRN_MD_TWC	797
+#define MD_L2TB		0xfffff000	/* Level 2 table base address */
+#define MD_L2INDX	0xfffffe00	/* Level 2 index (*pte), when read */
+#define MD_APG		0x000001e0	/* Access protection group (0) */
+#define MD_GUARDED	0x00000010	/* Guarded storage */
+#define MD_PSMASK	0x0000000c	/* Mask of page size bits */
+#define MD_PS8MEG	0x0000000c	/* 8M page size */
+#define MD_PS512K	0x00000004	/* 512K page size */
+#define MD_PS4K_16K	0x00000000	/* 4K or 16K page size */
+#define MD_WT		0x00000002	/* Use writethrough page attribute */
+#define MD_SVALID	0x00000001	/* Segment entry is valid */
+					/* Reset value is undefined */
+
+
+/* Real page number.  Defined by the pte.  Writing this register
+ * causes a TLB entry to be created for the data TLB, using
+ * additional information from the MD_EPN, and MD_TWC registers.
+ */
+#define SPRN_MD_RPN	798
+#define MD_SPS16K	0x00000008	/* Small page size (0 = 4k, 1 = 16k) */
+
+/* This is a temporary storage register that could be used to save
+ * a processor working register during a tablewalk.
+ */
+#define SPRN_M_TW	799
+
+#ifdef CONFIG_PPC_MM_SLICES
+#include <asm/nohash/32/slice.h>
+#define SLICE_ARRAY_SIZE	(1 << (32 - SLICE_LOW_SHIFT - 1))
+#endif
+
+#ifndef __ASSEMBLY__
+struct slice_mask {
+	u64 low_slices;
+	DECLARE_BITMAP(high_slices, 0);
+};
+
+typedef struct {
+	unsigned int id;
+	unsigned int active;
+	unsigned long vdso_base;
+#ifdef CONFIG_PPC_MM_SLICES
+	u16 user_psize;		/* page size index */
+	unsigned char low_slices_psize[SLICE_ARRAY_SIZE];
+	unsigned char high_slices_psize[0];
+	unsigned long slb_addr_limit;
+	struct slice_mask mask_base_psize; /* 4k or 16k */
+# ifdef CONFIG_HUGETLB_PAGE
+	struct slice_mask mask_512k;
+	struct slice_mask mask_8m;
+# endif
+#endif
+} mm_context_t;
+
+#define PHYS_IMMR_BASE (mfspr(SPRN_IMMR) & 0xfff80000)
+#define VIRT_IMMR_BASE (__fix_to_virt(FIX_IMMR_BASE))
+
+/* Page size definitions, common between 32 and 64-bit
+ *
+ *    shift : is the "PAGE_SHIFT" value for that page size
+ *    penc  : is the pte encoding mask
+ *
+ */
+struct mmu_psize_def {
+	unsigned int	shift;	/* number of bits */
+	unsigned int	enc;	/* PTE encoding */
+	unsigned int    ind;    /* Corresponding indirect page size shift */
+	unsigned int	flags;
+#define MMU_PAGE_SIZE_DIRECT	0x1	/* Supported as a direct size */
+#define MMU_PAGE_SIZE_INDIRECT	0x2	/* Supported as an indirect size */
+};
+
+extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
+
+static inline int shift_to_mmu_psize(unsigned int shift)
+{
+	int psize;
+
+	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize)
+		if (mmu_psize_defs[psize].shift == shift)
+			return psize;
+	return -1;
+}
+
+static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
+{
+	if (mmu_psize_defs[mmu_psize].shift)
+		return mmu_psize_defs[mmu_psize].shift;
+	BUG();
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#if defined(CONFIG_PPC_4K_PAGES)
+#define mmu_virtual_psize	MMU_PAGE_4K
+#elif defined(CONFIG_PPC_16K_PAGES)
+#define mmu_virtual_psize	MMU_PAGE_16K
+#else
+#error "Unsupported PAGE_SIZE"
+#endif
+
+#define mmu_linear_psize	MMU_PAGE_8M
+
+#endif /* _ASM_POWERPC_MMU_8XX_H_ */
diff --git a/arch/powerpc/include/asm/nohash/32/mmu.h b/arch/powerpc/include/asm/nohash/32/mmu.h
new file mode 100644
index 000000000000..f61f933a4cd8
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/32/mmu.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_32_MMU_H_
+#define _ASM_POWERPC_NOHASH_32_MMU_H_
+
+#if defined(CONFIG_40x)
+/* 40x-style software loaded TLB */
+#include <asm/nohash/32/mmu-40x.h>
+#elif defined(CONFIG_44x)
+/* 44x-style software loaded TLB */
+#include <asm/nohash/32/mmu-44x.h>
+#elif defined(CONFIG_PPC_BOOK3E_MMU)
+/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
+#include <asm/nohash/mmu-book3e.h>
+#elif defined (CONFIG_PPC_8xx)
+/* Motorola/Freescale 8xx software loaded TLB */
+#include <asm/nohash/32/mmu-8xx.h>
+#endif
+
+#ifndef __ASSEMBLY__
+typedef struct page *pgtable_t;
+#endif
+
+#endif /* _ASM_POWERPC_NOHASH_32_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/include/asm/nohash/64/mmu.h
new file mode 100644
index 000000000000..e6585480dfc4
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/64/mmu.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_64_MMU_H_
+#define _ASM_POWERPC_NOHASH_64_MMU_H_
+
+/* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
+#include <asm/nohash/mmu-book3e.h>
+
+#ifndef __ASSEMBLY__
+typedef struct page *pgtable_t;
+#endif
+
+#endif /* _ASM_POWERPC_NOHASH_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/mmu-book3e.h b/arch/powerpc/include/asm/nohash/mmu-book3e.h
new file mode 100644
index 000000000000..e20072972e35
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/mmu-book3e.h
@@ -0,0 +1,313 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_MMU_BOOK3E_H_
+#define _ASM_POWERPC_MMU_BOOK3E_H_
+/*
+ * Freescale Book-E/Book-3e (ISA 2.06+) MMU support
+ */
+
+/* Book-3e defined page sizes */
+#define BOOK3E_PAGESZ_1K	0
+#define BOOK3E_PAGESZ_2K	1
+#define BOOK3E_PAGESZ_4K	2
+#define BOOK3E_PAGESZ_8K	3
+#define BOOK3E_PAGESZ_16K	4
+#define BOOK3E_PAGESZ_32K	5
+#define BOOK3E_PAGESZ_64K	6
+#define BOOK3E_PAGESZ_128K	7
+#define BOOK3E_PAGESZ_256K	8
+#define BOOK3E_PAGESZ_512K	9
+#define BOOK3E_PAGESZ_1M	10
+#define BOOK3E_PAGESZ_2M	11
+#define BOOK3E_PAGESZ_4M	12
+#define BOOK3E_PAGESZ_8M	13
+#define BOOK3E_PAGESZ_16M	14
+#define BOOK3E_PAGESZ_32M	15
+#define BOOK3E_PAGESZ_64M	16
+#define BOOK3E_PAGESZ_128M	17
+#define BOOK3E_PAGESZ_256M	18
+#define BOOK3E_PAGESZ_512M	19
+#define BOOK3E_PAGESZ_1GB	20
+#define BOOK3E_PAGESZ_2GB	21
+#define BOOK3E_PAGESZ_4GB	22
+#define BOOK3E_PAGESZ_8GB	23
+#define BOOK3E_PAGESZ_16GB	24
+#define BOOK3E_PAGESZ_32GB	25
+#define BOOK3E_PAGESZ_64GB	26
+#define BOOK3E_PAGESZ_128GB	27
+#define BOOK3E_PAGESZ_256GB	28
+#define BOOK3E_PAGESZ_512GB	29
+#define BOOK3E_PAGESZ_1TB	30
+#define BOOK3E_PAGESZ_2TB	31
+
+/* MAS registers bit definitions */
+
+#define MAS0_TLBSEL_MASK	0x30000000
+#define MAS0_TLBSEL_SHIFT	28
+#define MAS0_TLBSEL(x)		(((x) << MAS0_TLBSEL_SHIFT) & MAS0_TLBSEL_MASK)
+#define MAS0_GET_TLBSEL(mas0)	(((mas0) & MAS0_TLBSEL_MASK) >> \
+			MAS0_TLBSEL_SHIFT)
+#define MAS0_ESEL_MASK		0x0FFF0000
+#define MAS0_ESEL_SHIFT		16
+#define MAS0_ESEL(x)		(((x) << MAS0_ESEL_SHIFT) & MAS0_ESEL_MASK)
+#define MAS0_NV(x)		((x) & 0x00000FFF)
+#define MAS0_HES		0x00004000
+#define MAS0_WQ_ALLWAYS		0x00000000
+#define MAS0_WQ_COND		0x00001000
+#define MAS0_WQ_CLR_RSRV       	0x00002000
+
+#define MAS1_VALID		0x80000000
+#define MAS1_IPROT		0x40000000
+#define MAS1_TID(x)		(((x) << 16) & 0x3FFF0000)
+#define MAS1_IND		0x00002000
+#define MAS1_TS			0x00001000
+#define MAS1_TSIZE_MASK		0x00000f80
+#define MAS1_TSIZE_SHIFT	7
+#define MAS1_TSIZE(x)		(((x) << MAS1_TSIZE_SHIFT) & MAS1_TSIZE_MASK)
+#define MAS1_GET_TSIZE(mas1)	(((mas1) & MAS1_TSIZE_MASK) >> MAS1_TSIZE_SHIFT)
+
+#define MAS2_EPN		(~0xFFFUL)
+#define MAS2_X0			0x00000040
+#define MAS2_X1			0x00000020
+#define MAS2_W			0x00000010
+#define MAS2_I			0x00000008
+#define MAS2_M			0x00000004
+#define MAS2_G			0x00000002
+#define MAS2_E			0x00000001
+#define MAS2_WIMGE_MASK		0x0000001f
+#define MAS2_EPN_MASK(size)		(~0 << (size + 10))
+#define MAS2_VAL(addr, size, flags)	((addr) & MAS2_EPN_MASK(size) | (flags))
+
+#define MAS3_RPN		0xFFFFF000
+#define MAS3_U0			0x00000200
+#define MAS3_U1			0x00000100
+#define MAS3_U2			0x00000080
+#define MAS3_U3			0x00000040
+#define MAS3_UX			0x00000020
+#define MAS3_SX			0x00000010
+#define MAS3_UW			0x00000008
+#define MAS3_SW			0x00000004
+#define MAS3_UR			0x00000002
+#define MAS3_SR			0x00000001
+#define MAS3_BAP_MASK		0x0000003f
+#define MAS3_SPSIZE		0x0000003e
+#define MAS3_SPSIZE_SHIFT	1
+
+#define MAS4_TLBSEL_MASK	MAS0_TLBSEL_MASK
+#define MAS4_TLBSELD(x) 	MAS0_TLBSEL(x)
+#define MAS4_INDD		0x00008000	/* Default IND */
+#define MAS4_TSIZED(x)		MAS1_TSIZE(x)
+#define MAS4_X0D		0x00000040
+#define MAS4_X1D		0x00000020
+#define MAS4_WD			0x00000010
+#define MAS4_ID			0x00000008
+#define MAS4_MD			0x00000004
+#define MAS4_GD			0x00000002
+#define MAS4_ED			0x00000001
+#define MAS4_WIMGED_MASK	0x0000001f	/* Default WIMGE */
+#define MAS4_WIMGED_SHIFT	0
+#define MAS4_VLED		MAS4_X1D	/* Default VLE */
+#define MAS4_ACMD		0x000000c0	/* Default ACM */
+#define MAS4_ACMD_SHIFT		6
+#define MAS4_TSIZED_MASK	0x00000f80	/* Default TSIZE */
+#define MAS4_TSIZED_SHIFT	7
+
+#define MAS5_SGS		0x80000000
+
+#define MAS6_SPID0		0x3FFF0000
+#define MAS6_SPID1		0x00007FFE
+#define MAS6_ISIZE(x)		MAS1_TSIZE(x)
+#define MAS6_SAS		0x00000001
+#define MAS6_SPID		MAS6_SPID0
+#define MAS6_SIND 		0x00000002	/* Indirect page */
+#define MAS6_SIND_SHIFT		1
+#define MAS6_SPID_MASK		0x3fff0000
+#define MAS6_SPID_SHIFT		16
+#define MAS6_ISIZE_MASK		0x00000f80
+#define MAS6_ISIZE_SHIFT	7
+
+#define MAS7_RPN		0xFFFFFFFF
+
+#define MAS8_TGS		0x80000000 /* Guest space */
+#define MAS8_VF			0x40000000 /* Virtualization Fault */
+#define MAS8_TLPID		0x000000ff
+
+/* Bit definitions for MMUCFG */
+#define MMUCFG_MAVN	0x00000003	/* MMU Architecture Version Number */
+#define MMUCFG_MAVN_V1	0x00000000	/* v1.0 */
+#define MMUCFG_MAVN_V2	0x00000001	/* v2.0 */
+#define MMUCFG_NTLBS	0x0000000c	/* Number of TLBs */
+#define MMUCFG_PIDSIZE	0x000007c0	/* PID Reg Size */
+#define MMUCFG_TWC	0x00008000	/* TLB Write Conditional (v2.0) */
+#define MMUCFG_LRAT	0x00010000	/* LRAT Supported (v2.0) */
+#define MMUCFG_RASIZE	0x00fe0000	/* Real Addr Size */
+#define MMUCFG_LPIDSIZE	0x0f000000	/* LPID Reg Size */
+
+/* Bit definitions for MMUCSR0 */
+#define MMUCSR0_TLB1FI	0x00000002	/* TLB1 Flash invalidate */
+#define MMUCSR0_TLB0FI	0x00000004	/* TLB0 Flash invalidate */
+#define MMUCSR0_TLB2FI	0x00000040	/* TLB2 Flash invalidate */
+#define MMUCSR0_TLB3FI	0x00000020	/* TLB3 Flash invalidate */
+#define MMUCSR0_TLBFI	(MMUCSR0_TLB0FI | MMUCSR0_TLB1FI | \
+			 MMUCSR0_TLB2FI | MMUCSR0_TLB3FI)
+#define MMUCSR0_TLB0PS	0x00000780	/* TLB0 Page Size */
+#define MMUCSR0_TLB1PS	0x00007800	/* TLB1 Page Size */
+#define MMUCSR0_TLB2PS	0x00078000	/* TLB2 Page Size */
+#define MMUCSR0_TLB3PS	0x00780000	/* TLB3 Page Size */
+
+/* MMUCFG bits */
+#define MMUCFG_MAVN_NASK	0x00000003
+#define MMUCFG_MAVN_V1_0	0x00000000
+#define MMUCFG_MAVN_V2_0	0x00000001
+#define MMUCFG_NTLB_MASK	0x0000000c
+#define MMUCFG_NTLB_SHIFT	2
+#define MMUCFG_PIDSIZE_MASK	0x000007c0
+#define MMUCFG_PIDSIZE_SHIFT	6
+#define MMUCFG_TWC		0x00008000
+#define MMUCFG_LRAT		0x00010000
+#define MMUCFG_RASIZE_MASK	0x00fe0000
+#define MMUCFG_RASIZE_SHIFT	17
+#define MMUCFG_LPIDSIZE_MASK	0x0f000000
+#define MMUCFG_LPIDSIZE_SHIFT	24
+
+/* TLBnCFG encoding */
+#define TLBnCFG_N_ENTRY		0x00000fff	/* number of entries */
+#define TLBnCFG_HES		0x00002000	/* HW select supported */
+#define TLBnCFG_IPROT		0x00008000	/* IPROT supported */
+#define TLBnCFG_GTWE		0x00010000	/* Guest can write */
+#define TLBnCFG_IND		0x00020000	/* IND entries supported */
+#define TLBnCFG_PT		0x00040000	/* Can load from page table */
+#define TLBnCFG_MINSIZE		0x00f00000	/* Minimum Page Size (v1.0) */
+#define TLBnCFG_MINSIZE_SHIFT	20
+#define TLBnCFG_MAXSIZE		0x000f0000	/* Maximum Page Size (v1.0) */
+#define TLBnCFG_MAXSIZE_SHIFT	16
+#define TLBnCFG_ASSOC		0xff000000	/* Associativity */
+#define TLBnCFG_ASSOC_SHIFT	24
+
+/* TLBnPS encoding */
+#define TLBnPS_4K		0x00000004
+#define TLBnPS_8K		0x00000008
+#define TLBnPS_16K		0x00000010
+#define TLBnPS_32K		0x00000020
+#define TLBnPS_64K		0x00000040
+#define TLBnPS_128K		0x00000080
+#define TLBnPS_256K		0x00000100
+#define TLBnPS_512K		0x00000200
+#define TLBnPS_1M 		0x00000400
+#define TLBnPS_2M 		0x00000800
+#define TLBnPS_4M 		0x00001000
+#define TLBnPS_8M 		0x00002000
+#define TLBnPS_16M		0x00004000
+#define TLBnPS_32M		0x00008000
+#define TLBnPS_64M		0x00010000
+#define TLBnPS_128M		0x00020000
+#define TLBnPS_256M		0x00040000
+#define TLBnPS_512M		0x00080000
+#define TLBnPS_1G		0x00100000
+#define TLBnPS_2G		0x00200000
+#define TLBnPS_4G		0x00400000
+#define TLBnPS_8G		0x00800000
+#define TLBnPS_16G		0x01000000
+#define TLBnPS_32G		0x02000000
+#define TLBnPS_64G		0x04000000
+#define TLBnPS_128G		0x08000000
+#define TLBnPS_256G		0x10000000
+
+/* tlbilx action encoding */
+#define TLBILX_T_ALL			0
+#define TLBILX_T_TID			1
+#define TLBILX_T_FULLMATCH		3
+#define TLBILX_T_CLASS0			4
+#define TLBILX_T_CLASS1			5
+#define TLBILX_T_CLASS2			6
+#define TLBILX_T_CLASS3			7
+
+#ifndef __ASSEMBLY__
+#include <asm/bug.h>
+
+extern unsigned int tlbcam_index;
+
+typedef struct {
+	unsigned int	id;
+	unsigned int	active;
+	unsigned long	vdso_base;
+} mm_context_t;
+
+/* Page size definitions, common between 32 and 64-bit
+ *
+ *    shift : is the "PAGE_SHIFT" value for that page size
+ *    penc  : is the pte encoding mask
+ *
+ */
+struct mmu_psize_def
+{
+	unsigned int	shift;	/* number of bits */
+	unsigned int	enc;	/* PTE encoding */
+	unsigned int    ind;    /* Corresponding indirect page size shift */
+	unsigned int	flags;
+#define MMU_PAGE_SIZE_DIRECT	0x1	/* Supported as a direct size */
+#define MMU_PAGE_SIZE_INDIRECT	0x2	/* Supported as an indirect size */
+};
+extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
+
+static inline int shift_to_mmu_psize(unsigned int shift)
+{
+	int psize;
+
+	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize)
+		if (mmu_psize_defs[psize].shift == shift)
+			return psize;
+	return -1;
+}
+
+static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
+{
+	if (mmu_psize_defs[mmu_psize].shift)
+		return mmu_psize_defs[mmu_psize].shift;
+	BUG();
+}
+
+/* The page sizes use the same names as 64-bit hash but are
+ * constants
+ */
+#if defined(CONFIG_PPC_4K_PAGES)
+#define mmu_virtual_psize	MMU_PAGE_4K
+#else
+#error Unsupported page size
+#endif
+
+extern int mmu_linear_psize;
+extern int mmu_vmemmap_psize;
+
+struct tlb_core_data {
+	/*
+	 * Per-core spinlock for e6500 TLB handlers (no tlbsrx.)
+	 * Must be the first struct element.
+	 */
+	u8 lock;
+
+	/* For software way selection, as on Freescale TLB1 */
+	u8 esel_next, esel_max, esel_first;
+};
+
+#ifdef CONFIG_PPC64
+extern unsigned long linear_map_top;
+extern int book3e_htw_mode;
+
+#define PPC_HTW_NONE	0
+#define PPC_HTW_IBM	1
+#define PPC_HTW_E6500	2
+
+/*
+ * 64-bit booke platforms don't load the tlb in the tlb miss handler code.
+ * HUGETLB_NEED_PRELOAD handles this - it causes huge_ptep_set_access_flags to
+ * return 1, indicating that the tlb requires preloading.
+ */
+#define HUGETLB_NEED_PRELOAD
+
+#define mmu_cleanup_all NULL
+
+#endif
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_POWERPC_MMU_BOOK3E_H_ */
diff --git a/arch/powerpc/include/asm/nohash/mmu.h b/arch/powerpc/include/asm/nohash/mmu.h
new file mode 100644
index 000000000000..a037cb1efb57
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/mmu.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_MMU_H_
+#define _ASM_POWERPC_NOHASH_MMU_H_
+
+#ifdef CONFIG_PPC64
+#include <asm/nohash/64/mmu.h>
+#else
+#include <asm/nohash/32/mmu.h>
+#endif
+
+#endif /* _ASM_POWERPC_NOHASH_MMU_H_ */
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index f6a1265face2..ddfb4b965e5b 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -335,20 +335,6 @@ void arch_free_page(struct page *page, int order);
 #endif
 
 struct vm_area_struct;
-#ifdef CONFIG_PPC_BOOK3S_64
-/*
- * For BOOK3s 64 with 4k and 64K linux page size
- * we want to use pointers, because the page table
- * actually store pfn
- */
-typedef pte_t *pgtable_t;
-#else
-#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC64)
-typedef pte_t *pgtable_t;
-#else
-typedef struct page *pgtable_t;
-#endif
-#endif
 
 #include <asm-generic/memory_model.h>
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
new file mode 100644
index 000000000000..d05d969c98c2
--- /dev/null
+++ b/arch/powerpc/include/asm/stackprotector.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * GCC stack protector support.
+ *
+ */
+
+#ifndef _ASM_STACKPROTECTOR_H
+#define _ASM_STACKPROTECTOR_H
+
+#include <linux/random.h>
+#include <linux/version.h>
+#include <asm/reg.h>
+#include <asm/current.h>
+
+/*
+ * Initialize the stackprotector canary value.
+ *
+ * NOTE: this must only be called from functions that never return,
+ * and it must always be inlined.
+ */
+static __always_inline void boot_init_stack_canary(void)
+{
+	unsigned long canary;
+
+	/* Try to get a semi random initial value. */
+	canary = get_random_canary();
+	canary ^= mftb();
+	canary ^= LINUX_VERSION_CODE;
+	canary &= CANARY_MASK;
+
+	current->stack_canary = canary;
+}
+
+#endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index bf19c5514d6c..cccea292af68 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -21,6 +21,8 @@ CFLAGS_prom_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_btext.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_prom.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 
+CFLAGS_prom_init.o += $(call cc-option, -fno-stack-protector)
+
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
 CFLAGS_REMOVE_cputable.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 50400f213bbf..c2288c73d56d 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -79,6 +79,9 @@ int main(void)
 {
 	OFFSET(THREAD, task_struct, thread);
 	OFFSET(MM, task_struct, mm);
+#ifdef CONFIG_STACKPROTECTOR
+	OFFSET(TASK_CANARY, task_struct, stack_canary);
+#endif
 	OFFSET(MMCONTEXTID, mm_struct, context.id);
 #ifdef CONFIG_PPC64
 	DEFINE(SIGSEGV, SIGSEGV);
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 8d142e5d84cd..5fbc890d1094 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -17,7 +17,7 @@
 #include <asm/processor.h>
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
-#include <asm/mmu-book3e.h>
+#include <asm/nohash/mmu-book3e.h>
 #include <asm/asm-offsets.h>
 #include <asm/mpc85xx.h>
 
diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 10fabae2574d..ddab3488cadb 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -714,9 +714,9 @@ static int __init rtas_flash_init(void)
 	if (!rtas_validate_flash_data.buf)
 		return -ENOMEM;
 
-	flash_block_cache = kmem_cache_create("rtas_flash_cache",
-					      RTAS_BLK_SIZE, RTAS_BLK_SIZE, 0,
-					      NULL);
+	flash_block_cache = kmem_cache_create_usercopy("rtas_flash_cache",
+						       RTAS_BLK_SIZE, RTAS_BLK_SIZE,
+						       0, 0, RTAS_BLK_SIZE, NULL);
 	if (!flash_block_cache) {
 		printk(KERN_ERR "%s: failed to create block cache\n",
 				__func__);
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 94f04fcb373e..962ee90a0dfe 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -20,7 +20,7 @@
 #define KVM_E500_H
 
 #include <linux/kvm_host.h>
-#include <asm/mmu-book3e.h>
+#include <asm/nohash/mmu-book3e.h>
 #include <asm/tlb.h>
 #include <asm/cputhreads.h>
 
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 3c844bdd16c4..d4648a1e6e6c 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -42,13 +42,5 @@ obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
 obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= mmu_context_iommu.o
-obj-$(CONFIG_PPC_PTDUMP)	+= dump_linuxpagetables.o
-ifdef CONFIG_PPC_PTDUMP
-obj-$(CONFIG_4xx)		+= dump_linuxpagetables-generic.o
-obj-$(CONFIG_PPC_8xx)		+= dump_linuxpagetables-8xx.o
-obj-$(CONFIG_PPC_BOOK3E_MMU)	+= dump_linuxpagetables-generic.o
-obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= dump_linuxpagetables-book3s64.o
-endif
-obj-$(CONFIG_PPC_HTDUMP)	+= dump_hashpagetable.o
+obj-$(CONFIG_PPC_PTDUMP)	+= ptdump/
 obj-$(CONFIG_PPC_MEM_KEYS)	+= pkeys.o
diff --git a/arch/powerpc/mm/dump_hashpagetable.c b/arch/powerpc/mm/dump_hashpagetable.c
deleted file mode 100644
index b430e4e08af6..000000000000
--- a/arch/powerpc/mm/dump_hashpagetable.c
+++ /dev/null
@@ -1,550 +0,0 @@
-/*
- * Copyright 2016, Rashmica Gupta, IBM Corp.
- *
- * This traverses the kernel virtual memory and dumps the pages that are in
- * the hash pagetable, along with their flags to
- * /sys/kernel/debug/kernel_hash_pagetable.
- *
- * If radix is enabled then there is no hash page table and so no debugfs file
- * is generated.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2
- * of the License.
- */
-#include <linux/debugfs.h>
-#include <linux/fs.h>
-#include <linux/io.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/seq_file.h>
-#include <asm/pgtable.h>
-#include <linux/const.h>
-#include <asm/page.h>
-#include <asm/pgalloc.h>
-#include <asm/plpar_wrappers.h>
-#include <linux/memblock.h>
-#include <asm/firmware.h>
-
-struct pg_state {
-	struct seq_file *seq;
-	const struct addr_marker *marker;
-	unsigned long start_address;
-	unsigned int level;
-	u64 current_flags;
-};
-
-struct addr_marker {
-	unsigned long start_address;
-	const char *name;
-};
-
-static struct addr_marker address_markers[] = {
-	{ 0,	"Start of kernel VM" },
-	{ 0,	"vmalloc() Area" },
-	{ 0,	"vmalloc() End" },
-	{ 0,	"isa I/O start" },
-	{ 0,	"isa I/O end" },
-	{ 0,	"phb I/O start" },
-	{ 0,	"phb I/O end" },
-	{ 0,	"I/O remap start" },
-	{ 0,	"I/O remap end" },
-	{ 0,	"vmemmap start" },
-	{ -1,	NULL },
-};
-
-struct flag_info {
-	u64		mask;
-	u64		val;
-	const char	*set;
-	const char	*clear;
-	bool		is_val;
-	int		shift;
-};
-
-static const struct flag_info v_flag_array[] = {
-	{
-		.mask   = SLB_VSID_B,
-		.val    = SLB_VSID_B_256M,
-		.set    = "ssize: 256M",
-		.clear  = "ssize: 1T  ",
-	}, {
-		.mask	= HPTE_V_SECONDARY,
-		.val	= HPTE_V_SECONDARY,
-		.set	= "secondary",
-		.clear	= "primary  ",
-	}, {
-		.mask	= HPTE_V_VALID,
-		.val	= HPTE_V_VALID,
-		.set	= "valid  ",
-		.clear	= "invalid",
-	}, {
-		.mask	= HPTE_V_BOLTED,
-		.val	= HPTE_V_BOLTED,
-		.set	= "bolted",
-		.clear	= "",
-	}
-};
-
-static const struct flag_info r_flag_array[] = {
-	{
-		.mask	= HPTE_R_PP0 | HPTE_R_PP,
-		.val	= PP_RWXX,
-		.set	= "prot:RW--",
-	}, {
-		.mask	= HPTE_R_PP0 | HPTE_R_PP,
-		.val	= PP_RWRX,
-		.set	= "prot:RWR-",
-	}, {
-		.mask	= HPTE_R_PP0 | HPTE_R_PP,
-		.val	= PP_RWRW,
-		.set	= "prot:RWRW",
-	}, {
-		.mask	= HPTE_R_PP0 | HPTE_R_PP,
-		.val	= PP_RXRX,
-		.set	= "prot:R-R-",
-	}, {
-		.mask	= HPTE_R_PP0 | HPTE_R_PP,
-		.val	= PP_RXXX,
-		.set	= "prot:R---",
-	}, {
-		.mask	= HPTE_R_KEY_HI | HPTE_R_KEY_LO,
-		.val	= HPTE_R_KEY_HI | HPTE_R_KEY_LO,
-		.set	= "key",
-		.clear	= "",
-		.is_val = true,
-	}, {
-		.mask	= HPTE_R_R,
-		.val	= HPTE_R_R,
-		.set	= "ref",
-		.clear	= "   ",
-	}, {
-		.mask	= HPTE_R_C,
-		.val	= HPTE_R_C,
-		.set	= "changed",
-		.clear	= "       ",
-	}, {
-		.mask	= HPTE_R_N,
-		.val	= HPTE_R_N,
-		.set	= "no execute",
-	}, {
-		.mask	= HPTE_R_WIMG,
-		.val	= HPTE_R_W,
-		.set	= "writethru",
-	}, {
-		.mask	= HPTE_R_WIMG,
-		.val	= HPTE_R_I,
-		.set	= "no cache",
-	}, {
-		.mask	= HPTE_R_WIMG,
-		.val	= HPTE_R_G,
-		.set	= "guarded",
-	}
-};
-
-static int calculate_pagesize(struct pg_state *st, int ps, char s[])
-{
-	static const char units[] = "BKMGTPE";
-	const char *unit = units;
-
-	while (ps > 9 && unit[1]) {
-		ps -= 10;
-		unit++;
-	}
-	seq_printf(st->seq, "  %s_ps: %i%c\t", s, 1<<ps, *unit);
-	return ps;
-}
-
-static void dump_flag_info(struct pg_state *st, const struct flag_info
-		*flag, u64 pte, int num)
-{
-	unsigned int i;
-
-	for (i = 0; i < num; i++, flag++) {
-		const char *s = NULL;
-		u64 val;
-
-		/* flag not defined so don't check it */
-		if (flag->mask == 0)
-			continue;
-		/* Some 'flags' are actually values */
-		if (flag->is_val) {
-			val = pte & flag->val;
-			if (flag->shift)
-				val = val >> flag->shift;
-			seq_printf(st->seq, "  %s:%llx", flag->set, val);
-		} else {
-			if ((pte & flag->mask) == flag->val)
-				s = flag->set;
-			else
-				s = flag->clear;
-			if (s)
-				seq_printf(st->seq, "  %s", s);
-		}
-	}
-}
-
-static void dump_hpte_info(struct pg_state *st, unsigned long ea, u64 v, u64 r,
-		unsigned long rpn, int bps, int aps, unsigned long lp)
-{
-	int aps_index;
-
-	while (ea >= st->marker[1].start_address) {
-		st->marker++;
-		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
-	}
-	seq_printf(st->seq, "0x%lx:\t", ea);
-	seq_printf(st->seq, "AVPN:%llx\t", HPTE_V_AVPN_VAL(v));
-	dump_flag_info(st, v_flag_array, v, ARRAY_SIZE(v_flag_array));
-	seq_printf(st->seq, "  rpn: %lx\t", rpn);
-	dump_flag_info(st, r_flag_array, r, ARRAY_SIZE(r_flag_array));
-
-	calculate_pagesize(st, bps, "base");
-	aps_index = calculate_pagesize(st, aps, "actual");
-	if (aps_index != 2)
-		seq_printf(st->seq, "LP enc: %lx", lp);
-	seq_putc(st->seq, '\n');
-}
-
-
-static int native_find(unsigned long ea, int psize, bool primary, u64 *v, u64
-		*r)
-{
-	struct hash_pte *hptep;
-	unsigned long hash, vsid, vpn, hpte_group, want_v, hpte_v;
-	int i, ssize = mmu_kernel_ssize;
-	unsigned long shift = mmu_psize_defs[psize].shift;
-
-	/* calculate hash */
-	vsid = get_kernel_vsid(ea, ssize);
-	vpn  = hpt_vpn(ea, vsid, ssize);
-	hash = hpt_hash(vpn, shift, ssize);
-	want_v = hpte_encode_avpn(vpn, psize, ssize);
-
-	/* to check in the secondary hash table, we invert the hash */
-	if (!primary)
-		hash = ~hash;
-	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-	for (i = 0; i < HPTES_PER_GROUP; i++) {
-		hptep = htab_address + hpte_group;
-		hpte_v = be64_to_cpu(hptep->v);
-
-		if (HPTE_V_COMPARE(hpte_v, want_v) && (hpte_v & HPTE_V_VALID)) {
-			/* HPTE matches */
-			*v = be64_to_cpu(hptep->v);
-			*r = be64_to_cpu(hptep->r);
-			return 0;
-		}
-		++hpte_group;
-	}
-	return -1;
-}
-
-#ifdef CONFIG_PPC_PSERIES
-static int pseries_find(unsigned long ea, int psize, bool primary, u64 *v, u64 *r)
-{
-	struct hash_pte ptes[4];
-	unsigned long vsid, vpn, hash, hpte_group, want_v;
-	int i, j, ssize = mmu_kernel_ssize;
-	long lpar_rc = 0;
-	unsigned long shift = mmu_psize_defs[psize].shift;
-
-	/* calculate hash */
-	vsid = get_kernel_vsid(ea, ssize);
-	vpn  = hpt_vpn(ea, vsid, ssize);
-	hash = hpt_hash(vpn, shift, ssize);
-	want_v = hpte_encode_avpn(vpn, psize, ssize);
-
-	/* to check in the secondary hash table, we invert the hash */
-	if (!primary)
-		hash = ~hash;
-	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-	/* see if we can find an entry in the hpte with this hash */
-	for (i = 0; i < HPTES_PER_GROUP; i += 4, hpte_group += 4) {
-		lpar_rc = plpar_pte_read_4(0, hpte_group, (void *)ptes);
-
-		if (lpar_rc != H_SUCCESS)
-			continue;
-		for (j = 0; j < 4; j++) {
-			if (HPTE_V_COMPARE(ptes[j].v, want_v) &&
-					(ptes[j].v & HPTE_V_VALID)) {
-				/* HPTE matches */
-				*v = ptes[j].v;
-				*r = ptes[j].r;
-				return 0;
-			}
-		}
-	}
-	return -1;
-}
-#endif
-
-static void decode_r(int bps, unsigned long r, unsigned long *rpn, int *aps,
-		unsigned long *lp_bits)
-{
-	struct mmu_psize_def entry;
-	unsigned long arpn, mask, lp;
-	int penc = -2, idx = 0, shift;
-
-	/*.
-	 * The LP field has 8 bits. Depending on the actual page size, some of
-	 * these bits are concatenated with the APRN to get the RPN. The rest
-	 * of the bits in the LP field is the LP value and is an encoding for
-	 * the base page size and the actual page size.
-	 *
-	 *  -	find the mmu entry for our base page size
-	 *  -	go through all page encodings and use the associated mask to
-	 *	find an encoding that matches our encoding in the LP field.
-	 */
-	arpn = (r & HPTE_R_RPN) >> HPTE_R_RPN_SHIFT;
-	lp = arpn & 0xff;
-
-	entry = mmu_psize_defs[bps];
-	while (idx < MMU_PAGE_COUNT) {
-		penc = entry.penc[idx];
-		if ((penc != -1) && (mmu_psize_defs[idx].shift)) {
-			shift = mmu_psize_defs[idx].shift -  HPTE_R_RPN_SHIFT;
-			mask = (0x1 << (shift)) - 1;
-			if ((lp & mask) == penc) {
-				*aps = mmu_psize_to_shift(idx);
-				*lp_bits = lp & mask;
-				*rpn = arpn >> shift;
-				return;
-			}
-		}
-		idx++;
-	}
-}
-
-static int base_hpte_find(unsigned long ea, int psize, bool primary, u64 *v,
-			  u64 *r)
-{
-#ifdef CONFIG_PPC_PSERIES
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		return pseries_find(ea, psize, primary, v, r);
-#endif
-	return native_find(ea, psize, primary, v, r);
-}
-
-static unsigned long hpte_find(struct pg_state *st, unsigned long ea, int psize)
-{
-	unsigned long slot;
-	u64 v  = 0, r = 0;
-	unsigned long rpn, lp_bits;
-	int base_psize = 0, actual_psize = 0;
-
-	if (ea < PAGE_OFFSET)
-		return -1;
-
-	/* Look in primary table */
-	slot = base_hpte_find(ea, psize, true, &v, &r);
-
-	/* Look in secondary table */
-	if (slot == -1)
-		slot = base_hpte_find(ea, psize, false, &v, &r);
-
-	/* No entry found */
-	if (slot == -1)
-		return -1;
-
-	/*
-	 * We found an entry in the hash page table:
-	 *  - check that this has the same base page
-	 *  - find the actual page size
-	 *  - find the RPN
-	 */
-	base_psize = mmu_psize_to_shift(psize);
-
-	if ((v & HPTE_V_LARGE) == HPTE_V_LARGE) {
-		decode_r(psize, r, &rpn, &actual_psize, &lp_bits);
-	} else {
-		/* 4K actual page size */
-		actual_psize = 12;
-		rpn = (r & HPTE_R_RPN) >> HPTE_R_RPN_SHIFT;
-		/* In this case there are no LP bits */
-		lp_bits = -1;
-	}
-	/*
-	 * We didn't find a matching encoding, so the PTE we found isn't for
-	 * this address.
-	 */
-	if (actual_psize == -1)
-		return -1;
-
-	dump_hpte_info(st, ea, v, r, rpn, base_psize, actual_psize, lp_bits);
-	return 0;
-}
-
-static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
-{
-	pte_t *pte = pte_offset_kernel(pmd, 0);
-	unsigned long addr, pteval, psize;
-	int i, status;
-
-	for (i = 0; i < PTRS_PER_PTE; i++, pte++) {
-		addr = start + i * PAGE_SIZE;
-		pteval = pte_val(*pte);
-
-		if (addr < VMALLOC_END)
-			psize = mmu_vmalloc_psize;
-		else
-			psize = mmu_io_psize;
-#ifdef CONFIG_PPC_64K_PAGES
-		/* check for secret 4K mappings */
-		if (((pteval & H_PAGE_COMBO) == H_PAGE_COMBO) ||
-			((pteval & H_PAGE_4K_PFN) == H_PAGE_4K_PFN))
-			psize = mmu_io_psize;
-#endif
-		/* check for hashpte */
-		status = hpte_find(st, addr, psize);
-
-		if (((pteval & H_PAGE_HASHPTE) != H_PAGE_HASHPTE)
-				&& (status != -1)) {
-		/* found a hpte that is not in the linux page tables */
-			seq_printf(st->seq, "page probably bolted before linux"
-				" pagetables were set: addr:%lx, pteval:%lx\n",
-				addr, pteval);
-		}
-	}
-}
-
-static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
-{
-	pmd_t *pmd = pmd_offset(pud, 0);
-	unsigned long addr;
-	unsigned int i;
-
-	for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
-		addr = start + i * PMD_SIZE;
-		if (!pmd_none(*pmd))
-			/* pmd exists */
-			walk_pte(st, pmd, addr);
-	}
-}
-
-static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
-{
-	pud_t *pud = pud_offset(pgd, 0);
-	unsigned long addr;
-	unsigned int i;
-
-	for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
-		addr = start + i * PUD_SIZE;
-		if (!pud_none(*pud))
-			/* pud exists */
-			walk_pmd(st, pud, addr);
-	}
-}
-
-static void walk_pagetables(struct pg_state *st)
-{
-	pgd_t *pgd = pgd_offset_k(0UL);
-	unsigned int i;
-	unsigned long addr;
-
-	/*
-	 * Traverse the linux pagetable structure and dump pages that are in
-	 * the hash pagetable.
-	 */
-	for (i = 0; i < PTRS_PER_PGD; i++, pgd++) {
-		addr = KERN_VIRT_START + i * PGDIR_SIZE;
-		if (!pgd_none(*pgd))
-			/* pgd exists */
-			walk_pud(st, pgd, addr);
-	}
-}
-
-
-static void walk_linearmapping(struct pg_state *st)
-{
-	unsigned long addr;
-
-	/*
-	 * Traverse the linear mapping section of virtual memory and dump pages
-	 * that are in the hash pagetable.
-	 */
-	unsigned long psize = 1 << mmu_psize_defs[mmu_linear_psize].shift;
-
-	for (addr = PAGE_OFFSET; addr < PAGE_OFFSET +
-			memblock_end_of_DRAM(); addr += psize)
-		hpte_find(st, addr, mmu_linear_psize);
-}
-
-static void walk_vmemmap(struct pg_state *st)
-{
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-	struct vmemmap_backing *ptr = vmemmap_list;
-
-	/*
-	 * Traverse the vmemmaped memory and dump pages that are in the hash
-	 * pagetable.
-	 */
-	while (ptr->list) {
-		hpte_find(st, ptr->virt_addr, mmu_vmemmap_psize);
-		ptr = ptr->list;
-	}
-	seq_puts(st->seq, "---[ vmemmap end ]---\n");
-#endif
-}
-
-static void populate_markers(void)
-{
-	address_markers[0].start_address = PAGE_OFFSET;
-	address_markers[1].start_address = VMALLOC_START;
-	address_markers[2].start_address = VMALLOC_END;
-	address_markers[3].start_address = ISA_IO_BASE;
-	address_markers[4].start_address = ISA_IO_END;
-	address_markers[5].start_address = PHB_IO_BASE;
-	address_markers[6].start_address = PHB_IO_END;
-	address_markers[7].start_address = IOREMAP_BASE;
-	address_markers[8].start_address = IOREMAP_END;
-#ifdef CONFIG_PPC_BOOK3S_64
-	address_markers[9].start_address =  H_VMEMMAP_BASE;
-#else
-	address_markers[9].start_address =  VMEMMAP_BASE;
-#endif
-}
-
-static int ptdump_show(struct seq_file *m, void *v)
-{
-	struct pg_state st = {
-		.seq = m,
-		.start_address = PAGE_OFFSET,
-		.marker = address_markers,
-	};
-	/*
-	 * Traverse the 0xc, 0xd and 0xf areas of the kernel virtual memory and
-	 * dump pages that are in the hash pagetable.
-	 */
-	walk_linearmapping(&st);
-	walk_pagetables(&st);
-	walk_vmemmap(&st);
-	return 0;
-}
-
-static int ptdump_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ptdump_show, NULL);
-}
-
-static const struct file_operations ptdump_fops = {
-	.open		= ptdump_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int ptdump_init(void)
-{
-	struct dentry *debugfs_file;
-
-	if (!radix_enabled()) {
-		populate_markers();
-		debugfs_file = debugfs_create_file("kernel_hash_pagetable",
-				0400, NULL, NULL, &ptdump_fops);
-		return debugfs_file ? 0 : -ENOMEM;
-	}
-	return 0;
-}
-device_initcall(ptdump_init);
diff --git a/arch/powerpc/mm/dump_linuxpagetables-8xx.c b/arch/powerpc/mm/dump_linuxpagetables-8xx.c
deleted file mode 100644
index 33f52a97975b..000000000000
--- a/arch/powerpc/mm/dump_linuxpagetables-8xx.c
+++ /dev/null
@@ -1,82 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * From split of dump_linuxpagetables.c
- * Copyright 2016, Rashmica Gupta, IBM Corp.
- *
- */
-#include <linux/kernel.h>
-#include <asm/pgtable.h>
-
-#include "dump_linuxpagetables.h"
-
-static const struct flag_info flag_array[] = {
-	{
-		.mask	= _PAGE_PRIVILEGED,
-		.val	= 0,
-		.set	= "user",
-		.clear	= "    ",
-	}, {
-		.mask	= _PAGE_RO | _PAGE_NA,
-		.val	= 0,
-		.set	= "rw",
-	}, {
-		.mask	= _PAGE_RO | _PAGE_NA,
-		.val	= _PAGE_RO,
-		.set	= "r ",
-	}, {
-		.mask	= _PAGE_RO | _PAGE_NA,
-		.val	= _PAGE_NA,
-		.set	= "  ",
-	}, {
-		.mask	= _PAGE_EXEC,
-		.val	= _PAGE_EXEC,
-		.set	= " X ",
-		.clear	= "   ",
-	}, {
-		.mask	= _PAGE_PRESENT,
-		.val	= _PAGE_PRESENT,
-		.set	= "present",
-		.clear	= "       ",
-	}, {
-		.mask	= _PAGE_GUARDED,
-		.val	= _PAGE_GUARDED,
-		.set	= "guarded",
-		.clear	= "       ",
-	}, {
-		.mask	= _PAGE_DIRTY,
-		.val	= _PAGE_DIRTY,
-		.set	= "dirty",
-		.clear	= "     ",
-	}, {
-		.mask	= _PAGE_ACCESSED,
-		.val	= _PAGE_ACCESSED,
-		.set	= "accessed",
-		.clear	= "        ",
-	}, {
-		.mask	= _PAGE_NO_CACHE,
-		.val	= _PAGE_NO_CACHE,
-		.set	= "no cache",
-		.clear	= "        ",
-	}, {
-		.mask	= _PAGE_SPECIAL,
-		.val	= _PAGE_SPECIAL,
-		.set	= "special",
-	}
-};
-
-struct pgtable_level pg_level[5] = {
-	{
-	}, { /* pgd */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	}, { /* pud */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	}, { /* pmd */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	}, { /* pte */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	},
-};
diff --git a/arch/powerpc/mm/dump_linuxpagetables-book3s64.c b/arch/powerpc/mm/dump_linuxpagetables-book3s64.c
deleted file mode 100644
index a637e612b205..000000000000
--- a/arch/powerpc/mm/dump_linuxpagetables-book3s64.c
+++ /dev/null
@@ -1,115 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * From split of dump_linuxpagetables.c
- * Copyright 2016, Rashmica Gupta, IBM Corp.
- *
- */
-#include <linux/kernel.h>
-#include <asm/pgtable.h>
-
-#include "dump_linuxpagetables.h"
-
-static const struct flag_info flag_array[] = {
-	{
-		.mask	= _PAGE_PRIVILEGED,
-		.val	= 0,
-		.set	= "user",
-		.clear	= "    ",
-	}, {
-		.mask	= _PAGE_READ,
-		.val	= _PAGE_READ,
-		.set	= "r",
-		.clear	= " ",
-	}, {
-		.mask	= _PAGE_WRITE,
-		.val	= _PAGE_WRITE,
-		.set	= "w",
-		.clear	= " ",
-	}, {
-		.mask	= _PAGE_EXEC,
-		.val	= _PAGE_EXEC,
-		.set	= " X ",
-		.clear	= "   ",
-	}, {
-		.mask	= _PAGE_PTE,
-		.val	= _PAGE_PTE,
-		.set	= "pte",
-		.clear	= "   ",
-	}, {
-		.mask	= _PAGE_PRESENT,
-		.val	= _PAGE_PRESENT,
-		.set	= "present",
-		.clear	= "       ",
-	}, {
-		.mask	= H_PAGE_HASHPTE,
-		.val	= H_PAGE_HASHPTE,
-		.set	= "hpte",
-		.clear	= "    ",
-	}, {
-		.mask	= _PAGE_DIRTY,
-		.val	= _PAGE_DIRTY,
-		.set	= "dirty",
-		.clear	= "     ",
-	}, {
-		.mask	= _PAGE_ACCESSED,
-		.val	= _PAGE_ACCESSED,
-		.set	= "accessed",
-		.clear	= "        ",
-	}, {
-		.mask	= _PAGE_NON_IDEMPOTENT,
-		.val	= _PAGE_NON_IDEMPOTENT,
-		.set	= "non-idempotent",
-		.clear	= "              ",
-	}, {
-		.mask	= _PAGE_TOLERANT,
-		.val	= _PAGE_TOLERANT,
-		.set	= "tolerant",
-		.clear	= "        ",
-	}, {
-		.mask	= H_PAGE_BUSY,
-		.val	= H_PAGE_BUSY,
-		.set	= "busy",
-	}, {
-#ifdef CONFIG_PPC_64K_PAGES
-		.mask	= H_PAGE_COMBO,
-		.val	= H_PAGE_COMBO,
-		.set	= "combo",
-	}, {
-		.mask	= H_PAGE_4K_PFN,
-		.val	= H_PAGE_4K_PFN,
-		.set	= "4K_pfn",
-	}, {
-#else /* CONFIG_PPC_64K_PAGES */
-		.mask	= H_PAGE_F_GIX,
-		.val	= H_PAGE_F_GIX,
-		.set	= "f_gix",
-		.is_val	= true,
-		.shift	= H_PAGE_F_GIX_SHIFT,
-	}, {
-		.mask	= H_PAGE_F_SECOND,
-		.val	= H_PAGE_F_SECOND,
-		.set	= "f_second",
-	}, {
-#endif /* CONFIG_PPC_64K_PAGES */
-		.mask	= _PAGE_SPECIAL,
-		.val	= _PAGE_SPECIAL,
-		.set	= "special",
-	}
-};
-
-struct pgtable_level pg_level[5] = {
-	{
-	}, { /* pgd */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	}, { /* pud */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	}, { /* pmd */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	}, { /* pte */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	},
-};
diff --git a/arch/powerpc/mm/dump_linuxpagetables-generic.c b/arch/powerpc/mm/dump_linuxpagetables-generic.c
deleted file mode 100644
index fed6923bcb46..000000000000
--- a/arch/powerpc/mm/dump_linuxpagetables-generic.c
+++ /dev/null
@@ -1,82 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * From split of dump_linuxpagetables.c
- * Copyright 2016, Rashmica Gupta, IBM Corp.
- *
- */
-#include <linux/kernel.h>
-#include <asm/pgtable.h>
-
-#include "dump_linuxpagetables.h"
-
-static const struct flag_info flag_array[] = {
-	{
-		.mask	= _PAGE_USER,
-		.val	= _PAGE_USER,
-		.set	= "user",
-		.clear	= "    ",
-	}, {
-		.mask	= _PAGE_RW,
-		.val	= 0,
-		.set	= "r ",
-		.clear	= "rw",
-	}, {
-#ifndef CONFIG_PPC_BOOK3S_32
-		.mask	= _PAGE_EXEC,
-		.val	= _PAGE_EXEC,
-		.set	= " X ",
-		.clear	= "   ",
-	}, {
-#endif
-		.mask	= _PAGE_PRESENT,
-		.val	= _PAGE_PRESENT,
-		.set	= "present",
-		.clear	= "       ",
-	}, {
-		.mask	= _PAGE_GUARDED,
-		.val	= _PAGE_GUARDED,
-		.set	= "guarded",
-		.clear	= "       ",
-	}, {
-		.mask	= _PAGE_DIRTY,
-		.val	= _PAGE_DIRTY,
-		.set	= "dirty",
-		.clear	= "     ",
-	}, {
-		.mask	= _PAGE_ACCESSED,
-		.val	= _PAGE_ACCESSED,
-		.set	= "accessed",
-		.clear	= "        ",
-	}, {
-		.mask	= _PAGE_WRITETHRU,
-		.val	= _PAGE_WRITETHRU,
-		.set	= "write through",
-		.clear	= "             ",
-	}, {
-		.mask	= _PAGE_NO_CACHE,
-		.val	= _PAGE_NO_CACHE,
-		.set	= "no cache",
-		.clear	= "        ",
-	}, {
-		.mask	= _PAGE_SPECIAL,
-		.val	= _PAGE_SPECIAL,
-		.set	= "special",
-	}
-};
-
-struct pgtable_level pg_level[5] = {
-	{
-	}, { /* pgd */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	}, { /* pud */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	}, { /* pmd */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	}, { /* pte */
-		.flag	= flag_array,
-		.num	= ARRAY_SIZE(flag_array),
-	},
-};
diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
deleted file mode 100644
index 6aa41669ac1a..000000000000
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ /dev/null
@@ -1,373 +0,0 @@
-/*
- * Copyright 2016, Rashmica Gupta, IBM Corp.
- *
- * This traverses the kernel pagetables and dumps the
- * information about the used sections of memory to
- * /sys/kernel/debug/kernel_pagetables.
- *
- * Derived from the arm64 implementation:
- * Copyright (c) 2014, The Linux Foundation, Laura Abbott.
- * (C) Copyright 2008 Intel Corporation, Arjan van de Ven.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2
- * of the License.
- */
-#include <linux/debugfs.h>
-#include <linux/fs.h>
-#include <linux/hugetlb.h>
-#include <linux/io.h>
-#include <linux/mm.h>
-#include <linux/highmem.h>
-#include <linux/sched.h>
-#include <linux/seq_file.h>
-#include <asm/fixmap.h>
-#include <asm/pgtable.h>
-#include <linux/const.h>
-#include <asm/page.h>
-#include <asm/pgalloc.h>
-
-#include "dump_linuxpagetables.h"
-
-#ifdef CONFIG_PPC32
-#define KERN_VIRT_START	0
-#endif
-
-/*
- * To visualise what is happening,
- *
- *  - PTRS_PER_P** = how many entries there are in the corresponding P**
- *  - P**_SHIFT = how many bits of the address we use to index into the
- * corresponding P**
- *  - P**_SIZE is how much memory we can access through the table - not the
- * size of the table itself.
- * P**={PGD, PUD, PMD, PTE}
- *
- *
- * Each entry of the PGD points to a PUD. Each entry of a PUD points to a
- * PMD. Each entry of a PMD points to a PTE. And every PTE entry points to
- * a page.
- *
- * In the case where there are only 3 levels, the PUD is folded into the
- * PGD: every PUD has only one entry which points to the PMD.
- *
- * The page dumper groups page table entries of the same type into a single
- * description. It uses pg_state to track the range information while
- * iterating over the PTE entries. When the continuity is broken it then
- * dumps out a description of the range - ie PTEs that are virtually contiguous
- * with the same PTE flags are chunked together. This is to make it clear how
- * different areas of the kernel virtual memory are used.
- *
- */
-struct pg_state {
-	struct seq_file *seq;
-	const struct addr_marker *marker;
-	unsigned long start_address;
-	unsigned long start_pa;
-	unsigned long last_pa;
-	unsigned int level;
-	u64 current_flags;
-};
-
-struct addr_marker {
-	unsigned long start_address;
-	const char *name;
-};
-
-static struct addr_marker address_markers[] = {
-	{ 0,	"Start of kernel VM" },
-	{ 0,	"vmalloc() Area" },
-	{ 0,	"vmalloc() End" },
-#ifdef CONFIG_PPC64
-	{ 0,	"isa I/O start" },
-	{ 0,	"isa I/O end" },
-	{ 0,	"phb I/O start" },
-	{ 0,	"phb I/O end" },
-	{ 0,	"I/O remap start" },
-	{ 0,	"I/O remap end" },
-	{ 0,	"vmemmap start" },
-#else
-	{ 0,	"Early I/O remap start" },
-	{ 0,	"Early I/O remap end" },
-#ifdef CONFIG_NOT_COHERENT_CACHE
-	{ 0,	"Consistent mem start" },
-	{ 0,	"Consistent mem end" },
-#endif
-#ifdef CONFIG_HIGHMEM
-	{ 0,	"Highmem PTEs start" },
-	{ 0,	"Highmem PTEs end" },
-#endif
-	{ 0,	"Fixmap start" },
-	{ 0,	"Fixmap end" },
-#endif
-	{ -1,	NULL },
-};
-
-static void dump_flag_info(struct pg_state *st, const struct flag_info
-		*flag, u64 pte, int num)
-{
-	unsigned int i;
-
-	for (i = 0; i < num; i++, flag++) {
-		const char *s = NULL;
-		u64 val;
-
-		/* flag not defined so don't check it */
-		if (flag->mask == 0)
-			continue;
-		/* Some 'flags' are actually values */
-		if (flag->is_val) {
-			val = pte & flag->val;
-			if (flag->shift)
-				val = val >> flag->shift;
-			seq_printf(st->seq, "  %s:%llx", flag->set, val);
-		} else {
-			if ((pte & flag->mask) == flag->val)
-				s = flag->set;
-			else
-				s = flag->clear;
-			if (s)
-				seq_printf(st->seq, "  %s", s);
-		}
-		st->current_flags &= ~flag->mask;
-	}
-	if (st->current_flags != 0)
-		seq_printf(st->seq, "  unknown flags:%llx", st->current_flags);
-}
-
-static void dump_addr(struct pg_state *st, unsigned long addr)
-{
-	static const char units[] = "KMGTPE";
-	const char *unit = units;
-	unsigned long delta;
-
-#ifdef CONFIG_PPC64
-	seq_printf(st->seq, "0x%016lx-0x%016lx ", st->start_address, addr-1);
-	seq_printf(st->seq, "0x%016lx ", st->start_pa);
-#else
-	seq_printf(st->seq, "0x%08lx-0x%08lx ", st->start_address, addr - 1);
-	seq_printf(st->seq, "0x%08lx ", st->start_pa);
-#endif
-
-	delta = (addr - st->start_address) >> 10;
-	/* Work out what appropriate unit to use */
-	while (!(delta & 1023) && unit[1]) {
-		delta >>= 10;
-		unit++;
-	}
-	seq_printf(st->seq, "%9lu%c", delta, *unit);
-
-}
-
-static void note_page(struct pg_state *st, unsigned long addr,
-	       unsigned int level, u64 val)
-{
-	u64 flag = val & pg_level[level].mask;
-	u64 pa = val & PTE_RPN_MASK;
-
-	/* At first no level is set */
-	if (!st->level) {
-		st->level = level;
-		st->current_flags = flag;
-		st->start_address = addr;
-		st->start_pa = pa;
-		st->last_pa = pa;
-		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
-	/*
-	 * Dump the section of virtual memory when:
-	 *   - the PTE flags from one entry to the next differs.
-	 *   - we change levels in the tree.
-	 *   - the address is in a different section of memory and is thus
-	 *   used for a different purpose, regardless of the flags.
-	 *   - the pa of this page is not adjacent to the last inspected page
-	 */
-	} else if (flag != st->current_flags || level != st->level ||
-		   addr >= st->marker[1].start_address ||
-		   pa != st->last_pa + PAGE_SIZE) {
-
-		/* Check the PTE flags */
-		if (st->current_flags) {
-			dump_addr(st, addr);
-
-			/* Dump all the flags */
-			if (pg_level[st->level].flag)
-				dump_flag_info(st, pg_level[st->level].flag,
-					  st->current_flags,
-					  pg_level[st->level].num);
-
-			seq_putc(st->seq, '\n');
-		}
-
-		/*
-		 * Address indicates we have passed the end of the
-		 * current section of virtual memory
-		 */
-		while (addr >= st->marker[1].start_address) {
-			st->marker++;
-			seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
-		}
-		st->start_address = addr;
-		st->start_pa = pa;
-		st->last_pa = pa;
-		st->current_flags = flag;
-		st->level = level;
-	} else {
-		st->last_pa = pa;
-	}
-}
-
-static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
-{
-	pte_t *pte = pte_offset_kernel(pmd, 0);
-	unsigned long addr;
-	unsigned int i;
-
-	for (i = 0; i < PTRS_PER_PTE; i++, pte++) {
-		addr = start + i * PAGE_SIZE;
-		note_page(st, addr, 4, pte_val(*pte));
-
-	}
-}
-
-static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
-{
-	pmd_t *pmd = pmd_offset(pud, 0);
-	unsigned long addr;
-	unsigned int i;
-
-	for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
-		addr = start + i * PMD_SIZE;
-		if (!pmd_none(*pmd) && !pmd_huge(*pmd))
-			/* pmd exists */
-			walk_pte(st, pmd, addr);
-		else
-			note_page(st, addr, 3, pmd_val(*pmd));
-	}
-}
-
-static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
-{
-	pud_t *pud = pud_offset(pgd, 0);
-	unsigned long addr;
-	unsigned int i;
-
-	for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
-		addr = start + i * PUD_SIZE;
-		if (!pud_none(*pud) && !pud_huge(*pud))
-			/* pud exists */
-			walk_pmd(st, pud, addr);
-		else
-			note_page(st, addr, 2, pud_val(*pud));
-	}
-}
-
-static void walk_pagetables(struct pg_state *st)
-{
-	pgd_t *pgd = pgd_offset_k(0UL);
-	unsigned int i;
-	unsigned long addr;
-
-	addr = st->start_address;
-
-	/*
-	 * Traverse the linux pagetable structure and dump pages that are in
-	 * the hash pagetable.
-	 */
-	for (i = 0; i < PTRS_PER_PGD; i++, pgd++, addr += PGDIR_SIZE) {
-		if (!pgd_none(*pgd) && !pgd_huge(*pgd))
-			/* pgd exists */
-			walk_pud(st, pgd, addr);
-		else
-			note_page(st, addr, 1, pgd_val(*pgd));
-	}
-}
-
-static void populate_markers(void)
-{
-	int i = 0;
-
-	address_markers[i++].start_address = PAGE_OFFSET;
-	address_markers[i++].start_address = VMALLOC_START;
-	address_markers[i++].start_address = VMALLOC_END;
-#ifdef CONFIG_PPC64
-	address_markers[i++].start_address = ISA_IO_BASE;
-	address_markers[i++].start_address = ISA_IO_END;
-	address_markers[i++].start_address = PHB_IO_BASE;
-	address_markers[i++].start_address = PHB_IO_END;
-	address_markers[i++].start_address = IOREMAP_BASE;
-	address_markers[i++].start_address = IOREMAP_END;
-#ifdef CONFIG_PPC_BOOK3S_64
-	address_markers[i++].start_address =  H_VMEMMAP_BASE;
-#else
-	address_markers[i++].start_address =  VMEMMAP_BASE;
-#endif
-#else /* !CONFIG_PPC64 */
-	address_markers[i++].start_address = ioremap_bot;
-	address_markers[i++].start_address = IOREMAP_TOP;
-#ifdef CONFIG_NOT_COHERENT_CACHE
-	address_markers[i++].start_address = IOREMAP_TOP;
-	address_markers[i++].start_address = IOREMAP_TOP +
-					     CONFIG_CONSISTENT_SIZE;
-#endif
-#ifdef CONFIG_HIGHMEM
-	address_markers[i++].start_address = PKMAP_BASE;
-	address_markers[i++].start_address = PKMAP_ADDR(LAST_PKMAP);
-#endif
-	address_markers[i++].start_address = FIXADDR_START;
-	address_markers[i++].start_address = FIXADDR_TOP;
-#endif /* CONFIG_PPC64 */
-}
-
-static int ptdump_show(struct seq_file *m, void *v)
-{
-	struct pg_state st = {
-		.seq = m,
-		.marker = address_markers,
-	};
-
-	if (radix_enabled())
-		st.start_address = PAGE_OFFSET;
-	else
-		st.start_address = KERN_VIRT_START;
-
-	/* Traverse kernel page tables */
-	walk_pagetables(&st);
-	note_page(&st, 0, 0, 0);
-	return 0;
-}
-
-
-static int ptdump_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ptdump_show, NULL);
-}
-
-static const struct file_operations ptdump_fops = {
-	.open		= ptdump_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static void build_pgtable_complete_mask(void)
-{
-	unsigned int i, j;
-
-	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
-		if (pg_level[i].flag)
-			for (j = 0; j < pg_level[i].num; j++)
-				pg_level[i].mask |= pg_level[i].flag[j].mask;
-}
-
-static int ptdump_init(void)
-{
-	struct dentry *debugfs_file;
-
-	populate_markers();
-	build_pgtable_complete_mask();
-	debugfs_file = debugfs_create_file("kernel_page_tables", 0400, NULL,
-			NULL, &ptdump_fops);
-	return debugfs_file ? 0 : -ENOMEM;
-}
-device_initcall(ptdump_init);
diff --git a/arch/powerpc/mm/dump_linuxpagetables.h b/arch/powerpc/mm/dump_linuxpagetables.h
deleted file mode 100644
index 5d513636de73..000000000000
--- a/arch/powerpc/mm/dump_linuxpagetables.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/types.h>
-
-struct flag_info {
-	u64		mask;
-	u64		val;
-	const char	*set;
-	const char	*clear;
-	bool		is_val;
-	int		shift;
-};
-
-struct pgtable_level {
-	const struct flag_info *flag;
-	size_t num;
-	u64 mask;
-};
-
-extern struct pgtable_level pg_level[5];
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 9ee235fca427..75cbedaac5d2 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -1041,8 +1041,8 @@ void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
 				  pte_t entry, unsigned long address, int psize)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
-					      _PAGE_RW | _PAGE_EXEC);
+	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_SOFT_DIRTY |
+					      _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
 
 	unsigned long change = pte_val(entry) ^ pte_val(*ptep);
 	/*
diff --git a/arch/powerpc/mm/ptdump/8xx.c b/arch/powerpc/mm/ptdump/8xx.c
new file mode 100644
index 000000000000..80b4f73f7fdc
--- /dev/null
+++ b/arch/powerpc/mm/ptdump/8xx.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * From split of dump_linuxpagetables.c
+ * Copyright 2016, Rashmica Gupta, IBM Corp.
+ *
+ */
+#include <linux/kernel.h>
+#include <asm/pgtable.h>
+
+#include "ptdump.h"
+
+static const struct flag_info flag_array[] = {
+	{
+		.mask	= _PAGE_PRIVILEGED,
+		.val	= 0,
+		.set	= "user",
+		.clear	= "    ",
+	}, {
+		.mask	= _PAGE_RO | _PAGE_NA,
+		.val	= 0,
+		.set	= "rw",
+	}, {
+		.mask	= _PAGE_RO | _PAGE_NA,
+		.val	= _PAGE_RO,
+		.set	= "r ",
+	}, {
+		.mask	= _PAGE_RO | _PAGE_NA,
+		.val	= _PAGE_NA,
+		.set	= "  ",
+	}, {
+		.mask	= _PAGE_EXEC,
+		.val	= _PAGE_EXEC,
+		.set	= " X ",
+		.clear	= "   ",
+	}, {
+		.mask	= _PAGE_PRESENT,
+		.val	= _PAGE_PRESENT,
+		.set	= "present",
+		.clear	= "       ",
+	}, {
+		.mask	= _PAGE_GUARDED,
+		.val	= _PAGE_GUARDED,
+		.set	= "guarded",
+		.clear	= "       ",
+	}, {
+		.mask	= _PAGE_DIRTY,
+		.val	= _PAGE_DIRTY,
+		.set	= "dirty",
+		.clear	= "     ",
+	}, {
+		.mask	= _PAGE_ACCESSED,
+		.val	= _PAGE_ACCESSED,
+		.set	= "accessed",
+		.clear	= "        ",
+	}, {
+		.mask	= _PAGE_NO_CACHE,
+		.val	= _PAGE_NO_CACHE,
+		.set	= "no cache",
+		.clear	= "        ",
+	}, {
+		.mask	= _PAGE_SPECIAL,
+		.val	= _PAGE_SPECIAL,
+		.set	= "special",
+	}
+};
+
+struct pgtable_level pg_level[5] = {
+	{
+	}, { /* pgd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pud */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pmd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pte */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	},
+};
diff --git a/arch/powerpc/mm/ptdump/Makefile b/arch/powerpc/mm/ptdump/Makefile
new file mode 100644
index 000000000000..712762be3cb1
--- /dev/null
+++ b/arch/powerpc/mm/ptdump/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y	+= ptdump.o
+
+obj-$(CONFIG_4xx)		+= shared.o
+obj-$(CONFIG_PPC_8xx)		+= 8xx.o
+obj-$(CONFIG_PPC_BOOK3E_MMU)	+= shared.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= shared.o bats.o segment_regs.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= book3s64.o hashpagetable.o
diff --git a/arch/powerpc/mm/ptdump/bats.c b/arch/powerpc/mm/ptdump/bats.c
new file mode 100644
index 000000000000..a0d23e96e841
--- /dev/null
+++ b/arch/powerpc/mm/ptdump/bats.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018, Christophe Leroy CS S.I.
+ * <christophe.leroy@c-s.fr>
+ *
+ * This dumps the content of BATS
+ */
+
+#include <asm/debugfs.h>
+#include <asm/pgtable.h>
+#include <asm/cpu_has_feature.h>
+
+static char *pp_601(int k, int pp)
+{
+	if (pp == 0)
+		return k ? "NA" : "RWX";
+	if (pp == 1)
+		return k ? "ROX" : "RWX";
+	if (pp == 2)
+		return k ? "RWX" : "RWX";
+	return k ? "ROX" : "ROX";
+}
+
+static void bat_show_601(struct seq_file *m, int idx, u32 lower, u32 upper)
+{
+	u32 blpi = upper & 0xfffe0000;
+	u32 k = (upper >> 2) & 3;
+	u32 pp = upper & 3;
+	phys_addr_t pbn = PHYS_BAT_ADDR(lower);
+	u32 bsm = lower & 0x3ff;
+	u32 size = (bsm + 1) << 17;
+
+	seq_printf(m, "%d: ", idx);
+	if (!(lower & 0x40)) {
+		seq_puts(m, "        -\n");
+		return;
+	}
+
+	seq_printf(m, "0x%08x-0x%08x ", blpi, blpi + size - 1);
+#ifdef CONFIG_PHYS_64BIT
+	seq_printf(m, "0x%016llx ", pbn);
+#else
+	seq_printf(m, "0x%08x ", pbn);
+#endif
+
+	seq_printf(m, "Kernel %s User %s", pp_601(k & 2, pp), pp_601(k & 1, pp));
+
+	if (lower & _PAGE_WRITETHRU)
+		seq_puts(m, "write through ");
+	if (lower & _PAGE_NO_CACHE)
+		seq_puts(m, "no cache ");
+	if (lower & _PAGE_COHERENT)
+		seq_puts(m, "coherent ");
+	seq_puts(m, "\n");
+}
+
+#define BAT_SHOW_601(_m, _n, _l, _u) bat_show_601(_m, _n, mfspr(_l), mfspr(_u))
+
+static int bats_show_601(struct seq_file *m, void *v)
+{
+	seq_puts(m, "---[ Block Address Translation ]---\n");
+
+	BAT_SHOW_601(m, 0, SPRN_IBAT0L, SPRN_IBAT0U);
+	BAT_SHOW_601(m, 1, SPRN_IBAT1L, SPRN_IBAT1U);
+	BAT_SHOW_601(m, 2, SPRN_IBAT2L, SPRN_IBAT2U);
+	BAT_SHOW_601(m, 3, SPRN_IBAT3L, SPRN_IBAT3U);
+
+	return 0;
+}
+
+static void bat_show_603(struct seq_file *m, int idx, u32 lower, u32 upper, bool is_d)
+{
+	u32 bepi = upper & 0xfffe0000;
+	u32 bl = (upper >> 2) & 0x7ff;
+	u32 k = upper & 3;
+	phys_addr_t brpn = PHYS_BAT_ADDR(lower);
+	u32 size = (bl + 1) << 17;
+
+	seq_printf(m, "%d: ", idx);
+	if (k == 0) {
+		seq_puts(m, "        -\n");
+		return;
+	}
+
+	seq_printf(m, "0x%08x-0x%08x ", bepi, bepi + size - 1);
+#ifdef CONFIG_PHYS_64BIT
+	seq_printf(m, "0x%016llx ", brpn);
+#else
+	seq_printf(m, "0x%08x ", brpn);
+#endif
+
+	if (k == 1)
+		seq_puts(m, "User ");
+	else if (k == 2)
+		seq_puts(m, "Kernel ");
+	else
+		seq_puts(m, "Kernel/User ");
+
+	if (lower & BPP_RX)
+		seq_puts(m, is_d ? "RO " : "EXEC ");
+	else if (lower & BPP_RW)
+		seq_puts(m, is_d ? "RW " : "EXEC ");
+	else
+		seq_puts(m, is_d ? "NA " : "NX   ");
+
+	if (lower & _PAGE_WRITETHRU)
+		seq_puts(m, "write through ");
+	if (lower & _PAGE_NO_CACHE)
+		seq_puts(m, "no cache ");
+	if (lower & _PAGE_COHERENT)
+		seq_puts(m, "coherent ");
+	if (lower & _PAGE_GUARDED)
+		seq_puts(m, "guarded ");
+	seq_puts(m, "\n");
+}
+
+#define BAT_SHOW_603(_m, _n, _l, _u, _d) bat_show_603(_m, _n, mfspr(_l), mfspr(_u), _d)
+
+static int bats_show_603(struct seq_file *m, void *v)
+{
+	seq_puts(m, "---[ Instruction Block Address Translation ]---\n");
+
+	BAT_SHOW_603(m, 0, SPRN_IBAT0L, SPRN_IBAT0U, false);
+	BAT_SHOW_603(m, 1, SPRN_IBAT1L, SPRN_IBAT1U, false);
+	BAT_SHOW_603(m, 2, SPRN_IBAT2L, SPRN_IBAT2U, false);
+	BAT_SHOW_603(m, 3, SPRN_IBAT3L, SPRN_IBAT3U, false);
+	if (mmu_has_feature(MMU_FTR_USE_HIGH_BATS)) {
+		BAT_SHOW_603(m, 4, SPRN_IBAT4L, SPRN_IBAT4U, false);
+		BAT_SHOW_603(m, 5, SPRN_IBAT5L, SPRN_IBAT5U, false);
+		BAT_SHOW_603(m, 6, SPRN_IBAT6L, SPRN_IBAT6U, false);
+		BAT_SHOW_603(m, 7, SPRN_IBAT7L, SPRN_IBAT7U, false);
+	}
+
+	seq_puts(m, "\n---[ Data Block Address Translation ]---\n");
+
+	BAT_SHOW_603(m, 0, SPRN_DBAT0L, SPRN_DBAT0U, true);
+	BAT_SHOW_603(m, 1, SPRN_DBAT1L, SPRN_DBAT1U, true);
+	BAT_SHOW_603(m, 2, SPRN_DBAT2L, SPRN_DBAT2U, true);
+	BAT_SHOW_603(m, 3, SPRN_DBAT3L, SPRN_DBAT3U, true);
+	if (mmu_has_feature(MMU_FTR_USE_HIGH_BATS)) {
+		BAT_SHOW_603(m, 4, SPRN_DBAT4L, SPRN_DBAT4U, true);
+		BAT_SHOW_603(m, 5, SPRN_DBAT5L, SPRN_DBAT5U, true);
+		BAT_SHOW_603(m, 6, SPRN_DBAT6L, SPRN_DBAT6U, true);
+		BAT_SHOW_603(m, 7, SPRN_DBAT7L, SPRN_DBAT7U, true);
+	}
+
+	return 0;
+}
+
+static int bats_open(struct inode *inode, struct file *file)
+{
+	if (cpu_has_feature(CPU_FTR_601))
+		return single_open(file, bats_show_601, NULL);
+
+	return single_open(file, bats_show_603, NULL);
+}
+
+static const struct file_operations bats_fops = {
+	.open		= bats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init bats_init(void)
+{
+	struct dentry *debugfs_file;
+
+	debugfs_file = debugfs_create_file("block_address_translation", 0400,
+					   powerpc_debugfs_root, NULL, &bats_fops);
+	return debugfs_file ? 0 : -ENOMEM;
+}
+device_initcall(bats_init);
diff --git a/arch/powerpc/mm/ptdump/book3s64.c b/arch/powerpc/mm/ptdump/book3s64.c
new file mode 100644
index 000000000000..0bce5b85d011
--- /dev/null
+++ b/arch/powerpc/mm/ptdump/book3s64.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * From split of dump_linuxpagetables.c
+ * Copyright 2016, Rashmica Gupta, IBM Corp.
+ *
+ */
+#include <linux/kernel.h>
+#include <asm/pgtable.h>
+
+#include "ptdump.h"
+
+static const struct flag_info flag_array[] = {
+	{
+		.mask	= _PAGE_PRIVILEGED,
+		.val	= 0,
+		.set	= "user",
+		.clear	= "    ",
+	}, {
+		.mask	= _PAGE_READ,
+		.val	= _PAGE_READ,
+		.set	= "r",
+		.clear	= " ",
+	}, {
+		.mask	= _PAGE_WRITE,
+		.val	= _PAGE_WRITE,
+		.set	= "w",
+		.clear	= " ",
+	}, {
+		.mask	= _PAGE_EXEC,
+		.val	= _PAGE_EXEC,
+		.set	= " X ",
+		.clear	= "   ",
+	}, {
+		.mask	= _PAGE_PTE,
+		.val	= _PAGE_PTE,
+		.set	= "pte",
+		.clear	= "   ",
+	}, {
+		.mask	= _PAGE_PRESENT,
+		.val	= _PAGE_PRESENT,
+		.set	= "present",
+		.clear	= "       ",
+	}, {
+		.mask	= H_PAGE_HASHPTE,
+		.val	= H_PAGE_HASHPTE,
+		.set	= "hpte",
+		.clear	= "    ",
+	}, {
+		.mask	= _PAGE_DIRTY,
+		.val	= _PAGE_DIRTY,
+		.set	= "dirty",
+		.clear	= "     ",
+	}, {
+		.mask	= _PAGE_ACCESSED,
+		.val	= _PAGE_ACCESSED,
+		.set	= "accessed",
+		.clear	= "        ",
+	}, {
+		.mask	= _PAGE_NON_IDEMPOTENT,
+		.val	= _PAGE_NON_IDEMPOTENT,
+		.set	= "non-idempotent",
+		.clear	= "              ",
+	}, {
+		.mask	= _PAGE_TOLERANT,
+		.val	= _PAGE_TOLERANT,
+		.set	= "tolerant",
+		.clear	= "        ",
+	}, {
+		.mask	= H_PAGE_BUSY,
+		.val	= H_PAGE_BUSY,
+		.set	= "busy",
+	}, {
+#ifdef CONFIG_PPC_64K_PAGES
+		.mask	= H_PAGE_COMBO,
+		.val	= H_PAGE_COMBO,
+		.set	= "combo",
+	}, {
+		.mask	= H_PAGE_4K_PFN,
+		.val	= H_PAGE_4K_PFN,
+		.set	= "4K_pfn",
+	}, {
+#else /* CONFIG_PPC_64K_PAGES */
+		.mask	= H_PAGE_F_GIX,
+		.val	= H_PAGE_F_GIX,
+		.set	= "f_gix",
+		.is_val	= true,
+		.shift	= H_PAGE_F_GIX_SHIFT,
+	}, {
+		.mask	= H_PAGE_F_SECOND,
+		.val	= H_PAGE_F_SECOND,
+		.set	= "f_second",
+	}, {
+#endif /* CONFIG_PPC_64K_PAGES */
+		.mask	= _PAGE_SPECIAL,
+		.val	= _PAGE_SPECIAL,
+		.set	= "special",
+	}
+};
+
+struct pgtable_level pg_level[5] = {
+	{
+	}, { /* pgd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pud */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pmd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pte */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	},
+};
diff --git a/arch/powerpc/mm/ptdump/hashpagetable.c b/arch/powerpc/mm/ptdump/hashpagetable.c
new file mode 100644
index 000000000000..b430e4e08af6
--- /dev/null
+++ b/arch/powerpc/mm/ptdump/hashpagetable.c
@@ -0,0 +1,550 @@
+/*
+ * Copyright 2016, Rashmica Gupta, IBM Corp.
+ *
+ * This traverses the kernel virtual memory and dumps the pages that are in
+ * the hash pagetable, along with their flags to
+ * /sys/kernel/debug/kernel_hash_pagetable.
+ *
+ * If radix is enabled then there is no hash page table and so no debugfs file
+ * is generated.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <asm/pgtable.h>
+#include <linux/const.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <asm/plpar_wrappers.h>
+#include <linux/memblock.h>
+#include <asm/firmware.h>
+
+struct pg_state {
+	struct seq_file *seq;
+	const struct addr_marker *marker;
+	unsigned long start_address;
+	unsigned int level;
+	u64 current_flags;
+};
+
+struct addr_marker {
+	unsigned long start_address;
+	const char *name;
+};
+
+static struct addr_marker address_markers[] = {
+	{ 0,	"Start of kernel VM" },
+	{ 0,	"vmalloc() Area" },
+	{ 0,	"vmalloc() End" },
+	{ 0,	"isa I/O start" },
+	{ 0,	"isa I/O end" },
+	{ 0,	"phb I/O start" },
+	{ 0,	"phb I/O end" },
+	{ 0,	"I/O remap start" },
+	{ 0,	"I/O remap end" },
+	{ 0,	"vmemmap start" },
+	{ -1,	NULL },
+};
+
+struct flag_info {
+	u64		mask;
+	u64		val;
+	const char	*set;
+	const char	*clear;
+	bool		is_val;
+	int		shift;
+};
+
+static const struct flag_info v_flag_array[] = {
+	{
+		.mask   = SLB_VSID_B,
+		.val    = SLB_VSID_B_256M,
+		.set    = "ssize: 256M",
+		.clear  = "ssize: 1T  ",
+	}, {
+		.mask	= HPTE_V_SECONDARY,
+		.val	= HPTE_V_SECONDARY,
+		.set	= "secondary",
+		.clear	= "primary  ",
+	}, {
+		.mask	= HPTE_V_VALID,
+		.val	= HPTE_V_VALID,
+		.set	= "valid  ",
+		.clear	= "invalid",
+	}, {
+		.mask	= HPTE_V_BOLTED,
+		.val	= HPTE_V_BOLTED,
+		.set	= "bolted",
+		.clear	= "",
+	}
+};
+
+static const struct flag_info r_flag_array[] = {
+	{
+		.mask	= HPTE_R_PP0 | HPTE_R_PP,
+		.val	= PP_RWXX,
+		.set	= "prot:RW--",
+	}, {
+		.mask	= HPTE_R_PP0 | HPTE_R_PP,
+		.val	= PP_RWRX,
+		.set	= "prot:RWR-",
+	}, {
+		.mask	= HPTE_R_PP0 | HPTE_R_PP,
+		.val	= PP_RWRW,
+		.set	= "prot:RWRW",
+	}, {
+		.mask	= HPTE_R_PP0 | HPTE_R_PP,
+		.val	= PP_RXRX,
+		.set	= "prot:R-R-",
+	}, {
+		.mask	= HPTE_R_PP0 | HPTE_R_PP,
+		.val	= PP_RXXX,
+		.set	= "prot:R---",
+	}, {
+		.mask	= HPTE_R_KEY_HI | HPTE_R_KEY_LO,
+		.val	= HPTE_R_KEY_HI | HPTE_R_KEY_LO,
+		.set	= "key",
+		.clear	= "",
+		.is_val = true,
+	}, {
+		.mask	= HPTE_R_R,
+		.val	= HPTE_R_R,
+		.set	= "ref",
+		.clear	= "   ",
+	}, {
+		.mask	= HPTE_R_C,
+		.val	= HPTE_R_C,
+		.set	= "changed",
+		.clear	= "       ",
+	}, {
+		.mask	= HPTE_R_N,
+		.val	= HPTE_R_N,
+		.set	= "no execute",
+	}, {
+		.mask	= HPTE_R_WIMG,
+		.val	= HPTE_R_W,
+		.set	= "writethru",
+	}, {
+		.mask	= HPTE_R_WIMG,
+		.val	= HPTE_R_I,
+		.set	= "no cache",
+	}, {
+		.mask	= HPTE_R_WIMG,
+		.val	= HPTE_R_G,
+		.set	= "guarded",
+	}
+};
+
+static int calculate_pagesize(struct pg_state *st, int ps, char s[])
+{
+	static const char units[] = "BKMGTPE";
+	const char *unit = units;
+
+	while (ps > 9 && unit[1]) {
+		ps -= 10;
+		unit++;
+	}
+	seq_printf(st->seq, "  %s_ps: %i%c\t", s, 1<<ps, *unit);
+	return ps;
+}
+
+static void dump_flag_info(struct pg_state *st, const struct flag_info
+		*flag, u64 pte, int num)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++, flag++) {
+		const char *s = NULL;
+		u64 val;
+
+		/* flag not defined so don't check it */
+		if (flag->mask == 0)
+			continue;
+		/* Some 'flags' are actually values */
+		if (flag->is_val) {
+			val = pte & flag->val;
+			if (flag->shift)
+				val = val >> flag->shift;
+			seq_printf(st->seq, "  %s:%llx", flag->set, val);
+		} else {
+			if ((pte & flag->mask) == flag->val)
+				s = flag->set;
+			else
+				s = flag->clear;
+			if (s)
+				seq_printf(st->seq, "  %s", s);
+		}
+	}
+}
+
+static void dump_hpte_info(struct pg_state *st, unsigned long ea, u64 v, u64 r,
+		unsigned long rpn, int bps, int aps, unsigned long lp)
+{
+	int aps_index;
+
+	while (ea >= st->marker[1].start_address) {
+		st->marker++;
+		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
+	}
+	seq_printf(st->seq, "0x%lx:\t", ea);
+	seq_printf(st->seq, "AVPN:%llx\t", HPTE_V_AVPN_VAL(v));
+	dump_flag_info(st, v_flag_array, v, ARRAY_SIZE(v_flag_array));
+	seq_printf(st->seq, "  rpn: %lx\t", rpn);
+	dump_flag_info(st, r_flag_array, r, ARRAY_SIZE(r_flag_array));
+
+	calculate_pagesize(st, bps, "base");
+	aps_index = calculate_pagesize(st, aps, "actual");
+	if (aps_index != 2)
+		seq_printf(st->seq, "LP enc: %lx", lp);
+	seq_putc(st->seq, '\n');
+}
+
+
+static int native_find(unsigned long ea, int psize, bool primary, u64 *v, u64
+		*r)
+{
+	struct hash_pte *hptep;
+	unsigned long hash, vsid, vpn, hpte_group, want_v, hpte_v;
+	int i, ssize = mmu_kernel_ssize;
+	unsigned long shift = mmu_psize_defs[psize].shift;
+
+	/* calculate hash */
+	vsid = get_kernel_vsid(ea, ssize);
+	vpn  = hpt_vpn(ea, vsid, ssize);
+	hash = hpt_hash(vpn, shift, ssize);
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
+
+	/* to check in the secondary hash table, we invert the hash */
+	if (!primary)
+		hash = ~hash;
+	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+	for (i = 0; i < HPTES_PER_GROUP; i++) {
+		hptep = htab_address + hpte_group;
+		hpte_v = be64_to_cpu(hptep->v);
+
+		if (HPTE_V_COMPARE(hpte_v, want_v) && (hpte_v & HPTE_V_VALID)) {
+			/* HPTE matches */
+			*v = be64_to_cpu(hptep->v);
+			*r = be64_to_cpu(hptep->r);
+			return 0;
+		}
+		++hpte_group;
+	}
+	return -1;
+}
+
+#ifdef CONFIG_PPC_PSERIES
+static int pseries_find(unsigned long ea, int psize, bool primary, u64 *v, u64 *r)
+{
+	struct hash_pte ptes[4];
+	unsigned long vsid, vpn, hash, hpte_group, want_v;
+	int i, j, ssize = mmu_kernel_ssize;
+	long lpar_rc = 0;
+	unsigned long shift = mmu_psize_defs[psize].shift;
+
+	/* calculate hash */
+	vsid = get_kernel_vsid(ea, ssize);
+	vpn  = hpt_vpn(ea, vsid, ssize);
+	hash = hpt_hash(vpn, shift, ssize);
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
+
+	/* to check in the secondary hash table, we invert the hash */
+	if (!primary)
+		hash = ~hash;
+	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+	/* see if we can find an entry in the hpte with this hash */
+	for (i = 0; i < HPTES_PER_GROUP; i += 4, hpte_group += 4) {
+		lpar_rc = plpar_pte_read_4(0, hpte_group, (void *)ptes);
+
+		if (lpar_rc != H_SUCCESS)
+			continue;
+		for (j = 0; j < 4; j++) {
+			if (HPTE_V_COMPARE(ptes[j].v, want_v) &&
+					(ptes[j].v & HPTE_V_VALID)) {
+				/* HPTE matches */
+				*v = ptes[j].v;
+				*r = ptes[j].r;
+				return 0;
+			}
+		}
+	}
+	return -1;
+}
+#endif
+
+static void decode_r(int bps, unsigned long r, unsigned long *rpn, int *aps,
+		unsigned long *lp_bits)
+{
+	struct mmu_psize_def entry;
+	unsigned long arpn, mask, lp;
+	int penc = -2, idx = 0, shift;
+
+	/*.
+	 * The LP field has 8 bits. Depending on the actual page size, some of
+	 * these bits are concatenated with the APRN to get the RPN. The rest
+	 * of the bits in the LP field is the LP value and is an encoding for
+	 * the base page size and the actual page size.
+	 *
+	 *  -	find the mmu entry for our base page size
+	 *  -	go through all page encodings and use the associated mask to
+	 *	find an encoding that matches our encoding in the LP field.
+	 */
+	arpn = (r & HPTE_R_RPN) >> HPTE_R_RPN_SHIFT;
+	lp = arpn & 0xff;
+
+	entry = mmu_psize_defs[bps];
+	while (idx < MMU_PAGE_COUNT) {
+		penc = entry.penc[idx];
+		if ((penc != -1) && (mmu_psize_defs[idx].shift)) {
+			shift = mmu_psize_defs[idx].shift -  HPTE_R_RPN_SHIFT;
+			mask = (0x1 << (shift)) - 1;
+			if ((lp & mask) == penc) {
+				*aps = mmu_psize_to_shift(idx);
+				*lp_bits = lp & mask;
+				*rpn = arpn >> shift;
+				return;
+			}
+		}
+		idx++;
+	}
+}
+
+static int base_hpte_find(unsigned long ea, int psize, bool primary, u64 *v,
+			  u64 *r)
+{
+#ifdef CONFIG_PPC_PSERIES
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		return pseries_find(ea, psize, primary, v, r);
+#endif
+	return native_find(ea, psize, primary, v, r);
+}
+
+static unsigned long hpte_find(struct pg_state *st, unsigned long ea, int psize)
+{
+	unsigned long slot;
+	u64 v  = 0, r = 0;
+	unsigned long rpn, lp_bits;
+	int base_psize = 0, actual_psize = 0;
+
+	if (ea < PAGE_OFFSET)
+		return -1;
+
+	/* Look in primary table */
+	slot = base_hpte_find(ea, psize, true, &v, &r);
+
+	/* Look in secondary table */
+	if (slot == -1)
+		slot = base_hpte_find(ea, psize, false, &v, &r);
+
+	/* No entry found */
+	if (slot == -1)
+		return -1;
+
+	/*
+	 * We found an entry in the hash page table:
+	 *  - check that this has the same base page
+	 *  - find the actual page size
+	 *  - find the RPN
+	 */
+	base_psize = mmu_psize_to_shift(psize);
+
+	if ((v & HPTE_V_LARGE) == HPTE_V_LARGE) {
+		decode_r(psize, r, &rpn, &actual_psize, &lp_bits);
+	} else {
+		/* 4K actual page size */
+		actual_psize = 12;
+		rpn = (r & HPTE_R_RPN) >> HPTE_R_RPN_SHIFT;
+		/* In this case there are no LP bits */
+		lp_bits = -1;
+	}
+	/*
+	 * We didn't find a matching encoding, so the PTE we found isn't for
+	 * this address.
+	 */
+	if (actual_psize == -1)
+		return -1;
+
+	dump_hpte_info(st, ea, v, r, rpn, base_psize, actual_psize, lp_bits);
+	return 0;
+}
+
+static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
+{
+	pte_t *pte = pte_offset_kernel(pmd, 0);
+	unsigned long addr, pteval, psize;
+	int i, status;
+
+	for (i = 0; i < PTRS_PER_PTE; i++, pte++) {
+		addr = start + i * PAGE_SIZE;
+		pteval = pte_val(*pte);
+
+		if (addr < VMALLOC_END)
+			psize = mmu_vmalloc_psize;
+		else
+			psize = mmu_io_psize;
+#ifdef CONFIG_PPC_64K_PAGES
+		/* check for secret 4K mappings */
+		if (((pteval & H_PAGE_COMBO) == H_PAGE_COMBO) ||
+			((pteval & H_PAGE_4K_PFN) == H_PAGE_4K_PFN))
+			psize = mmu_io_psize;
+#endif
+		/* check for hashpte */
+		status = hpte_find(st, addr, psize);
+
+		if (((pteval & H_PAGE_HASHPTE) != H_PAGE_HASHPTE)
+				&& (status != -1)) {
+		/* found a hpte that is not in the linux page tables */
+			seq_printf(st->seq, "page probably bolted before linux"
+				" pagetables were set: addr:%lx, pteval:%lx\n",
+				addr, pteval);
+		}
+	}
+}
+
+static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
+{
+	pmd_t *pmd = pmd_offset(pud, 0);
+	unsigned long addr;
+	unsigned int i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
+		addr = start + i * PMD_SIZE;
+		if (!pmd_none(*pmd))
+			/* pmd exists */
+			walk_pte(st, pmd, addr);
+	}
+}
+
+static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
+{
+	pud_t *pud = pud_offset(pgd, 0);
+	unsigned long addr;
+	unsigned int i;
+
+	for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
+		addr = start + i * PUD_SIZE;
+		if (!pud_none(*pud))
+			/* pud exists */
+			walk_pmd(st, pud, addr);
+	}
+}
+
+static void walk_pagetables(struct pg_state *st)
+{
+	pgd_t *pgd = pgd_offset_k(0UL);
+	unsigned int i;
+	unsigned long addr;
+
+	/*
+	 * Traverse the linux pagetable structure and dump pages that are in
+	 * the hash pagetable.
+	 */
+	for (i = 0; i < PTRS_PER_PGD; i++, pgd++) {
+		addr = KERN_VIRT_START + i * PGDIR_SIZE;
+		if (!pgd_none(*pgd))
+			/* pgd exists */
+			walk_pud(st, pgd, addr);
+	}
+}
+
+
+static void walk_linearmapping(struct pg_state *st)
+{
+	unsigned long addr;
+
+	/*
+	 * Traverse the linear mapping section of virtual memory and dump pages
+	 * that are in the hash pagetable.
+	 */
+	unsigned long psize = 1 << mmu_psize_defs[mmu_linear_psize].shift;
+
+	for (addr = PAGE_OFFSET; addr < PAGE_OFFSET +
+			memblock_end_of_DRAM(); addr += psize)
+		hpte_find(st, addr, mmu_linear_psize);
+}
+
+static void walk_vmemmap(struct pg_state *st)
+{
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	struct vmemmap_backing *ptr = vmemmap_list;
+
+	/*
+	 * Traverse the vmemmaped memory and dump pages that are in the hash
+	 * pagetable.
+	 */
+	while (ptr->list) {
+		hpte_find(st, ptr->virt_addr, mmu_vmemmap_psize);
+		ptr = ptr->list;
+	}
+	seq_puts(st->seq, "---[ vmemmap end ]---\n");
+#endif
+}
+
+static void populate_markers(void)
+{
+	address_markers[0].start_address = PAGE_OFFSET;
+	address_markers[1].start_address = VMALLOC_START;
+	address_markers[2].start_address = VMALLOC_END;
+	address_markers[3].start_address = ISA_IO_BASE;
+	address_markers[4].start_address = ISA_IO_END;
+	address_markers[5].start_address = PHB_IO_BASE;
+	address_markers[6].start_address = PHB_IO_END;
+	address_markers[7].start_address = IOREMAP_BASE;
+	address_markers[8].start_address = IOREMAP_END;
+#ifdef CONFIG_PPC_BOOK3S_64
+	address_markers[9].start_address =  H_VMEMMAP_BASE;
+#else
+	address_markers[9].start_address =  VMEMMAP_BASE;
+#endif
+}
+
+static int ptdump_show(struct seq_file *m, void *v)
+{
+	struct pg_state st = {
+		.seq = m,
+		.start_address = PAGE_OFFSET,
+		.marker = address_markers,
+	};
+	/*
+	 * Traverse the 0xc, 0xd and 0xf areas of the kernel virtual memory and
+	 * dump pages that are in the hash pagetable.
+	 */
+	walk_linearmapping(&st);
+	walk_pagetables(&st);
+	walk_vmemmap(&st);
+	return 0;
+}
+
+static int ptdump_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ptdump_show, NULL);
+}
+
+static const struct file_operations ptdump_fops = {
+	.open		= ptdump_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int ptdump_init(void)
+{
+	struct dentry *debugfs_file;
+
+	if (!radix_enabled()) {
+		populate_markers();
+		debugfs_file = debugfs_create_file("kernel_hash_pagetable",
+				0400, NULL, NULL, &ptdump_fops);
+		return debugfs_file ? 0 : -ENOMEM;
+	}
+	return 0;
+}
+device_initcall(ptdump_init);
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
new file mode 100644
index 000000000000..76be98988578
--- /dev/null
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -0,0 +1,373 @@
+/*
+ * Copyright 2016, Rashmica Gupta, IBM Corp.
+ *
+ * This traverses the kernel pagetables and dumps the
+ * information about the used sections of memory to
+ * /sys/kernel/debug/kernel_pagetables.
+ *
+ * Derived from the arm64 implementation:
+ * Copyright (c) 2014, The Linux Foundation, Laura Abbott.
+ * (C) Copyright 2008 Intel Corporation, Arjan van de Ven.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/hugetlb.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <asm/fixmap.h>
+#include <asm/pgtable.h>
+#include <linux/const.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+
+#include "ptdump.h"
+
+#ifdef CONFIG_PPC32
+#define KERN_VIRT_START	0
+#endif
+
+/*
+ * To visualise what is happening,
+ *
+ *  - PTRS_PER_P** = how many entries there are in the corresponding P**
+ *  - P**_SHIFT = how many bits of the address we use to index into the
+ * corresponding P**
+ *  - P**_SIZE is how much memory we can access through the table - not the
+ * size of the table itself.
+ * P**={PGD, PUD, PMD, PTE}
+ *
+ *
+ * Each entry of the PGD points to a PUD. Each entry of a PUD points to a
+ * PMD. Each entry of a PMD points to a PTE. And every PTE entry points to
+ * a page.
+ *
+ * In the case where there are only 3 levels, the PUD is folded into the
+ * PGD: every PUD has only one entry which points to the PMD.
+ *
+ * The page dumper groups page table entries of the same type into a single
+ * description. It uses pg_state to track the range information while
+ * iterating over the PTE entries. When the continuity is broken it then
+ * dumps out a description of the range - ie PTEs that are virtually contiguous
+ * with the same PTE flags are chunked together. This is to make it clear how
+ * different areas of the kernel virtual memory are used.
+ *
+ */
+struct pg_state {
+	struct seq_file *seq;
+	const struct addr_marker *marker;
+	unsigned long start_address;
+	unsigned long start_pa;
+	unsigned long last_pa;
+	unsigned int level;
+	u64 current_flags;
+};
+
+struct addr_marker {
+	unsigned long start_address;
+	const char *name;
+};
+
+static struct addr_marker address_markers[] = {
+	{ 0,	"Start of kernel VM" },
+	{ 0,	"vmalloc() Area" },
+	{ 0,	"vmalloc() End" },
+#ifdef CONFIG_PPC64
+	{ 0,	"isa I/O start" },
+	{ 0,	"isa I/O end" },
+	{ 0,	"phb I/O start" },
+	{ 0,	"phb I/O end" },
+	{ 0,	"I/O remap start" },
+	{ 0,	"I/O remap end" },
+	{ 0,	"vmemmap start" },
+#else
+	{ 0,	"Early I/O remap start" },
+	{ 0,	"Early I/O remap end" },
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	{ 0,	"Consistent mem start" },
+	{ 0,	"Consistent mem end" },
+#endif
+#ifdef CONFIG_HIGHMEM
+	{ 0,	"Highmem PTEs start" },
+	{ 0,	"Highmem PTEs end" },
+#endif
+	{ 0,	"Fixmap start" },
+	{ 0,	"Fixmap end" },
+#endif
+	{ -1,	NULL },
+};
+
+static void dump_flag_info(struct pg_state *st, const struct flag_info
+		*flag, u64 pte, int num)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++, flag++) {
+		const char *s = NULL;
+		u64 val;
+
+		/* flag not defined so don't check it */
+		if (flag->mask == 0)
+			continue;
+		/* Some 'flags' are actually values */
+		if (flag->is_val) {
+			val = pte & flag->val;
+			if (flag->shift)
+				val = val >> flag->shift;
+			seq_printf(st->seq, "  %s:%llx", flag->set, val);
+		} else {
+			if ((pte & flag->mask) == flag->val)
+				s = flag->set;
+			else
+				s = flag->clear;
+			if (s)
+				seq_printf(st->seq, "  %s", s);
+		}
+		st->current_flags &= ~flag->mask;
+	}
+	if (st->current_flags != 0)
+		seq_printf(st->seq, "  unknown flags:%llx", st->current_flags);
+}
+
+static void dump_addr(struct pg_state *st, unsigned long addr)
+{
+	static const char units[] = "KMGTPE";
+	const char *unit = units;
+	unsigned long delta;
+
+#ifdef CONFIG_PPC64
+	seq_printf(st->seq, "0x%016lx-0x%016lx ", st->start_address, addr-1);
+	seq_printf(st->seq, "0x%016lx ", st->start_pa);
+#else
+	seq_printf(st->seq, "0x%08lx-0x%08lx ", st->start_address, addr - 1);
+	seq_printf(st->seq, "0x%08lx ", st->start_pa);
+#endif
+
+	delta = (addr - st->start_address) >> 10;
+	/* Work out what appropriate unit to use */
+	while (!(delta & 1023) && unit[1]) {
+		delta >>= 10;
+		unit++;
+	}
+	seq_printf(st->seq, "%9lu%c", delta, *unit);
+
+}
+
+static void note_page(struct pg_state *st, unsigned long addr,
+	       unsigned int level, u64 val)
+{
+	u64 flag = val & pg_level[level].mask;
+	u64 pa = val & PTE_RPN_MASK;
+
+	/* At first no level is set */
+	if (!st->level) {
+		st->level = level;
+		st->current_flags = flag;
+		st->start_address = addr;
+		st->start_pa = pa;
+		st->last_pa = pa;
+		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
+	/*
+	 * Dump the section of virtual memory when:
+	 *   - the PTE flags from one entry to the next differs.
+	 *   - we change levels in the tree.
+	 *   - the address is in a different section of memory and is thus
+	 *   used for a different purpose, regardless of the flags.
+	 *   - the pa of this page is not adjacent to the last inspected page
+	 */
+	} else if (flag != st->current_flags || level != st->level ||
+		   addr >= st->marker[1].start_address ||
+		   pa != st->last_pa + PAGE_SIZE) {
+
+		/* Check the PTE flags */
+		if (st->current_flags) {
+			dump_addr(st, addr);
+
+			/* Dump all the flags */
+			if (pg_level[st->level].flag)
+				dump_flag_info(st, pg_level[st->level].flag,
+					  st->current_flags,
+					  pg_level[st->level].num);
+
+			seq_putc(st->seq, '\n');
+		}
+
+		/*
+		 * Address indicates we have passed the end of the
+		 * current section of virtual memory
+		 */
+		while (addr >= st->marker[1].start_address) {
+			st->marker++;
+			seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
+		}
+		st->start_address = addr;
+		st->start_pa = pa;
+		st->last_pa = pa;
+		st->current_flags = flag;
+		st->level = level;
+	} else {
+		st->last_pa = pa;
+	}
+}
+
+static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
+{
+	pte_t *pte = pte_offset_kernel(pmd, 0);
+	unsigned long addr;
+	unsigned int i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++, pte++) {
+		addr = start + i * PAGE_SIZE;
+		note_page(st, addr, 4, pte_val(*pte));
+
+	}
+}
+
+static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
+{
+	pmd_t *pmd = pmd_offset(pud, 0);
+	unsigned long addr;
+	unsigned int i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
+		addr = start + i * PMD_SIZE;
+		if (!pmd_none(*pmd) && !pmd_huge(*pmd))
+			/* pmd exists */
+			walk_pte(st, pmd, addr);
+		else
+			note_page(st, addr, 3, pmd_val(*pmd));
+	}
+}
+
+static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
+{
+	pud_t *pud = pud_offset(pgd, 0);
+	unsigned long addr;
+	unsigned int i;
+
+	for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
+		addr = start + i * PUD_SIZE;
+		if (!pud_none(*pud) && !pud_huge(*pud))
+			/* pud exists */
+			walk_pmd(st, pud, addr);
+		else
+			note_page(st, addr, 2, pud_val(*pud));
+	}
+}
+
+static void walk_pagetables(struct pg_state *st)
+{
+	pgd_t *pgd = pgd_offset_k(0UL);
+	unsigned int i;
+	unsigned long addr;
+
+	addr = st->start_address;
+
+	/*
+	 * Traverse the linux pagetable structure and dump pages that are in
+	 * the hash pagetable.
+	 */
+	for (i = 0; i < PTRS_PER_PGD; i++, pgd++, addr += PGDIR_SIZE) {
+		if (!pgd_none(*pgd) && !pgd_huge(*pgd))
+			/* pgd exists */
+			walk_pud(st, pgd, addr);
+		else
+			note_page(st, addr, 1, pgd_val(*pgd));
+	}
+}
+
+static void populate_markers(void)
+{
+	int i = 0;
+
+	address_markers[i++].start_address = PAGE_OFFSET;
+	address_markers[i++].start_address = VMALLOC_START;
+	address_markers[i++].start_address = VMALLOC_END;
+#ifdef CONFIG_PPC64
+	address_markers[i++].start_address = ISA_IO_BASE;
+	address_markers[i++].start_address = ISA_IO_END;
+	address_markers[i++].start_address = PHB_IO_BASE;
+	address_markers[i++].start_address = PHB_IO_END;
+	address_markers[i++].start_address = IOREMAP_BASE;
+	address_markers[i++].start_address = IOREMAP_END;
+#ifdef CONFIG_PPC_BOOK3S_64
+	address_markers[i++].start_address =  H_VMEMMAP_BASE;
+#else
+	address_markers[i++].start_address =  VMEMMAP_BASE;
+#endif
+#else /* !CONFIG_PPC64 */
+	address_markers[i++].start_address = ioremap_bot;
+	address_markers[i++].start_address = IOREMAP_TOP;
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	address_markers[i++].start_address = IOREMAP_TOP;
+	address_markers[i++].start_address = IOREMAP_TOP +
+					     CONFIG_CONSISTENT_SIZE;
+#endif
+#ifdef CONFIG_HIGHMEM
+	address_markers[i++].start_address = PKMAP_BASE;
+	address_markers[i++].start_address = PKMAP_ADDR(LAST_PKMAP);
+#endif
+	address_markers[i++].start_address = FIXADDR_START;
+	address_markers[i++].start_address = FIXADDR_TOP;
+#endif /* CONFIG_PPC64 */
+}
+
+static int ptdump_show(struct seq_file *m, void *v)
+{
+	struct pg_state st = {
+		.seq = m,
+		.marker = address_markers,
+	};
+
+	if (radix_enabled())
+		st.start_address = PAGE_OFFSET;
+	else
+		st.start_address = KERN_VIRT_START;
+
+	/* Traverse kernel page tables */
+	walk_pagetables(&st);
+	note_page(&st, 0, 0, 0);
+	return 0;
+}
+
+
+static int ptdump_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ptdump_show, NULL);
+}
+
+static const struct file_operations ptdump_fops = {
+	.open		= ptdump_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static void build_pgtable_complete_mask(void)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
+		if (pg_level[i].flag)
+			for (j = 0; j < pg_level[i].num; j++)
+				pg_level[i].mask |= pg_level[i].flag[j].mask;
+}
+
+static int ptdump_init(void)
+{
+	struct dentry *debugfs_file;
+
+	populate_markers();
+	build_pgtable_complete_mask();
+	debugfs_file = debugfs_create_file("kernel_page_tables", 0400, NULL,
+			NULL, &ptdump_fops);
+	return debugfs_file ? 0 : -ENOMEM;
+}
+device_initcall(ptdump_init);
diff --git a/arch/powerpc/mm/ptdump/ptdump.h b/arch/powerpc/mm/ptdump/ptdump.h
new file mode 100644
index 000000000000..5d513636de73
--- /dev/null
+++ b/arch/powerpc/mm/ptdump/ptdump.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/types.h>
+
+struct flag_info {
+	u64		mask;
+	u64		val;
+	const char	*set;
+	const char	*clear;
+	bool		is_val;
+	int		shift;
+};
+
+struct pgtable_level {
+	const struct flag_info *flag;
+	size_t num;
+	u64 mask;
+};
+
+extern struct pgtable_level pg_level[5];
diff --git a/arch/powerpc/mm/ptdump/segment_regs.c b/arch/powerpc/mm/ptdump/segment_regs.c
new file mode 100644
index 000000000000..501843664bb9
--- /dev/null
+++ b/arch/powerpc/mm/ptdump/segment_regs.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018, Christophe Leroy CS S.I.
+ * <christophe.leroy@c-s.fr>
+ *
+ * This dumps the content of Segment Registers
+ */
+
+#include <asm/debugfs.h>
+
+static void seg_show(struct seq_file *m, int i)
+{
+	u32 val = mfsrin(i << 28);
+
+	seq_printf(m, "0x%01x0000000-0x%01xfffffff ", i, i);
+	seq_printf(m, "Kern key %d ", (val >> 30) & 1);
+	seq_printf(m, "User key %d ", (val >> 29) & 1);
+	if (val & 0x80000000) {
+		seq_printf(m, "Device 0x%03x", (val >> 20) & 0x1ff);
+		seq_printf(m, "-0x%05x", val & 0xfffff);
+	} else {
+		if (val & 0x10000000)
+			seq_puts(m, "No Exec ");
+		seq_printf(m, "VSID 0x%06x", val & 0xffffff);
+	}
+	seq_puts(m, "\n");
+}
+
+static int sr_show(struct seq_file *m, void *v)
+{
+	int i;
+
+	seq_puts(m, "---[ User Segments ]---\n");
+	for (i = 0; i < TASK_SIZE >> 28; i++)
+		seg_show(m, i);
+
+	seq_puts(m, "\n---[ Kernel Segments ]---\n");
+	for (; i < 16; i++)
+		seg_show(m, i);
+
+	return 0;
+}
+
+static int sr_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, sr_show, NULL);
+}
+
+static const struct file_operations sr_fops = {
+	.open		= sr_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init sr_init(void)
+{
+	struct dentry *debugfs_file;
+
+	debugfs_file = debugfs_create_file("segment_registers", 0400,
+					   powerpc_debugfs_root, NULL, &sr_fops);
+	return debugfs_file ? 0 : -ENOMEM;
+}
+device_initcall(sr_init);
diff --git a/arch/powerpc/mm/ptdump/shared.c b/arch/powerpc/mm/ptdump/shared.c
new file mode 100644
index 000000000000..1cda3d91c6c2
--- /dev/null
+++ b/arch/powerpc/mm/ptdump/shared.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * From split of dump_linuxpagetables.c
+ * Copyright 2016, Rashmica Gupta, IBM Corp.
+ *
+ */
+#include <linux/kernel.h>
+#include <asm/pgtable.h>
+
+#include "ptdump.h"
+
+static const struct flag_info flag_array[] = {
+	{
+		.mask	= _PAGE_USER,
+		.val	= _PAGE_USER,
+		.set	= "user",
+		.clear	= "    ",
+	}, {
+		.mask	= _PAGE_RW,
+		.val	= 0,
+		.set	= "r ",
+		.clear	= "rw",
+	}, {
+#ifndef CONFIG_PPC_BOOK3S_32
+		.mask	= _PAGE_EXEC,
+		.val	= _PAGE_EXEC,
+		.set	= " X ",
+		.clear	= "   ",
+	}, {
+#endif
+		.mask	= _PAGE_PRESENT,
+		.val	= _PAGE_PRESENT,
+		.set	= "present",
+		.clear	= "       ",
+	}, {
+		.mask	= _PAGE_GUARDED,
+		.val	= _PAGE_GUARDED,
+		.set	= "guarded",
+		.clear	= "       ",
+	}, {
+		.mask	= _PAGE_DIRTY,
+		.val	= _PAGE_DIRTY,
+		.set	= "dirty",
+		.clear	= "     ",
+	}, {
+		.mask	= _PAGE_ACCESSED,
+		.val	= _PAGE_ACCESSED,
+		.set	= "accessed",
+		.clear	= "        ",
+	}, {
+		.mask	= _PAGE_WRITETHRU,
+		.val	= _PAGE_WRITETHRU,
+		.set	= "write through",
+		.clear	= "             ",
+	}, {
+		.mask	= _PAGE_NO_CACHE,
+		.val	= _PAGE_NO_CACHE,
+		.set	= "no cache",
+		.clear	= "        ",
+	}, {
+		.mask	= _PAGE_SPECIAL,
+		.val	= _PAGE_SPECIAL,
+		.set	= "special",
+	}
+};
+
+struct pgtable_level pg_level[5] = {
+	{
+	}, { /* pgd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pud */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pmd */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	}, { /* pte */
+		.flag	= flag_array,
+		.num	= ARRAY_SIZE(flag_array),
+	},
+};
diff --git a/arch/powerpc/platforms/powermac/Makefile b/arch/powerpc/platforms/powermac/Makefile
index 561a67d65e4d..923bfb340433 100644
--- a/arch/powerpc/platforms/powermac/Makefile
+++ b/arch/powerpc/platforms/powermac/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS_bootx_init.o  		+= -fPIC
+CFLAGS_bootx_init.o  		+= $(call cc-option, -fno-stack-protector)
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 71ca064e3794..31fe56a90cbf 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -44,7 +44,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
 	 * initial apic id, which also represents 32-bit extended x2apic id.
 	 */
 	c->initial_apicid = edx;
-	smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 #endif
 	return 0;
 }
@@ -68,7 +68,8 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	 * Populate HT related information from sub-leaf level 0.
 	 */
 	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 
 	sub_index = 1;
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 7d372db8bee1..e33b732ad337 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -811,6 +811,14 @@ void __init fpu__init_system_xstate(void)
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
 	setup_xstate_comp();
+
+	/*
+	 * CPU capabilities initialization runs before FPU init. So
+	 * X86_FEATURE_OSXSAVE is not set. Now that XSAVE is completely
+	 * functional, set the feature bit so depending code works.
+	 */
+	setup_force_cpu_cap(X86_FEATURE_OSXSAVE);
+
 	print_xstate_offset_size();
 
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 560936617d9c..4a4160221183 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -32,7 +32,8 @@ int amiga_partition(struct parsed_partitions *state)
 	unsigned char *data;
 	struct RigidDiskBlock *rdb;
 	struct PartitionBlock *pb;
-	int start_sect, nr_sects, blk, part, res = 0;
+	sector_t start_sect, nr_sects;
+	int blk, part, res = 0;
 	int blksize = 1;	/* Multiplier for disk block size */
 	int slot = 1;
 	char b[BDEVNAME_SIZE];
@@ -100,14 +101,14 @@ int amiga_partition(struct parsed_partitions *state)
 
 		/* Tell Kernel about it */
 
-		nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
-			    be32_to_cpu(pb->pb_Environment[9])) *
+		nr_sects = ((sector_t)be32_to_cpu(pb->pb_Environment[10]) + 1 -
+			   be32_to_cpu(pb->pb_Environment[9])) *
 			   be32_to_cpu(pb->pb_Environment[3]) *
 			   be32_to_cpu(pb->pb_Environment[5]) *
 			   blksize;
 		if (!nr_sects)
 			continue;
-		start_sect = be32_to_cpu(pb->pb_Environment[9]) *
+		start_sect = (sector_t)be32_to_cpu(pb->pb_Environment[9]) *
 			     be32_to_cpu(pb->pb_Environment[3]) *
 			     be32_to_cpu(pb->pb_Environment[5]) *
 			     blksize;
diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 056acde5e7d3..4b9d68af090b 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -246,8 +246,8 @@ static int regmap_i2c_smbus_i2c_read(void *context, const void *reg,
 static struct regmap_bus regmap_i2c_smbus_i2c_block = {
 	.write = regmap_i2c_smbus_i2c_write,
 	.read = regmap_i2c_smbus_i2c_read,
-	.max_raw_read = I2C_SMBUS_BLOCK_MAX,
-	.max_raw_write = I2C_SMBUS_BLOCK_MAX,
+	.max_raw_read = I2C_SMBUS_BLOCK_MAX - 1,
+	.max_raw_write = I2C_SMBUS_BLOCK_MAX - 1,
 };
 
 static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 81ba4eb34890..09d369306ee3 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -200,6 +200,7 @@ static const struct dma_fence_ops timeline_fence_ops = {
  */
 static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
 {
+	LIST_HEAD(signalled);
 	struct sync_pt *pt, *next;
 
 	trace_sync_timeline(obj);
@@ -212,21 +213,20 @@ static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
 		if (!timeline_fence_signaled(&pt->base))
 			break;
 
-		list_del_init(&pt->link);
+		dma_fence_get(&pt->base);
+
+		list_move_tail(&pt->link, &signalled);
 		rb_erase(&pt->node, &obj->pt_tree);
 
-		/*
-		 * A signal callback may release the last reference to this
-		 * fence, causing it to be freed. That operation has to be
-		 * last to avoid a use after free inside this loop, and must
-		 * be after we remove the fence from the timeline in order to
-		 * prevent deadlocking on timeline->lock inside
-		 * timeline_fence_release().
-		 */
 		dma_fence_signal_locked(&pt->base);
 	}
 
 	spin_unlock_irq(&obj->lock);
+
+	list_for_each_entry_safe(pt, next, &signalled, link) {
+		list_del_init(&pt->link);
+		dma_fence_put(&pt->base);
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e667bcf64bc7..70e446c2acf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1502,15 +1502,15 @@ static int amdgpu_cs_wait_all_fences(struct amdgpu_device *adev,
 			continue;
 
 		r = dma_fence_wait_timeout(fence, true, timeout);
+		if (r > 0 && fence->error)
+			r = fence->error;
+
 		dma_fence_put(fence);
 		if (r < 0)
 			return r;
 
 		if (r == 0)
 			break;
-
-		if (fence->error)
-			return fence->error;
 	}
 
 	memset(wait, 0, sizeof(*wait));
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index ead221ccb93e..ddec675ba690 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2529,7 +2529,9 @@ static void dcn10_wait_for_mpcc_disconnect(
 		if (pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst]) {
 			struct hubp *hubp = get_hubp_by_inst(res_pool, mpcc_inst);
 
-			res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
+			if (pipe_ctx->stream_res.tg &&
+				pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg))
+				res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
 			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] = false;
 			hubp->funcs->set_blank(hubp, true);
 			/*DC_LOG_ERROR(dc->ctx->logger,
diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
index 1ae31dbc61c6..5e61abb3dce5 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -265,7 +265,8 @@ int radeon_cs_parser_init(struct radeon_cs_parser *p, void *data)
 {
 	struct drm_radeon_cs *cs = data;
 	uint64_t *chunk_array_ptr;
-	unsigned size, i;
+	u64 size;
+	unsigned i;
 	u32 ring = RADEON_CS_RING_GFX;
 	s32 priority = 0;
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c0ba8d6f4978..a9d6f8acf70b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -571,6 +571,7 @@
 #define USB_DEVICE_ID_UGCI_FIGHTING	0x0030
 
 #define USB_VENDOR_ID_HP		0x03f0
+#define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A		0x464a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A	0x0a4a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A	0x0b4a
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE		0x134a
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 8de294aa3184..a2ab338166e6 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -98,6 +98,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A293), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A), HID_QUIRK_ALWAYS_POLL },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_094A), HID_QUIRK_ALWAYS_POLL },
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index d08aeb41cd07..810e72e4e8b7 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -70,6 +70,7 @@ config IIO_TRIGGERED_EVENT
 
 source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
+source "drivers/iio/addac/Kconfig"
 source "drivers/iio/afe/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
 source "drivers/iio/chemical/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index cb5993251381..a60d0cbfe4cd 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_IIO_TRIGGERED_EVENT) += industrialio-triggered-event.o
 
 obj-y += accel/
 obj-y += adc/
+obj-y += addac/
 obj-y += afe/
 obj-y += amplifiers/
 obj-y += buffer/
diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 0662ca199eb0..49aeb76212fd 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -23,7 +23,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 #define STX104_OUT_CHAN(chan) {				\
 	.type = IIO_VOLTAGE,				\
@@ -52,14 +54,38 @@ static unsigned int num_stx104;
 module_param_hw_array(base, uint, ioport, &num_stx104, 0);
 MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
 
+/**
+ * struct stx104_reg - device register structure
+ * @ssr_ad:	Software Strobe Register and ADC Data
+ * @achan:	ADC Channel
+ * @dio:	Digital I/O
+ * @dac:	DAC Channels
+ * @cir_asr:	Clear Interrupts and ADC Status
+ * @acr:	ADC Control
+ * @pccr_fsh:	Pacer Clock Control and FIFO Status MSB
+ * @acfg:	ADC Configuration
+ */
+struct stx104_reg {
+	u16 ssr_ad;
+	u8 achan;
+	u8 dio;
+	u16 dac[2];
+	u8 cir_asr;
+	u8 acr;
+	u8 pccr_fsh;
+	u8 acfg;
+};
+
 /**
  * struct stx104_iio - IIO device private data structure
+ * @lock: synchronization lock to prevent I/O race conditions
  * @chan_out_states:	channels' output states
- * @base:		base port address of the IIO device
+ * @reg:		I/O address offset for the device registers
  */
 struct stx104_iio {
+	struct mutex lock;
 	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
-	unsigned int base;
+	struct stx104_reg __iomem *reg;
 };
 
 /**
@@ -72,7 +98,7 @@ struct stx104_iio {
 struct stx104_gpio {
 	struct gpio_chip chip;
 	spinlock_t lock;
-	unsigned int base;
+	u8 __iomem *base;
 	unsigned int out_state;
 };
 
@@ -80,6 +106,7 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
 	struct stx104_iio *const priv = iio_priv(indio_dev);
+	struct stx104_reg __iomem *const reg = priv->reg;
 	unsigned int adc_config;
 	int adbu;
 	int gain;
@@ -87,7 +114,7 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		/* get gain configuration */
-		adc_config = inb(priv->base + 11);
+		adc_config = ioread8(&reg->acfg);
 		gain = adc_config & 0x3;
 
 		*val = 1 << gain;
@@ -98,25 +125,31 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT;
 		}
 
+		mutex_lock(&priv->lock);
+
 		/* select ADC channel */
-		outb(chan->channel | (chan->channel << 4), priv->base + 2);
+		iowrite8(chan->channel | (chan->channel << 4), &reg->achan);
+
+		/* trigger ADC sample capture by writing to the 8-bit
+		 * Software Strobe Register and wait for completion
+		 */
+		iowrite8(0, &reg->ssr_ad);
+		while (ioread8(&reg->cir_asr) & BIT(7));
 
-		/* trigger ADC sample capture and wait for completion */
-		outb(0, priv->base);
-		while (inb(priv->base + 8) & BIT(7));
+		*val = ioread16(&reg->ssr_ad);
 
-		*val = inw(priv->base);
+		mutex_unlock(&priv->lock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		/* get ADC bipolar/unipolar configuration */
-		adc_config = inb(priv->base + 11);
+		adc_config = ioread8(&reg->acfg);
 		adbu = !(adc_config & BIT(2));
 
 		*val = -32768 * adbu;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* get ADC bipolar/unipolar and gain configuration */
-		adc_config = inb(priv->base + 11);
+		adc_config = ioread8(&reg->acfg);
 		adbu = !(adc_config & BIT(2));
 		gain = adc_config & 0x3;
 
@@ -138,16 +171,16 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 		/* Only four gain states (x1, x2, x4, x8) */
 		switch (val) {
 		case 1:
-			outb(0, priv->base + 11);
+			iowrite8(0, &priv->reg->acfg);
 			break;
 		case 2:
-			outb(1, priv->base + 11);
+			iowrite8(1, &priv->reg->acfg);
 			break;
 		case 4:
-			outb(2, priv->base + 11);
+			iowrite8(2, &priv->reg->acfg);
 			break;
 		case 8:
-			outb(3, priv->base + 11);
+			iowrite8(3, &priv->reg->acfg);
 			break;
 		default:
 			return -EINVAL;
@@ -160,9 +193,12 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 			if ((unsigned int)val > 65535)
 				return -EINVAL;
 
+			mutex_lock(&priv->lock);
+
 			priv->chan_out_states[chan->channel] = val;
-			outw(val, priv->base + 4 + 2 * chan->channel);
+			iowrite16(val, &priv->reg->dac[chan->channel]);
 
+			mutex_unlock(&priv->lock);
 			return 0;
 		}
 		return -EINVAL;
@@ -230,7 +266,7 @@ static int stx104_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	if (offset >= 4)
 		return -EINVAL;
 
-	return !!(inb(stx104gpio->base) & BIT(offset));
+	return !!(ioread8(stx104gpio->base) & BIT(offset));
 }
 
 static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
@@ -238,7 +274,7 @@ static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 {
 	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
 
-	*bits = inb(stx104gpio->base);
+	*bits = ioread8(stx104gpio->base);
 
 	return 0;
 }
@@ -260,7 +296,7 @@ static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	else
 		stx104gpio->out_state &= ~mask;
 
-	outb(stx104gpio->out_state, stx104gpio->base);
+	iowrite8(stx104gpio->out_state, stx104gpio->base);
 
 	spin_unlock_irqrestore(&stx104gpio->lock, flags);
 }
@@ -287,7 +323,7 @@ static void stx104_gpio_set_multiple(struct gpio_chip *chip,
 
 	stx104gpio->out_state &= ~*mask;
 	stx104gpio->out_state |= *mask & *bits;
-	outb(stx104gpio->out_state, stx104gpio->base);
+	iowrite8(stx104gpio->out_state, stx104gpio->base);
 
 	spin_unlock_irqrestore(&stx104gpio->lock, flags);
 }
@@ -314,11 +350,16 @@ static int stx104_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
+	priv = iio_priv(indio_dev);
+	priv->reg = devm_ioport_map(dev, base[id], STX104_EXTENT);
+	if (!priv->reg)
+		return -ENOMEM;
+
 	indio_dev->info = &stx104_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* determine if differential inputs */
-	if (inb(base[id] + 8) & BIT(5)) {
+	if (ioread8(&priv->reg->cir_asr) & BIT(5)) {
 		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_diff);
 		indio_dev->channels = stx104_channels_diff;
 	} else {
@@ -329,18 +370,17 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	indio_dev->name = dev_name(dev);
 	indio_dev->dev.parent = dev;
 
-	priv = iio_priv(indio_dev);
-	priv->base = base[id];
+	mutex_init(&priv->lock);
 
 	/* configure device for software trigger operation */
-	outb(0, base[id] + 9);
+	iowrite8(0, &priv->reg->acr);
 
 	/* initialize gain setting to x1 */
-	outb(0, base[id] + 11);
+	iowrite8(0, &priv->reg->acfg);
 
 	/* initialize DAC output to 0V */
-	outw(0, base[id] + 4);
-	outw(0, base[id] + 6);
+	iowrite16(0, &priv->reg->dac[0]);
+	iowrite16(0, &priv->reg->dac[1]);
 
 	stx104gpio->chip.label = dev_name(dev);
 	stx104gpio->chip.parent = dev;
@@ -355,7 +395,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	stx104gpio->chip.get_multiple = stx104_gpio_get_multiple;
 	stx104gpio->chip.set = stx104_gpio_set;
 	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
-	stx104gpio->base = base[id] + 3;
+	stx104gpio->base = &priv->reg->dio;
 	stx104gpio->out_state = 0x0;
 
 	spin_lock_init(&stx104gpio->lock);
diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
new file mode 100644
index 000000000000..2e64d7755d5e
--- /dev/null
+++ b/drivers/iio/addac/Kconfig
@@ -0,0 +1,8 @@
+#
+# ADC DAC drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Analog to digital and digital to analog converters"
+
+endmenu
diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
new file mode 100644
index 000000000000..b888b9ee12da
--- /dev/null
+++ b/drivers/iio/addac/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for industrial I/O ADDAC drivers
+#
+
+# When adding new entries keep the list in alphabetical order
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index f3985469c221..caebafed49bb 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -48,7 +48,7 @@ void __iomem *mips_gic_base;
 
 DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
 
-static DEFINE_SPINLOCK(gic_lock);
+static DEFINE_RAW_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
 static struct irq_domain *gic_ipi_domain;
 static int gic_shared_intrs;
@@ -207,7 +207,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 
 	irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_FALLING:
 		pol = GIC_POL_FALLING_EDGE;
@@ -247,7 +247,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	else
 		irq_set_chip_handler_name_locked(d, &gic_level_irq_controller,
 						 handle_level_irq, NULL);
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
 }
@@ -265,7 +265,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 		return -EINVAL;
 
 	/* Assumption : cpumask refers to a single CPU */
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 
 	/* Re-route this IRQ */
 	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
@@ -276,7 +276,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 		set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return IRQ_SET_MASK_OK;
 }
@@ -354,12 +354,12 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
 	cd = irq_data_get_irq_chip_data(d);
 	cd->mask = false;
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_rmask(BIT(intr));
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
 static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
@@ -372,32 +372,45 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
 	cd = irq_data_get_irq_chip_data(d);
 	cd->mask = true;
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_smask(BIT(intr));
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
-static void gic_all_vpes_irq_cpu_online(struct irq_data *d)
+static void gic_all_vpes_irq_cpu_online(void)
 {
-	struct gic_all_vpes_chip_data *cd;
-	unsigned int intr;
+	static const unsigned int local_intrs[] = {
+		GIC_LOCAL_INT_TIMER,
+		GIC_LOCAL_INT_PERFCTR,
+		GIC_LOCAL_INT_FDC,
+	};
+	unsigned long flags;
+	int i;
 
-	intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
-	cd = irq_data_get_irq_chip_data(d);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 
-	write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
-	if (cd->mask)
-		write_gic_vl_smask(BIT(intr));
+	for (i = 0; i < ARRAY_SIZE(local_intrs); i++) {
+		unsigned int intr = local_intrs[i];
+		struct gic_all_vpes_chip_data *cd;
+
+		if (!gic_local_irq_is_routable(intr))
+			continue;
+		cd = &gic_all_vpes_chip_data[intr];
+		write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
+		if (cd->mask)
+			write_gic_vl_smask(BIT(intr));
+	}
+
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 }
 
 static struct irq_chip gic_all_vpes_local_irq_controller = {
 	.name			= "MIPS GIC Local",
 	.irq_mask		= gic_mask_local_irq_all_vpes,
 	.irq_unmask		= gic_unmask_local_irq_all_vpes,
-	.irq_cpu_online		= gic_all_vpes_irq_cpu_online,
 };
 
 static void __gic_irq_dispatch(void)
@@ -421,11 +434,11 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
 
 	data = irq_get_irq_data(virq);
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
 	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
 	irq_data_update_effective_affinity(data, cpumask_of(cpu));
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
 }
@@ -476,6 +489,10 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	intr = GIC_HWIRQ_TO_LOCAL(hwirq);
 	map = GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
 
+	/*
+	 * If adding support for more per-cpu interrupts, keep the the
+	 * array in gic_all_vpes_irq_cpu_online() in sync.
+	 */
 	switch (intr) {
 	case GIC_LOCAL_INT_TIMER:
 		/* CONFIG_MIPS_CMP workaround (see __gic_init) */
@@ -514,12 +531,12 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	if (!gic_local_irq_is_routable(intr))
 		return -EPERM;
 
-	spin_lock_irqsave(&gic_lock, flags);
+	raw_spin_lock_irqsave(&gic_lock, flags);
 	for_each_online_cpu(cpu) {
 		write_gic_vl_other(mips_cm_vp_id(cpu));
 		write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
 	}
-	spin_unlock_irqrestore(&gic_lock, flags);
+	raw_spin_unlock_irqrestore(&gic_lock, flags);
 
 	return 0;
 }
@@ -662,8 +679,8 @@ static int gic_cpu_startup(unsigned int cpu)
 	/* Clear all local IRQ masks (ie. disable all local interrupts) */
 	write_gic_vl_rmask(~0);
 
-	/* Invoke irq_cpu_online callbacks to enable desired interrupts */
-	irq_cpu_online();
+	/* Enable desired interrupts */
+	gic_all_vpes_irq_cpu_online();
 
 	return 0;
 }
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 0a4e440948f0..234464c1c050 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -29,11 +29,11 @@
 #define DEFAULT_BUFFER_SECTORS		128
 #define DEFAULT_JOURNAL_WATERMARK	50
 #define DEFAULT_SYNC_MSEC		10000
-#define DEFAULT_MAX_JOURNAL_SECTORS	131072
+#define DEFAULT_MAX_JOURNAL_SECTORS	(IS_ENABLED(CONFIG_64BIT) ? 131072 : 8192)
 #define MIN_LOG2_INTERLEAVE_SECTORS	3
 #define MAX_LOG2_INTERLEAVE_SECTORS	31
 #define METADATA_WORKQUEUE_MAX_ACTIVE	16
-#define RECALC_SECTORS			8192
+#define RECALC_SECTORS			(IS_ENABLED(CONFIG_64BIT) ? 32768 : 2048)
 #define RECALC_WRITE_SUPER		16
 
 /*
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 6ad408514a99..193a1f800a22 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -766,6 +766,8 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
 		return -EINVAL;
 
 	if (*nplanes) {
+		if (*nplanes != q_data->fmt->num_planes)
+			return -EINVAL;
 		for (i = 0; i < *nplanes; i++)
 			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;
diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index 9b57fb285728..46ec1f2699aa 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -537,16 +537,18 @@ static int load_requested_vpu(struct mtk_vpu *vpu,
 int vpu_load_firmware(struct platform_device *pdev)
 {
 	struct mtk_vpu *vpu;
-	struct device *dev = &pdev->dev;
+	struct device *dev;
 	struct vpu_run *run;
 	const struct firmware *vpu_fw = NULL;
 	int ret;
 
 	if (!pdev) {
-		dev_err(dev, "VPU platform device is invalid\n");
+		pr_err("VPU platform device is invalid\n");
 		return -EINVAL;
 	}
 
+	dev = &pdev->dev;
+
 	vpu = platform_get_drvdata(pdev);
 	run = &vpu->run;
 
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 88114e576efb..039058fe6a41 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1976,15 +1976,16 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
 	mmc_blk_urgent_bkops(mq, mqrq);
 }
 
-static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq,
+				     struct request_queue *q,
+				     enum mmc_issue_type issue_type)
 {
-	struct request_queue *q = req->q;
 	unsigned long flags;
 	bool put_card;
 
 	spin_lock_irqsave(q->queue_lock, flags);
 
-	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
+	mq->in_flight[issue_type] -= 1;
 
 	put_card = (mmc_tot_in_flight(mq) == 0);
 
@@ -1996,9 +1997,11 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
 
 static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 {
+	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_request *mrq = &mqrq->brq.mrq;
 	struct mmc_host *host = mq->card->host;
+	struct request_queue *q = req->q;
 
 	mmc_post_req(host, mrq, 0);
 
@@ -2011,7 +2014,7 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 	else
 		blk_mq_complete_request(req);
 
-	mmc_blk_mq_dec_in_flight(mq, req);
+	mmc_blk_mq_dec_in_flight(mq, q, issue_type);
 }
 
 void mmc_blk_mq_recovery(struct mmc_queue *mq)
diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 5301302fb531..2b3ff4be7ae0 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1417,9 +1417,8 @@ static int bcm2835_probe(struct platform_device *pdev)
 	host->max_clk = clk_get_rate(clk);
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		dev_err(dev, "get IRQ failed\n");
-		ret = -EINVAL;
+	if (host->irq < 0) {
+		ret = host->irq;
 		goto err;
 	}
 
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 864338e308e2..b8fb518c6db0 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1060,7 +1060,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
 		ret = host->irq;
-		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
 		goto err_free_host;
 	}
 
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index dba98c2886f2..28f07d410043 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -26,7 +26,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/ioport.h>
-#include <linux/spinlock.h>
 #include <linux/dma-mapping.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -159,7 +158,6 @@ struct meson_host {
 	struct	mmc_host	*mmc;
 	struct	mmc_command	*cmd;
 
-	spinlock_t lock;
 	void __iomem *regs;
 	struct clk *core_clk;
 	struct clk *mmc_clk;
@@ -1042,8 +1040,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (WARN_ON(!host) || WARN_ON(!host->cmd))
 		return IRQ_NONE;
 
-	spin_lock(&host->lock);
-
 	cmd = host->cmd;
 	data = cmd->data;
 	cmd->error = 0;
@@ -1071,11 +1067,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS)) {
 		if (data && !cmd->error)
 			data->bytes_xfered = data->blksz * data->blocks;
-		if (meson_mmc_bounce_buf_read(data) ||
-		    meson_mmc_get_next_command(cmd))
-			ret = IRQ_WAKE_THREAD;
-		else
-			ret = IRQ_HANDLED;
+
+		return IRQ_WAKE_THREAD;
 	}
 
 out:
@@ -1090,10 +1083,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 		writel(start, host->regs + SD_EMMC_START);
 	}
 
-	if (ret == IRQ_HANDLED)
-		meson_mmc_request_done(host->mmc, cmd->mrq);
-
-	spin_unlock(&host->lock);
 	return ret;
 }
 
@@ -1246,8 +1235,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	host->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, host);
 
-	spin_lock_init(&host->lock);
-
 	/* Get regulators and the supported OCR mask */
 	host->vqmmc_enabled = false;
 	ret = mmc_regulator_get_supply(mmc);
@@ -1285,7 +1272,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq <= 0) {
-		dev_err(&pdev->dev, "failed to get interrupt resource.\n");
 		ret = -EINVAL;
 		goto free_host;
 	}
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 6215feb976e3..a0e8ac912445 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1017,10 +1017,8 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
 	if (!mmc)
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index eabfcb5bbaff..a2c44cc8e2e7 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -155,6 +155,66 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	return ret == 0 ? best_freq : clk_get_rate(priv->clk);
 }
 
+static void renesas_sdhi_clk_start(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		usleep_range(10000, 11000);
+}
+
+static void renesas_sdhi_clk_stop(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		usleep_range(10000, 11000);
+}
+
+static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
+				   unsigned int new_clock)
+{
+	u32 clk = 0, clock;
+
+	if (new_clock == 0) {
+		renesas_sdhi_clk_stop(host);
+		return;
+	}
+	/*
+	 * Both HS400 and HS200/SD104 set 200MHz, but some devices need to
+	 * set 400MHz to distinguish the CPG settings in HS400.
+	 */
+	if (host->mmc->ios.timing == MMC_TIMING_MMC_HS400 &&
+	    host->pdata->flags & TMIO_MMC_HAVE_4TAP_HS400 &&
+	    new_clock == 200000000)
+		new_clock = 400000000;
+
+	clock = renesas_sdhi_clk_update(host, new_clock) / 512;
+
+	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
+		clock <<= 1;
+
+	/* 1/1 clock is option */
+	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) && ((clk >> 22) & 0x1)) {
+		if (!(host->mmc->ios.timing == MMC_TIMING_MMC_HS400))
+			clk |= 0xff;
+		else
+			clk &= ~0xff;
+	}
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
+	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
+		usleep_range(10000, 11000);
+
+	renesas_sdhi_clk_start(host);
+}
+
 static void renesas_sdhi_clk_disable(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
@@ -621,8 +681,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	host->write16_hook	= renesas_sdhi_write16_hook;
 	host->clk_enable	= renesas_sdhi_clk_enable;
-	host->clk_update	= renesas_sdhi_clk_update;
 	host->clk_disable	= renesas_sdhi_clk_disable;
+	host->set_clock		= renesas_sdhi_set_clock;
 	host->multi_io_quirk	= renesas_sdhi_multi_io_quirk;
 	host->dma_ops		= dma_ops;
 
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index f77493604312..ca2239ea6d96 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1661,7 +1661,6 @@ static int s3cmci_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq <= 0) {
-		dev_err(&pdev->dev, "failed to get interrupt resource.\n");
 		ret = -EINVAL;
 		goto probe_iounmap;
 	}
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4970cd40813b..feede31fab47 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1914,8 +1914,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	/* Setup IRQ for handling power/voltage tasks with PMIC */
 	msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
 	if (msm_host->pwr_irq < 0) {
-		dev_err(&pdev->dev, "Get pwr_irq failed (%d)\n",
-			msm_host->pwr_irq);
 		ret = msm_host->pwr_irq;
 		goto clk_disable;
 	}
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 02bea6159d79..ac380c54bd17 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -131,7 +131,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ number\n");
 		ret = irq;
 		goto err;
 	}
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 9ef89d00970e..936d88a33a67 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -493,10 +493,8 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq specified\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	host = sdhci_alloc_host(dev, sizeof(struct sdhci_s3c));
 	if (IS_ERR(host)) {
diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index ca9e05440da1..ee8160d6015e 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -122,10 +122,8 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	u32 reg = 0;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "%s: no irq specified\n", __func__);
+	if (irq < 0)
 		return irq;
-	}
 
 	host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
 	if (IS_ERR(host))
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 757eb175611f..bc3f8a1df10c 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1308,8 +1308,8 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		return ret;
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		ret = -EINVAL;
+	if (host->irq < 0) {
+		ret = host->irq;
 		goto error_disable_mmc;
 	}
 
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 43a2ea5cff24..b031a776c12e 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -13,6 +13,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/tmio.h>
@@ -23,6 +24,52 @@
 
 #include "tmio_mmc.h"
 
+static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	usleep_range(10000, 11000);
+	sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
+	usleep_range(10000, 11000);
+}
+
+static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
+	usleep_range(10000, 11000);
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	usleep_range(10000, 11000);
+}
+
+static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
+			       unsigned int new_clock)
+{
+	u32 clk = 0, clock;
+
+	if (new_clock == 0) {
+		tmio_mmc_clk_stop(host);
+		return;
+	}
+
+	clock = host->mmc->f_min;
+
+	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
+		clock <<= 1;
+
+	host->pdata->set_clk_div(host->pdev, (clk >> 22) & 1);
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
+	usleep_range(10000, 11000);
+
+	tmio_mmc_clk_start(host);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int tmio_mmc_suspend(struct device *dev)
 {
@@ -100,6 +147,7 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 
 	/* SD control register space size is 0x200, 0x400 for bus_shift=1 */
 	host->bus_shift = resource_size(res) >> 10;
+	host->set_clock = tmio_mmc_set_clock;
 
 	host->mmc->f_max = pdata->hclk;
 	host->mmc->f_min = pdata->hclk / 512;
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 7c40a7e1fea1..358aa258cb15 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -133,7 +133,6 @@ struct tmio_mmc_host {
 
 	/* Callbacks for clock / power control */
 	void (*set_pwr)(struct platform_device *host, int state);
-	void (*set_clk_div)(struct platform_device *host, int state);
 
 	/* pio related stuff */
 	struct scatterlist      *sg_ptr;
@@ -170,10 +169,9 @@ struct tmio_mmc_host {
 
 	/* Mandatory callback */
 	int (*clk_enable)(struct tmio_mmc_host *host);
+	void (*set_clock)(struct tmio_mmc_host *host, unsigned int clock);
 
 	/* Optional callbacks */
-	unsigned int (*clk_update)(struct tmio_mmc_host *host,
-				   unsigned int new_clock);
 	void (*clk_disable)(struct tmio_mmc_host *host);
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 33c9ca8f14a9..f819757e125e 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -161,83 +161,6 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
-static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
-{
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-
-	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
-	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
-		usleep_range(10000, 11000);
-
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
-		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
-		usleep_range(10000, 11000);
-	}
-}
-
-static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
-{
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
-		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
-		usleep_range(10000, 11000);
-	}
-
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-
-	/* HW engineers overrode docs: no sleep needed on R-Car2+ */
-	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
-		usleep_range(10000, 11000);
-}
-
-static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
-			       unsigned int new_clock)
-{
-	u32 clk = 0, clock;
-
-	if (new_clock == 0) {
-		tmio_mmc_clk_stop(host);
-		return;
-	}
-	/*
-	 * Both HS400 and HS200/SD104 set 200MHz, but some devices need to
-	 * set 400MHz to distinguish the CPG settings in HS400.
-	 */
-	if (host->mmc->ios.timing == MMC_TIMING_MMC_HS400 &&
-	    host->pdata->flags & TMIO_MMC_HAVE_4TAP_HS400 &&
-	    new_clock == 200000000)
-		new_clock = 400000000;
-
-	if (host->clk_update)
-		clock = host->clk_update(host, new_clock) / 512;
-	else
-		clock = host->mmc->f_min;
-
-	for (clk = 0x80000080; new_clock >= (clock << 1); clk >>= 1)
-		clock <<= 1;
-
-	/* 1/1 clock is option */
-	if ((host->pdata->flags & TMIO_MMC_CLK_ACTUAL) &&
-	    ((clk >> 22) & 0x1)) {
-		if (!(host->mmc->ios.timing == MMC_TIMING_MMC_HS400))
-			clk |= 0xff;
-		else
-			clk &= ~0xff;
-	}
-
-	if (host->set_clk_div)
-		host->set_clk_div(host->pdev, (clk >> 22) & 1);
-
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
-			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
-	if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
-		usleep_range(10000, 11000);
-
-	tmio_mmc_clk_start(host);
-}
-
 static void tmio_mmc_reset(struct tmio_mmc_host *host)
 {
 	/* FIXME - should we set stop clock reg here */
@@ -1051,15 +974,15 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		tmio_mmc_power_off(host);
-		tmio_mmc_clk_stop(host);
+		host->set_clock(host, 0);
 		break;
 	case MMC_POWER_UP:
 		tmio_mmc_power_on(host, ios->vdd);
-		tmio_mmc_set_clock(host, ios->clock);
+		host->set_clock(host, ios->clock);
 		tmio_mmc_set_bus_width(host, ios->bus_width);
 		break;
 	case MMC_POWER_ON:
-		tmio_mmc_set_clock(host, ios->clock);
+		host->set_clock(host, ios->clock);
 		tmio_mmc_set_bus_width(host, ios->bus_width);
 		break;
 	}
@@ -1245,7 +1168,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	int ret;
 
 	/*
-	 * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
+	 * Check the sanity of mmc->f_min to prevent host->set_clock() from
 	 * looping forever...
 	 */
 	if (mmc->f_min == 0)
@@ -1255,7 +1178,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 		_host->write16_hook = NULL;
 
 	_host->set_pwr = pdata->set_pwr;
-	_host->set_clk_div = pdata->set_clk_div;
 
 	ret = tmio_mmc_init_ocr(_host);
 	if (ret < 0)
@@ -1318,7 +1240,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		_host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
 
-	tmio_mmc_clk_stop(_host);
+	_host->set_clock(_host, 0);
 	tmio_mmc_reset(_host);
 
 	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
@@ -1402,7 +1324,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
 	if (host->clk_cache)
-		tmio_mmc_clk_stop(host);
+		host->set_clock(host, 0);
 
 	tmio_mmc_clk_disable(host);
 
@@ -1423,7 +1345,7 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 	tmio_mmc_clk_enable(host);
 
 	if (host->clk_cache)
-		tmio_mmc_set_clock(host, host->clk_cache);
+		host->set_clock(host, host->clk_cache);
 
 	if (host->native_hotplug)
 		tmio_mmc_enable_mmc_irqs(host,
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 9b15431d961c..1df3ea9e5d6f 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1713,8 +1713,6 @@ static int wbsd_init(struct device *dev, int base, int irq, int dma,
 
 		wbsd_release_resources(host);
 		wbsd_free_mmc(dev);
-
-		mmc_free_host(mmc);
 		return ret;
 	}
 
diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 3fc439d92445..e03f4883858a 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -671,10 +671,10 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
 		return NULL;
 	arp = (struct arp_pkt *)skb_network_header(skb);
 
-	/* Don't modify or load balance ARPs that do not originate locally
-	 * (e.g.,arrive via a bridge).
+	/* Don't modify or load balance ARPs that do not originate
+	 * from the bond itself or a VLAN directly above the bond.
 	 */
-	if (!bond_slave_has_mac_rx(bond, arp->mac_src))
+	if (!bond_slave_has_mac_rcu(bond, arp->mac_src))
 		return NULL;
 
 	if (arp->op_code == htons(ARPOP_REPLY)) {
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 75a1915d95aa..23997f1c2619 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -209,7 +209,7 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)
 	unsigned long offset;
 
 	for (offset = 0; offset < length; offset += SMP_CACHE_BYTES)
-		asm("dcbfl %0,%1" :: "b" (addr), "r" (offset));
+		asm("dcbf %0,%1,1" :: "b" (addr), "r" (offset));
 }
 
 /* replenish the buffers for a pool.  note that we don't need to
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 0299e5bbb902..10e9e60f6cf7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -210,11 +210,11 @@ static i40e_status i40e_read_nvm_word_srctl(struct i40e_hw *hw, u16 offset,
  * @hw: pointer to the HW structure.
  * @module_pointer: module pointer location in words from the NVM beginning
  * @offset: offset in words from module start
- * @words: number of words to write
- * @data: buffer with words to write to the Shadow RAM
+ * @words: number of words to read
+ * @data: buffer with words to read to the Shadow RAM
  * @last_command: tells the AdminQ that this is the last command
  *
- * Writes a 16 bit words buffer to the Shadow RAM using the admin command.
+ * Reads a 16 bit words buffer to the Shadow RAM using the admin command.
  **/
 static i40e_status i40e_read_nvm_aq(struct i40e_hw *hw,
 				    u8 module_pointer, u32 offset,
@@ -234,18 +234,18 @@ static i40e_status i40e_read_nvm_aq(struct i40e_hw *hw,
 	 */
 	if ((offset + words) > hw->nvm.sr_size)
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write error: offset %d beyond Shadow RAM limit %d\n",
+			   "NVM read error: offset %d beyond Shadow RAM limit %d\n",
 			   (offset + words), hw->nvm.sr_size);
 	else if (words > I40E_SR_SECTOR_SIZE_IN_WORDS)
-		/* We can write only up to 4KB (one sector), in one AQ write */
+		/* We can read only up to 4KB (one sector), in one AQ write */
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write fail error: tried to write %d words, limit is %d.\n",
+			   "NVM read fail error: tried to read %d words, limit is %d.\n",
 			   words, I40E_SR_SECTOR_SIZE_IN_WORDS);
 	else if (((offset + (words - 1)) / I40E_SR_SECTOR_SIZE_IN_WORDS)
 		 != (offset / I40E_SR_SECTOR_SIZE_IN_WORDS))
-		/* A single write cannot spread over two sectors */
+		/* A single read cannot spread over two sectors */
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write error: cannot spread over two sectors in a single write offset=%d words=%d\n",
+			   "NVM read error: cannot spread over two sectors in a single read offset=%d words=%d\n",
 			   offset, words);
 	else
 		ret_code = i40e_aq_read_nvm(hw, module_pointer,
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 29ced6b74d36..be2e743e65de 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1181,18 +1181,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		return;
 	}
 
-	spin_lock_init(&adapter->tmreg_lock);
-	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
-
-	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
-		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
-				  igb_ptp_overflow_check);
-
-	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
-	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
-
-	igb_ptp_reset(adapter);
-
 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
 						&adapter->pdev->dev);
 	if (IS_ERR(adapter->ptp_clock)) {
@@ -1202,6 +1190,18 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		dev_info(&adapter->pdev->dev, "added PHC on %s\n",
 			 adapter->netdev->name);
 		adapter->ptp_flags |= IGB_PTP_ENABLED;
+
+		spin_lock_init(&adapter->tmreg_lock);
+		INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
+
+		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+			INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
+					  igb_ptp_overflow_check);
+
+		adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+		adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
+
+		igb_ptp_reset(adapter);
 	}
 }
 
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 94622d119abc..49fb62d02a76 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -421,6 +421,17 @@ static int bcm5482_read_status(struct phy_device *phydev)
 	return err;
 }
 
+static int bcm54810_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
+{
+	return -EOPNOTSUPP;
+}
+
+static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
+			      u16 val)
+{
+	return -EOPNOTSUPP;
+}
+
 static int bcm5481_config_aneg(struct phy_device *phydev)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
@@ -684,6 +695,8 @@ static struct phy_driver broadcom_drivers[] = {
 	.name           = "Broadcom BCM54810",
 	.features       = PHY_GBIT_FEATURES,
 	.flags          = PHY_HAS_INTERRUPT,
+	.read_mmd	= bcm54810_read_mmd,
+	.write_mmd	= bcm54810_write_mmd,
 	.config_init    = bcm54xx_config_init,
 	.config_aneg    = bcm5481_config_aneg,
 	.ack_interrupt  = bcm_phy_ack_intr,
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index d80bc5f59b3f..8b5e1ec6aabf 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2168,7 +2168,9 @@ static void team_setup(struct net_device *dev)
 
 	dev->hw_features = TEAM_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
-			   NETIF_F_HW_VLAN_CTAG_FILTER;
+			   NETIF_F_HW_VLAN_CTAG_FILTER |
+			   NETIF_F_HW_VLAN_STAG_RX |
+			   NETIF_F_HW_VLAN_STAG_FILTER;
 
 	dev->hw_features |= NETIF_F_GSO_ENCAP_ALL | NETIF_F_GSO_UDP_L4;
 	dev->features |= dev->hw_features;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 03e0f8060cc2..331d74f9281b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3120,8 +3120,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		}
 	}
 
-	_virtnet_set_queues(vi, vi->curr_queue_pairs);
-
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -3134,6 +3132,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 3d8844e7090a..72a289d73dfc 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -510,12 +510,15 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 				if (pass && dev->subordinate) {
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
-					__pci_bus_size_bridges(dev->subordinate,
-							       &add_list);
+					if (pci_is_root_bus(bus))
+						__pci_bus_size_bridges(dev->subordinate, &add_list);
 				}
 			}
 		}
-		__pci_bus_assign_resources(bus, &add_list, NULL);
+		if (pci_is_root_bus(bus))
+			__pci_bus_assign_resources(bus, &add_list, NULL);
+		else
+			pci_assign_unassigned_bridge_resources(bus->self);
 	}
 
 	acpiphp_sanitize_bus(bus);
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 123420cac6b5..b75b12c2c702 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -1056,6 +1056,8 @@ static void nonstatic_release_resource_db(struct pcmcia_socket *s)
 		q = p->next;
 		kfree(p);
 	}
+
+	kfree(data);
 }
 
 
diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index cd0aba0d58b2..cd7912e34dcd 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -210,54 +210,6 @@ raid_attr_ro_state(level);
 raid_attr_ro_fn(resync);
 raid_attr_ro_state_fn(state);
 
-static void raid_component_release(struct device *dev)
-{
-	struct raid_component *rc =
-		container_of(dev, struct raid_component, dev);
-	dev_printk(KERN_ERR, rc->dev.parent, "COMPONENT RELEASE\n");
-	put_device(rc->dev.parent);
-	kfree(rc);
-}
-
-int raid_component_add(struct raid_template *r,struct device *raid_dev,
-		       struct device *component_dev)
-{
-	struct device *cdev =
-		attribute_container_find_class_device(&r->raid_attrs.ac,
-						      raid_dev);
-	struct raid_component *rc;
-	struct raid_data *rd = dev_get_drvdata(cdev);
-	int err;
-
-	rc = kzalloc(sizeof(*rc), GFP_KERNEL);
-	if (!rc)
-		return -ENOMEM;
-
-	INIT_LIST_HEAD(&rc->node);
-	device_initialize(&rc->dev);
-	rc->dev.release = raid_component_release;
-	rc->dev.parent = get_device(component_dev);
-	rc->num = rd->component_count++;
-
-	dev_set_name(&rc->dev, "component-%d", rc->num);
-	list_add_tail(&rc->node, &rd->component_list);
-	rc->dev.class = &raid_class.class;
-	err = device_add(&rc->dev);
-	if (err)
-		goto err_out;
-
-	return 0;
-
-err_out:
-	put_device(&rc->dev);
-	list_del(&rc->node);
-	rd->component_count--;
-	put_device(component_dev);
-	kfree(rc);
-	return err;
-}
-EXPORT_SYMBOL(raid_component_add);
-
 struct raid_template *
 raid_class_attach(struct raid_function_template *ft)
 {
diff --git a/drivers/scsi/snic/snic_disc.c b/drivers/scsi/snic/snic_disc.c
index 388ba2ebcce5..02b80291c136 100644
--- a/drivers/scsi/snic/snic_disc.c
+++ b/drivers/scsi/snic/snic_disc.c
@@ -316,12 +316,11 @@ snic_tgt_create(struct snic *snic, struct snic_tgt_id *tgtid)
 			      "Snic Tgt: device_add, with err = %d\n",
 			      ret);
 
-		put_device(&tgt->dev);
 		put_device(&snic->shost->shost_gendev);
 		spin_lock_irqsave(snic->shost->host_lock, flags);
 		list_del(&tgt->list);
 		spin_unlock_irqrestore(snic->shost->host_lock, flags);
-		kfree(tgt);
+		put_device(&tgt->dev);
 		tgt = NULL;
 
 		return tgt;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 66de3a59f577..d3161be35b1b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3224,6 +3224,7 @@ void serial8250_init_port(struct uart_8250_port *up)
 	struct uart_port *port = &up->port;
 
 	spin_lock_init(&port->lock);
+	port->pm = NULL;
 	port->ops = &serial8250_pops;
 
 	up->cur_iotype = 0xFF;
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 36321d810d36..af23d41b9843 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2136,6 +2136,8 @@ static int __init lpuart32_imx_early_console_setup(struct earlycon_device *devic
 OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_setup);
+OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8ulp-lpuart", lpuart32_imx_early_console_setup);
+OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8qxp-lpuart", lpuart32_imx_early_console_setup);
 EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
 EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
 
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 58e1bc3a77d8..0f090188e265 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -176,55 +176,58 @@ static int dwc3_qcom_register_extcon(struct dwc3_qcom *qcom)
 /* Only usable in contexts where the role can not change. */
 static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 {
-	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
+	struct dwc3 *dwc;
+
+	/*
+	 * FIXME: Fix this layering violation.
+	 */
+	dwc = platform_get_drvdata(qcom->dwc3);
+
+	/* Core driver may not have probed yet. */
+	if (!dwc)
+		return false;
 
 	return dwc->xhci;
 }
 
+static void dwc3_qcom_enable_wakeup_irq(int irq)
+{
+	if (!irq)
+		return;
+
+	enable_irq(irq);
+	enable_irq_wake(irq);
+}
+
+static void dwc3_qcom_disable_wakeup_irq(int irq)
+{
+	if (!irq)
+		return;
+
+	disable_irq_wake(irq);
+	disable_irq_nosync(irq);
+}
+
 static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 {
-	if (qcom->hs_phy_irq) {
-		disable_irq_wake(qcom->hs_phy_irq);
-		disable_irq_nosync(qcom->hs_phy_irq);
-	}
+	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
 
-	if (qcom->dp_hs_phy_irq) {
-		disable_irq_wake(qcom->dp_hs_phy_irq);
-		disable_irq_nosync(qcom->dp_hs_phy_irq);
-	}
+	dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
 
-	if (qcom->dm_hs_phy_irq) {
-		disable_irq_wake(qcom->dm_hs_phy_irq);
-		disable_irq_nosync(qcom->dm_hs_phy_irq);
-	}
+	dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
 
-	if (qcom->ss_phy_irq) {
-		disable_irq_wake(qcom->ss_phy_irq);
-		disable_irq_nosync(qcom->ss_phy_irq);
-	}
+	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq);
 }
 
 static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 {
-	if (qcom->hs_phy_irq) {
-		enable_irq(qcom->hs_phy_irq);
-		enable_irq_wake(qcom->hs_phy_irq);
-	}
+	dwc3_qcom_enable_wakeup_irq(qcom->hs_phy_irq);
 
-	if (qcom->dp_hs_phy_irq) {
-		enable_irq(qcom->dp_hs_phy_irq);
-		enable_irq_wake(qcom->dp_hs_phy_irq);
-	}
+	dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq);
 
-	if (qcom->dm_hs_phy_irq) {
-		enable_irq(qcom->dm_hs_phy_irq);
-		enable_irq_wake(qcom->dm_hs_phy_irq);
-	}
+	dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq);
 
-	if (qcom->ss_phy_irq) {
-		enable_irq(qcom->ss_phy_irq);
-		enable_irq_wake(qcom->ss_phy_irq);
-	}
+	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq);
 }
 
 static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
diff --git a/drivers/video/fbdev/core/sysimgblt.c b/drivers/video/fbdev/core/sysimgblt.c
index a4d05b1b17d7..665ef7a0a249 100644
--- a/drivers/video/fbdev/core/sysimgblt.c
+++ b/drivers/video/fbdev/core/sysimgblt.c
@@ -188,23 +188,29 @@ static void fast_imageblit(const struct fb_image *image, struct fb_info *p,
 {
 	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
 	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
-	u32 bit_mask, end_mask, eorx, shift;
-	const char *s = image->data, *src;
+	u32 bit_mask, eorx, shift;
+	const u8 *s = image->data, *src;
 	u32 *dst;
-	const u32 *tab = NULL;
+	const u32 *tab;
+	size_t tablen;
+	u32 colortab[16];
 	int i, j, k;
 
 	switch (bpp) {
 	case 8:
 		tab = fb_be_math(p) ? cfb_tab8_be : cfb_tab8_le;
+		tablen = 16;
 		break;
 	case 16:
 		tab = fb_be_math(p) ? cfb_tab16_be : cfb_tab16_le;
+		tablen = 4;
 		break;
 	case 32:
-	default:
 		tab = cfb_tab32;
+		tablen = 2;
 		break;
+	default:
+		return;
 	}
 
 	for (i = ppw-1; i--; ) {
@@ -218,20 +224,62 @@ static void fast_imageblit(const struct fb_image *image, struct fb_info *p,
 	eorx = fgx ^ bgx;
 	k = image->width/ppw;
 
+	for (i = 0; i < tablen; ++i)
+		colortab[i] = (tab[i] & eorx) ^ bgx;
+
 	for (i = image->height; i--; ) {
 		dst = dst1;
 		shift = 8;
 		src = s;
 
-		for (j = k; j--; ) {
+		/*
+		 * Manually unroll the per-line copying loop for better
+		 * performance. This works until we processed the last
+		 * completely filled source byte (inclusive).
+		 */
+		switch (ppw) {
+		case 4: /* 8 bpp */
+			for (j = k; j >= 2; j -= 2, ++src) {
+				*dst++ = colortab[(*src >> 4) & bit_mask];
+				*dst++ = colortab[(*src >> 0) & bit_mask];
+			}
+			break;
+		case 2: /* 16 bpp */
+			for (j = k; j >= 4; j -= 4, ++src) {
+				*dst++ = colortab[(*src >> 6) & bit_mask];
+				*dst++ = colortab[(*src >> 4) & bit_mask];
+				*dst++ = colortab[(*src >> 2) & bit_mask];
+				*dst++ = colortab[(*src >> 0) & bit_mask];
+			}
+			break;
+		case 1: /* 32 bpp */
+			for (j = k; j >= 8; j -= 8, ++src) {
+				*dst++ = colortab[(*src >> 7) & bit_mask];
+				*dst++ = colortab[(*src >> 6) & bit_mask];
+				*dst++ = colortab[(*src >> 5) & bit_mask];
+				*dst++ = colortab[(*src >> 4) & bit_mask];
+				*dst++ = colortab[(*src >> 3) & bit_mask];
+				*dst++ = colortab[(*src >> 2) & bit_mask];
+				*dst++ = colortab[(*src >> 1) & bit_mask];
+				*dst++ = colortab[(*src >> 0) & bit_mask];
+			}
+			break;
+		}
+
+		/*
+		 * For image widths that are not a multiple of 8, there
+		 * are trailing pixels left on the current line. Print
+		 * them as well.
+		 */
+		for (; j--; ) {
 			shift -= ppw;
-			end_mask = tab[(*src >> shift) & bit_mask];
-			*dst++ = (end_mask & eorx) ^ bgx;
+			*dst++ = colortab[(*src >> shift) & bit_mask];
 			if (!shift) {
 				shift = 8;
-				src++;
+				++src;
 			}
 		}
+
 		dst1 += p->fix.line_length;
 		s += spitch;
 	}
diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index fcdbb2df137f..2277d64310ab 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -523,7 +523,9 @@ static int mmphw_probe(struct platform_device *pdev)
 		ret = -ENOENT;
 		goto failed;
 	}
-	clk_prepare_enable(ctrl->clk);
+	ret = clk_prepare_enable(ctrl->clk);
+	if (ret)
+		goto failed;
 
 	/* init global regs */
 	ctrl_set_default(ctrl);
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 17cd682acc22..07be3a374efb 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -536,11 +536,9 @@ static void virtio_mmio_release_dev(struct device *_d)
 {
 	struct virtio_device *vdev =
 			container_of(_d, struct virtio_device, dev);
-	struct virtio_mmio_device *vm_dev =
-			container_of(vdev, struct virtio_mmio_device, vdev);
-	struct platform_device *pdev = vm_dev->pdev;
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 
-	devm_kfree(&pdev->dev, vm_dev);
+	kfree(vm_dev);
 }
 
 /* Platform device */
@@ -548,19 +546,10 @@ static void virtio_mmio_release_dev(struct device *_d)
 static int virtio_mmio_probe(struct platform_device *pdev)
 {
 	struct virtio_mmio_device *vm_dev;
-	struct resource *mem;
 	unsigned long magic;
 	int rc;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem)
-		return -EINVAL;
-
-	if (!devm_request_mem_region(&pdev->dev, mem->start,
-			resource_size(mem), pdev->name))
-		return -EBUSY;
-
-	vm_dev = devm_kzalloc(&pdev->dev, sizeof(*vm_dev), GFP_KERNEL);
+	vm_dev = kzalloc(sizeof(*vm_dev), GFP_KERNEL);
 	if (!vm_dev)
 		return -ENOMEM;
 
@@ -571,9 +560,9 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&vm_dev->virtqueues);
 	spin_lock_init(&vm_dev->lock);
 
-	vm_dev->base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
-	if (vm_dev->base == NULL)
-		return -EFAULT;
+	vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(vm_dev->base))
+		return PTR_ERR(vm_dev->base);
 
 	/* Check magic value */
 	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0294f519c29e..b69d6f7012f4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4106,8 +4106,7 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info)
 		}
 	}
 
-	BUG_ON(fs_info->balance_ctl ||
-		test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
+	ASSERT(!test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
 	atomic_dec(&fs_info->balance_cancel_req);
 	mutex_unlock(&fs_info->balance_mutex);
 	return 0;
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 7b482489bd22..0613b86cc3fd 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3991,9 +3991,9 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 
 io_error:
 	kunmap(page);
-	unlock_page(page);
 
 read_complete:
+	unlock_page(page);
 	return rc;
 }
 
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index d4e204473e76..0864481d8551 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1858,7 +1858,7 @@ static void del_timeout(struct dlm_lkb *lkb)
 void dlm_scan_timeout(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r;
-	struct dlm_lkb *lkb;
+	struct dlm_lkb *lkb = NULL, *iter;
 	int do_cancel, do_warn;
 	s64 wait_us;
 
@@ -1869,27 +1869,28 @@ void dlm_scan_timeout(struct dlm_ls *ls)
 		do_cancel = 0;
 		do_warn = 0;
 		mutex_lock(&ls->ls_timeout_mutex);
-		list_for_each_entry(lkb, &ls->ls_timeout, lkb_time_list) {
+		list_for_each_entry(iter, &ls->ls_timeout, lkb_time_list) {
 
 			wait_us = ktime_to_us(ktime_sub(ktime_get(),
-					      		lkb->lkb_timestamp));
+							iter->lkb_timestamp));
 
-			if ((lkb->lkb_exflags & DLM_LKF_TIMEOUT) &&
-			    wait_us >= (lkb->lkb_timeout_cs * 10000))
+			if ((iter->lkb_exflags & DLM_LKF_TIMEOUT) &&
+			    wait_us >= (iter->lkb_timeout_cs * 10000))
 				do_cancel = 1;
 
-			if ((lkb->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
+			if ((iter->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
 			    wait_us >= dlm_config.ci_timewarn_cs * 10000)
 				do_warn = 1;
 
 			if (!do_cancel && !do_warn)
 				continue;
-			hold_lkb(lkb);
+			hold_lkb(iter);
+			lkb = iter;
 			break;
 		}
 		mutex_unlock(&ls->ls_timeout_mutex);
 
-		if (!do_cancel && !do_warn)
+		if (!lkb)
 			break;
 
 		r = lkb->lkb_resource;
@@ -5243,21 +5244,18 @@ void dlm_recover_waiters_pre(struct dlm_ls *ls)
 
 static struct dlm_lkb *find_resend_waiter(struct dlm_ls *ls)
 {
-	struct dlm_lkb *lkb;
-	int found = 0;
+	struct dlm_lkb *lkb = NULL, *iter;
 
 	mutex_lock(&ls->ls_waiters_mutex);
-	list_for_each_entry(lkb, &ls->ls_waiters, lkb_wait_reply) {
-		if (lkb->lkb_flags & DLM_IFL_RESEND) {
-			hold_lkb(lkb);
-			found = 1;
+	list_for_each_entry(iter, &ls->ls_waiters, lkb_wait_reply) {
+		if (iter->lkb_flags & DLM_IFL_RESEND) {
+			hold_lkb(iter);
+			lkb = iter;
 			break;
 		}
 	}
 	mutex_unlock(&ls->ls_waiters_mutex);
 
-	if (!found)
-		lkb = NULL;
 	return lkb;
 }
 
@@ -5916,37 +5914,36 @@ int dlm_user_adopt_orphan(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
 		     int mode, uint32_t flags, void *name, unsigned int namelen,
 		     unsigned long timeout_cs, uint32_t *lkid)
 {
-	struct dlm_lkb *lkb;
+	struct dlm_lkb *lkb = NULL, *iter;
 	struct dlm_user_args *ua;
 	int found_other_mode = 0;
-	int found = 0;
 	int rv = 0;
 
 	mutex_lock(&ls->ls_orphans_mutex);
-	list_for_each_entry(lkb, &ls->ls_orphans, lkb_ownqueue) {
-		if (lkb->lkb_resource->res_length != namelen)
+	list_for_each_entry(iter, &ls->ls_orphans, lkb_ownqueue) {
+		if (iter->lkb_resource->res_length != namelen)
 			continue;
-		if (memcmp(lkb->lkb_resource->res_name, name, namelen))
+		if (memcmp(iter->lkb_resource->res_name, name, namelen))
 			continue;
-		if (lkb->lkb_grmode != mode) {
+		if (iter->lkb_grmode != mode) {
 			found_other_mode = 1;
 			continue;
 		}
 
-		found = 1;
-		list_del_init(&lkb->lkb_ownqueue);
-		lkb->lkb_flags &= ~DLM_IFL_ORPHAN;
-		*lkid = lkb->lkb_id;
+		lkb = iter;
+		list_del_init(&iter->lkb_ownqueue);
+		iter->lkb_flags &= ~DLM_IFL_ORPHAN;
+		*lkid = iter->lkb_id;
 		break;
 	}
 	mutex_unlock(&ls->ls_orphans_mutex);
 
-	if (!found && found_other_mode) {
+	if (!lkb && found_other_mode) {
 		rv = -EAGAIN;
 		goto out;
 	}
 
-	if (!found) {
+	if (!lkb) {
 		rv = -ENOENT;
 		goto out;
 	}
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 9fef426ce6f4..0501821182b1 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -83,8 +83,7 @@ static void send_op(struct plock_op *op)
    abandoned waiter.  So, we have to insert the unlock-close when the
    lock call is interrupted. */
 
-static void do_unlock_close(struct dlm_ls *ls, u64 number,
-			    struct file *file, struct file_lock *fl)
+static void do_unlock_close(const struct dlm_plock_info *info)
 {
 	struct plock_op *op;
 
@@ -93,15 +92,12 @@ static void do_unlock_close(struct dlm_ls *ls, u64 number,
 		return;
 
 	op->info.optype		= DLM_PLOCK_OP_UNLOCK;
-	op->info.pid		= fl->fl_pid;
-	op->info.fsid		= ls->ls_global_id;
-	op->info.number		= number;
+	op->info.pid		= info->pid;
+	op->info.fsid		= info->fsid;
+	op->info.number		= info->number;
 	op->info.start		= 0;
 	op->info.end		= OFFSET_MAX;
-	if (fl->fl_lmops && fl->fl_lmops->lm_grant)
-		op->info.owner	= (__u64) fl->fl_pid;
-	else
-		op->info.owner	= (__u64)(long) fl->fl_owner;
+	op->info.owner		= info->owner;
 
 	op->info.flags |= DLM_PLOCK_FL_CLOSE;
 	send_op(op);
@@ -164,13 +160,14 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 
 	rv = wait_event_killable(recv_wq, (op->done != 0));
 	if (rv == -ERESTARTSYS) {
-		log_debug(ls, "%s: wait killed %llx", __func__,
-			  (unsigned long long)number);
 		spin_lock(&ops_lock);
 		list_del(&op->list);
 		spin_unlock(&ops_lock);
+		log_debug(ls, "%s: wait interrupted %x %llx pid %d",
+			  __func__, ls->ls_global_id,
+			  (unsigned long long)number, op->info.pid);
 		dlm_release_plock_op(op);
-		do_unlock_close(ls, number, file, fl);
+		do_unlock_close(&op->info);
 		goto out;
 	}
 
@@ -411,7 +408,7 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 		if (op->info.flags & DLM_PLOCK_FL_CLOSE)
 			list_del(&op->list);
 		else
-			list_move(&op->list, &recv_list);
+			list_move_tail(&op->list, &recv_list);
 		memcpy(&info, &op->info, sizeof(info));
 	}
 	spin_unlock(&ops_lock);
@@ -436,9 +433,9 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 			 loff_t *ppos)
 {
+	struct plock_op *op = NULL, *iter;
 	struct dlm_plock_info info;
-	struct plock_op *op;
-	int found = 0, do_callback = 0;
+	int do_callback = 0;
 
 	if (count != sizeof(info))
 		return -EINVAL;
@@ -449,31 +446,63 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 	if (check_version(&info))
 		return -EINVAL;
 
+	/*
+	 * The results for waiting ops (SETLKW) can be returned in any
+	 * order, so match all fields to find the op.  The results for
+	 * non-waiting ops are returned in the order that they were sent
+	 * to userspace, so match the result with the first non-waiting op.
+	 */
 	spin_lock(&ops_lock);
-	list_for_each_entry(op, &recv_list, list) {
-		if (op->info.fsid == info.fsid &&
-		    op->info.number == info.number &&
-		    op->info.owner == info.owner) {
-			list_del_init(&op->list);
-			memcpy(&op->info, &info, sizeof(info));
-			if (op->data)
-				do_callback = 1;
-			else
-				op->done = 1;
-			found = 1;
-			break;
+	if (info.wait) {
+		list_for_each_entry(iter, &recv_list, list) {
+			if (iter->info.fsid == info.fsid &&
+			    iter->info.number == info.number &&
+			    iter->info.owner == info.owner &&
+			    iter->info.pid == info.pid &&
+			    iter->info.start == info.start &&
+			    iter->info.end == info.end &&
+			    iter->info.ex == info.ex &&
+			    iter->info.wait) {
+				op = iter;
+				break;
+			}
+		}
+	} else {
+		list_for_each_entry(iter, &recv_list, list) {
+			if (!iter->info.wait) {
+				op = iter;
+				break;
+			}
 		}
 	}
+
+	if (op) {
+		/* Sanity check that op and info match. */
+		if (info.wait)
+			WARN_ON(op->info.optype != DLM_PLOCK_OP_LOCK);
+		else
+			WARN_ON(op->info.fsid != info.fsid ||
+				op->info.number != info.number ||
+				op->info.owner != info.owner ||
+				op->info.optype != info.optype);
+
+		list_del_init(&op->list);
+		memcpy(&op->info, &info, sizeof(info));
+		if (op->data)
+			do_callback = 1;
+		else
+			op->done = 1;
+	}
 	spin_unlock(&ops_lock);
 
-	if (found) {
+	if (op) {
 		if (do_callback)
 			dlm_plock_callback(op);
 		else
 			wake_up(&recv_wq);
 	} else
-		log_print("dev_write no op %x %llx", info.fsid,
-			  (unsigned long long)info.number);
+		log_print("%s: no op %x %llx", __func__,
+			  info.fsid, (unsigned long long)info.number);
 	return count;
 }
 
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index ce2aa54ca2e2..98b710cc9cf3 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -734,10 +734,9 @@ void dlm_recovered_lock(struct dlm_rsb *r)
 
 static void recover_lvb(struct dlm_rsb *r)
 {
-	struct dlm_lkb *lkb, *high_lkb = NULL;
+	struct dlm_lkb *big_lkb = NULL, *iter, *high_lkb = NULL;
 	uint32_t high_seq = 0;
 	int lock_lvb_exists = 0;
-	int big_lock_exists = 0;
 	int lvblen = r->res_ls->ls_lvblen;
 
 	if (!rsb_flag(r, RSB_NEW_MASTER2) &&
@@ -753,37 +752,37 @@ static void recover_lvb(struct dlm_rsb *r)
 	/* we are the new master, so figure out if VALNOTVALID should
 	   be set, and set the rsb lvb from the best lkb available. */
 
-	list_for_each_entry(lkb, &r->res_grantqueue, lkb_statequeue) {
-		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
+	list_for_each_entry(iter, &r->res_grantqueue, lkb_statequeue) {
+		if (!(iter->lkb_exflags & DLM_LKF_VALBLK))
 			continue;
 
 		lock_lvb_exists = 1;
 
-		if (lkb->lkb_grmode > DLM_LOCK_CR) {
-			big_lock_exists = 1;
+		if (iter->lkb_grmode > DLM_LOCK_CR) {
+			big_lkb = iter;
 			goto setflag;
 		}
 
-		if (((int)lkb->lkb_lvbseq - (int)high_seq) >= 0) {
-			high_lkb = lkb;
-			high_seq = lkb->lkb_lvbseq;
+		if (((int)iter->lkb_lvbseq - (int)high_seq) >= 0) {
+			high_lkb = iter;
+			high_seq = iter->lkb_lvbseq;
 		}
 	}
 
-	list_for_each_entry(lkb, &r->res_convertqueue, lkb_statequeue) {
-		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
+	list_for_each_entry(iter, &r->res_convertqueue, lkb_statequeue) {
+		if (!(iter->lkb_exflags & DLM_LKF_VALBLK))
 			continue;
 
 		lock_lvb_exists = 1;
 
-		if (lkb->lkb_grmode > DLM_LOCK_CR) {
-			big_lock_exists = 1;
+		if (iter->lkb_grmode > DLM_LOCK_CR) {
+			big_lkb = iter;
 			goto setflag;
 		}
 
-		if (((int)lkb->lkb_lvbseq - (int)high_seq) >= 0) {
-			high_lkb = lkb;
-			high_seq = lkb->lkb_lvbseq;
+		if (((int)iter->lkb_lvbseq - (int)high_seq) >= 0) {
+			high_lkb = iter;
+			high_seq = iter->lkb_lvbseq;
 		}
 	}
 
@@ -792,7 +791,7 @@ static void recover_lvb(struct dlm_rsb *r)
 		goto out;
 
 	/* lvb is invalidated if only NL/CR locks remain */
-	if (!big_lock_exists)
+	if (!big_lkb)
 		rsb_set_flag(r, RSB_VALNOTVALID);
 
 	if (!r->res_lvbptr) {
@@ -801,9 +800,9 @@ static void recover_lvb(struct dlm_rsb *r)
 			goto out;
 	}
 
-	if (big_lock_exists) {
-		r->res_lvbseq = lkb->lkb_lvbseq;
-		memcpy(r->res_lvbptr, lkb->lkb_lvbptr, lvblen);
+	if (big_lkb) {
+		r->res_lvbseq = big_lkb->lkb_lvbseq;
+		memcpy(r->res_lvbptr, big_lkb->lkb_lvbptr, lvblen);
 	} else if (high_lkb) {
 		r->res_lvbseq = high_lkb->lkb_lvbseq;
 		memcpy(r->res_lvbptr, high_lkb->lkb_lvbptr, lvblen);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index bb0eaa4638e3..29157f7d9663 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1374,7 +1374,14 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 {
 	struct gfs2_sbd *sdp = root->d_sb->s_fs_info;
 	struct gfs2_args *args = &sdp->sd_args;
-	int val;
+	unsigned int logd_secs, statfs_slow, statfs_quantum, quota_quantum;
+
+	spin_lock(&sdp->sd_tune.gt_spin);
+	logd_secs = sdp->sd_tune.gt_logd_secs;
+	quota_quantum = sdp->sd_tune.gt_quota_quantum;
+	statfs_quantum = sdp->sd_tune.gt_statfs_quantum;
+	statfs_slow = sdp->sd_tune.gt_statfs_slow;
+	spin_unlock(&sdp->sd_tune.gt_spin);
 
 	if (is_ancestor(root, sdp->sd_master_dir))
 		seq_puts(s, ",meta");
@@ -1429,17 +1436,14 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 	}
 	if (args->ar_discard)
 		seq_puts(s, ",discard");
-	val = sdp->sd_tune.gt_logd_secs;
-	if (val != 30)
-		seq_printf(s, ",commit=%d", val);
-	val = sdp->sd_tune.gt_statfs_quantum;
-	if (val != 30)
-		seq_printf(s, ",statfs_quantum=%d", val);
-	else if (sdp->sd_tune.gt_statfs_slow)
+	if (logd_secs != 30)
+		seq_printf(s, ",commit=%d", logd_secs);
+	if (statfs_quantum != 30)
+		seq_printf(s, ",statfs_quantum=%d", statfs_quantum);
+	else if (statfs_slow)
 		seq_puts(s, ",statfs_quantum=0");
-	val = sdp->sd_tune.gt_quota_quantum;
-	if (val != 60)
-		seq_printf(s, ",quota_quantum=%d", val);
+	if (quota_quantum != 60)
+		seq_printf(s, ",quota_quantum=%d", quota_quantum);
 	if (args->ar_statfs_percent)
 		seq_printf(s, ",statfs_percent=%d", args->ar_statfs_percent);
 	if (args->ar_errors != GFS2_ERRORS_DEFAULT) {
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 07b9df8938f2..63ad6b1d575a 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2040,6 +2040,9 @@ dbAllocDmapLev(struct bmap * bmp,
 	if (dbFindLeaf((dmtree_t *) & dp->tree, l2nb, &leafidx))
 		return -ENOSPC;
 
+	if (leafidx < 0)
+		return -EIO;
+
 	/* determine the block number within the file system corresponding
 	 * to the leaf at which free space was found.
 	 */
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 78789c5ed36b..e10db01f253b 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -367,6 +367,11 @@ tid_t txBegin(struct super_block *sb, int flag)
 	jfs_info("txBegin: flag = 0x%x", flag);
 	log = JFS_SBI(sb)->log;
 
+	if (!log) {
+		jfs_error(sb, "read-only filesystem\n");
+		return 0;
+	}
+
 	TXN_LOCK();
 
 	INCREMENT(TxStat.txBegin);
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 14528c0ffe63..c2c439acbb78 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -811,6 +811,11 @@ static int jfs_link(struct dentry *old_dentry,
 	if (rc)
 		goto out;
 
+	if (isReadOnly(ip)) {
+		jfs_error(ip->i_sb, "read-only filesystem\n");
+		return -EROFS;
+	}
+
 	tid = txBegin(ip->i_sb, 0);
 
 	mutex_lock_nested(&JFS_IP(dir)->commit_mutex, COMMIT_MUTEX_PARENT);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 78191320f8e2..e958181b7361 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1019,9 +1019,9 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 	WARN_ON(!list_empty(&dp->dl_recall_lru));
 
 	if (clp->cl_minorversion) {
+		spin_lock(&clp->cl_lock);
 		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
 		refcount_inc(&dp->dl_stid.sc_count);
-		spin_lock(&clp->cl_lock);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
 		spin_unlock(&clp->cl_lock);
 	}
@@ -4998,15 +4998,6 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return status;
-	/* Client debugging aid. */
-	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid)) {
-		char addr_str[INET6_ADDRSTRLEN];
-		rpc_ntop((struct sockaddr *)&cl->cl_addr, addr_str,
-				 sizeof(addr_str));
-		pr_warn_ratelimited("NFSD: client %s testing state ID "
-					"with incorrect client ID\n", addr_str);
-		return status;
-	}
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s)
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 770a2b143485..303987d29b9c 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -540,7 +540,7 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			continue;
 		/* Wait for dquot users */
 		if (atomic_read(&dquot->dq_count)) {
-			dqgrab(dquot);
+			atomic_inc(&dquot->dq_count);
 			spin_unlock(&dq_list_lock);
 			/*
 			 * Once dqput() wakes us up, we know it's time to free
@@ -2407,7 +2407,8 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 
 	error = add_dquot_ref(sb, type);
 	if (error)
-		dquot_disable(sb, type, flags);
+		dquot_disable(sb, type,
+			      DQUOT_USAGE_ENABLED | DQUOT_LIMITS_ENABLED);
 
 	return error;
 out_fmt:
diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
index 5fcfa96463eb..85521d6b0237 100644
--- a/fs/udf/unicode.c
+++ b/fs/udf/unicode.c
@@ -247,7 +247,7 @@ static int udf_name_from_CS0(struct super_block *sb,
 	}
 
 	if (translate) {
-		if (str_o_len <= 2 && str_o[0] == '.' &&
+		if (str_o_len > 0 && str_o_len <= 2 && str_o[0] == '.' &&
 		    (str_o_len == 1 || str_o[1] == '.'))
 			needsCRC = 1;
 		if (needsCRC) {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 4f750c481b82..0a2382d3f68c 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -175,6 +175,39 @@ int clk_get_scaled_duty_cycle(struct clk *clk, unsigned int scale);
  */
 bool clk_is_match(const struct clk *p, const struct clk *q);
 
+/**
+ * clk_rate_exclusive_get - get exclusivity over the rate control of a
+ *                          producer
+ * @clk: clock source
+ *
+ * This function allows drivers to get exclusive control over the rate of a
+ * provider. It prevents any other consumer to execute, even indirectly,
+ * opereation which could alter the rate of the provider or cause glitches
+ *
+ * If exlusivity is claimed more than once on clock, even by the same driver,
+ * the rate effectively gets locked as exclusivity can't be preempted.
+ *
+ * Must not be called from within atomic context.
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_rate_exclusive_get(struct clk *clk);
+
+/**
+ * clk_rate_exclusive_put - release exclusivity over the rate control of a
+ *                          producer
+ * @clk: clock source
+ *
+ * This function allows drivers to release the exclusivity it previously got
+ * from clk_rate_exclusive_get()
+ *
+ * The caller must balance the number of clk_rate_exclusive_get() and
+ * clk_rate_exclusive_put() calls.
+ *
+ * Must not be called from within atomic context.
+ */
+void clk_rate_exclusive_put(struct clk *clk);
+
 #else
 
 static inline int clk_notifier_register(struct clk *clk,
@@ -221,6 +254,13 @@ static inline bool clk_is_match(const struct clk *p, const struct clk *q)
 	return p == q;
 }
 
+static inline int clk_rate_exclusive_get(struct clk *clk)
+{
+	return 0;
+}
+
+static inline void clk_rate_exclusive_put(struct clk *clk) {}
+
 #endif
 
 /**
@@ -364,38 +404,6 @@ struct clk *devm_clk_get(struct device *dev, const char *id);
  */
 struct clk *devm_get_clk_from_child(struct device *dev,
 				    struct device_node *np, const char *con_id);
-/**
- * clk_rate_exclusive_get - get exclusivity over the rate control of a
- *                          producer
- * @clk: clock source
- *
- * This function allows drivers to get exclusive control over the rate of a
- * provider. It prevents any other consumer to execute, even indirectly,
- * opereation which could alter the rate of the provider or cause glitches
- *
- * If exlusivity is claimed more than once on clock, even by the same driver,
- * the rate effectively gets locked as exclusivity can't be preempted.
- *
- * Must not be called from within atomic context.
- *
- * Returns success (0) or negative errno.
- */
-int clk_rate_exclusive_get(struct clk *clk);
-
-/**
- * clk_rate_exclusive_put - release exclusivity over the rate control of a
- *                          producer
- * @clk: clock source
- *
- * This function allows drivers to release the exclusivity it previously got
- * from clk_rate_exclusive_get()
- *
- * The caller must balance the number of clk_rate_exclusive_get() and
- * clk_rate_exclusive_put() calls.
- *
- * Must not be called from within atomic context.
- */
-void clk_rate_exclusive_put(struct clk *clk);
 
 /**
  * clk_enable - inform the system when the clock source should be running.
@@ -665,14 +673,6 @@ static inline void clk_bulk_put(int num_clks, struct clk_bulk_data *clks) {}
 
 static inline void devm_clk_put(struct device *dev, struct clk *clk) {}
 
-
-static inline int clk_rate_exclusive_get(struct clk *clk)
-{
-	return 0;
-}
-
-static inline void clk_rate_exclusive_put(struct clk *clk) {}
-
 static inline int clk_enable(struct clk *clk)
 {
 	return 0;
diff --git a/include/linux/raid_class.h b/include/linux/raid_class.h
index ec8655514283..c868bb927c3d 100644
--- a/include/linux/raid_class.h
+++ b/include/linux/raid_class.h
@@ -78,7 +78,3 @@ DEFINE_RAID_ATTRIBUTE(enum raid_state, state)
 	
 struct raid_template *raid_class_attach(struct raid_function_template *);
 void raid_class_release(struct raid_template *);
-
-int __must_check raid_component_add(struct raid_template *, struct device *,
-				    struct device *);
-
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index faee73c084d4..d49c1aad2464 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -148,6 +148,10 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		if (gso_type & SKB_GSO_UDP)
 			nh_off -= thlen;
 
+		/* Kernel has a special handling for GSO_BY_FRAGS. */
+		if (gso_size == GSO_BY_FRAGS)
+			return -EINVAL;
+
 		/* Too small packets are not really GSO ones. */
 		if (skb->len - nh_off > gso_size) {
 			shinfo->gso_size = gso_size;
diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index d655720e16a1..62c67e9e190c 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -405,7 +405,14 @@ void v4l2_m2m_buf_queue(struct v4l2_m2m_ctx *m2m_ctx,
 static inline
 unsigned int v4l2_m2m_num_src_bufs_ready(struct v4l2_m2m_ctx *m2m_ctx)
 {
-	return m2m_ctx->out_q_ctx.num_rdy;
+	unsigned int num_buf_rdy;
+	unsigned long flags;
+
+	spin_lock_irqsave(&m2m_ctx->out_q_ctx.rdy_spinlock, flags);
+	num_buf_rdy = m2m_ctx->out_q_ctx.num_rdy;
+	spin_unlock_irqrestore(&m2m_ctx->out_q_ctx.rdy_spinlock, flags);
+
+	return num_buf_rdy;
 }
 
 /**
@@ -417,7 +424,14 @@ unsigned int v4l2_m2m_num_src_bufs_ready(struct v4l2_m2m_ctx *m2m_ctx)
 static inline
 unsigned int v4l2_m2m_num_dst_bufs_ready(struct v4l2_m2m_ctx *m2m_ctx)
 {
-	return m2m_ctx->cap_q_ctx.num_rdy;
+	unsigned int num_buf_rdy;
+	unsigned long flags;
+
+	spin_lock_irqsave(&m2m_ctx->cap_q_ctx.rdy_spinlock, flags);
+	num_buf_rdy = m2m_ctx->cap_q_ctx.num_rdy;
+	spin_unlock_irqrestore(&m2m_ctx->cap_q_ctx.rdy_spinlock, flags);
+
+	return num_buf_rdy;
 }
 
 /**
diff --git a/include/net/bonding.h b/include/net/bonding.h
index c458f084f7bb..7d317434e3d1 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -675,37 +675,14 @@ static inline struct slave *bond_slave_has_mac(struct bonding *bond,
 }
 
 /* Caller must hold rcu_read_lock() for read */
-static inline struct slave *bond_slave_has_mac_rcu(struct bonding *bond,
-					       const u8 *mac)
+static inline bool bond_slave_has_mac_rcu(struct bonding *bond, const u8 *mac)
 {
 	struct list_head *iter;
 	struct slave *tmp;
 
-	bond_for_each_slave_rcu(bond, tmp, iter)
-		if (ether_addr_equal_64bits(mac, tmp->dev->dev_addr))
-			return tmp;
-
-	return NULL;
-}
-
-/* Caller must hold rcu_read_lock() for read */
-static inline bool bond_slave_has_mac_rx(struct bonding *bond, const u8 *mac)
-{
-	struct list_head *iter;
-	struct slave *tmp;
-	struct netdev_hw_addr *ha;
-
 	bond_for_each_slave_rcu(bond, tmp, iter)
 		if (ether_addr_equal_64bits(mac, tmp->dev->dev_addr))
 			return true;
-
-	if (netdev_uc_empty(bond->dev))
-		return false;
-
-	netdev_for_each_uc_addr(ha, bond->dev)
-		if (ether_addr_equal_64bits(mac, ha->addr))
-			return true;
-
 	return false;
 }
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 72739f72e4b9..373e34b46a3c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1152,6 +1152,7 @@ struct proto {
 	/*
 	 * Pressure flag: try to collapse.
 	 * Technical note: it is used by multiple contexts non atomically.
+	 * Make sure to use READ_ONCE()/WRITE_ONCE() for all reads/writes.
 	 * All the __sk_mem_schedule() is of this nature: accounting
 	 * is strict, actions are advisory and have some latency.
 	 */
@@ -1265,6 +1266,12 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
 	return sk->sk_prot->memory_pressure != NULL;
 }
 
+static inline bool sk_under_global_memory_pressure(const struct sock *sk)
+{
+	return sk->sk_prot->memory_pressure &&
+		!!READ_ONCE(*sk->sk_prot->memory_pressure);
+}
+
 static inline bool sk_under_memory_pressure(const struct sock *sk)
 {
 	if (!sk->sk_prot->memory_pressure)
@@ -1274,7 +1281,7 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
-	return !!*sk->sk_prot->memory_pressure;
+	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
 }
 
 static inline long
@@ -1328,7 +1335,7 @@ proto_memory_pressure(struct proto *prot)
 {
 	if (!prot->memory_pressure)
 		return false;
-	return !!*prot->memory_pressure;
+	return !!READ_ONCE(*prot->memory_pressure);
 }
 
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 9c6c3572b131..394c66442cff 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1522,6 +1522,8 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
 	BUG_ON(idx >= MAX_RT_PRIO);
 
 	queue = array->queue + idx;
+	if (SCHED_WARN_ON(list_empty(queue)))
+		return NULL;
 	next = list_entry(queue->next, struct sched_rt_entity, run_list);
 
 	return next;
@@ -1535,7 +1537,8 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 
 	do {
 		rt_se = pick_next_rt_entity(rq, rt_rq);
-		BUG_ON(!rt_se);
+		if (unlikely(!rt_se))
+			return NULL;
 		rt_rq = group_rt_rq(rt_se);
 	} while (rt_rq);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9da7b10e56d2..f44c8f1fd3ec 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3277,8 +3277,15 @@ static void *s_start(struct seq_file *m, loff_t *pos)
 	 * will point to the same string as current_trace->name.
 	 */
 	mutex_lock(&trace_types_lock);
-	if (unlikely(tr->current_trace && iter->trace->name != tr->current_trace->name))
+	if (unlikely(tr->current_trace && iter->trace->name != tr->current_trace->name)) {
+		/* Close iter->trace before switching to the new current tracer */
+		if (iter->trace->close)
+			iter->trace->close(iter);
 		*iter->trace = *tr->current_trace;
+		/* Reopen the new current tracer */
+		if (iter->trace->open)
+			iter->trace->open(iter);
+	}
 	mutex_unlock(&trace_types_lock);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 98ea6d28df15..0f36bb59970d 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -222,7 +222,8 @@ static void irqsoff_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
-
+	else
+		iter->private = NULL;
 }
 
 static void irqsoff_trace_close(struct trace_iterator *iter)
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 11f4dbd9526b..8041bd5e4262 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -287,6 +287,8 @@ static void wakeup_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
+	else
+		iter->private = NULL;
 }
 
 static void wakeup_trace_close(struct trace_iterator *iter)
diff --git a/lib/clz_ctz.c b/lib/clz_ctz.c
index 2e11e48446ab..ca0582d33532 100644
--- a/lib/clz_ctz.c
+++ b/lib/clz_ctz.c
@@ -30,36 +30,16 @@ int __weak __clzsi2(int val)
 }
 EXPORT_SYMBOL(__clzsi2);
 
-int __weak __clzdi2(long val);
-int __weak __ctzdi2(long val);
-#if BITS_PER_LONG == 32
-
-int __weak __clzdi2(long val)
+int __weak __clzdi2(u64 val);
+int __weak __clzdi2(u64 val)
 {
-	return 32 - fls((int)val);
+	return 64 - fls64(val);
 }
 EXPORT_SYMBOL(__clzdi2);
 
-int __weak __ctzdi2(long val)
+int __weak __ctzdi2(u64 val);
+int __weak __ctzdi2(u64 val)
 {
-	return __ffs((u32)val);
+	return __ffs64(val);
 }
 EXPORT_SYMBOL(__ctzdi2);
-
-#elif BITS_PER_LONG == 64
-
-int __weak __clzdi2(long val)
-{
-	return 64 - fls64((u64)val);
-}
-EXPORT_SYMBOL(__clzdi2);
-
-int __weak __ctzdi2(long val)
-{
-	return __ffs64((u64)val);
-}
-EXPORT_SYMBOL(__ctzdi2);
-
-#else
-#error BITS_PER_LONG not 32 or 64
-#endif
diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
index 6c5229f98c9e..cac4e5aee739 100644
--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -639,30 +639,12 @@ do { \
 	**************  MIPS  *****************
 	***************************************/
 #if defined(__mips__) && W_TYPE_SIZE == 32
-#if (__GNUC__ >= 5) || (__GNUC__ >= 4 && __GNUC_MINOR__ >= 4)
 #define umul_ppmm(w1, w0, u, v)			\
 do {						\
 	UDItype __ll = (UDItype)(u) * (v);	\
 	w1 = __ll >> 32;			\
 	w0 = __ll;				\
 } while (0)
-#elif __GNUC__ > 2 || __GNUC_MINOR__ >= 7
-#define umul_ppmm(w1, w0, u, v) \
-	__asm__ ("multu %2,%3" \
-	: "=l" ((USItype)(w0)), \
-	     "=h" ((USItype)(w1)) \
-	: "d" ((USItype)(u)), \
-	     "d" ((USItype)(v)))
-#else
-#define umul_ppmm(w1, w0, u, v) \
-	__asm__ ("multu %2,%3\n" \
-	   "mflo %0\n" \
-	   "mfhi %1" \
-	: "=d" ((USItype)(w0)), \
-	     "=d" ((USItype)(w1)) \
-	: "d" ((USItype)(u)), \
-	     "d" ((USItype)(v)))
-#endif
 #define UMUL_TIME 10
 #define UDIV_TIME 100
 #endif /* __mips__ */
@@ -687,7 +669,7 @@ do {									\
 		 : "d" ((UDItype)(u)),					\
 		   "d" ((UDItype)(v)));					\
 } while (0)
-#elif (__GNUC__ >= 5) || (__GNUC__ >= 4 && __GNUC_MINOR__ >= 4)
+#else
 #define umul_ppmm(w1, w0, u, v) \
 do {									\
 	typedef unsigned int __ll_UTItype __attribute__((mode(TI)));	\
@@ -695,22 +677,6 @@ do {									\
 	w1 = __ll >> 64;						\
 	w0 = __ll;							\
 } while (0)
-#elif __GNUC__ > 2 || __GNUC_MINOR__ >= 7
-#define umul_ppmm(w1, w0, u, v) \
-	__asm__ ("dmultu %2,%3" \
-	: "=l" ((UDItype)(w0)), \
-	     "=h" ((UDItype)(w1)) \
-	: "d" ((UDItype)(u)), \
-	     "d" ((UDItype)(v)))
-#else
-#define umul_ppmm(w1, w0, u, v) \
-	__asm__ ("dmultu %2,%3\n" \
-	   "mflo %0\n" \
-	   "mfhi %1" \
-	: "=d" ((UDItype)(w0)), \
-	     "=d" ((UDItype)(w1)) \
-	: "d" ((UDItype)(u)), \
-	     "d" ((UDItype)(v)))
 #endif
 #define UMUL_TIME 20
 #define UDIV_TIME 140
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index b5e779bcfb34..be3baea88b61 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -284,16 +284,26 @@ static ssize_t config_test_show_str(char *dst,
 	return len;
 }
 
-static int test_dev_config_update_bool(const char *buf, size_t size,
-				       bool *cfg)
+static inline int __test_dev_config_update_bool(const char *buf, size_t size,
+						bool *cfg)
 {
 	int ret;
 
-	mutex_lock(&test_fw_mutex);
 	if (strtobool(buf, cfg) < 0)
 		ret = -EINVAL;
 	else
 		ret = size;
+
+	return ret;
+}
+
+static int test_dev_config_update_bool(const char *buf, size_t size,
+				       bool *cfg)
+{
+	int ret;
+
+	mutex_lock(&test_fw_mutex);
+	ret = __test_dev_config_update_bool(buf, size, cfg);
 	mutex_unlock(&test_fw_mutex);
 
 	return ret;
@@ -323,7 +333,7 @@ static ssize_t test_dev_config_show_int(char *buf, int cfg)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+static inline int __test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 {
 	int ret;
 	long new;
@@ -335,14 +345,23 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 	if (new > U8_MAX)
 		return -EINVAL;
 
-	mutex_lock(&test_fw_mutex);
 	*(u8 *)cfg = new;
-	mutex_unlock(&test_fw_mutex);
 
 	/* Always return full write size even if we didn't consume all */
 	return size;
 }
 
+static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+{
+	int ret;
+
+	mutex_lock(&test_fw_mutex);
+	ret = __test_dev_config_update_u8(buf, size, cfg);
+	mutex_unlock(&test_fw_mutex);
+
+	return ret;
+}
+
 static ssize_t test_dev_config_show_u8(char *buf, u8 cfg)
 {
 	u8 val;
@@ -375,10 +394,10 @@ static ssize_t config_num_requests_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_u8(buf, count,
-				       &test_fw_config->num_requests);
+	rc = __test_dev_config_update_u8(buf, count,
+					 &test_fw_config->num_requests);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index af3da6cdfc79..17100d9ceaf0 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -513,7 +513,7 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_elp_packet *elp_packet;
 	struct batadv_hard_iface *primary_if;
-	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	struct ethhdr *ethhdr;
 	bool res;
 	int ret = NET_RX_DROP;
 
@@ -521,6 +521,7 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	if (!res)
 		goto free_skb;
 
+	ethhdr = eth_hdr(skb);
 	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		goto free_skb;
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 04a620fd1301..5d4232d8d651 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -119,8 +119,10 @@ static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	if (hard_iface->if_status != BATADV_IF_ACTIVE)
+	if (hard_iface->if_status != BATADV_IF_ACTIVE) {
+		kfree_skb(skb);
 		return;
+	}
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_TX);
 	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_TX_BYTES,
@@ -832,7 +834,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_ogm2_packet *ogm_packet;
-	struct ethhdr *ethhdr = eth_hdr(skb);
+	struct ethhdr *ethhdr;
 	int ogm_offset;
 	u8 *packet_pos;
 	int ret = NET_RX_DROP;
@@ -846,6 +848,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 	if (!batadv_check_management_packet(skb, if_incoming, BATADV_OGM2_HLEN))
 		goto free_skb;
 
+	ethhdr = eth_hdr(skb);
 	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		goto free_skb;
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 6d68cdb9dd77..0d5519fcb438 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -643,7 +643,19 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
  */
 void batadv_update_min_mtu(struct net_device *soft_iface)
 {
-	soft_iface->mtu = batadv_hardif_min_mtu(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	int limit_mtu;
+	int mtu;
+
+	mtu = batadv_hardif_min_mtu(soft_iface);
+
+	if (bat_priv->mtu_set_by_user)
+		limit_mtu = bat_priv->mtu_set_by_user;
+	else
+		limit_mtu = ETH_DATA_LEN;
+
+	mtu = min(mtu, limit_mtu);
+	dev_set_mtu(soft_iface, mtu);
 
 	/* Check if the local translate table should be cleaned up to match a
 	 * new (and smaller) MTU.
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 1003abb8cc35..7447dbd305fc 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -167,11 +167,14 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 
 static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 {
+	struct batadv_priv *bat_priv = netdev_priv(dev);
+
 	/* check ranges */
 	if (new_mtu < 68 || new_mtu > batadv_hardif_min_mtu(dev))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
+	bat_priv->mtu_set_by_user = new_mtu;
 
 	return 0;
 }
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6bdb70c93e3f..c64d58c1b724 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -793,7 +793,6 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 		if (roamed_back) {
 			batadv_tt_global_free(bat_priv, tt_global,
 					      "Roaming canceled");
-			tt_global = NULL;
 		} else {
 			/* The global entry has to be marked as ROAMING and
 			 * has to be kept for consistency purpose
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 37598ae1d3f7..34c18f72a41b 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1514,6 +1514,12 @@ struct batadv_priv {
 	/** @soft_iface: net device which holds this struct as private data */
 	struct net_device *soft_iface;
 
+	/**
+	 * @mtu_set_by_user: MTU was set once by user
+	 * protected by rtnl_lock
+	 */
+	int mtu_set_by_user;
+
 	/**
 	 * @bat_counters: mesh internal traffic statistic counters (see
 	 *  batadv_counters)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fcc471f92189..9346fae5d664 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5705,9 +5705,14 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 	if (!chan)
 		goto done;
 
+	chan = l2cap_chan_hold_unless_zero(chan);
+	if (!chan)
+		goto done;
+
 	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNREFUSED);
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 done:
 	mutex_unlock(&conn->chan_lock);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 79f62517e24a..794db633f1c9 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2702,7 +2702,10 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(net, ifm->ifi_index);
-	else if (tb[IFLA_IFNAME])
+	else if (ifm->ifi_index < 0) {
+		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
+		return -EINVAL;
+	} else if (tb[IFLA_IFNAME])
 		dev = __dev_get_by_name(net, ifname);
 	else
 		goto errout;
diff --git a/net/core/sock.c b/net/core/sock.c
index 3e6da3694a5a..4e3ed80a68ce 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2538,7 +2538,7 @@ void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
 		mem_cgroup_uncharge_skmem(sk->sk_memcg, amount);
 
-	if (sk_under_memory_pressure(sk) &&
+	if (sk_under_global_memory_pressure(sk) &&
 	    (sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)))
 		sk_leave_memory_pressure(sk);
 }
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 27de4dc1ff51..c4ea0159ce2e 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -328,11 +328,15 @@ EXPORT_SYMBOL_GPL(dccp_disconnect);
 __poll_t dccp_poll(struct file *file, struct socket *sock,
 		       poll_table *wait)
 {
-	__poll_t mask;
 	struct sock *sk = sock->sk;
+	__poll_t mask;
+	u8 shutdown;
+	int state;
 
 	sock_poll_wait(file, sock, wait);
-	if (sk->sk_state == DCCP_LISTEN)
+
+	state = inet_sk_state_load(sk);
+	if (state == DCCP_LISTEN)
 		return inet_csk_listen_poll(sk);
 
 	/* Socket is not locked. We are protected from async events
@@ -341,20 +345,21 @@ __poll_t dccp_poll(struct file *file, struct socket *sock,
 	 */
 
 	mask = 0;
-	if (sk->sk_err)
+	if (READ_ONCE(sk->sk_err))
 		mask = EPOLLERR;
+	shutdown = READ_ONCE(sk->sk_shutdown);
 
-	if (sk->sk_shutdown == SHUTDOWN_MASK || sk->sk_state == DCCP_CLOSED)
+	if (shutdown == SHUTDOWN_MASK || state == DCCP_CLOSED)
 		mask |= EPOLLHUP;
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
+	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	/* Connected? */
-	if ((1 << sk->sk_state) & ~(DCCPF_REQUESTING | DCCPF_RESPOND)) {
+	if ((1 << state) & ~(DCCPF_REQUESTING | DCCPF_RESPOND)) {
 		if (atomic_read(&sk->sk_rmem_alloc) > 0)
 			mask |= EPOLLIN | EPOLLRDNORM;
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
+		if (!(shutdown & SEND_SHUTDOWN)) {
 			if (sk_stream_is_writeable(sk)) {
 				mask |= EPOLLOUT | EPOLLWRNORM;
 			} else {  /* send SIGIO later */
@@ -372,7 +377,6 @@ __poll_t dccp_poll(struct file *file, struct socket *sock,
 	}
 	return mask;
 }
-
 EXPORT_SYMBOL_GPL(dccp_poll);
 
 int dccp_ioctl(struct sock *sk, int cmd, unsigned long arg)
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 15c71b08c2df..a3536dfe9b16 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -319,12 +319,12 @@ static netdev_tx_t vti_tunnel_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET);
 		break;
 	case htons(ETH_P_IPV6):
-		xfrm_decode_session(skb, &fl, AF_INET6);
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET6);
 		break;
 	default:
 		goto tx_err;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 84069db0423a..d8d28ba169b4 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -549,7 +549,9 @@ void tcp_retransmit_timer(struct sock *sk)
 	    tcp_stream_is_thin(tp) &&
 	    icsk->icsk_retransmits <= TCP_THIN_LINEAR_RETRIES) {
 		icsk->icsk_backoff = 0;
-		icsk->icsk_rto = min(__tcp_set_rto(tp), TCP_RTO_MAX);
+		icsk->icsk_rto = clamp(__tcp_set_rto(tp),
+				       tcp_rto_min(sk),
+				       TCP_RTO_MAX);
 	} else {
 		/* Use normal (exponential) backoff */
 		icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 866ce815625e..a64050e77588 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -562,12 +562,12 @@ vti6_tnl_xmit(struct sk_buff *skb, struct net_device *dev)
 		    vti6_addr_conflict(t, ipv6_hdr(skb)))
 			goto tx_err;
 
-		xfrm_decode_session(skb, &fl, AF_INET6);
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET6);
 		break;
 	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET);
 		break;
 	default:
 		goto tx_err;
diff --git a/net/key/af_key.c b/net/key/af_key.c
index b8456e2f1167..47ffa69ca6f6 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1858,9 +1858,9 @@ static int pfkey_dump(struct sock *sk, struct sk_buff *skb, const struct sadb_ms
 	if (ext_hdrs[SADB_X_EXT_FILTER - 1]) {
 		struct sadb_x_filter *xfilter = ext_hdrs[SADB_X_EXT_FILTER - 1];
 
-		if ((xfilter->sadb_x_filter_splen >=
+		if ((xfilter->sadb_x_filter_splen >
 			(sizeof(xfrm_address_t) << 3)) ||
-		    (xfilter->sadb_x_filter_dplen >=
+		    (xfilter->sadb_x_filter_dplen >
 			(sizeof(xfrm_address_t) << 3))) {
 			mutex_unlock(&pfk->dump_lock);
 			return -EINVAL;
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 3bf8d7f3cdc3..0909f32eabfd 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1656,6 +1656,7 @@ static int ip_vs_zero_all(struct netns_ipvs *ipvs)
 #ifdef CONFIG_SYSCTL
 
 static int zero;
+static int one = 1;
 static int three = 3;
 
 static int
@@ -1667,12 +1668,18 @@ proc_do_defense_mode(struct ctl_table *table, int write,
 	int val = *valp;
 	int rc;
 
-	rc = proc_dointvec(table, write, buffer, lenp, ppos);
+	struct ctl_table tmp = {
+		.data = &val,
+		.maxlen = sizeof(int),
+		.mode = table->mode,
+	};
+
+	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);
 	if (write && (*valp != val)) {
-		if ((*valp < 0) || (*valp > 3)) {
-			/* Restore the correct value */
-			*valp = val;
+		if (val < 0 || val > 3) {
+			rc = -EINVAL;
 		} else {
+			*valp = val;
 			update_defense_level(ipvs);
 		}
 	}
@@ -1683,37 +1690,27 @@ static int
 proc_do_sync_threshold(struct ctl_table *table, int write,
 		       void __user *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
 	int val[2];
 	int rc;
+	struct ctl_table tmp = {
+		.data = &val,
+		.maxlen = table->maxlen,
+		.mode = table->mode,
+	};
 
-	/* backup the value first */
+	mutex_lock(&ipvs->sync_mutex);
 	memcpy(val, valp, sizeof(val));
-
-	rc = proc_dointvec(table, write, buffer, lenp, ppos);
-	if (write && (valp[0] < 0 || valp[1] < 0 ||
-	    (valp[0] >= valp[1] && valp[1]))) {
-		/* Restore the correct value */
-		memcpy(valp, val, sizeof(val));
-	}
-	return rc;
-}
-
-static int
-proc_do_sync_mode(struct ctl_table *table, int write,
-		     void __user *buffer, size_t *lenp, loff_t *ppos)
-{
-	int *valp = table->data;
-	int val = *valp;
-	int rc;
-
-	rc = proc_dointvec(table, write, buffer, lenp, ppos);
-	if (write && (*valp != val)) {
-		if ((*valp < 0) || (*valp > 1)) {
-			/* Restore the correct value */
-			*valp = val;
-		}
+	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);
+	if (write) {
+		if (val[0] < 0 || val[1] < 0 ||
+		    (val[0] >= val[1] && val[1]))
+			rc = -EINVAL;
+		else
+			memcpy(valp, val, sizeof(val));
 	}
+	mutex_unlock(&ipvs->sync_mutex);
 	return rc;
 }
 
@@ -1725,12 +1722,18 @@ proc_do_sync_ports(struct ctl_table *table, int write,
 	int val = *valp;
 	int rc;
 
-	rc = proc_dointvec(table, write, buffer, lenp, ppos);
+	struct ctl_table tmp = {
+		.data = &val,
+		.maxlen = sizeof(int),
+		.mode = table->mode,
+	};
+
+	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);
 	if (write && (*valp != val)) {
-		if (*valp < 1 || !is_power_of_2(*valp)) {
-			/* Restore the correct value */
+		if (val < 1 || !is_power_of_2(val))
+			rc = -EINVAL;
+		else
 			*valp = val;
-		}
 	}
 	return rc;
 }
@@ -1790,7 +1793,9 @@ static struct ctl_table vs_vars[] = {
 		.procname	= "sync_version",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_do_sync_mode,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &one,
 	},
 	{
 		.procname	= "sync_ports",
@@ -3942,6 +3947,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	ipvs->sysctl_sync_threshold[0] = DEFAULT_SYNC_THRESHOLD;
 	ipvs->sysctl_sync_threshold[1] = DEFAULT_SYNC_PERIOD;
 	tbl[idx].data = &ipvs->sysctl_sync_threshold;
+	tbl[idx].extra2 = ipvs;
 	tbl[idx++].maxlen = sizeof(ipvs->sysctl_sync_threshold);
 	ipvs->sysctl_sync_refresh_period = DEFAULT_SYNC_REFRESH_PERIOD;
 	tbl[idx++].data = &ipvs->sysctl_sync_refresh_period;
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index cadeb22a48f2..8453e92936ac 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -58,8 +58,8 @@ static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] = {
 	[SCTP_CONNTRACK_COOKIE_WAIT]		= 3 SECS,
 	[SCTP_CONNTRACK_COOKIE_ECHOED]		= 3 SECS,
 	[SCTP_CONNTRACK_ESTABLISHED]		= 5 DAYS,
-	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= 300 SECS / 1000,
-	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= 300 SECS / 1000,
+	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= 3 SECS,
+	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= 3 SECS,
 	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	= 3 SECS,
 	[SCTP_CONNTRACK_HEARTBEAT_SENT]		= 30 SECS,
 	[SCTP_CONNTRACK_HEARTBEAT_ACKED]	= 210 SECS,
@@ -119,7 +119,7 @@ static const u8 sctp_conntracks[2][11][SCTP_CONNTRACK_MAX] = {
 	{
 /*	ORIGINAL	*/
 /*                  sNO, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS, sHA */
-/* init         */ {sCW, sCW, sCW, sCE, sES, sSS, sSR, sSA, sCW, sHA},
+/* init         */ {sCW, sCW, sCW, sCE, sES, sCL, sCL, sSA, sCW, sHA},
 /* init_ack     */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL, sHA},
 /* abort        */ {sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL},
 /* shutdown     */ {sCL, sCL, sCW, sCE, sSS, sSS, sSR, sSA, sCL, sSS},
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 84c59de27882..b3a0385290a1 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -93,8 +93,6 @@ bool nf_queue_entry_get_refs(struct nf_queue_entry *entry)
 		dev_hold(state->in);
 	if (state->out)
 		dev_hold(state->out);
-	if (state->sk)
-		sock_hold(state->sk);
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	if (entry->skb->nf_bridge) {
 		struct net_device *physdev;
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 651c9784904c..a4c6aba7da7e 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -144,6 +144,9 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
+	if (set->flags & NFT_SET_OBJECT)
+		return -EOPNOTSUPP;
+
 	if (set->ops->update == NULL)
 		return -EOPNOTSUPP;
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 5a0e71873e24..8105563593b6 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1438,10 +1438,28 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	return 0;
 }
 
+static bool req_create_or_replace(struct nlmsghdr *n)
+{
+	return (n->nlmsg_flags & NLM_F_CREATE &&
+		n->nlmsg_flags & NLM_F_REPLACE);
+}
+
+static bool req_create_exclusive(struct nlmsghdr *n)
+{
+	return (n->nlmsg_flags & NLM_F_CREATE &&
+		n->nlmsg_flags & NLM_F_EXCL);
+}
+
+static bool req_change(struct nlmsghdr *n)
+{
+	return (!(n->nlmsg_flags & NLM_F_CREATE) &&
+		!(n->nlmsg_flags & NLM_F_REPLACE) &&
+		!(n->nlmsg_flags & NLM_F_EXCL));
+}
+
 /*
  * Create/change qdisc.
  */
-
 static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 			   struct netlink_ext_ack *extack)
 {
@@ -1538,27 +1556,35 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				 *
 				 *   We know, that some child q is already
 				 *   attached to this parent and have choice:
-				 *   either to change it or to create/graft new one.
+				 *   1) change it or 2) create/graft new one.
+				 *   If the requested qdisc kind is different
+				 *   than the existing one, then we choose graft.
+				 *   If they are the same then this is "change"
+				 *   operation - just let it fallthrough..
 				 *
 				 *   1. We are allowed to create/graft only
-				 *   if CREATE and REPLACE flags are set.
+				 *   if the request is explicitly stating
+				 *   "please create if it doesn't exist".
 				 *
-				 *   2. If EXCL is set, requestor wanted to say,
-				 *   that qdisc tcm_handle is not expected
+				 *   2. If the request is to exclusive create
+				 *   then the qdisc tcm_handle is not expected
 				 *   to exist, so that we choose create/graft too.
 				 *
 				 *   3. The last case is when no flags are set.
+				 *   This will happen when for example tc
+				 *   utility issues a "change" command.
 				 *   Alas, it is sort of hole in API, we
 				 *   cannot decide what to do unambiguously.
-				 *   For now we select create/graft, if
-				 *   user gave KIND, which does not match existing.
+				 *   For now we select create/graft.
 				 */
-				if ((n->nlmsg_flags & NLM_F_CREATE) &&
-				    (n->nlmsg_flags & NLM_F_REPLACE) &&
-				    ((n->nlmsg_flags & NLM_F_EXCL) ||
-				     (tca[TCA_KIND] &&
-				      nla_strcmp(tca[TCA_KIND], q->ops->id))))
-					goto create_n_graft;
+				if (tca[TCA_KIND] &&
+				    nla_strcmp(tca[TCA_KIND], q->ops->id)) {
+					if (req_create_or_replace(n) ||
+					    req_create_exclusive(n))
+						goto create_n_graft;
+					else if (req_change(n))
+						goto create_n_graft2;
+				}
 			}
 		}
 	} else {
@@ -1592,6 +1618,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		NL_SET_ERR_MSG(extack, "Qdisc not found. To create specify NLM_F_CREATE flag");
 		return -ENOENT;
 	}
+create_n_graft2:
 	if (clid == TC_H_INGRESS) {
 		if (dev_ingress_queue(dev)) {
 			q = qdisc_create(dev, dev_ingress_queue(dev), p,
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index baa825751c39..432dccd37506 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -112,7 +112,7 @@ struct percpu_counter sctp_sockets_allocated;
 
 static void sctp_enter_memory_pressure(struct sock *sk)
 {
-	sctp_memory_pressure = 1;
+	WRITE_ONCE(sctp_memory_pressure, 1);
 }
 
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 8971341c4f8a..402060cf3198 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1984,6 +1984,7 @@ static ssize_t unix_stream_sendpage(struct socket *socket, struct page *page,
 
 	if (false) {
 alloc_skb:
+		spin_unlock(&other->sk_receive_queue.lock);
 		unix_state_unlock(other);
 		mutex_unlock(&unix_sk(other)->iolock);
 		newskb = sock_alloc_send_pskb(sk, 0, 0, flags & MSG_DONTWAIT,
@@ -2023,6 +2024,7 @@ static ssize_t unix_stream_sendpage(struct socket *socket, struct page *page,
 		init_scm = false;
 	}
 
+	spin_lock(&other->sk_receive_queue.lock);
 	skb = skb_peek_tail(&other->sk_receive_queue);
 	if (tail && tail == skb) {
 		skb = newskb;
@@ -2053,14 +2055,11 @@ static ssize_t unix_stream_sendpage(struct socket *socket, struct page *page,
 	refcount_add(size, &sk->sk_wmem_alloc);
 
 	if (newskb) {
-		err = unix_scm_to_skb(&scm, skb, false);
-		if (err)
-			goto err_state_unlock;
-		spin_lock(&other->sk_receive_queue.lock);
+		unix_scm_to_skb(&scm, skb, false);
 		__skb_queue_tail(&other->sk_receive_queue, newskb);
-		spin_unlock(&other->sk_receive_queue.lock);
 	}
 
+	spin_unlock(&other->sk_receive_queue.lock);
 	unix_state_unlock(other);
 	mutex_unlock(&unix_sk(other)->iolock);
 
diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
index fbc4552d17b8..6e5e307f985e 100644
--- a/net/xfrm/Makefile
+++ b/net/xfrm/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the XFRM subsystem.
 #
 
+xfrm_interface-$(CONFIG_XFRM_INTERFACE) += xfrm_interface_core.o
+
 obj-$(CONFIG_XFRM) := xfrm_policy.o xfrm_state.o xfrm_hash.o \
 		      xfrm_input.o xfrm_output.o \
 		      xfrm_sysctl.o xfrm_replay.o xfrm_device.o
diff --git a/net/xfrm/xfrm_interface.c b/net/xfrm/xfrm_interface.c
deleted file mode 100644
index 3c642328a117..000000000000
--- a/net/xfrm/xfrm_interface.c
+++ /dev/null
@@ -1,996 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	XFRM virtual interface
- *
- *	Copyright (C) 2018 secunet Security Networks AG
- *
- *	Author:
- *	Steffen Klassert <steffen.klassert@secunet.com>
- */
-
-#include <linux/module.h>
-#include <linux/capability.h>
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/sockios.h>
-#include <linux/icmp.h>
-#include <linux/if.h>
-#include <linux/in.h>
-#include <linux/ip.h>
-#include <linux/net.h>
-#include <linux/in6.h>
-#include <linux/netdevice.h>
-#include <linux/if_link.h>
-#include <linux/if_arp.h>
-#include <linux/icmpv6.h>
-#include <linux/init.h>
-#include <linux/route.h>
-#include <linux/rtnetlink.h>
-#include <linux/netfilter_ipv6.h>
-#include <linux/slab.h>
-#include <linux/hash.h>
-
-#include <linux/uaccess.h>
-#include <linux/atomic.h>
-
-#include <net/icmp.h>
-#include <net/ip.h>
-#include <net/ipv6.h>
-#include <net/ip6_route.h>
-#include <net/addrconf.h>
-#include <net/xfrm.h>
-#include <net/net_namespace.h>
-#include <net/netns/generic.h>
-#include <linux/etherdevice.h>
-
-static int xfrmi_dev_init(struct net_device *dev);
-static void xfrmi_dev_setup(struct net_device *dev);
-static struct rtnl_link_ops xfrmi_link_ops __read_mostly;
-static unsigned int xfrmi_net_id __read_mostly;
-
-struct xfrmi_net {
-	/* lists for storing interfaces in use */
-	struct xfrm_if __rcu *xfrmi[1];
-};
-
-#define for_each_xfrmi_rcu(start, xi) \
-	for (xi = rcu_dereference(start); xi; xi = rcu_dereference(xi->next))
-
-static struct xfrm_if *xfrmi_lookup(struct net *net, struct xfrm_state *x)
-{
-	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
-	struct xfrm_if *xi;
-
-	for_each_xfrmi_rcu(xfrmn->xfrmi[0], xi) {
-		if (x->if_id == xi->p.if_id &&
-		    (xi->dev->flags & IFF_UP))
-			return xi;
-	}
-
-	return NULL;
-}
-
-static struct xfrm_if *xfrmi_decode_session(struct sk_buff *skb,
-					    unsigned short family)
-{
-	struct xfrmi_net *xfrmn;
-	struct xfrm_if *xi;
-	int ifindex = 0;
-
-	if (!secpath_exists(skb) || !skb->dev)
-		return NULL;
-
-	switch (family) {
-	case AF_INET6:
-		ifindex = inet6_sdif(skb);
-		break;
-	case AF_INET:
-		ifindex = inet_sdif(skb);
-		break;
-	}
-	if (!ifindex)
-		ifindex = skb->dev->ifindex;
-
-	xfrmn = net_generic(xs_net(xfrm_input_state(skb)), xfrmi_net_id);
-
-	for_each_xfrmi_rcu(xfrmn->xfrmi[0], xi) {
-		if (ifindex == xi->dev->ifindex &&
-			(xi->dev->flags & IFF_UP))
-				return xi;
-	}
-
-	return NULL;
-}
-
-static void xfrmi_link(struct xfrmi_net *xfrmn, struct xfrm_if *xi)
-{
-	struct xfrm_if __rcu **xip = &xfrmn->xfrmi[0];
-
-	rcu_assign_pointer(xi->next , rtnl_dereference(*xip));
-	rcu_assign_pointer(*xip, xi);
-}
-
-static void xfrmi_unlink(struct xfrmi_net *xfrmn, struct xfrm_if *xi)
-{
-	struct xfrm_if __rcu **xip;
-	struct xfrm_if *iter;
-
-	for (xip = &xfrmn->xfrmi[0];
-	     (iter = rtnl_dereference(*xip)) != NULL;
-	     xip = &iter->next) {
-		if (xi == iter) {
-			rcu_assign_pointer(*xip, xi->next);
-			break;
-		}
-	}
-}
-
-static void xfrmi_dev_free(struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-
-	gro_cells_destroy(&xi->gro_cells);
-	free_percpu(dev->tstats);
-}
-
-static int xfrmi_create(struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-	struct net *net = dev_net(dev);
-	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
-	int err;
-
-	dev->rtnl_link_ops = &xfrmi_link_ops;
-	err = register_netdevice(dev);
-	if (err < 0)
-		goto out;
-
-	dev_hold(dev);
-	xfrmi_link(xfrmn, xi);
-
-	return 0;
-
-out:
-	return err;
-}
-
-static struct xfrm_if *xfrmi_locate(struct net *net, struct xfrm_if_parms *p)
-{
-	struct xfrm_if __rcu **xip;
-	struct xfrm_if *xi;
-	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
-
-	for (xip = &xfrmn->xfrmi[0];
-	     (xi = rtnl_dereference(*xip)) != NULL;
-	     xip = &xi->next)
-		if (xi->p.if_id == p->if_id)
-			return xi;
-
-	return NULL;
-}
-
-static void xfrmi_dev_uninit(struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-	struct xfrmi_net *xfrmn = net_generic(xi->net, xfrmi_net_id);
-
-	xfrmi_unlink(xfrmn, xi);
-	dev_put(dev);
-}
-
-static void xfrmi_scrub_packet(struct sk_buff *skb, bool xnet)
-{
-	skb->tstamp = 0;
-	skb->pkt_type = PACKET_HOST;
-	skb->skb_iif = 0;
-	skb->ignore_df = 0;
-	skb_dst_drop(skb);
-	nf_reset(skb);
-	nf_reset_trace(skb);
-
-	if (!xnet)
-		return;
-
-	ipvs_reset(skb);
-	secpath_reset(skb);
-	skb_orphan(skb);
-	skb->mark = 0;
-}
-
-static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
-{
-	struct pcpu_sw_netstats *tstats;
-	struct xfrm_mode *inner_mode;
-	struct net_device *dev;
-	struct xfrm_state *x;
-	struct xfrm_if *xi;
-	bool xnet;
-
-	if (err && !skb->sp)
-		return 0;
-
-	x = xfrm_input_state(skb);
-
-	xi = xfrmi_lookup(xs_net(x), x);
-	if (!xi)
-		return 1;
-
-	dev = xi->dev;
-	skb->dev = dev;
-
-	if (err) {
-		dev->stats.rx_errors++;
-		dev->stats.rx_dropped++;
-
-		return 0;
-	}
-
-	xnet = !net_eq(xi->net, dev_net(skb->dev));
-
-	if (xnet) {
-		inner_mode = x->inner_mode;
-
-		if (x->sel.family == AF_UNSPEC) {
-			inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
-			if (inner_mode == NULL) {
-				XFRM_INC_STATS(dev_net(skb->dev),
-					       LINUX_MIB_XFRMINSTATEMODEERROR);
-				return -EINVAL;
-			}
-		}
-
-		if (!xfrm_policy_check(NULL, XFRM_POLICY_IN, skb,
-				       inner_mode->afinfo->family))
-			return -EPERM;
-	}
-
-	xfrmi_scrub_packet(skb, xnet);
-
-	tstats = this_cpu_ptr(dev->tstats);
-
-	u64_stats_update_begin(&tstats->syncp);
-	tstats->rx_packets++;
-	tstats->rx_bytes += skb->len;
-	u64_stats_update_end(&tstats->syncp);
-
-	return 0;
-}
-
-static int
-xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device_stats *stats = &xi->dev->stats;
-	struct dst_entry *dst = skb_dst(skb);
-	unsigned int length = skb->len;
-	struct net_device *tdev;
-	struct xfrm_state *x;
-	int err = -1;
-	int mtu;
-
-	dst_hold(dst);
-	dst = xfrm_lookup_with_ifid(xi->net, dst, fl, NULL, 0, xi->p.if_id);
-	if (IS_ERR(dst)) {
-		err = PTR_ERR(dst);
-		dst = NULL;
-		goto tx_err_link_failure;
-	}
-
-	x = dst->xfrm;
-	if (!x)
-		goto tx_err_link_failure;
-
-	if (x->if_id != xi->p.if_id)
-		goto tx_err_link_failure;
-
-	tdev = dst->dev;
-
-	if (tdev == dev) {
-		stats->collisions++;
-		net_warn_ratelimited("%s: Local routing loop detected!\n",
-				     dev->name);
-		goto tx_err_dst_release;
-	}
-
-	mtu = dst_mtu(dst);
-	if (skb->len > mtu) {
-		skb_dst_update_pmtu_no_confirm(skb, mtu);
-
-		if (skb->protocol == htons(ETH_P_IPV6)) {
-			if (mtu < IPV6_MIN_MTU)
-				mtu = IPV6_MIN_MTU;
-
-			if (skb->len > 1280)
-				icmpv6_ndo_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
-			else
-				goto xmit;
-		} else {
-			if (!(ip_hdr(skb)->frag_off & htons(IP_DF)))
-				goto xmit;
-			icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
-				      htonl(mtu));
-		}
-
-		dst_release(dst);
-		return -EMSGSIZE;
-	}
-
-xmit:
-	xfrmi_scrub_packet(skb, !net_eq(xi->net, dev_net(dev)));
-	skb_dst_set(skb, dst);
-	skb->dev = tdev;
-
-	err = dst_output(xi->net, skb->sk, skb);
-	if (net_xmit_eval(err) == 0) {
-		struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
-
-		u64_stats_update_begin(&tstats->syncp);
-		tstats->tx_bytes += length;
-		tstats->tx_packets++;
-		u64_stats_update_end(&tstats->syncp);
-	} else {
-		stats->tx_errors++;
-		stats->tx_aborted_errors++;
-	}
-
-	return 0;
-tx_err_link_failure:
-	stats->tx_carrier_errors++;
-	dst_link_failure(skb);
-tx_err_dst_release:
-	dst_release(dst);
-	return err;
-}
-
-static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device_stats *stats = &xi->dev->stats;
-	struct dst_entry *dst = skb_dst(skb);
-	struct flowi fl;
-	int ret;
-
-	memset(&fl, 0, sizeof(fl));
-
-	switch (skb->protocol) {
-	case htons(ETH_P_IPV6):
-		xfrm_decode_session(skb, &fl, AF_INET6);
-		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
-		if (!dst) {
-			fl.u.ip6.flowi6_oif = dev->ifindex;
-			fl.u.ip6.flowi6_flags |= FLOWI_FLAG_ANYSRC;
-			dst = ip6_route_output(dev_net(dev), NULL, &fl.u.ip6);
-			if (dst->error) {
-				dst_release(dst);
-				stats->tx_carrier_errors++;
-				goto tx_err;
-			}
-			skb_dst_set(skb, dst);
-		}
-		break;
-	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
-		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
-		if (!dst) {
-			struct rtable *rt;
-
-			fl.u.ip4.flowi4_oif = dev->ifindex;
-			fl.u.ip4.flowi4_flags |= FLOWI_FLAG_ANYSRC;
-			rt = __ip_route_output_key(dev_net(dev), &fl.u.ip4);
-			if (IS_ERR(rt)) {
-				stats->tx_carrier_errors++;
-				goto tx_err;
-			}
-			skb_dst_set(skb, &rt->dst);
-		}
-		break;
-	default:
-		goto tx_err;
-	}
-
-	fl.flowi_oif = xi->p.link;
-
-	ret = xfrmi_xmit2(skb, dev, &fl);
-	if (ret < 0)
-		goto tx_err;
-
-	return NETDEV_TX_OK;
-
-tx_err:
-	stats->tx_errors++;
-	stats->tx_dropped++;
-	kfree_skb(skb);
-	return NETDEV_TX_OK;
-}
-
-static int xfrmi4_err(struct sk_buff *skb, u32 info)
-{
-	const struct iphdr *iph = (const struct iphdr *)skb->data;
-	struct net *net = dev_net(skb->dev);
-	int protocol = iph->protocol;
-	struct ip_comp_hdr *ipch;
-	struct ip_esp_hdr *esph;
-	struct ip_auth_hdr *ah ;
-	struct xfrm_state *x;
-	struct xfrm_if *xi;
-	__be32 spi;
-
-	switch (protocol) {
-	case IPPROTO_ESP:
-		esph = (struct ip_esp_hdr *)(skb->data+(iph->ihl<<2));
-		spi = esph->spi;
-		break;
-	case IPPROTO_AH:
-		ah = (struct ip_auth_hdr *)(skb->data+(iph->ihl<<2));
-		spi = ah->spi;
-		break;
-	case IPPROTO_COMP:
-		ipch = (struct ip_comp_hdr *)(skb->data+(iph->ihl<<2));
-		spi = htonl(ntohs(ipch->cpi));
-		break;
-	default:
-		return 0;
-	}
-
-	switch (icmp_hdr(skb)->type) {
-	case ICMP_DEST_UNREACH:
-		if (icmp_hdr(skb)->code != ICMP_FRAG_NEEDED)
-			return 0;
-	case ICMP_REDIRECT:
-		break;
-	default:
-		return 0;
-	}
-
-	x = xfrm_state_lookup(net, skb->mark, (const xfrm_address_t *)&iph->daddr,
-			      spi, protocol, AF_INET);
-	if (!x)
-		return 0;
-
-	xi = xfrmi_lookup(net, x);
-	if (!xi) {
-		xfrm_state_put(x);
-		return -1;
-	}
-
-	if (icmp_hdr(skb)->type == ICMP_DEST_UNREACH)
-		ipv4_update_pmtu(skb, net, info, 0, 0, protocol, 0);
-	else
-		ipv4_redirect(skb, net, 0, 0, protocol, 0);
-	xfrm_state_put(x);
-
-	return 0;
-}
-
-static int xfrmi6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
-		    u8 type, u8 code, int offset, __be32 info)
-{
-	const struct ipv6hdr *iph = (const struct ipv6hdr *)skb->data;
-	struct net *net = dev_net(skb->dev);
-	int protocol = iph->nexthdr;
-	struct ip_comp_hdr *ipch;
-	struct ip_esp_hdr *esph;
-	struct ip_auth_hdr *ah;
-	struct xfrm_state *x;
-	struct xfrm_if *xi;
-	__be32 spi;
-
-	switch (protocol) {
-	case IPPROTO_ESP:
-		esph = (struct ip_esp_hdr *)(skb->data + offset);
-		spi = esph->spi;
-		break;
-	case IPPROTO_AH:
-		ah = (struct ip_auth_hdr *)(skb->data + offset);
-		spi = ah->spi;
-		break;
-	case IPPROTO_COMP:
-		ipch = (struct ip_comp_hdr *)(skb->data + offset);
-		spi = htonl(ntohs(ipch->cpi));
-		break;
-	default:
-		return 0;
-	}
-
-	if (type != ICMPV6_PKT_TOOBIG &&
-	    type != NDISC_REDIRECT)
-		return 0;
-
-	x = xfrm_state_lookup(net, skb->mark, (const xfrm_address_t *)&iph->daddr,
-			      spi, protocol, AF_INET6);
-	if (!x)
-		return 0;
-
-	xi = xfrmi_lookup(net, x);
-	if (!xi) {
-		xfrm_state_put(x);
-		return -1;
-	}
-
-	if (type == NDISC_REDIRECT)
-		ip6_redirect(skb, net, skb->dev->ifindex, 0,
-			     sock_net_uid(net, NULL));
-	else
-		ip6_update_pmtu(skb, net, info, 0, 0, sock_net_uid(net, NULL));
-	xfrm_state_put(x);
-
-	return 0;
-}
-
-static int xfrmi_change(struct xfrm_if *xi, const struct xfrm_if_parms *p)
-{
-	if (xi->p.link != p->link)
-		return -EINVAL;
-
-	xi->p.if_id = p->if_id;
-
-	return 0;
-}
-
-static int xfrmi_update(struct xfrm_if *xi, struct xfrm_if_parms *p)
-{
-	struct net *net = xi->net;
-	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
-	int err;
-
-	xfrmi_unlink(xfrmn, xi);
-	synchronize_net();
-	err = xfrmi_change(xi, p);
-	xfrmi_link(xfrmn, xi);
-	netdev_state_change(xi->dev);
-	return err;
-}
-
-static void xfrmi_get_stats64(struct net_device *dev,
-			       struct rtnl_link_stats64 *s)
-{
-	int cpu;
-
-	if (!dev->tstats)
-		return;
-
-	for_each_possible_cpu(cpu) {
-		struct pcpu_sw_netstats *stats;
-		struct pcpu_sw_netstats tmp;
-		int start;
-
-		stats = per_cpu_ptr(dev->tstats, cpu);
-		do {
-			start = u64_stats_fetch_begin_irq(&stats->syncp);
-			tmp.rx_packets = stats->rx_packets;
-			tmp.rx_bytes   = stats->rx_bytes;
-			tmp.tx_packets = stats->tx_packets;
-			tmp.tx_bytes   = stats->tx_bytes;
-		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
-
-		s->rx_packets += tmp.rx_packets;
-		s->rx_bytes   += tmp.rx_bytes;
-		s->tx_packets += tmp.tx_packets;
-		s->tx_bytes   += tmp.tx_bytes;
-	}
-
-	s->rx_dropped = dev->stats.rx_dropped;
-	s->tx_dropped = dev->stats.tx_dropped;
-}
-
-static int xfrmi_get_iflink(const struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-
-	return xi->p.link;
-}
-
-
-static const struct net_device_ops xfrmi_netdev_ops = {
-	.ndo_init	= xfrmi_dev_init,
-	.ndo_uninit	= xfrmi_dev_uninit,
-	.ndo_start_xmit = xfrmi_xmit,
-	.ndo_get_stats64 = xfrmi_get_stats64,
-	.ndo_get_iflink = xfrmi_get_iflink,
-};
-
-static void xfrmi_dev_setup(struct net_device *dev)
-{
-	dev->netdev_ops 	= &xfrmi_netdev_ops;
-	dev->type		= ARPHRD_NONE;
-	dev->mtu		= ETH_DATA_LEN;
-	dev->min_mtu		= ETH_MIN_MTU;
-	dev->max_mtu		= IP_MAX_MTU;
-	dev->flags 		= IFF_NOARP;
-	dev->needs_free_netdev	= true;
-	dev->priv_destructor	= xfrmi_dev_free;
-	netif_keep_dst(dev);
-
-	eth_broadcast_addr(dev->broadcast);
-}
-
-static int xfrmi_dev_init(struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device *phydev = __dev_get_by_index(xi->net, xi->p.link);
-	int err;
-
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
-	err = gro_cells_init(&xi->gro_cells, dev);
-	if (err) {
-		free_percpu(dev->tstats);
-		return err;
-	}
-
-	dev->features |= NETIF_F_LLTX;
-
-	if (phydev) {
-		dev->needed_headroom = phydev->needed_headroom;
-		dev->needed_tailroom = phydev->needed_tailroom;
-
-		if (is_zero_ether_addr(dev->dev_addr))
-			eth_hw_addr_inherit(dev, phydev);
-		if (is_zero_ether_addr(dev->broadcast))
-			memcpy(dev->broadcast, phydev->broadcast,
-			       dev->addr_len);
-	} else {
-		eth_hw_addr_random(dev);
-		eth_broadcast_addr(dev->broadcast);
-	}
-
-	return 0;
-}
-
-static int xfrmi_validate(struct nlattr *tb[], struct nlattr *data[],
-			 struct netlink_ext_ack *extack)
-{
-	return 0;
-}
-
-static void xfrmi_netlink_parms(struct nlattr *data[],
-			       struct xfrm_if_parms *parms)
-{
-	memset(parms, 0, sizeof(*parms));
-
-	if (!data)
-		return;
-
-	if (data[IFLA_XFRM_LINK])
-		parms->link = nla_get_u32(data[IFLA_XFRM_LINK]);
-
-	if (data[IFLA_XFRM_IF_ID])
-		parms->if_id = nla_get_u32(data[IFLA_XFRM_IF_ID]);
-}
-
-static int xfrmi_newlink(struct net *src_net, struct net_device *dev,
-			struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
-{
-	struct net *net = dev_net(dev);
-	struct xfrm_if_parms p = {};
-	struct xfrm_if *xi;
-	int err;
-
-	xfrmi_netlink_parms(data, &p);
-	if (!p.if_id) {
-		NL_SET_ERR_MSG(extack, "if_id must be non zero");
-		return -EINVAL;
-	}
-
-	xi = xfrmi_locate(net, &p);
-	if (xi)
-		return -EEXIST;
-
-	xi = netdev_priv(dev);
-	xi->p = p;
-	xi->net = net;
-	xi->dev = dev;
-
-	err = xfrmi_create(dev);
-	return err;
-}
-
-static void xfrmi_dellink(struct net_device *dev, struct list_head *head)
-{
-	unregister_netdevice_queue(dev, head);
-}
-
-static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
-			   struct nlattr *data[],
-			   struct netlink_ext_ack *extack)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-	struct net *net = xi->net;
-	struct xfrm_if_parms p = {};
-
-	xfrmi_netlink_parms(data, &p);
-	if (!p.if_id) {
-		NL_SET_ERR_MSG(extack, "if_id must be non zero");
-		return -EINVAL;
-	}
-
-	xi = xfrmi_locate(net, &p);
-	if (!xi) {
-		xi = netdev_priv(dev);
-	} else {
-		if (xi->dev != dev)
-			return -EEXIST;
-	}
-
-	return xfrmi_update(xi, &p);
-}
-
-static size_t xfrmi_get_size(const struct net_device *dev)
-{
-	return
-		/* IFLA_XFRM_LINK */
-		nla_total_size(4) +
-		/* IFLA_XFRM_IF_ID */
-		nla_total_size(4) +
-		0;
-}
-
-static int xfrmi_fill_info(struct sk_buff *skb, const struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-	struct xfrm_if_parms *parm = &xi->p;
-
-	if (nla_put_u32(skb, IFLA_XFRM_LINK, parm->link) ||
-	    nla_put_u32(skb, IFLA_XFRM_IF_ID, parm->if_id))
-		goto nla_put_failure;
-	return 0;
-
-nla_put_failure:
-	return -EMSGSIZE;
-}
-
-struct net *xfrmi_get_link_net(const struct net_device *dev)
-{
-	struct xfrm_if *xi = netdev_priv(dev);
-
-	return xi->net;
-}
-
-static const struct nla_policy xfrmi_policy[IFLA_XFRM_MAX + 1] = {
-	[IFLA_XFRM_LINK]	= { .type = NLA_U32 },
-	[IFLA_XFRM_IF_ID]	= { .type = NLA_U32 },
-};
-
-static struct rtnl_link_ops xfrmi_link_ops __read_mostly = {
-	.kind		= "xfrm",
-	.maxtype	= IFLA_XFRM_MAX,
-	.policy		= xfrmi_policy,
-	.priv_size	= sizeof(struct xfrm_if),
-	.setup		= xfrmi_dev_setup,
-	.validate	= xfrmi_validate,
-	.newlink	= xfrmi_newlink,
-	.dellink	= xfrmi_dellink,
-	.changelink	= xfrmi_changelink,
-	.get_size	= xfrmi_get_size,
-	.fill_info	= xfrmi_fill_info,
-	.get_link_net	= xfrmi_get_link_net,
-};
-
-static void __net_exit xfrmi_destroy_interfaces(struct xfrmi_net *xfrmn)
-{
-	struct xfrm_if *xi;
-	LIST_HEAD(list);
-
-	xi = rtnl_dereference(xfrmn->xfrmi[0]);
-	if (!xi)
-		return;
-
-	unregister_netdevice_queue(xi->dev, &list);
-	unregister_netdevice_many(&list);
-}
-
-static int __net_init xfrmi_init_net(struct net *net)
-{
-	return 0;
-}
-
-static void __net_exit xfrmi_exit_net(struct net *net)
-{
-	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
-
-	rtnl_lock();
-	xfrmi_destroy_interfaces(xfrmn);
-	rtnl_unlock();
-}
-
-static void __net_exit xfrmi_exit_batch_net(struct list_head *net_exit_list)
-{
-	struct net *net;
-	LIST_HEAD(list);
-
-	rtnl_lock();
-	list_for_each_entry(net, net_exit_list, exit_list) {
-		struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
-		struct xfrm_if __rcu **xip;
-		struct xfrm_if *xi;
-
-		for (xip = &xfrmn->xfrmi[0];
-		     (xi = rtnl_dereference(*xip)) != NULL;
-		     xip = &xi->next)
-			unregister_netdevice_queue(xi->dev, &list);
-	}
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
-}
-
-static struct pernet_operations xfrmi_net_ops = {
-	.exit_batch = xfrmi_exit_batch_net,
-	.init = xfrmi_init_net,
-	.exit = xfrmi_exit_net,
-	.id   = &xfrmi_net_id,
-	.size = sizeof(struct xfrmi_net),
-};
-
-static struct xfrm6_protocol xfrmi_esp6_protocol __read_mostly = {
-	.handler	=	xfrm6_rcv,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi6_err,
-	.priority	=	10,
-};
-
-static struct xfrm6_protocol xfrmi_ah6_protocol __read_mostly = {
-	.handler	=	xfrm6_rcv,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi6_err,
-	.priority	=	10,
-};
-
-static struct xfrm6_protocol xfrmi_ipcomp6_protocol __read_mostly = {
-	.handler	=	xfrm6_rcv,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi6_err,
-	.priority	=	10,
-};
-
-static struct xfrm4_protocol xfrmi_esp4_protocol __read_mostly = {
-	.handler	=	xfrm4_rcv,
-	.input_handler	=	xfrm_input,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi4_err,
-	.priority	=	10,
-};
-
-static struct xfrm4_protocol xfrmi_ah4_protocol __read_mostly = {
-	.handler	=	xfrm4_rcv,
-	.input_handler	=	xfrm_input,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi4_err,
-	.priority	=	10,
-};
-
-static struct xfrm4_protocol xfrmi_ipcomp4_protocol __read_mostly = {
-	.handler	=	xfrm4_rcv,
-	.input_handler	=	xfrm_input,
-	.cb_handler	=	xfrmi_rcv_cb,
-	.err_handler	=	xfrmi4_err,
-	.priority	=	10,
-};
-
-static int __init xfrmi4_init(void)
-{
-	int err;
-
-	err = xfrm4_protocol_register(&xfrmi_esp4_protocol, IPPROTO_ESP);
-	if (err < 0)
-		goto xfrm_proto_esp_failed;
-	err = xfrm4_protocol_register(&xfrmi_ah4_protocol, IPPROTO_AH);
-	if (err < 0)
-		goto xfrm_proto_ah_failed;
-	err = xfrm4_protocol_register(&xfrmi_ipcomp4_protocol, IPPROTO_COMP);
-	if (err < 0)
-		goto xfrm_proto_comp_failed;
-
-	return 0;
-
-xfrm_proto_comp_failed:
-	xfrm4_protocol_deregister(&xfrmi_ah4_protocol, IPPROTO_AH);
-xfrm_proto_ah_failed:
-	xfrm4_protocol_deregister(&xfrmi_esp4_protocol, IPPROTO_ESP);
-xfrm_proto_esp_failed:
-	return err;
-}
-
-static void xfrmi4_fini(void)
-{
-	xfrm4_protocol_deregister(&xfrmi_ipcomp4_protocol, IPPROTO_COMP);
-	xfrm4_protocol_deregister(&xfrmi_ah4_protocol, IPPROTO_AH);
-	xfrm4_protocol_deregister(&xfrmi_esp4_protocol, IPPROTO_ESP);
-}
-
-static int __init xfrmi6_init(void)
-{
-	int err;
-
-	err = xfrm6_protocol_register(&xfrmi_esp6_protocol, IPPROTO_ESP);
-	if (err < 0)
-		goto xfrm_proto_esp_failed;
-	err = xfrm6_protocol_register(&xfrmi_ah6_protocol, IPPROTO_AH);
-	if (err < 0)
-		goto xfrm_proto_ah_failed;
-	err = xfrm6_protocol_register(&xfrmi_ipcomp6_protocol, IPPROTO_COMP);
-	if (err < 0)
-		goto xfrm_proto_comp_failed;
-
-	return 0;
-
-xfrm_proto_comp_failed:
-	xfrm6_protocol_deregister(&xfrmi_ah6_protocol, IPPROTO_AH);
-xfrm_proto_ah_failed:
-	xfrm6_protocol_deregister(&xfrmi_esp6_protocol, IPPROTO_ESP);
-xfrm_proto_esp_failed:
-	return err;
-}
-
-static void xfrmi6_fini(void)
-{
-	xfrm6_protocol_deregister(&xfrmi_ipcomp6_protocol, IPPROTO_COMP);
-	xfrm6_protocol_deregister(&xfrmi_ah6_protocol, IPPROTO_AH);
-	xfrm6_protocol_deregister(&xfrmi_esp6_protocol, IPPROTO_ESP);
-}
-
-static const struct xfrm_if_cb xfrm_if_cb = {
-	.decode_session =	xfrmi_decode_session,
-};
-
-static int __init xfrmi_init(void)
-{
-	const char *msg;
-	int err;
-
-	pr_info("IPsec XFRM device driver\n");
-
-	msg = "tunnel device";
-	err = register_pernet_device(&xfrmi_net_ops);
-	if (err < 0)
-		goto pernet_dev_failed;
-
-	msg = "xfrm4 protocols";
-	err = xfrmi4_init();
-	if (err < 0)
-		goto xfrmi4_failed;
-
-	msg = "xfrm6 protocols";
-	err = xfrmi6_init();
-	if (err < 0)
-		goto xfrmi6_failed;
-
-
-	msg = "netlink interface";
-	err = rtnl_link_register(&xfrmi_link_ops);
-	if (err < 0)
-		goto rtnl_link_failed;
-
-	xfrm_if_register_cb(&xfrm_if_cb);
-
-	return err;
-
-rtnl_link_failed:
-	xfrmi6_fini();
-xfrmi6_failed:
-	xfrmi4_fini();
-xfrmi4_failed:
-	unregister_pernet_device(&xfrmi_net_ops);
-pernet_dev_failed:
-	pr_err("xfrmi init: failed to register %s\n", msg);
-	return err;
-}
-
-static void __exit xfrmi_fini(void)
-{
-	xfrm_if_unregister_cb();
-	rtnl_link_unregister(&xfrmi_link_ops);
-	xfrmi4_fini();
-	xfrmi6_fini();
-	unregister_pernet_device(&xfrmi_net_ops);
-}
-
-module_init(xfrmi_init);
-module_exit(xfrmi_fini);
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_RTNL_LINK("xfrm");
-MODULE_ALIAS_NETDEV("xfrm0");
-MODULE_AUTHOR("Steffen Klassert");
-MODULE_DESCRIPTION("XFRM virtual interface");
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
new file mode 100644
index 000000000000..40081af62b68
--- /dev/null
+++ b/net/xfrm/xfrm_interface_core.c
@@ -0,0 +1,996 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *	XFRM virtual interface
+ *
+ *	Copyright (C) 2018 secunet Security Networks AG
+ *
+ *	Author:
+ *	Steffen Klassert <steffen.klassert@secunet.com>
+ */
+
+#include <linux/module.h>
+#include <linux/capability.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/sockios.h>
+#include <linux/icmp.h>
+#include <linux/if.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/net.h>
+#include <linux/in6.h>
+#include <linux/netdevice.h>
+#include <linux/if_link.h>
+#include <linux/if_arp.h>
+#include <linux/icmpv6.h>
+#include <linux/init.h>
+#include <linux/route.h>
+#include <linux/rtnetlink.h>
+#include <linux/netfilter_ipv6.h>
+#include <linux/slab.h>
+#include <linux/hash.h>
+
+#include <linux/uaccess.h>
+#include <linux/atomic.h>
+
+#include <net/icmp.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/ip6_route.h>
+#include <net/addrconf.h>
+#include <net/xfrm.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>
+#include <linux/etherdevice.h>
+
+static int xfrmi_dev_init(struct net_device *dev);
+static void xfrmi_dev_setup(struct net_device *dev);
+static struct rtnl_link_ops xfrmi_link_ops __read_mostly;
+static unsigned int xfrmi_net_id __read_mostly;
+
+struct xfrmi_net {
+	/* lists for storing interfaces in use */
+	struct xfrm_if __rcu *xfrmi[1];
+};
+
+#define for_each_xfrmi_rcu(start, xi) \
+	for (xi = rcu_dereference(start); xi; xi = rcu_dereference(xi->next))
+
+static struct xfrm_if *xfrmi_lookup(struct net *net, struct xfrm_state *x)
+{
+	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
+	struct xfrm_if *xi;
+
+	for_each_xfrmi_rcu(xfrmn->xfrmi[0], xi) {
+		if (x->if_id == xi->p.if_id &&
+		    (xi->dev->flags & IFF_UP))
+			return xi;
+	}
+
+	return NULL;
+}
+
+static struct xfrm_if *xfrmi_decode_session(struct sk_buff *skb,
+					    unsigned short family)
+{
+	struct xfrmi_net *xfrmn;
+	struct xfrm_if *xi;
+	int ifindex = 0;
+
+	if (!secpath_exists(skb) || !skb->dev)
+		return NULL;
+
+	switch (family) {
+	case AF_INET6:
+		ifindex = inet6_sdif(skb);
+		break;
+	case AF_INET:
+		ifindex = inet_sdif(skb);
+		break;
+	}
+	if (!ifindex)
+		ifindex = skb->dev->ifindex;
+
+	xfrmn = net_generic(xs_net(xfrm_input_state(skb)), xfrmi_net_id);
+
+	for_each_xfrmi_rcu(xfrmn->xfrmi[0], xi) {
+		if (ifindex == xi->dev->ifindex &&
+			(xi->dev->flags & IFF_UP))
+				return xi;
+	}
+
+	return NULL;
+}
+
+static void xfrmi_link(struct xfrmi_net *xfrmn, struct xfrm_if *xi)
+{
+	struct xfrm_if __rcu **xip = &xfrmn->xfrmi[0];
+
+	rcu_assign_pointer(xi->next , rtnl_dereference(*xip));
+	rcu_assign_pointer(*xip, xi);
+}
+
+static void xfrmi_unlink(struct xfrmi_net *xfrmn, struct xfrm_if *xi)
+{
+	struct xfrm_if __rcu **xip;
+	struct xfrm_if *iter;
+
+	for (xip = &xfrmn->xfrmi[0];
+	     (iter = rtnl_dereference(*xip)) != NULL;
+	     xip = &iter->next) {
+		if (xi == iter) {
+			rcu_assign_pointer(*xip, xi->next);
+			break;
+		}
+	}
+}
+
+static void xfrmi_dev_free(struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+
+	gro_cells_destroy(&xi->gro_cells);
+	free_percpu(dev->tstats);
+}
+
+static int xfrmi_create(struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+	struct net *net = dev_net(dev);
+	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
+	int err;
+
+	dev->rtnl_link_ops = &xfrmi_link_ops;
+	err = register_netdevice(dev);
+	if (err < 0)
+		goto out;
+
+	dev_hold(dev);
+	xfrmi_link(xfrmn, xi);
+
+	return 0;
+
+out:
+	return err;
+}
+
+static struct xfrm_if *xfrmi_locate(struct net *net, struct xfrm_if_parms *p)
+{
+	struct xfrm_if __rcu **xip;
+	struct xfrm_if *xi;
+	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
+
+	for (xip = &xfrmn->xfrmi[0];
+	     (xi = rtnl_dereference(*xip)) != NULL;
+	     xip = &xi->next)
+		if (xi->p.if_id == p->if_id)
+			return xi;
+
+	return NULL;
+}
+
+static void xfrmi_dev_uninit(struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+	struct xfrmi_net *xfrmn = net_generic(xi->net, xfrmi_net_id);
+
+	xfrmi_unlink(xfrmn, xi);
+	dev_put(dev);
+}
+
+static void xfrmi_scrub_packet(struct sk_buff *skb, bool xnet)
+{
+	skb->tstamp = 0;
+	skb->pkt_type = PACKET_HOST;
+	skb->skb_iif = 0;
+	skb->ignore_df = 0;
+	skb_dst_drop(skb);
+	nf_reset(skb);
+	nf_reset_trace(skb);
+
+	if (!xnet)
+		return;
+
+	ipvs_reset(skb);
+	secpath_reset(skb);
+	skb_orphan(skb);
+	skb->mark = 0;
+}
+
+static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
+{
+	struct pcpu_sw_netstats *tstats;
+	struct xfrm_mode *inner_mode;
+	struct net_device *dev;
+	struct xfrm_state *x;
+	struct xfrm_if *xi;
+	bool xnet;
+
+	if (err && !skb->sp)
+		return 0;
+
+	x = xfrm_input_state(skb);
+
+	xi = xfrmi_lookup(xs_net(x), x);
+	if (!xi)
+		return 1;
+
+	dev = xi->dev;
+	skb->dev = dev;
+
+	if (err) {
+		dev->stats.rx_errors++;
+		dev->stats.rx_dropped++;
+
+		return 0;
+	}
+
+	xnet = !net_eq(xi->net, dev_net(skb->dev));
+
+	if (xnet) {
+		inner_mode = x->inner_mode;
+
+		if (x->sel.family == AF_UNSPEC) {
+			inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
+			if (inner_mode == NULL) {
+				XFRM_INC_STATS(dev_net(skb->dev),
+					       LINUX_MIB_XFRMINSTATEMODEERROR);
+				return -EINVAL;
+			}
+		}
+
+		if (!xfrm_policy_check(NULL, XFRM_POLICY_IN, skb,
+				       inner_mode->afinfo->family))
+			return -EPERM;
+	}
+
+	xfrmi_scrub_packet(skb, xnet);
+
+	tstats = this_cpu_ptr(dev->tstats);
+
+	u64_stats_update_begin(&tstats->syncp);
+	tstats->rx_packets++;
+	tstats->rx_bytes += skb->len;
+	u64_stats_update_end(&tstats->syncp);
+
+	return 0;
+}
+
+static int
+xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+	struct net_device_stats *stats = &xi->dev->stats;
+	struct dst_entry *dst = skb_dst(skb);
+	unsigned int length = skb->len;
+	struct net_device *tdev;
+	struct xfrm_state *x;
+	int err = -1;
+	int mtu;
+
+	dst_hold(dst);
+	dst = xfrm_lookup_with_ifid(xi->net, dst, fl, NULL, 0, xi->p.if_id);
+	if (IS_ERR(dst)) {
+		err = PTR_ERR(dst);
+		dst = NULL;
+		goto tx_err_link_failure;
+	}
+
+	x = dst->xfrm;
+	if (!x)
+		goto tx_err_link_failure;
+
+	if (x->if_id != xi->p.if_id)
+		goto tx_err_link_failure;
+
+	tdev = dst->dev;
+
+	if (tdev == dev) {
+		stats->collisions++;
+		net_warn_ratelimited("%s: Local routing loop detected!\n",
+				     dev->name);
+		goto tx_err_dst_release;
+	}
+
+	mtu = dst_mtu(dst);
+	if (skb->len > mtu) {
+		skb_dst_update_pmtu_no_confirm(skb, mtu);
+
+		if (skb->protocol == htons(ETH_P_IPV6)) {
+			if (mtu < IPV6_MIN_MTU)
+				mtu = IPV6_MIN_MTU;
+
+			if (skb->len > 1280)
+				icmpv6_ndo_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
+			else
+				goto xmit;
+		} else {
+			if (!(ip_hdr(skb)->frag_off & htons(IP_DF)))
+				goto xmit;
+			icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
+				      htonl(mtu));
+		}
+
+		dst_release(dst);
+		return -EMSGSIZE;
+	}
+
+xmit:
+	xfrmi_scrub_packet(skb, !net_eq(xi->net, dev_net(dev)));
+	skb_dst_set(skb, dst);
+	skb->dev = tdev;
+
+	err = dst_output(xi->net, skb->sk, skb);
+	if (net_xmit_eval(err) == 0) {
+		struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
+
+		u64_stats_update_begin(&tstats->syncp);
+		tstats->tx_bytes += length;
+		tstats->tx_packets++;
+		u64_stats_update_end(&tstats->syncp);
+	} else {
+		stats->tx_errors++;
+		stats->tx_aborted_errors++;
+	}
+
+	return 0;
+tx_err_link_failure:
+	stats->tx_carrier_errors++;
+	dst_link_failure(skb);
+tx_err_dst_release:
+	dst_release(dst);
+	return err;
+}
+
+static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+	struct net_device_stats *stats = &xi->dev->stats;
+	struct dst_entry *dst = skb_dst(skb);
+	struct flowi fl;
+	int ret;
+
+	memset(&fl, 0, sizeof(fl));
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IPV6):
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET6);
+		if (!dst) {
+			fl.u.ip6.flowi6_oif = dev->ifindex;
+			fl.u.ip6.flowi6_flags |= FLOWI_FLAG_ANYSRC;
+			dst = ip6_route_output(dev_net(dev), NULL, &fl.u.ip6);
+			if (dst->error) {
+				dst_release(dst);
+				stats->tx_carrier_errors++;
+				goto tx_err;
+			}
+			skb_dst_set(skb, dst);
+		}
+		break;
+	case htons(ETH_P_IP):
+		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET);
+		if (!dst) {
+			struct rtable *rt;
+
+			fl.u.ip4.flowi4_oif = dev->ifindex;
+			fl.u.ip4.flowi4_flags |= FLOWI_FLAG_ANYSRC;
+			rt = __ip_route_output_key(dev_net(dev), &fl.u.ip4);
+			if (IS_ERR(rt)) {
+				stats->tx_carrier_errors++;
+				goto tx_err;
+			}
+			skb_dst_set(skb, &rt->dst);
+		}
+		break;
+	default:
+		goto tx_err;
+	}
+
+	fl.flowi_oif = xi->p.link;
+
+	ret = xfrmi_xmit2(skb, dev, &fl);
+	if (ret < 0)
+		goto tx_err;
+
+	return NETDEV_TX_OK;
+
+tx_err:
+	stats->tx_errors++;
+	stats->tx_dropped++;
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+static int xfrmi4_err(struct sk_buff *skb, u32 info)
+{
+	const struct iphdr *iph = (const struct iphdr *)skb->data;
+	struct net *net = dev_net(skb->dev);
+	int protocol = iph->protocol;
+	struct ip_comp_hdr *ipch;
+	struct ip_esp_hdr *esph;
+	struct ip_auth_hdr *ah ;
+	struct xfrm_state *x;
+	struct xfrm_if *xi;
+	__be32 spi;
+
+	switch (protocol) {
+	case IPPROTO_ESP:
+		esph = (struct ip_esp_hdr *)(skb->data+(iph->ihl<<2));
+		spi = esph->spi;
+		break;
+	case IPPROTO_AH:
+		ah = (struct ip_auth_hdr *)(skb->data+(iph->ihl<<2));
+		spi = ah->spi;
+		break;
+	case IPPROTO_COMP:
+		ipch = (struct ip_comp_hdr *)(skb->data+(iph->ihl<<2));
+		spi = htonl(ntohs(ipch->cpi));
+		break;
+	default:
+		return 0;
+	}
+
+	switch (icmp_hdr(skb)->type) {
+	case ICMP_DEST_UNREACH:
+		if (icmp_hdr(skb)->code != ICMP_FRAG_NEEDED)
+			return 0;
+	case ICMP_REDIRECT:
+		break;
+	default:
+		return 0;
+	}
+
+	x = xfrm_state_lookup(net, skb->mark, (const xfrm_address_t *)&iph->daddr,
+			      spi, protocol, AF_INET);
+	if (!x)
+		return 0;
+
+	xi = xfrmi_lookup(net, x);
+	if (!xi) {
+		xfrm_state_put(x);
+		return -1;
+	}
+
+	if (icmp_hdr(skb)->type == ICMP_DEST_UNREACH)
+		ipv4_update_pmtu(skb, net, info, 0, 0, protocol, 0);
+	else
+		ipv4_redirect(skb, net, 0, 0, protocol, 0);
+	xfrm_state_put(x);
+
+	return 0;
+}
+
+static int xfrmi6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
+		    u8 type, u8 code, int offset, __be32 info)
+{
+	const struct ipv6hdr *iph = (const struct ipv6hdr *)skb->data;
+	struct net *net = dev_net(skb->dev);
+	int protocol = iph->nexthdr;
+	struct ip_comp_hdr *ipch;
+	struct ip_esp_hdr *esph;
+	struct ip_auth_hdr *ah;
+	struct xfrm_state *x;
+	struct xfrm_if *xi;
+	__be32 spi;
+
+	switch (protocol) {
+	case IPPROTO_ESP:
+		esph = (struct ip_esp_hdr *)(skb->data + offset);
+		spi = esph->spi;
+		break;
+	case IPPROTO_AH:
+		ah = (struct ip_auth_hdr *)(skb->data + offset);
+		spi = ah->spi;
+		break;
+	case IPPROTO_COMP:
+		ipch = (struct ip_comp_hdr *)(skb->data + offset);
+		spi = htonl(ntohs(ipch->cpi));
+		break;
+	default:
+		return 0;
+	}
+
+	if (type != ICMPV6_PKT_TOOBIG &&
+	    type != NDISC_REDIRECT)
+		return 0;
+
+	x = xfrm_state_lookup(net, skb->mark, (const xfrm_address_t *)&iph->daddr,
+			      spi, protocol, AF_INET6);
+	if (!x)
+		return 0;
+
+	xi = xfrmi_lookup(net, x);
+	if (!xi) {
+		xfrm_state_put(x);
+		return -1;
+	}
+
+	if (type == NDISC_REDIRECT)
+		ip6_redirect(skb, net, skb->dev->ifindex, 0,
+			     sock_net_uid(net, NULL));
+	else
+		ip6_update_pmtu(skb, net, info, 0, 0, sock_net_uid(net, NULL));
+	xfrm_state_put(x);
+
+	return 0;
+}
+
+static int xfrmi_change(struct xfrm_if *xi, const struct xfrm_if_parms *p)
+{
+	if (xi->p.link != p->link)
+		return -EINVAL;
+
+	xi->p.if_id = p->if_id;
+
+	return 0;
+}
+
+static int xfrmi_update(struct xfrm_if *xi, struct xfrm_if_parms *p)
+{
+	struct net *net = xi->net;
+	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
+	int err;
+
+	xfrmi_unlink(xfrmn, xi);
+	synchronize_net();
+	err = xfrmi_change(xi, p);
+	xfrmi_link(xfrmn, xi);
+	netdev_state_change(xi->dev);
+	return err;
+}
+
+static void xfrmi_get_stats64(struct net_device *dev,
+			       struct rtnl_link_stats64 *s)
+{
+	int cpu;
+
+	if (!dev->tstats)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct pcpu_sw_netstats *stats;
+		struct pcpu_sw_netstats tmp;
+		int start;
+
+		stats = per_cpu_ptr(dev->tstats, cpu);
+		do {
+			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			tmp.rx_packets = stats->rx_packets;
+			tmp.rx_bytes   = stats->rx_bytes;
+			tmp.tx_packets = stats->tx_packets;
+			tmp.tx_bytes   = stats->tx_bytes;
+		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+
+		s->rx_packets += tmp.rx_packets;
+		s->rx_bytes   += tmp.rx_bytes;
+		s->tx_packets += tmp.tx_packets;
+		s->tx_bytes   += tmp.tx_bytes;
+	}
+
+	s->rx_dropped = dev->stats.rx_dropped;
+	s->tx_dropped = dev->stats.tx_dropped;
+}
+
+static int xfrmi_get_iflink(const struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+
+	return xi->p.link;
+}
+
+
+static const struct net_device_ops xfrmi_netdev_ops = {
+	.ndo_init	= xfrmi_dev_init,
+	.ndo_uninit	= xfrmi_dev_uninit,
+	.ndo_start_xmit = xfrmi_xmit,
+	.ndo_get_stats64 = xfrmi_get_stats64,
+	.ndo_get_iflink = xfrmi_get_iflink,
+};
+
+static void xfrmi_dev_setup(struct net_device *dev)
+{
+	dev->netdev_ops 	= &xfrmi_netdev_ops;
+	dev->type		= ARPHRD_NONE;
+	dev->mtu		= ETH_DATA_LEN;
+	dev->min_mtu		= ETH_MIN_MTU;
+	dev->max_mtu		= IP_MAX_MTU;
+	dev->flags 		= IFF_NOARP;
+	dev->needs_free_netdev	= true;
+	dev->priv_destructor	= xfrmi_dev_free;
+	netif_keep_dst(dev);
+
+	eth_broadcast_addr(dev->broadcast);
+}
+
+static int xfrmi_dev_init(struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+	struct net_device *phydev = __dev_get_by_index(xi->net, xi->p.link);
+	int err;
+
+	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!dev->tstats)
+		return -ENOMEM;
+
+	err = gro_cells_init(&xi->gro_cells, dev);
+	if (err) {
+		free_percpu(dev->tstats);
+		return err;
+	}
+
+	dev->features |= NETIF_F_LLTX;
+
+	if (phydev) {
+		dev->needed_headroom = phydev->needed_headroom;
+		dev->needed_tailroom = phydev->needed_tailroom;
+
+		if (is_zero_ether_addr(dev->dev_addr))
+			eth_hw_addr_inherit(dev, phydev);
+		if (is_zero_ether_addr(dev->broadcast))
+			memcpy(dev->broadcast, phydev->broadcast,
+			       dev->addr_len);
+	} else {
+		eth_hw_addr_random(dev);
+		eth_broadcast_addr(dev->broadcast);
+	}
+
+	return 0;
+}
+
+static int xfrmi_validate(struct nlattr *tb[], struct nlattr *data[],
+			 struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static void xfrmi_netlink_parms(struct nlattr *data[],
+			       struct xfrm_if_parms *parms)
+{
+	memset(parms, 0, sizeof(*parms));
+
+	if (!data)
+		return;
+
+	if (data[IFLA_XFRM_LINK])
+		parms->link = nla_get_u32(data[IFLA_XFRM_LINK]);
+
+	if (data[IFLA_XFRM_IF_ID])
+		parms->if_id = nla_get_u32(data[IFLA_XFRM_IF_ID]);
+}
+
+static int xfrmi_newlink(struct net *src_net, struct net_device *dev,
+			struct nlattr *tb[], struct nlattr *data[],
+			struct netlink_ext_ack *extack)
+{
+	struct net *net = dev_net(dev);
+	struct xfrm_if_parms p = {};
+	struct xfrm_if *xi;
+	int err;
+
+	xfrmi_netlink_parms(data, &p);
+	if (!p.if_id) {
+		NL_SET_ERR_MSG(extack, "if_id must be non zero");
+		return -EINVAL;
+	}
+
+	xi = xfrmi_locate(net, &p);
+	if (xi)
+		return -EEXIST;
+
+	xi = netdev_priv(dev);
+	xi->p = p;
+	xi->net = net;
+	xi->dev = dev;
+
+	err = xfrmi_create(dev);
+	return err;
+}
+
+static void xfrmi_dellink(struct net_device *dev, struct list_head *head)
+{
+	unregister_netdevice_queue(dev, head);
+}
+
+static int xfrmi_changelink(struct net_device *dev, struct nlattr *tb[],
+			   struct nlattr *data[],
+			   struct netlink_ext_ack *extack)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+	struct net *net = xi->net;
+	struct xfrm_if_parms p = {};
+
+	xfrmi_netlink_parms(data, &p);
+	if (!p.if_id) {
+		NL_SET_ERR_MSG(extack, "if_id must be non zero");
+		return -EINVAL;
+	}
+
+	xi = xfrmi_locate(net, &p);
+	if (!xi) {
+		xi = netdev_priv(dev);
+	} else {
+		if (xi->dev != dev)
+			return -EEXIST;
+	}
+
+	return xfrmi_update(xi, &p);
+}
+
+static size_t xfrmi_get_size(const struct net_device *dev)
+{
+	return
+		/* IFLA_XFRM_LINK */
+		nla_total_size(4) +
+		/* IFLA_XFRM_IF_ID */
+		nla_total_size(4) +
+		0;
+}
+
+static int xfrmi_fill_info(struct sk_buff *skb, const struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+	struct xfrm_if_parms *parm = &xi->p;
+
+	if (nla_put_u32(skb, IFLA_XFRM_LINK, parm->link) ||
+	    nla_put_u32(skb, IFLA_XFRM_IF_ID, parm->if_id))
+		goto nla_put_failure;
+	return 0;
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
+struct net *xfrmi_get_link_net(const struct net_device *dev)
+{
+	struct xfrm_if *xi = netdev_priv(dev);
+
+	return xi->net;
+}
+
+static const struct nla_policy xfrmi_policy[IFLA_XFRM_MAX + 1] = {
+	[IFLA_XFRM_LINK]	= { .type = NLA_U32 },
+	[IFLA_XFRM_IF_ID]	= { .type = NLA_U32 },
+};
+
+static struct rtnl_link_ops xfrmi_link_ops __read_mostly = {
+	.kind		= "xfrm",
+	.maxtype	= IFLA_XFRM_MAX,
+	.policy		= xfrmi_policy,
+	.priv_size	= sizeof(struct xfrm_if),
+	.setup		= xfrmi_dev_setup,
+	.validate	= xfrmi_validate,
+	.newlink	= xfrmi_newlink,
+	.dellink	= xfrmi_dellink,
+	.changelink	= xfrmi_changelink,
+	.get_size	= xfrmi_get_size,
+	.fill_info	= xfrmi_fill_info,
+	.get_link_net	= xfrmi_get_link_net,
+};
+
+static void __net_exit xfrmi_destroy_interfaces(struct xfrmi_net *xfrmn)
+{
+	struct xfrm_if *xi;
+	LIST_HEAD(list);
+
+	xi = rtnl_dereference(xfrmn->xfrmi[0]);
+	if (!xi)
+		return;
+
+	unregister_netdevice_queue(xi->dev, &list);
+	unregister_netdevice_many(&list);
+}
+
+static int __net_init xfrmi_init_net(struct net *net)
+{
+	return 0;
+}
+
+static void __net_exit xfrmi_exit_net(struct net *net)
+{
+	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
+
+	rtnl_lock();
+	xfrmi_destroy_interfaces(xfrmn);
+	rtnl_unlock();
+}
+
+static void __net_exit xfrmi_exit_batch_net(struct list_head *net_exit_list)
+{
+	struct net *net;
+	LIST_HEAD(list);
+
+	rtnl_lock();
+	list_for_each_entry(net, net_exit_list, exit_list) {
+		struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
+		struct xfrm_if __rcu **xip;
+		struct xfrm_if *xi;
+
+		for (xip = &xfrmn->xfrmi[0];
+		     (xi = rtnl_dereference(*xip)) != NULL;
+		     xip = &xi->next)
+			unregister_netdevice_queue(xi->dev, &list);
+	}
+	unregister_netdevice_many(&list);
+	rtnl_unlock();
+}
+
+static struct pernet_operations xfrmi_net_ops = {
+	.exit_batch = xfrmi_exit_batch_net,
+	.init = xfrmi_init_net,
+	.exit = xfrmi_exit_net,
+	.id   = &xfrmi_net_id,
+	.size = sizeof(struct xfrmi_net),
+};
+
+static struct xfrm6_protocol xfrmi_esp6_protocol __read_mostly = {
+	.handler	=	xfrm6_rcv,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi6_err,
+	.priority	=	10,
+};
+
+static struct xfrm6_protocol xfrmi_ah6_protocol __read_mostly = {
+	.handler	=	xfrm6_rcv,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi6_err,
+	.priority	=	10,
+};
+
+static struct xfrm6_protocol xfrmi_ipcomp6_protocol __read_mostly = {
+	.handler	=	xfrm6_rcv,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi6_err,
+	.priority	=	10,
+};
+
+static struct xfrm4_protocol xfrmi_esp4_protocol __read_mostly = {
+	.handler	=	xfrm4_rcv,
+	.input_handler	=	xfrm_input,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi4_err,
+	.priority	=	10,
+};
+
+static struct xfrm4_protocol xfrmi_ah4_protocol __read_mostly = {
+	.handler	=	xfrm4_rcv,
+	.input_handler	=	xfrm_input,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi4_err,
+	.priority	=	10,
+};
+
+static struct xfrm4_protocol xfrmi_ipcomp4_protocol __read_mostly = {
+	.handler	=	xfrm4_rcv,
+	.input_handler	=	xfrm_input,
+	.cb_handler	=	xfrmi_rcv_cb,
+	.err_handler	=	xfrmi4_err,
+	.priority	=	10,
+};
+
+static int __init xfrmi4_init(void)
+{
+	int err;
+
+	err = xfrm4_protocol_register(&xfrmi_esp4_protocol, IPPROTO_ESP);
+	if (err < 0)
+		goto xfrm_proto_esp_failed;
+	err = xfrm4_protocol_register(&xfrmi_ah4_protocol, IPPROTO_AH);
+	if (err < 0)
+		goto xfrm_proto_ah_failed;
+	err = xfrm4_protocol_register(&xfrmi_ipcomp4_protocol, IPPROTO_COMP);
+	if (err < 0)
+		goto xfrm_proto_comp_failed;
+
+	return 0;
+
+xfrm_proto_comp_failed:
+	xfrm4_protocol_deregister(&xfrmi_ah4_protocol, IPPROTO_AH);
+xfrm_proto_ah_failed:
+	xfrm4_protocol_deregister(&xfrmi_esp4_protocol, IPPROTO_ESP);
+xfrm_proto_esp_failed:
+	return err;
+}
+
+static void xfrmi4_fini(void)
+{
+	xfrm4_protocol_deregister(&xfrmi_ipcomp4_protocol, IPPROTO_COMP);
+	xfrm4_protocol_deregister(&xfrmi_ah4_protocol, IPPROTO_AH);
+	xfrm4_protocol_deregister(&xfrmi_esp4_protocol, IPPROTO_ESP);
+}
+
+static int __init xfrmi6_init(void)
+{
+	int err;
+
+	err = xfrm6_protocol_register(&xfrmi_esp6_protocol, IPPROTO_ESP);
+	if (err < 0)
+		goto xfrm_proto_esp_failed;
+	err = xfrm6_protocol_register(&xfrmi_ah6_protocol, IPPROTO_AH);
+	if (err < 0)
+		goto xfrm_proto_ah_failed;
+	err = xfrm6_protocol_register(&xfrmi_ipcomp6_protocol, IPPROTO_COMP);
+	if (err < 0)
+		goto xfrm_proto_comp_failed;
+
+	return 0;
+
+xfrm_proto_comp_failed:
+	xfrm6_protocol_deregister(&xfrmi_ah6_protocol, IPPROTO_AH);
+xfrm_proto_ah_failed:
+	xfrm6_protocol_deregister(&xfrmi_esp6_protocol, IPPROTO_ESP);
+xfrm_proto_esp_failed:
+	return err;
+}
+
+static void xfrmi6_fini(void)
+{
+	xfrm6_protocol_deregister(&xfrmi_ipcomp6_protocol, IPPROTO_COMP);
+	xfrm6_protocol_deregister(&xfrmi_ah6_protocol, IPPROTO_AH);
+	xfrm6_protocol_deregister(&xfrmi_esp6_protocol, IPPROTO_ESP);
+}
+
+static const struct xfrm_if_cb xfrm_if_cb = {
+	.decode_session =	xfrmi_decode_session,
+};
+
+static int __init xfrmi_init(void)
+{
+	const char *msg;
+	int err;
+
+	pr_info("IPsec XFRM device driver\n");
+
+	msg = "tunnel device";
+	err = register_pernet_device(&xfrmi_net_ops);
+	if (err < 0)
+		goto pernet_dev_failed;
+
+	msg = "xfrm4 protocols";
+	err = xfrmi4_init();
+	if (err < 0)
+		goto xfrmi4_failed;
+
+	msg = "xfrm6 protocols";
+	err = xfrmi6_init();
+	if (err < 0)
+		goto xfrmi6_failed;
+
+
+	msg = "netlink interface";
+	err = rtnl_link_register(&xfrmi_link_ops);
+	if (err < 0)
+		goto rtnl_link_failed;
+
+	xfrm_if_register_cb(&xfrm_if_cb);
+
+	return err;
+
+rtnl_link_failed:
+	xfrmi6_fini();
+xfrmi6_failed:
+	xfrmi4_fini();
+xfrmi4_failed:
+	unregister_pernet_device(&xfrmi_net_ops);
+pernet_dev_failed:
+	pr_err("xfrmi init: failed to register %s\n", msg);
+	return err;
+}
+
+static void __exit xfrmi_fini(void)
+{
+	xfrm_if_unregister_cb();
+	rtnl_link_unregister(&xfrmi_link_ops);
+	xfrmi4_fini();
+	xfrmi6_fini();
+	unregister_pernet_device(&xfrmi_net_ops);
+}
+
+module_init(xfrmi_init);
+module_exit(xfrmi_fini);
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_RTNL_LINK("xfrm");
+MODULE_ALIAS_NETDEV("xfrm0");
+MODULE_AUTHOR("Steffen Klassert");
+MODULE_DESCRIPTION("XFRM virtual interface");
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 94c7ebc26c48..699e544b4bfd 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -521,7 +521,7 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
 	struct nlattr *et = attrs[XFRMA_ETIMER_THRESH];
 	struct nlattr *rt = attrs[XFRMA_REPLAY_THRESH];
 
-	if (re) {
+	if (re && x->replay_esn && x->preplay_esn) {
 		struct xfrm_replay_state_esn *replay_esn;
 		replay_esn = nla_data(re);
 		memcpy(x->replay_esn, replay_esn,
@@ -1036,6 +1036,15 @@ static int xfrm_dump_sa(struct sk_buff *skb, struct netlink_callback *cb)
 					 sizeof(*filter), GFP_KERNEL);
 			if (filter == NULL)
 				return -ENOMEM;
+
+			/* see addr_match(), (prefix length >> 5) << 2
+			 * will be used to compare xfrm_address_t
+			 */
+			if (filter->splen > (sizeof(xfrm_address_t) << 3) ||
+			    filter->dplen > (sizeof(xfrm_address_t) << 3)) {
+				kfree(filter);
+				return -EINVAL;
+			}
 		}
 
 		if (attrs[XFRMA_PROTO])
@@ -2573,7 +2582,7 @@ static const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_ALG_COMP]	= { .len = sizeof(struct xfrm_algo) },
 	[XFRMA_ENCAP]		= { .len = sizeof(struct xfrm_encap_tmpl) },
 	[XFRMA_TMPL]		= { .len = sizeof(struct xfrm_user_tmpl) },
-	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_sec_ctx) },
+	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_user_sec_ctx) },
 	[XFRMA_LTIME_VAL]	= { .len = sizeof(struct xfrm_lifetime_cur) },
 	[XFRMA_REPLAY_VAL]	= { .len = sizeof(struct xfrm_replay_state) },
 	[XFRMA_REPLAY_THRESH]	= { .type = NLA_U32 },
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 3ec45028a8c5..cd32fe3311af 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -7,7 +7,7 @@ config IMA
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
-	select TCG_TPM if HAS_IOMEM && !UML
+	select TCG_TPM if HAS_IOMEM
 	select TCG_TIS if TCG_TPM && X86
 	select TCG_CRB if TCG_TPM && ACPI
 	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 1f25e6d029d8..84d98c098b74 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -1550,14 +1550,8 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 	gpr += 2;
 
 	/* Master volume (will be renamed later) */
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+1+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+1+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+2+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+2+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+3+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+3+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+4+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+4+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+5+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+5+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+6+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+6+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+7+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+7+SND_EMU10K1_PLAYBACK_CHANNELS));
+	for (z = 0; z < 8; z++)
+		A_OP(icode, &ptr, iMAC0, A_GPR(playback+z+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+z+SND_EMU10K1_PLAYBACK_CHANNELS));
 	snd_emu10k1_init_mono_control(&controls[nctl++], "Wave Master Playback Volume", gpr, 0);
 	gpr += 2;
 
@@ -1641,102 +1635,14 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 			dev_dbg(emu->card->dev, "emufx.c: gpr=0x%x, tmp=0x%x\n",
 			       gpr, tmp);
 			*/
-			/* For the EMU1010: How to get 32bit values from the DSP. High 16bits into L, low 16bits into R. */
-			/* A_P16VIN(0) is delayed by one sample,
-			 * so all other A_P16VIN channels will need to also be delayed
-			 */
-			/* Left ADC in. 1 of 2 */
 			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_P16VIN(0x0), A_FXBUS2(0) );
-			/* Right ADC in 1 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			/* Delaying by one sample: instead of copying the input
-			 * value A_P16VIN to output A_FXBUS2 as in the first channel,
-			 * we use an auxiliary register, delaying the value by one
-			 * sample
-			 */
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(2) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x1), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(4) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x2), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(6) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x3), A_C_00000000, A_C_00000000);
-			/* For 96kHz mode */
-			/* Left ADC in. 2 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0x8) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x4), A_C_00000000, A_C_00000000);
-			/* Right ADC in 2 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xa) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x5), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xc) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x6), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xe) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x7), A_C_00000000, A_C_00000000);
-			/* Pavel Hofman - we still have voices, A_FXBUS2s, and
-			 * A_P16VINs available -
-			 * let's add 8 more capture channels - total of 16
-			 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x10));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x8),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x12));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x9),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x14));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xa),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x16));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xb),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x18));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xc),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1a));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xd),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1c));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xe),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1e));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xf),
-			     A_C_00000000, A_C_00000000);
+			/* A_P16VIN(0) is delayed by one sample, so all other A_P16VIN channels
+			 * will need to also be delayed; we use an auxiliary register for that. */
+			for (z = 1; z < 0x10; z++) {
+				snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr), A_FXBUS2(z * 2) );
+				A_OP(icode, &ptr, iACC3, A_GPR(gpr), A_P16VIN(z), A_C_00000000, A_C_00000000);
+				gpr_map[gpr++] = 0x00000000;
+			}
 		}
 
 #if 0
diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 6ba99f5ed3f4..a7ed2a19c3ec 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4475,6 +4475,8 @@ static void rt5665_remove(struct snd_soc_component *component)
 	struct rt5665_priv *rt5665 = snd_soc_component_get_drvdata(component);
 
 	regmap_write(rt5665->regmap, RT5665_RESET, 0);
+
+	regulator_bulk_disable(ARRAY_SIZE(rt5665->supplies), rt5665->supplies);
 }
 
 #ifdef CONFIG_PM
diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index 43e390f9358a..a195160b6820 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -28,27 +28,32 @@ int axg_tdm_formatter_set_channel_masks(struct regmap *map,
 					struct axg_tdm_stream *ts,
 					unsigned int offset)
 {
-	unsigned int val, ch = ts->channels;
-	unsigned long mask;
-	int i, j;
+	unsigned int ch = ts->channels;
+	u32 val[AXG_TDM_NUM_LANES];
+	int i, j, k;
+
+	/*
+	 * We need to mimick the slot distribution used by the HW to keep the
+	 * channel placement consistent regardless of the number of channel
+	 * in the stream. This is why the odd algorithm below is used.
+	 */
+	memset(val, 0, sizeof(*val) * AXG_TDM_NUM_LANES);
 
 	/*
 	 * Distribute the channels of the stream over the available slots
-	 * of each TDM lane
+	 * of each TDM lane. We need to go over the 32 slots ...
 	 */
-	for (i = 0; i < AXG_TDM_NUM_LANES; i++) {
-		val = 0;
-		mask = ts->mask[i];
-
-		for (j = find_first_bit(&mask, 32);
-		     (j < 32) && ch;
-		     j = find_next_bit(&mask, 32, j + 1)) {
-			val |= 1 << j;
-			ch -= 1;
+	for (i = 0; (i < 32) && ch; i += 2) {
+		/* ... of all the lanes ... */
+		for (j = 0; j < AXG_TDM_NUM_LANES; j++) {
+			/* ... then distribute the channels in pairs */
+			for (k = 0; k < 2; k++) {
+				if ((BIT(i + k) & ts->mask[j]) && ch) {
+					val[j] |= BIT(i + k);
+					ch -= 1;
+				}
+			}
 		}
-
-		regmap_write(map, offset, val);
-		offset += regmap_get_reg_stride(map);
 	}
 
 	/*
@@ -61,6 +66,11 @@ int axg_tdm_formatter_set_channel_masks(struct regmap *map,
 		return -EINVAL;
 	}
 
+	for (i = 0; i < AXG_TDM_NUM_LANES; i++) {
+		regmap_write(map, offset, val[i]);
+		offset += regmap_get_reg_stride(map);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(axg_tdm_formatter_set_channel_masks);
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index e72f744bc305..6c546f520f99 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3677,5 +3677,34 @@ ALC1220_VB_DESKTOP(0x26ce, 0x0a01), /* Asrock TRX40 Creator */
 		}
 	}
 },
+{
+	/* Advanced modes of the Mythware XA001AU.
+	 * For the standard mode, Mythware XA001AU has ID ffad:a001
+	 */
+	USB_DEVICE_VENDOR_SPEC(0xffad, 0xa001),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Mythware",
+		.product_name = "XA001AU",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_IGNORE_INTERFACE,
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 
 #undef USB_DEVICE_VENDOR_SPEC
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
index 135902aa8b11..a372863c9efd 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
@@ -72,7 +72,8 @@ test_span_gre_ttl()
 
 	RET=0
 
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev \
+		"prot ip flower $tcflags ip_prot icmp"
 	tc filter add dev $h3 ingress pref 77 prot $prot \
 		flower ip_ttl 50 action pass
 
diff --git a/tools/testing/selftests/net/forwarding/tc_flower.sh b/tools/testing/selftests/net/forwarding/tc_flower.sh
index 20d1077e5a3d..85faef980887 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower.sh
@@ -48,8 +48,8 @@ match_dst_mac_test()
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
 
-	tc_check_packets "dev $h2 ingress" 102 1
-	check_err $? "Did not match on correct filter"
+	tc_check_packets "dev $h2 ingress" 102 0
+	check_fail $? "Did not match on correct filter"
 
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 	tc filter del dev $h2 ingress protocol ip pref 2 handle 102 flower
@@ -74,8 +74,8 @@ match_src_mac_test()
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
 
-	tc_check_packets "dev $h2 ingress" 102 1
-	check_err $? "Did not match on correct filter"
+	tc_check_packets "dev $h2 ingress" 102 0
+	check_fail $? "Did not match on correct filter"
 
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 	tc filter del dev $h2 ingress protocol ip pref 2 handle 102 flower
