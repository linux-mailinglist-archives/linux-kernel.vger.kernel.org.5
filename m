Return-Path: <linux-kernel+bounces-74864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C8285DDB2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F04281675
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6A78063C;
	Wed, 21 Feb 2024 14:06:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E67FBAB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524401; cv=none; b=u95EusGlYIxZ576qaeoUSxhAniQD1y1HbhY0WrcHd0ye7UwxqsTU2eY3kAH7hblV2YgpByg204WP+GO/9DxBofYX2x+QLbeoHwdUt6gNtBNi7vizJ57UZX7NaDrro6PK3evKWqg4ODCA7guA1P8sFA2hAYyQDOuoc0eBcg+ZIaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524401; c=relaxed/simple;
	bh=eyyWOYQCH9WQRXC4Wt570cAK/u/hPo+Ek3C54i8jWXw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WyFijQOev0PZ6gf0ZzDGePv0qLp17MmMzqnveETYYFHpLc3PxotmjvmWNq3C9/hc1hSqdseiieClEzsHhpy5Ly3SjurdJdJs4hv9IfSaAWamlBavLreXFS8i8tldySM11Lp5pGeZWTeE/ORbF/YlXmK8o+3dGus5UR1iBmQDEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008C0C433C7;
	Wed, 21 Feb 2024 14:06:41 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rcnGv-00000002iAp-1C2u;
	Wed, 21 Feb 2024 09:08:29 -0500
Message-ID: <20240221140829.145700395@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 21 Feb 2024 09:08:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 08/11] tracing: Add snapshot refcount
References: <20240221140756.797572998@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

When a ring-buffer is memory mapped by user-space, no trace or
ring-buffer swap is possible. This means the snapshot feature is
mutually exclusive with the memory mapping. Having a refcount on
snapshot users will help to know if a mapping is possible or not.

Instead of relying on the global trace_types_lock, a new spinlock is
introduced to serialize accesses to trace_array->snapshot. This intends
to allow access to that variable in a context where the mmap lock is
already held.

Link: https://lore.kernel.org/linux-trace-kernel/20240220202310.2489614-4-vdonnefort@google.com

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c                | 99 ++++++++++++++++++++++++-----
 kernel/trace/trace.h                |  8 ++-
 kernel/trace/trace_events_trigger.c | 58 ++++++++++++-----
 3 files changed, 129 insertions(+), 36 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 50fab999e72e..2b922a79c553 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1300,6 +1300,50 @@ static void free_snapshot(struct trace_array *tr)
 	tr->allocated_snapshot = false;
 }
 
+static int tracing_arm_snapshot_locked(struct trace_array *tr)
+{
+	int ret;
+
+	lockdep_assert_held(&trace_types_lock);
+
+	spin_lock(&tr->snapshot_trigger_lock);
+	if (tr->snapshot == UINT_MAX) {
+		spin_unlock(&tr->snapshot_trigger_lock);
+		return -EBUSY;
+	}
+
+	tr->snapshot++;
+	spin_unlock(&tr->snapshot_trigger_lock);
+
+	ret = tracing_alloc_snapshot_instance(tr);
+	if (ret) {
+		spin_lock(&tr->snapshot_trigger_lock);
+		tr->snapshot--;
+		spin_unlock(&tr->snapshot_trigger_lock);
+	}
+
+	return ret;
+}
+
+int tracing_arm_snapshot(struct trace_array *tr)
+{
+	int ret;
+
+	mutex_lock(&trace_types_lock);
+	ret = tracing_arm_snapshot_locked(tr);
+	mutex_unlock(&trace_types_lock);
+
+	return ret;
+}
+
+void tracing_disarm_snapshot(struct trace_array *tr)
+{
+	spin_lock(&tr->snapshot_trigger_lock);
+	if (!WARN_ON(!tr->snapshot))
+		tr->snapshot--;
+	spin_unlock(&tr->snapshot_trigger_lock);
+}
+
 /**
  * tracing_alloc_snapshot - allocate snapshot buffer.
  *
@@ -1373,10 +1417,6 @@ int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
 
 	mutex_lock(&trace_types_lock);
 
-	ret = tracing_alloc_snapshot_instance(tr);
-	if (ret)
-		goto fail_unlock;
-
 	if (tr->current_trace->use_max_tr) {
 		ret = -EBUSY;
 		goto fail_unlock;
@@ -1395,6 +1435,10 @@ int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
 		goto fail_unlock;
 	}
 
+	ret = tracing_arm_snapshot_locked(tr);
+	if (ret)
+		goto fail_unlock;
+
 	local_irq_disable();
 	arch_spin_lock(&tr->max_lock);
 	tr->cond_snapshot = cond_snapshot;
@@ -1439,6 +1483,8 @@ int tracing_snapshot_cond_disable(struct trace_array *tr)
 	arch_spin_unlock(&tr->max_lock);
 	local_irq_enable();
 
+	tracing_disarm_snapshot(tr);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(tracing_snapshot_cond_disable);
@@ -1481,6 +1527,7 @@ int tracing_snapshot_cond_disable(struct trace_array *tr)
 }
 EXPORT_SYMBOL_GPL(tracing_snapshot_cond_disable);
 #define free_snapshot(tr)	do { } while (0)
+#define tracing_arm_snapshot_locked(tr) ({ -EBUSY; })
 #endif /* CONFIG_TRACER_SNAPSHOT */
 
 void tracer_tracing_off(struct trace_array *tr)
