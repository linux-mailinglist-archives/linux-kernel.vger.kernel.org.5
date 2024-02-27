Return-Path: <linux-kernel+bounces-83176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BC2868FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A198A1F2B3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE74145348;
	Tue, 27 Feb 2024 12:09:34 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7593513AA5D;
	Tue, 27 Feb 2024 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035773; cv=none; b=JN1mpBfKFQSIeYIMT9UMq6k8B/Jsr1SBx6Mwbt0U4k2GSTSC9h+PktQSZ/egqfCrZ9uzLgrAz/dxC9tTUrmEcHrwb75NuZamU08594EQwHB4v+G3IZmo7kIK5d3kHlsaFfQy/4z5rzM9Tesjsbo+fU0Z9rXEw8hYdFSk1BCN+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035773; c=relaxed/simple;
	bh=gj6NVHpq0Y6xpRlyoFks9hO476lUefpwWpArgf0CebQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faUm9EMIQqC9kEuin5pOSjHIWQOyROGWvPD3oSW65OExQM3NzMKON/D591b3VG5H8xI+JeoPufKJiVe0KoojMnQPl3RjwGQy54ww1EaUkLoQN4sNhZMt3hekLIMwHrJ72WMoRWXQ8DJ20AuITLafVMWp8HCBXus7UBLaiYr6e/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TkbrK06Vcz4f3mJP;
	Tue, 27 Feb 2024 20:09:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 512E61A016E;
	Tue, 27 Feb 2024 20:09:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHv0N1lpKNAFQ--.28259S14;
	Tue, 27 Feb 2024 20:09:28 +0800 (CST)
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
Subject: [PATCH md-6.9 v2 10/10] md/raid1: factor out helpers to choose the best rdev from read_balance()
Date: Tue, 27 Feb 2024 20:03:27 +0800
Message-Id: <20240227120327.1432511-11-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+RHv0N1lpKNAFQ--.28259S14
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWrWw15Wr1UAFyfAryxXwb_yoW3ZF13pw
	45GFn2y3yUZryruwn5tr4UWrWS934fJa18GrWkG34S93sagrZ0qFn7KryY9FyDGrs3Cw12
	qw15Gr47C3Z7GFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The way that best rdev is chosen:

1) If the read is sequential from one rdev:
 - if rdev is rotational, use this rdev;
 - if rdev is non-rotational, use this rdev until total read length
   exceed disk opt io size;

2) If the read is not sequential:
 - if there is idle disk, use it, otherwise:
 - if the array has non-rotational disk, choose the rdev with minimal
   inflight IO;
 - if all the underlaying disks are rotational disk, choose the rdev
   with closest IO;

There are no functional changes, just to make code cleaner and prepare
for following refactor.

Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 175 +++++++++++++++++++++++++--------------------
 1 file changed, 98 insertions(+), 77 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index d3e9a0157437..1bdd59d9e6ba 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -730,74 +730,71 @@ static bool should_choose_next(struct r1conf *conf, int disk)
 	       mirror->next_seq_sect - opt_iosize >= mirror->seq_start;
 }
 
