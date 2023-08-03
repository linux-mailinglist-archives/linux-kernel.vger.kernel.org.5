Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99C476EAAB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbjHCNfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbjHCNdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:33:51 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E74ED0;
        Thu,  3 Aug 2023 06:32:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGqXJ6mJGz4f44wx;
        Thu,  3 Aug 2023 21:32:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHuKtqrMtkWHLlPQ--.49699S20;
        Thu, 03 Aug 2023 21:32:33 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 16/29] md/raid5: use new apis to suspend array for raid5_change_consistency_policy()
Date:   Thu,  3 Aug 2023 21:29:17 +0800
Message-Id: <20230803132930.2742286-17-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132930.2742286-1-yukuai1@huaweicloud.com>
References: <20230803132930.2742286-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHuKtqrMtkWHLlPQ--.49699S20
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4DuF4rZr1Uur4xCFyUKFg_yoW8ur48pa
        1a9a4fur1Uury3Jryjya1qgFy8Jw1UKrZ7trW7Xwn3X3Wft34xGFyrZrZ7Wry8Aa4fJa48
        Ja15K3W8CF4UJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqiihUUUUU=
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

Convert to use new apis, the old apis will be removed eventually.

This is not hot path, so performance is not concerned.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid5.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 11fcaa1f7de5..b4b2d0d5855d 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8966,12 +8966,12 @@ static int raid5_change_consistency_policy(struct mddev *mddev, const char *buf)
 	struct r5conf *conf;
 	int err;
 
-	err = mddev_lock(mddev);
+	err = mddev_suspend_and_lock(mddev);
 	if (err)
 		return err;
 	conf = mddev->private;
 	if (!conf) {
-		mddev_unlock(mddev);
+		mddev_unlock_and_resume(mddev);
 		return -ENODEV;
 	}
 
@@ -8981,19 +8981,14 @@ static int raid5_change_consistency_policy(struct mddev *mddev, const char *buf)
 			err = log_init(conf, NULL, true);
 			if (!err) {
 				err = resize_stripes(conf, conf->pool_size);
-				if (err) {
-					mddev_suspend(mddev);
+				if (err)
 					log_exit(conf);
-					mddev_resume(mddev);
-				}
 			}
 		} else
 			err = -EINVAL;
 	} else if (strncmp(buf, "resync", 6) == 0) {
 		if (raid5_has_ppl(conf)) {
-			mddev_suspend(mddev);
 			log_exit(conf);
-			mddev_resume(mddev);
 			err = resize_stripes(conf, conf->pool_size);
 		} else if (test_bit(MD_HAS_JOURNAL, &conf->mddev->flags) &&
 			   r5l_log_disk_error(conf)) {
@@ -9006,11 +9001,9 @@ static int raid5_change_consistency_policy(struct mddev *mddev, const char *buf)
 					break;
 				}
 
-			if (!journal_dev_exists) {
-				mddev_suspend(mddev);
+			if (!journal_dev_exists)
 				clear_bit(MD_HAS_JOURNAL, &mddev->flags);
-				mddev_resume(mddev);
-			} else  /* need remove journal device first */
+			else  /* need remove journal device first */
 				err = -EBUSY;
 		} else
 			err = -EINVAL;
@@ -9021,7 +9014,7 @@ static int raid5_change_consistency_policy(struct mddev *mddev, const char *buf)
 	if (!err)
 		md_update_sb(mddev, 1);
 
-	mddev_unlock(mddev);
+	mddev_unlock_and_resume(mddev);
 
 	return err;
 }
-- 
2.39.2

