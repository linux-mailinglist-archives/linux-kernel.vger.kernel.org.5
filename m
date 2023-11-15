Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EF97EC9CD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjKORh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjKORhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:37:43 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BB683
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:38 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7789a4c01ddso456314085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069857; x=1700674657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxm7rj1nNs1AxdmMRh1p1RVuTse+b2SlzLkV0LVvDBU=;
        b=iDAvRoTyGuyIGDfa3wfdJU3vhm8OjtJjhH8gZTj6uZXuZ5Z/C6cojYYCyjEObu243b
         rzt+Ay01W9KuZm4nl/iQCymlIuCtYrjx6aj+Z75kOWzquRRlcxusagEMa8+Yyodh1e/N
         O7XrhGxtjkStBDZvNADs9hQZ/bV0soX9heP5QBfkfBe3mgoCuKG2CT0vyBviI7Z8Ucu/
         Ltt79ZnMFd1+T5wf3+X585c+cII6nJcl049CrmutnSPIDTAd+JcGfj4aqqldRCB2aqvG
         gnbcv86DKUE6E2n0zPa8vTvWsquxlxGyG4/BeekihPYE/9Out9+moOsoFpjRzuUDGvbC
         HisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069857; x=1700674657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxm7rj1nNs1AxdmMRh1p1RVuTse+b2SlzLkV0LVvDBU=;
        b=lv2XfPd6nEQXgbjkeWC3z6MdZ8Hltdd1MQ8yaJpXyjomls2xKM+bF1SUl2uZA2sz85
         0Y2eh/u0gSd4EcGwxj3vVDFx/qFgyEHPzgnlCDM2c14NBWV8AUzp6hmmq2Rz93v8UoDy
         yzW2U4PGyKYJYwTR+iG3/G5C4+ZPYa4METatoXDVMgj2BMwZhNzW/eoNY+Oa1rQs+A32
         /SlxHEnMOK6Lx2eznwVvdEhYqDW6s/2icGQYgA+ltJZBgl0lRjEiHevbalyqdYTH9VWl
         hhxvrt16FS8/GnAsMGbeXtbDhoFk1nHMXQe/3iGnP74P1CXTxzJ8D09dKkcior2qjI/L
         uBfQ==
X-Gm-Message-State: AOJu0Ywk141eJ+aRY0gyI5dXm9yqevMPgXs5KfvHbq4SNIA/IUlEWuFw
        3ZQ6rTUFs9DDSdnJ72iq7BLYY5amZg==
X-Google-Smtp-Source: AGHT+IFWoKnkzh2sJI0YvIv6Zk4oTeGY1P2gC/wOCClYJ/hpiehbfxjiCRYsfqxU5qJ1L6qu2xAyBg==
X-Received: by 2002:a05:620a:118e:b0:778:8da0:a6a2 with SMTP id b14-20020a05620a118e00b007788da0a6a2mr5872469qkk.28.1700069856945;
        Wed, 15 Nov 2023 09:37:36 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077bda014d8esm3260099qkg.87.2023.11.15.09.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:37:36 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>, David.Laight@aculab.com,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 09/14] x86/percpu/64: Use relative percpu offsets
Date:   Wed, 15 Nov 2023 12:37:03 -0500
Message-ID: <20231115173708.108316-10-brgerst@gmail.com>
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

The percpu section is currently linked at virtual address 0, because
older compilers hardcoded the stack protector canary value at a fixed
offset from the start of the GS segment.  Now that the canary is a
normal percpu variable, the percpu section can be linked normally.
This means that x86-64 will calculate percpu offsets like most other
architectures, as the delta between the initial percpu address and the
dynamically allocated memory.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/processor.h |  6 +++++-
 arch/x86/kernel/head_64.S        | 19 +++++++++----------
 arch/x86/kernel/setup_percpu.c   | 12 ++----------
 arch/x86/kernel/vmlinux.lds.S    | 29 +----------------------------
 arch/x86/platform/pvh/head.S     |  5 ++---
 arch/x86/tools/relocs.c          | 10 +++-------
 arch/x86/xen/xen-head.S          |  9 ++++-----
 init/Kconfig                     |  2 +-
 8 files changed, 27 insertions(+), 65 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3ee091225904..73fa9d4d2e16 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -403,7 +403,11 @@ DECLARE_INIT_PER_CPU(fixed_percpu_data);
 
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
-	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
+#ifdef CONFIG_SMP
+	return per_cpu_offset(cpu);
+#else
+	return 0;
+#endif
 }
 
 extern asmlinkage void entry_SYSCALL32_ignore(void);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 0d94d2a091fe..fe73e1c4cc5d 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -70,11 +70,14 @@ SYM_CODE_START_NOALIGN(startup_64)
 
 	leaq	_text(%rip), %rdi
 
-	/* Setup GSBASE to allow stack canary access for C code */
+	/*
+	 * Set up GSBASE.
+	 * Note that, on SMP, the boot cpu uses init data section until
+	 * the per cpu areas are set up.
+	 */
 	movl	$MSR_GS_BASE, %ecx
-	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
-	movl	%edx, %eax
-	shrq	$32,  %rdx
+	xorl	%eax, %eax
+	xorl	%edx, %edx
 	wrmsr
 
 	call	startup_64_setup_env
