Return-Path: <linux-kernel+bounces-83487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB90A869A29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C971F22CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F65145343;
	Tue, 27 Feb 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0B8jN3Gb"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA41420B3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047167; cv=none; b=YF6MYRpNPMgt5or1Zeehll2AC+Ko+Wy2WQXqx08B3BlvSD8NSYh47NphqwrN56ix/quK9Vab/WIqCvMWYU7OqQ/m3n0OSlL1+B97KE1+VEa8yESjHJdVtzV9mbIum6xqWAFYBvZVm5eks1rSKN6I2IxZmFw/GjGiOzD+wFgfxy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047167; c=relaxed/simple;
	bh=CBHnFGty3UwF5woU9FH0wlEAG8G1OTGQbjOXf2dVQ3Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ht1jKxsAeGE6Tz1VN1VeBTqAnLnS17Ulkf6l88kHAq+1QSFgGzUEeDLAmlIEyx9xZjMvkeumNasKT1NkVIcfKb+tsXzEyFk+0wZn3K8fs4OHgVy02NxRaeXU6njgQG/vB/1iEdnmH6wM3UrJoTbyS+72dRYGTawheiQ65pGsTeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0B8jN3Gb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so6246143276.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709047165; x=1709651965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+kR9nuu+f3rXEtZJvvepNzOYr6GJN2sdntJZoeWS+k=;
        b=0B8jN3GbRsIqivMwq0YSRtTau2HHIC4XYnHolHZfqPKfiacyigtI0UZ1tNL0He350u
         aQIihibi9DM7mfR9SSl/dgE3DbulMGwApuboZ/tgENVGeAB07oV7mYKk59/IQRS+1Mdf
         vlwpGvD/0lWAgT+OeBQDd4aVyk9R1O01zomOP7jOv3OK+mMPWZvTXasMA12LOL1WD4FN
         1rc1EEN71h4YrbbW4+S7CQ/ll9x92Tv8FEECEd/k5PJcZa9aPPZDRPugshnFA8rRzraw
         2/Kwo+k0u9DHbvLg8B3ngyYiQDEgw8RrNKaCE4+Cy4Yh3J+gBopT4KhMtdZPzETDPjCQ
         VGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047165; x=1709651965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+kR9nuu+f3rXEtZJvvepNzOYr6GJN2sdntJZoeWS+k=;
        b=KEzkvMsRC97iJP59xMEPnaRybBh3DcDp6cHPpbrKY83tOPzB9iw8Dt8L+PcnGzmtF+
         uFEq0oxVkPggDHt103swYqF49KJYP26EtkjcRKwOUkPaono2emeRU4Vdl/CtOcPo2VMd
         XN6UUpAUq/Wmtrbc0vhMLs5rkIZtMNgIL6xzuPoR98Xp9x/b93DXLMGfzEKWysUAkTQ3
         L0VqiKLIPvF0CgY9AGzEXmlkV8MYJWhxxCzOcnrJEem8KEr81BnX94wdwIVyATTbC+Iz
         CrWAEQLyqa4x8y09BbwsFAPDj/rpzbP6aJ7x0pThx2YQKxlJ34w97SybaDdxhGKMgfwU
         mPhA==
X-Gm-Message-State: AOJu0Yx2UqeiAg8Tc8DqfruJc890ttn3K88vLYDjVGha8cFxJQvm/yNC
	JOczAfn/UM30krQ5hHvEb9ThKUzQPZ4kLgRzwsHxYBViiLcRqug9EbDKQZ5u48MucnbHBiuGlqv
	+CyhnHxzvYGzdpq3HKE2b9bwUylW23VeULyiunqEhpteQaQFMU7Ek+9hqVVI3as5KQDZ3upX3JJ
	Od5mZEpYGj4ICm3QEvpK1kLRbdmlEoew==
X-Google-Smtp-Source: AGHT+IGsX7kyVQt1/JyYzT4XLoY1Nf00PeCKfqLvzDDHOeFa+2QUyDyQytW+rOsWbWfWDPdLjmlqe25L
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:4ac1:0:b0:dcf:b5b8:f825 with SMTP id
 x184-20020a254ac1000000b00dcfb5b8f825mr178068yba.0.1709047165048; Tue, 27 Feb
 2024 07:19:25 -0800 (PST)
Date: Tue, 27 Feb 2024 16:19:09 +0100
In-Reply-To: <20240227151907.387873-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227151907.387873-12-ardb+git@google.com>
Subject: [PATCH v7 1/9] x86/startup_64: Simplify CR4 handling in startup code
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
2.44.0.rc1.240.g4c46232300-goog


