Return-Path: <linux-kernel+bounces-35160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CB5838CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9058C28D8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4CF5D911;
	Tue, 23 Jan 2024 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ghj0L04f"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C245D8F6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008091; cv=none; b=qnMns1/6goiv6ac++Uo3mkU2pnuQPQ+wHZ7lJIYyw4sJtwjQJCrsVgmB7wvcTi7ZblsTJTWDLsgDY2EteUF+0Be88nDKQ56juQltj0/ZIVCZMJ3ue/QQ6N6cbtPCfDQ+YnAdXcBIrTEziV3FCS/oCdblbmoGGd0nVh9pYqbBdiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008091; c=relaxed/simple;
	bh=L2LAOFcpz374aq8+MhwwriEORj7D1Fxmja4Be/sRvZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ozw+8jeLYz19ZxMX2bB0lOraZwX6mtmOf30MSy9Sm5F98I+/KwlCHvNLnJMdagfLYBMY298S0MztMdoZMvt9303XODQq9sn9KFatb8Ekan9YYN6xzLqzTaqx4apOTC4gob7Gy53/6g7NNYzNavuxdb1cFUTOOGVJ3hErZ/8uISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ghj0L04f; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40eba1f0aa7so5172415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706008088; x=1706612888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C10/Kn1e0NHjWL/pUEbGc+DKo3L2nbmZjaNGz+IRIn0=;
        b=Ghj0L04fB+IXnYlTr3pePiNnxWIVK8qXhXledyGj3StiR+73dXLqwVbANwlQb11QYV
         Bj8TnG7VcoptP3MDSscf3rQSf1uDap5X36i0doGDg1A/AvcdJuDOlT5Co4LB78cY3tdx
         Ccj1Nmu+ak3TNAQP3CNlbOk1Uf6cO9u9eabgLjn4EzAXSK3PxnOIxx9bQXRciovdPRP9
         Isfi0SuvrFGhKu7mQ7MdX/hOVROHIsdf7+uhx4FHIRP6qqC47MVskbLDmPU4JTH5PU19
         3oynR6+WCJAEFyRhuNhxvXw9Qn3b6G+AkSGb3JxIq4q58hXCRvUPEtf0CUCg+yG4DqkE
         yddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706008088; x=1706612888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C10/Kn1e0NHjWL/pUEbGc+DKo3L2nbmZjaNGz+IRIn0=;
        b=FiJzV1tA617rWbr9mdtnNTk0HdoXL6jtiSrrpTVi+JK8BM1CJh230P1NDNq0mOHVhV
         dnCXD4/04fSFrdvD8sup2ZmaCw9yV5SAmuAR1wyIqK97hOo9yGNj2d9eMPtuK7xopPoA
         SQZKTt1PRmXtWvbTEwOAmWwD/TBIxVUVUk4aqSJOePdvbnYZxDYoSwmhfIqymRBfELsL
         fjYwvS7kNsZMrEW+wXZ8TcPTLP5gHN+rWq2AAyXWJTcvTqJAQhZzuCT0MoCZt+bm21q4
         +EP4DkV9EAzwekEXxOkHqWIccwXrDeMoZwjqhHQ8Irogc/tRuW04w9E2AG/7M+fL0mgV
         xVcg==
X-Gm-Message-State: AOJu0YyxO1CvN4AqbY1ClP+b1JAoTw4R2aGVb1RJsY4maoI/tTvDcnwB
	H04CVGQNygf+Cu00+GTvrWJ3EHo6J8XLuEQTuV3cMZg4ulXKuldh7Slj6j9/voLOR5k4MSoF3Rk
	j4PK/kfzG54aNFZ2qZA==
X-Google-Smtp-Source: AGHT+IETut/KeUEf/hyk0DzZNYHBiDsdkOSjSLyD8KgYdpxYYFNiOA07t2gQdW1neiibQsN+R5V32m0jfeL9hJ8y
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1d90:b0:40e:b31e:7a5b with
 SMTP id p16-20020a05600c1d9000b0040eb31e7a5bmr30139wms.0.1706008088208; Tue,
 23 Jan 2024 03:08:08 -0800 (PST)
Date: Tue, 23 Jan 2024 11:07:54 +0000
In-Reply-To: <20240123110757.3657908-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123110757.3657908-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123110757.3657908-4-vdonnefort@google.com>
Subject: [PATCH v12 3/6] tracing: Add snapshot refcount
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

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 46dbe22121e9..ac59321a8d95 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1300,6 +1300,52 @@ static void free_snapshot(struct trace_array *tr)
 	tr->allocated_snapshot = false;
 }
 
