Return-Path: <linux-kernel+bounces-115348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38878893AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F641F2F446
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DB77F7D7;
	Mon, 25 Mar 2024 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxTZn1aN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB605823C3;
	Sun, 24 Mar 2024 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320553; cv=none; b=WG9FbSDr2Jo9H3zEslUXjrmH5iWwsrNHLWODrmYn1yQsumZaxfNx8mGMq0/h5JJNp7z9GdbsovqJSvY+hPrwpPw22XYYyE69D+FHtuPxi7qmDLDWdOtV+X8OkK50injOU5TzaZxOKb9uS946QjkaPZzZs+fQJD8afZnGJ7y1sUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320553; c=relaxed/simple;
	bh=1+ikIWtWHRXR0kk5lqirv4izK6JE6ku88jJ6P99LoZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rft56q9AfHT1SkPoPt1SP4D1sRFCariFKQGIfS65X+W6MeIWHtokOOPUkPgrm4fzCixJNdeiUtoG4bFllsZlab3VhxKyk0P3kUnIG/QDxuuRrPEpUi8ylnvnzD6p+MPEizBioSe3IyXEgEPgHg6Pomn8ZVHTHrRzbp3zqQ9C6Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxTZn1aN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E955FC433F1;
	Sun, 24 Mar 2024 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320552;
	bh=1+ikIWtWHRXR0kk5lqirv4izK6JE6ku88jJ6P99LoZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxTZn1aNEZOUEOw3EQOJE7IUgZLcIR16eFwfIcSzVLiKotZpgfe68DC3smD/PMQR0
	 xeapOTFehevEibj7K5DgwguttWRs/naz6b5JP9t+387TomsC2L1wmWbj9s5Z+1LKin
	 y6IY3YP+GkQs4bWrQ70ohyUQRrIL15f85sb/U6CQXiPs2ARKcw28ZdwZF0SpRo0K8h
	 TeC9dJJzdIuWhn53NrfbNJ8m6Umrv9nwlKQggeLvIWmmiEY6NzIK3PahmyBTr8IvA0
	 V6nGI9r1Mb8RcXCS72I8HXbaEf0FV5Sdx4qCkHEjn14W+vqJQtud+M8ggoG+vwmWCL
	 jUl7NJkPAOyGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 113/713] md/raid1: remove rcu protection to access rdev from conf
Date: Sun, 24 Mar 2024 18:37:19 -0400
Message-ID: <20240324224720.1345309-114-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 2d32777d60de81aa020a2431567020af26564c71 ]

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

And these will cover all the scenarios in raid1.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20231125081604.3939938-4-yukuai1@huaweicloud.com
Stable-dep-of: 257ac239ffcf ("md/raid1: fix choose next idle in read_balance()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 62 +++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 6bd42ccbea9c4..71bd372c14e2c 100644
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
 
@@ -1691,16 +1686,15 @@ static void print_conf(struct r1conf *conf)
 	pr_debug(" --- wd:%d rd:%d\n", conf->raid_disks - conf->mddev->degraded,
 		 conf->raid_disks);
 
-	rcu_read_lock();
+	lockdep_assert_held(&conf->mddev->reconfig_mutex);
 	for (i = 0; i < conf->raid_disks; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
+		struct md_rdev *rdev = conf->mirrors[i].rdev;
 		if (rdev)
 			pr_debug(" disk %d, wo:%d, o:%d, dev:%pg\n",
 				 i, !test_bit(In_sync, &rdev->flags),
 				 !test_bit(Faulty, &rdev->flags),
 				 rdev->bdev);
 	}
-	rcu_read_unlock();
 }
 
 static void close_sync(struct r1conf *conf)
@@ -1810,7 +1804,7 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 			 */
 			if (rdev->saved_raid_disk < 0)
 				conf->fullsync = 1;
-			rcu_assign_pointer(p->rdev, rdev);
+			WRITE_ONCE(p->rdev, rdev);
 			break;
 		}
 		if (test_bit(WantReplacement, &p->rdev->flags) &&
@@ -1826,7 +1820,7 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		rdev->raid_disk = repl_slot;
 		err = 0;
 		conf->fullsync = 1;
-		rcu_assign_pointer(p[conf->raid_disks].rdev, rdev);
+		WRITE_ONCE(p[conf->raid_disks].rdev, rdev);
 	}
 
 	print_conf(conf);
@@ -1862,7 +1856,7 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 			err = -EBUSY;
 			goto abort;
 		}
-		p->rdev = NULL;
+		WRITE_ONCE(p->rdev, NULL);
 		if (conf->mirrors[conf->raid_disks + number].rdev) {
 			/* We just removed a device that is being replaced.
 			 * Move down the replacement.  We drain all IO before
@@ -1883,7 +1877,7 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 				goto abort;
 			}
 			clear_bit(Replacement, &repl->flags);
-			p->rdev = repl;
+			WRITE_ONCE(p->rdev, repl);
 			conf->mirrors[conf->raid_disks + number].rdev = NULL;
 			unfreeze_array(conf);
 		}
@@ -2281,8 +2275,7 @@ static void fix_read_error(struct r1conf *conf, int read_disk,
 			sector_t first_bad;
 			int bad_sectors;
 
-			rcu_read_lock();
-			rdev = rcu_dereference(conf->mirrors[d].rdev);
+			rdev = conf->mirrors[d].rdev;
 			if (rdev &&
 			    (test_bit(In_sync, &rdev->flags) ||
 			     (!test_bit(Faulty, &rdev->flags) &&
@@ -2290,15 +2283,14 @@ static void fix_read_error(struct r1conf *conf, int read_disk,
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
@@ -2317,29 +2309,24 @@ static void fix_read_error(struct r1conf *conf, int read_disk,
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
 						conf->tmppage, REQ_OP_WRITE);
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
 						conf->tmppage, REQ_OP_READ)) {
 					atomic_add(s, &rdev->corrected_errors);
@@ -2350,8 +2337,7 @@ static void fix_read_error(struct r1conf *conf, int read_disk,
 						rdev->bdev);
 				}
 				rdev_dec_pending(rdev, mddev);
-			} else
-				rcu_read_unlock();
+			}
 		}
 		sectors -= s;
 		sect += s;
@@ -2732,7 +2718,6 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 
 	r1_bio = raid1_alloc_init_r1buf(conf);
 
-	rcu_read_lock();
 	/*
 	 * If we get a correctably read error during resync or recovery,
 	 * we might want to read from a different device.  So we
@@ -2753,7 +2738,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 		struct md_rdev *rdev;
 		bio = r1_bio->bios[i];
 
-		rdev = rcu_dereference(conf->mirrors[i].rdev);
+		rdev = conf->mirrors[i].rdev;
 		if (rdev == NULL ||
 		    test_bit(Faulty, &rdev->flags)) {
 			if (i < conf->raid_disks)
@@ -2811,7 +2796,6 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 				bio->bi_opf |= MD_FAILFAST;
 		}
 	}
-	rcu_read_unlock();
 	if (disk < 0)
 		disk = wonly;
 	r1_bio->read_disk = disk;
-- 
2.43.0


