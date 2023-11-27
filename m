Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2357FA1DB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjK0OBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjK0OAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:00:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59DE2684
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:56:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2AEC43142;
        Mon, 27 Nov 2023 13:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701093417;
        bh=R6EgaSgZ7Tdx6KgYvPS0TsL+d8KuoSEr4jZGrN8IH3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uDRb3wktXM7mUmieOpxA0h8PD9PH/lzIA2FmVUvXYYArKqItK0Z3Lbr6iAEiVKI9P
         uWHcfhZ714xxrl4lhaeeoSGziKQl5A1USSywa6QPsc5tOwhayU/tnPtqsc5B8L+QJY
         ZNZeQL+W4zKkhW2ug7+oLTFdDLNQ+isaJUrdhJVMo9IdERqLBjmuUiuqaq4hkUwkHf
         +zn89278SvyjBO1WnGfXWH1IlfwVHX4ZfT6o4eZtOLVrjh1ayuvJCAh0Dh7soO2gh3
         WgOtFjKA2eXspMjCGFXQ9vKQh2qLrqtTaB6zXIJhh98TYS9ah7Clk+m99LuRR/FMeU
         q+L8isT8TrXBQ==
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
Subject: [PATCH v3 19/33] function_graph: Add a new entry handler with parent_ip and ftrace_regs
Date:   Mon, 27 Nov 2023 22:56:50 +0900
Message-Id: <170109341033.343914.15037337357771755187.stgit@devnote2>
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

Add a new entry handler to fgraph_ops as 'entryregfunc'  which takes
parent_ip and ftrace_regs. Note that the 'entryfunc' and 'entryregfunc'
are mutual exclusive. You can set only one of them.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Update for new multiple fgraph.
---
 arch/arm64/kernel/ftrace.c               |    2 +
 arch/loongarch/kernel/ftrace_dyn.c       |    6 ++++
 arch/powerpc/kernel/trace/ftrace.c       |    2 +
 arch/powerpc/kernel/trace/ftrace_64_pg.c |   10 ++++---
 arch/x86/kernel/ftrace.c                 |   42 ++++++++++++++++--------------
 include/linux/ftrace.h                   |   19 +++++++++++---
 kernel/trace/fgraph.c                    |   30 +++++++++++++++++----
 7 files changed, 76 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 205937e04ece..9d71a475d4c5 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -495,7 +495,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
-	if (!function_graph_enter_ops(*parent, ip, fregs->fp, parent, gops))
+	if (!function_graph_enter_ops(*parent, ip, fregs->fp, parent, fregs, gops))
 		*parent = (unsigned long)&return_to_handler;
 
 	ftrace_test_recursion_unlock(bit);
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 73858c9029cc..39b3f09a5e0c 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -244,7 +244,11 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	struct pt_regs *regs = &fregs->regs;
 	unsigned long *parent = (unsigned long *)&regs->regs[1];
 
-	prepare_ftrace_return(ip, (unsigned long *)parent);
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	if (!function_graph_enter_regs(regs->regs[1], ip, 0, parent, fregs))
+		regs->regs[1] = (unsigned long)&return_to_handler;
 }
 #else
 static int ftrace_modify_graph_caller(bool enable)
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 82010629cf88..9bf1b6912116 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -422,7 +422,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		goto out;
 
-	if (!function_graph_enter(parent_ip, ip, 0, (unsigned long *)sp))
+	if (!function_graph_enter_regs(parent_ip, ip, 0, (unsigned long *)sp, fregs))
 		parent_ip = ppc_function_entry(return_to_handler);
 
 	ftrace_test_recursion_unlock(bit);
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.c b/arch/powerpc/kernel/trace/ftrace_64_pg.c
index 7b85c3b460a3..43f6cfaaf7db 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.c
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.c
@@ -795,7 +795,8 @@ int ftrace_disable_ftrace_graph_caller(void)
  * in current thread info. Return the address we want to divert to.
  */
 static unsigned long
