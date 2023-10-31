Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B357D7DD864
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376326AbjJaWeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346807AbjJaWe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:34:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A89102;
        Tue, 31 Oct 2023 15:34:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E231AC433C9;
        Tue, 31 Oct 2023 22:34:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qxxJV-00EPjd-0X;
        Tue, 31 Oct 2023 18:34:21 -0400
Message-ID: <20231031223420.988874091@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 31 Oct 2023 18:33:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: [PATCH v5 6/7] eventfs: Delete eventfs_inode when the last dentry is freed
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

Cc: stable@vger.kernel.org
Fixes: 5bdcd5f5331a2 ("eventfs: Implement removal of meta data from eventfs")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 184 +++++++++++++++++----------------------
 fs/tracefs/internal.h    |   2 +
 2 files changed, 84 insertions(+), 102 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 87a8aaeda231..827ca152cfbe 100644
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
@@ -962,13 +937,79 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
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
+	struct inode *inode;
+
+	if (!dentry)
+		return;
+
+	/* Keep the dentry from being freed yet (see eventfs_workfn()) */
+	dget(dentry);
+
+	inode = dentry->d_inode;
+	inode_lock(inode);
+	if (d_is_dir(dentry))
+		inode->i_flags |= S_DEAD;
+	clear_nlink(inode);
+	inode_unlock(inode);
+
+	inode = dentry->d_parent->d_inode;
+	inode_lock(inode);
+
+	/* Remove its visibility */
+	d_invalidate(dentry);
+	if (d_is_dir(dentry))
+		fsnotify_rmdir(inode, dentry);
+	else
+		fsnotify_unlink(inode, dentry);
+
+	if (d_is_dir(dentry))
+		drop_nlink(inode);
+	inode_unlock(inode);
+}
+
 /**
  * eventfs_remove_rec - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
@@ -1006,34 +1047,6 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, struct list_head *head,
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
-
 /**
  * eventfs_remove_dir - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
@@ -1044,61 +1057,28 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
 {
 	struct eventfs_inode *tmp;
 	LIST_HEAD(ei_del_list);
-	struct dentry *dentry_list = NULL;
-	struct dentry *dentry;
-	struct inode *inode;
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
-
-	list_for_each_entry_safe(ei, tmp, &ei_del_list, del_list) {
-		for (i = 0; i < ei->nr_entries; i++)
-			unhook_dentry(&ei->d_children[i], &dentry_list);
-		unhook_dentry(&ei->dentry, &dentry_list);
-		call_srcu(&eventfs_srcu, &ei->rcu, free_rcu_ei);
-	}
 	mutex_unlock(&eventfs_mutex);
 
-	while (dentry_list) {
-		unsigned long ptr;
-
-		dentry = dentry_list;
-		ptr = (unsigned long)dentry->d_fsdata & ~1UL;
-		dentry_list = (struct dentry *)ptr;
-		dentry->d_fsdata = NULL;
-
-		inode = dentry->d_inode;
-		inode_lock(inode);
-		if (d_is_dir(dentry))
-			inode->i_flags |= S_DEAD;
-		clear_nlink(inode);
-		inode_unlock(inode);
-
-		inode = dentry->d_parent->d_inode;
-		inode_lock(inode);
-
-		/* Remove its visibility */
-		d_invalidate(dentry);
-		if (d_is_dir(dentry))
-			fsnotify_rmdir(inode, dentry);
-		else
-			fsnotify_unlink(inode, dentry);
-
-		if (d_is_dir(dentry))
-			drop_nlink(inode);
-		inode_unlock(inode);
+	list_for_each_entry_safe(ei, tmp, &ei_del_list, del_list) {
 
-		mutex_lock(&eventfs_mutex);
-		/* dentry should now have at least a single reference */
-		WARN_ONCE((int)d_count(dentry) < 1,
-			  "dentry %px (%s) less than one reference (%d) after invalidate\n",
-			  dentry, dentry->d_name.name, d_count(dentry));
-		mutex_unlock(&eventfs_mutex);
-		dput(dentry);
+		for (int i = 0; i < ei->nr_entries; i++)
+			unhook_dentry(ei->d_children[i]);
+		unhook_dentry(ei->dentry);
+		list_del(&ei->del_list);
+		call_srcu(&eventfs_srcu, &ei->rcu, free_rcu_ei);
 	}
 }
 
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
2.42.0
