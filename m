Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A443C781D23
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 11:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjHTJRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 05:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjHTJRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 05:17:07 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5F249FE;
        Sun, 20 Aug 2023 02:13:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RT8zw27Mbz4f3jqB;
        Sun, 20 Aug 2023 17:13:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBahH2eFkmXibBA--.44158S10;
        Sun, 20 Aug 2023 17:13:48 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, mariusz.tkaczyk@linux.intel.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 6/7] md: factor out a helper rdev_addable() from remove_and_add_spares()
Date:   Sun, 20 Aug 2023 17:09:48 +0800
Message-Id: <20230820090949.2874537-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBahH2eFkmXibBA--.44158S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtr13KF4ftr13Jwb_yoW8Ary8pa
        yrKFy3K3yUAF13W3WDKryUGa4Yqa10grWIkry2ka4rXas8Jrn8Kw4rCF90qF98JFZY9F45
        ZF15tw48ur1agFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
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
 drivers/md/md.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 11d27c934fdd..cdc361c521d4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9177,6 +9177,20 @@ static bool rdev_is_spare(struct md_rdev *rdev)
 	       !test_bit(Faulty, &rdev->flags);
 }
 
+static bool rdev_addable(struct md_rdev *rdev)
+{
+	if (test_bit(Candidate, &rdev->flags) || rdev->raid_disk >= 0 ||
+	    test_bit(Faulty, &rdev->flags))
+		return false;
+
+	if (!test_bit(Journal, &rdev->flags) && !md_is_rdwr(rdev->mddev) &&
+	    !(rdev->saved_raid_disk >= 0 &&
+	      !test_bit(Bitmap_sync, &rdev->flags)))
+		return false;
+
+	return true;
+}
+
 static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this)
 {
@@ -9227,20 +9241,10 @@ static int remove_and_add_spares(struct mddev *mddev,
 			continue;
 		if (rdev_is_spare(rdev))
 			spares++;
-		if (test_bit(Candidate, &rdev->flags))
+		if (!rdev_addable(rdev))
 			continue;
-		if (rdev->raid_disk >= 0)
-			continue;
-		if (test_bit(Faulty, &rdev->flags))
-			continue;
-		if (!test_bit(Journal, &rdev->flags)) {
-			if (!md_is_rdwr(mddev) &&
-			    !(rdev->saved_raid_disk >= 0 &&
-			      !test_bit(Bitmap_sync, &rdev->flags)))
-				continue;
-
+		if (!test_bit(Journal, &rdev->flags))
 			rdev->recovery_offset = 0;
-		}
 		if (mddev->pers->hot_add_disk(mddev, rdev) == 0) {
 			/* failure here is OK */
 			sysfs_link_rdev(mddev, rdev);
-- 
2.39.2

