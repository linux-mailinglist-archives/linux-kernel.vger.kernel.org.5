Return-Path: <linux-kernel+bounces-51357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01003848A17
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E12B24F30
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693C417584;
	Sun,  4 Feb 2024 01:18:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F5F101FA;
	Sun,  4 Feb 2024 01:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009488; cv=none; b=baHu0vwkzBR0gYKnYacZ96zEsLEe4OXT7d+lchAYJY5421xBTz8XFDTRYaIkrjM7ee3I05x0UE2rCLNbMK8rj9r6kqnQc0qoIjViT/SI6oR92arEvhP5C0F++qXaNO2T9xesV6GwCb1FXUNj4sSifJ5S7R++D3yvDNlpg6bm8/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009488; c=relaxed/simple;
	bh=1bWv9KlxHQzO4IJ5J8Xlt8xuUk/3QGMai5L7xRHgYPA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=biJZ+0qtNlzu7Y098Z4rxo7BzuoQX8QjlNd9JdvaY/KojfJupkWW24G5k0fDr29v24gIvXqHr43j7EVTN0lD6LY615/vvOjrL/GmDK6HkIV8k6oJdBdJvBOtBXHfjr09ikLVJ4xUZbkBs8SS24Sv5R8G8rgD6gDL6NwfbqmXBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C497BC32799;
	Sun,  4 Feb 2024 01:18:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rWR9S-00000006Our-1vXx;
	Sat, 03 Feb 2024 20:18:30 -0500
Message-ID: <20240204011830.314244430@goodmis.org>
User-Agent: quilt/0.67
Date: Sat, 03 Feb 2024 20:16:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [v6.7][PATCH 21/23] eventfs: Restructure eventfs_inode structure to be more condensed
References: <20240204011615.703023949@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Some of the eventfs_inode structure has holes in it. Rework the structure
to be a bit more condensed, and also remove the no longer used llist
field.

Link: https://lore.kernel.org/linux-trace-kernel/20240201161617.002321438@goodmis.org

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/internal.h | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 1886f1826cd8..beb3dcd0e434 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -32,40 +32,37 @@ struct eventfs_attr {
 /*
  * struct eventfs_inode - hold the properties of the eventfs directories.
  * @list:	link list into the parent directory
+ * @rcu:	Union with @list for freeing
+ * @children:	link list into the child eventfs_inode
  * @entries:	the array of entries representing the files in the directory
  * @name:	the name of the directory to create
- * @children:	link list into the child eventfs_inode
  * @events_dir: the dentry of the events directory
  * @entry_attrs: Saved mode and ownership of the @d_children
- * @attr:	Saved mode and ownership of eventfs_inode itself
  * @data:	The private data to pass to the callbacks
+ * @attr:	Saved mode and ownership of eventfs_inode itself
  * @is_freed:	Flag set if the eventfs is on its way to be freed
  *                Note if is_freed is set, then dentry is corrupted.
+ * @is_events:	Flag set for only the top level "events" directory
  * @nr_entries: The number of items in @entries
+ * @ino:	The saved inode number
  */
 struct eventfs_inode {
-	struct kref			kref;
-	struct list_head		list;
+	union {
+		struct list_head	list;
+		struct rcu_head		rcu;
+	};
+	struct list_head		children;
 	const struct eventfs_entry	*entries;
 	const char			*name;
-	struct list_head		children;
 	struct dentry			*events_dir;
 	struct eventfs_attr		*entry_attrs;
-	struct eventfs_attr		attr;
 	void				*data;
+	struct eventfs_attr		attr;
+	struct kref			kref;
 	unsigned int			is_freed:1;
 	unsigned int			is_events:1;
 	unsigned int			nr_entries:30;
 	unsigned int			ino;
-	/*
-	 * Union - used for deletion
-	 * @llist:	for calling dput() if needed after RCU
-	 * @rcu:	eventfs_inode to delete in RCU
-	 */
-	union {
-		struct llist_node	llist;
-		struct rcu_head		rcu;
-	};
 };
 
 static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
-- 
2.43.0



