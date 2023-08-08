Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6659773E83
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjHHQbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjHHQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:29:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5C367FB;
        Tue,  8 Aug 2023 08:51:31 -0700 (PDT)
Date:   Tue, 08 Aug 2023 08:44:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691484242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMRuFvIXsVvXna/SQV0FY9XnncGUvnsoTSeMt1RWo8c=;
        b=1ACcZgWt3ukFZSjJrc7HIXpAN28daQEgcht2bQkD+s0x7LdbFwXmH2xHq3p2TTxplV5T5p
        D+KOucnUVfdjVl40q3HWwGTfZv7bbtsYnmSQl5nc0nI7PFkCQuSWknjhKDClZzr80Gq2IQ
        y4gyWu/h4XTnEup7WrybRAJbv+vzd4eqIAV0ubuymmKT+wCOEE+bcarN7Hlc96IcVxfLpw
        lHt6tC6TvpALff3DHmsg0tDSykfXumsbr98piThMpCLm0Xq5vxxEDE8bydlA6iPPdUNP02
        tGCHN5YIoV96iXbLPCBGnrbzgmNRxJxQELMMJ7jEBs4MH+FGpbemPZ4BCO2lcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691484242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMRuFvIXsVvXna/SQV0FY9XnncGUvnsoTSeMt1RWo8c=;
        b=ghVyKTk/jOBhW1gIn7UjTAR7TzEmXMlfJzOvyYac3Vj29D1dqLKn5ILHmxhEnSJaI0uwQu
        x/umSS6YWtHnx1Dw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/decompressor: Only call the trampoline when
 changing paging levels
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230807162720.545787-14-ardb@kernel.org>
References: <20230807162720.545787-14-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <169148424201.27769.12237039734397435881.tip-bot2@tip-bot2>
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

Commit-ID:     f97b67a773cd84bd8b55c0a0ec32448a87fc56bb
Gitweb:        https://git.kernel.org/tip/f97b67a773cd84bd8b55c0a0ec32448a87fc56bb
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Aug 2023 18:27:10 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Aug 2023 20:48:09 +02:00

x86/decompressor: Only call the trampoline when changing paging levels

Since the current and desired number of paging levels are known when the
trampoline is being prepared, avoid calling the trampoline at all if it
is clear that calling it is not going to result in a change to the
number of paging levels.

Given that the CPU is already running in long mode, the PAE and LA57
settings are necessarily consistent with the currently active page
tables, and other fields in CR4 will be initialized by the startup code
in the kernel proper. So limit the manipulation of CR4 to toggling the
LA57 bit, which is the only thing that really needs doing at this point
in the boot. This also means that there is no need to pass the value of
l5_required to toggle_la57(), as it will not be called unless CR4.LA57
needs to toggle.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20230807162720.545787-14-ardb@kernel.org
---
 arch/x86/boot/compressed/head_64.S    | 45 ++------------------------
 arch/x86/boot/compressed/pgtable_64.c | 22 +++++--------
 2 files changed, 13 insertions(+), 54 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index cd6e3e1..8730b1d 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -387,10 +387,6 @@ SYM_CODE_START(startup_64)
 	 * For the trampoline, we need the top page table to reside in lower
 	 * memory as we don't have a way to load 64-bit values into CR3 in
 	 * 32-bit mode.
-	 *
-	 * We go though the trampoline even if we don't have to: if we're
-	 * already in a desired paging mode. This way the trampoline code gets
-	 * tested on every boot.
 	 */
 
 	/* Make sure we have GDT with 32-bit code segment */
@@ -526,8 +522,7 @@ SYM_FUNC_END(.Lrelocated)
  *
  * Return address is at the top of the stack (might be above 4G).
  * The first argument (EDI) contains the 32-bit addressable base of the
- * trampoline memory. A non-zero second argument (ESI) means that the
- * trampoline needs to enable 5-level paging.
+ * trampoline memory.
  */
 	.section ".rodata", "a", @progbits
 SYM_CODE_START(trampoline_32bit_src)
@@ -579,25 +574,10 @@ SYM_CODE_START(trampoline_32bit_src)
 	btrl	$X86_CR0_PG_BIT, %eax
 	movl	%eax, %cr0
 
-	/* Check what paging mode we want to be in after the trampoline */
-	testl	%esi, %esi
-	jz	1f
-
-	/* We want 5-level paging: don't touch CR3 if it already points to 5-level page tables */
-	movl	%cr4, %eax
-	testl	$X86_CR4_LA57, %eax
-	jnz	3f
-	jmp	2f
-1:
-	/* We want 4-level paging: don't touch CR3 if it already points to 4-level page tables */
-	movl	%cr4, %eax
-	testl	$X86_CR4_LA57, %eax
-	jz	3f
-2:
 	/* Point CR3 to the trampoline's new top level page table */
 	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%edi), %eax
 	movl	%eax, %cr3
-3:
+
 	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
 	movl	$MSR_EFER, %ecx
 	rdmsr
@@ -606,26 +586,9 @@ SYM_CODE_START(trampoline_32bit_src)
 	jc	1f
 	wrmsr
 1:
-#ifdef CONFIG_X86_MCE
-	/*
-	 * Preserve CR4.MCE if the kernel will enable #MC support.
-	 * Clearing MCE may fault in some environments (that also force #MC
-	 * support). Any machine check that occurs before #MC support is fully
-	 * configured will crash the system regardless of the CR4.MCE value set
-	 * here.
-	 */
+	/* Toggle CR4.LA57 */
 	movl	%cr4, %eax
-	andl	$X86_CR4_MCE, %eax
-#else
-	movl	$0, %eax
-#endif
-
-	/* Enable PAE and LA57 (if required) paging modes */
-	orl	$X86_CR4_PAE, %eax
-	testl	%esi, %esi
-	jz	1f
-	orl	$X86_CR4_LA57, %eax
-1:
+	btcl	$X86_CR4_LA57_BIT, %eax
 	movl	%eax, %cr4
 
 	/* Enable paging again. */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index f9cc86b..4213473 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -103,7 +103,7 @@ static unsigned long find_trampoline_placement(void)
 
 asmlinkage void configure_5level_paging(struct boot_params *bp)
 {
-	void (*toggle_la57)(void *trampoline, bool enable_5lvl);
+	void (*toggle_la57)(void *trampoline);
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
@@ -133,6 +133,13 @@ asmlinkage void configure_5level_paging(struct boot_params *bp)
 		ptrs_per_p4d = 512;
 	}
 
+	/*
+	 * The trampoline will not be used if the paging mode is already set to
+	 * the desired one.
+	 */
+	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
+		return;
+
 	trampoline_32bit = (unsigned long *)find_trampoline_placement();
 
 	/* Preserve trampoline memory */
@@ -160,18 +167,8 @@ asmlinkage void configure_5level_paging(struct boot_params *bp)
 	 *
 	 * The new page table will be used by trampoline code for switching
 	 * from 4- to 5-level paging or vice versa.
-	 *
-	 * If switching is not required, the page table is unused: trampoline
-	 * code wouldn't touch CR3.
 	 */
 
-	/*
-	 * We are not going to use the page table in trampoline memory if we
-	 * are already in the desired paging mode.
-	 */
-	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
-		goto out;
-
 	if (l5_required) {
 		/*
 		 * For 4- to 5-level paging transition, set up current CR3 as
@@ -194,8 +191,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp)
 		       (void *)src, PAGE_SIZE);
 	}
 
-out:
-	toggle_la57(trampoline_32bit, l5_required);
+	toggle_la57(trampoline_32bit);
 }
 
 void cleanup_trampoline(void *pgtable)
