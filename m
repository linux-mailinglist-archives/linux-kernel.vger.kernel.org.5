Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DDB7BF434
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442511AbjJJHZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442505AbjJJHXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:23:47 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E99B0;
        Tue, 10 Oct 2023 00:23:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S4S7D2bKTz4f3kpV;
        Tue, 10 Oct 2023 15:23:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgDHXd31+yRl1AZbCg--.36859S17;
        Tue, 10 Oct 2023 15:23:41 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v4 13/19] md: use new apis to suspend array before mddev_create/destroy_serial_pool
Date:   Tue, 10 Oct 2023 23:19:52 +0800
Message-Id: <20231010151958.145896-14-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010151958.145896-1-yukuai1@huaweicloud.com>
References: <20231010151958.145896-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHXd31+yRl1AZbCg--.36859S17
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar45Jr1xGr4rGry3KF45KFg_yoW7Ww1xpr
        4fKa4SgrWUX343Jw1UZa1kuFy5Jw18KrZrtry7Xayfu3W3XwsxGr4FgF98Jryv9as5JF15
        Ja15Ww4kAry8GFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRv
        JPtUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

mddev_create/destroy_serial_pool() will be called from several places
where mddev_suspend() will be called later.

Prepare to remove the mddev_suspend() from
mddev_create/destroy_serial_pool().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-autodetect.c |  4 ++--
 drivers/md/md-bitmap.c     |  8 ++++----
 drivers/md/md.c            | 22 ++++++++++++----------
 3 files changed, 18 insertions(+), 16 deletions(-)

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
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 7d21e2a5b06e..b3d701c5c461 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2537,7 +2537,7 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	if (backlog > COUNTER_MAX)
 		return -EINVAL;
 
-	rv = mddev_lock(mddev);
+	rv = mddev_suspend_and_lock(mddev);
 	if (rv)
 		return rv;
 
@@ -2562,16 +2562,16 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	if (!backlog && mddev->serial_info_pool) {
 		/* serial_info_pool is not needed if backlog is zero */
 		if (!mddev->serialize_policy)
-			mddev_destroy_serial_pool(mddev, NULL, false);
+			mddev_destroy_serial_pool(mddev, NULL, true);
 	} else if (backlog && !mddev->serial_info_pool) {
 		/* serial_info_pool is needed since backlog is not zero */
 		rdev_for_each(rdev, mddev)
-			mddev_create_serial_pool(mddev, rdev, false);
+			mddev_create_serial_pool(mddev, rdev, true);
 	}
 	if (old_mwb != backlog)
 		md_bitmap_update_sb(mddev->bitmap);
 
-	mddev_unlock(mddev);
+	mddev_unlock_and_resume(mddev);
 	return len;
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index ee20e6a4b998..85e263376be9 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2557,7 +2557,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	pr_debug("md: bind<%s>\n", b);
 
 	if (mddev->raid_disks)
-		mddev_create_serial_pool(mddev, rdev, false);
+		mddev_create_serial_pool(mddev, rdev, true);
 
 	if ((err = kobject_add(&rdev->kobj, &mddev->kobj, "dev-%s", b)))
 		goto fail;
@@ -3077,11 +3077,11 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		}
 	} else if (cmd_match(buf, "writemostly")) {
 		set_bit(WriteMostly, &rdev->flags);
-		mddev_create_serial_pool(rdev->mddev, rdev, false);
+		mddev_create_serial_pool(rdev->mddev, rdev, true);
 		need_update_sb = true;
 		err = 0;
 	} else if (cmd_match(buf, "-writemostly")) {
-		mddev_destroy_serial_pool(rdev->mddev, rdev, false);
+		mddev_destroy_serial_pool(rdev->mddev, rdev, true);
 		clear_bit(WriteMostly, &rdev->flags);
 		need_update_sb = true;
 		err = 0;
@@ -3707,7 +3707,9 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
 	if (entry->store == state_store) {
 		if (cmd_match(page, "remove"))
 			kn = sysfs_break_active_protection(kobj, attr);
-		if (cmd_match(page, "remove") || cmd_match(page, "re-add"))
+		if (cmd_match(page, "remove") || cmd_match(page, "re-add") ||
+		    cmd_match(page, "writemostly") ||
+		    cmd_match(page, "-writemostly"))
 			suspend = true;
 	}
 
@@ -4684,7 +4686,7 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
 	    minor != MINOR(dev))
 		return -EOVERFLOW;
 
-	err = mddev_lock(mddev);
+	err = mddev_suspend_and_lock(mddev);
 	if (err)
 		return err;
 	if (mddev->persistent) {
@@ -4705,14 +4707,14 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
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
@@ -6649,13 +6651,13 @@ static void autorun_devices(int part)
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
@@ -6665,7 +6667,7 @@ static void autorun_devices(int part)
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

