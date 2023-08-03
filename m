Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6076EAB2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbjHCNfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjHCNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:34:02 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5422D4EF3;
        Thu,  3 Aug 2023 06:32:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGqXN2pvRz4f41V7;
        Thu,  3 Aug 2023 21:32:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHuKtqrMtkWHLlPQ--.49699S29;
        Thu, 03 Aug 2023 21:32:36 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 25/29] md: cleanup mddev_create/destroy_serial_pool()
Date:   Thu,  3 Aug 2023 21:29:26 +0800
Message-Id: <20230803132930.2742286-26-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132930.2742286-1-yukuai1@huaweicloud.com>
References: <20230803132930.2742286-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHuKtqrMtkWHLlPQ--.49699S29
X-Coremail-Antispam: 1UD129KBjvJXoW3GryUCw1UZrWUKFy8CFy8Zrb_yoWxtryDpw
        4aqa4rWr45Z3y5Ww1UCayDG3WYvr1ktrZ7try3u3yfXw43twn3KF1rWa45tr98Zas5Ar1U
        X3WUur4kCr1fKFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Now that except for stopping the array, all the callers already suspend
the array, there is no need to suspend anymore, hence remove the second
parameter.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c |  8 ++++----
 drivers/md/md.c        | 33 ++++++++++-----------------------
 drivers/md/md.h        |  7 +++----
 3 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index b3d701c5c461..9672f75c3050 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1861,7 +1861,7 @@ void md_bitmap_destroy(struct mddev *mddev)
 
 	md_bitmap_wait_behind_writes(mddev);
 	if (!mddev->serialize_policy)
-		mddev_destroy_serial_pool(mddev, NULL, true);
+		mddev_destroy_serial_pool(mddev, NULL);
 
 	mutex_lock(&mddev->bitmap_info.mutex);
 	spin_lock(&mddev->lock);
@@ -1977,7 +1977,7 @@ int md_bitmap_load(struct mddev *mddev)
 		goto out;
 
 	rdev_for_each(rdev, mddev)
-		mddev_create_serial_pool(mddev, rdev, true);
+		mddev_create_serial_pool(mddev, rdev);
 
 	if (mddev_is_clustered(mddev))
 		md_cluster_ops->load_bitmaps(mddev, mddev->bitmap_info.nodes);
@@ -2562,11 +2562,11 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	if (!backlog && mddev->serial_info_pool) {
 		/* serial_info_pool is not needed if backlog is zero */
 		if (!mddev->serialize_policy)
-			mddev_destroy_serial_pool(mddev, NULL, true);
+			mddev_destroy_serial_pool(mddev, NULL);
 	} else if (backlog && !mddev->serial_info_pool) {
 		/* serial_info_pool is needed since backlog is not zero */
 		rdev_for_each(rdev, mddev)
-			mddev_create_serial_pool(mddev, rdev, true);
+			mddev_create_serial_pool(mddev, rdev);
 	}
 	if (old_mwb != backlog)
 		md_bitmap_update_sb(mddev->bitmap);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9bfa15b2fa97..915a6f15d726 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -205,8 +205,7 @@ static int rdev_need_serial(struct md_rdev *rdev)
  * 1. rdev is the first device which return true from rdev_enable_serial.
  * 2. rdev is NULL, means we want to enable serialization for all rdevs.
  */
-void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-			      bool is_suspend)
+void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
 {
 	int ret = 0;
 
@@ -214,15 +213,12 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 	    !test_bit(CollisionCheck, &rdev->flags))
 		return;
 
-	if (!is_suspend)
-		mddev_suspend(mddev);
-
 	if (!rdev)
 		ret = rdevs_init_serial(mddev);
 	else
 		ret = rdev_init_serial(rdev);
 	if (ret)
