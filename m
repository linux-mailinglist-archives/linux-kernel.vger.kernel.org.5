Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4377F76A4B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjGaXS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGaXRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:17:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B57F1FEB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 812CA61360
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE1CC433CC;
        Mon, 31 Jul 2023 23:17:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQc8R-003fRa-2y;
        Mon, 31 Jul 2023 19:17:07 -0400
Message-ID: <20230731231707.741705134@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 19:16:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: [for-next][PATCH 14/15] eventfs: Move tracing/events to eventfs
References: <20230731231634.031452225@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajay Kaher <akaher@vmware.com>

Up until now, /sys/kernel/tracing/events was no different than any other
part of tracefs. The files and directories within the events directory was
created when the tracefs was mounted, and also created for the instances in
/sys/kernel/tracing/instances/<instance>/events. Most of these files and
directories will never be referenced. Since there are thousands of these
files and directories they spend their time wasting precious memory
resources.

Move the "events" directory to the new eventfs. The eventfs will take the
meta data of the events that they represent and store that. When the files
in the events directory are referenced, the dentry and inodes to represent
them are then created. When the files are no longer referenced, they are
freed. This saves the precious memory resources that were wasted on these
seldom referenced dentries and inodes.

Running the following:

 ~# cat /proc/meminfo /proc/slabinfo  > before.out
 ~# mkdir /sys/kernel/tracing/instances/foo
 ~# cat /proc/meminfo /proc/slabinfo  > after.out

to test the changes produces the following deltas:

Before this change:

 Before after deltas for meminfo:

   MemFree: -32260
   MemAvailable: -21496
   KReclaimable: 21528
   Slab: 22440
   SReclaimable: 21528
   SUnreclaim: 912
   VmallocUsed: 16

 Before after deltas for slabinfo:

   <slab>:		<objects>	[ * <size> = <total>]

   tracefs_inode_cache:	14472		[* 1184 = 17134848]
   buffer_head:		24		[* 168 = 4032]
   hmem_inode_cache:	28		[* 1480 = 41440]
   dentry:		14450		[* 312 = 4508400]
   lsm_inode_cache:	14453		[* 32 = 462496]
   vma_lock:		11		[* 152 = 1672]
   vm_area_struct:	2		[* 184 = 368]
   trace_event_file:	1748		[* 88 = 153824]
   kmalloc-256:		1072		[* 256 = 274432]
   kmalloc-64:		2842		[* 64 = 181888]

 Total slab additions in size: 22,763,400 bytes

With this change:

 Before after deltas for meminfo:

   MemFree: -12600
   MemAvailable: -12580
   Cached: 24
   Active: 12
   Inactive: 68
   Inactive(anon): 48
   Active(file): 12
   Inactive(file): 20
   Dirty: -4
   AnonPages: 68
   KReclaimable: 12
   Slab: 1856
   SReclaimable: 12
   SUnreclaim: 1844
   KernelStack: 16
   PageTables: 36
   VmallocUsed: 16

 Before after deltas for slabinfo:

   <slab>:		<objects>	[ * <size> = <total>]

   tracefs_inode_cache:	108		[* 1184 = 127872]
   buffer_head:		24		[* 168 = 4032]
   hmem_inode_cache:	18		[* 1480 = 26640]
   dentry:		127		[* 312 = 39624]
   lsm_inode_cache:	152		[* 32 = 4864]
   vma_lock:		67		[* 152 = 10184]
   vm_area_struct:	-12		[* 184 = -2208]
   trace_event_file: 	1764		[* 96 = 169344]
   kmalloc-96:		14322		[* 96 = 1374912]
   kmalloc-64:		2814		[* 64 = 180096]
   kmalloc-32:		1103		[* 32 = 35296]
   kmalloc-16:		2308		[* 16 = 36928]
   kmalloc-8:		12800		[* 8 = 102400]

 Total slab additions in size: 2,109,984 bytes

Which is a savings of 20,653,416 bytes (20 MB) per tracing instance.

Link: https://lkml.kernel.org/r/1690568452-46553-10-git-send-email-akaher@vmware.com

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c           | 18 ++++++++++
 include/linux/trace_events.h |  1 +
 kernel/trace/trace.h         |  2 +-
 kernel/trace/trace_events.c  | 65 ++++++++++++++++++------------------
 4 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index d9273066f25f..bb6de89eb446 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -374,6 +374,23 @@ static const struct super_operations tracefs_super_operations = {
 	.show_options	= tracefs_show_options,
 };
 
