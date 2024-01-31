Return-Path: <linux-kernel+bounces-45730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E3A8434B9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF5A1F24DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3093F16426;
	Wed, 31 Jan 2024 04:06:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC02D14A92;
	Wed, 31 Jan 2024 04:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706673960; cv=none; b=tmoRJdDH/nbNWZdPCR6UCE8Ga2ZV72fGl0/KI1s+mwvgn7vjNj7ZzddWp6KzjsDAHjr/DohxKkpS6mBPjIgTj2nZIXb6T7Ywg7Ceg6fkLJrd9Ps/6kkXNO7Onky3W24NHiR/wG9niHOqo8dT/Wp5UUupGqqrgaf47QRu5WnCwOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706673960; c=relaxed/simple;
	bh=E3NIQxoA8SMIzX9BXY7UqTvrppGF6a/PTIVPf1MjfcA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ejUotKHDzaT4vfHA1AnNBwwRJT0xNu3TJXTV9/b/TC74kF6G9jaS0HKWAIxr9MGL0XpR/kGEkJTBG18LzG70y/+w1VHdckXXmOyKOzjGUYfp/5XgI90Fe148xEl94hH9+uNb48LWm/yJCVxkaI6mCIZTNg/LXe4mz/Nda9Z9BW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7553BC43399;
	Wed, 31 Jan 2024 04:05:59 +0000 (UTC)
Date: Tue, 30 Jan 2024 23:06:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro
 <viro@ZenIV.linux.org.uk>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracefs: Zero out the tracefs_inode when allocating it
Message-ID: <20240130230612.377a1933@gandalf.local.home>
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

eventfs uses the tracefs_inode and assumes that it's already initialized
to zero. That is, it doesn't set fields to zero (like ti->private) after
getting its tracefs_inode. This causes bugs due to stale values.

Just initialize the entire structure to zero on allocation so there isn't
any more surprises.

This is a partial fix for accessing ti->private. The assignment still needs
to be made before the dentry is instantiated.

Cc: stable@vger.kernel.org
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401291043.e62e89dc-oliver.sang@intel.com
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/all/20240130151737.6e97ae00@gandalf.local.home/

- I didn't realize the slab had a constructor which prohibits __GFP_ZERO.
  Just use memset() in the constructor. I noticed the WARN_ON_ONCE
  that was triggering early in the boot process.

 fs/tracefs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index e1b172c0e091..636180d45c62 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -38,8 +38,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 	if (!ti)
 		return NULL;
 
-	ti->flags = 0;
-
 	return &ti->vfs_inode;
 }
 
@@ -779,6 +777,7 @@ static void init_once(void *foo)
 {
 	struct tracefs_inode *ti = (struct tracefs_inode *) foo;
 
+	memset(ti, 0, sizeof(*ti));
 	inode_init_once(&ti->vfs_inode);
 }
 
-- 
2.43.0


