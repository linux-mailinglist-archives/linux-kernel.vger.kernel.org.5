Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE0476EA4E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbjHCN1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbjHCN1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:27:35 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BBEE70;
        Thu,  3 Aug 2023 06:27:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RGqQQ5zZ6z4f3lwY;
        Thu,  3 Aug 2023 21:27:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7M6q8tk5SrlPQ--.7420S11;
        Thu, 03 Aug 2023 21:27:29 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 07/13] md: factor out a helper remove_rdev() from state_store()
Date:   Thu,  3 Aug 2023 21:24:20 +0800
Message-Id: <20230803132426.2688608-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
References: <20230803132426.2688608-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7M6q8tk5SrlPQ--.7420S11
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4fWrW8Jw15CFWDZry8AFb_yoW8uryfp3
        yfKFy5Gr4UA343Jw43t3ykWa45Jr40qrZrtry3uw1S9anxArZ5Ja4FgF95Jr95Cayvvr45
        Xa15Wa1rWryxWF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
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

state_store() is a very big function already, factor out a helper to
prevent that following changes will make state_store() more complicated.

There are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 50 +++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 77c48f7b605c..3903bdfe5293 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2883,6 +2883,35 @@ state_show(struct md_rdev *rdev, char *page)
 	return len+sprintf(page+len, "\n");
 }
 
+static int remove_rdev(struct md_rdev *rdev)
+{
+	struct mddev *mddev = rdev->mddev;
+
+	if (mddev->pers) {
+		clear_bit(Blocked, &rdev->flags);
+		remove_and_add_spares(mddev, rdev);
+	}
+
+	if (rdev->raid_disk >= 0)
+		return -EBUSY;
+
+	if (mddev_is_clustered(mddev)) {
+		int err = md_cluster_ops->remove_disk(mddev, rdev);
+
+		if (err)
+			return err;
+	}
+
+	md_kick_rdev_from_array(rdev);
+	if (mddev->pers) {
+		set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
+		md_wakeup_thread(mddev->thread);
+	}
+	md_new_event();
+
+	return 0;
+}
+
 static ssize_t
 state_store(struct md_rdev *rdev, const char *buf, size_t len)
 {
@@ -2913,26 +2942,7 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		else
 			err = 0;
 	} else if (cmd_match(buf, "remove")) {
-		if (rdev->mddev->pers) {
-			clear_bit(Blocked, &rdev->flags);
-			remove_and_add_spares(rdev->mddev, rdev);
-		}
-		if (rdev->raid_disk >= 0)
-			err = -EBUSY;
-		else {
-			err = 0;
-			if (mddev_is_clustered(mddev))
-				err = md_cluster_ops->remove_disk(mddev, rdev);
-
-			if (err == 0) {
-				md_kick_rdev_from_array(rdev);
-				if (mddev->pers) {
-					set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-					md_wakeup_thread(mddev->thread);
-				}
-				md_new_event();
-			}
-		}
+		err = remove_rdev(rdev);
 	} else if (cmd_match(buf, "writemostly")) {
 		set_bit(WriteMostly, &rdev->flags);
 		mddev_create_serial_pool(rdev->mddev, rdev, false);
-- 
2.39.2

