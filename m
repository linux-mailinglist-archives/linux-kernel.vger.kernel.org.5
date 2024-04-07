Return-Path: <linux-kernel+bounces-134390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495BB89B0EB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDB9281F8E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D71374FB;
	Sun,  7 Apr 2024 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akv/2Iv9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6AB2BAE8
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712494921; cv=none; b=TBGzh5eiJ51V1eHmhXfbDDyLWgj++AynBQBcoHFW/b7q1z+9NTvVwk+Q7DbTGaW7huGfviJGwyHTLHAROcpVFJGahJP1K0dBgeWP45XtFYqOo0yXamOacR9o6rCBSInuY5riWeXbtdUQHG2VNoNeolobdU6ltClTAR1nC1dIzSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712494921; c=relaxed/simple;
	bh=83E515a2nO7sRb4gFRv6JWkPvQiwSgf/9QRVASfeg24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=esNmTPye+j7m7Zp3fBSae+4F56ABCVT1OpCXb4qWLSYF7PAOu8+ITbOvNXdFmsXbeF04ATgGLUhftgwqOJoPQik/JgG230LIUt+yTAmrF98wpg+K/F/hjq2mGj+7j787GYrrpA5r+COxtzMm1RMgzg9iBBNgY4lPQnK/9vpOWVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akv/2Iv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A97C433C7;
	Sun,  7 Apr 2024 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712494921;
	bh=83E515a2nO7sRb4gFRv6JWkPvQiwSgf/9QRVASfeg24=;
	h=From:To:Cc:Subject:Date:From;
	b=akv/2Iv9tOQN9h9nheDTrnyaoqEAJVxBglrU0gpJtOIebqXXkg/adFuM68hRzfiQ2
	 ioXnCXgGAg8OQlmyQuAaKaGIKLJzD/v4SZ4h3RSVujiS7knJ7D6oVD/AUb6/pQJSIq
	 NkA/MnwxzWnvlVDT2J395YklxKlLJNcnaTD6yzy0qtgtVyCVp/YX3d91HnM2bLeMsR
	 3ISX11LLmkX5CGMwunJMXjzf1MPVzPpBecFSVZiC6UXLyZQpQiWXtRwLNDxBIcw6Nc
	 U+j9F1LP0Q5W6qqRrQmQdcCVN+b5yAFTuvC+8l2w7FwmUFOZGbbLcVjFPe0HAuuvc7
	 ObMcskCm7RnKg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: use per-log target_bitmap to improve lookup performace of ssr allocation
Date: Sun,  7 Apr 2024 21:01:54 +0800
Message-Id: <20240407130155.3602415-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 899fee36fac0 ("f2fs: fix to avoid data corruption by
forbidding SSR overwrite"), valid block bitmap of current openned
segment is fixed, let's introduce a per-log bitmap instead of temp
bitmap to avoid unnecessary calculation overhead whenever allocating
free slot w/ SSR allocator.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 30 ++++++++++++++++++++++--------
 fs/f2fs/segment.h |  1 +
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4a3cf2888faf..ecb9ee80d5e0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2840,31 +2840,39 @@ static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 	return 0;
 }
 
-static int __next_free_blkoff(struct f2fs_sb_info *sbi,
-					int segno, block_t start)
+static void __get_segment_bitmap(struct f2fs_sb_info *sbi,
+					unsigned long *target_map,
+					int segno)
 {
 	struct seg_entry *se = get_seg_entry(sbi, segno);
 	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
-	unsigned long *target_map = SIT_I(sbi)->tmp_map;
 	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
 	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
 	int i;
 
 	for (i = 0; i < entries; i++)
 		target_map[i] = ckpt_map[i] | cur_map[i];
+}
+
+static int __next_free_blkoff(struct f2fs_sb_info *sbi, unsigned long *bitmap,
+					int segno, block_t start)
+{
+	__get_segment_bitmap(sbi, bitmap, segno);
 
-	return __find_rev_next_zero_bit(target_map, BLKS_PER_SEG(sbi), start);
+	return __find_rev_next_zero_bit(bitmap, BLKS_PER_SEG(sbi), start);
 }
 
 static int f2fs_find_next_ssr_block(struct f2fs_sb_info *sbi,
-		struct curseg_info *seg)
+					struct curseg_info *seg)
 {
-	return __next_free_blkoff(sbi, seg->segno, seg->next_blkoff + 1);
+	return __find_rev_next_zero_bit(seg->target_map,
+				BLKS_PER_SEG(sbi), seg->next_blkoff + 1);
 }
 
 bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
 {
-	return __next_free_blkoff(sbi, segno, 0) < BLKS_PER_SEG(sbi);
+	return __next_free_blkoff(sbi, SIT_I(sbi)->tmp_map, segno, 0) <
+							BLKS_PER_SEG(sbi);
 }
 
 /*
@@ -2890,7 +2898,8 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
 
 	reset_curseg(sbi, type, 1);
 	curseg->alloc_type = SSR;
-	curseg->next_blkoff = __next_free_blkoff(sbi, curseg->segno, 0);
+	curseg->next_blkoff = __next_free_blkoff(sbi, curseg->target_map,
+							curseg->segno, 0);
 
 	sum_page = f2fs_get_sum_page(sbi, new_segno);
 	if (IS_ERR(sum_page)) {
@@ -4652,6 +4661,10 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 				sizeof(struct f2fs_journal), GFP_KERNEL);
 		if (!array[i].journal)
 			return -ENOMEM;
+		array[i].target_map = f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE,
+								GFP_KERNEL);
+		if (!array[i].target_map)
+			return -ENOMEM;
 		if (i < NR_PERSISTENT_LOG)
 			array[i].seg_type = CURSEG_HOT_DATA + i;
 		else if (i == CURSEG_COLD_DATA_PINNED)
@@ -5470,6 +5483,7 @@ static void destroy_curseg(struct f2fs_sb_info *sbi)
 	for (i = 0; i < NR_CURSEG_TYPE; i++) {
 		kfree(array[i].sum_blk);
 		kfree(array[i].journal);
+		kfree(array[i].target_map);
 
 #ifdef CONFIG_BLK_DEV_ZONED
 		if (f2fs_sb_has_blkzoned(sbi)) {
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 855978ca869f..08d667e6a36f 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -293,6 +293,7 @@ struct curseg_info {
 	struct f2fs_summary_block *sum_blk;	/* cached summary block */
 	struct rw_semaphore journal_rwsem;	/* protect journal area */
 	struct f2fs_journal *journal;		/* cached journal info */
+	unsigned long *target_map;		/* bitmap for SSR allocator */
 	unsigned char alloc_type;		/* current allocation type */
 	unsigned short seg_type;		/* segment type like CURSEG_XXX_TYPE */
 	unsigned int segno;			/* current segment number */
-- 
2.40.1