+static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
+{
+	struct tracefs_inode *ti;
+
+	if (!dentry || !inode)
+		return;
+
+	ti = get_tracefs(inode);
+	if (ti && ti->flags & TRACEFS_EVENT_INODE)
+		eventfs_set_ef_status_free(dentry);
+	iput(inode);
+}
+
+static const struct dentry_operations tracefs_dentry_operations = {
+	.d_iput = tracefs_dentry_iput,
+};
+
 static int trace_fill_super(struct super_block *sb, void *data, int silent)
 {
 	static const struct tree_descr trace_files[] = {{""}};
@@ -396,6 +413,7 @@ static int trace_fill_super(struct super_block *sb, void *data, int silent)
 		goto fail;
 
 	sb->s_op = &tracefs_super_operations;
+	sb->s_d_op = &tracefs_dentry_operations;
 
 	tracefs_apply_options(sb, false);
 
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 3930e676436c..c17623c78029 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -638,6 +638,7 @@ struct trace_event_file {
 	struct list_head		list;
 	struct trace_event_call		*event_call;
 	struct event_filter __rcu	*filter;
+	struct eventfs_file             *ef;
 	struct dentry			*dir;
 	struct trace_array		*tr;
 	struct trace_subsystem_dir	*system;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index ba7ababb8308..5b1f9e24764a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1334,7 +1334,7 @@ struct trace_subsystem_dir {
 	struct list_head		list;
 	struct event_subsystem		*subsystem;
 	struct trace_array		*tr;
-	struct dentry			*entry;
+	struct eventfs_file             *ef;
 	int				ref_count;
 	int				nr_events;
 };
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 3ecc41f6acd9..ed367d713be0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -984,7 +984,7 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 		return;
 
 	if (!--dir->nr_events) {
-		tracefs_remove(dir->entry);
+		eventfs_remove(dir->ef);
 		list_del(&dir->list);
 		__put_system_dir(dir);
 	}
@@ -1005,7 +1005,7 @@ static void remove_event_file_dir(struct trace_event_file *file)
 
 		tracefs_remove(dir);
 	}
-
+	eventfs_remove(file->ef);
 	list_del(&file->list);
 	remove_subsystem(file->system);
 	free_event_filter(file->filter);
@@ -2291,13 +2291,13 @@ create_new_subsystem(const char *name)
 	return NULL;
 }
 
-static struct dentry *
+static struct eventfs_file *
 event_subsystem_dir(struct trace_array *tr, const char *name,
 		    struct trace_event_file *file, struct dentry *parent)
 {
 	struct event_subsystem *system, *iter;
 	struct trace_subsystem_dir *dir;
-	struct dentry *entry;
+	int res;
 
 	/* First see if we did not already create this dir */
 	list_for_each_entry(dir, &tr->systems, list) {
@@ -2305,7 +2305,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 		if (strcmp(system->name, name) == 0) {
 			dir->nr_events++;
 			file->system = dir;
-			return dir->entry;
+			return dir->ef;
 		}
 	}
 
@@ -2329,8 +2329,8 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	} else
 		__get_system(system);
 
