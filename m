Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21CE7DD185
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345131AbjJaQZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345110AbjJaQZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:25:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E719E6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:24:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BFDC433C7;
        Tue, 31 Oct 2023 16:24:55 +0000 (UTC)
Date:   Tue, 31 Oct 2023 12:24:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [PATCH] tracing: Have trace_event_file have ref counters
Message-ID: <20231031122453.7a48b923@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The following can crash the kernel:

 # cd /sys/kernel/tracing
 # echo 'p:sched schedule' > kprobe_events
 # exec 5>>events/kprobes/sched/enable
 # > kprobe_events
 # exec 5>&-

The above commands:

 1. Change directory to the tracefs directory
 2. Create a kprobe event (doesn't matter what one)
 3. Open bash file descriptor 5 on the enable file of the kprobe event
 4. Delete the kprobe event (removes the files too)
 5. Close the bash file descriptor 5

The above causes a crash!

 BUG: kernel NULL pointer dereference, address: 0000000000000028
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 6 PID: 877 Comm: bash Not tainted 6.5.0-rc4-test-00008-g2c6b6b1029d4-dirty #186
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
 RIP: 0010:tracing_release_file_tr+0xc/0x50

What happens here is that the kprobe event creates a trace_event_file
"file" descriptor that represents the file in tracefs to the event. It
maintains state of the event (is it enabled for the given instance?).
Opening the "enable" file gets a reference to the event "file" descriptor
via the open file descriptor. When the kprobe event is deleted, the file is
also deleted from the tracefs system which also frees the event "file"
descriptor.

But as the tracefs file is still opened by user space, it will not be
totally removed until the final dput() is called on it. But this is not
true with the event "file" descriptor that is already freed. If the user
does a write to or simply closes the file descriptor it will reference the
event "file" descriptor that was just freed, causing a use-after-free bug.

To solve this, add a ref count to the event "file" descriptor as well as a
new flag called "FREED". The "file" will not be freed until the last
reference is released. But the FREE flag will be set when the event is
removed to prevent any more modifications to that event from happening,
even if there's still a reference to the event "file" descriptor.

Link: https://lore.kernel.org/linux-trace-kernel/20231031000031.1e705592@gandalf.local.home/

Cc: stable@vger.kernel.org
Fixes: f5ca233e2e66d ("tracing: Increase trace array ref count on enable and filter files")
Reported-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h       |  4 ++++
 kernel/trace/trace.c               | 15 +++++++++++++++
 kernel/trace/trace.h               |  3 +++
 kernel/trace/trace_events.c        | 31 ++++++++++++++++++++++++++----
 kernel/trace/trace_events_filter.c |  3 +++
 5 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 12207dc6722d..696f8dc4aa53 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -492,6 +492,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_COND_BIT,
 	EVENT_FILE_FL_PID_FILTER_BIT,
 	EVENT_FILE_FL_WAS_ENABLED_BIT,
+	EVENT_FILE_FL_FREED_BIT,
 };
 
 extern struct trace_event_file *trace_get_event_file(const char *instance,
@@ -630,6 +631,7 @@ extern int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...);
  *  TRIGGER_COND  - When set, one or more triggers has an associated filter
  *  PID_FILTER    - When set, the event is filtered based on pid
  *  WAS_ENABLED   - Set when enabled to know to clear trace on module removal
