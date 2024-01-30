Return-Path: <linux-kernel+bounces-45159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCDE842C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1AA1C24875
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBF078B62;
	Tue, 30 Jan 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wGjmvTEi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3977995D;
	Tue, 30 Jan 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641464; cv=none; b=o0B7DM++OveallHu48BMF14JVDcFOYVD4rYR+55EMSDg4qZSCBrzp+5WqCXxV8z3ZSIn4PMKtc80fIgd4RIg5JRcbme86sITk8pkUp/YIt9KJB2pY6thmu8AxYbQxgnjrl4lJ/8xww29JUVlH/Fp3uoUUF1vOVXXlS2KU7f2n9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641464; c=relaxed/simple;
	bh=uW+OU0rYpytIA1AFMT3QHS+mJXzgQjvRvaoJkHkudIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjfluNwvKJDeD+m5VhlIkZIEqsV8mNomNZQlOqihH2wEG2Kp5663Id0pk/IxGyApLEQXzK/aKJ928l4645gHN0ur7dDJ9YmgemH0E5u0kjQHl+dQT/lRZKfcxQIBXUtGIwDYRq1iY4dhYpUONa2+zCaojXNKmzwVRQIxNUz/itw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wGjmvTEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91369C43399;
	Tue, 30 Jan 2024 19:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706641463;
	bh=uW+OU0rYpytIA1AFMT3QHS+mJXzgQjvRvaoJkHkudIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wGjmvTEiT7sEcOAeBTVz3vAxOPiWnLBmpzpTnw7l8nUEO5LLLIbDIWjK6IaFdeOU4
	 Fkw4pWkwCYXU+aJqTOdxCzGuWtI+ab9/xRDcPLzv9FA7ZJzGJUlVoTC/GLbo2EXcGM
	 S6VRjgiALRhRcIhP+0JXRRnUDEZkBplONVjBTeA0=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6/6] eventfs: clean up dentry ops and add revalidate function
Date: Tue, 30 Jan 2024 11:03:55 -0800
Message-ID: <20240130190355.11486-6-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.43.0.5.g38fb137bdb
In-Reply-To: <20240130190355.11486-1-torvalds@linux-foundation.org>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/tracefs/event_inode.c | 21 +++++----------------
 fs/tracefs/inode.c       | 27 ++++++++++++++++++---------
 fs/tracefs/internal.h    |  3 ++-
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a37db0dac302..acdc797bd9c0 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -414,23 +414,14 @@ static inline struct eventfs_inode *alloc_ei(const char *name)
 
 
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
-	struct eventfs_inode *ei;
-
-	mutex_lock(&eventfs_mutex);
-	ei = dentry->d_fsdata;
-	if (ei) {
-		dentry->d_fsdata = NULL;
-		put_ei(ei);
-	}
-	mutex_unlock(&eventfs_mutex);
+	put_ei(dentry->d_fsdata);
 }
 
 /**
@@ -517,9 +508,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	}
 
  enoent:
-	/* Nothing found? */
-	d_add(dentry, NULL);
-	result = NULL;
+	/* Don't cache negative lookups, just return an error */
+	result = ERR_PTR(-ENOENT);
 
  out:
 	mutex_unlock(&eventfs_mutex);
@@ -857,6 +847,5 @@ void eventfs_remove_events_dir(struct eventfs_inode *ei)
 	 * sticks around while the other ei->dentry are created
 	 * and destroyed dynamically.
 	 */
-	simple_recursive_removal(dentry, NULL);
 	dput(dentry);
 }
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index e1b172c0e091..64122787e5d0 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -379,21 +379,30 @@ static const struct super_operations tracefs_super_operations = {
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
index 72db3bdc4dfb..d4194466b643 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -79,6 +79,7 @@ struct inode *tracefs_get_inode(struct super_block *sb);
 struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
 struct dentry *eventfs_failed_creating(struct dentry *dentry);
 struct dentry *eventfs_end_creating(struct dentry *dentry);
-void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry);
+
+void eventfs_d_release(struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */
-- 
2.43.0.5.g38fb137bdb


