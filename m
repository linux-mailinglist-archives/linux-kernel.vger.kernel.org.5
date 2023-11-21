Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA17F348A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjKURKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjKURKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:10:42 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A170C113;
        Tue, 21 Nov 2023 09:10:36 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9c41e95efcbso800911766b.3;
        Tue, 21 Nov 2023 09:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586635; x=1701191435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYzfZG/C2MsaKXteb7v0bs2m1+uBySJFf8Q+cZod/zU=;
        b=Cx6XihnEbe9T0TPFuiMPu+9Kms3AqcC6TbwbtxYmYpgRwxlqEgzL+1dh2yYZTOLsDk
         iknGKUZSxFRC7q0XAlxu0bMA4dc2GDNghQRQ/gZCCD2wcG9c8GwchZ7Cd5TRSmMAOI9a
         bzrmz82sseLmeRWm+9Og0z1vNs4UO1awy6odCVl+xWhuHy02FeOeOUlfCG1zhgp4dm2R
         /QS1DwgQE7J+KiErU39dtKK/uGQ1eUiWHQokjeto1FS51+TgIvDBZz3NNFNChc74mnkU
         5xBJUVzgR6zgGWz9st5OFzpqVwj0Tquak+So02IV2AQSY3P5FFdxaU76TY8AnCw0TtdJ
         FQag==
X-Gm-Message-State: AOJu0YxZ4ik6FtvihPPp0svTyKzqdjJqvXuRH6BUa0xcP7oOyWXurcse
        O1H867SfQspWaRVzEtfq56k=
X-Google-Smtp-Source: AGHT+IFOLlde1hd/FwBjTEqq2fDrNO2y7A/cNpao+Cj+qYRuyc+DWgdFp5uEKoS6wVmJFZEEoI0uEA==
X-Received: by 2002:a17:906:28d:b0:9fe:380e:9055 with SMTP id 13-20020a170906028d00b009fe380e9055mr4722702ejf.8.1700586634665;
        Tue, 21 Nov 2023 09:10:34 -0800 (PST)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id kk17-20020a170907767100b0099cce6f7d50sm5494542ejc.64.2023.11.21.09.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:10:34 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        bp@alien8.de, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     leit@meta.com, linux-kernel@vger.kernel.org,
        pawan.kumar.gupta@linux.intel.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Brian Gerst <brgerst@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Hugh Dickins <hughd@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH v6 04/13] x86/bugs: Rename PAGE_TABLE_ISOLATION to MITIGATION_PAGE_TABLE_ISOLATION
Date:   Tue, 21 Nov 2023 08:07:31 -0800
Message-Id: <20231121160740.1249350-5-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121160740.1249350-1-leitao@debian.org>
References: <20231121160740.1249350-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU mitigations config entries are inconsistent, and names are hard to
related. There are concrete benefits for both users and developers of
having all the mitigation config options living in the same config
namespace.

The mitigation options should have consistency and start with
MITIGATION.

Rename the Kconfig entry from PAGE_TABLE_ISOLATION to
MITIGATION_PAGE_TABLE_ISOLATION.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/arch/x86/pti.rst                 |  6 +++---
 arch/x86/Kconfig                               |  2 +-
 arch/x86/boot/compressed/ident_map_64.c        |  4 ++--
 arch/x86/entry/calling.h                       |  4 ++--
 arch/x86/entry/entry_64.S                      |  2 +-
 arch/x86/include/asm/disabled-features.h       |  2 +-
 arch/x86/include/asm/pgalloc.h                 |  2 +-
 arch/x86/include/asm/pgtable-3level.h          |  2 +-
 arch/x86/include/asm/pgtable.h                 | 18 +++++++++---------
 arch/x86/include/asm/pgtable_64.h              |  3 ++-
 arch/x86/include/asm/processor-flags.h         |  2 +-
 arch/x86/include/asm/pti.h                     |  2 +-
 arch/x86/kernel/dumpstack.c                    |  2 +-
 arch/x86/kernel/head_32.S                      |  4 ++--
 arch/x86/kernel/head_64.S                      |  2 +-
 arch/x86/kernel/ldt.c                          |  8 ++++----
 arch/x86/mm/Makefile                           |  2 +-
 arch/x86/mm/debug_pagetables.c                 |  4 ++--
 arch/x86/mm/dump_pagetables.c                  |  4 ++--
 arch/x86/mm/pgtable.c                          |  4 ++--
 arch/x86/mm/tlb.c                              | 10 +++++-----
 include/linux/pti.h                            |  2 +-
 tools/arch/x86/include/asm/disabled-features.h |  2 +-
 23 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/Documentation/arch/x86/pti.rst b/Documentation/arch/x86/pti.rst
