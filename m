Return-Path: <linux-kernel+bounces-54885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B9B84B4CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6631F25560
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580CB137C44;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33701353F4;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221359; cv=none; b=LXUQa516Csi2cv3g4WpoQVbwtqRfhQY1mvAut+90eCmpeCbGhXPrnkhuklbDKiNMWCXNZtLAKm6FtpIW0uVm/Occ0IC3b2k25VObh3J1aIEfEy5naLYy2wiAXrBtJuSyDTdvgr7fRin47iJzP1KWDqZvX6BtHgkKlyIw4rZ8jMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221359; c=relaxed/simple;
	bh=yxagGa01h2asUZexPZIm50VtsB5OwdxwdGuVM2gCW2Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pH9bKuaCWChFkY6iw3xGpc3FdOqfbd6X0dGf+GOECCRBSzHpi6JBQ7gIN28NcSaFzz8veR+sHgwjoZ9d1gfqrTCvs0YO0hjyBUcTD3YShsgOPR6TO/GfQo64QqAc9Fo60ljk2x4y1wdUAbKZPxqIkTKADFH+gjrBwfe9GzIwBAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE411C433B1;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGq-00000006b6L-0bJb;
	Tue, 06 Feb 2024 07:09:48 -0500
Message-ID: <20240206120948.003109160@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Julia Lawall <julia.lawall@inria.fr>
Subject: [v6.6][PATCH 10/57] eventfs: Fix failure path in eventfs_create_events_dir()
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The failure path of allocating ei goes to a path that dereferences ei.
Add another label that skips over the ei dereferences to do the rest of
the clean up.

Link: https://lore.kernel.org/all/70e7bace-561c-95f-1117-706c2c220bc@inria.fr/
Link: https://lore.kernel.org/linux-trace-kernel/20231019204132.6662fef0@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 7e8ad67c9b5c11e990c320ed7e7563f2301672a7)
---
 fs/tracefs/event_inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 9f19b6608954..1885f1f1f339 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -735,7 +735,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 
 	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
 	if (!ei)
-		goto fail;
+		goto fail_ei;
 
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
@@ -781,6 +781,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
  fail:
 	kfree(ei->d_children);
 	kfree(ei);
+ fail_ei:
 	tracefs_failed_creating(dentry);
 	return ERR_PTR(-ENOMEM);
 }
-- 
2.43.0



