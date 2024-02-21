Return-Path: <linux-kernel+bounces-74858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A8D85DDA9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC1B1F2344D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE89B7F7EF;
	Wed, 21 Feb 2024 14:06:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD917BB1E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524400; cv=none; b=tZ2tDJ/NJFoAAZ0qspJvsisHohGR8+wYQpW7vwymbbhqnjSM2kzoK/YSQ+EU8W1Eub5nHZOxMDr1b/b87D5DsHF9IcSIKNnGc/E/uLmcVmNhRI9CVCxmJgsTDQNdfOc2IsALyFtNFavRD0P0pSE6ghCiq4JwWCG1lilJhP1CVG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524400; c=relaxed/simple;
	bh=nL4DEb/ABUB0gZnwIH/oIgImYb0Z/fdbaS/trT70KF0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mWXKVjqWTUstpPmb1DxksqcUZLE+ZIezWrJ0+B7KkUHa3+QNKS0zRHd9AZl2wuP5OkR5iegi7DctUzCObwiOfltfROm+mmIoiB3rKnO6UqBRhpEUlCfjrNw5RHDmc8WO60/apZ40Cm6VaMUry9MEtHz+J127n/VIh2agVteI3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA15C43399;
	Wed, 21 Feb 2024 14:06:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rcnGu-00000002i7Q-0hdt;
	Wed, 21 Feb 2024 09:08:28 -0500
Message-ID: <20240221140828.033019650@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 21 Feb 2024 09:07:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Subject: [for-next][PATCH 01/11] eventfs: Add WARN_ON_ONCE() to checks in eventfs_root_lookup()
References: <20240221140756.797572998@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There's a couple of if statements in eventfs_root_lookup() that should
never be true. Instead of removing them, add WARN_ON_ONCE() around them.

  One is a tracefs_inode not being for eventfs.

  The other is a child being freed but still on the parent's children
  list. When a child is freed, it is removed from the list under the
  same mutex that is held during the iteration.

Link: https://lore.kernel.org/linux-trace-kernel/20240201002719.GS2087318@ZenIV/
Link: https://lore.kernel.org/linux-trace-kernel/20240201123346.724afa46@gandalf.local.home

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 110e8a272189..9d9c7dc3114b 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -483,7 +483,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	struct dentry *result = NULL;
 
 	ti = get_tracefs(dir);
-	if (!(ti->flags & TRACEFS_EVENT_INODE))
+	if (WARN_ON_ONCE(!(ti->flags & TRACEFS_EVENT_INODE)))
 		return ERR_PTR(-EIO);
 
 	mutex_lock(&eventfs_mutex);
@@ -495,7 +495,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	list_for_each_entry(ei_child, &ei->children, list) {
 		if (strcmp(ei_child->name, name) != 0)
 			continue;
-		if (ei_child->is_freed)
+		/* A child is freed and removed from the list at the same time */
+		if (WARN_ON_ONCE(ei_child->is_freed))
 			goto out;
 		result = lookup_dir_entry(dentry, ei, ei_child);
 		goto out;
-- 
2.43.0



