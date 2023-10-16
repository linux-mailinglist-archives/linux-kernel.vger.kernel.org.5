Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841C97C9CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 03:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjJPB25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 21:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjJPB2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 21:28:43 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ABEA9;
        Sun, 15 Oct 2023 18:28:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S7zyl60qWz4f3knZ;
        Mon, 16 Oct 2023 09:28:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgB3BdXCkSxl3zBODA--.42064S8;
        Mon, 16 Oct 2023 09:28:37 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 4/6] md/raid10: remove rcu protection to access rdev from conf
Date:   Mon, 16 Oct 2023 17:24:37 +0800
Message-Id: <20231016092439.493646-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016092439.493646-1-yukuai1@huaweicloud.com>
References: <20231016092439.493646-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3BdXCkSxl3zBODA--.42064S8
X-Coremail-Antispam: 1UD129KBjvAXoWfZrWxtr4DAw4DAr13trWxXrb_yoW8tr17Co
        Z5JwnxKw1fAr9Yq3y7JF1ftrsrua45Aw1fuw15GrZ8CFWqgw4FvwsxGr4rZa4YqF1SqFyU
        Xr9rXw4vqFsxA3yxn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
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

And these will cover all the scenarios in raid10.

This patch also cleanup the code to handle the case that replacement
replace rdev while IO is still inflight.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid10.c | 210 ++++++++++++--------------------------------
 1 file changed, 57 insertions(+), 153 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 33ab00323cae..806a7fe2f74a 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -743,7 +743,6 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 	struct geom *geo = &conf->geo;
 
 	raid10_find_phys(conf, r10_bio);
-	rcu_read_lock();
 	best_dist_slot = -1;
 	min_pending = UINT_MAX;
 	best_dist_rdev = NULL;
@@ -775,18 +774,11 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 		if (r10_bio->devs[slot].bio == IO_BLOCKED)
 			continue;
 		disk = r10_bio->devs[slot].devnum;
-		rdev = rcu_dereference(conf->mirrors[disk].replacement);
+		rdev = conf->mirrors[disk].replacement;
 		if (rdev == NULL || test_bit(Faulty, &rdev->flags) ||
 		    r10_bio->devs[slot].addr + sectors >
-		    rdev->recovery_offset) {
-			/*
-			 * Read replacement first to prevent reading both rdev
-			 * and replacement as NULL during replacement replace
-			 * rdev.
-			 */
-			smp_mb();
-			rdev = rcu_dereference(conf->mirrors[disk].rdev);
-		}
+		    rdev->recovery_offset)
+			rdev = conf->mirrors[disk].rdev;
 		if (rdev == NULL ||
 		    test_bit(Faulty, &rdev->flags))
 			continue;
@@ -876,7 +868,6 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 		r10_bio->read_slot = slot;
 	} else
 		rdev = NULL;
-	rcu_read_unlock();
 	*max_sectors = best_good_sectors;
 
 	return rdev;
@@ -1198,9 +1189,8 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 		 */
 		gfp = GFP_NOIO | __GFP_HIGH;
 
-		rcu_read_lock();
 		disk = r10_bio->devs[slot].devnum;
-		err_rdev = rcu_dereference(conf->mirrors[disk].rdev);
+		err_rdev = conf->mirrors[disk].rdev;
 		if (err_rdev)
 			snprintf(b, sizeof(b), "%pg", err_rdev->bdev);
 		else {
@@ -1208,7 +1198,6 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 			/* This never gets dereferenced */
 			err_rdev = r10_bio->devs[slot].rdev;
 		}
-		rcu_read_unlock();
 	}
 
 	if (!regular_request_wait(mddev, conf, bio, r10_bio->sectors))
@@ -1279,15 +1268,8 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 	int devnum = r10_bio->devs[n_copy].devnum;
 	struct bio *mbio;
 
