Return-Path: <linux-kernel+bounces-54809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4694284B3F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793F31C21C70
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C021384A2;
	Tue,  6 Feb 2024 11:33:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9948E1350D0;
	Tue,  6 Feb 2024 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219213; cv=none; b=qlnBMp8+kCeV4V1+Q62WxuIk+YD3hEzqzeHNUg8vPKTIPuTBBaDxJ8WhgqRXgCZd5OYXB5Sf+NnBMFVgCVYhSRM1iYi5uXGZPi6s93COdvfFakPpWBVZiY8+q1JVZ1IqYEB5fyVJJBpUplUtSVmOo6sL3RAOhjAlC1U7so2p/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219213; c=relaxed/simple;
	bh=K0Ph34GY80unDV6Wcvz0AavqMJytP5uSNCEE07y3Q00=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=R+YfVpntuY9rMvHY0L0Mo0ERrA38qXWVQ2UtCgSZFn5ZaDq+feRj6v+R6nGllm5NlVUMobZhhInF04QtlJV9j8EKIg0RJScD9Qu57Sn7UgGCxBhsPrT19491kTAs82UkvNrY5xenfkLCFUqSs5kwDqX53Q4jcp66hPqlIDq8fdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849F1C43141;
	Tue,  6 Feb 2024 11:33:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXJiD-00000006aRp-42bw;
	Tue, 06 Feb 2024 06:34:01 -0500
Message-ID: <20240206113401.818811467@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 06:32:21 -0500
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
Subject: [v6.7][PATCH v2 23/23] eventfs: Keep all directory links at 1
References: <20240206113158.822006147@rostedt.homelinux.com>
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



