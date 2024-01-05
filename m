Return-Path: <linux-kernel+bounces-18162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E95F825990
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07E12857B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8353529D;
	Fri,  5 Jan 2024 18:00:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE8834CEA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA708C433CD;
	Fri,  5 Jan 2024 18:00:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rLoVT-000000012Vt-1Y3M;
	Fri, 05 Jan 2024 13:01:19 -0500
Message-ID: <20240105180119.231810370@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 05 Jan 2024 13:00:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [for-next][PATCH 3/4] eventfs: Read ei->entries before ei->children in eventfs_iterate()
References: <20240105180051.741934288@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In order to apply a shortcut to skip over the current ctx->pos
immediately, by using the ei->entries array, the reading of that array
should be first. Moving the array reading before the linked list reading
will make the shortcut change diff nicer to read.

Link: https://lore.kernel.org/all/CAHk-=wiKwDUDv3+jCsv-uacDcHDVTYsXtBR9=6sGM5mqX+DhOg@mail.gmail.com/
Link: https://lore.kernel.org/linux-trace-kernel/20240104220048.333115095@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 46 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index c73fb1f7ddbc..a1934e0eea3b 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -752,8 +752,8 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	 * Need to create the dentries and inodes to have a consistent
 	 * inode number.
 	 */
-	list_for_each_entry_srcu(ei_child, &ei->children, list,
-				 srcu_read_lock_held(&eventfs_srcu)) {
+	for (i = 0; i < ei->nr_entries; i++) {
+		void *cdata = ei->data;
 
 		if (c > 0) {
 			c--;
@@ -762,23 +762,32 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		ctx->pos++;
 
-		if (ei_child->is_freed)
-			continue;
+		entry = &ei->entries[i];
+		name = entry->name;
 
-		name = ei_child->name;
+		mutex_lock(&eventfs_mutex);
+		/* If ei->is_freed then just bail here, nothing more to do */
+		if (ei->is_freed) {
+			mutex_unlock(&eventfs_mutex);
+			goto out_dec;
+		}
+		r = entry->callback(name, &mode, &cdata, &fops);
+		mutex_unlock(&eventfs_mutex);
+		if (r <= 0)
+			continue;
 
-		dentry = create_dir_dentry(ei, ei_child, ei_dentry);
+		dentry = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
 		if (!dentry)
 			goto out_dec;
 		ino = dentry->d_inode->i_ino;
 		dput(dentry);
 
-		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
+		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
 			goto out_dec;
 	}
 
-	for (i = 0; i < ei->nr_entries; i++) {
-		void *cdata = ei->data;
+	list_for_each_entry_srcu(ei_child, &ei->children, list,
+				 srcu_read_lock_held(&eventfs_srcu)) {
 
 		if (c > 0) {
 			c--;
@@ -787,27 +796,18 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		ctx->pos++;
 
-		entry = &ei->entries[i];
-		name = entry->name;
-
-		mutex_lock(&eventfs_mutex);
-		/* If ei->is_freed then just bail here, nothing more to do */
-		if (ei->is_freed) {
-			mutex_unlock(&eventfs_mutex);
-			goto out_dec;
-		}
-		r = entry->callback(name, &mode, &cdata, &fops);
-		mutex_unlock(&eventfs_mutex);
-		if (r <= 0)
+		if (ei_child->is_freed)
 			continue;
 
-		dentry = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
+		name = ei_child->name;
+
+		dentry = create_dir_dentry(ei, ei_child, ei_dentry);
 		if (!dentry)
 			goto out_dec;
 		ino = dentry->d_inode->i_ino;
 		dput(dentry);
 
-		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
+		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
 			goto out_dec;
 	}
 	ret = 1;
-- 
2.42.0