-	if (replacement) {
-		rdev = conf->mirrors[devnum].replacement;
-		if (rdev == NULL) {
-			/* Replacement just got moved to main 'rdev' */
-			smp_mb();
-			rdev = conf->mirrors[devnum].rdev;
-		}
-	} else
-		rdev = conf->mirrors[devnum].rdev;
+	rdev = replacement ? conf->mirrors[devnum].replacement :
+			     conf->mirrors[devnum].rdev;
 
 	mbio = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO, &mddev->bio_set);
 	if (replacement)
@@ -1321,25 +1303,6 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 	}
 }
 
-static struct md_rdev *dereference_rdev_and_rrdev(struct raid10_info *mirror,
-						  struct md_rdev **prrdev)
-{
-	struct md_rdev *rdev, *rrdev;
-
-	rrdev = rcu_dereference(mirror->replacement);
-	/*
-	 * Read replacement first to prevent reading both rdev and
-	 * replacement as NULL during replacement replace rdev.
-	 */
-	smp_mb();
-	rdev = rcu_dereference(mirror->rdev);
-	if (rdev == rrdev)
-		rrdev = NULL;
-
-	*prrdev = rrdev;
-	return rdev;
-}
-
 static void wait_blocked_dev(struct mddev *mddev, struct r10bio *r10_bio)
 {
 	int i;
@@ -1348,11 +1311,11 @@ static void wait_blocked_dev(struct mddev *mddev, struct r10bio *r10_bio)
 
 retry_wait:
 	blocked_rdev = NULL;
-	rcu_read_lock();
 	for (i = 0; i < conf->copies; i++) {
 		struct md_rdev *rdev, *rrdev;
 
-		rdev = dereference_rdev_and_rrdev(&conf->mirrors[i], &rrdev);
+		rdev = conf->mirrors[i].rdev;
+		rrdev = conf->mirrors[i].replacement;
 		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
 			atomic_inc(&rdev->nr_pending);
 			blocked_rdev = rdev;
@@ -1391,7 +1354,6 @@ static void wait_blocked_dev(struct mddev *mddev, struct r10bio *r10_bio)
 			}
 		}
 	}
-	rcu_read_unlock();
 
 	if (unlikely(blocked_rdev)) {
 		/* Have to wait for this device to get unblocked, then retry */
@@ -1474,14 +1436,14 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 
 	wait_blocked_dev(mddev, r10_bio);
 
-	rcu_read_lock();
 	max_sectors = r10_bio->sectors;
 
 	for (i = 0;  i < conf->copies; i++) {
 		int d = r10_bio->devs[i].devnum;
 		struct md_rdev *rdev, *rrdev;
 
-		rdev = dereference_rdev_and_rrdev(&conf->mirrors[d], &rrdev);
+		rdev = conf->mirrors[d].rdev;
+		rrdev = conf->mirrors[d].replacement;
 		if (rdev && (test_bit(Faulty, &rdev->flags)))
 			rdev = NULL;
 		if (rrdev && (test_bit(Faulty, &rrdev->flags)))
@@ -1535,7 +1497,6 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 			atomic_inc(&rrdev->nr_pending);
 		}
 	}
-	rcu_read_unlock();
 
 	if (max_sectors < r10_bio->sectors)
 		r10_bio->sectors = max_sectors;
@@ -1625,17 +1586,8 @@ static void raid10_end_discard_request(struct bio *bio)
 		set_bit(R10BIO_Uptodate, &r10_bio->state);
 
 	dev = find_bio_disk(conf, r10_bio, bio, &slot, &repl);
-	if (repl)
-		rdev = conf->mirrors[dev].replacement;
-	if (!rdev) {
-		/*
-		 * raid10_remove_disk uses smp_mb to make sure rdev is set to
-		 * replacement before setting replacement to NULL. It can read
-		 * rdev first without barrier protect even replacement is NULL
-		 */
-		smp_rmb();
-		rdev = conf->mirrors[dev].rdev;
-	}
+	rdev = repl ? conf->mirrors[dev].replacement :
+		      conf->mirrors[dev].rdev;
 
 	raid_end_discard_bio(r10_bio);
 	rdev_dec_pending(rdev, conf->mddev);
