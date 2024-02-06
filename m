Return-Path: <linux-kernel+bounces-54889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB3684B4D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B44B2848C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383C61386AE;
	Tue,  6 Feb 2024 12:09:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F578135A63;
	Tue,  6 Feb 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221360; cv=none; b=r/GBtCUpQTH52YlMUA95X8HvDjO59M0/CrH6kY4OLT7H8RjGpj/7cwANAjmMINEZI6e8K9ZZOh3lDcl3RYvqUnMT+u9ayUIZR9CWK9xfK5i31sbtBAQ/xchTc7yXnldEBHbP2OCxXaDS92T3SBRnpMr9dBs0Z5/PEuIB145lVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221360; c=relaxed/simple;
	bh=2aaBsNBmdbcGzMEkSucJzBcIVM88W8uW7E3nMS6OFqQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Dj/wrbXEOKn/wCSF2BTOyb0y2PCi8vVPQtN6vz8FiD83HP9uZaGiLqyK/rvr8USV8OopD0VAhkWa2tytP45kjYDr+stlluwUPqV4KfXj5QYERIGTfCfHu6CtHF2pMnpxJ9Xz9ev89j1/+FvoUQ6DMEloJ7fsrvTt5KOS62tuYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534CDC433B2;
	Tue,  6 Feb 2024 12:09:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGq-00000006b8K-3L6D;
	Tue, 06 Feb 2024 07:09:48 -0500
Message-ID: <20240206120948.657072999@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [v6.6][PATCH 14/57] eventfs: Remove extra dget() in eventfs_create_events_dir()
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The creation of the top events directory does a dget() at the end of the
creation in eventfs_create_events_dir() with a comment saying the final
dput() will happen when it is removed. The problem is that a dget() is
already done on the dentry when it was created with tracefs_start_creating()!
The dget() now just causes a memory leak of that dentry.

Remove the extra dget() as the final dput() in the deletion of the events
directory actually matches the one in tracefs_start_creating().

Link: https://lore.kernel.org/linux-trace-kernel/20231031124229.4f2e3fa1@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 77bc4d4921bd3497678ba8e7f4e480de35692f05)
---
 fs/tracefs/event_inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 4d2da7480e5f..5536860eb2ff 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -774,9 +774,6 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
 	tracefs_end_creating(dentry);
 
-	/* Will call dput when the directory is removed */
-	dget(dentry);
-
 	return ei;
 
  fail:
-- 
2.43.0