index 4b858a9bad8d..3241b081f1ad 100644
--- a/Documentation/arch/x86/pti.rst
+++ b/Documentation/arch/x86/pti.rst
@@ -26,9 +26,9 @@ comments in pti.c).
 
 This approach helps to ensure that side-channel attacks leveraging
 the paging structures do not function when PTI is enabled.  It can be
-enabled by setting CONFIG_PAGE_TABLE_ISOLATION=y at compile time.
-Once enabled at compile-time, it can be disabled at boot with the
-'nopti' or 'pti=' kernel parameters (see kernel-parameters.txt).
+enabled by setting CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=y at compile
+time.  Once enabled at compile-time, it can be disabled at boot with
+the 'nopti' or 'pti=' kernel parameters (see kernel-parameters.txt).
 
 Page Table Management
 =====================
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3ecfeedaf248..4398e9ebef8c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2487,7 +2487,7 @@ menuconfig SPECULATION_MITIGATIONS
 
 if SPECULATION_MITIGATIONS
 
-config PAGE_TABLE_ISOLATION
+config MITIGATION_PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
 	default y
 	depends on (X86_64 || X86_PAE)
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 473ba59b82a8..0cbf6a6c3bc3 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -8,8 +8,8 @@
  * Copyright (C)      2016  Kees Cook
  */
 
-/* No PAGE_TABLE_ISOLATION support needed either: */
-#undef CONFIG_PAGE_TABLE_ISOLATION
+/* No MITIGATION_PAGE_TABLE_ISOLATION support needed either: */
+#undef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 
 #include "error.h"
 #include "misc.h"
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index f6907627172b..ace89d5c1ddd 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -142,7 +142,7 @@ For 32-bit we have the following conventions - kernel is built with
 	.endif
 .endm
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 
 /*
  * PAGE_TABLE_ISOLATION PGDs are 8k.  Flip bit 12 to switch between the two
@@ -269,7 +269,7 @@ For 32-bit we have the following conventions - kernel is built with
 .Lend_\@:
 .endm
 
-#else /* CONFIG_PAGE_TABLE_ISOLATION=n: */
+#else /* CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=n: */
 
 .macro SWITCH_TO_KERNEL_CR3 scratch_reg:req
 .endm
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index de6469dffe3a..3b4f6243de37 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1085,7 +1085,7 @@ SYM_CODE_END(error_return)
  *
  * Registers:
  *	%r14: Used to save/restore the CR3 of the interrupted context
- *	      when PAGE_TABLE_ISOLATION is in use.  Do not clobber.
+ *	      when MITIGATION_PAGE_TABLE_ISOLATION is in use.  Do not clobber.
  */
 SYM_CODE_START(asm_exc_nmi)
 	UNWIND_HINT_IRET_ENTRY
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index c1d3a5795618..fb604ec95a5f 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -44,7 +44,7 @@
 # define DISABLE_LA57	(1<<(X86_FEATURE_LA57 & 31))
 #endif
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 # define DISABLE_PTI		0
 #else
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index c7ec5bb88334..dcd836b59beb 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -34,7 +34,7 @@ static inline void paravirt_release_p4d(unsigned long pfn) {}
  */
 extern gfp_t __userpte_alloc_gfp;
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /*
  * Instead of one PGD, we acquire two PGDs.  Being order-1, it is
  * both 8k in size and 8k-aligned.  That lets us just flip bit 12
diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index 9e7c0b719c3c..dabafba957ea 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -52,7 +52,7 @@ static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 
 static inline void native_set_pud(pud_t *pudp, pud_t pud)
 {
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	pud.p4d.pgd = pti_set_user_pgtbl(&pudp->p4d.pgd, pud.p4d.pgd);
 #endif
 	pxx_xchg64(pud, pudp, native_pud_val(pud));
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 57bab91bbf50..b23d0c162573 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -908,7 +908,7 @@ static inline int is_new_memtype_allowed(u64 paddr, unsigned long size,
 pmd_t *populate_extra_pmd(unsigned long vaddr);
 pte_t *populate_extra_pte(unsigned long vaddr);
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd);
 
 /*
@@ -922,12 +922,12 @@ static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 		return pgd;
 	return __pti_set_user_pgtbl(pgdp, pgd);
 }
-#else   /* CONFIG_PAGE_TABLE_ISOLATION */
+#else   /* CONFIG_MITIGATION_PAGE_TABLE_ISOLATION */
 static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	return pgd;
 }
-#endif  /* CONFIG_PAGE_TABLE_ISOLATION */
+#endif  /* CONFIG_MITIGATION_PAGE_TABLE_ISOLATION */
 
 #endif	/* __ASSEMBLY__ */
 
@@ -1130,7 +1130,7 @@ static inline int p4d_bad(p4d_t p4d)
 {
 	unsigned long ignore_flags = _KERNPG_TABLE | _PAGE_USER;
 
-	if (IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION))
+	if (IS_ENABLED(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION))
 		ignore_flags |= _PAGE_NX;
 
 	return (p4d_flags(p4d) & ~ignore_flags) != 0;
