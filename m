Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7FB80C271
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjLKH5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjLKH5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:57:34 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07601CE;
        Sun, 10 Dec 2023 23:57:41 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpYxs0PPxz4f3jHf;
        Mon, 11 Dec 2023 15:57:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 3AFC21A0AF2;
        Mon, 11 Dec 2023 15:57:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgCnqxHwwHZlw69ZDQ--.3210S6;
        Mon, 11 Dec 2023 15:57:38 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, axboe@kernel.dk
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linan666@huaweicloud.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH 2/2] md: don't account sync_io if iostats of the disk is disabled
Date:   Mon, 11 Dec 2023 15:56:14 +0800
Message-Id: <20231211075614.1850003-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211075614.1850003-1-linan666@huaweicloud.com>
References: <20231211075614.1850003-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCnqxHwwHZlw69ZDQ--.3210S6
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWxKF4kKr1xuF15XryDAwb_yoW8GFWrpF
        W8JFyayryjqw45ua4UZ34Dua4rG3srK39rArW7A393ZFy3JrnxGrWfWayqqryDWFyrWFWa
        va4DJrZ8ua10yr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
        c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
        ACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I
        3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
        WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
        k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
        6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0J5FUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

If iostats is disabled, disk_stats will not be updated and
part_stat_read_accum() only returns a constant value. In this case,
continuing to count sync_io and to check is_mddev_idle() is no longer
meaningful.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.h | 3 ++-
 drivers/md/md.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 1a4f976951c1..d57e765b4ec2 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -589,7 +589,8 @@ static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sect
 
 static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
 {
-	md_sync_acct(bio->bi_bdev, nr_sectors);
+	if (blk_queue_io_stat(disk—>queue))
+		md_sync_acct(bio->bi_bdev, nr_sectors);
 }
 
 struct md_personality
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1d71b2a9af03..9a3610bcc75f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8502,6 +8502,10 @@ static int is_mddev_idle(struct mddev *mddev, int init)
 	rcu_read_lock();
 	rdev_for_each_rcu(rdev, mddev) {
 		struct gendisk *disk = rdev->bdev->bd_disk;
+
+		if (blk_queue_io_stat(disk—>queue))
+			continue;
+
 		curr_events =
 			(long long)part_stat_read_accum(disk->part0, sectors) -
 			      atomic64_read(&disk->sync_io);
-- 
2.39.2