-__prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp)
+__prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp,
+			struct ftrace_regs *fregs)
 {
 	unsigned long return_hooker;
 	int bit;
@@ -812,7 +813,7 @@ __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp
 
 	return_hooker = ppc_function_entry(return_to_handler);
 
-	if (!function_graph_enter(parent, ip, 0, (unsigned long *)sp))
+	if (!function_graph_enter_regs(parent, ip, 0, (unsigned long *)sp, fregs))
 		parent = return_hooker;
 
 	ftrace_test_recursion_unlock(bit);
@@ -824,13 +825,14 @@ __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	fregs->regs.link = __prepare_ftrace_return(parent_ip, ip, fregs->regs.gpr[1]);
+	fregs->regs.link = __prepare_ftrace_return(parent_ip, ip,
+						   fregs->regs.gpr[1], fregs);
 }
 #else
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip,
 				    unsigned long sp)
 {
-	return __prepare_ftrace_return(parent, ip, sp);
+	return __prepare_ftrace_return(parent, ip, sp, NULL);
 }
 #endif
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 845e29b4254f..0f757e399a96 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -614,16 +614,8 @@ int ftrace_disable_ftrace_graph_caller(void)
 }
 #endif /* CONFIG_DYNAMIC_FTRACE && !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 
-/*
- * Hook the return address and push it in the stack of return addrs
- * in current thread info.
- */
-void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
-			   unsigned long frame_pointer)
+static inline bool skip_ftrace_return(void)
 {
-	unsigned long return_hooker = (unsigned long)&return_to_handler;
-	int bit;
-
 	/*
 	 * When resuming from suspend-to-ram, this function can be indirectly
 	 * called from early CPU startup code while the CPU is in real mode,
@@ -633,13 +625,28 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 	 * This check isn't as accurate as virt_addr_valid(), but it should be
 	 * good enough for this purpose, and it's fast.
 	 */
-	if (unlikely((long)__builtin_frame_address(0) >= 0))
-		return;
+	if ((long)__builtin_frame_address(0) >= 0)
+		return true;
 
-	if (unlikely(ftrace_graph_is_dead()))
-		return;
+	if (ftrace_graph_is_dead())
+		return true;
+
+	if (atomic_read(&current->tracing_graph_pause))
+		return true;
+	return false;
+}
 
-	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+/*
+ * Hook the return address and push it in the stack of return addrs
+ * in current thread info.
+ */
+void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
+			   unsigned long frame_pointer)
+{
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	int bit;
+
+	if (unlikely(skip_ftrace_return()))
 		return;
 
 	bit = ftrace_test_recursion_trylock(ip, *parent);
@@ -661,17 +668,14 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	struct fgraph_ops *gops = container_of(op, struct fgraph_ops, ops);
 	int bit;
 
-	if (unlikely(ftrace_graph_is_dead()))
-		return;
-
-	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+	if (unlikely(skip_ftrace_return()))
 		return;
 
 	bit = ftrace_test_recursion_trylock(ip, *parent);
 	if (bit < 0)
 		return;
 
-	if (!function_graph_enter_ops(*parent, ip, 0, parent, gops))
+	if (!function_graph_enter_ops(*parent, ip, 0, parent, fregs, gops))
 		*parent = (unsigned long)&return_to_handler;
 
 	ftrace_test_recursion_unlock(bit);
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 1c121237016e..6da6cc9aaeaf 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1063,6 +1063,11 @@ typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
 typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
 				      struct fgraph_ops *); /* entry */
 
+typedef int (*trace_func_graph_regs_ent_t)(unsigned long func,
+					   unsigned long parent_ip,
+					   struct ftrace_regs *fregs,
+					   struct fgraph_ops *); /* entry w/ regs */
+
 extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
