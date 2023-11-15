Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5727EC9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjKORhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjKORhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:37:41 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55161D48
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:37 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7781bc3783fso459166285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069855; x=1700674655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtJ0rnAMMvu0qTTk2sGNJank9S4dE7egD/BT6LvuAOM=;
        b=gZeJ++nom6xVXbXIMXz0VIkKa1sAncCLIlYj5JtTC6ePRGw1xXyrHFGZeR57E4HkYf
         LXiO7bo8V8oDvcthsUmZjxHf6nZvQfEYIQVEYAiIyfGerfrKT8smaru22mDbg0wD0Jt/
         GVlyaNs7LPjluOGEjcG/4+2UTtn6BN77TkJMemuJIFzHQbm2D1IV/LC0t3prAsaUOy5Y
         nW/hNZY5hRyG+dFTylA+y/Jb902iDMAWa+06XF7qb73UgwwOv6fzMA4bwwghxTNZvDWb
         hq3FTPYA6ixXGgnbXEhnwrzQv07ZEQCX6MJ9oXZOad4m/W/AhKTikbbYeRDKmWeRA9Qa
         7EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069855; x=1700674655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtJ0rnAMMvu0qTTk2sGNJank9S4dE7egD/BT6LvuAOM=;
        b=rgRM/B2JDIRYdUsIyA3MDPyGKLt+hHQwy8nWZ4/BfUvDg6NU4tvDU+VkS9UwQX7Eh6
         vW/tJ9e2Mc31494eEab2q3TMqetODSEDymBuc5ogZoPJpV24orrWSMZSqnINqt+/WhoU
         hhCqKL0gI+wQKPdwrNFC1Yz37kuDkKUMDROj//vGVTG+dAm2eVOjz5O37/yuoa51NiTz
         r9/WU8BW+PuqKNrAJQDhfoECA3NllpfYX1Gb5YGOHXMS9Vysrb0IWeCu3tFO0oUU4O8C
         IXVw1IVKKB/qxnBH5CYiCxP6LAQidBDeHDLsFKAlBctwqcdiNu3yxKUUpEeoWCh4Thy/
         C19A==
X-Gm-Message-State: AOJu0YwDpYXAgZKBB48PqzGVVYT8B8dLSw8JdxTXr08xEaxgZ5atKo2+
        h/CCR9ncJp28BcTaRQ6TxMWQGRF6Bw==
X-Google-Smtp-Source: AGHT+IGoyEoIHIylVJJPlxpgTBEFasM2YeujOc6F2/G6+EUfcXBIXlq9zuNoBlNn/MVBwRskr5jCng==
X-Received: by 2002:a05:620a:29c8:b0:76f:1d46:4a9f with SMTP id s8-20020a05620a29c800b0076f1d464a9fmr5982220qkp.4.1700069855299;
        Wed, 15 Nov 2023 09:37:35 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077bda014d8esm3260099qkg.87.2023.11.15.09.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:37:34 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>, David.Laight@aculab.com,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 08/14] x86/stackprotector/64: Convert to normal percpu variable
Date:   Wed, 15 Nov 2023 12:37:02 -0500
Message-ID: <20231115173708.108316-9-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115173708.108316-1-brgerst@gmail.com>
References: <20231115173708.108316-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older versions of GCC fixed the location of the stack protector canary
at %gs:40.  This constraint forced the percpu section to be linked at
virtual address 0 so that the canary could be the first data object in
the percpu section.  Supporting the zero-based percpu section requires
additional code to handle relocations for RIP-relative references to
percpu data, extra complexity to kallsyms, and workarounds for linker
bugs due to the use of absolute symbols.

