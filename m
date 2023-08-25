Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D19E787E80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbjHYDVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjHYDUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:20:41 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74711FD0;
        Thu, 24 Aug 2023 20:20:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RX4w33b86z4f3nbZ;
        Fri, 25 Aug 2023 11:20:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHoqUBHuhkPT4XBg--.14533S10;
        Fri, 25 Aug 2023 11:20:36 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 6/7] md: factor out a helper rdev_addable() from remove_and_add_spares()
Date:   Fri, 25 Aug 2023 11:16:21 +0800
Message-Id: <20230825031622.1530464-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230825031622.1530464-1-yukuai1@huaweicloud.com>
References: <20230825031622.1530464-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHoqUBHuhkPT4XBg--.14533S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtr13KF4ftw4rGrg_yoW8ZFy8pa
        yfKFW3Kw4UAr43WF4qgr1UGa4YqF40gFWIkFy3Ca48Zas8Jr1Yg3ykGFyYqF9rJFWF9r4Y
        qF15Jw48ur17WFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
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
 drivers/md/md.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6d413979ad74..851cf10d0178 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9197,6 +9197,31 @@ static bool rdev_is_spare(struct md_rdev *rdev)
 	       !test_bit(Faulty, &rdev->flags);
 }
 
+static bool rdev_addable(struct md_rdev *rdev)
+{
+	/* rdev is already used, don't add it again. */
+	if (test_bit(Candidate, &rdev->flags) || rdev->raid_disk >= 0 ||
+	    test_bit(Faulty, &rdev->flags))
+		return false;
+
+	/* Allow to add journal disk. */
+	if (test_bit(Journal, &rdev->flags))
+		return true;
+
+	/* Allow to add if array is read-write. */
+	if (md_is_rdwr(rdev->mddev))
+		return true;
+
+	/*
+	 * For read-only array, only allow to readd a rdev. And if bitmap is
+	 * used, don't allow to readd a rdev that is too old.
+	 */
+	if (rdev->saved_raid_disk >= 0 && !test_bit(Bitmap_sync, &rdev->flags))
+		return true;
+
+	return false;
+}
+
 static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this)
 {
@@ -9254,20 +9279,10 @@ static int remove_and_add_spares(struct mddev *mddev,
 			continue;
 		if (rdev_is_spare(rdev))
 			spares++;
-		if (test_bit(Candidate, &rdev->flags))
-			continue;
-		if (rdev->raid_disk >= 0)
+		if (!rdev_addable(rdev))
 			continue;
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

