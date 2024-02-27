Return-Path: <linux-kernel+bounces-83495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F22869A36
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F320E1F22B88
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEF4149DEF;
	Tue, 27 Feb 2024 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0zkaYKEt"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78FD148FF6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047187; cv=none; b=C4gqx9c1c8z2x9j9CGlo2ob0PR39B3O/wXLIzQU3vrH7e/alyNkrzPUzvU/gBFRz993ycUPPnEEqzwSYlZ+kNEyCSyUqqRjx4eqEAOruu7VZMvNn4TZoXJ0mxbrODK3lD9Yk8/nj6n9lPDDOTDBuAzrsBZovx3d4SRLi7NZp2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047187; c=relaxed/simple;
	bh=qSjwtFzc0l5zAcSrUDslu+YsQKRi8QzKlxiS3GF6OKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cosFl6wHtaPoAJawRP7XLycUfnIGpa+t35mOmjkTiaE0AwD0EEGiqebxvF4mDuP+iCu19vx9lOcTkEhZfQkWsiT7fdLNUkckrHIbA2hBZNDDtNrRS086ZG3QfguQCNZtUmOsZTyxhbcUkJcZWHGgs67ocihzh5IOKRoQeoAZ0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0zkaYKEt; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33d23c8694dso2020830f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709047184; x=1709651984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYuGtKHJMVquxPkGaFI0DQjYYMZ/RRITtvpZGgefhyk=;
        b=0zkaYKEt6VGQR04lMGpSiyjYy49rSyKkd+qUITHwg/WOBNYR2nbH6+InWoO5HlbBId
         axHvxbiqpazuYYcry2KCVqFwCns0shpmL/m3Ce08xQn/zIYR5mARC/ZaM4TGW4N6CrNT
         wQnAftOvio6vi+eMxRgk7OXElLbMxBfXiP5N1CcSWR0eu7RH7LwZ6prlfiovfMgZHfUQ
         a8tcHopNhBbngjyFEOArChy+0SW+k4RjOIkzyPJTjNty5OIZ0GC74rcI3lVJpkUQhXLZ
         Z9v8BBncwbEOwX76ER0+a76JLUfDMkIfWIt4Iq5AsF5Yio4epnb0vxqgQwZ2U7bgjZCR
         IjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047184; x=1709651984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYuGtKHJMVquxPkGaFI0DQjYYMZ/RRITtvpZGgefhyk=;
        b=XCKpboIMnc20BxhLVqVbQS1Lp70NV1GA7GKVVtzxOm36bQ1vycvxv5Jv5783tWIYBN
         nO4rkeYtCBwC4ECgCoXXKfArG/1s61ExZsO/bkd3Iu9rfk84wTtVN2mRk3HRErPc5JBw
         jV3/8kBol5YxqeMo+qxICwmoRG6Rv7rD9OiczpwfwItiA03MnOXUVVXxhrLZOOga1ptb
         XNqKRupJ4YkC8j1ODPkLZ11QSxnqFGSMKsDYAia51bTiaGargYmLj0Mdb6//4wglK2uq
         ci/FDhLiAnTkY9tZqvl6G/W6nPistPUDABfeR3Vm54kGDG+K5ut4ajwZECQ7yDqfhkRt
         hZMA==
X-Gm-Message-State: AOJu0Yx5XLbLlIyZUmaLFeGN8Z5bgOAwGREPR8T5yBQLooB0khwDQ2/x
	zeEppUxGyk59uhP/ZQJm2icGNVQBGBbtVzzf0wc6b8m/2SOdzML72t1ap3xmj6fR+wx4iIZtdwr
	8PbB5l/v3ymb6eVDUZThNdLcB6MyTmYFM0/Yo0N3pr/rtczzWwh8qckFGYd2mL6el5ssBBN3lPN
	D4kVTQo28xKPpnQkFUMLwA/UUWBjO9TA==
X-Google-Smtp-Source: AGHT+IF6CgeeXl4atjMBx7ihWosSGIXv1BRRHC/R1qvhQeIkl+g55FsIJVNlGhSAjAbb1JWqw3e0SxBQ
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:253:b0:33d:2808:f647 with SMTP id
 m19-20020a056000025300b0033d2808f647mr59319wrz.3.1709047184002; Tue, 27 Feb
 2024 07:19:44 -0800 (PST)
Date: Tue, 27 Feb 2024 16:19:17 +0100
In-Reply-To: <20240227151907.387873-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227151907.387873-20-ardb+git@google.com>
Subject: [PATCH v7 9/9] x86/startup_64: Drop global variables keeping track of
 LA57 state
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

On x86_64, the core kernel is entered in long mode, which implies that
paging is enabled. This means that the CR4.LA57 control bit is
guaranteed to be in sync with the number of paging levels used by the
kernel, and there is no need to store this in a variable.

