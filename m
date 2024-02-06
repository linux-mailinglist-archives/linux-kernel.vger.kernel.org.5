Return-Path: <linux-kernel+bounces-54904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3D084B506
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAE01F207C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A793713E227;
	Tue,  6 Feb 2024 12:09:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AD1384B1;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221363; cv=none; b=ggMc1hE9s3NFUWRBl15kA3ZW65H9sdirQecUcWyGdrwgh48eDy1w98yuPR0UtyA4aTQ6CtSj0IyBTfg9y6lBjZncwA7ES+EAKieVU56ROIDlwuMNcJc+CAwkiPPpx0LkT8XZpUXX+3r7JnkZtcTu4smEGN/h8QgM6WdyTuV2Kks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221363; c=relaxed/simple;
	bh=3SwXKn69jqhTzyrSfRqMAzadq7iwgEqhvz0y/eDGZkM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=We/dMSdZ0RscfLli4/aLeah+CEeqHaI+M/YwDr3HzXhSr/2podkLi87AJR3lOqeNCMrKrSG/Ggm7TrjiOE8AlJxBuBvsJ4gT9yZ9qNl1nVx2t4AJWCTsrmkNEcLj7Zsel0bbdJD+BjNssGDOLq+7AO71OqLys8UX6ZTK30u7xos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9779BC43390;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGt-00000006bFL-0JBS;
	Tue, 06 Feb 2024 07:09:51 -0500
Message-ID: <20240206120950.930155940@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:33 -0500
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
Subject: [v6.6][PATCH 28/57] eventfs: Do not allow NULL parent to eventfs_start_creating()
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The eventfs directory is dynamically created via the meta data supplied by
the existing trace events. All files and directories in eventfs has a
parent. Do not allow NULL to be passed into eventfs_start_creating() as
the parent because that should never happen. Warn if it does.

Link: https://lkml.kernel.org/r/20231121231112.693841807@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit fc4561226feaad5fcdcb55646c348d77b8ee69c5)
---
 fs/tracefs/inode.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 34ffb2f8114e..b9ed8db4f6b9 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -509,20 +509,15 @@ struct dentry *eventfs_start_creating(const char *name, struct dentry *parent)
 	struct dentry *dentry;
 	int error;
 
+	/* Must always have a parent. */
+	if (WARN_ON_ONCE(!parent))
+		return ERR_PTR(-EINVAL);
+
 	error = simple_pin_fs(&trace_fs_type, &tracefs_mount,
 			      &tracefs_mount_count);
 	if (error)
 		return ERR_PTR(error);
 
-	/*
-	 * If the parent is not specified, we create it in the root.
-	 * We need the root dentry to do this, which is in the super
-	 * block. A pointer to that is in the struct vfsmount that we
-	 * have around.
-	 */
-	if (!parent)
-		parent = tracefs_mount->mnt_root;
-
 	if (unlikely(IS_DEADDIR(parent->d_inode)))
 		dentry = ERR_PTR(-ENOENT);
 	else
-- 
2.43.0