@@ -343,16 +346,12 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movl %eax,%fs
 	movl %eax,%gs
 
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data.
+	/*
+	 * Set up GSBASE.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-#ifndef CONFIG_SMP
-	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
-#endif
 	movl	%edx, %eax
 	shrq	$32, %rdx
 	wrmsr
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 2c97bf7b56ae..8707dd07b9ce 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -23,18 +23,10 @@
 #include <asm/cpumask.h>
 #include <asm/cpu.h>
 
-#ifdef CONFIG_X86_64
-#define BOOT_PERCPU_OFFSET ((unsigned long)__per_cpu_load)
-#else
-#define BOOT_PERCPU_OFFSET 0
-#endif
-
-DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off) = BOOT_PERCPU_OFFSET;
+DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
 EXPORT_PER_CPU_SYMBOL(this_cpu_off);
 
-unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init = {
-	[0 ... NR_CPUS-1] = BOOT_PERCPU_OFFSET,
-};
+unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init;
 EXPORT_SYMBOL(__per_cpu_offset);
 
 /*
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1239be7cc8d8..57a83fb2d8a0 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -103,12 +103,6 @@ const_pcpu_hot = pcpu_hot;
 PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
 	data PT_LOAD FLAGS(6);          /* RW_ */
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_SMP
-	percpu PT_LOAD FLAGS(6);        /* RW_ */
-#endif
-	init PT_LOAD FLAGS(7);          /* RWE */
-#endif
 	note PT_NOTE FLAGS(0);          /* ___ */
 }
 
@@ -224,21 +218,7 @@ SECTIONS
 		__init_begin = .; /* paired with __init_end */
 	}
 
-#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
-	/*
-	 * percpu offsets are zero-based on SMP.  PERCPU_VADDR() changes the
-	 * output PHDR, so the next output section - .init.text - should
-	 * start another segment - init.
-	 */
-	PERCPU_VADDR(INTERNODE_CACHE_BYTES, 0, :percpu)
-	ASSERT(SIZEOF(.data..percpu) < CONFIG_PHYSICAL_START,
-	       "per-CPU data too large - increase CONFIG_PHYSICAL_START")
-#endif
-
 	INIT_TEXT_SECTION(PAGE_SIZE)
-#ifdef CONFIG_X86_64
-	:init
-#endif
 
 	/*
 	 * Section for code used exclusively before alternatives are run. All
@@ -368,9 +348,7 @@ SECTIONS
 		EXIT_DATA
 	}
 
-#if !defined(CONFIG_X86_64) || !defined(CONFIG_SMP)
 	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
-#endif
 
 	. = ALIGN(PAGE_SIZE);
 
@@ -508,16 +486,11 @@ SECTIONS
  * Per-cpu symbols which need to be offset from __per_cpu_load
  * for the boot processor.
  */
-#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
+#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x)
 INIT_PER_CPU(gdt_page);
 INIT_PER_CPU(fixed_percpu_data);
 INIT_PER_CPU(irq_stack_backing_store);
 
-#ifdef CONFIG_SMP
-. = ASSERT((fixed_percpu_data == 0),
-           "fixed_percpu_data is not at start of per-cpu area");
-#endif
-
 #ifdef CONFIG_CPU_UNRET_ENTRY
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 #endif
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index fab90368481f..2ce07dffc314 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -100,9 +100,8 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	 * the per cpu areas are set up.
 	 */
 	mov $MSR_GS_BASE,%ecx
-	lea INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
-	mov %edx, %eax
-	shr $32, %rdx
+	xor %eax, %eax
+	xor %edx, %edx
 	wrmsr
 
 	call xen_prepare_pvh
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 24ad10c62840..ef355242a8d8 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -822,12 +822,7 @@ static void percpu_init(void)
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 {
-	int shndx = sym_index(sym);
-
-	return (shndx == per_cpu_shndx) &&
-		strcmp(symname, "__init_begin") &&
-		strcmp(symname, "__per_cpu_load") &&
-		strncmp(symname, "init_per_cpu_", 13);
+	return 0;
 }
 
 
@@ -1051,7 +1046,8 @@ static int cmp_relocs(const void *va, const void *vb)
 
 static void sort_relocs(struct relocs *r)
 {
-	qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
+	if (r->count)
+		qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
 }
 
 static int write32(uint32_t v, FILE *f)
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 30f27e757354..7e8754c5fa1d 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -51,15 +51,14 @@ SYM_CODE_START(startup_xen)
 
 	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
 
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data.
+	/*
+	 * Set up GSBASE.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movq	$INIT_PER_CPU_VAR(fixed_percpu_data),%rax
-	cdq
+	xorl	%eax, %eax
+	xorl	%edx, %edx
 	wrmsr
 
 	mov	%rsi, %rdi
diff --git a/init/Kconfig b/init/Kconfig
index 9ffb103fc927..5f2c1f4a16aa 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1718,7 +1718,7 @@ config KALLSYMS_ALL
 config KALLSYMS_ABSOLUTE_PERCPU
 	bool
 	depends on KALLSYMS
-	default X86_64 && SMP
+	default n
 
 config KALLSYMS_BASE_RELATIVE
 	bool
-- 
2.41.0

