Return-Path: <linux-kernel+bounces-51341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E55848A01
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A816B23F50
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39FCC153;
	Sun,  4 Feb 2024 01:18:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A570C1FA0;
	Sun,  4 Feb 2024 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009485; cv=none; b=rBe+KZ9WW8h+ciK1lTdFYgMGUNc4SPnygpPn2+hc1iT+lAVDbsM2qGfbdnFPEvFrsm3fE4rk76Lfm4vai9XTmJ+RoQH9B5ePj/THuu8WRfnT2DiRUeosUpqVbcOe4keBtAkkq0ko2gzJ++YH8Wf3enD8v31EuZtSwa+xw7RFqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009485; c=relaxed/simple;
	bh=Z0WFv+6WQ373ABo/KMOyPZvBrXjCfwOl5DRRrGItHYo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Jyao2nWgTt+1iFmN5tg2YhWwFyqo/CqJrXFkPnYp0t8donaEOnH7TCt/uEtQl2V/xXV0adeAtVf+p9njmmWOjGMWTh3nS5JhxFjjGz9ApQo3LfcYBUueQeP8ATLdSU5+lHM0PndK1oV1LP3uuGrUFgwPbjwFzsmlq+YeDAd3vA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D91BC41674;
	Sun,  4 Feb 2024 01:18:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rWR9P-00000006Omt-3Wit;
	Sat, 03 Feb 2024 20:18:27 -0500
Message-ID: <20240204011827.696890375@goodmis.org>
User-Agent: quilt/0.67
Date: Sat, 03 Feb 2024 20:16:20 -0500
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
 Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Subject: [v6.7][PATCH 05/23] eventfs: Do ctx->pos update for all iterations in eventfs_iterate()
References: <20240204011615.703023949@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The ctx->pos was only updated when it added an entry, but the "skip to
current pos" check (c--) happened for every loop regardless of if the
entry was added or not. This inconsistency caused readdir to be incorrect.

It was due to:

	for (i = 0; i < ei->nr_entries; i++) {

		if (c > 0) {
			c--;
			continue;
		}

		mutex_lock(&eventfs_mutex);
		/* If ei->is_freed then just bail here, nothing more to do */
		if (ei->is_freed) {
			mutex_unlock(&eventfs_mutex);
			goto out;
		}
		r = entry->callback(name, &mode, &cdata, &fops);
		mutex_unlock(&eventfs_mutex);

		[..]
		ctx->pos++;
	}

But this can cause the iterator to return a file that was already read.
That's because of the way the callback() works. Some events may not have
all files, and the callback can return 0 to tell eventfs to skip the file
for this directory.

for instance, we have:

 # ls /sys/kernel/tracing/events/ftrace/function
format  hist  hist_debug  id  inject

and

 # ls /sys/kernel/tracing/events/sched/sched_switch/
enable  filter  format  hist  hist_debug  id  inject  trigger

Where the function directory is missing "enable", "filter" and
"trigger". That's because the callback() for events has:

static int event_callback(const char *name, umode_t *mode, void **data,
			  const struct file_operations **fops)
{
	struct trace_event_file *file = *data;
	struct trace_event_call *call = file->event_call;

[..]

	/*
	 * Only event directories that can be enabled should have
	 * triggers or filters, with the exception of the "print"
	 * event that can have a "trigger" file.
	 */
	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
		if (call->class->reg && strcmp(name, "enable") == 0) {
			*mode = TRACE_MODE_WRITE;
			*fops = &ftrace_enable_fops;
			return 1;
		}

		if (strcmp(name, "filter") == 0) {
			*mode = TRACE_MODE_WRITE;
			*fops = &ftrace_event_filter_fops;
			return 1;
		}
	}

	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE) ||
	    strcmp(trace_event_name(call), "print") == 0) {
		if (strcmp(name, "trigger") == 0) {
			*mode = TRACE_MODE_WRITE;
			*fops = &event_trigger_fops;
			return 1;
		}
	}
[..]
	return 0;
}

Where the function event has the TRACE_EVENT_FL_IGNORE_ENABLE set.

This means that the entries array elements for "enable", "filter" and
"trigger" when called on the function event will have the callback return
0 and not 1, to tell eventfs to skip these files for it.

Because the "skip to current ctx->pos" check happened for all entries, but
the ctx->pos++ only happened to entries that exist, it would confuse the
reading of a directory. Which would cause:

 # ls /sys/kernel/tracing/events/ftrace/function/
format  hist  hist  hist_debug  hist_debug  id  inject  inject

The missing "enable", "filter" and "trigger" caused ls to show "hist",
"hist_debug" and "inject" twice.

Update the ctx->pos for every iteration to keep its update and the "skip"
update consistent. This also means that on error, the ctx->pos needs to be
decremented if it was incremented without adding something.

Link: https://lore.kernel.org/all/20240104150500.38b15a62@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20240104220048.172295263@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 493ec81a8fb8e ("eventfs: Stop using dcache_readdir() for getdents()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 0aca6910efb3..c73fb1f7ddbc 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -760,6 +760,8 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 			continue;
 		}
 
+		ctx->pos++;
+
 		if (ei_child->is_freed)
 			continue;
 
@@ -767,13 +769,12 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		dentry = create_dir_dentry(ei, ei_child, ei_dentry);
 		if (!dentry)
-			goto out;
+			goto out_dec;
 		ino = dentry->d_inode->i_ino;
 		dput(dentry);
 
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
-			goto out;
-		ctx->pos++;
+			goto out_dec;
 	}
 
 	for (i = 0; i < ei->nr_entries; i++) {
@@ -784,6 +785,8 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 			continue;
 		}
 
+		ctx->pos++;
+
 		entry = &ei->entries[i];
 		name = entry->name;
 
@@ -791,7 +794,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		/* If ei->is_freed then just bail here, nothing more to do */
 		if (ei->is_freed) {
 			mutex_unlock(&eventfs_mutex);
-			goto out;
+			goto out_dec;
 		}
 		r = entry->callback(name, &mode, &cdata, &fops);
 		mutex_unlock(&eventfs_mutex);
@@ -800,19 +803,23 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		dentry = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
 		if (!dentry)
-			goto out;
+			goto out_dec;
 		ino = dentry->d_inode->i_ino;
 		dput(dentry);
 
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
-			goto out;
-		ctx->pos++;
+			goto out_dec;
 	}
 	ret = 1;
  out:
 	srcu_read_unlock(&eventfs_srcu, idx);
 
 	return ret;
+
+ out_dec:
+	/* Incremented ctx->pos without adding something, reset it */
+	ctx->pos--;
+	goto out;
 }
 
 /**
-- 
2.43.0



