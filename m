Return-Path: <linux-kernel+bounces-19747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B648272CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5753DB22D7F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C904EB30;
	Mon,  8 Jan 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvJFHb9X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9F14C610;
	Mon,  8 Jan 2024 15:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB16DC433D9;
	Mon,  8 Jan 2024 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704727109;
	bh=FzqC8vGfSQKqsymfIdQBKBTvSoDcKJkKyoEMFGNr5Uk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gvJFHb9Xq0bzJfqeoSEGCf46TqK7pW8iIA3JfYScQ5bMzgQKusktpVugjcf+bnaTL
	 9d4PGxUgbUzzKz/dBm0AtNmD/mcCkHhr8XISUr3K1V6vpXwRmX0wJiAYoqoLS5oDPS
	 m2XoZFONLVnSemx1zCmy/l4j64iyGF2tZgQKtq5Yb8rTsIx0ZMupXr7aktEP7a/0DB
	 vZo5LOeiJWdthDDXP/lbn6l2rpFb6iPMdZQGDnbDIFE8zM0QzzQQ92CDLdyVxjZ11n
	 QRnduPh4FfEpjnZ7QKHKaGyn6pqBHbItOoixHzdzVGC75Q/staHKB4wKGSQwT2pgnk
	 3otHs/0DLb0Sg==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 08 Jan 2024 15:18:17 +0000
Subject: [PATCH v2 1/8] fs/9p: switch vfsmount to use v9fs_get_new_inode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-ericvh-fix-cache-dups-v2-1-a73f8822838c@kernel.org>
References: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
In-Reply-To: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=FzqC8vGfSQKqsymfIdQBKBTvSoDcKJkKyoEMFGNr5Uk=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlnBJCcsP0XfYsl1bHEYlKvirxIWNqyGqk06LyC
 AIHCFd/voeJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZwSQgAKCRCI/9X7Sl//
 mHnAEACDKZbFob0ZtPl7iWvsU3dfgcfLKnTJf/egIgnl7cVoO6PsIpz3hB3X0A4jloQnBDmg6X7
 FXJv9lxQc0vk1yhrmhEII/z7DSFWr2bq/h5Y8pxJENWouNmVtGHzq0bdvx5iYs61pepRQsOw3+M
 oXzKEHqqkziWCWzWmSG4Pmy2FoFkyfWcL9X8eY4URoZmcQUNVqozhgfpOUWOTDZvB6MJyOHlhy1
 LxAa4snk7LtnamWSdirXRaYWor/8YKZ4T3uMwdnhsmdr5j4xJTTWIgeSLHn1u7HJR27ieyDeZpV
 pYTb5cGFq5TnGVlKkPPj5iqksQrvP9wbKQrT3CzftOz6DyYei20l6UOcUp0rCn4WekMV8TSlOS1
 xt1xjja5HNf9tw72lJpgz+J0mbkQSACOFV5jmTcngnnHzTKPXc31btAd/yjIrWU5Ct9psZe14vs
 xIyCTjxmGSkr1tfxAMwdJsbPXxW+LY7QIWkP6f+QsMgzNKV9Vs2716niEve1YQ/mLSHzHONDpVx
 iKtsQZUZVUwfhtcqCYViPKBi6/Ts4VjqvXKOZu9mHOObMWkBbO0ubkI6Gco0dMex5CXITlbIHDx
 8gXwaAz2+ZmpBNFtJ7CX3zJN0BWOnFT5nQz+VhJbxT52cqEEy0Mx3YGmrNjPMxGG7O+5IkJqUBE
 SFf1uHf5GqeDvVQ==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

In the process of cleaning up inode number allocation, I noticed several functions which didn't use the standard helper
allocators.  This patch fixes the allocation in the mount entrypoint.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_super.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 73db55c050bf..8d14cc0b3916 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -110,7 +110,6 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	struct inode *inode = NULL;
 	struct dentry *root = NULL;
 	struct v9fs_session_info *v9ses = NULL;
-	umode_t mode = 0777 | S_ISVTX;
 	struct p9_fid *fid;
 	int retval = 0;
 
@@ -140,7 +139,7 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	else
 		sb->s_d_op = &v9fs_dentry_operations;
 
-	inode = v9fs_get_inode(sb, S_IFDIR | mode, 0);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb);
 	if (IS_ERR(inode)) {
 		retval = PTR_ERR(inode);
 		goto release_sb;
@@ -152,32 +151,6 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 		goto release_sb;
 	}
 	sb->s_root = root;
-	if (v9fs_proto_dotl(v9ses)) {
-		struct p9_stat_dotl *st = NULL;
-
-		st = p9_client_getattr_dotl(fid, P9_STATS_BASIC);
-		if (IS_ERR(st)) {
-			retval = PTR_ERR(st);
-			goto release_sb;
-		}
-		d_inode(root)->i_ino = v9fs_qid2ino(&st->qid);
-		v9fs_stat2inode_dotl(st, d_inode(root), 0);
-		kfree(st);
-	} else {
-		struct p9_wstat *st = NULL;
-
-		st = p9_client_stat(fid);
-		if (IS_ERR(st)) {
-			retval = PTR_ERR(st);
-			goto release_sb;
-		}
-
-		d_inode(root)->i_ino = v9fs_qid2ino(&st->qid);
-		v9fs_stat2inode(st, d_inode(root), sb, 0);
-
-		p9stat_free(st);
-		kfree(st);
-	}
 	retval = v9fs_get_acl(inode, fid);
 	if (retval)
 		goto release_sb;

-- 
2.41.0


