Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E7A76A55A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjHAAOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjHAAOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:14:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD757173F;
        Mon, 31 Jul 2023 17:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5330061378;
        Tue,  1 Aug 2023 00:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665AFC433C7;
        Tue,  1 Aug 2023 00:14:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQd25-003gA6-0u;
        Mon, 31 Jul 2023 20:14:37 -0400
Message-ID: <20230801001437.098004191@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 20:13:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>, chinglinyu@google.com,
        lkp@intel.com, namit@vmware.com, oe-lkp@lists.linux.dev,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH 2/2] eventfs: Remove eventfs_file and just use eventfs_inode
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

Instead of having a descriptor for every file represented in the eventfs
directory, only have the directory itself represented. Change the API to
send in a list of entries that represent all the files in the directory
(but not other directories). The entry list contains a name and a callback
function that will be used to create the files when they are accessed.

struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry *parent,
						const struct eventfs_entry *entries,
						int size, void *data);

is used for the top level eventfs directory, and returns an eventfs_inode
that will be used by:

struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode *parent,
					 const struct eventfs_entry *entries,
					 int size, void *data);

where both of the above take an array of struct eventfs_entry entries for
every file that is in the directory.

The entries are defined by:

typedef int (*eventfs_callback)(const char *name, umode_t *mode, void **data,
				const struct file_operations **fops);

struct eventfs_entry {
	const char			*name;
	eventfs_callback		callback;
};

Where the name is the name of the file and the callback gets called when
the file is being created. The callback passes in the name (in case the
same callback is used for multiple files), a pointer to the mode, data and
fops. The data will be pointing to the data that was passed in
eventfs_create_dir() or eventfs_create_events_dir() but may be overridden
to point to something else, as it will be used to point to the
inode->i_private that is created. The information passed back from the
callback is used to create the dentry/inode.

If the callback fills the data and the file should be created, it must
return a positive number. On zero or negative, the file is ignored.

This logic may also be used as a prototype to convert entire pseudo file
systems into just-in-time allocation.

The "show_events_dentry" file has been updated to show the directories,
and any files they have.

With just the eventfs_file allocations:

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

With this change:

 Before after deltas for meminfo:

   MemFree: -12340
   MemAvailable: -12340
   Inactive: 228
   Inactive(anon): 228
   AnonPages: 228
   Slab: 456
   SUnreclaim: 456
   VmallocUsed: 16

 Before after deltas for slabinfo:

   <slab>:		<objects>	[ * <size> = <total>]

   tracefs_inode_cache:	135		[* 1184 = 159840]
   dentry:		117		[* 312 = 36504]
   lsm_inode_cache:	231		[* 32 = 7392]
   vma_lock:		-9		[* 152 = -1368]
   vm_area_struct:	67		[* 184 = 12328]
   trace_event_file:	1722		[* 96 = 165312]
   kmalloc-128:		1870		[* 128 = 239360]
   kmalloc-64:		4687		[* 64 = 299968]

 Total slab additions in size: 919,336 bytes

