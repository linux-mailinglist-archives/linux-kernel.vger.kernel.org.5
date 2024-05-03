Return-Path: <linux-kernel+bounces-168381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB838BB7C3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326A41F23AED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FBA84E16;
	Fri,  3 May 2024 22:50:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBED682492;
	Fri,  3 May 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776634; cv=none; b=OkLqJy2+ob9sSrM/LaAio1UZJTo86GMlu7+Q2xxRHQqq6Dh0O8Bjf5CthrXMBx8EWWDr5m8xXf05qjli6N4xfJYvwrhSRaWDBAW5UuRXFK6kB9OJLlN1M6gaaXBqThI0ERYAZP49TZDl81oUgbdEtQ1gwNupIYmTcEERJJhsqF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776634; c=relaxed/simple;
	bh=McYy6Lgc3mMmlqQ9pzQufet3Lee+0qYzcrm26PnjriY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=E2YwnsSArqfgCkuNVkeeF46dOfIwRvAii2CiqL16zTmaixwtBQ1E+OBHzE7cLMrwtg325umXk1TnsXegOiZ1b0scsQN0PkApwVnIoMVuA1661YzFeJA8Mb5oHqpfXLjNngOmgKuGNUDezPaPngT73xJp6iYixIrHLuAueCAYoLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D55C4AF1C;
	Fri,  3 May 2024 22:50:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s31je-00000000NL7-0FOA;
	Fri, 03 May 2024 18:50:34 -0400
Message-ID: <20240503225033.917734121@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 03 May 2024 18:50:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Tze-nan wu <Tze-nan.Wu@mediatek.com>
Subject: [for-linus][PATCH 3/9] eventfs/tracing: Add callback for release of an eventfs_inode
References: <20240503225013.519028385@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
Link: https://lore.kernel.org/linux-trace-kernel/20240502090315.448cba46@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: Tze-nan wu <Tze-nan.Wu@mediatek.com>
Tested-by: Tze-nan Wu (吳澤南) <Tze-nan.Wu@mediatek.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
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



