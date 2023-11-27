Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1311D7FA1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjK0OBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjK0N7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:59:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C357211E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:56:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285FDC433D9;
        Mon, 27 Nov 2023 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701093391;
        bh=bEmKPtX4VZv4hW/cbKkJPMLtohKC5T+Wkpa4vqI+jos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1tvLS6tXxcXoAmkiTRlCNz31Btw7dOkdmRJJbtaLc3BdJEkAalkPC2QYfqd/KvON
         k6dQotJjBDlznb8Jhn8cZwKWATdb9NrlRf12eYASmWIKJcqGgud72DBrKGTGhIM8c4
         UYWtM5x84kQBMb9E6dg1njZBJqSChatXy678QXiCPABCPduItxojo2am30TMxLP+D6
         KpkGJHJLqZuy5BFM/ABUNmLG+xxhmJgIzJ4MJMjHJ1OA2KCk2FhQM319/UNc/yyTXF
         QNm9KyJJtHj7JBPI9F1m/5tAg64ltdAaqVhdDT1KwQ8ECUfz+en7MCGtaQLVre/w3m
         rhdC3E/569svA==
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
Subject: [PATCH v3 17/33] function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
Date:   Mon, 27 Nov 2023 22:56:24 +0900
Message-Id: <170109338411.343914.7434126754301624440.stgit@devnote2>
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

Added functions that can be called by a fgraph_ops entryfunc and retfunc to
store state between the entry of the function being traced to the exit of
the same function. The fgraph_ops entryfunc() may call
fgraph_reserve_data() to store up to 32 words onto the task's shadow
ret_stack and this then can be retrieved by fgraph_retrieve_data() called
by the corresponding retfunc().

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Store fgraph_array index to the data entry.
  - Both function requires fgraph_array index to store/retrieve data.
  - Reserve correct size of the data.
  - Return correct data area.
 Changes in v2:
  - Retrieve the reserved size by fgraph_retrieve_data().
  - Expand the maximum data size to 32 words.
  - Update stack index with __get_index(val) if FGRAPH_TYPE_ARRAY entry.
  - fix typos and make description lines shorter than 76 chars.
---
 include/linux/ftrace.h |    3 +
 kernel/trace/fgraph.c  |  175 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 170 insertions(+), 8 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 09ca4bba63f2..1c121237016e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1075,6 +1075,9 @@ struct fgraph_ops {
 	int				idx;
 };
 
+void *fgraph_reserve_data(int idx, int size_bytes);
+void *fgraph_retrieve_data(int idx, int *size_bytes);
+
 /*
  * Stack of return addresses for functions
  * of a thread.
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d1981fe8edf0..317202943936 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -41,17 +41,29 @@
  * bits: 10 - 11	Type of storage
  *			  0 - reserved
  *			  1 - bitmap of fgraph_array index
+ *			  2 - reserved data
  *
  * For bitmap of fgraph_array index
  *  bits: 12 - 27	The bitmap of fgraph_ops fgraph_array index
  *
+ * For reserved data:
+ *  bits: 12 - 17	The size in words that is stored
+ *  bits: 18 - 23	The index of fgraph_array, which shows who is stored
+ *
  * That is, at the end of function_graph_enter, if the first and forth
  * fgraph_ops on the fgraph_array[] (index 0 and 3) needs their retfunc called
- * on the return of the function being traced, this is what will be on the
- * task's shadow ret_stack: (the stack grows upward)
+ * on the return of the function being traced, and the forth fgraph_ops
+ * stored two words of data, this is what will be on the task's shadow
+ * ret_stack: (the stack grows upward)
  *
  * |                                            | <- task->curr_ret_stack
  * +--------------------------------------------+
+ * | data_type(idx:3, size:2,                   |
+ * |           offset:FGRAPH_RET_INDEX+3)       | ( Data with size of 2 words)
+ * +--------------------------------------------+ ( It is 4 words from the ret_stack)
+ * |            STORED DATA WORD 2              |
+ * |            STORED DATA WORD 1              |
+ * +------i-------------------------------------+
  * | bitmap_type(bitmap:(BIT(3)|BIT(0)),        |
  * |             offset:FGRAPH_RET_INDEX)       | <- the offset is from here
  * +--------------------------------------------+
@@ -78,14 +90,23 @@
 enum {
 	FGRAPH_TYPE_RESERVED	= 0,
 	FGRAPH_TYPE_BITMAP	= 1,
+	FGRAPH_TYPE_DATA	= 2,
 };
 
 #define FGRAPH_INDEX_SIZE	16
 #define FGRAPH_INDEX_MASK	GENMASK(FGRAPH_INDEX_SIZE - 1, 0)
 #define FGRAPH_INDEX_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
 
-/* Currently the max stack index can't be more than register callers */
-#define FGRAPH_MAX_INDEX	(FGRAPH_INDEX_SIZE + FGRAPH_RET_INDEX)
+#define FGRAPH_DATA_SIZE	5
+#define FGRAPH_DATA_MASK	((1 << FGRAPH_DATA_SIZE) - 1)
+#define FGRAPH_DATA_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
+
+#define FGRAPH_DATA_INDEX_SIZE	4
+#define FGRAPH_DATA_INDEX_MASK	((1 << FGRAPH_DATA_INDEX_SIZE) - 1)
+#define FGRAPH_DATA_INDEX_SHIFT	(FGRAPH_DATA_SHIFT + FGRAPH_DATA_SIZE)
+
+#define FGRAPH_MAX_INDEX	\
+	((FGRAPH_INDEX_SIZE << FGRAPH_DATA_SIZE) + FGRAPH_RET_INDEX)
 
 #define FGRAPH_ARRAY_SIZE	FGRAPH_INDEX_SIZE
 
