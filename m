Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70663773EB6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjHHQex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjHHQd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:33:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E339087;
        Tue,  8 Aug 2023 08:52:21 -0700 (PDT)
Date:   Tue, 08 Aug 2023 08:44:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691484243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7bQ+cNqwpjqyQvkp57Fn3I8ulPZ5t4VRLDI6PVz9WZY=;
        b=jzypU/oShINLODrqROfFp9wXwtmk474UpcbIP7wrWIomYOwDM4nIQaafmANDuwuY++3exl
        rYeJEA/KuL0JDsTGlkowf9qNvrsTZ5F3pEi7nUhv2A0Z3CnMIT7gZI875acLNAt9rbsT2l
        feWe3/jCHegzYj0e+qtiGuDGEbbx3hlxmFmWfXR381/NAaBKskdKTloAzcFtY+pBkYTL/p
        GpnK0sNkdiUCIgx/MHkR8APKQlVLNaYc7dLJqor1rrn9pk7y0VSXAV5LJYJFaGgSLU0LIh
        OYujXIankWbApzvF86mGWii04N4MdZ4FYAIvUVqx9Dqv4hGyWO/a4aZsqFJUFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691484243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7bQ+cNqwpjqyQvkp57Fn3I8ulPZ5t4VRLDI6PVz9WZY=;
        b=V4dEGt6tvUbavlUuwUqPA1XMejpHcz5mXvkB06n+Dd+nUP9a/wb7o0NwMIY5SEtB8NIxqV
        0dI9vprbu4jG9ADQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/decompressor: Avoid the need for a stack in the
 32-bit trampoline
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230807162720.545787-12-ardb@kernel.org>
References: <20230807162720.545787-12-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <169148424279.27769.10804321420012596024.tip-bot2@tip-bot2>
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

Commit-ID:     bd328aa01ff77a45aeffea5fc4521854291db11f
Gitweb:        https://git.kernel.org/tip/bd328aa01ff77a45aeffea5fc4521854291db11f
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Aug 2023 18:27:08 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Aug 2023 20:45:55 +02:00

x86/decompressor: Avoid the need for a stack in the 32-bit trampoline

The 32-bit trampoline no longer uses the stack for anything except
performing a far return back to long mode, and preserving the caller's
stack pointer value. Currently, the trampoline stack is placed in the
same page that carries the trampoline code, which means this page must
be mapped writable and executable, and the stack is therefore executable
as well.

Replace the far return with a far jump, so that the return address can
be pre-calculated and patched into the code before it is called. This
removes the need for a 32-bit addressable stack entirely, and in a later
patch, this will be taken advantage of by removing writable permissions
from (and adding executable permissions to) the trampoline code page
when booting via the EFI stub.

Note that the value of RSP still needs to be preserved explicitly across
the switch into 32-bit mode, as the register may get truncated to 32
bits.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20230807162720.545787-12-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S    | 45 +++++++++++++++-----------
 arch/x86/boot/compressed/pgtable.h    |  4 +-
 arch/x86/boot/compressed/pgtable_64.c | 12 ++++++-
 3 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index c475042..37fd7b7 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -540,6 +540,7 @@ SYM_FUNC_END(.Lrelocated)
  * trampoline memory. A non-zero second argument (ESI) means that the
  * trampoline needs to enable 5-level paging.
  */
+	.section ".rodata", "a", @progbits
 SYM_CODE_START(trampoline_32bit_src)
 	/*
 	 * Preserve live 64-bit registers on the stack: this is necessary
@@ -550,13 +551,9 @@ SYM_CODE_START(trampoline_32bit_src)
 	pushq	%rbp
 	pushq	%rbx
 
-	/* Set up 32-bit addressable stack and push the old RSP value */
-	leaq	(TRAMPOLINE_32BIT_STACK_END - 8)(%rcx), %rbx
-	movq	%rsp, (%rbx)
-	movq	%rbx, %rsp
-
-	/* Take the address of the trampoline exit code */
-	leaq	.Lret(%rip), %rbx
+	/* Preserve top half of RSP in a legacy mode GPR to avoid truncation */
+	movq	%rsp, %rbx
+	shrq	$32, %rbx
 
 	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
 	pushq	$__KERNEL32_CS
