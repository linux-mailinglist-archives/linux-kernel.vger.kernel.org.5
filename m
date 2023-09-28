Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941AA7B12A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjI1GWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjI1GWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:22:02 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F8EB4;
        Wed, 27 Sep 2023 23:22:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx3Kc3wGtz4f3jqc;
        Thu, 28 Sep 2023 14:21:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnvdyCGxVl3v1WBg--.22861S7;
        Thu, 28 Sep 2023 14:21:57 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 03/25] md: add new helpers to suspend/resume array
Date:   Thu, 28 Sep 2023 14:15:21 +0800
Message-Id: <20230928061543.1845742-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
References: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnvdyCGxVl3v1WBg--.22861S7
X-Coremail-Antispam: 1UD129KBjvJXoWxKrykZr4xGrWDXF4DJF1UWrg_yoWxJw47p3
        yIqFZ5tr4UJF9xZw47tasrWa45Ww1rKFWDtrZrW3W3Cw1akr4rWr15Xr15Xr1vka4xCr4D
        Jw40qayUuFy8WFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
        CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUojjgUUUU
        U
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Advantages for new apis:
 - reconfig_mutex is not required;
 - the weird logical that suspend array hold 'reconfig_mutex' for
   mddev_check_recovery() to update superblock is not needed;
 - the specail handling, 'pers->prepare_suspend', for raid456 is not
   needed;
 - It's safe to be called at any time once mddev is allocated, and it's
   designed to be used from slow path where array configuration is changed;
 - the new helpers is designed to be called before mddev_lock(), hence
   it support to be interrupted by user as well.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/md/md.h |   3 ++
 2 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index e460b380143d..a075d03d03d3 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -443,12 +443,22 @@ void mddev_suspend(struct mddev *mddev)
 			lockdep_is_held(&mddev->reconfig_mutex));
 
 	WARN_ON_ONCE(thread && current == thread->tsk);
-	if (mddev->suspended++)
+
+	/* can't concurrent with __mddev_suspend() and __mddev_resume() */
+	mutex_lock(&mddev->suspend_mutex);
+	if (mddev->suspended++) {
+		mutex_unlock(&mddev->suspend_mutex);
 		return;
+	}
+
 	wake_up(&mddev->sb_wait);
 	set_bit(MD_ALLOW_SB_UPDATE, &mddev->flags);
 	percpu_ref_kill(&mddev->active_io);
 
+	/*
+	 * TODO: cleanup 'pers->prepare_suspend after all callers are replaced
+	 * by __mddev_suspend().
+	 */
 	if (mddev->pers && mddev->pers->prepare_suspend)
 		mddev->pers->prepare_suspend(mddev);
 
@@ -459,14 +469,21 @@ void mddev_suspend(struct mddev *mddev)
 	del_timer_sync(&mddev->safemode_timer);
 	/* restrict memory reclaim I/O during raid array is suspend */
 	mddev->noio_flag = memalloc_noio_save();
+
+	mutex_unlock(&mddev->suspend_mutex);
 }
 EXPORT_SYMBOL_GPL(mddev_suspend);
 
 void mddev_resume(struct mddev *mddev)
 {
 	lockdep_assert_held(&mddev->reconfig_mutex);
-	if (--mddev->suspended)
+
+	/* can't concurrent with __mddev_suspend() and __mddev_resume() */
+	mutex_lock(&mddev->suspend_mutex);
+	if (--mddev->suspended) {
+		mutex_unlock(&mddev->suspend_mutex);
 		return;
+	}
 
 	/* entred the memalloc scope from mddev_suspend() */
 	memalloc_noio_restore(mddev->noio_flag);
@@ -477,9 +494,89 @@ void mddev_resume(struct mddev *mddev)
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	md_wakeup_thread(mddev->thread);
 	md_wakeup_thread(mddev->sync_thread); /* possibly kick off a reshape */
+
+	mutex_unlock(&mddev->suspend_mutex);
 }
 EXPORT_SYMBOL_GPL(mddev_resume);
 
