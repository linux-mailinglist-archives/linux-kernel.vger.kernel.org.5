Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984557F2DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjKUNEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKUNEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:04:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577D5D52;
        Tue, 21 Nov 2023 05:04:03 -0800 (PST)
Date:   Tue, 21 Nov 2023 13:04:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700571842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WBl/px+XRB5UWETJoziXFsofH7eRQgIae/X5SAkBZMM=;
        b=faSaJPXqt/pIh32JK3jhtnN7Tm+6QyQm3iz9KIlPZgk6kmHWmJbZOc1MS6bcIOMZVUcu2S
        J1x9uIHyI/3TeI9OldglUXTeGlk97JAlxILYuSe18pjTsbmg6oeu75UNyXa7yYs8qSqlDc
        oJ/GPbH8pV0YZw+ii9H9DF3h2jDOKc8xgYytKt+pqZnbJkdrwDARqrhVRltGQ7Kr1KORvC
        pPugPXP2iUNEO7qgmQNgX1pqK2m0zppDLwnYJ0Vo7gTMMQhTypZl53zOYDMvfCP9JFOfpo
        PC+1MKOiVDyiVLdeSLmaBz7WDXeDDWtFJxcUBuXey/A5PMvtCEQZvLmYquoJbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700571842;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WBl/px+XRB5UWETJoziXFsofH7eRQgIae/X5SAkBZMM=;
        b=uQxIQs+RdqXuBnR3ap4aeur7V1qDmA4QIVX+qYDhV0WUufNrej+FYnl88DBddvmiXf4Apk
        MoF1d6f7Eh8b+xCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Harden return-to-user
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120143626.753200755@infradead.org>
References: <20231120143626.753200755@infradead.org>
MIME-Version: 1.0
Message-ID: <170057184115.398.10717080354798999392.tip-bot2@tip-bot2>
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

Commit-ID:     1e4d3001f59fb7a9917cb746544b65e616b5f809
Gitweb:        https://git.kernel.org/tip/1e4d3001f59fb7a9917cb746544b65e616b5f809
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 20 Nov 2023 15:33:46 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 21 Nov 2023 13:57:31 +01:00

x86/entry: Harden return-to-user

Make the CONFIG_DEBUG_ENTRY=y check that validates CS is a user segment
unconditional and move it nearer to IRET.

  PRE:
       140,026,608      cycles:k                                                      ( +-  0.01% )
       236,696,176      instructions:k            #    1.69  insn per cycle           ( +-  0.00% )

  POST:
       139,957,681      cycles:k                                                      ( +-  0.01% )
       236,681,819      instructions:k            #    1.69  insn per cycle           ( +-  0.00% )

(this is with --repeat 100 and the run-to-run variance is bigger than
the difference shown)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231120143626.753200755@infradead.org
---
 arch/x86/entry/entry_64.S | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index dfbf799..c40f89a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -559,13 +559,6 @@ __irqentry_text_end:
 SYM_CODE_START_LOCAL(common_interrupt_return)
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	IBRS_EXIT
-#ifdef CONFIG_DEBUG_ENTRY
-	/* Assert that pt_regs indicates user mode. */
-	testb	$3, CS(%rsp)
-	jnz	1f
-	ud2
-1:
-#endif
 #ifdef CONFIG_XEN_PV
 	ALTERNATIVE "", "jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 #endif
@@ -576,8 +569,14 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	STACKLEAK_ERASE
 	POP_REGS
 	add	$8, %rsp	/* orig_ax */
+	UNWIND_HINT_IRET_REGS
+
+.Lswapgs_and_iret:
 	swapgs
-	jmp	.Lnative_iret
+	/* Assert that the IRET frame indicates user mode. */
+	testb	$3, 8(%rsp)
+	jnz	.Lnative_iret
+	ud2
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 .Lpti_restore_regs_and_return_to_usermode:
@@ -613,8 +612,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 
 	/* Restore RDI. */
 	popq	%rdi
-	swapgs
-	jmp	.Lnative_iret
+	jmp	.Lswapgs_and_iret
 #endif
 
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
