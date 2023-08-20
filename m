Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBEB781D1E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 11:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjHTJRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 05:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjHTJRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 05:17:06 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F4E49F1;
        Sun, 20 Aug 2023 02:13:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RT8zq4SYNz4f3mL4;
        Sun, 20 Aug 2023 17:13:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBahH2eFkmXibBA--.44158S5;
        Sun, 20 Aug 2023 17:13:46 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, mariusz.tkaczyk@linux.intel.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 1/7] md: use separate work_struct for md_start_sync()
Date:   Sun, 20 Aug 2023 17:09:43 +0800
Message-Id: <20230820090949.2874537-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBahH2eFkmXibBA--.44158S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary3ur4xKr18JFykJF4Utwb_yoW5JFyfpa
        ySgFy3JrW8J390qw4UWFWDC3Wagw1vyryDtryfCw4FvF9xtr1UGa1FgayqqF98CayFkr1a
        va1FqFW5ur18Gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbec_DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
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

