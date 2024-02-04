Return-Path: <linux-kernel+bounces-51355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3C7848A18
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E361C22BAE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735FD17592;
	Sun,  4 Feb 2024 01:18:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA63D272;
	Sun,  4 Feb 2024 01:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009488; cv=none; b=HclpD+3YiRZLIyV0EIrYVsqQfcnMu9xsPNPnT1ewBXPRih/5BNkBxZLfTgTXacJj6X7GEofDsZWCpMhEPEmYVcYccKl5mc8knPkwvRM9NKMZES8UpQ7WgRk/OohfIv2GBWC4oaAx6tZDWzuErU1H/O+soxGHjrZ1j/dMGmONkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009488; c=relaxed/simple;
	bh=VbPnmr5i8jO9pUVUWfcJV065CxA6MC9e4dU/HikVKBs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=h6jEcHs4sRkmcEmXh7+3S5GatTry1TBNv/xADOmfxQH0Mx4oqUCiY+csF4ai95nouFJHYp5aSXiXq1f2mTsmnyoj5h1E6aU8K+0RXmqIEZE0WXMLd0OLF8ldJTBsdqtNNO6VPUqbsTOrZ5uHHmlsh0b1uFL0ovWGOqc6xcSiHIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3BCC32785;
	Sun,  4 Feb 2024 01:18:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rWR9R-00000006OtN-41u8;
	Sat, 03 Feb 2024 20:18:29 -0500
Message-ID: <20240204011829.816275573@goodmis.org>
User-Agent: quilt/0.67
Date: Sat, 03 Feb 2024 20:16:33 -0500
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
Subject: [v6.7][PATCH 18/23] eventfs: Clean up dentry ops and add revalidate function
References: <20240204011615.703023949@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Linus Torvalds <torvalds@linux-foundation.org>

In order for the dentries to stay up-to-date with the eventfs changes,
just add a 'd_revalidate' function that checks the 'is_freed' bit.

Also, clean up the dentry release to actually use d_release() rather
than the slightly odd d_iput() function.  We don't care about the inode,
all we want to do is to get rid of the refcount to the eventfs data
added by dentry->d_fsdata.

It would probably be cleaner to make eventfs its own filesystem, or at
least set its own dentry ops when looking up eventfs files.  But as it
is, only eventfs dentries use d_fsdata, so we don't really need to split
these things up by use.

Another thing that might be worth doing is to make all eventfs lookups
mark their dentries as not worth caching.  We could do that with
d_delete(), but the DCACHE_DONTCACHE flag would likely be even better.

As it is, the dentries are all freeable, but they only tend to get freed
at memory pressure rather than more proactively.  But that's a separate
issue.

Link: https://lore.kernel.org/linux-trace-kernel/202401291043.e62e89dc-oliver.sang@intel.com/
Link: https://lore.kernel.org/linux-trace-kernel/20240131185513.124644253@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: c1504e510238 ("eventfs: Implement eventfs dir creation functions")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c |  5 ++---
 fs/tracefs/inode.c       | 27 ++++++++++++++++++---------
 fs/tracefs/internal.h    |  3 ++-
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 16ca8d9759b1..b2285d5f3fed 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -378,13 +378,12 @@ static void free_ei(struct eventfs_inode *ei)
 }
 
 /**
- * eventfs_set_ei_status_free - remove the dentry reference from an eventfs_inode
- * @ti: the tracefs_inode of the dentry
+ * eventfs_d_release - dentry is going away
  * @dentry: dentry which has the reference to remove.
  *
  * Remove the association between a dentry from an eventfs_inode.
  */
-void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
+void eventfs_d_release(struct dentry *dentry)
 {
 	struct eventfs_inode *ei;
 	int i;
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 5c84460feeeb..d65ffad4c327 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -377,21 +377,30 @@ static const struct super_operations tracefs_super_operations = {
 	.show_options	= tracefs_show_options,
 };
 
-static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
+/*
+ * It would be cleaner if eventfs had its own dentry ops.
+ *
+ * Note that d_revalidate is called potentially under RCU,
+ * so it can't take the eventfs mutex etc. It's fine - if
+ * we open a file just as it's marked dead, things will
+ * still work just fine, and just see the old stale case.
+ */
+static void tracefs_d_release(struct dentry *dentry)
 {
-	struct tracefs_inode *ti;
+	if (dentry->d_fsdata)
+		eventfs_d_release(dentry);
+}
 
-	if (!dentry || !inode)
-		return;
+static int tracefs_d_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	struct eventfs_inode *ei = dentry->d_fsdata;
 
-	ti = get_tracefs(inode);
-	if (ti && ti->flags & TRACEFS_EVENT_INODE)
-		eventfs_set_ei_status_free(ti, dentry);
-	iput(inode);
+	return !(ei && ei->is_freed);
 }
 
 static const struct dentry_operations tracefs_dentry_operations = {
-	.d_iput = tracefs_dentry_iput,
+	.d_revalidate = tracefs_d_revalidate,
+	.d_release = tracefs_d_release,
 };
 
 static int trace_fill_super(struct super_block *sb, void *data, int silent)
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 932733a2696a..4b50a0668055 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -78,6 +78,7 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
 struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
-void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry);
+
+void eventfs_d_release(struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */
-- 
2.43.0