+ *  FREED         - File descriptor is freed, all fields should be considered invalid
  */
 enum {
 	EVENT_FILE_FL_ENABLED		= (1 << EVENT_FILE_FL_ENABLED_BIT),
@@ -643,6 +645,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_COND	= (1 << EVENT_FILE_FL_TRIGGER_COND_BIT),
 	EVENT_FILE_FL_PID_FILTER	= (1 << EVENT_FILE_FL_PID_FILTER_BIT),
 	EVENT_FILE_FL_WAS_ENABLED	= (1 << EVENT_FILE_FL_WAS_ENABLED_BIT),
+	EVENT_FILE_FL_FREED		= (1 << EVENT_FILE_FL_FREED_BIT),
 };
 
 struct trace_event_file {
@@ -671,6 +674,7 @@ struct trace_event_file {
 	 * caching and such. Which is mostly OK ;-)
 	 */
 	unsigned long		flags;
+	atomic_t		ref;	/* ref count for opened files */
 	atomic_t		sm_ref;	/* soft-mode reference counter */
 	atomic_t		tm_ref;	/* trigger-mode reference counter */
 };
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2539cfc20a97..9aebf904ff97 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4978,6 +4978,20 @@ int tracing_open_file_tr(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
+	mutex_lock(&event_mutex);
+
+	/* Fail if the file is marked for removal */
+	if (file->flags & EVENT_FILE_FL_FREED) {
+		trace_array_put(file->tr);
+		ret = -ENODEV;
+	} else {
+		event_file_get(file);
+	}
+
+	mutex_unlock(&event_mutex);
+	if (ret)
+		return ret;
+
 	filp->private_data = inode->i_private;
 
 	return 0;
@@ -4988,6 +5002,7 @@ int tracing_release_file_tr(struct inode *inode, struct file *filp)
 	struct trace_event_file *file = inode->i_private;
 
 	trace_array_put(file->tr);
+	event_file_put(file);
 
 	return 0;
 }
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0e1405abf4f7..b7f4ea25a194 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1669,6 +1669,9 @@ extern void event_trigger_unregister(struct event_command *cmd_ops,
 				     char *glob,
 				     struct event_trigger_data *trigger_data);
 
+extern void event_file_get(struct trace_event_file *file);
+extern void event_file_put(struct trace_event_file *file);
+
 /**
  * struct event_trigger_ops - callbacks for trace event triggers
  *
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f9e3e24d8796..f29e815ca5b2 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -990,13 +990,35 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 	}
 }
 
+void event_file_get(struct trace_event_file *file)
+{
+	atomic_inc(&file->ref);
+}
+
+void event_file_put(struct trace_event_file *file)
+{
+	if (WARN_ON_ONCE(!atomic_read(&file->ref))) {
+		if (file->flags & EVENT_FILE_FL_FREED)
+			kmem_cache_free(file_cachep, file);
+		return;
+	}
+
+	if (atomic_dec_and_test(&file->ref)) {
+		/* Count should only go to zero when it is freed */
+		if (WARN_ON_ONCE(!(file->flags & EVENT_FILE_FL_FREED)))
+			return;
+		kmem_cache_free(file_cachep, file);
+	}
+}
+
 static void remove_event_file_dir(struct trace_event_file *file)
 {
 	eventfs_remove_dir(file->ei);
 	list_del(&file->list);
 	remove_subsystem(file->system);
 	free_event_filter(file->filter);
-	kmem_cache_free(file_cachep, file);
+	file->flags |= EVENT_FILE_FL_FREED;
+	event_file_put(file);
 }
 
 /*
@@ -1369,7 +1391,7 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 		flags = file->flags;
 	mutex_unlock(&event_mutex);
 
-	if (!file)
+	if (!file || flags & EVENT_FILE_FL_FREED)
 		return -ENODEV;
 
 	if (flags & EVENT_FILE_FL_ENABLED &&
@@ -1403,7 +1425,7 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		ret = -ENODEV;
 		mutex_lock(&event_mutex);
 		file = event_file_data(filp);
-		if (likely(file)) {
+		if (likely(file && !(file->flags & EVENT_FILE_FL_FREED))) {
 			ret = tracing_update_buffers(file->tr);
 			if (ret < 0) {
 				mutex_unlock(&event_mutex);
@@ -1683,7 +1705,7 @@ event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
 
 	mutex_lock(&event_mutex);
 	file = event_file_data(filp);
-	if (file)
+	if (file && !(file->flags & EVENT_FILE_FL_FREED))
 		print_event_filter(file, s);
 	mutex_unlock(&event_mutex);
 
@@ -2902,6 +2924,7 @@ trace_create_new_event(struct trace_event_call *call,
 	atomic_set(&file->tm_ref, 0);
 	INIT_LIST_HEAD(&file->triggers);
 	list_add(&file->list, &tr->events);
+	event_file_get(file);
 
 	return file;
 }
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 33264e510d16..0c611b281a5b 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2349,6 +2349,9 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 	struct event_filter *filter = NULL;
 	int err;
 
+	if (file->flags & EVENT_FILE_FL_FREED)
+		return -ENODEV;
+
 	if (!strcmp(strstrip(filter_string), "0")) {
 		filter_disable(file);
 		filter = event_filter(file);
-- 
2.42.0

