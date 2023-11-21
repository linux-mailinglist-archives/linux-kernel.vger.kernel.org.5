Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DAA7F249E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 04:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjKUDZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 22:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKUDZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 22:25:35 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D965CE7;
        Mon, 20 Nov 2023 19:25:31 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZ8s23tnnz4f3kpd;
        Tue, 21 Nov 2023 11:25:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 374FE1A0513;
        Tue, 21 Nov 2023 11:25:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgDX2xEmI1xlv3EABg--.26174S6;
        Tue, 21 Nov 2023 11:25:29 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 2/2] block: warn once for each partition in bio_check_ro()
Date:   Tue, 21 Nov 2023 19:19:27 +0800
Message-Id: <20231121111927.2021846-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231121111927.2021846-1-yukuai1@huaweicloud.com>
References: <20231121111927.2021846-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2xEmI1xlv3EABg--.26174S6
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1kXr15WF4xJF47ZrWDJwb_yoW8Ww1fpr
        nxKFyrGryjgrWxuan7GF13Aa4rGa1kWrW5ArWfZw1Yyay3Kry0q3Zaqr13Jr48uF4SkrW3
        Xr1jkrWrCa4DurJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
        CS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
        W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7s
        RNLvtUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Commit 1b0a151c10a6 ("blk-core: use pr_warn_ratelimited() in
bio_check_ro()") fix message storm by limit the rate, however, there
will still be lots of message in the long term. Fix it better by warn
once for each partition.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c          | 14 +++++++++++---
 include/linux/blk_types.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f9f8b12ba626..6575f684d41e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -502,9 +502,17 @@ static inline void bio_check_ro(struct bio *bio)
 	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
 			return;
-		pr_warn_ratelimited("Trying to write to read-only block-device %pg\n",
-				    bio->bi_bdev);
-		/* Older lvm-tools actually trigger this */
+
+		if (bdev_flagged(bio->bi_bdev, BD_FLAG_RO_WARNED))
+			return;
+
+		bdev_set_flag(bio->bi_bdev, BD_FLAG_RO_WARNED);
+		/*
+		 * Use ioctl to set underlying disk of raid/dm to read-only
+		 * will trigger this.
+		 */
+		pr_warn("Trying to write to read-only block-device %pg\n",
+			bio->bi_bdev);
 	}
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index f7a7965eeb25..07abd0165226 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -41,6 +41,7 @@ struct bio_crypt_ctx;
 #define BD_FLAG_WRITE_HOLDER	1
 #define BD_FLAG_HAS_SUBMIT_BIO	2
 #define BD_FLAG_MAKE_IT_FAIL	3
+#define BD_FLAG_RO_WARNED	4
 
 struct block_device {
 	sector_t		bd_start_sect;
-- 
2.39.2

