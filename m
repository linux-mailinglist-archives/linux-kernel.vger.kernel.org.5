Return-Path: <linux-kernel+bounces-42901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3726A84084A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67F51F260ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E49B1272AC;
	Mon, 29 Jan 2024 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0afKLLTx"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE785C64
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538500; cv=none; b=beSi1noWbvH1m9Scl2kYvCS/1fZ0rXvtFZxOsEUMzFmZnRqOVGFIoQj0AfSzT/gWA6gP1iq2UdhgzkDPqvsRiIplPK0qL+nrebahu4NB4uLl3st3ux/s9KwG/BLuMiaSNYW89OnSxwKA9b+ysNVHeF2PzK4arUySh7fE1WoKA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538500; c=relaxed/simple;
	bh=E6UNj21N9nGf6EXoj+iWwGVYkleK4uyYB0kIXGMO3ko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P15LijlXf7urtXGLvfq/ZqX2n4uD+MSjqErpCNHzRhgpwkHAjVyGaSldWoFIchguggvQuO7Xq7ojmthNCtNS3h7jzpkjJpK/euMOelY9jJRllcH2Z3h7xGOtUKYABzm3y/Ho5bVNw9u/QCXBm1PL2mDVrZEZf7YdzuBwYjjvqFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0afKLLTx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ff7eabfd94so41547897b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706538497; x=1707143297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7MsjY0/2c9mGaJnQcEyejruJlnIDyMNckUiDR6Tnrs=;
        b=0afKLLTx1FBLaZ/Q6refGm5kUff6rJ/uW/QKoeqdTf6Uk/rG+QXDiyVUg0v+zFtPKA
         O3bwBDg5XbpvxAqoHMl+3dhkLRM+fVWpl2Qgj02hOCl/8UNzqEvex60N9kWoi/3yd7IS
         AOriC3MwSdw3yl1q7KBbMfgWwrBzqQJGo4o/gnz6OswGBgPZceWjvogv54vN0TYFW4tf
         B/71FpXy2A0h6KmGxTTDlK1qVYK51F9cYZepue/+sdc6T8TV3WG2cIyMWOu8Fn4ZefuD
         9LDhB9F6bEZNHC1SOlEfbn0yPQH46OUQVMiZ/HKCgVBC5xu5sYKYVxuYBP9v0R3qKvl6
         /45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706538497; x=1707143297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7MsjY0/2c9mGaJnQcEyejruJlnIDyMNckUiDR6Tnrs=;
        b=lbm6KmQu9Fys618Ndx9AY67ce7kNEyUNnxEieDuO8q9uK0ZeyDNhrj9kVG9LtkAsR6
         HFWKOO5O5TmHmiNAbPBEnxvpCrv0Nrfn5rDmZsi9SeSB7k4x8Sbo53RjttmiCXsF0XSw
         E+LtKT0ZwILBX9CmQKiGLXHUSg/pAMEAOiEVhdvRQKt1PRiNG5Z3a7MpC7/g1UMBFcGZ
         M2I43B6nMr/GgB/mq/xxqgpwgsr1otyRogFcxjmO/ij+H4o4+hDiQrZ6KHKXOdqy6I23
         Fd0KzmdBUA2ra4aHDLatAsdz740Uv2i0JGWuPrFsRRoU6+O2n0ZuFhCh4FvYyI4ab5N3
         jHPg==
X-Gm-Message-State: AOJu0YzITGEXzn8S/8ORqji+w63cHPM4ssUkTSpL2GCsN2ehe5o55k9y
	KUNNLQ/2C3986rXqeQu12b2QjSSxMfTUolUGutQPuJjEKmyV42STWI0GGru5GOpomhTssNkvDfj
	jHoPRtpetU9/OKEXm1g==
X-Google-Smtp-Source: AGHT+IFh8xyRibCwbDS89IsRYVO3WeP9Fhcc6x4KC5I4Asw/F6M+w2+sZAcr0wqttwNeJ7ilqXy645GwGpAKqCFS
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:38a:b0:5fb:7b86:db36 with SMTP
 id bh10-20020a05690c038a00b005fb7b86db36mr1923105ywb.4.1706538497399; Mon, 29
 Jan 2024 06:28:17 -0800 (PST)
Date: Mon, 29 Jan 2024 14:27:59 +0000
In-Reply-To: <20240129142802.2145305-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129142802.2145305-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129142802.2145305-4-vdonnefort@google.com>
Subject: [PATCH v13 3/6] tracing: Add snapshot refcount
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
index 2a7c6fd934e9..b6a0e506b3f9 100644
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
@@ -6593,11 +6641,12 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
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
@@ -6606,8 +6655,13 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 
 	if (t->init) {
 		ret = tracer_init(t, tr);
-		if (ret)
+		if (ret) {
+#ifdef CONFIG_TRACER_MAX_TRACE
+			if (t->use_max_tr)
+				tracing_disarm_snapshot_locked(tr);
+#endif
 			goto out;
+		}
 	}
 
 	tr->current_trace = t;
@@ -7709,10 +7763,11 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
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
@@ -7722,6 +7777,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
 						 (void *)tr, 1);
 		}
+		tracing_disarm_snapshot_locked(tr);
 		break;
 	default:
 		if (tr->allocated_snapshot) {
@@ -8846,8 +8902,13 @@ ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
 
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
@@ -8866,12 +8927,13 @@ ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
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
2.43.0.429.g432eaa2c6b-goog


