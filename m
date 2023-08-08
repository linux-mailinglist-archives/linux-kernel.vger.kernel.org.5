Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338B1773EC9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjHHQfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjHHQel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:34:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B71290BC;
        Tue,  8 Aug 2023 08:52:35 -0700 (PDT)
Date:   Tue, 08 Aug 2023 08:43:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691484240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y77rgn7E7TfOuMWUCKwBavhvM7WJdaVehINdRrYibZ4=;
        b=QfomoJby8n++lU8QdermIsj5JolG5JYq7kfupJzzzFE5K810wsMOPrjuB1MTwCvbT721Mj
        +WKtPfEpNpITseMdq9tuULIOiWvujAHzPqqKeut938J9eZyweIX0EQ7HGBTMHuV11RoSZO
        a/bYFcg1L06fdBiO6FddkUObhRCGZ8WsB2eeHbdSH/EYdqnuehoJOOgU1sRuyZx9W+h2lY
        PFDIibgbU3OTCJ7VaDO2/J2v9vYXmb1MpRlR+7AogC+irI1wDnEg6iHX7zaAh6PCsUhtej
        pZf1g4Xj1XJLcrIhbBJpMNym57b7F/KeeXtnaxyIsdOPD/CWSwd8luba9zXS2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691484240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y77rgn7E7TfOuMWUCKwBavhvM7WJdaVehINdRrYibZ4=;
        b=9D6cKiU37Yi4ul0awgJy9eR+7tYNOfPqzykhnpzSOp+KzQpYRJP0WZpsV/Hc7/EamSIVRf
        mdjP8yuNq8KPYMBg==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/decompressor: Move global symbol references to C code
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807162720.545787-20-ardb@kernel.org>
References: <20230807162720.545787-20-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <169148423950.27769.1609790519786768176.tip-bot2@tip-bot2>
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

Commit-ID:     24388292e2d7fae79a0d4183cc91716b851299cf
Gitweb:        https://git.kernel.org/tip/24388292e2d7fae79a0d4183cc91716b851299cf
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Aug 2023 18:27:16 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Aug 2023 20:58:02 +02:00

x86/decompressor: Move global symbol references to C code

It is no longer necessary to be cautious when referring to global
variables in the position independent decompressor code, now that it is
built using PIE codegen and makes an assertion in the linker script that
no GOT entries exist (which would require adjustment for the actual
runtime load address of the decompressor binary).

This means global variables can be referenced directly from C code,
instead of having to pass their runtime addresses into C routines from
asm code, which needs to happen at each call site. Do so for the code
that will be called directly from the EFI stub after a subsequent patch,
and avoid the need to duplicate this logic a third time.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-20-ardb@kernel.org
---
 arch/x86/boot/compressed/head_32.S |  8 --------
 arch/x86/boot/compressed/head_64.S | 10 ++--------
 arch/x86/boot/compressed/misc.c    | 16 +++++++++-------
 3 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 8876ffe..3af4a38 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -168,13 +168,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
  */
 	/* push arguments for extract_kernel: */
 
-	pushl	output_len@GOTOFF(%ebx)	/* decompressed length, end of relocs */
 	pushl	%ebp			/* output address */
-	pushl	input_len@GOTOFF(%ebx)	/* input_len */
-	leal	input_data@GOTOFF(%ebx), %eax
-	pushl	%eax			/* input_data */
-	leal	boot_heap@GOTOFF(%ebx), %eax
-	pushl	%eax			/* heap area */
 	pushl	%esi			/* real mode pointer */
 	call	extract_kernel		/* returns kernel entry point in %eax */
 	addl	$24, %esp
@@ -202,8 +196,6 @@ SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
  */
 	.bss
 	.balign 4
-boot_heap:
-	.fill BOOT_HEAP_SIZE, 1, 0
 boot_stack:
 	.fill BOOT_STACK_SIZE, 1, 0
 boot_stack_end:
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fb0e562..28f4605 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -493,13 +493,9 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 /*
  * Do the extraction, and jump to the new kernel..
  */
-	/* pass struct boot_params pointer */
+	/* pass struct boot_params pointer and output target address */
 	movq	%r15, %rdi
-	leaq	boot_heap(%rip), %rsi	/* malloc area for uncompression */
-	leaq	input_data(%rip), %rdx  /* input_data */
-	movl	input_len(%rip), %ecx	/* input_len */
-	movq	%rbp, %r8		/* output target address */
-	movl	output_len(%rip), %r9d	/* decompressed length, end of relocs */
+	movq	%rbp, %rsi
 	call	extract_kernel		/* returns kernel entry point in %rax */
 
 /*
@@ -657,8 +653,6 @@ SYM_DATA_END_LABEL(boot_idt, SYM_L_GLOBAL, boot_idt_end)
  */
 	.bss
 	.balign 4
-SYM_DATA_LOCAL(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
-
 SYM_DATA_START_LOCAL(boot_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
 	.balign 16
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 94b7abc..2d91d56 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -330,6 +330,11 @@ static size_t parse_elf(void *output)
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
+static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
+
+extern unsigned char input_data[];
+extern unsigned int input_len, output_len;
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -347,14 +352,11 @@ static size_t parse_elf(void *output)
  *             |-------uncompressed kernel image---------|
  *
  */
-asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
-				  unsigned char *input_data,
-				  unsigned long input_len,
-				  unsigned char *output,
-				  unsigned long output_len)
+asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 {
 	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
+	memptr heap = (memptr)boot_heap;
 	unsigned long needed_size;
 	size_t entry_offset;
 
@@ -412,7 +414,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	 * entries. This ensures the full mapped area is usable RAM
 	 * and doesn't include any reserved areas.
 	 */
-	needed_size = max(output_len, kernel_total_size);
+	needed_size = max_t(unsigned long, output_len, kernel_total_size);
 #ifdef CONFIG_X86_64
 	needed_size = ALIGN(needed_size, MIN_KERNEL_ALIGN);
 #endif
@@ -443,7 +445,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 #ifdef CONFIG_X86_64
 	if (heap > 0x3fffffffffffUL)
 		error("Destination address too large");
-	if (virt_addr + max(output_len, kernel_total_size) > KERNEL_IMAGE_SIZE)
+	if (virt_addr + needed_size > KERNEL_IMAGE_SIZE)
 		error("Destination virtual address is beyond the kernel mapping area");
 #else
 	if (heap > ((-__PAGE_OFFSET-(128<<20)-1) & 0x7fffffff))
