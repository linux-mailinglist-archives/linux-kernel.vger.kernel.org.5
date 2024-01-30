Return-Path: <linux-kernel+bounces-45249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C744842D93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E114A28972F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03E71B46;
	Tue, 30 Jan 2024 20:17:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75CE69E1E;
	Tue, 30 Jan 2024 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645846; cv=none; b=GYnQWJLTDB/LH/cLaTNtV6yArH1SuBPVnRO9ATvyxrPEwtYLYhbK41mkFpTiTwWmACTlweYf2AljMbSHkvHYW8r/7WYgxqLs0ShCDGQVNg5As86bGJjoSv+T92pWxnYAQbI0Wb6pqeWQkUQ4o5Bg9/5EmQr2CfhBChe1fvqNWpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645846; c=relaxed/simple;
	bh=zdUltoJAz28yULsd7S70/VZtc01SbxyEdOQCLH49gNE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lkAy9EaHe5aJznb//oyUD5VOIoyAuZFWHWDGpdfBwCICMjqf1GicZyzioQH/dsPx2n/bzKv5tctQPOwr27ltyoeOITsFR0XhjuLm+s2FvMiqRjLjgzaDg5XiP4vtTQzRhKtmyvf26HgdW7XOQx9oXWgbBMGDG8da3VPEiOPwKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B67AC433F1;
	Tue, 30 Jan 2024 20:17:25 +0000 (UTC)
Date: Tue, 30 Jan 2024 15:17:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH] tracefs: Zero out the tracefs_inode when allocating it
Message-ID: <20240130151737.6e97ae00@gandalf.local.home>
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
 fs/tracefs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index e1b172c0e091..f7cde61ff2fc 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -34,12 +34,10 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 {
 	struct tracefs_inode *ti;
 
-	ti = kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL);
+	ti = kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL | __GFP_ZERO);
 	if (!ti)
 		return NULL;
 
-	ti->flags = 0;
-
 	return &ti->vfs_inode;
 }
 
-- 
2.43.0


