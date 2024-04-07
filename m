Return-Path: <linux-kernel+bounces-134391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5DF89B0EC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1CD1C20A1C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1D23838A;
	Sun,  7 Apr 2024 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIQsKGWB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083E137160
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712494923; cv=none; b=mc08weoiQEQgHOZnhzDMOz5YLF0QbJ+RRMQPxdzNDwp7iqkDjMCoYARfa9ABTthqzmcE7dSr6eo75HGMghxC37nrnzG4KPCtTppxdAOXvxC5T65HtIFioDsgjO3Ix4ifLpfdQIWn0KECXuwTO2CCgcIRbsBGxO/2UDhlzQNASFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712494923; c=relaxed/simple;
	bh=vlwwBg4ZiQTSQiT1cbzo/lmslvX2+yGwLAwsr5WpIc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hloNFQg24i9uvtPg62qsuIEe4AqUJv9mDQ6YSGDXDLqPxBJuDgVC6C4+DGJOnhhTh9NaqRPx2hE5zG59MRn0KYskdVZCcJHjiR2Jcod91uEU2MZCzzF4imcl0HdJYrJyzOnXZUgTxxCbFvEODFqI3WDStWeC+hx0t7RLzF/vKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIQsKGWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837FBC433F1;
	Sun,  7 Apr 2024 13:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712494922;
	bh=vlwwBg4ZiQTSQiT1cbzo/lmslvX2+yGwLAwsr5WpIc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIQsKGWBWYK7m/q3+X1qpdn9/qBUVzHdHBnWu7e1zMKCHCf0Vb+QYzMDS7w76YKSW
	 xxDoxsmQ9xCjapjbDlZgVCkAga2Ekutjs1UkPZqcd6uGTrZkdJSf6OmwNEZBrjkwDX
	 LXj7Ygn6/f8cC9+bX5sNdKrIxhdNmVeGxHi7SjCLAGUl7sFOuRmZ6FPTdUt507olqk
	 ifdqlrtfh7Wjk++PQseDpyHAt0KDI4bk3KiUUtv1H97LVuBok6ghbgKr6BGp+KMiQ+
	 fsrHIjDcoVEi5ILxAcDpuEoxamM2mAw7MFDKqRvw9nev8wuQqLoQuX2cGdN4Fq2BgJ
	 NP0m8Y6ZWu3XA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: introduce written_map to indicate written datas
Date: Sun,  7 Apr 2024 21:01:55 +0800
Message-Id: <20240407130155.3602415-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240407130155.3602415-1-chao@kernel.org>
References: <20240407130155.3602415-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, __exchange_data_block() will check checkpointed state of data,
if it is not checkpointed, it will try to exchange blkaddrs directly in
dnode.

However, after commit 899fee36fac0 ("f2fs: fix to avoid data corruption
by forbidding SSR overwrite"), in order to disallow SSR allocator to
reuse all written data/node type blocks, all written blocks were set as
checkpointed.

In order to reenable metadata exchange functionality, let's introduce
written_map to indicate all written blocks including checkpointed one,
or newly written and invalidated one, and use it for SSR allocation,
and then ckpt_valid_bitmap can indicate real checkpointed status, and
we can use it correctly in __exchange_data_block().

[testcase]
xfs_io -f /mnt/f2fs/src -c "pwrite 0 2m"
xfs_io -f /mnt/f2fs/dst -c "pwrite 0 2m"
xfs_io /mnt/f2fs/src -c "fiemap -v"
xfs_io /mnt/f2fs/dst -c "fiemap -v"
f2fs_io move_range /mnt/f2fs/src /mnt/f2fs/dst 0 0 2097152
xfs_io /mnt/f2fs/src -c "fiemap -v"
xfs_io /mnt/f2fs/dst -c "fiemap -v"

[before]
/mnt/f2fs/src:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..4095]:       8445952..8450047  4096 0x1001
/mnt/f2fs/dst:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..4095]:       143360..147455    4096 0x1001

/mnt/f2fs/src:
/mnt/f2fs/dst:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..4095]:       4284416..4288511  4096 0x1001

