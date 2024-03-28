Return-Path: <linux-kernel+bounces-113792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EB8888E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8121C2AFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A19712F391;
	Sun, 24 Mar 2024 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx1hcfnL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC01E4A31;
	Sun, 24 Mar 2024 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320812; cv=none; b=ZdrDhs8oHky6Ikp+aUAlZAy2H4NV9sj7WRrpRDJK6CKQnjZn758J5OT/rxlihe0lWaMMlJdbKFjJUg4OinjtR9ANZGLo+eWytHrjnJglOYdxSUdajfmo29hxEr2HXQ6vmZzVuOUldeIOv8hRhX239SxHj/EF05xD8bRA7Z59b5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320812; c=relaxed/simple;
	bh=/wkUrVURaFW6PhpN42GU6CG4bO+YUQVvcwI8FwqBU1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4PdzmOhjC5yWk30KUC4WGhoPAF/5EbrM+UCKlb4NAKDFHFt7ZYmMY4Q6l2HWQ60RXZpmU0E2Qg071UoyRtS1Hm0f9ZzmQQgdMfZTHm+vyr7aiu9EzGjDzB2xifFX8jwG5vR21f1b5tsez5dIoV8WYztBsCMoqTsy4oXgGIvJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx1hcfnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8020C43399;
	Sun, 24 Mar 2024 22:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320811;
	bh=/wkUrVURaFW6PhpN42GU6CG4bO+YUQVvcwI8FwqBU1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gx1hcfnLaPT+uoSFSJAxEUrM12PEPKrsq99KNW5AfWRSRcztAj5vTMboGBqTFhrJ+
	 aH4V/0Zm1bKBEhj3+MwZUbO3pGPEkaJRdHyvUuMgNUqSCTDZ3eYYH7sEhn91CpeZVs
	 O78IdNmyM1ND8fkOUY2uH2G3He6mHNwvq/ys1MDRv/BJOfvqjfls24nWG9LqjB7hC6
	 yxFugiUuPjsAf4ijhOXwHlv6QKpzVjSO7P5sSyGiZu6cqijM/q4X6dxqLN3tDglAu3
	 2TWGS4QWhY+I5dTiI3S93YL5p0oQdtER3sLnf7bCp6s7EuYzPq0Hf6gH+trN3+8SdG
	 HbEL2zoRWeyTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Yang Erkun <yangerkun@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 376/713] erofs: fix lockdep false positives on initializing erofs_pseudo_mnt
Date: Sun, 24 Mar 2024 18:41:42 -0400
Message-ID: <20240324224720.1345309-377-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 0f28be64d132aaf95d06375c8002ad9ecea69d71 ]

Lockdep reported the following issue when mounting erofs with a domain_id:

============================================
WARNING: possible recursive locking detected
6.8.0-rc7-xfstests #521 Not tainted
--------------------------------------------
mount/396 is trying to acquire lock:
ffff907a8aaaa0e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
						at: alloc_super+0xe3/0x3d0

