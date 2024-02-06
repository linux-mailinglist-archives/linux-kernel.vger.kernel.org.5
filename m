Return-Path: <linux-kernel+bounces-54884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2257684B4C8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27C81F229D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291F6137C26;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C691A1353F6;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221359; cv=none; b=j10sjl/smn0N9a0Dq5uXHp7TIP2NIxB5SuimRFe73cwtsQoifQzV2qw2zkIBgG1H2luZXCWxbxcVgW9IE/vJL52q9CNA30Ly5sanN3uIU1uiWgxFsU/lLEJCeBQlkRwAIFJu1pe23k13JLVg1p7rHrXSZ8WkfMPB0WU61+GyNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221359; c=relaxed/simple;
	bh=rJbSuvhtLipDc17VpOUCoHRbi16A8mbSZ9ZCLhURrio=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nC/NKnTaV3MMCJa0VmLVPtN/TU1X9gdWosO9wEtfwUOd+HYTnI+AP1DVmtt5dmpHX9dkwhA0D460Mdb9Ddw7CYUpvonUbon9RT5AwDxsJQPgph1gW5VvaEhqidC86PAfgjxHg3Ncymw7H4VjQiKvLZ7qZuKTBFbCMCDRv9tNPJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C93C43394;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGp-00000006b5L-3Rzc;
	Tue, 06 Feb 2024 07:09:47 -0500
Message-ID: <20240206120947.686070579@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 kernel test robot <lkp@intel.com>
Subject: [v6.6][PATCH 08/57] eventfs: Use eventfs_remove_events_dir()
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The update to removing the eventfs_file changed the way the events top
level directory was handled. Instead of returning a dentry, it now returns
the eventfs_inode. In this changed, the removing of the events top level
directory is not much different than removing any of the other
directories. Because of this, the removal just called eventfs_remove_dir()
instead of eventfs_remove_events_dir().

Although eventfs_remove_dir() does the clean up, it misses out on the
dget() of the ei->dentry done in eventfs_create_events_dir(). It makes
more sense to match eventfs_create_events_dir() with a specific function
eventfs_remove_events_dir() and this specific function can then perform
the dput() to the dentry that had the dget() when it was created.

Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310051743.y9EobbUr-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 2819f23ac12ce93ff79ca7a54597df9a4a1f6331)
---
 fs/tracefs/event_inode.c    | 19 +++++++------------
 include/linux/tracefs.h     |  1 +
 kernel/trace/trace_events.c |  2 +-
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index eab18b157ef5..1ccd100bc565 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -901,22 +901,17 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
 }
 
 /**
- * eventfs_remove_events_dir - remove eventfs dir or file from list
- * @dentry: events's dentry to be removed.
+ * eventfs_remove_events_dir - remove the top level eventfs directory
+ * @ei: the event_inode returned by eventfs_create_events_dir().
  *
- * This function remove events main directory
+ * This function removes the events main directory
  */
-void eventfs_remove_events_dir(struct dentry *dentry)
+void eventfs_remove_events_dir(struct eventfs_inode *ei)
 {
-	struct tracefs_inode *ti;
-
-	if (!dentry || !dentry->d_inode)
-		return;
+	struct dentry *dentry = ei->dentry;
 
-	ti = get_tracefs(dentry->d_inode);
-	if (!ti || !(ti->flags & TRACEFS_EVENT_INODE))
-		return;
+	eventfs_remove_dir(ei);
 
-	d_invalidate(dentry);
+	/* Matches the dget() from eventfs_create_events_dir() */
 	dput(dentry);
 }
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 0c39704455d9..13359b1a35d1 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -41,6 +41,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 					 const struct eventfs_entry *entries,
 					 int size, void *data);
 
+void eventfs_remove_events_dir(struct eventfs_inode *ei);
 void eventfs_remove_dir(struct eventfs_inode *ei);
 
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 6595317c3830..697163f8f670 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3893,7 +3893,7 @@ int event_trace_del_tracer(struct trace_array *tr)
 
 	down_write(&trace_event_sem);
 	__trace_remove_event_dirs(tr);
-	eventfs_remove_dir(tr->event_dir);
+	eventfs_remove_events_dir(tr->event_dir);
 	up_write(&trace_event_sem);
 
 	tr->event_dir = NULL;
-- 
2.43.0



