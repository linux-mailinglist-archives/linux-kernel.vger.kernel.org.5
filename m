Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476317BF419
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442477AbjJJHXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442278AbjJJHXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:23:41 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2350B6;
        Tue, 10 Oct 2023 00:23:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S4S780PJVz4f3kp8;
        Tue, 10 Oct 2023 15:23:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHXd31+yRl1AZbCg--.36859S5;
        Tue, 10 Oct 2023 15:23:37 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 01/19] md: use READ_ONCE/WRITE_ONCE for 'suspend_lo' and 'suspend_hi'
Date:   Tue, 10 Oct 2023 23:19:40 +0800
Message-Id: <20231010151958.145896-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010151958.145896-1-yukuai1@huaweicloud.com>
References: <20231010151958.145896-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHXd31+yRl1AZbCg--.36859S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4DuF45KFyfJrW3CrWDtwb_yoW8tF4Up3
        yIgFWYgw45tas5Aw1Ut3WkCFy5XwsxKrWvyrZrWry7C3W7Ww1rGr15WF43XryFvas7CFsx
        Gw4DA3WrA348GFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRxhLUUUUUU
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Protect 'suspend_lo' and 'suspend_hi' with READ_ONCE/WRITE_ONCE to prevent
reading abnormal values.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 78853b05f99c..930bcabeec79 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -359,11 +359,11 @@ static bool is_suspended(struct mddev *mddev, struct bio *bio)
 		return true;
 	if (bio_data_dir(bio) != WRITE)
 		return false;
-	if (mddev->suspend_lo >= mddev->suspend_hi)
+	if (READ_ONCE(mddev->suspend_lo) >= READ_ONCE(mddev->suspend_hi))
 		return false;
-	if (bio->bi_iter.bi_sector >= mddev->suspend_hi)
+	if (bio->bi_iter.bi_sector >= READ_ONCE(mddev->suspend_hi))
 		return false;
-	if (bio_end_sector(bio) < mddev->suspend_lo)
+	if (bio_end_sector(bio) < READ_ONCE(mddev->suspend_lo))
 		return false;
 	return true;
 }
@@ -5179,7 +5179,8 @@ __ATTR(sync_max, S_IRUGO|S_IWUSR, max_sync_show, max_sync_store);
 static ssize_t
 suspend_lo_show(struct mddev *mddev, char *page)
 {
-	return sprintf(page, "%llu\n", (unsigned long long)mddev->suspend_lo);
+	return sprintf(page, "%llu\n",
+		       (unsigned long long)READ_ONCE(mddev->suspend_lo));
 }
 
 static ssize_t
@@ -5199,7 +5200,7 @@ suspend_lo_store(struct mddev *mddev, const char *buf, size_t len)
 		return err;
 
 	mddev_suspend(mddev);
-	mddev->suspend_lo = new;
+	WRITE_ONCE(mddev->suspend_lo, new);
 	mddev_resume(mddev);
 
 	mddev_unlock(mddev);
@@ -5211,7 +5212,8 @@ __ATTR(suspend_lo, S_IRUGO|S_IWUSR, suspend_lo_show, suspend_lo_store);
 static ssize_t
 suspend_hi_show(struct mddev *mddev, char *page)
 {
-	return sprintf(page, "%llu\n", (unsigned long long)mddev->suspend_hi);
+	return sprintf(page, "%llu\n",
+		       (unsigned long long)READ_ONCE(mddev->suspend_hi));
 }
 
 static ssize_t
@@ -5231,7 +5233,7 @@ suspend_hi_store(struct mddev *mddev, const char *buf, size_t len)
 		return err;
 
 	mddev_suspend(mddev);
-	mddev->suspend_hi = new;
+	WRITE_ONCE(mddev->suspend_hi, new);
 	mddev_resume(mddev);
 
 	mddev_unlock(mddev);
-- 
2.39.2

