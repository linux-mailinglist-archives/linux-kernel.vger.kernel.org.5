Return-Path: <linux-kernel+bounces-45155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82203842C40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B85289B93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B245169DE8;
	Tue, 30 Jan 2024 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vd1hrNDi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3DE7994D;
	Tue, 30 Jan 2024 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641458; cv=none; b=QvZCbPjauh+biMAwaCIyFStY/sToMfJfvO910z+8NyjspITMR4b/2ePsYOisK3jB1OWhBtSpZS5qWlXbjH1JCGl6RqzoG+Fwp5JdO+AutVzXzE7Oj/HcWab6fTadbYZEIQ951aufQ7psAMRQP8wHy2ho6Ajuwob5ojArhUqofYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641458; c=relaxed/simple;
	bh=UN73rU1wKgk+kPZG4I6r0l+EYowt6RDqJg5XsMuGiLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/2OZDZm7Le22C/grg8G+n782s3uw1yVqFq36mhl7SHuo9M2CtVK1hUCB4OWZuFkXB/i2OVPPr9YCh8OO6O9M9ziDF+LhtmEo75wpo+iC+xhNFarKmeNLJZMGX1oLexKPrJrWgaxfhenxKNTB/+oGtPpLOy0cngkKBkgg11ZhG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vd1hrNDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B164C433F1;
	Tue, 30 Jan 2024 19:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706641457;
	bh=UN73rU1wKgk+kPZG4I6r0l+EYowt6RDqJg5XsMuGiLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vd1hrNDi9XyJiMLBg7nk96fWw9ntucwuoWji3NVvRxAagTIdMFOl0KoD36I7e+2VN
	 VnHMY7fCpF6mvFH03bTwvvq/HhaKy3ufgcODBFOxIt/jukpRAqV9ZQPeNO61tr5hZy
	 XzWvd6ERZDEGPk+VJTU5IUICtY1fOooFW2U32I7k=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/6] eventfsfs: initialize the tracefs inode properly
Date: Tue, 30 Jan 2024 11:03:51 -0800
Message-ID: <20240130190355.11486-2-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.43.0.5.g38fb137bdb
In-Reply-To: <20240130190355.11486-1-torvalds@linux-foundation.org>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tracefs-specific fields in the inode were not initialized before the
inode was exposed to others through the dentry with 'd_instantiate()'.

And the ->flags file was initialized incorrectly with a '|=', when the
old value was stale.  It should have just been a straight assignment.

Move the field initializations up to before the d_instantiate, and fix
the use of uninitialized data.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/tracefs/event_inode.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 2d128bedd654..c0d977e6c0f2 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -328,7 +328,9 @@ static struct dentry *create_file(const char *name, umode_t mode,
 	inode->i_ino = EVENTFS_FILE_INODE_INO;
 
 	ti = get_tracefs(inode);
-	ti->flags |= TRACEFS_EVENT_INODE;
+	ti->flags = TRACEFS_EVENT_INODE;
+	ti->private = NULL;			// Directories have 'ei', files not
+
 	d_instantiate(dentry, inode);
 	fsnotify_create(dentry->d_parent->d_inode, dentry);
 	return eventfs_end_creating(dentry);
@@ -367,7 +369,8 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 	inode->i_ino = eventfs_dir_ino(ei);
 
 	ti = get_tracefs(inode);
-	ti->flags |= TRACEFS_EVENT_INODE;
+	ti->flags = TRACEFS_EVENT_INODE;
+	ti->private = ei;
 
 	inc_nlink(inode);
 	d_instantiate(dentry, inode);
@@ -513,7 +516,6 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 static void eventfs_post_create_dir(struct eventfs_inode *ei)
 {
 	struct eventfs_inode *ei_child;
-	struct tracefs_inode *ti;
 
 	lockdep_assert_held(&eventfs_mutex);
 
@@ -523,9 +525,6 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
 				 srcu_read_lock_held(&eventfs_srcu)) {
 		ei_child->d_parent = ei->dentry;
 	}
-
-	ti = get_tracefs(ei->dentry->d_inode);
-	ti->private = ei;
 }
 
 /**
@@ -943,7 +942,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	INIT_LIST_HEAD(&ei->list);
 
 	ti = get_tracefs(inode);
-	ti->flags |= TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
+	ti->flags = TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
 	ti->private = ei;
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
-- 
2.43.0.5.g38fb137bdb


