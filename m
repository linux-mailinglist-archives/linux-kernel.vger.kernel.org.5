Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1497D8663
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345435AbjJZQBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbjJZQBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:01:35 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8FA1BC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:32 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5af6c445e9eso1975137b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698336091; x=1698940891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4rQnE8nrNp1mQ6GgRY7B4WNhxftPYkRdGzH6F4NzGA=;
        b=KqBKLkXXq1QJ5aZOn0EV1Qp6lZwrkhkA2rIPwpHi/EZco66HzMc3GTEUGbpyXplC+3
         /sa4Xr8LjO1nRwr7LLJYqUg88EgmPUsbmLM0VR2M53AhZZogrMiLwvKjZIJq72XXcPtu
         sMQcIDadcMBQkUJBUePAgNaOCoihjjG5dT1p5yGc/dgFo1OoW/7ePecaaCPgA2QQe3Bw
         3g/Z8U/quOUeAyGOF/xiXLBtwOKGBhPVfYBV8JyGhZFEmKmGxZQH3V1ZM1H27FSuycr9
         V7Q2BfQkmyWJY3RrWtPUZuvjZ89Pr4IWKDKr91/2HE6R5cRx2n0lW5TeIqTDu+qbTuu4
         475w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698336091; x=1698940891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4rQnE8nrNp1mQ6GgRY7B4WNhxftPYkRdGzH6F4NzGA=;
        b=uIC28h8PNF2O8SbbOyF5WPlBG4W/S/uFglzybAk1u3iWDLSwChnWWyAdgZjT+BrvMK
         DVPYPMVmTGR1TB5sJe67EcAo7izS/id2losNnlgpovKHwB8TWv4nfdYXx0A7kNdxxNyP
         UqBxigLCGWSv3KjBfaohTLFGi6z8Qx10D52mF1C25C1gIhUntvEynYFpBDsXM597X97k
         YLKBOlr7IpFcjGbHhFcQVm950OjgWI48j9WXZgG1IvDNaJsUD+Q8FFTLh9nvjscnx6zP
         ms1Ih5CZJRSXQHFg+vdymLHn8UWUD+bnl/wfWxcmCfmHdqdM9HntYiSHfF6A0LHAi0LZ
         r88A==
X-Gm-Message-State: AOJu0YyhyOrjQP9uFX4gPhxZD7IDxaI/Af0nkB3k0O3h0gRiLnBrftkM
        LEtnb5lJFRI30sIdozJALUsyeIHlOg==
X-Google-Smtp-Source: AGHT+IGlYnpBLsQwiMkgBkwAeMfHUNz/MKpT+sTdi6C4pwyOLroQ9f3hgfDvD/rrAX5/e24bnw0UMQ==
X-Received: by 2002:a05:690c:f83:b0:570:89bf:6f10 with SMTP id df3-20020a05690c0f8300b0057089bf6f10mr21132399ywb.25.1698336091379;
        Thu, 26 Oct 2023 09:01:31 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id a71-20020a0dd84a000000b005a20ab8a184sm6130129ywe.31.2023.10.26.09.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:01:30 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 06/11] x86/percpu/64: Remove fixed_percpu_data
Date:   Thu, 26 Oct 2023 12:00:55 -0400
Message-ID: <20231026160100.195099-7-brgerst@gmail.com>
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

Now that the stack protector canary value is a normal percpu variable,
fixed_percpu_data is unused and can be removed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/processor.h | 13 +++++--------
 arch/x86/kernel/cpu/common.c     |  4 ----
 arch/x86/kernel/head_64.S        | 11 ++++++-----
 arch/x86/kernel/vmlinux.lds.S    |  6 ------
 arch/x86/platform/pvh/head.S     |  7 ++++++-
 arch/x86/tools/relocs.c          |  1 -
 arch/x86/xen/xen-head.S          | 11 ++++++++---
 7 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2b6531d90273..d5a4044dba8f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -393,16 +393,13 @@ struct irq_stack {
 } __aligned(IRQ_STACK_SIZE);
 
 #ifdef CONFIG_X86_64
-struct fixed_percpu_data {
-	char		gs_base[40];
-};
-
-DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;
-DECLARE_INIT_PER_CPU(fixed_percpu_data);
-
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
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index fb8f0371ffc3..32ae76cf4508 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2052,10 +2052,6 @@ EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
 
 #ifdef CONFIG_X86_64
-DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
-		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
-EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
-
 static void wrmsrl_cstar(unsigned long val)
 {
 	/*
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 0d94d2a091fe..f2453eb38417 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -72,9 +72,14 @@ SYM_CODE_START_NOALIGN(startup_64)
 
 	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
-	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+#ifdef CONFIG_SMP
+	leaq	__per_cpu_load(%rip), %rdx
 	movl	%edx, %eax
 	shrq	$32,  %rdx
+#else
+	xorl	%eax, %eax
+	xorl	%edx, %edx
+#endif
 	wrmsr
 
 	call	startup_64_setup_env
@@ -345,14 +350,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to fixed_percpu_data.
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
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1239be7cc8d8..e6126cd21615 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -510,14 +510,8 @@ SECTIONS
  */
 #define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
 INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(fixed_percpu_data);
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
index be8d973c0528..d215b16bf89f 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -96,9 +96,14 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 1:
 	/* Set base address in stack canary descriptor. */
 	mov $MSR_GS_BASE,%ecx
-	lea INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+#ifdef CONFIG_SMP
+	lea __per_cpu_load(%rip), %rdx
 	mov %edx, %eax
 	shr $32, %rdx
+#else
+	xor %eax, %eax
+	xor %edx, %edx
+#endif
 	wrmsr
 
 	call xen_prepare_pvh
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index d30949e25ebd..3ccd9d4fcf9c 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -811,7 +811,6 @@ static void percpu_init(void)
  *	__per_cpu_load
  *
  * The "gold" linker incorrectly associates:
- *	init_per_cpu__fixed_percpu_data
  *	init_per_cpu__gdt_page
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 30f27e757354..9ce0d9d268bb 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -53,13 +53,18 @@ SYM_CODE_START(startup_xen)
 
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to fixed_percpu_data.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movq	$INIT_PER_CPU_VAR(fixed_percpu_data),%rax
-	cdq
+#ifdef CONFIG_SMP
+	leaq	__per_cpu_load(%rip), %rdx
+	movl	%edx, %eax
+	shrq	$32, %rdx
+#else
+	xorl	%eax, %eax
+	xorl	%edx, %edx
+#endif
 	wrmsr
 
 	mov	%rsi, %rdi
-- 
2.41.0

