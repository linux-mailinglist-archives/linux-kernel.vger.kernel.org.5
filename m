Return-Path: <linux-kernel+bounces-34672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A958385F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0BD1F26CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC501877;
	Tue, 23 Jan 2024 03:13:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC11102
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705979603; cv=none; b=E55Vk+c63bvc4NS3qODQiyiARbfOrhRUmMa0jt0NpsJ+NR44sx0oonxcE4rtnY0t12Y7x57KK3x5bv3Wh33IpUH3u8uOZ+5DECYmKZXEN1c0+YhjGM/jh2wmXWRwWz8bEiOlwA6otsngegYo564Wq3v2SgbDQC4VGLjcTRHBFug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705979603; c=relaxed/simple;
	bh=g1vOPJnY9t3y2bVhIPnU2h6iLtYDdE5uoCvaW6dG+O4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lvsVILXeXkQR7AKknv6/VcPlG/eYSrFWTU5WLfbA1IR9G2dt4w2YbayW5R9g3N0d3PICil5T6bZWFWrLyDMwHVDDRwVxHt4RYCbj+ML1B8D+ESi7Tw7cqQaC6qOQZEHBBiNZjQ/nNivqd0I8BunsvKSBvOW+J5vF2dmZx/r4Ijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CF5C43394;
	Tue, 23 Jan 2024 03:13:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rS7FU-00000002i9Q-45QQ;
	Mon, 22 Jan 2024 22:14:52 -0500
Message-ID: <20240123031452.830697973@goodmis.org>
User-Agent: quilt/0.67
Date: Mon, 22 Jan 2024 22:08:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Kees Cook <keescook@chromium.org>
Subject: [for-linus][PATCH 2/2] eventfs: Save directory inodes in the eventfs_inode structure
References: <20240123030826.619242906@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The eventfs inodes and directories are allocated when referenced. But this
leaves the issue of keeping consistent inode numbers and the number is
only saved in the inode structure itself. When the inode is no longer
referenced, it can be freed. When the file that the inode was representing
is referenced again, the inode is once again created, but the inode number
needs to be the same as it was before.

Just making the inode numbers the same for all files is fine, but that
does not work with directories. The find command will check for loops via
the inode number and having the same inode number for directories triggers:

  # find /sys/kernel/tracing
find: File system loop detected;
'/sys/kernel/debug/tracing/events/initcall/initcall_finish' is part of the same file system loop as
'/sys/kernel/debug/tracing/events/initcall'.
[..]

Linus pointed out that the eventfs_inode structure ends with a single
32bit int, and on 64 bit machines, there's likely a 4 byte hole due to
alignment. We can use this hole to store the inode number for the
eventfs_inode. All directories in eventfs are represented by an
eventfs_inode and that data structure can hold its inode number.

That last int was also purposely placed at the end of the structure to
prevent holes from within. Now that there's a 4 byte number to hold the
inode, both the inode number and the last integer can be moved up in the
structure for better cache locality, where the llist and rcu fields can be
moved to the end as they are only used when the eventfs_inode is being
deleted.

Link: https://lore.kernel.org/all/CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com/
Link: https://lore.kernel.org/linux-trace-kernel/20240122152748.46897388@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 53c41052ba31 ("eventfs: Have the inodes all for files and directories all be the same")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/tracefs/event_inode.c | 14 +++++++++++---
 fs/tracefs/internal.h    |  7 ++++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 6795fda2af19..6b211522a13e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -34,7 +34,15 @@ static DEFINE_MUTEX(eventfs_mutex);
 
 /* Choose something "unique" ;-) */
 #define EVENTFS_FILE_INODE_INO		0x12c4e37
-#define EVENTFS_DIR_INODE_INO		0x134b2f5
+
+/* Just try to make something consistent and unique */
+static int eventfs_dir_ino(struct eventfs_inode *ei)
+{
+	if (!ei->ino)
+		ei->ino = get_next_ino();
+
+	return ei->ino;
+}
 
 /*
  * The eventfs_inode (ei) itself is protected by SRCU. It is released from
@@ -396,7 +404,7 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 	inode->i_fop = &eventfs_file_operations;
 
 	/* All directories will have the same inode number */
-	inode->i_ino = EVENTFS_DIR_INODE_INO;
+	inode->i_ino = eventfs_dir_ino(ei);
 
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
@@ -802,7 +810,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		name = ei_child->name;
 
-		ino = EVENTFS_DIR_INODE_INO;
+		ino = eventfs_dir_ino(ei_child);
 
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
 			goto out_dec;
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 12b7d0150ae9..45397df9bb65 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -55,6 +55,10 @@ struct eventfs_inode {
 	struct eventfs_attr		*entry_attrs;
 	struct eventfs_attr		attr;
 	void				*data;
+	unsigned int			is_freed:1;
+	unsigned int			is_events:1;
+	unsigned int			nr_entries:30;
+	unsigned int			ino;
 	/*
 	 * Union - used for deletion
 	 * @llist:	for calling dput() if needed after RCU
@@ -64,9 +68,6 @@ struct eventfs_inode {
 		struct llist_node	llist;
 		struct rcu_head		rcu;
 	};
-	unsigned int			is_freed:1;
-	unsigned int			is_events:1;
-	unsigned int			nr_entries:30;
 };
 
 static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
-- 
2.43.0



