Return-Path: <linux-kernel+bounces-74640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983B885D72A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C0F1C22FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6589D4E1CA;
	Wed, 21 Feb 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uOOGWx0T"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237146535
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515362; cv=none; b=oUcw+fsO9PM7YYDrt6jiRW5GinLD6IUjxFvCupVfrdcpF4uKjl3mnYGFbUsja597D7sgBHmRy9TJKYW6M9PtJkS+rIFuDrayr3gNhPXWWiajYPnOUlKt56VPuaeYQxH7tZWt6jSfdXXTrEpHiHkO6YBoi9UuJPIbaqZgaoCKQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515362; c=relaxed/simple;
	bh=G1DG06D2aqp4pwBOMLdzbyqBLE1i1IBpz8O+pTeBX18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WD+gifH4v85ak8moibKkc9zQhwGCWrSHfQqesf/ADVG0QyhzV7q+75sk0O1oAr63UaiTdJjCmrAzbOtpywHe4yVIE+0vLLWvV5u9NK82LrRq9LIhiA5og3C9XlHUqVAS25ZXfO3bEzF1osuNuuyApZhN5YZB2xLVaIElZ7CPnxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uOOGWx0T; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-41256ffe281so19047205e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515359; x=1709120159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTqJ99P6i6SBAIAH+IAXdMn7P2pIU1w2UuJtp90ikvg=;
        b=uOOGWx0Tsum9AyZZbdXGqFrO0o/LYVm3Px09l2rC2lcQKiC3SJL3rMqfC5dYMQPRNI
         3t6mdzeWMijdlayAr1Q7DcXz1EGT7VJpA8tTIjzorGDUYtaXFFbyceFcBoTc7XIM+O0E
         dmbRkSKBkIQPmv1l2ZQo8r10yQUiqmGeJV0Dp1Fd0U2j6SbtQcU08SZcyU1g19vEZ/2U
         zuqG+wNQyrMXIPH4hfCc51ch4vXr6ZyEF95nLKt24tywjn95gSXIcNN6yESOEXjactrf
         Kppdpku6a/57HrEP4D5JcX9gGViIlfK4fbaE5OnVQUFhHzPRE9nIGVe1M3KXJK7hUlB3
         3pCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515359; x=1709120159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTqJ99P6i6SBAIAH+IAXdMn7P2pIU1w2UuJtp90ikvg=;
        b=oxPFcD6HsJFK8Bbgnjfylg6jYkOMT91G7KkiT4fDG5J8F4ZF5TGHFDOZhGQ1KyHbX4
         OyhOsoypU+UbA/sF1utgkWb6DU9RDw6gR63qv3QDCeZCiTcrcz+ruv1ZFujLcQkBUEA0
         1NrP+8aqMjUrYeWylF7OzOyzi4WbavbSlMPE1IZb1U4kKtU+4RCZE4wAD77gqq2jtTkb
         CxtXIRrQKcoILWZ+jEjuxp/eYy2DDck3xx3qWApfbYgTADNmbe9SfDDJKIE18nWOr7ue
         rvMUSbyn4rzx/2PK3K75EjLc5Jp4bwv15HQP9Sd+t6Jh7dO06H6hOS5AP7Obzle31d2a
         h88Q==
X-Gm-Message-State: AOJu0YybzeT9C6x00M1wkEiqwpUprMHEITfaWsU862aFkXJ5rcyN2Qo6
	osXx0OcyED1DRzvN8IKIl7E8RUSn2kil6SnwzxMJsxilcI8GROmHae9LuuNMPjoi2u9JTB9pgbm
	h1Yy12w1Ds0sOdJf1ka6AdSzKSkRJ62GubRw/aNnsDShspB+N1JRgSuirLviHMzR0QiqXi1blxt
	9xoeEeuuBQNCKRMFE7vomk/2OLDbpU0A==
X-Google-Smtp-Source: AGHT+IFITrStDY8qkTtuSdIIdzMUYcaY2nSms8BthZQq6Td2kpNAr50Wg4EXwQUrpgtDrocBPdUr8Ddn
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1f17:b0:412:72d3:cfdb with SMTP id
 bd23-20020a05600c1f1700b0041272d3cfdbmr10352wmb.2.1708515358491; Wed, 21 Feb
 2024 03:35:58 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:17 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4361; i=ardb@kernel.org;
 h=from:subject; bh=i7YTwnF8QsOAYHIVebyuOmPcW0rncRMhxzgGUyIgY38=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/U/vplsk/HzNuOys4hb23w4nvt/7HBDut6vewlGn6
 NxOleWtHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiIYsYGS7F3dGZ7vRpnUPq
 w7kBIQdLeRyv/F3AEvfgbefPCUflymwZGfYpGMxXyxfjX+4aMyFzvdIWPnWn14yXL3sF7Tljten 9XxYA
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-28-ardb+git@google.com>
Subject: [PATCH v5 10/16] x86/startup_64: Simplify virtual switch on primary boot
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

