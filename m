Return-Path: <linux-kernel+bounces-54908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A2E84B508
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B34F1C22E0F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BF6140765;
	Tue,  6 Feb 2024 12:09:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ADF1386DD;
	Tue,  6 Feb 2024 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221363; cv=none; b=exv13tten1F/yXmIzNi6zOU0f/JDQw+bXw9z5QKSSiaQjSGXO+Sx8LQOEYSbX3SMAlGdgKm3km3f0n0kEGuND/fykv5Cip35DZE+LR9bXIRfo66U0CtzsfDbBZXKfatbxPIlhoHxIPC3tH7PPdlxz84XkbuKxn+Cn2a1KOL30BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221363; c=relaxed/simple;
	bh=uCRKBFI8oZi6Z1Cps+YjkEugAUzD0pvOcGwAbYn4DiE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qXo+yvNaZXZlfi6rEv0QYuVHh/oi1zXrJZ4xiiGI1sWkZX0i1RiRJieTJAzjQ449o4eSOTU++ox0EaINzewYKNwMWQQ/vym/x8snUAxU5XczQhcMhBG1sAXNtk8E1gvprywFyzq5K3iHdw3+OasS72MMbILKHE6xnt3tAoJvK00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A2AC433C7;
	Tue,  6 Feb 2024 12:09:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGt-00000006bHq-3giE;
	Tue, 06 Feb 2024 07:09:51 -0500
Message-ID: <20240206120951.738927603@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Ubisectech Sirius" <bugreport@ubisectech.com>
Subject: [v6.6][PATCH 33/57] tracefs: Check for dentry->d_inode exists in set_gid()
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
Link: https://lore.kernel.org/linux-trace-kernel/20240102151249.05da244d@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 7e8358edf503e ("eventfs: Fix file and directory uid and gid ownership")
Reported-by: "Ubisectech Sirius" <bugreport@ubisectech.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit ad579864637af46447208254719943179b69d41a)
---
 fs/tracefs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 7b0ba379d6d7..c27b0cfff70c 100644
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
2.43.0



