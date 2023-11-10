Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F137E7F86
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjKJRyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKJRx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:53:26 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B19F244B3;
        Fri, 10 Nov 2023 01:34:01 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SRYYG4TX1z4f4BLR;
        Fri, 10 Nov 2023 17:33:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 7AECE1A019B;
        Fri, 10 Nov 2023 17:33:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgA3iA4E+U1l0pQlAg--.33627S7;
        Fri, 10 Nov 2023 17:33:58 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, yukuai3@huawei.com, neilb@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 3/8] md: return error to user if idle/frozen_sync_thread() is interrupted
Date:   Sat, 11 Nov 2023 01:28:29 +0800
Message-Id: <20231110172834.3939490-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231110172834.3939490-1-yukuai1@huaweicloud.com>
References: <20231110172834.3939490-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgA3iA4E+U1l0pQlAg--.33627S7
X-Coremail-Antispam: 1UD129KBjvJXoWxur4UWr1UJFW5Xr4xAFWfuFg_yoWrCr1xp3
        yxJF98Ar4YyrZ3Zry7t3WDAay5uw1IqrWqyry3W34fAFn3tr47KF1Y9F1UAFykKayrAa1U
        XayrtF4fuFyrWr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR_-BtUUUUU
        =
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

It doesn't make sense that "echo idle/forzon > sync_action" doesn't
return error to user if idle/frozen_sync_thread() is interrupted.

Also make sure array recovery flags is not changed if error is returned.

Fixes: 8e8e2518fcec ("md: Close race when setting 'action' to 'idle'.")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
---
 drivers/md/md.c | 70 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5c9387369de1..d7b9d597b54d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4848,13 +4848,16 @@ action_show(struct mddev *mddev, char *page)
 	return sprintf(page, "%s\n", type);
 }
 
-static void stop_sync_thread(struct mddev *mddev)
+static int stop_sync_thread(struct mddev *mddev)
 {
+	int ret = 0;
+
 	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
-		return;
+		return 0;
 
-	if (mddev_lock(mddev))
-		return;
+	ret = mddev_lock(mddev);
+	if (ret)
+		return ret;
 
 	/*
 	 * Check again in case MD_RECOVERY_RUNNING is cleared before lock is
@@ -4862,7 +4865,7 @@ static void stop_sync_thread(struct mddev *mddev)
 	 */
 	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 		mddev_unlock(mddev);
-		return;
+		return 0;
 	}
 
 	if (work_pending(&mddev->sync_work))
@@ -4876,50 +4879,69 @@ static void stop_sync_thread(struct mddev *mddev)
 	md_wakeup_thread_directly(mddev->sync_thread);
 
 	mddev_unlock(mddev);
+	return 0;
 }
 
-static void idle_sync_thread(struct mddev *mddev)
+static int idle_sync_thread(struct mddev *mddev)
 {
+	int ret;
 	int sync_seq = atomic_read(&mddev->sync_seq);
+	bool flag;
 
-	if (mutex_lock_interruptible(&mddev->sync_mutex))
-		return;
+	ret = mutex_lock_interruptible(&mddev->sync_mutex);
+	if (ret)
+		return ret;
 
-	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	stop_sync_thread(mddev);
+	flag = test_and_clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	ret = stop_sync_thread(mddev);
+	if (ret)
+		goto out;
 
-	wait_event_interruptible(resync_wait,
+	ret = wait_event_interruptible(resync_wait,
 			sync_seq != atomic_read(&mddev->sync_seq) ||
 			!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
-
+out:
+	if (ret && flag)
+		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	mutex_unlock(&mddev->sync_mutex);
+	return ret;
 }
 
-static void frozen_sync_thread(struct mddev *mddev)
+static int frozen_sync_thread(struct mddev *mddev)
 {
-	if (mutex_lock_interruptible(&mddev->sync_mutex))
-		return;
+	int ret = mutex_lock_interruptible(&mddev->sync_mutex);
+	bool flag;
 
-	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-	stop_sync_thread(mddev);
+	if (ret)
+		return ret;
 
-	wait_event_interruptible(resync_wait, mddev->sync_thread == NULL &&
-			!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
+	flag = test_and_set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	ret = stop_sync_thread(mddev);
+	if (ret)
+		goto out;
 
+	ret = wait_event_interruptible(resync_wait,
+			mddev->sync_thread == NULL &&
+			!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
+out:
+	if (ret && !flag)
+		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	mutex_unlock(&mddev->sync_mutex);
+	return ret;
 }
 
 static ssize_t
 action_store(struct mddev *mddev, const char *page, size_t len)
 {
+	int ret = 0;
+
 	if (!mddev->pers || !mddev->pers->sync_request)
 		return -EINVAL;
 
-
 	if (cmd_match(page, "idle"))
-		idle_sync_thread(mddev);
+		ret = idle_sync_thread(mddev);
 	else if (cmd_match(page, "frozen"))
-		frozen_sync_thread(mddev);
+		ret = frozen_sync_thread(mddev);
 	else if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		return -EBUSY;
 	else if (cmd_match(page, "resync"))
@@ -4963,6 +4985,10 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 		set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
 		set_bit(MD_RECOVERY_SYNC, &mddev->recovery);
 	}
+
+	if (ret)
+		return ret;
+
 	if (mddev->ro == MD_AUTO_READ) {
 		/* A write to sync_action is enough to justify
 		 * canceling read-auto mode
-- 
2.39.2

