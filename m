Return-Path: <linux-kernel+bounces-166477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 603738B9B3B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A781C21CDE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE87483CD0;
	Thu,  2 May 2024 13:02:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55106824A7;
	Thu,  2 May 2024 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654952; cv=none; b=N0W8oesObY5Xlk5b5vngpnC7qkbEu5WHRlG840haVl7NrUZ7q9+PQnUgy80WO2O3oPmAs2vEglOqICA1tU23JzCwMA/fXHCGqB+rDDNezaO5JFbEg3xIAyg0OeKAPLXnPlgyNT+idZD3qORitO0y1X91TWHnHRhd7oqz3LiUCac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654952; c=relaxed/simple;
	bh=XuDqN2clZKE8rpRfrTJJLt2NhYMUnJTCnv3AGJMBtO8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nrTKqmDN4MWSQ10zbyM8ydPtFbHgJ7gZKFNxIiHWfdylC6yST7qLa9Rk2Fgs+1tAhlM+dJrTtSocUJTqkag3FVsl4viLyS4WnhHBbbungZ0qxOWzqKdlMRq6D1fusDoUJoe/q9+a/qHtSSg/4tGyIcBScc3nTOgXkwdRhFJDUl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D7AC113CC;
	Thu,  2 May 2024 13:02:30 +0000 (UTC)
Date: Thu, 2 May 2024 09:03:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tze-nan wu <Tze-nan.Wu@mediatek.com>
Subject: [PATCH v2] eventfs/tracing: Add callback for release of an
 eventfs_inode
Message-ID: <20240502090315.448cba46@gandalf.local.home>
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

Synthetic events create and destroy tracefs files when they are created
and removed. The tracing subsystem has its own file descriptor
representing the state of the events attached to the tracefs files.
There's a race between the eventfs files and this file descriptor of the
tracing system where the following can cause an issue:

With two scripts 'A' and 'B' doing:

  Script 'A':
    echo "hello int aaa" > /sys/kernel/tracing/synthetic_events
    while :
    do
      echo 0 > /sys/kernel/tracing/events/synthetic/hello/enable
    done

  Script 'B':
    echo > /sys/kernel/tracing/synthetic_events

Script 'A' creates a synthetic event "hello" and then just writes zero
into its enable file.

Script 'B' removes all synthetic events (including the newly created
"hello" event).

What happens is that the opening of the "enable" file has:

 {
	struct trace_event_file *file = inode->i_private;
	int ret;

	ret = tracing_check_open_get_tr(file->tr);
 [..]

But deleting the events frees the "file" descriptor, and a "use after
free" happens with the dereference at "file->tr".

The file descriptor does have a reference counter, but there needs to be a
way to decrement it from the eventfs when the eventfs_inode is removed
that represents this file descriptor.

Add an optional "release" callback to the eventfs_entry array structure,
that gets called when the eventfs file is about to be removed. This allows
for the creating on the eventfs file to increment the tracing file
descriptor ref counter. When the eventfs file is deleted, it can call the
release function that will call the put function for the tracing file
descriptor.

This will protect the tracing file from being freed while a eventfs file
that references it is being opened.

Link: https://lore.kernel.org/linux-trace-kernel/20240426073410.17154-1-Tze-nan.Wu@mediatek.com/

Cc: stable@vger.kernel.org
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: Tze-nan wu <Tze-nan.Wu@mediatek.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240430142327.7bff81ba@gandalf.local.home/

- Do not call release function on error creating the eventfs_inode

 fs/tracefs/event_inode.c    | 23 +++++++++++++++++++++--
 include/linux/tracefs.h     |  3 +++
 kernel/trace/trace_events.c | 12 ++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 894c6ca1e500..f5510e26f0f6 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -84,10 +84,17 @@ enum {
 static void release_ei(struct kref *ref)
 {
 	struct eventfs_inode *ei = container_of(ref, struct eventfs_inode, kref);
+	const struct eventfs_entry *entry;
 	struct eventfs_root_inode *rei;
 
 	WARN_ON_ONCE(!ei->is_freed);
 
+	for (int i = 0; i < ei->nr_entries; i++) {
+		entry = &ei->entries[i];
+		if (entry->release)
+			entry->release(entry->name, ei->data);
+	}
+
 	kfree(ei->entry_attrs);
 	kfree_const(ei->name);
 	if (ei->is_events) {
@@ -112,6 +119,18 @@ static inline void free_ei(struct eventfs_inode *ei)
 	}
 }
 
+/*
+ * Called when creation of an ei fails, do not call release() functions.
+ */
+static inline void cleanup_ei(struct eventfs_inode *ei)
+{
+	if (ei) {
+		/* Set nr_entries to 0 to prevent release() function being called */
+		ei->nr_entries = 0;
+		free_ei(ei);
+	}
+}
+
 static inline struct eventfs_inode *get_ei(struct eventfs_inode *ei)
 {
 	if (ei)
@@ -734,7 +753,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
-		free_ei(ei);
+		cleanup_ei(ei);
 		ei = NULL;
 	}
 	return ei;
@@ -835,7 +854,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ei;
 
  fail:
-	free_ei(ei);
+	cleanup_ei(ei);
 	tracefs_failed_creating(dentry);
 	return ERR_PTR(-ENOMEM);
 }
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 7a5fe17b6bf9..d03f74658716 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -62,6 +62,8 @@ struct eventfs_file;
 typedef int (*eventfs_callback)(const char *name, umode_t *mode, void **data,
 				const struct file_operations **fops);
 
+typedef void (*eventfs_release)(const char *name, void *data);
+
 /**
  * struct eventfs_entry - dynamically created eventfs file call back handler
  * @name:	Then name of the dynamic file in an eventfs directory
@@ -72,6 +74,7 @@ typedef int (*eventfs_callback)(const char *name, umode_t *mode, void **data,
 struct eventfs_entry {
 	const char			*name;
 	eventfs_callback		callback;
+	eventfs_release			release;
 };
 
 struct eventfs_inode;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 52f75c36bbca..6ef29eba90ce 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2552,6 +2552,14 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	return 0;
 }
 
+/* The file is incremented on creation and freeing the enable file decrements it */
+static void event_release(const char *name, void *data)
+{
+	struct trace_event_file *file = data;
+
+	event_file_put(file);
+}
+
 static int
 event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 {
@@ -2566,6 +2574,7 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 		{
 			.name		= "enable",
 			.callback	= event_callback,
+			.release	= event_release,
 		},
 		{
 			.name		= "filter",
@@ -2634,6 +2643,9 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 		return ret;
 	}
 
+	/* Gets decremented on freeing of the "enable" file */
+	event_file_get(file);
+
 	return 0;
 }
 
-- 
2.43.0


