Return-Path: <linux-kernel+bounces-18160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE8582598D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD96B22C06
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15197347A1;
	Fri,  5 Jan 2024 18:00:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68C328D1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BA1C433C7;
	Fri,  5 Jan 2024 18:00:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rLoVT-000000012Uu-0E2Y;
	Fri, 05 Jan 2024 13:01:19 -0500
Message-ID: <20240105180118.917102213@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 05 Jan 2024 13:00:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [for-next][PATCH 1/4] eventfs: Have eventfs_iterate() stop immediately if ei->is_freed is
 set
References: <20240105180051.741934288@goodmis.org>
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
2.42.0



