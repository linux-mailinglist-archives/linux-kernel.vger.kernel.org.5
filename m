Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0671F76EA50
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbjHCN2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjHCN1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:27:43 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871E12D4E;
        Thu,  3 Aug 2023 06:27:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RGqQS0FBxz4f3lx7;
        Thu,  3 Aug 2023 21:27:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7M6q8tk5SrlPQ--.7420S14;
        Thu, 03 Aug 2023 21:27:30 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 10/13] md: cleanup remove_and_add_spares()
Date:   Thu,  3 Aug 2023 21:24:23 +0800
Message-Id: <20230803132426.2688608-11-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
References: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7M6q8tk5SrlPQ--.7420S14
X-Coremail-Antispam: 1UD129KBjvJXoWxJFW7KF45tr4DZr15AFyxXwb_yoW5XFy3pa
        1Ik3ZxCr4UZ3yfZayjqr4DGa45Jr10qrZFyFy7ua4fZ3Wayr1vga4rZFy7ArZ5AasY9F43
        Aw48Kw45ur18GF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Now that remove_and_add_spares() is only called from daemon thread, and
the second parameter is always NULL, remove the second parameter.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1dc26bb1e096..e64d1d0b4c5c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -86,8 +86,6 @@ static struct workqueue_struct *md_misc_wq;
 struct workqueue_struct *md_bitmap_wq;
 
 static bool hot_remove_rdev(struct md_rdev *rdev);
-static int remove_and_add_spares(struct mddev *mddev,
-				 struct md_rdev *this);
 static void mddev_detach(struct mddev *mddev);
 static void export_rdev(struct md_rdev *rdev, struct mddev *mddev);
 static void md_wakeup_thread_directly(struct md_thread __rcu *thread);
@@ -9232,36 +9230,26 @@ static bool hot_add_rdev(struct md_rdev *rdev)
 	return true;
 }
 
-static int remove_and_add_spares(struct mddev *mddev,
-				 struct md_rdev *this)
+static int remove_and_add_spares(struct mddev *mddev)
 {
 	struct md_rdev *rdev;
 	int spares = 0;
 	int removed = 0;
 
-	if (this && test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
-		/* Mustn't remove devices when resync thread is running */
-		return 0;
-
 	rdev_for_each(rdev, mddev)
-		if ((this == NULL || rdev == this) && hot_remove_rdev(rdev))
+		if (hot_remove_rdev(rdev))
 			removed++;
 
 	if (removed && mddev->kobj.sd)
 		sysfs_notify_dirent_safe(mddev->sysfs_degraded);
 
-	if (this && removed)
-		goto no_add;
-
 	rdev_for_each(rdev, mddev) {
-		if (this && this != rdev)
-			continue;
 		if (rdev_is_spare(rdev))
 			spares++;
 		if (hot_add_rdev(rdev) && !test_bit(Journal, &rdev->flags))
 			spares++;
 	}
-no_add:
+
 	if (removed)
 		set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
 	return spares;
@@ -9381,7 +9369,7 @@ void md_check_recovery(struct mddev *mddev)
 			 * As we only add devices that are already in-sync,
 			 * we can activate the spares immediately.
 			 */
-			remove_and_add_spares(mddev, NULL);
+			remove_and_add_spares(mddev);
 			/* There is no thread, but we need to call
 			 * ->spare_active and clear saved_raid_disk
 			 */
@@ -9462,7 +9450,7 @@ void md_check_recovery(struct mddev *mddev)
 				goto not_running;
 			set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 			clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
-		} else if ((spares = remove_and_add_spares(mddev, NULL))) {
+		} else if ((spares = remove_and_add_spares(mddev))) {
 			clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
 			clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 			clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
-- 
2.39.2

