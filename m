Return-Path: <linux-kernel+bounces-166622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADEA8B9D26
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC8B286BDB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1883B15B967;
	Thu,  2 May 2024 15:15:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FEA15B0E7;
	Thu,  2 May 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662934; cv=none; b=kUaTa6Qgo/ROGuffzDekM5xLj6XjpXL8lL6wTS31t8uJCmQIBe/tl+ff0/X7PiRyVSYU9XQVYkq3o3iwZwyz5hgXBFAaOlQCiB4mORg/WuQZSP+wo8MZnscGezY8LGmeAb8BSnjbiDNNHnvOrOzUCWkqFWLJkcy9oXsJpneSo4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662934; c=relaxed/simple;
	bh=/hEvsIWw8xq5n6yLQhKQJHjRomIpW/YtSsUGay22gSE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZMj2l4zrSlE0Js1u9qC3EfDs60o+ZnSG22kNMKPaQYMKjILsXS2BjIjGDXLKgof9VgRuaVlKxsFesN4H+82FjiW9wP2mZVO2hzByxpEWCzmE1XD6ofNTk93tl73Iy8dEJfoi/e9oedOMJjaiZKCZOBJbmdEJtBU/h/130U4Bs1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B8AC4AF1B;
	Thu,  2 May 2024 15:15:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s2YAW-00000003ITj-3ag4;
	Thu, 02 May 2024 11:16:20 -0400
Message-ID: <20240502151620.714547671@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 02 May 2024 11:15:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH v2 3/5] eventfs: Do not differentiate the toplevel events directory
References: <20240502151547.973653253@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The toplevel events directory is really no different than the events
directory of instances. Having the two be different caused
inconsistencies and made it harder to fix the permissions bugs.

Make all events directories act the same.

Cc: stable@vger.kernel.org
Fixes: 8186fff7ab649 ("tracefs/eventfs: Use root and instance inodes as default ownership")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 29 ++++++++---------------------
 fs/tracefs/internal.h    |  7 +++----
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a754c6725a52..2971609946e5 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -68,7 +68,6 @@ enum {
 	EVENTFS_SAVE_MODE	= BIT(16),
 	EVENTFS_SAVE_UID	= BIT(17),
 	EVENTFS_SAVE_GID	= BIT(18),
-	EVENTFS_TOPLEVEL	= BIT(19),
 };
 
 #define EVENTFS_MODE_MASK	(EVENTFS_SAVE_MODE - 1)
@@ -232,14 +231,10 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return ret;
 }
 
-static void update_top_events_attr(struct eventfs_inode *ei, struct super_block *sb)
+static void update_events_attr(struct eventfs_inode *ei, struct super_block *sb)
 {
 	struct inode *root;
 
-	/* Only update if the "events" was on the top level */
-	if (!ei || !(ei->attr.mode & EVENTFS_TOPLEVEL))
-		return;
-
 	/* Get the tracefs root inode. */
 	root = d_inode(sb->s_root);
 	ei->attr.uid = root->i_uid;
@@ -252,10 +247,10 @@ static void set_top_events_ownership(struct inode *inode)
 	struct eventfs_inode *ei = ti->private;
 
 	/* The top events directory doesn't get automatically updated */
-	if (!ei || !ei->is_events || !(ei->attr.mode & EVENTFS_TOPLEVEL))
+	if (!ei || !ei->is_events)
 		return;
 
-	update_top_events_attr(ei, inode->i_sb);
+	update_events_attr(ei, inode->i_sb);
 
 	if (!(ei->attr.mode & EVENTFS_SAVE_UID))
 		inode->i_uid = ei->attr.uid;
@@ -284,7 +279,7 @@ static int eventfs_permission(struct mnt_idmap *idmap,
 	return generic_permission(idmap, inode, mask);
 }
 
-static const struct inode_operations eventfs_root_dir_inode_operations = {
+static const struct inode_operations eventfs_dir_inode_operations = {
 	.lookup		= eventfs_root_lookup,
 	.setattr	= eventfs_set_attr,
 	.getattr	= eventfs_get_attr,
@@ -352,7 +347,7 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 		// Walk upwards until you find the events inode
 	} while (!ei->is_events);
 
-	update_top_events_attr(ei, dentry->d_sb);
+	update_events_attr(ei, dentry->d_sb);
 
 	return ei;
 }
@@ -458,7 +453,7 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 	update_inode_attr(dentry, inode, &ei->attr,
 			  S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
 
-	inode->i_op = &eventfs_root_dir_inode_operations;
+	inode->i_op = &eventfs_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
 	/* All directories will have the same inode number */
@@ -838,14 +833,6 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	uid = d_inode(dentry->d_parent)->i_uid;
 	gid = d_inode(dentry->d_parent)->i_gid;
 
-	/*
-	 * If the events directory is of the top instance, then parent
-	 * is NULL. Set the attr.mode to reflect this and its permissions will
-	 * default to the tracefs root dentry.
-	 */
-	if (!parent)
-		ei->attr.mode = EVENTFS_TOPLEVEL;
-
 	/* This is used as the default ownership of the files and directories */
 	ei->attr.uid = uid;
 	ei->attr.gid = gid;
@@ -854,13 +841,13 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	INIT_LIST_HEAD(&ei->list);
 
 	ti = get_tracefs(inode);
-	ti->flags |= TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
+	ti->flags |= TRACEFS_EVENT_INODE;
 	ti->private = ei;
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	inode->i_op = &eventfs_root_dir_inode_operations;
+	inode->i_op = &eventfs_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
 	dentry->d_fsdata = get_ei(ei);
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 29f0c999975b..f704d8348357 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -4,10 +4,9 @@
 
 enum {
 	TRACEFS_EVENT_INODE		= BIT(1),
-	TRACEFS_EVENT_TOP_INODE		= BIT(2),
-	TRACEFS_GID_PERM_SET		= BIT(3),
-	TRACEFS_UID_PERM_SET		= BIT(4),
-	TRACEFS_INSTANCE_INODE		= BIT(5),
+	TRACEFS_GID_PERM_SET		= BIT(2),
+	TRACEFS_UID_PERM_SET		= BIT(3),
+	TRACEFS_INSTANCE_INODE		= BIT(4),
 };
 
 struct tracefs_inode {
-- 
2.43.0



