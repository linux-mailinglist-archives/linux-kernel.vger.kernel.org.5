Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA32376D01B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjHBOd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjHBOdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:33:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6798E19B0;
        Wed,  2 Aug 2023 07:33:18 -0700 (PDT)
Date:   Wed, 02 Aug 2023 14:33:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690986796;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pah/arar9NtcS7UbPidywH94kx8HEMnQMVyR6NuD98w=;
        b=hfZeeLXWDdBK/tWgk3Ft359Z3bpUifeYdtRXplcHkurCMqxHGRrERvAoDVkmQ9vxA87scb
        0yr8gORFLfwjTeXcaGZrEfRLFagzz66XVVXWEVZPuRdnnBBsN6irL5gSG+fPYcWHMUAxyK
        PBdmWrKPhRekucd3zr61f1p0T/Z5o9fZK8RIodnJaRLoBYtlueHGiR+PQ99BsP/cpNl8Hj
        qCew/wVzGifg1z86hNAGe7AQN244CJarq2t79HOY1p07M3bX1iOKIR9+4hbjC1i7R/QRHI
        AEvRbOrhmBEJqlQ9yvHG44NexwYhW8n5DPtBxR2OinqLXbf/YStFhsQTrk5Z+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690986796;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pah/arar9NtcS7UbPidywH94kx8HEMnQMVyR6NuD98w=;
        b=CVn1n/xyCGLuxybIe8G+5w0u3iYNsRijvNrYrvHgsUxRqBjoWhD+zZn4n1B7QNw4ZvIfms
        XMODNHzBNYPh0ABQ==
From:   "tip-bot2 for Petr Pavlu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/retpoline,kprobes: Skip optprobe check for
 indirect jumps with retpolines and IBT
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230711091952.27944-3-petr.pavlu@suse.com>
References: <20230711091952.27944-3-petr.pavlu@suse.com>
MIME-Version: 1.0
Message-ID: <169098679555.28540.9078901836593234321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     029239c5b0e6484e4443be90e5664fd0bf0f066b
Gitweb:        https://git.kernel.org/tip/029239c5b0e6484e4443be90e5664fd0bf0f066b
Author:        Petr Pavlu <petr.pavlu@suse.com>
AuthorDate:    Tue, 11 Jul 2023 11:19:52 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Aug 2023 16:27:08 +02:00

x86/retpoline,kprobes: Skip optprobe check for indirect jumps with retpolines and IBT

The kprobes optimization check can_optimize() calls
insn_is_indirect_jump() to detect indirect jump instructions in
a target function. If any is found, creating an optprobe is disallowed
in the function because the jump could be from a jump table and could
potentially land in the middle of the target optprobe.

With retpolines, insn_is_indirect_jump() additionally looks for calls to
indirect thunks which the compiler potentially used to replace original
jumps. This extra check is however unnecessary because jump tables are
disabled when the kernel is built with retpolines. The same is currently
the case with IBT.

Based on this observation, remove the logic to look for calls to
indirect thunks and skip the check for indirect jumps altogether if the
kernel is built with retpolines or IBT. Remove subsequently the symbols
__indirect_thunk_start and __indirect_thunk_end which are no longer
needed.

Dropping this logic indirectly fixes a problem where the range
[__indirect_thunk_start, __indirect_thunk_end] wrongly included also the
return thunk. It caused that machines which used the return thunk as
a mitigation and didn't have it patched by any alternative ended up not
being able to use optprobes in any regular function.

Fixes: 0b53c374b9ef ("x86/retpoline: Use -mfunction-return")
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20230711091952.27944-3-petr.pavlu@suse.com
---
 arch/x86/include/asm/nospec-branch.h |  3 +--
 arch/x86/kernel/kprobes/opt.c        | 40 ++++++++++-----------------
 arch/x86/kernel/vmlinux.lds.S        |  2 +-
 tools/perf/util/thread-stack.c       |  4 +---
 4 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 1a65cf4..db460e6 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -465,9 +465,6 @@ enum ssb_mitigation {
 	SPEC_STORE_BYPASS_SECCOMP,
 };
 
-extern char __indirect_thunk_start[];
-extern char __indirect_thunk_end[];
-
 static __always_inline
 void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
 {
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 57b0037..517821b 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -226,7 +226,7 @@ static int copy_optimized_instructions(u8 *dest, u8 *src, u8 *real)
 }
 
 /* Check whether insn is indirect jump */
-static int __insn_is_indirect_jump(struct insn *insn)
+static int insn_is_indirect_jump(struct insn *insn)
 {
 	return ((insn->opcode.bytes[0] == 0xff &&
 		(X86_MODRM_REG(insn->modrm.value) & 6) == 4) || /* Jump */
@@ -260,26 +260,6 @@ static int insn_jump_into_range(struct insn *insn, unsigned long start, int len)
 	return (start <= target && target <= start + len);
 }
 
-static int insn_is_indirect_jump(struct insn *insn)
-{
-	int ret = __insn_is_indirect_jump(insn);
-
-#ifdef CONFIG_RETPOLINE
-	/*
-	 * Jump to x86_indirect_thunk_* is treated as an indirect jump.
-	 * Note that even with CONFIG_RETPOLINE=y, the kernel compiled with
-	 * older gcc may use indirect jump. So we add this check instead of
-	 * replace indirect-jump check.
-	 */
-	if (!ret)
-		ret = insn_jump_into_range(insn,
-				(unsigned long)__indirect_thunk_start,
-				(unsigned long)__indirect_thunk_end -
-				(unsigned long)__indirect_thunk_start);
-#endif
-	return ret;
-}
-
 /* Decode whole function to ensure any instructions don't jump into target */
 static int can_optimize(unsigned long paddr)
 {
@@ -334,9 +314,21 @@ static int can_optimize(unsigned long paddr)
 		/* Recover address */
 		insn.kaddr = (void *)addr;
 		insn.next_byte = (void *)(addr + insn.length);
-		/* Check any instructions don't jump into target */
-		if (insn_is_indirect_jump(&insn) ||
-		    insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
+		/*
+		 * Check any instructions don't jump into target, indirectly or
+		 * directly.
+		 *
+		 * The indirect case is present to handle a code with jump
+		 * tables. When the kernel uses retpolines, the check should in
+		 * theory additionally look for jumps to indirect thunks.
+		 * However, the kernel built with retpolines or IBT has jump
+		 * tables disabled so the check can be skipped altogether.
+		 */
+		if (!IS_ENABLED(CONFIG_RETPOLINE) &&
+		    !IS_ENABLED(CONFIG_X86_KERNEL_IBT) &&
+		    insn_is_indirect_jump(&insn))
+			return 0;
+		if (insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
 					 DISP32_SIZE))
 			return 0;
 		addr += insn.length;
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index a4cd04c..dd5b0a6 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -133,9 +133,7 @@ SECTIONS
 		KPROBES_TEXT
 		SOFTIRQENTRY_TEXT
 #ifdef CONFIG_RETPOLINE
-		__indirect_thunk_start = .;
 		*(.text..__x86.*)
-		__indirect_thunk_end = .;
 #endif
 		STATIC_CALL_TEXT
 
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 374d142..c6a0a27 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -1038,9 +1038,7 @@ static int thread_stack__trace_end(struct thread_stack *ts,
 
 static bool is_x86_retpoline(const char *name)
 {
-	const char *p = strstr(name, "__x86_indirect_thunk_");
-
-	return p == name || !strcmp(name, "__indirect_thunk_start");
+	return strstr(name, "__x86_indirect_thunk_") == name;
 }
 
 /*
