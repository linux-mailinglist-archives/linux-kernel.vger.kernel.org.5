Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEEC7D8662
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345560AbjJZQBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345529AbjJZQBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:01:35 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17591B3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:31 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7b91faf40so8371237b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698336090; x=1698940890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8bf/choau5eM7/3Y9MdeM+IwC0QQbaOD15x1tu2PeM=;
        b=Y4Up4BVZsbfjbSK+Twtai/gpBBQfpx4/iHHwZEu5/O8A2w2b/fOwfXWsH0vHXSTqre
         UnQG2H2bqqCVyiMDJ9tBLaG0rzdN05e68gpvXPs5nbMhD/FEbpKJ9OE6nFezpR7zt/9J
         SjVjAXPyaHMhla/bKnhqRieDuY+Vq5vhXgtnxPS54RUnIKcr6ZAmG62ZvYAGUS5IR9K0
         37eTs8mORYGYVwPk4PQ4XAXCeRhfD/2WGQE91K2yQbi1tQ1oPkCZwY2EKkcCSp3TGavx
         NWF9AksnUpORX/rvyuZAhuIttvlfX0EET2g1WyPX3GwsTu6r90K/x7HudrKouHfE9QPN
         8Cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698336090; x=1698940890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8bf/choau5eM7/3Y9MdeM+IwC0QQbaOD15x1tu2PeM=;
        b=tOSUarFKnzjebv1hEyVd0SOuoHq9eGXZAPvKtbsV0MujZJet5QdBj5YpsGth5wENMo
         4u/Dvu2XSZxCDtDets+1lgTrv8M1xkeoVW+3JJgaUfJc0Xf1mt42CcxRTu5Wcb+gVAMo
         eROmp2VSL7N5sPLEwGRFEZO8PHCbk+EPJfacsdVqUNQ3msUe36BsUKmON+9a+5EIUVWo
         D0xVRNyB8fE5jCvP4SFSU5qTgDSZA6Z7d39AyGC1CySp+23KKadIEKA2QudVUSHZOqHQ
         Q0qyMn2pfR+wkoE0KEWD6kOWJ3jjs9Sg3v67xRQUt8hbNTsSMYtBGiq/O6a+fKsArkGY
         Y7WA==
X-Gm-Message-State: AOJu0YxkgkaOJjjCMEJoKeryHhlNXYTOs1kJZEmBl5PWhNE9iZOf50lT
        Iim6kF5Bh3/M8GMUM/5A0ZG7sH96sw==
X-Google-Smtp-Source: AGHT+IFy0gwV8D3GKdWXw9TqrwckKSjIDzohxA4p+XWiDjaeqbnNHSqBN7Igi088mknzyC7770GNzw==
X-Received: by 2002:a81:8943:0:b0:5a8:1058:5d97 with SMTP id z64-20020a818943000000b005a810585d97mr19244991ywf.45.1698336090168;
        Thu, 26 Oct 2023 09:01:30 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id a71-20020a0dd84a000000b005a20ab8a184sm6130129ywe.31.2023.10.26.09.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:01:29 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 05/11] x86/stackprotector/64: Convert stack protector to normal percpu variable
Date:   Thu, 26 Oct 2023 12:00:54 -0400
Message-ID: <20231026160100.195099-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026160100.195099-1-brgerst@gmail.com>
References: <20231026160100.195099-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Since version 8.1, GCC has options to configure the location of the
canary value.  This allows the canary to be turned into a normal
percpu variable and removes the constraint that the percpu section
be zero-based.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                      |  5 ++--
 arch/x86/Makefile                     | 19 +++++++++-----
 arch/x86/entry/entry_64.S             |  2 +-
 arch/x86/include/asm/processor.h      | 15 +----------
 arch/x86/include/asm/stackprotector.h | 37 +++++----------------------
 arch/x86/kernel/asm-offsets_64.c      |  6 -----
 arch/x86/kernel/cpu/common.c          |  4 +--
 arch/x86/kernel/head_64.S             |  3 +--
 arch/x86/xen/xen-head.S               |  3 +--
 9 files changed, 26 insertions(+), 68 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 92144c6f26d2..c95e0ce557da 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -410,12 +410,11 @@ config PGTABLE_LEVELS
 
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
-	default y if 64BIT
+	default $(cc-option,-mstack-protector-guard-reg=gs -mstack-protector-guard-symbol=__stack_chk_guard) if 64BIT
 	default $(cc-option,-mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard)
 	help
 	  We have to make sure stack protector is unconditionally disabled if
-	  the compiler produces broken code or if it does not let us control
-	  the segment on 32-bit kernels.
+	  the compiler does not allow control of the segment and symbol.
 
 menu "Processor type and features"
 
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 22e41d9dbc23..6ab8b4419f41 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -111,13 +111,7 @@ ifeq ($(CONFIG_X86_32),y)
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
@@ -167,6 +161,17 @@ else
         KBUILD_CFLAGS += -mcmodel=kernel
         KBUILD_RUSTFLAGS += -Cno-redzone=y
         KBUILD_RUSTFLAGS += -Ccode-model=kernel
+
+	percpu_seg := gs
+endif
+
+ifeq ($(CONFIG_STACKPROTECTOR),y)
+	ifeq ($(CONFIG_SMP),y)
+		KBUILD_CFLAGS += -mstack-protector-guard-reg=$(percpu_seg)
+		KBUILD_CFLAGS += -mstack-protector-guard-symbol=__stack_chk_guard
+	else
+		KBUILD_CFLAGS += -mstack-protector-guard=global
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
index 4b130d894cb6..2b6531d90273 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -394,16 +394,7 @@ struct irq_stack {
 
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
 };
 
 DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;
@@ -418,11 +409,7 @@ extern asmlinkage void entry_SYSCALL32_ignore(void);
 
 /* Save actual FS/GS selectors and bases to current->thread */
 void current_save_fsgs(void);
-#else	/* X86_64 */
-#ifdef CONFIG_STACKPROTECTOR
-DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
-#endif
-#endif	/* !X86_64 */
+#endif /* X86_64 */
 
 struct perf_event;
 
diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 00473a650f51..33abbd29ea26 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -2,26 +2,13 @@
 /*
  * GCC stack protector support.
  *
- * Stack protector works by putting predefined pattern at the start of
+ * Stack protector works by putting a predefined pattern at the start of
  * the stack frame and verifying that it hasn't been overwritten when
- * returning from the function.  The pattern is called stack canary
- * and unfortunately gcc historically required it to be at a fixed offset
- * from the percpu segment base.  On x86_64, the offset is 40 bytes.
+ * returning from the function.  The pattern is called the stack canary
+ * and is a unique value for each task.
  *
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
+ * GCC is configured to read the stack canary value from the __stack_chk_guard
+ * per-cpu variable, which is changed on task switch.
  */
 
 #ifndef _ASM_STACKPROTECTOR_H
@@ -36,6 +23,8 @@
 
 #include <linux/sched.h>
 
+DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
+
 /*
  * Initialize the stackprotector canary value.
  *
@@ -51,25 +40,13 @@ static __always_inline void boot_init_stack_canary(void)
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
index 9058da9ae011..fb8f0371ffc3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2104,15 +2104,13 @@ void syscall_init(void)
 	       X86_EFLAGS_AC|X86_EFLAGS_ID);
 }
 
-#else	/* CONFIG_X86_64 */
+#endif	/* CONFIG_X86_64 */
 
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