+int __mddev_suspend(struct mddev *mddev, bool interruptible)
+{
+	int err = 0;
+
+	/*
+	 * hold reconfig_mutex to wait for normal io will deadlock, because
+	 * other context can't update super_block, and normal io can rely on
+	 * updating super_block.
+	 */
+	lockdep_assert_not_held(&mddev->reconfig_mutex);
+
+	if (interruptible)
+		err = mutex_lock_interruptible(&mddev->suspend_mutex);
+	else
+		mutex_lock(&mddev->suspend_mutex);
+	if (err)
+		return err;
+
+	if (mddev->suspended) {
+		WRITE_ONCE(mddev->suspended, mddev->suspended + 1);
+		mutex_unlock(&mddev->suspend_mutex);
+		return 0;
+	}
+
+	percpu_ref_kill(&mddev->active_io);
+	if (interruptible)
+		err = wait_event_interruptible(mddev->sb_wait,
+				percpu_ref_is_zero(&mddev->active_io));
+	else
+		wait_event(mddev->sb_wait,
+				percpu_ref_is_zero(&mddev->active_io));
+	if (err) {
+		percpu_ref_resurrect(&mddev->active_io);
+		mutex_unlock(&mddev->suspend_mutex);
+		return err;
+	}
+
+	/*
+	 * For raid456, io might be waiting for reshape to make progress,
+	 * allow new reshape to start while waiting for io to be done to
+	 * prevent deadlock.
+	 */
+	WRITE_ONCE(mddev->suspended, mddev->suspended + 1);
+
+	del_timer_sync(&mddev->safemode_timer);
+	/* restrict memory reclaim I/O during raid array is suspend */
+	mddev->noio_flag = memalloc_noio_save();
+
+	mutex_unlock(&mddev->suspend_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__mddev_suspend);
+
+void __mddev_resume(struct mddev *mddev)
+{
+	lockdep_assert_not_held(&mddev->reconfig_mutex);
+
+	mutex_lock(&mddev->suspend_mutex);
+	WRITE_ONCE(mddev->suspended, mddev->suspended - 1);
+	if (mddev->suspended) {
+		mutex_unlock(&mddev->suspend_mutex);
+		return;
+	}
+
+	/* entred the memalloc scope from __mddev_suspend() */
+	memalloc_noio_restore(mddev->noio_flag);
+
+	percpu_ref_resurrect(&mddev->active_io);
+	wake_up(&mddev->sb_wait);
+
+	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(mddev->sync_thread); /* possibly kick off a reshape */
+
+	mutex_unlock(&mddev->suspend_mutex);
+}
+EXPORT_SYMBOL_GPL(__mddev_resume);
+
 /*
  * Generic flush handling for md
  */
@@ -672,6 +769,7 @@ int mddev_init(struct mddev *mddev)
 	mutex_init(&mddev->open_mutex);
 	mutex_init(&mddev->reconfig_mutex);
 	mutex_init(&mddev->sync_mutex);
+	mutex_init(&mddev->suspend_mutex);
 	mutex_init(&mddev->bitmap_info.mutex);
 	INIT_LIST_HEAD(&mddev->disks);
 	INIT_LIST_HEAD(&mddev->all_mddevs);
diff --git a/drivers/md/md.h b/drivers/md/md.h
index b628c292506e..b5894dc64615 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -316,6 +316,7 @@ struct mddev {
 	unsigned long			sb_flags;
 
 	int				suspended;
+	struct mutex			suspend_mutex;
 	struct percpu_ref		active_io;
 	int				ro;
 	int				sysfs_active; /* set when sysfs deletes
@@ -811,6 +812,8 @@ extern void md_rdev_clear(struct md_rdev *rdev);
 extern void md_handle_request(struct mddev *mddev, struct bio *bio);
 extern void mddev_suspend(struct mddev *mddev);
 extern void mddev_resume(struct mddev *mddev);
+extern int __mddev_suspend(struct mddev *mddev, bool interruptible);
+extern void __mddev_resume(struct mddev *mddev);
 
 extern void md_reload_sb(struct mddev *mddev, int raid_disk);
 extern void md_update_sb(struct mddev *mddev, int force);
-- 
2.39.2

