Return-Path: <linux-kernel+bounces-83167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4528C868FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F842283B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F39313AA44;
	Tue, 27 Feb 2024 12:09:31 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38713A250;
	Tue, 27 Feb 2024 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035770; cv=none; b=kTODbYvWC0RXUrGUWsIPF635gVjy2MKUv5pjmTloc/gSKO6lZSxWB+1UG2N9Qd9uMSKxzfZM/ykt0m/U8DuOta0oTMj1n3SHP3hbtwDyldxmM7lA63PuSY4VdyXgJLsCGo+qLh6bN6MRSYDLZawmBw0zdi7Yr7pibFmE+bZyS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035770; c=relaxed/simple;
	bh=VHPw/XIujHrrnoKg8+hTdwOfW2a8iMlT6BhNgl66NrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QuTK1FkDDia4qRcjahfKwHjeoddoF/5YTVLPTz7cirTQeHgbq/C7kq5aIJYx9ku9zAzMDbOOSDwnRxzWEqQo6HeZYpiTsHdDpUs+7UpoiYgloe0MsTZ9Z3QUdJd+rHZ17f1NrlCsNSZPu/YxHXvMyn7qE8ebpIaHgTCf3sRxnEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TkbrD65Pnz4f3m7B;
	Tue, 27 Feb 2024 20:09:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2AD561A0232;
	Tue, 27 Feb 2024 20:09:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHv0N1lpKNAFQ--.28259S5;
	Tue, 27 Feb 2024 20:09:23 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: xni@redhat.com,
	paul.e.luse@linux.intel.com,
	song@kernel.org,
	shli@fb.com,
	neilb@suse.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.9 v2 01/10] md: add a new helper rdev_has_badblock()
Date: Tue, 27 Feb 2024 20:03:18 +0800
Message-Id: <20240227120327.1432511-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227120327.1432511-1-yukuai1@huaweicloud.com>
References: <20240227120327.1432511-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RHv0N1lpKNAFQ--.28259S5
X-Coremail-Antispam: 1UD129KBjvJXoW3uFWUuFWxKFW3Jw47Cw47CFg_yoWkZw13p3
	9rJa4SyFWUJFyfWw4DJayUurnYy34fJrW7JFWxX34Iga4jkr9xKFykXryYgF98uFy3ur12
	qwnrZ3y7u397KFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
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

From: Yu Kuai <yukuai3@huawei.com>

The current api is_badblock() must pass in 'first_bad' and
'bad_sectors', however, many caller just want to know if there are
badblocks or not, and these caller must define two local variable that
will never be used.

Add a new helper rdev_has_badblock() that will only return if there are
badblocks or not, remove unnecessary local variables and replace
is_badblock() with the new helper in many places.

There are no functional changes, and the new helper will also be used
later to refactor read_balance().

Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.h     | 10 ++++++++++
 drivers/md/raid1.c  | 26 +++++++-------------------
 drivers/md/raid10.c | 45 ++++++++++++++-------------------------------
 drivers/md/raid5.c  | 35 +++++++++++++----------------------
 4 files changed, 44 insertions(+), 72 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 8d881cc59799..a49ab04ab707 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -222,6 +222,16 @@ static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
 	}
 	return 0;
 }
+
+static inline int rdev_has_badblock(struct md_rdev *rdev, sector_t s,
+				    int sectors)
+{
+	sector_t first_bad;
+	int bad_sectors;
+
+	return is_badblock(rdev, s, sectors, &first_bad, &bad_sectors);
+}
+
 extern int rdev_set_badblocks(struct md_rdev *rdev, sector_t s, int sectors,
 			      int is_new);
 extern int rdev_clear_badblocks(struct md_rdev *rdev, sector_t s, int sectors,
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 286f8b16c7bd..a145fe48b9ce 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -498,9 +498,6 @@ static void raid1_end_write_request(struct bio *bio)
 		 * to user-side. So if something waits for IO, then it
 		 * will wait for the 'master' bio.
 		 */
-		sector_t first_bad;
-		int bad_sectors;
-
 		r1_bio->bios[mirror] = NULL;
 		to_put = bio;
 		/*
@@ -516,8 +513,8 @@ static void raid1_end_write_request(struct bio *bio)
 			set_bit(R1BIO_Uptodate, &r1_bio->state);
 
 		/* Maybe we can clear some bad blocks. */
-		if (is_badblock(rdev, r1_bio->sector, r1_bio->sectors,
-				&first_bad, &bad_sectors) && !discard_error) {
+		if (rdev_has_badblock(rdev, r1_bio->sector, r1_bio->sectors) &&
+		    !discard_error) {
 			r1_bio->bios[mirror] = IO_MADE_GOOD;
 			set_bit(R1BIO_MadeGood, &r1_bio->state);
 		}
@@ -1944,8 +1941,6 @@ static void end_sync_write(struct bio *bio)
 	struct r1bio *r1_bio = get_resync_r1bio(bio);
 	struct mddev *mddev = r1_bio->mddev;
 	struct r1conf *conf = mddev->private;
-	sector_t first_bad;
-	int bad_sectors;
 	struct md_rdev *rdev = conf->mirrors[find_bio_disk(r1_bio, bio)].rdev;
 
 	if (!uptodate) {
@@ -1955,14 +1950,11 @@ static void end_sync_write(struct bio *bio)
 			set_bit(MD_RECOVERY_NEEDED, &
 				mddev->recovery);
 		set_bit(R1BIO_WriteError, &r1_bio->state);
-	} else if (is_badblock(rdev, r1_bio->sector, r1_bio->sectors,
-			       &first_bad, &bad_sectors) &&
-		   !is_badblock(conf->mirrors[r1_bio->read_disk].rdev,
-				r1_bio->sector,
-				r1_bio->sectors,
-				&first_bad, &bad_sectors)
-		)
+	} else if (rdev_has_badblock(rdev, r1_bio->sector, r1_bio->sectors) &&
+		   !rdev_has_badblock(conf->mirrors[r1_bio->read_disk].rdev,
+				      r1_bio->sector, r1_bio->sectors)) {
 		set_bit(R1BIO_MadeGood, &r1_bio->state);
+	}
 
 	put_sync_write_buf(r1_bio, uptodate);
 }
