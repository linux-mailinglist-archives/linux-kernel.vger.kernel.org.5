Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7C076EA41
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjHCN2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbjHCN1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:27:42 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A072A1FF0;
        Thu,  3 Aug 2023 06:27:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGqQV1C1Yz4f3lD2;
        Thu,  3 Aug 2023 21:27:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7M6q8tk5SrlPQ--.7420S15;
        Thu, 03 Aug 2023 21:27:31 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 11/13] md: use separate work_struct for md_start_sync()
Date:   Thu,  3 Aug 2023 21:24:24 +0800
Message-Id: <20230803132426.2688608-12-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
References: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7M6q8tk5SrlPQ--.7420S15
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary3ur4xtw48KFW8JF13Arb_yoW5JFyfpa
        ySgFy3JrW8J390qw4UWFWDC3Wagw1vkryDtryfuwsYvF9xtr1UGa1FgayqqF98Cayrtr1a
        va1FqFW5ur18Gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

It's a little weird to borrow 'del_work' for md_start_sync(), declare
a new work_struct 'sync_work' for md_start_sync().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 10 ++++++----
 drivers/md/md.h |  5 ++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index e64d1d0b4c5c..8980a41bfe97 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -630,13 +630,13 @@ void mddev_put(struct mddev *mddev)
 		 * flush_workqueue() after mddev_find will succeed in waiting
 		 * for the work to be done.
 		 */
-		INIT_WORK(&mddev->del_work, mddev_delayed_delete);
 		queue_work(md_misc_wq, &mddev->del_work);
 	}
 	spin_unlock(&all_mddevs_lock);
 }
 
 static void md_safemode_timeout(struct timer_list *t);
+static void md_start_sync(struct work_struct *ws);
 
 void mddev_init(struct mddev *mddev)
 {
@@ -661,6 +661,9 @@ void mddev_init(struct mddev *mddev)
 	mddev->resync_min = 0;
 	mddev->resync_max = MaxSector;
 	mddev->level = LEVEL_NONE;
+
+	INIT_WORK(&mddev->sync_work, md_start_sync);
+	INIT_WORK(&mddev->del_work, mddev_delayed_delete);
 }
 EXPORT_SYMBOL_GPL(mddev_init);
 
@@ -9257,7 +9260,7 @@ static int remove_and_add_spares(struct mddev *mddev)
 
 static void md_start_sync(struct work_struct *ws)
 {
-	struct mddev *mddev = container_of(ws, struct mddev, del_work);
+	struct mddev *mddev = container_of(ws, struct mddev, sync_work);
 
 	rcu_assign_pointer(mddev->sync_thread,
 			   md_register_thread(md_do_sync, mddev, "resync"));
@@ -9470,8 +9473,7 @@ void md_check_recovery(struct mddev *mddev)
 				 */
 				md_bitmap_write_all(mddev->bitmap);
 			}
-			INIT_WORK(&mddev->del_work, md_start_sync);
-			queue_work(md_misc_wq, &mddev->del_work);
+			queue_work(md_misc_wq, &mddev->sync_work);
 			goto unlock;
 		}
 	not_running:
diff --git a/drivers/md/md.h b/drivers/md/md.h
index b25b6d061372..0381f2aa6cbb 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -445,7 +445,10 @@ struct mddev {
 	struct kernfs_node		*sysfs_degraded;	/*handle for 'degraded' */
 	struct kernfs_node		*sysfs_level;		/*handle for 'level' */
 
-	struct work_struct del_work;	/* used for delayed sysfs removal */
+	/* used for delayed sysfs removal */
+	struct work_struct del_work;
+	/* used for register new sync thread */
+	struct work_struct sync_work;
 
 	/* "lock" protects:
 	 *   flush_bio transition from NULL to !NULL
-- 
2.39.2

