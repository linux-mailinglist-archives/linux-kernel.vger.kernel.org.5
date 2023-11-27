Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A167FA188
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjK0Ny2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjK0NyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:54:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ADAD4D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:54:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4759DC433CB;
        Mon, 27 Nov 2023 13:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701093255;
        bh=51Cq89Jg5fqfgwiJmEALH7euiYhrlJJ1/IPjogh9mj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i1Gsc2hzftsRB5mtHmfgDLsiBQ637hCqTNT8OoJeKcDYp1pbRJMwrPIffPZvcNZ9L
         RtV8iWVrRDRYCnJJD6iPvNQGlvVFPkxNTuzWnbany6BXzHp5MyYLsgVSfZaDACZGXm
         DyV1UiaX3xUV0p8OCj9C/Y32Q+7uJHw/c6h9GtZMG9m/5+o+164NEUeQ2jt/cy1mB5
         E5Rq66EcEaRFmfKvFQSl0Rk7BTV70WKaw0iOV8tWm71tPqU2ySZJVGiykBKpYfmnrC
         M9TIVWZ/FQxTJ1sr/RSPeSMd4kYwdeOcJiOmyPKkGH8Uu59PC+pHctV4MDMtmkhjZc
         WEpgvj7iuHvyw==
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
Subject: [PATCH v3 06/33] function_graph: Add an array structure that will allow multiple callbacks
Date:   Mon, 27 Nov 2023 22:54:08 +0900
Message-Id: <170109324834.343914.5305076823761174091.stgit@devnote2>
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

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Add an array structure that will eventually allow the function graph tracer
to have up to 16 simultaneous callbacks attached. It's an array of 16
fgraph_ops pointers, that is assigned when one is registered. On entry of a
function the entry of the first item in the array is called, and if it
returns zero, then the callback returns non zero if it wants the return
callback to be called on exit of the function.

The array will simplify the process of having more than one callback
attached to the same function, as its index into the array can be stored on
the shadow stack. We need to only save the index, because this will allow
the fgraph_ops to be freed before the function returns (which may happen if
the function call schedule for a long time).

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Remove unneeded brace.
---
 kernel/trace/fgraph.c |  114 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 81 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 837daf929d2a..86df3ca6964f 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -39,6 +39,11 @@
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
+static int fgraph_array_cnt;
+#define FGRAPH_ARRAY_SIZE	16
+
+static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
+
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
@@ -62,6 +67,20 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
 }
 #endif
 
+int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
+{
+	return 0;
+}
+
+static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace)
+{
+}
+
+static struct fgraph_ops fgraph_stub = {
+	.entryfunc = ftrace_graph_entry_stub,
+	.retfunc = ftrace_graph_ret_stub,
+};
+
 /**
  * ftrace_graph_stop - set to permanently disable function graph tracing
  *
@@ -159,7 +178,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 		goto out;
 
 	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
+	if (!fgraph_array[0]->entryfunc(&trace))
 		goto out_ret;
 
 	return 0;
@@ -274,7 +293,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	trace.retval = fgraph_ret_regs_return_value(ret_regs);
 #endif
 	trace.rettime = trace_clock_local();
-	ftrace_graph_return(&trace);
+	fgraph_array[0]->retfunc(&trace);
 	/*
 	 * The ftrace_graph_return() may still access the current
 	 * ret_stack structure, we need to make sure the update of
@@ -410,11 +429,6 @@ void ftrace_graph_sleep_time_control(bool enable)
 	fgraph_sleep_time = enable;
 }
 
-int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
-{
-	return 0;
-}
-
 /*
  * Simply points to ftrace_stub, but with the proper protocol.
  * Defined by the linker script in linux/vmlinux.lds.h
@@ -652,37 +666,54 @@ static int start_graph_tracing(void)
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	int ret = 0;
+	int i;
 
 	mutex_lock(&ftrace_lock);
 
-	/* we currently allow only one tracer registered at a time */
-	if (ftrace_graph_active) {
+	if (!fgraph_array[0]) {
+		/* The array must always have real data on it */
+		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
+			fgraph_array[i] = &fgraph_stub;
+	}
+
+	/* Look for an available spot */
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+		if (fgraph_array[i] == &fgraph_stub)
+			break;
+	}
+	if (i >= FGRAPH_ARRAY_SIZE) {
 		ret = -EBUSY;
 		goto out;
 	}
 
-	register_pm_notifier(&ftrace_suspend_notifier);
+	fgraph_array[i] = gops;
+	if (i + 1 > fgraph_array_cnt)
+		fgraph_array_cnt = i + 1;
 
 	ftrace_graph_active++;
-	ret = start_graph_tracing();
-	if (ret) {
-		ftrace_graph_active--;
-		goto out;
-	}
 
-	ftrace_graph_return = gops->retfunc;
+	if (ftrace_graph_active == 1) {
+		register_pm_notifier(&ftrace_suspend_notifier);
+		ret = start_graph_tracing();
+		if (ret) {
+			ftrace_graph_active--;
+			goto out;
+		}
+
+		ftrace_graph_return = gops->retfunc;
 
-	/*
-	 * Update the indirect function to the entryfunc, and the
-	 * function that gets called to the entry_test first. Then
-	 * call the update fgraph entry function to determine if
-	 * the entryfunc should be called directly or not.
-	 */
-	__ftrace_graph_entry = gops->entryfunc;
-	ftrace_graph_entry = ftrace_graph_entry_test;
-	update_function_graph_func();
+		/*
+		 * Update the indirect function to the entryfunc, and the
+		 * function that gets called to the entry_test first. Then
+		 * call the update fgraph entry function to determine if
+		 * the entryfunc should be called directly or not.
+		 */
+		__ftrace_graph_entry = gops->entryfunc;
+		ftrace_graph_entry = ftrace_graph_entry_test;
+		update_function_graph_func();
 
-	ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
+		ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
+	}
 out:
 	mutex_unlock(&ftrace_lock);
 	return ret;
@@ -690,19 +721,36 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
+	int i;
+
 	mutex_lock(&ftrace_lock);
 
 	if (unlikely(!ftrace_graph_active))
 		goto out;
 
-	ftrace_graph_active--;
-	ftrace_graph_return = ftrace_stub_graph;
-	ftrace_graph_entry = ftrace_graph_entry_stub;
-	__ftrace_graph_entry = ftrace_graph_entry_stub;
-	ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
-	unregister_pm_notifier(&ftrace_suspend_notifier);
-	unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
+	for (i = 0; i < fgraph_array_cnt; i++)
+		if (gops == fgraph_array[i])
+			break;
+	if (i >= fgraph_array_cnt)
+		goto out;
 
+	fgraph_array[i] = &fgraph_stub;
+	if (i + 1 == fgraph_array_cnt) {
+		for (; i >= 0; i--)
+			if (fgraph_array[i] != &fgraph_stub)
+				break;
+		fgraph_array_cnt = i + 1;
+	}
+
+	ftrace_graph_active--;
+	if (!ftrace_graph_active) {
+		ftrace_graph_return = ftrace_stub_graph;
+		ftrace_graph_entry = ftrace_graph_entry_stub;
+		__ftrace_graph_entry = ftrace_graph_entry_stub;
+		ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
+		unregister_pm_notifier(&ftrace_suspend_notifier);
+		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
+	}
  out:
 	mutex_unlock(&ftrace_lock);
 }

