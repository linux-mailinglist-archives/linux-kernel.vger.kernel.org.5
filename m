Return-Path: <linux-kernel+bounces-81622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B1186787B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE7C1C28D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548FC12AACF;
	Mon, 26 Feb 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbLixok0"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E844A12AAC4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957804; cv=none; b=qEJzLkwJTEjNok8i25o63GygvXE99hPNUt/3dJOEZf4iHm8XrwZ13hZF4R72gjGzhNlypFWQreP9Aj+6VjTTYTJNB7aDhg+A48EP97KeSk4dUAFrsKMdeAbp7W9yVlJldzYbJZP9OxJzH6YhgUjxuf0S+qzJUnIqB/Gmtot1F50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957804; c=relaxed/simple;
	bh=wkfgi3tF51NfZa7UfUiPY8DHKdeYcx95mPJdjnoKkNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jPug9fe0L+Q3pSYbYVPXzXHExV8Fq+h7HUx6jWmQljKs/4PSZUE/cVBQZlioIgm40V6pJT0WNk8xW9/RfV7PR2X9lrJK9QosaHYFd5jG0H13Ghxp9e2FegPzNIvJvakypf5IS8teX1cexi2E1QTh3ElAMdZVTlDLx46XJoHEjSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dbLixok0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608d6e7314bso28507027b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708957802; x=1709562602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CpT/v58LZa+6DN+5ZZ1kc+YtmkGbFtn0oji87VtEKmc=;
        b=dbLixok0jF3K3eFbyGlBl51OgWZHSZN4xu+kyb9DRD8dcCkAEXPgqnMkUKVcBw5XSE
         k9SS+SRZNR/qfjgUpdJ1xxuh59QXFA9J/MXlNUgjK+CtozRn69iGHwnncCfqSayZqw4r
         PgDCaUNULDumN4h8Ato3TjBtmr6Lp4cV61iwlPkfk5Zu2lZXgPE0iA4YBt0pfDEI2r7A
         UM7bfLKq3oWrLvJdhcYBUDkUoLhw1Ny8MN30eFoDN7RAvH9qIQQBTlTLQP1/zcsITIZ5
         PSQq+li96fapPwJNieRvCTxwuUa+ZDKkYAx7/KYfEFK31K3/kne+T/uaXUzUsg4bO8rx
         VclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708957802; x=1709562602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpT/v58LZa+6DN+5ZZ1kc+YtmkGbFtn0oji87VtEKmc=;
        b=hM4ZDp8oStyTK6YJpdEeUYzAndoAE2cow1YlGZVTZ9ojfgwTRHNimTCV5OmW//gchE
         RXn9IfR9e7hPZs5hQXwJOFNvn6O2VP36rmL70a/xlY97SYgooaeMQ1hHQd4Vc6L1+y9u
         tOqU+wkoQhkRttiHSNTglxNhnxBvzOPDcji65zRSKzExddT4lC+GvkUfx0mW26Xk6CL7
         LMvxdKpULESmAwFgaJ8fTrS7T/F+5CCg+0ikIU//+rD6huCmjCOORa60tWowgNQsxb85
         4c/8///xwYV3XdkippGVckaCY9mPazT0QVIfnsRL4+ypHXtgsL6iyACVBAsnUnnOhSem
         39mQ==
X-Gm-Message-State: AOJu0YxZdGuSOVO69haOxkuoO19gVt2w2xhF17MsNBMbpJ5DJBq/z7OX
	vRfV6dvwwZAs0ABpDYL9obg8FBHFijWYPozG33MNUN/9JNSqY1nAgNjFIgTYnQHPH6yGiJDQUjU
	ceYB5wNoKEoMoJwt6HWbjmUtgrTedovHdC1/F/GrsfUpusNZsy8Tmh7sBUT4H425ZL2OmsiJoQC
	VPP/vqGrFPG3NgemorY7hg6y7bJ2NUgQ==
X-Google-Smtp-Source: AGHT+IHod6f/RrqkCgL54qo6RscTh9l22Lk9+yxAVoO5/E8ILZeNb8jQagSgESUz8cZPbWdOUgpHSimR
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:100b:b0:dcc:8be2:7cb0 with SMTP id
 w11-20020a056902100b00b00dcc8be27cb0mr244198ybt.0.1708957801956; Mon, 26 Feb
 2024 06:30:01 -0800 (PST)
Date: Mon, 26 Feb 2024 15:29:54 +0100
In-Reply-To: <20240226142952.64769-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226142952.64769-12-ardb+git@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240226142952.64769-13-ardb+git@google.com>
Subject: [PATCH v6 01/10] x86/startup_64: Simplify CR4 handling in startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

When paging is enabled, the CR4.PAE and CR4.LA57 control bits cannot be
changed, and so they can simply be preserved rather than reason about
whether or not they need to be set. CR4.MCE should be preserved unless
the kernel was built without CONFIG_X86_MCE, in which case it must be
cleared.

CR4.PSE should be set explicitly, regardless of whether or not it was
set before.

CR4.PGE is set explicitly, and then cleared and set again after
programming CR3 in order to flush TLB entries based on global
translations. This makes the first assignment redundant, and can
therefore be omitted. So clear PGE by omitting it from the preserve
mask, and set it again explicitly after switching to the new page
tables.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 30 ++++++++------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d295bf68bf94..1b054585bfd1 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -185,6 +185,11 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	addq	$(init_top_pgt - __START_KERNEL_map), %rax
 1:
 
+	/*
+	 * Create a mask of CR4 bits to preserve. Omit PGE in order to clean
+	 * global 1:1 translations from the TLBs.
+	 */
+	movl	$(X86_CR4_PAE | X86_CR4_LA57), %edx
 #ifdef CONFIG_X86_MCE
 	/*
 	 * Preserve CR4.MCE if the kernel will enable #MC support.
@@ -193,20 +198,13 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * configured will crash the system regardless of the CR4.MCE value set
 	 * here.
 	 */
-	movq	%cr4, %rcx
-	andl	$X86_CR4_MCE, %ecx
-#else
-	movl	$0, %ecx
+	orl	$X86_CR4_MCE, %edx
 #endif
+	movq	%cr4, %rcx
+	andl	%edx, %ecx
 
-	/* Enable PAE mode, PSE, PGE and LA57 */
-	orl	$(X86_CR4_PAE | X86_CR4_PSE | X86_CR4_PGE), %ecx
-#ifdef CONFIG_X86_5LEVEL
-	testb	$1, __pgtable_l5_enabled(%rip)
-	jz	1f
-	orl	$X86_CR4_LA57, %ecx
-1:
-#endif
+	/* Even if ignored in long mode, set PSE uniformly on all logical CPUs. */
+	btsl	$X86_CR4_PSE_BIT, %ecx
 	movq	%rcx, %cr4
 
 	/* Setup early boot stage 4-/5-level pagetables. */
@@ -223,14 +221,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movq	%rax, %cr3
 
 	/*
-	 * Do a global TLB flush after the CR3 switch to make sure the TLB
-	 * entries from the identity mapping are flushed.
+	 * Set CR4.PGE to re-enable global translations.
 	 */
-	movq	%cr4, %rcx
-	movq	%rcx, %rax
-	xorq	$X86_CR4_PGE, %rcx
+	btsl	$X86_CR4_PGE_BIT, %ecx
 	movq	%rcx, %cr4
-	movq	%rax, %cr4
 
 	/* Ensure I am executing from virtual addresses */
 	movq	$1f, %rax
-- 
2.44.0.rc0.258.g7320e95886-goog


