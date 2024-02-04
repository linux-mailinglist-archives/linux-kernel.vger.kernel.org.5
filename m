Return-Path: <linux-kernel+bounces-51349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E40A5848A11
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E671C228AC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EA112B9B;
	Sun,  4 Feb 2024 01:18:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9CFB651;
	Sun,  4 Feb 2024 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009487; cv=none; b=T214Iq8Y8ycUi3nZW4CPehSz+olYrgxiedbl4tEyNVqkHc2fg+DGUGq3g9nWx0RcIcGzqPbrP0mg6/zagaUJ6sMZb2KTwaVzitOoHBrYPkPu2XxFK3qE2HGcWf2vh3zRtPzBk71lJkTOBCM8vN6Oea2wlsZL1cXoXjJCqgC42I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009487; c=relaxed/simple;
	bh=RnbwjrjDZZt5dBQ8lSVav9CcZQtdfsC0kXd6oQD/gQw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DEyjiCbAG8wFfMawl4qqd/UAILFK2WYb9CZoLrvH56Cttg4GmoPYdf/wrzqHC2ZENh9URxK9aDZpvULB1VkjQNMCc5O8kW5tH2dugwV1gklUVsYL6YDaSVSMH2SluQFHD0V8QhtBps4wXIhA6ahLvHvP+qd74Ko0NNhB0ByVDu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE90C3279D;
	Sun,  4 Feb 2024 01:18:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rWR9Q-00000006OqM-497i;
	Sat, 03 Feb 2024 20:18:28 -0500
Message-ID: <20240204011828.840729219@goodmis.org>
User-Agent: quilt/0.67
Date: Sat, 03 Feb 2024 20:16:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [v6.7][PATCH 12/23] tracefs: remove stale update_gid code
References: <20240204011615.703023949@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Linus Torvalds <torvalds@linux-foundation.org>

The 'eventfs_update_gid()' function is no longer called, so remove it
(and the helper function it uses).

Link: https://lore.kernel.org/all/CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com/

Fixes: 8186fff7ab64 ("tracefs/eventfs: Use root and instance inodes as default ownership")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 38 --------------------------------------
 fs/tracefs/internal.h    |  1 -
 2 files changed, 39 deletions(-)

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
-- 
2.43.0



