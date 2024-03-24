Return-Path: <linux-kernel+bounces-112924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E46887FCA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E885F281338
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7E571741;
	Sun, 24 Mar 2024 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOObiQcm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C87172B;
	Sun, 24 Mar 2024 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319736; cv=none; b=mq/QQbTSNi3l3qx9gfCLY1Jvo5b6BBX67NkriKIOVDXpbHEnNEbqh42vUwUf+/wFftnyAmtk5dUCr8W68vR9V2sgfj71piswRHaY2vjH6wsBtmp9lElBxMi12fVchdm7JBYrSayygG7g3aPZTjSlvFcknFSyYEcY/pyy3UuM8+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319736; c=relaxed/simple;
	bh=/nkVN1yDcY9oxD5onlKvnyC7QCORQPVPAOK6wS4gzPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUA5WK31LiWq+LUQ0Ab1EMaB1xVWqJzLRnLdmHn/cjvwdbQJqiya4uL9fxPFJTaWZ28YafIy8iSeaABS8KSjZOdqe39nm32mZ8iEDgJ9raEIJk8sH41KzJKqFnPgzHZnE5Bht37qRg+/ihfPZ4/y9B4042jR8aLG0wnG6M8Qre4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOObiQcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFCBC433B1;
	Sun, 24 Mar 2024 22:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319736;
	bh=/nkVN1yDcY9oxD5onlKvnyC7QCORQPVPAOK6wS4gzPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOObiQcmyDGUjSGy2t2kUUS7ijOvFPqJBANL6jDyOrd+g7ZGqt4EWU2zzw4pwrVaz
	 jcpjXdtJ9N/s6R5ts4fd/rW1EzD4xrL+CTktTF54nCZjjjl25zRJFjAiA7eoX4thn+
	 O3/3Fk6QxEuOEBtYM1HG6BJH0je1HXfy7whFWBkkqfjtplb8OmwtfCxtSoERXSwvhE
	 c2KmW3F6aERn0Wk2YNxD0+PSU5rq4zd59AmNr8gcAQy6rIN/AYhpl7V1OwN1o7HN3q
	 L7BNIxMaWBvA3wY9nAK2qc7z0Br+8x3pjddqwqXh+l6gSJ24a2CRZyYQF5C6b7rS6w
	 TNCgpoCVsaOFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Paul Luse <paul.e.luse@linux.intel.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 037/715] md/raid1: record nonrot rdevs while adding/removing rdevs to conf
Date: Sun, 24 Mar 2024 18:23:36 -0400
Message-ID: <20240324223455.1342824-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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

[ Upstream commit 2c27d09d3a76b33629d2e681bf8b774f776ade7f ]

For raid1, each read will iterate all the rdevs from conf and check if
any rdev is non-rotational, then choose rdev with minimal IO inflight
if so, or rdev with closest distance otherwise.

Disk nonrot info can be changed through sysfs entry:

/sys/block/[disk_name]/queue/rotational

However, consider that this should only be used for testing, and user
really shouldn't do this in real life. Record the number of non-rotational
disks in conf, to avoid checking each rdev in IO fast path and simplify
read_balance() a little bit.

Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240229095714.926789-4-yukuai1@huaweicloud.com
Stable-dep-of: 257ac239ffcf ("md/raid1: fix choose next idle in read_balance()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.h    |  1 +
 drivers/md/raid1.c | 17 ++++++++++-------
 drivers/md/raid1.h |  1 +
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 8d881cc597992..27d187ca6258a 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -207,6 +207,7 @@ enum flag_bits {
 				 * check if there is collision between raid1
 				 * serial bios.
 				 */
+	Nonrot,			/* non-rotational device (SSD) */
 };
 
 static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index a560824e038b4..456d745eb93b3 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -602,7 +602,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	int sectors;
 	int best_good_sectors;
 	int best_disk, best_dist_disk, best_pending_disk;
-	int has_nonrot_disk;
 	int disk;
 	sector_t best_dist;
 	unsigned int min_pending;
@@ -623,7 +622,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	best_pending_disk = -1;
 	min_pending = UINT_MAX;
 	best_good_sectors = 0;
-	has_nonrot_disk = 0;
 	choose_next_idle = 0;
 	clear_bit(R1BIO_FailFast, &r1_bio->state);
 
@@ -640,7 +638,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 		sector_t first_bad;
 		int bad_sectors;
 		unsigned int pending;
-		bool nonrot;
 
 		rdev = conf->mirrors[disk].rdev;
 		if (r1_bio->bios[disk] == IO_BLOCKED
@@ -706,8 +703,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			/* At least two disks to choose from so failfast is OK */
 			set_bit(R1BIO_FailFast, &r1_bio->state);
 
-		nonrot = bdev_nonrot(rdev->bdev);
-		has_nonrot_disk |= nonrot;
 		pending = atomic_read(&rdev->nr_pending);
 		dist = abs(this_sector - conf->mirrors[disk].head_position);
 		if (choose_first) {
@@ -734,7 +729,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			 * small, but not a big deal since when the second disk
 			 * starts IO, the first disk is likely still busy.
 			 */
-			if (nonrot && opt_iosize > 0 &&
+			if (test_bit(Nonrot, &rdev->flags) && opt_iosize > 0 &&
 			    mirror->seq_start != MaxSector &&
 			    mirror->next_seq_sect > opt_iosize &&
 			    mirror->next_seq_sect - opt_iosize >=
@@ -766,7 +761,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	 * mixed ratation/non-rotational disks depending on workload.
 	 */
 	if (best_disk == -1) {
-		if (has_nonrot_disk || min_pending == 0)
+		if (READ_ONCE(conf->nonrot_disks) || min_pending == 0)
 			best_disk = best_pending_disk;
 		else
 			best_disk = best_dist_disk;
@@ -1771,6 +1766,11 @@ static bool raid1_add_conf(struct r1conf *conf, struct md_rdev *rdev, int disk,
 	if (info->rdev)
 		return false;
 
+	if (bdev_nonrot(rdev->bdev)) {
+		set_bit(Nonrot, &rdev->flags);
+		WRITE_ONCE(conf->nonrot_disks, conf->nonrot_disks + 1);
+	}
+
 	rdev->raid_disk = disk;
 	info->head_position = 0;
 	info->seq_start = MaxSector;
@@ -1794,6 +1794,9 @@ static bool raid1_remove_conf(struct r1conf *conf, int disk)
 	    rdev->mddev->degraded < conf->raid_disks)
 		return false;
 
+	if (test_and_clear_bit(Nonrot, &rdev->flags))
+		WRITE_ONCE(conf->nonrot_disks, conf->nonrot_disks - 1);
+
 	WRITE_ONCE(info->rdev, NULL);
 	return true;
 }
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index 14d4211a123a8..5300cbaa58a41 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -71,6 +71,7 @@ struct r1conf {
 						 * allow for replacements.
 						 */
 	int			raid_disks;
+	int			nonrot_disks;
 
 	spinlock_t		device_lock;
 
-- 
2.43.0


