Return-Path: <linux-kernel+bounces-54894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F95084B4DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5611F265F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB61013A25E;
	Tue,  6 Feb 2024 12:09:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDBC136985;
	Tue,  6 Feb 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221361; cv=none; b=XRzZwVi49uojamjaMMH6ltZJ7X7g/GiZAnsVeg1rcBH/Jg5mmqvpiKMwC+icynVDaCiFVdo0o+kX5VvWjKAxr8krfMZ5aKtP5USwmvyNrjzOi+tWaJvAEsCymrMGncZ9NkTW5TDXX+WviRol+zMQprdlr+YN41D0fiY1Q8LUXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221361; c=relaxed/simple;
	bh=kG1/nxJbNWFSUElspzrXtQDehW5c+TNmxIPqBWLO/nI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hfh38pqeQhclImi3FCqMtTzKhaTPE+gE0lnHHlA7/sWI6DWUIBln0hJpELPRm/LRwS3aBxIiyTXgtrc4ssTijxIOE6BWyha1rTmuLiPCIIxYdTmLoL65eypoIu7QkHK2qd/QkmWVhY2yr0aPUucK84a5D9MuOPZRTb2dB6Jgh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AE0C43394;
	Tue,  6 Feb 2024 12:09:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGr-00000006bAL-1r5a;
	Tue, 06 Feb 2024 07:09:49 -0500
Message-ID: <20240206120949.301438848@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:23 -0500
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
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: [v6.6][PATCH 18/57] eventfs: Test for ei->is_freed when accessing ei->dentry
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The eventfs_inode (ei) is protected by SRCU, but the ei->dentry is not. It
is protected by the eventfs_mutex. Anytime the eventfs_mutex is released,
and access to the ei->dentry needs to be done, it should first check if
ei->is_freed is set under the eventfs_mutex. If it is, then the ei->dentry
is invalid and must not be used. The ei->dentry must only be accessed
under the eventfs_mutex and after checking if ei->is_freed is set.

When the ei is being freed, it will (under the eventfs_mutex) set is_freed
and at the same time move the dentry to a free list to be cleared after
the eventfs_mutex is released. This means that any access to the
ei->dentry must check first if ei->is_freed is set, because if it is, then
the dentry is on its way to be freed.

Also add comments to describe this better.

Link: https://lore.kernel.org/all/CA+G9fYt6pY+tMZEOg=SoEywQOe19fGP3uR15SGowkdK+_X85Cg@mail.gmail.com/
Link: https://lore.kernel.org/all/CA+G9fYuDP3hVQ3t7FfrBAjd_WFVSurMgCepTxunSJf=MTe=6aA@mail.gmail.com/
Link: https://lkml.kernel.org/r/20231101172649.477608228@goodmis.org

Cc: Ajay Kaher <akaher@vmware.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Beau Belgrave <beaub@linux.microsoft.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 77a06c33a22d13f3a6e31f06f6ee6bca666e6898)
---
 fs/tracefs/event_inode.c | 45 ++++++++++++++++++++++++++++++++++------
 fs/tracefs/internal.h    |  3 ++-
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index dd5971855732..e9625732c52d 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -24,7 +24,20 @@
 #include <linux/delay.h>
 #include "internal.h"
 
+/*
+ * eventfs_mutex protects the eventfs_inode (ei) dentry. Any access
+ * to the ei->dentry must be done under this mutex and after checking
+ * if ei->is_freed is not set. The ei->dentry is released under the
+ * mutex at the same time ei->is_freed is set. If ei->is_freed is set
+ * then the ei->dentry is invalid.
+ */
 static DEFINE_MUTEX(eventfs_mutex);
