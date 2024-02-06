Return-Path: <linux-kernel+bounces-54789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C3784B3B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104B21F2132A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB40133982;
	Tue,  6 Feb 2024 11:33:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089F130E53;
	Tue,  6 Feb 2024 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219210; cv=none; b=TlCeMx91WGzxUc+RubxIzep94PCwmxOqfTQIwTT5SqK01Lcc2e4ZG4dKBHh1tsUTAQRPquGVSpqtjBaeoHMTc67IQx721OlgIu4FMsFJ4X8tIpexwGMyNaCVC+4ef9/X093rDN6KWICoxkbgv+ys3xPdFk0GkoL5bzyH0TP3ZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219210; c=relaxed/simple;
	bh=3jDSxRh6ezDXpMpe9bCVmX2ZEPsqcyYEs+U1X03bFjY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KUPv4lJ8XwGwNoxzOlZxVcfKonx3LNAIpbneJAwqGfP0sv8hLu7/3ywRDtisybqvYgigpBZGzXkoobEJOBQIW+EkSo7gR4EVCHSdyFlpLrzuIxUgr/HDWku/Ci0437Bd1SI3hOk6/MNNG4pModXqdNfONEDTArZ/cWSrO4Mck5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D193C43601;
	Tue,  6 Feb 2024 11:33:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXJiA-00000006aIN-3fhr;
	Tue, 06 Feb 2024 06:33:58 -0500
Message-ID: <20240206113358.729003384@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 06:32:02 -0500
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
 Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Subject: [v6.7][PATCH v2 04/23] eventfs: Have eventfs_iterate() stop immediately if ei->is_freed is
 set
References: <20240206113158.822006147@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If ei->is_freed is set in eventfs_iterate(), it means that the directory
that is being iterated on is in the process of being freed. Just exit the
loop immediately when that is ever detected, and separate out the return
of the entry->callback() from ei->is_freed.

Link: https://lore.kernel.org/linux-trace-kernel/20240104220048.016261289@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit e109deadb73318cf4a3bd61287d969f705df278f)
---
 fs/tracefs/event_inode.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 72912b5f9a90..0aca6910efb3 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -788,11 +788,12 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		name = entry->name;
 
 		mutex_lock(&eventfs_mutex);
-		/* If ei->is_freed, then the event itself may be too */
-		if (!ei->is_freed)
-			r = entry->callback(name, &mode, &cdata, &fops);
-		else
-			r = -1;
+		/* If ei->is_freed then just bail here, nothing more to do */
+		if (ei->is_freed) {
+			mutex_unlock(&eventfs_mutex);
+			goto out;
+		}
+		r = entry->callback(name, &mode, &cdata, &fops);
 		mutex_unlock(&eventfs_mutex);
 		if (r <= 0)
 			continue;
-- 
2.43.0



