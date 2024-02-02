Return-Path: <linux-kernel+bounces-49097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2668465D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE30328A604
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F800EAF7;
	Fri,  2 Feb 2024 02:30:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B3C8DB;
	Fri,  2 Feb 2024 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841005; cv=none; b=m1hjlENu/2p0GcEDCV72iKhx5hx9FbKQPCUFei+dRFflc/BGq4vZxXx/HqxY+TVVnjoUvtEtJi2GmUmDMgn17/W82AKvjQMj1YJ5W29LM7DV6JNmwb1/K93CWOH1fg4J0s/D612kEo/z4gXb1ilxfEQZ4jhPktuzlstbMNTxvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841005; c=relaxed/simple;
	bh=NR3h4mErQ47RHUi+GxBhB9CL/lVTmIE+3l5kJKozkPk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rswfJaxezvlxFotSZLfo05E7DWzMaC0Ci4feCCiMQXc9VbfIVVgpIgAdEYKB6IIjyIqJ32izABQGDcjHgsWfPanSM1JFn/Y7cUAKYzvnLFhipUNIIsRZSLYb5uNCE3lS7OH327FxQQFZZQZmB9KaCoWvy8OlzpQRh6djk8IWO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9488C43390;
	Fri,  2 Feb 2024 02:30:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVjJu-00000005k7c-2tuQ;
	Thu, 01 Feb 2024 21:30:22 -0500
Message-ID: <20240202023022.554271330@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 01 Feb 2024 21:30:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-linus][PATCH 04/13] tracefs: Avoid using the ei->dentry pointer unnecessarily
References: <20240202022959.515961549@goodmis.org>
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



