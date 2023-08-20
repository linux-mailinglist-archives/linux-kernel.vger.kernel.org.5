Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED048781D24
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 11:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjHTJRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 05:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjHTJRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 05:17:07 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA249F5;
        Sun, 20 Aug 2023 02:13:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RT8zr5dhmz4f3tCt;
        Sun, 20 Aug 2023 17:13:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBahH2eFkmXibBA--.44158S8;
        Sun, 20 Aug 2023 17:13:47 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, mariusz.tkaczyk@linux.intel.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 4/7] md: factor out a helper rdev_removeable() from remove_and_add_spares()
Date:   Sun, 20 Aug 2023 17:09:46 +0800
Message-Id: <20230820090949.2874537-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBahH2eFkmXibBA--.44158S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtr13KF4fuw4Uurg_yoW8KFyfpa
        yfKFyYkr4UA3yaqw1kKrn5Ga45Xa18KayIkFy3Ga4FvasxAr98Xw1rKFy5Xr90yFZ3ZF4Y
        vF15Jw4rCr1xuF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
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

There are no functional changes, just to make the code simpler and
prepare to delay remove_and_add_spares() to md_start_sync().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 561cac13ff96..ceace5ffadd6 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9153,6 +9153,22 @@ void md_do_sync(struct md_thread *thread)
 }
 EXPORT_SYMBOL_GPL(md_do_sync);
 
+static bool rdev_removeable(struct md_rdev *rdev)
+{
+	if (rdev->raid_disk < 0 || test_bit(Blocked, &rdev->flags) ||
+	    atomic_read(&rdev->nr_pending))
+		return false;
+
+	if (test_bit(RemoveSynchronized, &rdev->flags))
+		return true;
+
+	if (test_bit(In_sync, &rdev->flags) ||
+	    test_bit(Journal, &rdev->flags))
+		return false;
+
+	return true;
+}
+
 static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this)
 {
@@ -9166,11 +9182,7 @@ static int remove_and_add_spares(struct mddev *mddev,
 		return 0;
 
 	rdev_for_each(rdev, mddev) {
-		if ((this == NULL || rdev == this) &&
-		    rdev->raid_disk >= 0 &&
-		    !test_bit(Blocked, &rdev->flags) &&
-		    test_bit(Faulty, &rdev->flags) &&
-		    atomic_read(&rdev->nr_pending)==0) {
+		if ((this == NULL || rdev == this) && rdev_removeable(rdev)) {
 			/* Faulty non-Blocked devices with nr_pending == 0
 			 * never get nr_pending incremented,
 			 * never get Faulty cleared, and never get Blocked set.
@@ -9185,19 +9197,12 @@ static int remove_and_add_spares(struct mddev *mddev,
 		synchronize_rcu();
 	rdev_for_each(rdev, mddev) {
 		if ((this == NULL || rdev == this) &&
-		    rdev->raid_disk >= 0 &&
-		    !test_bit(Blocked, &rdev->flags) &&
-		    ((test_bit(RemoveSynchronized, &rdev->flags) ||
-		     (!test_bit(In_sync, &rdev->flags) &&
-		      !test_bit(Journal, &rdev->flags))) &&
-		    atomic_read(&rdev->nr_pending)==0)) {
-			if (mddev->pers->hot_remove_disk(
-				    mddev, rdev) == 0) {
+		    rdev_removeable(rdev) &&
+		    mddev->pers->hot_remove_disk(mddev, rdev) == 0) {
 				sysfs_unlink_rdev(mddev, rdev);
 				rdev->saved_raid_disk = rdev->raid_disk;
 				rdev->raid_disk = -1;
 				removed++;
-			}
 		}
 		if (remove_some && test_bit(RemoveSynchronized, &rdev->flags))
 			clear_bit(RemoveSynchronized, &rdev->flags);
-- 
2.39.2

