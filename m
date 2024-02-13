Return-Path: <linux-kernel+bounces-63462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F54852FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513231F23F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E713E3E485;
	Tue, 13 Feb 2024 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yjFxc8eK"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6403B290
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825058; cv=none; b=CShruLSjr4PP2HJgJbs+xX9kpphFwPKGuVsi3RsXHSTB3+ZIxjlAVgCZfxa4uoAw/Thju4xkojuZwKfQuDwJ5SENS/uzWnKw00VDPBZrySV0SFsxgAESTlSgiXhoQ6+Z3bbyJfihhYOsUI36vXURuKSlS7ZepIXEafP3wSsEv2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825058; c=relaxed/simple;
	bh=MApb/KU3APzxlFgZL+OJ5De3oK1aRzd7YLFeINSgGUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Is82fBWU4ilr7WHmrH1l1mX4l4bgONBnpP0Z9oLXulcuVieCnbIhZwVw/QuVBWkuky98M98sxVyoa2h/YJvnEgFyemELuR2Di8mYxWuzMi5Ncvn6vjNDpLWEBK5dCNYVAtStjYN7wNK+y5c2dnr3UOWWvbaWHvESzYssM37TYFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yjFxc8eK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40e435a606aso27029505e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707825055; x=1708429855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iC3ltUXDHiI03h8nicKfbM5lCCaHJc2Ye8xyZlGM6ac=;
        b=yjFxc8eKVfPkKAXtreGzaSKTXN9hO6P/ILLc4WYSi+dl4b5z+FBGR85lJU1wQ+zPx3
         wEdAKIwvJf5h4qcD+AJH5T5HlPmWSpwEqaNq9M3pd1ZeoX33GJ63/fyMcWx31os+Ylfp
         frnzg2tp9coZBDIkmsmwxoYQVwGTjUzaszw7s1sUekfKeWTyam+Pps9zgI8lHGFSx2T2
         lgagf1DEcCi0tbquB6ZHtaJrpdHsO7ipHb5jUDdYjodB4DkSYTi1r/CDYyMssniDSilX
         YXI8hWglXU3N6Q9pjgB6d5d8MRjqPBWtnEVkcUyFuI3jq7SrLai7u6KQvOkmuZ6wMipu
         UhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707825055; x=1708429855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iC3ltUXDHiI03h8nicKfbM5lCCaHJc2Ye8xyZlGM6ac=;
        b=fCxpxYUem1ZTZvk4UCIOkEl9JK+GBQW7b2b7MQbF4WHDIs49V7gcbuRCl4gbzzeop4
         vnVoWdySMKXJItuNo1GCIlQdG2HHkgFwP7WqE/grKLbTGlS2OxY/ZI7rIJmvIPp43g9b
         f1ys/2NkeuT5kgZjITn2u9rdpCazJH8hWpULiXZZ1d7YtnURV90eCYOXbW13Znc0sEMX
         mNIKITEjDHit/I16cOb9Yb+a3i45AgMXp/5Ez6O0xBO7PJCWgB0Q9yhFyyyjVppe/6Sr
         lBfhnvU6+4vk3pu+ELyta79e5auLs85JX4xJYPqtOCOPhf5ck/P6P5tHFuyrYP7WHTn7
         VvKw==
X-Forwarded-Encrypted: i=1; AJvYcCUKES38+2SqYZGt6YuCjc0AGVBmzXUeW+2U3Zwnv/hbdg18TgwdzmdF+SflZPRWZGFC9tovJXgeNVU1+xPrpzlnq1bCQdsYpbzgnjUB
X-Gm-Message-State: AOJu0Yy7EsPsG48OtHf0G+sq+M6pmrqzrla3+c92raR/KyKRg67bZ7Te
	Ms51xwLRM32l8elSitZawssk9THvQ4Ott9864/e6/6ThCxVlsNt6o1YGbonJUR5N/rkZx6Rhhzs
	ed0Da1Ilf3xCbnyGdog==
X-Google-Smtp-Source: AGHT+IGZuRv+6qm3B3dAcVK5/7QNPIg5zEZrk7PXaV/MKzk/Jbwa+S3pVhOpu7wCixZ/GVvm856I71kz42zLMU0k
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:34c4:b0:411:bbe6:bcf5 with
 SMTP id d4-20020a05600c34c400b00411bbe6bcf5mr22666wmq.7.1707825055336; Tue,
 13 Feb 2024 03:50:55 -0800 (PST)
Date: Tue, 13 Feb 2024 11:49:42 +0000
In-Reply-To: <20240213114945.3528801-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213114945.3528801-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213114945.3528801-4-vdonnefort@google.com>
Subject: [PATCH v17 3/6] tracing: Add snapshot refcount
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When a ring-buffer is memory mapped by user-space, no trace or
ring-buffer swap is possible. This means the snapshot feature is
mutually exclusive with the memory mapping. Having a refcount on
snapshot users will help to know if a mapping is possible or not.

Instead of relying on the global trace_types_lock, a new spinlock is
introduced to serialize accesses to trace_array->snapshot. This intends
to allow access to that variable in a context where the mmap lock is
already held.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a7c6fd934e9..4ebf4d0bd14c 100644
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
@@ -6593,11 +6640,12 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
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
@@ -6606,8 +6654,13 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 
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
@@ -7709,10 +7762,11 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
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
@@ -7722,6 +7776,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
 						 (void *)tr, 1);
 		}
+		tracing_disarm_snapshot(tr);
 		break;
 	default:
 		if (tr->allocated_snapshot) {
@@ -8846,8 +8901,13 @@ ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
 
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
@@ -8866,12 +8926,13 @@ ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
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
@@ -9678,7 +9739,9 @@ trace_array_create_systems(const char *name, const char *systems)
 	raw_spin_lock_init(&tr->start_lock);
 
 	tr->max_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
-
+#ifdef CONFIG_TRCER_MAX_TRACE
+	spinlock_init(&tr->snapshot_trigger_lock);
+#endif
 	tr->current_trace = &nop_trace;
 
 	INIT_LIST_HEAD(&tr->systems);
@@ -10648,7 +10711,9 @@ __init static int tracer_alloc_buffers(void)
 	global_trace.current_trace = &nop_trace;
 
 	global_trace.max_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
-
+#ifdef CONFIG_TRACER_MAX_TRACE
+	spin_lock_init(&global_trace.snapshot_trigger_lock);
+#endif
 	ftrace_init_global_array_ops(&global_trace);
 
 	init_trace_flags_index(&global_trace);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 00f873910c5d..bd312e9afe25 100644
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
@@ -1973,12 +1973,16 @@ static inline void trace_event_eval_update(struct trace_eval_map **map, int len)
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
2.43.0.687.g38aa6559b0-goog


