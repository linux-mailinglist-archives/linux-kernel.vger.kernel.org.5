Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5137C9CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 03:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjJPB3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 21:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjJPB2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 21:28:46 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49F1D6;
        Sun, 15 Oct 2023 18:28:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S7zyq742tz4f3kp9;
        Mon, 16 Oct 2023 09:28:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgB3BdXCkSxl3zBODA--.42064S9;
        Mon, 16 Oct 2023 09:28:37 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 5/6] md/raid5: remove rcu protection to access rdev from conf
Date:   Mon, 16 Oct 2023 17:24:38 +0800
Message-Id: <20231016092439.493646-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016092439.493646-1-yukuai1@huaweicloud.com>
References: <20231016092439.493646-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3BdXCkSxl3zBODA--.42064S9
X-Coremail-Antispam: 1UD129KBjvAXoWfCFW8Aryxtw4kZr1DJFy3CFg_yoW8tFWUZo
        Z7Zwsxta1xJry0g3y7trn3tr47uay8Aw1fCr15WrZ5Za92gw4F9w13Cr45XF1UXF1fKFy7
        Xr93Xw4vqF15CrZ3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOb7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82xGYIkIc2
        x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Y
        j41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwV
        C0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0
        Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64
        xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j
        6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI
        8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
        UUUUU
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

It's safe to accees rdev from conf:
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
index 209a6a9d4146..36ca6db37153 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -692,12 +692,12 @@ int raid5_calc_degraded(struct r5conf *conf)
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
@@ -715,15 +715,14 @@ int raid5_calc_degraded(struct r5conf *conf)
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
@@ -737,7 +736,6 @@ int raid5_calc_degraded(struct r5conf *conf)
 			if (conf->raid_disks <= conf->previous_raid_disks)
 				degraded2++;
 	}
-	rcu_read_unlock();
 	if (degraded2 > degraded)
 		return degraded2;
 	return degraded;
@@ -1175,14 +1173,8 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
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
@@ -1203,7 +1195,6 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 			rrdev = NULL;
 		if (rrdev)
 			atomic_inc(&rrdev->nr_pending);
-		rcu_read_unlock();
 
 		/* We have already checked bad blocks for reads.  Now
 		 * need to check for writes.  We never accept write errors
@@ -2722,28 +2713,6 @@ static void shrink_stripes(struct r5conf *conf)
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
@@ -2769,9 +2738,9 @@ static void raid5_end_read_request(struct bio * bi)
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
@@ -2884,11 +2853,11 @@ static void raid5_end_write_request(struct bio *bi)
 
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
@@ -2896,7 +2865,7 @@ static void raid5_end_write_request(struct bio *bi)
 				 * replaced it.  rdev is not removed
 				 * until all requests are finished.
 				 */
-				rdev = rdev_pend_deref(conf->disks[i].rdev);
+				rdev = conf->disks[i].rdev;
 			break;
 		}
 	}
@@ -3658,15 +3627,13 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
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
@@ -3784,16 +3751,17 @@ handle_failed_sync(struct r5conf *conf, struct stripe_head *sh,
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
@@ -3801,7 +3769,6 @@ handle_failed_sync(struct r5conf *conf, struct stripe_head *sh,
 						   RAID5_STRIPE_SECTORS(conf), 0))
 				abort = 1;
 		}
-		rcu_read_unlock();
 		if (abort)
 			conf->recovery_disabled =
 				conf->mddev->recovery_disabled;
@@ -3814,15 +3781,13 @@ static int want_replace(struct stripe_head *sh, int disk_idx)
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
 
@@ -4699,7 +4664,6 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 	s->log_failed = r5l_log_disk_error(conf);
 
 	/* Now to look around and see what can be done */
