Return-Path: <linux-kernel+bounces-81625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B554286787F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8BCD1C2A6E2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC801E492;
	Mon, 26 Feb 2024 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJFT1AwJ"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8330F53E28
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957812; cv=none; b=WbS8kGoMNNFwjq9dDxFcEDdEIm45u9jW9QdHVHXQBQKTpe0qIDplooPykf+fgi3tfQ3tQe7e/IWPNjd3F6V1RdQL1epseP4xsV+EH+oY9zEmSxVn9VFoicw5ZooMtangwCV4yM8GIPRj2zZ8DPDVhPaeGJMdgXF282EFj+Y4vnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957812; c=relaxed/simple;
	bh=+SAmI2opGAKocGzeZEPFdFE24u4ggFbULQvVpI+lmmo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FEcjRvUvaCUa6zvACdkIMjUrnAsyrlgderKZ6eE31urFyCzvHDi9XWa3LAB2uKc4Yv8iiMETAKnBHX++6F4yedzNXX1qJQfnB5E7pnCR4BZwzpGbKVOGNQAhRK9G1yNpGlHRrr9sLr0nqGku5xH/UcxbICMzVUuLIsklZE8qynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJFT1AwJ; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33d6eb5e5a9so2319021f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708957809; x=1709562609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUEqNAX+crIm6ixnlTe40pRvCdb8ZI8NNnngiA9aRDQ=;
        b=NJFT1AwJg/QdP/N9y9wIu3Y+VcOPAgca8O+z7aYJPaY/Widy/qcYsaFvx3sNc7ozB9
         iyrkE47WtIPAzkP/ng22SeUz7U04syim6dTIeMc1NGXnW7zblRPGY4YJycmjNnwRR6ty
         KpXydcgDbm2lpfSMsglYSXzYnGXZn0skReqtQqaOqcWgicZvpRwFG+h8dVcdd1u13KYp
         EOpZ55cLzAaO0dliXZEBx0NOm53lf3qonIOA4uQOip66nk5Oa5W2TEYWlptbScHKb2YY
         a+u/neMpPxTr1l5BtBlG8fE+J1htEUEDgXSJ+zXEWNefqBftidoOqX1fv2kR6V3jUY8j
         Lmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708957809; x=1709562609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUEqNAX+crIm6ixnlTe40pRvCdb8ZI8NNnngiA9aRDQ=;
        b=G+H3VtGznaOkZnuGY7VfmD4IaXUY9Huy1iTIN06NqZ0T7fqG1JJHANp6hHXg2UMHlY
         nlW6xUHRHt3Ova7n4maUJW6WR/lNMzFYUkoR+2QTvqb5GlRRjWRomhhR1y/GVljbWab7
         6sMP93x/uklIUfdZ2YTNO3EoNHTWbOm5keoHL6FGTeMKsz4MLdgEAfaF+CIWm9Mzdqvj
         nwxX03SEPw7zL3myVbtFWCPJDdToaOOUJQfvtpY+nQUIYor86LEi5x6Qphv6VJ7qClZj
         2LapMtGlvaxmWlvsi6SJ9qvgensY4bz4fg63tlYeED77zgA61DJRzjkoKLUdSVbNXvRu
         hWag==
X-Gm-Message-State: AOJu0YzKbOY7nXiHRqK9NEukYsxRYzLhS3AlzJC5RtPAmR2OCWiKxifW
	EUGvlcEX+yK9etIDca8/+GG2MFnjX5d6nnybJ5JYlIXbmIbSAlQO+OQkdzyE+IX8KGpTty20hMl
	dm5Pf2G21PqfzIYF3Kk+3LV1IPQQmTh2lP4W81EYdyaCHQvDMcoJyTYfl7k4GNSchCXeGFuTKWC
	cK8cTIAJTnexNnED1Q8Q6B6LXn9IvOaA==
X-Google-Smtp-Source: AGHT+IFz2/Gq+kY1OpAOcxRY1/GI23JdH1NFoQhDudrZpcMvdeI1kbkli5B7xZwmoaLYUTI/B9A3SbgI
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:5d85:0:b0:33d:ae58:8e1e with SMTP id
 ci5-20020a5d5d85000000b0033dae588e1emr14897wrb.12.1708957808755; Mon, 26 Feb
 2024 06:30:08 -0800 (PST)
Date: Mon, 26 Feb 2024 15:29:57 +0100
In-Reply-To: <20240226142952.64769-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226142952.64769-12-ardb+git@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240226142952.64769-16-ardb+git@google.com>
Subject: [PATCH v6 04/10] x86/startup_64: Simplify virtual switch on primary boot
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
2.44.0.rc0.258.g7320e95886-goog


