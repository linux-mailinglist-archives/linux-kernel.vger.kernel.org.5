Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC5E7F8923
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjKYIQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYIQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:16:32 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A9A18B;
        Sat, 25 Nov 2023 00:16:37 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Scl7410TSz4f3kL1;
        Sat, 25 Nov 2023 16:16:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id E069B1A0424;
        Sat, 25 Nov 2023 16:16:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgCnqxFfrWFlP8KIBw--.32848S8;
        Sat, 25 Nov 2023 16:16:34 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v3 4/5] md/raid5: remove rcu protection to access rdev from conf
Date:   Sat, 25 Nov 2023 16:16:03 +0800
Message-Id: <20231125081604.3939938-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231125081604.3939938-1-yukuai1@huaweicloud.com>
References: <20231125081604.3939938-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCnqxFfrWFlP8KIBw--.32848S8
X-Coremail-Antispam: 1UD129KBjvAXoWfCFW8AryfXr47CF1rJFyUAwb_yoW8tFW8Wo
        Z7Zwsxta1xJryvg3y7trn3tr47uayrAw1fCr15WrZ5Za92gw4F9w13Cr45XF1UXF1fKFy7
        Xr93Xw4vqF15CrZ3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYl7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
        Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
        84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
        WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
        3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
        x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
        JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Because it's safe to accees rdev from conf:
 - If any spinlock is held, because synchronize_rcu() from
   md_kick_rdev_from_array() will prevent 'rdev' to be freed until
   spinlock is released;
 - If 'reconfig_lock' is held, because rdev can't be added or removed from
   array;
 - If there is normal IO inflight, because mddev_suspend() will prevent
   rdev to be added or removed from array;
 - If there is sync IO inflight, because 'MD_RECOVERY_RUNNING' is
   checked in remove_and_add_spares().

And these will cover all the scenarios in raid456.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid5-cache.c |  11 +--
 drivers/md/raid5-ppl.c   |  16 +---
 drivers/md/raid5.c       | 182 +++++++++++++--------------------------
 drivers/md/raid5.h       |   4 +-
 4 files changed, 69 insertions(+), 144 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 6157f5beb9fe..874874fe4fa1 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1890,28 +1890,22 @@ r5l_recovery_replay_one_stripe(struct r5conf *conf,
 			continue;
 
 		/* in case device is broken */
-		rcu_read_lock();
-		rdev = rcu_dereference(conf->disks[disk_index].rdev);
+		rdev = conf->disks[disk_index].rdev;
 		if (rdev) {
 			atomic_inc(&rdev->nr_pending);
-			rcu_read_unlock();
 			sync_page_io(rdev, sh->sector, PAGE_SIZE,
 				     sh->dev[disk_index].page, REQ_OP_WRITE,
 				     false);
 			rdev_dec_pending(rdev, rdev->mddev);
-			rcu_read_lock();
 		}
-		rrdev = rcu_dereference(conf->disks[disk_index].replacement);
+		rrdev = conf->disks[disk_index].replacement;
 		if (rrdev) {
 			atomic_inc(&rrdev->nr_pending);
-			rcu_read_unlock();
 			sync_page_io(rrdev, sh->sector, PAGE_SIZE,
 				     sh->dev[disk_index].page, REQ_OP_WRITE,
 				     false);
 			rdev_dec_pending(rrdev, rrdev->mddev);
-			rcu_read_lock();
 		}
-		rcu_read_unlock();
 	}
 	ctx->data_parity_stripes++;
 out:
@@ -2948,7 +2942,6 @@ bool r5c_big_stripe_cached(struct r5conf *conf, sector_t sect)
 	if (!log)
 		return false;
 
-	WARN_ON_ONCE(!rcu_read_lock_held());
 	tree_index = r5c_tree_index(conf, sect);
 	slot = radix_tree_lookup(&log->big_stripe_tree, tree_index);
 	return slot != NULL;
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index eaea57aee602..da4ba736c4f0 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -620,11 +620,9 @@ static void ppl_do_flush(struct ppl_io_unit *io)
 		struct md_rdev *rdev;
 		struct block_device *bdev = NULL;
 
