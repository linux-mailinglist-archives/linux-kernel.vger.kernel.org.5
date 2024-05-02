Return-Path: <linux-kernel+bounces-166887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF33E8BA15F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF5AB2117F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF99181B99;
	Thu,  2 May 2024 20:08:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71AD17BB1E;
	Thu,  2 May 2024 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680498; cv=none; b=hfJcOjyg2QBMjGK3ay89ktGf2bnbC6IPpckFof/IhYPrYfAQUEw+Py56QLr1NfLO66t1HQChUm0i/3P3jE433HIzZhi/d5S9uxyzgY+DAqsOFdSZ/6uz+WQEDa27Chrd3xHwygQhdHzolPZytFVaWOdoRVD46ouy0uecmzl4RVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680498; c=relaxed/simple;
	bh=BXI70jCOvD7RTkM+sMCT2dixj7pb508M6+wCZOAh60A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=icZkx84PBMuFiAfeqMKq1/AWdQ/HcL1i8SdwrEdIlghiSQIGHLjck9tLJktswaDy0sFliRBlPlu4lph3gmDEuG1B02EtKNvbo9hJDCltkFz9fH+bSJY9+f7glu+N3DSaNCO/+6CqayPyaCZSiFzp1/ZIwK27a3QHSw4EGxFFtj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A37C4AF48;
	Thu,  2 May 2024 20:08:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s2cjp-00000003M4i-3Spy;
	Thu, 02 May 2024 16:09:05 -0400
Message-ID: <20240502200905.686838327@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 02 May 2024 16:08:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH v3 3/6] tracefs: Still use mount point as default permissions for instances
References: <20240502200821.125580570@goodmis.org>
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



