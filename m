Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026A9787E77
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbjHYDVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjHYDUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:20:41 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70C11FCE;
        Thu, 24 Aug 2023 20:20:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RX4w36LGkz4f3mW5;
        Fri, 25 Aug 2023 11:20:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHoqUBHuhkPT4XBg--.14533S9;
        Fri, 25 Aug 2023 11:20:36 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 5/7] md: factor out a helper rdev_is_spare() from remove_and_add_spares()
Date:   Fri, 25 Aug 2023 11:16:20 +0800
Message-Id: <20230825031622.1530464-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230825031622.1530464-1-yukuai1@huaweicloud.com>
References: <20230825031622.1530464-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHoqUBHuhkPT4XBg--.14533S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtr13KF4DJrWrKrg_yoW8GFWkpa
        yxKFyakrWUZFyjga1qgryUGa43Ka10g3yIkFy7Ca4xZas8Jry5Kw4FkF90qrn8AFWFvF45
        ZF45tw48C3WFgF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5dbc2efc8a0d..6d413979ad74 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9189,6 +9189,14 @@ static bool rdev_removeable(struct md_rdev *rdev)
 	return false;
 }
 
+static bool rdev_is_spare(struct md_rdev *rdev)
+{
+	return !test_bit(Candidate, &rdev->flags) && rdev->raid_disk >= 0 &&
+	       !test_bit(In_sync, &rdev->flags) &&
+	       !test_bit(Journal, &rdev->flags) &&
+	       !test_bit(Faulty, &rdev->flags);
+}
+
 static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this)
 {
@@ -9244,13 +9252,10 @@ static int remove_and_add_spares(struct mddev *mddev,
 	rdev_for_each(rdev, mddev) {
 		if (this && this != rdev)
 			continue;
+		if (rdev_is_spare(rdev))
+			spares++;
 		if (test_bit(Candidate, &rdev->flags))
 			continue;
-		if (rdev->raid_disk >= 0 &&
-		    !test_bit(In_sync, &rdev->flags) &&
-		    !test_bit(Journal, &rdev->flags) &&
-		    !test_bit(Faulty, &rdev->flags))
-			spares++;
 		if (rdev->raid_disk >= 0)
 			continue;
 		if (test_bit(Faulty, &rdev->flags))
-- 
2.39.2

