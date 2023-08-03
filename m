Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5073276EA51
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbjHCN2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbjHCN1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:27:42 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AE12109;
        Thu,  3 Aug 2023 06:27:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RGqQR1nnrz4f3lwK;
        Thu,  3 Aug 2023 21:27:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7M6q8tk5SrlPQ--.7420S12;
        Thu, 03 Aug 2023 21:27:29 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 08/13] md: convert to use hot_remove_rdev() to hot remove one rdev
Date:   Thu,  3 Aug 2023 21:24:21 +0800
Message-Id: <20230803132426.2688608-9-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
References: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7M6q8tk5SrlPQ--.7420S12
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtF1UJF1fCw1ftFb_yoW8uFWkpa
        yxJas8Wr47Aw43Xw4UtF4DGa45tw10grZ2yry7ua4fZ3Z3Jr1kW3WrGFWUXr95Aa9YvF4r
        JF48ta1Uu3yIkFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes, prepare to cleanup
remove_and_add_spares().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3903bdfe5293..de7399769c8d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -85,6 +85,7 @@ static struct workqueue_struct *md_wq;
 static struct workqueue_struct *md_misc_wq;
 struct workqueue_struct *md_bitmap_wq;
 
+static bool hot_remove_rdev(struct md_rdev *rdev);
 static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this);
 static void mddev_detach(struct mddev *mddev);
@@ -2887,9 +2888,13 @@ static int remove_rdev(struct md_rdev *rdev)
 {
 	struct mddev *mddev = rdev->mddev;
 
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+		return -EBUSY;
+
 	if (mddev->pers) {
 		clear_bit(Blocked, &rdev->flags);
-		remove_and_add_spares(mddev, rdev);
+		if (!hot_remove_rdev(rdev))
+			return -EBUSY;
 	}
 
 	if (rdev->raid_disk >= 0)
@@ -3133,8 +3138,8 @@ slot_store(struct md_rdev *rdev, const char *buf, size_t len)
 		if (rdev->mddev->pers->hot_remove_disk == NULL)
 			return -EINVAL;
 		clear_bit(Blocked, &rdev->flags);
-		remove_and_add_spares(rdev->mddev, rdev);
-		if (rdev->raid_disk >= 0)
+		if (test_bit(MD_RECOVERY_RUNNING, &rdev->mddev->recovery) ||
+		    !hot_remove_rdev(rdev))
 			return -EBUSY;
 		set_bit(MD_RECOVERY_NEEDED, &rdev->mddev->recovery);
 		md_wakeup_thread(rdev->mddev->thread);
@@ -6931,6 +6936,9 @@ static int hot_remove_disk(struct mddev *mddev, dev_t dev)
 	if (!mddev->pers)
 		return -ENODEV;
 
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+		return -EBUSY;
+
 	rdev = find_rdev(mddev, dev);
 	if (!rdev)
 		return -ENXIO;
@@ -6939,9 +6947,7 @@ static int hot_remove_disk(struct mddev *mddev, dev_t dev)
 		goto kick_rdev;
 
 	clear_bit(Blocked, &rdev->flags);
-	remove_and_add_spares(mddev, rdev);
-
-	if (rdev->raid_disk >= 0)
+	if (!hot_remove_rdev(rdev))
 		goto busy;
 
 kick_rdev:
-- 
2.39.2