@@ -97,6 +118,8 @@ enum {
 
 #define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
 
+#define FGRAPH_MAX_DATA_SIZE (sizeof(long) * (1 << FGRAPH_DATA_SIZE))
+
 /*
  * Each fgraph_ops has a reservered unsigned long at the end (top) of the
  * ret_stack to store task specific state.
@@ -111,14 +134,39 @@ static int fgraph_array_cnt;
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 
+static inline int __get_index(unsigned long val)
+{
+	return val & FGRAPH_RET_INDEX_MASK;
+}
+
+static inline int __get_type(unsigned long val)
+{
+	return (val >> FGRAPH_TYPE_SHIFT) & FGRAPH_TYPE_MASK;
+}
+
+static inline int __get_data_index(unsigned long val)
+{
+	return (val >> FGRAPH_DATA_INDEX_SHIFT) & FGRAPH_DATA_INDEX_MASK;
+}
+
+static inline int __get_data_size(unsigned long val)
+{
+	return (val >> FGRAPH_DATA_SHIFT) & FGRAPH_DATA_MASK;
+}
+
+static inline unsigned long get_fgraph_entry(struct task_struct *t, int index)
+{
+	return t->ret_stack[index];
+}
+
 static inline int get_ret_stack_index(struct task_struct *t, int offset)
 {
-	return t->ret_stack[offset] & FGRAPH_RET_INDEX_MASK;
+	return __get_index(t->ret_stack[offset]);
 }
 
 static inline int get_fgraph_type(struct task_struct *t, int offset)
 {
-	return (t->ret_stack[offset] >> FGRAPH_TYPE_SHIFT) & FGRAPH_TYPE_MASK;
+	return __get_type(t->ret_stack[offset]);
 }
 
 static inline unsigned long
@@ -145,6 +193,22 @@ add_fgraph_index_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
 	t->ret_stack[offset] |= (bitmap << FGRAPH_INDEX_SHIFT);
 }
 
+static inline void *get_fgraph_data(struct task_struct *t, int index)
+{
+	unsigned long val = t->ret_stack[index];
+
+	if (__get_type(val) != FGRAPH_TYPE_DATA)
+		return NULL;
+	index -= __get_data_size(val);
+	return (void *)&t->ret_stack[index];
+}
+
+static inline unsigned long make_fgraph_data(int idx, int size, int offset)
+{
+	return (idx << FGRAPH_DATA_INDEX_SHIFT) | (size << FGRAPH_DATA_SHIFT) |
+		(FGRAPH_TYPE_DATA << FGRAPH_TYPE_SHIFT) | offset;
+}
+
 /* ftrace_graph_entry set to this to tell some archs to run function graph */
 static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops)
 {
@@ -178,6 +242,92 @@ static void ret_stack_init_task_vars(unsigned long *ret_stack)
 	memset(gvals, 0, sizeof(*gvals) * FGRAPH_ARRAY_SIZE);
 }
 
