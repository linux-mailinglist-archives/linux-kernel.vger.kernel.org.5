Return-Path: <linux-kernel+bounces-113487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCF08884AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C121F23BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628F513D24C;
	Sun, 24 Mar 2024 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbqWEiT+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838BC1B6FD7;
	Sun, 24 Mar 2024 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320288; cv=none; b=WIk2ADNImiKua0wx1o1y6hC81ggQ1OscL4FW2thlDm2dxLZEkHz++jwyDvEuFvSQ66o4XZ7YM4xwuSSUHZJCbk+y0/q84nSW2KTrSZOq+hXH3ImCZ3TrbFM5nsw1PRGt9ukg0dePVo+7v0pmMPayg5YFm4pmGD+xuDP3UQXSzWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320288; c=relaxed/simple;
	bh=vwZ4/4X/5jDQuCgjMxaxQ6J/+J/ZUdtEn/n/mlNumpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHrDRKLGstRdFCte6LdX0N1O40bAal2FNCZ0z8zrpCjDAP1Q9CxUootZAZxWlhloSHUFVB5t2r7xwHvxZSnO6BeEnQLvtn/GJtasz91fpSSm2UM4ScZC2bsB+M1NI14U9QeP/RcSpDoys3qtnkYb9U76OzKObfMpuz5SNjPF4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbqWEiT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF7DC43141;
	Sun, 24 Mar 2024 22:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320288;
	bh=vwZ4/4X/5jDQuCgjMxaxQ6J/+J/ZUdtEn/n/mlNumpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YbqWEiT+wT12JidyOqFaD7YZAiqvqzu8LsjUAEeFj3R3NlTqfzyaJAZw9qTJyAsh4
	 56DzG/Orn0V8j77dvOu4SobgE5K/roFEs6Kr5GfrzQ7Mlbvz2FqORPCIRH2jfokJ0N
	 LkH7OXW51p0igwXbFOjbdwl7WDI/LNme1tJ1ltkroxqQShrU/q7CDMc+bxhD/KmuSQ
	 QtfY7LtvmG/32cyGJmCfEKl3vwbJJr2zoZvANoexdQd7uL0HxdLRoN/gt2Yblgk8Vh
	 TdSJ7wCGO9B+xAs8QijTc9ofZ6f3VdRdXNSVjeksZpx+Q2AGO5SAMJdOiiAcP7DklP
	 PrXUFI9Ob8eLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiuhong Wang <xiuhong.wang@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 596/715] f2fs: compress: fix reserve_cblocks counting error when out of space
Date: Sun, 24 Mar 2024 18:32:55 -0400
Message-ID: <20240324223455.1342824-597-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 3da9a298c50a7..ffe7fca39a8e8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3588,10 +3588,10 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
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
@@ -3655,12 +3655,12 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 
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
@@ -3721,7 +3721,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		count = min(end_offset - dn.ofs_in_node, last_idx - page_idx);
 		count = round_up(count, F2FS_I(inode)->i_cluster_size);
 
-		ret = reserve_compress_blocks(&dn, count);
+		ret = reserve_compress_blocks(&dn, count, &reserved_blocks);
 
 		f2fs_put_dnode(&dn);
 
@@ -3729,13 +3729,12 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
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
@@ -3744,7 +3743,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 
-	if (ret >= 0) {
+	if (!ret) {
 		ret = put_user(reserved_blocks, (u64 __user *)arg);
 	} else if (reserved_blocks &&
 			atomic_read(&F2FS_I(inode)->i_compr_blocks)) {
-- 
2.43.0


