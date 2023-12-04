Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD2803C36
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjLDSEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjLDSE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:04:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E6BFA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:04:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F04C433C7;
        Mon,  4 Dec 2023 18:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701713074;
        bh=PwUOwNlOAh2R10G7w1lvJbSsW8uLBZf2Vd4s/Pbn7C8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9AVu69ZIryiI3PhsohcgkW8Ue+YPlthWMUoLAFbugh0wVR0eRz52wYTvFetN7lLM
         Ayvhjb1AWpSA7eXj0iPh/lPKVtfQ3okc92q0NVjScrt7EMybF59PIyaL5i35o0omPk
         DH8fpVlcfLJ4GzcsktlKTHNrd63uPfr43VSxb/Pynleq5c4BKvZb84za+YKO9bfMeM
         Mt+umIlYcJw42krd+AtLNbJoAf8tJFx9dO67tOcW6slFzyRPyq9IGL97O05PvCp1n4
         ZHL1k3iv8Nja/QL8IBtFLS/Zc+tYm7QMtuZx9aANQUksIkTr5LhjWKdecJnoTvl91L
         ucNJDY53woRnQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: let's finish or reset zones all the time
Date:   Mon,  4 Dec 2023 10:04:28 -0800
Message-ID: <20231204180428.925779-4-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204180428.925779-1-jaegeuk@kernel.org>
References: <20231204180428.925779-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 74 +++++++++++------------------------------------
 1 file changed, 17 insertions(+), 57 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9081c9af977a..5696a4d381ff 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4870,82 +4870,44 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 				    struct f2fs_dev_info *fdev,
 				    struct blk_zone *zone)
 {
-	unsigned int wp_segno, wp_blkoff, zone_secno, zone_segno, segno;
-	block_t zone_block, wp_block, last_valid_block;
+	unsigned int zone_segno;
+	block_t zone_block, wp_block, valid_block_cnt;
 	unsigned int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
-	int i, s, b, ret;
-	struct seg_entry *se;
+	int ret;
 
 	if (zone->type != BLK_ZONE_TYPE_SEQWRITE_REQ)
 		return 0;
 
 	wp_block = fdev->start_blk + (zone->wp >> log_sectors_per_block);
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
 
@@ -4957,10 +4919,8 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
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

