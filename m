Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B7D807E35
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441966AbjLGCIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjLGCId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:08:33 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2EAF7;
        Wed,  6 Dec 2023 18:08:38 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SlyNt5ZYxz4f3m6f;
        Thu,  7 Dec 2023 10:08:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 83AEB1A0C14;
        Thu,  7 Dec 2023 10:08:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgBXWhAgKXFlIBzOCw--.9536S4;
        Thu, 07 Dec 2023 10:08:33 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, yukuai3@huawei.com
Cc:     pmenzel@molgen.mpg.de, janpieter.sollie@edpnet.be,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH v2] md: split MD_RECOVERY_NEEDED out of mddev_resume
Date:   Thu,  7 Dec 2023 10:07:24 +0800
Message-Id: <20231207020724.2797445-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXWhAgKXFlIBzOCw--.9536S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1Dur43Zr17Jw1rGF13XFb_yoW5Zw48pa
        yxtF95Wr4UZFZ3XrWUGa4kWa45Jw10grZFyFW3u3sxA34rt3yfWr15ur1DXrWkt3s2qFs8
        Xa1Fva1xAr1jgrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DUUUU
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

New mddev_resume() calls are added to synchronize IO with array
reconfiguration, however, this introduces a performance regression while
adding it in md_start_sync():

1) someone sets MD_RECOVERY_NEEDED first;
2) daemon thread grabs reconfig_mutex, then clears MD_RECOVERY_NEEDED and
   queues a new sync work;
3) daemon thread releases reconfig_mutex;
4) in md_start_sync
   a) check that there are spares that can be added/removed, then suspend
      the array;
   b) remove_and_add_spares may not be called, or called without really
      add/remove spares;
   c) resume the array, then set MD_RECOVERY_NEEDED again!

Loop between 2 - 4, then mddev_suspend() will be called quite often, for
consequence, normal IO will be quite slow.

Fix this problem by don't set MD_RECOVERY_NEEDED again in md_start_sync(),
hence the loop will be broken.

Fixes: bc08041b32ab ("md: suspend array in md_start_sync() if array need reconfiguration")
Suggested-by: Song Liu <song@kernel.org>
Reported-by: Janpieter Sollie <janpieter.sollie@edpnet.be>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218200
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v2:
 - use a new approch as suggested by Song Liu;

 drivers/md/md.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index bc9d67af1961..49540db8a210 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -490,7 +490,7 @@ int mddev_suspend(struct mddev *mddev, bool interruptible)
 }
 EXPORT_SYMBOL_GPL(mddev_suspend);
 
-void mddev_resume(struct mddev *mddev)
+static void __mddev_resume(struct mddev *mddev, bool recovery_needed)
 {
 	lockdep_assert_not_held(&mddev->reconfig_mutex);
 
@@ -507,12 +507,18 @@ void mddev_resume(struct mddev *mddev)
 	percpu_ref_resurrect(&mddev->active_io);
 	wake_up(&mddev->sb_wait);
 
-	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+	if (recovery_needed)
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	md_wakeup_thread(mddev->thread);
 	md_wakeup_thread(mddev->sync_thread); /* possibly kick off a reshape */
 
 	mutex_unlock(&mddev->suspend_mutex);
 }
+
+void mddev_resume(struct mddev *mddev)
+{
+	return __mddev_resume(mddev, true);
+}
 EXPORT_SYMBOL_GPL(mddev_resume);
 
 /*
@@ -9389,7 +9395,9 @@ static void md_start_sync(struct work_struct *ws)
 		goto not_running;
 	}
 
-	suspend ? mddev_unlock_and_resume(mddev) : mddev_unlock(mddev);
+	mddev_unlock(mddev);
+	if (suspend)
+		__mddev_resume(mddev, false);
 	md_wakeup_thread(mddev->sync_thread);
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
 	md_new_event();
@@ -9401,7 +9409,9 @@ static void md_start_sync(struct work_struct *ws)
 	clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
 	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 	clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
-	suspend ? mddev_unlock_and_resume(mddev) : mddev_unlock(mddev);
+	mddev_unlock(mddev);
+	if (suspend)
+		__mddev_resume(mddev, false);
 
 	wake_up(&resync_wait);
 	if (test_and_clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery) &&
-- 
2.39.2

