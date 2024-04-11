Return-Path: <linux-kernel+bounces-140071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809E38A0B14
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40F71C21FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03997140E2F;
	Thu, 11 Apr 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBO7JyDp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A3C26ACC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823847; cv=none; b=JNh+pebBAN45d1+wr+Suty1frMm8MwCZM1v5aSSXBPMttXemd+cgpdjMQH9NZpLG1nZvE6F+Dh4Xi+8ssSPaguYAPcZ7QzamadNjhajszq20PPcYA3tCiN+oJ6CcumMnz5wbCPIWPj//Hb0A/xcSkAhq3hs+/rvw7pRZFkBVveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823847; c=relaxed/simple;
	bh=1hvUBYI/Rg9a1ewLzoki6lOEsbXv62celAuWn3Eyce4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKuqGLczeL9kIYydim6cV5x1u3Bp3TLUpTT+7zy9eTxvRCCH26ZbHZLH3LYA4oJq7QqjWYB/HP9ODLTZMHOMM6mDDvuEO3fiIpZY/YqFNeqe1sgqweeKSZADeX7fIrOgTVlJpg4QaCvLK76Ocm5wXf94uQtIlsSwu1XdYsqI2iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBO7JyDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB15C433F1;
	Thu, 11 Apr 2024 08:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712823846;
	bh=1hvUBYI/Rg9a1ewLzoki6lOEsbXv62celAuWn3Eyce4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LBO7JyDp9Z7Qfi+TjJIrQJLvtZM7idRVKoSbN14Z98ReA0VGOLXiqvI5fZbzVvw0a
	 bXIfjeXNbFpBApDcNGi79qinkcxy6+e8BIaUe5R+ZTEHMg0Rh4Ipawcs709UfBxTOL
	 eHo93ey64etY/MDir4ZWtG7J7LVpYzkvmfscUsE40eAmDoJtGRLs0lr59MNzm57OLr
	 IxBqbQLQUdlxuc3zW8gk8Ay4/2r7ldC25JM+6klvJFbYbVcKHipvFXk6Tzou8SE3jj
	 GOtwSKdYYDwHQPIP/4coNnr0sn4xMgSyGbtF6rw350BzlUPg+oy+DOy6lDjyAK6hV9
	 zg/bPrBX4pAoQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/2] f2fs: introduce written_map to indicate written datas
Date: Thu, 11 Apr 2024 16:23:54 +0800
Message-Id: <20240411082354.1691820-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240411082354.1691820-1-chao@kernel.org>
References: <20240411082354.1691820-1-chao@kernel.org>
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
v2:
- introduce written_blocks in struct seg_entry for
ssr allocator.
 fs/f2fs/gc.c      |  2 +-
 fs/f2fs/segment.c | 22 ++++++++++++----------
 fs/f2fs/segment.h | 19 ++++++++++++++-----
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8852814dab7f..ea7b5ca6f09b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -366,7 +366,7 @@ static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct victim_sel_policy *p)
 {
 	if (p->alloc_mode == SSR)
-		return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
+		return get_seg_entry(sbi, segno)->written_blocks;
 
 	/* alloc_mode == LFS */
 	if (p->gc_mode == GC_GREEDY)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index af716925db19..0d110908e383 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2456,12 +2456,13 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			sbi->discard_blks--;
 
 		/*
-		 * SSR should never reuse block which is checkpointed
-		 * or newly invalidated.
+		 * if CP disabling is enable, it allows SSR to reuse newly
+		 * invalidated block, otherwise forbidding it to pretect fsyned
+		 * datas.
 		 */
 		if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
-			if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map))
-				se->ckpt_valid_blocks++;
+			if (!f2fs_test_and_set_bit(offset, se->written_map))
+				se->written_blocks++;
 		}
 	} else {
 		exist = f2fs_test_and_clear_bit(offset, se->cur_valid_map);
@@ -2498,8 +2499,6 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			f2fs_test_and_clear_bit(offset, se->discard_map))
 			sbi->discard_blks++;
 	}
-	if (!f2fs_test_bit(offset, se->ckpt_valid_map))
-		se->ckpt_valid_blocks += del;
 
 	__mark_sit_entry_dirty(sbi, segno);
 
@@ -2847,11 +2846,11 @@ static void __get_segment_bitmap(struct f2fs_sb_info *sbi,
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
@@ -4512,9 +4511,9 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
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
@@ -4529,6 +4528,9 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 		sit_i->sentries[start].ckpt_valid_map = bitmap;
 		bitmap += SIT_VBLOCK_MAP_SIZE;
 
+		sit_i->sentries[start].written_map = bitmap;
+		bitmap += SIT_VBLOCK_MAP_SIZE;
+
 #ifdef CONFIG_F2FS_CHECK_FS
 		sit_i->sentries[start].cur_valid_map_mir = bitmap;
 		bitmap += SIT_VBLOCK_MAP_SIZE;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 10f3e44f036f..71131a0b00d7 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -191,10 +191,11 @@ struct victim_sel_policy {
 };
 
 struct seg_entry {
-	unsigned int type:6;		/* segment type like CURSEG_XXX_TYPE */
-	unsigned int valid_blocks:10;	/* # of valid blocks */
-	unsigned int ckpt_valid_blocks:10;	/* # of valid blocks last cp */
-	unsigned int padding:6;		/* padding */
+	unsigned long long type:6;		/* segment type like CURSEG_XXX_TYPE */
+	unsigned long long valid_blocks:10;	/* # of valid blocks */
+	unsigned long long ckpt_valid_blocks:10;/* # of valid blocks last cp */
+	unsigned long long written_blocks:10;	/* # of written blocks */
+	unsigned long long padding:28;		/* padding */
 	unsigned char *cur_valid_map;	/* validity bitmap of blocks */
 #ifdef CONFIG_F2FS_CHECK_FS
 	unsigned char *cur_valid_map_mir;	/* mirror of current valid bitmap */
@@ -204,6 +205,10 @@ struct seg_entry {
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
@@ -366,9 +371,11 @@ static inline void seg_info_from_raw_sit(struct seg_entry *se,
 					struct f2fs_sit_entry *rs)
 {
 	se->valid_blocks = GET_SIT_VBLOCKS(rs);
-	se->ckpt_valid_blocks = GET_SIT_VBLOCKS(rs);
+	se->ckpt_valid_blocks = se->valid_blocks;
+	se->written_blocks = se->valid_blocks;
 	memcpy(se->cur_valid_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
 	memcpy(se->ckpt_valid_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
+	memcpy(se->written_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
 #ifdef CONFIG_F2FS_CHECK_FS
 	memcpy(se->cur_valid_map_mir, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
 #endif
@@ -411,7 +418,9 @@ static inline void seg_info_to_raw_sit(struct seg_entry *se,
 	__seg_info_to_raw_sit(se, rs);
 
 	memcpy(se->ckpt_valid_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
+	memcpy(se->written_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
 	se->ckpt_valid_blocks = se->valid_blocks;
+	se->written_blocks = se->valid_blocks;
 }
 
 static inline unsigned int find_next_inuse(struct free_segmap_info *free_i,
-- 
2.40.1