+static int tracing_arm_snapshot_locked(struct trace_array *tr)
+{
+	int ret;
+
+	lockdep_assert_held(&trace_types_lock);
+
+	if (tr->snapshot == UINT_MAX)
+		return -EBUSY;
+
+	ret = tracing_alloc_snapshot_instance(tr);
+	if (ret)
+		return ret;
+
+	tr->snapshot++;
+
+	return 0;
+}
+
+static void tracing_disarm_snapshot_locked(struct trace_array *tr)
+{
+	lockdep_assert_held(&trace_types_lock);
+
+	if (WARN_ON(!tr->snapshot))
+		return;
+
+	tr->snapshot--;
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
+	mutex_lock(&trace_types_lock);
+	tracing_disarm_snapshot_locked(tr);
+	mutex_unlock(&trace_types_lock);
+}
+
 /**
  * tracing_alloc_snapshot - allocate snapshot buffer.
  *
@@ -1373,10 +1419,6 @@ int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
 
 	mutex_lock(&trace_types_lock);
 
-	ret = tracing_alloc_snapshot_instance(tr);
-	if (ret)
-		goto fail_unlock;
-
 	if (tr->current_trace->use_max_tr) {
 		ret = -EBUSY;
 		goto fail_unlock;
@@ -1395,6 +1437,10 @@ int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
 		goto fail_unlock;
 	}
 
+	ret = tracing_arm_snapshot_locked(tr);
+	if (ret)
+		goto fail_unlock;
+
 	local_irq_disable();
 	arch_spin_lock(&tr->max_lock);
 	tr->cond_snapshot = cond_snapshot;
@@ -1439,6 +1485,8 @@ int tracing_snapshot_cond_disable(struct trace_array *tr)
 	arch_spin_unlock(&tr->max_lock);
 	local_irq_enable();
 
+	tracing_disarm_snapshot(tr);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(tracing_snapshot_cond_disable);
@@ -6579,11 +6627,12 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 		 */
 		synchronize_rcu();
 		free_snapshot(tr);
+		tracing_disarm_snapshot_locked(tr);
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
@@ -6592,8 +6641,11 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 
 	if (t->init) {
 		ret = tracer_init(t, tr);
-		if (ret)
+		if (ret) {
+			if (t->use_max_tr)
+				tracing_disarm_snapshot_locked(tr);
 			goto out;
+		}
 	}
 
 	tr->current_trace = t;
@@ -7695,10 +7747,11 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
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
@@ -7708,6 +7761,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
 						 (void *)tr, 1);
 		}
+		tracing_disarm_snapshot_locked(tr);
 		break;
 	default:
 		if (tr->allocated_snapshot) {
@@ -8832,8 +8886,13 @@ ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
 
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
@@ -8852,12 +8911,13 @@ ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
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
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 00f873910c5d..3aa06bd5e48d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -334,6 +334,7 @@ struct trace_array {
 	 */
 	struct array_buffer	max_buffer;
 	bool			allocated_snapshot;
+	unsigned int		snapshot;
 #endif
 #ifdef CONFIG_TRACER_MAX_TRACE
 	unsigned long		max_latency;
@@ -1973,12 +1974,16 @@ static inline void trace_event_eval_update(struct trace_eval_map **map, int len)
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
index 46439e3bcec4..d41bf64741e2 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -597,20 +597,9 @@ static int register_trigger(char *glob,
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
- */
-static void unregister_trigger(char *glob,
-			       struct event_trigger_data *test,
-			       struct trace_event_file *file)
+static bool __unregister_trigger(char *glob,
+				 struct event_trigger_data *test,
+				 struct trace_event_file *file)
 {
 	struct event_trigger_data *data = NULL, *iter;
 
@@ -626,8 +615,32 @@ static void unregister_trigger(char *glob,
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
+	__unregister_trigger(glob, test, file);
 }
 
 /*
@@ -1470,12 +1483,20 @@ register_snapshot_trigger(char *glob,
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
-	if (tracing_alloc_snapshot_instance(file->tr) != 0)
+	if (tracing_arm_snapshot(file->tr))
 		return 0;
 
 	return register_trigger(glob, data, file);
 }
 
+static void unregister_snapshot_trigger(char *glob,
+					struct event_trigger_data *data,
+					struct trace_event_file *file)
+{
+	if (__unregister_trigger(glob, data, file))
+		tracing_disarm_snapshot(file->tr);
+}
+
 static int
 snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 {
@@ -1508,7 +1529,7 @@ static struct event_command trigger_snapshot_cmd = {
 	.trigger_type		= ETT_SNAPSHOT,
 	.parse			= event_trigger_parse,
 	.reg			= register_snapshot_trigger,
-	.unreg			= unregister_trigger,
+	.unreg			= unregister_snapshot_trigger,
 	.get_trigger_ops	= snapshot_get_trigger_ops,
 	.set_filter		= set_trigger_filter,
 };
-- 
2.43.0.429.g432eaa2c6b-goog


