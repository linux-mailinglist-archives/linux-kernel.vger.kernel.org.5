Return-Path: <linux-kernel+bounces-45154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7753B842C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11561C2467F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EFE79956;
	Tue, 30 Jan 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sPvFIbvn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FD79948;
	Tue, 30 Jan 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641452; cv=none; b=S50TscRi5ny3JoTnv/gnaSB1I33qw2jO28EwMtTb3Dq+Zs3WfdblTMRXyQFNwbY6ZKKFxQPXfGbq2sipuwr3r3tfbkNaUy4Az/UEk+Fe5ZjJkqZ9g+dXjCNMRjAyjF8nBQZA9CqAnog52J10SROr/13L9GT+ikkW155D7lx36K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641452; c=relaxed/simple;
	bh=/VhpS5sd/6Wo9lZmVmUCPhzalbMspHdeI+886w/8Nls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AjnBtPXejlonvizDos76qup11iEzPBy/yXFcmGOO1aLQH8tFS//ZkGmmqbcjS0jcarxZp3LMT0SOwkR7jlbM5RXvMqiUnilJCf5tdJO8OelF1p19JdKGyThD9Mdo7jbvy40B4Sd7UCP/xx2KlUwbt9zlL3WUv6ELa3JGrOyONjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sPvFIbvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FA5C433C7;
	Tue, 30 Jan 2024 19:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706641451;
	bh=/VhpS5sd/6Wo9lZmVmUCPhzalbMspHdeI+886w/8Nls=;
	h=From:To:Cc:Subject:Date:From;
	b=sPvFIbvnEnAfVnGnWpE1wIA6AsVzmHu44QSP4mHgzR0gVpraQ6hb0UWMyr45N6ncO
	 /fVUj47CsgFdoUz4mICcPYg7bl3baxe6qDxRRPpihbNyvnDIKLYXMGkumfcjW6TN2z
	 iDwbrd2zJw+5M5jf/ePV/Uv8EaiQdo1lrUABqMrI=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/6] tracefs: avoid using the ei->dentry pointer unnecessarily
Date: Tue, 30 Jan 2024 11:03:50 -0800
Message-ID: <20240130190355.11486-1-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.43.0.5.g38fb137bdb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/tracefs/event_inode.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 1c3dd0ad4660..2d128bedd654 100644
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
2.43.0.5.g38fb137bdb


