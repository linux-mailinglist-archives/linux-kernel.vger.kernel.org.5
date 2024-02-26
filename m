Return-Path: <linux-kernel+bounces-81623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9789A86787C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E02028D408
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7D026AE6;
	Mon, 26 Feb 2024 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZh6eQ2G"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8912B157
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957807; cv=none; b=amAk4BCVbyFank+Em2to2MSIYbV8/5GhpUipt2Xzwm3UGEKzon9as7208KSnzpueZM6VBWWDdWLwi50agQy0KusIANz/TPJDaa8GUSiqDnRrlrXOGUWzQ+PCfzzHzUIcerHFGlnLklVQSPBsRs5c5bhXQ6QpEda418IiJrIEMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957807; c=relaxed/simple;
	bh=IKzSvD/LgGiOgyH8nDLzJUWhN/QyWc5LsEQ67nR9hkM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bl1Fs7k0R+nA4Ve1rIICx0sHZOKBsy4C4Cx0GqC26y0FL7qyu88KEhDyVy/8bNgTdcf4wTD2hskQPwCq54fMLWuZgtCWJEvJ4/U6HD6t67nbjgjbMKYgRCXG8DyOKrK12/FH1r1aZANBxwfDfl25pWKr0KrFsiJU5wD0CqFYeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZh6eQ2G; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so4214550276.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708957804; x=1709562604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMaXkJDSba/rz2ejEwTszeJPuP18TapiV6QGh3kcGw8=;
        b=FZh6eQ2GuYuEiRfPS5iThakFFTPnnFvfuV9ztUKWjWCDNZWEoNiwoPNbH0bonYHmpw
         NLz2js5RqV+HBTiMVlZtD/pXnl8rTc9z4O7xXYx9uKPp/fdnv2uNBRTM2ybzQMX+KPmh
         TyICpKQL3HTGhKKeJAOFg243/QrHgyQ7QtVbBNaGB6L3ac75fImGWBj63MCxoUI2PqI8
         MB0UbYAwh+/FgY0DTJMD1lt+gs4YtjCoTLYDaWg+ugfzm5idbn9ce1xH0O1SXh3aEgFt
         vb6xU3JXO4qcfXj8V5gILncxbzZjBy70krfQtplvC3ohwOtC8gQqmsGQra5c0U2hcenx
         eHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708957804; x=1709562604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMaXkJDSba/rz2ejEwTszeJPuP18TapiV6QGh3kcGw8=;
        b=s1vYli1gJLGusbRLQyLoXL2o74gdSlkT5byurkpBCZt4vjm6MVEFvTGBcUf3T3oBjp
         2QueToW3mwXRVRpfYj5mySn2Gr4HJgsw5bVA4Dsf9OaY576xOoZfUW1A5bHl88xjHgQP
         F4FLwhHp8ClvGckX+NsOD0zRVo0AmfR5I7uhD/CYlZ+hUCBbMYmXaqfFq37fp5g3h2QD
         zxwdZZ+eHg7fkKVTqbDi0aI5+MyYf+cTe8vrth6gtdDflZ6sHlRRiqMdbjK6Pqqg8FWg
         SwIC8byqFLmAnTB669HYZrGlSmULpGBEEBvd2uj+ezRqt1pR9RXSpZQUJ7wKvqC5sSoX
         pXEw==
X-Gm-Message-State: AOJu0YwC1YIa+F7J4cKzbREUzXbRGjB7nT+sC1YYMWyMOivOYmbUj1s1
	+H/O3iRw1nUBeYSuH96HrtKb1ZDQSfDYYqae4CaU1Volg5x4Vrqd5GPk/BsjC6akVQDPTZK4nE1
	lmncHJXN390LOnS25u7uHBqPkQS8NobUgNVBWCHY8ZFZ4Qv2rx0UfCtz5YVAGgLn0yDjAsZkFFx
	gq99i6wjdzKs71aR07lpB2omD/D2U/YA==
X-Google-Smtp-Source: AGHT+IEUFPLAlQCZPyvo7j59jIi34TcGtha4YVxqIHMEu/vZ8b6ngZI2tbNpjPT7i/7H0tEzm+U0lWFR
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1003:b0:dc7:3189:4e75 with SMTP id
 w3-20020a056902100300b00dc731894e75mr252518ybt.3.1708957804161; Mon, 26 Feb
 2024 06:30:04 -0800 (PST)
