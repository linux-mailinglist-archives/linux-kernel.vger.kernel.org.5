Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BFD76EA3B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjHCN1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbjHCN1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:27:34 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64031134;
        Thu,  3 Aug 2023 06:27:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RGqQQ0VcHz4f4Hwm;
        Thu,  3 Aug 2023 21:27:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7M6q8tk5SrlPQ--.7420S9;
        Thu, 03 Aug 2023 21:27:28 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 05/13] md: factor out a helper hot_remove_rdev() from remove_and_add_spares()
Date:   Thu,  3 Aug 2023 21:24:18 +0800
Message-Id: <20230803132426.2688608-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
References: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7M6q8tk5SrlPQ--.7420S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtr47GrWfuw4kZwb_yoW8WF13pa
        17KFyfWr43Aw17Ja13Xr4DGFy5Jw18ta1Iya4fWa4Iv3W3AryDWw1fXFy3Xr9YyFZY9F4f
        JF4ftw45Cry0gF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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

There are no functional changes, just to make the code simpler and
prepare to refactor remove_and_add_spares().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8017371a9e53..74ee31f2706b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9179,6 +9179,23 @@ static bool rdev_is_spare(struct md_rdev *rdev)
 	       !test_bit(Faulty, &rdev->flags);
 }
 
+static bool hot_remove_rdev(struct md_rdev *rdev)
+{
+	struct mddev *mddev;
+
+	if (!rdev_removeable(rdev))
+		return false;
+
+	mddev = rdev->mddev;
+	if (mddev->pers->hot_remove_disk(mddev, rdev))
+		return false;
+
+	sysfs_unlink_rdev(mddev, rdev);
+	rdev->saved_raid_disk = rdev->raid_disk;
+	rdev->raid_disk = -1;
+	return true;
+}
+
 static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this)
 {
@@ -9190,15 +9207,9 @@ static int remove_and_add_spares(struct mddev *mddev,
 		/* Mustn't remove devices when resync thread is running */
 		return 0;
 
-	rdev_for_each(rdev, mddev) {
-		if ((this == NULL || rdev == this) && rdev_removeable(rdev) &&
-		    !mddev->pers->hot_remove_disk(mddev, rdev)) {
-			sysfs_unlink_rdev(mddev, rdev);
-			rdev->saved_raid_disk = rdev->raid_disk;
-			rdev->raid_disk = -1;
+	rdev_for_each(rdev, mddev)
+		if ((this == NULL || rdev == this) && hot_remove_rdev(rdev))
 			removed++;
-		}
-	}
 
 	if (removed && mddev->kobj.sd)
 		sysfs_notify_dirent_safe(mddev->sysfs_degraded);
-- 
2.39.2

