Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5981D7AC9B3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjIXNhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjIXNhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:37:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B533E40
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 06:36:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1710AC433C8;
        Sun, 24 Sep 2023 13:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695562565;
        bh=LhYnyuDASlXkoXmwCgKG/bRCaq518SQW1Kv1bqMglGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqIRRymLElY+P25kTdNjEVyJB1A9ldCYTxgORJ2fY34/Up+1xmNu/blxLvgvO5d9v
         YiLVnE8f+DqJ9TRtFd+qISOHrQMIzP3no7VHIYYfltA8O88TF9oWSzN1loDL1H8+Av
         y2pog5Q99aZxCYiO+eGs+EcZEK5QCFRKxQ1H0BoMXnKzdM7ZmuvT++GsX3E5aZ6zkP
         RcNxCFEkV5UQYuJsW4OtyYkLV7KQiGlqwJLrJvlkTB1UERoEbXgseOI6XFhvKBFitR
         O+Q57mxrGf5S2tiOPkc0LYv4MVrdrsoBejfM774lHvH+n9ZtLBCoy5+6jnf/Ar9sx+
         WlJQquCgwUxMg==
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
Subject: [PATCH v5 01/12] riscv: ftrace: Fix to pass correct ftrace_regs to ftrace_func_t functions
Date:   Sun, 24 Sep 2023 22:35:59 +0900
Message-Id: <169556255915.146934.16583650430641758878.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169556254640.146934.5654329452696494756.stgit@devnote2>
References: <169556254640.146934.5654329452696494756.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since ftrace_func_t requires to pass 'struct ftrace_regs *' as the 4th
argument even if FTRACE_OPS_FL_SAVE_REGS is not set, ftrace_caller must
pass 'struct ftrace_regs *', which is a partial pt_regs, on the stack
to the ftrace_func_t functions, so that the ftrace_func_t functions can
access some partial registers.

Fix to allocate 'struct ftrace_regs' (which has the same size of 'struct
pt_regs') on the stack and save partial (argument) registers on it
instead of reduced size custom data structure.

Fixes: afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/riscv/kernel/mcount-dyn.S |   65 +++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 669b8697aa38..84963680eff4 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -14,46 +14,37 @@
 	.text
 
 #define FENTRY_RA_OFFSET	8
-#define ABI_SIZE_ON_STACK	80
-#define ABI_A0			0
-#define ABI_A1			8
-#define ABI_A2			16
-#define ABI_A3			24
-#define ABI_A4			32
-#define ABI_A5			40
-#define ABI_A6			48
-#define ABI_A7			56
-#define ABI_T0			64
-#define ABI_RA			72
 
 	.macro SAVE_ABI
-	addi	sp, sp, -ABI_SIZE_ON_STACK
-
-	REG_S	a0, ABI_A0(sp)
-	REG_S	a1, ABI_A1(sp)
-	REG_S	a2, ABI_A2(sp)
-	REG_S	a3, ABI_A3(sp)
-	REG_S	a4, ABI_A4(sp)
-	REG_S	a5, ABI_A5(sp)
-	REG_S	a6, ABI_A6(sp)
-	REG_S	a7, ABI_A7(sp)
-	REG_S	t0, ABI_T0(sp)
-	REG_S	ra, ABI_RA(sp)
+	addi	sp, sp, -PT_SIZE_ON_STACK
+
+	/* Save t0 as epc for ftrace_regs_get_instruction_pointer() */
+	REG_S	t0, PT_EPC(sp)
+	REG_S	a0, PT_A0(sp)
+	REG_S	a1, PT_A1(sp)
+	REG_S	a2, PT_A2(sp)
+	REG_S	a3, PT_A3(sp)
+	REG_S	a4, PT_A4(sp)
+	REG_S	a5, PT_A5(sp)
+	REG_S	a6, PT_A6(sp)
+	REG_S	a7, PT_A7(sp)
+	REG_S	t0, PT_T0(sp)
+	REG_S	ra, PT_RA(sp)
 	.endm
 
 	.macro RESTORE_ABI
-	REG_L	a0, ABI_A0(sp)
-	REG_L	a1, ABI_A1(sp)
-	REG_L	a2, ABI_A2(sp)
-	REG_L	a3, ABI_A3(sp)
-	REG_L	a4, ABI_A4(sp)
-	REG_L	a5, ABI_A5(sp)
-	REG_L	a6, ABI_A6(sp)
-	REG_L	a7, ABI_A7(sp)
-	REG_L	t0, ABI_T0(sp)
-	REG_L	ra, ABI_RA(sp)
-
-	addi	sp, sp, ABI_SIZE_ON_STACK
+	REG_L	a0, PT_A0(sp)
+	REG_L	a1, PT_A1(sp)
+	REG_L	a2, PT_A2(sp)
+	REG_L	a3, PT_A3(sp)
+	REG_L	a4, PT_A4(sp)
+	REG_L	a5, PT_A5(sp)
+	REG_L	a6, PT_A6(sp)
+	REG_L	a7, PT_A7(sp)
+	REG_L	t0, PT_T0(sp)
+	REG_L	ra, PT_RA(sp)
+
+	addi	sp, sp, PT_SIZE_ON_STACK
 	.endm
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
@@ -96,8 +87,8 @@ ftrace_call:
 	call	ftrace_stub
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	addi	a0, sp, ABI_RA
-	REG_L	a1, ABI_T0(sp)
+	addi	a0, sp, PT_RA
+	REG_L	a1, PT_T0(sp)
 	addi	a1, a1, -FENTRY_RA_OFFSET
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	mv	a2, s0

