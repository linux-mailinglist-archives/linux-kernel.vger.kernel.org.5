Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BA076EA46
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjHCN2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbjHCN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:27:41 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C6273E;
        Thu,  3 Aug 2023 06:27:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGqQV6gD1z4f3jMN;
        Thu,  3 Aug 2023 21:27:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7M6q8tk5SrlPQ--.7420S17;
        Thu, 03 Aug 2023 21:27:31 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 13/13] md: delay remove_and_add_spares() for read only array to md_start_sync()
Date:   Thu,  3 Aug 2023 21:24:26 +0800
Message-Id: <20230803132426.2688608-14-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
References: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7M6q8tk5SrlPQ--.7420S17
X-Coremail-Antispam: 1UD129KBjvJXoWxZry5GFyrZryfZF17uw4fAFb_yoW5Zr15pr
        4SyF909r4Dt34fZr47Gw1DWa4Fkr10qrZFyry3ua48Aw13Ars7G34rWa4DJryrJa4Sya13
        Ja18KFs8CF18GaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index ef88581d9a39..f6e024c15530 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9188,6 +9188,16 @@ static bool rdev_addable(struct md_rdev *rdev)
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
 static bool rdev_is_spare(struct md_rdev *rdev)
 {
 	return !test_bit(Candidate, &rdev->flags) && rdev->raid_disk >= 0 &&
@@ -9265,6 +9275,12 @@ static void md_start_sync(struct work_struct *ws)
 
 	mddev_lock_nointr(mddev);
 
+	if (!md_is_rdwr(mddev)) {
+		remove_and_add_spares(mddev);
+		mddev_unlock(mddev);
+		return;
+	}
+
 	/*
 	 * No recovery is running, remove any failed drives, then add spares if
 	 * possible. Spares are also removed and re-added, to allow the
@@ -9381,7 +9397,8 @@ void md_check_recovery(struct mddev *mddev)
 	}
 
 	if (!md_is_rdwr(mddev) &&
-	    !test_bit(MD_RECOVERY_NEEDED, &mddev->recovery))
+	    (!test_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
+	     work_pending(&mddev->sync_work)))
 		return;
 	if ( ! (
 		(mddev->sb_flags & ~ (1<<MD_SB_CHANGE_PENDING)) ||
@@ -9409,15 +9426,8 @@ void md_check_recovery(struct mddev *mddev)
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
-			remove_and_add_spares(mddev);
-			/* There is no thread, but we need to call
+			/*
+			 * There is no thread, but we need to call
 			 * ->spare_active and clear saved_raid_disk
 			 */
 			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
@@ -9425,6 +9435,13 @@ void md_check_recovery(struct mddev *mddev)
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

