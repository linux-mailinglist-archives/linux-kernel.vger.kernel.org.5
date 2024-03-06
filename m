Return-Path: <linux-kernel+bounces-93213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E786872C6A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09991C21907
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA9912B9A;
	Wed,  6 Mar 2024 01:58:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7519D518;
	Wed,  6 Mar 2024 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690294; cv=none; b=spD1ooTUAEMqD/0nu/QlxX5LlAZ231xOEO4SFGWToTvi78OWEkGUKc/ehHmxa5lvRWI3CDYfIJv7tt70QICyQelnObXWiGsTPbtpzZjjEKNRTS9WKLSi56ylZPcR3e8IdGg3wNvGMpbc3DZkmuTiJWBR/OOR2oJFQI8s4XTswVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690294; c=relaxed/simple;
	bh=YbMoNGJoQ7LPWdY+QV7XwG6+ZinAIu9HNwmJVTQ9CoU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=H8X1xqzlmZB0DAFcdDD17Hwh47Hj9bI13vAFjruXcBvmsJiqCsy2GqPBD7zSWChDS1eZqvCEbLn+4IqZMfvUHayOaLnoMLYYPsvmOuzMrcHyODHo4oplrlqPxTIU1qS4tG5w2u980w7PaaxgIECplzfFdBiZNQOAQFsOir2dSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63663C43142;
	Wed,  6 Mar 2024 01:58:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rhgZh-00000000TBO-3sEl;
	Tue, 05 Mar 2024 21:00:05 -0500
Message-ID: <20240306020005.782553145@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 05 Mar 2024 20:59:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>
Subject: [PATCH 3/8] tracing: Create "boot_mapped" instance for memory mapped buffer
References: <20240306015910.766510873@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add two global variables trace_buffer_start and trace_buffer_size. If they
are both set, then a "boot_mapped" instance will be created using the
memory specified by these variables as its ring buffer.

The instance will exist in:

  /sys/kernel/tracing/instances/boot_mapped

Note, because the ring buffer is using a defined memory ranged, it will
act just like a memory mapped ring buffer. It will not have a snapshot
buffer, as it can't swap out the buffer. The snapshot files as well as any
tracers that uses a snapshot will not be present in the boot_mapped
instance.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace.h |  7 +++++
 kernel/trace/trace.c  | 65 ++++++++++++++++++++++++++++++++++++-------
 kernel/trace/trace.h  |  3 ++
 3 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index fdcd76b7be83..75dab6bb88c9 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -33,6 +33,13 @@ struct trace_array;
 int register_ftrace_export(struct trace_export *export);
 int unregister_ftrace_export(struct trace_export *export);
 
+/*
+ * If the below are set, then a "boot_mapped" tracing instance will
+ * be created using this memory for its ring buffer.
+ */
+extern unsigned long trace_buffer_start;
+extern unsigned long trace_buffer_size;
+
 /**
  * trace_array_puts - write a constant string into the trace buffer.
  * @tr:    The trace array to write to
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ff0b0a999171..ff986d2a4bd0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4900,6 +4900,11 @@ static int tracing_open(struct inode *inode, struct file *file)
 static bool
 trace_ok_for_array(struct tracer *t, struct trace_array *tr)
 {
+#ifdef CONFIG_TRACER_SNAPSHOT
+	/* arrays with mapped buffer range do not have snapshots */
+	if (tr->range_addr_start && t->use_max_tr)
+		return false;
+#endif
 	return (tr->flags & TRACE_ARRAY_FL_GLOBAL) || t->allow_instances;
 }
 
@@ -8670,11 +8675,13 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 				tr, cpu, &tracing_entries_fops);
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-	trace_create_cpu_file("snapshot", TRACE_MODE_WRITE, d_cpu,
-				tr, cpu, &snapshot_fops);
+	if (!tr->range_addr_start) {
+		trace_create_cpu_file("snapshot", TRACE_MODE_WRITE, d_cpu,
+				      tr, cpu, &snapshot_fops);
 
-	trace_create_cpu_file("snapshot_raw", TRACE_MODE_READ, d_cpu,
-				tr, cpu, &snapshot_raw_fops);
+		trace_create_cpu_file("snapshot_raw", TRACE_MODE_READ, d_cpu,
+				      tr, cpu, &snapshot_raw_fops);
+	}
 #endif
 }
 
