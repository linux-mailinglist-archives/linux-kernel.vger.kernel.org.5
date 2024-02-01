Return-Path: <linux-kernel+bounces-48599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDA5845E98
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC97296BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B935C03D;
	Thu,  1 Feb 2024 17:33:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857B5C031;
	Thu,  1 Feb 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808811; cv=none; b=MAH98Rm3vwMm56tOtkSOO5cLoeulsAaixKHp3g5bCqQjxTcPVgi+Ihg5bWldVf0hA42xLNqkpt8BFdJ316oWctKt25U5beBqW/SKNQiOaO4x947e/q4x+wXIDQJeDiMAk98UXHRFKxe+Ri3v4Oy/AtppZ4WylfOW8M6Bwoj3t4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808811; c=relaxed/simple;
	bh=LKxrhYRM7JvYQIwJPXuFZOozKiFl12d3yQS0K6y3YwI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=axM0/bCUVdXlSzmgr5Ov1KRT7rTkQi+9dINIFqRUqGIhAXbMIHMOaeN8QjEFnGrDDOONpO67daD/yTRV8yx3cPVw2C/VIg/AJz/iSfyiKwMI7Zr/LYvNAHbdqqgNCokGO2jZrP43V4wr+SxIrQ9OfoZKWnB7VTYm/8JCLJjGTdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E10C433F1;
	Thu,  1 Feb 2024 17:33:30 +0000 (UTC)
Date: Thu, 1 Feb 2024 12:33:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro
 <viro@ZenIV.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Ajay
 Kaher <ajay.kaher@broadcom.com>
Subject: [PATCH v2] eventfs: Add WARN_ON_ONCE() to checks in
 eventfs_root_lookup()
Message-ID: <20240201123346.724afa46@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

}From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There's a couple of if statements in eventfs_root_lookup() that should
never be true. Instead of removing them, add WARN_ON_ONCE() around them.

  One is a tracefs_inode not being for eventfs.

  The other is a child being freed but still on the parent's children
  list. When a child is freed, it is removed from the list under the
  same mutex that is held during the iteration.

Link: https://lore.kernel.org/linux-trace-kernel/20240201002719.GS2087318@ZenIV/

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240201161617.499712009@goodmis.org

- Fixed missing open parenthesis in first WARN_ON_ONCE()

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


