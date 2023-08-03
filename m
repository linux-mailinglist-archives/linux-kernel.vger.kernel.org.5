Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B3176EAA8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbjHCNfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbjHCNdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:33:55 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1B6273E;
        Thu,  3 Aug 2023 06:32:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RGqXJ3yv0z4f3lXd;
        Thu,  3 Aug 2023 21:32:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHuKtqrMtkWHLlPQ--.49699S25;
        Thu, 03 Aug 2023 21:32:35 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 21/29] md: use new apis to suspend array for bind_rdev_to_array()
Date:   Thu,  3 Aug 2023 21:29:22 +0800
Message-Id: <20230803132930.2742286-22-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132930.2742286-1-yukuai1@huaweicloud.com>
References: <20230803132930.2742286-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHuKtqrMtkWHLlPQ--.49699S25
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1xJF45WFW3uw13Jry7KFg_yoW5CFWxpr
        s2ga4SgryjqrW3J34UZan29Fy5Jw12grZFkryfXa4xXa1fXw13Gr4Fgry5Jr109a4rAFn8
        Xa15Xw4kZFyUGFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqiihUUUUU=
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

mddev_create_serial_pool() will be called from bind_rdev_to_array(), and
mddev_suspend() will be called if serial pool is used.

Prepare to remove the mddev_suspend() from mddev_create_serial_pool().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-autodetect.c |  4 ++--
 drivers/md/md.c            | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/md/md-autodetect.c b/drivers/md/md-autodetect.c
index 6eaa0eab40f9..4b80165afd23 100644
--- a/drivers/md/md-autodetect.c
+++ b/drivers/md/md-autodetect.c
@@ -175,7 +175,7 @@ static void __init md_setup_drive(struct md_setup_args *args)
 		return;
 	}
 
-	err = mddev_lock(mddev);
+	err = mddev_suspend_and_lock(mddev);
 	if (err) {
 		pr_err("md: failed to lock array %s\n", name);
 		goto out_mddev_put;
@@ -221,7 +221,7 @@ static void __init md_setup_drive(struct md_setup_args *args)
 	if (err)
 		pr_warn("md: starting %s failed\n", name);
 out_unlock:
-	mddev_unlock(mddev);
+	mddev_unlock_and_resume(mddev);
 out_mddev_put:
 	mddev_put(mddev);
 }
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4a522558a570..ca1fe1d17ec1 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2534,7 +2534,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	pr_debug("md: bind<%s>\n", b);
 
 	if (mddev->raid_disks)
-		mddev_create_serial_pool(mddev, rdev, false);
+		mddev_create_serial_pool(mddev, rdev, true);
 
 	if ((err = kobject_add(&rdev->kobj, &mddev->kobj, "dev-%s", b)))
 		goto fail;
@@ -4666,7 +4666,7 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
 	    minor != MINOR(dev))
 		return -EOVERFLOW;
 
-	err = mddev_lock(mddev);
+	err = mddev_suspend_and_lock(mddev);
 	if (err)
 		return err;
 	if (mddev->persistent) {
@@ -4687,14 +4687,14 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
 		rdev = md_import_device(dev, -1, -1);
 
 	if (IS_ERR(rdev)) {
-		mddev_unlock(mddev);
+		mddev_unlock_and_resume(mddev);
 		return PTR_ERR(rdev);
 	}
 	err = bind_rdev_to_array(rdev, mddev);
  out:
 	if (err)
 		export_rdev(rdev, mddev);
-	mddev_unlock(mddev);
+	mddev_unlock_and_resume(mddev);
 	if (!err)
 		md_new_event();
 	return err ? err : len;
@@ -6622,13 +6622,13 @@ static void autorun_devices(int part)
 		if (IS_ERR(mddev))
 			break;
 
-		if (mddev_lock(mddev))
+		if (mddev_suspend_and_lock(mddev))
 			pr_warn("md: %s locked, cannot run\n", mdname(mddev));
 		else if (mddev->raid_disks || mddev->major_version
 			 || !list_empty(&mddev->disks)) {
 			pr_warn("md: %s already running, cannot run %pg\n",
 				mdname(mddev), rdev0->bdev);
-			mddev_unlock(mddev);
+			mddev_unlock_and_resume(mddev);
 		} else {
 			pr_debug("md: created %s\n", mdname(mddev));
 			mddev->persistent = 1;
@@ -6638,7 +6638,7 @@ static void autorun_devices(int part)
 					export_rdev(rdev, mddev);
 			}
 			autorun_array(mddev);
-			mddev_unlock(mddev);
+			mddev_unlock_and_resume(mddev);
 		}
 		/* on success, candidates will be empty, on error
 		 * it won't...
-- 
2.39.2

