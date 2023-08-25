Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7B9787E63
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjHYDOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbjHYDOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:14:18 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC4199A;
        Thu, 24 Aug 2023 20:14:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RX4mg5wPxz4f3kkK;
        Fri, 25 Aug 2023 11:14:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBah_HOhkveEWBg--.3212S5;
        Fri, 25 Aug 2023 11:14:12 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 1/7] md: initialize 'active_io' while allocating mddev
Date:   Fri, 25 Aug 2023 11:09:50 +0800
Message-Id: <20230825030956.1527023-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230825030956.1527023-1-yukuai1@huaweicloud.com>
References: <20230825030956.1527023-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBah_HOhkveEWBg--.3212S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKF4xCr43Gw1UZrW3Cr4rXwb_yoW7tw1kpa
        1Iqas5Jr4UJFZIqrW3JF4Dua45Ww1kKrWkKry3Gwn3AF1akr1DG3WYqFW8ZrykCayrC3W5
        Xw1FgFWUuF18Gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
        v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjeWlDUUUUU=
        =
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

'active_io' is used for mddev_suspend() and it's initialized in
md_run(), this restrict that 'reconfig_mutex' must be held and
"mddev->pers" must be set before calling mddev_suspend().

Initialize 'active_io' early so that mddev_suspend() is safe to call
once mddev is allocated, this will be helpful to refactor
mddev_suspend() in following patches.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-raid.c |  7 +++++-
 drivers/md/md.c      | 53 +++++++++++++++++++++++++++-----------------
 drivers/md/md.h      |  3 ++-
 3 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 1f22bef27841..020598c10db0 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -749,7 +749,11 @@ static struct raid_set *raid_set_alloc(struct dm_target *ti, struct raid_type *r
 		return ERR_PTR(-ENOMEM);
 	}
 
-	mddev_init(&rs->md);
+	if (mddev_init(&rs->md)) {
+		kfree(rs);
+		ti->error = "Cannot initialize raid context";
+		return ERR_PTR(-ENOMEM);
+	}
 
 	rs->raid_disks = raid_devs;
 	rs->delta_disks = 0;
@@ -798,6 +802,7 @@ static void raid_set_free(struct raid_set *rs)
 			dm_put_device(rs->ti, rs->dev[i].data_dev);
 	}
 
+	mddev_destroy(&rs->md);
 	kfree(rs);
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4e5bca33f559..9974cf45f9d0 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -639,8 +639,20 @@ void mddev_put(struct mddev *mddev)
 static void md_safemode_timeout(struct timer_list *t);
 static void md_start_sync(struct work_struct *ws);
 
-void mddev_init(struct mddev *mddev)
+static void active_io_release(struct percpu_ref *ref)
 {
+	struct mddev *mddev = container_of(ref, struct mddev, active_io);
+
+	wake_up(&mddev->sb_wait);
+}
+
+int mddev_init(struct mddev *mddev)
+{
+
+	if (percpu_ref_init(&mddev->active_io, active_io_release,
+			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL))
+		return -ENOMEM;
+
 	mutex_init(&mddev->open_mutex);
 	mutex_init(&mddev->reconfig_mutex);
 	mutex_init(&mddev->sync_mutex);
@@ -665,9 +677,17 @@ void mddev_init(struct mddev *mddev)
 
 	INIT_WORK(&mddev->sync_work, md_start_sync);
 	INIT_WORK(&mddev->del_work, mddev_delayed_delete);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mddev_init);
 
