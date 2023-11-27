Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A207FA1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjK0ODP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjK0OBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:01:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECAE2D40
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:57:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BF8C433C7;
        Mon, 27 Nov 2023 13:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701093466;
        bh=laXiPq6pCZezVsgqy2AbYoST02LKOiIN00hspmTWaV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mjl1gU6E/H4SivudDYeoneFcQjDJLVwxkwxIB9sH92a8mwKwj4fGQiTQNOHHDC3tu
         J0P+AoSuDghoMThhLLoWMMxQw5jaEWhi5zj8N9bzLZy2IFSwzFhzFZqhU+BWNR2zfi
         mCQme+LXphmTC9L6W+akPXsWajpZfajpiqNsSPHl/W2PhMPyI0i2nhsjV/Qcvp4S/v
         qsNYBw3iHERLhrXwbdiLtqXY+/dZqDGRnQPxA4L+LMVNYcDaq23KhbVNja/lpr7SWK
         9kXStCyPUn1fmeQMOG6iRXO62PL3tWoN9iOJEY5WkHAMp81fPUZdA+DJXBUDCtfc0A
         kpQ3oqJhOwciA==
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
Subject: [PATCH v3 23/33] arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Date:   Mon, 27 Nov 2023 22:57:40 +0900
Message-Id: <170109345963.343914.8985762897942714493.stgit@devnote2>
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

Enable CONFIG_HAVE_FUNCTION_GRAPH_FREGS on arm64. Note that this
depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS which is enabled if the
compiler supports "-fpatchable-function-entry=2". If not, it
continue to use ftrace_ret_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
   - Newly added.
---
 arch/arm64/Kconfig               |    2 ++
 arch/arm64/include/asm/ftrace.h  |    6 ++++++
 arch/arm64/kernel/entry-ftrace.S |   28 ++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 78f20e632712..373f6e113141 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -192,6 +192,8 @@ config ARM64
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
 		if $(cc-option,-fpatchable-function-entry=2)
+	select HAVE_FUNCTION_GRAPH_FREGS \
+		if HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
 		if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index ab158196480c..efd5dbf74dd6 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -131,6 +131,12 @@ ftrace_regs_set_return_value(struct ftrace_regs *fregs,
 	fregs->regs[0] = ret;
 }
 
+static __always_inline unsigned long
+ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
+{
+	return fregs->fp;
+}
+
 static __always_inline void
 ftrace_override_function_with_return(struct ftrace_regs *fregs)
 {
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index f0c16640ef21..d87ccdb9e678 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -328,6 +328,33 @@ SYM_FUNC_END(ftrace_stub_graph)
  * Run ftrace_return_to_handler() before going back to parent.
  * @fp is checked against the value passed by ftrace_graph_caller().
  */
+#ifdef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
+SYM_CODE_START(return_to_handler)
+	/* save ftrace_regs except for PC */
+	sub	sp, sp, #FREGS_SIZE
+	stp	x0, x1, [sp, #FREGS_X0]
+	stp	x2, x3, [sp, #FREGS_X2]
+	stp	x4, x5, [sp, #FREGS_X4]
+	stp	x6, x7, [sp, #FREGS_X6]
+	str	x8,     [sp, #FREGS_X8]
+	str	x29, [sp, #FREGS_FP]
+	str	x9,  [sp, #FREGS_LR]
+	str	x10, [sp, #FREGS_SP]
+
+	mov	x0, sp
+	bl	ftrace_return_to_handler	// addr = ftrace_return_to_hander(fregs);
+	mov	x30, x0				// restore the original return address
+
+	/* restore return value regs */
+	ldp x0, x1, [sp, #FREGS_X0]
+	ldp x2, x3, [sp, #FREGS_X2]
+	ldp x4, x5, [sp, #FREGS_X4]
+	ldp x6, x7, [sp, #FREGS_X6]
+	add sp, sp, #FREGS_SIZE
+
+	ret
+SYM_CODE_END(return_to_handler)
+#else /* !CONFIG_HAVE_FUNCTION_GRAPH_FREGS */
 SYM_CODE_START(return_to_handler)
 	/* save return value regs */
 	sub sp, sp, #FGRET_REGS_SIZE
@@ -350,4 +377,5 @@ SYM_CODE_START(return_to_handler)
 
 	ret
 SYM_CODE_END(return_to_handler)
+#endif /* CONFIG_HAVE_FUNCTION_GRAPH_FREGS */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */

