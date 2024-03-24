Return-Path: <linux-kernel+bounces-115721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F4888973C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758801C30A96
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514563614DB;
	Mon, 25 Mar 2024 02:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4+A3Xi+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688F21852F;
	Sun, 24 Mar 2024 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321788; cv=none; b=c2OpCG230UnR9BBDC0D/bVLUYw9ibMXpxkvI9rRSJY+D0xMGsxW2KogSXN2OKrpi72AtJmzYdhnYaGqas3riTM7w6bM28O22Ydx3C8Nc4ubCGecEUBgBVDhBBweF5miOwIOtzmjOUkxLKU/J7hGm3Ti/W09/B0pMLgP6dQNuIpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321788; c=relaxed/simple;
	bh=6pjehYBSScvnSOK9O8MquXi1ww2Y2L8LMEe0OnuTJlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taq6xVVNYp8aKRhKfcEk4zQK3B2JUr30fgvwDsVRJQkCj1SEyC1HRji+kHufucDAPrZYW1GGp5wrAz0hRijYXJ32E0JheNpgVGn0XmZNCROKFfPkyCLw8T5hx5tgOJX+OOLEmmHLQyzGQnBHSFZPImvGGvinJG7jYCgbMhkpclc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4+A3Xi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7731C43390;
	Sun, 24 Mar 2024 23:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321788;
	bh=6pjehYBSScvnSOK9O8MquXi1ww2Y2L8LMEe0OnuTJlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4+A3Xi+Hh7fKyBF2W+Am4rzblhllKMMGpQTKj4Luh97OdQvGE+LsIai/Pv7ZXGZr
	 ccxfEHwrRmDFJKa4iUdDJ2iS1L6/1wQEhWsAat5dXy1u7Y97ybJQ4Jo6Y2iJxo5MrV
	 3sIun+iEutSq8Il24aIG1C0NJeIwjQ+MZT+3Dm7fiAyYVHgAHaoynqIpEE4NTUfm2n
	 IX0hxhlSoTTJ7DlecRidN4xRgQ2VvxdkR9HRbHh44jDDDVycmisISxOfK25XyQCsAZ
	 GDNjPzl3VhFqtBprildDvG2oFtS5C2G7aw3Q8TmVRPjESBdm7dWDeJnXM5PaowAq6s
	 3083nHauxSLlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 516/638] f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode
Date: Sun, 24 Mar 2024 18:59:13 -0400
Message-ID: <20240324230116.1348576-517-sashal@kernel.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit 54607494875edd636aff3c21ace3ad9a7da758a9 ]

In reserve_compress_blocks(), we update blkaddrs of dnode in prior to
inc_valid_block_count(), it may cause inconsistent status bewteen
i_blocks and blkaddrs once inc_valid_block_count() fails.

To fix this issue, it needs to reverse their invoking order.

Fixes: c75488fb4d82 ("f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS")
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c    |  5 +++--
 fs/f2fs/f2fs.h    |  7 ++++++-
 fs/f2fs/file.c    | 26 ++++++++++++++------------
 fs/f2fs/segment.c |  2 +-
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a961288daafcb..3dcff94221695 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1219,7 +1219,8 @@ int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 
 	if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
 		return -EPERM;
-	if (unlikely((err = inc_valid_block_count(sbi, dn->inode, &count))))
+	err = inc_valid_block_count(sbi, dn->inode, &count, true);
+	if (unlikely(err))
 		return err;
 
 	trace_f2fs_reserve_new_blocks(dn->inode, dn->nid,
@@ -1476,7 +1477,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 
 	dn->data_blkaddr = f2fs_data_blkaddr(dn);
 	if (dn->data_blkaddr == NULL_ADDR) {
-		err = inc_valid_block_count(sbi, dn->inode, &count);
+		err = inc_valid_block_count(sbi, dn->inode, &count, true);
 		if (unlikely(err))
 			return err;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a768722f26b65..8e5df06e9bb2c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2244,7 +2244,7 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
 
 static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
 static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
-				 struct inode *inode, blkcnt_t *count)
+				 struct inode *inode, blkcnt_t *count, bool partial)
 {
 	blkcnt_t diff = 0, release = 0;
 	block_t avail_user_block_count;
@@ -2284,6 +2284,11 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 			avail_user_block_count = 0;
 	}
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
+		if (!partial) {
+			spin_unlock(&sbi->stat_lock);
+			goto enospc;
+		}
+
 		diff = sbi->total_valid_block_count - avail_user_block_count;
 		if (diff > *count)
 			diff = *count;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 73e1df8d584fb..f41788ab0cf45 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3609,14 +3609,16 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 		blkcnt_t reserved;
 		int ret;
 
-		for (i = 0; i < cluster_size; i++, dn->ofs_in_node++) {
-			blkaddr = f2fs_data_blkaddr(dn);
+		for (i = 0; i < cluster_size; i++) {
+			blkaddr = data_blkaddr(dn->inode, dn->node_page,
+						dn->ofs_in_node + i);
 
 			if (i == 0) {
-				if (blkaddr == COMPRESS_ADDR)
-					continue;
-				dn->ofs_in_node += cluster_size;
-				goto next;
+				if (blkaddr != COMPRESS_ADDR) {
+					dn->ofs_in_node += cluster_size;
+					goto next;
+				}
+				continue;
 			}
 
 			/*
@@ -3629,8 +3631,6 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 				compr_blocks++;
 				continue;
 			}
-
-			f2fs_set_data_blkaddr(dn, NEW_ADDR);
 		}
 
 		reserved = cluster_size - compr_blocks;
@@ -3639,12 +3639,14 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 		if (reserved == 1)
 			goto next;
 
-		ret = inc_valid_block_count(sbi, dn->inode, &reserved);
-		if (ret)
+		ret = inc_valid_block_count(sbi, dn->inode, &reserved, false);
+		if (unlikely(ret))
 			return ret;
 
-		if (reserved != cluster_size - compr_blocks)
-			return -ENOSPC;
+		for (i = 0; i < cluster_size; i++, dn->ofs_in_node++) {
+			if (f2fs_data_blkaddr(dn) == NULL_ADDR)
+				f2fs_set_data_blkaddr(dn, NEW_ADDR);
+		}
 
 		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, true);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d05b41608fc00..e77591a0cc118 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -248,7 +248,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 	} else {
 		blkcnt_t count = 1;
 
-		err = inc_valid_block_count(sbi, inode, &count);
+		err = inc_valid_block_count(sbi, inode, &count, true);
 		if (err) {
 			f2fs_put_dnode(&dn);
 			return err;
-- 
2.43.0


