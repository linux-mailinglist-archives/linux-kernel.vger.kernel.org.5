Return-Path: <linux-kernel+bounces-166624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDEB8B9D2A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD71281543
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F6315B0FD;
	Thu,  2 May 2024 15:15:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9178415B141;
	Thu,  2 May 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662934; cv=none; b=OIPh0YhFe+yaQUjzrK4nLzm55QFgwm65U6wl9veXspZEiuEmhnlk4vUIXXeCiFwzs8XGNBiwjpQ4AlvqWcsAKrF9kuBT3DW7edk+zQ2dqlLJfkopfB3Hd5NqjqbIqmDo/vk4bKKXwSGwtaLDUgfqcq0yItndeaOwg5l1ape6K3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662934; c=relaxed/simple;
	bh=i+Q36AjRIPs7Ry987XtuVA+g0h3Lg22zj9IHFjW5j1M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=caoiMNtYht+Lb/j7iFBhQvUPGepsLXd++M4a9rhwyf4iRogkRXZPxCNmKE6NLynUmBE0nrdpBWRm796Y2GPXUv3KNFIo8sVFbwrZrC2A8s5t9O+MPN554DehmqkUH7cGJqTLu9FiKbimRVLulML/q6NNDNellyRs9Qlwq7/eWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FF2C4AF18;
	Thu,  2 May 2024 15:15:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s2YAX-00000003IUD-024u;
	Thu, 02 May 2024 11:16:21 -0400
Message-ID: <20240502151620.874018137@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 02 May 2024 11:15:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH v2 4/5] eventfs: Do not treat events directory different than other
 directories
References: <20240502151547.973653253@goodmis.org>
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
index 2971609946e5..ff4ee3dad56a 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -199,21 +199,7 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
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



