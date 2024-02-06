Return-Path: <linux-kernel+bounces-54792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2576084B3CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CA41C223C8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7A9134CF7;
	Tue,  6 Feb 2024 11:33:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B136133987;
	Tue,  6 Feb 2024 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219211; cv=none; b=PBJwj2CcHbU3Qsc2uLHuio2wxfLDKOR+bISjr4W6Rlgo9TFYRVjihSvNQPCO9wy/ZSEPPlGuAkTZuzsmaFkCu6AKvOjnqKosHhFZXfpFvBTgtTVFl7pnEkOfiHAqhH9IxQjAO7zva6kHUOaX3eaiZ4zcF4f3rgCR1igS6bocz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219211; c=relaxed/simple;
	bh=JSygnlx6+56lX3XXzthIgsNjw4j5XL26vPR3L/z2tEs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aNHJpennxOWhSmaLTPRnq8Jd5WX9qI7JzeT/ryWz5eDLa7h9pLVmzERqmx6kY8LKI0DYF0BrbvzojNd1VImkrhKE6G/gxVYIcHoWH7wJuGRKbtqm0ycDNBlmQa8NM+ERVCzzWx+Hq26FyUAotuibgIGnxb7TJN4M73Gay3Jdxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEF0C43330;
	Tue,  6 Feb 2024 11:33:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXJiB-00000006aKJ-2Ejb;
	Tue, 06 Feb 2024 06:33:59 -0500
Message-ID: <20240206113359.393228331@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 06:32:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>,
 Al  Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [v6.7][PATCH v2 08/23] eventfs: Have the inodes all for files and directories all be the
 same
References: <20240206113158.822006147@rostedt.homelinux.com>
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
(cherry picked from commit 53c41052ba3121761e6f62a813961164532a214f)
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



