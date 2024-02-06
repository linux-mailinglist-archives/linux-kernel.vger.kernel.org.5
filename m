Return-Path: <linux-kernel+bounces-54899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A28984B4FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC11B284FA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF10513C1D5;
	Tue,  6 Feb 2024 12:09:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4446B137C37;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221362; cv=none; b=TWE1YE9Agu/20iI1ayjN7/64yN0EagVrPbMHQA9AqVnB4EOCv6y2SLjpsaUAk1tFg360tQ+OBnC8clYYG28B7mbNG2dyUMTW0WakE+kU7j6wch3GwMavk9le4nsyxY2rtDWTclR3O4NLBlMH0QMCgV0J7ayOJk396iOsWCUVqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221362; c=relaxed/simple;
	bh=PbQrblDeR9F0JgOw4gGsVCF/2xvBxqNknZ0wT0MnC+M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dnLdyaz2fELQKPO8Sl9lPqwra8UqiB7WvSLTX2tWBS6zhSKwY3Mv9rNDcSY6kOS/PT7RklMXsX7efPiv991nza+n/sACDjswwbrmH+2hxbBzhVvzrspw6UJk4kpU4FEbq2frtHX37P1t+7i2Nj9gvHILYzd9V7P0a54zNxC4I9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A80C433F1;
	Tue,  6 Feb 2024 12:09:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGs-00000006bDL-1mZY;
	Tue, 06 Feb 2024 07:09:50 -0500
Message-ID: <20240206120950.284520771@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [v6.6][PATCH 24/57] eventfs: Remove expectation that ei->is_freed means ei->dentry ==
 NULL
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The logic to free the eventfs_inode (ei) use to set is_freed and clear the
"dentry" field under the eventfs_mutex. But that changed when a race was
found where the ei->dentry needed to be cleared when the last dput() was
called on it. But there was still logic that checked if ei->dentry was not
NULL and is_freed is set, and would warn if it was.

But since that situation was changed and the ei->dentry isn't cleared
until the last dput() is called on it while the ei->is_freed is set, do
not test for that condition anymore, and change the comments to reflect
that.

Link: https://lkml.kernel.org/r/20231120235154.265826243@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 020010fbfa20 ("eventfs: Delete eventfs_inode when the last dentry is freed")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 88903daecacf03b1e5636e1b5f18bda5b07030fc)
---
 fs/tracefs/event_inode.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index f8a594a50ae6..f239b2b507a4 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -27,16 +27,16 @@
 /*
  * eventfs_mutex protects the eventfs_inode (ei) dentry. Any access
  * to the ei->dentry must be done under this mutex and after checking
- * if ei->is_freed is not set. The ei->dentry is released under the
- * mutex at the same time ei->is_freed is set. If ei->is_freed is set
- * then the ei->dentry is invalid.
+ * if ei->is_freed is not set. When ei->is_freed is set, the dentry
+ * is on its way to being freed after the last dput() is made on it.
  */
 static DEFINE_MUTEX(eventfs_mutex);
 
 /*
  * The eventfs_inode (ei) itself is protected by SRCU. It is released from
  * its parent's list and will have is_freed set (under eventfs_mutex).
- * After the SRCU grace period is over, the ei may be freed.
+ * After the SRCU grace period is over and the last dput() is called
+ * the ei is freed.
  */
 DEFINE_STATIC_SRCU(eventfs_srcu);
 
@@ -365,12 +365,14 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 		 * created the dentry for this e_dentry. In which case
 		 * use that one.
 		 *
-		 * Note, with the mutex held, the e_dentry cannot have content
-		 * and the ei->is_freed be true at the same time.
+		 * If ei->is_freed is set, the e_dentry is currently on its
+		 * way to being freed, don't return it. If e_dentry is NULL
+		 * it means it was already freed.
 		 */
-		dentry = *e_dentry;
-		if (WARN_ON_ONCE(dentry && ei->is_freed))
+		if (ei->is_freed)
 			dentry = NULL;
+		else
+			dentry = *e_dentry;
 		/* The lookup does not need to up the dentry refcount */
 		if (dentry && !lookup)
 			dget(dentry);
@@ -473,8 +475,8 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 		 * created the dentry for this e_dentry. In which case
 		 * use that one.
 		 *
-		 * Note, with the mutex held, the e_dentry cannot have content
-		 * and the ei->is_freed be true at the same time.
+		 * If ei->is_freed is set, the e_dentry is currently on its
+		 * way to being freed.
 		 */
 		dentry = ei->dentry;
 		if (dentry && !lookup)
-- 
2.43.0



