Return-Path: <linux-kernel+bounces-5377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 688E9818A10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C24C1C243FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01FD20DE0;
	Tue, 19 Dec 2023 14:32:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB752208BC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EF2C433C7;
	Tue, 19 Dec 2023 14:32:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFb9X-00000003MDx-130V;
	Tue, 19 Dec 2023 09:32:59 -0500
Message-ID: <20231219143259.032310636@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 09:32:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sean Paul <seanpaul@chromium.org>,
 Arun Easi <aeasi@marvell.com>,
 Daniel Wagner <dwagner@suse.de>,
 Dmytro Maluka <dmaluka@chromium.org>
Subject: [for-next][PATCH 01/10] tracing: Allow creating instances with specified system events
References: <20231219143233.204534014@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

A trace instance may only need to enable specific events. As the eventfs
directory of an instance currently creates all events which adds overhead,
allow internal instances to be created with just the events in systems
that they care about. This currently only deals with systems and not
individual events, but this should bring down the overhead of creating
instances for specific use cases quite bit.

The trace_array_get_by_name() now has another parameter "systems". This
parameter is a const string pointer of a comma/space separated list of
event systems that should be created by the trace_array. (Note if the
trace_array already exists, this parameter is ignored).

The list of systems is saved and if a module is loaded, its events will
not be added unless the system for those events also match the systems
string.

