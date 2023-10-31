Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F29F7DD860
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376343AbjJaWen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346808AbjJaWe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:34:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1F2F4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:34:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17F4C43395;
        Tue, 31 Oct 2023 22:34:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qxxJU-00EPj5-37;
        Tue, 31 Oct 2023 18:34:20 -0400
Message-ID: <20231031223420.778161254@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 31 Oct 2023 18:33:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH v5 5/7] eventfs: Hold eventfs_mutex when calling callback functions
References: <20231031223326.794680978@goodmis.org>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The callback function that is used to create inodes and dentries is not
protected by anything and the data that is passed to it could become
stale. After eventfs_remove_dir() is called by the tracing system, it is
free to remove the events that are associated to that directory.
Unfortunately, that means the callbacks must not be called after that.

     CPU0				CPU1
     ----				----
 eventfs_root_lookup() {
				 eventfs_remove_dir() {
				      mutex_lock(&event_mutex);
				      ei->is_freed = set;
				      mutex_unlock(&event_mutex);
				 }
				 kfree(event_call);

    for (...) {
      entry = &ei->entries[i];
      r = entry->callback() {
          call = data;		// call == event_call above
          if (call->flags ...)

 [ USE AFTER FREE BUG ]

The safest way to protect this is to wrap the callback with:

 mutex_lock(&eventfs_mutex);
 if (!ei->is_freed)
     r = entry->callback();
 else
     r = -1;
 mutex_unlock(&eventfs_mutex);

This will make sure that the callback will not be called after it is
freed. But now it needs to be known that the callback is called while
holding internal eventfs locks, and that it must not call back into the
eventfs / tracefs system. There's no reason it should anyway, but document
that as well.

Link: https://lore.kernel.org/all/CA+G9fYu9GOEbD=rR5eMR-=HJ8H6rMsbzDC2ZY5=Y50WpWAE7_Q@mail.gmail.com/

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1/v4: https://lore.kernel.org/linux-trace-kernel/20231030114047.759c7bdf@gandalf.local.home

- Rebased to this series (which is was v4)

 fs/tracefs/event_inode.c | 22 ++++++++++++++++++--
 include/linux/tracefs.h  | 43 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index d1683bf6d316..87a8aaeda231 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -615,7 +615,13 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		entry = &ei->entries[i];
 		if (strcmp(name, entry->name) == 0) {
 			void *cdata = data;
-			r = entry->callback(name, &mode, &cdata, &fops);
+			mutex_lock(&eventfs_mutex);
+			/* If ei->is_freed, then the event itself may be too */
+			if (!ei->is_freed)
+				r = entry->callback(name, &mode, &cdata, &fops);
+			else
+				r = -1;
+			mutex_unlock(&eventfs_mutex);
 			if (r <= 0)
 				continue;
 			ret = simple_lookup(dir, dentry, flags);
@@ -749,7 +755,13 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 		void *cdata = data;
 		entry = &ei->entries[i];
 		name = entry->name;
-		r = entry->callback(name, &mode, &cdata, &fops);
+		mutex_lock(&eventfs_mutex);
+		/* If ei->is_freed, then the event itself may be too */
+		if (!ei->is_freed)
+			r = entry->callback(name, &mode, &cdata, &fops);
+		else
+			r = -1;
+		mutex_unlock(&eventfs_mutex);
 		if (r <= 0)
 			continue;
 		d = create_file_dentry(ei, i, parent, name, mode, cdata, fops, false);
@@ -819,6 +831,10 @@ static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx)
  *   data = A pointer to @data, and the callback may replace it, which will
  *         cause the file created to pass the new data to the open() call.
  *   fops = the fops to use for the created file.
+ *
+ * NB. @callback is called while holding internal locks of the eventfs
+ *     system. The callback must not call any code that might also call into
+ *     the tracefs or eventfs system or it will risk creating a deadlock.
  */
 struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode *parent,
 					 const struct eventfs_entry *entries,
@@ -878,6 +894,8 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
  * @data: The default data to pass to the files (an entry may override it).
  *
  * This function creates the top of the trace event directory.
+ *
+ * See eventfs_create_dir() for use of @entries.
  */
 struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry *parent,
 						const struct eventfs_entry *entries,
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 13359b1a35d1..7a5fe17b6bf9 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -23,9 +23,52 @@ struct file_operations;
 
 struct eventfs_file;
 
+/**
+ * eventfs_callback - A callback function to create dynamic files in eventfs
+ * @name: The name of the file that is to be created
+ * @mode: return the file mode for the file (RW access, etc)
+ * @data: data to pass to the created file ops
+ * @fops: the file operations of the created file
+ *
+ * The evetnfs files are dynamically created. The struct eventfs_entry array
+ * is passed to eventfs_create_dir() or eventfs_create_events_dir() that will
+ * be used to create the files within those directories. When a lookup
+ * or access to a file within the directory is made, the struct eventfs_entry
+ * array is used to find a callback() with the matching name that is being
+ * referenced (for lookups, the entire array is iterated and each callback
+ * will be called).
+ *
+ * The callback will be called with @name for the name of the file to create.
+ * The callback can return less than 1 to indicate  that no file should be
+ * created.
+ *
+ * If a file is to be created, then @mode should be populated with the file
+ * mode (permissions) for which the file is created for. This would be
+ * used to set the created inode i_mode field.
+ *
+ * The @data should be set to the data passed to the other file operations
+ * (read, write, etc). Note, @data will also point to the data passed in
+ * to eventfs_create_dir() or eventfs_create_events_dir(), but the callback
+ * can replace the data if it chooses to. Otherwise, the original data
+ * will be used for the file operation functions.
+ *
+ * The @fops should be set to the file operations that will be used to create
+ * the inode.
+ *
+ * NB. This callback is called while holding internal locks of the eventfs
+ *     system. The callback must not call any code that might also call into
+ *     the tracefs or eventfs system or it will risk creating a deadlock.
+ */
 typedef int (*eventfs_callback)(const char *name, umode_t *mode, void **data,
 				const struct file_operations **fops);
 
+/**
+ * struct eventfs_entry - dynamically created eventfs file call back handler
+ * @name:	Then name of the dynamic file in an eventfs directory
+ * @callback:	The callback to get the fops of the file when it is created
+ *
+ * See evenfs_callback() typedef for how to set up @callback.
+ */
 struct eventfs_entry {
 	const char			*name;
 	eventfs_callback		callback;
-- 
2.42.0
