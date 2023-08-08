Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6745A773EA5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjHHQdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjHHQcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:32:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB531034;
        Tue,  8 Aug 2023 08:52:03 -0700 (PDT)
Date:   Tue, 08 Aug 2023 08:44:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691484247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/QMZQliKphSu6iVAfYaGfKqsW7zTXWKkam3GAeYdPzw=;
        b=p9yR6lVtT8I19k2kQ68h4moDM2uDiFrsBZJ11EL8yH7YoeL6T9ojS8V8G43YC+zYJ0obr1
        LlsZm505oz9bVfVxY2eCqVvZgRt3R2+9ulnl1B27xY3nxgEXand9yKws/UBzcmxqd5Ss4L
        oUwcBIVwtROtW2MoTPh566ozHKpOd7eotPFycLGiYOsLZXfVn11ZwqksapT0f8qr3IjDyK
        dCLorbYRwF0jw31UcVOmHtz+19/iZJDos/lM9arvzH9u9SHqHZwmGo/0Bzpi6orSwACK4m
        bYtn/spfXQxbUzsF3wXf08Gcs5JWtqTCkq5/P7RxCxrctXt1DD88kER9nczVqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691484247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/QMZQliKphSu6iVAfYaGfKqsW7zTXWKkam3GAeYdPzw=;
        b=lg/kn6lUd6scXMLFS4tTbViF55XfCtwaCoBmOt8bdRSmVpVwepHikZzbb8a6XqvY5kDWnE
        ZdX+dBU/axuUpvDw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/head_64: Store boot_params pointer in callee save
 register
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807162720.545787-3-ardb@kernel.org>
References: <20230807162720.545787-3-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <169148424646.27769.12729891213885700414.tip-bot2@tip-bot2>
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

Commit-ID:     2f69a81ad6873231a2ae78d5ade3263ec54a4c9c
Gitweb:        https://git.kernel.org/tip/2f69a81ad6873231a2ae78d5ade3263ec54a4c9c
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Aug 2023 18:26:59 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Aug 2023 19:20:32 +02:00

x86/head_64: Store boot_params pointer in callee save register

Instead of pushing/popping %RSI to/from the stack every time a function
is called from startup_64(), store it in a callee preserved register
and grab it from there when its value is actually needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-3-ardb@kernel.org
---
 arch/x86/kernel/head_64.S | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index c5b9289..ea69959 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -51,7 +51,9 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * for us.  These identity mapped page tables map all of the
 	 * kernel pages and possibly all of memory.
 	 *
-	 * %rsi holds a physical pointer to real_mode_data.
+	 * %RSI holds the physical address of the boot_params structure
+	 * provided by the bootloader. Preserve it in %R15 so C function calls
+	 * will not clobber it.
 	 *
 	 * We come here either directly from a 64bit bootloader, or from
 	 * arch/x86/boot/compressed/head_64.S.
@@ -62,6 +64,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * compiled to run at we first fixup the physical addresses in our page
 	 * tables and then reload them.
 	 */
+	mov	%rsi, %r15
 
 	/* Set up the stack for verify_cpu() */
 	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
@@ -75,9 +78,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	shrq	$32,  %rdx
 	wrmsr
 
-	pushq	%rsi
 	call	startup_64_setup_env
-	popq	%rsi
 
 	/* Now switch to __KERNEL_CS so IRET works reliably */
 	pushq	$__KERNEL_CS
@@ -93,12 +94,10 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * Activate SEV/SME memory encryption if supported/enabled. This needs to
 	 * be done now, since this also includes setup of the SEV-SNP CPUID table,
 	 * which needs to be done before any CPUID instructions are executed in
-	 * subsequent code.
+	 * subsequent code. Pass the boot_params pointer as the first argument.
 	 */
-	movq	%rsi, %rdi
-	pushq	%rsi
+	movq	%r15, %rdi
 	call	sme_enable
-	popq	%rsi
 #endif
 
 	/* Sanitize CPU configuration */
@@ -111,9 +110,8 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * programmed into CR3.
 	 */
 	leaq	_text(%rip), %rdi
-	pushq	%rsi
+	movq	%r15, %rsi
 	call	__startup_64
-	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	addq	$(early_top_pgt - __START_KERNEL_map), %rax
@@ -127,8 +125,6 @@ SYM_CODE_START(secondary_startup_64)
 	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 0,
 	 * and someone has loaded a mapped page table.
 	 *
-	 * %rsi holds a physical pointer to real_mode_data.
-	 *
 	 * We come here either from startup_64 (using physical addresses)
 	 * or from trampoline.S (using virtual addresses).
 	 *
@@ -153,6 +149,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR
 
+	/* Clear %R15 which holds the boot_params pointer on the boot CPU */
+	xorq	%r15, %r15
+
 	/*
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
 	 * added to the initial pgdir entry that will be programmed into CR3.
@@ -199,13 +198,9 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * hypervisor could lie about the C-bit position to perform a ROP
 	 * attack on the guest by writing to the unencrypted stack and wait for
 	 * the next RET instruction.
-	 * %rsi carries pointer to realmode data and is callee-clobbered. Save
-	 * and restore it.
 	 */
-	pushq	%rsi
 	movq	%rax, %rdi
 	call	sev_verify_cbit
-	popq	%rsi
 
 	/*
 	 * Switch to new page-table
@@ -365,9 +360,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	wrmsr
 
 	/* Setup and Load IDT */
-	pushq	%rsi
 	call	early_setup_idt
-	popq	%rsi
 
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
@@ -403,9 +396,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	pushq $0
 	popfq
 
-	/* rsi is pointer to real mode structure with interesting info.
-	   pass it to C */
-	movq	%rsi, %rdi
+	/* Pass the boot_params pointer as first argument */
+	movq	%r15, %rdi
 
 .Ljump_to_C_code:
 	/*
