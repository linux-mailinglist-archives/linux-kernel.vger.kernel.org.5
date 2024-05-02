Return-Path: <linux-kernel+bounces-165929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F988B938C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42551283ADF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7F72421D;
	Thu,  2 May 2024 03:00:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61721CAB0;
	Thu,  2 May 2024 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618809; cv=none; b=HTcRnrWYVTyLLgkc9DrN6/uh6dxAaSKj7NIYs25pJGSAPtIyzkbVaUF1Kd+0xu6+V3yLEM9aokTuyR+cdhT6R9qXEybWreXQ9GzsFruO1ekH3YBRQtgwf/I1pMux3Qm0Xm55AaclCgEF/HsG7x77fr+dpnZVrJqPuWfbIBeSLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618809; c=relaxed/simple;
	bh=zs4o1tAHCYYYG301c3bFj9a8t77Ec5DUdKDyCJITsJM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HMn9/A3j0pWn9wvnom9KQ4zGTqF7rLeloZf1XSwOtAl6dU4sKqYCRSH5b7srWVQwpnL/EYdMeUN17R5KDaWa2hVvWx0OmBP6sk3g517xkJV3S3OapxmTPCZeLIR94dfc64jZZslZuIlpIwjdvNdL1c40CcVF3Vl4Tqa4KkFefGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8C4C4AF52;
	Thu,  2 May 2024 03:00:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s2Mgn-000000039ig-3wtj;
	Wed, 01 May 2024 23:00:53 -0400
Message-ID: <20240502030053.801758522@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 01 May 2024 23:00:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH 5/5] eventfs: Have "events" directory get permissions from its parent
References: <20240502030024.062275408@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The events directory gets its permissions from the root inode. But this
can cause an inconsistency if the instances directory changes its
permissions, as the permissions of the created directories under it should
inherit the permissions of the instances directory when directories under
it are created.

Currently the behavior is:

 # cd /sys/kernel/tracing
 # chgrp 1002 instances
 # mkdir instances/foo
 # ls -l instances/foo
[..]
 -r--r-----  1 root lkp  0 May  1 18:55 buffer_total_size_kb
 -rw-r-----  1 root lkp  0 May  1 18:55 current_tracer
 -rw-r-----  1 root lkp  0 May  1 18:55 error_log
 drwxr-xr-x  1 root root 0 May  1 18:55 events
 --w-------  1 root lkp  0 May  1 18:55 free_buffer
 drwxr-x---  2 root lkp  0 May  1 18:55 options
 drwxr-x--- 10 root lkp  0 May  1 18:55 per_cpu
 -rw-r-----  1 root lkp  0 May  1 18:55 set_event

All the files and directories under "foo" has the "lkp" group except the
"events" directory. That's because its getting its default value from the
mount point instead of its parent.

Have the "events" directory make its default value based on its parent's
permissions. That now gives:

 # ls -l instances/foo
[..]
 -rw-r-----  1 root lkp 0 May  1 21:16 buffer_subbuf_size_kb
 -r--r-----  1 root lkp 0 May  1 21:16 buffer_total_size_kb
 -rw-r-----  1 root lkp 0 May  1 21:16 current_tracer
 -rw-r-----  1 root lkp 0 May  1 21:16 error_log
 drwxr-xr-x  1 root lkp 0 May  1 21:16 events
 --w-------  1 root lkp 0 May  1 21:16 free_buffer
 drwxr-x---  2 root lkp 0 May  1 21:16 options
 drwxr-x--- 10 root lkp 0 May  1 21:16 per_cpu
 -rw-r-----  1 root lkp 0 May  1 21:16 set_event

Cc: stable@vger.kernel.org
Fixes: 8186fff7ab649 ("tracefs/eventfs: Use root and instance inodes as default ownership")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 624a0e4a8e29..f77800398a54 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -37,6 +37,7 @@ static DEFINE_MUTEX(eventfs_mutex);
 
 struct eventfs_root_inode {
 	struct eventfs_inode		ei;
+	struct inode			*parent_inode;
 	struct dentry			*events_dir;
 };
 
@@ -207,12 +208,23 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 static void update_events_attr(struct eventfs_inode *ei, struct super_block *sb)
 {
-	struct inode *root;
+	struct eventfs_root_inode *rei;
+	struct inode *parent;
+
+	rei = get_root_inode(ei);
+
+	/* Use the parent inode permissions unless root set its permissions */
+	parent = rei->parent_inode;
 
-	/* Get the tracefs root inode. */
-	root = d_inode(sb->s_root);
-	ei->attr.uid = root->i_uid;
-	ei->attr.gid = root->i_gid;
+	if (rei->ei.attr.mode & EVENTFS_SAVE_UID)
+		ei->attr.uid = rei->ei.attr.uid;
+	else
+		ei->attr.uid = parent->i_uid;
+
+	if (rei->ei.attr.mode & EVENTFS_SAVE_GID)
+		ei->attr.gid = rei->ei.attr.gid;
+	else
+		ei->attr.gid = parent->i_gid;
 }
 
 static void set_top_events_ownership(struct inode *inode)
@@ -798,6 +810,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	// Note: we have a ref to the dentry from tracefs_start_creating()
 	rei = get_root_inode(ei);
 	rei->events_dir = dentry;
+	rei->parent_inode = d_inode(dentry->d_sb->s_root);
 
 	ei->entries = entries;
 	ei->nr_entries = size;
@@ -807,10 +820,15 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	uid = d_inode(dentry->d_parent)->i_uid;
 	gid = d_inode(dentry->d_parent)->i_gid;
 
-	/* This is used as the default ownership of the files and directories */
 	ei->attr.uid = uid;
 	ei->attr.gid = gid;
 
+	/*
+	 * When the "events" directory is created, it takes on the
+	 * permissions of its parent. But can be reset on remount.
+	 */
+	ei->attr.mode |= EVENTFS_SAVE_UID | EVENTFS_SAVE_GID;
+
 	INIT_LIST_HEAD(&ei->children);
 	INIT_LIST_HEAD(&ei->list);
 
-- 
2.43.0



