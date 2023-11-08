Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947DB7E58B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjKHOZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjKHOZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:25:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3CB1FC3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:25:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BA4C433C7;
        Wed,  8 Nov 2023 14:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699453550;
        bh=APQJdEZ6pt+ekGviwAieGT/uClX2gyf+ahHvsmx9rEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qvD3u0rM77fakiX5YrVbwQJhIi80sTl5bOZn5u7CwbQ1sM3wanINMsS/11exjNxDG
         /uEeXB6L7B7NwSjUoTsP/noNlHFwNNXzOxGwxjvshpRxdy5QSfx6DtMP1ixX8zhrOw
         pNU8ElFEFgS4C77UvQVouqBcMebcEb55juF3DFvjOPIid3DsvdV1AuN4m2UHP7L/Hn
         WUoKjau2orEfraqNR2tRmFE0U2bLos2wjdDUG83e7i11WFM3r62HNR+CqhHt6Qxb+v
         dfFGf64AUzA2Nq49zG7e1WPymg+t6bUj+uM5kr30omGwOukrzmyCu0WIdOHZ9cjjJZ
         sO8VOaRIsH/Kw==
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
Subject: [RFC PATCH v2 07/31] function_graph: Allow multiple users to attach to function graph
Date:   Wed,  8 Nov 2023 23:25:42 +0900
Message-Id: <169945354225.55307.2450853673796261475.stgit@devnote2>
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

Allow for multiple users to attach to function graph tracer at the same
time. Only 16 simultaneous users can attach to the tracer. This is because
there's an array that stores the pointers to the attached fgraph_ops. When
a function being traced is entered, each of the ftrace_ops entryfunc is
called and if it returns non zero, its index into the array will be added
to the shadow stack.

On exit of the function being traced, the shadow stack will contain the
indexes of the ftrace_ops on the array that want their retfunc to be
called.

Because a function may sleep for a long time (if a task sleeps itself),
the return of the function may be literally days later. If the ftrace_ops
is removed, its place on the array is replaced with a ftrace_ops that
contains the stub functions and that will be called when the function
finally returns.

If another ftrace_ops is added that happens to get the same index into the
array, its return function may be called. But that's actually the way
things current work with the old function graph tracer. If one tracer is
removed and another is added, the new one will get the return calls of the
function traced by the previous one, thus this is not a regression. This
can be fixed by adding a counter to each time the array item is updated and
save that on the shadow stack as well, such that it won't be called if the
index saved does not match the index on the array.

Note, being able to filter functions when both are called is not completely
handled yet, but that shouldn't be too hard to manage.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Check return value of the ftrace_pop_return_trace() instead of 'ret'
    since 'ret' is set to the address of panic().
  - Fix typo and make lines shorter than 76 chars in description.
---
 kernel/trace/fgraph.c |  332 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 280 insertions(+), 52 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 86df3ca6964f..8aba93be11b2 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -27,23 +27,144 @@
 
 #define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
 #define FGRAPH_RET_INDEX (FGRAPH_RET_SIZE / sizeof(long))