@@ -1785,11 +1737,11 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 	 * inc refcount on their rdev.  Record them by setting
 	 * bios[x] to bio
 	 */
-	rcu_read_lock();
 	for (disk = 0; disk < geo->raid_disks; disk++) {
 		struct md_rdev *rdev, *rrdev;
 
-		rdev = dereference_rdev_and_rrdev(&conf->mirrors[disk], &rrdev);
+		rdev = conf->mirrors[disk].rdev;
+		rrdev = conf->mirrors[disk].replacement;
 		r10_bio->devs[disk].bio = NULL;
 		r10_bio->devs[disk].repl_bio = NULL;
 
@@ -1809,7 +1761,6 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 			atomic_inc(&rrdev->nr_pending);
 		}
 	}
-	rcu_read_unlock();
 
 	atomic_set(&r10_bio->remaining, 1);
 	for (disk = 0; disk < geo->raid_disks; disk++) {
@@ -1939,6 +1890,8 @@ static void raid10_status(struct seq_file *seq, struct mddev *mddev)
 	struct r10conf *conf = mddev->private;
 	int i;
 
+	lockdep_assert_held(&mddev->lock);
+
 	if (conf->geo.near_copies < conf->geo.raid_disks)
 		seq_printf(seq, " %dK chunks", mddev->chunk_sectors / 2);
 	if (conf->geo.near_copies > 1)
@@ -1953,12 +1906,11 @@ static void raid10_status(struct seq_file *seq, struct mddev *mddev)
 	}
 	seq_printf(seq, " [%d/%d] [", conf->geo.raid_disks,
 					conf->geo.raid_disks - mddev->degraded);
-	rcu_read_lock();
 	for (i = 0; i < conf->geo.raid_disks; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
+		struct md_rdev *rdev = READ_ONCE(conf->mirrors[i].rdev);
+
 		seq_printf(seq, "%s", rdev && test_bit(In_sync, &rdev->flags) ? "U" : "_");
 	}
-	rcu_read_unlock();
 	seq_printf(seq, "]");
 }
 
@@ -1980,7 +1932,6 @@ static int _enough(struct r10conf *conf, int previous, int ignore)
 		ncopies = conf->geo.near_copies;
 	}
 
-	rcu_read_lock();
 	do {
 		int n = conf->copies;
 		int cnt = 0;
@@ -1988,7 +1939,7 @@ static int _enough(struct r10conf *conf, int previous, int ignore)
 		while (n--) {
 			struct md_rdev *rdev;
 			if (this != ignore &&
-			    (rdev = rcu_dereference(conf->mirrors[this].rdev)) &&
+			    (rdev = conf->mirrors[this].rdev) &&
 			    test_bit(In_sync, &rdev->flags))
 				cnt++;
 			this = (this+1) % disks;
@@ -1999,7 +1950,6 @@ static int _enough(struct r10conf *conf, int previous, int ignore)
 	} while (first != 0);
 	has_enough = 1;
 out:
-	rcu_read_unlock();
 	return has_enough;
 }
 
@@ -2164,7 +2114,7 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		err = 0;
 		if (rdev->saved_raid_disk != mirror)
 			conf->fullsync = 1;
-		rcu_assign_pointer(p->rdev, rdev);
+		WRITE_ONCE(p->rdev, rdev);
 		break;
 	}
 
@@ -2178,7 +2128,7 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 			disk_stack_limits(mddev->gendisk, rdev->bdev,
 					  rdev->data_offset << 9);
 		conf->fullsync = 1;
-		rcu_assign_pointer(p->replacement, rdev);
+		WRITE_ONCE(p->replacement, rdev);
 	}
 
 	return err;
@@ -2218,15 +2168,12 @@ static int raid10_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 		err = -EBUSY;
 		goto abort;
 	}
