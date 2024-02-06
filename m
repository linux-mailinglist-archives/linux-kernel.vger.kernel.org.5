Return-Path: <linux-kernel+bounces-54887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FED84B4CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91387283B87
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D5A137C5E;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8F135A49;
	Tue,  6 Feb 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221360; cv=none; b=gqWOfjL7NhsNP8hYNCXR9rwmmBI76v5TKWVYX6uBiEPpZyrZMoMLMdwav1w89AqpsKFI9slXiluAfYajuzu14ih2jdWtfO7n1UyegZhUcLsTGVwLouKCP4qCK8lht+1yF0Sn8Kmtgwb4AT1plXX+8b4sYGYoqnQBp1zpBt1eqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221360; c=relaxed/simple;
	bh=ag23ZLNHvKwtbUtFEFGHSFqm7C64xgRkm1HvLw4xCCI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ud4DNtBHsIUPXjWVUDE3IdsvGNTccqYyZaIuYAZWjjiDv/T07Ee6vNp3CQtwFvbnM2+SNYQeJQFISeHnGy4kpnHPwewbl6Jn7PdURJ0+6YN/V+1faMuYSvbVqqq80l2FeScdOpoJvzksNTNLe3C/eZc+rexYnkK93L/YRRCzGmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A394C433C7;
	Tue,  6 Feb 2024 12:09:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGq-00000006b7K-1zWt;
	Tue, 06 Feb 2024 07:09:48 -0500
Message-ID: <20240206120948.331907337@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [v6.6][PATCH 12/57] eventfs: Fix WARN_ON() in create_file_dentry()
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

As the comment right above a WARN_ON() in create_file_dentry() states:

  * Note, with the mutex held, the e_dentry cannot have content
  * and the ei->is_freed be true at the same time.

But the WARN_ON() only has:

  WARN_ON_ONCE(ei->is_free);

Where to match the comment (and what it should actually do) is:

  dentry = *e_dentry;
  WARN_ON_ONCE(dentry && ei->is_free)

Also in that case, set dentry to NULL (although it should never happen).

Link: https://lore.kernel.org/linux-trace-kernel/20231024123628.62b88755@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit a9de4eb15ad430fe45747c211e367da745a90093)
---
 fs/tracefs/event_inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 09ab93357957..4d2da7480e5f 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -264,8 +264,9 @@ create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
 		 * Note, with the mutex held, the e_dentry cannot have content
 		 * and the ei->is_freed be true at the same time.
 		 */
-		WARN_ON_ONCE(ei->is_freed);
 		dentry = *e_dentry;
+		if (WARN_ON_ONCE(dentry && ei->is_freed))
+			dentry = NULL;
 		/* The lookup does not need to up the dentry refcount */
 		if (dentry && !lookup)
 			dget(dentry);
-- 
2.43.0



