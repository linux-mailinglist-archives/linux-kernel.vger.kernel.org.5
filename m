Return-Path: <linux-kernel+bounces-54799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8067D84B3E8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07363286285
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6875135A47;
	Tue,  6 Feb 2024 11:33:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734F3134747;
	Tue,  6 Feb 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219212; cv=none; b=eKC8slVqQratL83v4LPgSi3VU9YWjZL3/FbHA/9AoBOMAU2EheSZZM/3GwmpwHsQJcSdEh4a/r0WQkGun7e+eAnpsZErHRCFj7BT0VvBl22szAYv6n8yzJP37Rd/S18tRPT08uFx2uIJi4FfGdWBp9Q2kHh+jtRDecobkMnmTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219212; c=relaxed/simple;
	bh=3cuwo8jKNFJ8ZNaRFdtkUgaWTecxRB1l6ECQ5pijtZI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SU0Q4xoQIxmhdVJp55/zreRVBoqnnJypBwuH4v4gzTUpnonPxqnSwR6Gya4JM6vfSBFTLXnkNtrzPejNd9NIEpy6EBf0KcbeIoWAbf6RWOwDOP8tzvaGkj8rsDuzW31019E5Djn+2Uw4C5F3Ei9+4FDfuufb+s5Z9BWECGnaKGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5504C43399;
	Tue,  6 Feb 2024 11:33:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXJiC-00000006aMK-0l4Q;
	Tue, 06 Feb 2024 06:34:00 -0500
Message-ID: <20240206113400.036997635@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 06:32:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [v6.7][PATCH v2 12/23] tracefs: remove stale update_gid code
References: <20240206113158.822006147@rostedt.homelinux.com>
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
(cherry picked from commit 29142dc92c37d3259a33aef15b03e6ee25b0d188)
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



