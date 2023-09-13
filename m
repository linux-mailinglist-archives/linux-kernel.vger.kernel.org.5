Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3C479F57B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjIMX2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjIMX2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:28:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6CA1BCB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:28:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0697EC433C7;
        Wed, 13 Sep 2023 23:28:44 +0000 (UTC)
Date:   Wed, 13 Sep 2023 19:29:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: [GIT PULL] tracing: Add eventfs file to help with debugging any
 more issues
Message-ID: <20230913192905.0a92bcab@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

tracing: Add eventfs file to help with debugging any more issues

While debugging the eventfs dynamic file creation issues, creating a file
in tracefs that exposed what dentries that were created along with their ref
counts proved invaluable.


Please pull the latest trace-v6.6-rc1-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.6-rc1-2

Tag SHA1: 48380652486eacb149420e083516fb159b475d13
Head SHA1: d6f358d6fff619cebbc547f2bdd3ec66ade04954


Steven Rostedt (Google) (1):
      tracefs: Add show_events_dentries

----
 fs/tracefs/Makefile         |   1 +
 fs/tracefs/event_inode.c    |  42 +------------
 fs/tracefs/event_show.c     | 147 ++++++++++++++++++++++++++++++++++++++++++++
 fs/tracefs/internal.h       |  44 +++++++++++++
 include/linux/tracefs.h     |   2 +
 kernel/trace/trace_events.c |   3 +
 6 files changed, 198 insertions(+), 41 deletions(-)
 create mode 100644 fs/tracefs/event_show.c
---------------------------
commit d6f358d6fff619cebbc547f2bdd3ec66ade04954
Author: Steven Rostedt (Google) <rostedt@goodmis.org>
Date:   Wed Sep 13 11:36:28 2023 -0400

    tracefs: Add show_events_dentries
    
    Add a file in tracefs that shows the "events" allocated entries and the
    dentries that are attached to them. This is used to see what dentries have
    been dynamically allocated as well as their current ref counts.
    
     ~# cat /sys/kernel/tracing/events/sched/sched_switch/enable
     0
     ~# grep -A4 sched_switch /sys/kernel/tracing/show_events_dentries
     sched_switch/ dentry: (1)
     enable dentry: (0)
     id
     filter
     trigger
    
    The first value is the name of the file or directory. If a dentry is
    allocated, then a "dentry: (<ref-count>)" is displayed showing the address
    of the dentry as well as its ref count.
    
    Link: https://lore.kernel.org/linux-trace-kernel/20230913113628.172907b7@gandalf.local.home
    
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Ajay Kaher <akaher@vmware.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/fs/tracefs/Makefile b/fs/tracefs/Makefile
index 73c56da8e284..8f48f4fc6698 100644
--- a/fs/tracefs/Makefile
+++ b/fs/tracefs/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 tracefs-objs	:= inode.o
 tracefs-objs	+= event_inode.o
+tracefs-objs	+= event_show.o
 
 obj-$(CONFIG_TRACING)	+= tracefs.o
 
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 9f64e7332796..b23bb0957bb4 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -23,47 +23,7 @@
 #include <linux/delay.h>
 #include "internal.h"
 
