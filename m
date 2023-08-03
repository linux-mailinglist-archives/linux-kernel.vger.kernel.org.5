Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48D676EA73
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjHCNc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjHCNcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:32:02 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B02D4E;
        Thu,  3 Aug 2023 06:30:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGqVH4m51z4f41Tp;
        Thu,  3 Aug 2023 21:30:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7MGrMtkNVvlPQ--.7517S5;
        Thu, 03 Aug 2023 21:30:48 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 1/7] md: initialize 'active_io' while allocating mddev
Date:   Thu,  3 Aug 2023 21:27:45 +0800
Message-Id: <20230803132751.2741652-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132751.2741652-1-yukuai1@huaweicloud.com>
References: <20230803132751.2741652-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7MGrMtkNVvlPQ--.7517S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKF4xCr43Gw1UZrW3Cr4rXwb_yoW7tw1kpa
        1Iqas5Jr4UJFZIqrW3JF4Dua45Ww1kKrWktry3Gwn3AF1Skr4DG3WYqFWUZrykGayrC3W3
        Xw1FgFWUuF18Gr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
        W8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHyIUUUUUU=
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
index f6e024c15530..c391d8e016af 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -638,8 +638,20 @@ void mddev_put(struct mddev *mddev)
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
@@ -664,9 +676,17 @@ void mddev_init(struct mddev *mddev)
 
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
@@ -710,13 +730,16 @@ static struct mddev *mddev_alloc(dev_t unit)
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
@@ -727,7 +750,7 @@ static struct mddev *mddev_alloc(dev_t unit)
 		error = -ENODEV;
 		new->unit = mddev_alloc_unit();
 		if (!new->unit)
-			goto out_free_new;
+			goto out_destroy_new;
 		new->md_minor = MINOR(new->unit);
 		new->hold_active = UNTIL_STOP;
 	}
@@ -735,8 +758,11 @@ static struct mddev *mddev_alloc(dev_t unit)
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
@@ -747,6 +773,7 @@ static void mddev_free(struct mddev *mddev)
 	list_del(&mddev->all_mddevs);
 	spin_unlock(&all_mddevs_lock);
 
+	mddev_destroy(mddev);
 	kfree(mddev);
 }
 
@@ -5790,12 +5817,6 @@ static void md_safemode_timeout(struct timer_list *t)
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
@@ -5876,15 +5897,10 @@ int md_run(struct mddev *mddev)
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
@@ -6081,8 +6097,6 @@ int md_run(struct mddev *mddev)
 	bioset_exit(&mddev->sync_set);
 exit_bio_set:
 	bioset_exit(&mddev->bio_set);
-exit_active_io:
-	percpu_ref_exit(&mddev->active_io);
 	return err;
 }
 EXPORT_SYMBOL_GPL(md_run);
@@ -6298,7 +6312,6 @@ static void __md_stop(struct mddev *mddev)
 	module_put(pers->owner);
 	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 
-	percpu_ref_exit(&mddev->active_io);
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
 	bioset_exit(&mddev->io_clone_set);
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 0381f2aa6cbb..f4a3231a326b 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -790,7 +790,8 @@ extern int md_integrity_register(struct mddev *mddev);
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

