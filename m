Return-Path: <linux-kernel+bounces-54878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EA284B4B3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76ED21F29229
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C641353F7;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1E1350CF;
	Tue,  6 Feb 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221358; cv=none; b=IqPXcFM6TjuHEkGGrqPx4KY/xB0kciUrd688Pm9A673pbS5Hqz/HcUXoI+ka75brScDEeDkF8TDMJo1NzEzvsLd0F8AVvEvYBeoignCb7jTsC7qpCxXb81aB6P++NeVUeV4ValgMmGIvZlD65MJ1o9sU3rXDGaX/0QJhXbdwcAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221358; c=relaxed/simple;
	bh=zvKShgCK5034Xnelj/XlGEgqizQjwtbUh3c35v08Orw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sloQJVkJPIgF3jnOrraMJpKSNDylb9lAXSXjSs8voCjZ8NR+yfsw+4BFgvgjZe6mADfbkwzwoMgQacjF7kYeCedVXL2epCf8Yk1apyOEfuR1zBHVXbXwUt4CNX/QYANKu9Lq5wwV4Jjpmpc/j8d4ySB2nKLpmKwSnG/fyY6fSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8835FC43601;
	Tue,  6 Feb 2024 12:09:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGp-00000006b2t-028k;
	Tue, 06 Feb 2024 07:09:47 -0500
Message-ID: <20240206120946.866568635@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [v6.6][PATCH 03/57] Revert "eventfs: Use simple_recursive_removal() to clean up dentries"
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

This reverts commit 055907ad2c14838c90d63297f7bab8d180a5d844.

The eventfs was not designed properly and may have some hidden bugs in it.
Linus rewrote it properly and I trust his version more than this one. Revert
the backported patches for 6.6 and re-apply all the changes to make it
equivalent to Linus's version.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 71 +++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5fcfb634fec2..7aa92b8ebc51 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -54,10 +54,12 @@ struct eventfs_file {
 	/*
 	 * Union - used for deletion
 	 * @llist:	for calling dput() if needed after RCU
+	 * @del_list:	list of eventfs_file to delete
 	 * @rcu:	eventfs_file to delete in RCU
 	 */
 	union {
 		struct llist_node	llist;
+		struct list_head	del_list;
 		struct rcu_head		rcu;
 	};
 	void				*data;
@@ -274,6 +276,7 @@ static void free_ef(struct eventfs_file *ef)
  */
 void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 {
+	struct tracefs_inode *ti_parent;
 	struct eventfs_inode *ei;
 	struct eventfs_file *ef;
 
@@ -294,6 +297,10 @@ void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 
 	mutex_lock(&eventfs_mutex);
 
+	ti_parent = get_tracefs(dentry->d_parent->d_inode);
+	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
+		goto out;
+
 	ef = dentry->d_fsdata;
 	if (!ef)
 		goto out;
@@ -866,29 +873,30 @@ static void unhook_dentry(struct dentry *dentry)
 {
 	if (!dentry)
 		return;
-	/*
-	 * Need to add a reference to the dentry that is expected by
-	 * simple_recursive_removal(), which will include a dput().
-	 */
-	dget(dentry);
 
-	/*
-	 * Also add a reference for the dput() in eventfs_workfn().
-	 * That is required as that dput() will free the ei after
-	 * the SRCU grace period is over.
-	 */
+	/* Keep the dentry from being freed yet (see eventfs_workfn()) */
 	dget(dentry);
+
+	dentry->d_fsdata = NULL;
+	d_invalidate(dentry);
+	mutex_lock(&eventfs_mutex);
+	/* dentry should now have at least a single reference */
+	WARN_ONCE((int)d_count(dentry) < 1,
+		  "dentry %px (%s) less than one reference (%d) after invalidate\n",
+		  dentry, dentry->d_name.name, d_count(dentry));
+	mutex_unlock(&eventfs_mutex);
 }
 
 /**
  * eventfs_remove_rec - remove eventfs dir or file from list
  * @ef: eventfs_file to be removed.
+ * @head: to create list of eventfs_file to be deleted
  * @level: to check recursion depth
  *
  * The helper function eventfs_remove_rec() is used to clean up and free the
  * associated data from eventfs for both of the added functions.
  */
-static void eventfs_remove_rec(struct eventfs_file *ef, int level)
+static void eventfs_remove_rec(struct eventfs_file *ef, struct list_head *head, int level)
 {
 	struct eventfs_file *ef_child;
 
@@ -908,16 +916,14 @@ static void eventfs_remove_rec(struct eventfs_file *ef, int level)
 		/* search for nested folders or files */
 		list_for_each_entry_srcu(ef_child, &ef->ei->e_top_files, list,
 					 lockdep_is_held(&eventfs_mutex)) {
-			eventfs_remove_rec(ef_child, level + 1);
+			eventfs_remove_rec(ef_child, head, level + 1);
 		}
 	}
 
 	ef->is_freed = 1;
 
-	unhook_dentry(ef->dentry);
-
 	list_del_rcu(&ef->list);
-	call_srcu(&eventfs_srcu, &ef->rcu, free_rcu_ef);
+	list_add_tail(&ef->del_list, head);
 }
 
 /**
@@ -928,22 +934,28 @@ static void eventfs_remove_rec(struct eventfs_file *ef, int level)
  */
 void eventfs_remove(struct eventfs_file *ef)
 {
-	struct dentry *dentry;
+	struct eventfs_file *tmp;
+	LIST_HEAD(ef_del_list);
 
 	if (!ef)
 		return;
 
+	/*
+	 * Move the deleted eventfs_inodes onto the ei_del_list
+	 * which will also set the is_freed value. Note, this has to be
+	 * done under the eventfs_mutex, but the deletions of
+	 * the dentries must be done outside the eventfs_mutex.
+	 * Hence moving them to this temporary list.
+	 */
 	mutex_lock(&eventfs_mutex);
-	dentry = ef->dentry;
-	eventfs_remove_rec(ef, 0);
+	eventfs_remove_rec(ef, &ef_del_list, 0);
 	mutex_unlock(&eventfs_mutex);
 
-	/*
-	 * If any of the ei children has a dentry, then the ei itself
-	 * must have a dentry.
-	 */
-	if (dentry)
-		simple_recursive_removal(dentry, NULL);
+	list_for_each_entry_safe(ef, tmp, &ef_del_list, del_list) {
+		unhook_dentry(ef->dentry);
+		list_del(&ef->del_list);
+		call_srcu(&eventfs_srcu, &ef->rcu, free_rcu_ef);
+	}
 }
 
 /**
@@ -954,8 +966,6 @@ void eventfs_remove(struct eventfs_file *ef)
  */
 void eventfs_remove_events_dir(struct dentry *dentry)
 {
-	struct eventfs_file *ef_child;
-	struct eventfs_inode *ei;
 	struct tracefs_inode *ti;
 
 	if (!dentry || !dentry->d_inode)
@@ -965,11 +975,6 @@ void eventfs_remove_events_dir(struct dentry *dentry)
 	if (!ti || !(ti->flags & TRACEFS_EVENT_INODE))
 		return;
 
-	mutex_lock(&eventfs_mutex);
-	ei = ti->private;
-	list_for_each_entry_srcu(ef_child, &ei->e_top_files, list,
-				 lockdep_is_held(&eventfs_mutex)) {
-		eventfs_remove_rec(ef_child, 0);
-	}
-	mutex_unlock(&eventfs_mutex);
+	d_invalidate(dentry);
+	dput(dentry);
 }
-- 
2.43.0



