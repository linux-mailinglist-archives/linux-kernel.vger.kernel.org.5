Return-Path: <linux-kernel+bounces-63521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BF78530B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948401F24D51
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBD84F610;
	Tue, 13 Feb 2024 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pAmQAn5V"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EECE3FE27
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828126; cv=none; b=AFi/oi8edBZR9Y2erK0j88hDAqe/iCn2v5Qn6RewElSRFxlbr6k7Nk4NOVoLA0rSq/d+WEvKuvI0zPFxeuqFZKaerxBRpjHGll8m3sGQm3XRgvn4ghVcYBe5ShB/QfL94XSTr21oTOeXhOyR+gf9kX/3gYFkJaa3QSkrh+/0r9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828126; c=relaxed/simple;
	bh=YMvF0ORfuPi3XAD0k0pDL8v73CKkqlg6+lbGX9kyTzw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gQsPoesAssF7ZNt+Osmcglm8SHJVA0rJGbb13WZz+22CJN7sj6R5vfbgpqa987FVY07ktvMSXOTm+XhbiJ7col1QIwmp+iK0Kikh5kAxDlBA7yPchKfvo/glAQglpcxgkbLX+M1LxrRW0Zv/RKWvJnU5YDtmjK0PAurMbKcb2AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pAmQAn5V; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40e435a606aso27287515e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707828123; x=1708432923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IntT6izjYhpSpfiju4QdrJP91shTnHbBbhRa2UK23MU=;
        b=pAmQAn5VoM14YoCzbhlVh1q1bcvPTbZt3lgoqXK8nnMG9szFe/AjcdWa7L/gpZQUj9
         vxWXO6lTkT+A+KVnExB9AgrQwM0iqsRzeTSfcfLzq4Tk0IJx7wYnEzHDlYV6XCcZakvR
         xZbwceDjSF42Z6CrQMwRu4oELsMTzUTIkFxsG+hoW0iYTIDlpLXQcJrfp9B+3yz+2ojl
         oiLq7WeS8qPXy3l+/Dr6BA9tmGphjLdJa5IBeQiyWNl6s+5Nd4hgB+v+6ma1B4fKR82Y
         BbtqQp3NOF9XhBm6/ezEPruQbFCQbi0f9EyJKFyIwDAPTqaU34F9LxbYLWy7sE8BLchf
         ykNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828123; x=1708432923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IntT6izjYhpSpfiju4QdrJP91shTnHbBbhRa2UK23MU=;
        b=E7cBhVUMuvKJ/+rMTnouPgycs5H/qtQaCGmWiWIvorQcZHikB3T9YLGHB6Bk8awPFG
         YNVZe84c9AwfSTnsAk8ealbejuoQ5JL9QFvS3Ols9iVdkWv8Id+EWo/jysB1IbGKHbdP
         xfDAI+tkt42aCUQW93eoSjmKVtduOCf4VoPpWmdP66iLvOr9ynvrICWekIN03aRaHKoX
         FDrhQw/bslaIi4biquazou2wZRNQzJcZGWNfa85KaSQhxYHeqqcpMACJbvfj02pT3SNu
         dRoML7vRO0BYOi0d5hdVqTaiIxoUsP+SAqXE6RI7GHLQkW8nvWvccx9mvdqF1ZDUOPcy
         ENUA==
X-Gm-Message-State: AOJu0Yxnp10rOmsjq7/f25NOTHXaQc9TDR0WYLhTmPNPuHclCWjjxqXJ
	QvdSmgSQVpAz7bebSUbc6mccw4BnVNtM+QpJDbjqSaoCQ94I3/vkE5yWrw9hrkdKQrwcbeOYXKZ
	5M/7sw1gd06dechoFLGmS7mh3fn1i6h9JgCO/iyi8zFLUhOZ/C9cmWs+dKGUPueDD1vmktsysnb
	sPHYqQ9lptOC+dXwu59Jebh63E8EAaxQ==