-		rcu_read_lock();
-		rdev = rcu_dereference(conf->disks[i].rdev);
+		rdev = conf->disks[i].rdev;
 		if (rdev && !test_bit(Faulty, &rdev->flags))
 			bdev = rdev->bdev;
-		rcu_read_unlock();
 
 		if (bdev) {
 			struct bio *bio;
@@ -882,9 +880,7 @@ static int ppl_recover_entry(struct ppl_log *log, struct ppl_header_entry *e,
 				 (unsigned long long)r_sector, dd_idx,
 				 (unsigned long long)sector);
 
-			/* Array has not started so rcu dereference is safe */
-			rdev = rcu_dereference_protected(
-					conf->disks[dd_idx].rdev, 1);
+			rdev = conf->disks[dd_idx].rdev;
 			if (!rdev || (!test_bit(In_sync, &rdev->flags) &&
 				      sector >= rdev->recovery_offset)) {
 				pr_debug("%s:%*s data member disk %d missing\n",
@@ -936,9 +932,7 @@ static int ppl_recover_entry(struct ppl_log *log, struct ppl_header_entry *e,
 				0, &disk, &sh);
 		BUG_ON(sh.pd_idx != le32_to_cpu(e->parity_disk));
 
-		/* Array has not started so rcu dereference is safe */
-		parity_rdev = rcu_dereference_protected(
-					conf->disks[sh.pd_idx].rdev, 1);
+		parity_rdev = conf->disks[sh.pd_idx].rdev;
 
 		BUG_ON(parity_rdev->bdev->bd_dev != log->rdev->bdev->bd_dev);
 		pr_debug("%s:%*s write parity at sector %llu, disk %pg\n",
@@ -1404,9 +1398,7 @@ int ppl_init_log(struct r5conf *conf)
 
 	for (i = 0; i < ppl_conf->count; i++) {
 		struct ppl_log *log = &ppl_conf->child_logs[i];
-		/* Array has not started so rcu dereference is safe */
-		struct md_rdev *rdev =
-			rcu_dereference_protected(conf->disks[i].rdev, 1);
+		struct md_rdev *rdev = conf->disks[i].rdev;
 
 		mutex_init(&log->io_mutex);
 		spin_lock_init(&log->io_list_lock);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index fb009e3df132..8056071cf39f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -694,12 +694,12 @@ int raid5_calc_degraded(struct r5conf *conf)
 	int degraded, degraded2;
 	int i;
 
-	rcu_read_lock();
 	degraded = 0;
 	for (i = 0; i < conf->previous_raid_disks; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->disks[i].rdev);
+		struct md_rdev *rdev = READ_ONCE(conf->disks[i].rdev);
+
 		if (rdev && test_bit(Faulty, &rdev->flags))
-			rdev = rcu_dereference(conf->disks[i].replacement);
+			rdev = READ_ONCE(conf->disks[i].replacement);
 		if (!rdev || test_bit(Faulty, &rdev->flags))
 			degraded++;
 		else if (test_bit(In_sync, &rdev->flags))
@@ -717,15 +717,14 @@ int raid5_calc_degraded(struct r5conf *conf)
 			if (conf->raid_disks >= conf->previous_raid_disks)
 				degraded++;
 	}
-	rcu_read_unlock();
 	if (conf->raid_disks == conf->previous_raid_disks)
 		return degraded;
-	rcu_read_lock();
 	degraded2 = 0;
 	for (i = 0; i < conf->raid_disks; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->disks[i].rdev);
+		struct md_rdev *rdev = READ_ONCE(conf->disks[i].rdev);
+
 		if (rdev && test_bit(Faulty, &rdev->flags))
-			rdev = rcu_dereference(conf->disks[i].replacement);
+			rdev = READ_ONCE(conf->disks[i].replacement);
 		if (!rdev || test_bit(Faulty, &rdev->flags))
 			degraded2++;
 		else if (test_bit(In_sync, &rdev->flags))
@@ -739,7 +738,6 @@ int raid5_calc_degraded(struct r5conf *conf)
 			if (conf->raid_disks <= conf->previous_raid_disks)
 				degraded2++;
 	}
-	rcu_read_unlock();
 	if (degraded2 > degraded)
 		return degraded2;
 	return degraded;
@@ -1177,14 +1175,8 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 		bi = &dev->req;
 		rbi = &dev->rreq; /* For writing to replacement */
 
-		rcu_read_lock();
-		rrdev = rcu_dereference(conf->disks[i].replacement);
-		smp_mb(); /* Ensure that if rrdev is NULL, rdev won't be */
-		rdev = rcu_dereference(conf->disks[i].rdev);
-		if (!rdev) {
-			rdev = rrdev;
-			rrdev = NULL;
-		}
+		rdev = conf->disks[i].rdev;
+		rrdev = conf->disks[i].replacement;
 		if (op_is_write(op)) {
 			if (replace_only)
 				rdev = NULL;
@@ -1205,7 +1197,6 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			rrdev = NULL;
 		if (rrdev)
 			atomic_inc(&rrdev->nr_pending);
-		rcu_read_unlock();
 
 		/* We have already checked bad blocks for reads.  Now
 		 * need to check for writes.  We never accept write errors
@@ -2724,28 +2715,6 @@ static void shrink_stripes(struct r5conf *conf)
 	conf->slab_cache = NULL;
 }
 
-/*
- * This helper wraps rcu_dereference_protected() and can be used when
- * it is known that the nr_pending of the rdev is elevated.
- */
-static struct md_rdev *rdev_pend_deref(struct md_rdev __rcu *rdev)
-{
-	return rcu_dereference_protected(rdev,
-			atomic_read(&rcu_access_pointer(rdev)->nr_pending));
-}
-
-/*
- * This helper wraps rcu_dereference_protected() and should be used
- * when it is known that the mddev_lock() is held. This is safe
- * seeing raid5_remove_disk() has the same lock held.
- */
-static struct md_rdev *rdev_mdlock_deref(struct mddev *mddev,
-					 struct md_rdev __rcu *rdev)
-{
-	return rcu_dereference_protected(rdev,
-			lockdep_is_held(&mddev->reconfig_mutex));
-}
-
 static void raid5_end_read_request(struct bio * bi)
 {
 	struct stripe_head *sh = bi->bi_private;
@@ -2771,9 +2740,9 @@ static void raid5_end_read_request(struct bio * bi)
 		 * In that case it moved down to 'rdev'.
 		 * rdev is not removed until all requests are finished.
 		 */
-		rdev = rdev_pend_deref(conf->disks[i].replacement);
+		rdev = conf->disks[i].replacement;
 	if (!rdev)
-		rdev = rdev_pend_deref(conf->disks[i].rdev);
+		rdev = conf->disks[i].rdev;
 
 	if (use_new_offset(conf, sh))
 		s = sh->sector + rdev->new_data_offset;
@@ -2886,11 +2855,11 @@ static void raid5_end_write_request(struct bio *bi)
 
 	for (i = 0 ; i < disks; i++) {
 		if (bi == &sh->dev[i].req) {
-			rdev = rdev_pend_deref(conf->disks[i].rdev);
+			rdev = conf->disks[i].rdev;
 			break;
 		}
 		if (bi == &sh->dev[i].rreq) {
-			rdev = rdev_pend_deref(conf->disks[i].replacement);
+			rdev = conf->disks[i].replacement;
 			if (rdev)
 				replacement = 1;
 			else
@@ -2898,7 +2867,7 @@ static void raid5_end_write_request(struct bio *bi)
 				 * replaced it.  rdev is not removed
 				 * until all requests are finished.
 				 */
-				rdev = rdev_pend_deref(conf->disks[i].rdev);
+				rdev = conf->disks[i].rdev;
 			break;
 		}
 	}
@@ -3660,15 +3629,13 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 		int bitmap_end = 0;
 
 		if (test_bit(R5_ReadError, &sh->dev[i].flags)) {
-			struct md_rdev *rdev;
-			rcu_read_lock();
-			rdev = rcu_dereference(conf->disks[i].rdev);
+			struct md_rdev *rdev = conf->disks[i].rdev;
+
 			if (rdev && test_bit(In_sync, &rdev->flags) &&
 			    !test_bit(Faulty, &rdev->flags))
 				atomic_inc(&rdev->nr_pending);
 			else
 				rdev = NULL;
-			rcu_read_unlock();
 			if (rdev) {
 				if (!rdev_set_badblocks(
 					    rdev,
@@ -3786,16 +3753,17 @@ handle_failed_sync(struct r5conf *conf, struct stripe_head *sh,
 		/* During recovery devices cannot be removed, so
 		 * locking and refcounting of rdevs is not needed
 		 */
-		rcu_read_lock();
 		for (i = 0; i < conf->raid_disks; i++) {
-			struct md_rdev *rdev = rcu_dereference(conf->disks[i].rdev);
+			struct md_rdev *rdev = conf->disks[i].rdev;
+
 			if (rdev
 			    && !test_bit(Faulty, &rdev->flags)
 			    && !test_bit(In_sync, &rdev->flags)
 			    && !rdev_set_badblocks(rdev, sh->sector,
 						   RAID5_STRIPE_SECTORS(conf), 0))
 				abort = 1;
-			rdev = rcu_dereference(conf->disks[i].replacement);
+			rdev = conf->disks[i].replacement;
+
 			if (rdev
 			    && !test_bit(Faulty, &rdev->flags)
 			    && !test_bit(In_sync, &rdev->flags)
@@ -3803,7 +3771,6 @@ handle_failed_sync(struct r5conf *conf, struct stripe_head *sh,
 						   RAID5_STRIPE_SECTORS(conf), 0))
 				abort = 1;
 		}
-		rcu_read_unlock();
 		if (abort)
 			conf->recovery_disabled =
 				conf->mddev->recovery_disabled;
@@ -3816,15 +3783,13 @@ static int want_replace(struct stripe_head *sh, int disk_idx)
 	struct md_rdev *rdev;
 	int rv = 0;
 
-	rcu_read_lock();
-	rdev = rcu_dereference(sh->raid_conf->disks[disk_idx].replacement);
+	rdev = sh->raid_conf->disks[disk_idx].replacement;
 	if (rdev
 	    && !test_bit(Faulty, &rdev->flags)
 	    && !test_bit(In_sync, &rdev->flags)
 	    && (rdev->recovery_offset <= sh->sector
 		|| rdev->mddev->recovery_cp <= sh->sector))
 		rv = 1;
-	rcu_read_unlock();
 	return rv;
 }
 
@@ -4701,7 +4666,6 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 	s->log_failed = r5l_log_disk_error(conf);
 
 	/* Now to look around and see what can be done */
-	rcu_read_lock();
 	for (i=disks; i--; ) {
 		struct md_rdev *rdev;
 		sector_t first_bad;
@@ -4746,7 +4710,7 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 		/* Prefer to use the replacement for reads, but only
 		 * if it is recovered enough and has no bad blocks.
 		 */
-		rdev = rcu_dereference(conf->disks[i].replacement);
+		rdev = conf->disks[i].replacement;
 		if (rdev && !test_bit(Faulty, &rdev->flags) &&
 		    rdev->recovery_offset >= sh->sector + RAID5_STRIPE_SECTORS(conf) &&
 		    !is_badblock(rdev, sh->sector, RAID5_STRIPE_SECTORS(conf),
@@ -4757,7 +4721,7 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 				set_bit(R5_NeedReplace, &dev->flags);
 			else
 				clear_bit(R5_NeedReplace, &dev->flags);
-			rdev = rcu_dereference(conf->disks[i].rdev);
+			rdev = conf->disks[i].rdev;
 			clear_bit(R5_ReadRepl, &dev->flags);
 		}
 		if (rdev && test_bit(Faulty, &rdev->flags))
@@ -4804,8 +4768,8 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 		if (test_bit(R5_WriteError, &dev->flags)) {
 			/* This flag does not apply to '.replacement'
 			 * only to .rdev, so make sure to check that*/
-			struct md_rdev *rdev2 = rcu_dereference(
-				conf->disks[i].rdev);
+			struct md_rdev *rdev2 = conf->disks[i].rdev;
+
 			if (rdev2 == rdev)
 				clear_bit(R5_Insync, &dev->flags);
 			if (rdev2 && !test_bit(Faulty, &rdev2->flags)) {
@@ -4817,8 +4781,8 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 		if (test_bit(R5_MadeGood, &dev->flags)) {
 			/* This flag does not apply to '.replacement'
 			 * only to .rdev, so make sure to check that*/
-			struct md_rdev *rdev2 = rcu_dereference(
-				conf->disks[i].rdev);
+			struct md_rdev *rdev2 = conf->disks[i].rdev;
+
 			if (rdev2 && !test_bit(Faulty, &rdev2->flags)) {
 				s->handle_bad_blocks = 1;
 				atomic_inc(&rdev2->nr_pending);
@@ -4826,8 +4790,8 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 				clear_bit(R5_MadeGood, &dev->flags);
 		}
 		if (test_bit(R5_MadeGoodRepl, &dev->flags)) {
-			struct md_rdev *rdev2 = rcu_dereference(
-				conf->disks[i].replacement);
+			struct md_rdev *rdev2 = conf->disks[i].replacement;
+
 			if (rdev2 && !test_bit(Faulty, &rdev2->flags)) {
 				s->handle_bad_blocks = 1;
 				atomic_inc(&rdev2->nr_pending);
@@ -4848,8 +4812,7 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 			if (rdev && !test_bit(Faulty, &rdev->flags))
 				do_recovery = 1;
 			else if (!rdev) {
-				rdev = rcu_dereference(
-				    conf->disks[i].replacement);
+				rdev = conf->disks[i].replacement;
 				if (rdev && !test_bit(Faulty, &rdev->flags))
 					do_recovery = 1;
 			}
@@ -4876,7 +4839,6 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 		else
 			s->replacing = 1;
 	}
-	rcu_read_unlock();
 }
 
 /*
@@ -5333,23 +5295,23 @@ static void handle_stripe(struct stripe_head *sh)
 			struct r5dev *dev = &sh->dev[i];
 			if (test_and_clear_bit(R5_WriteError, &dev->flags)) {
 				/* We own a safe reference to the rdev */
-				rdev = rdev_pend_deref(conf->disks[i].rdev);
+				rdev = conf->disks[i].rdev;
 				if (!rdev_set_badblocks(rdev, sh->sector,
 							RAID5_STRIPE_SECTORS(conf), 0))
 					md_error(conf->mddev, rdev);
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			if (test_and_clear_bit(R5_MadeGood, &dev->flags)) {
-				rdev = rdev_pend_deref(conf->disks[i].rdev);
+				rdev = conf->disks[i].rdev;
 				rdev_clear_badblocks(rdev, sh->sector,
 						     RAID5_STRIPE_SECTORS(conf), 0);
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			if (test_and_clear_bit(R5_MadeGoodRepl, &dev->flags)) {
-				rdev = rdev_pend_deref(conf->disks[i].replacement);
+				rdev = conf->disks[i].replacement;
 				if (!rdev)
 					/* rdev have been moved down */
-					rdev = rdev_pend_deref(conf->disks[i].rdev);
+					rdev = conf->disks[i].rdev;
 				rdev_clear_badblocks(rdev, sh->sector,
 						     RAID5_STRIPE_SECTORS(conf), 0);
 				rdev_dec_pending(rdev, conf->mddev);
@@ -5508,24 +5470,22 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 				      &dd_idx, NULL);
 	end_sector = sector + bio_sectors(raid_bio);
 
-	rcu_read_lock();
 	if (r5c_big_stripe_cached(conf, sector))
-		goto out_rcu_unlock;
+		return 0;
 
-	rdev = rcu_dereference(conf->disks[dd_idx].replacement);
+	rdev = conf->disks[dd_idx].replacement;
 	if (!rdev || test_bit(Faulty, &rdev->flags) ||
 	    rdev->recovery_offset < end_sector) {
-		rdev = rcu_dereference(conf->disks[dd_idx].rdev);
+		rdev = conf->disks[dd_idx].rdev;
 		if (!rdev)
-			goto out_rcu_unlock;
+			return 0;
 		if (test_bit(Faulty, &rdev->flags) ||
 		    !(test_bit(In_sync, &rdev->flags) ||
 		      rdev->recovery_offset >= end_sector))
-			goto out_rcu_unlock;
+			return 0;
 	}
 
 	atomic_inc(&rdev->nr_pending);
-	rcu_read_unlock();
 
 	if (is_badblock(rdev, sector, bio_sectors(raid_bio), &first_bad,
 			&bad_sectors)) {
@@ -5569,10 +5529,6 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 				      raid_bio->bi_iter.bi_sector);
 	submit_bio_noacct(align_bio);
 	return 1;
-
-out_rcu_unlock:
-	rcu_read_unlock();
-	return 0;
 }
 
 static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
@@ -6575,14 +6531,12 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
 	 * Note in case of > 1 drive failures it's possible we're rebuilding
 	 * one drive while leaving another faulty drive in array.
 	 */
-	rcu_read_lock();
 	for (i = 0; i < conf->raid_disks; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->disks[i].rdev);
+		struct md_rdev *rdev = conf->disks[i].rdev;
 
 		if (rdev == NULL || test_bit(Faulty, &rdev->flags))
 			still_degraded = 1;
 	}
-	rcu_read_unlock();
 
 	md_bitmap_start_sync(mddev->bitmap, sector_nr, &sync_blocks, still_degraded);
 
@@ -7898,18 +7852,10 @@ static int raid5_run(struct mddev *mddev)
 
 	for (i = 0; i < conf->raid_disks && conf->previous_raid_disks;
 	     i++) {
-		rdev = rdev_mdlock_deref(mddev, conf->disks[i].rdev);
-		if (!rdev && conf->disks[i].replacement) {
-			/* The replacement is all we have yet */
-			rdev = rdev_mdlock_deref(mddev,
-						 conf->disks[i].replacement);
-			conf->disks[i].replacement = NULL;
-			clear_bit(Replacement, &rdev->flags);
-			rcu_assign_pointer(conf->disks[i].rdev, rdev);
-		}
+		rdev = conf->disks[i].rdev;
 		if (!rdev)
 			continue;
-		if (rcu_access_pointer(conf->disks[i].replacement) &&
+		if (conf->disks[i].replacement &&
 		    conf->reshape_progress != MaxSector) {
 			/* replacements and reshape simply do not mix. */
 			pr_warn("md: cannot handle concurrent replacement and reshape.\n");
@@ -8093,15 +8039,16 @@ static void raid5_status(struct seq_file *seq, struct mddev *mddev)
 	struct r5conf *conf = mddev->private;
 	int i;
 
+	lockdep_assert_held(&mddev->lock);
+
 	seq_printf(seq, " level %d, %dk chunk, algorithm %d", mddev->level,
 		conf->chunk_sectors / 2, mddev->layout);
 	seq_printf (seq, " [%d/%d] [", conf->raid_disks, conf->raid_disks - mddev->degraded);
-	rcu_read_lock();
 	for (i = 0; i < conf->raid_disks; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->disks[i].rdev);
+		struct md_rdev *rdev = READ_ONCE(conf->disks[i].rdev);
+
 		seq_printf (seq, "%s", rdev && test_bit(In_sync, &rdev->flags) ? "U" : "_");
 	}
-	rcu_read_unlock();
 	seq_printf (seq, "]");
 }
 
@@ -8139,9 +8086,8 @@ static int raid5_spare_active(struct mddev *mddev)
 	unsigned long flags;
 
 	for (i = 0; i < conf->raid_disks; i++) {
-		rdev = rdev_mdlock_deref(mddev, conf->disks[i].rdev);
-		replacement = rdev_mdlock_deref(mddev,
-						conf->disks[i].replacement);
+		rdev = conf->disks[i].rdev;
+		replacement = conf->disks[i].replacement;
 		if (replacement
 		    && replacement->recovery_offset == MaxSector
 		    && !test_bit(Faulty, &replacement->flags)
@@ -8180,7 +8126,7 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	struct r5conf *conf = mddev->private;
 	int err = 0;
 	int number = rdev->raid_disk;
-	struct md_rdev __rcu **rdevp;
+	struct md_rdev **rdevp;
 	struct disk_info *p;
 	struct md_rdev *tmp;
 
@@ -8203,9 +8149,9 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	if (unlikely(number >= conf->pool_size))
 		return 0;
 	p = conf->disks + number;
-	if (rdev == rcu_access_pointer(p->rdev))
+	if (rdev == p->rdev)
 		rdevp = &p->rdev;
-	else if (rdev == rcu_access_pointer(p->replacement))
+	else if (rdev == p->replacement)
 		rdevp = &p->replacement;
 	else
 		return 0;
@@ -8225,28 +8171,24 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	if (!test_bit(Faulty, &rdev->flags) &&
 	    mddev->recovery_disabled != conf->recovery_disabled &&
 	    !has_failed(conf) &&
-	    (!rcu_access_pointer(p->replacement) ||
-	     rcu_access_pointer(p->replacement) == rdev) &&
+	    (!p->replacement || p->replacement == rdev) &&
 	    number < conf->raid_disks) {
 		err = -EBUSY;
 		goto abort;
 	}
-	*rdevp = NULL;
+	WRITE_ONCE(*rdevp, NULL);
 	if (!err) {
 		err = log_modify(conf, rdev, false);
 		if (err)
 			goto abort;
 	}
 
-	tmp = rcu_access_pointer(p->replacement);
+	tmp = p->replacement;
 	if (tmp) {
 		/* We must have just cleared 'rdev' */
-		rcu_assign_pointer(p->rdev, tmp);
+		WRITE_ONCE(p->rdev, tmp);
 		clear_bit(Replacement, &tmp->flags);
-		smp_mb(); /* Make sure other CPUs may see both as identical
-			   * but will never see neither - if they are careful
-			   */
-		rcu_assign_pointer(p->replacement, NULL);
+		WRITE_ONCE(p->replacement, NULL);
 
 		if (!err)
 			err = log_modify(conf, tmp, true);
@@ -8314,7 +8256,7 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 			rdev->raid_disk = disk;
 			if (rdev->saved_raid_disk != disk)
 				conf->fullsync = 1;
-			rcu_assign_pointer(p->rdev, rdev);
+			WRITE_ONCE(p->rdev, rdev);
 
 			err = log_modify(conf, rdev, true);
 
@@ -8323,7 +8265,7 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 	}
 	for (disk = first; disk <= last; disk++) {
 		p = conf->disks + disk;
-		tmp = rdev_mdlock_deref(mddev, p->rdev);
+		tmp = p->rdev;
 		if (test_bit(WantReplacement, &tmp->flags) &&
 		    mddev->reshape_position == MaxSector &&
 		    p->replacement == NULL) {
@@ -8332,7 +8274,7 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 			rdev->raid_disk = disk;
 			err = 0;
 			conf->fullsync = 1;
-			rcu_assign_pointer(p->replacement, rdev);
+			WRITE_ONCE(p->replacement, rdev);
 			break;
 		}
 	}
@@ -8465,7 +8407,7 @@ static int raid5_start_reshape(struct mddev *mddev)
 	if (mddev->recovery_cp < MaxSector)
 		return -EBUSY;
 	for (i = 0; i < conf->raid_disks; i++)
-		if (rdev_mdlock_deref(mddev, conf->disks[i].replacement))
+		if (conf->disks[i].replacement)
 			return -EBUSY;
 
 	rdev_for_each(rdev, mddev) {
@@ -8636,12 +8578,10 @@ static void raid5_finish_reshape(struct mddev *mddev)
 			for (d = conf->raid_disks ;
 			     d < conf->raid_disks - mddev->delta_disks;
 			     d++) {
-				rdev = rdev_mdlock_deref(mddev,
-							 conf->disks[d].rdev);
+				rdev = conf->disks[d].rdev;
 				if (rdev)
 					clear_bit(In_sync, &rdev->flags);
-				rdev = rdev_mdlock_deref(mddev,
-						conf->disks[d].replacement);
+				rdev = conf->disks[d].replacement;
 				if (rdev)
 					clear_bit(In_sync, &rdev->flags);
 			}
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 97a795979a35..9163c8cefb3f 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -473,8 +473,8 @@ enum {
  */
 
 struct disk_info {
-	struct md_rdev	__rcu *rdev;
-	struct md_rdev  __rcu *replacement;
+	struct md_rdev	*rdev;
+	struct md_rdev	*replacement;
 	struct page	*extra_page; /* extra page to use in prexor */
 };
 
-- 
2.39.2

