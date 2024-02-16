Return-Path: <linux-kernel+bounces-69405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48071858884
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0503328C6CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BC91468F4;
	Fri, 16 Feb 2024 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT7HqGzw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69012BF0D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122731; cv=none; b=k07qA9SD2JR1jmIyU2rtdPd9ai+WVz98krBxhppxxTNAyjOzzgzL2YaLcQ62PKnFYqp3yuLbRluqgKmeEVwuE/k4ynAjjSQzrJV9HnJFhRBV/tEi2K4zJ+FtRXa/YS+As473t0BZxtP3XgDHVkzMS7FickS+lryEBge3oi6ryTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122731; c=relaxed/simple;
	bh=BNjwzfz+8rUOwJ8I6tUQYA45nCwEW2fVJcmb1pvmVYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heD1glJuWmd2AHrXjdr6I8ZbfHl39m6WBzM3Ie0HMgNOEy3T34cIjzQHyPiHXnZo92vyb1hpZPzk+CXor/SopGgXFMYedDVnlF7XWCOSLLGctVUQDTe/LSQ441SkGqmgeHqLVy4Qu/6rSIFLbCeCThFeqGA+g8pa90KQubas0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT7HqGzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F928C433F1;
	Fri, 16 Feb 2024 22:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708122731;
	bh=BNjwzfz+8rUOwJ8I6tUQYA45nCwEW2fVJcmb1pvmVYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LT7HqGzw8AW3DgO12/pwHOdv/1xgeeTvVSJyVm/jEoyEfkahOj0Y9yvKRVrdxsgYu
	 P7pGkT0+vFqnAg6/LCybblKkUMvKP+m0kJD51Z58xs2BwzSByUwAww+WZvn0qgmrmo
	 xjZlPBfFNTEIVQhU6H1Qil8jt99zACJlqE9vMqC86BrTrREejXK2drgcfp4Un8DmpN
	 qvFb8jbO29TnfaU4lqnSrUkmB09sbknwOcBXEFxE9fzlYZ3o46b0C6W/7Cp/8JE4ag
	 SLVEOxQUrn+fQrvKdt2bx01wiumnaL8aMeHuQul6L6gdPhNw7REIOw9BXnJq8cFzym
	 2mBe/PzOYJ9AQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: print zone status in string and some log
Date: Fri, 16 Feb 2024 14:32:08 -0800
Message-ID: <20240216223208.443024-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216223208.443024-1-jaegeuk@kernel.org>
References: <20240216223208.443024-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change, but add some more logs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 34 ++++++++++++++++++++++++----------
 fs/f2fs/super.c   |  1 +
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4e248be030a6..3bbb80487b13 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4855,6 +4855,16 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
+const char *f2fs_zone_status[BLK_ZONE_COND_OFFLINE + 1] = {
+	[BLK_ZONE_COND_NOT_WP]		= "NOT_WP",
+	[BLK_ZONE_COND_EMPTY]		= "EMPTY",
+	[BLK_ZONE_COND_IMP_OPEN]	= "IMPLICITE_OPEN",
+	[BLK_ZONE_COND_EXP_OPEN]	= "EXPLICITE_OPEN",
+	[BLK_ZONE_COND_CLOSED]		= "CLOSED",
+	[BLK_ZONE_COND_READONLY]	= "READONLY",
+	[BLK_ZONE_COND_FULL]		= "FULL",
+	[BLK_ZONE_COND_OFFLINE]		= "OFFLINE",
+};
 
 static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 				    struct f2fs_dev_info *fdev,
@@ -4871,18 +4881,22 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 	zone_block = fdev->start_blk + (zone->start >> log_sectors_per_block);
 	zone_segno = GET_SEGNO(sbi, zone_block);
 
+	/*
+	 * Get # of valid block of the zone.
+	 */
+	valid_block_cnt = get_valid_blocks(sbi, zone_segno, true);
+
 	/*
 	 * Skip check of zones cursegs point to, since
 	 * fix_curseg_write_pointer() checks them.
 	 */
 	if (zone_segno >= MAIN_SEGS(sbi) ||
-	    IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, zone_segno)))
+	    IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, zone_segno))) {
+		f2fs_notice(sbi, "Open zones: valid block[0x%x,0x%x] cond[%s]",
+				zone_segno, valid_block_cnt,
+				f2fs_zone_status[zone->cond]);
 		return 0;
-
-	/*
-	 * Get # of valid block of the zone.
-	 */
-	valid_block_cnt = get_valid_blocks(sbi, zone_segno, true);
+	}
 
 	if ((!valid_block_cnt && zone->cond == BLK_ZONE_COND_EMPTY) ||
 	    (valid_block_cnt && zone->cond == BLK_ZONE_COND_FULL))
@@ -4890,8 +4904,8 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 
 	if (!valid_block_cnt) {
 		f2fs_notice(sbi, "Zone without valid block has non-zero write "
-			    "pointer. Reset the write pointer: cond[0x%x]",
-			    zone->cond);
+			    "pointer. Reset the write pointer: cond[%s]",
+			    f2fs_zone_status[zone->cond]);
 		ret = __f2fs_issue_discard_zone(sbi, fdev->bdev, zone_block,
 					zone->len >> log_sectors_per_block);
 		if (ret)
@@ -4908,8 +4922,8 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 	 * selected for write operation until it get discarded.
 	 */
 	f2fs_notice(sbi, "Valid blocks are not aligned with write "
-		    "pointer: valid block[0x%x,0x%x] cond[0x%x]",
-		    zone_segno, valid_block_cnt, zone->cond);
+		    "pointer: valid block[0x%x,0x%x] cond[%s]",
+		    zone_segno, valid_block_cnt, f2fs_zone_status[zone->cond]);
 
 	ret = blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
 				zone->start, zone->len, GFP_NOFS);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a2b7a5c448b5..cb597b8e8ec5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4657,6 +4657,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * check zoned block devices' write pointer consistency.
 	 */
 	if (!f2fs_readonly(sb) && f2fs_sb_has_blkzoned(sbi)) {
+		f2fs_notice(sbi, "Checking entire write pointers");
 		err = f2fs_check_write_pointer(sbi);
 		if (err)
 			goto free_meta;
-- 
2.44.0.rc0.258.g7320e95886-goog


