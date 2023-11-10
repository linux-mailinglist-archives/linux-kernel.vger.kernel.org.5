Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992077E7FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbjKJSDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbjKJSCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:02:40 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F632BE24;
        Fri, 10 Nov 2023 01:34:02 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SRYYK26h7z4f4HDw;
        Fri, 10 Nov 2023 17:33:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id AA82B1A0177;
        Fri, 10 Nov 2023 17:33:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgA3iA4E+U1l0pQlAg--.33627S10;
        Fri, 10 Nov 2023 17:33:59 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, yukuai3@huawei.com, neilb@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 6/8] md: factor out a helper to stop sync_thread
Date:   Sat, 11 Nov 2023 01:28:32 +0800
Message-Id: <20231110172834.3939490-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231110172834.3939490-1-yukuai1@huaweicloud.com>
References: <20231110172834.3939490-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgA3iA4E+U1l0pQlAg--.33627S10
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1kKFyrur15GrWrWF15urg_yoWxKF1fp3
        yfJF98Jr48ArWfZrZrt3WDZayrZr1jqayqyry3Wa4fJr1ftr43KFyF9FyUAFykKay0yr45
        XayrtFW3ZFy7Wr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRi4SO
        UUUUU
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

stop_sync_thread(), md_set_readonly() and do_md_stop() are trying to
stop sync_thread() the same way, hence factor out a helper to make code
cleaner, and also prepare to use the new helper to fix problems later.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
---
 drivers/md/md.c | 129 ++++++++++++++++++++++++++----------------------
 1 file changed, 69 insertions(+), 60 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index c0f2bdafe46a..7252fae0c989 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4848,29 +4848,46 @@ action_show(struct mddev *mddev, char *page)
 	return sprintf(page, "%s\n", type);
 }
 