+
+/*
+ * On entry to a function (via function_graph_enter()), a new ftrace_ret_stack
+ * is allocated on the task's ret_stack, then each fgraph_ops on the
+ * fgraph_array[]'s entryfunc is called and if that returns non-zero, the
+ * index into the fgraph_array[] for that fgraph_ops is added to the ret_stack.
+ * As the associated ftrace_ret_stack saved for those fgraph_ops needs to
+ * be found, the index to it is also added to the ret_stack along with the
+ * index of the fgraph_array[] to each fgraph_ops that needs their retfunc
+ * called.
+ *
+ * The top of the ret_stack (when not empty) will always have a reference
+ * to the last ftrace_ret_stack saved. All references to the
+ * ftrace_ret_stack has the format of:
+ *
+ * bits:  0 - 13	Index in words from the previous ftrace_ret_stack
+ * bits: 14 - 15	Type of storage
+ *			  0 - reserved
+ *			  1 - fgraph_array index
+ * For fgraph_array_index:
+ *  bits: 16 - 23	The fgraph_ops fgraph_array index
+ *
+ * That is, at the end of function_graph_enter, if the first and forth
+ * fgraph_ops on the fgraph_array[] (index 0 and 3) needs their retfunc called
+ * on the return of the function being traced, this is what will be on the
+ * task's shadow ret_stack: (the stack grows upward)
+ *
+ * |                                  | <- task->curr_ret_stack
+ * +----------------------------------+
+ * | (3 << FGRAPH_ARRAY_SHIFT)|(2)    | ( 3 for index of fourth fgraph_ops)
+ * +----------------------------------+
+ * | (0 << FGRAPH_ARRAY_SHIFT)|(1)    | ( 0 for index of first fgraph_ops)
+ * +----------------------------------+
+ * | struct ftrace_ret_stack          |
+ * |   (stores the saved ret pointer) |
+ * +----------------------------------+
+ * |             (X) | (N)            | ( N words away from previous ret_stack)
+ * |                                  |
+ *
+ * If a backtrace is required, and the real return pointer needs to be
+ * fetched, then it looks at the task's curr_ret_stack index, if it
+ * is greater than zero, it would subtact one, and then mask the value
+ * on the ret_stack by FGRAPH_RET_INDEX_MASK and subtract FGRAPH_RET_INDEX
+ * from that, to get the index of the ftrace_ret_stack structure stored
+ * on the shadow stack.
+ */
+
+#define FGRAPH_RET_INDEX_SIZE	14
+#define FGRAPH_RET_INDEX_MASK	((1 << FGRAPH_RET_INDEX_SIZE) - 1)
+
+
+#define FGRAPH_TYPE_SIZE	2
+#define FGRAPH_TYPE_MASK	((1 << FGRAPH_TYPE_SIZE) - 1)
+#define FGRAPH_TYPE_SHIFT	FGRAPH_RET_INDEX_SIZE
+
+enum {
+	FGRAPH_TYPE_RESERVED	= 0,
+	FGRAPH_TYPE_ARRAY	= 1,
+};
+
+#define FGRAPH_ARRAY_SIZE	16
+#define FGRAPH_ARRAY_MASK	((1 << FGRAPH_ARRAY_SIZE) - 1)
+#define FGRAPH_ARRAY_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
+
+/* Currently the max stack index can't be more than register callers */
+#define FGRAPH_MAX_INDEX	FGRAPH_ARRAY_SIZE
+
+#define FGRAPH_FRAME_SIZE (FGRAPH_RET_SIZE + FGRAPH_ARRAY_SIZE * (sizeof(long)))
+#define FGRAPH_FRAME_INDEX (ALIGN(FGRAPH_FRAME_SIZE,		\
+				  sizeof(long)) / sizeof(long))
 #define SHADOW_STACK_SIZE (PAGE_SIZE)
 #define SHADOW_STACK_INDEX (SHADOW_STACK_SIZE / sizeof(long))
 /* Leave on a buffer at the end */
-#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
+#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - (FGRAPH_RET_INDEX + 1))
 
 #define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
-#define RET_STACK_INC(c) ({ c += FGRAPH_RET_INDEX; })
-#define RET_STACK_DEC(c) ({ c -= FGRAPH_RET_INDEX; })
 
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
 static int fgraph_array_cnt;
