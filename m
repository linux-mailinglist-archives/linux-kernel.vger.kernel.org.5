Return-Path: <linux-kernel+bounces-47234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B2C844AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2972FB24C98
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC0939FFC;
	Wed, 31 Jan 2024 22:11:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBCF39FFB;
	Wed, 31 Jan 2024 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739067; cv=none; b=APhxINq/35JRlzCieVibVKEAUmcc/w0iyJ3Q7SEA6imClvaPghhDR/hRVC3QIheHypLjnAP0wP2cx404SVRqwVp+c3eCrJ8TSTvn1j1Bbbbt5QUuLLXAZq1h/jwpM6jd04aO9xeWTNH7TCEGzxSEXLEuZbLkJh1FVTKIJ+byBH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739067; c=relaxed/simple;
	bh=TcJ0LtlwRMoHr5h77qmW67gE+n5AX8DYT/vIshYiA9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ifmAx9FWC+zwoKbLr7x/QF29tJClHRsO9ldzYUfTKNlDyS5ht8UKF6acm0zPS3M/I5wtzgrpOvPIgRdKg6KDZrcRn68dQS8Iu9XMwVbkf6oMQ9JAVsDGngVKSzNK2ADyjmfJjBg9HaI3G5U9buw2vJIloUcckk+cCgLiz5eAX7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E985C433A6;
	Wed, 31 Jan 2024 22:11:06 +0000 (UTC)
Date: Wed, 31 Jan 2024 17:11:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: [PATCH] eventfs: Create eventfs_root_inode to store dentry
Message-ID: <20240131171120.607cb71d@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Only the root "events" directory stores a dentry. There's no reason to
hold a dentry pointer for every eventfs_inode as it is never set except
for the root "events" eventfs_inode.

Create a eventfs_root_inode structure that holds the events_dir dentry.
The "events" eventfs_inode *is* special, let it have its own descriptor.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 65 +++++++++++++++++++++++++++++++++-------
 fs/tracefs/internal.h    |  2 --
 2 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 463920295237..126cbe62f142 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -35,6 +35,17 @@ static DEFINE_MUTEX(eventfs_mutex);
 /* Choose something "unique" ;-) */
 #define EVENTFS_FILE_INODE_INO		0x12c4e37
 
+struct eventfs_root_inode {
+	struct eventfs_inode		ei;
+	struct dentry			*events_dir;
+};
+
+static struct eventfs_root_inode *get_root_inode(struct eventfs_inode *ei)
+{
+	WARN_ON_ONCE(!ei->is_events);
+	return container_of(ei, struct eventfs_root_inode, ei);
+}
+
 /* Just try to make something consistent and unique */
 static int eventfs_dir_ino(struct eventfs_inode *ei)
 {
@@ -73,12 +84,18 @@ enum {
 static void release_ei(struct kref *ref)
 {
 	struct eventfs_inode *ei = container_of(ref, struct eventfs_inode, kref);
+	struct eventfs_root_inode *rei;
 
 	WARN_ON_ONCE(!ei->is_freed);
 
 	kfree(ei->entry_attrs);
 	kfree_const(ei->name);
-	kfree_rcu(ei, rcu);
+	if (ei->is_events) {
+		rei = get_root_inode(ei);
+		kfree_rcu(rei, ei.rcu);
+	} else {
+		kfree_rcu(ei, rcu);
+	}
 }
 
 static inline void put_ei(struct eventfs_inode *ei)
@@ -412,19 +429,43 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 	return NULL;
 }
 
+static inline struct eventfs_inode *init_ei(struct eventfs_inode *ei, const char *name)
+{
+	ei->name = kstrdup_const(name, GFP_KERNEL);
+	if (!ei->name)
+		return NULL;
+	kref_init(&ei->kref);
+	return ei;
+}
+
 static inline struct eventfs_inode *alloc_ei(const char *name)
 {
 	struct eventfs_inode *ei = kzalloc(sizeof(*ei), GFP_KERNEL);
+	struct eventfs_inode *result;
 
 	if (!ei)
 		return NULL;
 
-	ei->name = kstrdup_const(name, GFP_KERNEL);
-	if (!ei->name) {
+	result = init_ei(ei, name);
+	if (!result)
 		kfree(ei);
+
+	return result;
+}
+
+static inline struct eventfs_inode *alloc_root_ei(const char *name)
+{
+	struct eventfs_root_inode *rei = kzalloc(sizeof(*rei), GFP_KERNEL);
+	struct eventfs_inode *ei;
+
+	if (!rei)
 		return NULL;
-	}
-	kref_init(&ei->kref);
+
+	rei->ei.is_events = 1;
+	ei = init_ei(&rei->ei, name);
+	if (!ei)
+		kfree(rei);
+
 	return ei;
 }
 
@@ -718,6 +759,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 						int size, void *data)
 {
 	struct dentry *dentry = tracefs_start_creating(name, parent);
+	struct eventfs_root_inode *rei;
 	struct eventfs_inode *ei;
 	struct tracefs_inode *ti;
 	struct inode *inode;
@@ -730,7 +772,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 
-	ei = alloc_ei(name);
+	ei = alloc_root_ei(name);
 	if (!ei)
 		goto fail;
 
@@ -739,10 +781,11 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 		goto fail;
 
 	// Note: we have a ref to the dentry from tracefs_start_creating()
-	ei->events_dir = dentry;
+	rei = get_root_inode(ei);
+	rei->events_dir = dentry;
+
 	ei->entries = entries;
 	ei->nr_entries = size;
-	ei->is_events = 1;
 	ei->data = data;
 
 	/* Save the ownership of this directory */
@@ -845,13 +888,15 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
  */
 void eventfs_remove_events_dir(struct eventfs_inode *ei)
 {
+	struct eventfs_root_inode *rei;
 	struct dentry *dentry;
 
-	dentry = ei->events_dir;
+	rei = get_root_inode(ei);
+	dentry = rei->events_dir;
 	if (!dentry)
 		return;
 
-	ei->events_dir = NULL;
+	rei->events_dir = NULL;
 	eventfs_remove_dir(ei);
 
 	/*
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index beb3dcd0e434..15c26f9aaad4 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -36,7 +36,6 @@ struct eventfs_attr {
  * @children:	link list into the child eventfs_inode
  * @entries:	the array of entries representing the files in the directory
  * @name:	the name of the directory to create
- * @events_dir: the dentry of the events directory
  * @entry_attrs: Saved mode and ownership of the @d_children
  * @data:	The private data to pass to the callbacks
  * @attr:	Saved mode and ownership of eventfs_inode itself
@@ -54,7 +53,6 @@ struct eventfs_inode {
 	struct list_head		children;
 	const struct eventfs_entry	*entries;
 	const char			*name;
-	struct dentry			*events_dir;
 	struct eventfs_attr		*entry_attrs;
 	void				*data;
 	struct eventfs_attr		attr;
-- 
2.43.0


