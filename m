Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83F577C64B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbjHODQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjHODOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:14:22 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4609D1998;
        Mon, 14 Aug 2023 20:13:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RPxDZ1nQ1z4f3khv;
        Tue, 15 Aug 2023 11:13:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6ld7dpknET3Ag--.64666S9;
        Tue, 15 Aug 2023 11:13:37 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 5/7] md: factor out a helper rdev_is_spare() from remove_and_add_spares()
Date:   Tue, 15 Aug 2023 11:09:55 +0800
Message-Id: <20230815030957.509535-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815030957.509535-1-yukuai1@huaweicloud.com>
References: <20230815030957.509535-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXp6ld7dpknET3Ag--.64666S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtr13KF4fCF1fCrg_yoW8GF17pa
        yIgFWYkw4UZayUWa1vgryUGa43K3W0g3yIkFyxCa4fZas8Jry5Kws5CF90qFn8AFWFvF45
        Za1Uta1kCF1rKF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
        W8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
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
 drivers/md/md.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index ea091eef23d1..6baaa4d314b3 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9169,6 +9169,14 @@ static bool rdev_removeable(struct md_rdev *rdev)
 	return true;
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
@@ -9217,13 +9225,10 @@ static int remove_and_add_spares(struct mddev *mddev,
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