-	*rdevp = NULL;
+	WRITE_ONCE(*rdevp, NULL);
 	if (p->replacement) {
 		/* We must have just cleared 'rdev' */
-		p->rdev = p->replacement;
+		WRITE_ONCE(p->rdev, p->replacement);
 		clear_bit(Replacement, &p->replacement->flags);
-		smp_mb(); /* Make sure other CPUs may see both as identical
-			   * but will never see neither -- if they are careful.
-			   */
-		p->replacement = NULL;
+		WRITE_ONCE(p->replacement, NULL);
 	}
 
 	clear_bit(WantReplacement, &rdev->flags);
@@ -2725,20 +2672,18 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 		if (s > (PAGE_SIZE>>9))
 			s = PAGE_SIZE >> 9;
 
-		rcu_read_lock();
 		do {
 			sector_t first_bad;
 			int bad_sectors;
 
 			d = r10_bio->devs[sl].devnum;
-			rdev = rcu_dereference(conf->mirrors[d].rdev);
+			rdev = conf->mirrors[d].rdev;
 			if (rdev &&
 			    test_bit(In_sync, &rdev->flags) &&
 			    !test_bit(Faulty, &rdev->flags) &&
 			    is_badblock(rdev, r10_bio->devs[sl].addr + sect, s,
 					&first_bad, &bad_sectors) == 0) {
 				atomic_inc(&rdev->nr_pending);
-				rcu_read_unlock();
 				success = sync_page_io(rdev,
 						       r10_bio->devs[sl].addr +
 						       sect,
@@ -2746,7 +2691,6 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 						       conf->tmppage,
 						       REQ_OP_READ, false);
 				rdev_dec_pending(rdev, mddev);
-				rcu_read_lock();
 				if (success)
 					break;
 			}
@@ -2754,7 +2698,6 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 			if (sl == conf->copies)
 				sl = 0;
 		} while (sl != slot);
-		rcu_read_unlock();
 
 		if (!success) {
 			/* Cannot read from anywhere, just mark the block
@@ -2778,20 +2721,18 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 
 		start = sl;
 		/* write it back and re-read */
-		rcu_read_lock();
 		while (sl != slot) {
 			if (sl==0)
 				sl = conf->copies;
 			sl--;
 			d = r10_bio->devs[sl].devnum;
-			rdev = rcu_dereference(conf->mirrors[d].rdev);
+			rdev = conf->mirrors[d].rdev;
 			if (!rdev ||
 			    test_bit(Faulty, &rdev->flags) ||
 			    !test_bit(In_sync, &rdev->flags))
 				continue;
 
 			atomic_inc(&rdev->nr_pending);
-			rcu_read_unlock();
 			if (r10_sync_page_io(rdev,
 					     r10_bio->devs[sl].addr +
 					     sect,
@@ -2810,7 +2751,6 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 					  rdev->bdev);
 			}
 			rdev_dec_pending(rdev, mddev);
-			rcu_read_lock();
 		}
 		sl = start;
 		while (sl != slot) {
@@ -2818,14 +2758,13 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 				sl = conf->copies;
 			sl--;
 			d = r10_bio->devs[sl].devnum;
-			rdev = rcu_dereference(conf->mirrors[d].rdev);
+			rdev = conf->mirrors[d].rdev;
 			if (!rdev ||
 			    test_bit(Faulty, &rdev->flags) ||
 			    !test_bit(In_sync, &rdev->flags))
 				continue;
 
 			atomic_inc(&rdev->nr_pending);
-			rcu_read_unlock();
 			switch (r10_sync_page_io(rdev,
 					     r10_bio->devs[sl].addr +
 					     sect,
@@ -2853,9 +2792,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 			}
 
 			rdev_dec_pending(rdev, mddev);
-			rcu_read_lock();
 		}
-		rcu_read_unlock();
 
 		sectors -= s;
 		sect += s;
@@ -3329,14 +3266,13 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				/* Completed a full sync so the replacements
 				 * are now fully recovered.
 				 */
-				rcu_read_lock();
 				for (i = 0; i < conf->geo.raid_disks; i++) {
 					struct md_rdev *rdev =
-						rcu_dereference(conf->mirrors[i].replacement);
+						conf->mirrors[i].replacement;
+
 					if (rdev)
 						rdev->recovery_offset = MaxSector;
 				}
-				rcu_read_unlock();
 			}
 			conf->fullsync = 0;
 		}
