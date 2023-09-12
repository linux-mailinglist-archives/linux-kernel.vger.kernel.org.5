Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B501D79D8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjILSkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjILSke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:40:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C7510D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:40:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7884C433C8;
        Tue, 12 Sep 2023 18:40:29 +0000 (UTC)
Date:   Tue, 12 Sep 2023 14:40:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Naveen N Rao <naveen@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [GIT PULL] tracing: Fixes for 6.6
Message-ID: <20230912144046.692c1e4d@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes for 6.6:

- Add missing LOCKDOWN checks for eventfs callers
  When LOCKDOWN is active for tracing, it causes inconsistent state
  when some functions succeed and others fail.

- Use dput() to free the top level eventfs descriptor
  There was a race between accesses and freeing it.

- Fix a long standing bug that eventfs exposed due to changing timings
  by dynamically creating files. That is, If a event file is opened
  for an instance, there's nothing preventing the instance from being
  removed which will make accessing the files cause use-after-free bugs.

- Fix a ring buffer race that happens when iterating over the ring
  buffer while writers are active. Check to make sure not to read
  the event meta data if it's beyond the end of the ring buffer sub buffer.

- Fix the print trigger that disappeared because the test to create it
  was looking for the event dir field being filled, but now it has the
  "ef" field filled for the eventfs structure.

- Remove the unused "dir" field from the event structure.

- Fix the order of the trace_dynamic_info as it had it backwards for the
  offset and len fields for which one was for which endianess.

- Fix the selftest that missed the endianess issue.

- Fix NULL pointer dereference with eventfs_remove_rec()
  If an allocation fails in one of the eventfs_add_*() functions,
  the caller of it in event_subsystem_dir() or event_create_dir()
  assigns the result to the structure. But it's assigning the ERR_PTR
  and not NULL. This was passed to eventfs_remove_rec() which expects
  either a good pointer or a NULL, not ERR_PTR. The fix is to not
  assign the ERR_PTR to the structure, but to keep it NULL on error.

- Fix list_for_each_rcu() to use list_for_each_srcu() in
  dcache_dir_open_wrapper(). One iteration of the code used RCU
  but because it had to call sleepable code, it had to be changed
  to use SRCU, but one of the iterations was missed.

- Fix synthetic event print function to use "as_u64" instead of
  passing in a pointer to the union. To fix big/little endian issues,
  the u64 that represented several types was turned into a union to
  define the types properly.


Please pull the latest trace-v6.6-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.6-rc1

Tag SHA1: 6d49d1b6b06aea107d5a2d7862c55ce018d60c60
Head SHA1: c8414dab164a74bd3bb859a2d836cb537d6b9298


Jinjie Ruan (1):
      eventfs: Fix the NULL pointer dereference bug in eventfs_remove_rec()

Naveen N Rao (1):
      selftests/ftrace: Fix dependencies for some of the synthetic event tests

Steven Rostedt (Google) (14):
      tracefs: Add missing lockdown check to tracefs_create_dir()
      tracefs/eventfs: Add missing lockdown checks
      tracefs/eventfs: Use dput to free the toplevel events directory
      tracing: Increase trace array ref count on enable and filter files
      tracing: Have tracing_max_latency inc the trace array ref count
      tracing: Have current_trace inc the trace array ref count
      tracing: Have option files inc the trace array ref count
      tracing: Have event inject files inc the trace array ref count
      tracefs/eventfs: Free top level files on removal
      ring-buffer: Do not attempt to read past "commit"
      tracing: Use the new eventfs descriptor for print trigger
      tracing: Remove unused trace_event_file dir field
      tracing/synthetic: Fix order of struct trace_dynamic_info
      tracefs/eventfs: Use list_for_each_srcu() in dcache_dir_open_wrapper()

Tero Kristo (1):
      tracing/synthetic: Print out u64 values properly

Zheng Yejian (1):
      ring-buffer: Avoid softlockup in ring_buffer_resize()

