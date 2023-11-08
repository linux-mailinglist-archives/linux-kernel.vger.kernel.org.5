Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773757E58E4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343927AbjKHO3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjKHO2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:28:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3E3213B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:28:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A424C433C8;
        Wed,  8 Nov 2023 14:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699453709;
        bh=G3M7rbLjDgrYIoVpHOxqlUDZWOOF6wiqlb0+xA/Zo8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBc2p8Oovhos6kzYacPKsTG2cNxhxOf8Zc9rKcUW5GN5AHQLo8RjtjINvAETh0q6G
         7L1hdzBjsdJUvpWoFoOqRFMth+slPDl0CKH39BBf7/lrTNEp7Q13ZI/MWjqIH7gv1l
         6orjGNmYalsNsgRNFjwA5tGGGGgPHXRAsvATWYc3TOhGgGoh2+mMrpi4cTJRNyfX/L
         /8f1wRO2HxRUua3LjREkEPer52K25ScmIJJdCxQ8LMhBUNwihl14mMdDIRr02KoM9Z
         g81tT2GZ9RBIYxEQZNc+Dk8Epnkrb0xZBu2A45FMsu/yBCTFAH/CyHSR/NCAHlj7t/
         FquFR4zRAVsCw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH v2 21/31] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Date:   Wed,  8 Nov 2023 23:28:23 +0900
Message-Id: <169945370304.55307.2480628822573420604.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169945345785.55307.5003201137843449313.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Support HAVE_FUNCTION_GRAPH_FREGS on x86-64, which saves ftrace_regs
on the stack in ftrace_graph return trampoline so that the callbacks
can access registers via ftrace_regs APIs.

Note that this only recovers 'rax' and 'rdx' registers because other
registers are not used anymore and recovered by caller. 'rax' and
'rdx' will be used for passing the return value.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Save rsp register and drop clearing orig_ax.
---
 arch/x86/Kconfig            |    3 ++-
 arch/x86/kernel/ftrace_64.S |   36 ++++++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfabae8814..4b4c2f9d67da 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -219,7 +219,8 @@ config X86
 	select HAVE_FAST_GUP
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
-	select HAVE_FUNCTION_GRAPH_RETVAL	if HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_FREGS	if HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_FUNCTION_GRAPH_RETVAL	if !HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_FUNCTION_GRAPH_TRACER	if X86_32 || (X86_64 && DYNAMIC_FTRACE)
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 945cfa5f7239..029b0e3a0206 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -348,21 +348,41 @@ STACK_FRAME_NON_STANDARD_FP(__fentry__)
 SYM_CODE_START(return_to_handler)
 	UNWIND_HINT_UNDEFINED
 	ANNOTATE_NOENDBR
-	subq  $24, %rsp
+	/*
+	 * Save the registers requires for ftrace_regs;
+	 * rax, rcx, rdx, rdi, rsi, r8, r9 and rbp
+	 */
+	subq $(FRAME_SIZE), %rsp
+	movq %rax, RAX(%rsp)
+	movq %rcx, RCX(%rsp)
+	movq %rdx, RDX(%rsp)
+	movq %rsi, RSI(%rsp)
+	movq %rdi, RDI(%rsp)
+	movq %r8, R8(%rsp)
+	movq %r9, R9(%rsp)
+	movq %rbp, RBP(%rsp)
+	/*
+	 * orig_ax is not cleared because it is used for indicating the direct
+	 * trampoline in the fentry.
+	 */
+
+	leaq FRAME_SIZE(%rsp), %rcx
+	movq %rcx, RSP(%rsp)
 
-	/* Save the return values */
-	movq %rax, (%rsp)
-	movq %rdx, 8(%rsp)
-	movq %rbp, 16(%rsp)
 	movq %rsp, %rdi
 
 	call ftrace_return_to_handler
 
 	movq %rax, %rdi
-	movq 8(%rsp), %rdx
-	movq (%rsp), %rax
 
-	addq $24, %rsp
+	/*
+	 * Restore only rax and rdx because other registers are not used
+	 * for return value nor callee saved. Caller will reuse/recover it.
+	 */
+	movq RDX(%rsp), %rdx
+	movq RAX(%rsp), %rax
+
+	addq $(FRAME_SIZE), %rsp
 	/*
 	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
 	 * since IBT would demand that contain ENDBR, which simply isn't so for