[after]
/mnt/f2fs/src:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..4095]:       147456..151551    4096 0x1001
/mnt/f2fs/dst:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..4095]:       151552..155647    4096 0x1001

/mnt/f2fs/src:
/mnt/f2fs/dst:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..4095]:       147456..151551    4096 0x1001

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 24 ++++++++++++------------
 fs/f2fs/segment.h |  6 ++++++
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ecb9ee80d5e0..ec3288381397 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2456,13 +2456,12 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			sbi->discard_blks--;
 
 		/*
-		 * SSR should never reuse block which is checkpointed
-		 * or newly invalidated.
+		 * if CP disabling is enable, it allows SSR to reuse newly
+		 * invalidated block, otherwise forbidding it to pretect fsyned
+		 * datas.
 		 */
-		if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
-			if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map))
-				se->ckpt_valid_blocks++;
-		}
+		if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED))
+			f2fs_set_bit(offset, se->written_map);
 	} else {
 		exist = f2fs_test_and_clear_bit(offset, se->cur_valid_map);
 #ifdef CONFIG_F2FS_CHECK_FS
@@ -2498,8 +2497,6 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			f2fs_test_and_clear_bit(offset, se->discard_map))
 			sbi->discard_blks++;
 	}
-	if (!f2fs_test_bit(offset, se->ckpt_valid_map))
-		se->ckpt_valid_blocks += del;
 
 	__mark_sit_entry_dirty(sbi, segno);
 
@@ -2847,11 +2844,11 @@ static void __get_segment_bitmap(struct f2fs_sb_info *sbi,
 	struct seg_entry *se = get_seg_entry(sbi, segno);
 	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
 	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
-	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
+	unsigned long *written_map = (unsigned long *)se->written_map;
 	int i;
 
 	for (i = 0; i < entries; i++)
-		target_map[i] = ckpt_map[i] | cur_map[i];
+		target_map[i] = ckpt_map[i] | written_map[i];
 }
 
 static int __next_free_blkoff(struct f2fs_sb_info *sbi, unsigned long *bitmap,
@@ -4529,9 +4526,9 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 
 #ifdef CONFIG_F2FS_CHECK_FS
-	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * (3 + discard_map);
+	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * (4 + discard_map);
 #else
-	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * (2 + discard_map);
+	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * (3 + discard_map);
 #endif
 	sit_i->bitmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
 	if (!sit_i->bitmap)
@@ -4546,6 +4543,9 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 		sit_i->sentries[start].ckpt_valid_map = bitmap;
 		bitmap += SIT_VBLOCK_MAP_SIZE;
 
+		sit_i->sentries[start].written_map = bitmap;
+		bitmap += SIT_VBLOCK_MAP_SIZE;
+
 #ifdef CONFIG_F2FS_CHECK_FS
 		sit_i->sentries[start].cur_valid_map_mir = bitmap;
 		bitmap += SIT_VBLOCK_MAP_SIZE;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 08d667e6a36f..eda04d9ed5a5 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -205,6 +205,10 @@ struct seg_entry {
 	 * checkpoint pack. This information is used by the SSR mode.
 	 */
 	unsigned char *ckpt_valid_map;	/* validity bitmap of blocks last cp */
+	unsigned char *written_map;	/*
+					 * blocks were written, including newly
+					 * invalidated data
+					 */
 	unsigned char *discard_map;
 	unsigned long long mtime;	/* modification time of the segment */
 };
@@ -370,6 +374,7 @@ static inline void seg_info_from_raw_sit(struct seg_entry *se,
 	se->ckpt_valid_blocks = GET_SIT_VBLOCKS(rs);
 	memcpy(se->cur_valid_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
 	memcpy(se->ckpt_valid_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
+	memcpy(se->written_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
 #ifdef CONFIG_F2FS_CHECK_FS
 	memcpy(se->cur_valid_map_mir, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
 #endif
@@ -412,6 +417,7 @@ static inline void seg_info_to_raw_sit(struct seg_entry *se,
 	__seg_info_to_raw_sit(se, rs);
 
 	memcpy(se->ckpt_valid_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
+	memcpy(se->written_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
 	se->ckpt_valid_blocks = se->valid_blocks;
 }
 
-- 
2.40.1


