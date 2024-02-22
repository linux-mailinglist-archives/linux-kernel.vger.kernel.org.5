Return-Path: <linux-kernel+bounces-76051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D69E85F262
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2261F21B40
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC45208C3;
	Thu, 22 Feb 2024 08:03:58 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741CD17BAB;
	Thu, 22 Feb 2024 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589037; cv=none; b=UxOgfe2Y40ySYxPn+anS+70nQGbIkGDcflVzWSTKdQpVqNyhmklbY536Sc651IMhUFIuvJkQ9VL+mdG5MAsDueRcBd75EaX0Np8yyoKpy6jOA+3RnFeM9vwUIL/0U23eUGyrApK8u2jSh0r+YM/aoMrJlMTEezCHps8BGnP0ta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589037; c=relaxed/simple;
	bh=NrQmFfskHAQvaTPgUXtBcsCXY0LSONsPXMM2b6dNWZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=siXy0HUEc8ws5yI4yqGCOIC67+pYd6U89FmDU+RsEwKoZauDQOeL95+xmXR9FtVNk+OWLvycyz4/IB5Opv9m8TqG3or2V40vi3l0J5tnGmKG7sgFpSvcva3CWgb0MRtWQeijLw7daCL8Kn0cMh5gVwX2KjfLkpzAixloh/n8M1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TgQdC2KB1z4f3l8C;
	Thu, 22 Feb 2024 16:03:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 85D581A104C;
	Thu, 22 Feb 2024 16:03:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBHc_9ZlnaUhEw--.37287S6;
	Thu, 22 Feb 2024 16:03:46 +0800 (CST)
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
Subject: [PATCH md-6.9 02/10] md: record nonrot rdevs while adding/removing rdevs to conf
Date: Thu, 22 Feb 2024 15:57:58 +0800
Message-Id: <20240222075806.1816400-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBXKBHc_9ZlnaUhEw--.37287S6
X-Coremail-Antispam: 1UD129KBjvJXoW3ArW8AFy3Aw15Jr18try5urg_yoWxKF43p3
	y5ta4fXw4UA345Gwn8tF4kCrnaq34UKay0kFZ3C34SgasIqry0qa18G343tryDAFZ5Aw17
	Xr1UKa1DC3WIgFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

For raid1/raid10, each read will iterate all the rdevs from conf and
check if any rdev is non-rotational, then choose rdev with minimal IO
inflight if so, or rdev with closest distance otherwise.

Disk nonrot info can be changed through sysfs entry:

/sys/block/[disk_name]/queue/rotational

However, consider that this should only be used for testing, and user
really shouldn't do this in real life. Record the number of non-rotational
disks in mddev, to avoid checking each rdev in IO fast path and simplify
read_balance() a little bit.

Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c     | 28 ++++++++++++++++++++++++++--
 drivers/md/md.h     |  2 ++
 drivers/md/raid1.c  |  9 ++-------
 drivers/md/raid10.c |  8 ++------
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index e2a5f513dbb7..9e671eec9309 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -146,6 +146,24 @@ static inline int speed_max(struct mddev *mddev)
 		mddev->sync_speed_max : sysctl_speed_limit_max;
 }
 
+static void rdev_update_nonrot(struct md_rdev *rdev)
+{
+	if (!bdev_nonrot(rdev->bdev))
+		return;
+
+	set_bit(Nonrot, &rdev->flags);
+	WRITE_ONCE(rdev->mddev->nonrot_disks, rdev->mddev->nonrot_disks + 1);
+}
+
+static void rdev_clear_nonrot(struct md_rdev *rdev)
+{
+	if (!test_bit(Nonrot, &rdev->flags))
+		return;
+
+	clear_bit(Nonrot, &rdev->flags);
+	WRITE_ONCE(rdev->mddev->nonrot_disks, rdev->mddev->nonrot_disks - 1);
+}
+
 static void rdev_uninit_serial(struct md_rdev *rdev)
 {
 	if (!test_and_clear_bit(CollisionCheck, &rdev->flags))
@@ -2922,6 +2940,8 @@ static int add_bound_rdev(struct md_rdev *rdev)
 			md_kick_rdev_from_array(rdev);
 			return err;
 		}
+
+		rdev_update_nonrot(rdev);
 	}
 	sysfs_notify_dirent_safe(rdev->sysfs_state);
 
@@ -3271,8 +3291,10 @@ slot_store(struct md_rdev *rdev, const char *buf, size_t len)
 		if (err) {
 			rdev->raid_disk = -1;
 			return err;
-		} else
-			sysfs_notify_dirent_safe(rdev->sysfs_state);
+		}
+
+		rdev_update_nonrot(rdev);
+		sysfs_notify_dirent_safe(rdev->sysfs_state);
 		/* failure here is OK */;
 		sysfs_link_rdev(rdev->mddev, rdev);
 		/* don't wakeup anyone, leave that to userspace. */
