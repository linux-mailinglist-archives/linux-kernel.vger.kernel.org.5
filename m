Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64B2787E62
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbjHYDOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjHYDOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:14:17 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AA2D3;
        Thu, 24 Aug 2023 20:14:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RX4md34cmz4f3tDR;
        Fri, 25 Aug 2023 11:14:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAnBah_HOhkveEWBg--.3212S6;
        Fri, 25 Aug 2023 11:14:12 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, xni@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 2/7] md: initialize 'writes_pending' while allocating mddev
Date:   Fri, 25 Aug 2023 11:09:51 +0800
Message-Id: <20230825030956.1527023-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230825030956.1527023-1-yukuai1@huaweicloud.com>
References: <20230825030956.1527023-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnBah_HOhkveEWBg--.3212S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4fAw43Gr1Uur45uFWDXFb_yoW7Ar13pa
        yIqFyfZr4jq3yFq34DAa4kua4Yqr1kKFZ2krW3C34rZFnxurWDGay5XFyjvrWDCa9avw43
        Xw48CrWUu3W8JrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
        v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbdOz7UUUUU=
        =
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently 'writes_pending' is initialized in pers->run for raid1/5/10,
and it's freed while deleing mddev, instead of pers->free. pers->run can
be called multiple times before mddev is deleted, and a helper
mddev_init_writes_pending() is used to prevent 'writes_pending' to be
initialized multiple times, this usage is safe but a litter weird.

On the other hand, 'writes_pending' is only initialized for raid1/5/10,
however, it's used in common layer, for example:

array_state_store
 set_in_sync
  if (!mddev->in_sync) -> in_sync is used for all levels
   // access writes_pending

There might be some implicit dependency that I don't recognized to make
sure 'writes_pending' can only be accessed for raid1/5/10, but there are
no comments about that.

By the way, it make sense to initialize 'writes_pending' in common layer
because there are already three levels use it.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c     | 29 ++++++++++++-----------------
 drivers/md/md.h     |  1 -
 drivers/md/raid1.c  |  3 +--
 drivers/md/raid10.c |  3 ---
 drivers/md/raid5.c  |  3 ---
 5 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9974cf45f9d0..e6faeb73172d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -646,6 +646,8 @@ static void active_io_release(struct percpu_ref *ref)
 	wake_up(&mddev->sb_wait);
 }
 
+static void no_op(struct percpu_ref *r) {}
+
 int mddev_init(struct mddev *mddev)
 {
 
@@ -653,6 +655,15 @@ int mddev_init(struct mddev *mddev)
 			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL))
 		return -ENOMEM;
 
+	if (percpu_ref_init(&mddev->writes_pending, no_op,
+			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL)) {
+		percpu_ref_exit(&mddev->active_io);
+		return -ENOMEM;
+	}
+
+	/* We want to start with the refcount at zero */
+	percpu_ref_put(&mddev->writes_pending);
+
 	mutex_init(&mddev->open_mutex);
 	mutex_init(&mddev->reconfig_mutex);
 	mutex_init(&mddev->sync_mutex);
@@ -685,6 +696,7 @@ EXPORT_SYMBOL_GPL(mddev_init);
 void mddev_destroy(struct mddev *mddev)
 {
 	percpu_ref_exit(&mddev->active_io);
+	percpu_ref_exit(&mddev->writes_pending);
 }
 EXPORT_SYMBOL_GPL(mddev_destroy);
 
@@ -5619,21 +5631,6 @@ static void mddev_delayed_delete(struct work_struct *ws)
 	kobject_put(&mddev->kobj);
 }
 
-static void no_op(struct percpu_ref *r) {}
-
-int mddev_init_writes_pending(struct mddev *mddev)
-{
-	if (mddev->writes_pending.percpu_count_ptr)
-		return 0;
-	if (percpu_ref_init(&mddev->writes_pending, no_op,
-			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL) < 0)
-		return -ENOMEM;
-	/* We want to start with the refcount at zero */
-	percpu_ref_put(&mddev->writes_pending);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mddev_init_writes_pending);
-
 struct mddev *md_alloc(dev_t dev, char *name)
 {
 	/*
@@ -6312,7 +6309,6 @@ void md_stop(struct mddev *mddev)
 	 */
 	__md_stop_writes(mddev);
 	__md_stop(mddev);
-	percpu_ref_exit(&mddev->writes_pending);
 }
 
 EXPORT_SYMBOL_GPL(md_stop);
@@ -7896,7 +7892,6 @@ static void md_free_disk(struct gendisk *disk)
 {
 	struct mddev *mddev = disk->private_data;
 
-	percpu_ref_exit(&mddev->writes_pending);
 	mddev_free(mddev);
 }
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index f6b64b0e92c7..b365226a4183 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -768,7 +768,6 @@ extern void md_unregister_thread(struct mddev *mddev, struct md_thread __rcu **t
 extern void md_wakeup_thread(struct md_thread __rcu *thread);
 extern void md_check_recovery(struct mddev *mddev);
 extern void md_reap_sync_thread(struct mddev *mddev);
-extern int mddev_init_writes_pending(struct mddev *mddev);
 extern bool md_write_start(struct mddev *mddev, struct bio *bi);
 extern void md_write_inc(struct mddev *mddev, struct bio *bi);
 extern void md_write_end(struct mddev *mddev);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 4b30a1742162..95504612b7e2 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3123,8 +3123,7 @@ static int raid1_run(struct mddev *mddev)
 			mdname(mddev));
 		return -EIO;
 	}
-	if (mddev_init_writes_pending(mddev) < 0)
-		return -ENOMEM;
+
 	/*
 	 * copy the already verified devices into our private RAID1
 	 * bookkeeping area. [whatever we allocate in run(),
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 023413120851..a5927e98dc67 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4154,9 +4154,6 @@ static int raid10_run(struct mddev *mddev)
 	sector_t min_offset_diff = 0;
 	int first = 1;
 
-	if (mddev_init_writes_pending(mddev) < 0)
-		return -ENOMEM;
-
 	if (mddev->private == NULL) {
 		conf = setup_conf(mddev);
 		if (IS_ERR(conf))
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4cb9c608ee19..6383723468e5 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7778,9 +7778,6 @@ static int raid5_run(struct mddev *mddev)
 	long long min_offset_diff = 0;
 	int first = 1;
 
-	if (mddev_init_writes_pending(mddev) < 0)
-		return -ENOMEM;
-
 	if (mddev->recovery_cp != MaxSector)
 		pr_notice("md/raid:%s: not clean -- starting background reconstruction\n",
 			  mdname(mddev));
-- 
2.39.2

