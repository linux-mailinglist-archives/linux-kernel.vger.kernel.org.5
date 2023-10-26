Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF407D8664
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbjJZQB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbjJZQBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:01:36 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE52D1B9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:33 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so781315276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698336092; x=1698940892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzZdKB+Rr9L94zIvXHTcozK/pzpYFPssH1Oc3UCmsKk=;
        b=Fcf0Oq1pfPBzz2o8bl8grY8jviFMstrp+uPSTxy7Xb44AzhuFLaXOBD9O1SO8KLc1G
         uZ13zf2dHK2Aqw7T0jnJ581hidyggXfNdkWezUDGdY6wcs27szYszH4j5A7jjNspJzfo
         QYLHDzVBbNVi2E4g/WyyVAAnl2Z92CQmowQM+5p8bRSNogQEg9UJEDMO6diq0YBZ1opR
         9yiWWzutnMLVY5sXqlhLMGMTtgPUr/NJdnMxvL+O1HjUl0yeZMb01w5/vHLld9DU8/Zk
         41jmK/OvHQJ4NUg+WmsNHNrJbevryi+Br7Yjs7QJLxCwCMHAbe9apLWFZ7hE61rJ1yYU
         t0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698336092; x=1698940892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzZdKB+Rr9L94zIvXHTcozK/pzpYFPssH1Oc3UCmsKk=;
        b=PJI0w7hHUqF9SOj1RNXVqVvAJmW9/R/Fq3rg8RScxQj9ceiP0SRQ6zzwCTZzq5uJ47
         FcRj3mStdUdI6yFcS4hdEfnZybk8KLeCW9yqIYFo2eWuWzSzpwsWp7kLxv5OWyvcS7ZS
         6D3MismLRkSdrnzN4i/QA2l02Jj4pkC18I1oNyRwqmrfToqj0jiREorpJhVl6S2jPt6a
         frfbWY+AXgAuZoUCy0MslW1VuRoAFfw5IalyV1p5KuiSd6O9H3NZt/2q/HnMFTDBG4PV
         c+hCtNldHR8CWLkfJoiSZjba/jyurPK56DYGLpA8L7E5SSTf2azGjMm3TgHpzNfqQINx
         /how==
X-Gm-Message-State: AOJu0Yx2/0viEH9oUF+Y6eMa3lS5AFtqC+rj2Dx32eiwIkXveY2uGgSF
        Ni9UiM1kutY59a9l/MSOpAbuCfwEHw==
X-Google-Smtp-Source: AGHT+IH9FE3qq8naQuR5Pwqxamh3WOxbv1i6lmug4mYAjy3ER2KjIHtRyNUV1pNGMQtfhiNa4m+ckw==
X-Received: by 2002:a81:7354:0:b0:5a8:1973:190a with SMTP id o81-20020a817354000000b005a81973190amr21056414ywc.8.1698336092476;
        Thu, 26 Oct 2023 09:01:32 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id a71-20020a0dd84a000000b005a20ab8a184sm6130129ywe.31.2023.10.26.09.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:01:32 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 07/11] x86/percpu/64: Use relative percpu offsets
Date:   Thu, 26 Oct 2023 12:00:56 -0400
Message-ID: <20231026160100.195099-8-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026160100.195099-1-brgerst@gmail.com>
References: <20231026160100.195099-1-brgerst@gmail.com>
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

The percpu section is currently linked at virtual address 0, because
older compilers hardcoded the stack protector canary value at a fixed
offset from the start of the GS segment.  Now that the canary is a
normal percpu variable, the percpu section can be linked normally.
This means that x86-64 will calculate percpu offsets like most other
architectures, as the delta between the initial percpu address and the
dynamically allocated memory.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/head_64.S      |  6 ------
 arch/x86/kernel/setup_percpu.c | 12 ++----------
 arch/x86/kernel/vmlinux.lds.S  | 24 +-----------------------
 arch/x86/platform/pvh/head.S   |  6 ------
 arch/x86/tools/relocs.c        | 10 +++-------
 arch/x86/xen/xen-head.S        |  6 ------
 init/Kconfig                   |  2 +-
 7 files changed, 7 insertions(+), 59 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index f2453eb38417..b35f74e58dd7 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -72,14 +72,8 @@ SYM_CODE_START_NOALIGN(startup_64)
 
 	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
-#ifdef CONFIG_SMP
-	leaq	__per_cpu_load(%rip), %rdx
-	movl	%edx, %eax
-	shrq	$32,  %rdx
-#else
 	xorl	%eax, %eax
 	xorl	%edx, %edx
-#endif
 	wrmsr
 
 	call	startup_64_setup_env
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
index e6126cd21615..efa4885060b5 100644
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
 
@@ -508,7 +486,7 @@ SECTIONS
  * Per-cpu symbols which need to be offset from __per_cpu_load
  * for the boot processor.
  */
-#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
+#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x)
 INIT_PER_CPU(gdt_page);
 INIT_PER_CPU(irq_stack_backing_store);
 
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index d215b16bf89f..4bd925b23436 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -96,14 +96,8 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 1:
 	/* Set base address in stack canary descriptor. */
 	mov $MSR_GS_BASE,%ecx
-#ifdef CONFIG_SMP
-	lea __per_cpu_load(%rip), %rdx
-	mov %edx, %eax
-	shr $32, %rdx
-#else
 	xor %eax, %eax
 	xor %edx, %edx
-#endif
 	wrmsr
 
 	call xen_prepare_pvh
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 3ccd9d4fcf9c..01efbfdd3eb3 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -815,12 +815,7 @@ static void percpu_init(void)
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
 
 
@@ -1043,7 +1038,8 @@ static int cmp_relocs(const void *va, const void *vb)
 
 static void sort_relocs(struct relocs *r)
 {
-	qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
+	if (r->count)
+		qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
 }
 
 static int write32(uint32_t v, FILE *f)
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 9ce0d9d268bb..c1d9c92b417a 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -57,14 +57,8 @@ SYM_CODE_START(startup_xen)
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-#ifdef CONFIG_SMP
-	leaq	__per_cpu_load(%rip), %rdx
-	movl	%edx, %eax
-	shrq	$32, %rdx
-#else
 	xorl	%eax, %eax
 	xorl	%edx, %edx
-#endif
 	wrmsr
 
 	mov	%rsi, %rdi
diff --git a/init/Kconfig b/init/Kconfig
index 6d35728b94b2..1af31b23e376 100644
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

