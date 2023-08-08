Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484F0773EC7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjHHQfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjHHQei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:34:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A211990B6;
        Tue,  8 Aug 2023 08:52:34 -0700 (PDT)
Date:   Tue, 08 Aug 2023 08:44:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691484242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9uMFnVMvpV7u6Zboz1FXKAblV/BqL2wTGL7YczSuts=;
        b=JpvnmxgRO9QjhDnaUJD0TwbH9jPP7CffuOADDJOzh2oXOUWy+psK5IOnT4WsIiuU5w7ioz
        mm7QNB+1vKSFQaDa7fACD19gAK+2FVEKpOGcdAILbyILnpEYL3fmy/iYrcFaWqkIa3+IE1
        v4GRwf6m7XoQkT1uisAJ3l6WtOsRPyCEx8hYCKN0OEOhIK7/IxXn+mpP7OB4gu93p2d+TG
        RGlo5B1sTxk11Sv2qBZP9wQgL/Mq+mNHh0bHv1CRCcS1h00FJbeetg2+049w1jDDWXBGrB
        VReAb3O0viEOEYrfiGlk5dH4sBz7ISIrtRwy0mbJv0pUp8YSUqi+ti9g/ffd4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691484242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9uMFnVMvpV7u6Zboz1FXKAblV/BqL2wTGL7YczSuts=;
        b=2VKa/oYoBFGQAEBda9j/JAsM8lxae676QZEvnWbWm/fedil8P4RV0vHcI+H3oPYcgO51ab
        Rmu9CYWRvBkPfPBw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/decompressor: Pass pgtable address to trampoline directly
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807162720.545787-15-ardb@kernel.org>
References: <20230807162720.545787-15-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <169148424162.27769.9087697733406558566.tip-bot2@tip-bot2>
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

Commit-ID:     cb83cece57e1889109dd73ea08ee338668c9d1b8
Gitweb:        https://git.kernel.org/tip/cb83cece57e1889109dd73ea08ee338668c9d1b8
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Aug 2023 18:27:11 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Aug 2023 20:49:26 +02:00

x86/decompressor: Pass pgtable address to trampoline directly

The only remaining use of the trampoline address by the trampoline
itself is deriving the page table address from it, and this involves
adding an offset of 0x0. So simplify this, and pass the new CR3 value
directly.

This makes the fact that the page table happens to be at the start of
the trampoline allocation an implementation detail of the caller.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-15-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S    |  8 ++++----
 arch/x86/boot/compressed/pgtable.h    |  2 --
 arch/x86/boot/compressed/pgtable_64.c |  9 ++++-----
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 8730b1d..afdaf8c 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -521,8 +521,9 @@ SYM_FUNC_END(.Lrelocated)
  * running in 64-bit mode.
  *
  * Return address is at the top of the stack (might be above 4G).
- * The first argument (EDI) contains the 32-bit addressable base of the
- * trampoline memory.
+ * The first argument (EDI) contains the address of the temporary PGD level
+ * page table in 32-bit addressable memory which will be programmed into
+ * register CR3.
  */
 	.section ".rodata", "a", @progbits
 SYM_CODE_START(trampoline_32bit_src)
@@ -575,8 +576,7 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	%eax, %cr0
 
 	/* Point CR3 to the trampoline's new top level page table */
-	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%edi), %eax
-	movl	%eax, %cr3
+	movl	%edi, %cr3
 
 	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
 	movl	$MSR_EFER, %ecx
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index c6b0903..6d595ab 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -3,8 +3,6 @@
 
 #define TRAMPOLINE_32BIT_SIZE		(2 * PAGE_SIZE)
 
-#define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
-
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
 #define TRAMPOLINE_32BIT_CODE_SIZE	0xA0
 
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 4213473..eab4e6b 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -103,7 +103,7 @@ static unsigned long find_trampoline_placement(void)
 
 asmlinkage void configure_5level_paging(struct boot_params *bp)
 {
-	void (*toggle_la57)(void *trampoline);
+	void (*toggle_la57)(void *cr3);
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
@@ -174,7 +174,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp)
 		 * For 4- to 5-level paging transition, set up current CR3 as
 		 * the first and the only entry in a new top-level page table.
 		 */
-		trampoline_32bit[TRAMPOLINE_32BIT_PGTABLE_OFFSET] = __native_read_cr3() | _PAGE_TABLE_NOENC;
+		*trampoline_32bit = __native_read_cr3() | _PAGE_TABLE_NOENC;
 	} else {
 		unsigned long src;
 
@@ -187,8 +187,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp)
 		 * may be above 4G.
 		 */
 		src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
-		memcpy(trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long),
-		       (void *)src, PAGE_SIZE);
+		memcpy(trampoline_32bit, (void *)src, PAGE_SIZE);
 	}
 
 	toggle_la57(trampoline_32bit);
@@ -198,7 +197,7 @@ void cleanup_trampoline(void *pgtable)
 {
 	void *trampoline_pgtable;
 
-	trampoline_pgtable = trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long);
+	trampoline_pgtable = trampoline_32bit;
 
 	/*
 	 * Move the top level page table out of trampoline memory,
