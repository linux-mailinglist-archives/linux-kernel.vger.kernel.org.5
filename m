Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB5F78A471
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjH1CFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjH1CE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:04:59 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD321124;
        Sun, 27 Aug 2023 19:04:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RYv5H0fLQz4f3mLt;
        Mon, 28 Aug 2023 10:04:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBai7AOxk9qcCBw--.25880S25;
        Mon, 28 Aug 2023 10:04:54 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 21/28] md: use new apis to suspend array for bind_rdev_to_array()
Date:   Mon, 28 Aug 2023 10:00:14 +0800
Message-Id: <20230828020021.2489641-22-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
References: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBai7AOxk9qcCBw--.25880S25
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1xJF45WFW3uw13Jry7KFg_yoW5CFWxpr
        s2ga4SgryUXrW3J34UZa929Fy5Jw1xKrZFkryfXa4xX3WfXw13Gr4Fgry5Xr1v9a4rJFn8
        Ja15Xw1kZFyUGFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
        SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
index 0f1006197afd..43bd7274b705 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2535,7 +2535,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	pr_debug("md: bind<%s>\n", b);
 
 	if (mddev->raid_disks)
-		mddev_create_serial_pool(mddev, rdev, false);
+		mddev_create_serial_pool(mddev, rdev, true);
 
 	if ((err = kobject_add(&rdev->kobj, &mddev->kobj, "dev-%s", b)))
 		goto fail;
@@ -4662,7 +4662,7 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
 	    minor != MINOR(dev))
 		return -EOVERFLOW;
 
-	err = mddev_lock(mddev);
+	err = mddev_suspend_and_lock(mddev);
 	if (err)
 		return err;
 	if (mddev->persistent) {
@@ -4683,14 +4683,14 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
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
@@ -6619,13 +6619,13 @@ static void autorun_devices(int part)
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
@@ -6635,7 +6635,7 @@ static void autorun_devices(int part)
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

