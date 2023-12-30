Return-Path: <linux-kernel+bounces-13455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD9D8206DC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109BCB212A8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8FD8F77;
	Sat, 30 Dec 2023 15:20:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A238F5C
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 15:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78ABBC433C8;
	Sat, 30 Dec 2023 15:20:41 +0000 (UTC)
Date: Sat, 30 Dec 2023 10:21:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] tracing: Fixes for 6.7-rc7
Message-ID: <20231230102134.149235d7@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Linus,

[
  This is on top of the last pull request you wanted to wait on:
    https://lore.kernel.org/all/20231222082959.7d08894a@gandalf.local.home/

  This current pull request has nothing to do with eventfs, but more
  with errors found in reading the ring buffer as well as direct
  callbacks from ftrace.
]

tracing fixes for v6.7-rc7:

- Fix readers that are blocked on the ring buffer when buffer_percent is
  100%. They are supposed to wake up when the buffer is full, but
  because the sub-buffer that the writer is on is never considered
  "dirty" in the calculation, dirty pages will never equal nr_pages.
  Add +1 to the dirty count in order to count for the sub-buffer that
  the writer is on.

- When a reader is blocked on the "snapshot_raw" file, it is to be
  woken up when a snapshot is done and be able to read the snapshot
  buffer. But because the snapshot swaps the buffers (the main one
  with the snapshot one), and the snapshot reader is waiting on the
  old snapshot buffer, it was not woken up (because it is now on
  the main buffer after the swap). Worse yet, when it reads the buffer
  after a snapshot, it's not reading the snapshot buffer, it's reading
  the live active main buffer.

  Fix this by forcing a wakeup of all readers on the snapshot buffer when
  a new snapshot happens, and then update the buffer that the reader
  is reading to be back on the snapshot buffer.

- Fix the modification of the direct_function hash. There was a race
  when new functions were added to the direct_function hash as when
  it moved function entries from the old hash to the new one, a direct
  function trace could be hit and not see its entry.

  This is fixed by allocating the new hash, copy all the old entries
  onto it as well as the new entries, and then use rcu_assign_pointer()
  to update the new direct_function hash with it.

  This also fixes a memory leak in that code.


Please pull the latest trace-v6.7-rc7 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.7-rc7

Tag SHA1: c7f52a28c2ee2edb40e4884b45e3a12440ee6774
Head SHA1: d05cb470663a2a1879277e544f69e660208f08f2


Steven Rostedt (Google) (3):
      ring-buffer: Fix wake ups when buffer_percent is set to 100
      tracing: Fix blocked reader of snapshot buffer
      ftrace: Fix modification of direct_function hash while in use

----
 kernel/trace/ftrace.c      | 100 +++++++++++++++++++++------------------------
 kernel/trace/ring_buffer.c |  12 ++++--
 kernel/trace/trace.c       |  20 +++++++--
 3 files changed, 73 insertions(+), 59 deletions(-)
---------------------------
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8de8bec5f366..b01ae7d36021 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1183,18 +1183,19 @@ static void __add_hash_entry(struct ftrace_hash *hash,
 	hash->count++;
 }
 
-static int add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
+static struct ftrace_func_entry *
+add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
 {
 	struct ftrace_func_entry *entry;
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
-		return -ENOMEM;
+		return NULL;
 
 	entry->ip = ip;
 	__add_hash_entry(hash, entry);
 
-	return 0;
+	return entry;
 }
 
 static void
@@ -1349,7 +1350,6 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *new_hash;
 	int size;
-	int ret;
 	int i;
 
 	new_hash = alloc_ftrace_hash(size_bits);
@@ -1366,8 +1366,7 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			ret = add_hash_entry(new_hash, entry->ip);
-			if (ret < 0)
+			if (add_hash_entry(new_hash, entry->ip) == NULL)
 				goto free_hash;
 		}
 	}
@@ -2536,7 +2535,7 @@ ftrace_find_unique_ops(struct dyn_ftrace *rec)
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /* Protected by rcu_tasks for reading, and direct_mutex for writing */
-static struct ftrace_hash *direct_functions = EMPTY_HASH;
+static struct ftrace_hash __rcu *direct_functions = EMPTY_HASH;
 static DEFINE_MUTEX(direct_mutex);
 int ftrace_direct_func_count;
 
@@ -2555,39 +2554,6 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 	return entry->direct;
 }
 
-static struct ftrace_func_entry*
-ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
-		      struct ftrace_hash **free_hash)
-{
-	struct ftrace_func_entry *entry;
-
-	if (ftrace_hash_empty(direct_functions) ||
-	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
-		struct ftrace_hash *new_hash;
-		int size = ftrace_hash_empty(direct_functions) ? 0 :
-			direct_functions->count + 1;
-
-		if (size < 32)
-			size = 32;
-
-		new_hash = dup_hash(direct_functions, size);
-		if (!new_hash)
-			return NULL;
-
-		*free_hash = direct_functions;
-		direct_functions = new_hash;
-	}
-
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return NULL;
-
-	entry->ip = ip;
-	entry->direct = addr;
-	__add_hash_entry(direct_functions, entry);
-	return entry;
-}
-
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
@@ -4223,8 +4189,8 @@ enter_record(struct ftrace_hash *hash, struct dyn_ftrace *rec, int clear_filter)
 		/* Do nothing if it exists */
 		if (entry)
 			return 0;
