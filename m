Return-Path: <linux-kernel+bounces-38511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E48B83C0E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457AD289422
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F79050A71;
	Thu, 25 Jan 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CceKwkEg"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFA44F893
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182377; cv=none; b=Lj/pMZNLmIfqYiw5jl5X446yCfbKG72qxtAow2EW76CBhz2/5cUbo+yQ9J0j/hqXuecqJlEt2MmPPMqZ9k3VjsIiwMFpJLSRhP18Z/Jcr5jMsWWuMjtmAnYHAQyX/P7NVRiK42kJ4Sa4ONo2WgPLXnsPuG7dA36yMi+jQl7pjlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182377; c=relaxed/simple;
	bh=9H4JrfvvUnACeesgQKj2mOvmlC0TpA0V7SRr0Kxm8nk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Axuc6rgRYAP4R/BeFR+8xJmglNpfPKQlmrWZnm74IJfOfDzdykmpv1SKlq3q97eJgp27C0q8+5VPCis5tU4/Js193Y9sZ5QMyNKQ7iwhyvsm5y7nSzqGsqJdrG03PupABZo5dvFLxFvOr1cDgCtTIX3C9JxBLsOf/8CuxnZz/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CceKwkEg; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-337d6024098so3870818f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182373; x=1706787173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K393o/iOXcO+KXDFEg2lpPBpqdPHLp4izeuXizwM1H4=;
        b=CceKwkEgY9fn7y0kKsYr8aBtywEMDbQKtOijG0xLcp3P8WXeImSYjPrcey7i293v6L
         hahVHOT/ANyOTE3PbaICYSOCWX6DRJz0auSW6bcQx5IF8beVzB+211A7PGXKw3IngN8y
         JQlJutT1SXBI1ChE2B7xzvnetcAFszCrh2coTIdps3q9c/g+WO2FTlTr0cbWtQWXS4Bf
         gT9MIK3PFs3zF6SfeEA3IS9EvdfUcbsfnCebaoRE6hx1kcT/vD4oKUO9DhyRXWsAE/QN
         vKodNcEzS6+QlFZteIRJ4Q0W/f7QE8BEAHSr3Cd31R7j+OIbauao951Rxy2zmuywvT8Y
         tjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182373; x=1706787173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K393o/iOXcO+KXDFEg2lpPBpqdPHLp4izeuXizwM1H4=;
        b=RRArlG0w+EA7hK9pDtlOqc69j5EDmiyEco+D8Js+cfb+JuDf4LDXV+9it375vtaynV
         yGUNG4TeF+8/tUYR93VqJZiSKZkGe4HtilrpdpXErdwI3Kk0cSOQ7xNLTqqqyf/udu+w
         6JaZgJ1tKWrxzAEBsBdA7Z89JWG9LRdBJLjDNVz3mPHuOPlnVOiKR9zh4t1S0dnfjHxN
         uBi75QdbEJ5vhtoj2tAiWKWtOu/SCsfxigucvhThtauhDRKHuuRDilSOPO707nBzJiM5
         3X3bpgQl7ZnCS7F5d6r/MTjyIJVcGNEXAv/kAHF5vaLtsn3G9+rLhCYwL0Ze+iq4wGE/
         ZEBA==
X-Gm-Message-State: AOJu0Yy8MlsowkxJ4FKniAnylpy6/OOZdpajW00z9SVxayrxpPhWhAu/
	HxKejJZyCbLJ4DZG1g3REJb+ZEhB/oYo1NoDTzknMhYk+XBz1Vvxso39+SnH4A4hi/ftHrnGXSq
	xfDcVfzFyg+kmNWsVB/nSSp/dUc8yXKn7f8/Rk31bsle5VcmFD/Zh4q57qomvXAJbDAG8mYJPD7
	yPFGCLp3PaN2+fKmEz2sEpEmm6yGU+4w==
