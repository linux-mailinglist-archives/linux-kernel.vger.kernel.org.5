Return-Path: <linux-kernel+bounces-83490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CBB869A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F7A283A16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B03146E9A;
	Tue, 27 Feb 2024 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hju/C2NM"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15230145356
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047175; cv=none; b=SYc4EnkK7rMfAU1mDB/fYQJKAH3h0xpxUQcRpEdBeai2wGS8VjtyqVeaRswayOu9hUnP/aRiqSAigtgISx0GYi1y4jrFLkvo1K3BdmHuzT2U48pg8fGUTKHX52Xfm911SML4YAScJEbcQbd2KBDW56ye8fHbQZZa3oQMnbxMVJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047175; c=relaxed/simple;
	bh=/S719xaU9xP8uHOi68ntsc/Hv6QyoUaD6Ro7ASZe5Gs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nHw14P5cJVhTv1kNuHDYQDKSBtvmxOorvV80FAaVwDZZZwGPQQECRj27TZi4BZIJBlMC6VLtyJS1/HHN9yNzNWaVjdbzHEJ5vEBLh11NGpLTk0KqhJMOpVTYGs36EG7CaJ0G3h/bzCoDJIjXMCONO0CD+zvRsv8j6QS7k/aR2SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hju/C2NM; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-412b0d34a42so1109735e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709047172; x=1709651972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEFw4Uv2SMq6PunMM0SQo+ZA+grVXwI4qkkkBFDNiX4=;
        b=hju/C2NMxsKzTO45beITfx7SppNhRSwKOdEpnwju6ECRVoAJBwLQt7lsqVWNVgKWAk
         0DnoEnGP7EoXbEqVbbieuZr53R5Emfsb0mHucG+i6aMxstlYpMLwmwjaH+YVVYhF/off
         +XjbY/5K5g9EiHWqfGn10FvFoLUyl1maOpm6LwXlt/zagR89LapAyAX6cus/ugwNiGJe
         FR8t3w4JJQ/1jzCMXHSGghkjCQVFY5Ym62JaKCv5rrEWKt5Ecrs/83OiKdMM3dA12uJX
         p3wOEJujm+WCBDCh+hOySZQhMg838SorSZXyWXd2hypsOWgyf2LGJYxnaAqnFJBS/PJo
         dgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047172; x=1709651972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEFw4Uv2SMq6PunMM0SQo+ZA+grVXwI4qkkkBFDNiX4=;
        b=LDyvLlG0XzzEX4M6AcQSPZKolObL6j+1AYWNZcH7gzk9t5YkL2fipMW2JML66xhBXM
         zow1fDlmOhsHKH/CncKtyzRJkQBnLd12vwedTMFdOOD/n5/agj23lnG5M5AlVp2raS+N
         X5VhAOiSLmSQpouHuK0fX4Lzos5au9cnLxO317VZFQaA+nnU5X+qGQKVnsLEtntIKp/x
         FNZEXbP5N0dmGAFdQ+fnsrcvIGFLTjjuDiCqnUAqpP5sZmCfs8LytkQFviF7fi5Acr0y
         G8HHbquCgSfGW2Gb+QWJXyHRXdh2YNq27FtTx/pcH+qlAPHkBTD2v1DJC9UVLjbeLmIR
         Xc8g==
X-Gm-Message-State: AOJu0YxexueXlJU6fm6rzEBS2AQNxCl1uVwNpsCwl2BwfYu6PBiM0hsy
	zACEkDuHTbI8QOLGx9IN4bgVOEupYez2XaqOGMS26eWmENSps4ynkjXvkSigGGkUaSh3wzqCIqn
	oOJyBoPaUzNn3ig97FjhcUtynu33qZEzzZ/bVJShpt+oIVEjTaFtx/JsEUMy3JAOmOlvMFEkwH2
	FvFAZR2IUk151a+/tLdWIur+S34Bf61g==
X-Google-Smtp-Source: AGHT+IFysygNpHf+18pTGAS71ClaoQSQ+JaoCbZFS7HD9wqWVL+KBtvGFMnkk+HiwBS1Xli6tcKC6NIE
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:54e7:b0:412:c62:2dd9 with SMTP id
 jb7-20020a05600c54e700b004120c622dd9mr51036wmb.2.1709047172165; Tue, 27 Feb
 2024 07:19:32 -0800 (PST)
Date: Tue, 27 Feb 2024 16:19:12 +0100
In-Reply-To: <20240227151907.387873-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227151907.387873-15-ardb+git@google.com>
Subject: [PATCH v7 4/9] x86/startup_64: Simplify virtual switch on primary boot
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
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
placement inside the executable, move it to the .text section.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 42 ++++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index c451a72bc92b..87929f615048 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -39,7 +39,6 @@ L4_START_KERNEL = l4_index(__START_KERNEL_map)
 
 L3_START_KERNEL = pud_index(__START_KERNEL_map)
 
-	.text
 	__HEAD
 	.code64
 SYM_CODE_START_NOALIGN(startup_64)
@@ -126,9 +125,21 @@ SYM_CODE_START_NOALIGN(startup_64)
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
+	.text
 SYM_CODE_START(secondary_startup_64)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR
@@ -174,8 +185,15 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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
 
 	/*
 	 * Create a mask of CR4 bits to preserve. Omit PGE in order to clean
@@ -199,30 +217,12 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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
 	 * Set CR4.PGE to re-enable global translations.
 	 */
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
2.44.0.rc1.240.g4c46232300-goog


