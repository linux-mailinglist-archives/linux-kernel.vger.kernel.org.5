Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC597F6DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344880AbjKXIIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjKXIII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:08:08 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820AE4482;
        Fri, 24 Nov 2023 00:00:23 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sc6pp2RVYz4f3k62;
        Fri, 24 Nov 2023 16:00:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 181811A0B67;
        Fri, 24 Nov 2023 16:00:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgDX2xERWGBlUnAqBw--.22901S9;
        Fri, 24 Nov 2023 16:00:20 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, yukuai3@huawei.com, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH v2 5/6] md: fix stopping sync thread
Date:   Fri, 24 Nov 2023 15:59:52 +0800
Message-Id: <20231124075953.1932764-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231124075953.1932764-1-yukuai1@huaweicloud.com>
References: <20231124075953.1932764-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2xERWGBlUnAqBw--.22901S9
X-Coremail-Antispam: 1UD129KBjvJXoW3JF43Xr13GF48ZFy5tw1DKFg_yoWxXr1Up3
        yft3Z8JrW8ArW3ZrW7K3WDZayrZw1jvrWDtryfWa4fJ3Wftr47KFyY9FyUAFykta4Fyr4U
        Z3yrJFWfZFy8Kr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently sync thread is stopped from multiple contex:
 - idle_sync_thread
 - frozen_sync_thread
 - __md_stop_writes
 - md_set_readonly
 - do_md_stop

And there are some problems:
1) sync_work is flushed while reconfig_mutex is grabbed, this can
   deadlock because the work function will grab reconfig_mutex as well.
2) md_reap_sync_thread() can't be called directly while md_do_sync() is
   not finished yet, for example, commit 130443d60b1b ("md: refactor
   idle/frozen_sync_thread() to fix deadlock").
3) If MD_RECOVERY_RUNNING is not set, there is no need to stop
   sync_thread at all because sync_thread must not be registered.

Factor out a helper prepare_to_stop_sync_thread(), so that above contex
will behave the same. Fix 1) by flushing sync_work after reconfig_mutex
is released, before waiting for sync_thread to be done; Fix 2) bt
letting daemon thread to unregister sync_thread; Fix 3) by always
checking MD_RECOVERY_RUNNING first.

Fixes: db5e653d7c9f ("md: delay choosing sync action to md_start_sync()")

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 96 ++++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 50 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5af67748e53e..fb8a7d1eebee 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4846,26 +4846,9 @@ action_show(struct mddev *mddev, char *page)
 	return sprintf(page, "%s\n", type);
 }
 
-static void stop_sync_thread(struct mddev *mddev)
+static void prepare_to_stop_sync_thread(struct mddev *mddev)
+	__releases(&mddev->reconfig_mutex)
 {
-	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
-		return;
-
-	if (mddev_lock(mddev))
-		return;
-
-	/*
-	 * Check again in case MD_RECOVERY_RUNNING is cleared before lock is
-	 * held.
-	 */
-	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
-		mddev_unlock(mddev);
-		return;
-	}
-
-	if (work_pending(&mddev->sync_work))
-		flush_workqueue(md_misc_wq);
-
 	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 	/*
 	 * Thread might be blocked waiting for metadata update which will now
@@ -4874,6 +4857,8 @@ static void stop_sync_thread(struct mddev *mddev)
 	md_wakeup_thread_directly(mddev->sync_thread);
 
 	mddev_unlock(mddev);
+	if (work_pending(&mddev->sync_work))
+		flush_work(&mddev->sync_work);
 }
 
 static void idle_sync_thread(struct mddev *mddev)
@@ -4882,10 +4867,20 @@ static void idle_sync_thread(struct mddev *mddev)
 
 	mutex_lock(&mddev->sync_mutex);
 	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	stop_sync_thread(mddev);
 
-	wait_event(resync_wait, sync_seq != atomic_read(&mddev->sync_seq) ||
+	if (mddev_lock(mddev)) {
+		mutex_unlock(&mddev->sync_mutex);
+		return;
+	}
+
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+		prepare_to_stop_sync_thread(mddev);
+		wait_event(resync_wait,
+			sync_seq != atomic_read(&mddev->sync_seq) ||
 			!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
+	} else {
+		mddev_unlock(mddev);
+	}
 
 	mutex_unlock(&mddev->sync_mutex);
 }
@@ -4894,9 +4889,19 @@ static void frozen_sync_thread(struct mddev *mddev)
 {
 	mutex_lock(&mddev->sync_mutex);
 	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	stop_sync_thread(mddev);
 
-	wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
+	if (mddev_lock(mddev)) {
+		mutex_unlock(&mddev->sync_mutex);
+		return;
+	}
+
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+		prepare_to_stop_sync_thread(mddev);
+		wait_event(resync_wait,
+			!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
+	} else {
+		mddev_unlock(mddev);
+	}
 
 	mutex_unlock(&mddev->sync_mutex);
 }
@@ -6270,11 +6275,11 @@ static void md_clean(struct mddev *mddev)
 static void __md_stop_writes(struct mddev *mddev)
 {
 	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	if (work_pending(&mddev->sync_work))
-		flush_workqueue(md_misc_wq);
-	if (mddev->sync_thread) {
-		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-		md_reap_sync_thread(mddev);
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+		prepare_to_stop_sync_thread(mddev);
+		wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
+						  &mddev->recovery));
+		mddev_lock_nointr(mddev);
 	}
 
 	del_timer_sync(&mddev->safemode_timer);
@@ -6367,18 +6372,15 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 		did_freeze = 1;
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	}
-	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
-		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 
-	/*
-	 * Thread might be blocked waiting for metadata update which will now
-	 * never happen
-	 */
-	md_wakeup_thread_directly(mddev->sync_thread);
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+		prepare_to_stop_sync_thread(mddev);
+		wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
+						  &mddev->recovery));
+	} else {
+		mddev_unlock(mddev);
+	}
 
-	mddev_unlock(mddev);
-	wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
-					  &mddev->recovery));
 	wait_event(mddev->sb_wait,
 		   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
 	mddev_lock_nointr(mddev);
@@ -6429,19 +6431,13 @@ static int do_md_stop(struct mddev *mddev, int mode,
 		did_freeze = 1;
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	}
-	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
-		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-
-	/*
-	 * Thread might be blocked waiting for metadata update which will now
-	 * never happen
-	 */
-	md_wakeup_thread_directly(mddev->sync_thread);
 
-	mddev_unlock(mddev);
-	wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
-					  &mddev->recovery));
-	mddev_lock_nointr(mddev);
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+		prepare_to_stop_sync_thread(mddev);
+		wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
+						  &mddev->recovery));
+		mddev_lock_nointr(mddev);
+	}
 
 	mutex_lock(&mddev->open_mutex);
 	if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
-- 
2.39.2