The secondary startup code is used on the primary boot path as well, but
in this case, the initial part runs from a 1:1 mapping, until an
explicit cross-jump is made to the kernel virtual mapping of the same
code.

On the secondary boot path, this jump is pointless as the code already
executes from the mapping targeted by the jump. So combine this
cross-jump with the jump from startup_64() into the common boot path.
This simplifies the execution flow, and clearly separates code that runs
from a 1:1 mapping from code that runs from the kernel virtual mapping.

Note that this requires a page table switch, so hoist the CR3 assignment
into startup_64() as well. And since absolute symbol references will no
longer be permitted in .head.text once we enable the associated build
time checks, a RIP-relative memory operand is used in the JMP
instruction, referring to an absolute constant in the .init.rodata
section.

Given that the secondary startup code does not require a special
placement inside the executable, move it to the .noinstr.text section.
This requires the use of a subsection so that the payload is placed
after the page aligned Xen hypercall page, as otherwise, objtool will
complain about the resulting JMP instruction emitted by the assembler
being unreachable.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c  |  2 +-
 arch/x86/kernel/head_64.S | 43 ++++++++++----------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index deaaea3280d9..0b827cbf6ee4 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -553,7 +553,7 @@ static void __head startup_64_load_idt(void *vc_handler)
 }
 
 /* This is used when running on kernel addresses */
-void early_setup_idt(void)
+void noinstr early_setup_idt(void)
 {
 	void *handler = NULL;
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index b92031d7e006..03268bf0214a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -39,7 +39,6 @@ L4_START_KERNEL = l4_index(__START_KERNEL_map)
 
 L3_START_KERNEL = pud_index(__START_KERNEL_map)
 
-	.text
 	__HEAD
 	.code64
 SYM_CODE_START_NOALIGN(startup_64)
@@ -126,9 +125,22 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	sev_verify_cbit
 #endif
 
-	jmp 1f
+	/*
+	 * Switch to early_top_pgt which still has the identity mappings
+	 * present.
+	 */
+	movq	%rax, %cr3
+
+	/* Branch to the common startup code at its kernel virtual address */
+	ANNOTATE_RETPOLINE_SAFE
+	jmp	*0f(%rip)
 SYM_CODE_END(startup_64)
 
+	__INITRODATA
+0:	.quad	common_startup_64
+
+	.section .noinstr.text, "ax"
+	.subsection 1
 SYM_CODE_START(secondary_startup_64)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR
@@ -174,8 +186,15 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	addq	sme_me_mask(%rip), %rax
 #endif
+	/*
+	 * Switch to the init_top_pgt here, away from the trampoline_pgd and
+	 * unmap the identity mapped ranges.
+	 */
+	movq	%rax, %cr3
 
-1:
+SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
+	UNWIND_HINT_END_OF_STACK
+	ANNOTATE_NOENDBR
 
 	/* Create a mask of CR4 bits to preserve */
 	movl	$(X86_CR4_PAE | X86_CR4_LA57), %edx
@@ -196,16 +215,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	btsl	$X86_CR4_PSE_BIT, %ecx
 	movq	%rcx, %cr4
 
-	/*
-	 * Switch to new page-table
-	 *
-	 * For the boot CPU this switches to early_top_pgt which still has the
-	 * identity mappings present. The secondary CPUs will switch to the
-	 * init_top_pgt here, away from the trampoline_pgd and unmap the
-	 * identity mapped ranges.
-	 */
-	movq	%rax, %cr3
-
 	/*
 	 * Do a global TLB flush after the CR3 switch to make sure the TLB
 	 * entries from the identity mapping are flushed.
@@ -213,14 +222,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	btsl	$X86_CR4_PGE_BIT, %ecx
 	movq	%rcx, %cr4
 
-	/* Ensure I am executing from virtual addresses */
-	movq	$1f, %rax
-	ANNOTATE_RETPOLINE_SAFE
-	jmp	*%rax
-1:
-	UNWIND_HINT_END_OF_STACK
-	ANNOTATE_NOENDBR // above
-
 #ifdef CONFIG_SMP
 	/*
 	 * For parallel boot, the APIC ID is read from the APIC, and then
-- 
2.44.0.rc0.258.g7320e95886-goog