-#define FGRAPH_ARRAY_SIZE	16
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 
+static inline int get_ret_stack_index(struct task_struct *t, int offset)
+{
+	return current->ret_stack[offset] & FGRAPH_RET_INDEX_MASK;
+}
+
+static inline int get_fgraph_type(struct task_struct *t, int offset)
+{
+	return (current->ret_stack[offset] >> FGRAPH_TYPE_SHIFT) &
+		FGRAPH_TYPE_MASK;
+}
+
+static inline int get_fgraph_array(struct task_struct *t, int offset)
+{
+	return (current->ret_stack[offset] >> FGRAPH_ARRAY_SHIFT) &
+		FGRAPH_ARRAY_MASK;
+}
+
+/*
+ * @offset: The index into @t->ret_stack to find the ret_stack entry
+ * @index: Where to place the index into @t->ret_stack of that entry
+ *
+ * Calling this with:
+ *
+ *   offset = task->curr_ret_stack;
+ *   do {
+ *	ret_stack = get_ret_stack(task, offset, &offset);
+ *   } while (ret_stack);
+ *
+ * Will iterate through all the ret_stack entries from curr_ret_stack
+ * down to the first one.
+ */
+static inline struct ftrace_ret_stack *
+get_ret_stack(struct task_struct *t, int offset, int *index)
+{
+	int idx;
+
+	BUILD_BUG_ON(FGRAPH_RET_SIZE % sizeof(long));
+
+	if (offset <= 0)
+		return NULL;
+
+	idx = get_ret_stack_index(t, offset - 1);
+
+	if (idx <= 0 || idx > FGRAPH_MAX_INDEX)
+		return NULL;
+
+	offset -= idx + FGRAPH_RET_INDEX;
+	if (offset < 0)
+		return NULL;
+
+	*index = offset;
+	return RET_STACK(t, offset);
+}
+
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
@@ -126,9 +247,34 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	calltime = trace_clock_local();
 
 	index = current->curr_ret_stack;
-	RET_STACK_INC(current->curr_ret_stack);
+	/* ret offset = 1 ; type = reserved */
+	current->ret_stack[index + FGRAPH_RET_INDEX] = 1;
 	ret_stack = RET_STACK(current, index);
+	ret_stack->ret = ret;
+	/*
+	 * The unwinders expect curr_ret_stack to point to either zero
+	 * or an index where to find the next ret_stack. Even though the
+	 * ret stack might be bogus, we want to write the ret and the
+	 * index to find the ret_stack before we increment the stack point.
+	 * If an interrupt comes in now before we increment the curr_ret_stack
+	 * it may blow away what we wrote. But that's fine, because the
+	 * index will still be correct (even though the 'ret' won't be).
+	 * What we worry about is the index being correct after we increment
+	 * the curr_ret_stack and before we update that index, as if an
+	 * interrupt comes in and does an unwind stack dump, it will need
+	 * at least a correct index!
+	 */
 	barrier();
+	current->curr_ret_stack += FGRAPH_RET_INDEX + 1;
+	/*
+	 * This next barrier is to ensure that an interrupt coming in
+	 * will not corrupt what we are about to write.
+	 */
+	barrier();
+
+	/* Still keep it reserved even if an interrupt came in */
+	current->ret_stack[index + FGRAPH_RET_INDEX] = 1;
+
 	ret_stack->ret = ret;
 	ret_stack->func = func;
 	ret_stack->calltime = calltime;
@@ -159,6 +305,12 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
 	struct ftrace_graph_ent trace;
+	int offset;
+	int start;
+	int type;
+	int val;
+	int cnt = 0;
+	int i;
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	/*
@@ -177,38 +329,87 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (ftrace_push_return_trace(ret, func, frame_pointer, retp))
 		goto out;
 
-	/* Only trace if the calling function expects to */
-	if (!fgraph_array[0]->entryfunc(&trace))
+	/* Use start for the distance to ret_stack (skipping over reserve) */
+	start = offset = current->curr_ret_stack - 2;
+
+	for (i = 0; i < fgraph_array_cnt; i++) {
+		struct fgraph_ops *gops = fgraph_array[i];
+
+		if (gops == &fgraph_stub)
+			continue;
+
+		if ((offset == start) &&
+		    (current->curr_ret_stack >= SHADOW_STACK_INDEX - 1)) {
+			atomic_inc(&current->trace_overrun);
+			break;
+		}
+		if (fgraph_array[i]->entryfunc(&trace)) {
+			offset = current->curr_ret_stack;
+			/* Check the top level stored word */
+			type = get_fgraph_type(current, offset - 1);
+
+			val = (i << FGRAPH_ARRAY_SHIFT) |
+				(FGRAPH_TYPE_ARRAY << FGRAPH_TYPE_SHIFT) |
+				((offset - start) - 1);
+
+			/* We can reuse the top word if it is reserved */
+			if (type == FGRAPH_TYPE_RESERVED) {
+				current->ret_stack[offset - 1] = val;
+				cnt++;
+				continue;
+			}
+			val++;
+
+			current->ret_stack[offset] = val;
+			/*
+			 * Write the value before we increment, so that
+			 * if an interrupt comes in after we increment
+			 * it will still see the value and skip over
+			 * this.
+			 */
+			barrier();
+			current->curr_ret_stack++;
+			/*
+			 * Have to write again, in case an interrupt
+			 * came in before the increment and after we
+			 * wrote the value.
+			 */
+			barrier();
+			current->ret_stack[offset] = val;
+			cnt++;
+		}
+	}
+
+	if (!cnt)
 		goto out_ret;
 
 	return 0;
  out_ret:
-	RET_STACK_DEC(current->curr_ret_stack);
+	current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
  out:
 	current->curr_ret_depth--;
 	return -EBUSY;
 }
 
 /* Retrieve a function return address to the trace stack on thread info.*/
-static void
+static struct ftrace_ret_stack *
 ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 			unsigned long frame_pointer)
 {
 	struct ftrace_ret_stack *ret_stack;
 	int index;
 
-	index = current->curr_ret_stack;
-	RET_STACK_DEC(index);
+	ret_stack = get_ret_stack(current, current->curr_ret_stack, &index);
 
-	if (unlikely(index < 0 || index > SHADOW_STACK_MAX_INDEX)) {
+	if (unlikely(!ret_stack)) {
 		ftrace_graph_stop();
-		WARN_ON(1);
+		WARN(1, "Bad function graph ret_stack pointer: %d",
+		     current->curr_ret_stack);
 		/* Might as well panic, otherwise we have no where to go */
 		*ret = (unsigned long)panic;
-		return;
+		return NULL;
 	}
 
-	ret_stack = RET_STACK(current, index);
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	/*
 	 * The arch may choose to record the frame pointer used
@@ -228,12 +429,12 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 		ftrace_graph_stop();
 		WARN(1, "Bad frame pointer: expected %lx, received %lx\n"
 		     "  from func %ps return to %lx\n",
-		     current->ret_stack[index].fp,
+		     ret_stack->fp,
 		     frame_pointer,
 		     (void *)ret_stack->func,
 		     ret_stack->ret);
 		*ret = (unsigned long)panic;
-		return;
+		return NULL;
 	}
 #endif
 
@@ -241,13 +442,15 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	trace->func = ret_stack->func;
 	trace->calltime = ret_stack->calltime;
 	trace->overrun = atomic_read(&current->trace_overrun);
-	trace->depth = current->curr_ret_depth--;
+	trace->depth = current->curr_ret_depth;
 	/*
 	 * We still want to trace interrupts coming in if
 	 * max_depth is set to 1. Make sure the decrement is
 	 * seen before ftrace_graph_return.
 	 */
 	barrier();
+
+	return ret_stack;
 }
 
 /*
@@ -285,30 +488,47 @@ struct fgraph_ret_regs;
 static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs,
 						unsigned long frame_pointer)
 {
+	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_graph_ret trace;
 	unsigned long ret;
+	int offset;
+	int index;
+	int idx;
+	int i;
+
+	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer);
+
+	if (unlikely(!ret_stack)) {
+		ftrace_graph_stop();
+		WARN_ON(1);
+		/* Might as well panic. What else to do? */
+		return (unsigned long)panic;
+	}
 
-	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
+	trace.rettime = trace_clock_local();
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	trace.retval = fgraph_ret_regs_return_value(ret_regs);
 #endif