-	dir->entry = tracefs_create_dir(name, parent);
-	if (!dir->entry) {
+	dir->ef = eventfs_add_subsystem_dir(name, parent);
+	if (IS_ERR(dir->ef)) {
 		pr_warn("Failed to create system directory %s\n", name);
 		__put_system(system);
 		goto out_free;
@@ -2345,22 +2345,22 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	/* the ftrace system is special, do not create enable or filter files */
 	if (strcmp(name, "ftrace") != 0) {
 
-		entry = tracefs_create_file("filter", TRACE_MODE_WRITE,
-					    dir->entry, dir,
+		res = eventfs_add_file("filter", TRACE_MODE_WRITE,
+					    dir->ef, dir,
 					    &ftrace_subsystem_filter_fops);
-		if (!entry) {
+		if (res) {
 			kfree(system->filter);
 			system->filter = NULL;
 			pr_warn("Could not create tracefs '%s/filter' entry\n", name);
 		}
 
-		trace_create_file("enable", TRACE_MODE_WRITE, dir->entry, dir,
+		eventfs_add_file("enable", TRACE_MODE_WRITE, dir->ef, dir,
 				  &ftrace_system_enable_fops);
 	}
 
 	list_add(&dir->list, &tr->systems);
 
-	return dir->entry;
+	return dir->ef;
 
  out_free:
 	kfree(dir);
@@ -2413,8 +2413,8 @@ static int
 event_create_dir(struct dentry *parent, struct trace_event_file *file)
 {
 	struct trace_event_call *call = file->event_call;
+	struct eventfs_file *ef_subsystem = NULL;
 	struct trace_array *tr = file->tr;
-	struct dentry *d_events;
 	const char *name;
 	int ret;
 
@@ -2426,24 +2426,24 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 	if (WARN_ON_ONCE(strcmp(call->class->system, TRACE_SYSTEM) == 0))
 		return -ENODEV;
 
-	d_events = event_subsystem_dir(tr, call->class->system, file, parent);
-	if (!d_events)
+	ef_subsystem = event_subsystem_dir(tr, call->class->system, file, parent);
+	if (!ef_subsystem)
 		return -ENOMEM;
 
 	name = trace_event_name(call);
-	file->dir = tracefs_create_dir(name, d_events);
-	if (!file->dir) {
+	file->ef = eventfs_add_dir(name, ef_subsystem);
+	if (IS_ERR(file->ef)) {
 		pr_warn("Could not create tracefs '%s' directory\n", name);
 		return -1;
 	}
 
 	if (call->class->reg && !(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE))
-		trace_create_file("enable", TRACE_MODE_WRITE, file->dir, file,
+		eventfs_add_file("enable", TRACE_MODE_WRITE, file->ef, file,
 				  &ftrace_enable_fops);
 
 #ifdef CONFIG_PERF_EVENTS
 	if (call->event.type && call->class->reg)
-		trace_create_file("id", TRACE_MODE_READ, file->dir,
+		eventfs_add_file("id", TRACE_MODE_READ, file->ef,
 				  (void *)(long)call->event.type,
 				  &ftrace_event_id_fops);
 #endif
@@ -2459,27 +2459,27 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 	 * triggers or filters.
 	 */
 	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
-		trace_create_file("filter", TRACE_MODE_WRITE, file->dir,
+		eventfs_add_file("filter", TRACE_MODE_WRITE, file->ef,
 				  file, &ftrace_event_filter_fops);
 
-		trace_create_file("trigger", TRACE_MODE_WRITE, file->dir,
+		eventfs_add_file("trigger", TRACE_MODE_WRITE, file->ef,
 				  file, &event_trigger_fops);
 	}
 
 #ifdef CONFIG_HIST_TRIGGERS
-	trace_create_file("hist", TRACE_MODE_READ, file->dir, file,
+	eventfs_add_file("hist", TRACE_MODE_READ, file->ef, file,
 			  &event_hist_fops);
 #endif
 #ifdef CONFIG_HIST_TRIGGERS_DEBUG
-	trace_create_file("hist_debug", TRACE_MODE_READ, file->dir, file,
+	eventfs_add_file("hist_debug", TRACE_MODE_READ, file->ef, file,
 			  &event_hist_debug_fops);
 #endif
-	trace_create_file("format", TRACE_MODE_READ, file->dir, call,
+	eventfs_add_file("format", TRACE_MODE_READ, file->ef, call,
 			  &ftrace_event_format_fops);
 
 #ifdef CONFIG_TRACE_EVENT_INJECT
 	if (call->event.type && call->class->reg)
-		trace_create_file("inject", 0200, file->dir, file,
+		eventfs_add_file("inject", 0200, file->ef, file,
 				  &event_inject_fops);
 #endif
 
@@ -3632,21 +3632,22 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 {
 	struct dentry *d_events;
 	struct dentry *entry;
+	int error = 0;
 
 	entry = trace_create_file("set_event", TRACE_MODE_WRITE, parent,
 				  tr, &ftrace_set_event_fops);
 	if (!entry)
 		return -ENOMEM;
 
-	d_events = tracefs_create_dir("events", parent);
-	if (!d_events) {
+	d_events = eventfs_create_events_dir("events", parent);
+	if (IS_ERR(d_events)) {
 		pr_warn("Could not create tracefs 'events' directory\n");
 		return -ENOMEM;
 	}
 
-	entry = trace_create_file("enable", TRACE_MODE_WRITE, d_events,
+	error = eventfs_add_events_file("enable", TRACE_MODE_WRITE, d_events,
 				  tr, &ftrace_tr_enable_fops);
-	if (!entry)
+	if (error)
 		return -ENOMEM;
 
 	/* There are not as crucial, just warn if they are not created */
@@ -3659,11 +3660,11 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 			  &ftrace_set_event_notrace_pid_fops);
 
 	/* ring buffer internal formats */
-	trace_create_file("header_page", TRACE_MODE_READ, d_events,
+	eventfs_add_events_file("header_page", TRACE_MODE_READ, d_events,
 				  ring_buffer_print_page_header,
 				  &ftrace_show_header_fops);
 
-	trace_create_file("header_event", TRACE_MODE_READ, d_events,
+	eventfs_add_events_file("header_event", TRACE_MODE_READ, d_events,
 				  ring_buffer_print_entry_header,
 				  &ftrace_show_header_fops);
 
@@ -3751,7 +3752,7 @@ int event_trace_del_tracer(struct trace_array *tr)
 
 	down_write(&trace_event_sem);
 	__trace_remove_event_dirs(tr);
-	tracefs_remove(tr->event_dir);
+	eventfs_remove_events_dir(tr->event_dir);
 	up_write(&trace_event_sem);
 
 	tr->event_dir = NULL;
-- 
2.40.1
