Return-Path: <linux-kernel+bounces-165924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB568B9384
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251381F223F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1611BC23;
	Thu,  2 May 2024 03:00:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA68217753;
	Thu,  2 May 2024 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618808; cv=none; b=kgtj3PN16Mg4ZXnZz3G9RLoRz5HVeMT0oFPQrbA15xJDFg0DHHuX3oYilpy0HRRU/vdZ7PJrnXhmiCm/xSYOJuyOtDdUXObPR7QGUygutFC/m6lxDTQHwMwB1bErL8bOPZCVfOV7EuCN92se6BWmJPgpLtnJjLw+mn0ZsiJVWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618808; c=relaxed/simple;
	bh=rlxBYejMI5eLwdgRniNFednykQJ9FFa5TEGJMDAHtMw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=knj5NRg9F3vG5diL0c/TnGVQFfVC6nP3+udJY70cLaICKR9CpMR1PrL0D29MPjluDIsklg+5NitdMmXUcbiwwXYyyRKAlg0BicxXr8l6iv2LNb7Lp4Os+t3rkKNyWIcpWX3R9GyZV5j9p6GA/PJOQnyfO7wAr7tAoeo6Fh5DvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DBBC4AF19;
	Thu,  2 May 2024 03:00:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s2Mgn-000000039gk-1FIj;
	Wed, 01 May 2024 23:00:53 -0400
Message-ID: <20240502030053.156658371@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 01 May 2024 23:00:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH 1/5] tracefs: Reset permissions on remount if permissions are options
References: <20240502030024.062275408@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There's an inconsistency with the way permissions are handled in tracefs.
Because the permissions are generated when accessed, they default to the
root inode's permission if they were never set by the user. If the user
sets the permissions, then a flag is set and the permissions are saved via
the inode (for tracefs files) or an internal attribute field (for
eventfs).

But if a remount happens that specify the permissions, all the files that
were not changed by the user gets updated, but the ones that were are not.
If the user were to remount the file system with a given permission, then
all files and directories within that file system should be updated.

This can cause security issues if a file's permission was updated but the
admin forgot about it. They could incorrectly think that remounting with
permissions set would update all files, but miss some.

For example:

 # cd /sys/kernel/tracing
 # chgrp 1002 current_tracer
 # ls -l
[..]
 -rw-r-----  1 root root 0 May  1 21:25 buffer_size_kb
 -rw-r-----  1 root root 0 May  1 21:25 buffer_subbuf_size_kb
 -r--r-----  1 root root 0 May  1 21:25 buffer_total_size_kb
 -rw-r-----  1 root lkp  0 May  1 21:25 current_tracer
 -rw-r-----  1 root root 0 May  1 21:25 dynamic_events
 -r--r-----  1 root root 0 May  1 21:25 dyn_ftrace_total_info
 -r--r-----  1 root root 0 May  1 21:25 enabled_functions

Where current_tracer now has group "lkp".

 # mount -o remount,gid=1001 .
 # ls -l
 -rw-r-----  1 root tracing 0 May  1 21:25 buffer_size_kb
 -rw-r-----  1 root tracing 0 May  1 21:25 buffer_subbuf_size_kb
 -r--r-----  1 root tracing 0 May  1 21:25 buffer_total_size_kb
 -rw-r-----  1 root lkp     0 May  1 21:25 current_tracer
 -rw-r-----  1 root tracing 0 May  1 21:25 dynamic_events
 -r--r-----  1 root tracing 0 May  1 21:25 dyn_ftrace_total_info
 -r--r-----  1 root tracing 0 May  1 21:25 enabled_functions

Everything changed but the "current_tracer".

Add a new link list that keeps track of all the tracefs_inodes which has
the permission flags that tell if the file/dir should use the root inode's
permission or not. Then on remount, clear all the flags so that the
default behavior of using the root inode's permission is done for all
files and directories.

