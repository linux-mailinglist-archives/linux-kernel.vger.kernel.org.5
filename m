Return-Path: <linux-kernel+bounces-140070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF98A0B13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6B21C21AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B89813FD7E;
	Thu, 11 Apr 2024 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWecwx1y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D3026ACC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823843; cv=none; b=JCZ9Ebuox3Fvm5Dn0lfOm/A1t8uXlVdzE03WT2mvOX/lgNfG7ACSWUuFsg86BprjOhX+vbqEEvWgIbg0ulXjPfLva3rC2VvRhagVW27yhbNqCmEOiov8QwFwPdo8R3f2Kig7iEeVSwreiZki/maCGrHkId+WirzYks2DLx91L6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823843; c=relaxed/simple;
	bh=HGrPWL/UFBpYufo7bXlquMGLiLIjYpTaziY24qzx4y8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BcQufiYg2EPyZZViIztcrQ6UUvCMVwtK0ArahOIak2kcJXJqAQWh20MgZNmbaxG05bdLJZPu3zVKjH4j4L6N84mfNBRrBw5Co5lSCRxZkRiBHa5LvQWg9MKqFrF1kzZA8iC6rFTsGOdiSFnlTkEV2XnqZ79/ysn4CRJ5+PACou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWecwx1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EB9C433C7;
	Thu, 11 Apr 2024 08:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712823843;
	bh=HGrPWL/UFBpYufo7bXlquMGLiLIjYpTaziY24qzx4y8=;
	h=From:To:Cc:Subject:Date:From;
	b=fWecwx1yk0PFl68/D7X5P0gstlR7wk3ZmH6pWAtzw28T+Xl/Xl0CQlVKuQL1obn0v
	 1CEv7whB+3wOvRes7t39a7EVus2VGM+FFfqH97Px4ZwQ4dPNemPtHkV1snHKFQjFF8
	 fvPe7VcF3Dw4obej4Zk2IIcOdKc0wOIDC9Xdd9/criA4UGZ7vvQZLlS/OAIl+0EbOb
	 uljL5UBwckorfQoRp3oWw2iA+mA3aD9tA8uMfhU7HnxpAI9Bh93xE0tVp85XovHNzq
	 VhlJEeGF8CfRV7g3140ia+ExaTJV/GyKurMT74ILFtuInSG+57MEWccxGOW9jpTLye
	 xjY0oGWbgRMdg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 1/2] f2fs: use per-log target_bitmap to improve lookup performace of ssr allocation
Date: Thu, 11 Apr 2024 16:23:53 +0800
Message-Id: <20240411082354.1691820-1-chao@kernel.org>
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
- rebase to last dev-test branch.
 fs/f2fs/segment.c | 30 ++++++++++++++++++++++--------
 fs/f2fs/segment.h |  1 +
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6474b7338e81..af716925db19 100644
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
@@ -4635,6 +4644,10 @@ static int build_curseg(struct f2fs_sb_info *sbi)
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
@@ -5453,6 +5466,7 @@ static void destroy_curseg(struct f2fs_sb_info *sbi)
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