Link: https://lore.kernel.org/linux-trace-kernel/20231213093701.03fddec0@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Arun Easi   <aeasi@marvell.com>
Cc: Daniel Wagner <dwagner@suse.de>
Tested-by: Dmytro Maluka <dmaluka@chromium.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/scsi/qla2xxx/qla_os.c       |  2 +-
 include/linux/trace.h               |  4 +--
 kernel/trace/trace.c                | 23 +++++++++++---
 kernel/trace/trace.h                |  1 +
 kernel/trace/trace_boot.c           |  2 +-
 kernel/trace/trace_events.c         | 48 +++++++++++++++++++++++++++--
 samples/ftrace/sample-trace-array.c |  2 +-
 7 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 03348f605c2e..dd674378f2f3 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -2889,7 +2889,7 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 static void
 qla_trace_init(void)
 {
-	qla_trc_array = trace_array_get_by_name("qla2xxx");
+	qla_trc_array = trace_array_get_by_name("qla2xxx", NULL);
 	if (!qla_trc_array) {
 		ql_log(ql_log_fatal, NULL, 0x0001,
 		       "Unable to create qla2xxx trace instance, instance logging will be disabled.\n");
diff --git a/include/linux/trace.h b/include/linux/trace.h
index 2a70a447184c..fdcd76b7be83 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -51,7 +51,7 @@ int trace_array_printk(struct trace_array *tr, unsigned long ip,
 		       const char *fmt, ...);
 int trace_array_init_printk(struct trace_array *tr);
 void trace_array_put(struct trace_array *tr);
-struct trace_array *trace_array_get_by_name(const char *name);
+struct trace_array *trace_array_get_by_name(const char *name, const char *systems);
 int trace_array_destroy(struct trace_array *tr);
 
 /* For osnoise tracer */
@@ -84,7 +84,7 @@ static inline int trace_array_init_printk(struct trace_array *tr)
 static inline void trace_array_put(struct trace_array *tr)
 {
 }
-static inline struct trace_array *trace_array_get_by_name(const char *name)
+static inline struct trace_array *trace_array_get_by_name(const char *name, const char *systems)
 {
 	return NULL;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 199df497db07..59e39b652afb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9490,7 +9490,8 @@ static int trace_array_create_dir(struct trace_array *tr)
 	return ret;
 }
 
-static struct trace_array *trace_array_create(const char *name)
+static struct trace_array *
+trace_array_create_systems(const char *name, const char *systems)
 {
 	struct trace_array *tr;
 	int ret;
@@ -9510,6 +9511,12 @@ static struct trace_array *trace_array_create(const char *name)
 	if (!zalloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
 		goto out_free_tr;
 
+	if (systems) {
+		tr->system_names = kstrdup_const(systems, GFP_KERNEL);
+		if (!tr->system_names)
+			goto out_free_tr;
+	}
+
 	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
 
 	cpumask_copy(tr->tracing_cpumask, cpu_all_mask);
@@ -9556,12 +9563,18 @@ static struct trace_array *trace_array_create(const char *name)
 	free_trace_buffers(tr);
 	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
+	kfree_const(tr->system_names);
 	kfree(tr->name);
 	kfree(tr);
 
 	return ERR_PTR(ret);
 }
 
+static struct trace_array *trace_array_create(const char *name)
+{
+	return trace_array_create_systems(name, NULL);
+}
+
 static int instance_mkdir(const char *name)
 {
 	struct trace_array *tr;
@@ -9587,6 +9600,7 @@ static int instance_mkdir(const char *name)
 /**
  * trace_array_get_by_name - Create/Lookup a trace array, given its name.
  * @name: The name of the trace array to be looked up/created.
+ * @systems: A list of systems to create event directories for (NULL for all)
  *
  * Returns pointer to trace array with given name.
  * NULL, if it cannot be created.
@@ -9600,7 +9614,7 @@ static int instance_mkdir(const char *name)
  * trace_array_put() is called, user space can not delete it.
  *
  */
-struct trace_array *trace_array_get_by_name(const char *name)
+struct trace_array *trace_array_get_by_name(const char *name, const char *systems)
 {
 	struct trace_array *tr;
 
@@ -9612,7 +9626,7 @@ struct trace_array *trace_array_get_by_name(const char *name)
 			goto out_unlock;
 	}
 
-	tr = trace_array_create(name);
+	tr = trace_array_create_systems(name, systems);
 
 	if (IS_ERR(tr))
 		tr = NULL;
@@ -9659,6 +9673,7 @@ static int __remove_instance(struct trace_array *tr)
 
 	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
+	kfree_const(tr->system_names);
 	kfree(tr->name);
 	kfree(tr);
 
@@ -10377,7 +10392,7 @@ __init static void enable_instances(void)
 		if (IS_ENABLED(CONFIG_TRACER_MAX_TRACE))
 			do_allocate_snapshot(tok);
 
-		tr = trace_array_get_by_name(tok);
+		tr = trace_array_get_by_name(tok, NULL);
 		if (!tr) {
 			pr_warn("Failed to create instance buffer %s\n", curr_str);
 			continue;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0489e72c8169..79180aed13ee 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -377,6 +377,7 @@ struct trace_array {
 	unsigned char		trace_flags_index[TRACE_FLAGS_MAX_SIZE];
 	unsigned int		flags;
 	raw_spinlock_t		start_lock;
+	const char		*system_names;
 	struct list_head	err_log;
 	struct dentry		*dir;
 	struct dentry		*options;
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 7ccc7a8e155b..dbe29b4c6a7a 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -633,7 +633,7 @@ trace_boot_init_instances(struct xbc_node *node)
 		if (!p || *p == '\0')
 			continue;
 
-		tr = trace_array_get_by_name(p);
+		tr = trace_array_get_by_name(p, NULL);
 		if (!tr) {
 			pr_err("Failed to get trace instance %s\n", p);
 			continue;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f29e815ca5b2..b70d03818038 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2896,6 +2896,27 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 	up_write(&trace_event_sem);
 }
 
+static bool event_in_systems(struct trace_event_call *call,
+			     const char *systems)
+{
+	const char *system;
+	const char *p;
+
+	if (!systems)
+		return true;
+
+	system = call->class->system;
+	p = strstr(systems, system);
+	if (!p)
+		return false;
+
+	if (p != systems && !isspace(*(p - 1)) && *(p - 1) != ',')
+		return false;
+
+	p += strlen(system);
+	return !*p || isspace(*p) || *p == ',';
+}
+
 static struct trace_event_file *
 trace_create_new_event(struct trace_event_call *call,
 		       struct trace_array *tr)
@@ -2905,9 +2926,12 @@ trace_create_new_event(struct trace_event_call *call,
 	struct trace_event_file *file;
 	unsigned int first;
 
+	if (!event_in_systems(call, tr->system_names))
+		return NULL;
+
 	file = kmem_cache_alloc(file_cachep, GFP_TRACE);
 	if (!file)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	pid_list = rcu_dereference_protected(tr->filtered_pids,
 					     lockdep_is_held(&event_mutex));
@@ -2972,8 +2996,17 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
 	struct trace_event_file *file;
 
 	file = trace_create_new_event(call, tr);
+	/*
+	 * trace_create_new_event() returns ERR_PTR(-ENOMEM) if failed
+	 * allocation, or NULL if the event is not part of the tr->system_names.
+	 * When the event is not part of the tr->system_names, return zero, not
+	 * an error.
+	 */
 	if (!file)
-		return -ENOMEM;
+		return 0;
+
+	if (IS_ERR(file))
+		return PTR_ERR(file);
 
 	if (eventdir_initialized)
 		return event_create_dir(tr->event_dir, file);
@@ -3012,8 +3045,17 @@ __trace_early_add_new_event(struct trace_event_call *call,
 	int ret;
 
 	file = trace_create_new_event(call, tr);
+	/*
+	 * trace_create_new_event() returns ERR_PTR(-ENOMEM) if failed
+	 * allocation, or NULL if the event is not part of the tr->system_names.
+	 * When the event is not part of the tr->system_names, return zero, not
+	 * an error.
+	 */
 	if (!file)
-		return -ENOMEM;
+		return 0;
+
+	if (IS_ERR(file))
+		return PTR_ERR(file);
 
 	ret = event_define_fields(call);
 	if (ret)
diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
index 6aba02a31c96..d0ee9001c7b3 100644
--- a/samples/ftrace/sample-trace-array.c
+++ b/samples/ftrace/sample-trace-array.c
@@ -105,7 +105,7 @@ static int __init sample_trace_array_init(void)
 	 * NOTE: This function increments the reference counter
 	 * associated with the trace array - "tr".
 	 */
-	tr = trace_array_get_by_name("sample-instance");
+	tr = trace_array_get_by_name("sample-instance", "sched,timer,kprobes");
 
 	if (!tr)
 		return -1;
-- 
2.42.0



