Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2BD7F88E5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjKYHnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYHm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:42:59 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EBA10FB;
        Fri, 24 Nov 2023 23:42:57 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SckND1h0kz4f3kKv;
        Sat, 25 Nov 2023 15:42:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
        by mail.maildlp.com (Postfix) with ESMTP id 05F4C1A0373;
        Sat, 25 Nov 2023 15:42:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgCX7Ut8pWFlk8TCBw--.12413S7;
        Sat, 25 Nov 2023 15:42:54 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ext4: Add unit test for ext4_mb_mark_diskspace_used
Date:   Sat, 25 Nov 2023 23:41:44 +0800
Message-Id: <20231125154144.3943442-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231125154144.3943442-1-shikemeng@huaweicloud.com>
References: <20231125154144.3943442-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCX7Ut8pWFlk8TCBw--.12413S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4ktFW5Aw4xXw43Zr17GFg_yoW5Gryfpa
        15urn0kr45XrnxWr43WrZrC3W3Kw4kZrWktryfWrn0qF47GF98Aa10kF15Gw48Jr4kXa43
        Z3Wqqa47Gr4xCrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3XTQUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add unit test for ext4_mb_mark_diskspace_used

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc-test.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index b68f44740..8d5d27ab5 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -470,6 +470,59 @@ static void test_free_blocks_simple(struct kunit *test)
 			ranges[i].start, ranges[i].len);
 }
 
+static void
+test_mark_diskspace_used_range(struct kunit *test,
+			       struct ext4_allocation_context *ac,
+			       ext4_grpblk_t start,
+			       ext4_grpblk_t len)
+{
+	struct super_block *sb = (struct super_block *)test->priv;
+	int ret;
+	void *bitmap;
+	ext4_grpblk_t i, max;
+
+	/* ext4_mb_mark_diskspace_used will BUG if len is 0 */
+	if (len == 0)
+		return;
+
+	ac->ac_b_ex.fe_group = TEST_GOAL_GROUP;
+	ac->ac_b_ex.fe_start = start;
+	ac->ac_b_ex.fe_len = len;
+
+	bitmap = mbt_ctx_bitmap(sb, TEST_GOAL_GROUP);
+	memset(bitmap, 0, sb->s_blocksize);
+	ret = ext4_mb_mark_diskspace_used(ac, NULL, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	max = EXT4_CLUSTERS_PER_GROUP(sb);
+	i = mb_find_next_bit(bitmap, max, 0);
+	KUNIT_ASSERT_EQ(test, i, start);
+	i = mb_find_next_zero_bit(bitmap, max, i + 1);
+	KUNIT_ASSERT_EQ(test, i, start + len);
+	i = mb_find_next_bit(bitmap, max, i + 1);
+	KUNIT_ASSERT_EQ(test, max, i);
+}
+
+static void test_mark_diskspace_used(struct kunit *test)
+{
+	struct super_block *sb = (struct super_block *)test->priv;
+	struct inode inode = { .i_sb = sb, };
+	ext4_grpblk_t max;
+	struct ext4_allocation_context ac;
+	struct test_range ranges[TEST_RANGE_COUNT];
+	int i;
+
+	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
+
+	ac.ac_status = AC_STATUS_FOUND;
+	ac.ac_sb = sb;
+	ac.ac_inode = &inode;
+	max = EXT4_CLUSTERS_PER_GROUP(sb);
+	for (i = 0; i < TEST_RANGE_COUNT; i++)
+		test_mark_diskspace_used_range(test, &ac, ranges[i].start,
+					       ranges[i].len);
+}
+
 static void mbt_generate_buddy(struct super_block *sb, void *buddy,
 			       void *bitmap, struct ext4_group_info *grp)
 {
@@ -784,6 +837,7 @@ static struct kunit_case mbt_test_cases[] = {
 	KUNIT_CASE_PARAM(test_mb_generate_buddy, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_mb_mark_used, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_mb_free_blocks, mbt_layouts_gen_params),
+	KUNIT_CASE_PARAM(test_mark_diskspace_used, mbt_layouts_gen_params),
 	{}
 };
 
-- 
2.30.0

