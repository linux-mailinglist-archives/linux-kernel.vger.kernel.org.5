Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C80F7AFAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjI0GTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjI0GS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:18:56 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA8A1AC;
        Tue, 26 Sep 2023 23:18:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RwRJQ0rSfz4f3l7F;
        Wed, 27 Sep 2023 14:18:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXrt1IyRNl_QoCBg--.53663S5;
        Wed, 27 Sep 2023 14:18:50 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     mariusz.tkaczyk@linux.intel.com, xni@redhat.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v3 1/2] md: factor out a helper from mddev_put()
Date:   Wed, 27 Sep 2023 14:12:40 +0800
Message-Id: <20230927061241.1552837-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927061241.1552837-1-yukuai1@huaweicloud.com>
References: <20230927061241.1552837-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXrt1IyRNl_QoCBg--.53663S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtr4Utry3GF4UArb_yoW8WFWrpa
        yfta9xCrW8XrW3J3yUJrsru3W5X3Za9rWDtryxWws5ZFy5ur15Gw1Fga4rJryDGa4fAF45
        Za18WFWDCryFgrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes, prepare to simplify md_seq_ops in next
patch.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 10cb4dfbf4ae..73782cafad4e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -616,23 +616,28 @@ static inline struct mddev *mddev_get(struct mddev *mddev)
 
 static void mddev_delayed_delete(struct work_struct *ws);
 
+static void __mddev_put(struct mddev *mddev)
+{
+	if (mddev->raid_disks || !list_empty(&mddev->disks) ||
+	    mddev->ctime || mddev->hold_active)
+		return;
+
+	/* Array is not configured at all, and not held active, so destroy it */
+	set_bit(MD_DELETED, &mddev->flags);
+
+	/*
+	 * Call queue_work inside the spinlock so that flush_workqueue() after
+	 * mddev_find will succeed in waiting for the work to be done.
+	 */
+	queue_work(md_misc_wq, &mddev->del_work);
+}
+
 void mddev_put(struct mddev *mddev)
 {
 	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
 		return;
-	if (!mddev->raid_disks && list_empty(&mddev->disks) &&
-	    mddev->ctime == 0 && !mddev->hold_active) {
-		/* Array is not configured at all, and not held active,
-		 * so destroy it */
-		set_bit(MD_DELETED, &mddev->flags);
 
-		/*
-		 * Call queue_work inside the spinlock so that
-		 * flush_workqueue() after mddev_find will succeed in waiting
-		 * for the work to be done.
-		 */
-		queue_work(md_misc_wq, &mddev->del_work);
-	}
+	__mddev_put(mddev);
 	spin_unlock(&all_mddevs_lock);
 }
 
-- 
2.39.2