+/**
+ * fgraph_reserve_data - Reserve storage on the task's ret_stack
+ * @idx:	The index of fgraph_array
+ * @size_bytes: The size in bytes to reserve
+ *
+ * Reserves space of up to FGRAPH_MAX_DATA_SIZE bytes on the
+ * task's ret_stack shadow stack, for a given fgraph_ops during
+ * the entryfunc() call. If entryfunc() returns zero, the storage
+ * is discarded. An entryfunc() can only call this once per iteration.
+ * The fgraph_ops retfunc() can retrieve this stored data with
+ * fgraph_retrieve_data().
+ *
+ * Returns: On success, a pointer to the data on the stack.
+ *   Otherwise, NULL if there's not enough space left on the
+ *   ret_stack for the data, or if fgraph_reserve_data() was called
+ *   more than once for a single entryfunc() call.
+ */
+void *fgraph_reserve_data(int idx, int size_bytes)
+{
+	unsigned long val;
+	void *data;
+	int curr_ret_stack = current->curr_ret_stack;
+	int data_size;
+
+	if (size_bytes > FGRAPH_MAX_DATA_SIZE)
+		return NULL;
+
+	/* Convert to number of longs + data word */
+	data_size = DIV_ROUND_UP(size_bytes, sizeof(long));
+
+	val = get_fgraph_entry(current, curr_ret_stack - 1);
+	data = &current->ret_stack[curr_ret_stack];
+
+	curr_ret_stack += data_size + 1;
+	if (unlikely(curr_ret_stack >= SHADOW_STACK_MAX_INDEX))
+		return NULL;
+
+	val = make_fgraph_data(idx, data_size, __get_index(val) + data_size + 1);
+
+	/* Set the last word to be reserved */
+	current->ret_stack[curr_ret_stack - 1] = val;
+
+	/* Make sure interrupts see this */
+	barrier();
+	current->curr_ret_stack = curr_ret_stack;
+	/* Again sync with interrupts, and reset reserve */
+	current->ret_stack[curr_ret_stack - 1] = val;
+
+	return data;
+}
+
+/**
+ * fgraph_retrieve_data - Retrieve stored data from fgraph_reserve_data()
+ * @idx:	the index of fgraph_array (fgraph_ops::idx)
+ * @size_bytes: pointer to retrieved data size.
+ *
+ * This is to be called by a fgraph_ops retfunc(), to retrieve data that
+ * was stored by the fgraph_ops entryfunc() on the function entry.
+ * That is, this will retrieve the data that was reserved on the
+ * entry of the function that corresponds to the exit of the function
+ * that the fgraph_ops retfunc() is called on.
+ *
+ * Returns: The stored data from fgraph_reserve_data() called by the
+ *    matching entryfunc() for the retfunc() this is called from.
+ *   Or NULL if there was nothing stored.
+ */
+void *fgraph_retrieve_data(int idx, int *size_bytes)
+{
+	int index = current->curr_ret_stack - 1;
+	unsigned long val;
+
+	val = get_fgraph_entry(current, index);
+	while (__get_type(val) == FGRAPH_TYPE_DATA) {
+		if (__get_data_index(val) == idx)
+			goto found;
+		index -= __get_data_size(val) + 1;
+		val = get_fgraph_entry(current, index);
+	}
+	return NULL;
+found:
+	if (size_bytes)
+		*size_bytes = __get_data_size(val) *
+			      sizeof(long);
+	return get_fgraph_data(current, index);
+}
+
 /**
  * fgraph_get_task_var - retrieve a task specific state variable
  * @gops: The ftrace_ops that owns the task specific variable
@@ -424,13 +574,18 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 	for (i = 0; i < fgraph_array_cnt; i++) {
 		struct fgraph_ops *gops = fgraph_array[i];
+		int save_curr_ret_stack;
 
 		if (gops == &fgraph_stub)
 			continue;
 
+		save_curr_ret_stack = current->curr_ret_stack;
 		if (ftrace_ops_test(&gops->ops, func, NULL) &&
 		    gops->entryfunc(&trace, gops))
 			bitmap |= BIT(i);
+		else
+			/* Clear out any saved storage */
+			current->curr_ret_stack = save_curr_ret_stack;
 	}
 
 	if (!bitmap)
@@ -452,6 +607,7 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 			     struct fgraph_ops *gops)
 {
 	struct ftrace_graph_ent trace;
+	int save_curr_ret_stack;
 	int index;
 	int type;
 
@@ -468,13 +624,15 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
 
 	trace.func = func;
 	trace.depth = current->curr_ret_depth;
+	save_curr_ret_stack = current->curr_ret_stack;
 	if (gops->entryfunc(&trace, gops)) {
 		if (type == FGRAPH_TYPE_RESERVED)
 			set_fgraph_index_bitmap(current, index, BIT(gops->idx));
 		else
 			add_fgraph_index_bitmap(current, index, BIT(gops->idx));
 		return 0;
-	}
+	} else
+		current->curr_ret_stack = save_curr_ret_stack;
 
 	if (type == FGRAPH_TYPE_RESERVED) {
 		current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
@@ -619,7 +777,8 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	 * curr_ret_stack is after that.
 	 */
 	barrier();
-	current->curr_ret_stack -= FGRAPH_RET_INDEX + 1;
+	current->curr_ret_stack = index - FGRAPH_RET_INDEX;
+
 	current->curr_ret_depth--;
 	return ret;
 }