Date: Mon, 26 Feb 2024 15:29:55 +0100
In-Reply-To: <20240226142952.64769-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226142952.64769-12-ardb+git@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240226142952.64769-14-ardb+git@google.com>
Subject: [PATCH v6 02/10] x86/startup_64: Defer assignment of 5-level paging
 global variables
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Assigning the 5-level paging related global variables from the earliest
C code using explicit references that use the 1:1 translation of memory
is unnecessary, as the startup code itself does not rely on them to
create the initial page tables, and this is all it should be doing. So
defer these assignments to the primary C entry code that executes via
the ordinary kernel virtual mapping.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/pgtable_64_types.h |  2 +-
 arch/x86/kernel/head64.c                | 44 +++++++-------------
 2 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 38b54b992f32..9053dfe9fa03 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -21,9 +21,9 @@ typedef unsigned long	pgprotval_t;
 typedef struct { pteval_t pte; } pte_t;
 typedef struct { pmdval_t pmd; } pmd_t;
 
-#ifdef CONFIG_X86_5LEVEL
 extern unsigned int __pgtable_l5_enabled;
 
+#ifdef CONFIG_X86_5LEVEL
 #ifdef USE_EARLY_PGTABLE_L5
 /*
  * cpu_feature_enabled() is not available in early boot code.
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 72351c3121a6..deaaea3280d9 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -23,6 +23,7 @@
 #include <linux/pgtable.h>
 
 #include <asm/asm.h>
+#include <asm/page_64.h>
 #include <asm/processor.h>
 #include <asm/proto.h>
 #include <asm/smp.h>
@@ -77,24 +78,11 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
 	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
 };
 
-#ifdef CONFIG_X86_5LEVEL
-static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
-{
-	return ptr - (void *)_text + (void *)physaddr;
-}
-
-static unsigned long __head *fixup_long(void *ptr, unsigned long physaddr)
+static inline bool check_la57_support(void)
 {
-	return fixup_pointer(ptr, physaddr);
-}
-
-static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
-{
-	return fixup_pointer(ptr, physaddr);
-}
+	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
+		return false;
 
-static bool __head check_la57_support(unsigned long physaddr)
-{
 	/*
 	 * 5-level paging is detected and enabled at kernel decompression
 	 * stage. Only check if it has been enabled there.
@@ -102,21 +90,8 @@ static bool __head check_la57_support(unsigned long physaddr)
 	if (!(native_read_cr4() & X86_CR4_LA57))
 		return false;
 
-	*fixup_int(&__pgtable_l5_enabled, physaddr) = 1;
-	*fixup_int(&pgdir_shift, physaddr) = 48;
-	*fixup_int(&ptrs_per_p4d, physaddr) = 512;
-	*fixup_long(&page_offset_base, physaddr) = __PAGE_OFFSET_BASE_L5;
-	*fixup_long(&vmalloc_base, physaddr) = __VMALLOC_BASE_L5;
-	*fixup_long(&vmemmap_base, physaddr) = __VMEMMAP_BASE_L5;
-
 	return true;
 }
-#else
-static bool __head check_la57_support(unsigned long physaddr)
-{
-	return false;
-}
-#endif
 
 static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
 {
@@ -180,7 +155,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	bool la57;
 	int i;
 
-	la57 = check_la57_support(physaddr);
+	la57 = check_la57_support();
 
 	/* Is the address too large? */
 	if (physaddr >> MAX_PHYSMEM_BITS)
@@ -465,6 +440,15 @@ asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode
 				(__START_KERNEL & PGDIR_MASK)));
 	BUILD_BUG_ON(__fix_to_virt(__end_of_fixed_addresses) <= MODULES_END);
 
+	if (check_la57_support()) {
+		__pgtable_l5_enabled	= 1;
+		pgdir_shift		= 48;
+		ptrs_per_p4d		= 512;
+		page_offset_base	= __PAGE_OFFSET_BASE_L5;
+		vmalloc_base		= __VMALLOC_BASE_L5;
+		vmemmap_base		= __VMEMMAP_BASE_L5;
+	}
+
 	cr4_init_shadow();
 
 	/* Kill off the identity-map trampoline */
-- 
2.44.0.rc0.258.g7320e95886-goog