X-Google-Smtp-Source: AGHT+IGO4JBfeGvnTwxmmn7JIMK9YckhUWh4H18sWfV5jiwrBdxJzdJIlnTTVHSvArGFHZiJixRxORXb
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:518a:b0:411:a802:700d with SMTP id
 fa10-20020a05600c518a00b00411a802700dmr70870wmb.2.1707828123104; Tue, 13 Feb
 2024 04:42:03 -0800 (PST)
Date: Tue, 13 Feb 2024 13:41:45 +0100
In-Reply-To: <20240213124143.1484862-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6089; i=ardb@kernel.org;
 h=from:subject; bh=BsdoewkQfg4v5NoT6opMjWi0Vrg2mA8a392y9Jxs7FU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfV0cueOKzuMyz5W71o5TYp9kdW5Wa0xu5br/SkOjb++u
 +9vHS9XRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIkguMDDu+bZC0ZT+Yvm5u
 Ise2zLtZBuoPpiZea4wzc1/5zzhy1XOG/2G3FvnknSyvm3xqo5Hi+U/3rS7NzF25v9om6r3Ekno 9Nx4A
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213124143.1484862-14-ardb+git@google.com>
Subject: [PATCH v4 01/11] x86/startup_64: Simplify global variable accesses in
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
 arch/x86/kernel/head64.c     | 56 +++++++-------------
 arch/x86/kernel/head_64.S    |  4 +-
 3 files changed, 22 insertions(+), 40 deletions(-)

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
index dc0956067944..9d7f12829f2d 100644
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
@@ -569,12 +561,7 @@ void __init __noreturn x86_64_start_reservations(char *real_mode_data)
  */
 static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
 
-static struct desc_ptr bringup_idt_descr = {
-	.size		= (NUM_EXCEPTION_VECTORS * sizeof(gate_desc)) - 1,
-	.address	= 0, /* Set at runtime */
-};
-
-static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
+static void __head set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
 {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	struct idt_data data;
@@ -586,45 +573,42 @@ static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
 #endif
 }
 
-/* This runs while still in the direct mapping */
-static void __head startup_64_load_idt(unsigned long physbase)
+/* This may run while still in the direct mapping */
+static void __head startup_64_load_idt(void *handler)
 {
-	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
-	gate_desc *idt = fixup_pointer(bringup_idt_table, physbase);
-
-
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-		void *handler;
+	struct desc_ptr desc = {
+		.address	= (unsigned long)&RIP_REL_REF(bringup_idt_table),
+		.size		= sizeof(bringup_idt_table) - 1,
+	};
+	gate_desc *idt = (gate_desc *)desc.address;
 
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
 		/* VMM Communication Exception */
-		handler = fixup_pointer(vc_no_ghcb, physbase);
 		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
-	}
 
-	desc->address = (unsigned long)idt;
-	native_load_idt(desc);
+	native_load_idt(&desc);
 }
 
 /* This is used when running on kernel addresses */
 void early_setup_idt(void)
 {
-	/* VMM Communication Exception */
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
 		setup_ghcb();
-		set_bringup_idt_handler(bringup_idt_table, X86_TRAP_VC, vc_boot_ghcb);
-	}
 
-	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
-	native_load_idt(&bringup_idt_descr);
+	startup_64_load_idt(vc_boot_ghcb);
 }
 
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
-void __head startup_64_setup_env(unsigned long physbase)
+void __head startup_64_setup_gdt_idt(void)
 {
+	struct desc_ptr startup_gdt_descr = {
+		.address	= (unsigned long)&RIP_REL_REF(startup_gdt),
+		.size		= sizeof(startup_gdt) - 1,
+	};
+
 	/* Load GDT */
-	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
 	native_load_gdt(&startup_gdt_descr);
 
 	/* New GDT is live - reload data segment registers */
@@ -632,5 +616,5 @@ void __head startup_64_setup_env(unsigned long physbase)
 		     "movl %%eax, %%ss\n"
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
 
-	startup_64_load_idt(physbase);
+	startup_64_load_idt(&RIP_REL_REF(vc_no_ghcb));
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
2.43.0.687.g38aa6559b0-goog


