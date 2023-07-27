Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE407648AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjG0HeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjG0Hdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:33:46 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235789A9D;
        Thu, 27 Jul 2023 00:23:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RBMgS2vcYz4f3jMb;
        Thu, 27 Jul 2023 15:23:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCXaK9mG8JkwjuoOw--.65260S4;
        Thu, 27 Jul 2023 15:23:19 +0800 (CST)
From:   Li Lingfeng <lilingfeng@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, linan122@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com,
        lilingfeng3@huawei.com
Subject: [PATCH -next] md:ensure mddev->reconfig_mutex is hold when try to get mddev->sync_thread
Date:   Thu, 27 Jul 2023 15:20:47 +0800
Message-Id: <20230727072047.389637-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXaK9mG8JkwjuoOw--.65260S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr48GF4rJw47Xr13Ww1fXrb_yoW7tF4xpa
        yrXFy3Ar4FvrW5Zr4DJayDuay5A3WIgFWjkryfC3yrA3WfW3y5JFWj9FyDXr1DZFyrAr4a
        qa15KF48uFWvgr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ba9d9f1a707f ("Revert "md: unlock mddev before reap sync_thread in
action_store"") removed the scenario of calling md_unregister_thread()
without holding mddev->reconfig_mutex, so add a lock holding check before
acquiring mddev->sync_thread.

Signed-off-by: Li Lingfeng <lilingfeng@huaweicloud.com>
---
 drivers/md/md-cluster.c  | 8 ++++----
 drivers/md/md.c          | 9 +++++----
 drivers/md/md.h          | 2 +-
 drivers/md/raid1.c       | 4 ++--
 drivers/md/raid10.c      | 2 +-
 drivers/md/raid5-cache.c | 2 +-
 drivers/md/raid5.c       | 2 +-
 7 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 3d9fd74233df..1e26eb223349 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -952,8 +952,8 @@ static int join(struct mddev *mddev, int nodes)
 	return 0;
 err:
 	set_bit(MD_CLUSTER_HOLDING_MUTEX_FOR_RECVD, &cinfo->state);
-	md_unregister_thread(&cinfo->recovery_thread);
-	md_unregister_thread(&cinfo->recv_thread);
+	md_unregister_thread(mddev, &cinfo->recovery_thread);
+	md_unregister_thread(mddev, &cinfo->recv_thread);
 	lockres_free(cinfo->message_lockres);
 	lockres_free(cinfo->token_lockres);
 	lockres_free(cinfo->ack_lockres);
@@ -1015,8 +1015,8 @@ static int leave(struct mddev *mddev)
 		resync_bitmap(mddev);
 
 	set_bit(MD_CLUSTER_HOLDING_MUTEX_FOR_RECVD, &cinfo->state);
-	md_unregister_thread(&cinfo->recovery_thread);
-	md_unregister_thread(&cinfo->recv_thread);
+	md_unregister_thread(mddev, &cinfo->recovery_thread);
+	md_unregister_thread(mddev, &cinfo->recv_thread);
 	lockres_free(cinfo->message_lockres);
 	lockres_free(cinfo->token_lockres);
 	lockres_free(cinfo->ack_lockres);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index a3d98273b295..5c3c19b8d509 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6258,7 +6258,7 @@ static void mddev_detach(struct mddev *mddev)
 		mddev->pers->quiesce(mddev, 1);
 		mddev->pers->quiesce(mddev, 0);
 	}
-	md_unregister_thread(&mddev->thread);
+	md_unregister_thread(mddev, &mddev->thread);
 	if (mddev->queue)
 		blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
 }
@@ -7990,9 +7990,10 @@ struct md_thread *md_register_thread(void (*run) (struct md_thread *),
 }
 EXPORT_SYMBOL(md_register_thread);
 
-void md_unregister_thread(struct md_thread __rcu **threadp)
+void md_unregister_thread(struct mddev *mddev, struct md_thread __rcu **threadp)
 {
-	struct md_thread *thread = rcu_dereference_protected(*threadp, true);
+	struct md_thread *thread = rcu_dereference_protected(*threadp,
+					lockdep_is_held(&mddev->reconfig_mutex));
 
 	if (!thread)
 		return;
@@ -9484,7 +9485,7 @@ void md_reap_sync_thread(struct mddev *mddev)
 	bool is_reshaped = false;
 
 	/* resync has finished, collect result */
-	md_unregister_thread(&mddev->sync_thread);
+	md_unregister_thread(mddev, &mddev->sync_thread);
 	atomic_inc(&mddev->sync_seq);
 
 	if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 8ae957480976..9bcb77bca963 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -761,7 +761,7 @@ extern struct md_thread *md_register_thread(
 	void (*run)(struct md_thread *thread),
 	struct mddev *mddev,
 	const char *name);
-extern void md_unregister_thread(struct md_thread __rcu **threadp);
+extern void md_unregister_thread(struct mddev *mddev, struct md_thread __rcu **threadp);
 extern void md_wakeup_thread(struct md_thread __rcu *thread);
 extern void md_check_recovery(struct mddev *mddev);
 extern void md_reap_sync_thread(struct mddev *mddev);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 23d211969565..581dfbdfca89 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3152,7 +3152,7 @@ static int raid1_run(struct mddev *mddev)
 	 * RAID1 needs at least one disk in active
 	 */
 	if (conf->raid_disks - mddev->degraded < 1) {
-		md_unregister_thread(&conf->thread);
+		md_unregister_thread(mddev, &conf->thread);
 		ret = -EINVAL;
 		goto abort;
 	}
@@ -3179,7 +3179,7 @@ static int raid1_run(struct mddev *mddev)
 
 	ret = md_integrity_register(mddev);
 	if (ret) {
-		md_unregister_thread(&mddev->thread);
+		md_unregister_thread(mddev, &mddev->thread);
 		goto abort;
 	}
 	return 0;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 16aa9d735880..6188b71186f4 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4320,7 +4320,7 @@ static int raid10_run(struct mddev *mddev)
 	return 0;
 
 out_free_conf:
-	md_unregister_thread(&mddev->thread);
+	md_unregister_thread(mddev, &mddev->thread);
 	raid10_free_conf(conf);
 	mddev->private = NULL;
 out:
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 47ba7d9e81e1..ce9b42fd54b9 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -3171,7 +3171,7 @@ void r5l_exit_log(struct r5conf *conf)
 	/* Ensure disable_writeback_work wakes up and exits */
 	wake_up(&conf->mddev->sb_wait);
 	flush_work(&log->disable_writeback_work);
-	md_unregister_thread(&log->reclaim_thread);
+	md_unregister_thread(conf->mddev, &log->reclaim_thread);
 
 	conf->log = NULL;
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4cdb35e54251..f41f9b712d3d 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8107,7 +8107,7 @@ static int raid5_run(struct mddev *mddev)
 
 	return 0;
 abort:
-	md_unregister_thread(&mddev->thread);
+	md_unregister_thread(mddev, &mddev->thread);
 	print_raid5_conf(conf);
 	free_conf(conf);
 	mddev->private = NULL;
-- 
2.39.2

