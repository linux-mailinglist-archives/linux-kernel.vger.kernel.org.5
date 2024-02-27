Return-Path: <linux-kernel+bounces-83488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B33DD869A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF941C23492
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041CD146009;
	Tue, 27 Feb 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rReYyReM"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8987145356
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047170; cv=none; b=jSGOftHebmwxT8ci03GUvVUkXqPKB593GNMlpfPJpoK/unejq6cQik2Kubb2ghIlp+zpRSlJ3kM0wXJyc9XD9LmH9bAODvSkgq/ilssKb0FFLvkSCYjOGRZNW5n9/clwyRQX/TrvDJ4+nUblXyoi2bIIdkssG/JX3ABBQmHeeng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047170; c=relaxed/simple;
	bh=X6/OzZGiJqFpxqpC0njbNWYz6ODH6zW8Z1ABMSbDTS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WUMB0nV7stk+Zi11rW4hAiRijIYxK+Ypwu+o7m+mVjKkS3JHgtbxXghZqOKBrn3XBNZb2YBs0RpWfdW3/0kJnLmWjGHUpmq4PElhfwtRCRrKRe8n2HfJfZamSvLAOgnxZ+KMq2diWHBIdxig7Z4NTejWy+gWkaKVDIGVLw8asw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rReYyReM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso6691509276.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709047168; x=1709651968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5GeRQDtmrQKN4psfZmd6RkmjsdFQnHB8sOV6dww9xU=;
        b=rReYyReMccWVAE3OSLOF4pa/aTGkPQB/+kIIUW8bT2A32mF44Lr9B0Nh+ZMfOTYp0z
         OashlJ/oTPlgiRqm3CwTurtEh/DoFiSzfDUF8IPhboblwkqzhZUeroaN4xtOYQ9O9KtK
         bRAtnprD3e9fRLE3nmFCG+EmPY9cg5YVzXwpDHPxukI1kAvE35mMOOqeQ32aBr8dB3DI
         aH51/PPmOynLegTSxagLpEj8yDc33B0xMlWXcbI+n2IcRZO3d/XCNhem1lPsiw3H2DAY
         uOxVbwrDBExy9VHQCRSjEClAChX6lawqkPprZytm77XcuL3m35K2OvJ0SRkjOKxNf5sA
         l85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047168; x=1709651968;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5GeRQDtmrQKN4psfZmd6RkmjsdFQnHB8sOV6dww9xU=;
        b=qcxQgphbD09koAcBK3YUD8NolTNkJqXdVEbNtUbK6rX13pjN//YJJnlja0xKT0WzxN
         0d1XBZ8lHoEJyGg7ArTqKGhhAyX7u1p2gPT5ArgS5pK4T1c6Yt4DIGxTzjsuSCDv1T0X
         RKQbqccHI/hf+td3O2Clpkfk3uYDRAU7CW9OcAo9sSC0NyjDyckNmQsvaIQP9FlqtxtL
         glvkvoy2lt0MgoZLXfoIxEZc8WxNm0smST6fpLj5BOtP6lk19T7WtshWtuA7G32KBBCO
         I342wbEZq8ADnEOBmds+TevycyMZYszgGBOpE+QG5nk5BY8lmNrUOHW1adDK2HxmlqqR
         ySHw==
X-Gm-Message-State: AOJu0YzmJCBUhTi9Xo7Q3+FfluiSfeLON3P92alWy1Z6QCv5QazNlNim
	p4V4LHqSQftP7jwuqGkQGekbVbhgKMM0Q7u0ugYNikDNTF3OFkYBVxaDT2GDmpIZNrDwGYaKsq/
	L2qZnahMRjQ4XVed1gqfpffcMrs0+nJt/HSc5rM8d7Ac0m48u7+gZ4QlyT0kW9VQKdQXypHBg3L
	LiRmBpzDswnK2o3ArSEvYGWU9GB/XAlg==
X-Google-Smtp-Source: AGHT+IEA1JwrjX9NbLPuGgU7IQqerLyenqMpBskU343Gwd36pNaNnPUHHb/tx0w9vjnjOqTrxlsQUZ7C
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1005:b0:dc2:5273:53f9 with SMTP id
 w5-20020a056902100500b00dc2527353f9mr134018ybt.1.1709047167684; Tue, 27 Feb
 2024 07:19:27 -0800 (PST)
Date: Tue, 27 Feb 2024 16:19:10 +0100
In-Reply-To: <20240227151907.387873-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227151907.387873-13-ardb+git@google.com>
Subject: [PATCH v7 2/9] x86/startup_64: Defer assignment of 5-level paging
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
2.44.0.rc1.240.g4c46232300-goog


