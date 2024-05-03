Return-Path: <linux-kernel+bounces-168382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC44D8BB7C9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9257F1F23947
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5A212E1C4;
	Fri,  3 May 2024 22:50:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566CB84DE3;
	Fri,  3 May 2024 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776635; cv=none; b=VBMF4Gwk0IP+U6Jb2UsE7sGmi+LTVCp8dBlVJ5zS9W1KzyqGJEcGqpI6F72tbRznCQ9N1Y5ybWYcGVAz4+WPgo7Q9XAZjUDVdQQTc0RWankFBYqTo6glKANJzUY/HdLKKgENyFhb277G+HWPSOiHBGHlFQl7BVXvHCZsARKcdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776635; c=relaxed/simple;
	bh=bpSCd43Ut+OwXKlls62ARJc+HkCi55QJAuqfOmnNK+E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QRhIj9EhSj3LDqcqgF0+F3kq2MfaU4swNRaEbX56+HWm5RJlwtcLxAO17u8G7PqoglV7sAQoUaMAT/AucWukXQ6+5NYL3QJBfm6UkB7sh/Y41h5ENY3gXH/JVbef35WjnZ4CU9shnuZejlswA45m/lGtNRnzeuyAOtRe2jAAmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10411C4AF50;
	Fri,  3 May 2024 22:50:35 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s31je-00000000NMZ-2G6X;
	Fri, 03 May 2024 18:50:34 -0400
Message-ID: <20240503225034.399142991@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 03 May 2024 18:50:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 6/9] tracefs: Still use mount point as default permissions for instances
References: <20240503225013.519028385@goodmis.org>
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

Link: https://lore.kernel.org/linux-trace-kernel/20240502200905.686838327@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 8186fff7ab649 ("tracefs/eventfs: Use root and instance inodes as default ownership")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 52aa14bd2994..417c840e6403 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -180,16 +180,39 @@ static void set_tracefs_inode_owner(struct inode *inode)
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



