Return-Path: <linux-kernel+bounces-54931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0D784B520
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BAD1C21AC5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC46A1509B7;
	Tue,  6 Feb 2024 12:09:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6531F1353F6;
	Tue,  6 Feb 2024 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221367; cv=none; b=soyWUGiiqs46RukQ4Po+1fluBQRbtz15mVeq7RjJAFTNURX8MOg+cw3kHYamAsSev2ww0uvgkLVaX+dCGvH3SNJHNEmiWR6VeoJHJjPUqvn7skkHT9M9janw00ExNCl7PnsNplBqbAsEdtxL8lIg1EMKERVKbu2BfQ9W6cj8OAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221367; c=relaxed/simple;
	bh=K0Ph34GY80unDV6Wcvz0AavqMJytP5uSNCEE07y3Q00=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=vCmHioN24qOTIxnFGZPSjyWnAXfZ4rW9jaErtt49iJDlLZtLiGMegAz65nefRlxcSJZT5O3BABvtVV6MBbIYGNdr15Lh/ZOd3CdLMkar0v1H4FTEWa/fnX8hnKprAF4DMQbSh2wmS2Tyx8UCHgB/NMMsId1SKzRDzIwQ5JSZoOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B13C433A6;
	Tue,  6 Feb 2024 12:09:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGx-00000006bTp-3PR9;
	Tue, 06 Feb 2024 07:09:55 -0500
Message-ID: <20240206120955.665411833@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:10:02 -0500
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
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Subject: [v6.6][PATCH 57/57] eventfs: Keep all directory links at 1
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The directory link count in eventfs was somewhat bogus. It was only being
updated when a directory child was being looked up and not on creation.

One solution would be to update in get_attr() the link count by iterating
the ei->children list and then adding 2. But that could slow down simple
stat() calls, especially if it's done on all directories in eventfs.

Another solution would be to add a parent pointer to the eventfs_inode
and keep track of the number of sub directories it has on creation. But
this adds overhead for something not really worthwhile.

The solution decided upon is to keep all directory links in eventfs as 1.
This tells user space not to rely on the hard links of directories. Which
in this case it shouldn't.

Link: https://lore.kernel.org/linux-trace-kernel/20240201002719.GS2087318@ZenIV/
Link: https://lore.kernel.org/linux-trace-kernel/20240201161617.339968298@goodmis.org

Cc: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Fixes: c1504e510238 ("eventfs: Implement eventfs dir creation functions")
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit ca185770db914869ff9fe773bac5e0e5e4165b83)
---
 fs/tracefs/event_inode.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 9e031e5a2713..110e8a272189 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -404,9 +404,7 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 
 	dentry->d_fsdata = get_ei(ei);
 
-	inc_nlink(inode);
 	d_add(dentry, inode);
-	inc_nlink(dentry->d_parent->d_inode);
 	return NULL;
 }
 
@@ -769,9 +767,17 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 
 	dentry->d_fsdata = get_ei(ei);
 
-	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inc_nlink(inode);
+	/*
+	 * Keep all eventfs directories with i_nlink == 1.
+	 * Due to the dynamic nature of the dentry creations and not
+	 * wanting to add a pointer to the parent eventfs_inode in the
+	 * eventfs_inode structure, keeping the i_nlink in sync with the
+	 * number of directories would cause too much complexity for
+	 * something not worth much. Keeping directory links at 1
+	 * tells userspace not to trust the link number.
+	 */
 	d_instantiate(dentry, inode);
+	/* The dentry of the "events" parent does keep track though */
 	inc_nlink(dentry->d_parent->d_inode);
 	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
 	tracefs_end_creating(dentry);
-- 
2.43.0



