Return-Path: <linux-kernel+bounces-42129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADF883FCC2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4048CB215AF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A873110940;
	Mon, 29 Jan 2024 03:31:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2510949
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499114; cv=none; b=GJnu1ieCpgVOiu22BZppXuIIMhPv63O+l6/uYkBNaz2G082XOxeD39DqjO45QgogoyrztP6GJtil2Dtf90PU4Oj47TrSK0G/PgyO/ajiqTNMzpwHnwCy9KvVpR8pFEumd1Pn57g/1KUjGOPO+CRH9PcHTiNvkPH+ret/GAo4af4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499114; c=relaxed/simple;
	bh=IKXig95vKmdIC1I71WRDokmA4+6M3oYG4crRkE+z1j0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=H+g8eZ5D92d4BwWoQwhy/M3xmi/bi/zX7qccHhvbXbtQJxAWDpqc2gsCgxIanGAWhF8XNuAiHHaiEFXaAhjSW1574LXCGSq/P2YRKuaEUcqCxYdPhjz1b7X+dnzUl9hpjuJzHx2Qf0PybgeBQ/G8cCgxDOcrbUJ/ySlmMnPNwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C7AC433C7;
	Mon, 29 Jan 2024 03:31:52 +0000 (UTC)
Date: Sun, 28 Jan 2024 22:31:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] tracing: A couple of fixes for 6.8
Message-ID: <20240128223151.2dad6599@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

tracing: Two small fixes for tracing and eventfs:

- Fix register_snapshot_trigger() on allocation error
  If the snapshot fails to allocate, the register_snapshot_trigger() can
  still return success. If the call to tracing_alloc_snapshot_instance()
  returned anything but 0, it returned 0, but it should have been returning
  the error code from that allocation function.

- Remove leftover code from tracefs doing a dentry walk on remount.
  The update_gid() function was called by the tracefs code on remount
  to update the gid of eventfs, but that is no longer the case, but that
  code wasn't deleted. Nothing calls it. Remove it.


Please pull the latest trace-v6.8-rc1-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.8-rc1-2

Tag SHA1: 4428da6214384c6eff60b4c8e481d58bd70ece96
Head SHA1: 29142dc92c37d3259a33aef15b03e6ee25b0d188


Linus Torvalds (1):
      tracefs: remove stale 'update_gid' code

Masami Hiramatsu (Google) (1):
      tracing/trigger: Fix to return error if failed to alloc snapshot

----
 fs/tracefs/event_inode.c            | 38 -------------------------------------
 fs/tracefs/internal.h               |  1 -
 kernel/trace/trace_events_trigger.c |  6 ++++--
 3 files changed, 4 insertions(+), 41 deletions(-)
---------------------------
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 6b211522a13e..1c3dd0ad4660 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -281,44 +281,6 @@ static void update_inode_attr(struct dentry *dentry, struct inode *inode,
 		inode->i_gid = attr->gid;
 }
 
-static void update_gid(struct eventfs_inode *ei, kgid_t gid, int level)
-{
-	struct eventfs_inode *ei_child;
-
-	/* at most we have events/system/event */
-	if (WARN_ON_ONCE(level > 3))
-		return;
-
-	ei->attr.gid = gid;
-
-	if (ei->entry_attrs) {
-		for (int i = 0; i < ei->nr_entries; i++) {
-			ei->entry_attrs[i].gid = gid;
-		}
-	}
-
-	/*
-	 * Only eventfs_inode with dentries are updated, make sure
-	 * all eventfs_inodes are updated. If one of the children
-	 * do not have a dentry, this function must traverse it.
-	 */
-	list_for_each_entry_srcu(ei_child, &ei->children, list,
-				 srcu_read_lock_held(&eventfs_srcu)) {
-		if (!ei_child->dentry)
-			update_gid(ei_child, gid, level + 1);
-	}
-}
-
-void eventfs_update_gid(struct dentry *dentry, kgid_t gid)
-{
-	struct eventfs_inode *ei = dentry->d_fsdata;
-	int idx;
-
-	idx = srcu_read_lock(&eventfs_srcu);
-	update_gid(ei, gid, 0);
-	srcu_read_unlock(&eventfs_srcu, idx);
-}
-
 /**
  * create_file - create a file in the tracefs filesystem
  * @name: the name of the file to create.
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 45397df9bb65..91c2bf0b91d9 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -82,7 +82,6 @@ struct inode *tracefs_get_inode(struct super_block *sb);
 struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
 struct dentry *eventfs_failed_creating(struct dentry *dentry);
 struct dentry *eventfs_end_creating(struct dentry *dentry);
-void eventfs_update_gid(struct dentry *dentry, kgid_t gid);
 void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 46439e3bcec4..b33c3861fbbb 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1470,8 +1470,10 @@ register_snapshot_trigger(char *glob,
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
-	if (tracing_alloc_snapshot_instance(file->tr) != 0)
-		return 0;
+	int ret = tracing_alloc_snapshot_instance(file->tr);
+
+	if (ret < 0)
+		return ret;
 
 	return register_trigger(glob, data, file);
 }

