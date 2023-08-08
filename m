Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710EC773EB2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjHHQem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjHHQdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:33:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CDB73FC;
        Tue,  8 Aug 2023 08:52:16 -0700 (PDT)
Date:   Tue, 08 Aug 2023 08:44:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691484244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZpd66tZ1O4cA0zNKZj4Z7f5dQ9IzZjn8+doueP5aak=;
        b=BUhyFpEEyzRLA6Vv+5MFGu68FssBQMlY7Q7XT5wEzco7pBKU4e05RiAGI+RFX2vQT8dmCY
        ACTg5mG73jhgeSeNK1WGGVaNa1S2+dEgTQlFm66vNFO7RK1ZJ1NKeM8gWVEsxE4uuAJafz
        ec12QcPdw/C/ZLq4cGQ7/8SRPLq5yjEb6mZUr8N7g8i5ddWgcJTYWpb50hmyvtrVLSRB3f
        3KsU2rLDzvqLXwED2v/MHsXijbXxI4V6ChVCJ7kfj1jPHAGEeD4xirlXzev0rq+rPc6TdV
        vvkX7/fD/z0C2QE7C60SbKY2UZgKCYne1tBAjv1dMnOIeGgA5aqPaG685aMcqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691484244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZpd66tZ1O4cA0zNKZj4Z7f5dQ9IzZjn8+doueP5aak=;
        b=UGowB+g8elhUnnNZq6WXHNuoPbwHfoxUFosXrsHPJRMdrgWTNF5NwFYiLLLPSwq42XrV31
        l3xJl+Yg0KaLGVDg==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/decompressor: Call trampoline as a normal function
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230807162720.545787-10-ardb@kernel.org>
References: <20230807162720.545787-10-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <169148424368.27769.6571904072667422897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Commit-ID:     e8972a76aa90c05a0078043413f806c02fcb3487
Gitweb:        https://git.kernel.org/tip/e8972a76aa90c05a0078043413f806c02fcb3487
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Aug 2023 18:27:06 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Aug 2023 20:43:13 +02:00

x86/decompressor: Call trampoline as a normal function

Move the long return to switch to 32-bit mode into the trampoline code
so it can be called as an ordinary function. This will allow it to be
called directly from C code in a subsequent patch.

While at it, reorganize the code somewhat to keep the prologue and
epilogue of the function together, making the code a bit easier to
follow. Also, given that the trampoline is now entered in 64-bit mode, a
simple RIP-relative reference can be used to take the address of the
exit point.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20230807162720.545787-10-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S | 79 ++++++++++++-----------------
 arch/x86/boot/compressed/pgtable.h |  2 +-
 2 files changed, 36 insertions(+), 45 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 19bf810..91b5eee 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -447,39 +447,8 @@ SYM_CODE_START(startup_64)
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
 
-	/* Set up 32-bit addressable stack */
-	leaq	TRAMPOLINE_32BIT_STACK_END(%rcx), %rsp
-
-	/*
-	 * Preserve live 64-bit registers on the stack: this is necessary
-	 * because the architecture does not guarantee that GPRs will retain
-	 * their full 64-bit values across a 32-bit mode switch.
-	 */
-	pushq	%r15
-	pushq	%rbp
-	pushq	%rbx
-
-	/*
-	 * Push the 64-bit address of trampoline_return() onto the new stack.
-	 * It will be used by the trampoline to return to the main code. Due to
-	 * the 32-bit mode switch, it cannot be kept it in a register either.
-	 */
-	leaq	trampoline_return(%rip), %rdi
-	pushq	%rdi
-
-	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
-	pushq	$__KERNEL32_CS
 	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
-	pushq	%rax
-	lretq
-trampoline_return:
-	/* Restore live 64-bit registers */
-	popq	%rbx
-	popq	%rbp
-	popq	%r15
-
-	/* Restore the stack, the 32-bit trampoline uses its own stack */
-	leaq	rva(boot_stack_end)(%rbx), %rsp
+	call	*%rax
 
 	/*
 	 * cleanup_trampoline() would restore trampoline memory.
@@ -561,7 +530,6 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	jmp	*%rax
 SYM_FUNC_END(.Lrelocated)
 
-	.code32
 /*
  * This is the 32-bit trampoline that will be copied over to low memory.
  *
@@ -570,6 +538,39 @@ SYM_FUNC_END(.Lrelocated)
  * Non zero RDX means trampoline needs to enable 5-level paging.
  */
 SYM_CODE_START(trampoline_32bit_src)
+	/*
+	 * Preserve live 64-bit registers on the stack: this is necessary
+	 * because the architecture does not guarantee that GPRs will retain
+	 * their full 64-bit values across a 32-bit mode switch.
+	 */
+	pushq	%r15
+	pushq	%rbp
+	pushq	%rbx
+
+	/* Set up 32-bit addressable stack and push the old RSP value */
+	leaq	(TRAMPOLINE_32BIT_STACK_END - 8)(%rcx), %rbx
+	movq	%rsp, (%rbx)
+	movq	%rbx, %rsp
+
+	/* Take the address of the trampoline exit code */
+	leaq	.Lret(%rip), %rbx
+
+	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
+	pushq	$__KERNEL32_CS
+	leaq	0f(%rip), %rax
+	pushq	%rax
+	lretq
+
+.Lret:
+	/* Restore the preserved 64-bit registers */
+	movq	(%rsp), %rsp
+	popq	%rbx
+	popq	%rbp
+	popq	%r15
+	retq
+
+	.code32
+0:
 	/* Set up data and stack segments */
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
@@ -633,12 +634,9 @@ SYM_CODE_START(trampoline_32bit_src)
 1:
 	movl	%eax, %cr4
 
-	/* Calculate address of paging_enabled() once we are executing in the trampoline */
-	leal	.Lpaging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%ecx), %eax
-
 	/* Prepare the stack for far return to Long Mode */
 	pushl	$__KERNEL_CS
-	pushl	%eax
+	pushl	%ebx
 
 	/* Enable paging again. */
 	movl	%cr0, %eax
@@ -648,12 +646,6 @@ SYM_CODE_START(trampoline_32bit_src)
 	lret
 SYM_CODE_END(trampoline_32bit_src)
 
-	.code64
-SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
-	/* Return from the trampoline */
-	retq
-SYM_FUNC_END(.Lpaging_enabled)
-
 	/*
          * The trampoline code has a size limit.
          * Make sure we fail to compile if the trampoline code grows
@@ -661,7 +653,6 @@ SYM_FUNC_END(.Lpaging_enabled)
 	 */
 	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
 
-	.code32
 SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index cc9b252..91dbb99 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -6,7 +6,7 @@
 #define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
 
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
-#define TRAMPOLINE_32BIT_CODE_SIZE	0x80
+#define TRAMPOLINE_32BIT_CODE_SIZE	0xA0
 
 #define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
 
