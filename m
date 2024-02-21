Return-Path: <linux-kernel+bounces-74631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E8285D718
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5801A28322F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D949A481A5;
	Wed, 21 Feb 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1f2YhjBm"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E6145970
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515339; cv=none; b=shH3O+rnizTsgznP205mbpgp+98yB+ujL/zMn2sNgbMkEu+LieAbwQmmOSntmCnAc5GTU1/QQb/+j7GLmMgsz6QKCg98hHpgrgbwbapt7dIyRPDJ5hzTIz/G5OzYlTfl/4T9jy9dNvgCBRP4LirunC1J/sT3ddUuicYugSHCnqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515339; c=relaxed/simple;
	bh=py9Y+djzPQO6EmF7F9NJ1i5hAa8K3oSBQk/6uhAH298=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gPUPLE0oPDHH2XP3RhtuocBLzffz7qRkUcnl4PHg80RtbSOIdYSxw6ezvpOYKlA4I8K44mRzODamBXC0aBtjXhB5avoB5Snnz4Jps5ihfti3ykdm2Hpk5WpLQta9LcVJlwdja3ZrQSPY2SjD5hAliUwIPlJ7Vqo3E6Zm8mVhyyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1f2YhjBm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608749ea095so17629897b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515337; x=1709120137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qW/A0wjJqrnttxBCkESXpcpyFK56vfk0Gs3tCOMJv4Y=;
        b=1f2YhjBm6qxcDIoKgvJYITX4UJSnUl2ga3VSCfiEWq2akVTbwHmciSfRplrv7kJsJc
         isidw9jqQUoKrnCgNXNxFLtce0n2e0Rwy4ATkD7eAzaQySqK9S0G9gXD5t0qes7fd7rj
         L9k1W/7q/qRkly/cmuG5xY8vPU2WwjcoBNV4xRoMwwP1ZXQAXUXV1S1lS0WK4ME9MROW
         vylr6uVZWkIF4p/m4BSZd0ULedY/orp9K3cBt7ujVaexWpagTSE0hhQSaBZpcdCWE4BX
         X0JUd0i+lE0mSWMqglwK6gnGy90MYplm1x9C2LJD3u14DFQvMndPZEHRAcHxn9pGf5q3
         ZvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515337; x=1709120137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qW/A0wjJqrnttxBCkESXpcpyFK56vfk0Gs3tCOMJv4Y=;
        b=QaXXHRcRWcg7UihwSAFoVXGW0cMl35TUrh0c1pSw7iZ546WQG8Jg5Zh6C9gJH48dWR
         PGlq4M7/M+84AmvZ2ntBJ4ndTLfUxucgH3mrp+OeeKcxpkUPrzqg2Ic98IxKL6uiNDmI
         pOhM7+0qQFGWONGYeVv+fE7evAMyKrscijAJJA/JVBM291U/9ibTWpzI1pBXHKgxmXfQ
         8gE/GuCuY2m+Arop9dMl2GjNreYgDp9SJ2h5vteqDO7BvO9BfV1gkzhfxOzAuBF1puI/
         y71F9Ut+MNrqlrTGE7/ncU1EBeCH+HhjNrCGX6l8mH6BDvV4R8OqlJXIhTiO2igAuj+U
         YCEA==
X-Gm-Message-State: AOJu0YxbcrINbaDowDBSeN/H+qpvjVWWslIFdJWM8rCpFdBqr1vxUEHO
	TrnK+EyJ/hbrMzBae5A//tWCmWip5/jgtRdBLlXYV6np8uAfq7mf2UO0FNFxi/uTxpXeS6NdidK
	aqibGQ54DgB8gWhlvyCNi8GmAwlU0J9iz4EANC2KzpxSYmR4zXepQIiBAJ5udMuNmNftA7B8yoV
	a43LVPnzmuEdp4Uikc4tzy1okPs9tgNQ==
X-Google-Smtp-Source: AGHT+IGiMJD52uZON/RU30Dr1ARXomCp+ofU7VN13ZzAwGe5Q0FoIxKq+Mo7hRtI+nMB9sdyP7jtj8yX
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:e904:0:b0:607:8f65:5433 with SMTP id
 s4-20020a0de904000000b006078f655433mr4327050ywe.4.1708515336661; Wed, 21 Feb
 2024 03:35:36 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:08 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6347; i=ardb@kernel.org;
 h=from:subject; bh=znXuPAQkSUWGkxlryxVinIdceSOSj8FHbeDMB1myZ+Q=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/dflrwLZVwhePf5QQEj9QfXG/7v/HGuIPGUQaL4k9
 aSVsZJ7RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIPj9GhvVz7Ln//KirE/HO
 rxD0imif0jvh897z5Y2batlfK2p+dGVk2LPefEc0wx0r3Q1pNjeEfbl4ux32JMmnPYsL7BZdLKv JBwA=
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-19-ardb+git@google.com>
Subject: [PATCH v5 01/16] x86/startup_64: Simplify global variable accesses in
 GDT/IDT programming
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

There are two code paths in the startup code to program an IDT: one that
runs from the 1:1 mapping and one that runs from the virtual kernel
mapping. Currently, these are strictly separate because fixup_pointer()
is used on the 1:1 path, which will produce the wrong value when used
while executing from the virtual kernel mapping.

