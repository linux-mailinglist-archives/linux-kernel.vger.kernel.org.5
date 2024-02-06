Return-Path: <linux-kernel+bounces-54913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1449B84B50D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A16282420
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EE7145343;
	Tue,  6 Feb 2024 12:09:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B913A882;
	Tue,  6 Feb 2024 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221364; cv=none; b=MMtmGvLXWZv7gN+Bbp8avCHvZc+CPwes2NoLve1ChHpuFC3ee4a8CzgiVjzj0UCui9WpIJmozntqNIPloy3vo+9RxOTXgvgKgOrJ8qaE7U1xSQV3+nkO2aXDnCGNDpCS6ITnpEhGBkmgPqNVHi8jsBU8C+eP35/Foa0AQ5Iykek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221364; c=relaxed/simple;
	bh=3jDSxRh6ezDXpMpe9bCVmX2ZEPsqcyYEs+U1X03bFjY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=R+ycmMDvT8JqB4bgU0co7QBLiBH+/z7dfLgtU0REVkCuKEZ4mdehb5vS8/Q1WDVjRZWxl0/UecclwRXWnYigYjSPCejTqYqWXSFGTimWB10W9V9UY7VxmX9x+SaYAAUZZxfOJXnMl9cxJYS7VhS+OdsmKJvXgE1Ylb67JuT3lq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BCDC43399;
	Tue,  6 Feb 2024 12:09:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGu-00000006bKL-2wSM;
	Tue, 06 Feb 2024 07:09:52 -0500
Message-ID: <20240206120952.562520394@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:43 -0500
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
Subject: [v6.6][PATCH 38/57] eventfs: Have eventfs_iterate() stop immediately if ei->is_freed is
 set
References: <20240206120905.570408983@rostedt.homelinux.com>
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



