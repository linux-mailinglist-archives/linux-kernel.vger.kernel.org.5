Return-Path: <linux-kernel+bounces-54806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE4084B3F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAEE81F24F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0778138483;
	Tue,  6 Feb 2024 11:33:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FCD134CFD;
	Tue,  6 Feb 2024 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219213; cv=none; b=GELwH/kn162Pyy/qhPD9MsW0W/8Uy9tpR9oXxFiC0BcpGzvLAEJvktt5cCHSGIi+6727WO1puPsBPeaPQWoKrbPTrzFJqbplJu3Tis66pvmXmWEhrDzbfc3AhMIjWYMzgk93UiTyuI6cmux/f1uSJu9JS5a+kBm/CtZrzN0RU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219213; c=relaxed/simple;
	bh=ovB9zqm93FTVxxBECSNPxdclrmbXtlerbnuNH1s24zo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cFHJmruJDfhbljS00I7crpY/KsKIJvcQBgGia9xeXWuhx6zJLKHvEe8TGVAyK5gyDtgumDiSesg/QJNAoBHui5inxNtPGyGUDwqypLlLcsqtxcDVdkLuVdlOUnWrfmk9I8pInv/MOm/BZx3v4PtomN/6w2HGHY7TxD0s+8ZvkYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430E6C43394;
	Tue,  6 Feb 2024 11:33:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXJiD-00000006aQq-2eTT;
	Tue, 06 Feb 2024 06:34:01 -0500
Message-ID: <20240206113401.490005209@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 06:32:19 -0500
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
Subject: [v6.7][PATCH v2 21/23] eventfs: Restructure eventfs_inode structure to be more condensed
References: <20240206113158.822006147@rostedt.homelinux.com>
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
(cherry picked from commit 264424dfdd5cbd92bc5b5ddf93944929fc877fac)
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