-
-		ret = add_hash_entry(hash, rec->ip);
+		if (add_hash_entry(hash, rec->ip) == NULL)
+			ret = -ENOMEM;
 	}
 	return ret;
 }
@@ -5266,7 +5232,8 @@ __ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 		return 0;
 	}
 
-	return add_hash_entry(hash, ip);
+	entry = add_hash_entry(hash, ip);
+	return entry ? 0 :  -ENOMEM;
 }
 
 static int
@@ -5410,7 +5377,7 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
  */
 int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
-	struct ftrace_hash *hash, *free_hash = NULL;
+	struct ftrace_hash *hash, *new_hash = NULL, *free_hash = NULL;
 	struct ftrace_func_entry *entry, *new;
 	int err = -EBUSY, size, i;
 
@@ -5436,17 +5403,44 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 		}
 	}
 
-	/* ... and insert them to direct_functions hash. */
 	err = -ENOMEM;
+
+	/* Make a copy hash to place the new and the old entries in */
+	size = hash->count + direct_functions->count;
+	if (size > 32)
+		size = 32;
+	new_hash = alloc_ftrace_hash(fls(size));
+	if (!new_hash)
+		goto out_unlock;
+
+	/* Now copy over the existing direct entries */
+	size = 1 << direct_functions->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &direct_functions->buckets[i], hlist) {
+			new = add_hash_entry(new_hash, entry->ip);
+			if (!new)
+				goto out_unlock;
+			new->direct = entry->direct;
+		}
+	}
+
+	/* ... and add the new entries */
+	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			new = ftrace_add_rec_direct(entry->ip, addr, &free_hash);
+			new = add_hash_entry(new_hash, entry->ip);
 			if (!new)
-				goto out_remove;
+				goto out_unlock;
+			/* Update both the copy and the hash entry */
+			new->direct = addr;
 			entry->direct = addr;
 		}
 	}
 
+	free_hash = direct_functions;
+	rcu_assign_pointer(direct_functions, new_hash);
+	new_hash = NULL;
+
 	ops->func = call_direct_funcs;
 	ops->flags = MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
@@ -5454,17 +5448,17 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	err = register_ftrace_function_nolock(ops);
 
- out_remove:
-	if (err)
-		remove_direct_functions_hash(hash, addr);
-
  out_unlock:
 	mutex_unlock(&direct_mutex);
 
-	if (free_hash) {
+	if (free_hash && free_hash != EMPTY_HASH) {
 		synchronize_rcu_tasks();
 		free_ftrace_hash(free_hash);
 	}
+
+	if (new_hash)
+		free_ftrace_hash(new_hash);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(register_ftrace_direct);
@@ -6309,7 +6303,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 
 				if (entry)
 					continue;
-				if (add_hash_entry(hash, rec->ip) < 0)
+				if (add_hash_entry(hash, rec->ip) == NULL)
 					goto out;
 			} else {
 				if (entry) {
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 83eab547f1d1..9286f88fcd32 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -881,9 +881,14 @@ static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int f
 	if (!nr_pages || !full)
 		return true;
 
-	dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
+	/*
+	 * Add one as dirty will never equal nr_pages, as the sub-buffer
+	 * that the writer is on is not counted as dirty.
+	 * This is needed if "buffer_percent" is set to 100.
+	 */
+	dirty = ring_buffer_nr_dirty_pages(buffer, cpu) + 1;
 
-	return (dirty * 100) > (full * nr_pages);
+	return (dirty * 100) >= (full * nr_pages);
 }
 
 /*
@@ -944,7 +949,8 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 	/* make sure the waiters see the new index */
 	smp_wmb();
 
-	rb_wake_up_waiters(&rbwork->work);
+	/* This can be called in any context */
+	irq_work_queue(&rbwork->work);
 }
 
 /**
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 199df497db07..a0defe156b57 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1894,6 +1894,9 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 	__update_max_tr(tr, tsk, cpu);
 
 	arch_spin_unlock(&tr->max_lock);
+
+	/* Any waiters on the old snapshot buffer need to wake up */
+	ring_buffer_wake_waiters(tr->array_buffer.buffer, RING_BUFFER_ALL_CPUS);
 }
 
 /**
@@ -1945,12 +1948,23 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 static int wait_on_pipe(struct trace_iterator *iter, int full)
 {
+	int ret;
+
 	/* Iterators are static, they should be filled or empty */
 	if (trace_buffer_iter(iter, iter->cpu_file))
 		return 0;
 
-	return ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file,
-				full);
+	ret = ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file, full);
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	/*
+	 * Make sure this is still the snapshot buffer, as if a snapshot were
+	 * to happen, this would now be the main buffer.
+	 */
+	if (iter->snapshot)
+		iter->array_buffer = &iter->tr->max_buffer;
+#endif
+	return ret;
 }
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
@@ -8517,7 +8531,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 
 		wait_index = READ_ONCE(iter->wait_index);
 
-		ret = wait_on_pipe(iter, iter->tr->buffer_percent);
+		ret = wait_on_pipe(iter, iter->snapshot ? 0 : iter->tr->buffer_percent);
 		if (ret)
 			goto out;
 

