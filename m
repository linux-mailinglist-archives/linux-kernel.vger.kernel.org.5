Return-Path: <linux-kernel+bounces-30220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9296E831BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB25B22BED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B236D1E520;
	Thu, 18 Jan 2024 14:45:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A481E4A1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589128; cv=none; b=JnmvlZNjF7q1QYHswm5WFdVocWpJlFXyf8N5BQLnt6qIPyn/XSZ9mZXq80MeUe9fRL276Rdw/dwETKqZdSZQx4P2HNh6wCCjQALUjEKrAgNFdlJ6mkjm4GlZmKvPlmdQzDwN+bJpigwdvmrSllyM7XuUCwgpMqqK4z6NqReet0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589128; c=relaxed/simple;
	bh=jWDkfChzYYvTaG6H6B35gjloWDfYxgMr/RX4Mzi9osU=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding; b=Y5yawU1VNspqh+FBDw7gRRnOYcC6PhrY6xYZBsaBM8VA+x6MvoBefwUrKnn3uNkd+VLiJ18xPPPR/ZCbf4E7yxJpfC8rpZ0tomBweV7lJaWOcYKCmB1r2osr3lj6i4dEOY4Hiw2MhfrZebOhnqmuvnc+m/g/YeCRJdhtR0hY8h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F007FC433F1;
	Thu, 18 Jan 2024 14:45:26 +0000 (UTC)
Date: Thu, 18 Jan 2024 09:46:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Erick Archer <erick.archer@gmx.com>, Nathan Lynch <nathanl@linux.ibm.com>
Subject: [GIT PULL] eventfs: Fix for readdir and a seq_buf fix
Message-ID: <20240118094645.58edbfb7@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

This includes the fix to eventfs that we discussed. It removes the creation
of dentries/inodes from the readdir() logic. I also threw in a seq_buf fix
that was sent to me not to long ago.

More eventfs fixes and a seq_buf fix for 6.8:

- Hard-code the inodes for eventfs to the same number for files, and
  the same number for directories.

- Have getdent() not create dentries/inodes in iterate_shared() as now
  it has hard-coded inode numbers

- Use kcalloc() instead of kzalloc() on a list of elements

- Fix seq_buf warning and make static work properly.


Please pull the latest eventfs-v6.8-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
eventfs-v6.8-2

Tag SHA1: 09d733778820003cca5836364cbc0b162d70bb7e
Head SHA1: 7a8e9cdf9405819105ae7405cd91e482bf574b01


Erick Archer (1):
      eventfs: Use kcalloc() instead of kzalloc()

Nathan Lynch (1):
      seq_buf: Make DECLARE_SEQ_BUF() usable

Steven Rostedt (Google) (2):
      eventfs: Have the inodes all for files and directories all be the same
      eventfs: Do not create dentries nor inodes in iterate_shared

----
 fs/tracefs/event_inode.c | 36 ++++++++++++++++++------------------
 include/linux/seq_buf.h  |  3 +--
 2 files changed, 19 insertions(+), 20 deletions(-)
---------------------------
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index fdff53d5a1f8..6795fda2af19 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -32,6 +32,10 @@
  */
 static DEFINE_MUTEX(eventfs_mutex);
 
+/* Choose something "unique" ;-) */
+#define EVENTFS_FILE_INODE_INO		0x12c4e37
+#define EVENTFS_DIR_INODE_INO		0x134b2f5
+
 /*
  * The eventfs_inode (ei) itself is protected by SRCU. It is released from
  * its parent's list and will have is_freed set (under eventfs_mutex).
@@ -93,7 +97,7 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	/* Preallocate the children mode array if necessary */
 	if (!(dentry->d_inode->i_mode & S_IFDIR)) {
 		if (!ei->entry_attrs) {
-			ei->entry_attrs = kzalloc(sizeof(*ei->entry_attrs) * ei->nr_entries,
+			ei->entry_attrs = kcalloc(ei->nr_entries, sizeof(*ei->entry_attrs),
 						  GFP_NOFS);
 			if (!ei->entry_attrs) {
 				ret = -ENOMEM;
@@ -352,6 +356,9 @@ static struct dentry *create_file(const char *name, umode_t mode,
 	inode->i_fop = fop;
 	inode->i_private = data;
 
+	/* All files will have the same inode number */
+	inode->i_ino = EVENTFS_FILE_INODE_INO;
+
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
 	d_instantiate(dentry, inode);
@@ -388,6 +395,9 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 	inode->i_op = &eventfs_root_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
+	/* All directories will have the same inode number */
+	inode->i_ino = EVENTFS_DIR_INODE_INO;
+
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
 
@@ -717,8 +727,6 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
-	struct dentry *ei_dentry = NULL;
-	struct dentry *dentry;
 	const char *name;
 	umode_t mode;
 	int idx;
@@ -739,11 +747,11 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 	mutex_lock(&eventfs_mutex);
 	ei = READ_ONCE(ti->private);
-	if (ei && !ei->is_freed)
-		ei_dentry = READ_ONCE(ei->dentry);
+	if (ei && ei->is_freed)
+		ei = NULL;
 	mutex_unlock(&eventfs_mutex);
 
-	if (!ei || !ei_dentry)
+	if (!ei)
 		goto out;
 
 	/*
@@ -770,11 +778,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		if (r <= 0)
 			continue;
 
-		dentry = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
-		if (!dentry)
-			goto out;
-		ino = dentry->d_inode->i_ino;
-		dput(dentry);
+		ino = EVENTFS_FILE_INODE_INO;
 
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
 			goto out;
@@ -798,11 +802,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		name = ei_child->name;
 
-		dentry = create_dir_dentry(ei, ei_child, ei_dentry);
-		if (!dentry)
-			goto out_dec;
-		ino = dentry->d_inode->i_ino;
-		dput(dentry);
+		ino = EVENTFS_DIR_INODE_INO;
 
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
 			goto out_dec;
@@ -874,7 +874,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	}
 
 	if (size) {
-		ei->d_children = kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
+		ei->d_children = kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
 		if (!ei->d_children) {
 			kfree_const(ei->name);
 			kfree(ei);
@@ -941,7 +941,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 		goto fail;
 
 	if (size) {
-		ei->d_children = kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
+		ei->d_children = kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
 		if (!ei->d_children)
 			goto fail;
 	}
diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 5fb1f12c33f9..c44f4b47b945 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -22,9 +22,8 @@ struct seq_buf {
 };
 
 #define DECLARE_SEQ_BUF(NAME, SIZE)			\
-	char __ ## NAME ## _buffer[SIZE] = "";		\
 	struct seq_buf NAME = {				\
-		.buffer = &__ ## NAME ## _buffer,	\
+		.buffer = (char[SIZE]) { 0 },		\
 		.size = SIZE,				\
 	}
 

