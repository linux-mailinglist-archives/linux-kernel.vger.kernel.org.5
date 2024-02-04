Return-Path: <linux-kernel+bounces-51346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64E5848A0D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10BAFB25302
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839BC111B7;
	Sun,  4 Feb 2024 01:18:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B6E5660;
	Sun,  4 Feb 2024 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009486; cv=none; b=XIOFKkvJAJozx0jkBmDoOyq+zdrB0Mkj/M+KS6+uJslKLv/bdbUyFJGEab4hsUqU2CKNtCDiYf/79EXNIUsrzmcKjksYbePHYVbkPrqdyo8rXlpv8sftbsjkKQGTES5CFJRBlzB7wZdGJpUqNfle1j/6Xhar9fx/exD4Fxm6cYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009486; c=relaxed/simple;
	bh=/JpS99lNgHIlmUQoiQN2u6X1Nyd8YU3yIhcsAIJ1oQc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pyZwXklrAueG4tjuwnfkUCYcnuXU1RV23o2R2fDk8+mpddGSPomXhqXwt9h4M7arnMWcybY3SIHu1BS+suM5ZK9pvk0ddjCF4uQ+ivbD8CheI7DxX1aBCien4k12KSoBpWgLs7TZ3agxzXOvTgarNDm6Wlt18dM6OCsZY/InpvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B658C32789;
	Sun,  4 Feb 2024 01:18:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rWR9Q-00000006Onr-0hp8;
	Sat, 03 Feb 2024 20:18:28 -0500
Message-ID: <20240204011828.022360802@goodmis.org>
User-Agent: quilt/0.67
Date: Sat, 03 Feb 2024 20:16:22 -0500
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
 Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Subject: [v6.7][PATCH 07/23] eventfs: Shortcut eventfs_iterate() by skipping entries already read
References: <20240204011615.703023949@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

As the ei->entries array is fixed for the duration of the eventfs_inode,
it can be used to skip over already read entries in eventfs_iterate().

That is, if ctx->pos is greater than zero, there's no reason in doing the
loop across the ei->entries array for the entries less than ctx->pos.
Instead, start the lookup of the entries at the current ctx->pos.

Link: https://lore.kernel.org/all/CAHk-=wiKwDUDv3+jCsv-uacDcHDVTYsXtBR9=6sGM5mqX+DhOg@mail.gmail.com/
Link: https://lore.kernel.org/linux-trace-kernel/20240104220048.494956957@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a1934e0eea3b..fdff53d5a1f8 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -746,21 +746,15 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	if (!ei || !ei_dentry)
 		goto out;
 
-	ret = 0;
-
 	/*
 	 * Need to create the dentries and inodes to have a consistent
 	 * inode number.
 	 */
-	for (i = 0; i < ei->nr_entries; i++) {
-		void *cdata = ei->data;
-
-		if (c > 0) {
-			c--;
-			continue;
-		}
+	ret = 0;
 
-		ctx->pos++;
+	/* Start at 'c' to jump over already read entries */
+	for (i = c; i < ei->nr_entries; i++, ctx->pos++) {
+		void *cdata = ei->data;
 
 		entry = &ei->entries[i];
 		name = entry->name;
@@ -769,7 +763,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		/* If ei->is_freed then just bail here, nothing more to do */
 		if (ei->is_freed) {
 			mutex_unlock(&eventfs_mutex);
-			goto out_dec;
+			goto out;
 		}
 		r = entry->callback(name, &mode, &cdata, &fops);
 		mutex_unlock(&eventfs_mutex);
@@ -778,14 +772,17 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		dentry = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
 		if (!dentry)
-			goto out_dec;
+			goto out;
 		ino = dentry->d_inode->i_ino;
 		dput(dentry);
 
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
-			goto out_dec;
+			goto out;
 	}
 
+	/* Subtract the skipped entries above */
+	c -= min((unsigned int)c, (unsigned int)ei->nr_entries);
+
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
 
-- 
2.43.0



