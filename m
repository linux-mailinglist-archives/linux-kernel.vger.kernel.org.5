Return-Path: <linux-kernel+bounces-165925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 161218B9385
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D1D1C2134F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2401BF38;
	Thu,  2 May 2024 03:00:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F61862F;
	Thu,  2 May 2024 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618808; cv=none; b=GwZCtlMNAVKT55HsQU2lddvxVcTDg1mGWuIiwLg0T9G2hkWY7iRksW/PPx9zGVY7KG5Pt/UL7sGUetqJIIqJI1B6Tm3kP3kXpGhN7GAPx3hG8SMU08KvZPlWs6pIVDGBumiWUu6DbW/ZExl5dyacRcBWxhoCaivYkvoVStHdrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618808; c=relaxed/simple;
	bh=ydI3fYejD4Xls86Gl5fOeRuiZIbVbw1jrCOxj0nEOXY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uQyMfPRxBld2gCipaR0UQC9WnPSVp9/UCsddW5TBgp4oBVHAnssHmaVB2p4Nz+/oqli+Osx1Rp0UXiINk9jem2M0tUWBoYDmwjtZj8+zEZ5iFc+8YiKmEvBcq9+pgtahGePce9cnPDdhjaEYumVUf560/FPuyBS+nXkHcSK5akE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC0FC4AF1D;
	Thu,  2 May 2024 03:00:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s2Mgn-000000039hE-1v62;
	Wed, 01 May 2024 23:00:53 -0400
Message-ID: <20240502030053.317255047@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 01 May 2024 23:00:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH 2/5] tracefs: Still use mount point as default permissions for instances
References: <20240502030024.062275408@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If the instances directory's permissions were never change, then have it
and its children use the mount point permissions as the default.

Currently, the permissions of instance directories are determined by the
instance directory's permissions itself. But if the tracefs file system is
remounted and changes the permissions, the instance directory and its
children should use the new permission.

But because both the instance directory and its children use the instance
directory's inode for permissions, it misses the update.

To demonstrate this:

  # cd /sys/kernel/tracing/
  # mkdir instances/foo
  # ls -ld instances/foo
 drwxr-x--- 5 root root 0 May  1 19:07 instances/foo
  # ls -ld instances
 drwxr-x--- 3 root root 0 May  1 18:57 instances
  # ls -ld current_tracer
 -rw-r----- 1 root root 0 May  1 18:57 current_tracer

  # mount -o remount,gid=1002 .
  # ls -ld instances
 drwxr-x--- 3 root root 0 May  1 18:57 instances
  # ls -ld instances/foo/
 drwxr-x--- 5 root root 0 May  1 19:07 instances/foo/
  # ls -ld current_tracer
 -rw-r----- 1 root lkp 0 May  1 18:57 current_tracer

Notice that changing the group id to that of "lkp" did not affect the
instances directory nor its children. It should have been:

  # ls -ld current_tracer
 -rw-r----- 1 root root 0 May  1 19:19 current_tracer
  # ls -ld instances/foo/
 drwxr-x--- 5 root root 0 May  1 19:25 instances/foo/
  # ls -ld instances
 drwxr-x--- 3 root root 0 May  1 19:19 instances

  # mount -o remount,gid=1002 .
  # ls -ld current_tracer
 -rw-r----- 1 root lkp 0 May  1 19:19 current_tracer
  # ls -ld instances
 drwxr-x--- 3 root lkp 0 May  1 19:19 instances
  # ls -ld instances/foo/
 drwxr-x--- 5 root lkp 0 May  1 19:25 instances/foo/

Where all files were updated by the remount gid update.

Cc: stable@vger.kernel.org
Fixes: 8186fff7ab649 ("tracefs/eventfs: Use root and instance inodes as default ownership")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 2a1dc2b442d1..1130c0fe2426 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -170,16 +170,39 @@ static void set_tracefs_inode_owner(struct inode *inode)
 {
 	struct tracefs_inode *ti = get_tracefs(inode);
 	struct inode *root_inode = ti->private;
+	kuid_t uid;
+	kgid_t gid;
+
+	uid = root_inode->i_uid;
+	gid = root_inode->i_gid;
+
+	/*
+	 * If the root is not the mount point, then check the root's
+	 * permissions. If it was never set, then default to the
+	 * mount point.
+	 */
+	if (root_inode != d_inode(root_inode->i_sb->s_root)) {
+		struct tracefs_inode *rti;
+
+		rti = get_tracefs(root_inode);
+		root_inode = d_inode(root_inode->i_sb->s_root);
+
+		if (!(rti->flags & TRACEFS_UID_PERM_SET))
+			uid = root_inode->i_uid;
+
+		if (!(rti->flags & TRACEFS_GID_PERM_SET))
+			gid = root_inode->i_gid;
+	}
 
 	/*
 	 * If this inode has never been referenced, then update
 	 * the permissions to the superblock.
 	 */
 	if (!(ti->flags & TRACEFS_UID_PERM_SET))
-		inode->i_uid = root_inode->i_uid;
+		inode->i_uid = uid;
 
 	if (!(ti->flags & TRACEFS_GID_PERM_SET))
-		inode->i_gid = root_inode->i_gid;
+		inode->i_gid = gid;
 }
 
 static int tracefs_permission(struct mnt_idmap *idmap,
-- 
2.43.0



