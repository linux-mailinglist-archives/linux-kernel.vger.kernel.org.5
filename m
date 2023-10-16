Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701207C9CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 03:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjJPB2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 21:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjJPB2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 21:28:42 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111B0D9;
        Sun, 15 Oct 2023 18:28:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S7zyq1xq2z4f3kpx;
        Mon, 16 Oct 2023 09:28:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgB3BdXCkSxl3zBODA--.42064S7;
        Mon, 16 Oct 2023 09:28:36 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 3/6] md/raid1: remove rcu protection to access rdev from conf
Date:   Mon, 16 Oct 2023 17:24:36 +0800
Message-Id: <20231016092439.493646-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016092439.493646-1-yukuai1@huaweicloud.com>
References: <20231016092439.493646-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3BdXCkSxl3zBODA--.42064S7
X-Coremail-Antispam: 1UD129KBjvJXoW3WrWrJr43Wr47Aw1DXw17GFg_yoW3Wr4kpw
        43tas7tF4DX3s0gF1DAayDG3WSyryaqFWxJryfGw4I93s3KrZxtFW8Gryaqry5CrZ8Ar15
        X3W5K398CFyxKF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRPEf5UUUUU
        =
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

And these will cover all the scenarios in raid1.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 57 +++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 4348d670439d..5c647036663d 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -609,7 +609,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	int choose_first;
 	int choose_next_idle;
 
-	rcu_read_lock();
 	/*
 	 * Check if we can balance. We can balance on the whole
 	 * device if no resync is going on, or below the resync window.
@@ -642,7 +641,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 		unsigned int pending;
 		bool nonrot;
 
-		rdev = rcu_dereference(conf->mirrors[disk].rdev);
+		rdev = conf->mirrors[disk].rdev;
 		if (r1_bio->bios[disk] == IO_BLOCKED
 		    || rdev == NULL
 		    || test_bit(Faulty, &rdev->flags))
@@ -773,7 +772,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	}
 
 	if (best_disk >= 0) {
-		rdev = rcu_dereference(conf->mirrors[best_disk].rdev);
+		rdev = conf->mirrors[best_disk].rdev;
 		if (!rdev)
 			goto retry;
 		atomic_inc(&rdev->nr_pending);
@@ -784,7 +783,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 
 		conf->mirrors[best_disk].next_seq_sect = this_sector + sectors;
 	}
-	rcu_read_unlock();
 	*max_sectors = sectors;
 
 	return best_disk;
@@ -1235,14 +1233,12 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 
 	if (r1bio_existed) {
 		/* Need to get the block device name carefully */
-		struct md_rdev *rdev;
-		rcu_read_lock();
-		rdev = rcu_dereference(conf->mirrors[r1_bio->read_disk].rdev);
+		struct md_rdev *rdev = conf->mirrors[r1_bio->read_disk].rdev;
+
 		if (rdev)
 			snprintf(b, sizeof(b), "%pg", rdev->bdev);
 		else
 			strcpy(b, "???");
-		rcu_read_unlock();
 	}
 
 	/*
@@ -1396,10 +1392,9 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 	disks = conf->raid_disks * 2;
 	blocked_rdev = NULL;
-	rcu_read_lock();
 	max_sectors = r1_bio->sectors;
 	for (i = 0;  i < disks; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
+		struct md_rdev *rdev = conf->mirrors[i].rdev;
 
 		/*
 		 * The write-behind io is only attempted on drives marked as
@@ -1465,7 +1460,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 		}
 		r1_bio->bios[i] = bio;
 	}
-	rcu_read_unlock();
 
 	if (unlikely(blocked_rdev)) {
 		/* Wait for this device to become unblocked */
@@ -1617,15 +1611,16 @@ static void raid1_status(struct seq_file *seq, struct mddev *mddev)
 	struct r1conf *conf = mddev->private;
 	int i;
 
+	lockdep_assert_held(&mddev->lock);
+
 	seq_printf(seq, " [%d/%d] [", conf->raid_disks,
 		   conf->raid_disks - mddev->degraded);
-	rcu_read_lock();
 	for (i = 0; i < conf->raid_disks; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
+		struct md_rdev *rdev = READ_ONCE(conf->mirrors[i].rdev);
+
 		seq_printf(seq, "%s",
 			   rdev && test_bit(In_sync, &rdev->flags) ? "U" : "_");
 	}
-	rcu_read_unlock();
 	seq_printf(seq, "]");
 }
 
@@ -1785,7 +1780,7 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 			 */
 			if (rdev->saved_raid_disk < 0)
 				conf->fullsync = 1;