@@ -3417,9 +3353,8 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			struct raid10_info *mirror = &conf->mirrors[i];
 			struct md_rdev *mrdev, *mreplace;
 
-			rcu_read_lock();
-			mrdev = rcu_dereference(mirror->rdev);
-			mreplace = rcu_dereference(mirror->replacement);
+			mrdev = mirror->rdev;
+			mreplace = mirror->replacement;
 
 			if (mrdev && (test_bit(Faulty, &mrdev->flags) ||
 			    test_bit(In_sync, &mrdev->flags)))
@@ -3427,22 +3362,18 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			if (mreplace && test_bit(Faulty, &mreplace->flags))
 				mreplace = NULL;
 
-			if (!mrdev && !mreplace) {
-				rcu_read_unlock();
+			if (!mrdev && !mreplace)
 				continue;
-			}
 
 			still_degraded = 0;
 			/* want to reconstruct this device */
 			rb2 = r10_bio;
 			sect = raid10_find_virt(conf, sector_nr, i);
-			if (sect >= mddev->resync_max_sectors) {
+			if (sect >= mddev->resync_max_sectors)
 				/* last stripe is not complete - don't
 				 * try to recover this sector.
 				 */
-				rcu_read_unlock();
 				continue;
-			}
 			/* Unless we are doing a full sync, or a replacement
 			 * we only need to recover the block if it is set in
 			 * the bitmap
@@ -3458,14 +3389,12 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				 * that there will never be anything to do here
 				 */
 				chunks_skipped = -1;
-				rcu_read_unlock();
 				continue;
 			}
 			if (mrdev)
 				atomic_inc(&mrdev->nr_pending);
 			if (mreplace)
 				atomic_inc(&mreplace->nr_pending);
-			rcu_read_unlock();
 
 			r10_bio = raid10_alloc_init_r10buf(conf);
 			r10_bio->state = 0;
@@ -3484,10 +3413,9 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			/* Need to check if the array will still be
 			 * degraded
 			 */