@@ -6092,11 +6139,12 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 		 */
 		synchronize_rcu();
 		free_snapshot(tr);
+		tracing_disarm_snapshot(tr);
 	}
 
-	if (t->use_max_tr && !tr->allocated_snapshot) {
-		ret = tracing_alloc_snapshot_instance(tr);
-		if (ret < 0)
+	if (t->use_max_tr) {
+		ret = tracing_arm_snapshot_locked(tr);
+		if (ret)
 			goto out;
 	}
 #else
@@ -6105,8 +6153,13 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 
 	if (t->init) {
 		ret = tracer_init(t, tr);
-		if (ret)
+		if (ret) {
+#ifdef CONFIG_TRACER_MAX_TRACE
+			if (t->use_max_tr)
+				tracing_disarm_snapshot(tr);
+#endif
 			goto out;
+		}
 	}
 
 	tr->current_trace = t;
@@ -7208,10 +7261,11 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		if (tr->allocated_snapshot)
 			ret = resize_buffer_duplicate_size(&tr->max_buffer,
 					&tr->array_buffer, iter->cpu_file);
-		else
-			ret = tracing_alloc_snapshot_instance(tr);
-		if (ret < 0)
+
+		ret = tracing_arm_snapshot_locked(tr);
+		if (ret)
 			break;
+
 		/* Now, we're going to swap */
 		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
 			local_irq_disable();
@@ -7221,6 +7275,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
 						 (void *)tr, 1);
 		}
+		tracing_disarm_snapshot(tr);
 		break;
 	default:
 		if (tr->allocated_snapshot) {
@@ -8345,8 +8400,13 @@ ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
 
 	ops = param ? &snapshot_count_probe_ops :  &snapshot_probe_ops;
 
-	if (glob[0] == '!')
-		return unregister_ftrace_function_probe_func(glob+1, tr, ops);
+	if (glob[0] == '!') {
+		ret = unregister_ftrace_function_probe_func(glob+1, tr, ops);
+		if (!ret)
+			tracing_disarm_snapshot(tr);
+
+		return ret;
+	}
 
 	if (!param)
 		goto out_reg;
@@ -8365,12 +8425,13 @@ ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
 		return ret;
 
  out_reg:
-	ret = tracing_alloc_snapshot_instance(tr);
+	ret = tracing_arm_snapshot(tr);
 	if (ret < 0)
 		goto out;
 
 	ret = register_ftrace_function_probe(glob, tr, ops, count);
-
+	if (ret < 0)
+		tracing_disarm_snapshot(tr);
  out:
 	return ret < 0 ? ret : 0;
 }
@@ -9177,7 +9238,9 @@ trace_array_create_systems(const char *name, const char *systems)
 	raw_spin_lock_init(&tr->start_lock);
 
 	tr->max_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
-
+#ifdef CONFIG_TRACER_MAX_TRACE
+	spin_lock_init(&tr->snapshot_trigger_lock);
+#endif
 	tr->current_trace = &nop_trace;
 
 	INIT_LIST_HEAD(&tr->systems);
@@ -10147,7 +10210,9 @@ __init static int tracer_alloc_buffers(void)
 	global_trace.current_trace = &nop_trace;
 
 	global_trace.max_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
