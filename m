Return-Path: <linux-kernel+bounces-54801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F5184B3EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5709CB2295A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE62713666C;
	Tue,  6 Feb 2024 11:33:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359113474A;
	Tue,  6 Feb 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219212; cv=none; b=qYY6gV65qVnQtVLBYAmRc72mjzKIbSadKF5G6pSpsbbrKJDXtFEqoKMcDT1kDhtUodc6yD+g5HbtO6vrGRShIsCeWUSgBvqFJBq2Xj6dXdS5BCv8gs1E6sl17J2Y/Gefpd8tlsPhCjZGF+yWUOiEzrFCkgz4ODD+DNKS+BOJd1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219212; c=relaxed/simple;
	bh=/K/tqg9istqeXtA6KzMmoqfKg3qYs4d2GHKRR+nK7sY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BaFmHSQJ6VY/N0eyuH+Py26guINifwbzU3PawqeZZRlMW0K4ZiuId53M1Rkh2BTDy6CcszPRqzq3Xr9yVWdoy5VLjYaHll7EGljpv7YlmCCSQeIoBm9ObXj2mRPwG8sYhhwhyAuKVHINzaN3x29Mj41Mz6kE9++NIej/R9EYhKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134D1C3277D;
	Tue,  6 Feb 2024 11:33:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXJiC-00000006aNJ-27Hk;
	Tue, 06 Feb 2024 06:34:00 -0500
Message-ID: <20240206113400.362338010@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 06:32:12 -0500
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
 kernel test robot <oliver.sang@intel.com>
Subject: [v6.7][PATCH v2 14/23] eventfs: Initialize the tracefs inode properly
References: <20240206113158.822006147@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Linus Torvalds <torvalds@linux-foundation.org>

The tracefs-specific fields in the inode were not initialized before the
inode was exposed to others through the dentry with 'd_instantiate()'.

Move the field initializations up to before the d_instantiate.

Link: https://lore.kernel.org/linux-trace-kernel/20240131185512.478449628@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401291043.e62e89dc-oliver.sang@intel.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 4fa4b010b83fb2f837b5ef79e38072a79e96e4f1)
---
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