Use compiler options to redefine the stack protector location if
supported, otherwise use objtool.  This will remove the contraint that
the percpu section must be zero-based.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                      | 11 ++++----
 arch/x86/Makefile                     | 21 ++++++++++------
 arch/x86/entry/entry_64.S             |  2 +-
 arch/x86/include/asm/processor.h      | 16 ++----------
 arch/x86/include/asm/stackprotector.h | 36 ++++-----------------------
 arch/x86/kernel/asm-offsets_64.c      |  6 -----
 arch/x86/kernel/cpu/common.c          |  4 +--
 arch/x86/kernel/head_64.S             |  3 +--
 arch/x86/xen/xen-head.S               |  3 +--
 9 files changed, 30 insertions(+), 72 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6cee46127fd2..83404b741c0a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -266,7 +266,7 @@ config X86
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_SETUP_PER_CPU_AREA
 	select HAVE_SOFTIRQ_ON_OWN_STACK
-	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
+	select HAVE_STACKPROTECTOR		if X86_64 || CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
@@ -410,15 +410,14 @@ config PGTABLE_LEVELS
 
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
-	default y if 64BIT
+	default $(cc-option,-mstack-protector-guard-reg=gs -mstack-protector-guard-symbol=__stack_chk_guard) if 64BIT
 	default $(cc-option,-mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard)
-	help
-	  We have to make sure stack protector is unconditionally disabled if
-	  the compiler does not allow control of the segment and symbol.
 
 config STACKPROTECTOR_OBJTOOL
 	bool
-	default n
+	depends on X86_64 && STACKPROTECTOR
+	default !CC_HAS_SANE_STACKPROTECTOR
+	prompt "Debug objtool stack protector conversion" if CC_HAS_SANE_STACKPROTECTOR && DEBUG_KERNEL
 
 menu "Processor type and features"
 
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1a068de12a56..06a79361e88f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -112,13 +112,7 @@ ifeq ($(CONFIG_X86_32),y)
         # temporary until string.h is fixed
         KBUILD_CFLAGS += -ffreestanding
 
-	ifeq ($(CONFIG_STACKPROTECTOR),y)
-		ifeq ($(CONFIG_SMP),y)
-			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
-		else
-			KBUILD_CFLAGS += -mstack-protector-guard=global
-		endif
-	endif
+	percpu_seg := fs
 else
         BITS := 64
         UTS_MACHINE := x86_64
@@ -168,6 +162,19 @@ else
         KBUILD_CFLAGS += -mcmodel=kernel
         KBUILD_RUSTFLAGS += -Cno-redzone=y
         KBUILD_RUSTFLAGS += -Ccode-model=kernel
+
+	percpu_seg := gs
+endif
+
+ifeq ($(CONFIG_STACKPROTECTOR),y)
+	ifneq ($(CONFIG_STACKPROTECTOR_OBJTOOL),y)
+		ifeq ($(CONFIG_SMP),y)
+			KBUILD_CFLAGS += -mstack-protector-guard-reg=$(percpu_seg)
+			KBUILD_CFLAGS += -mstack-protector-guard-symbol=__stack_chk_guard
+		else
+			KBUILD_CFLAGS += -mstack-protector-guard=global
+		endif
+	endif
 endif
 
 #
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1a88ad8a7b48..cddcc236aaae 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -190,7 +190,7 @@ SYM_FUNC_START(__switch_to_asm)
 
 #ifdef CONFIG_STACKPROTECTOR
 	movq	TASK_stack_canary(%rsi), %rbx
-	movq	%rbx, PER_CPU_VAR(fixed_percpu_data + FIXED_stack_canary)
+	movq	%rbx, PER_CPU_VAR(__stack_chk_guard)
 #endif
 
 	/*
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 061aa86b4662..3ee091225904 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -394,16 +394,8 @@ struct irq_stack {
 
 #ifdef CONFIG_X86_64
 struct fixed_percpu_data {
-	/*
-	 * GCC hardcodes the stack canary as %gs:40.  Since the
-	 * irq_stack is the object at %gs:0, we reserve the bottom
-	 * 48 bytes of the irq stack for the canary.
-	 *
-	 * Once we are willing to require -mstack-protector-guard-symbol=
-	 * support for x86_64 stackprotector, we can get rid of this.
-	 */
 	char		gs_base[40];
-	unsigned long	stack_canary;
+	unsigned long	reserved;
 };
 
 DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;
@@ -418,11 +410,7 @@ extern asmlinkage void entry_SYSCALL32_ignore(void);
 
 /* Save actual FS/GS selectors and bases to current->thread */
 void current_save_fsgs(void);