@@ -564,9 +561,17 @@ SYM_CODE_START(trampoline_32bit_src)
 	pushq	%rax
 	lretq
 
+	/*
+	 * The 32-bit code below will do a far jump back to long mode and end
+	 * up here after reconfiguring the number of paging levels. First, the
+	 * stack pointer needs to be restored to its full 64-bit value before
+	 * the callee save register contents can be popped from the stack.
+	 */
 .Lret:
+	shlq	$32, %rbx
+	orq	%rbx, %rsp
+
 	/* Restore the preserved 64-bit registers */
-	movq	(%rsp), %rsp
 	popq	%rbx
 	popq	%rbp
 	popq	%r15
@@ -574,11 +579,6 @@ SYM_CODE_START(trampoline_32bit_src)
 
 	.code32
 0:
-	/* Set up data and stack segments */
-	movl	$__KERNEL_DS, %eax
-	movl	%eax, %ds
-	movl	%eax, %ss
-
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -633,18 +633,26 @@ SYM_CODE_START(trampoline_32bit_src)
 1:
 	movl	%eax, %cr4
 
-	/* Prepare the stack for far return to Long Mode */
-	pushl	$__KERNEL_CS
-	pushl	%ebx
-
 	/* Enable paging again. */
 	movl	%cr0, %eax
 	btsl	$X86_CR0_PG_BIT, %eax
 	movl	%eax, %cr0
 
-	lret
+	/*
+	 * Return to the 64-bit calling code using LJMP rather than LRET, to
+	 * avoid the need for a 32-bit addressable stack. The destination
+	 * address will be adjusted after the template code is copied into a
+	 * 32-bit addressable buffer.
+	 */
+.Ljmp:	ljmpl	$__KERNEL_CS, $(.Lret - trampoline_32bit_src)
 SYM_CODE_END(trampoline_32bit_src)
 
+/*
+ * This symbol is placed right after trampoline_32bit_src() so its address can
+ * be used to infer the size of the trampoline code.
+ */
+SYM_DATA(trampoline_ljmp_imm_offset, .word  .Ljmp + 1 - trampoline_32bit_src)
+
 	/*
          * The trampoline code has a size limit.
          * Make sure we fail to compile if the trampoline code grows
@@ -652,6 +660,7 @@ SYM_CODE_END(trampoline_32bit_src)
 	 */
 	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
 
+	.text
 SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index 4e8cef1..c6b0903 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -8,13 +8,13 @@
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
 #define TRAMPOLINE_32BIT_CODE_SIZE	0xA0
 
-#define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
-
 #ifndef __ASSEMBLER__
 
 extern unsigned long *trampoline_32bit;
 
 extern void trampoline_32bit_src(void *trampoline, bool enable_5lvl);
 
+extern const u16 trampoline_ljmp_imm_offset;
+
 #endif /* __ASSEMBLER__ */
 #endif /* BOOT_COMPRESSED_PAGETABLE_H */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index f8092d3..5198a05 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -109,6 +109,7 @@ static unsigned long find_trampoline_placement(void)
 struct paging_config paging_prepare(void *rmode)
 {
 	struct paging_config paging_config = {};
+	void *tramp_code;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
 	boot_params = rmode;
@@ -148,10 +149,19 @@ struct paging_config paging_prepare(void *rmode)
 	memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
 
 	/* Copy trampoline code in place */
-	memcpy(trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
+	tramp_code = memcpy(trampoline_32bit +
+			TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
 			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
 
 	/*
+	 * Avoid the need for a stack in the 32-bit trampoline code, by using
+	 * LJMP rather than LRET to return back to long mode. LJMP takes an
+	 * immediate absolute address, which needs to be adjusted based on the
+	 * placement of the trampoline.
+	 */
+	*(u32 *)(tramp_code + trampoline_ljmp_imm_offset) += (unsigned long)tramp_code;
+
+	/*
 	 * The code below prepares page table in trampoline memory.
 	 *
 	 * The new page table will be used by trampoline code for switching