-	trace.rettime = trace_clock_local();
-	fgraph_array[0]->retfunc(&trace);
+
+	offset = current->curr_ret_stack - 1;
+	index = get_ret_stack_index(current, offset);
+
+	/* index has to be at least one! Optimize for it */
+	i = 0;
+	do {
+		idx = get_fgraph_array(current, offset - i);
+		fgraph_array[idx]->retfunc(&trace);
+		i++;
+	} while (i < index);
+
 	/*
 	 * The ftrace_graph_return() may still access the current
 	 * ret_stack structure, we need to make sure the update of
 	 * curr_ret_stack is after that.
 	 */
 	barrier();
-	RET_STACK_DEC(current->curr_ret_stack);
-
-	if (unlikely(!ret)) {
-		ftrace_graph_stop();
-		WARN_ON(1);
-		/* Might as well panic. What else to do? */
-		ret = (unsigned long)panic;
-	}
-
+	current->curr_ret_stack -= index + FGRAPH_RET_INDEX;
+	current->curr_ret_depth--;
 	return ret;
 }
 
@@ -343,15 +563,17 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
+	struct ftrace_ret_stack *ret_stack = NULL;
 	int index = task->curr_ret_stack;
 
-	BUILD_BUG_ON(FGRAPH_RET_SIZE % sizeof(long));
-
-	index -= FGRAPH_RET_INDEX * (idx + 1);
 	if (index < 0)
 		return NULL;
 
-	return RET_STACK(task, index);
+	do {
+		ret_stack = get_ret_stack(task, index, &index);
+	} while (ret_stack && --idx >= 0);
+
+	return ret_stack;
 }
 
 /**
@@ -374,16 +596,15 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
 	struct ftrace_ret_stack *ret_stack;
-	int index = task->curr_ret_stack;
-	int i;
+	int i = task->curr_ret_stack;
 
 	if (ret != (unsigned long)dereference_kernel_function_descriptor(return_to_handler))
 		return ret;
 
-	RET_STACK_DEC(index);
-
-	for (i = index; i >= 0; RET_STACK_DEC(i)) {
-		ret_stack = RET_STACK(task, i);
+	while (i > 0) {
+		ret_stack = get_ret_stack(current, i, &i);
+		if (!ret_stack)
+			break;
 		if (ret_stack->retp == retp)
 			return ret_stack->ret;
 	}
@@ -394,21 +615,26 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
-	int task_idx;
+	struct ftrace_ret_stack *ret_stack;
+	int task_idx = task->curr_ret_stack;
+	int i;
 
 	if (ret != (unsigned long)dereference_kernel_function_descriptor(return_to_handler))
 		return ret;
 
-	task_idx = task->curr_ret_stack;
-	RET_STACK_DEC(task_idx);
-
-	if (!task->ret_stack || task_idx < *idx)
+	if (!idx)
 		return ret;
 
-	task_idx -= *idx;
-	RET_STACK_INC(*idx);
+	i = *idx;
+	do {
+		ret_stack = get_ret_stack(task, task_idx, &task_idx);
+		i--;
+	} while (i >= 0 && ret_stack);
+
+	if (ret_stack)
+		return ret_stack->ret;
 
-	return RET_STACK(task, task_idx);
+	return ret;
 }
 #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
 
@@ -514,10 +740,10 @@ ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
 	 */
 	timestamp -= next->ftrace_timestamp;
 
-	for (index = next->curr_ret_stack - FGRAPH_RET_INDEX; index >= 0; ) {
-		ret_stack = RET_STACK(next, index);
-		ret_stack->calltime += timestamp;
-		index -= FGRAPH_RET_INDEX;
+	for (index = next->curr_ret_stack; index > 0; ) {
+		ret_stack = get_ret_stack(next, index, &index);
+		if (ret_stack)
+			ret_stack->calltime += timestamp;
 	}
 }
 
@@ -568,6 +794,8 @@ graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 {
 	atomic_set(&t->trace_overrun, 0);
 	t->ftrace_timestamp = 0;
+	t->curr_ret_stack = 0;
+	t->curr_ret_depth = -1;
 	/* make curr_ret_stack visible before we add the ret_stack */
 	smp_wmb();
 	t->ret_stack = ret_stack;

