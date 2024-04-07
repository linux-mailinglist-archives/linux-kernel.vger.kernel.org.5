Return-Path: <linux-kernel+bounces-134419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B95DD89B142
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705DB282207
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93A45464A;
	Sun,  7 Apr 2024 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boM7nXEl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F7953E0A;
	Sun,  7 Apr 2024 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495504; cv=none; b=l6KP+TbkkyshHHMpv0CqNb7Cck6D7PtJ2vizvZhbGu1s/vF5f2Gg8eLPZrI06nJVliD5Q1neCSQnlVtIEp+S1mNghn3KY+M3Jq5j1THvJBZQ0VUDTtmE1f+3SoP7iVMYVCeSM0XQ3/gkDOe0ssLRNKStKD+BG6hzxuTuz+BIYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495504; c=relaxed/simple;
	bh=GU/bIG34sl0ux4ckOUDhahlO5itK/3HHm/ilLxKhAhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLMqqQ4yVKo/++ZiNl/HtSUk2IAZDNhRSRFzwQTbJYMD4iWGAeZmZt9qB5miQDIBDKbzypF5UPf25PsUseITNipKTjQyGI+5nD6qUapUuBp5blWYFGOZqnLCacxgkiH4ODsatYBZpI54zzkF2PHhQzj0hZmQ0QhaksawEzHxexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boM7nXEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C340BC433C7;
	Sun,  7 Apr 2024 13:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495503;
	bh=GU/bIG34sl0ux4ckOUDhahlO5itK/3HHm/ilLxKhAhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=boM7nXElhJLNOXGdC+h+WIbh/zRlr3MgFyKM/wrUIY//fjW8SjI7bvMMpBf5V6u+1
	 KHZlyqNtC8JM/mTSb85OneqxbuU9FiPeZ/Cq37hokOMeaCP06N0TSyrhsuWXwNJgO2
	 VjAQLdDbdg1PFjA9sSqcBkIdm+WCCbxn3+8Mf2lAtFsbYRjx3nyVHXRW4Xm/JYI/f4
	 KQ/CK1MOW7IlyTvasV1TjqbSZ4/9yp6fzUdUoIrA6eU6pm/UFxAD8LTM3k2T2o0Wo7
	 vN9J8rPj+t+zNxMjbxF/bPySwknq1cHL4VhicA86aEt/XxUGaKrrDfquNvSVCjc4sW
	 ES9y0TKzJuWMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 09/25] fs/9p: fix uninitialized values during inode evict
Date: Sun,  7 Apr 2024 09:10:57 -0400
Message-ID: <20240407131130.1050321-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
Content-Transfer-Encoding: 8bit

From: Eric Van Hensbergen <ericvh@kernel.org>

[ Upstream commit 6630036b7c228f57c7893ee0403e92c2db2cd21d ]

If an iget fails due to not being able to retrieve information
from the server then the inode structure is only partially
initialized.  When the inode gets evicted, references to
uninitialized structures (like fscache cookies) were being
made.

This patch checks for a bad_inode before doing anything other
than clearing the inode from the cache.  Since the inode is
bad, it shouldn't have any state associated with it that needs
to be written back (and there really isn't a way to complete
those anyways).

Reported-by: syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_inode.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 32572982f72e6..7d42f0c6c644f 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -371,17 +371,21 @@ void v9fs_evict_inode(struct inode *inode)
 	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);
 	__le32 __maybe_unused version;
 
-	truncate_inode_pages_final(&inode->i_data);
+	if (!is_bad_inode(inode)) {
+		truncate_inode_pages_final(&inode->i_data);
 
-	version = cpu_to_le32(v9inode->qid.version);
-	netfs_clear_inode_writeback(inode, &version);
+		version = cpu_to_le32(v9inode->qid.version);
+		netfs_clear_inode_writeback(inode, &version);
 
-	clear_inode(inode);
-	filemap_fdatawrite(&inode->i_data);
+		clear_inode(inode);
+		filemap_fdatawrite(&inode->i_data);
 
 #ifdef CONFIG_9P_FSCACHE
-	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+		if (v9fs_inode_cookie(v9inode))
+			fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
 #endif
+	} else
+		clear_inode(inode);
 }
 
 static int v9fs_test_inode(struct inode *inode, void *data)
-- 
2.43.0


