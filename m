Return-Path: <linux-kernel+bounces-35446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C7C83914C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C351F214C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3174C5FB80;
	Tue, 23 Jan 2024 14:24:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9A5EE8E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019870; cv=none; b=maHt6uanfFDzCUZLpw1nk6fN5Gzu//NpTzLI4eULPAtWh6q6+LDB+36r3cnPWgLTs2fHQQg60dif7i4wGUnjc4K3I2AKkLNipueoCVbD5HTRwEfrOOme9vXsvuVIGNFIJPQcJFYZrn3/MsJpuLXdn5gkEEBL+GHkOquUcdjwib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019870; c=relaxed/simple;
	bh=OqwBKZG+HAM9Z/m1JbNtARLUkXeFQAw6q0XphWXmSYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fvpnw2t/0EKholZblnVujYGA3R3NS400gGnucBMNaCC3IE7+cLFyK8SYAGcwSoniHoghzvLKWMXM+bZWUSx4vMUSoBdiQKGLTrD9NOb+I9D4fYJFZPCoHbyg6VzMqyD4nEkUKSVwC7MO1Prs9tIW7PahuK219ZQTiKXX6TcZ3VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9F5C433C7;
	Tue, 23 Jan 2024 14:24:29 +0000 (UTC)
Date: Tue, 23 Jan 2024 09:26:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Petr Pavlu <petr.pavlu@suse.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] tracing: Fixes for eventfs and histograms
Message-ID: <20240123092600.39d78909@gandalf.local.home>
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

Tracing and eventfs fixes for 6.8:

- Fix histogram tracing_map insertion.
  The tracing_map_insert copies the value into the elt variable and
  then assigns the elt to the entry value. But it is possible that
  the entry value becomes visible on other CPUs before the elt is
  fully initialized. This is fixed by adding a wmb() between the
  initialization of the elt variable and assigning it.

- Have eventfs directory have unique inode numbers. Having them be
  all the same proved to be a failure as the find application will
  think that the directories are causing loops, as it checks for
  directory loops via their inodes. Have the evenfs dir entries
  get their inodes assigned when they are referenced and then save
  them in the eventfs_inode structure.


Please pull the latest trace-v6.8-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.8-rc1

Tag SHA1: 729afc0bff83ae580a1151b1de10618ce04cb6dd
Head SHA1: 834bf76add3e6168038150f162cbccf1fd492a67


Petr Pavlu (1):
      tracing: Ensure visibility when inserting an element into tracing_map

Steven Rostedt (Google) (1):
      eventfs: Save directory inodes in the eventfs_inode structure

----
 fs/tracefs/event_inode.c   | 14 +++++++++++---
 fs/tracefs/internal.h      |  7 ++++---
 kernel/trace/tracing_map.c |  7 ++++++-
 3 files changed, 21 insertions(+), 7 deletions(-)
---------------------------
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
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index c774e560f2f9..a4dcf0f24352 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -574,7 +574,12 @@ __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
 				}
 
 				memcpy(elt->key, key, map->key_size);
-				entry->val = elt;
+				/*
+				 * Ensure the initialization is visible and
+				 * publish the elt.
+				 */
+				smp_wmb();
+				WRITE_ONCE(entry->val, elt);
 				atomic64_inc(&map->hits);
 
 				return entry->val;

