Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D59787E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbjHYDVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjHYDUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:20:40 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E285D196;
        Thu, 24 Aug 2023 20:20:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RX4w230Pdz4f3mVk;
        Fri, 25 Aug 2023 11:20:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHoqUBHuhkPT4XBg--.14533S5;
        Fri, 25 Aug 2023 11:20:34 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 1/7] md: use separate work_struct for md_start_sync()
Date:   Fri, 25 Aug 2023 11:16:16 +0800
Message-Id: <20230825031622.1530464-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230825031622.1530464-1-yukuai1@huaweicloud.com>
References: <20230825031622.1530464-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHoqUBHuhkPT4XBg--.14533S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4xJF48CFWkWr4fXrWxXrb_yoW5Gr18pa
        ySgFy3JrW8J390qw4UWFWDC3WYgw1vyryDtryfCw4FvF9xtr1UGF4Fgayqqr98CayrKr1a
        va1FvFW5ur18Gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
        W8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHyIUUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

It's a little weird to borrow 'del_work' for md_start_sync(), declare
a new work_struct 'sync_work' for md_start_sync().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c | 10 ++++++----
 drivers/md/md.h |  5 ++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5c3c19b8d509..90815be1e80f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -631,13 +631,13 @@ void mddev_put(struct mddev *mddev)
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
@@ -662,6 +662,9 @@ void mddev_init(struct mddev *mddev)
 	mddev->resync_min = 0;
 	mddev->resync_max = MaxSector;
 	mddev->level = LEVEL_NONE;
+
+	INIT_WORK(&mddev->sync_work, md_start_sync);
+	INIT_WORK(&mddev->del_work, mddev_delayed_delete);
 }
 EXPORT_SYMBOL_GPL(mddev_init);
 
@@ -9245,7 +9248,7 @@ static int remove_and_add_spares(struct mddev *mddev,
 
 static void md_start_sync(struct work_struct *ws)
 {
-	struct mddev *mddev = container_of(ws, struct mddev, del_work);
+	struct mddev *mddev = container_of(ws, struct mddev, sync_work);
 
 	rcu_assign_pointer(mddev->sync_thread,
 			   md_register_thread(md_do_sync, mddev, "resync"));
@@ -9458,8 +9461,7 @@ void md_check_recovery(struct mddev *mddev)
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
index 9bcb77bca963..64d05cb65287 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -450,7 +450,10 @@ struct mddev {
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