-			rcu_assign_pointer(p->rdev, rdev);
+			WRITE_ONCE(p->rdev, rdev);
 			break;
 		}
 		if (test_bit(WantReplacement, &p->rdev->flags) &&
@@ -1801,7 +1796,7 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		rdev->raid_disk = repl_slot;
 		err = 0;
 		conf->fullsync = 1;
-		rcu_assign_pointer(p[conf->raid_disks].rdev, rdev);
+		WRITE_ONCE(p[conf->raid_disks].rdev, rdev);
 	}
 
 	return err;
@@ -1835,7 +1830,7 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 			err = -EBUSY;
 			goto abort;
 		}
-		p->rdev = NULL;
+		WRITE_ONCE(p->rdev, NULL);
 		if (conf->mirrors[conf->raid_disks + number].rdev) {
 			/* We just removed a device that is being replaced.
 			 * Move down the replacement.  We drain all IO before
@@ -1856,7 +1851,7 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 				goto abort;
 			}
 			clear_bit(Replacement, &repl->flags);
-			p->rdev = repl;
+			WRITE_ONCE(p->rdev, repl);
 			conf->mirrors[conf->raid_disks + number].rdev = NULL;
 			unfreeze_array(conf);
 		}
@@ -2253,8 +2248,7 @@ static void fix_read_error(struct r1conf *conf, int read_disk,
 			sector_t first_bad;
 			int bad_sectors;
 
-			rcu_read_lock();
-			rdev = rcu_dereference(conf->mirrors[d].rdev);
+			rdev = conf->mirrors[d].rdev;
 			if (rdev &&
 			    (test_bit(In_sync, &rdev->flags) ||
 			     (!test_bit(Faulty, &rdev->flags) &&
@@ -2262,15 +2256,14 @@ static void fix_read_error(struct r1conf *conf, int read_disk,
 			    is_badblock(rdev, sect, s,
 					&first_bad, &bad_sectors) == 0) {
 				atomic_inc(&rdev->nr_pending);
-				rcu_read_unlock();
 				if (sync_page_io(rdev, sect, s<<9,
 					 conf->tmppage, REQ_OP_READ, false))
 					success = 1;
 				rdev_dec_pending(rdev, mddev);
 				if (success)
 					break;
-			} else
-				rcu_read_unlock();
+			}
+
 			d++;
 			if (d == conf->raid_disks * 2)
 				d = 0;
@@ -2289,29 +2282,24 @@ static void fix_read_error(struct r1conf *conf, int read_disk,
 			if (d==0)
 				d = conf->raid_disks * 2;
 			d--;
-			rcu_read_lock();
-			rdev = rcu_dereference(conf->mirrors[d].rdev);
+			rdev = conf->mirrors[d].rdev;
 			if (rdev &&
 			    !test_bit(Faulty, &rdev->flags)) {
 				atomic_inc(&rdev->nr_pending);
-				rcu_read_unlock();
 				r1_sync_page_io(rdev, sect, s,
 						conf->tmppage, WRITE);
 				rdev_dec_pending(rdev, mddev);
-			} else
-				rcu_read_unlock();
+			}
 		}
 		d = start;
 		while (d != read_disk) {
 			if (d==0)
 				d = conf->raid_disks * 2;
 			d--;
-			rcu_read_lock();
-			rdev = rcu_dereference(conf->mirrors[d].rdev);
+			rdev = conf->mirrors[d].rdev;
 			if (rdev &&
 			    !test_bit(Faulty, &rdev->flags)) {
 				atomic_inc(&rdev->nr_pending);
-				rcu_read_unlock();
 				if (r1_sync_page_io(rdev, sect, s,
 						    conf->tmppage, READ)) {
 					atomic_add(s, &rdev->corrected_errors);
@@ -2322,8 +2310,7 @@ static void fix_read_error(struct r1conf *conf, int read_disk,
 						rdev->bdev);
 				}
 				rdev_dec_pending(rdev, mddev);
-			} else
-				rcu_read_unlock();
+			}
 		}
 		sectors -= s;
 		sect += s;
@@ -2704,7 +2691,6 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 
 	r1_bio = raid1_alloc_init_r1buf(conf);
 
-	rcu_read_lock();
 	/*
 	 * If we get a correctably read error during resync or recovery,
 	 * we might want to read from a different device.  So we
@@ -2725,7 +2711,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		struct md_rdev *rdev;
 		bio = r1_bio->bios[i];
 
-		rdev = rcu_dereference(conf->mirrors[i].rdev);
+		rdev = conf->mirrors[i].rdev;
 		if (rdev == NULL ||
 		    test_bit(Faulty, &rdev->flags)) {
 			if (i < conf->raid_disks)
@@ -2783,7 +2769,6 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 				bio->bi_opf |= MD_FAILFAST;
 		}
 	}
-	rcu_read_unlock();
 	if (disk < 0)
 		disk = wonly;
 	r1_bio->read_disk = disk;
-- 
2.39.2