Switch to RIP_REL_REF() so that the two code paths can be merged. Also,
move the GDT and IDT descriptors to the stack so that they can be
referenced directly, rather than via RIP_REL_REF().

Rename startup_64_setup_env() to startup_64_setup_gdt_idt() while at it,
to make the call from assembler self-documenting.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/setup.h |  2 +-
 arch/x86/kernel/head64.c     | 75 ++++++++------------
 arch/x86/kernel/head_64.S    |  4 +-
 3 files changed, 32 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 5c83729c8e71..e61e68d71cba 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -48,7 +48,7 @@ extern unsigned long saved_video_mode;
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
 extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
-extern void startup_64_setup_env(unsigned long physbase);
+extern void startup_64_setup_gdt_idt(void);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index dc0956067944..1d6865eafe6a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -22,6 +22,7 @@
 #include <linux/cc_platform.h>
 #include <linux/pgtable.h>
 
+#include <asm/asm.h>
 #include <asm/processor.h>
 #include <asm/proto.h>
 #include <asm/smp.h>
@@ -76,15 +77,6 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
 	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
 };
 
-/*
- * Address needs to be set at runtime because it references the startup_gdt
- * while the kernel still uses a direct mapping.
- */
-static struct desc_ptr startup_gdt_descr __initdata = {
-	.size = sizeof(startup_gdt)-1,
-	.address = 0,
-};
-
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
 	return ptr - (void *)_text + (void *)physaddr;
@@ -569,62 +561,52 @@ void __init __noreturn x86_64_start_reservations(char *real_mode_data)
  */
 static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
 
-static struct desc_ptr bringup_idt_descr = {
-	.size		= (NUM_EXCEPTION_VECTORS * sizeof(gate_desc)) - 1,
-	.address	= 0, /* Set at runtime */
-};
-
-static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
+/* This may run while still in the direct mapping */
+static void __head startup_64_load_idt(void *vc_handler)
 {
-#ifdef CONFIG_AMD_MEM_ENCRYPT
+	struct desc_ptr desc = {
+		.address = (unsigned long)&RIP_REL_REF(bringup_idt_table),
+		.size    = sizeof(bringup_idt_table) - 1,
+	};
 	struct idt_data data;
-	gate_desc desc;
-
-	init_idt_data(&data, n, handler);
-	idt_init_desc(&desc, &data);
-	native_write_idt_entry(idt, n, &desc);
-#endif
-}
+	gate_desc idt_desc;
 
-/* This runs while still in the direct mapping */
-static void __head startup_64_load_idt(unsigned long physbase)
-{
-	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
-	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
-
-
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-		void *handler;
-
-		/* VMM Communication Exception */
-		handler = fixup_pointer(vc_no_ghcb, physbase);
-		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
+	/* @vc_handler is set only for a VMM Communication Exception */
+	if (vc_handler) {
+		init_idt_data(&data, X86_TRAP_VC, vc_handler);
+		idt_init_desc(&idt_desc, &data);
+		native_write_idt_entry((gate_desc *)desc.address, X86_TRAP_VC, &idt_desc);
 	}
 
-	desc->address = (unsigned long)idt;
-	native_load_idt(desc);
+	native_load_idt(&desc);
 }
 
 /* This is used when running on kernel addresses */
 void early_setup_idt(void)
 {
-	/* VMM Communication Exception */
+	void *handler = NULL;
+
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
 		setup_ghcb();
-		set_bringup_idt_handler(bringup_idt_table, X86_TRAP_VC, vc_boot_ghcb);
+		handler = vc_boot_ghcb;
 	}
 
-	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
-	native_load_idt(&bringup_idt_descr);
+	startup_64_load_idt(handler);
 }
 
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
-void __head startup_64_setup_env(unsigned long physbase)
+void __head startup_64_setup_gdt_idt(void)
 {
+	void *handler = NULL;
+
+	struct desc_ptr startup_gdt_descr = {
+		.address = (unsigned long)&RIP_REL_REF(startup_gdt),
+		.size    = sizeof(startup_gdt) - 1,
+	};
+
 	/* Load GDT */
-	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
 	native_load_gdt(&startup_gdt_descr);
 
 	/* New GDT is live - reload data segment registers */
@@ -632,5 +614,8 @@ void __head startup_64_setup_env(unsigned long physbase)
 		     "movl %%eax, %%ss\n"
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
 
-	startup_64_load_idt(physbase);
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		handler = &RIP_REL_REF(vc_no_ghcb);
+
+	startup_64_load_idt(handler);
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d4918d03efb4..3cac98c61066 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -68,8 +68,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Set up the stack for verify_cpu() */
 	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
 
-	leaq	_text(%rip), %rdi
-
 	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
 	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
@@ -77,7 +75,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	shrq	$32,  %rdx
 	wrmsr
 
-	call	startup_64_setup_env
+	call	startup_64_setup_gdt_idt
 
 	/* Now switch to __KERNEL_CS so IRET works reliably */
 	pushq	$__KERNEL_CS
-- 
2.44.0.rc0.258.g7320e95886-goog


