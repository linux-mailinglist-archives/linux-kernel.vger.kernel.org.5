Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D410776A559
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjHAAOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHAAOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:14:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94917173D;
        Mon, 31 Jul 2023 17:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23F8A61376;
        Tue,  1 Aug 2023 00:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642D5C433C9;
        Tue,  1 Aug 2023 00:14:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQd25-003g9G-0F;
        Mon, 31 Jul 2023 20:14:37 -0400
Message-ID: <20230801001436.890782912@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 20:13:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>, chinglinyu@google.com,
        lkp@intel.com, namit@vmware.com, oe-lkp@lists.linux.dev,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH 1/2] tracefs: Add show_events_dentries
References: <20230801001349.520930329@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add a file in tracefs that shows the "events" allocated entries and the
dentries that are attached to them. This is used to see what dentries have
been dynamically allocated as well as their current ref counts.

 ~# cat /sys/kernel/tracing/events/sched/sched_switch/enable
 0
 ~# grep -A4 sched_switch /sys/kernel/tracing/show_events_dentries
 ffff88810118dde0 sched_switch/ dentry: ffff888110e2de78 (1)
 ffff88810118dd80 enable dentry: ffff888110e2d5f0 (0)
 ffff88810118d5a0 id
 ffff88810118d840 filter
 ffff88810118d960 trigger

The first value is the address of the descriptor for the event_file, the
next is the name of the file or directory. If a dentry is allocated, then
a "dentry: <addr> (<ref-count>)" is displayed showing the address of the
dentry as well as its ref count.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/Makefile         |   1 +
 fs/tracefs/event_inode.c    |  36 +----------
 fs/tracefs/event_show.c     | 124 ++++++++++++++++++++++++++++++++++++
 fs/tracefs/internal.h       |  38 +++++++++++
 include/linux/tracefs.h     |   2 +
 kernel/trace/trace_events.c |   3 +
 6 files changed, 169 insertions(+), 35 deletions(-)
 create mode 100644 fs/tracefs/event_show.c

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
index da8d2e73cc47..675847fcb179 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -23,41 +23,7 @@
 #include <linux/delay.h>
 #include "internal.h"
 
-struct eventfs_inode {
-	struct list_head	e_top_files;
-};
-
-/**
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
-	union {
-		struct list_head	del_list; /* list of eventfs_file to delete */
-		struct rcu_head		rcu; /* eventfs_file to delete */
-		unsigned long		is_freed; /* Freed if one of the above is set */
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
index 000000000000..a402d0aa05a8
--- /dev/null
+++ b/fs/tracefs/event_show.c
@@ -0,0 +1,124 @@
+#include <linux/seq_file.h>
+#include <linux/tracefs.h>
+#include "internal.h"
+
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
+	while (next == head) {
+		if (!level)
+			return NULL;
+
+		elist->level = --level;
+		head = elist->head[level];
+		/* Going down does not update next, so do it here */
+		next = elist->next[level]->next;
+		elist->next[level] = next;
+	}
+
+	ef = list_entry(next, struct eventfs_file, list);
+
+	if (ef->ei && !list_empty(&ef->ei->e_top_files) && level < 2) {
+		elist->level = ++level;
+		head = &ef->ei->e_top_files;
+		elist->head[level] = head;
+		next = head;
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
+	seq_printf(m, "%px %s", ef, ef->name);
+	if (ef->ei)
+		seq_putc(m, '/');
+
+	if (ef->dentry)
+		seq_printf(m, " dentry: %px (%d)", ef->dentry, d_count(ef->dentry));
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
index 69c2b1d87c46..4cb50d59ca6e 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -2,10 +2,48 @@
 #ifndef _TRACEFS_INTERNAL_H
 #define _TRACEFS_INTERNAL_H
 
+#include <linux/mutex.h>
+
 enum {
 	TRACEFS_EVENT_INODE     = BIT(1),
 };
 
+struct eventfs_inode {
+	struct list_head	e_top_files;
+};
+
+/**
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
+	union {
+		struct list_head	del_list; /* list of eventfs_file to delete */
+		struct rcu_head		rcu; /* eventfs_file to delete */
+		unsigned long		is_freed; /* Freed if one of the above is set */
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
index ed367d713be0..d3c22752bf91 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3645,6 +3645,9 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 		return -ENOMEM;
 	}
 
+	trace_create_file("show_events_dentries", TRACE_MODE_READ, parent, d_events,
+			  &eventfs_show_dentry_fops);
+
 	error = eventfs_add_events_file("enable", TRACE_MODE_WRITE, d_events,
 				  tr, &ftrace_tr_enable_fops);
 	if (error)
-- 
2.40.1
