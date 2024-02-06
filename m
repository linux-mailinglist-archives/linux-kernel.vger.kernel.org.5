Return-Path: <linux-kernel+bounces-54896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8936D84B4EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F882834D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFC413AA57;
	Tue,  6 Feb 2024 12:09:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BB313698A;
	Tue,  6 Feb 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221361; cv=none; b=VX5x0xl6o7GzuzjAWlZSP42PTEmCCMPqBYN6tJub8RQ3oqjuckNTn68cccWw9Lnm+RWCPUQ0omhjZXcUYSil5lOGZjNfy5cQH7NVGnCUsduHgGo6b60kmBXLPzCmPBUs7tSQvTZlnbGb4lviwjw8OKYlwoqZM+ZCLDiN4dVosuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221361; c=relaxed/simple;
	bh=EX62FCliiicp1Ebv2cbXuAVT6VCGkHG/rJaEKHec0Co=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gXgmkjSoiNrwK1R6wS2+9eySybwrPX5KcqmBRDebSmLr8MLg/N1x7xJoT1tUqXIglSDIZNP6JS2kgtKKjTd+s6ToVKO8eX2oFBZ6PJNPdlfenygLiaxAkUwhwQM4MRCNs0RrWIkvNr7zqEZ3rR5xIhFrrr536XBCe4VyR3N9oOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70897C433F1;
	Tue,  6 Feb 2024 12:09:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGr-00000006bBq-3v6a;
	Tue, 06 Feb 2024 07:09:49 -0500
Message-ID: <20240206120949.792406858@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ajay Kaher <akaher@vmware.com>
Subject: [v6.6][PATCH 21/57] eventfs: Delete eventfs_inode when the last dentry is freed
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There exists a race between holding a reference of an eventfs_inode dentry
and the freeing of the eventfs_inode. If user space has a dentry held long
enough, it may still be able to access the dentry's eventfs_inode after it
has been freed.

To prevent this, have he eventfs_inode freed via the last dput() (or via
RCU if the eventfs_inode does not have a dentry).

This means reintroducing the eventfs_inode del_list field at a temporary
place to put the eventfs_inode. It needs to mark it as freed (via the
list) but also must invalidate the dentry immediately as the return from
eventfs_remove_dir() expects that they are. But the dentry invalidation
must not be called under the eventfs_mutex, so it must be done after the
eventfs_inode is marked as free (put on a deletion list).

Link: https://lkml.kernel.org/r/20231101172650.123479767@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ajay Kaher <akaher@vmware.com>
Fixes: 5bdcd5f5331a2 ("eventfs: Implement removal of meta data from eventfs")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 020010fbfa202aa528a52743eba4ab0da3400a4e)
---
 fs/tracefs/event_inode.c | 146 ++++++++++++++++++---------------------
 fs/tracefs/internal.h    |   2 +
 2 files changed, 69 insertions(+), 79 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 8ac9abf7a3d5..0a04ae0ca8c8 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -85,8 +85,7 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	mutex_lock(&eventfs_mutex);
 	ei = dentry->d_fsdata;
