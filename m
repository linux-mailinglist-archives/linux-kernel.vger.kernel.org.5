Return-Path: <linux-kernel+bounces-166891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36458BA166
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2D828769A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310DB1BF6E3;
	Thu,  2 May 2024 20:08:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535ED181BAB;
	Thu,  2 May 2024 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680499; cv=none; b=bXkUcltQN5gh8o04awTzCGBKQFD2M2v86VwUKI541H/pqqAr3leE0LIFC6uQyG32ImrSYASiXMmoXnaSC2Bf1vj5Orf4GNmXkD4VSdhOABjurfMQQzGa/augWLVhOQqCqa6gontS2EuMw+l6BhOT+y/5yd7fkWAY4VmVniTi4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680499; c=relaxed/simple;
	bh=LkvnSPnW8jpmisC5i8bfSVpD14v4d0FDqxC2Qf1Fp3Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EznWI/Y+BZ3jSVMJ7sDnh2KuUVGbeOAEIbaJ3P7Vk/Bi7sbhDslXYMMnUXt7Eev/NA0k03gkNDe4T84+JxLwj6abS08z7Cz8Oegz+pCyrN2VamliKJfrKH0TxgMO5wjjDN5zZ1zsh2ED02BY4LotnBj6Xgl1t2WfomsO54ZWgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07401C4AF1A;
	Thu,  2 May 2024 20:08:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s2cjq-00000003M5g-0aws;
	Thu, 02 May 2024 16:09:06 -0400
Message-ID: <20240502200906.002923579@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 02 May 2024 16:08:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH v3 5/6] eventfs: Do not treat events directory different than other
 directories
References: <20240502200821.125580570@goodmis.org>
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

Cc: stable@vger.kernel.org
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



