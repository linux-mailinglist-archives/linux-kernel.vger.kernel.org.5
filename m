Return-Path: <linux-kernel+bounces-45257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F2D842DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBD928A329
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3ED71B4C;
	Tue, 30 Jan 2024 20:25:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943669E14;
	Tue, 30 Jan 2024 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646357; cv=none; b=HQ89lYCHTtbGYVt1BDDeANMmYm4BuBUEMD7QLnIUr45ffPvrChG5EZ7UOtEncwz2fnQfMQKRuHi2lE4Ffu78eQxkRBmIqn62dmrAhRGAH/ZqquhRmExZqxBuNlmGZjvnjTTMLgIB6C/Mwiyu4YGtI//P9iWqUransBtuYXzRDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646357; c=relaxed/simple;
	bh=je2CByjKT1BRcxYLvvVwO24vrSwpwb2pzoNMj9oDxZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=d674S6zcnkhoLQg9sXB3uN6/DVEiMDPQRgPQtiRLzA0Jryp0Aa2LOgqs4TJQUeb7uQekF+lcIomZ4avQM8USKg/uMtJj6JPIbXuyEKHuNnjZ1NhgJm9Lkpz6eA6CyvOOMyzsi/nhrx++pg1oLPbP51iKXpWABOoH8xv/UwSMA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D9CC433F1;
	Tue, 30 Jan 2024 20:25:56 +0000 (UTC)
Date: Tue, 30 Jan 2024 15:26:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH v2] eventfs: Initialize the tracefs inode properly
Message-ID: <20240130152608.6109e7b0@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Linus Torvalds <torvalds@linux-foundation.org>

The tracefs-specific fields in the inode were not initialized before the
inode was exposed to others through the dentry with 'd_instantiate()'.

Move the field initializations up to before the d_instantiate.

Cc: stable@vger.kernel.org
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401291043.e62e89dc-oliver.sang@intel.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240130190355.11486-2-torvalds@linux-foundation.org

- Since another patch zeroed out the entire tracefs_inode, there's no need
  to initialize any of its fields to NULL.
  (see https://lore.kernel.org/linux-trace-kernel/20240130151737.6e97ae00@gandalf.local.home/)

 fs/tracefs/event_inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 1c3dd0ad4660..824b1811e342 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -370,6 +370,8 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
+	/* Only directories have ti->private set to an ei, not files */
+	ti->private = ei;
 
 	inc_nlink(inode);
 	d_instantiate(dentry, inode);
@@ -515,7 +517,6 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 static void eventfs_post_create_dir(struct eventfs_inode *ei)
 {
 	struct eventfs_inode *ei_child;
-	struct tracefs_inode *ti;
 
 	lockdep_assert_held(&eventfs_mutex);
 
@@ -525,9 +526,6 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
 				 srcu_read_lock_held(&eventfs_srcu)) {
 		ei_child->d_parent = ei->dentry;
 	}
-
-	ti = get_tracefs(ei->dentry->d_inode);
-	ti->private = ei;
 }
 
 /**
-- 
2.43.0


