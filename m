Return-Path: <linux-kernel+bounces-114647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6FB888B82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD7D1C2952D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A512AA9DA;
	Sun, 24 Mar 2024 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJQCEJYh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91E2002DD;
	Sun, 24 Mar 2024 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322298; cv=none; b=Io5gK9mx/+5kaoxdaFpy1JYFxLQ99zH+2gvEDvLBE4MlUe/Qu3tx2if8KgX073BRooDg/OzErXH3MXi/6BcmEDlBi8xdUM3QwKnm9JrvxhydtCZqKXlsHFt6ayuVlNPczWTEfYHhyUI/+hg/XlUKXsu0225yPVuD/DKiL420cOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322298; c=relaxed/simple;
	bh=/bXkY6dK5NCiDQ0gc7WTqr8VejKapTB/nJwPlB62Ets=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbjA0TscumuSCcq81GENopdEvKKW2Gs9w0BY9mbU6giUfGtggR8ZCLQf6JXAmjnoTRdw5640agTf09Tcs8u94daE139X4F6qyXJTCAhH6VgdZH1iBwBZBtShwm+/A7GaqB/k375WPB+Av+4MKv1HtyXW3ICl4n8Xmk6AmdzXBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJQCEJYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C02DC433A6;
	Sun, 24 Mar 2024 23:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322297;
	bh=/bXkY6dK5NCiDQ0gc7WTqr8VejKapTB/nJwPlB62Ets=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJQCEJYhdrae5R/v7UWP4yfqHso0fN6vwBpTEXeA7Tl7vlNcqy+wV/kcqqdIH9ueo
	 jBmQ8Yz2ylBrMi/3YpWKDiG4jb0qVYaI1qy7XvgYnLY4TrevihOK9Rg+eHx2USIaON
	 CBnbh1hI1jGKkkDCK1FZA8bAc0rHo9pfZ0DvKLmZhtnG1A2sMl0ONR1CPFE0FwuBce
	 EGde/HgDqND5ghlyU3MDz+yfj2UD4L8dZXzUiN8SLh3j404hjHKQs25AnK+vUjEYvB
	 v8nEmkJ9sAkkyRzwt9Sfu4sZt3YKtCq+VoNgBaZ75cfNR8hUA8Yz/2n5234x9J37Ul
	 hNI7vaQMy3I1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiuhong Wang <xiuhong.wang@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 380/451] f2fs: compress: fix reserve_cblocks counting error when out of space
Date: Sun, 24 Mar 2024 19:10:56 -0400
Message-ID: <20240324231207.1351418-381-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 5dbd874ba3d8d..2fbc8d89c600b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3561,10 +3561,10 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
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
@@ -3628,12 +3628,12 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 
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
@@ -3694,7 +3694,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		count = min(end_offset - dn.ofs_in_node, last_idx - page_idx);
 		count = round_up(count, F2FS_I(inode)->i_cluster_size);
 
-		ret = reserve_compress_blocks(&dn, count);
+		ret = reserve_compress_blocks(&dn, count, &reserved_blocks);
 
 		f2fs_put_dnode(&dn);
 
@@ -3702,13 +3702,12 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 			break;
 
 		page_idx += count;
-		reserved_blocks += ret;
 	}
 
 	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
-	if (ret >= 0) {
+	if (!ret) {
 		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
 		inode->i_ctime = current_time(inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
@@ -3717,7 +3716,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 
-	if (ret >= 0) {
+	if (!ret) {
 		ret = put_user(reserved_blocks, (u64 __user *)arg);
 	} else if (reserved_blocks &&
 			atomic_read(&F2FS_I(inode)->i_compr_blocks)) {
-- 
2.43.0