-	rcu_read_lock();
 	for (i=disks; i--; ) {
 		struct md_rdev *rdev;
 		sector_t first_bad;
@@ -4744,7 +4708,7 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 		/* Prefer to use the replacement for reads, but only
 		 * if it is recovered enough and has no bad blocks.
 		 */
-		rdev = rcu_dereference(conf->disks[i].replacement);
+		rdev = conf->disks[i].replacement;
 		if (rdev && !test_bit(Faulty, &rdev->flags) &&
 		    rdev->recovery_offset >= sh->sector + RAID5_STRIPE_SECTORS(conf) &&
 		    !is_badblock(rdev, sh->sector, RAID5_STRIPE_SECTORS(conf),
@@ -4755,7 +4719,7 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 				set_bit(R5_NeedReplace, &dev->flags);
 			else
 				clear_bit(R5_NeedReplace, &dev->flags);
-			rdev = rcu_dereference(conf->disks[i].rdev);
+			rdev = conf->disks[i].rdev;
 			clear_bit(R5_ReadRepl, &dev->flags);
 		}
 		if (rdev && test_bit(Faulty, &rdev->flags))
@@ -4802,8 +4766,8 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
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
@@ -4815,8 +4779,8 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
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
@@ -4824,8 +4788,8 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
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
@@ -4846,8 +4810,7 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 			if (rdev && !test_bit(Faulty, &rdev->flags))
 				do_recovery = 1;
 			else if (!rdev) {
-				rdev = rcu_dereference(
-				    conf->disks[i].replacement);
+				rdev = conf->disks[i].replacement;
 				if (rdev && !test_bit(Faulty, &rdev->flags))
 					do_recovery = 1;
 			}
@@ -4874,7 +4837,6 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 		else
 			s->replacing = 1;
 	}
-	rcu_read_unlock();
 }
 
 /*
@@ -5331,23 +5293,23 @@ static void handle_stripe(struct stripe_head *sh)
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
@@ -5506,24 +5468,22 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
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
@@ -5567,10 +5527,6 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 				      raid_bio->bi_iter.bi_sector);
 	submit_bio_noacct(align_bio);
 	return 1;
-
-out_rcu_unlock:
-	rcu_read_unlock();
-	return 0;
 }
 
 static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
@@ -6596,14 +6552,12 @@ static inline sector_t raid5_sync_request(struct mddev *mddev, sector_t sector_n
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
 
@@ -7921,18 +7875,10 @@ static int raid5_run(struct mddev *mddev)
 
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
@@ -8113,15 +8059,16 @@ static void raid5_status(struct seq_file *seq, struct mddev *mddev)
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
 
@@ -8134,9 +8081,8 @@ static int raid5_spare_active(struct mddev *mddev)
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
@@ -8174,7 +8120,7 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	struct r5conf *conf = mddev->private;
 	int err = 0;
 	int number = rdev->raid_disk;
-	struct md_rdev __rcu **rdevp;
+	struct md_rdev **rdevp;
 	struct disk_info *p;
 	struct md_rdev *tmp;
 
@@ -8196,9 +8142,9 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
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
@@ -8218,28 +8164,24 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
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
@@ -8306,7 +8248,7 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 			rdev->raid_disk = disk;
 			if (rdev->saved_raid_disk != disk)
 				conf->fullsync = 1;
-			rcu_assign_pointer(p->rdev, rdev);
+			WRITE_ONCE(p->rdev, rdev);
 
 			err = log_modify(conf, rdev, true);
 
@@ -8315,7 +8257,7 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 	}
 	for (disk = first; disk <= last; disk++) {
 		p = conf->disks + disk;
-		tmp = rdev_mdlock_deref(mddev, p->rdev);
+		tmp = p->rdev;
 		if (test_bit(WantReplacement, &tmp->flags) &&
 		    mddev->reshape_position == MaxSector &&
 		    p->replacement == NULL) {
@@ -8324,7 +8266,7 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 			rdev->raid_disk = disk;
 			err = 0;
 			conf->fullsync = 1;
-			rcu_assign_pointer(p->replacement, rdev);
+			WRITE_ONCE(p->replacement, rdev);
 			break;
 		}
 	}
@@ -8456,7 +8398,7 @@ static int raid5_start_reshape(struct mddev *mddev)
 	if (mddev->recovery_cp < MaxSector)
 		return -EBUSY;
 	for (i = 0; i < conf->raid_disks; i++)
-		if (rdev_mdlock_deref(mddev, conf->disks[i].replacement))
+		if (conf->disks[i].replacement)
 			return -EBUSY;
 
 	rdev_for_each(rdev, mddev) {
@@ -8627,12 +8569,10 @@ static void raid5_finish_reshape(struct mddev *mddev)
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

