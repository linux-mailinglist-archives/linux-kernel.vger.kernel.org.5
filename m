Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E199781D18
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 11:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjHTJQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 05:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjHTJQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 05:16:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E902349F6;
        Sun, 20 Aug 2023 02:13:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RT8zt31VKz4f3vdR;
        Sun, 20 Aug 2023 17:13:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBahH2eFkmXibBA--.44158S7;
        Sun, 20 Aug 2023 17:13:47 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, mariusz.tkaczyk@linux.intel.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 3/7] md: delay choosing sync action to md_start_sync()
Date:   Sun, 20 Aug 2023 17:09:45 +0800
Message-Id: <20230820090949.2874537-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBahH2eFkmXibBA--.44158S7
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr4rKFy3KFWfAr4kCF1DGFg_yoW7Ar47pa
        yfAF9xJrW8JFZxZrW2q3WDWay5Xr10q39rtrW3Was5G3WFy3WxKF15u3WUAFWDtasaka13
        Zw4rJanxZFy5uaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU=
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

Before this patch, for read-write array:

1) md_check_recover() found that something need to be done, and it'll
   try to grab 'reconfig_mutex'. The case that md_check_recover() need
   to do something:
   - array is not suspend;
   - super_block need to be updated;
   - 'MD_RECOVERY_NEEDED' or ''MD_RECOVERY_DONE' is set;
   - unusual case related to safemode;

2) if 'MD_RECOVERY_RUNNING' is not set, and 'MD_RECOVERY_NEEDED' is set,
   md_check_recover() will try to choose a sync action, and then queue a
   work md_start_sync().

3) md_start_sync() register sync_thread;

After this patch,

1) is the same;
2) if 'MD_RECOVERY_RUNNING' is not set, and 'MD_RECOVERY_NEEDED' is set,
   queue a work md_start_sync() directly;
3) md_start_sync() will try to choose a sync action, and then register
   sync_thread();

Because 'MD_RECOVERY_RUNNING' is cleared when sync_thread is done, 2)
and 3) and md_do_sync() is always ran in serial and they can never
concurrent, this change should not introduce any behavior change for now.

Also fix a problem that md_start_sync() can clear 'MD_RECOVERY_RUNNING'
without protection in error path, which might affect the logical in
md_check_recovery().

The advantage to change this is that array reconfiguration is
independent from daemon now, and it'll be much easier to synchronize it
with io, consider that io may rely on daemon thread to be done.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 73 ++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0cb9fa703a0c..561cac13ff96 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9293,6 +9293,22 @@ static bool md_choose_sync_action(struct mddev *mddev, int *spares)
 static void md_start_sync(struct work_struct *ws)
 {
 	struct mddev *mddev = container_of(ws, struct mddev, sync_work);
+	int spares = 0;
+
+	mddev_lock_nointr(mddev);
+
+	if (!md_choose_sync_action(mddev, &spares))
+		goto not_running;
+
+	if (!mddev->pers->sync_request)
+		goto not_running;
+
+	/*
+	 * We are adding a device or devices to an array which has the bitmap
+	 * stored on all devices. So make sure all bitmap pages get written.
+	 */
+	if (spares)
+		md_bitmap_write_all(mddev->bitmap);
 
 	rcu_assign_pointer(mddev->sync_thread,
 			   md_register_thread(md_do_sync, mddev, "resync"));
@@ -9300,20 +9316,27 @@ static void md_start_sync(struct work_struct *ws)
 		pr_warn("%s: could not start resync thread...\n",
 			mdname(mddev));
 		/* leave the spares where they are, it shouldn't hurt */
-		clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
-		clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
-		clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
-		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
-		clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
-		wake_up(&resync_wait);
-		if (test_and_clear_bit(MD_RECOVERY_RECOVER,
-				       &mddev->recovery))
-			if (mddev->sysfs_action)
-				sysfs_notify_dirent_safe(mddev->sysfs_action);
-	} else
-		md_wakeup_thread(mddev->sync_thread);
+		goto not_running;
+	}
+
+	mddev_unlock(mddev);
+	md_wakeup_thread(mddev->sync_thread);
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
 	md_new_event();
+	return;
+
+not_running:
+	clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
+	clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
+	clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
+	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
+	clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
+	mddev_unlock(mddev);
+
+	wake_up(&resync_wait);
+	if (test_and_clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery) &&
+	    mddev->sysfs_action)
+		sysfs_notify_dirent_safe(mddev->sysfs_action);
 }
 
 /*
@@ -9381,7 +9404,6 @@ void md_check_recovery(struct mddev *mddev)
 		return;
 
 	if (mddev_trylock(mddev)) {
-		int spares = 0;
 		bool try_set_sync = mddev->safemode != 0;
 
 		if (!mddev->external && mddev->safemode == 1)
@@ -9468,31 +9490,14 @@ void md_check_recovery(struct mddev *mddev)
 		clear_bit(MD_RECOVERY_INTR, &mddev->recovery);
 		clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
 
-		if (!test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
-		    test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
-			goto not_running;
-		if (!md_choose_sync_action(mddev, &spares))
-			goto not_running;
-		if (mddev->pers->sync_request) {
-			if (spares) {
-				/* We are adding a device or devices to an array
-				 * which has the bitmap stored on all devices.
-				 * So make sure all bitmap pages get written
-				 */
-				md_bitmap_write_all(mddev->bitmap);
-			}
+		if (test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery) &&
+		    !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
 			queue_work(md_misc_wq, &mddev->sync_work);
-			goto unlock;
-		}
-	not_running:
-		if (!mddev->sync_thread) {
+		} else {
 			clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
 			wake_up(&resync_wait);
-			if (test_and_clear_bit(MD_RECOVERY_RECOVER,
-					       &mddev->recovery))
-				if (mddev->sysfs_action)
-					sysfs_notify_dirent_safe(mddev->sysfs_action);
 		}
+
 	unlock:
 		wake_up(&mddev->sb_wait);
 		mddev_unlock(mddev);
-- 
2.39.2