There is also no need to use variables for storing the calculations of
pgdir_shift and ptrs_per_p4d, as they are easily determined on the fly.

This removes the need for two different sources of truth for determining
whether 5-level paging is in use: CR4.LA57 always reflects the actual
state, and never changes from the point of view of the 64-bit core
kernel. The only potential concern is the cost of CR4 accesses, which
can be mitigated using alternatives patching based on feature detection.

Note that even the decompressor does not manipulate any page tables
before updating CR4.LA57, so it can also avoid the associated global
variables entirely. However, as it does not implement alternatives
patching, the associated ELF sections need to be discarded.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.h         |  4 --
 arch/x86/boot/compressed/pgtable_64.c   | 12 ------
 arch/x86/boot/compressed/vmlinux.lds.S  |  1 +
 arch/x86/include/asm/pgtable_64_types.h | 43 ++++++++++----------
 arch/x86/kernel/cpu/common.c            |  2 -
 arch/x86/kernel/head64.c                | 33 +--------------
 arch/x86/mm/kasan_init_64.c             |  3 --
 arch/x86/mm/mem_encrypt_identity.c      |  9 ----
 8 files changed, 25 insertions(+), 82 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index b353a7be380c..e4ab7b4d8698 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -16,9 +16,6 @@
 
 #define __NO_FORTIFY
 
-/* cpu_feature_enabled() cannot be used this early */
-#define USE_EARLY_PGTABLE_L5
-
 /*
  * Boot stub deals with identity mappings, physical and virtual addresses are
  * the same, so override these defines.
@@ -181,7 +178,6 @@ static inline int count_immovable_mem_regions(void) { return 0; }
 #endif
 
 /* ident_map_64.c */
-extern unsigned int __pgtable_l5_enabled, pgdir_shift, ptrs_per_p4d;
 extern void kernel_add_identity_map(unsigned long start, unsigned long end);
 
 /* Used by PAGE_KERN* macros: */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 51f957b24ba7..ae72f53f5e77 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -9,13 +9,6 @@
 #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
 #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
 
-#ifdef CONFIG_X86_5LEVEL
-/* __pgtable_l5_enabled needs to be in .data to avoid being cleared along with .bss */
-unsigned int __section(".data") __pgtable_l5_enabled;
-unsigned int __section(".data") pgdir_shift = 39;
-unsigned int __section(".data") ptrs_per_p4d = 1;
-#endif
-
 /* Buffer to preserve trampoline memory */
 static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
 
@@ -125,11 +118,6 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 			native_cpuid_eax(0) >= 7 &&
 			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
 		l5_required = true;
-
-		/* Initialize variables for 5-level paging */
-		__pgtable_l5_enabled = 1;
-		pgdir_shift = 48;
-		ptrs_per_p4d = 512;
 	}
 
 	/*
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 083ec6d7722a..06358bb067fe 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -81,6 +81,7 @@ SECTIONS
 		*(.dynamic) *(.dynsym) *(.dynstr) *(.dynbss)
 		*(.hash) *(.gnu.hash)
 		*(.note.*)
+		*(.altinstructions .altinstr_replacement)
 	}
 
 	.got.plt (INFO) : {
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 9053dfe9fa03..2fac8ba9564a 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -6,7 +6,10 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
+#include <asm/alternative.h>
+#include <asm/cpufeatures.h>
 #include <asm/kaslr.h>
+#include <asm/processor-flags.h>
 
 /*
  * These are used to make use of C type-checking..
@@ -21,28 +24,24 @@ typedef unsigned long	pgprotval_t;
 typedef struct { pteval_t pte; } pte_t;
 typedef struct { pmdval_t pmd; } pmd_t;
 
-extern unsigned int __pgtable_l5_enabled;
-
-#ifdef CONFIG_X86_5LEVEL
-#ifdef USE_EARLY_PGTABLE_L5
-/*
- * cpu_feature_enabled() is not available in early boot code.
- * Use variable instead.
- */
-static inline bool pgtable_l5_enabled(void)
+static __always_inline __pure bool pgtable_l5_enabled(void)
 {
-	return __pgtable_l5_enabled;
-}
-#else
-#define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
-#endif /* USE_EARLY_PGTABLE_L5 */
+	unsigned long r;
+	bool ret;
 
-#else
-#define pgtable_l5_enabled() 0
-#endif /* CONFIG_X86_5LEVEL */
+	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
+		return false;
 
-extern unsigned int pgdir_shift;
-extern unsigned int ptrs_per_p4d;
+	asm(ALTERNATIVE_TERNARY(
+		"movq %%cr4, %[reg] \n\t btl %[la57], %k[reg]" CC_SET(c),
+		%P[feat], "stc", "clc")
+		: [reg] "=&r" (r), CC_OUT(c) (ret)
+		: [feat] "i"  (X86_FEATURE_LA57),
+		  [la57] "i"  (X86_CR4_LA57_BIT)
+		: "cc");
+
+	return ret;
+}
 
 #endif	/* !__ASSEMBLY__ */
 