@@ -1176,7 +1176,7 @@ static inline int pgd_bad(pgd_t pgd)
 	if (!pgtable_l5_enabled())
 		return 0;
 
-	if (IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION))
+	if (IS_ENABLED(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION))
 		ignore_flags |= _PAGE_NX;
 
 	return (pgd_flags(pgd) & ~ignore_flags) != _KERNPG_TABLE;
@@ -1421,9 +1421,9 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 #define pgd_leaf	pgd_large
 static inline int pgd_large(pgd_t pgd) { return 0; }
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /*
- * All top-level PAGE_TABLE_ISOLATION page tables are order-1 pages
+ * All top-level MITIGATION_PAGE_TABLE_ISOLATION page tables are order-1 pages
  * (8k-aligned and 8k in size).  The kernel one is at the beginning 4k and
  * the user one is in the last 4k.  To switch between them, you
  * just need to flip the 12th bit in their addresses.
@@ -1468,7 +1468,7 @@ static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
 {
 	return ptr_clear_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
 }
-#endif /* CONFIG_PAGE_TABLE_ISOLATION */
+#endif /* CONFIG_MITIGATION_PAGE_TABLE_ISOLATION */
 
 /*
  * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
@@ -1483,7 +1483,7 @@ static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
 static inline void clone_pgd_range(pgd_t *dst, pgd_t *src, int count)
 {
 	memcpy(dst, src, count * sizeof(pgd_t));
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
 	/* Clone the user space pgd as well */
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index a629b1b9f65a..8108d68d146c 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -143,7 +143,8 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	pgd_t pgd;
 
-	if (pgtable_l5_enabled() || !IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION)) {
+	if (pgtable_l5_enabled() ||
+	    !IS_ENABLED(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)) {
 		WRITE_ONCE(*p4dp, p4d);
 		return;
 	}
diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
index d8cccadc83a6..e5f204b9b33d 100644
--- a/arch/x86/include/asm/processor-flags.h
+++ b/arch/x86/include/asm/processor-flags.h
@@ -51,7 +51,7 @@
 #define CR3_NOFLUSH	0
 #endif
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 # define X86_CR3_PTI_PCID_USER_BIT	11
 #endif
 
diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 07375b476c4f..ab167c96b9ab 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -3,7 +3,7 @@
 #define _ASM_X86_PTI_H
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 extern void pti_init(void);
 extern void pti_check_boottime_disable(void);
 extern void pti_finalize(void);
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index f18ca44c904b..44a91ef5a23b 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -410,7 +410,7 @@ static void __die_header(const char *str, struct pt_regs *regs, long err)
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",
-	       IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION) ?
+	       IS_ENABLED(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION) ?
 	       (boot_cpu_has(X86_FEATURE_PTI) ? " PTI" : " NOPTI") : "");
 }
 NOKPROBE_SYMBOL(__die_header);
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 487ac57e2c81..b50f3641c4d6 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -414,7 +414,7 @@ __REFDATA
 	.align 4
 SYM_DATA(initial_code,		.long i386_start_kernel)
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 #define	PGD_ALIGN	(2 * PAGE_SIZE)
 #define PTI_USER_PGD_FILL	1024
 #else
@@ -474,7 +474,7 @@ SYM_DATA_START(initial_page_table)
 # endif
 	.align PAGE_SIZE		/* needs to be page-sized too */
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	/*
 	 * PTI needs another page so sync_initial_pagetable() works correctly
 	 * and does not scribble over the data which is placed behind the
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 086a2c3aaaa0..e23bc2a541cf 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -593,7 +593,7 @@ SYM_CODE_END(vc_no_ghcb)
 #define SYM_DATA_START_PAGE_ALIGNED(name)			\
 	SYM_START(name, SYM_L_GLOBAL, .balign PAGE_SIZE)
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /*
  * Each PGD needs to be 8k long and 8k aligned.  We do not
  * ever go out to userspace with these, so we do not
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index adc67f98819a..7e6de84b9358 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -184,7 +184,7 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
 	return new_ldt;
 }
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 
 static void do_sanity_check(struct mm_struct *mm,
 			    bool had_kernel_mapping,
@@ -377,7 +377,7 @@ static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
 	flush_tlb_mm_range(mm, va, va + nr_pages * PAGE_SIZE, PAGE_SHIFT, false);
 }
 
-#else /* !CONFIG_PAGE_TABLE_ISOLATION */
+#else /* !CONFIG_MITIGATION_PAGE_TABLE_ISOLATION */
 
 static int
 map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
@@ -388,11 +388,11 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
 {
 }