Cc: stable@vger.kernel.org
Fixes: 8186fff7ab649 ("tracefs/eventfs: Use root and instance inodes as default ownership")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 29 +++++++++++++++++++++++++++++
 fs/tracefs/inode.c       | 40 +++++++++++++++++++++++++++++++++++++++-
 fs/tracefs/internal.h    |  2 ++
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index dc97c19f9e0a..db71fed7057d 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -289,6 +289,35 @@ static const struct file_operations eventfs_file_operations = {
 	.llseek		= generic_file_llseek,
 };
 
+/*
+ * On a remount of tracefs, if UID or GID options are set, then
+ * the mount point inode permissions should be used.
+ * Reset the saved permission flags appropriately.
+ */
+void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid)
+{
+	struct eventfs_inode *ei = ti->private;
+
+	if (!ei)
+		return;
+
+	if (update_uid)
+		ei->attr.mode &= ~EVENTFS_SAVE_UID;
+
+	if (update_gid)
+		ei->attr.mode &= ~EVENTFS_SAVE_GID;
+
+	if (!ei->entry_attrs)
+		return;
+
+	for (int i = 0; i < ei->nr_entries; i++) {
+		if (update_uid)
+			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_UID;
+		if (update_gid)
+			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_GID;
+	}
+}
+
 /* Return the evenfs_inode of the "events" directory */
 static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 {
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 5545e6bf7d26..2a1dc2b442d1 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -30,6 +30,13 @@ static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
+/*
+ * Keep track of all tracefs_inodes in order to update their
+ * flags if necessary on a remount.
+ */
+static DEFINE_MUTEX(tracefs_inode_mutex);
+static LIST_HEAD(tracefs_inodes);
+
 static struct inode *tracefs_alloc_inode(struct super_block *sb)
 {
 	struct tracefs_inode *ti;
@@ -38,12 +45,22 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 	if (!ti)
 		return NULL;
 
+	mutex_lock(&tracefs_inode_mutex);
+	list_add(&ti->list, &tracefs_inodes);
+	mutex_unlock(&tracefs_inode_mutex);
+
 	return &ti->vfs_inode;
 }
 
 static void tracefs_free_inode(struct inode *inode)
 {
-	kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
+	struct tracefs_inode *ti = get_tracefs(inode);
+
+	mutex_lock(&tracefs_inode_mutex);
+	list_del(&ti->list);
+	mutex_unlock(&tracefs_inode_mutex);
+
+	kmem_cache_free(tracefs_inode_cachep, ti);
 }
 
 static ssize_t default_read_file(struct file *file, char __user *buf,
@@ -313,6 +330,8 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 	struct tracefs_fs_info *fsi = sb->s_fs_info;
 	struct inode *inode = d_inode(sb->s_root);
 	struct tracefs_mount_opts *opts = &fsi->mount_opts;
+	struct tracefs_inode *ti;
+	bool update_uid, update_gid;
 	umode_t tmp_mode;
 
 	/*
@@ -332,6 +351,25 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 	if (!remount || opts->opts & BIT(Opt_gid))
 		inode->i_gid = opts->gid;
 
+	if (remount && (opts->opts & BIT(Opt_uid) || opts->opts & BIT(Opt_gid))) {
+		mutex_lock(&tracefs_inode_mutex);
+
+		update_uid = opts->opts & BIT(Opt_uid);
+		update_gid = opts->opts & BIT(Opt_gid);
+
+		list_for_each_entry(ti, &tracefs_inodes, list) {
+			if (update_uid)
+				ti->flags &= ~TRACEFS_UID_PERM_SET;
+
+			if (update_gid)
+				ti->flags &= ~TRACEFS_GID_PERM_SET;
+
+			if (ti->flags & TRACEFS_EVENT_INODE)
+				eventfs_remount(ti, update_uid, update_gid);
+		}
+		mutex_unlock(&tracefs_inode_mutex);
+	}
+
 	return 0;
 }
 
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 15c26f9aaad4..661ac13e2984 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -13,6 +13,7 @@ enum {
 struct tracefs_inode {
 	struct inode            vfs_inode;
 	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
+	struct list_head	list;
 	unsigned long           flags;
 	void                    *private;
 };
@@ -73,6 +74,7 @@ struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
 
+void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid);
 void eventfs_d_release(struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */
-- 
2.43.0