+
+/*
+ * The eventfs_inode (ei) itself is protected by SRCU. It is released from
+ * its parent's list and will have is_freed set (under eventfs_mutex).
+ * After the SRCU grace period is over, the ei may be freed.
+ */
 DEFINE_STATIC_SRCU(eventfs_srcu);
 
 static struct dentry *eventfs_root_lookup(struct inode *dir,
@@ -239,6 +252,10 @@ create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
 	bool invalidate = false;
 
 	mutex_lock(&eventfs_mutex);
+	if (ei->is_freed) {
+		mutex_unlock(&eventfs_mutex);
+		return NULL;
+	}
 	/* If the e_dentry already has a dentry, use it */
 	if (*e_dentry) {
 		/* lookup does not need to up the ref count */
@@ -312,6 +329,8 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
 	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
 
+	lockdep_assert_held(&eventfs_mutex);
+
 	/* srcu lock already held */
 	/* fill parent-child relation */
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
@@ -325,6 +344,7 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
 
 /**
  * create_dir_dentry - Create a directory dentry for the eventfs_inode
+ * @pei: The eventfs_inode parent of ei.
  * @ei: The eventfs_inode to create the directory for
  * @parent: The dentry of the parent of this directory
  * @lookup: True if this is called by the lookup code
@@ -332,12 +352,17 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
  * This creates and attaches a directory dentry to the eventfs_inode @ei.
  */
 static struct dentry *
-create_dir_dentry(struct eventfs_inode *ei, struct dentry *parent, bool lookup)
+create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
+		  struct dentry *parent, bool lookup)
 {
 	bool invalidate = false;
 	struct dentry *dentry = NULL;
 
 	mutex_lock(&eventfs_mutex);
+	if (pei->is_freed || ei->is_freed) {
+		mutex_unlock(&eventfs_mutex);
+		return NULL;
+	}
 	if (ei->dentry) {
 		/* If the dentry already has a dentry, use it */
 		dentry = ei->dentry;
@@ -440,7 +465,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	 */
 	mutex_lock(&eventfs_mutex);
 	ei = READ_ONCE(ti->private);
-	if (ei)
+	if (ei && !ei->is_freed)
 		ei_dentry = READ_ONCE(ei->dentry);
 	mutex_unlock(&eventfs_mutex);
 
@@ -454,7 +479,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		if (strcmp(ei_child->name, name) != 0)
 			continue;
 		ret = simple_lookup(dir, dentry, flags);
-		create_dir_dentry(ei_child, ei_dentry, true);
+		create_dir_dentry(ei, ei_child, ei_dentry, true);
 		created = true;
 		break;
 	}
@@ -588,7 +613,7 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
-		d = create_dir_dentry(ei_child, parent, false);
+		d = create_dir_dentry(ei, ei_child, parent, false);
 		if (d) {
 			ret = add_dentries(&dentries, d, cnt);
 			if (ret < 0)
@@ -705,12 +730,20 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	ei->nr_entries = size;
 	ei->data = data;
 	INIT_LIST_HEAD(&ei->children);
+	INIT_LIST_HEAD(&ei->list);
 
 	mutex_lock(&eventfs_mutex);
-	list_add_tail(&ei->list, &parent->children);
-	ei->d_parent = parent->dentry;
+	if (!parent->is_freed) {
+		list_add_tail(&ei->list, &parent->children);
+		ei->d_parent = parent->dentry;
+	}
 	mutex_unlock(&eventfs_mutex);
 
+	/* Was the parent freed? */
+	if (list_empty(&ei->list)) {
+		free_ei(ei);
+		ei = NULL;
+	}
 	return ei;
 }
 
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index c7d88aaa949f..5a98e87dd3d1 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -24,6 +24,7 @@ struct tracefs_inode {
  * @d_children: The array of dentries to represent the files when created
  * @data:	The private data to pass to the callbacks
  * @is_freed:	Flag set if the eventfs is on its way to be freed
+ *                Note if is_freed is set, then dentry is corrupted.
  * @nr_entries: The number of items in @entries
  */
 struct eventfs_inode {
@@ -31,7 +32,7 @@ struct eventfs_inode {
 	const struct eventfs_entry	*entries;
 	const char			*name;
 	struct list_head		children;
-	struct dentry			*dentry;
+	struct dentry			*dentry; /* Check is_freed to access */
 	struct dentry			*d_parent;
 	struct dentry			**d_children;
 	void				*data;
-- 
2.43.0