----
 fs/tracefs/event_inode.c                           | 59 +++++++++++++++---
 fs/tracefs/inode.c                                 |  5 +-
 fs/tracefs/internal.h                              |  5 +-
 include/linux/trace_events.h                       |  7 +--
 kernel/trace/ring_buffer.c                         |  7 +++
 kernel/trace/trace.c                               | 72 +++++++++++++++++++---
 kernel/trace/trace.h                               |  2 +
 kernel/trace/trace_events.c                        | 32 ++++------
 kernel/trace/trace_events_inject.c                 |  3 +-
 kernel/trace/trace_events_synth.c                  |  2 +-
 .../trigger-synthetic-event-dynstring.tc           |  2 +-
 .../trigger-synthetic_event_syntax_errors.tc       |  2 +-
 12 files changed, 152 insertions(+), 46 deletions(-)
---------------------------
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 237c6f370ad9..9f64e7332796 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -185,17 +185,49 @@ static struct dentry *create_dir(const char *name, struct dentry *parent, void *
 
 /**
  * eventfs_set_ef_status_free - set the ef->status to free
+ * @ti: the tracefs_inode of the dentry
  * @dentry: dentry who's status to be freed
  *
  * eventfs_set_ef_status_free will be called if no more
  * references remain
  */
-void eventfs_set_ef_status_free(struct dentry *dentry)
+void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 {
 	struct tracefs_inode *ti_parent;
-	struct eventfs_file *ef;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef, *tmp;
+
+	/* The top level events directory may be freed by this */
+	if (unlikely(ti->flags & TRACEFS_EVENT_TOP_INODE)) {
+		LIST_HEAD(ef_del_list);
+
+		mutex_lock(&eventfs_mutex);
+
+		ei = ti->private;
+
+		/* Record all the top level files */
+		list_for_each_entry_srcu(ef, &ei->e_top_files, list,
+					 lockdep_is_held(&eventfs_mutex)) {
+			list_add_tail(&ef->del_list, &ef_del_list);
+		}
+
+		/* Nothing should access this, but just in case! */
+		ti->private = NULL;
+
+		mutex_unlock(&eventfs_mutex);
+
+		/* Now safely free the top level files and their children */
+		list_for_each_entry_safe(ef, tmp, &ef_del_list, del_list) {
+			list_del(&ef->del_list);
+			eventfs_remove(ef);
+		}
+
+		kfree(ei);
+		return;
+	}
 
 	mutex_lock(&eventfs_mutex);
+
 	ti_parent = get_tracefs(dentry->d_parent->d_inode);
 	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
 		goto out;
@@ -420,7 +452,8 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 
 	ei = ti->private;
 	idx = srcu_read_lock(&eventfs_srcu);
-	list_for_each_entry_rcu(ef, &ei->e_top_files, list) {
+	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
+				 srcu_read_lock_held(&eventfs_srcu)) {
 		create_dentry(ef, dentry, false);
 	}
 	srcu_read_unlock(&eventfs_srcu, idx);
@@ -491,6 +524,9 @@ struct dentry *eventfs_create_events_dir(const char *name,
 	struct tracefs_inode *ti;
 	struct inode *inode;
 
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
 	if (IS_ERR(dentry))
 		return dentry;
 
@@ -507,7 +543,7 @@ struct dentry *eventfs_create_events_dir(const char *name,
 	INIT_LIST_HEAD(&ei->e_top_files);
 
 	ti = get_tracefs(inode);
-	ti->flags |= TRACEFS_EVENT_INODE;
+	ti->flags |= TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
 	ti->private = ei;
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
@@ -538,6 +574,9 @@ struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
 	struct eventfs_inode *ei_parent;
 	struct eventfs_file *ef;
 
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
 	if (!parent)
 		return ERR_PTR(-EINVAL);
 
@@ -569,6 +608,9 @@ struct eventfs_file *eventfs_add_dir(const char *name,
 {
 	struct eventfs_file *ef;
 
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
 	if (!ef_parent)
 		return ERR_PTR(-EINVAL);
 
@@ -606,6 +648,9 @@ int eventfs_add_events_file(const char *name, umode_t mode,
 	struct eventfs_inode *ei;
 	struct eventfs_file *ef;
 
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return -ENODEV;
+
 	if (!parent)
 		return -EINVAL;
 
@@ -654,6 +699,9 @@ int eventfs_add_file(const char *name, umode_t mode,
 {
 	struct eventfs_file *ef;
 
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return -ENODEV;
+
 	if (!ef_parent)
 		return -EINVAL;
 
@@ -791,7 +839,6 @@ void eventfs_remove(struct eventfs_file *ef)
 void eventfs_remove_events_dir(struct dentry *dentry)
 {
 	struct tracefs_inode *ti;
-	struct eventfs_inode *ei;
 
 	if (!dentry || !dentry->d_inode)
 		return;
@@ -800,8 +847,6 @@ void eventfs_remove_events_dir(struct dentry *dentry)
 	if (!ti || !(ti->flags & TRACEFS_EVENT_INODE))
 		return;
 
-	ei = ti->private;
 	d_invalidate(dentry);
 	dput(dentry);
-	kfree(ei);
 }
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index de5b72216b1a..891653ba9cf3 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -385,7 +385,7 @@ static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
 
 	ti = get_tracefs(inode);
 	if (ti && ti->flags & TRACEFS_EVENT_INODE)
-		eventfs_set_ef_status_free(dentry);
+		eventfs_set_ef_status_free(ti, dentry);
 	iput(inode);
 }
 
@@ -673,6 +673,9 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
  */
 struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
 {
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
 	return __create_dir(name, parent, &simple_dir_inode_operations);
 }
 
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 69c2b1d87c46..4f2e49e2197b 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -3,7 +3,8 @@
 #define _TRACEFS_INTERNAL_H
 
 enum {
-	TRACEFS_EVENT_INODE     = BIT(1),
+	TRACEFS_EVENT_INODE		= BIT(1),
+	TRACEFS_EVENT_TOP_INODE		= BIT(2),
 };
 
 struct tracefs_inode {
@@ -24,6 +25,6 @@ struct inode *tracefs_get_inode(struct super_block *sb);
 struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
 struct dentry *eventfs_failed_creating(struct dentry *dentry);
 struct dentry *eventfs_end_creating(struct dentry *dentry);
-void eventfs_set_ef_status_free(struct dentry *dentry);
+void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index eb5c3add939b..21ae37e49319 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -62,13 +62,13 @@ void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...);
 /* Used to find the offset and length of dynamic fields in trace events */
 struct trace_dynamic_info {
 #ifdef CONFIG_CPU_BIG_ENDIAN
-	u16	offset;
 	u16	len;
+	u16	offset;
 #else
-	u16	len;
 	u16	offset;
+	u16	len;
 #endif
-};
+} __packed;
 
 /*
  * The trace entry - the most basic unit of tracing. This is what
@@ -650,7 +650,6 @@ struct trace_event_file {
 	struct trace_event_call		*event_call;
 	struct event_filter __rcu	*filter;
 	struct eventfs_file             *ef;
-	struct dentry			*dir;
 	struct trace_array		*tr;
 	struct trace_subsystem_dir	*system;
 	struct list_head		triggers;
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 78502d4c7214..a1651edc48d5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2198,6 +2198,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		cpus_read_lock();
@@ -2388,6 +2390,11 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 */
 	commit = rb_page_commit(iter_head_page);
 	smp_rmb();
+
+	/* An event needs to be at least 8 bytes in size */
+	if (iter->head > commit - 8)
+		goto reset;
+
 	event = __rb_page_index(iter_head_page, iter->head);
 	length = rb_event_length(event);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 35783a7baf15..122c23c9eb28 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1772,7 +1772,7 @@ static void trace_create_maxlat_file(struct trace_array *tr,
 	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
 	tr->d_max_latency = trace_create_file("tracing_max_latency",
 					      TRACE_MODE_WRITE,
-					      d_tracer, &tr->max_latency,
+					      d_tracer, tr,
 					      &tracing_max_lat_fops);
 }
 
@@ -1805,7 +1805,7 @@ void latency_fsnotify(struct trace_array *tr)
 
 #define trace_create_maxlat_file(tr, d_tracer)				\
 	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
-			  d_tracer, &tr->max_latency, &tracing_max_lat_fops)
+			  d_tracer, tr, &tracing_max_lat_fops)
 
 #endif
 
@@ -4973,6 +4973,33 @@ int tracing_open_generic_tr(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/*
+ * The private pointer of the inode is the trace_event_file.
+ * Update the tr ref count associated to it.
+ */
+int tracing_open_file_tr(struct inode *inode, struct file *filp)
+{
+	struct trace_event_file *file = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(file->tr);
+	if (ret)
+		return ret;
+
+	filp->private_data = inode->i_private;
+
+	return 0;
+}
+
+int tracing_release_file_tr(struct inode *inode, struct file *filp)
+{
+	struct trace_event_file *file = inode->i_private;
+
+	trace_array_put(file->tr);
+
+	return 0;
+}
+
 static int tracing_mark_open(struct inode *inode, struct file *filp)
 {
 	stream_open(inode, filp);
@@ -6690,14 +6717,18 @@ static ssize_t
 tracing_max_lat_read(struct file *filp, char __user *ubuf,
 		     size_t cnt, loff_t *ppos)
 {
-	return tracing_nsecs_read(filp->private_data, ubuf, cnt, ppos);
+	struct trace_array *tr = filp->private_data;
+
+	return tracing_nsecs_read(&tr->max_latency, ubuf, cnt, ppos);
 }
 
 static ssize_t
 tracing_max_lat_write(struct file *filp, const char __user *ubuf,
 		      size_t cnt, loff_t *ppos)
 {
-	return tracing_nsecs_write(filp->private_data, ubuf, cnt, ppos);
+	struct trace_array *tr = filp->private_data;
+
+	return tracing_nsecs_write(&tr->max_latency, ubuf, cnt, ppos);
 }
 
 #endif
@@ -7751,18 +7782,20 @@ static const struct file_operations tracing_thresh_fops = {
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 static const struct file_operations tracing_max_lat_fops = {
-	.open		= tracing_open_generic,
+	.open		= tracing_open_generic_tr,
 	.read		= tracing_max_lat_read,
 	.write		= tracing_max_lat_write,
 	.llseek		= generic_file_llseek,
+	.release	= tracing_release_generic_tr,
 };
 #endif
 
 static const struct file_operations set_tracer_fops = {
-	.open		= tracing_open_generic,
+	.open		= tracing_open_generic_tr,
 	.read		= tracing_set_trace_read,
 	.write		= tracing_set_trace_write,
 	.llseek		= generic_file_llseek,
+	.release	= tracing_release_generic_tr,
 };
 
 static const struct file_operations tracing_pipe_fops = {
@@ -8955,12 +8988,33 @@ trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	return cnt;
 }
 
+static int tracing_open_options(struct inode *inode, struct file *filp)
+{
+	struct trace_option_dentry *topt = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(topt->tr);
+	if (ret)
+		return ret;
+
+	filp->private_data = inode->i_private;
+	return 0;
+}
+
+static int tracing_release_options(struct inode *inode, struct file *file)
+{
+	struct trace_option_dentry *topt = file->private_data;
+
+	trace_array_put(topt->tr);
+	return 0;
+}
 
 static const struct file_operations trace_options_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_options,
 	.read = trace_options_read,
 	.write = trace_options_write,
 	.llseek	= generic_file_llseek,
+	.release = tracing_release_options,
 };
 
 /*
@@ -9738,8 +9792,8 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 			  tr, &tracing_mark_fops);
 
 	file = __find_event_file(tr, "ftrace", "print");
-	if (file && file->dir)
-		trace_create_file("trigger", TRACE_MODE_WRITE, file->dir,
+	if (file && file->ef)
+		eventfs_add_file("trigger", TRACE_MODE_WRITE, file->ef,
 				  file, &event_trigger_fops);
 	tr->trace_marker_file = file;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5669dd1f90d9..77debe53f07c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -610,6 +610,8 @@ void tracing_reset_all_online_cpus(void);
 void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
+int tracing_open_file_tr(struct inode *inode, struct file *filp);
+int tracing_release_file_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index ed367d713be0..91951d038ba4 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -992,19 +992,6 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 
 static void remove_event_file_dir(struct trace_event_file *file)
 {
-	struct dentry *dir = file->dir;
-	struct dentry *child;
-
-	if (dir) {
-		spin_lock(&dir->d_lock);	/* probably unneeded */
-		list_for_each_entry(child, &dir->d_subdirs, d_child) {
-			if (d_really_is_positive(child))	/* probably unneeded */
-				d_inode(child)->i_private = NULL;
-		}
-		spin_unlock(&dir->d_lock);
-
-		tracefs_remove(dir);
-	}
 	eventfs_remove(file->ef);
 	list_del(&file->list);
 	remove_subsystem(file->system);
@@ -2103,9 +2090,10 @@ static const struct file_operations ftrace_set_event_notrace_pid_fops = {
 };
 
 static const struct file_operations ftrace_enable_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_enable_read,
 	.write = event_enable_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
@@ -2122,9 +2110,10 @@ static const struct file_operations ftrace_event_id_fops = {
 };
 
 static const struct file_operations ftrace_event_filter_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_filter_read,
 	.write = event_filter_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
@@ -2297,6 +2286,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 {
 	struct event_subsystem *system, *iter;
 	struct trace_subsystem_dir *dir;
+	struct eventfs_file *ef;
 	int res;
 
 	/* First see if we did not already create this dir */
@@ -2329,13 +2319,14 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	} else
 		__get_system(system);
 
-	dir->ef = eventfs_add_subsystem_dir(name, parent);
-	if (IS_ERR(dir->ef)) {
+	ef = eventfs_add_subsystem_dir(name, parent);
+	if (IS_ERR(ef)) {
 		pr_warn("Failed to create system directory %s\n", name);
 		__put_system(system);
 		goto out_free;
 	}
 
+	dir->ef = ef;
 	dir->tr = tr;
 	dir->ref_count = 1;
 	dir->nr_events = 1;
@@ -2415,6 +2406,7 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 	struct trace_event_call *call = file->event_call;
 	struct eventfs_file *ef_subsystem = NULL;
 	struct trace_array *tr = file->tr;
+	struct eventfs_file *ef;
 	const char *name;
 	int ret;
 
@@ -2431,12 +2423,14 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 		return -ENOMEM;
 
 	name = trace_event_name(call);
-	file->ef = eventfs_add_dir(name, ef_subsystem);
-	if (IS_ERR(file->ef)) {
+	ef = eventfs_add_dir(name, ef_subsystem);
+	if (IS_ERR(ef)) {
 		pr_warn("Could not create tracefs '%s' directory\n", name);
 		return -1;
 	}
 
+	file->ef = ef;
+
 	if (call->class->reg && !(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE))
 		eventfs_add_file("enable", TRACE_MODE_WRITE, file->ef, file,
 				  &ftrace_enable_fops);
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index abe805d471eb..8650562bdaa9 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -328,7 +328,8 @@ event_inject_read(struct file *file, char __user *buf, size_t size,
 }
 
 const struct file_operations event_inject_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_inject_read,
 	.write = event_inject_write,
+	.release = tracing_release_file_tr,
 };
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 9897d0bfcab7..14cb275a0bab 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -337,7 +337,7 @@ static void print_synth_event_num_val(struct trace_seq *s,
 		break;
 
 	default:
-		trace_seq_printf(s, print_fmt, name, val, space);
+		trace_seq_printf(s, print_fmt, name, val->as_u64, space);
 		break;
 	}
 }
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
index 213d890ed188..174376ddbc6c 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger trace action with dynamic string param
-# requires: set_event synthetic_events events/sched/sched_process_exec/hist "char name[]' >> synthetic_events":README ping:program
+# requires: set_event synthetic_events events/sched/sched_process_exec/hist "' >> synthetic_events":README ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
index 955e3ceea44b..b927ee54c02d 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test synthetic_events syntax parser errors
-# requires: synthetic_events error_log "char name[]' >> synthetic_events":README
+# requires: synthetic_events error_log "' >> synthetic_events":README
 
 check_error() { # command-with-error-pos-by-^
     ftrace_errlog_check 'synthetic_events' "$1" 'synthetic_events'