+void mddev_destroy(struct mddev *mddev)
+{
+	percpu_ref_exit(&mddev->active_io);
+}
+EXPORT_SYMBOL_GPL(mddev_destroy);
+
 static struct mddev *mddev_find_locked(dev_t unit)
 {
 	struct mddev *mddev;
@@ -711,13 +731,16 @@ static struct mddev *mddev_alloc(dev_t unit)
 	new = kzalloc(sizeof(*new), GFP_KERNEL);
 	if (!new)
 		return ERR_PTR(-ENOMEM);
-	mddev_init(new);
+
+	error = mddev_init(new);
+	if (error)
+		goto out_free_new;
 
 	spin_lock(&all_mddevs_lock);
 	if (unit) {
 		error = -EEXIST;
 		if (mddev_find_locked(unit))
-			goto out_free_new;
+			goto out_destroy_new;
 		new->unit = unit;
 		if (MAJOR(unit) == MD_MAJOR)
 			new->md_minor = MINOR(unit);
@@ -728,7 +751,7 @@ static struct mddev *mddev_alloc(dev_t unit)
 		error = -ENODEV;
 		new->unit = mddev_alloc_unit();
 		if (!new->unit)
-			goto out_free_new;
+			goto out_destroy_new;
 		new->md_minor = MINOR(new->unit);
 		new->hold_active = UNTIL_STOP;
 	}
@@ -736,8 +759,11 @@ static struct mddev *mddev_alloc(dev_t unit)
 	list_add(&new->all_mddevs, &all_mddevs);
 	spin_unlock(&all_mddevs_lock);
 	return new;
-out_free_new:
+
+out_destroy_new:
 	spin_unlock(&all_mddevs_lock);
+	mddev_destroy(new);
+out_free_new:
 	kfree(new);
 	return ERR_PTR(error);
 }
@@ -748,6 +774,7 @@ static void mddev_free(struct mddev *mddev)
 	list_del(&mddev->all_mddevs);
 	spin_unlock(&all_mddevs_lock);
 
+	mddev_destroy(mddev);
 	kfree(mddev);
 }
 
@@ -5778,12 +5805,6 @@ static void md_safemode_timeout(struct timer_list *t)
 }
 
 static int start_dirty_degraded;
-static void active_io_release(struct percpu_ref *ref)
-{
-	struct mddev *mddev = container_of(ref, struct mddev, active_io);
-
-	wake_up(&mddev->sb_wait);
-}
 
 int md_run(struct mddev *mddev)
 {
@@ -5864,15 +5885,10 @@ int md_run(struct mddev *mddev)
 		nowait = nowait && bdev_nowait(rdev->bdev);
 	}
 
-	err = percpu_ref_init(&mddev->active_io, active_io_release,
-				PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
-	if (err)
-		return err;
-
 	if (!bioset_initialized(&mddev->bio_set)) {
 		err = bioset_init(&mddev->bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 		if (err)
-			goto exit_active_io;
+			return err;
 	}
 	if (!bioset_initialized(&mddev->sync_set)) {
 		err = bioset_init(&mddev->sync_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
@@ -6069,8 +6085,6 @@ int md_run(struct mddev *mddev)
 	bioset_exit(&mddev->sync_set);
 exit_bio_set:
 	bioset_exit(&mddev->bio_set);
-exit_active_io:
-	percpu_ref_exit(&mddev->active_io);
 	return err;
 }
 EXPORT_SYMBOL_GPL(md_run);
@@ -6286,7 +6300,6 @@ static void __md_stop(struct mddev *mddev)
 	module_put(pers->owner);
 	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 
-	percpu_ref_exit(&mddev->active_io);
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
 	bioset_exit(&mddev->io_clone_set);
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 64d05cb65287..f6b64b0e92c7 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -795,7 +795,8 @@ extern int md_integrity_register(struct mddev *mddev);
 extern int md_integrity_add_rdev(struct md_rdev *rdev, struct mddev *mddev);
 extern int strict_strtoul_scaled(const char *cp, unsigned long *res, int scale);
 
-extern void mddev_init(struct mddev *mddev);
+extern int mddev_init(struct mddev *mddev);
+extern void mddev_destroy(struct mddev *mddev);
 struct mddev *md_alloc(dev_t dev, char *name);
 void mddev_put(struct mddev *mddev);
 extern int md_run(struct mddev *mddev);
-- 
2.39.2

