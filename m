Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECD07D4193
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjJWVSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjJWVRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:17:46 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912FC10C0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:43 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7e5dc8573so38040987b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698095862; x=1698700662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKtCKkTSYC7hZ3rLuwOCTXUI3GkJ5ijCz5zkNO2WTMs=;
        b=drm7NLvQ2F3JJl62iCQscBlIJ5zJXHFmCha6Na5ZmgNuujszmJ03pBWgUChG4DZ7Tg
         DTbOVzI7K6vO7yJjxD96oLFAgU8Wek4eMGa58vfb1j0FABD3zfgM9vJXoQ342KtgXOKQ
         l2YqWDZsJxrTPKt93OEr0dip9dWKU7sFb2orA5P9piwARYKDtSX2SqkhLykGfM/rV8yW
         3wexc34/7xJCOK1GnBjMdlWZORLxyvP+eB3wTFFU9Cspu75bn10Z7bYvmhPc4qJgCmRf
         cy78w47pwy9qWqifljqm5AVnTSUTEDSjFR68opZZCF85pVpGyLla5vt5MCIsXYpsB4XD
         Cwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095862; x=1698700662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKtCKkTSYC7hZ3rLuwOCTXUI3GkJ5ijCz5zkNO2WTMs=;
        b=QPYKhnHFuyXZhjhSWU2DSO7KHgbXMOnpwaXr9MjJSTjaFol/n9ZdVgg0/h5+j0TqHx
         xFumQ3eNXiO/1wO94++vfHRsjWwKH5ONbVNpekcynGwx9U3r9rDoNA8ODpV6upZismH0
         mr8pU08mqae8wF2o0NGvcKJ1DG+mkGUgIpTHYeMU3PqnAgTmbHEKh7M+ICp0JN7IDrM2
         A/ZgPkeDvYcFM0J5NJ6igAPdytYBGRJukXXhoAZe4vegxSu40MQNBcShNOt65AXtvhd8
         OLW+dT7CBAnrwt7+E8ZJqLSuzi+Udi/ejCq4mx4r55f7fISijOz2uXH4N2RexiZbLUI0
         QCYg==
X-Gm-Message-State: AOJu0YzLd9EAxXyVbr4+hb+pOGbyZJ7mD95LX1enJ5XMEN6H8vb53XvJ
        r22RcT2RyRadWbvlaGvBd41X9zeILw==
X-Google-Smtp-Source: AGHT+IEROiHoBNjn4pD8Mtc2ZO+iLijow8kSxKIl3Yv9O4ECWRnThxVkscF5wZgkW8/wPHIU9yxEXg==
X-Received: by 2002:a0d:d804:0:b0:59b:d872:5ca8 with SMTP id a4-20020a0dd804000000b0059bd8725ca8mr12323788ywe.22.1698095862341;
        Mon, 23 Oct 2023 14:17:42 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id o139-20020a0dcc91000000b00583e52232f1sm3485430ywd.112.2023.10.23.14.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:17:42 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 5/9] x86/percpu/64: Use relative percpu offsets
Date:   Mon, 23 Oct 2023 17:17:26 -0400
Message-ID: <20231023211730.40566-6-brgerst@gmail.com>
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
 arch/x86/tools/relocs.c        | 10 +++-------
 arch/x86/xen/xen-head.S        |  6 ------
 init/Kconfig                   |  2 +-
 6 files changed, 7 insertions(+), 53 deletions(-)

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
index c87dc8de2084..8d8eb4d9ff9d 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -102,12 +102,6 @@ jiffies = jiffies_64;
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
 
@@ -223,21 +217,7 @@ SECTIONS
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
@@ -367,9 +347,7 @@ SECTIONS
 		EXIT_DATA
 	}
 
-#if !defined(CONFIG_X86_64) || !defined(CONFIG_SMP)
 	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
-#endif
 
 	. = ALIGN(PAGE_SIZE);
 
@@ -507,7 +485,7 @@ SECTIONS
  * Per-cpu symbols which need to be offset from __per_cpu_load
  * for the boot processor.
  */
-#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
+#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x)
 INIT_PER_CPU(gdt_page);
 INIT_PER_CPU(irq_stack_backing_store);
 
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