-struct eventfs_inode {
-	struct list_head	e_top_files;
-};
-
-/*
- * struct eventfs_file - hold the properties of the eventfs files and
- *                       directories.
- * @name:	the name of the file or directory to create
- * @d_parent:   holds parent's dentry
- * @dentry:     once accessed holds dentry
- * @list:	file or directory to be added to parent directory
- * @ei:		list of files and directories within directory
- * @fop:	file_operations for file or directory
- * @iop:	inode_operations for file or directory
- * @data:	something that the caller will want to get to later on
- * @mode:	the permission that the file or directory should have
- */
-struct eventfs_file {
-	const char			*name;
-	struct dentry			*d_parent;
-	struct dentry			*dentry;
-	struct list_head		list;
-	struct eventfs_inode		*ei;
-	const struct file_operations	*fop;
-	const struct inode_operations	*iop;
-	/*
-	 * Union - used for deletion
-	 * @del_list:	list of eventfs_file to delete
-	 * @rcu:	eventfs_file to delete in RCU
-	 * @is_freed:	node is freed if one of the above is set
-	 */
-	union {
-		struct list_head	del_list;
-		struct rcu_head		rcu;
-		unsigned long		is_freed;
-	};
-	void				*data;
-	umode_t				mode;
-};
-
-static DEFINE_MUTEX(eventfs_mutex);
+DEFINE_MUTEX(eventfs_mutex);
 DEFINE_STATIC_SRCU(eventfs_srcu);
 
 static struct dentry *eventfs_root_lookup(struct inode *dir,
diff --git a/fs/tracefs/event_show.c b/fs/tracefs/event_show.c
new file mode 100644
index 000000000000..66dece7cc810
--- /dev/null
+++ b/fs/tracefs/event_show.c
@@ -0,0 +1,147 @@
+#include <linux/seq_file.h>
+#include <linux/tracefs.h>
+#include "internal.h"
+
+/*
+ * This will iterate three lists that correspond to the directory level
+ * of the eventfs directory.
+ *
+ * level 0 : /sys/kernel/tracing/events
+ * level 1 : /sys/kernel/tracing/events/<system>
+ * level 2 : /sys/kernel/tracing/events/<system>/event
+ *
+ * The iterator needs to see all levels as they all contain dynamically
+ * allocated dentries and inodes.
+ */
+struct event_list {
+	int			level;
+	struct list_head	*head[3];
+	struct list_head	*next[3];
+};
+
+static void *e_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct event_list *elist = m->private;
+	int level = elist->level;
+	struct list_head *head = elist->head[level];
+	struct list_head *next = elist->next[level];
+	struct eventfs_file *ef;
+
+	(*pos)++;
+
+	/* If next is equal to head, then the list is complete */
+	while (next == head) {
+		if (!level)
+			return NULL;
+
+		/* sublevel below top level, go up one */
+		elist->level = --level;
+		head = elist->head[level];
+		/* Going down does not update next, so do it here */
+		next = elist->next[level]->next;
+		elist->next[level] = next;
+	}
+
+	ef = list_entry(next, struct eventfs_file, list);
+
+	/* For each entry (not at the bottom) do a breadth first search */
+	if (ef->ei && !list_empty(&ef->ei->e_top_files) && level < 2) {
+		elist->level = ++level;
+		head = &ef->ei->e_top_files;
+		elist->head[level] = head;
+		next = head;
+		/*
+		 * Note, next is now pointing to the next sub level.
+		 * Need to update the next for the previous level on the way up.
+		 */
+	}
+
+	elist->next[level] = next->next;
+	return ef;
+}
+
+static void *e_start(struct seq_file *m, loff_t *pos)
+{
+	struct event_list *elist = m->private;
+	struct eventfs_file *ef = NULL;
+	loff_t l;
+
+	mutex_lock(&eventfs_mutex);
+
+	elist->level = 0;
+	elist->next[0] = elist->head[0]->next;
+
+	for (l = 0; l <= *pos; ) {
+		ef = e_next(m, ef, &l);
+		if (!ef)
+			break;
+	}
+	return ef;
+}
+
+static int e_show(struct seq_file *m, void *v)
+{
+	struct eventfs_file *ef = v;
+
+	seq_printf(m, "%s", ef->name);
+	if (ef->ei)
+		seq_putc(m, '/');
+
+	if (ef->dentry)
+		seq_printf(m, " dentry: (%d)", d_count(ef->dentry));
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static void e_stop(struct seq_file *m, void *p)
+{
+	mutex_unlock(&eventfs_mutex);
+}
+
+static const struct seq_operations eventfs_show_dentry_seq_ops = {
+	.start = e_start,
+	.next = e_next,
+	.show = e_show,
+	.stop = e_stop,
+};
+
+static int
+eventfs_show_dentry_open(struct inode *inode, struct file *file)
+{
+	const struct seq_operations *seq_ops = &eventfs_show_dentry_seq_ops;
+	struct event_list *elist;
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct dentry *dentry;
+
+	/* The inode private should have the dentry of the "events" directory */
+	dentry = inode->i_private;
+	if (!dentry)
+		return -EINVAL;
+
+	elist = __seq_open_private(file, seq_ops, sizeof(*elist));
+	if (!elist)
+		return -ENOMEM;
+
+	ti = get_tracefs(dentry->d_inode);
+	ei = ti->private;
+
+	/*
+	 * Start off at level 0 (/sys/kernel/tracing/events)
+	 * Initialize head to the events files and next to the
+	 * first file.
+	 */
+	elist->level = 0;
+	elist->head[0] = &ei->e_top_files;
+	elist->next[0] = ei->e_top_files.next;
+
+	return 0;
+}
+
+const struct file_operations eventfs_show_dentry_fops = {
+	.open = eventfs_show_dentry_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 4f2e49e2197b..461920f0133f 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -2,11 +2,55 @@
 #ifndef _TRACEFS_INTERNAL_H
 #define _TRACEFS_INTERNAL_H
 
+#include <linux/mutex.h>
+
 enum {
 	TRACEFS_EVENT_INODE		= BIT(1),
 	TRACEFS_EVENT_TOP_INODE		= BIT(2),
 };
 
+struct eventfs_inode {
+	struct list_head	e_top_files;
+};
+
+/*
+ * struct eventfs_file - hold the properties of the eventfs files and
+ *                       directories.
+ * @name:	the name of the file or directory to create
+ * @d_parent:   holds parent's dentry
+ * @dentry:     once accessed holds dentry
+ * @list:	file or directory to be added to parent directory
+ * @ei:		list of files and directories within directory
+ * @fop:	file_operations for file or directory
+ * @iop:	inode_operations for file or directory
+ * @data:	something that the caller will want to get to later on
+ * @mode:	the permission that the file or directory should have
+ */
+struct eventfs_file {
+	const char			*name;
+	struct dentry			*d_parent;
+	struct dentry			*dentry;
+	struct list_head		list;
+	struct eventfs_inode		*ei;
+	const struct file_operations	*fop;
+	const struct inode_operations	*iop;
+	/*
+	 * Union - used for deletion
+	 * @del_list:	list of eventfs_file to delete
+	 * @rcu:	eventfs_file to delete in RCU
+	 * @is_freed:	node is freed if one of the above is set
+	 */
+	union {
+		struct list_head	del_list;
+		struct rcu_head		rcu;
+		unsigned long		is_freed;
+	};
+	void				*data;
+	umode_t				mode;
+};
+
+extern struct mutex eventfs_mutex;
+
 struct tracefs_inode {
 	unsigned long           flags;
 	void                    *private;
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 009072792fa3..f76c7d74b23d 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -58,6 +58,8 @@ struct dentry *tracefs_create_instance_dir(const char *name, struct dentry *pare
 
 bool tracefs_initialized(void);
 
+extern const struct file_operations eventfs_show_dentry_fops;
+
 #endif /* CONFIG_TRACING */
 
 #endif
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 91951d038ba4..5b0cc40910b2 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3639,6 +3639,9 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 		return -ENOMEM;
 	}
 
+	trace_create_file("show_events_dentries", TRACE_MODE_READ, parent, d_events,
+			  &eventfs_show_dentry_fops);
+
 	error = eventfs_add_events_file("enable", TRACE_MODE_WRITE, d_events,
 				  tr, &ftrace_tr_enable_fops);
 	if (error)
