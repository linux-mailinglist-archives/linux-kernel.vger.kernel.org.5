Return-Path: <linux-kernel+bounces-54883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562DB84B4C7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86001F233BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B096137C2A;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB0B1353E2;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221359; cv=none; b=JPKlCowuhEJYgsDuDfQjSEw7maJkUABSzQIZZFDiHpO3GvBPaOsKkMxunVleiIl+3uTfx90gxp3Wz5hWrtkkzG3thmC831cmhPcZpNt58NmyR82dncJ4Wkpbyo5MhGT7oc5akC6nJHz2TPuhb3/rL0CFQFjVQOGiPV/dWsM+8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221359; c=relaxed/simple;
	bh=U8O8HbXTyCH85fzphuPj2gzKXQlZuOW81DY3SFrBp6U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lMqlO1EERJ/qxICVaJXvGVCP27hy+3GlQu7YsshPtEMkniIa+BFbVgCzpKPX4Pi+2QfNOoBDHvG5p2T7bCycXNPrrzYBGRINvTRpIhqZmwiG+qjbbMQM80UWHtBK9nXcF2JbUR7igd9MVyGZEnGWOqbufFeRuBCNm04pECVyIrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891EBC4166B;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGp-00000006b5q-47OS;
	Tue, 06 Feb 2024 07:09:47 -0500
Message-ID: <20240206120947.843106843@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Kees Cook <keescook@chromium.org>,
 Nathan Chancellor <nathan@kernel.org>
Subject: [v6.6][PATCH 09/57] eventfs: Use ERR_CAST() in eventfs_create_events_dir()
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nathan Chancellor <nathan@kernel.org>

When building with clang and CONFIG_RANDSTRUCT_FULL=y, there is an error
due to a cast in eventfs_create_events_dir():

  fs/tracefs/event_inode.c:734:10: error: casting from randomized structure pointer type 'struct dentry *' to 'struct eventfs_inode *'
    734 |                 return (struct eventfs_inode *)dentry;
        |                        ^
  1 error generated.

Use the ERR_CAST() function to resolve the error, as it was designed for
this exact situation (casting an error pointer to another type).

Link: https://lore.kernel.org/linux-trace-kernel/20231018-ftrace-fix-clang-randstruct-v1-1-338cb214abfb@kernel.org

Closes: https://github.com/ClangBuiltLinux/linux/issues/1947
Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit b8a555dc31e5aa18d976de0bc228006e398a2e7d)
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 1ccd100bc565..9f19b6608954 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -731,7 +731,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 		return NULL;
 
 	if (IS_ERR(dentry))
-		return (struct eventfs_inode *)dentry;
+		return ERR_CAST(dentry);
 
 	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
 	if (!ei)
-- 
2.43.0



