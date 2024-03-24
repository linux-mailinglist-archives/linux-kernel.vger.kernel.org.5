Return-Path: <linux-kernel+bounces-114401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79654888A42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2FB1F26C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D12121A836;
	Sun, 24 Mar 2024 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEqo9qRY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E81F097F;
	Sun, 24 Mar 2024 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321818; cv=none; b=Ok6ya+UUazI9wwutICtOLktl+6dCxAtVZOTilXB20u2CEtFLCuI33jjHTUUpV9Y9cdUsH59qd/1HCz2as9LzIPBFQNPClRMhoeQ8zXUcqGZKF72n8piMQsYWHFTN0ES8Ot6bKK0Tus1VPgvkthvcmnbTGrx1WXFVjCpi/8LN42I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321818; c=relaxed/simple;
	bh=57KAIZwTtdaHRl7fKf5l1Ry+q+WlV2hVfIvN1N+UAgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlaz/nfRkJP5tcU0+VesEXraY7qRLyi0oKYha9VWCK5+TAhBYBuKnSOaq1NrmoQO4l5Vj0PyPR1QhemQN1+LYUEAGK3Ccjku1N1peaRJ7/eSQ+t2UcmFdOD7Cx3JHiAGA4Xq1U3S1Nf13lJjbU6WJUnBr6OnCM5bLa9pvQ66q8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEqo9qRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8D0C433C7;
	Sun, 24 Mar 2024 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321817;
	bh=57KAIZwTtdaHRl7fKf5l1Ry+q+WlV2hVfIvN1N+UAgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vEqo9qRY0PrbX29d19R9gvUKdfv/mAy5obEn6JdA84EtUJv1394UhVjiCvLaS1sFL
	 wZ//SOqLBtr/NNEM5KdyTgIMUays0ltN3s06mlzsAbH85a29VMAllp0LmellMBOvWm
	 PX0XzE6/E+ogECtk49b8WtWm17N33v3VGQhvgnLGjVeCgbL5HYauyHnOPfHki1lYmt
	 vLNsuO+hdW5vPlgJepbLD3/Y8stfvU4PeB5XujVeo7cZmaX/HBM4SjyJ7OSSbYvyoV
	 tfG7eGidmKexGNCFos6cNYDigQtmf2u7gfkNekdZmN2X6h6ji/cU+aBS+cD0GKtD5Z
	 t1Yi/9mk7YS4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiuhong Wang <xiuhong.wang@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 545/638] f2fs: compress: fix reserve_cblocks counting error when out of space
Date: Sun, 24 Mar 2024 18:59:42 -0400
Message-ID: <20240324230116.1348576-546-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Xiuhong Wang <xiuhong.wang@unisoc.com>

[ Upstream commit 2f6d721e14b69d6e1251f69fa238b48e8374e25f ]

When a file only needs one direct_node, performing the following
operations will cause the file to be unrepairable:

unisoc # ./f2fs_io compress test.apk
unisoc #df -h | grep dm-48
/dev/block/dm-48 112G 112G 1.2M 100% /data

unisoc # ./f2fs_io release_cblocks test.apk
924
unisoc # df -h | grep dm-48
/dev/block/dm-48 112G 112G 4.8M 100% /data

unisoc # dd if=/dev/random of=file4 bs=1M count=3
3145728 bytes (3.0 M) copied, 0.025 s, 120 M/s
unisoc # df -h | grep dm-48
/dev/block/dm-48 112G 112G 1.8M 100% /data

unisoc # ./f2fs_io reserve_cblocks test.apk
F2FS_IOC_RESERVE_COMPRESS_BLOCKS failed: No space left on device

adb reboot
unisoc # df -h  | grep dm-48
/dev/block/dm-48             112G 112G   11M 100% /data
unisoc # ./f2fs_io reserve_cblocks test.apk
0

This is because the file has only one direct_node. After returning
to -ENOSPC, reserved_blocks += ret will not be executed. As a result,
the reserved_blocks at this time is still 0, which is not the real
number of reserved blocks. Therefore, fsck cannot be set to repair
the file.

After this patch, the fsck flag will be set to fix this problem.

unisoc # df -h | grep dm-48
/dev/block/dm-48             112G 112G  1.8M 100% /data
unisoc # ./f2fs_io reserve_cblocks test.apk
F2FS_IOC_RESERVE_COMPRESS_BLOCKS failed: No space left on device

adb reboot then fsck will be executed
unisoc # df -h  | grep dm-48
/dev/block/dm-48             112G 112G   11M 100% /data
unisoc # ./f2fs_io reserve_cblocks test.apk
924

Fixes: c75488fb4d82 ("f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS")
Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b156ac6a17390..ee5df9adaf775 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3583,10 +3583,10 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	return ret;
 }
 
-static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
+static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
+		unsigned int *reserved_blocks)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
-	unsigned int reserved_blocks = 0;
 	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
 	block_t blkaddr;
 	int i;
@@ -3650,12 +3650,12 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 
 		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, true);
 
-		reserved_blocks += reserved;
+		*reserved_blocks += reserved;
 next:
 		count -= cluster_size;
 	}
 
-	return reserved_blocks;
+	return 0;
 }
 
 static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
@@ -3716,7 +3716,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		count = min(end_offset - dn.ofs_in_node, last_idx - page_idx);
 		count = round_up(count, F2FS_I(inode)->i_cluster_size);
 
-		ret = reserve_compress_blocks(&dn, count);
+		ret = reserve_compress_blocks(&dn, count, &reserved_blocks);
 
 		f2fs_put_dnode(&dn);
 
@@ -3724,13 +3724,12 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 			break;
 
 		page_idx += count;
-		reserved_blocks += ret;
 	}
 
 	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
-	if (ret >= 0) {
+	if (!ret) {
 		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
 		inode_set_ctime_current(inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
@@ -3739,7 +3738,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 
-	if (ret >= 0) {
+	if (!ret) {
 		ret = put_user(reserved_blocks, (u64 __user *)arg);
 	} else if (reserved_blocks &&
 			atomic_read(&F2FS_I(inode)->i_compr_blocks)) {
-- 
2.43.0


