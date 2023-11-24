Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10957F6DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjKXIE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjKXIEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:04:34 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB3A172B;
        Fri, 24 Nov 2023 00:00:22 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sc6pp1wsZz4f3mHs;
        Fri, 24 Nov 2023 16:00:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 008EF1A0B36;
        Fri, 24 Nov 2023 16:00:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgDX2xERWGBlUnAqBw--.22901S6;
        Fri, 24 Nov 2023 16:00:19 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, yukuai3@huawei.com, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH v2 2/6] md: remove redundant check of 'mddev->sync_thread'
Date:   Fri, 24 Nov 2023 15:59:49 +0800
Message-Id: <20231124075953.1932764-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231124075953.1932764-1-yukuai1@huaweicloud.com>
References: <20231124075953.1932764-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2xERWGBlUnAqBw--.22901S6
X-Coremail-Antispam: 1UD129KBjvJXoW3XF1DCw4UWr1kArWDWF1rZwb_yoW7XFyUpa
        yxJF98XrW8ZFW3XrWUK3WDXay5Zw1jqFZFyFyfWa4rJw1fKr42kF45uFyUAFWkJa9Yya15
        Z34rJF45ZFy09w7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

The lifetime of sync_thread:

1) Set MD_RECOVERY_NEEDED and wake up daemon thread (by ioctl/sysfs or
   other events);
2) Daemon thread woke up, md_check_recovery() found that
   MD_RECOVERY_NEEDED is set:
   a) try to grab reconfig_mutex;
   b) set MD_RECOVERY_RUNNING;
   c) clear MD_RECOVERY_NEEDED, and then queue sync_work;
3) md_start_sync() choose sync_action, then register sync_thread;
4) md_do_sync() is done, set MD_RECOVERY_DONE and wake up daemon thread;
5) Daemon thread woke up, md_check_recovery() found that
   MD_RECOVERY_DONE is set:
   a) try to grab reconfig_mutex;
   b) unregister sync_thread;
   c) clear MD_RECOVERY_RUNNING and MD_RECOVERY_DONE;

Hence if MD_RECOVERY_RUNNING is not set, mddev->sync_thread must be
NULL, there is no need to judge "mddev->sync_thread == NULL" if
MD_RECOVERY_RUNNING is not set.

Noted that unregister sync_thread(md_reap_sync_thread()) from other
context is wrong and will cause deadlock, for example commit
130443d60b1b ("md: refactor idle/frozen_sync_thread() to fix deadlock").

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c    | 22 +++++++---------------
 drivers/md/raid5.c |  6 ++----
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1701e2fb219f..1d33a39d4f13 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3302,8 +3302,7 @@ static ssize_t new_offset_store(struct md_rdev *rdev,
 	if (kstrtoull(buf, 10, &new_offset) < 0)
 		return -EINVAL;
 
-	if (mddev->sync_thread ||
-	    test_bit(MD_RECOVERY_RUNNING,&mddev->recovery))
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		return -EBUSY;
 	if (new_offset == rdev->data_offset)
 		/* reset is always permitted */
@@ -3987,8 +3986,7 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
 	 */
 
 	rv = -EBUSY;
-	if (mddev->sync_thread ||
-	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
 	    mddev->reshape_position != MaxSector ||
 	    mddev->sysfs_active)
 		goto out_unlock;
@@ -4898,8 +4896,7 @@ static void frozen_sync_thread(struct mddev *mddev)
 	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	stop_sync_thread(mddev);
 
-	wait_event(resync_wait, mddev->sync_thread == NULL &&
-			!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
+	wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
 
 	mutex_unlock(&mddev->sync_mutex);
 }
@@ -6388,7 +6385,6 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 
 	mutex_lock(&mddev->open_mutex);
 	if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
-	    mddev->sync_thread ||
 	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 		pr_warn("md: %s still in use.\n",mdname(mddev));
 		if (did_freeze) {
@@ -6444,15 +6440,13 @@ static int do_md_stop(struct mddev *mddev, int mode,
 	md_wakeup_thread_directly(mddev->sync_thread);
 
 	mddev_unlock(mddev);
-	wait_event(resync_wait, (mddev->sync_thread == NULL &&
-				 !test_bit(MD_RECOVERY_RUNNING,
-					   &mddev->recovery)));
+	wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
+					  &mddev->recovery));
 	mddev_lock_nointr(mddev);
 
 	mutex_lock(&mddev->open_mutex);
 	if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
 	    mddev->sysfs_active ||
-	    mddev->sync_thread ||
 	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 		pr_warn("md: %s still in use.\n",mdname(mddev));
 		mutex_unlock(&mddev->open_mutex);
@@ -7298,8 +7292,7 @@ static int update_size(struct mddev *mddev, sector_t num_sectors)
 	 * of each device.  If num_sectors is zero, we find the largest size
 	 * that fits.
 	 */
-	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
-	    mddev->sync_thread)
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		return -EBUSY;
 	if (!md_is_rdwr(mddev))
 		return -EROFS;
@@ -7336,8 +7329,7 @@ static int update_raid_disks(struct mddev *mddev, int raid_disks)
 	if (raid_disks <= 0 ||
 	    (mddev->max_disks && raid_disks >= mddev->max_disks))
 		return -EINVAL;
-	if (mddev->sync_thread ||
-	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
 	    test_bit(MD_RESYNCING_REMOTE, &mddev->recovery) ||
 	    mddev->reshape_position != MaxSector)
 		return -EBUSY;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4207e945e8c8..ec6cb8185207 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7018,10 +7018,8 @@ raid5_store_stripe_size(struct mddev  *mddev, const char *page, size_t len)
 	pr_debug("md/raid: change stripe_size from %lu to %lu\n",
 			conf->stripe_size, new);
 
-	if (mddev->sync_thread ||
-		test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
-		mddev->reshape_position != MaxSector ||
-		mddev->sysfs_active) {
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
+	    mddev->reshape_position != MaxSector || mddev->sysfs_active) {
 		err = -EBUSY;
 		goto out_unlock;
 	}
-- 
2.39.2

