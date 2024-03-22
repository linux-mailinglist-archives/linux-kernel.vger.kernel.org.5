Return-Path: <linux-kernel+bounces-111819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F59C887151
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CFD1F238CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7989F605D3;
	Fri, 22 Mar 2024 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcaeD4vo"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA2605B3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126381; cv=none; b=Ak/42WoqzI6+MCzZHLL4f6U/cckNwVVHSmgMEFFv7iFFAPbPIQtcvfjqLhnn6/nNznszidzPHICiWvj5qEr63tdwSJi/6mw69a47FZJ3VLdjjllnGQPDZVKNMA0bqdNWvqQkGXd51E/TRcQJO4xF/IVnX3T5nIu7p0CJUCOwY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126381; c=relaxed/simple;
	bh=w74KHiO+YST9ARW1jHTpRqiePbvHH2TmcOuZXl0KFiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wzk8dU/BF4uFUccgAe00XwSHKyGcOPOS8/9ZmWYWyzBmN8XqMUzuMZmDpLi74Of/eLzbHmcUxrCZNEIDZO4m4E/MlDod7NLFIoovYSEUqTmEt/xBlRlN2VasYicsdYE/AYNbKFzPC6A8AG8F1CYUazrUOifbiGL0kL5jh9mDS0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcaeD4vo; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78a15537fa1so140542785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126378; x=1711731178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W92Rk8kM7/AXvQoVC7dyXuqJmhy1XSFxQGTPsQsT0t4=;
        b=jcaeD4voozas/8GrhH/lTqgNPu/M6j/3a9pDH/vzThW7OmOWXnOAvh2e3+zEQLu47M
         k+IJYC8JNcyI4X+uLqpmtXCBequgmEPjp8p4EdcWpDbPlFBtQjl3Bh/Pkoz3Rc2j6BZi
         eWqCivx4Z+ckgu84WaGkEhtN5FzulHA6qE1w1MthEWJegdqoZdLzzKeux1hIQL9M6T6L
         gqRYhfHbap9Hov/lYxZd6ozHDjtbij+Ohg8APydE/APdX6fXIZ+KHRsAJ+YaXlhlmWTF
         htwL9vY/XLMuTPaTJ12NAMYj2bw6WIyRMPV64hBYIX1Vc61/68D3qxY8Y0WwaUOjnPzp
         xJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126378; x=1711731178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W92Rk8kM7/AXvQoVC7dyXuqJmhy1XSFxQGTPsQsT0t4=;
        b=hMrtShVfvf7UhTz5P9cMzp4p63X3/pey7xgsGl3rDngmSLMpBc8salEb1ngt0fxTx6
         i+tgfcvEHK0GSlMxJJWO0382dK2+PCOfDDTHMncCsO+7Awmev9Wgpea3XnQOD1sWoQmW
         8sSo4x2PVGJGJppHtgbzdHmRPkgv6IA6x4RqYs9b+YgkCnCA4L9xcmozq5LnnsJjoYK/
         SlQgVpje8xzr26qFKxA5GT0isv4xKJUOFVu0B7JqHAltjniZNcy0+mEeW4+e9RHUkI65
         BsYp4QJo9Fc81DEuBmY9mkp2TlXkOO1v4BknZ0bLkTc72mDFO0O/SlMwAq4gfW/wEQNu
         sPDw==
X-Gm-Message-State: AOJu0YzMdaY2bowcAPQClJsbx5S9s9NWyy1y+oaeGv8Ocau6HMRvJVrO
	EG+hE0Gk+gNa89/Wob+YcvHuokHLWfgYjAWN1vjd3zmweB9PgO2Y4PFTI8A=
X-Google-Smtp-Source: AGHT+IFOfu8nOq3c30WzRZvtC4ZlrrvO2Eepx/p6GBhCRoKI3ql1SDQRkNJcDPE0t07IpcYeysSlvQ==
X-Received: by 2002:a05:620a:7ed:b0:78a:3fa5:9f30 with SMTP id k13-20020a05620a07ed00b0078a3fa59f30mr8685qkk.14.1711126377705;
        Fri, 22 Mar 2024 09:52:57 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:52:57 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	David.Laight@aculab.com,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 09/16] x86/percpu/64: Use relative percpu offsets
Date: Fri, 22 Mar 2024 12:52:26 -0400
Message-ID: <20240322165233.71698-10-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322165233.71698-1-brgerst@gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The percpu section is currently linked at virtual address 0, because
older compilers hardcoded the stack protector canary value at a fixed
offset from the start of the GS segment.  Now that the canary is a
normal percpu variable, the percpu section does not need to be linked
at a specific virtual address.  This means that x86-64 will calculate
percpu offsets like most other architectures, as the delta between the
initial percpu address and the dynamically allocated memory.

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
index 946bebce396f..40d6add8ff31 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -396,7 +396,11 @@ DECLARE_INIT_PER_CPU(fixed_percpu_data);
 
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
index cfbf0486d424..5b2cc711feec 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -68,11 +68,14 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Set up the stack for verify_cpu() */
 	leaq	__top_init_kernel_stack(%rip), %rsp
 
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
 
 	call	startup_64_setup_gdt_idt
@@ -359,16 +362,12 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
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
index b30d6e180df7..1e7be9409aa2 100644
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
index 3509afc6a672..0b152f96c24e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -99,12 +99,6 @@ const_pcpu_hot = pcpu_hot;
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
 
@@ -222,21 +216,7 @@ SECTIONS
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
@@ -353,9 +333,7 @@ SECTIONS
 		EXIT_DATA
 	}
 
-#if !defined(CONFIG_X86_64) || !defined(CONFIG_SMP)
 	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
-#endif
 
 	. = ALIGN(PAGE_SIZE);
 
@@ -493,16 +471,11 @@ SECTIONS
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
 #ifdef CONFIG_MITIGATION_UNRET_ENTRY
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 #endif
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 1f1c3230b27b..7e3e07c6170f 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -101,9 +101,8 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
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
index adf11a48ec70..016650ddaf7f 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -839,12 +839,7 @@ static void percpu_init(void)
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
 
 
@@ -1068,7 +1063,8 @@ static int cmp_relocs(const void *va, const void *vb)
 
 static void sort_relocs(struct relocs *r)
 {
-	qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
+	if (r->count)
+		qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
 }
 
 static int write32(uint32_t v, FILE *f)
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index ae4672ea00bb..1796884b727d 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -51,15 +51,14 @@ SYM_CODE_START(startup_xen)
 
 	leaq	__top_init_kernel_stack(%rip), %rsp
 
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
index f3ea5dea9c85..0f928f82dc7a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1784,7 +1784,7 @@ config KALLSYMS_ALL
 config KALLSYMS_ABSOLUTE_PERCPU
 	bool
 	depends on KALLSYMS
-	default X86_64 && SMP
+	default n
 
 config KALLSYMS_BASE_RELATIVE
 	bool
-- 
2.44.0


