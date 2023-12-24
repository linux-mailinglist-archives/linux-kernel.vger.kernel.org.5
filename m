Return-Path: <linux-kernel+bounces-10715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C685E81DAC6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 14:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45285B21655
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A865663;
	Sun, 24 Dec 2023 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwrTjy1t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7C5382
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 13:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27464C433C7;
	Sun, 24 Dec 2023 13:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703424239;
	bh=16qtMbQ31XIsOuybyPjYeZRVVYAm2rk42uzOoCijo4o=;
	h=From:To:Cc:Subject:Date:From;
	b=gwrTjy1tkGWO4ydoT1QV3U/Vdzbg5Qw83NMf07Im3qdyjP1YZiDRXo3StkFbjQml9
	 pSZd/ZIC7AQIgQuoc19HYtDRl/uHeJWUBhgqHMdCcCYWfNt4IM95AH1rycznhXsE9U
	 V31sHyBQxVAusKgylbZkDNUmPndy4Ad4cmLcl0KaNK59fzc5tb9OIL+rj4Wl3/fheG
	 f3mhXqmyrkSqlL8ZsEGgr2UebpP6BsGzD1mr3VcK4RWRtkX6qQa3NMLpUafmSKHez0
	 m8ToPG5/BkMbE0qP/j4AsLwZNW3ulwPCC6KYVkDS9hj+jvVftp85WB8ilpk+YV3yRM
	 7xeAmbwsfm+AA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 4/6] f2fs: compress: fix to avoid inconsistent bewteen i_blocks and dnode
Date: Sun, 24 Dec 2023 21:23:49 +0800
Message-Id: <20231224132349.12109-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In reserve_compress_blocks(), we update blkaddrs of dnode in prior to
inc_valid_block_count(), it may cause inconsistent status bewteen
i_blocks and blkaddrs once inc_valid_block_count() fails.

To fix this issue, it needs to reverse their invoking order.

Fixes: c75488fb4d82 ("f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- rebase code to last dev-test branch
 fs/f2fs/data.c    |  5 +++--
 fs/f2fs/f2fs.h    |  7 ++++++-
 fs/f2fs/file.c    | 26 ++++++++++++++------------
 fs/f2fs/segment.c |  2 +-
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 263053219b28..b6e35e601e24 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1224,7 +1224,8 @@ int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 
 	if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
 		return -EPERM;
-	if (unlikely((err = inc_valid_block_count(sbi, dn->inode, &count))))
+	err = inc_valid_block_count(sbi, dn->inode, &count, true);
+	if (unlikely(err))
 		return err;
 
 	trace_f2fs_reserve_new_blocks(dn->inode, dn->nid,
@@ -1481,7 +1482,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 
 	dn->data_blkaddr = f2fs_data_blkaddr(dn);
 	if (dn->data_blkaddr == NULL_ADDR) {
-		err = inc_valid_block_count(sbi, dn->inode, &count);
+		err = inc_valid_block_count(sbi, dn->inode, &count, true);
 		if (unlikely(err))
 			return err;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7d0c2b05c5a8..dc1feafb4973 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2251,7 +2251,7 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
 
 static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
 static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
-				 struct inode *inode, blkcnt_t *count)
+				 struct inode *inode, blkcnt_t *count, bool partial)
 {
 	blkcnt_t diff = 0, release = 0;
 	block_t avail_user_block_count;
@@ -2291,6 +2291,11 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
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
index 782ae3be48f6..9f4e21b5916c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3614,14 +3614,16 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
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
@@ -3637,20 +3639,20 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 				compr_blocks++;
 				continue;
 			}
-
-			f2fs_set_data_blkaddr(dn, NEW_ADDR);
 		}
 
 		reserved = cluster_size - compr_blocks;
 		if (!reserved)
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
index 61da26eb61cc..9632e9977c90 100644
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
2.40.1


