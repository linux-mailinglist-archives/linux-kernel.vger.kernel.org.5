Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516FC77B5D8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjHNKAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbjHNKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:00:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E2BE63;
        Mon, 14 Aug 2023 03:00:26 -0700 (PDT)
Date:   Mon, 14 Aug 2023 10:00:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692007224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7yubJp/iJHeJZOGuTsfDsCZmWOOrPsxtOO4LmR2Irfw=;
        b=Act1Bkvs/tenQlVBTrT/gzWR/wC1rNRVApjOo6e4bnIwKs3+UyWq8iSaIS8GQnHjdGLROz
        9qBUn9uWqREgNr34rbChMYmmvvxOzp9LprCqEFmH7dmNoMtuTwf9qDZOO/WGETC1BO/6H4
        DiZSrbAPdzjV7SO+aknkutzgGNSi+A7jyGCB9MRnu+dkPDdgJXrmBhnSvp6lFRU9+9Of/p
        Hvcn2kVIV4L5A1ANIuB35VsLybB4b9J47t+cO8625gwM5H4ILxdxiyHELQ4su9Tzq51fqq
        KWiDHlhXXALrcjvudhatonlrDN87ui+ddL6e/kqTKPZkLDxzHqdxDT4AyNgLkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692007224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7yubJp/iJHeJZOGuTsfDsCZmWOOrPsxtOO4LmR2Irfw=;
        b=XC7RKdTZSjrdW5iuRiybjlICjHenwup+nRgQhX3NQXshsVVZdlv3d2S0HqX90b0EBtYJEc
        BfcPyfbaj4zAHKCQ==
From:   "tip-bot2 for Petr Pavlu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/retpoline,kprobes: Skip optprobe check for
 indirect jumps with retpolines and IBT
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230711091952.27944-3-petr.pavlu@suse.com>
References: <20230711091952.27944-3-petr.pavlu@suse.com>
MIME-Version: 1.0
Message-ID: <169200722405.27769.5064998979687602839.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     833fd800bf56b74d39d71d3f5936dffb3e0409c6
Gitweb:        https://git.kernel.org/tip/833fd800bf56b74d39d71d3f5936dffb3e0409c6
Author:        Petr Pavlu <petr.pavlu@suse.com>
AuthorDate:    Tue, 11 Jul 2023 11:19:52 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 14 Aug 2023 11:46:51 +02:00

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
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20230711091952.27944-3-petr.pavlu@suse.com
---
 arch/x86/include/asm/nospec-branch.h |  3 +--
 arch/x86/kernel/kprobes/opt.c        | 40 ++++++++++-----------------
 arch/x86/kernel/vmlinux.lds.S        |  2 +-
 tools/perf/util/thread-stack.c       |  4 +---
 4 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 3faf044..e50db53 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -478,9 +478,6 @@ enum ssb_mitigation {
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
index dfb8783..8e2a306 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -133,10 +133,8 @@ SECTIONS
 		KPROBES_TEXT
 		SOFTIRQENTRY_TEXT
 #ifdef CONFIG_RETPOLINE
-		__indirect_thunk_start = .;
 		*(.text..__x86.indirect_thunk)
 		*(.text..__x86.return_thunk)
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
