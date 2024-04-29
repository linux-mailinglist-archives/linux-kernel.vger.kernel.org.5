Return-Path: <linux-kernel+bounces-162844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2001A8B614C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F8C1C22114
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAEC13AA32;
	Mon, 29 Apr 2024 18:45:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A842A1BB;
	Mon, 29 Apr 2024 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416349; cv=none; b=hFAn9AhqaNZZ3STG2MDjpqhGWNGltHZQ4uyAwQDipGNTjiwueDmbZRhVWJqefY25ul1cEqx5hyC4k7ekXKsihkyUq7IV9gjb6odhfUk8g/4T524MIiqarzR/ZoPpNPRvE73d212SGqlzRW4C3TQlQ5wi4GRecfO1zO5PRG5jyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416349; c=relaxed/simple;
	bh=V6izb0GAHCGz5w8715/v5zNlGoTcwH585pHGUtYZwYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ob3I4IjUWGnzNZmulJhRK7DfBBllaVtWj9TDYaYJAC0tOCmVXuLnuoPB+B38GTag1FYpeucBDDRq9logF0Z005nkL/6P9vojZA5yoXgj/O4YFcHbYNoSWPLdXG08GV4KRjfdsZSLUZnEbJgJYZHOX2mFPFYoe5uDA5SJJqPgMUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A1FC113CD;
	Mon, 29 Apr 2024 18:45:47 +0000 (UTC)
Date: Mon, 29 Apr 2024 14:46:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tze-nan wu <Tze-nan.Wu@mediatek.com>
Cc: <mhiramat@kernel.org>, <bobule.chang@mediatek.com>,
 <wsd_upstream@mediatek.com>, Cheng-Jui Wang <cheng-jui.wang@mediatek.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] tracing: Fix uaf issue in tracing_open_file_tr
Message-ID: <20240429144626.7d868ad3@gandalf.local.home>
In-Reply-To: <20240428202837.0cabca17@rorschach.local.home>
References: <20240426073410.17154-1-Tze-nan.Wu@mediatek.com>
	<20240428202837.0cabca17@rorschach.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Apr 2024 20:28:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Looking for any suggestion or solution, appreciate.  
> 
> Yeah, I do not think eventfs should be involved in this. It needs to be
> protected at a higher level (in the synthetic/dynamic event code).
> 
> I'm just coming back from Japan, and I'll need to take a deeper look at
> this after I recover from my jetlag.

OK, so I guess the eventfs nodes need an optional release callback. Here's
the right way to do that. I added a "release" function to the passed in
entry array that allows for calling a release function when the
eventfs_inode is freed. Then in code for creating events, I call
event_file_get() on the file being assigned and have the freeing of the
"enable" file have the release function that will call event_file_put() on
that file structure.

Does this fix it for you?

-- Steve

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 894c6ca1e500..dc97c19f9e0a 100644
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
index 52f75c36bbca..d14c84281f2b 100644
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
 