@@ -9211,7 +9218,18 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 
 	buf->tr = tr;
 
-	buf->buffer = ring_buffer_alloc(size, rb_flags);
+	if (tr->range_addr_start && tr->range_addr_size) {
+		buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
+						      tr->range_addr_start,
+						      tr->range_addr_size);
+		/*
+		 * This is basically the same as a mapped buffer,
+		 * with the same restrictions.
+		 */
+		tr->mapped++;
+	} else {
+		buf->buffer = ring_buffer_alloc(size, rb_flags);
+	}
 	if (!buf->buffer)
 		return -ENOMEM;
 
@@ -9248,6 +9266,10 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 		return ret;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
+	/* Fix mapped buffer trace arrays do not have snapshot buffers */
+	if (tr->range_addr_start)
+		return 0;
+
 	ret = allocate_trace_buffer(tr, &tr->max_buffer,
 				    allocate_snapshot ? size : 1);
 	if (MEM_FAIL(ret, "Failed to allocate trace buffer\n")) {
@@ -9348,7 +9370,9 @@ static int trace_array_create_dir(struct trace_array *tr)
 }
 
 static struct trace_array *
-trace_array_create_systems(const char *name, const char *systems)
+trace_array_create_systems(const char *name, const char *systems,
+			   unsigned long range_addr_start,
+			   unsigned long range_addr_size)
 {
 	struct trace_array *tr;
 	int ret;
@@ -9374,6 +9398,10 @@ trace_array_create_systems(const char *name, const char *systems)
 			goto out_free_tr;
 	}
 
+	/* Only for boot up memory mapped ring buffers */
+	tr->range_addr_start = range_addr_start;
+	tr->range_addr_size = range_addr_size;
+
 	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
 
 	cpumask_copy(tr->tracing_cpumask, cpu_all_mask);
@@ -9431,9 +9459,24 @@ trace_array_create_systems(const char *name, const char *systems)
 
 static struct trace_array *trace_array_create(const char *name)
 {
-	return trace_array_create_systems(name, NULL);
+	return trace_array_create_systems(name, NULL, 0, 0);
+}
+
+unsigned long trace_buffer_start;
+unsigned long trace_buffer_size;
+
+static int __init trace_range_tr(void)
+{
+	if (!trace_buffer_start || !trace_buffer_size)
+		return 0;
+
+	trace_array_create_systems("boot_mapped", NULL,
+				   trace_buffer_start, trace_buffer_size);
+	return 0;
 }
 
+fs_initcall(trace_range_tr);
+
 static int instance_mkdir(const char *name)
 {
 	struct trace_array *tr;
@@ -9485,7 +9528,7 @@ struct trace_array *trace_array_get_by_name(const char *name, const char *system
 			goto out_unlock;
 	}
 
-	tr = trace_array_create_systems(name, systems);
+	tr = trace_array_create_systems(name, systems, 0, 0);
 
 	if (IS_ERR(tr))
 		tr = NULL;
@@ -9678,8 +9721,10 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 		MEM_FAIL(1, "Could not allocate function filter files");
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-	trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
-			  tr, &snapshot_fops);
+	if (!tr->range_addr_start) {
+		trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
+				  tr, &snapshot_fops);
+	}
 #endif
 
 	trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 749a182dab48..d22d7c3b770a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -338,6 +338,9 @@ struct trace_array {
 	unsigned int		snapshot;
 	unsigned int		mapped;
 	unsigned long		max_latency;
+	/* The below is for memory mapped ring buffer */
+	unsigned long		range_addr_start;
+	unsigned long		range_addr_size;
 #ifdef CONFIG_FSNOTIFY
 	struct dentry		*d_max_latency;
 	struct work_struct	fsnotify_work;
-- 
2.43.0



