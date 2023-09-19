Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2BC7A6266
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjISMQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjISMQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:16:20 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195B0FB;
        Tue, 19 Sep 2023 05:16:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RqgcR43PLz4f3xsY;
        Tue, 19 Sep 2023 20:16:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnOA0DkQllO8FpAw--.40065S4;
        Tue, 19 Sep 2023 20:16:08 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/12] ext4: factor out codes to update block bitmap and group descriptor on disk from ext4_mb_mark_bb
Date:   Wed, 20 Sep 2023 04:15:22 +0800
Message-Id: <20230919201532.310085-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230919201532.310085-1-shikemeng@huaweicloud.com>
References: <20230919201532.310085-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnOA0DkQllO8FpAw--.40065S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtrWrZFy7WFW5Kw1DKr4fuFg_yoW7uFWUpF
        9IyF1DCr43JrnruF43W34jq3WrGw109w1kGryfC345CF4ayr95WF1xKFyS9as0yFZrZFnF
        qF1Yya1xur1rWrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jy9aPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several reasons to add a general function ext4_mb_mark_context
to update block bitmap and group descriptor on disk:
1. pair behavior of alloc/free bits. For example,
ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
2. remove repeat code to read from disk, update and write back to disk.
3. reduce future unit test mocks to catch real IO to update structure
on disk.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 147 ++++++++++++++++++++++++----------------------
 1 file changed, 77 insertions(+), 70 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index cf09adfbaf11..e1320eea46e9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3953,6 +3953,80 @@ void ext4_exit_mballoc(void)
 	ext4_groupinfo_destroy_slabs();
 }
 
+static int
+ext4_mb_mark_context(struct super_block *sb, bool state, ext4_group_t group,
+		     ext4_grpblk_t blkoff, ext4_grpblk_t len)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct buffer_head *bitmap_bh = NULL;
+	struct ext4_group_desc *gdp;
+	struct buffer_head *gdp_bh;
+	int err;
+	unsigned int i, already, changed;
+
+	bitmap_bh = ext4_read_block_bitmap(sb, group);
+	if (IS_ERR(bitmap_bh))
+		return PTR_ERR(bitmap_bh);
+
+	err = -EIO;
+	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
+	if (!gdp)
+		goto out_err;
+
+	ext4_lock_group(sb, group);
+	if (ext4_has_group_desc_csum(sb) &&
+	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
+		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
+		ext4_free_group_clusters_set(sb, gdp,
+			ext4_free_clusters_after_init(sb, group, gdp));
+	}
+
+	already = 0;
+	for (i = 0; i < len; i++)
+		if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
+				state)
+			already++;
+	changed = len - already;
+
+	if (state) {
+		mb_set_bits(bitmap_bh->b_data, blkoff, len);
+		ext4_free_group_clusters_set(sb, gdp,
+			ext4_free_group_clusters(sb, gdp) - changed);
+	} else {
+		mb_clear_bits(bitmap_bh->b_data, blkoff, len);
+		ext4_free_group_clusters_set(sb, gdp,
+			ext4_free_group_clusters(sb, gdp) + changed);
+	}
+
+	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
+	ext4_group_desc_csum_set(sb, group, gdp);
+	ext4_unlock_group(sb, group);
+
+	if (sbi->s_log_groups_per_flex) {
+		ext4_group_t flex_group = ext4_flex_group(sbi, group);
+		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
+					   s_flex_groups, flex_group);
+
+		if (state)
+			atomic64_sub(changed, &fg->free_clusters);
+		else
+			atomic64_add(changed, &fg->free_clusters);
+	}
+
+	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
+	if (err)
+		goto out_err;
+	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
+	if (err)
+		goto out_err;
+
+	sync_dirty_buffer(bitmap_bh);
+	sync_dirty_buffer(gdp_bh);
+
+out_err:
+	brelse(bitmap_bh);
+	return err;
+}
 
 /*
  * Check quota and mark chosen space (ac->ac_b_ex) non-free in bitmaps
@@ -4079,15 +4153,11 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 		     int len, bool state)
 {
-	struct buffer_head *bitmap_bh = NULL;
-	struct ext4_group_desc *gdp;
-	struct buffer_head *gdp_bh;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_group_t group;
 	ext4_grpblk_t blkoff;
-	int i, err = 0;
-	int already;
-	unsigned int clen, clen_changed, thisgrp_len;
+	int err = 0;
+	unsigned int clen, thisgrp_len;
 
 	while (len > 0) {
 		ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
@@ -4108,80 +4178,17 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 			ext4_error(sb, "Marking blocks in system zone - "
 				   "Block = %llu, len = %u",
 				   block, thisgrp_len);
-			bitmap_bh = NULL;
 			break;
 		}
 
-		bitmap_bh = ext4_read_block_bitmap(sb, group);
-		if (IS_ERR(bitmap_bh)) {
-			err = PTR_ERR(bitmap_bh);
-			bitmap_bh = NULL;
-			break;
-		}
-
-		err = -EIO;
-		gdp = ext4_get_group_desc(sb, group, &gdp_bh);
-		if (!gdp)
-			break;
-
-		ext4_lock_group(sb, group);
-		already = 0;
-		for (i = 0; i < clen; i++)
-			if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
-					 !state)
-				already++;
-
-		clen_changed = clen - already;
-		if (state)
-			mb_set_bits(bitmap_bh->b_data, blkoff, clen);
-		else
-			mb_clear_bits(bitmap_bh->b_data, blkoff, clen);
-		if (ext4_has_group_desc_csum(sb) &&
-		    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
-			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
-			ext4_free_group_clusters_set(sb, gdp,
-			     ext4_free_clusters_after_init(sb, group, gdp));
-		}
-		if (state)
-			clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
-		else
-			clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
-
-		ext4_free_group_clusters_set(sb, gdp, clen);
-		ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
-		ext4_group_desc_csum_set(sb, group, gdp);
-
-		ext4_unlock_group(sb, group);
-
-		if (sbi->s_log_groups_per_flex) {
-			ext4_group_t flex_group = ext4_flex_group(sbi, group);
-			struct flex_groups *fg = sbi_array_rcu_deref(sbi,
-						   s_flex_groups, flex_group);
-
-			if (state)
-				atomic64_sub(clen_changed, &fg->free_clusters);
-			else
-				atomic64_add(clen_changed, &fg->free_clusters);
-
-		}
-
-		err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
-		if (err)
-			break;
-		sync_dirty_buffer(bitmap_bh);
-		err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
-		sync_dirty_buffer(gdp_bh);
+		err = ext4_mb_mark_context(sb, state, group, blkoff, clen);
 		if (err)
 			break;
 
 		block += thisgrp_len;
 		len -= thisgrp_len;
-		brelse(bitmap_bh);
 		BUG_ON(len < 0);
 	}
-
-	if (err)
-		brelse(bitmap_bh);
 }
 
 /*
-- 
2.30.0

