Return-Path: <linux-kernel+bounces-134509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEF989B25E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA99B20CB0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF63D3A1A1;
	Sun,  7 Apr 2024 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ7lvTky"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1E039FEC
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712497788; cv=none; b=lMiDYASkNnnT3m4Bh0zZQQaiIwqETv8dTsRgWm8kr3ejGZ4AVDrxjAbOsrZJEkKSooxlC04KnNccMohqqQ1uu9ZOfd2LosXk1O/pduqtGEpxIsTZb5WGx4SJhLX2QTa2G+RlsjoyOpIYyeDSNTrbkEYdDiXYnFXpuwtptpxE9uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712497788; c=relaxed/simple;
	bh=hqxjb7RfijF3LcOlQPe5piUT0kCZFUF7iZqGOdB6KRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TQv5kJi4Lah4nR4gzPVJaaZLv7VeW+I1FIwIeUFK4PjiYVok66di92SFINa7MB5YjunFyftxE4amPWR1N+fJiJs+br8U+DdPnLKasvB25cgLjMNxIkiEC/4Z5B0XUS2JSKQZ/+MxPi+s414Hj906ehbqE9Ic/LgsMYFX7QSgh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ7lvTky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9CAC433F1;
	Sun,  7 Apr 2024 13:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712497787;
	bh=hqxjb7RfijF3LcOlQPe5piUT0kCZFUF7iZqGOdB6KRE=;
	h=From:To:Cc:Subject:Date:From;
	b=DQ7lvTkyxBROmrsezaqKDaz6jzpLmcrem8kNHND6AfTU3XCg92IP+sYrQl6KdcxJc
	 +PE952KVAFEkuHP0He27hvvrXAwhIcYPbuJtziYDbemGMJ99duErfXoAK6UMcS2BMl
	 0djiIlImTGiE7nWTNs0JglWTTkIwVlw6CmCFyoMmH9aqnKp/9oSZcYVQ2z/nNR+3G6
	 iCECCG1X6vIFJ8jGESe5ARLy7OLd+BGWINwPcQ6vW0tfFUi1EejCozLtaPzBU8GCbV
	 Lbcj1VTjU1GPDDwIaQ9mQgwTh1mkUs3fw0waKOJhK7bY+ZVUbimQHH51fGu5GEYFE2
	 c0yESt4jd3DZw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 1/2] f2fs: use per-log target_bitmap to improve lookup performace of ssr allocation
Date: Sun,  7 Apr 2024 21:49:33 +0800
Message-Id: <20240407134934.3635739-1-chao@kernel.org>
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
v2:
- rebase to last dev-test branch
 fs/f2fs/segment.c | 30 ++++++++++++++++++++++--------
 fs/f2fs/segment.h |  1 +
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4fd76e867e0a..9039d60c989d 100644
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
@@ -4633,6 +4642,10 @@ static int build_curseg(struct f2fs_sb_info *sbi)
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
@@ -5451,6 +5464,7 @@ static void destroy_curseg(struct f2fs_sb_info *sbi)
 	for (i = 0; i < NR_CURSEG_TYPE; i++) {
 		kfree(array[i].sum_blk);
 		kfree(array[i].journal);
+		kfree(array[i].target_map);
 	}
 	kfree(array);
 }
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index e1c0f418aa11..10f3e44f036f 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -292,6 +292,7 @@ struct curseg_info {
 	struct f2fs_summary_block *sum_blk;	/* cached summary block */
 	struct rw_semaphore journal_rwsem;	/* protect journal area */
 	struct f2fs_journal *journal;		/* cached journal info */
+	unsigned long *target_map;		/* bitmap for SSR allocator */
 	unsigned char alloc_type;		/* current allocation type */
 	unsigned short seg_type;		/* segment type like CURSEG_XXX_TYPE */
 	unsigned int segno;			/* current segment number */
-- 
2.40.1


