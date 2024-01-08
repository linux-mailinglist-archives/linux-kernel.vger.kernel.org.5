Return-Path: <linux-kernel+bounces-19751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB188272D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF334B21CC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B70E5103E;
	Mon,  8 Jan 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuQmyRVl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2002524A2;
	Mon,  8 Jan 2024 15:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFDFC4166B;
	Mon,  8 Jan 2024 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704727112;
	bh=yRE6PYaDBQWCEJAQHlZSqyEFDAFo/1wr7VhpyL1bSEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PuQmyRVlJoSoS66BS5OQqhtApFrOiQo+Y/7lqQFPVi1KV9C4LwoELM7cncTE3kNHY
	 g8SRiwObOj6/rl6J1bBirQgMmR4fcia6QU8Gfs/GIYUVLyWQOhtUe+gEf8VO5oFht9
	 MnQzX6XkPB3t1BVvLwsbyLdVjVuES1XvbBhWWbAsiJLpKHbICvnx5bheAeILN+qCw1
	 XNGWD+n7HDJfbLMteeBd4c0ZgY+qsj2sb0f03ou4OEVGY8FDBTMIigBEVPLDY+YU/M
	 /7eRvvW01raTLIALBDgq9WwXhdrxGAkFcHBFsAZUTO6O5f39uxEvf5qfOiLLbWQ+RL
	 zcHnX8GMnj+UA==
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Mon, 08 Jan 2024 15:18:21 +0000
Subject: [PATCH v2 5/8] fs/9p: Eliminate now unused v9fs_get_inode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-ericvh-fix-cache-dups-v2-5-a73f8822838c@kernel.org>
References: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
In-Reply-To: <20240108-ericvh-fix-cache-dups-v2-0-a73f8822838c@kernel.org>
To: Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1950; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=yRE6PYaDBQWCEJAQHlZSqyEFDAFo/1wr7VhpyL1bSEE=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBlnBJDrhR11jQUqruHWzbI87YKtpGC0MDEnVJll
 0M1z1c8j8eJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZZwSQwAKCRCI/9X7Sl//
 mKLsEACGqbKDEItypwvOa91xtEAwMpftX9Sft+ackDPWm5aDeLA2e64e4SedBvCKYF07vCzafzP
 MW55RTiAIn10xwajgkPyFT4U7bW1lxzlTotFeep/6ZudYWnyWwk0mXDOSwKKUQFYCRbdtHZ84Fo
 tI1dualnmv7Sxr0bY65CR7nIkZV2OPYehNUiZrd9Tb6Z3+OhbbaAB9nzR7SaWLsIHTjYp/X6eSL
 OQm1QcR1pY/UbtTiXKIGUbc4mlhFq0WCYsK/Wk6XSYllNHGU5V57GAHv6/ng/Xuncj3RPJvL8hB
 eudIE/88U0XQKhfODWshfXiuAAS9kCnec3fNwCWO1yv67KBz3KlRseQyTYCyBmPQ1zRHK26/zH3
 KoZqm+Hx9fCmzjGSCxZNHfxU7yDDrni1ba8ZUcZ3kMO6si7hu4RQqYUD5PmPNfGtK8JfQf88HwW
 68E6Nx8hdCqmo84sklNjVWW1lGpC+ptcVD9PPq4zQofJ1GNyZY4qDF6gPo3ScRxx9pFnDszmcFb
 T9ICozIuQA4JRIikMmzY0VN2XemOjYDqAoj9epT5A5J3NKWiaYkS/GlD3I/02qWM7vENYJXJhsG
 NP2l01qvJJVaIWbzJrqJMSvWuxvkKIDdoNUEhrtXHtueWSclUnkfZeSLlYfnfp3QZhYgQff+2i/
 v04TCZ9KLESaJZA==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98

Now with all inode allocation going through get_from_fid
functions we can remove v9fs_get_inode and reduce us down
to a single inode allocation path.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/v9fs_vfs.h  |  2 --
 fs/9p/vfs_inode.c | 29 -----------------------------
 2 files changed, 31 deletions(-)

diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index 731e3d14b67d..ad0310deb6c8 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -40,8 +40,6 @@ extern struct kmem_cache *v9fs_inode_cache;
 
 struct inode *v9fs_alloc_inode(struct super_block *sb);
 void v9fs_free_inode(struct inode *inode);
-struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode,
-			     dev_t rdev);
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		    struct inode *inode, umode_t mode, dev_t rdev);
 void v9fs_evict_inode(struct inode *inode);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index b845ee18a80b..0d06dca353aa 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -333,35 +333,6 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 
 }
 
-/**
- * v9fs_get_inode - helper function to setup an inode
- * @sb: superblock
- * @mode: mode to setup inode with
- * @rdev: The device numbers to set
- */
-
-struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode, dev_t rdev)
-{
-	int err;
-	struct inode *inode;
-	struct v9fs_session_info *v9ses = sb->s_fs_info;
-
-	p9_debug(P9_DEBUG_VFS, "super block: %p mode: %ho\n", sb, mode);
-
-	inode = new_inode(sb);
-	if (!inode) {
-		pr_warn("%s (%d): Problem allocating inode\n",
-			__func__, task_pid_nr(current));
-		return ERR_PTR(-ENOMEM);
-	}
-	err = v9fs_init_inode(v9ses, inode, mode, rdev);
-	if (err) {
-		iput(inode);
-		return ERR_PTR(err);
-	}
-	return inode;
-}
-
 /**
  * v9fs_evict_inode - Remove an inode from the inode cache
  * @inode: inode to release

-- 
2.41.0