-	/* The LSB is set when the eventfs_inode is being freed */
-	if (((unsigned long)ei & 1UL) || ei->is_freed) {
+	if (ei->is_freed) {
 		/* Do not allow changes if the event is about to be removed. */
 		mutex_unlock(&eventfs_mutex);
 		return -ENODEV;
@@ -276,35 +275,17 @@ static void free_ei(struct eventfs_inode *ei)
 void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 {
 	struct tracefs_inode *ti_parent;
-	struct eventfs_inode *ei_child, *tmp;
 	struct eventfs_inode *ei;
 	int i;
 
 	/* The top level events directory may be freed by this */
 	if (unlikely(ti->flags & TRACEFS_EVENT_TOP_INODE)) {
-		LIST_HEAD(ef_del_list);
-
 		mutex_lock(&eventfs_mutex);
-
 		ei = ti->private;
-
-		/* Record all the top level files */
-		list_for_each_entry_srcu(ei_child, &ei->children, list,
-					 lockdep_is_held(&eventfs_mutex)) {
-			list_add_tail(&ei_child->del_list, &ef_del_list);
-		}
-
 		/* Nothing should access this, but just in case! */
 		ti->private = NULL;
-
 		mutex_unlock(&eventfs_mutex);
 
-		/* Now safely free the top level files and their children */
-		list_for_each_entry_safe(ei_child, tmp, &ef_del_list, del_list) {
-			list_del(&ei_child->del_list);
-			eventfs_remove_dir(ei_child);
-		}
-
 		free_ei(ei);
 		return;
 	}
@@ -319,14 +300,6 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 	if (!ei)
 		goto out;
 
-	/*
-	 * If ei was freed, then the LSB bit is set for d_fsdata.
-	 * But this should not happen, as it should still have a
-	 * ref count that prevents it. Warn in case it does.
-	 */
-	if (WARN_ON_ONCE((unsigned long)ei & 1))
-		goto out;
-
 	/* This could belong to one of the files of the ei */
 	if (ei->dentry != dentry) {
 		for (i = 0; i < ei->nr_entries; i++) {
@@ -336,6 +309,8 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 		if (WARN_ON_ONCE(i == ei->nr_entries))
 			goto out;
 		ei->d_children[i] = NULL;
+	} else if (ei->is_freed) {
+		free_ei(ei);
 	} else {
 		ei->dentry = NULL;
 	}
@@ -962,13 +937,65 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ERR_PTR(-ENOMEM);
 }
 
+static LLIST_HEAD(free_list);
+
+static void eventfs_workfn(struct work_struct *work)
+{
+        struct eventfs_inode *ei, *tmp;
+        struct llist_node *llnode;
+
+	llnode = llist_del_all(&free_list);
+        llist_for_each_entry_safe(ei, tmp, llnode, llist) {
+		/* This dput() matches the dget() from unhook_dentry() */
+		for (int i = 0; i < ei->nr_entries; i++) {
+			if (ei->d_children[i])
+				dput(ei->d_children[i]);
+		}
+		/* This should only get here if it had a dentry */
+		if (!WARN_ON_ONCE(!ei->dentry))
+			dput(ei->dentry);
+        }
+}
+
+static DECLARE_WORK(eventfs_work, eventfs_workfn);
+
 static void free_rcu_ei(struct rcu_head *head)
 {
 	struct eventfs_inode *ei = container_of(head, struct eventfs_inode, rcu);
 
+	if (ei->dentry) {
+		/* Do not free the ei until all references of dentry are gone */
+		if (llist_add(&ei->llist, &free_list))
+			queue_work(system_unbound_wq, &eventfs_work);
+		return;
+	}
+
+	/* If the ei doesn't have a dentry, neither should its children */
+	for (int i = 0; i < ei->nr_entries; i++) {
+		WARN_ON_ONCE(ei->d_children[i]);
+	}
+
 	free_ei(ei);
 }
 
+static void unhook_dentry(struct dentry *dentry)
+{
+	if (!dentry)
+		return;
+
+	/* Keep the dentry from being freed yet (see eventfs_workfn()) */
+	dget(dentry);
+
+	dentry->d_fsdata = NULL;
+	d_invalidate(dentry);
+	mutex_lock(&eventfs_mutex);
+	/* dentry should now have at least a single reference */
+	WARN_ONCE((int)d_count(dentry) < 1,
+		  "dentry %px (%s) less than one reference (%d) after invalidate\n",
+		  dentry, dentry->d_name.name, d_count(dentry));
+	mutex_unlock(&eventfs_mutex);
+}
+
 /**
  * eventfs_remove_rec - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
@@ -1006,33 +1033,6 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, struct list_head *head,
 	list_add_tail(&ei->del_list, head);
 }
 
-static void unhook_dentry(struct dentry **dentry, struct dentry **list)
-{
-	if (*dentry) {
-		unsigned long ptr = (unsigned long)*list;
-
-		/* Keep the dentry from being freed yet */
-		dget(*dentry);
-
-		/*
-		 * Paranoid: The dget() above should prevent the dentry
-		 * from being freed and calling eventfs_set_ei_status_free().
-		 * But just in case, set the link list LSB pointer to 1
-		 * and have eventfs_set_ei_status_free() check that to
-		 * make sure that if it does happen, it will not think
-		 * the d_fsdata is an eventfs_inode.
-		 *
-		 * For this to work, no eventfs_inode should be allocated
-		 * on a odd space, as the ef should always be allocated
-		 * to be at least word aligned. Check for that too.
-		 */
-		WARN_ON_ONCE(ptr & 1);
-
-		(*dentry)->d_fsdata = (void *)(ptr | 1);
-		*list = *dentry;
-		*dentry = NULL;
-	}
-}
 /**
  * eventfs_remove_dir - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
@@ -1043,40 +1043,28 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
 {
 	struct eventfs_inode *tmp;
 	LIST_HEAD(ei_del_list);
-	struct dentry *dentry_list = NULL;
-	struct dentry *dentry;
-	int i;
 
 	if (!ei)
 		return;
 
+	/*
+	 * Move the deleted eventfs_inodes onto the ei_del_list
+	 * which will also set the is_freed value. Note, this has to be
+	 * done under the eventfs_mutex, but the deletions of
+	 * the dentries must be done outside the eventfs_mutex.
+	 * Hence moving them to this temporary list.
+	 */
 	mutex_lock(&eventfs_mutex);
 	eventfs_remove_rec(ei, &ei_del_list, 0);
+	mutex_unlock(&eventfs_mutex);
 
 	list_for_each_entry_safe(ei, tmp, &ei_del_list, del_list) {
-		for (i = 0; i < ei->nr_entries; i++)
-			unhook_dentry(&ei->d_children[i], &dentry_list);
-		unhook_dentry(&ei->dentry, &dentry_list);
+		for (int i = 0; i < ei->nr_entries; i++)
+			unhook_dentry(ei->d_children[i]);
+		unhook_dentry(ei->dentry);
+		list_del(&ei->del_list);
 		call_srcu(&eventfs_srcu, &ei->rcu, free_rcu_ei);
 	}
-	mutex_unlock(&eventfs_mutex);
-
-	while (dentry_list) {
-		unsigned long ptr;
-
-		dentry = dentry_list;
-		ptr = (unsigned long)dentry->d_fsdata & ~1UL;
-		dentry_list = (struct dentry *)ptr;
-		dentry->d_fsdata = NULL;
-		d_invalidate(dentry);
-		mutex_lock(&eventfs_mutex);
-		/* dentry should now have at least a single reference */
-		WARN_ONCE((int)d_count(dentry) < 1,
-			  "dentry %px (%s) less than one reference (%d) after invalidate\n",
-			  dentry, dentry->d_name.name, d_count(dentry));
-		mutex_unlock(&eventfs_mutex);
-		dput(dentry);
-	}
 }
 
 /**
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 5f60bcd69289..06a1f220b901 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -54,10 +54,12 @@ struct eventfs_inode {
 	void				*data;
 	/*
 	 * Union - used for deletion
+	 * @llist:	for calling dput() if needed after RCU
 	 * @del_list:	list of eventfs_inode to delete
 	 * @rcu:	eventfs_inode to delete in RCU
 	 */
 	union {
+		struct llist_node	llist;
 		struct list_head	del_list;
 		struct rcu_head		rcu;
 	};
-- 
2.43.0