-
+#ifdef CONFIG_TRACER_MAX_TRACE
+	spin_lock_init(&global_trace.snapshot_trigger_lock);
+#endif
 	ftrace_init_global_array_ops(&global_trace);
 
 	init_trace_flags_index(&global_trace);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e4f0714d7a49..64450615ca0c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -334,8 +334,8 @@ struct trace_array {
 	 */
 	struct array_buffer	max_buffer;
 	bool			allocated_snapshot;
-#endif
-#ifdef CONFIG_TRACER_MAX_TRACE
+	spinlock_t		snapshot_trigger_lock;
+	unsigned int		snapshot;
 	unsigned long		max_latency;
 #ifdef CONFIG_FSNOTIFY
 	struct dentry		*d_max_latency;
@@ -1983,12 +1983,16 @@ static inline void trace_event_eval_update(struct trace_eval_map **map, int len)
 #ifdef CONFIG_TRACER_SNAPSHOT
 void tracing_snapshot_instance(struct trace_array *tr);
 int tracing_alloc_snapshot_instance(struct trace_array *tr);
+int tracing_arm_snapshot(struct trace_array *tr);
+void tracing_disarm_snapshot(struct trace_array *tr);
 #else
 static inline void tracing_snapshot_instance(struct trace_array *tr) { }
 static inline int tracing_alloc_snapshot_instance(struct trace_array *tr)
 {
 	return 0;
 }
+static inline int tracing_arm_snapshot(struct trace_array *tr) { return 0; }
+static inline void tracing_disarm_snapshot(struct trace_array *tr) { }
 #endif
 
 #ifdef CONFIG_PREEMPT_TRACER
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index b33c3861fbbb..62e4f58b8671 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -597,20 +597,12 @@ static int register_trigger(char *glob,
 	return ret;
 }
 
-/**
- * unregister_trigger - Generic event_command @unreg implementation
- * @glob: The raw string used to register the trigger
- * @test: Trigger-specific data used to find the trigger to remove
- * @file: The trace_event_file associated with the event
- *
- * Common implementation for event trigger unregistration.
- *
- * Usually used directly as the @unreg method in event command
- * implementations.
+/*
+ * True if the trigger was found and unregistered, else false.
  */
-static void unregister_trigger(char *glob,
-			       struct event_trigger_data *test,
-			       struct trace_event_file *file)
+static bool try_unregister_trigger(char *glob,
+				   struct event_trigger_data *test,
+				   struct trace_event_file *file)
 {
 	struct event_trigger_data *data = NULL, *iter;
 
@@ -626,8 +618,32 @@ static void unregister_trigger(char *glob,
 		}
 	}
 
-	if (data && data->ops->free)
-		data->ops->free(data);
+	if (data) {
+		if (data->ops->free)
+			data->ops->free(data);
+
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * unregister_trigger - Generic event_command @unreg implementation
+ * @glob: The raw string used to register the trigger
+ * @test: Trigger-specific data used to find the trigger to remove
+ * @file: The trace_event_file associated with the event
+ *
+ * Common implementation for event trigger unregistration.
+ *
+ * Usually used directly as the @unreg method in event command
+ * implementations.
+ */
+static void unregister_trigger(char *glob,
+			       struct event_trigger_data *test,
+			       struct trace_event_file *file)
+{
+	try_unregister_trigger(glob, test, file);
 }
 
 /*
@@ -1470,7 +1486,7 @@ register_snapshot_trigger(char *glob,
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
-	int ret = tracing_alloc_snapshot_instance(file->tr);
+	int ret = tracing_arm_snapshot(file->tr);
 
 	if (ret < 0)
 		return ret;
@@ -1478,6 +1494,14 @@ register_snapshot_trigger(char *glob,
 	return register_trigger(glob, data, file);
 }
 
+static void unregister_snapshot_trigger(char *glob,
+					struct event_trigger_data *data,
+					struct trace_event_file *file)
+{
+	if (try_unregister_trigger(glob, data, file))
+		tracing_disarm_snapshot(file->tr);
+}
+
 static int
 snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 {
@@ -1510,7 +1534,7 @@ static struct event_command trigger_snapshot_cmd = {
 	.trigger_type		= ETT_SNAPSHOT,
 	.parse			= event_trigger_parse,
 	.reg			= register_snapshot_trigger,
-	.unreg			= unregister_trigger,
+	.unreg			= unregister_snapshot_trigger,
 	.get_trigger_ops	= snapshot_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
 };
-- 
2.43.0