-#endif /* CONFIG_PAGE_TABLE_ISOLATION */
+#endif /* CONFIG_MITIGATION_PAGE_TABLE_ISOLATION */
 
 static void free_ldt_pgtables(struct mm_struct *mm)
 {
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	struct mmu_gather tlb;
 	unsigned long start = LDT_BASE_ADDR;
 	unsigned long end = LDT_END_ADDR;
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c80febc44cd2..031cd10ed17f 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -60,7 +60,7 @@ obj-$(CONFIG_NUMA_EMU)		+= numa_emulation.o
 
 obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
-obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
+obj-$(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)	+= pti.o
 
 obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
diff --git a/arch/x86/mm/debug_pagetables.c b/arch/x86/mm/debug_pagetables.c
index b43301cb2a80..ae5c213a1cb0 100644
--- a/arch/x86/mm/debug_pagetables.c
+++ b/arch/x86/mm/debug_pagetables.c
@@ -22,7 +22,7 @@ static int ptdump_curknl_show(struct seq_file *m, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(ptdump_curknl);
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 static int ptdump_curusr_show(struct seq_file *m, void *v)
 {
 	if (current->mm->pgd)
@@ -54,7 +54,7 @@ static int __init pt_dump_debug_init(void)
 	debugfs_create_file("current_kernel", 0400, dir, NULL,
 			    &ptdump_curknl_fops);
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	debugfs_create_file("current_user", 0400, dir, NULL,
 			    &ptdump_curusr_fops);
 #endif
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e1b599ecbbc2..b7b88c1d91ec 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -408,7 +408,7 @@ void ptdump_walk_pgd_level_debugfs(struct seq_file *m, struct mm_struct *mm,
 				   bool user)
 {
 	pgd_t *pgd = mm->pgd;
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	if (user && boot_cpu_has(X86_FEATURE_PTI))
 		pgd = kernel_to_user_pgdp(pgd);
 #endif
@@ -418,7 +418,7 @@ EXPORT_SYMBOL_GPL(ptdump_walk_pgd_level_debugfs);
 
 void ptdump_walk_user_pgd_level_checkwx(void)
 {
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	pgd_t *pgd = INIT_PGD;
 
 	if (!(__supported_pte_mask & _PAGE_NX) ||
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 0cbc1b8e8e3d..cceb779d882d 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -293,7 +293,7 @@ static void pgd_mop_up_pmds(struct mm_struct *mm, pgd_t *pgdp)
 	for (i = 0; i < PREALLOCATED_PMDS; i++)
 		mop_up_one_pmd(mm, &pgdp[i]);
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 
 	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
@@ -325,7 +325,7 @@ static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmds[])
 	}
 }
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 static void pgd_prepopulate_user_pmd(struct mm_struct *mm,
 				     pgd_t *k_pgd, pmd_t *pmds[])
 {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 453ea95b667d..77f448e55bf8 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -89,10 +89,10 @@
 #define CR3_HW_ASID_BITS		12
 
 /*
- * When enabled, PAGE_TABLE_ISOLATION consumes a single bit for
+ * When enabled, MITIGATION_PAGE_TABLE_ISOLATION consumes a single bit for
  * user/kernel switches
  */
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 # define PTI_CONSUMED_PCID_BITS	1
 #else
 # define PTI_CONSUMED_PCID_BITS	0
@@ -114,7 +114,7 @@ static inline u16 kern_pcid(u16 asid)
 {
 	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	/*
 	 * Make sure that the dynamic ASID space does not conflict with the
 	 * bit we are using to switch between user and kernel ASIDs.
@@ -149,7 +149,7 @@ static inline u16 kern_pcid(u16 asid)
 static inline u16 user_pcid(u16 asid)
 {
 	u16 ret = kern_pcid(asid);
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	ret |= 1 << X86_CR3_PTI_PCID_USER_BIT;
 #endif
 	return ret;
@@ -262,7 +262,7 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
 static inline void invalidate_user_asid(u16 asid)
 {
 	/* There is no user ASID if address space separation is off */
-	if (!IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION))
+	if (!IS_ENABLED(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION))
 		return;
 
 	/*
diff --git a/include/linux/pti.h b/include/linux/pti.h
index 1a941efcaa62..1fbf9d6c20ef 100644
--- a/include/linux/pti.h
+++ b/include/linux/pti.h
@@ -2,7 +2,7 @@
 #ifndef _INCLUDE_PTI_H
 #define _INCLUDE_PTI_H
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 #include <asm/pti.h>
 #else
 static inline void pti_init(void) { }
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 3d61b2432991..aeb3fbbbce46 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -44,7 +44,7 @@
 # define DISABLE_LA57	(1<<(X86_FEATURE_LA57 & 31))
 #endif
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 # define DISABLE_PTI		0
 #else
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
-- 
2.34.1

