Return-Path: <linux-kernel+bounces-168384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B638BB7CA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAB1284E2C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FC212E1CD;
	Fri,  3 May 2024 22:50:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7E584FDA;
	Fri,  3 May 2024 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776635; cv=none; b=A2SJk0RqpJNW7w6mSmnV0SmTWA35Qs6Rgmv54WPW9I+HZ++reQwFCmV9Js5yBlu8YuHnYa9QZyvvAtHItSwlaheFYn6c8AGTUgnkKrZTOz3hNJCG+g9Qt4P7plf9SSCmCVkdLNckJdHvaN2HWwy8V8ZIVWHLKJkD8PEW+SGFdBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776635; c=relaxed/simple;
	bh=D6iS8cCOd8O5bFYPsifgqFYZTYU5tiSfFPkglnT8J6A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NevaJOGJFJuBSQs1sFUCw8i+a5j3AToiGXSJ2u6T8l1rK861jloN7mvGu8KvtBQAGIrRjeAAscTHpF237EZmHvIIOYoN/YSRP1GSU68AyzLsuXMu5puBorZ9n0C4wKYPqSPU4XxIe3f4mLik4j957ltbA0Y9feMKP1U6BKfULXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEA1C4DDEB;
	Fri,  3 May 2024 22:50:35 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s31je-00000000NNZ-3cOV;
	Fri, 03 May 2024 18:50:34 -0400
Message-ID: <20240503225034.719025644@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 03 May 2024 18:50:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 8/9] eventfs: Do not treat events directory different than other
 directories
References: <20240503225013.519028385@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Treat the events directory the same as other directories when it comes to
permissions. The events directory was considered different because it's
dentry is persistent, whereas the other directory dentries are created
when accessed. But the way tracefs now does its ownership by using the
root dentry's permissions as the default permissions, the events directory
can get out of sync when a remount is performed setting the group and user
permissions.

Remove the special case for the events directory on setting the
attributes. This allows the updates caused by remount to work properly as
well as simplifies the code.

Link: https://lore.kernel.org/linux-trace-kernel/20240502200906.002923579@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 8186fff7ab649 ("tracefs/eventfs: Use root and instance inodes as default ownership")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 9dacf65c0b6e..6e08405892ae 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -206,21 +206,7 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	 * determined by the parent directory.
 	 */
 	if (dentry->d_inode->i_mode & S_IFDIR) {
-		/*
-		 * The events directory dentry is never freed, unless its
-		 * part of an instance that is deleted. It's attr is the
-		 * default for its child files and directories.
-		 * Do not update it. It's not used for its own mode or ownership.
-		 */
-		if (ei->is_events) {
-			/* But it still needs to know if it was modified */
-			if (iattr->ia_valid & ATTR_UID)
-				ei->attr.mode |= EVENTFS_SAVE_UID;
-			if (iattr->ia_valid & ATTR_GID)
-				ei->attr.mode |= EVENTFS_SAVE_GID;
-		} else {
-			update_attr(&ei->attr, iattr);
-		}
+		update_attr(&ei->attr, iattr);
 
 	} else {
 		name = dentry->d_name.name;
-- 
2.43.0



