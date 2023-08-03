Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC19076EA6D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbjHCNcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjHCNcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:32:01 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79FA2D73;
        Thu,  3 Aug 2023 06:30:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RGqVF5GbMz4f3nyh;
        Thu,  3 Aug 2023 21:30:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7MGrMtkNVvlPQ--.7517S6;
        Thu, 03 Aug 2023 21:30:48 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 2/7] md: initialize 'writes_pending' while allocating mddev
Date:   Thu,  3 Aug 2023 21:27:46 +0800
Message-Id: <20230803132751.2741652-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803132751.2741652-1-yukuai1@huaweicloud.com>
References: <20230803132751.2741652-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7MGrMtkNVvlPQ--.7517S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4fAw43Gr1Uur45ZF45trb_yoW7Ww43pa
        yIqFyfAr40q3yFq34DAa4kua4Yqr1kKFZ2krW3C34rZFnxurWDGa15XFWjvryDCa93Zw4a
        qw48CrW7u3W8KrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
        W8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUfwIDUUUUU=
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
index c391d8e016af..897e94a9e47d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -645,6 +645,8 @@ static void active_io_release(struct percpu_ref *ref)
 	wake_up(&mddev->sb_wait);
 }
 
+static void no_op(struct percpu_ref *r) {}
+
 int mddev_init(struct mddev *mddev)
 {
 
@@ -652,6 +654,15 @@ int mddev_init(struct mddev *mddev)
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
@@ -684,6 +695,7 @@ EXPORT_SYMBOL_GPL(mddev_init);
 void mddev_destroy(struct mddev *mddev)
 {
 	percpu_ref_exit(&mddev->active_io);
+	percpu_ref_exit(&mddev->writes_pending);
 }
 EXPORT_SYMBOL_GPL(mddev_destroy);
 
@@ -5631,21 +5643,6 @@ static void mddev_delayed_delete(struct work_struct *ws)
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
@@ -6324,7 +6321,6 @@ void md_stop(struct mddev *mddev)
 	 */
 	__md_stop_writes(mddev);
 	__md_stop(mddev);
-	percpu_ref_exit(&mddev->writes_pending);
 }
 
 EXPORT_SYMBOL_GPL(md_stop);
@@ -7905,7 +7901,6 @@ static void md_free_disk(struct gendisk *disk)
 {
 	struct mddev *mddev = disk->private_data;
 
-	percpu_ref_exit(&mddev->writes_pending);
 	mddev_free(mddev);
 }
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index f4a3231a326b..343dd89c13cf 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -763,7 +763,6 @@ extern void md_unregister_thread(struct md_thread __rcu **threadp);
 extern void md_wakeup_thread(struct md_thread __rcu *thread);
 extern void md_check_recovery(struct mddev *mddev);
 extern void md_reap_sync_thread(struct mddev *mddev);
-extern int mddev_init_writes_pending(struct mddev *mddev);
 extern bool md_write_start(struct mddev *mddev, struct bio *bi);
 extern void md_write_inc(struct mddev *mddev, struct bio *bi);
 extern void md_write_end(struct mddev *mddev);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index acb6d6542619..4842958cbb40 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3116,8 +3116,7 @@ static int raid1_run(struct mddev *mddev)
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
index 64dd5cb6133e..e836d29e0ca1 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4153,9 +4153,6 @@ static int raid10_run(struct mddev *mddev)
 	sector_t min_offset_diff = 0;
 	int first = 1;
 
-	if (mddev_init_writes_pending(mddev) < 0)
-		return -ENOMEM;
-
 	if (mddev->private == NULL) {
 		conf = setup_conf(mddev);
 		if (IS_ERR(conf))
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 37d9865b180a..d6695fc718c1 100644
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

