Return-Path: <linux-kernel+bounces-54902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9BB84B501
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EC61C23FB3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF2513C1F4;
	Tue,  6 Feb 2024 12:09:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D30138483;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221362; cv=none; b=pOGe1UM4ahG09RGS38FXETeyaJfKRLtCTWeOfC2BI7W78NmaZ9l3n/ocW6OpGp9GVv21WA/EgNhi9R+dkZbkxw9OAkOzCQCysoAZxhZcyYHDwzYQ/3AYkbPZrP2nWd0jJywU8mD25APcPbDY57dySxl3EaJ+yyvlG2tZQIrc6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221362; c=relaxed/simple;
	bh=KWJDRqmuSA25gha7hUXBxRETKbAFvLCSdo+JgHjFgUw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jd39vp9jKzcOLS384JbeVi1YImJkEvvmaWPDGLiEu9/uYdfxHIeAUQRItr56obtqxPA2reO6KYUrTc9Xkhrbl/jPLuzfYSO1ec3+cddrFCZ7LcUB8qPi49cXKtdVOUpXTFD3jven1Ak+3xF5V1mFDebLRK4jlo+kh7w/j6+ZbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754BBC433F1;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGs-00000006bEq-3oIR;
	Tue, 06 Feb 2024 07:09:50 -0500
Message-ID: <20240206120950.772179769@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:32 -0500
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
 Josef Bacik <josef@toxicpanda.com>
Subject: [v6.6][PATCH 27/57] eventfs: Move taking of inode_lock into dcache_dir_open_wrapper()
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The both create_file_dentry() and create_dir_dentry() takes a boolean
parameter "lookup", as on lookup the inode_lock should already be taken,
but for dcache_dir_open_wrapper() it is not taken.

There's no reason that the dcache_dir_open_wrapper() can't take the
inode_lock before calling these functions. In fact, it's better if it
does, as the lock can be held throughout both directory and file
creations.

This also simplifies the code, and possibly prevents unexpected race
conditions when the lock is released.

Link: https://lkml.kernel.org/r/20231121231112.528544825@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit bcae32c5632fc0a0dbce46fa731cd23403117e66)
---
 fs/tracefs/event_inode.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 56d192f0ead8..590e8176449b 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -347,15 +347,8 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 
 	mutex_unlock(&eventfs_mutex);
 
-	/* The lookup already has the parent->d_inode locked */
-	if (!lookup)
-		inode_lock(parent->d_inode);
-
 	dentry = create_file(name, mode, attr, parent, data, fops);
 
-	if (!lookup)
-		inode_unlock(parent->d_inode);
-
 	mutex_lock(&eventfs_mutex);
 
 	if (IS_ERR_OR_NULL(dentry)) {
@@ -453,15 +446,8 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 	}
 	mutex_unlock(&eventfs_mutex);
 
-	/* The lookup already has the parent->d_inode locked */
-	if (!lookup)
-		inode_lock(parent->d_inode);
-
 	dentry = create_dir(ei, parent);
 
-	if (!lookup)
-		inode_unlock(parent->d_inode);
-
 	mutex_lock(&eventfs_mutex);
 
 	if (IS_ERR_OR_NULL(dentry) && !ei->is_freed) {
@@ -693,6 +679,7 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
+	inode_lock(parent->d_inode);
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
 		d = create_dir_dentry(ei, ei_child, parent, false);
@@ -725,6 +712,7 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 			cnt++;
 		}
 	}
+	inode_unlock(parent->d_inode);
 	srcu_read_unlock(&eventfs_srcu, idx);
 	ret = dcache_dir_open(inode, file);
 
-- 
2.43.0