-#else	/* X86_64 */
-#ifdef CONFIG_STACKPROTECTOR
-DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
-#endif
-#endif	/* !X86_64 */
+#endif	/* X86_64 */
 
 struct perf_event;
 
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 00473a650f51..d43fb589fcf6 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -2,26 +2,10 @@
 /*
  * GCC stack protector support.
  *
- * Stack protector works by putting predefined pattern at the start of
+ * Stack protector works by putting a predefined pattern at the start of
  * the stack frame and verifying that it hasn't been overwritten when
- * returning from the function.  The pattern is called stack canary
- * and unfortunately gcc historically required it to be at a fixed offset
- * from the percpu segment base.  On x86_64, the offset is 40 bytes.
- *
- * The same segment is shared by percpu area and stack canary.  On
- * x86_64, percpu symbols are zero based and %gs (64-bit) points to the
- * base of percpu area.  The first occupant of the percpu area is always
- * fixed_percpu_data which contains stack_canary at the appropriate
- * offset.  On x86_32, the stack canary is just a regular percpu
- * variable.
- *
- * Putting percpu data in %fs on 32-bit is a minor optimization compared to
- * using %gs.  Since 32-bit userspace normally has %fs == 0, we are likely
- * to load 0 into %fs on exit to usermode, whereas with percpu data in
- * %gs, we are likely to load a non-null %gs on return to user mode.
- *
- * Once we are willing to require GCC 8.1 or better for 64-bit stackprotector
- * support, we can remove some of this complexity.
+ * returning from the function.  The pattern is called the stack canary
+ * and is a unique value for each task.
  */
 
 #ifndef _ASM_STACKPROTECTOR_H
@@ -36,6 +20,8 @@
 
 #include <linux/sched.h>
 
+DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
+
 /*
  * Initialize the stackprotector canary value.
  *
@@ -51,25 +37,13 @@ static __always_inline void boot_init_stack_canary(void)
 {
 	unsigned long canary = get_random_canary();
 
-#ifdef CONFIG_X86_64
-	BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) != 40);
-#endif
-
 	current->stack_canary = canary;
-#ifdef CONFIG_X86_64
-	this_cpu_write(fixed_percpu_data.stack_canary, canary);
-#else
 	this_cpu_write(__stack_chk_guard, canary);
-#endif
 }
 
 static inline void cpu_init_stack_canary(int cpu, struct task_struct *idle)
 {
-#ifdef CONFIG_X86_64
-	per_cpu(fixed_percpu_data.stack_canary, cpu) = idle->stack_canary;
-#else
 	per_cpu(__stack_chk_guard, cpu) = idle->stack_canary;
-#endif
 }
 
 #else	/* STACKPROTECTOR */
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index bb65371ea9df..590b6cd0eac0 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -54,11 +54,5 @@ int main(void)
 	BLANK();
 #undef ENTRY
 
-	BLANK();
-
-#ifdef CONFIG_STACKPROTECTOR
-	OFFSET(FIXED_stack_canary, fixed_percpu_data, stack_canary);
-	BLANK();
-#endif
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4d4b87c6885d..b5b1d95b1399 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2111,15 +2111,13 @@ void syscall_init(void)
 	       X86_EFLAGS_AC|X86_EFLAGS_ID);
 }
 
-#else	/* CONFIG_X86_64 */
+#endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_STACKPROTECTOR
 DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
 
-#endif	/* CONFIG_X86_64 */
-
 /*
  * Clear all 6 debug registers:
  */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3dcabbc49149..0d94d2a091fe 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -345,8 +345,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to fixed_percpu_data. If the
-	 * stack protector canary is enabled, it is located at %gs:40.
+	 * The base of %gs always points to fixed_percpu_data.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index a0ea285878db..30f27e757354 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -53,8 +53,7 @@ SYM_CODE_START(startup_xen)
 
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to fixed_percpu_data.  If the
-	 * stack protector canary is enabled, it is located at %gs:40.
+	 * The base of %gs always points to fixed_percpu_data.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
-- 
2.41.0