X-Google-Smtp-Source: AGHT+IFy3edfKoxwWsASuxlW/t9kLk8NmSC2Ul56dsG9JvulUQhc9AcRjbt7LFAvbXA6cz4fONssBwa/
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3f94:b0:40e:9cd9:46f5 with SMTP id
 fs20-20020a05600c3f9400b0040e9cd946f5mr12071wmb.8.1706182373512; Thu, 25 Jan
 2024 03:32:53 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:26 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4380; i=ardb@kernel.org;
 h=from:subject; bh=A4U+rfXqigBIzPefwYEqRJTK3Dd5A0XyBzuBQozAnUo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT62ORs9oPc/Qadt0tbndi1tzVIbl1cf+vJo6HTaHnq
 uVPxLl3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIk8DWP4w1F/53/Dulq+Y3y8
 Mcf/KH6/sfNN4ZzVx312dp/ta/U0usvwh2/z7Sg997ZlyTavl/NuZ97mbifpJewt9a5j5ZSK+8L xXAA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-26-ardb+git@google.com>
Subject: [PATCH v2 07/17] x86/head64: Simplify GDT/IDT initialization code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

There used to be two separate code paths for programming the IDT early:
one that was called via the 1:1 mapping, and one via the kernel virtual
mapping, where the former used explicit pointer fixups to obtain 1:1
mapped addresses.

That distinction is now gone so the GDT/IDT init code can be unified and
simplified accordingly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 59 +++++++-------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a4a380494703..993d888a3172 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -59,21 +59,12 @@ EXPORT_SYMBOL(vmemmap_base);
 /*
  * GDT used on the boot CPU before switching to virtual addresses.
  */
-static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
+static struct desc_struct startup_gdt[GDT_ENTRIES] __initconst = {
 	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
 	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(DESC_CODE64, 0, 0xfffff),
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
 #define __va_symbol(sym) ({						\
 	unsigned long __v;						\
 	asm("movq $" __stringify(sym) ", %0":"=r"(__v));		\
@@ -363,7 +354,7 @@ void __init do_early_exception(struct pt_regs *regs, int trapnr)
 	early_fixup_exception(regs, trapnr);
 }
 
-/* Don't add a printk in there. printk relies on the PDA which is not initialized 
+/* Don't add a printk in there. printk relies on the PDA which is not initialized
    yet. */
 void __init clear_bss(void)
 {
@@ -517,47 +508,32 @@ void __init __noreturn x86_64_start_reservations(char *real_mode_data)
  */
 static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
 
-static struct desc_ptr bringup_idt_descr = {
-	.size		= (NUM_EXCEPTION_VECTORS * sizeof(gate_desc)) - 1,
-	.address	= 0, /* Set at runtime */
-};
-
-static void set_bringup_idt_handler(gate_desc *idt, int n, void *handler)
-{
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	struct idt_data data;
-	gate_desc desc;
-
-	init_idt_data(&data, n, handler);
-	idt_init_desc(&desc, &data);
-	native_write_idt_entry(idt, n, &desc);
-#endif
-}
-
-/* This runs while still in the direct mapping */
-static void __head startup_64_load_idt(void)
+static void early_load_idt(void (*handler)(void))
 {
 	gate_desc *idt = bringup_idt_table;
+	struct desc_ptr bringup_idt_descr;
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		struct idt_data data;
+		gate_desc desc;
 
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
 		/* VMM Communication Exception */
-		set_bringup_idt_handler(idt, X86_TRAP_VC, vc_no_ghcb);
+		init_idt_data(&data, X86_TRAP_VC, handler);
+		idt_init_desc(&desc, &data);
+		native_write_idt_entry(idt, X86_TRAP_VC, &desc);
+	}
 
 	bringup_idt_descr.address = (unsigned long)idt;
+	bringup_idt_descr.size = sizeof(bringup_idt_table);
 	native_load_idt(&bringup_idt_descr);
 }
 
-/* This is used when running on kernel addresses */
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
+	early_load_idt(vc_boot_ghcb);
 }
 
 /*
@@ -565,8 +541,11 @@ void early_setup_idt(void)
  */
 void __head startup_64_setup_env(void)
 {
+	struct desc_ptr startup_gdt_descr;
+
 	/* Load GDT */
 	startup_gdt_descr.address = (unsigned long)startup_gdt;
+	startup_gdt_descr.size = sizeof(startup_gdt) - 1;
 	native_load_gdt(&startup_gdt_descr);
 
 	/* New GDT is live - reload data segment registers */
@@ -574,5 +553,5 @@ void __head startup_64_setup_env(void)
 		     "movl %%eax, %%ss\n"
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
 
-	startup_64_load_idt();
+	early_load_idt(vc_no_ghcb);
 }
-- 
2.43.0.429.g432eaa2c6b-goog


