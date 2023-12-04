Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B7B803C33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjLDSEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjLDSEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:04:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C259DB4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:04:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B42C433C8;
        Mon,  4 Dec 2023 18:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701713070;
        bh=mUugqGoNQY22hq7LD3Ng4JWWKEvMHSmLjfx04YNhku8=;
        h=From:To:Cc:Subject:Date:From;
        b=Ur12VQb4BP2PBWEsFOMmdyNuhOyOq9zdSRy80z1wC0D7+LaHAetoEvrqRb8zl2OrA
         V6RUsswTmytl3T/Q13d4lM8GRErmj202ovcKxAKrbhk+YnskL2w2+5Nq8eHkrxWsSA
         U2ytjP22b1y1jF4ckQB7Hs47rrKovgL1lslvSRsTvx93ilLOhIqHfJ9x+cdD0LjX8u
         oFYTcniGkb2iMOVXhyuHeDgrQ+8HQHyu9uiYJdaFF5AXSmyXEkOk4LkSb4bdzbSi5B
         HOAihdb8gM/T0oxKmrfe0hdiPqSB7hNaTXN/qGqnsvchwh26BFRLDq6SMfwBz/qrNy
         2IRyswgB7RFHg==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: allocate new section if it's not new
Date:   Mon,  4 Dec 2023 10:04:25 -0800
Message-ID: <20231204180428.925779-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
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

If fsck can allocate a new zone, it'd be better to use that instead of
allocating a new one.

And, it modifies kernel messages.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 08e2f44a1264..9081c9af977a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4949,20 +4949,18 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 		return ret;
 	}
 
-	if (is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
-		/*
-		 * If there are valid blocks and the write pointer doesn't match
-		 * with them, we need to report the inconsistency and fill
-		 * the zone till the end to close the zone. This inconsistency
-		 * does not cause write error because the zone will not be
-		 * selected for write operation until it get discarded.
-		 */
-		f2fs_notice(sbi, "Valid blocks are not aligned with write "
+	/*
+	 * If there are valid blocks and the write pointer doesn't match
+	 * with them, we need to report the inconsistency and fill
+	 * the zone till the end to close the zone. This inconsistency
+	 * does not cause write error because the zone will not be
+	 * selected for write operation until it get discarded.
+	 */
+	f2fs_notice(sbi, "Valid blocks are not aligned with write "
 			    "pointer: valid block[0x%x,0x%x] wp[0x%x,0x%x]",
 			    GET_SEGNO(sbi, last_valid_block),
 			    GET_BLKOFF_FROM_SEG0(sbi, last_valid_block),
 			    wp_segno, wp_blkoff);
-	}
 
 	ret = blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
 				zone->start, zone->len, GFP_NOFS);
@@ -5053,15 +5051,18 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 		f2fs_notice(sbi, "Unaligned curseg[%d] with write pointer: "
 			    "curseg[0x%x,0x%x] wp[0x%x,0x%x]", type, cs->segno,
 			    cs->next_blkoff, wp_segno, wp_blkoff);
-	} else {
-		f2fs_notice(sbi, "Not successfully unmounted in the previous "
-			    "mount");
 	}
 
-	f2fs_notice(sbi, "Assign new section to curseg[%d]: "
-		    "curseg[0x%x,0x%x]", type, cs->segno, cs->next_blkoff);
+	/* Allocate a new section if it's not new. */
+	if (cs->next_blkoff) {
+		unsigned int old_segno = cs->segno, old_blkoff = cs->next_blkoff;
 
-	f2fs_allocate_new_section(sbi, type, true);
+		f2fs_allocate_new_section(sbi, type, true);
+		f2fs_notice(sbi, "Assign new section to curseg[%d]: "
+				"[0x%x,0x%x] -> [0x%x,0x%x]",
+				type, old_segno, old_blkoff,
+				cs->segno, cs->next_blkoff);
+	}
 
 	/* check consistency of the zone curseg pointed to */
 	if (check_zone_write_pointer(sbi, zbd, &zone))
-- 
2.43.0.rc2.451.g8631bc7472-goog

