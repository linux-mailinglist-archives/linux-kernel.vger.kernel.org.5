Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BA17E58D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjKHO15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjKHO1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:27:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83524213E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:27:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8043C433C7;
        Wed,  8 Nov 2023 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699453641;
        bh=zcbx8h1RkttbOn5vskAZ1U6GGz5oeChBoNAtPCt+YfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMDiNy7mdXQI5gVVD/r73RXXWpdK9sk717vOxz0SIZbQKOMYkb+d/gg1ZAQeWVQ2I
         LmtrLrMyo/0bpfGX4OeCCj6cEEAggZg0njpuswCD1nu77kACMD2AF7ebaiMk4BO1WD
         zab2dpvg6JfVqxcrTg8ALIGCWcvrfipIBQzs8EXS/q4cVYT0laJGp2ljkACGzC239Z
         2KcffQCHcnay0hYxxBpUI8wgkuglZ0gjUebVx2b0tXfs5rUZTUl6nwxhI9O4z4Qppf
         ADStmb+8Exxsq/nNkDuN+J1uFhmhEadFL2Cga8RVzZiBb/qYje4+06SGG2Te3hdOSo
         Ne71oyUhldOww==
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
Subject: [RFC PATCH v2 15/31] function_graph: Move graph depth stored data to shadow stack global var
Date:   Wed,  8 Nov 2023 23:27:15 +0900
Message-Id: <169945363502.55307.4733872462347686914.stgit@devnote2>
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
graph depth was a bit of an abuse of that variable. Now that there
exists global vars that are per stack for registered graph traces, use that
instead.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/trace_recursion.h |   29 -----------------------------
 kernel/trace/trace.h            |   34 ++++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index 2efd5ec46d7f..00e792bf148d 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -44,25 +44,6 @@ enum {
  */
 	TRACE_IRQ_BIT,
 
-	/*
-	 * In the very unlikely case that an interrupt came in
-	 * at a start of graph tracing, and we want to trace
-	 * the function in that interrupt, the depth can be greater
-	 * than zero, because of the preempted start of a previous
-	 * trace. In an even more unlikely case, depth could be 2
-	 * if a softirq interrupted the start of graph tracing,
-	 * followed by an interrupt preempting a start of graph
-	 * tracing in the softirq, and depth can even be 3
-	 * if an NMI came in at the start of an interrupt function
-	 * that preempted a softirq start of a function that
-	 * preempted normal context!!!! Luckily, it can't be
-	 * greater than 3, so the next two bits are a mask
-	 * of what the depth is when we set TRACE_GRAPH_FL
-	 */
-
-	TRACE_GRAPH_DEPTH_START_BIT,
-	TRACE_GRAPH_DEPTH_END_BIT,
-
 	/*
 	 * To implement set_graph_notrace, if this bit is set, we ignore
 	 * function graph tracing of called functions, until the return
@@ -78,16 +59,6 @@ enum {
 #define trace_recursion_clear(bit)	do { (current)->trace_recursion &= ~(1<<(bit)); } while (0)
 #define trace_recursion_test(bit)	((current)->trace_recursion & (1<<(bit)))
 
-#define trace_recursion_depth() \
-	(((current)->trace_recursion >> TRACE_GRAPH_DEPTH_START_BIT) & 3)
-#define trace_recursion_set_depth(depth) \
-	do {								\
-		current->trace_recursion &=				\
-			~(3 << TRACE_GRAPH_DEPTH_START_BIT);		\
-		current->trace_recursion |=				\
-			((depth) & 3) << TRACE_GRAPH_DEPTH_START_BIT;	\
-	} while (0)
-
 #define TRACE_CONTEXT_BITS	4
 
 #define TRACE_FTRACE_START	TRACE_FTRACE_BIT
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 60d38709ab91..cbe44998ef77 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -891,8 +891,38 @@ extern void free_fgraph_ops(struct trace_array *tr);
 
 enum {
 	TRACE_GRAPH_FL		= 1,
+
+	/*
+	 * In the very unlikely case that an interrupt came in
+	 * at a start of graph tracing, and we want to trace
+	 * the function in that interrupt, the depth can be greater
+	 * than zero, because of the preempted start of a previous
+	 * trace. In an even more unlikely case, depth could be 2
+	 * if a softirq interrupted the start of graph tracing,
+	 * followed by an interrupt preempting a start of graph
+	 * tracing in the softirq, and depth can even be 3
+	 * if an NMI came in at the start of an interrupt function
+	 * that preempted a softirq start of a function that
+	 * preempted normal context!!!! Luckily, it can't be
+	 * greater than 3, so the next two bits are a mask
+	 * of what the depth is when we set TRACE_GRAPH_FL
+	 */
+
+	TRACE_GRAPH_DEPTH_START_BIT,
+	TRACE_GRAPH_DEPTH_END_BIT,
 };
 
+static inline unsigned long ftrace_graph_depth(unsigned long *task_var)
+{
+	return (*task_var >> TRACE_GRAPH_DEPTH_START_BIT) & 3;
+}
+
+static inline void ftrace_graph_set_depth(unsigned long *task_var, int depth)
+{
+	*task_var &= ~(3 << TRACE_GRAPH_DEPTH_START_BIT);
+	*task_var |= (depth & 3) << TRACE_GRAPH_DEPTH_START_BIT;
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern struct ftrace_hash __rcu *ftrace_graph_hash;
 extern struct ftrace_hash __rcu *ftrace_graph_notrace_hash;
@@ -925,7 +955,7 @@ ftrace_graph_addr(unsigned long *task_var, struct ftrace_graph_ent *trace)
 		 * when the depth is zero.
 		 */
 		*task_var |= TRACE_GRAPH_FL;
-		trace_recursion_set_depth(trace->depth);
+		ftrace_graph_set_depth(task_var, trace->depth);
 
 		/*
 		 * If no irqs are to be traced, but a set_graph_function
@@ -950,7 +980,7 @@ ftrace_graph_addr_finish(struct fgraph_ops *gops, struct ftrace_graph_ret *trace
 	unsigned long *task_var = fgraph_get_task_var(gops);
 
 	if ((*task_var & TRACE_GRAPH_FL) &&
-	    trace->depth == trace_recursion_depth())
+	    trace->depth == ftrace_graph_depth(task_var))
 		*task_var &= ~TRACE_GRAPH_FL;
 }
 

