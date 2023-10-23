Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B3F7D4191
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjJWVRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjJWVRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:17:45 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF39D7C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:42 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a92782615dso24179747b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698095861; x=1698700661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFuYnGAQUTzuREgXlsOmxY7LqCUSpomHGIDzZdL7lBI=;
        b=P4PQPayOy5mvjI6ghbg+pj3G6y5hprocXmeV4LxsEpZDhdm7/6ub6M+eXO2BUd/Xpt
         3Ln7EmPArt3UWfsBRk+Da04J2Km4KvZ7qQCRvE4wB2/9MiPEjg5OTEoVu26tlIL6/rce
         lyUgaS1YmfEGXL3OvJs3r3uExM4bFN76m0Ytrzg6t4Ng4D+PzLU+r2UenxAjqcKlyI4h
         yEiTsKh2tkcj6jySBYatz9fi7j9njv43Oqz9wT/DNKjLvH5sIt4ifRKqi/5cUxbl4dL1
         a5Nmmu9CB04wsMeIv4LaGYbgzvXN7rc3C4yl+klFwZ3YuccLdZW5nVjkE8SsngSkc/eg
         hd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095861; x=1698700661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFuYnGAQUTzuREgXlsOmxY7LqCUSpomHGIDzZdL7lBI=;
        b=irrA7AqwILursA3F2Y6eC8wMMeaYXU2lgsqfnrjQgOPE8M2oB53GHG7YQIYP5fPyCh
         WZYVrL6y5myDmoZCawjlyWgPYx2uH/k72NLq3DUanBfGKFtSzzENmRFaWEAGzghyYblv
         STHHv7pta5Au437s+fFAP6siNiJ8KUeIIkj7UiK0VkAzCRjH5y+PvBL/h1yjUo/nDQfC
         NnYk+sbL5PsplqMeBt2tTssViRUbwcSR99YAFqbK8WPUd5lKdJrZiKk2iEJRBoFN60Mw
         xeDEnUM3qFjqX2FNeZ365Q0PpKvpddRmLizE7eKvjAJSyj78Zis6RbS3FVrS/h3NYpZ1
         8G7A==
X-Gm-Message-State: AOJu0YwHkzAiKracwMZjNWLBM7opnJH0wIo2H2uuriW43SuBq4DWo4tw
        Vhq/d46qUXg3zgAAUp5zfdUfUFRAkw==
X-Google-Smtp-Source: AGHT+IEHzuLJ6NZkQ9Qu6yAzHSVWNKbJk2BtbbK9scEXx4qs3SWEpy0au3c8PbpTcfqKlj0QtcmFOQ==
X-Received: by 2002:a05:690c:fd1:b0:5a7:ccf3:7163 with SMTP id dg17-20020a05690c0fd100b005a7ccf37163mr12181250ywb.15.1698095861316;
        Mon, 23 Oct 2023 14:17:41 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id o139-20020a0dcc91000000b00583e52232f1sm3485430ywd.112.2023.10.23.14.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:17:40 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 4/9] x86/percpu/64: Remove fixed_percpu_data
Date:   Mon, 23 Oct 2023 17:17:25 -0400
Message-ID: <20231023211730.40566-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023211730.40566-1-brgerst@gmail.com>
References: <20231023211730.40566-1-brgerst@gmail.com>
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

Now that the stack protector canary value is a normal percpu variable,
fixed_percpu_data is unused and can be removed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/processor.h | 13 +++++--------
 arch/x86/kernel/cpu/common.c     |  4 ----
 arch/x86/kernel/head_64.S        | 12 ++++++------
 arch/x86/kernel/vmlinux.lds.S    |  6 ------
 arch/x86/tools/relocs.c          |  1 -
 arch/x86/xen/xen-head.S          | 12 ++++++++----
 6 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 04371f60e3c6..48c31b8e3e72 100644
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
index f9c8bd27b642..a44fd3ad460e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2051,10 +2051,6 @@ DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 
 #ifdef CONFIG_X86_64
-DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
-		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
-EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
-
 static void wrmsrl_cstar(unsigned long val)
 {
 	/*
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3dcabbc49149..f2453eb38417 100644
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
@@ -345,15 +350,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to fixed_percpu_data. If the
-	 * stack protector canary is enabled, it is located at %gs:40.
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
index 54a5596adaa6..c87dc8de2084 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -509,14 +509,8 @@ SECTIONS
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
index a0ea285878db..9ce0d9d268bb 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -53,14 +53,18 @@ SYM_CODE_START(startup_xen)
 
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to fixed_percpu_data.  If the
-	 * stack protector canary is enabled, it is located at %gs:40.
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

