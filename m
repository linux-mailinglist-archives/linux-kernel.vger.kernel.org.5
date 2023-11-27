Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0674E7FA1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjK0OBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjK0OA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:00:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263E42701
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:57:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92A8C43142;
        Mon, 27 Nov 2023 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701093441;
        bh=5BNVBB7peZKxOYYyHONtdZrMFDGpcSDPvsIQ08LtrvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tc1U8C8BCNN5UzRem7hdSm4O98H/yFk/QaKBcxjKhB4Y15Ed35bD5P1DcNtu7Ly7L
         yDFDZM5DkWfQNzsY818YkfJMK4+lW1sEppUvuPGc7SneWKamDbU4hKW0Dzb1Bk/3yf
         ejFzvhMVB+8MDzkAzj2JqpeJgGQZFgRlcQY2hQ0KQv9jy8t+chs3E4F2Zq98+2dfla
         MHOPRV7nFL7fVmSxa69OyO9ke4gqW6ttpsfLK0C9pJj/1cA1gKjugk7V75VG2D+5/7
         67cT19Igd4Vk0yODvBs6w8akuKyDEgi0fwnkLUTTEAV5yLWendJUvwysvzAhqnS9fu
         29nl/Z1FmT++A==
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
Subject: [PATCH v3 21/33] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Date:   Mon, 27 Nov 2023 22:57:15 +0900
Message-Id: <170109343500.343914.8822279017262195121.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170109317214.343914.4784420430328654397.stgit@devnote2>
References: <170109317214.343914.4784420430328654397.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 Changes in v3:
  - Add a comment about rip.
 Changes in v2:
  - Save rsp register and drop clearing orig_ax.
---
 arch/x86/Kconfig            |    3 ++-
 arch/x86/kernel/ftrace_64.S |   37 +++++++++++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 9 deletions(-)

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
index 945cfa5f7239..89a479f0c332 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -348,21 +348,42 @@ STACK_FRAME_NON_STANDARD_FP(__fentry__)
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
+	 * trampoline in the fentry. And rip is not set because we don't know
+	 * the correct return address here.
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

