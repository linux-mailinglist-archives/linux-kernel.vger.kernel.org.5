Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9467D4192
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjJWVRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjJWVRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:17:44 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D434DD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:41 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7a80a96dbso39579967b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698095860; x=1698700660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uj8LskhtlqyoaBwqcGX6oYCEo+qAf73XDhhIGhkA9po=;
        b=da0XDlBnIRWBC5U4tmQvJfeBs/1U5+gK9CqR3YJXbM18L3qRk0990gYZU2lJOUql+2
         pJuVkwXxE+5eszQ+J3RYuhv+nr18h1sJpSKwAhV3uHD6CyzbNrdxK5XM+hBrQxXDgK0z
         tfkju8M0TIMp+/Di4H8VK7BUDH4nrj+QccglUN51OcFqny34hZi9joSSAyo+UveeFrhh
         bQn3f+zn4lbuH3fAVfvComkhLbMUA20LmG0j7zYumUiYKMX76CO/1Wq9/gycHju9Za4v
         0VmA6LJ1N1psorbmkGmuYsb1UgHqCPwn+S9lN21+2+6zU6kC+kVyF+y3WepSMhuFbbjq
         908g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095860; x=1698700660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uj8LskhtlqyoaBwqcGX6oYCEo+qAf73XDhhIGhkA9po=;
        b=BM8/HbLjpIgfFgRMxmYMimYkWYXkpzAw0a0prPgm+fJqZlt2/pfCfmVIgX9zGRObYW
         ckunVbjzssSDXPBakc6BKbDR4BS5tKDL77zxuOp/SSfxyJPT3l7+69I1r1ntTbCROulX
         yxoh86HmaJiJLSt300R+7NKz8M1Mf8p6CKD1iQmKtBiaM5EVKJZPRmgkxBKm5rcKsiNk
         /5d/Do5RuI6Di45rwJu4SqFka8vjhUj4iRf8ZSTbX3Gv7p67ypEMJx3G/uCoaQVXbBTD
         +Gt+e6uslzW78wILlM8/Pt0+pioj9U9Bkx1oUHv9t2hjaBqEeB5jMLfO8XQoAKaQw9Ak
         Z4/g==
X-Gm-Message-State: AOJu0YzK3BBiQDmy21kh60oos4mhIzm3E6cHV6IlgD5xWHsDZmA8EbNM
        /uYjVPFI5HKyJ0dlyPjmSXPJO6+6uA==
X-Google-Smtp-Source: AGHT+IFgakgePs9Vj9E1ZA/nqVv02ZtfFXdKH535gI/M34MutuOTeKybIBimgIrtxo6LQt2ASKoV4Q==
X-Received: by 2002:a81:52cc:0:b0:5a7:af4f:59ad with SMTP id g195-20020a8152cc000000b005a7af4f59admr10395622ywb.0.1698095860215;
        Mon, 23 Oct 2023 14:17:40 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id o139-20020a0dcc91000000b00583e52232f1sm3485430ywd.112.2023.10.23.14.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:17:39 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 3/9] x86/stackprotector/64: Convert stack protector to normal percpu variable
Date:   Mon, 23 Oct 2023 17:17:24 -0400
Message-ID: <20231023211730.40566-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023211730.40566-1-brgerst@gmail.com>
References: <20231023211730.40566-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 arch/x86/Kconfig                          |  5 ++-
 arch/x86/Makefile                         | 19 +++++++-----
 arch/x86/entry/entry_64.S                 |  2 +-
 arch/x86/include/asm/processor.h          | 15 +--------
 arch/x86/include/asm/stackprotector.h     | 37 +++++------------------
 arch/x86/kernel/asm-offsets_64.c          |  6 ----
 arch/x86/kernel/cpu/common.c              |  4 +--
 scripts/gcc-x86_64-has-stack-protector.sh |  4 ---
 8 files changed, 24 insertions(+), 68 deletions(-)
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 039872be1630..c95e0ce557da 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -410,12 +410,11 @@ config PGTABLE_LEVELS
 
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
-	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) $(CLANG_FLAGS)) if 64BIT
+	default $(cc-option,-mstack-protector-guard-reg=gs -mstack-protector-guard-symbol=__stack_chk_guard) if 64BIT
 	default $(cc-option,-mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard)
 	help
 	  We have to make sure stack protector is unconditionally disabled if
-	  the compiler produces broken code or if it does not let us control
-	  the segment on 32-bit kernels.
+	  the compiler does not allow control of the segment and symbol.
 
 menu "Processor type and features"
 
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 22e41d9dbc23..169f086997ec 100644
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
+		KBUILD_CFLAGS += -mstack-protector-guard-reg=$(percpu_seg) \
+				 -mstack-protector-guard-symbol=__stack_chk_guard
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
index ae81a7191c1c..04371f60e3c6 100644
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
index b14fc8c1c953..f9c8bd27b642 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2103,15 +2103,13 @@ void syscall_init(void)
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
diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
deleted file mode 100755
index 75e4e22b986a..000000000000
--- a/scripts/gcc-x86_64-has-stack-protector.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
-- 
2.41.0

