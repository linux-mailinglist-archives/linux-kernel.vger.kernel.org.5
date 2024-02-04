Return-Path: <linux-kernel+bounces-51343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0425B848A04
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E547B24F7A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28218EAD2;
	Sun,  4 Feb 2024 01:18:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C863915E5D4;
	Sun,  4 Feb 2024 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009485; cv=none; b=lqiNP3mVwEcNk4HwjCc9KMb8JlRpDWdgnVLt9qUqh3liyicAov5uZ4rHGkdt/UlUI+QjIHPfkwQMALElAkgc2qqEuVAosLeZzGc1mOC7CFOSc7Iq3SPF+SWhmaQ8TqReM1xfu9cmf6XmntULdFkOoCiEnySJCfncDE6f7W+KpYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009485; c=relaxed/simple;
	bh=+l/2J1wuNvwwox8H/9diOMBy2Vp1lI/iE/4NnUV0Ybw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RCsmJ5UAXhOWayFjOG/76WbNyPadgsJwsvnIhrCP59RiB/lURfveoncOuZMDO7BYYz0PgDhJVikDpZyudCPS4G6nPvSdmH8CXKEnSHKxSwf+eJ/oBphWhIxVmGV7wjD2S9AmFbh3KmCLBC6Zazz/g6AM9Bkn2HrX3BHcjz2v1n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9046C433C7;
	Sun,  4 Feb 2024 01:18:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rWR9Q-00000006OoL-1NNa;
	Sat, 03 Feb 2024 20:18:28 -0500
Message-ID: <20240204011828.189770756@goodmis.org>
User-Agent: quilt/0.67
Date: Sat, 03 Feb 2024 20:16:23 -0500
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
 Al  Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [v6.7][PATCH 08/23] eventfs: Have the inodes all for files and directories all be the
 same
References: <20240204011615.703023949@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The dentries and inodes are created in the readdir for the sole purpose of
getting a consistent inode number. Linus stated that is unnecessary, and
that all inodes can have the same inode number. For a virtual file system
they are pretty meaningless.

Instead use a single unique inode number for all files and one for all
directories.

Link: https://lore.kernel.org/all/20240116133753.2808d45e@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20240116211353.412180363@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al  Viro <viro@ZenIV.linux.org.uk>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index fdff53d5a1f8..5edf0b96758b 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -32,6 +32,10 @@
  */
 static DEFINE_MUTEX(eventfs_mutex);
 
+/* Choose something "unique" ;-) */
+#define EVENTFS_FILE_INODE_INO		0x12c4e37
+#define EVENTFS_DIR_INODE_INO		0x134b2f5
+
 /*
  * The eventfs_inode (ei) itself is protected by SRCU. It is released from
  * its parent's list and will have is_freed set (under eventfs_mutex).
@@ -352,6 +356,9 @@ static struct dentry *create_file(const char *name, umode_t mode,
 	inode->i_fop = fop;
 	inode->i_private = data;
 
+	/* All files will have the same inode number */
+	inode->i_ino = EVENTFS_FILE_INODE_INO;
+
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
 	d_instantiate(dentry, inode);
@@ -388,6 +395,9 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 	inode->i_op = &eventfs_root_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
+	/* All directories will have the same inode number */
+	inode->i_ino = EVENTFS_DIR_INODE_INO;
+
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
 
-- 
2.43.0



