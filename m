Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA2877C64C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjHODQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjHODOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:14:22 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A52199A;
        Mon, 14 Aug 2023 20:13:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RPxDd4MSVz4f3q3s;
        Tue, 15 Aug 2023 11:13:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6ld7dpknET3Ag--.64666S11;
        Tue, 15 Aug 2023 11:13:37 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 7/7] md: delay remove_and_add_spares() for read only array to md_start_sync()
Date:   Tue, 15 Aug 2023 11:09:57 +0800
Message-Id: <20230815030957.509535-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815030957.509535-1-yukuai1@huaweicloud.com>
References: <20230815030957.509535-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXp6ld7dpknET3Ag--.64666S11
X-Coremail-Antispam: 1UD129KBjvJXoWxZry5GFyrZryfZF17uw4fAFb_yoW5Cry7pr
        4ftF9Igr4Ut3yfZr47G3WDGa4Yyr10qrZFyry3ua4xAw13Arn7C34rXayDXryrta4SyF43
        Aw48KFs8uF1rKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
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

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d26d2c35f9af..74d529479fcf 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9191,6 +9191,16 @@ static bool rdev_addable(struct md_rdev *rdev)
 	return true;
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
@@ -9309,6 +9319,12 @@ static void md_start_sync(struct work_struct *ws)
 
 	mddev_lock_nointr(mddev);
 
+	if (!md_is_rdwr(mddev)) {
+		remove_and_add_spares(mddev, NULL);
+		mddev_unlock(mddev);
+		return;
+	}
+
 	if (!md_choose_sync_direction(mddev, &spares))
 		goto not_running;
 
@@ -9403,7 +9419,8 @@ void md_check_recovery(struct mddev *mddev)
 	}
 
 	if (!md_is_rdwr(mddev) &&
-	    !test_bit(MD_RECOVERY_NEEDED, &mddev->recovery))
+	    (!test_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
+	     work_pending(&mddev->sync_work)))
 		return;
 	if ( ! (
 		(mddev->sb_flags & ~ (1<<MD_SB_CHANGE_PENDING)) ||
@@ -9431,15 +9448,8 @@ void md_check_recovery(struct mddev *mddev)
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
+			/*
+			 * There is no thread, but we need to call
 			 * ->spare_active and clear saved_raid_disk
 			 */
 			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
@@ -9447,6 +9457,13 @@ void md_check_recovery(struct mddev *mddev)
 			clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 			clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 			clear_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags);
+
+			/*
+			 * Let md_start_sync() to remove and add rdevs to the
+			 * array.
+			 */
+			if (md_spares_need_change(mddev))
+				queue_work(md_misc_wq, &mddev->sync_work);
 			goto unlock;
 		}
 
-- 
2.39.2