-		goto abort;
+		return;
 
 	if (mddev->serial_info_pool == NULL) {
 		/*
@@ -237,10 +233,6 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			pr_err("can't alloc memory pool for serialization\n");
 		}
 	}
-
-abort:
-	if (!is_suspend)
-		mddev_resume(mddev);
 }
 
 /*
@@ -249,8 +241,7 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
  * 2. when bitmap is destroyed while policy is not enabled.
  * 3. for disable policy, the pool is destroyed only when no rdev needs it.
  */
-void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-			       bool is_suspend)
+void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
 {
 	if (rdev && !test_bit(CollisionCheck, &rdev->flags))
 		return;
@@ -259,8 +250,6 @@ void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 		struct md_rdev *temp;
 		int num = 0; /* used to track if other rdevs need the pool */
 
-		if (!is_suspend)
-			mddev_suspend(mddev);
 		rdev_for_each(temp, mddev) {
 			if (!rdev) {
 				if (!mddev->serialize_policy ||
@@ -282,8 +271,6 @@ void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			mempool_destroy(mddev->serial_info_pool);
 			mddev->serial_info_pool = NULL;
 		}
-		if (!is_suspend)
-			mddev_resume(mddev);
 	}
 }
 
@@ -2534,7 +2521,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	pr_debug("md: bind<%s>\n", b);
 
 	if (mddev->raid_disks)
-		mddev_create_serial_pool(mddev, rdev, true);
+		mddev_create_serial_pool(mddev, rdev);
 
 	if ((err = kobject_add(&rdev->kobj, &mddev->kobj, "dev-%s", b)))
 		goto fail;
@@ -2586,7 +2573,7 @@ static void md_kick_rdev_from_array(struct md_rdev *rdev)
 	bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
 	list_del_rcu(&rdev->same_set);
 	pr_debug("md: unbind<%pg>\n", rdev->bdev);
-	mddev_destroy_serial_pool(rdev->mddev, rdev, false);
+	mddev_destroy_serial_pool(rdev->mddev, rdev);
 	rdev->mddev = NULL;
 	sysfs_remove_link(&rdev->kobj, "block");
 	sysfs_put(rdev->sysfs_state);
@@ -3067,11 +3054,11 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		err = remove_rdev(rdev);
 	} else if (cmd_match(buf, "writemostly")) {
 		set_bit(WriteMostly, &rdev->flags);
-		mddev_create_serial_pool(rdev->mddev, rdev, true);
+		mddev_create_serial_pool(rdev->mddev, rdev);
 		need_update_sb = true;
 		err = 0;
 	} else if (cmd_match(buf, "-writemostly")) {
-		mddev_destroy_serial_pool(rdev->mddev, rdev, true);
+		mddev_destroy_serial_pool(rdev->mddev, rdev);
 		clear_bit(WriteMostly, &rdev->flags);
 		need_update_sb = true;
 		err = 0;
@@ -5566,9 +5553,9 @@ serialize_policy_store(struct mddev *mddev, const char *buf, size_t len)
 	}
 
 	if (value)
-		mddev_create_serial_pool(mddev, NULL, true);
+		mddev_create_serial_pool(mddev, NULL);
 	else
-		mddev_destroy_serial_pool(mddev, NULL, true);
+		mddev_destroy_serial_pool(mddev, NULL);
 	mddev->serialize_policy = value;
 unlock:
 	mddev_unlock_and_resume(mddev);
@@ -6334,7 +6321,7 @@ static void __md_stop_writes(struct mddev *mddev)
 	}
 	/* disable policy to guarantee rdevs free resources for serialization */
 	mddev->serialize_policy = 0;
-	mddev_destroy_serial_pool(mddev, NULL, true);
+	mddev_destroy_serial_pool(mddev, NULL);
 }
 
 void md_stop_writes(struct mddev *mddev)
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 3a2488231fd2..24adb603461d 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -809,10 +809,9 @@ extern void __mddev_resume(struct mddev *mddev);
 
 extern void md_reload_sb(struct mddev *mddev, int raid_disk);
 extern void md_update_sb(struct mddev *mddev, int force);
-extern void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-				     bool is_suspend);
-extern void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-				      bool is_suspend);
+extern void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev);
+extern void mddev_destroy_serial_pool(struct mddev *mddev,
+				      struct md_rdev *rdev);
 struct md_rdev *md_find_rdev_nr_rcu(struct mddev *mddev, int nr);
 struct md_rdev *md_find_rdev_rcu(struct mddev *mddev, dev_t dev);
 
-- 
2.39.2

