Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3C3805EA0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbjLET3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLET3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:29:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFD1A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 11:29:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D86DC433C7;
        Tue,  5 Dec 2023 19:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701804585;
        bh=icfD1/c6dcAxTv3VQ2Fva2oj2NvRmskfgjhm2BQup5k=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=FLdOiwErQLm7TnmxWUgGRAwvpuE6c6fqacxbNJxs3SVnrAEp128VpkzWAIZmulnfS
         gHubPTgp1bIwILDDmksZXSkRZZD+XcRlJe8bHYeqvojNnywR6j87YLSj3d+bbYuE13
         rj37I/yK8IiLzfZcSC4xKKavNqhIFfYwAhbPZtVjqhCX4RUbfskRGjKCP9ORnb3JAt
         aQbwuWwC3SBRoSg22BsWg0+XGqhR8bHQVgYQOQiSEMH5yddJasHYp2wmD9eu8kXo0l
         ErXeRLHD4+hmvuvAQpAxKTPp2TiIrT1OwfwbzKvn9DbP1DCpQwucO/yZysr6YeiADY
         lcZK0HSEC5l1g==
Date:   Tue, 5 Dec 2023 11:29:43 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/4 v2] f2fs: let's finish or reset zones all the time
Message-ID: <ZW96J6UnvzHgPqb1@google.com>
References: <20231204180428.925779-1-jaegeuk@kernel.org>
 <20231204180428.925779-4-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204180428.925779-4-jaegeuk@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to limit # of open zones, let's finish or reset zones given # of
valid blocks per section and its zone condition.

Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 - remove unnecessary wp_block

 fs/f2fs/segment.c | 75 +++++++++++------------------------------------
 1 file changed, 17 insertions(+), 58 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9081c9af977a..007ebb107236 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4870,82 +4870,43 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 				    struct f2fs_dev_info *fdev,
 				    struct blk_zone *zone)
 {
-	unsigned int wp_segno, wp_blkoff, zone_secno, zone_segno, segno;
-	block_t zone_block, wp_block, last_valid_block;
+	unsigned int zone_segno;
+	block_t zone_block, valid_block_cnt;
 	unsigned int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
-	int i, s, b, ret;
-	struct seg_entry *se;
+	int ret;
 
 	if (zone->type != BLK_ZONE_TYPE_SEQWRITE_REQ)
 		return 0;
 
-	wp_block = fdev->start_blk + (zone->wp >> log_sectors_per_block);
-	wp_segno = GET_SEGNO(sbi, wp_block);
-	wp_blkoff = wp_block - START_BLOCK(sbi, wp_segno);
 	zone_block = fdev->start_blk + (zone->start >> log_sectors_per_block);
 	zone_segno = GET_SEGNO(sbi, zone_block);
-	zone_secno = GET_SEC_FROM_SEG(sbi, zone_segno);
-
-	if (zone_segno >= MAIN_SEGS(sbi))
-		return 0;
 
 	/*
 	 * Skip check of zones cursegs point to, since
 	 * fix_curseg_write_pointer() checks them.
 	 */
-	for (i = 0; i < NO_CHECK_TYPE; i++)
-		if (zone_secno == GET_SEC_FROM_SEG(sbi,
-						   CURSEG_I(sbi, i)->segno))
-			return 0;
+	if (zone_segno >= MAIN_SEGS(sbi) ||
+	    IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, zone_segno)))
+		return 0;
 
 	/*
-	 * Get last valid block of the zone.
+	 * Get # of valid block of the zone.
 	 */
-	last_valid_block = zone_block - 1;
-	for (s = sbi->segs_per_sec - 1; s >= 0; s--) {
-		segno = zone_segno + s;
-		se = get_seg_entry(sbi, segno);
-		for (b = sbi->blocks_per_seg - 1; b >= 0; b--)
-			if (f2fs_test_bit(b, se->cur_valid_map)) {
-				last_valid_block = START_BLOCK(sbi, segno) + b;
-				break;
-			}
-		if (last_valid_block >= zone_block)
-			break;
-	}
+	valid_block_cnt = get_valid_blocks(sbi, zone_segno, true);
 
-	/*
-	 * When safely unmounted in the previous mount, we can trust write
-	 * pointers. Otherwise, finish zones.
-	 */
-	if (is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
-		/*
-		 * The write pointer matches with the valid blocks or
-		 * already points to the end of the zone.
-		 */
-		if ((last_valid_block + 1 == wp_block) ||
-				(zone->wp == zone->start + zone->len))
-			return 0;
-	}
+	if ((!valid_block_cnt && zone->cond == BLK_ZONE_COND_EMPTY) ||
+	    (valid_block_cnt && zone->cond == BLK_ZONE_COND_FULL))
+		return 0;
 
-	if (last_valid_block + 1 == zone_block) {
-		if (is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
-			/*
-			 * If there is no valid block in the zone and if write
-			 * pointer is not at zone start, reset the write
-			 * pointer.
-			 */
-			f2fs_notice(sbi,
-			      "Zone without valid block has non-zero write "
-			      "pointer. Reset the write pointer: wp[0x%x,0x%x]",
-			      wp_segno, wp_blkoff);
-		}
+	if (!valid_block_cnt) {
+		f2fs_notice(sbi, "Zone without valid block has non-zero write "
+			    "pointer. Reset the write pointer: cond[0x%x]",
+			    zone->cond);
 		ret = __f2fs_issue_discard_zone(sbi, fdev->bdev, zone_block,
 					zone->len >> log_sectors_per_block);
 		if (ret)
 			f2fs_err(sbi, "Discard zone failed: %s (errno=%d)",
 				 fdev->path, ret);
-
 		return ret;
 	}
 
@@ -4957,10 +4918,8 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 	 * selected for write operation until it get discarded.
 	 */
 	f2fs_notice(sbi, "Valid blocks are not aligned with write "
-			    "pointer: valid block[0x%x,0x%x] wp[0x%x,0x%x]",
-			    GET_SEGNO(sbi, last_valid_block),
-			    GET_BLKOFF_FROM_SEG0(sbi, last_valid_block),
-			    wp_segno, wp_blkoff);
+		    "pointer: valid block[0x%x,0x%x] cond[0x%x]",
+		    zone_segno, valid_block_cnt, zone->cond);
 
 	ret = blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
 				zone->start, zone->len, GFP_NOFS);
-- 
2.43.0.rc2.451.g8631bc7472-goog