@@ -1070,6 +1075,7 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph
 struct fgraph_ops {
 	trace_func_graph_ent_t		entryfunc;
 	trace_func_graph_ret_t		retfunc;
+	trace_func_graph_regs_ent_t	entryregfunc;
 	struct ftrace_ops		ops; /* for the hash lists */
 	void				*private;
 	int				idx;
@@ -1106,13 +1112,20 @@ struct ftrace_ret_stack {
 extern void return_to_handler(void);
 
 extern int
-function_graph_enter(unsigned long ret, unsigned long func,
-		     unsigned long frame_pointer, unsigned long *retp);
+function_graph_enter_regs(unsigned long ret, unsigned long func,
+			  unsigned long frame_pointer, unsigned long *retp,
+			  struct ftrace_regs *fregs);
+
+static inline int function_graph_enter(unsigned long ret, unsigned long func,
+				       unsigned long fp, unsigned long *retp)
+{
+	return function_graph_enter_regs(ret, func, fp, retp, NULL);
+}
 
 extern int
 function_graph_enter_ops(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp,
-			 struct fgraph_ops *gops);
+			 struct ftrace_regs *fregs, struct fgraph_ops *gops);
 
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 317202943936..47040a78dfb3 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -544,9 +544,21 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 # define MCOUNT_INSN_SIZE 0
 #endif
 
+static inline int call_entry_func(struct ftrace_graph_ent *trace,
+				  unsigned long func, unsigned long ret,
+				  struct ftrace_regs *fregs,
+				  struct fgraph_ops *gops)
+{
+	if (gops->entryregfunc)
+		return gops->entryregfunc(func, ret, fregs, gops);
+
+	return gops->entryfunc(trace, gops);
+}
+
 /* If the caller does not use ftrace, call this function. */
-int function_graph_enter(unsigned long ret, unsigned long func,
-			 unsigned long frame_pointer, unsigned long *retp)
+int function_graph_enter_regs(unsigned long ret, unsigned long func,
+			      unsigned long frame_pointer, unsigned long *retp,
+			      struct ftrace_regs *fregs)
 {
 	struct ftrace_graph_ent trace;
 	unsigned long bitmap = 0;
@@ -581,7 +593,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 		save_curr_ret_stack = current->curr_ret_stack;
 		if (ftrace_ops_test(&gops->ops, func, NULL) &&
-		    gops->entryfunc(&trace, gops))
+		    call_entry_func(&trace, func, ret, fregs, gops))
 			bitmap |= BIT(i);
 		else
 			/* Clear out any saved storage */
@@ -604,6 +616,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 /* This is called from ftrace_graph_func() via ftrace */
 int function_graph_enter_ops(unsigned long ret, unsigned long func,
 			     unsigned long frame_pointer, unsigned long *retp,
+			     struct ftrace_regs *fregs,
 			     struct fgraph_ops *gops)
 {
 	struct ftrace_graph_ent trace;
@@ -625,7 +638,7 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 	trace.func = func;
 	trace.depth = current->curr_ret_depth;
 	save_curr_ret_stack = current->curr_ret_stack;
-	if (gops->entryfunc(&trace, gops)) {
+	if (call_entry_func(&trace, func, ret, fregs, gops)) {
 		if (type == FGRAPH_TYPE_RESERVED)
 			set_fgraph_index_bitmap(current, index, BIT(gops->idx));
 		else
@@ -906,7 +919,8 @@ void fgraph_init_ops(struct ftrace_ops *dst_ops,
 		     struct ftrace_ops *src_ops)
 {
 	dst_ops->func = ftrace_graph_func;
-	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB;
+	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB |
+			 FTRACE_OPS_FL_SAVE_ARGS;
 
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
 	dst_ops->trampoline = FTRACE_GRAPH_TRAMP_ADDR;
@@ -1148,10 +1162,14 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	int ret = 0;
 	int i;
 
+	if (gops->entryfunc && gops->entryregfunc)
+		return -EINVAL;
+
 	mutex_lock(&ftrace_lock);
 
 	if (!gops->ops.func) {
-		gops->ops.flags |= FTRACE_OPS_GRAPH_STUB;
+		gops->ops.flags |= FTRACE_OPS_GRAPH_STUB |
+				   FTRACE_OPS_FL_SAVE_ARGS;
 		gops->ops.func = ftrace_graph_func;
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
 		gops->ops.trampoline = FTRACE_GRAPH_TRAMP_ADDR;

