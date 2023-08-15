Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB02A77C650
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjHODQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjHODOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:14:24 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1AC1999;
        Mon, 14 Aug 2023 20:13:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RPxDd1l9Xz4f3m7s;
        Tue, 15 Aug 2023 11:13:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6ld7dpknET3Ag--.64666S10;
        Tue, 15 Aug 2023 11:13:37 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 6/7] md: factor out a helper rdev_addable() from remove_and_add_spares()
Date:   Tue, 15 Aug 2023 11:09:56 +0800
Message-Id: <20230815030957.509535-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815030957.509535-1-yukuai1@huaweicloud.com>
References: <20230815030957.509535-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXp6ld7dpknET3Ag--.64666S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtr13KF4ftr13Jwb_yoW8Ary8pa
        yrKFy3Kw4UAF13Wa1DKryUGa4Yqa10grWIkry2ka4rZas8Jrn8Kw4rCF98XF98JFZY9F45
        ZF15tw48ur13WFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

There are no functional changes, just to make the code simpler and
prepare to delay remove_and_add_spares() to md_start_sync().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6baaa4d314b3..d26d2c35f9af 100644
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