-			rcu_read_lock();
 			for (j = 0; j < conf->geo.raid_disks; j++) {
-				struct md_rdev *rdev = rcu_dereference(
-					conf->mirrors[j].rdev);
+				struct md_rdev *rdev = conf->mirrors[j].rdev;
+
 				if (rdev == NULL || test_bit(Faulty, &rdev->flags)) {
 					still_degraded = 1;
 					break;
@@ -3502,8 +3430,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				int k;
 				int d = r10_bio->devs[j].devnum;
 				sector_t from_addr, to_addr;
-				struct md_rdev *rdev =
-					rcu_dereference(conf->mirrors[d].rdev);
+				struct md_rdev *rdev = conf->mirrors[d].rdev;
 				sector_t sector, first_bad;
 				int bad_sectors;
 				if (!rdev ||
@@ -3582,7 +3509,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				atomic_inc(&r10_bio->remaining);
 				break;
 			}
-			rcu_read_unlock();
 			if (j == conf->copies) {
 				/* Cannot recover, so abort the recovery or
 				 * record a bad block */
@@ -3709,12 +3635,10 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 
 			bio = r10_bio->devs[i].bio;
 			bio->bi_status = BLK_STS_IOERR;
-			rcu_read_lock();
-			rdev = rcu_dereference(conf->mirrors[d].rdev);
-			if (rdev == NULL || test_bit(Faulty, &rdev->flags)) {
-				rcu_read_unlock();
+			rdev = conf->mirrors[d].rdev;
+			if (rdev == NULL || test_bit(Faulty, &rdev->flags))
 				continue;
-			}
+
 			sector = r10_bio->devs[i].addr;
 			if (is_badblock(rdev, sector, max_sync,
 					&first_bad, &bad_sectors)) {
@@ -3724,7 +3648,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 					bad_sectors -= (sector - first_bad);
 					if (max_sync > bad_sectors)
 						max_sync = bad_sectors;
-					rcu_read_unlock();
 					continue;
 				}
 			}
@@ -3740,11 +3663,10 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			bio_set_dev(bio, rdev->bdev);
 			count++;
 
-			rdev = rcu_dereference(conf->mirrors[d].replacement);
-			if (rdev == NULL || test_bit(Faulty, &rdev->flags)) {
-				rcu_read_unlock();
+			rdev = conf->mirrors[d].replacement;
+			if (rdev == NULL || test_bit(Faulty, &rdev->flags))
 				continue;
-			}
+
 			atomic_inc(&rdev->nr_pending);
 
 			/* Need to set up for writing to the replacement */
@@ -3761,7 +3683,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			bio->bi_iter.bi_sector = sector + rdev->data_offset;
 			bio_set_dev(bio, rdev->bdev);
 			count++;
-			rcu_read_unlock();
 		}
 
 		if (count < 2) {
@@ -4471,11 +4392,11 @@ static int calc_degraded(struct r10conf *conf)
 	int degraded, degraded2;
 	int i;
 
-	rcu_read_lock();
 	degraded = 0;
 	/* 'prev' section first */
 	for (i = 0; i < conf->prev.raid_disks; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
+		struct md_rdev *rdev = conf->mirrors[i].rdev;
+
 		if (!rdev || test_bit(Faulty, &rdev->flags))
 			degraded++;
 		else if (!test_bit(In_sync, &rdev->flags))
@@ -4485,13 +4406,12 @@ static int calc_degraded(struct r10conf *conf)
 			 */
 			degraded++;
 	}
-	rcu_read_unlock();
 	if (conf->geo.raid_disks == conf->prev.raid_disks)
 		return degraded;
-	rcu_read_lock();
 	degraded2 = 0;
 	for (i = 0; i < conf->geo.raid_disks; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
+		struct md_rdev *rdev = conf->mirrors[i].rdev;
+
 		if (!rdev || test_bit(Faulty, &rdev->flags))
 			degraded2++;
 		else if (!test_bit(In_sync, &rdev->flags)) {
@@ -4504,7 +4424,6 @@ static int calc_degraded(struct r10conf *conf)
 				degraded2++;
 		}
 	}
-	rcu_read_unlock();
 	if (degraded2 > degraded)
 		return degraded2;
 	return degraded;
@@ -4936,16 +4855,15 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 	blist = read_bio;
 	read_bio->bi_next = NULL;
 
-	rcu_read_lock();
 	for (s = 0; s < conf->copies*2; s++) {
 		struct bio *b;
 		int d = r10_bio->devs[s/2].devnum;
 		struct md_rdev *rdev2;
 		if (s&1) {
-			rdev2 = rcu_dereference(conf->mirrors[d].replacement);
+			rdev2 = conf->mirrors[d].replacement;
 			b = r10_bio->devs[s/2].repl_bio;
 		} else {
-			rdev2 = rcu_dereference(conf->mirrors[d].rdev);
+			rdev2 = conf->mirrors[d].rdev;
 			b = r10_bio->devs[s/2].bio;
 		}
 		if (!rdev2 || test_bit(Faulty, &rdev2->flags))
@@ -4979,7 +4897,6 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 		sector_nr += len >> 9;
 		nr_sectors += len >> 9;
 	}
-	rcu_read_unlock();
 	r10_bio->sectors = nr_sectors;
 
 	/* Now submit the read */
@@ -5032,20 +4949,17 @@ static void reshape_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 		struct bio *b;
 		int d = r10_bio->devs[s/2].devnum;
 		struct md_rdev *rdev;
-		rcu_read_lock();
 		if (s&1) {
-			rdev = rcu_dereference(conf->mirrors[d].replacement);
+			rdev = conf->mirrors[d].replacement;
 			b = r10_bio->devs[s/2].repl_bio;
 		} else {
-			rdev = rcu_dereference(conf->mirrors[d].rdev);
+			rdev = conf->mirrors[d].rdev;
 			b = r10_bio->devs[s/2].bio;
 		}
-		if (!rdev || test_bit(Faulty, &rdev->flags)) {
-			rcu_read_unlock();
+		if (!rdev || test_bit(Faulty, &rdev->flags))
 			continue;
-		}
+
 		atomic_inc(&rdev->nr_pending);
-		rcu_read_unlock();
 		md_sync_acct_bio(b, r10_bio->sectors);
 		atomic_inc(&r10_bio->remaining);
 		b->bi_next = NULL;
@@ -5116,10 +5030,9 @@ static int handle_reshape_read_error(struct mddev *mddev,
 		if (s > (PAGE_SIZE >> 9))
 			s = PAGE_SIZE >> 9;
 
-		rcu_read_lock();
 		while (!success) {
 			int d = r10b->devs[slot].devnum;
-			struct md_rdev *rdev = rcu_dereference(conf->mirrors[d].rdev);
+			struct md_rdev *rdev = conf->mirrors[d].rdev;
 			sector_t addr;
 			if (rdev == NULL ||
 			    test_bit(Faulty, &rdev->flags) ||
@@ -5128,14 +5041,12 @@ static int handle_reshape_read_error(struct mddev *mddev,
 
 			addr = r10b->devs[slot].addr + idx * PAGE_SIZE;
 			atomic_inc(&rdev->nr_pending);
-			rcu_read_unlock();
 			success = sync_page_io(rdev,
 					       addr,
 					       s << 9,
 					       pages[idx],
 					       REQ_OP_READ, false);
 			rdev_dec_pending(rdev, mddev);
-			rcu_read_lock();
 			if (success)
 				break;
 		failed:
@@ -5145,7 +5056,6 @@ static int handle_reshape_read_error(struct mddev *mddev,
 			if (slot == first_slot)
 				break;
 		}
-		rcu_read_unlock();
 		if (!success) {
 			/* couldn't read this block, must give up */
 			set_bit(MD_RECOVERY_INTR,
@@ -5171,12 +5081,8 @@ static void end_reshape_write(struct bio *bio)
 	struct md_rdev *rdev = NULL;
 
 	d = find_bio_disk(conf, r10_bio, bio, &slot, &repl);
-	if (repl)
-		rdev = conf->mirrors[d].replacement;
-	if (!rdev) {
-		smp_mb();
-		rdev = conf->mirrors[d].rdev;
-	}
+	rdev = repl ? conf->mirrors[d].replacement :
+		      conf->mirrors[d].rdev;
 
 	if (bio->bi_status) {
 		/* FIXME should record badblock */
@@ -5211,18 +5117,16 @@ static void raid10_finish_reshape(struct mddev *mddev)
 		mddev->resync_max_sectors = mddev->array_sectors;
 	} else {
 		int d;
-		rcu_read_lock();
 		for (d = conf->geo.raid_disks ;
 		     d < conf->geo.raid_disks - mddev->delta_disks;
 		     d++) {
-			struct md_rdev *rdev = rcu_dereference(conf->mirrors[d].rdev);
+			struct md_rdev *rdev = conf->mirrors[d].rdev;
 			if (rdev)
 				clear_bit(In_sync, &rdev->flags);
-			rdev = rcu_dereference(conf->mirrors[d].replacement);
+			rdev = conf->mirrors[d].replacement;
 			if (rdev)
 				clear_bit(In_sync, &rdev->flags);
 		}
-		rcu_read_unlock();
 	}
 	mddev->layout = mddev->new_layout;
 	mddev->chunk_sectors = 1 << conf->geo.chunk_shift;
-- 
2.39.2

