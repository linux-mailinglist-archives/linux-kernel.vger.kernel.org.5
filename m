Return-Path: <linux-kernel+bounces-139621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B017A8A0571
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB791F23676
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F8F664DB;
	Thu, 11 Apr 2024 01:26:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231B626DF;
	Thu, 11 Apr 2024 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798787; cv=none; b=bcjKh0hFGm4A+fPG+djB8Y2aoxCSv2sV1zBOoWaJKFueWqvgpTyKb0kDcfwm/sfLGqq35xQAiczcOpSTplTVX7cwylDCnD65Lx+DANzMxB4wAbRfbP9N2Ff1tldrAic4KYH9BOaAQD8JXN6oypvy1RISDjxMt6YYln9DRSbUfGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798787; c=relaxed/simple;
	bh=j7R15Vswkf2LNk7KzUJnfJqxLnSVENe3zwazAuIc2Ic=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nUxPesWPR4YsNS4+gR1rPe8f4GZxK7Wv6MYT8bZ10U0XLZ5qoQipDeMo881wqQoOrrp++JP+GVQp2G9yWkz1IjREMXUqPTmg6loTtL820bnor6fANws5eeyvSWtJVgmmKktrfzpU5gaVd/603EDM+a2OHT6CSpCaRjjmh/hduyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81018C43142;
	Thu, 11 Apr 2024 01:26:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rujFQ-00000000nVw-3Zls;
	Wed, 10 Apr 2024 21:29:04 -0400
Message-ID: <20240411012904.715156108@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 10 Apr 2024 21:25:45 -0400
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
Subject: [PATCH v2 04/11] tracing: Implement creating an instance based on a given memory
 region
References: <20240411012541.285904543@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Allow for creating a new instance by passing in an address and size to map
the ring buffer for the instance to.

This will allow features like a pstore memory mapped region to be used for
an tracing instance ring buffer that can be retrieved from one boot to the
next.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 50 +++++++++++++++++++++++++++++++++++---------
 kernel/trace/trace.h |  3 +++
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 83194bf7b1df..31067de977fc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4921,6 +4921,11 @@ static int tracing_open(struct inode *inode, struct file *file)
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
 
@@ -8673,11 +8678,13 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
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
 
@@ -9214,7 +9221,18 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 
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
 
@@ -9251,6 +9269,10 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 		return ret;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
+	/* Fix mapped buffer trace arrays do not have snapshot buffers */
+	if (tr->range_addr_start)
+		return 0;
+
 	ret = allocate_trace_buffer(tr, &tr->max_buffer,
 				    allocate_snapshot ? size : 1);
 	if (MEM_FAIL(ret, "Failed to allocate trace buffer\n")) {
@@ -9351,7 +9373,9 @@ static int trace_array_create_dir(struct trace_array *tr)
 }
 
 static struct trace_array *
-trace_array_create_systems(const char *name, const char *systems)
+trace_array_create_systems(const char *name, const char *systems,
+			   unsigned long range_addr_start,
+			   unsigned long range_addr_size)
 {
 	struct trace_array *tr;
 	int ret;
@@ -9377,6 +9401,10 @@ trace_array_create_systems(const char *name, const char *systems)
 			goto out_free_tr;
 	}
 
+	/* Only for boot up memory mapped ring buffers */
+	tr->range_addr_start = range_addr_start;
+	tr->range_addr_size = range_addr_size;
+
 	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
 
 	cpumask_copy(tr->tracing_cpumask, cpu_all_mask);
@@ -9434,7 +9462,7 @@ trace_array_create_systems(const char *name, const char *systems)
 
 static struct trace_array *trace_array_create(const char *name)
 {
-	return trace_array_create_systems(name, NULL);
+	return trace_array_create_systems(name, NULL, 0, 0);
 }
 
 static int instance_mkdir(const char *name)
@@ -9488,7 +9516,7 @@ struct trace_array *trace_array_get_by_name(const char *name, const char *system
 			goto out_unlock;
 	}
 
-	tr = trace_array_create_systems(name, systems);
+	tr = trace_array_create_systems(name, systems, 0, 0);
 
 	if (IS_ERR(tr))
 		tr = NULL;
@@ -9681,8 +9709,10 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
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



