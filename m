Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F0E7B12BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjI1GXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjI1GWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:22:20 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F34EE6;
        Wed, 27 Sep 2023 23:22:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rx3Kj1m1Tz4f3jMy;
        Thu, 28 Sep 2023 14:22:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnvdyCGxVl3v1WBg--.22861S25;
        Thu, 28 Sep 2023 14:22:05 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 21/25] md: cleanup mddev_create/destroy_serial_pool()
Date:   Thu, 28 Sep 2023 14:15:39 +0800
Message-Id: <20230928061543.1845742-22-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
References: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnvdyCGxVl3v1WBg--.22861S25
X-Coremail-Antispam: 1UD129KBjvJXoW3GryUCw1UZrWUKFy8CFy8Zrb_yoWxtr1fpw
        4aqa4rWr4UZ3y5Ww1UCayDG3WYvw1ktrZ7try3u3yfXw43twn3KF1rWa45tr98Zas5Ar1U
        X3WUur4kCr1fKFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
        X7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index f8d92d745105..c3a51d309063 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -206,8 +206,7 @@ static int rdev_need_serial(struct md_rdev *rdev)
  * 1. rdev is the first device which return true from rdev_enable_serial.
  * 2. rdev is NULL, means we want to enable serialization for all rdevs.
  */
-void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-			      bool is_suspend)
+void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
 {
 	int ret = 0;
 
@@ -215,15 +214,12 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
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
@@ -238,10 +234,6 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			pr_err("can't alloc memory pool for serialization\n");
 		}
 	}
-
-abort:
-	if (!is_suspend)
-		mddev_resume(mddev);
 }
 
 /*
@@ -250,8 +242,7 @@ void mddev_create_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
  * 2. when bitmap is destroyed while policy is not enabled.
  * 3. for disable policy, the pool is destroyed only when no rdev needs it.
  */
-void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
-			       bool is_suspend)
+void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev)
 {
 	if (rdev && !test_bit(CollisionCheck, &rdev->flags))
 		return;
@@ -260,8 +251,6 @@ void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 		struct md_rdev *temp;
 		int num = 0; /* used to track if other rdevs need the pool */
 
-		if (!is_suspend)
-			mddev_suspend(mddev);
 		rdev_for_each(temp, mddev) {
 			if (!rdev) {
 				if (!mddev->serialize_policy ||
@@ -283,8 +272,6 @@ void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 			mempool_destroy(mddev->serial_info_pool);
 			mddev->serial_info_pool = NULL;
 		}
-		if (!is_suspend)
-			mddev_resume(mddev);
 	}
 }
 
@@ -2557,7 +2544,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	pr_debug("md: bind<%s>\n", b);
 
 	if (mddev->raid_disks)
-		mddev_create_serial_pool(mddev, rdev, true);
+		mddev_create_serial_pool(mddev, rdev);
 
 	if ((err = kobject_add(&rdev->kobj, &mddev->kobj, "dev-%s", b)))
 		goto fail;
@@ -2610,7 +2597,7 @@ static void md_kick_rdev_from_array(struct md_rdev *rdev)
 	bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
 	list_del_rcu(&rdev->same_set);
 	pr_debug("md: unbind<%pg>\n", rdev->bdev);
-	mddev_destroy_serial_pool(rdev->mddev, rdev, false);
+	mddev_destroy_serial_pool(rdev->mddev, rdev);
 	rdev->mddev = NULL;
 	sysfs_remove_link(&rdev->kobj, "block");
 	sysfs_put(rdev->sysfs_state);
@@ -3077,11 +3064,11 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		}
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
@@ -5588,9 +5575,9 @@ serialize_policy_store(struct mddev *mddev, const char *buf, size_t len)
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
@@ -6356,7 +6343,7 @@ static void __md_stop_writes(struct mddev *mddev)
 	}
 	/* disable policy to guarantee rdevs free resources for serialization */
 	mddev->serialize_policy = 0;
-	mddev_destroy_serial_pool(mddev, NULL, true);
+	mddev_destroy_serial_pool(mddev, NULL);
 }
 
 void md_stop_writes(struct mddev *mddev)
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 5c8f3f045e78..63b4c393b1ee 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -817,10 +817,9 @@ extern void __mddev_resume(struct mddev *mddev);
 
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