@@ -2279,16 +2271,12 @@ static void fix_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 			s = PAGE_SIZE >> 9;
 
 		do {
-			sector_t first_bad;
-			int bad_sectors;
-
 			rdev = conf->mirrors[d].rdev;
 			if (rdev &&
 			    (test_bit(In_sync, &rdev->flags) ||
 			     (!test_bit(Faulty, &rdev->flags) &&
 			      rdev->recovery_offset >= sect + s)) &&
-			    is_badblock(rdev, sect, s,
-					&first_bad, &bad_sectors) == 0) {
+			    rdev_has_badblock(rdev, sect, s) == 0) {
 				atomic_inc(&rdev->nr_pending);
 				if (sync_page_io(rdev, sect, s<<9,
 					 conf->tmppage, REQ_OP_READ, false))
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 7412066ea22c..d5a7a621f0f0 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -518,11 +518,7 @@ static void raid10_end_write_request(struct bio *bio)
 		 * The 'master' represents the composite IO operation to
 		 * user-side. So if something waits for IO, then it will
 		 * wait for the 'master' bio.
-		 */
-		sector_t first_bad;
-		int bad_sectors;
-
-		/*
+		 *
 		 * Do not set R10BIO_Uptodate if the current device is
 		 * rebuilding or Faulty. This is because we cannot use
 		 * such device for properly reading the data back (we could
@@ -535,10 +531,9 @@ static void raid10_end_write_request(struct bio *bio)
 			set_bit(R10BIO_Uptodate, &r10_bio->state);
 
 		/* Maybe we can clear some bad blocks. */
-		if (is_badblock(rdev,
-				r10_bio->devs[slot].addr,
-				r10_bio->sectors,
-				&first_bad, &bad_sectors) && !discard_error) {
+		if (rdev_has_badblock(rdev, r10_bio->devs[slot].addr,
+				      r10_bio->sectors) &&
+		    !discard_error) {
 			bio_put(bio);
 			if (repl)
 				r10_bio->devs[slot].repl_bio = IO_MADE_GOOD;
@@ -1330,10 +1325,7 @@ static void wait_blocked_dev(struct mddev *mddev, struct r10bio *r10_bio)
 		}
 
 		if (rdev && test_bit(WriteErrorSeen, &rdev->flags)) {
-			sector_t first_bad;
 			sector_t dev_sector = r10_bio->devs[i].addr;
-			int bad_sectors;
-			int is_bad;
 
 			/*
 			 * Discard request doesn't care the write result
@@ -1342,9 +1334,8 @@ static void wait_blocked_dev(struct mddev *mddev, struct r10bio *r10_bio)
 			if (!r10_bio->sectors)
 				continue;
 
-			is_bad = is_badblock(rdev, dev_sector, r10_bio->sectors,
-					     &first_bad, &bad_sectors);
-			if (is_bad < 0) {
+			if (rdev_has_badblock(rdev, dev_sector,
+					      r10_bio->sectors) < 0) {
 				/*
 				 * Mustn't write here until the bad block
 				 * is acknowledged
@@ -2290,8 +2281,6 @@ static void end_sync_write(struct bio *bio)
 	struct mddev *mddev = r10_bio->mddev;
 	struct r10conf *conf = mddev->private;
 	int d;
-	sector_t first_bad;
-	int bad_sectors;
 	int slot;
 	int repl;
 	struct md_rdev *rdev = NULL;
@@ -2312,11 +2301,10 @@ static void end_sync_write(struct bio *bio)
 					&rdev->mddev->recovery);
 			set_bit(R10BIO_WriteError, &r10_bio->state);
 		}
-	} else if (is_badblock(rdev,
-			     r10_bio->devs[slot].addr,
-			     r10_bio->sectors,
-			     &first_bad, &bad_sectors))
+	} else if (rdev_has_badblock(rdev, r10_bio->devs[slot].addr,
+				     r10_bio->sectors)) {
 		set_bit(R10BIO_MadeGood, &r10_bio->state);
+	}
 
 	rdev_dec_pending(rdev, mddev);
 
@@ -2597,11 +2585,8 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 static int r10_sync_page_io(struct md_rdev *rdev, sector_t sector,
 			    int sectors, struct page *page, enum req_op op)
 {
-	sector_t first_bad;
-	int bad_sectors;
-
-	if (is_badblock(rdev, sector, sectors, &first_bad, &bad_sectors)
-	    && (op == REQ_OP_READ || test_bit(WriteErrorSeen, &rdev->flags)))
+	if (rdev_has_badblock(rdev, sector, sectors) &&
+	    (op == REQ_OP_READ || test_bit(WriteErrorSeen, &rdev->flags)))
 		return -1;
 	if (sync_page_io(rdev, sector, sectors << 9, page, op, false))
 		/* success */
@@ -2658,16 +2643,14 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 			s = PAGE_SIZE >> 9;
 
 		do {
-			sector_t first_bad;
-			int bad_sectors;
-
 			d = r10_bio->devs[sl].devnum;
 			rdev = conf->mirrors[d].rdev;
 			if (rdev &&
 			    test_bit(In_sync, &rdev->flags) &&
 			    !test_bit(Faulty, &rdev->flags) &&
-			    is_badblock(rdev, r10_bio->devs[sl].addr + sect, s,
-					&first_bad, &bad_sectors) == 0) {
+			    rdev_has_badblock(rdev,
+					      r10_bio->devs[sl].addr + sect,
+					      s) == 0) {
 				atomic_inc(&rdev->nr_pending);
 				success = sync_page_io(rdev,
 						       r10_bio->devs[sl].addr +
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 14f2cf75abbd..9241e95ef55c 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1210,10 +1210,8 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 		 */
 		while (op_is_write(op) && rdev &&
 		       test_bit(WriteErrorSeen, &rdev->flags)) {
-			sector_t first_bad;
-			int bad_sectors;
-			int bad = is_badblock(rdev, sh->sector, RAID5_STRIPE_SECTORS(conf),
-					      &first_bad, &bad_sectors);
+			int bad = rdev_has_badblock(rdev, sh->sector,
+						    RAID5_STRIPE_SECTORS(conf));
 			if (!bad)
 				break;
 
@@ -2855,8 +2853,6 @@ static void raid5_end_write_request(struct bio *bi)
 	struct r5conf *conf = sh->raid_conf;
 	int disks = sh->disks, i;
 	struct md_rdev *rdev;
-	sector_t first_bad;
-	int bad_sectors;
 	int replacement = 0;
 
 	for (i = 0 ; i < disks; i++) {
@@ -2888,9 +2884,8 @@ static void raid5_end_write_request(struct bio *bi)
 	if (replacement) {
 		if (bi->bi_status)
 			md_error(conf->mddev, rdev);
-		else if (is_badblock(rdev, sh->sector,
-				     RAID5_STRIPE_SECTORS(conf),
-				     &first_bad, &bad_sectors))
+		else if (rdev_has_badblock(rdev, sh->sector,
+					   RAID5_STRIPE_SECTORS(conf)))
 			set_bit(R5_MadeGoodRepl, &sh->dev[i].flags);
 	} else {
 		if (bi->bi_status) {
@@ -2900,9 +2895,8 @@ static void raid5_end_write_request(struct bio *bi)
 			if (!test_and_set_bit(WantReplacement, &rdev->flags))
 				set_bit(MD_RECOVERY_NEEDED,
 					&rdev->mddev->recovery);
-		} else if (is_badblock(rdev, sh->sector,
-				       RAID5_STRIPE_SECTORS(conf),
-				       &first_bad, &bad_sectors)) {
+		} else if (rdev_has_badblock(rdev, sh->sector,
+					     RAID5_STRIPE_SECTORS(conf))) {
 			set_bit(R5_MadeGood, &sh->dev[i].flags);
 			if (test_bit(R5_ReadError, &sh->dev[i].flags))
 				/* That was a successful write so make
@@ -4674,8 +4668,6 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 	/* Now to look around and see what can be done */
 	for (i=disks; i--; ) {
 		struct md_rdev *rdev;
-		sector_t first_bad;
-		int bad_sectors;
 		int is_bad = 0;
 
 		dev = &sh->dev[i];
@@ -4719,8 +4711,8 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 		rdev = conf->disks[i].replacement;
 		if (rdev && !test_bit(Faulty, &rdev->flags) &&
 		    rdev->recovery_offset >= sh->sector + RAID5_STRIPE_SECTORS(conf) &&
-		    !is_badblock(rdev, sh->sector, RAID5_STRIPE_SECTORS(conf),
-				 &first_bad, &bad_sectors))
+		    !rdev_has_badblock(rdev, sh->sector,
+				       RAID5_STRIPE_SECTORS(conf)))
 			set_bit(R5_ReadRepl, &dev->flags);
 		else {
 			if (rdev && !test_bit(Faulty, &rdev->flags))
@@ -4733,8 +4725,8 @@ static void analyse_stripe(struct stripe_head *sh, struct stripe_head_state *s)
 		if (rdev && test_bit(Faulty, &rdev->flags))
 			rdev = NULL;
 		if (rdev) {
-			is_bad = is_badblock(rdev, sh->sector, RAID5_STRIPE_SECTORS(conf),
-					     &first_bad, &bad_sectors);
+			is_bad = rdev_has_badblock(rdev, sh->sector,
+						   RAID5_STRIPE_SECTORS(conf));
 			if (s->blocked_rdev == NULL
 			    && (test_bit(Blocked, &rdev->flags)
 				|| is_bad < 0)) {
@@ -5463,8 +5455,8 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 	struct r5conf *conf = mddev->private;
 	struct bio *align_bio;
 	struct md_rdev *rdev;
-	sector_t sector, end_sector, first_bad;
-	int bad_sectors, dd_idx;
+	sector_t sector, end_sector;
+	int dd_idx;
 	bool did_inc;
 
 	if (!in_chunk_boundary(mddev, raid_bio)) {
@@ -5493,8 +5485,7 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 
 	atomic_inc(&rdev->nr_pending);
 
-	if (is_badblock(rdev, sector, bio_sectors(raid_bio), &first_bad,
-			&bad_sectors)) {
+	if (rdev_has_badblock(rdev, sector, bio_sectors(raid_bio))) {
 		rdev_dec_pending(rdev, mddev);
 		return 0;
 	}
-- 
2.39.2


