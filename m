Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D218E787E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbjHYDVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjHYDUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:20:41 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6411FD2;
        Thu, 24 Aug 2023 20:20:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RX4w15X38z4f3tDl;
        Fri, 25 Aug 2023 11:20:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHoqUBHuhkPT4XBg--.14533S11;
        Fri, 25 Aug 2023 11:20:37 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 7/7] md: delay remove_and_add_spares() for read only array to md_start_sync()
Date:   Fri, 25 Aug 2023 11:16:22 +0800
Message-Id: <20230825031622.1530464-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230825031622.1530464-1-yukuai1@huaweicloud.com>
References: <20230825031622.1530464-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHoqUBHuhkPT4XBg--.14533S11
X-Coremail-Antispam: 1UD129KBjvJXoWxZry5GFyrZryfZF17uw4fAFb_yoW7Jw43p3
        yftF9xKr4UJ3yfZrZrC3WDWa45Jw10qrZrtry3Wa48Aw13Ar93C345WayUJr98ta4Ska15
        Aw45KFZ8CF1jkF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUArcfUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Before this patch, for read-only array:

md_check_recovery() check that 'MD_RECOVERY_NEEDED' is set, then it will
call remove_and_add_spares() directly to try to remove and add rdevs
from array.

After this patch:

1) md_check_recovery() check that 'MD_RECOVERY_NEEDED' is set, and the
   worker 'sync_work' is not pending, and there are rdevs can be added
   or removed, then it will queue new work md_start_sync();
2) md_start_sync() will call remove_and_add_spares() and exist;

This change make sure that array reconfiguration is independent from
daemon, and it'll be much easier to synchronize it with io, consier
that io may rely on daemon thread to be done.

Also fix a problem that 'pers->spars_active' is called after
remove_and_add_spares(), which order is wrong, because spares must
active first, and then remove_and_add_spares() can add spares to the
array, like what read-write case does:

1) daemon set 'MD_RECOVERY_RUNNING', register new sync thread to do
   recovery;
2) recovery is done, md_do_sync() set 'MD_RECOVERY_DONE' before return;
3) daemon call 'pers->spars_active', and clear 'MD_RECOVERY_RUNNING';
4) in the next round of daemon, call remove_and_add_spares() to add
   spares to the array.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 61 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 851cf10d0178..7cd3e34fd1b5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4866,6 +4866,7 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 		/* A write to sync_action is enough to justify
 		 * canceling read-auto mode
 		 */
+		flush_work(&mddev->sync_work);
 		mddev->ro = MD_RDWR;
 		md_wakeup_thread(mddev->sync_thread);
 	}
@@ -7638,6 +7639,10 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 		mutex_unlock(&mddev->open_mutex);
 		sync_blockdev(bdev);
 	}
+
+	if (!md_is_rdwr(mddev))
+		flush_work(&mddev->sync_work);
+
 	err = mddev_lock(mddev);
 	if (err) {
 		pr_debug("md: ioctl lock interrupted, reason %d, cmd %d\n",
@@ -8562,6 +8567,7 @@ bool md_write_start(struct mddev *mddev, struct bio *bi)
 	BUG_ON(mddev->ro == MD_RDONLY);
 	if (mddev->ro == MD_AUTO_READ) {
 		/* need to switch to read/write */
+		flush_work(&mddev->sync_work);
 		mddev->ro = MD_RDWR;
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 		md_wakeup_thread(mddev->thread);
@@ -9222,6 +9228,16 @@ static bool rdev_addable(struct md_rdev *rdev)
 	return false;
 }
 
+static bool md_spares_need_change(struct mddev *mddev)
+{
+	struct md_rdev *rdev;
+
+	rdev_for_each(rdev, mddev)
+		if (rdev_removeable(rdev) || rdev_addable(rdev))
+			return true;
+	return false;
+}
+
 static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this)
 {
@@ -9349,6 +9365,18 @@ static void md_start_sync(struct work_struct *ws)
 
 	mddev_lock_nointr(mddev);
 
+	if (!md_is_rdwr(mddev)) {
+		/*
+		 * On a read-only array we can:
+		 * - remove failed devices
+		 * - add already-in_sync devices if the array itself is in-sync.
+		 * As we only add devices that are already in-sync, we can
+		 * activate the spares immediately.
+		 */
+		remove_and_add_spares(mddev, NULL);
+		goto not_running;
+	}
+
 	if (!md_choose_sync_action(mddev, &spares))
 		goto not_running;
 
@@ -9463,30 +9491,43 @@ void md_check_recovery(struct mddev *mddev)
 
 		if (!md_is_rdwr(mddev)) {
 			struct md_rdev *rdev;
+
+			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+				/* sync_work already queued. */
+				clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+				goto unlock;
+			}
+
 			if (!mddev->external && mddev->in_sync)
-				/* 'Blocked' flag not needed as failed devices
+				/*
+				 * 'Blocked' flag not needed as failed devices
 				 * will be recorded if array switched to read/write.
 				 * Leaving it set will prevent the device
 				 * from being removed.
 				 */
 				rdev_for_each(rdev, mddev)
 					clear_bit(Blocked, &rdev->flags);
-			/* On a read-only array we can:
-			 * - remove failed devices
-			 * - add already-in_sync devices if the array itself
-			 *   is in-sync.
-			 * As we only add devices that are already in-sync,
-			 * we can activate the spares immediately.
-			 */
-			remove_and_add_spares(mddev, NULL);
-			/* There is no thread, but we need to call
+
+			/*
+			 * There is no thread, but we need to call
 			 * ->spare_active and clear saved_raid_disk
 			 */
 			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 			md_reap_sync_thread(mddev);
+
+			/*
+			 * Let md_start_sync() to remove and add rdevs to the
+			 * array.
+			 */
+			if (md_spares_need_change(mddev)) {
+				set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
+				queue_work(md_misc_wq, &mddev->sync_work);
+			}
+
 			clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 			clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 			clear_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags);
+
 			goto unlock;
 		}
 
-- 
2.39.2

