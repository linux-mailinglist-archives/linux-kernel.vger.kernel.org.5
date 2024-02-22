Return-Path: <linux-kernel+bounces-76056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5B585F26B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE291C20B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C4925543;
	Thu, 22 Feb 2024 08:04:01 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A15720313;
	Thu, 22 Feb 2024 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589040; cv=none; b=r1lzlBKeoH7KlDIYB0Jy9YxhCHmt6nH8jYW0/qeJkc+LFEqInWaSJSp4Py8oE2+iM/2q3O/rkn+4/H78HcA5ZqiJtWSPywLtXtlS0HGLs9yCz+zm7LPQFk7IDQL9Lpka6sqylN1BF8rCD5FCDti+jvhKEQT/RSTMFHzaXpG55xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589040; c=relaxed/simple;
	bh=Iju3C+0qplBOBdqyqtyOXnYa0Y+uKJhdDQlEn2mhijM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=taaRz5wkJOO8mMr+Ffi9Rcvz6nyxb15c/TXFR5vgb0C/HVjuhqWHfjNZdKVV2X9c8IISUK9XPuFno2qO4gW48ZE3l9xRM8kv8HOhf/Yhqwc6yYBVrYaN35M6FY3rhDHkIk53HRFWIPADnbGSMh5eAKdyWt9mIgx3XBS6sD8Abl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TgQdF078rz4f3l7W;
	Thu, 22 Feb 2024 16:03:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0B6331A0283;
	Thu, 22 Feb 2024 16:03:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBHc_9ZlnaUhEw--.37287S14;
	Thu, 22 Feb 2024 16:03:49 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: paul.e.luse@linux.intel.com,
	song@kernel.org,
	neilb@suse.com,
	shli@fb.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.9 10/10] md/raid1: factor out helpers to choose the best rdev from read_balance()
Date: Thu, 22 Feb 2024 15:58:06 +0800
Message-Id: <20240222075806.1816400-11-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBHc_9ZlnaUhEw--.37287S14
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWrWw15WryrArWrXr1DWrg_yoW3Gr1fpw
	45GFnay3yUZryruwn5tF4UWrWS934rJa18GrZ7C34I93sagrZ8tF97KryY9Fy5Grs3uw12
	v345Gr47C3Z7uFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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
 drivers/md/raid1.c | 171 ++++++++++++++++++++++++---------------------
 1 file changed, 92 insertions(+), 79 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 223ef8d06f67..938b0e0170df 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -730,73 +730,68 @@ static bool should_choose_next(struct r1conf *conf, int disk)
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
-	int best_disk, best_dist_disk, best_pending_disk;
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
 
 			/*
 			 * Add 'pending' to avoid choosing this disk if there is
@@ -810,42 +805,60 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			dist = 0;
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
+		if (dist < ctl.closest_dist) {
+			ctl.closest_dist = dist;
+			ctl.closest_dist_disk = disk;
 		}
 	}
 
-	/*
-	 * If all disks are rotational, choose the closest disk. If any disk is
-	 * non-rotational, choose the disk with less pending request even the
-	 * disk is rotational, which might/might not be optimal for raids with
-	 * mixed ratation/non-rotational disks depending on workload.
-	 */
-	if (best_disk == -1) {
-		if (conf->mddev->nonrot_disks || min_pending == 0)
-			best_disk = best_pending_disk;
-		else
-			best_disk = best_dist_disk;
-	}
 
-	if (best_disk >= 0) {
-		rdev = conf->mirrors[best_disk].rdev;
-		if (!rdev)
-			goto retry;
+	if (ctl.min_pending_disk != -1 &&
+	    (conf->mddev->nonrot_disks || ctl.min_pending == 0))
+		return ctl.min_pending_disk;
+	else
+		return ctl.closest_dist_disk;
+}
 
-		sectors = best_good_sectors;
-		update_read_sectors(conf, disk, this_sector, sectors);
-	}
-	*max_sectors = sectors;
+/*
+ * This routine returns the disk from which the requested read should be done.
+ *
+ * 1) If resync is in progress, find the first usable disk and use
+ * it even if it has some bad blocks.
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
+
+ * The rdev for the device selected will have nr_pending incremented.
+ */
+static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sectors)
+{
+	int disk;
+
+	clear_bit(R1BIO_FailFast, &r1_bio->state);
 
-	if (best_disk >= 0)
-		return best_disk;
+	if (raid1_should_read_first(conf->mddev, r1_bio->sector,
+				    r1_bio->sectors))
+		return choose_first_rdev(conf, r1_bio, max_sectors);
+
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