but task is already holding lock:
ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
						at: alloc_super+0xe3/0x3d0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&type->s_umount_key#50/1);
  lock(&type->s_umount_key#50/1);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by mount/396:
 #0: ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
			at: alloc_super+0xe3/0x3d0
 #1: ffffffffc00e6f28 (erofs_domain_list_lock){+.+.}-{3:3},
			at: erofs_fscache_register_fs+0x3d/0x270 [erofs]

stack backtrace:
CPU: 1 PID: 396 Comm: mount Not tainted 6.8.0-rc7-xfstests #521
Call Trace:
 <TASK>
 dump_stack_lvl+0x64/0xb0
 validate_chain+0x5c4/0xa00
 __lock_acquire+0x6a9/0xd50
 lock_acquire+0xcd/0x2b0
 down_write_nested+0x45/0xd0
 alloc_super+0xe3/0x3d0
 sget_fc+0x62/0x2f0
 vfs_get_super+0x21/0x90
 vfs_get_tree+0x2c/0xf0
 fc_mount+0x12/0x40
 vfs_kern_mount.part.0+0x75/0x90
 kern_mount+0x24/0x40
 erofs_fscache_register_fs+0x1ef/0x270 [erofs]
 erofs_fc_fill_super+0x213/0x380 [erofs]

This is because the file_system_type of both erofs and the pseudo-mount
point of domain_id is erofs_fs_type, so two successive calls to
alloc_super() are considered to be using the same lock and trigger the
warning above.

Therefore add a nodev file_system_type called erofs_anon_fs_type in
fscache.c to silence this complaint. Because kern_mount() takes a
pointer to struct file_system_type, not its (string) name. So we don't
need to call register_filesystem(). In addition, call init_pseudo() in
erofs_anon_init_fs_context() as suggested by Al Viro, so that we can
remove erofs_fc_fill_pseudo_super(), erofs_fc_anon_get_tree(), and
erofs_anon_context_ops.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: a9849560c55e ("erofs: introduce a pseudo mnt to manage shared cookies")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-and-tested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Yang Erkun <yangerkun@huawei.com>
Link: https://lore.kernel.org/r/20240307101018.2021925-1-libaokun1@huawei.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/fscache.c  | 15 ++++++++++++++-
 fs/erofs/internal.h |  1 -
 fs/erofs/super.c    | 30 +-----------------------------
 3 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 1052f75d1dfae..afc37c9029ce7 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2022, Alibaba Cloud
  * Copyright (C) 2022, Bytedance Inc. All rights reserved.
  */
+#include <linux/pseudo_fs.h>
 #include <linux/fscache.h>
 #include "internal.h"
 
@@ -12,6 +13,18 @@ static LIST_HEAD(erofs_domain_list);
 static LIST_HEAD(erofs_domain_cookies_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
+static int erofs_anon_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
+}
+
+static struct file_system_type erofs_anon_fs_type = {
+	.owner		= THIS_MODULE,
+	.name           = "pseudo_erofs",
+	.init_fs_context = erofs_anon_init_fs_context,
+	.kill_sb        = kill_anon_super,
+};
+
 struct erofs_fscache_request {
 	struct erofs_fscache_request *primary;
 	struct netfs_cache_resources cache_resources;
@@ -381,7 +394,7 @@ static int erofs_fscache_init_domain(struct super_block *sb)
 		goto out;
 
 	if (!erofs_pseudo_mnt) {
-		struct vfsmount *mnt = kern_mount(&erofs_fs_type);
+		struct vfsmount *mnt = kern_mount(&erofs_anon_fs_type);
 		if (IS_ERR(mnt)) {
 			err = PTR_ERR(mnt);
 			goto out;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b0409badb0172..410f5af623540 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -385,7 +385,6 @@ struct erofs_map_dev {
 	unsigned int m_deviceid;
 };
 
-extern struct file_system_type erofs_fs_type;
 extern const struct super_operations erofs_sops;
 
 extern const struct address_space_operations erofs_raw_access_aops;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3789d62245136..8a82d5cec16da 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -573,13 +573,6 @@ static const struct export_operations erofs_export_ops = {
 	.get_parent = erofs_get_parent,
 };
 
-static int erofs_fc_fill_pseudo_super(struct super_block *sb, struct fs_context *fc)
-{
-	static const struct tree_descr empty_descr = {""};
-
-	return simple_fill_super(sb, EROFS_SUPER_MAGIC, &empty_descr);
-}
-
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
@@ -706,11 +699,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	return 0;
 }
 
-static int erofs_fc_anon_get_tree(struct fs_context *fc)
-{
-	return get_tree_nodev(fc, erofs_fc_fill_pseudo_super);
-}
-
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
 	struct erofs_fs_context *ctx = fc->fs_private;
@@ -783,20 +771,10 @@ static const struct fs_context_operations erofs_context_ops = {
 	.free		= erofs_fc_free,
 };
 
-static const struct fs_context_operations erofs_anon_context_ops = {
-	.get_tree       = erofs_fc_anon_get_tree,
-};
-
 static int erofs_init_fs_context(struct fs_context *fc)
 {
 	struct erofs_fs_context *ctx;
 
-	/* pseudo mount for anon inodes */
-	if (fc->sb_flags & SB_KERNMOUNT) {
-		fc->ops = &erofs_anon_context_ops;
-		return 0;
-	}
-
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
@@ -818,12 +796,6 @@ static void erofs_kill_sb(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
 
-	/* pseudo mount for anon inodes */
-	if (sb->s_flags & SB_KERNMOUNT) {
-		kill_anon_super(sb);
-		return;
-	}
-
 	if (erofs_is_fscache_mode(sb))
 		kill_anon_super(sb);
 	else
@@ -862,7 +834,7 @@ static void erofs_put_super(struct super_block *sb)
 	erofs_fscache_unregister_fs(sb);
 }
 
-struct file_system_type erofs_fs_type = {
+static struct file_system_type erofs_fs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "erofs",
 	.init_fs_context = erofs_init_fs_context,
-- 
2.43.0


