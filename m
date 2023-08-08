Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E83773EB4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjHHQen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjHHQdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:33:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E062E1397B;
        Tue,  8 Aug 2023 08:52:17 -0700 (PDT)
Date:   Tue, 08 Aug 2023 08:44:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691484247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=akwmlJvPa/5tWkMpeCgswWq6rVyG0zRGX8qCsIqf1YY=;
        b=GW51cpb6vI0qGTsCkiM1cr2LnuG7s8M4UTRHtZJXL3V1X8+iKpNRLyPo531fFrGP/0IfR/
        Avw6EqYQtHYAI3mnGtyGSRlIFOC4BsgasZ8Myo6Fgn+kKpQHe7j4cd4Rib4pLFrYdf49XW
        jJFW4ndvuBbLfWD46xfUriu+6MgviatkCW4w3ZNCsQt29MZXZhBhiLy8C877vwsVZ7jcTP
        33u87E8IZdu0ZBhBnL+EbmltBo7i8iS2FuHFtZOYY2YXDJAeqOMFvxukFtx9nogvOfeXng
        pazvTVrIhpk10YQi8E06B2C1Ttq1xnuGZc9aKUBuqMspvPkz6Cx+2JHtBgwMjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691484247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=akwmlJvPa/5tWkMpeCgswWq6rVyG0zRGX8qCsIqf1YY=;
        b=tUIAnbTiuZp5eOwvEz8V+f4e18jYBEDKo11641KQaX1ZKrd4Jtv73WhwKkvA59TxY/9+F8
        rXDJmlth8AK+jXDQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/decompressor: Don't rely on upper 32 bits of GPRs
 being preserved
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807162720.545787-2-ardb@kernel.org>
References: <20230807162720.545787-2-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <169148424686.27769.7264155385078320796.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     264b82fdb4989cf6a44a2bcd0c6ea05e8026b2ac
Gitweb:        https://git.kernel.org/tip/264b82fdb4989cf6a44a2bcd0c6ea05e802=
6b2ac
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Aug 2023 18:26:58 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Aug 2023 19:02:06 +02:00

x86/decompressor: Don't rely on upper 32 bits of GPRs being preserved

The 4-to-5 level mode switch trampoline disables long mode and paging in
order to be able to flick the LA57 bit. According to section 3.4.1.1 of
the x86 architecture manual [0], 64-bit GPRs might not retain the upper
32 bits of their contents across such a mode switch.

Given that RBP, RBX and RSI are live at this point, preserve them on the
stack, along with the return address that might be above 4G as well.

[0] Intel=C2=AE 64 and IA-32 Architectures Software Developer=E2=80=99s Manua=
l, Volume 1: Basic Architecture

  "Because the upper 32 bits of 64-bit general-purpose registers are
   undefined in 32-bit modes, the upper 32 bits of any general-purpose
   register are not preserved when switching from 64-bit mode to a 32-bit
   mode (to protected mode or compatibility mode). Software must not
   depend on these bits to maintain a value after a 64-bit to 32-bit
   mode switch."

Fixes: 194a9749c73d650c ("x86/boot/compressed/64: Handle 5-level paging boot =
if kernel is above 4G")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-2-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S | 30 ++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/he=
ad_64.S
index 03c4328..f732426 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -459,11 +459,25 @@ SYM_CODE_START(startup_64)
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
=20
+	/* Set up 32-bit addressable stack */
+	leaq	TRAMPOLINE_32BIT_STACK_END(%rcx), %rsp
+
+	/*
+	 * Preserve live 64-bit registers on the stack: this is necessary
+	 * because the architecture does not guarantee that GPRs will retain
+	 * their full 64-bit values across a 32-bit mode switch.
+	 */
+	pushq	%rbp
+	pushq	%rbx
+	pushq	%rsi
+
 	/*
-	 * Load the address of trampoline_return() into RDI.
-	 * It will be used by the trampoline to return to the main code.
+	 * Push the 64-bit address of trampoline_return() onto the new stack.
+	 * It will be used by the trampoline to return to the main code. Due to
+	 * the 32-bit mode switch, it cannot be kept it in a register either.
 	 */
 	leaq	trampoline_return(%rip), %rdi
+	pushq	%rdi
=20
 	/* Switch to compatibility mode (CS.L =3D 0 CS.D =3D 1) via far return */
 	pushq	$__KERNEL32_CS
@@ -471,6 +485,11 @@ SYM_CODE_START(startup_64)
 	pushq	%rax
 	lretq
 trampoline_return:
+	/* Restore live 64-bit registers */
+	popq	%rsi
+	popq	%rbx
+	popq	%rbp
+
 	/* Restore the stack, the 32-bit trampoline uses its own stack */
 	leaq	rva(boot_stack_end)(%rbx), %rsp
=20
@@ -582,7 +601,7 @@ SYM_FUNC_END(.Lrelocated)
 /*
  * This is the 32-bit trampoline that will be copied over to low memory.
  *
- * RDI contains the return address (might be above 4G).
+ * Return address is at the top of the stack (might be above 4G).
  * ECX contains the base address of the trampoline memory.
  * Non zero RDX means trampoline needs to enable 5-level paging.
  */
@@ -592,9 +611,6 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	%eax, %ds
 	movl	%eax, %ss
=20
-	/* Set up new stack */
-	leal	TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
-
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -671,7 +687,7 @@ SYM_CODE_END(trampoline_32bit_src)
 	.code64
 SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
 	/* Return from the trampoline */
-	jmp	*%rdi
+	retq
 SYM_FUNC_END(.Lpaging_enabled)
=20
 	/*
