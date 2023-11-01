Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6C87DE78D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346479AbjKAVie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345657AbjKAViI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:38:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8FD124;
        Wed,  1 Nov 2023 14:38:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36474C433CD;
        Wed,  1 Nov 2023 21:38:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qyIua-00Edci-14;
        Wed, 01 Nov 2023 17:38:04 -0400
Message-ID: <20231101213804.145321020@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Nov 2023 17:37:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [for-next][PATCH 12/12] eventfs: Use simple_recursive_removal() to clean up dentries
References: <20231101213718.381015321@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Looking at how dentry is removed via the tracefs system, I found that
eventfs does not do everything that it did under tracefs. The tracefs
removal of a dentry calls simple_recursive_removal() that does a lot more
than a simple d_invalidate().

As it should be a requirement that any eventfs_inode that has a dentry, so
does its parent. When removing a eventfs_inode, if it has a dentry, a call
to simple_recursive_removal() on that dentry should clean up all the
dentries underneath it.

Add WARN_ON_ONCE() to check for the parent having a dentry if any children
do.

Link: https://lore.kernel.org/all/20231101022553.GE1957730@ZenIV/
Link: https://lkml.kernel.org/r/20231101172650.552471568@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Fixes: 5bdcd5f5331a2 ("eventfs: Implement removal of meta data from eventfs")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 77 +++++++++++++++++++++++-----------------
 fs/tracefs/internal.h    |  2 --
 2 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 0087a3f455f1..f8a594a50ae6 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -967,30 +967,29 @@ static void unhook_dentry(struct dentry *dentry)
 {
 	if (!dentry)
 		return;
-
-	/* Keep the dentry from being freed yet (see eventfs_workfn()) */
+	/*
+	 * Need to add a reference to the dentry that is expected by
+	 * simple_recursive_removal(), which will include a dput().
+	 */
 	dget(dentry);
 
-	dentry->d_fsdata = NULL;
-	d_invalidate(dentry);
-	mutex_lock(&eventfs_mutex);
-	/* dentry should now have at least a single reference */
-	WARN_ONCE((int)d_count(dentry) < 1,
-		  "dentry %px (%s) less than one reference (%d) after invalidate\n",
-		  dentry, dentry->d_name.name, d_count(dentry));
-	mutex_unlock(&eventfs_mutex);
+	/*
+	 * Also add a reference for the dput() in eventfs_workfn().
+	 * That is required as that dput() will free the ei after
+	 * the SRCU grace period is over.
+	 */
+	dget(dentry);
 }
 
 /**
  * eventfs_remove_rec - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
- * @head: the list head to place the deleted @ei and children
  * @level: prevent recursion from going more than 3 levels deep.
  *
  * This function recursively removes eventfs_inodes which
  * contains info of files and/or directories.
  */
-static void eventfs_remove_rec(struct eventfs_inode *ei, struct list_head *head, int level)
+static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 {
 	struct eventfs_inode *ei_child;
 
@@ -1009,13 +1008,26 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, struct list_head *head,
 	/* search for nested folders or files */
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 lockdep_is_held(&eventfs_mutex)) {
-		eventfs_remove_rec(ei_child, head, level + 1);
+		/* Children only have dentry if parent does */
+		WARN_ON_ONCE(ei_child->dentry && !ei->dentry);
+		eventfs_remove_rec(ei_child, level + 1);
 	}
 
+
 	ei->is_freed = 1;
 
+	for (int i = 0; i < ei->nr_entries; i++) {
+		if (ei->d_children[i]) {
+			/* Children only have dentry if parent does */
+			WARN_ON_ONCE(!ei->dentry);
+			unhook_dentry(ei->d_children[i]);
+		}
+	}
+
+	unhook_dentry(ei->dentry);
+
 	list_del_rcu(&ei->list);
-	list_add_tail(&ei->del_list, head);
+	call_srcu(&eventfs_srcu, &ei->rcu, free_rcu_ei);
 }
 
 /**
@@ -1026,30 +1038,22 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, struct list_head *head,
  */
 void eventfs_remove_dir(struct eventfs_inode *ei)
 {
-	struct eventfs_inode *tmp;
-	LIST_HEAD(ei_del_list);
+	struct dentry *dentry;
 
 	if (!ei)
 		return;
 
-	/*
-	 * Move the deleted eventfs_inodes onto the ei_del_list
-	 * which will also set the is_freed value. Note, this has to be
-	 * done under the eventfs_mutex, but the deletions of
-	 * the dentries must be done outside the eventfs_mutex.
-	 * Hence moving them to this temporary list.
-	 */
 	mutex_lock(&eventfs_mutex);
-	eventfs_remove_rec(ei, &ei_del_list, 0);
+	dentry = ei->dentry;
+	eventfs_remove_rec(ei, 0);
 	mutex_unlock(&eventfs_mutex);
 
-	list_for_each_entry_safe(ei, tmp, &ei_del_list, del_list) {
-		for (int i = 0; i < ei->nr_entries; i++)
-			unhook_dentry(ei->d_children[i]);
-		unhook_dentry(ei->dentry);
-		list_del(&ei->del_list);
-		call_srcu(&eventfs_srcu, &ei->rcu, free_rcu_ei);
-	}
+	/*
+	 * If any of the ei children has a dentry, then the ei itself
+	 * must have a dentry.
+	 */
+	if (dentry)
+		simple_recursive_removal(dentry, NULL);
 }
 
 /**
@@ -1060,10 +1064,17 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
  */
 void eventfs_remove_events_dir(struct eventfs_inode *ei)
 {
-	struct dentry *dentry = ei->dentry;
+	struct dentry *dentry;
 
+	dentry = ei->dentry;
 	eventfs_remove_dir(ei);
 
-	/* Matches the dget() from eventfs_create_events_dir() */
+	/*
+	 * Matches the dget() done by tracefs_start_creating()
+	 * in eventfs_create_events_dir() when it the dentry was
+	 * created. In other words, it's a normal dentry that
+	 * sticks around while the other ei->dentry are created
+	 * and destroyed dynamically.
+	 */
 	dput(dentry);
 }
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 06a1f220b901..ccee18ca66c7 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -55,12 +55,10 @@ struct eventfs_inode {
 	/*
 	 * Union - used for deletion
 	 * @llist:	for calling dput() if needed after RCU
-	 * @del_list:	list of eventfs_inode to delete
 	 * @rcu:	eventfs_inode to delete in RCU
 	 */
 	union {
 		struct llist_node	llist;
-		struct list_head	del_list;
 		struct rcu_head		rcu;
 	};
 	unsigned int			is_freed:1;
-- 
2.42.0
