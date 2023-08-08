Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2908E773ED3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjHHQgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjHHQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:35:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CD335DC1;
        Tue,  8 Aug 2023 08:52:51 -0700 (PDT)
Date:   Tue, 08 Aug 2023 08:44:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691484241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSomEIAachQ7hlzJzMtpmy/kU1NReD4unTg1WOyRGHk=;
        b=bn4ArOdNWnvtrvnHfyt08RvipADUH7k5MLyy6cX+RD1o9/A7EB/K2ofXRlRYyli2yrTZ/k
        MelHssByOppQ0YJt6wl69yr9LqY+NfuuuNuv1dPc7AQy4hOEDo+pMLGzWviDw1/24RVmqM
        eKQT2XGXYxippBTkXtfQJ6/KaeywYyboO9Fx8sgmSbjxz/7JrtPhfLxzce1thB77qCbZOG
        +bM0+KM5e+lJdeS9nN8OhSCyVrs7j1X3d43ZqfTPp1KCNJfj/ZKlNH6TZkOuOIB92VUigR
        NkZ23YIiWfJW5OgBSGF5xuuwu3gQ0DrXSaPIh1abF3OchZ6huzT/c78MvTijaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691484241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSomEIAachQ7hlzJzMtpmy/kU1NReD4unTg1WOyRGHk=;
        b=WLuDD3g638eHpmlReioL+S3rJxKMpxaOWxcJLdKUtsBFUnjmeSdDOhM8HKN0eYgKBc4a61
        XRjr8Mxh1rTVmvDA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/decompressor: Merge trampoline cleanup with
 switching code
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230807162720.545787-16-ardb@kernel.org>
References: <20230807162720.545787-16-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <169148424124.27769.10780306981470418847.tip-bot2@tip-bot2>
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

Commit-ID:     03dda95137d3247564854ad9032c0354273a159d
Gitweb:        https://git.kernel.org/tip/03dda95137d3247564854ad9032c0354273a159d
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Aug 2023 18:27:12 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Aug 2023 20:51:17 +02:00

x86/decompressor: Merge trampoline cleanup with switching code

Now that the trampoline setup code and the actual invocation of it are
all done from the C routine, the trampoline cleanup can be merged into
it as well, instead of returning to asm just to call another C function.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20230807162720.545787-16-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S    | 14 ++++----------
 arch/x86/boot/compressed/pgtable_64.c | 18 ++++--------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index afdaf8c..fb0e562 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -430,20 +430,14 @@ SYM_CODE_START(startup_64)
 	 * a trampoline in 32-bit addressable memory if the current number does
 	 * not match the desired number.
 	 *
-	 * Pass the boot_params pointer as the first argument.
+	 * Pass the boot_params pointer as the first argument. The second
+	 * argument is the relocated address of the page table to use instead
+	 * of the page table in trampoline memory (if required).
 	 */
 	movq	%r15, %rdi
+	leaq	rva(top_pgtable)(%rbx), %rsi
 	call	configure_5level_paging
 
-	/*
-	 * cleanup_trampoline() would restore trampoline memory.
-	 *
-	 * RDI is address of the page table to use instead of page table
-	 * in trampoline memory (if required).
-	 */
-	leaq	rva(top_pgtable)(%rbx), %rdi
-	call	cleanup_trampoline
-
 	/* Zero EFLAGS */
 	pushq	$0
 	popfq
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index eab4e6b..7939eb6 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -101,7 +101,7 @@ static unsigned long find_trampoline_placement(void)
 	return bios_start - TRAMPOLINE_32BIT_SIZE;
 }
 
-asmlinkage void configure_5level_paging(struct boot_params *bp)
+asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 {
 	void (*toggle_la57)(void *cr3);
 	bool l5_required = false;
@@ -191,22 +191,12 @@ asmlinkage void configure_5level_paging(struct boot_params *bp)
 	}
 
 	toggle_la57(trampoline_32bit);
-}
-
-void cleanup_trampoline(void *pgtable)
-{
-	void *trampoline_pgtable;
-
-	trampoline_pgtable = trampoline_32bit;
 
 	/*
-	 * Move the top level page table out of trampoline memory,
-	 * if it's there.
+	 * Move the top level page table out of trampoline memory.
 	 */
-	if ((void *)__native_read_cr3() == trampoline_pgtable) {
-		memcpy(pgtable, trampoline_pgtable, PAGE_SIZE);
-		native_write_cr3((unsigned long)pgtable);
-	}
+	memcpy(pgtable, trampoline_32bit, PAGE_SIZE);
+	native_write_cr3((unsigned long)pgtable);
 
 	/* Restore trampoline memory */
 	memcpy(trampoline_32bit, trampoline_save, TRAMPOLINE_32BIT_SIZE);