That's over 1 MB in savings per instance.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c     | 745 +++++++++++++++++++----------------
 fs/tracefs/event_show.c      |  51 +--
 fs/tracefs/inode.c           |   2 +-
 fs/tracefs/internal.h        |  56 ++-
 include/linux/trace_events.h |   2 +-
 include/linux/tracefs.h      |  29 +-
 kernel/trace/trace.h         |   4 +-
 kernel/trace/trace_events.c  | 310 ++++++++++-----
 8 files changed, 683 insertions(+), 516 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 675847fcb179..17e1539e32c5 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -2,8 +2,9 @@
 /*
  *  event_inode.c - part of tracefs, a pseudo file system for activating tracing
  *
- *  Copyright (C) 2020-23 VMware Inc, author: Steven Rostedt (VMware) <rostedt@goodmis.org>
+ *  Copyright (C) 2020-23 VMware Inc, author: Steven Rostedt <rostedt@goodmis.org>
  *  Copyright (C) 2020-23 VMware Inc, author: Ajay Kaher <akaher@vmware.com>
+ *  Copyright (C) 2023 Google, author: Steven Rostedt <rostedt@goodmis.org>
  *
  *  eventfs is used to dynamically create inodes and dentries based on the
  *  meta data provided by the tracing system.
@@ -52,16 +53,9 @@ static const struct file_operations eventfs_file_operations = {
  * @data: something that the caller will want to get to later on.
  * @fop: struct file_operations that should be used for this file.
  *
- * This is the basic "create a file" function for tracefs.  It allows for a
- * wide range of flexibility in creating a file.
- *
- * This function will return a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the tracefs_remove() function when the file is
- * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
- *
- * If tracefs is not enabled in the kernel, the value -%ENODEV will be
- * returned.
+ * This function creates a dentry that represents a file in the eventsfs_inode
+ * directory. The inode.i_private pointer will point to @data in the open()
+ * call.
  */
 static struct dentry *create_file(const char *name, umode_t mode,
 				  struct dentry *parent, void *data,
@@ -77,6 +71,7 @@ static struct dentry *create_file(const char *name, umode_t mode,
 	if (WARN_ON_ONCE(!S_ISREG(mode)))
 		return NULL;
 
+	WARN_ON_ONCE(!parent);
 	dentry = eventfs_start_creating(name, parent);
 
 	if (IS_ERR(dentry))
@@ -101,20 +96,11 @@ static struct dentry *create_file(const char *name, umode_t mode,
  * create_dir - create a dir in the tracefs filesystem
  * @name: the name of the file to create.
  * @parent: parent dentry for this file.
- * @data: something that the caller will want to get to later on.
- *
- * This is the basic "create a dir" function for eventfs.  It allows for a
- * wide range of flexibility in creating a dir.
  *
- * This function will return a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the tracefs_remove() function when the file is
- * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
- *
- * If tracefs is not enabled in the kernel, the value -%ENODEV will be
- * returned.
+ * This function will create a dentry for a directory represented by
+ * a eventfs_inode.
  */
-static struct dentry *create_dir(const char *name, struct dentry *parent, void *data)
+static struct dentry *create_dir(const char *name, struct dentry *parent)
 {
 	struct tracefs_inode *ti;
 	struct dentry *dentry;
@@ -131,7 +117,6 @@ static struct dentry *create_dir(const char *name, struct dentry *parent, void *
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
 	inode->i_op = &eventfs_root_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
-	inode->i_private = data;
 
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
@@ -140,88 +125,183 @@ static struct dentry *create_dir(const char *name, struct dentry *parent, void *
 	d_instantiate(dentry, inode);
 	inc_nlink(dentry->d_parent->d_inode);
 	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
+
 	return eventfs_end_creating(dentry);
 }
 
 /**
- * eventfs_set_ef_status_free - set the ef->status to free
- * @dentry: dentry who's status to be freed
+ * eventfs_set_ei_status_free - remove the dentry reference from an eventfs_inode
+ * @dentry: dentry which has the reference to remove.
  *
- * eventfs_set_ef_status_free will be called if no more
- * references remain
+ * Remove the association between a dentry from an eventfs_inode.
  */
-void eventfs_set_ef_status_free(struct dentry *dentry)
+void eventfs_set_ei_status_free(struct dentry *dentry)
 {
 	struct tracefs_inode *ti_parent;
-	struct eventfs_file *ef;
+	struct eventfs_inode *ei;
+	int i;
 
 	mutex_lock(&eventfs_mutex);
 	ti_parent = get_tracefs(dentry->d_parent->d_inode);
 	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
 		goto out;
 
-	ef = dentry->d_fsdata;
-	if (!ef)
+	ei = dentry->d_fsdata;
+	if (!ei)
 		goto out;
 
 	/*
-	 * If ef was freed, then the LSB bit is set for d_fsdata.
+	 * If ei was freed, then the LSB bit is set for d_fsdata.
 	 * But this should not happen, as it should still have a
 	 * ref count that prevents it. Warn in case it does.
 	 */
-	if (WARN_ON_ONCE((unsigned long)ef & 1))
+	if (WARN_ON_ONCE((unsigned long)ei & 1))
 		goto out;
 
+	/* This could belong to one of the files of the ei */
+	if (ei->dentry != dentry) {
+		for (i = 0; i < ei->nr_entries; i++) {
+			if (ei->d_children[i] == dentry)
+				break;
+		}
+		if (WARN_ON_ONCE(i == ei->nr_entries))
+			goto out;
+		ei->d_children[i] = NULL;
+	} else {
+		ei->dentry = NULL;
+	}
+
 	dentry->d_fsdata = NULL;
-	ef->dentry = NULL;
-out:
+ out:
+	mutex_unlock(&eventfs_mutex);
+}
+
+/**
+ * create_file_dentry - create a dentry for a file of an eventfs_inode
+ * @ei: the eventfs_inode that the file will be created under
+ * @e_dentry: a pointer to the d_children[] of the @ei
+ * @parent: The parent dentry of the created file.
+ * @name: The name of the file to create
+ * @mode: The mode of the file.
+ * @data: The data to use to set the inode of the file with on open()
+ * @fops: The fops of the file to be created.
+ * @lookup: If called by the lookup routine, in which case, dput() the created dentry.
+ *
+ * Create a dentry for a file of an eventfs_inode @ei and place it into the
+ * address located at @e_dentry. If the @e_dentry already has a dentry, then
+ * just do a dget() on it and return. Otherwise create the dentry and attach it.
+ */
+static struct dentry *
+create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
+		   struct dentry *parent, const char *name, umode_t mode, void *data,
+		   const struct file_operations *fops, bool lookup)
+{
+	struct dentry *dentry;
+	bool invalidate = false;
+
+	mutex_lock(&eventfs_mutex);
+	/* If the e_dentry already has a dentry, use it */
+	if (*e_dentry) {
+		/* lookup does not need to up the ref count */
+		if (!lookup)
+			dget(*e_dentry);
+		mutex_unlock(&eventfs_mutex);
+		return *e_dentry;
+	}
+	mutex_unlock(&eventfs_mutex);
+
+	/* The lookup already has the parent->d_inode locked */
+	if (!lookup)
+		inode_lock(parent->d_inode);
+
+	dentry = create_file(name, mode, parent, data, fops);
+
+	if (!lookup)
+		inode_unlock(parent->d_inode);
+
+	mutex_lock(&eventfs_mutex);
+
+	if (IS_ERR_OR_NULL(dentry)) {
+		/*
+		 * When the mutex was released, something else could have
+		 * created the dentry for this e_dentry. In which case
+		 * use that one.
+		 *
+		 * Note, with the mutex held, the e_dentry cannot have content
+		 * and the ei->is_freed be true at the same time.
+		 */
+		WARN_ON_ONCE(ei->is_freed);
+		dentry = *e_dentry;
+		/* The lookup does not need to up the dentry refcount */
+		if (dentry && !lookup)
+			dget(dentry);
+		mutex_unlock(&eventfs_mutex);
+		return dentry;
+	}
+
+	if (!*e_dentry && !ei->is_freed) {
+		*e_dentry = dentry;
+		dentry->d_fsdata = ei;
+	} else {
+		/*
+		 * Should never happen unless we get here due to being freed.
+		 * Otherwise it means two dentries exist with the same name.
+		 */
+		WARN_ON_ONCE(!ei->is_freed);
+		invalidate = true;
+	}
 	mutex_unlock(&eventfs_mutex);
+
+	if (invalidate)
+		d_invalidate(dentry);
+
+	if (lookup || invalidate)
+		dput(dentry);
+
+	return invalidate ? NULL : dentry;
 }
 
 /**
  * eventfs_post_create_dir - post create dir routine
- * @ef: eventfs_file of recently created dir
+ * @ei: eventfs_inode of recently created dir
  *
  * Map the meta-data of files within an eventfs dir to their parent dentry
  */
-static void eventfs_post_create_dir(struct eventfs_file *ef)
+static void eventfs_post_create_dir(struct eventfs_inode *ei)
 {
-	struct eventfs_file *ef_child;
+	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
 
 	/* srcu lock already held */
 	/* fill parent-child relation */
-	list_for_each_entry_srcu(ef_child, &ef->ei->e_top_files, list,
+	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
-		ef_child->d_parent = ef->dentry;
+		ei_child->d_parent = ei->dentry;
 	}
 
-	ti = get_tracefs(ef->dentry->d_inode);
-	ti->private = ef->ei;
+	ti = get_tracefs(ei->dentry->d_inode);
+	ti->private = ei;
 }
 
 /**
- * create_dentry - helper function to create dentry
- * @ef: eventfs_file of file or directory to create
- * @parent: parent dentry
- * @lookup: true if called from lookup routine
+ * create_dir_dentry - Create a directory dentry for the eventfs_inode
+ * @ei: The eventfs_inode to create the directory for
+ * @parent: The dentry of the parent of this directory
+ * @lookup: True if this is called by the lookup code
  *
- * Used to create a dentry for file/dir, executes post dentry creation routine
+ * This creates and attaches a directory dentry to the eventfs_inode @ei.
  */
 static struct dentry *
-create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
+create_dir_dentry(struct eventfs_inode *ei, struct dentry *parent, bool lookup)
 {
 	bool invalidate = false;
-	struct dentry *dentry;
+	struct dentry *dentry = NULL;
 
 	mutex_lock(&eventfs_mutex);
-	if (ef->is_freed) {
-		mutex_unlock(&eventfs_mutex);
-		return NULL;
-	}
-	if (ef->dentry) {
-		dentry = ef->dentry;
-		/* On dir open, up the ref count */
+	if (ei->dentry) {
+		/* If the dentry already has a dentry, use it */
+		dentry = ei->dentry;
+		/* lookup does not need to up the ref count */
 		if (!lookup)
 			dget(dentry);
 		mutex_unlock(&eventfs_mutex);
@@ -229,42 +309,50 @@ create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
 	}
 	mutex_unlock(&eventfs_mutex);
 
+	/* The lookup already has the parent->d_inode locked */
 	if (!lookup)
 		inode_lock(parent->d_inode);
 
-	if (ef->ei)
-		dentry = create_dir(ef->name, parent, ef->data);
-	else
-		dentry = create_file(ef->name, ef->mode, parent,
-				     ef->data, ef->fop);
+	dentry = create_dir(ei->name, parent);
 
 	if (!lookup)
 		inode_unlock(parent->d_inode);
 
 	mutex_lock(&eventfs_mutex);
-	if (IS_ERR_OR_NULL(dentry)) {
-		/* If the ef was already updated get it */
-		dentry = ef->dentry;
+
+	if (IS_ERR_OR_NULL(dentry) && !ei->is_freed) {
+		/*
+		 * When the mutex was released, something else could have
+		 * created the dentry for this e_dentry. In which case
+		 * use that one.
+		 *
+		 * Note, with the mutex held, the e_dentry cannot have content
+		 * and the ei->is_freed be true at the same time.
+		 */
+		dentry = ei->dentry;
 		if (dentry && !lookup)
 			dget(dentry);
 		mutex_unlock(&eventfs_mutex);
 		return dentry;
 	}
 
-	if (!ef->dentry && !ef->is_freed) {
-		ef->dentry = dentry;
-		if (ef->ei)
-			eventfs_post_create_dir(ef);
-		dentry->d_fsdata = ef;
+	if (!ei->dentry && !ei->is_freed) {
+		ei->dentry = dentry;
+		eventfs_post_create_dir(ei);
+		dentry->d_fsdata = ei;
 	} else {
-		/* A race here, should try again (unless freed) */
+		/*
+		 * Should never happen unless we get here due to being freed.
+		 * Otherwise it means two dentries exist with the same name.
+		 */
+		WARN_ON_ONCE(!ei->is_freed);
 		invalidate = true;
 
 		/*
 		 * Should never happen unless we get here due to being freed.
 		 * Otherwise it means two dentries exist with the same name.
 		 */
-		WARN_ON_ONCE(!ef->is_freed);
+		WARN_ON_ONCE(!ei->is_freed);
 	}
 	mutex_unlock(&eventfs_mutex);
 	if (invalidate)
@@ -276,50 +364,70 @@ create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
 	return invalidate ? NULL : dentry;
 }
 
-static bool match_event_file(struct eventfs_file *ef, const char *name)
-{
-	bool ret;
-
-	mutex_lock(&eventfs_mutex);
-	ret = !ef->is_freed && strcmp(ef->name, name) == 0;
-	mutex_unlock(&eventfs_mutex);
-
-	return ret;
-}
-
 /**
  * eventfs_root_lookup - lookup routine to create file/dir
  * @dir: in which a lookup is being done
  * @dentry: file/dir dentry
- * @flags: to pass as flags parameter to simple lookup
+ * @flags: Just passed to simple_lookup()
  *
- * Used to create a dynamic file/dir within @dir. Use the eventfs_inode
- * list of meta data to find the information needed to create the file/dir.
+ * Used to create dynamic file/dir with-in @dir, search with-in @ei
+ * list, if @dentry found go ahead and create the file/dir
  */
+
 static struct dentry *eventfs_root_lookup(struct inode *dir,
 					  struct dentry *dentry,
 					  unsigned int flags)
 {
+	const struct file_operations *fops;
+	const struct eventfs_entry *entry;
+	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
-	struct eventfs_file *ef;
 	struct dentry *ret = NULL;
+	const char *name = dentry->d_name.name;
+	bool created = false;
+	umode_t mode;
+	void *data;
 	int idx;
+	int i;
+	int r;
 
 	ti = get_tracefs(dir);
 	if (!(ti->flags & TRACEFS_EVENT_INODE))
 		return NULL;
 
 	ei = ti->private;
+	data = ei->data;
+
 	idx = srcu_read_lock(&eventfs_srcu);
-	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
+	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
-		if (!match_event_file(ef, dentry->d_name.name))
+		if (strcmp(ei_child->name, name) != 0)
 			continue;
 		ret = simple_lookup(dir, dentry, flags);
-		create_dentry(ef, ef->d_parent, true);
+		create_dir_dentry(ei_child, ei->dentry, true);
+		created = true;
 		break;
 	}
+
+	if (created)
+		goto out;
+
+	for (i = 0; i < ei->nr_entries; i++) {
+		entry = &ei->entries[i];
+		if (strcmp(name, entry->name) == 0) {
+			void *cdata = data;
+			r = entry->callback(name, &mode, &cdata, &fops);
+			if (r <= 0)
+				continue;
+			ret = simple_lookup(dir, dentry, flags);
+			create_file_dentry(ei, &ei->d_children[i],
+					   ei->dentry, name, mode, cdata,
+					   fops, true);
+			break;
+		}
+	}
+ out:
 	srcu_read_unlock(&eventfs_srcu, idx);
 	return ret;
 }
@@ -331,11 +439,12 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
  */
 static int eventfs_release(struct inode *inode, struct file *file)
 {
+	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
-	struct eventfs_file *ef;
 	struct dentry *dentry;
 	int idx;
+	int i;
 
 	ti = get_tracefs(inode);
 	if (!(ti->flags & TRACEFS_EVENT_INODE))
@@ -343,108 +452,165 @@ static int eventfs_release(struct inode *inode, struct file *file)
 
 	ei = ti->private;
 	idx = srcu_read_lock(&eventfs_srcu);
-	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
+	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
 		mutex_lock(&eventfs_mutex);
-		dentry = ef->dentry;
+		dentry = ei_child->dentry;
+		mutex_unlock(&eventfs_mutex);
+		if (dentry)
+			dput(dentry);
+	}
+
+	for (i = 0; i < ei->nr_entries; i++) {
+		mutex_lock(&eventfs_mutex);
+		dentry = ei->d_children[i];
 		mutex_unlock(&eventfs_mutex);
 		if (dentry)
 			dput(dentry);
 	}
 	srcu_read_unlock(&eventfs_srcu, idx);
+
 	return dcache_dir_close(inode, file);
 }
 
 /**
  * dcache_dir_open_wrapper - eventfs open wrapper
  * @inode: not used
- * @file: dir to be opened (to create its child)
+ * @file: dir to be opened (to create it's children)
  *
- * Used to dynamically create the file/dir within @file. @file is really a
- * directory and all the files/dirs of the children within @file will be
- * created. If any of the files/dirs have already been created, their
- * reference count will be incremented.
+ * Used to dynamic create file/dir with-in @file, all the
+ * file/dir will be created. If already created then references
+ * will be increased
  */
 static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 {
+	const struct file_operations *fops;
+	const struct eventfs_entry *entry;
+	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
-	struct eventfs_file *ef;
-	struct dentry *dentry = file_dentry(file);
+	struct dentry *parent = file_dentry(file);
 	struct inode *f_inode = file_inode(file);
+	const char *name = parent->d_name.name;
+	umode_t mode;
+	void *data;
 	int idx;
+	int i;
+	int r;
 
 	ti = get_tracefs(f_inode);
 	if (!(ti->flags & TRACEFS_EVENT_INODE))
 		return -EINVAL;
 
 	ei = ti->private;
+	data = ei->data;
+
 	idx = srcu_read_lock(&eventfs_srcu);
-	list_for_each_entry_rcu(ef, &ei->e_top_files, list) {
-		create_dentry(ef, dentry, false);
+	list_for_each_entry_srcu(ei_child, &ei->children, list,
+				 srcu_read_lock_held(&eventfs_srcu)) {
+		create_dir_dentry(ei_child, parent, false);
+	}
+
+	for (i = 0; i < ei->nr_entries; i++) {
+		void *cdata = data;
+		entry = &ei->entries[i];
+		name = entry->name;
+		r = entry->callback(name, &mode, &cdata, &fops);
+		if (r <= 0)
+			continue;
+		create_file_dentry(ei, &ei->d_children[i],
+				       parent, name, mode, cdata, fops, false);
 	}
 	srcu_read_unlock(&eventfs_srcu, idx);
+
 	return dcache_dir_open(inode, file);
 }
 
 /**
- * eventfs_prepare_ef - helper function to prepare eventfs_file
- * @name: the name of the file/directory to create.
- * @mode: the permission that the file should have.
- * @fop: struct file_operations that should be used for this file/directory.
- * @iop: struct inode_operations that should be used for this file/directory.
- * @data: something that the caller will want to get to later on. The
- *        inode.i_private pointer will point to this value on the open() call.
+ * eventfs_create_dir - Create the eventfs_inode for this directory
+ * @name: The name of the directory to create.
+ * @parent: The eventfs_inode of the parent directory.
+ * @entries: A list of entries that represent the files under this directory
+ * @size: The number of @entries
+ * @data: The default data to pass to the files (an entry may override it).
+ *
+ * This function creates the descriptor to represent a directory in the
+ * eventfs. This descriptor is an eventfs_inode, and it is returned to be
+ * used to create other children underneath.
+ *
+ * The @entries is an array of eventfs_entry structures which has:
+ *	const char		 *name
+ *	eventfs_callback	callback;
  *
- * This function allocates and fills the eventfs_file structure.
+ * The name is the name of the file, and the callback is a pointer to a function
+ * that will be called when the file is reference (either by lookup or by
+ * reading a directory). The callback is of the prototype:
+ *
+ *    int callback(const char *name, umode_t *mode, void **data,
+ *		   const struct file_operations **fops);
+ *
+ * When a file needs to be created, this callback will be called with
+ *   name = the name of the file being created (so that the same callback
+ *          may be used for multiple files).
+ *   mode = a place to set the file's mode
+ *   data = A pointer to @data, and the callback may replace it, which will
+ *         cause the file created to pass the new data to the open() call.
+ *   fops = the fops to use for the created file.
  */
-static struct eventfs_file *eventfs_prepare_ef(const char *name, umode_t mode,
-					const struct file_operations *fop,
-					const struct inode_operations *iop,
-					void *data)
+struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode *parent,
+					 const struct eventfs_entry *entries,
+					 int size, void *data)
 {
-	struct eventfs_file *ef;
+	struct eventfs_inode *ei;
 
-	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
-	if (!ef)
+	if (!parent)
+		return ERR_PTR(-EINVAL);
+
+	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
+	if (!ei)
 		return ERR_PTR(-ENOMEM);
 
-	ef->name = kstrdup(name, GFP_KERNEL);
-	if (!ef->name) {
-		kfree(ef);
+	ei->name = kstrdup_const(name, GFP_KERNEL);
+	if (!ei->name) {
+		kfree(ei);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (S_ISDIR(mode)) {
-		ef->ei = kzalloc(sizeof(*ef->ei), GFP_KERNEL);
-		if (!ef->ei) {
-			kfree(ef->name);
-			kfree(ef);
+	if (size) {
+		ei->d_children = kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
+		if (!ei->d_children) {
+			kfree_const(ei->name);
+			kfree(ei);
 			return ERR_PTR(-ENOMEM);
 		}
-		INIT_LIST_HEAD(&ef->ei->e_top_files);
-	} else {
-		ef->ei = NULL;
 	}
 
-	ef->iop = iop;
-	ef->fop = fop;
-	ef->mode = mode;
-	ef->data = data;
-	return ef;
+	ei->entries = entries;
+	ei->nr_entries = size;
+	ei->data = data;
+	INIT_LIST_HEAD(&ei->children);
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ei->list, &parent->children);
+	ei->d_parent = parent->dentry;
+	mutex_unlock(&eventfs_mutex);
+
+	return ei;
 }
 
 /**
- * eventfs_create_events_dir - create the trace event structure
- * @name: the name of the directory to create.
- * @parent: parent dentry for this file.  This should be a directory dentry
- *          if set.  If this parameter is NULL, then the directory will be
- *          created in the root of the tracefs filesystem.
+ * eventfs_create_events_dir - create the top level events directory
+ * @name: The name of the top level directory to create.
+ * @parent: Parent dentry for this file in the tracefs directory.
+ * @entries: A list of entries that represent the files under this directory
+ * @size: The number of @entries
+ * @data: The default data to pass to the files (an entry may override it).
  *
  * This function creates the top of the trace event directory.
  */
-struct dentry *eventfs_create_events_dir(const char *name,
-					 struct dentry *parent)
+struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry *parent,
+						const struct eventfs_entry *entries,
+						int size, void *data)
 {
 	struct dentry *dentry = tracefs_start_creating(name, parent);
 	struct eventfs_inode *ei;
@@ -452,19 +618,32 @@ struct dentry *eventfs_create_events_dir(const char *name,
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
-		return dentry;
+		return (struct eventfs_inode *)dentry;
 
 	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
 	if (!ei)
-		return ERR_PTR(-ENOMEM);
+		goto fail;
+
 	inode = tracefs_get_inode(dentry->d_sb);
-	if (unlikely(!inode)) {
-		kfree(ei);
-		tracefs_failed_creating(dentry);
-		return ERR_PTR(-ENOMEM);
+	if (unlikely(!inode))
+		goto fail;
+
+	if (size) {
+		ei->d_children = kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
+		if (!ei->d_children)
+			goto fail;
 	}
 
-	INIT_LIST_HEAD(&ei->e_top_files);
+	ei->dentry = dentry;
+	ei->entries = entries;
+	ei->nr_entries = size;
+	ei->data = data;
+	ei->name = kstrdup_const(name, GFP_KERNEL);
+	if (!ei->name)
+		goto fail;
+
+	INIT_LIST_HEAD(&ei->children);
+	INIT_LIST_HEAD(&ei->list);
 
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
@@ -479,181 +658,41 @@ struct dentry *eventfs_create_events_dir(const char *name,
 	d_instantiate(dentry, inode);
 	inc_nlink(dentry->d_parent->d_inode);
 	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
-	return tracefs_end_creating(dentry);
-}
+	tracefs_end_creating(dentry);
 
-/**
- * eventfs_add_subsystem_dir - add eventfs subsystem_dir to list to create later
- * @name: the name of the file to create.
- * @parent: parent dentry for this dir.
- *
- * This function adds eventfs subsystem dir to list.
- * And all these dirs are created on the fly when they are looked up,
- * and the dentry and inodes will be removed when they are done.
- */
-struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
-					       struct dentry *parent)
-{
-	struct tracefs_inode *ti_parent;
-	struct eventfs_inode *ei_parent;
-	struct eventfs_file *ef;
+	/* Will call dput when the directory is removed */
+	dget(dentry);
 
-	if (!parent)
-		return ERR_PTR(-EINVAL);
+	return ei;
 
-	ti_parent = get_tracefs(parent->d_inode);
-	ei_parent = ti_parent->private;
-
-	ef = eventfs_prepare_ef(name, S_IFDIR, NULL, NULL, NULL);
-	if (IS_ERR(ef))
-		return ef;
-
-	mutex_lock(&eventfs_mutex);
-	list_add_tail(&ef->list, &ei_parent->e_top_files);
-	ef->d_parent = parent;
-	mutex_unlock(&eventfs_mutex);
-	return ef;
-}
-
-/**
- * eventfs_add_dir - add eventfs dir to list to create later
- * @name: the name of the file to create.
- * @ef_parent: parent eventfs_file for this dir.
- *
- * This function adds eventfs dir to list.
- * And all these dirs are created on the fly when they are looked up,
- * and the dentry and inodes will be removed when they are done.
- */
-struct eventfs_file *eventfs_add_dir(const char *name,
-				     struct eventfs_file *ef_parent)
-{
-	struct eventfs_file *ef;
-
-	if (!ef_parent)
-		return ERR_PTR(-EINVAL);
-
-	ef = eventfs_prepare_ef(name, S_IFDIR, NULL, NULL, NULL);
-	if (IS_ERR(ef))
-		return ef;
-
-	mutex_lock(&eventfs_mutex);
-	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
-	ef->d_parent = ef_parent->dentry;
-	mutex_unlock(&eventfs_mutex);
-	return ef;
-}
-
-/**
- * eventfs_add_events_file - add the data needed to create a file for later reference
- * @name: the name of the file to create.
- * @mode: the permission that the file should have.
- * @parent: parent dentry for this file.
- * @data: something that the caller will want to get to later on.
- * @fop: struct file_operations that should be used for this file.
- *
- * This function is used to add the information needed to create a
- * dentry/inode within the top level events directory. The file created
- * will have the @mode permissions. The @data will be used to fill the
- * inode.i_private when the open() call is done. The dentry and inodes are
- * all created when they are referenced, and removed when they are no
- * longer referenced.
- */
-int eventfs_add_events_file(const char *name, umode_t mode,
-			 struct dentry *parent, void *data,
-			 const struct file_operations *fop)
-{
-	struct tracefs_inode *ti;
-	struct eventfs_inode *ei;
-	struct eventfs_file *ef;
-
-	if (!parent)
-		return -EINVAL;
-
-	if (!(mode & S_IFMT))
-		mode |= S_IFREG;
-
-	if (!parent->d_inode)
-		return -EINVAL;
-
-	ti = get_tracefs(parent->d_inode);
-	if (!(ti->flags & TRACEFS_EVENT_INODE))
-		return -EINVAL;
-
-	ei = ti->private;
-	ef = eventfs_prepare_ef(name, mode, fop, NULL, data);
-
-	if (IS_ERR(ef))
-		return -ENOMEM;
-
-	mutex_lock(&eventfs_mutex);
-	list_add_tail(&ef->list, &ei->e_top_files);
-	ef->d_parent = parent;
-	mutex_unlock(&eventfs_mutex);
-	return 0;
-}
-
-/**
- * eventfs_add_file - add eventfs file to list to create later
- * @name: the name of the file to create.
- * @mode: the permission that the file should have.
- * @ef_parent: parent eventfs_file for this file.
- * @data: something that the caller will want to get to later on.
- * @fop: struct file_operations that should be used for this file.
- *
- * This function is used to add the information needed to create a
- * file within a subdirectory of the events directory. The file created
- * will have the @mode permissions. The @data will be used to fill the
- * inode.i_private when the open() call is done. The dentry and inodes are
- * all created when they are referenced, and removed when they are no
- * longer referenced.
- */
-int eventfs_add_file(const char *name, umode_t mode,
-		     struct eventfs_file *ef_parent,
-		     void *data,
-		     const struct file_operations *fop)
-{
-	struct eventfs_file *ef;
-
-	if (!ef_parent)
-		return -EINVAL;
-
-	if (!(mode & S_IFMT))
-		mode |= S_IFREG;
-
-	ef = eventfs_prepare_ef(name, mode, fop, NULL, data);
-	if (IS_ERR(ef))
-		return -ENOMEM;
-
-	mutex_lock(&eventfs_mutex);
-	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
-	ef->d_parent = ef_parent->dentry;
-	mutex_unlock(&eventfs_mutex);
-	return 0;
+ fail:
+	kfree(ei->d_children);
+	kfree(ei);
+	tracefs_failed_creating(dentry);
+	return ERR_PTR(-ENOMEM);
 }
 
-static void free_ef(struct rcu_head *head)
+static void free_ei(struct rcu_head *head)
 {
-	struct eventfs_file *ef = container_of(head, struct eventfs_file, rcu);
+	struct eventfs_inode *ei = container_of(head, struct eventfs_inode, rcu);
 
-	kfree(ef->name);
-	kfree(ef->ei);
-	kfree(ef);
+	kfree_const(ei->name);
+	kfree(ei->d_children);
+	kfree(ei);
 }
 
 /**
  * eventfs_remove_rec - remove eventfs dir or file from list
- * @ef: eventfs_file to be removed.
- * @head: to create list of eventfs_file to be deleted
- * @level: to check recursion depth
+ * @ei: eventfs_inode to be removed.
  *
- * The helper function eventfs_remove_rec() is used to clean up and free the
- * associated data from eventfs for both of the added functions.
+ * This function recursively remove eventfs_inode which
+ * contains info of file or dir.
  */
-static void eventfs_remove_rec(struct eventfs_file *ef, struct list_head *head, int level)
+static void eventfs_remove_rec(struct eventfs_inode *ei, struct list_head *head, int level)
 {
-	struct eventfs_file *ef_child;
+	struct eventfs_inode *ei_child;
 
-	if (!ef)
+	if (!ei)
 		return;
 	/*
 	 * Check recursion depth. It should never be greater than 3:
@@ -665,62 +704,68 @@ static void eventfs_remove_rec(struct eventfs_file *ef, struct list_head *head,
 	if (WARN_ON_ONCE(level > 3))
 		return;
 
-	if (ef->ei) {
-		/* search for nested folders or files */
-		list_for_each_entry_srcu(ef_child, &ef->ei->e_top_files, list,
-					 lockdep_is_held(&eventfs_mutex)) {
-			eventfs_remove_rec(ef_child, head, level + 1);
-		}
+	/* search for nested folders or files */
+	list_for_each_entry_srcu(ei_child, &ei->children, list,
+				 lockdep_is_held(&eventfs_mutex)) {
+		eventfs_remove_rec(ei_child, head, level + 1);
 	}
 
-	list_del_rcu(&ef->list);
-	list_add_tail(&ef->del_list, head);
+	list_del_rcu(&ei->list);
+	list_add_tail(&ei->del_list, head);
 }
 
+static void unhook_dentry(struct dentry **dentry, struct dentry **list)
+{
+	if (*dentry) {
+		unsigned long ptr = (unsigned long)*list;
+
+		/* Keep the dentry from being freed yet */
+		dget(*dentry);
+
+		/*
+		 * Paranoid: The dget() above should prevent the dentry
+		 * from being freed and calling eventfs_set_ei_status_free().
+		 * But just in case, set the link list LSB pointer to 1
+		 * and have eventfs_set_ei_status_free() check that to
+		 * make sure that if it does happen, it will not think
+		 * the d_fsdata is an eventfs_inode.
+		 *
+		 * For this to work, no eventfs_inode should be allocated
+		 * on a odd space, as the ef should always be allocated
+		 * to be at least word aligned. Check for that too.
+		 */
+		WARN_ON_ONCE(ptr & 1);
+
+		(*dentry)->d_fsdata = (void *)(ptr | 1);
+		*list = *dentry;
+		*dentry = NULL;
+	}
+}
 /**
  * eventfs_remove - remove eventfs dir or file from list
- * @ef: eventfs_file to be removed.
+ * @ei: eventfs_inode to be removed.
  *
  * This function acquire the eventfs_mutex lock and call eventfs_remove_rec()
  */
-void eventfs_remove(struct eventfs_file *ef)
+void eventfs_remove_dir(struct eventfs_inode *ei)
 {
-	struct eventfs_file *tmp;
-	LIST_HEAD(ef_del_list);
+	struct eventfs_inode *tmp;
+	LIST_HEAD(ei_del_list);
 	struct dentry *dentry_list = NULL;
 	struct dentry *dentry;
+	int i;
 
-	if (!ef)
+	if (!ei)
 		return;
 
 	mutex_lock(&eventfs_mutex);
-	eventfs_remove_rec(ef, &ef_del_list, 0);
-	list_for_each_entry_safe(ef, tmp, &ef_del_list, del_list) {
-		if (ef->dentry) {
-			unsigned long ptr = (unsigned long)dentry_list;
-
-			/* Keep the dentry from being freed yet */
-			dget(ef->dentry);
-
-			/*
-			 * Paranoid: The dget() above should prevent the dentry
-			 * from being freed and calling eventfs_set_ef_status_free().
-			 * But just in case, set the link list LSB pointer to 1
-			 * and have eventfs_set_ef_status_free() check that to
-			 * make sure that if it does happen, it will not think
-			 * the d_fsdata is an event_file.
-			 *
-			 * For this to work, no event_file should be allocated
-			 * on a odd space, as the ef should always be allocated
-			 * to be at least word aligned. Check for that too.
-			 */
-			WARN_ON_ONCE(ptr & 1);
-
-			ef->dentry->d_fsdata = (void *)(ptr | 1);
-			dentry_list = ef->dentry;
-			ef->dentry = NULL;
-		}
-		call_srcu(&eventfs_srcu, &ef->rcu, free_ef);
+	eventfs_remove_rec(ei, &ei_del_list, 0);
+
+	list_for_each_entry_safe(ei, tmp, &ei_del_list, del_list) {
+		for (i = 0; i < ei->nr_entries; i++)
+			unhook_dentry(&ei->d_children[i], &dentry_list);
+		unhook_dentry(&ei->dentry, &dentry_list);
+		call_srcu(&eventfs_srcu, &ei->rcu, free_ei);
 	}
 	mutex_unlock(&eventfs_mutex);
 
@@ -735,8 +780,8 @@ void eventfs_remove(struct eventfs_file *ef)
 		mutex_lock(&eventfs_mutex);
 		/* dentry should now have at least a single reference */
 		WARN_ONCE((int)d_count(dentry) < 1,
-			  "dentry %p less than one reference (%d) after invalidate\n",
-			  dentry, d_count(dentry));
+			  "dentry %px (%s) less than one reference (%d) after invalidate\n",
+			  dentry, dentry->d_name.name, d_count(dentry));
 		mutex_unlock(&eventfs_mutex);
 		dput(dentry);
 	}
@@ -763,5 +808,7 @@ void eventfs_remove_events_dir(struct dentry *dentry)
 	ei = ti->private;
 	d_invalidate(dentry);
 	dput(dentry);
+	kfree_const(ei->name);
+	kfree(ei->d_children);
 	kfree(ei);
 }
diff --git a/fs/tracefs/event_show.c b/fs/tracefs/event_show.c
index a402d0aa05a8..96a7c8dfdd09 100644
--- a/fs/tracefs/event_show.c
+++ b/fs/tracefs/event_show.c
@@ -14,7 +14,7 @@ static void *e_next(struct seq_file *m, void *v, loff_t *pos)
 	int level = elist->level;
 	struct list_head *head = elist->head[level];
 	struct list_head *next = elist->next[level];
-	struct eventfs_file *ef;
+	struct eventfs_inode *ei;
 
 	(*pos)++;
 
@@ -29,23 +29,23 @@ static void *e_next(struct seq_file *m, void *v, loff_t *pos)
 		elist->next[level] = next;
 	}
 
-	ef = list_entry(next, struct eventfs_file, list);
+	ei = list_entry(next, struct eventfs_inode, list);
 
-	if (ef->ei && !list_empty(&ef->ei->e_top_files) && level < 2) {
+	if (!list_empty(&ei->children) && level < 2) {
 		elist->level = ++level;
-		head = &ef->ei->e_top_files;
+		head = &ei->children;
 		elist->head[level] = head;
 		next = head;
 	}
 
 	elist->next[level] = next->next;
-	return ef;
+	return ei;
 }
 
 static void *e_start(struct seq_file *m, loff_t *pos)
 {
 	struct event_list *elist = m->private;
-	struct eventfs_file *ef = NULL;
+	struct eventfs_inode *ei = NULL;
 	loff_t l;
 
 	mutex_lock(&eventfs_mutex);
@@ -54,25 +54,31 @@ static void *e_start(struct seq_file *m, loff_t *pos)
 	elist->next[0] = elist->head[0]->next;
 
 	for (l = 0; l <= *pos; ) {
-		ef = e_next(m, ef, &l);
-		if (!ef)
+		ei = e_next(m, ei, &l);
+		if (!ei)
 			break;
 	}
-	return ef;
+	return ei;
 }
 
 static int e_show(struct seq_file *m, void *v)
 {
-	struct eventfs_file *ef = v;
+	struct eventfs_inode *ei = v;
+	int i;
 
-	seq_printf(m, "%px %s", ef, ef->name);
-	if (ef->ei)
-		seq_putc(m, '/');
+	seq_printf(m, "%px %s", ei, ei->name);
 
-	if (ef->dentry)
-		seq_printf(m, " dentry: %px (%d)", ef->dentry, d_count(ef->dentry));
+	if (ei->dentry)
+		seq_printf(m, " dentry: %px (%d)", ei->dentry, d_count(ei->dentry));
 	seq_putc(m, '\n');
 
+	for (i = 0; i < ei->nr_entries; i++) {
+		struct dentry *dentry = ei->d_children[i];
+		if (dentry) {
+			seq_printf(m, " %s dentry: %px (%d)\n",
+				   ei->entries[i].name, dentry, d_count(dentry));
+		}
+	}
 	return 0;
 }
 
@@ -93,25 +99,20 @@ eventfs_show_dentry_open(struct inode *inode, struct file *file)
 {
 	const struct seq_operations *seq_ops = &eventfs_show_dentry_seq_ops;
 	struct event_list *elist;
-	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
-	struct dentry *dentry;
 
-	/* The inode private should have the dentry of the "events" directory */
-	dentry = inode->i_private;
-	if (!dentry)
+	/* The inode private should have the eventfs_inode of the "events" directory */
+	ei = inode->i_private;
+	if (!ei)
 		return -EINVAL;
 
 	elist = __seq_open_private(file, seq_ops, sizeof(*elist));
 	if (!elist)
 		return -ENOMEM;
 
-	ti = get_tracefs(dentry->d_inode);
-	ei = ti->private;
-
 	elist->level = 0;
-	elist->head[0] = &ei->e_top_files;
-	elist->next[0] = ei->e_top_files.next;
+	elist->head[0] = &ei->children;
+	elist->next[0] = ei->children.next;
 
 	return 0;
 }
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index bb6de89eb446..007702e22d45 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -383,7 +383,7 @@ static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
 
 	ti = get_tracefs(inode);
 	if (ti && ti->flags & TRACEFS_EVENT_INODE)
-		eventfs_set_ef_status_free(dentry);
+		eventfs_set_ei_status_free(dentry);
 	iput(inode);
 }
 
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 4cb50d59ca6e..a232f073e6f7 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -8,48 +8,42 @@ enum {
 	TRACEFS_EVENT_INODE     = BIT(1),
 };
 
-struct eventfs_inode {
-	struct list_head	e_top_files;
+struct tracefs_inode {
+	unsigned long           flags;
+	void                    *private;
+	struct inode            vfs_inode;
 };
 
 /**
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
+ * struct eventfs_inode - hold the properties of the eventfs directories.
+ * @list:	link list into the parent directory
+ * @entries:	the array of entries representing the files in the directory
+ * @name:	the name of the directory to create
+ * @dentry:     the dentry of the directory
+ * @d_parent:   pointer to the parent's dentry
+ * @d_children: The array of dentries to represent the files when created
+ * @data:	The private data to pass to the callbacks
+ * @nr_entries: The number of items in @entries
  */
-struct eventfs_file {
+struct eventfs_inode {
+	struct list_head		list;
+	const struct eventfs_entry	*entries;
 	const char			*name;
-	struct dentry			*d_parent;
+	struct list_head		children;
 	struct dentry			*dentry;
-	struct list_head		list;
-	struct eventfs_inode		*ei;
-	const struct file_operations	*fop;
-	const struct inode_operations	*iop;
+	struct dentry			*d_parent;
+	struct dentry			**d_children;
+	void				*data;
 	union {
-		struct list_head	del_list; /* list of eventfs_file to delete */
-		struct rcu_head		rcu; /* eventfs_file to delete */
-		unsigned long		is_freed; /* Freed if one of the above is set */
+		struct list_head	del_list;
+		struct rcu_head		rcu;
+		unsigned long		is_freed;	/* true if the above are set */
 	};
-	void				*data;
-	umode_t				mode;
+	int				nr_entries;
 };
 
 extern struct mutex eventfs_mutex;
 
-struct tracefs_inode {
-	unsigned long           flags;
-	void                    *private;
-	struct inode            vfs_inode;
-};
-
 static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
 {
 	return container_of(inode, struct tracefs_inode, vfs_inode);
@@ -62,6 +56,6 @@ struct inode *tracefs_get_inode(struct super_block *sb);
 struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
 struct dentry *eventfs_failed_creating(struct dentry *dentry);
 struct dentry *eventfs_end_creating(struct dentry *dentry);
-void eventfs_set_ef_status_free(struct dentry *dentry);
+void eventfs_set_ei_status_free(struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index c17623c78029..eef8c5860f3c 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -638,7 +638,7 @@ struct trace_event_file {
 	struct list_head		list;
 	struct trace_event_call		*event_call;
 	struct event_filter __rcu	*filter;
-	struct eventfs_file             *ef;
+	struct eventfs_inode		*ei;
 	struct dentry			*dir;
 	struct trace_array		*tr;
 	struct trace_subsystem_dir	*system;
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index f76c7d74b23d..0f77ec2eb806 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -23,26 +23,25 @@ struct file_operations;
 
 struct eventfs_file;
 
-struct dentry *eventfs_create_events_dir(const char *name,
-					 struct dentry *parent);
+typedef int (*eventfs_callback)(const char *name, umode_t *mode, void **data,
+				const struct file_operations **fops);
 
-struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
-					       struct dentry *parent);
+struct eventfs_entry {
+	const char			*name;
+	eventfs_callback		callback;
+};
 
-struct eventfs_file *eventfs_add_dir(const char *name,
-				     struct eventfs_file *ef_parent);
+struct eventfs_inode;
 
-int eventfs_add_file(const char *name, umode_t mode,
-		     struct eventfs_file *ef_parent, void *data,
-		     const struct file_operations *fops);
+struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry *parent,
+						const struct eventfs_entry *entries,
+						int size, void *data);
 
-int eventfs_add_events_file(const char *name, umode_t mode,
-			 struct dentry *parent, void *data,
-			 const struct file_operations *fops);
+struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode *parent,
+					 const struct eventfs_entry *entries,
+					 int size, void *data);
 
-void eventfs_remove(struct eventfs_file *ef);
-
-void eventfs_remove_events_dir(struct dentry *dentry);
+void eventfs_remove_dir(struct eventfs_inode *ei);
 
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5b1f9e24764a..084564d6c5eb 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -381,7 +381,7 @@ struct trace_array {
 	struct dentry		*dir;
 	struct dentry		*options;
 	struct dentry		*percpu_dir;
-	struct dentry		*event_dir;
+	struct eventfs_inode	*event_dir;
 	struct trace_options	*topts;
 	struct list_head	systems;
 	struct list_head	events;
@@ -1334,7 +1334,7 @@ struct trace_subsystem_dir {
 	struct list_head		list;
 	struct event_subsystem		*subsystem;
 	struct trace_array		*tr;
-	struct eventfs_file             *ef;
+	struct eventfs_inode		*ei;
 	int				ref_count;
 	int				nr_events;
 };
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index d3c22752bf91..75febf0656d3 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -984,7 +984,7 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 		return;
 
 	if (!--dir->nr_events) {
-		eventfs_remove(dir->ef);
+		eventfs_remove_dir(dir->ei);
 		list_del(&dir->list);
 		__put_system_dir(dir);
 	}
@@ -1005,7 +1005,7 @@ static void remove_event_file_dir(struct trace_event_file *file)
 
 		tracefs_remove(dir);
 	}
-	eventfs_remove(file->ef);
+	eventfs_remove_dir(file->ei);
 	list_del(&file->list);
 	remove_subsystem(file->system);
 	free_event_filter(file->filter);
@@ -2291,13 +2291,46 @@ create_new_subsystem(const char *name)
 	return NULL;
 }
 
-static struct eventfs_file *
+static int ftrace_system_callback(const char *name, umode_t *mode, void **data,
+				  const struct file_operations **fops)
+{
+	/* ftrace only has directories no files */
+	return 0;
+}
+
+int system_callback(const char *name, umode_t *mode, void **data,
+		    const struct file_operations **fops)
+{
+	if (strcmp(name, "filter") == 0)
+		*fops = &ftrace_subsystem_filter_fops;
+
+	else if (strcmp(name, "enable") == 0)
+		*fops = &ftrace_system_enable_fops;
+
+	else
+		return 0;
+
+	*mode = TRACE_MODE_WRITE;
+	return 1;
+}
+
+static struct eventfs_inode *
 event_subsystem_dir(struct trace_array *tr, const char *name,
-		    struct trace_event_file *file, struct dentry *parent)
+		    struct trace_event_file *file, struct eventfs_inode *parent)
 {
 	struct event_subsystem *system, *iter;
 	struct trace_subsystem_dir *dir;
-	int res;
+	int nr_entries;
+	static struct eventfs_entry system_entries[] = {
+		{
+			.name		= "filter",
+			.callback	= system_callback,
+		},
+		{
+			.name		= "enable",
+			.callback	= system_callback,
+		}
+	};
 
 	/* First see if we did not already create this dir */
 	list_for_each_entry(dir, &tr->systems, list) {
@@ -2305,7 +2338,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 		if (strcmp(system->name, name) == 0) {
 			dir->nr_events++;
 			file->system = dir;
-			return dir->ef;
+			return dir->ei;
 		}
 	}
 
@@ -2329,8 +2362,14 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	} else
 		__get_system(system);
 
-	dir->ef = eventfs_add_subsystem_dir(name, parent);
-	if (IS_ERR(dir->ef)) {
+	/* ftrace only has directories no files */
+	if (strcmp(name, "ftrace") == 0)
+		nr_entries = 0;
+	else
+		nr_entries = ARRAY_SIZE(system_entries);
+
+	dir->ei = eventfs_create_dir(name, parent, system_entries, nr_entries, dir);
+	if (!dir->ei) {
 		pr_warn("Failed to create system directory %s\n", name);
 		__put_system(system);
 		goto out_free;
@@ -2342,25 +2381,9 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	dir->subsystem = system;
 	file->system = dir;
 
-	/* the ftrace system is special, do not create enable or filter files */
-	if (strcmp(name, "ftrace") != 0) {
-
-		res = eventfs_add_file("filter", TRACE_MODE_WRITE,
-					    dir->ef, dir,
-					    &ftrace_subsystem_filter_fops);
-		if (res) {
-			kfree(system->filter);
-			system->filter = NULL;
-			pr_warn("Could not create tracefs '%s/filter' entry\n", name);
-		}
-
-		eventfs_add_file("enable", TRACE_MODE_WRITE, dir->ef, dir,
-				  &ftrace_system_enable_fops);
-	}
-
 	list_add(&dir->list, &tr->systems);
 
-	return dir->ef;
+	return dir->ei;
 
  out_free:
 	kfree(dir);
@@ -2409,14 +2432,129 @@ event_define_fields(struct trace_event_call *call)
 	return ret;
 }
 
+static int event_callback(const char *name, umode_t *mode, void **data,
+			  const struct file_operations **fops)
+{
+	struct trace_event_file *file = *data;
+	struct trace_event_call *call = file->event_call;
+
+	if (strcmp(name, "format") == 0) {
+		*mode = TRACE_MODE_READ;
+		*fops = &ftrace_event_format_fops;
+		*data = call;
+		return 1;
+	}
+
+	/*
+	 * Only event directories that can be enabled should have
+	 * triggers or filters.
+	 */
+	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
+		if (call->class->reg && strcmp(name, "enable") == 0) {
+			*mode = TRACE_MODE_WRITE;
+			*fops = &ftrace_enable_fops;
+			return 1;
+		}
+
+		if (strcmp(name, "filter") == 0) {
+			*mode = TRACE_MODE_WRITE;
+			*fops = &ftrace_event_filter_fops;
+			return 1;
+		}
+
+		if (strcmp(name, "trigger") == 0) {
+			*mode = TRACE_MODE_WRITE;
+			*fops = &event_trigger_fops;
+			return 1;
+		}
+	}
+
+#ifdef CONFIG_PERF_EVENTS
+	if (call->event.type && call->class->reg &&
+	    strcmp(name, "id") == 0) {
+		*mode = TRACE_MODE_READ;
+		*data = (void *)(long)call->event.type;
+		*fops = &ftrace_event_id_fops;
+		return 1;
+	}
+#endif
+
+#ifdef CONFIG_HIST_TRIGGERS
+	if (strcmp(name, "hist") == 0) {
+		*mode = TRACE_MODE_READ;
+		*fops = &event_hist_fops;
+		return 1;
+	}
+#endif
+#ifdef CONFIG_HIST_TRIGGERS_DEBUG
+	if (strcmp(name, "hist_debug") == 0) {
+		*mode = TRACE_MODE_READ;
+		*fops = &event_hist_debug_fops;
+		return 1;
+	}
+#endif
+#ifdef CONFIG_TRACE_EVENT_INJECT
+	if (call->event.type && call->class->reg &&
+	    strcmp(name, "inject") == 0) {
+		*mode = 0200;
+		*fops = &event_inject_fops;
+		return 1;
+	}
+#endif
+	return 0;
+}
+
 static int
-event_create_dir(struct dentry *parent, struct trace_event_file *file)
+event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 {
 	struct trace_event_call *call = file->event_call;
-	struct eventfs_file *ef_subsystem = NULL;
 	struct trace_array *tr = file->tr;
+	struct eventfs_inode *e_events;
 	const char *name;
+	int nr_entries;
 	int ret;
+	static struct eventfs_entry event_entries[] = {
+		{
+			.name		= "enable",
+			.callback	= event_callback,
+		},
+		{
+			.name		= "filter",
+			.callback	= event_callback,
+		},
+		{
+			.name		= "trigger",
+			.callback	= event_callback,
+		},
+		{
+			.name		= "format",
+			.callback	= event_callback,
+		},
+#ifdef CONFIG_PERF_EVENTS
+		{
+			.name		= "id",
+			.callback	= event_callback,
+		},
+#endif
+#ifdef CONFIG_HIST_TRIGGERS
+		{
+			.name		= "hist",
+			.callback	= event_callback,
+		},
+#endif
+#ifdef CONFIG_HIST_TRIGGERS_DEBUG
+		{
+			.name		= "hist_debug",
+			.callback	= event_callback,
+		},
+#endif
+#ifdef CONFIG_TRACE_EVENT_INJECT
+		{
+			.name		= "inject",
+			.callback	= event_callback,
+		},
+#endif
+	};
 
 	/*
 	 * If the trace point header did not define TRACE_SYSTEM
@@ -2426,63 +2564,25 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 	if (WARN_ON_ONCE(strcmp(call->class->system, TRACE_SYSTEM) == 0))
 		return -ENODEV;
 
-	ef_subsystem = event_subsystem_dir(tr, call->class->system, file, parent);
-	if (!ef_subsystem)
+	e_events = event_subsystem_dir(tr, call->class->system, file, parent);
+	if (!e_events)
 		return -ENOMEM;
 
+	nr_entries = ARRAY_SIZE(event_entries);
+
 	name = trace_event_name(call);
-	file->ef = eventfs_add_dir(name, ef_subsystem);
-	if (IS_ERR(file->ef)) {
+	file->ei = eventfs_create_dir(name, e_events, event_entries, nr_entries, file);
+	if (IS_ERR(file->ei)) {
 		pr_warn("Could not create tracefs '%s' directory\n", name);
 		return -1;
 	}
 
-	if (call->class->reg && !(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE))
-		eventfs_add_file("enable", TRACE_MODE_WRITE, file->ef, file,
-				  &ftrace_enable_fops);
-
-#ifdef CONFIG_PERF_EVENTS
-	if (call->event.type && call->class->reg)
-		eventfs_add_file("id", TRACE_MODE_READ, file->ef,
-				  (void *)(long)call->event.type,
-				  &ftrace_event_id_fops);
-#endif
-
 	ret = event_define_fields(call);
 	if (ret < 0) {
 		pr_warn("Could not initialize trace point events/%s\n", name);
 		return ret;
 	}
 
-	/*
-	 * Only event directories that can be enabled should have
-	 * triggers or filters.
-	 */
-	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
-		eventfs_add_file("filter", TRACE_MODE_WRITE, file->ef,
-				  file, &ftrace_event_filter_fops);
-
-		eventfs_add_file("trigger", TRACE_MODE_WRITE, file->ef,
-				  file, &event_trigger_fops);
-	}
-
-#ifdef CONFIG_HIST_TRIGGERS
-	eventfs_add_file("hist", TRACE_MODE_READ, file->ef, file,
-			  &event_hist_fops);
-#endif
-#ifdef CONFIG_HIST_TRIGGERS_DEBUG
-	eventfs_add_file("hist_debug", TRACE_MODE_READ, file->ef, file,
-			  &event_hist_debug_fops);
-#endif
-	eventfs_add_file("format", TRACE_MODE_READ, file->ef, call,
-			  &ftrace_event_format_fops);
-
-#ifdef CONFIG_TRACE_EVENT_INJECT
-	if (call->event.type && call->class->reg)
-		eventfs_add_file("inject", 0200, file->ef, file,
-				  &event_inject_fops);
-#endif
-
 	return 0;
 }
 
@@ -3626,33 +3726,68 @@ static __init int setup_trace_event(char *str)
 }
 __setup("trace_event=", setup_trace_event);
 
+static int events_callback(const char *name, umode_t *mode, void **data,
+			   const struct file_operations **fops)
+{
+	if (strcmp(name, "enable") == 0) {
+		*mode = TRACE_MODE_WRITE;
+		*fops = &ftrace_tr_enable_fops;
+		return 1;
+	}
+
+	if (strcmp(name, "header_page") == 0)
+		*data = ring_buffer_print_page_header;
+
+	else if (strcmp(name, "header_event") == 0)
+		*data = ring_buffer_print_entry_header;
+
+	else
+		return 0;
+
+	*mode = TRACE_MODE_READ;
+	*fops = &ftrace_show_header_fops;
+	return 1;
+}
+
 /* Expects to have event_mutex held when called */
 static int
 create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 {
-	struct dentry *d_events;
+	struct eventfs_inode *e_events;
 	struct dentry *entry;
-	int error = 0;
+	int nr_entries;
+	static struct eventfs_entry events_entries[] = {
+		{
+			.name		= "enable",
+			.callback	= events_callback,
+		},
+		{
+			.name		= "header_page",
+			.callback	= events_callback,
+		},
+		{
+			.name		= "header_event",
+			.callback	= events_callback,
+		},
+	};
 
 	entry = trace_create_file("set_event", TRACE_MODE_WRITE, parent,
 				  tr, &ftrace_set_event_fops);
 	if (!entry)
 		return -ENOMEM;
 
-	d_events = eventfs_create_events_dir("events", parent);
-	if (IS_ERR(d_events)) {
+	nr_entries = ARRAY_SIZE(events_entries);
+
+	e_events = eventfs_create_events_dir("events", parent, events_entries,
+					     nr_entries, tr);
+	if (IS_ERR(e_events)) {
 		pr_warn("Could not create tracefs 'events' directory\n");
 		return -ENOMEM;
 	}
 
-	trace_create_file("show_events_dentries", TRACE_MODE_READ, parent, d_events,
+	trace_create_file("show_events_dentries", TRACE_MODE_READ, parent, e_events,
 			  &eventfs_show_dentry_fops);
 
-	error = eventfs_add_events_file("enable", TRACE_MODE_WRITE, d_events,
-				  tr, &ftrace_tr_enable_fops);
-	if (error)
-		return -ENOMEM;
-
 	/* There are not as crucial, just warn if they are not created */
 
 	trace_create_file("set_event_pid", TRACE_MODE_WRITE, parent,
@@ -3662,16 +3797,7 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 			  TRACE_MODE_WRITE, parent, tr,
 			  &ftrace_set_event_notrace_pid_fops);
 
-	/* ring buffer internal formats */
-	eventfs_add_events_file("header_page", TRACE_MODE_READ, d_events,
-				  ring_buffer_print_page_header,
-				  &ftrace_show_header_fops);
-
-	eventfs_add_events_file("header_event", TRACE_MODE_READ, d_events,
-				  ring_buffer_print_entry_header,
-				  &ftrace_show_header_fops);
-
-	tr->event_dir = d_events;
+	tr->event_dir = e_events;
 
 	return 0;
 }
@@ -3755,7 +3881,7 @@ int event_trace_del_tracer(struct trace_array *tr)
 
 	down_write(&trace_event_sem);
 	__trace_remove_event_dirs(tr);
-	eventfs_remove_events_dir(tr->event_dir);
+	eventfs_remove_dir(tr->event_dir);
 	up_write(&trace_event_sem);
 
 	tr->event_dir = NULL;
-- 
2.40.1
