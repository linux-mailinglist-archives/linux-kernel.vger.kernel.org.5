Return-Path: <linux-kernel+bounces-54893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD5E84B4DD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B502847F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A0D13A258;
	Tue,  6 Feb 2024 12:09:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7B913340F;
	Tue,  6 Feb 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221361; cv=none; b=NWjLiJud9zTgAhrDLmwqXlICWs+v4FMkR1jPkLy8+nk4gu8S9VQEdWqJ2s23OqhiY1ecprSpVXD2u+zqFg9uTsp/WRCr3fsi5JhRmQ97ZI4ZOQNY6jMU925aW5XxFXnQAPPMO8l6IFr2fkFutshSJcce5gb0HWfaY4K3k9ZLcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221361; c=relaxed/simple;
	bh=Ds/0uDvMhgVKQBK9pz1xuo17yjshJeDZO5q2PioWVWc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=a8z9JR4W5N7eptvID/D24wpnbiW5w5Uown+g9j37cf6jL9UBbPIkUnt0I+YQUltdphfbVAcnhrAAoUnV0ZCXc/o2MzDyvqMh2ubqZzlDUtq8ogI5b5M+vozKdMUtutiu+a1w5xvQI5bnu+b/Lt20nm0KhsFphbWyEqGFSnV3OrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B99BC433B1;
	Tue,  6 Feb 2024 12:09:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGr-00000006bBL-3EKs;
	Tue, 06 Feb 2024 07:09:49 -0500
Message-ID: <20240206120949.629213120@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ajay Kaher <akaher@vmware.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [v6.6][PATCH 20/57] eventfs: Hold eventfs_mutex when calling callback functions
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
Link: https://lkml.kernel.org/r/20231101172649.906696613@goodmis.org

Cc: Ajay Kaher <akaher@vmware.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 44365329f8219fc379097c2c9a75ff53f123764f)
---
 fs/tracefs/event_inode.c | 22 ++++++++++++++++++--
 include/linux/tracefs.h  | 43 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 93d08e552483..8ac9abf7a3d5 100644
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
2.43.0