@@ -9266,6 +9288,7 @@ static int remove_and_add_spares(struct mddev *mddev,
 	rdev_for_each(rdev, mddev) {
 		if ((this == NULL || rdev == this) && rdev_removeable(rdev) &&
 		    !mddev->pers->hot_remove_disk(mddev, rdev)) {
+			rdev_clear_nonrot(rdev);
 			sysfs_unlink_rdev(mddev, rdev);
 			rdev->saved_raid_disk = rdev->raid_disk;
 			rdev->raid_disk = -1;
@@ -9289,6 +9312,7 @@ static int remove_and_add_spares(struct mddev *mddev,
 		if (!test_bit(Journal, &rdev->flags))
 			rdev->recovery_offset = 0;
 		if (mddev->pers->hot_add_disk(mddev, rdev) == 0) {
+			rdev_update_nonrot(rdev);
 			/* failure here is OK */
 			sysfs_link_rdev(mddev, rdev);
 			if (!test_bit(Journal, &rdev->flags))
diff --git a/drivers/md/md.h b/drivers/md/md.h
index a49ab04ab707..54aa951f2bba 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -207,6 +207,7 @@ enum flag_bits {
 				 * check if there is collision between raid1
 				 * serial bios.
 				 */
+	Nonrot,			/* non-rotational device (SSD) */
 };
 
 static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
@@ -312,6 +313,7 @@ struct mddev {
 	unsigned long			flags;
 	unsigned long			sb_flags;
 
+	int				nonrot_disks;
 	int				suspended;
 	struct mutex			suspend_mutex;
 	struct percpu_ref		active_io;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index a145fe48b9ce..c60ea58ae8c5 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -599,7 +599,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	int sectors;
 	int best_good_sectors;
 	int best_disk, best_dist_disk, best_pending_disk;
-	int has_nonrot_disk;
 	int disk;
 	sector_t best_dist;
 	unsigned int min_pending;
@@ -620,7 +619,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	best_pending_disk = -1;
 	min_pending = UINT_MAX;
 	best_good_sectors = 0;
-	has_nonrot_disk = 0;
 	choose_next_idle = 0;
 	clear_bit(R1BIO_FailFast, &r1_bio->state);
 
@@ -637,7 +635,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 		sector_t first_bad;
 		int bad_sectors;
 		unsigned int pending;
-		bool nonrot;
 
 		rdev = conf->mirrors[disk].rdev;
 		if (r1_bio->bios[disk] == IO_BLOCKED
@@ -703,8 +700,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			/* At least two disks to choose from so failfast is OK */
 			set_bit(R1BIO_FailFast, &r1_bio->state);
 
-		nonrot = bdev_nonrot(rdev->bdev);
-		has_nonrot_disk |= nonrot;
 		pending = atomic_read(&rdev->nr_pending);
 		dist = abs(this_sector - conf->mirrors[disk].head_position);
 		if (choose_first) {
@@ -731,7 +726,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			 * small, but not a big deal since when the second disk
 			 * starts IO, the first disk is likely still busy.
 			 */
-			if (nonrot && opt_iosize > 0 &&
+			if (test_bit(Nonrot, &rdev->flags) && opt_iosize > 0 &&
 			    mirror->seq_start != MaxSector &&
 			    mirror->next_seq_sect > opt_iosize &&
 			    mirror->next_seq_sect - opt_iosize >=
@@ -763,7 +758,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	 * mixed ratation/non-rotational disks depending on workload.
 	 */
 	if (best_disk == -1) {
-		if (has_nonrot_disk || min_pending == 0)
+		if (conf->mddev->nonrot_disks || min_pending == 0)
 			best_disk = best_pending_disk;
 		else
 			best_disk = best_dist_disk;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index d5a7a621f0f0..1f6693e40e12 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -735,7 +735,6 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 	struct md_rdev *best_dist_rdev, *best_pending_rdev, *rdev = NULL;
 	int do_balance;
 	int best_dist_slot, best_pending_slot;
-	bool has_nonrot_disk = false;
 	unsigned int min_pending;
 	struct geom *geo = &conf->geo;
 
@@ -766,7 +765,6 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 		int bad_sectors;
 		sector_t dev_sector;
 		unsigned int pending;
-		bool nonrot;
 
 		if (r10_bio->devs[slot].bio == IO_BLOCKED)
 			continue;
@@ -818,10 +816,8 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 		if (!do_balance)
 			break;
 
-		nonrot = bdev_nonrot(rdev->bdev);
-		has_nonrot_disk |= nonrot;
 		pending = atomic_read(&rdev->nr_pending);
-		if (min_pending > pending && nonrot) {
+		if (min_pending > pending && test_bit(Nonrot, &rdev->flags)) {
 			min_pending = pending;
 			best_pending_slot = slot;
 			best_pending_rdev = rdev;
@@ -851,7 +847,7 @@ static struct md_rdev *read_balance(struct r10conf *conf,
 		}
 	}
 	if (slot >= conf->copies) {
-		if (has_nonrot_disk) {
+		if (conf->mddev->nonrot_disks) {
 			slot = best_pending_slot;
 			rdev = best_pending_rdev;
 		} else {
-- 
2.39.2


