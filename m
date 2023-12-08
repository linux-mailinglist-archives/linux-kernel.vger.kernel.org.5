Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A677180A0E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbjLHK3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjLHK3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:29:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265AE1FC4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:28:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2033C433C7;
        Fri,  8 Dec 2023 10:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702031316;
        bh=pPNJXjygt/V4vNYQ4X8NJkqM9twm0EdHZQuhceTJqsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M4lND6uY3SW66V0a116zBlvW7YKyDx2JWvKdATv15tvxVs1GXs5ibzMrf3AouWWlm
         VZWOWCEUTOmagWiyUuRHNRrYwpEFM2i8rqFUGPXtxhe9R8vuP4FuPk6DGFskiMSYdZ
         CGvTIJGqE2DFalwb9Qh8MJVZc6au4hduQkmMIEdF78R+E3QMXePZ5uhXgXJsVUnumd
         +4UTBzNiyf6godknzWaq4txBMIOe0FUd4rgCF8GlQCE+UaxYGZ3CeF/qJd4u+6Wie5
         vE2dtpOLCaYuJQSww8ynTzuiHDYocyqtb4P2ePNFWFpvGkerx7xxLW/kEF3wQRV8ps
         bug+7C7g9HEXA==
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
Subject: [PATCH v4 21/33] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Date:   Fri,  8 Dec 2023 19:28:30 +0900
Message-Id: <170203130982.579004.8630034805609766591.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170203105427.579004.8033550792660734570.stgit@devnote2>
References: <170203105427.579004.8033550792660734570.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 3762f41bb092..3b955c9e4eb6 100644
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
index 214f30e9f0c0..8a16f774604e 100644
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