@@ -53,7 +52,7 @@ extern unsigned int ptrs_per_p4d;
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
  */
-#define PGDIR_SHIFT	pgdir_shift
+#define PGDIR_SHIFT	(pgtable_l5_enabled() ? 48 : 39)
 #define PTRS_PER_PGD	512
 
 /*
@@ -61,7 +60,7 @@ extern unsigned int ptrs_per_p4d;
  */
 #define P4D_SHIFT		39
 #define MAX_PTRS_PER_P4D	512
-#define PTRS_PER_P4D		ptrs_per_p4d
+#define PTRS_PER_P4D		(pgtable_l5_enabled() ? 512 : 1)
 #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
 #define P4D_MASK		(~(P4D_SIZE - 1))
 
@@ -76,6 +75,8 @@ extern unsigned int ptrs_per_p4d;
 #define PTRS_PER_PGD		512
 #define MAX_PTRS_PER_P4D	1
 
+#define MAX_POSSIBLE_PHYSMEM_BITS	46
+
 #endif /* CONFIG_X86_5LEVEL */
 
 /*
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9e35e276c55a..d88e4be88868 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* cpu_feature_enabled() cannot be used this early */
-#define USE_EARLY_PGTABLE_L5
 
 #include <linux/memblock.h>
 #include <linux/linkage.h>
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index deaaea3280d9..789ed2c53527 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -7,9 +7,6 @@
 
 #define DISABLE_BRANCH_PROFILING
 
-/* cpu_feature_enabled() cannot be used this early */
-#define USE_EARLY_PGTABLE_L5
-
 #include <linux/init.h>
 #include <linux/linkage.h>
 #include <linux/types.h>
@@ -52,14 +49,6 @@ extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
 static unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
-#ifdef CONFIG_X86_5LEVEL
-unsigned int __pgtable_l5_enabled __ro_after_init;
-unsigned int pgdir_shift __ro_after_init = 39;
-EXPORT_SYMBOL(pgdir_shift);
-unsigned int ptrs_per_p4d __ro_after_init = 1;
-EXPORT_SYMBOL(ptrs_per_p4d);
-#endif
-
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
@@ -78,21 +67,6 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
 	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
 };
 
-static inline bool check_la57_support(void)
-{
-	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
-		return false;
-
-	/*
-	 * 5-level paging is detected and enabled at kernel decompression
-	 * stage. Only check if it has been enabled there.
-	 */
-	if (!(native_read_cr4() & X86_CR4_LA57))
-		return false;
-
-	return true;
-}
-
 static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
 {
 	unsigned long vaddr, vaddr_end;
@@ -155,7 +129,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	bool la57;
 	int i;
 
-	la57 = check_la57_support();
+	la57 = pgtable_l5_enabled();
 
 	/* Is the address too large? */
 	if (physaddr >> MAX_PHYSMEM_BITS)
@@ -440,10 +414,7 @@ asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode
 				(__START_KERNEL & PGDIR_MASK)));
 	BUILD_BUG_ON(__fix_to_virt(__end_of_fixed_addresses) <= MODULES_END);
 
-	if (check_la57_support()) {
-		__pgtable_l5_enabled	= 1;
-		pgdir_shift		= 48;
-		ptrs_per_p4d		= 512;
+	if (pgtable_l5_enabled()) {
 		page_offset_base	= __PAGE_OFFSET_BASE_L5;
 		vmalloc_base		= __VMALLOC_BASE_L5;
 		vmemmap_base		= __VMEMMAP_BASE_L5;
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0302491d799d..85ae1ef840cc 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -2,9 +2,6 @@
 #define DISABLE_BRANCH_PROFILING
 #define pr_fmt(fmt) "kasan: " fmt
 
-/* cpu_feature_enabled() cannot be used this early */
-#define USE_EARLY_PGTABLE_L5
-
 #include <linux/memblock.h>
 #include <linux/kasan.h>
 #include <linux/kdebug.h>
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 64b5005d49e5..a857945af177 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -27,15 +27,6 @@
 #undef CONFIG_PARAVIRT_XXL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 
-/*
- * This code runs before CPU feature bits are set. By default, the
- * pgtable_l5_enabled() function uses bit X86_FEATURE_LA57 to determine if
- * 5-level paging is active, so that won't work here. USE_EARLY_PGTABLE_L5
- * is provided to handle this situation and, instead, use a variable that
- * has been set by the early boot code.
- */
-#define USE_EARLY_PGTABLE_L5
-
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/mem_encrypt.h>
-- 
2.44.0.rc1.240.g4c46232300-goog


