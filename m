Return-Path: <linux-kernel+bounces-15093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DC482272E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AC11C22C33
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87C110A32;
	Wed,  3 Jan 2024 02:51:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999801798A;
	Wed,  3 Jan 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4Z3N0YtXz4f3mWk;
	Wed,  3 Jan 2024 10:50:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C9F251A082B;
	Wed,  3 Jan 2024 10:50:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3U0SNy5RlDGn8FQ--.36935S5;
	Wed, 03 Jan 2024 10:50:57 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] ext4: Add unit test for mb_mark_used
Date: Wed,  3 Jan 2024 18:48:58 +0800
Message-Id: <20240103104900.464789-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240103104900.464789-1-shikemeng@huaweicloud.com>
References: <20240103104900.464789-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3U0SNy5RlDGn8FQ--.36935S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4ktFW8CF13tF4fJrWkWFg_yoWrCr4xpF
	Z8Cr1Ykr45Wrnru3yfGrWqv3WSgw1kZrWkKryxWw15ZFyayr93GF1kKF1UAF4FyF4xXFsx
	Z3WYqry7Gr4xua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3G-eDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Add unit test for mb_mark_used

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc-test.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 6964974fa..38e3644cb 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -148,9 +148,13 @@ static void mbt_init_sb_layout(struct super_block *sb,
 static int mbt_grp_ctx_init(struct super_block *sb,
 			    struct mbt_grp_ctx *grp_ctx)
 {
+	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
+
 	grp_ctx->bitmap_bh.b_data = kzalloc(EXT4_BLOCK_SIZE(sb), GFP_KERNEL);
 	if (grp_ctx->bitmap_bh.b_data == NULL)
 		return -ENOMEM;
+	mb_set_bits(grp_ctx->bitmap_bh.b_data, max, sb->s_blocksize * 8 - max);
+	ext4_free_group_clusters_set(sb, &grp_ctx->desc, max);
 
 	return 0;
 }
@@ -197,6 +201,8 @@ static int mbt_ctx_init(struct super_block *sb)
 	 * block which will fail ext4_sb_block_valid check.
 	 */
 	mb_set_bits(ctx->grp_ctx[0].bitmap_bh.b_data, 0, 1);
+	ext4_free_group_clusters_set(sb, &ctx->grp_ctx[0].desc,
+				     EXT4_CLUSTERS_PER_GROUP(sb) - 1);
 
 	return 0;
 out:
@@ -231,6 +237,13 @@ static int ext4_wait_block_bitmap_stub(struct super_block *sb,
 				       ext4_group_t block_group,
 				       struct buffer_head *bh)
 {
+	/*
+	 * real ext4_wait_block_bitmap will set these flags and
+	 * functions like ext4_mb_init_cache will verify the flags.
+	 */
+	set_buffer_uptodate(bh);
+	set_bitmap_uptodate(bh);
+	set_buffer_verified(bh);
 	return 0;
 }
 
@@ -598,6 +611,70 @@ static void test_mb_generate_buddy(struct kunit *test)
 	}
 }
 
+static void
+test_mb_mark_used_range(struct kunit *test, struct ext4_buddy *e4b,
+			ext4_grpblk_t start, ext4_grpblk_t len, void *bitmap,
+			void *buddy, struct ext4_group_info *grp)
+{
+	struct super_block *sb = (struct super_block *)test->priv;
+	struct ext4_free_extent ex;
+	int i;
+
+	/* mb_mark_used only accepts non-zero len */
+	if (len == 0)
+		return;
+
+	ex.fe_start = start;
+	ex.fe_len = len;
+	ex.fe_group = TEST_GOAL_GROUP;
+	mb_mark_used(e4b, &ex);
+
+	mb_set_bits(bitmap, start, len);
+	/* bypass bb_free validatoin in ext4_mb_generate_buddy */
+	grp->bb_free -= len;
+	memset(buddy, 0xff, sb->s_blocksize);
+	for (i = 0; i < MB_NUM_ORDERS(sb); i++)
+		grp->bb_counters[i] = 0;
+	ext4_mb_generate_buddy(sb, buddy, bitmap, 0, grp);
+
+	KUNIT_ASSERT_EQ(test, memcmp(buddy, e4b->bd_buddy, sb->s_blocksize),
+			0);
+	mbt_validate_group_info(test, grp, e4b->bd_info);
+}
+
+static void test_mb_mark_used(struct kunit *test)
+{
+	struct ext4_buddy e4b;
+	struct super_block *sb = (struct super_block *)test->priv;
+	void *bitmap, *buddy;
+	struct ext4_group_info *grp;
+	int ret;
+	struct test_range ranges[TEST_RANGE_COUNT];
+	int i;
+
+	/* buddy cache assumes that each page contains at least one block */
+	if (sb->s_blocksize > PAGE_SIZE)
+		kunit_skip(test, "blocksize exceeds pagesize");
+
+	bitmap = kunit_kzalloc(test, sb->s_blocksize, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bitmap);
+	buddy = kunit_kzalloc(test, sb->s_blocksize, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buddy);
+	grp = kunit_kzalloc(test, offsetof(struct ext4_group_info,
+				bb_counters[MB_NUM_ORDERS(sb)]), GFP_KERNEL);
+
+	ret = ext4_mb_load_buddy(sb, TEST_GOAL_GROUP, &e4b);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	grp->bb_free = EXT4_CLUSTERS_PER_GROUP(sb);
+	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
+	for (i = 0; i < TEST_RANGE_COUNT; i++)
+		test_mb_mark_used_range(test, &e4b, ranges[i].start,
+					ranges[i].len, bitmap, buddy, grp);
+
+	ext4_mb_unload_buddy(&e4b);
+}
+
 static const struct mbt_ext4_block_layout mbt_test_layouts[] = {
 	{
 		.blocksize_bits = 10,
@@ -637,6 +714,7 @@ static struct kunit_case mbt_test_cases[] = {
 	KUNIT_CASE_PARAM(test_new_blocks_simple, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_free_blocks_simple, mbt_layouts_gen_params),
 	KUNIT_CASE_PARAM(test_mb_generate_buddy, mbt_layouts_gen_params),
+	KUNIT_CASE_PARAM(test_mb_mark_used, mbt_layouts_gen_params),
 	{}
 };
 
-- 
2.30.0


