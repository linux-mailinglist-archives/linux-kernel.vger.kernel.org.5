Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53C67F2DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjKUNEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjKUNEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:04:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CC8D54;
        Tue, 21 Nov 2023 05:04:04 -0800 (PST)
Date:   Tue, 21 Nov 2023 13:04:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700571842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vq3mp3VVlbiGiCUiKGAqxyw/3QBEwu1d5DThRFVhkC8=;
        b=bHS0PTTevS2/7YV7KIHlD3P7E7QJcwQw2yR4dfdlHYZrbVraDW+Oo3/YqAxkn4DFyhzTYF
        biJwC1V6dyu7HQ1KgJwo/ZHLGDPLPcwlGtCab0XuELuTXmaA2uFlpPlBe0P3bPMprv2d4h
        JcpaKIITDzREWRaDy/3U2MG/hq24c+xltewfQyW/TItCOQgmC4huBNgJOVGuU++U2lfSoi
        GnBLXoJjodoKOKp6Ms3oHBhVvN+vagPpS2cpIw9nIDH22j807QZMLH7u8HOtkXAlbISLu/
        6YTcDUuX4UuxaKLD5Y8q/eFwLu9Qev21ARTte+QWhr1VGUO214AgnJof7krG5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700571842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vq3mp3VVlbiGiCUiKGAqxyw/3QBEwu1d5DThRFVhkC8=;
        b=hh9Qu4h9TDSkoFIWm8B74rwTyFGmCXwzQ2FzDF1pNPVRs6MmUbKfAUuLD2w8hujSf4wnrd
        /XJk1kod2RRstcDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Optimize common_interrupt_return()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120143626.638107480@infradead.org>
References: <20231120143626.638107480@infradead.org>
MIME-Version: 1.0
Message-ID: <170057184198.398.10194594429929992769.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     c516213726fb572700cce4a5909aa8d82b77192a
Gitweb:        https://git.kernel.org/tip/c516213726fb572700cce4a5909aa8d82b77192a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 20 Nov 2023 15:33:45 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 21 Nov 2023 13:57:30 +01:00

x86/entry: Optimize common_interrupt_return()

The code in common_interrupt_return() does a bunch of unconditional
work that is really only needed on PTI kernels. Specifically it
unconditionally copies the IRET frame back onto the entry stack,
swizzles onto the entry stack and does IRET from there.

However, without PTI we can simply IRET from whatever stack we're on.

  ivb-ep, mitigations=off, gettid-1m:

  PRE:
       140,118,538      cycles:k                                                      ( +-  0.01% )
       236,692,878      instructions:k            #    1.69  insn per cycle           ( +-  0.00% )

  POST:
       140,026,608      cycles:k                                                      ( +-  0.01% )
       236,696,176      instructions:k            #    1.69  insn per cycle           ( +-  0.00% )

(this is with --repeat 100 and the run-to-run variance is bigger than
the difference shown)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231120143626.638107480@infradead.org
---
 arch/x86/entry/calling.h  | 12 +++++++++---
 arch/x86/entry/entry_64.S | 17 +++++++++++++++--
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index f690762..9f1d947 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -175,8 +175,7 @@ For 32-bit we have the following conventions - kernel is built with
 #define THIS_CPU_user_pcid_flush_mask   \
 	PER_CPU_VAR(cpu_tlbstate) + TLB_STATE_user_pcid_flush_mask
 
-.macro SWITCH_TO_USER_CR3_NOSTACK scratch_reg:req scratch_reg2:req
-	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
+.macro SWITCH_TO_USER_CR3 scratch_reg:req scratch_reg2:req
 	mov	%cr3, \scratch_reg
 
 	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
@@ -206,13 +205,20 @@ For 32-bit we have the following conventions - kernel is built with
 	/* Flip the PGD to the user version */
 	orq     $(PTI_USER_PGTABLE_MASK), \scratch_reg
 	mov	\scratch_reg, %cr3
+.endm
+
+.macro SWITCH_TO_USER_CR3_NOSTACK scratch_reg:req scratch_reg2:req
+	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
+	SWITCH_TO_USER_CR3 \scratch_reg \scratch_reg2
 .Lend_\@:
 .endm
 
 .macro SWITCH_TO_USER_CR3_STACK	scratch_reg:req
+	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
 	pushq	%rax
-	SWITCH_TO_USER_CR3_NOSTACK scratch_reg=\scratch_reg scratch_reg2=%rax
+	SWITCH_TO_USER_CR3 scratch_reg=\scratch_reg scratch_reg2=%rax
 	popq	%rax
+.Lend_\@:
 .endm
 
 .macro SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg:req save_reg:req
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index de6469d..dfbf799 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -569,7 +569,18 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 #ifdef CONFIG_XEN_PV
 	ALTERNATIVE "", "jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 #endif
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	ALTERNATIVE "", "jmp .Lpti_restore_regs_and_return_to_usermode", X86_FEATURE_PTI
+#endif
+
+	STACKLEAK_ERASE
+	POP_REGS
+	add	$8, %rsp	/* orig_ax */
+	swapgs
+	jmp	.Lnative_iret
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+.Lpti_restore_regs_and_return_to_usermode:
 	POP_REGS pop_rdi=0
 
 	/*
@@ -596,13 +607,15 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	 */
 	STACKLEAK_ERASE_NOCLOBBER
 
-	SWITCH_TO_USER_CR3_STACK scratch_reg=%rdi
+	push	%rax
+	SWITCH_TO_USER_CR3 scratch_reg=%rdi scratch_reg2=%rax
+	pop	%rax
 
 	/* Restore RDI. */
 	popq	%rdi
 	swapgs
 	jmp	.Lnative_iret
-
+#endif
 
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY
