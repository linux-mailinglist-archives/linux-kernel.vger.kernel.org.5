Return-Path: <linux-kernel+bounces-83489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0456C869A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF94A1F2329D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06914690E;
	Tue, 27 Feb 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfHB6/Sh"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD457146013
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047173; cv=none; b=EwZu+BpPcug+1gKeH3BcFNnR+eEsEoVpRUPmp0n7NUsEMWscdXFnQRVhUJzlNHilzRXMHCUV33c+qbH63eqbA+vhA8PzToLsJTEYrnJxXqpEPNCs3GvbAaZfUx+YI1ou/XDxokj4p9nXquQlUhGtAWWsAiAvOvedtWZr5Ptea6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047173; c=relaxed/simple;
	bh=cVqN7V5PAyNKuwnktsymYIoCY8DOsy5NnF9aYCziV6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qfxm/3p/3U4d5GFpq/3a8iY7dawNK2I/tVxyUTYeAzHjbvNEmLwrPwuv9nqnth9Si3N7ouUCkrl++tut1682+MNWSIc5j4d9iJs5egiE4N13dn6+do5AwGAd7e7HVjOjQxOr65JfEVwtDecE0oTwn81smDoXMQOCSPP4hbUJBD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VfHB6/Sh; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33d7e755f52so2147894f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709047170; x=1709651970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h4D8aoZuYpE3xE2uEwQyHY1rJvF5ooGRo/8T5tb1R2Q=;
        b=VfHB6/ShuugA2Wjzm/07GsI1VBIolgjiPf3jtDWhVf8Xlr9QTxKuJt6+zJvt68Ke/x
         ETt2uR52qJ/tOPdCQmVv1PcHnyD5zLK20ByuaAoD4a9oSW/+u+rksbk8XB12SoJ6RBNp
         8Itza8++ghuhYERnJuQXN0QXWlb9UfHVsW7OdHP1ouGsGXNKiMM4vMTJ5Gzj+vvapFS/
         uUV8nOBJhYlZpO3pjMmUhtHDrvP7y/vhXHtPwCf4gJXKVFmxGJHbtDOvtbUi2Y76jza/
         XCYTdXoG9d9ab9JPJc5zzvSfZ+zmayC8PoaEh2/jGfsvG9M5wRJXZA3Tw1EMSKiA5SOI
         MyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047170; x=1709651970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4D8aoZuYpE3xE2uEwQyHY1rJvF5ooGRo/8T5tb1R2Q=;
        b=csyFdt1RcWli02cbpMNQySIfQBI/tYudNN7AsS3i5q78VGHE3O2fqXOyIq5fcRVt13
         NtB6nUj8YYkKEe5N95/6s4FPUV0aJgTNDEGhDiCkU7ykNQqbbGb6FB6wVorq6j6oLcTc
         JiQt2Bw1if7Jbrz4NnBTJGEK/F2yMD2K1CHEYrF9IfSf5nTfaO2cQY+sBB6wtm/hQQ/Q
         9Tmu+S6jw/tGYjKEmvqVCX8jVtAjTP/ieUysfG/qH8yR+05YAZj1uY3z3Ud7c72tpIPV
         ROhE7u3G8DvWm/OxgLGyQCF+vGN6sXkh0yj0Xyn4Fa3fZ0tR8VrJMNP8H30eHLhvKDub
         3QGg==
X-Gm-Message-State: AOJu0Yxa3XMTrixHf5Az480bJY5oRtgm1QI2ll5RLBBMF8Due095UADE
	zhYKJwJ4n3uFPVWqy/AsVQUhiAnPYNLbN5Dvn6wBeBNJ2m3XwiFQKDQ8lroLh3TfjoBX/LHII86
	K1ktxAb+TOSOtcCEDht/K6jF5+tBDuQ3dZiZgK6/03drNKWb8f/vyuiBgvQVh7+lITkOY3Wigqg
	5dzn2Pp4SNKryRyEZsBUOldqKzuWUiBQ==
X-Google-Smtp-Source: AGHT+IEfxryu1e+iMshxpHdNlEVOtuCJFBcspECEXPloQOtlwsx/DVmbZ+uxzXVblnLSCd5meO2dM5h6
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:224:b0:33d:a18e:4eef with SMTP id
 l4-20020a056000022400b0033da18e4eefmr19570wrz.2.1709047169980; Tue, 27 Feb
 2024 07:19:29 -0800 (PST)
Date: Tue, 27 Feb 2024 16:19:11 +0100
In-Reply-To: <20240227151907.387873-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227151907.387873-14-ardb+git@google.com>
Subject: [PATCH v7 3/9] x86/startup_64: Simplify calculation of initial page
 table address
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Determining the address of the initial page table to program into CR3
involves:
- taking the physical address
- adding the SME encryption mask

On the primary entry path, the code is mapped using a 1:1 virtual to
physical translation, so the physical address can be taken directly
using a RIP-relative LEA instruction.

On the secondary entry path, the address can be obtained by taking the
offset from the virtual kernel base (__START_kernel_map) and adding the
physical kernel base.

This is implemented in a slightly confusing way, so clean this up.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 25 ++++++--------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 1b054585bfd1..c451a72bc92b 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -111,13 +111,11 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	__startup_64
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(early_top_pgt - __START_KERNEL_map), %rax
+	leaq	early_top_pgt(%rip), %rcx
+	addq	%rcx, %rax
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	mov	%rax, %rdi
-	mov	%rax, %r14
-
-	addq	phys_base(%rip), %rdi
 
 	/*
 	 * For SEV guests: Verify that the C-bit is correct. A malicious
@@ -126,12 +124,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * the next RET instruction.
 	 */
 	call	sev_verify_cbit
-
-	/*
-	 * Restore CR3 value without the phys_base which will be added
-	 * below, before writing %cr3.
-	 */
-	 mov	%r14, %rax
 #endif
 
 	jmp 1f
@@ -171,18 +163,18 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	/* Clear %R15 which holds the boot_params pointer on the boot CPU */
 	xorq	%r15, %r15
 
+	/* Derive the runtime physical address of init_top_pgt[] */
+	movq	phys_base(%rip), %rax
+	addq	$(init_top_pgt - __START_KERNEL_map), %rax
+
 	/*
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
 	 * added to the initial pgdir entry that will be programmed into CR3.
 	 */
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	movq	sme_me_mask, %rax
-#else
-	xorq	%rax, %rax
+	addq	sme_me_mask(%rip), %rax
 #endif
 
-	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(init_top_pgt - __START_KERNEL_map), %rax
 1:
 
 	/*
@@ -207,9 +199,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	btsl	$X86_CR4_PSE_BIT, %ecx
 	movq	%rcx, %cr4
 
-	/* Setup early boot stage 4-/5-level pagetables. */
-	addq	phys_base(%rip), %rax
-
 	/*
 	 * Switch to new page-table
 	 *
-- 
2.44.0.rc1.240.g4c46232300-goog


