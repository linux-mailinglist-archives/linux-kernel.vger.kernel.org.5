Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D591F7E58D2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbjKHO2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343846AbjKHO1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:27:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F521FF6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:27:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30239C433C9;
        Wed,  8 Nov 2023 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699453652;
        bh=AazvW4/a90V/YIaJshYrFG/FkUTxnxIHHqFsOEqmNJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DohexUuDrJLVtXyYt2QY1NH+ByHMTlsNWR/xtWNi+f16WQzyj7RApB2lZEO0ue2U2
         daoiGdIt2mMnqaffz8Z/7DGuSz97i9RrI3ZMvU9lkd2/X4j2SMXSOeYdarSnAv0cKB
         aagkuyx7DkWqwZTSHrk+Rovl0KtUXVEE4mHkb8X8cqN0YmREE4evEWtqwQicje0lZk
         os8vM3BFF1CYqQymMTlz8v6rZr7N+Fsbct8M/BnFLudVBepjL/hZsKMg35oF1BiQdx
         1Y4UebYZ/HkWVngvSj0T8rMEIQ25qcFyoa0j+cvjgBmP68jS1hoJo/B+UM6NQUV8M5
         1f/aApGWx0ctw==
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
Subject: [RFC PATCH v2 16/31] function_graph: Move graph notrace bit to shadow stack global var
Date:   Wed,  8 Nov 2023 23:27:27 +0900
Message-Id: <169945364658.55307.8169090480122784915.stgit@devnote2>
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

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

The use of the task->trace_recursion for the logic used for the function
graph no-trace was a bit of an abuse of that variable. Now that there
exists global vars that are per stack for registered graph traces, use
that instead.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Make description lines shorter than 76 chars.
---
 include/linux/trace_recursion.h      |    7 -------
 kernel/trace/trace.h                 |    9 +++++++++
 kernel/trace/trace_functions_graph.c |   10 ++++++----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index 00e792bf148d..cc11b0e9d220 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -44,13 +44,6 @@ enum {
  */
 	TRACE_IRQ_BIT,
 
-	/*
-	 * To implement set_graph_notrace, if this bit is set, we ignore
-	 * function graph tracing of called functions, until the return
-	 * function is called to clear it.
-	 */
-	TRACE_GRAPH_NOTRACE_BIT,
-
 	/* Used to prevent recursion recording from recursing. */
 	TRACE_RECORD_RECURSION_BIT,
 };
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index cbe44998ef77..27b2b52c36cc 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -910,8 +910,17 @@ enum {
 
 	TRACE_GRAPH_DEPTH_START_BIT,
 	TRACE_GRAPH_DEPTH_END_BIT,
+
+	/*
+	 * To implement set_graph_notrace, if this bit is set, we ignore
+	 * function graph tracing of called functions, until the return
+	 * function is called to clear it.
+	 */
+	TRACE_GRAPH_NOTRACE_BIT,
 };
 
+#define TRACE_GRAPH_NOTRACE		(1 << TRACE_GRAPH_NOTRACE_BIT)
+
 static inline unsigned long ftrace_graph_depth(unsigned long *task_var)
 {
 	return (*task_var >> TRACE_GRAPH_DEPTH_START_BIT) & 3;
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 66cce73e94f8..13d0387ac6a6 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -130,6 +130,7 @@ static inline int ftrace_graph_ignore_irqs(void)
 int trace_graph_entry(struct ftrace_graph_ent *trace,
 		      struct fgraph_ops *gops)
 {
+	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
 	struct trace_array_cpu *data;
 	unsigned long flags;
@@ -138,7 +139,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	int ret;
 	int cpu;
 
-	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT))
+	if (*task_var & TRACE_GRAPH_NOTRACE)
 		return 0;
 
 	/*
@@ -149,7 +150,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	 * returning from the function.
 	 */
 	if (ftrace_graph_notrace_addr(trace->func)) {
-		trace_recursion_set(TRACE_GRAPH_NOTRACE_BIT);
+		*task_var |= TRACE_GRAPH_NOTRACE_BIT;
 		/*
 		 * Need to return 1 to have the return called
 		 * that will clear the NOTRACE bit.
@@ -240,6 +241,7 @@ void __trace_graph_return(struct trace_array *tr,
 void trace_graph_return(struct ftrace_graph_ret *trace,
 			struct fgraph_ops *gops)
 {
+	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
 	struct trace_array_cpu *data;
 	unsigned long flags;
@@ -249,8 +251,8 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 
 	ftrace_graph_addr_finish(gops, trace);
 
-	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
-		trace_recursion_clear(TRACE_GRAPH_NOTRACE_BIT);
+	if (*task_var & TRACE_GRAPH_NOTRACE) {
+		*task_var &= ~TRACE_GRAPH_NOTRACE;
 		return;
 	}
 

