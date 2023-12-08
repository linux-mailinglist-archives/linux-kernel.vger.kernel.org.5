Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570EF80A0D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573669AbjLHK2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573663AbjLHK1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:27:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68C619AD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:27:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928C1C433C9;
        Fri,  8 Dec 2023 10:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702031243;
        bh=4gnOPh72MBp2/UPzOPml+kmyjzVijWhiPGlAlFNB6DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2t7RaJQSrT7iFJnVP9fCJZd6lBh0JXumou5ITkx3xjoSL4I97zMftxsjTZ7AEhJ2
         reTSrGBdgDX/cGHVnHlD1B6h6uq1pRZYEypdqf1yQSFu2520p15BD49riBz1GAgeAF
         wPr8/wogs2mMi9jC6zCTu8YuIlqS6NtqUezMH60slaHpyOltvRtAzwKBzWiN+nW0pE
         MmPMAVJU9PRoyUgu0aM4NQwUAcevT5Yg+E7JjY7/jtikEBgsTjjuUK61EfA6eIYKaW
         OGk6BPrKeT2ypowDVpR345n+A0ZmGS9hV7y0wMtqb+yv+92EF09/kflptVaJos1KUS
         AFKkHXquXzkRQ==
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
Subject: [PATCH v4 15/33] function_graph: Move graph depth stored data to shadow stack global var
Date:   Fri,  8 Dec 2023 19:27:17 +0900
Message-Id: <170203123663.579004.7455942203810529166.stgit@devnote2>
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
index 3b9266aeb43b..e3f452eda0e3 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -896,8 +896,38 @@ extern void free_fgraph_ops(struct trace_array *tr);
 
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
@@ -930,7 +960,7 @@ ftrace_graph_addr(unsigned long *task_var, struct ftrace_graph_ent *trace)
 		 * when the depth is zero.
 		 */
 		*task_var |= TRACE_GRAPH_FL;
-		trace_recursion_set_depth(trace->depth);
+		ftrace_graph_set_depth(task_var, trace->depth);
 
 		/*
 		 * If no irqs are to be traced, but a set_graph_function
@@ -955,7 +985,7 @@ ftrace_graph_addr_finish(struct fgraph_ops *gops, struct ftrace_graph_ret *trace
 	unsigned long *task_var = fgraph_get_task_var(gops);
 
 	if ((*task_var & TRACE_GRAPH_FL) &&
-	    trace->depth == trace_recursion_depth())
+	    trace->depth == ftrace_graph_depth(task_var))
 		*task_var &= ~TRACE_GRAPH_FL;
 }
 