-static int stop_sync_thread(struct mddev *mddev)
+static bool sync_thread_stopped(struct mddev *mddev, int *seq_ptr)
 {
-	int ret = 0;
+	if (seq_ptr && *seq_ptr != atomic_read(&mddev->sync_seq))
+		return true;
 
-	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
-		return 0;
+	return (!mddev->sync_thread &&
+		!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
+}
 
-	ret = mddev_lock(mddev);
-	if (ret)
-		return ret;
+/*
+ * stop_sync_thread() - stop running sync_thread.
+ * @mddev: the array that sync_thread belongs to.
+ * @freeze: set true to prevent new sync_thread to start.
+ * @interruptible: if set true, then user can interrupt while waiting for
+ * sync_thread to be done.
+ *
+ * Noted that this function must be called with 'reconfig_mutex' grabbed, and
+ * fter this function return, 'reconfig_mtuex' will be released.
+ */
+static int stop_sync_thread(struct mddev *mddev, bool freeze,
+			    bool interruptible)
+	__releases(&mddev->reconfig_mutex)
+{
+	int *seq_ptr = NULL;
+	int sync_seq;
+	int ret = 0;
+
+	if (freeze) {
+		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	} else {
+		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+		sync_seq = atomic_read(&mddev->sync_seq);
+		seq_ptr = &sync_seq;
+	}
 
-	/*
-	 * Check again in case MD_RECOVERY_RUNNING is cleared before lock is
-	 * held.
-	 */
 	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 		mddev_unlock(mddev);
 		return 0;
 	}
 
-	if (work_pending(&mddev->sync_work))
-		flush_workqueue(md_misc_wq);
-
 	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 	/*
 	 * Thread might be blocked waiting for metadata update which will now
@@ -4879,53 +4896,58 @@ static int stop_sync_thread(struct mddev *mddev)
 	md_wakeup_thread_directly(mddev->sync_thread);
 
 	mddev_unlock(mddev);
-	return 0;
+	if (work_pending(&mddev->sync_work))
+		flush_work(&mddev->sync_work);
+
+	if (interruptible)
+		ret = wait_event_interruptible(resync_wait,
+					sync_thread_stopped(mddev, seq_ptr));
+	else
+		wait_event(resync_wait, sync_thread_stopped(mddev, seq_ptr));
+
+	return ret;
 }
 
 static int idle_sync_thread(struct mddev *mddev)
 {
 	int ret;
-	int sync_seq = atomic_read(&mddev->sync_seq);
 	bool flag;
 
 	ret = mutex_lock_interruptible(&mddev->sync_mutex);
 	if (ret)
 		return ret;
 
-	flag = test_and_clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	ret = stop_sync_thread(mddev);
+	flag = test_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	ret = mddev_lock(mddev);
 	if (ret)
-		goto out;
+		goto unlock;
 
-	ret = wait_event_interruptible(resync_wait,
-			sync_seq != atomic_read(&mddev->sync_seq) ||
-			!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
-out:
+	ret = stop_sync_thread(mddev, false, true);
 	if (ret && flag)
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+unlock:
 	mutex_unlock(&mddev->sync_mutex);
 	return ret;
 }
 
 static int frozen_sync_thread(struct mddev *mddev)
 {
-	int ret = mutex_lock_interruptible(&mddev->sync_mutex);
+	int ret;
 	bool flag;
 
+	ret = mutex_lock_interruptible(&mddev->sync_mutex);
 	if (ret)
 		return ret;
 
-	flag = test_and_set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	ret = stop_sync_thread(mddev);
+	flag = test_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	ret = mddev_lock(mddev);
 	if (ret)
-		goto out;
+		goto unlock;
 
-	ret = wait_event_interruptible(resync_wait,
-			mddev->sync_thread == NULL &&
-			!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
-out:
+	ret = stop_sync_thread(mddev, true, true);
 	if (ret && !flag)
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+unlock:
 	mutex_unlock(&mddev->sync_mutex);
 	return ret;
 }
@@ -6397,22 +6419,10 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
 		return -EBUSY;
 
-	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
+	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
 		did_freeze = 1;
-		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	}
-	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
-		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 
-	/*
-	 * Thread might be blocked waiting for metadata update which will now
-	 * never happen
-	 */
-	md_wakeup_thread_directly(mddev->sync_thread);
-
-	mddev_unlock(mddev);
-	wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
-					  &mddev->recovery));
+	stop_sync_thread(mddev, true, false);
 	wait_event(mddev->sb_wait,
 		   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
 	mddev_lock_nointr(mddev);
@@ -6421,6 +6431,10 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
 	    mddev->sync_thread ||
 	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+		/*
+		 * This could happen if user change array state through
+		 * ioctl/sysfs while reconfig_mutex is released.
+		 */
 		pr_warn("md: %s still in use.\n",mdname(mddev));
 		err = -EBUSY;
 		goto out;
@@ -6457,30 +6471,25 @@ static int do_md_stop(struct mddev *mddev, int mode,
 	struct md_rdev *rdev;
 	int did_freeze = 0;
 
-	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
+	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
 		did_freeze = 1;
+
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+		stop_sync_thread(mddev, true, false);
+		mddev_lock_nointr(mddev);
+	} else {
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
-
-	mddev_unlock(mddev);
-	wait_event(resync_wait, (mddev->sync_thread == NULL &&
-				 !test_bit(MD_RECOVERY_RUNNING,
-					   &mddev->recovery)));
-	mddev_lock_nointr(mddev);
 
 	mutex_lock(&mddev->open_mutex);
 	if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
 	    mddev->sysfs_active ||
 	    mddev->sync_thread ||
 	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+		/*
+		 * This could happen if user change array state through
+		 * ioctl/sysfs while reconfig_mutex is released.
+		 */
 		pr_warn("md: %s still in use.\n",mdname(mddev));
 		mutex_unlock(&mddev->open_mutex);
 		if (did_freeze) {
-- 
2.39.2

