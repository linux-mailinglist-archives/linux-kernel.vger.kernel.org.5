Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6277575C2D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjGUJVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjGUJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:20:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BAD2D57;
        Fri, 21 Jul 2023 02:20:57 -0700 (PDT)
Date:   Fri, 21 Jul 2023 09:20:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689931255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lnSn0ECivsr7eEcD2ltZgdffvBPmL6Z4J6rcVRb2slo=;
        b=qFa3SmpnufMsfmk97ue4xwhxkkjwhLhWoBDYGFS50GhnIdz5i0OS/jFBdDyovnm5wzxDgq
        MSzVXMcL/RiIhg2jh5yeam/uXOX/NQ0pclZUbNWMC8m4yADjfBtlbbqRJZlQDNSjciIuNt
        0g2QOtEF5Pk9YE/0p1lADltzh0SVDo1YNL95QeHiPMTDEgm6ggiVBxxTFCJttz1I7xW511
        zdHjErwgwymDUQtb5osrw6R+72MyHfYUIAGCVSo6CiEeU4ImJhhWBymlgmtweCUlXn520d
        H+vH/tfJTNKmznTilyTWUf7RvJXeC0JfG5dfvVtZSOU/Jf0yRd/zyRrDeHsTHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689931255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lnSn0ECivsr7eEcD2ltZgdffvBPmL6Z4J6rcVRb2slo=;
        b=jEsxa6cHpQgPde3U7UwP5rO4fNg9DuTc4UbcZJBARNeT49ovoMX4N0P9cOhAiBgXPGPHAo
        XVW9r0VY2oD5dwDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86: Fix kthread unwind
Cc:     Petr Mladek <pmladek@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230719201538.GA3553016@hirez.programming.kicks-ass.net>
References: <20230719201538.GA3553016@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <168993125450.28540.2663691700893492367.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2e7e5bbb1c3c8d502edeb5c0670eac4995134b6f
Gitweb:        https://git.kernel.org/tip/2e7e5bbb1c3c8d502edeb5c0670eac4995134b6f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 19 Jul 2023 22:15:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Jul 2023 23:03:50 +02:00

x86: Fix kthread unwind

The rewrite of ret_from_form() misplaced an unwind hint which caused
all kthread stack unwinds to be marked unreliable, breaking
livepatching.

Restore the annotation and add a comment to explain the how and why of
things.

Fixes: 3aec4ecb3d1f ("x86: Rewrite ret_from_fork() in C")
Reported-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Petr Mladek <pmladek@suse.com>
Link: https://lkml.kernel.org/r/20230719201538.GA3553016@hirez.programming.kicks-ass.net
---
 arch/x86/entry/entry_64.S | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 91f6818..43606de 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -285,7 +285,15 @@ SYM_FUNC_END(__switch_to_asm)
  */
 .pushsection .text, "ax"
 SYM_CODE_START(ret_from_fork_asm)
-	UNWIND_HINT_REGS
+	/*
+	 * This is the start of the kernel stack; even through there's a
+	 * register set at the top, the regset isn't necessarily coherent
+	 * (consider kthreads) and one cannot unwind further.
+	 *
+	 * This ensures stack unwinds of kernel threads terminate in a known
+	 * good state.
+	 */
+	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR // copy_thread
 	CALL_DEPTH_ACCOUNT
 
@@ -295,6 +303,12 @@ SYM_CODE_START(ret_from_fork_asm)
 	movq	%r12, %rcx		/* fn_arg */
 	call	ret_from_fork
 
+	/*
+	 * Set the stack state to what is expected for the target function
+	 * -- at this point the register set should be a valid user set
+	 * and unwind should work normally.
+	 */
+	UNWIND_HINT_REGS
 	jmp	swapgs_restore_regs_and_return_to_usermode
 SYM_CODE_END(ret_from_fork_asm)
 .popsection
