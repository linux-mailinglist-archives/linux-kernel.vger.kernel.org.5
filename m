Return-Path: <linux-kernel+bounces-54802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 790E784B3ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE78F1F24EE0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C6A136993;
	Tue,  6 Feb 2024 11:33:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E69134759;
	Tue,  6 Feb 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219212; cv=none; b=DvTdwPh6wkEOjVT3j5LoRf7IQG1sDPZJP5NCg2prG6Q9Aybjwt2+V7aR4pFPWQirMftTTFaK33kkqiXVUFaLEvOLPrWC3AHuEwiZSdPrzz++ec1GkdQD9Btb29mHOYTHVKL+lNUTkP1U5xDqvoGaRyuYaQlX69fmLHmd/bN9J98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219212; c=relaxed/simple;
	bh=QRzNsPzlJd46xARPV8LoVgr8hMSulcnSOm9LygT2RX0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OUjuScDnonfNQvBUhWKjsf755H0P4o5VQRAoBmlfJYOsThlIwgOc53RvhKdLN5LXfrASCWgYVlWXXnp4cNafaJpPpOKvS8jkRBotji1Ln93GKZL4Rgi41xR6q9JY7aZvove39Zj/fNu+FsMS+I9609f8Foy3Jmd6oZjRAUCL8kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF7DC433C7;
	Tue,  6 Feb 2024 11:33:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXJiC-00000006aNp-2mUJ;
	Tue, 06 Feb 2024 06:34:00 -0500
Message-ID: <20240206113400.525587454@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 06:32:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [v6.7][PATCH v2 15/23] tracefs: Avoid using the ei->dentry pointer unnecessarily
References: <20240206113158.822006147@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Linus Torvalds <torvalds@linux-foundation.org>

The eventfs_find_events() code tries to walk up the tree to find the
event directory that a dentry belongs to, in order to then find the
eventfs inode that is associated with that event directory.

However, it uses an odd combination of walking the dentry parent,
looking up the eventfs inode associated with that, and then looking up
the dentry from there.  Repeat.

But the code shouldn't have back-pointers to dentries in the first
place, and it should just walk the dentry parenthood chain directly.

Similarly, 'set_top_events_ownership()' looks up the dentry from the
eventfs inode, but the only reason it wants a dentry is to look up the
superblock in order to look up the root dentry.

But it already has the real filesystem inode, which has that same
superblock pointer.  So just pass in the superblock pointer using the
information that's already there, instead of looking up extraneous data
that is irrelevant.

Link: https://lore.kernel.org/linux-trace-kernel/202401291043.e62e89dc-oliver.sang@intel.com/
Link: https://lore.kernel.org/linux-trace-kernel/20240131185512.638645365@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: c1504e510238 ("eventfs: Implement eventfs dir creation functions")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 99c001cb617df409dac275a059d6c3f187a2da7a)
---
 fs/tracefs/event_inode.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 824b1811e342..e9819d719d2a 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -156,33 +156,30 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return ret;
 }
 
-static void update_top_events_attr(struct eventfs_inode *ei, struct dentry *dentry)
+static void update_top_events_attr(struct eventfs_inode *ei, struct super_block *sb)
 {
-	struct inode *inode;
+	struct inode *root;
 
 	/* Only update if the "events" was on the top level */
 	if (!ei || !(ei->attr.mode & EVENTFS_TOPLEVEL))
 		return;
 
 	/* Get the tracefs root inode. */
-	inode = d_inode(dentry->d_sb->s_root);
-	ei->attr.uid = inode->i_uid;
-	ei->attr.gid = inode->i_gid;
+	root = d_inode(sb->s_root);
+	ei->attr.uid = root->i_uid;
+	ei->attr.gid = root->i_gid;
 }
 
 static void set_top_events_ownership(struct inode *inode)
 {
 	struct tracefs_inode *ti = get_tracefs(inode);
 	struct eventfs_inode *ei = ti->private;
-	struct dentry *dentry;
 
 	/* The top events directory doesn't get automatically updated */
 	if (!ei || !ei->is_events || !(ei->attr.mode & EVENTFS_TOPLEVEL))
 		return;
 
-	dentry = ei->dentry;
-
-	update_top_events_attr(ei, dentry);
+	update_top_events_attr(ei, inode->i_sb);
 
 	if (!(ei->attr.mode & EVENTFS_SAVE_UID))
 		inode->i_uid = ei->attr.uid;
@@ -235,8 +232,10 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 
 	mutex_lock(&eventfs_mutex);
 	do {
-		/* The parent always has an ei, except for events itself */
-		ei = dentry->d_parent->d_fsdata;
+		// The parent is stable because we do not do renames
+		dentry = dentry->d_parent;
+		// ... and directories always have d_fsdata
+		ei = dentry->d_fsdata;
 
 		/*
 		 * If the ei is being freed, the ownership of the children
@@ -246,12 +245,11 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 			ei = NULL;
 			break;
 		}
-
-		dentry = ei->dentry;
+		// Walk upwards until you find the events inode
 	} while (!ei->is_events);
 	mutex_unlock(&eventfs_mutex);
 
-	update_top_events_attr(ei, dentry);
+	update_top_events_attr(ei, dentry->d_sb);
 
 	return ei;
 }
-- 
2.43.0