-/*
- * This routine returns the disk from which the requested read should
- * be done. There is a per-array 'next expected sequential IO' sector
- * number - if this matches on the next IO then we use the last disk.
- * There is also a per-disk 'last know head position' sector that is
- * maintained from IRQ contexts, both the normal and the resync IO
- * completion handlers update this position correctly. If there is no
- * perfect sequential match then we pick the disk whose head is closest.
- *
- * If there are 2 mirrors in the same 2 devices, performance degrades
- * because position is mirror, not device based.
- *
- * The rdev for the device selected will have nr_pending incremented.
- */
-static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sectors)
+static bool rdev_readable(struct md_rdev *rdev, struct r1bio *r1_bio)
 {
-	const sector_t this_sector = r1_bio->sector;
-	int sectors;
-	int best_good_sectors;
-	int best_disk, best_dist_disk, best_pending_disk, sequential_disk;
-	int disk;
-	sector_t best_dist;
-	unsigned int min_pending;
-	struct md_rdev *rdev;
+	if (!rdev || test_bit(Faulty, &rdev->flags))
+		return false;
 
- retry:
-	sectors = r1_bio->sectors;
-	best_disk = -1;
-	best_dist_disk = -1;
-	sequential_disk = -1;
-	best_dist = MaxSector;
-	best_pending_disk = -1;
-	min_pending = UINT_MAX;
-	best_good_sectors = 0;
-	clear_bit(R1BIO_FailFast, &r1_bio->state);
+	/* still in recovery */
+	if (!test_bit(In_sync, &rdev->flags) &&
+	    rdev->recovery_offset < r1_bio->sector + r1_bio->sectors)
+		return false;
 
-	if (raid1_should_read_first(conf->mddev, this_sector, sectors))
-		return choose_first_rdev(conf, r1_bio, max_sectors);
+	/* don't read from slow disk unless have to */
+	if (test_bit(WriteMostly, &rdev->flags))
+		return false;
+
+	/* don't split IO for bad blocks unless have to */
+	if (rdev_has_badblock(rdev, r1_bio->sector, r1_bio->sectors))
+		return false;
+
+	return true;
+}
+
+struct read_balance_ctl {
+	sector_t closest_dist;
+	int closest_dist_disk;
+	int min_pending;
+	int min_pending_disk;
+	int sequential_disk;
+	int readable_disks;
+};
+
+static int choose_best_rdev(struct r1conf *conf, struct r1bio *r1_bio)
+{
+	int disk;
+	struct read_balance_ctl ctl = {
+		.closest_dist_disk      = -1,
+		.closest_dist           = MaxSector,
+		.min_pending_disk       = -1,
+		.min_pending            = UINT_MAX,
+		.sequential_disk	= -1,
+	};
 
 	for (disk = 0 ; disk < conf->raid_disks * 2 ; disk++) {
+		struct md_rdev *rdev;
 		sector_t dist;
 		unsigned int pending;
 
-		rdev = conf->mirrors[disk].rdev;
-		if (r1_bio->bios[disk] == IO_BLOCKED
-		    || rdev == NULL
-		    || test_bit(Faulty, &rdev->flags))
-			continue;
-		if (!test_bit(In_sync, &rdev->flags) &&
-		    rdev->recovery_offset < this_sector + sectors)
-			continue;
-		if (test_bit(WriteMostly, &rdev->flags))
+		if (r1_bio->bios[disk] == IO_BLOCKED)
 			continue;
-		if (rdev_has_badblock(rdev, this_sector, sectors))
+
+		rdev = conf->mirrors[disk].rdev;
+		if (!rdev_readable(rdev, r1_bio))
 			continue;
 
-		if (best_disk >= 0)
-			/* At least two disks to choose from so failfast is OK */
+		/* At least two disks to choose from so failfast is OK */
+		if (ctl.readable_disks++ == 1)
 			set_bit(R1BIO_FailFast, &r1_bio->state);
 
 		pending = atomic_read(&rdev->nr_pending);
-		dist = abs(this_sector - conf->mirrors[disk].head_position);
+		dist = abs(r1_bio->sector - conf->mirrors[disk].head_position);
+
 		/* Don't change to another disk for sequential reads */
 		if (is_sequential(conf, disk, r1_bio)) {
-			if (!should_choose_next(conf, disk)) {
-				best_disk = disk;
-				break;
-			}
+			if (!should_choose_next(conf, disk))
+				return disk;
+
 			/*
 			 * Add 'pending' to avoid choosing this disk if
 			 * there is other idle disk.
@@ -807,17 +804,17 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			 * If there is no other idle disk, this disk
 			 * will be chosen.
 			 */
-			sequential_disk = disk;
+			ctl.sequential_disk = disk;
 		}
 
-		if (min_pending > pending) {
-			min_pending = pending;
-			best_pending_disk = disk;
+		if (ctl.min_pending > pending) {
+			ctl.min_pending = pending;
+			ctl.min_pending_disk = disk;
 		}
 
-		if (dist < best_dist) {
-			best_dist = dist;
-			best_dist_disk = disk;
+		if (ctl.closest_dist > dist) {
+			ctl.closest_dist = dist;
+			ctl.closest_dist_disk = disk;
 		}
 	}
 
@@ -825,8 +822,8 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	 * sequential IO size exceeds optimal iosize, however, there is no other
 	 * idle disk, so choose the sequential disk.
 	 */
-	if (best_disk == -1 && min_pending != 0)
-		best_disk = sequential_disk;
+	if (ctl.sequential_disk != -1 && ctl.min_pending != 0)
+		return ctl.sequential_disk;
 
 	/*
 	 * If all disks are rotational, choose the closest disk. If any disk is
@@ -834,25 +831,49 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	 * disk is rotational, which might/might not be optimal for raids with
 	 * mixed ratation/non-rotational disks depending on workload.
 	 */
-	if (best_disk == -1) {
-		if (READ_ONCE(conf->nonrot_disks) || min_pending == 0)
-			best_disk = best_pending_disk;
-		else
-			best_disk = best_dist_disk;
-	}
+	if (ctl.min_pending_disk != -1 &&
+	    (READ_ONCE(conf->nonrot_disks) || ctl.min_pending == 0))
+		return ctl.min_pending_disk;
+	else
+		return ctl.closest_dist_disk;
+}
 
-	if (best_disk >= 0) {
-		rdev = conf->mirrors[best_disk].rdev;
-		if (!rdev)
-			goto retry;
+/*
+ * This routine returns the disk from which the requested read should be done.
+ *
+ * 1) If resync is in progress, find the first usable disk and use it even if it
+ * has some bad blocks.
+ *
+ * 2) Now that there is no resync, loop through all disks and skipping slow
+ * disks and disks with bad blocks for now. Only pay attention to key disk
+ * choice.
+ *
+ * 3) If we've made it this far, now look for disks with bad blocks and choose
+ * the one with most number of sectors.
+ *
+ * 4) If we are all the way at the end, we have no choice but to use a disk even
+ * if it is write mostly.
+ *
+ * The rdev for the device selected will have nr_pending incremented.
+ */
+static int read_balance(struct r1conf *conf, struct r1bio *r1_bio,
+			int *max_sectors)
+{
+	int disk;
 
-		sectors = best_good_sectors;
-		update_read_sectors(conf, disk, this_sector, sectors);
-	}
-	*max_sectors = sectors;
+	clear_bit(R1BIO_FailFast, &r1_bio->state);
+
+	if (raid1_should_read_first(conf->mddev, r1_bio->sector,
+				    r1_bio->sectors))
+		return choose_first_rdev(conf, r1_bio, max_sectors);
 
-	if (best_disk >= 0)
-		return best_disk;
+	disk = choose_best_rdev(conf, r1_bio);
+	if (disk >= 0) {
+		*max_sectors = r1_bio->sectors;
+		update_read_sectors(conf, disk, r1_bio->sector,
+				    r1_bio->sectors);
+		return disk;
+	}
 
 	/*
 	 * If we are here it means we didn't find a perfectly good disk so
-- 
2.39.2


