Return-Path: <linux-kernel+bounces-14795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7E182226C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09DC22847B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9016816401;
	Tue,  2 Jan 2024 20:11:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3517516404;
	Tue,  2 Jan 2024 20:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8F3C433C7;
	Tue,  2 Jan 2024 20:11:48 +0000 (UTC)
Date: Tue, 2 Jan 2024 15:12:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Ubisectech Sirius" <bugreport@ubisectech.com>
Subject: [PATCH v2] tracefs: Check for dentry->d_inode exists in set_gid()
Message-ID: <20240102151249.05da244d@gandalf.local.home>
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

In the subdir loop of the dentry lookup of set_gid(), if a child has a
NULL d_inode, simply skip it.

Link: https://lore.kernel.org/all/20240102135637.3a21fb10@gandalf.local.home/

Cc: stable@vger.kernel.org
Fixes: 7e8358edf503e ("eventfs: Fix file and directory uid and gid ownership")
Reported-by: "Ubisectech Sirius" <bugreport@ubisectech.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240102142311.5670813d@gandalf.local.home

- Simplify the logic to just continue the loop if the cursor dentry is hit.

 fs/tracefs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 62524b20964e..bc86ffdb103b 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -215,6 +215,10 @@ static void set_gid(struct dentry *parent, kgid_t gid)
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
 		next = tmp->next;
 
+		/* Note, getdents() can add a cursor dentry with no inode */
+		if (!dentry->d_inode)
+			continue;
+
 		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
 
 		change_gid(dentry, gid);
-- 
2.42.0


