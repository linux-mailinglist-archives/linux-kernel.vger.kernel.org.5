Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1F07F15D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjKTOiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjKTOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:37:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3EA112
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=d5XfGL+IrDak//xTR1WiSXXdLz5PwCMSAL7n3tlPN8o=; b=SJQGJytk1fKS8n/+Ta28Kl7DBA
        N6y0osVoOkoHKZ9ODHFh0IrauX/uyuoK0Mvx+Fg+VQta3h4oGY2eJj3oU2kZ8IMLtBoLCwKLDkV7q
        qGHIjHN4vhag1fD48fsJXZLRCnjA3lb6oQWp2s9PM2TY9cmYVxtjWQzd902OrY8NxVdFY0FFpi5q6
        r3xWR3NBT7C4+ofHYBbLPXxui+N7CDGcUjHwFgwtCYSWxROfPxTQpvRfUku79ETTBNg9imBw2o8z4
        8OmqmYTZxN2HFJhhSvqmFsxBI3raHZN8WKN11TYINAyeD+oixoLP+zri+BP1FZ+m7KM6vLSor8hzd
        efcttDsw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r55PM-00B09z-1p;
        Mon, 20 Nov 2023 14:37:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id D107B3004E3; Mon, 20 Nov 2023 15:37:51 +0100 (CET)
Message-Id: <20231120143626.638107480@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 20 Nov 2023 15:33:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 1/2] x86/entry: Optimize common_interrupt_return()
References: <20231120143344.584345121@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/entry/calling.h  |   12 +++++++++---
 arch/x86/entry/entry_64.S |   17 +++++++++++++++--
 2 files changed, 24 insertions(+), 5 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -175,8 +175,7 @@ For 32-bit we have the following convent
 #define THIS_CPU_user_pcid_flush_mask   \
 	PER_CPU_VAR(cpu_tlbstate + TLB_STATE_user_pcid_flush_mask)
 
-.macro SWITCH_TO_USER_CR3_NOSTACK scratch_reg:req scratch_reg2:req
-	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
+.macro SWITCH_TO_USER_CR3 scratch_reg:req scratch_reg2:req
 	mov	%cr3, \scratch_reg
 
 	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
@@ -206,13 +205,20 @@ For 32-bit we have the following convent
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
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -569,7 +569,18 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_
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
@@ -596,13 +607,15 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_
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


