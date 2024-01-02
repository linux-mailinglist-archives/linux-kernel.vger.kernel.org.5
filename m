Return-Path: <linux-kernel+bounces-14765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C63B88221EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F561F22A15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0095A15AF9;
	Tue,  2 Jan 2024 19:22:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9617015AD4;
	Tue,  2 Jan 2024 19:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4862CC433C8;
	Tue,  2 Jan 2024 19:22:10 +0000 (UTC)
Date: Tue, 2 Jan 2024 14:23:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Ubisectech Sirius" <bugreport@ubisectech.com>
Subject: [PATCH] tracefs: Check for dentry->d_inode exists in set_gid()
Message-ID: <20240102142311.5670813d@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If a getdents() is called on the tracefs directory but does not get all
the files, it can leave a "cursor" dentry in the d_subdirs list of tracefs
dentry. This cursor dentry does not have a d_inode for it. Before
referencing tracefs_inode from the dentry, the d_inode must first be
checked if it has content. If not, then it's not a tracefs_inode and can
be ignored.

The following caused a crash:

 #define getdents64(fd, dirp, count) syscall(SYS_getdents64, fd, dirp, count)
 #define BUF_SIZE 256
 #define TDIR "/tmp/file0"

 int main(void)
 {
	char buf[BUF_SIZE];
	int fd;
       	int n;

       	mkdir(TDIR, 0777);
	mount(NULL, TDIR, "tracefs", 0, NULL);
       	fd = openat(AT_FDCWD, TDIR, O_RDONLY);
       	n = getdents64(fd, buf, BUF_SIZE);
       	ret = mount(NULL, TDIR, NULL, MS_NOSUID|MS_REMOUNT|MS_RELATIME|MS_LAZYTIME,
		    "gid=1000");
	return 0;
 }

That's because the 256 BUF_SIZE was not big enough to read all the
dentries of the tracefs file system and it left a "cursor" dentry in the
subdirs of the tracefs root inode. Then on remounting with "gid=1000",
it would cause an iteration of all dentries which hit:

	ti = get_tracefs(dentry->d_inode);
	if (ti && (ti->flags & TRACEFS_EVENT_INODE))
		eventfs_update_gid(dentry, gid);

Which crashed because of the dereference of the cursor dentry which had a NULL
d_inode.

Link: https://lore.kernel.org/all/20240102135637.3a21fb10@gandalf.local.home/

Cc: stable@vger.kernel.org
Fixes: 7e8358edf503e ("eventfs: Fix file and directory uid and gid ownership")
Reported-by: "Ubisectech Sirius" <bugreport@ubisectech.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 62524b20964e..c29387a36bc8 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -219,10 +219,13 @@ static void set_gid(struct dentry *parent, kgid_t gid)
 
 		change_gid(dentry, gid);
 
-		/* If this is the events directory, update that too */
-		ti = get_tracefs(dentry->d_inode);
-		if (ti && (ti->flags & TRACEFS_EVENT_INODE))
-			eventfs_update_gid(dentry, gid);
+		/* Note, getdents() can add a cursor dentry with no inode */
+		if (dentry->d_inode) {
+			/* If this is the events directory, update that too */
+			ti = get_tracefs(dentry->d_inode);
+			if (ti && (ti->flags & TRACEFS_EVENT_INODE))
+				eventfs_update_gid(dentry, gid);
+		}
 
 		if (!list_empty(&dentry->d_subdirs)) {
 			spin_unlock(&this_parent->d_lock);
-- 
2.42.0


