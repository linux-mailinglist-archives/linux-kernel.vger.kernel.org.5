Return-Path: <linux-kernel+bounces-113642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D238885CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE011F242F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F19883CA3;
	Sun, 24 Mar 2024 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pr6IFrWi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F48B1D449E;
	Sun, 24 Mar 2024 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320555; cv=none; b=TCI2BOYf2lXXv8npMMIwuIGG6g0dQ/GeX4pjjbpVN5iEooO/02isGrkDUnP5LLB241RxUOfPB+cBFJzebrxD34WCnvVvXZFlfIs27Jktj6K+uFuqyYbU+db6O0W10ZrsWZVWlHUiTalvqWwopRoRpcILpIIR/hboIMfM/lnp8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320555; c=relaxed/simple;
	bh=jm8vtzOgOrM3dLp/kr7hOREKcTEftJ9mR8az4FFkQSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioIeLYcZwog3DM8EOEJcKnRD8bgAWn72prr/822FmP2HYMM7YmEKNIs0xWSJQV0HUbPUK13wXyBnALg8OpevpTe/FbZI/9wPx3sD4bWQInhGPuVZvymxVrnb4Bc7GZHrQJ9im5TwnhTLV+KMIYMHCRJBhS/JsxpLBILbMSP/4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pr6IFrWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6142C43390;
	Sun, 24 Mar 2024 22:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320554;
	bh=jm8vtzOgOrM3dLp/kr7hOREKcTEftJ9mR8az4FFkQSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pr6IFrWipoOKUhrAHVF2cikZQ6QBKEhWSDbWf5iterrBdNcez1dkH4HMP5VD6RuoK
	 A27PNnSb7TQtk0mzbkb10OZzXT3s08ISB8Gx5vBz/LT9xobdnqMwoqVopjQNA7ryh6
	 57HUH2SRn7nXhUxxCsvVVA6yGF0QjRJgan0jHlc6ZfYiCEnhkD8oUs/r5072DZ7kBY
	 HMIX8evrmTteXMEK9VIucn8Cgjq+dMP1wFDPhEvQ1rpp5q+3MUD+NzJyAGe9jz8V8s
	 PkRuHUBVqlaO0l4L59+17i+K57P2m3z2Z7KObdTZBDB1ICvhMJ1CP5eVzL3wNb3fCe
	 YZh6ZXpOdDlyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Paul Luse <paul.e.luse@linux.intel.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 115/713] md/raid1: record nonrot rdevs while adding/removing rdevs to conf
Date: Sun, 24 Mar 2024 18:37:21 -0400
Message-ID: <20240324224720.1345309-116-sashal@kernel.org>
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
index 57e2487a03507..27d15b640eff3 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -601,7 +601,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	int sectors;
 	int best_good_sectors;
 	int best_disk, best_dist_disk, best_pending_disk;
-	int has_nonrot_disk;
 	int disk;
 	sector_t best_dist;
 	unsigned int min_pending;
@@ -622,7 +621,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	best_pending_disk = -1;
 	min_pending = UINT_MAX;
 	best_good_sectors = 0;
-	has_nonrot_disk = 0;
 	choose_next_idle = 0;
 	clear_bit(R1BIO_FailFast, &r1_bio->state);
 
@@ -639,7 +637,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 		sector_t first_bad;
 		int bad_sectors;
 		unsigned int pending;
-		bool nonrot;
 
 		rdev = conf->mirrors[disk].rdev;
 		if (r1_bio->bios[disk] == IO_BLOCKED
@@ -705,8 +702,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			/* At least two disks to choose from so failfast is OK */
 			set_bit(R1BIO_FailFast, &r1_bio->state);
 
-		nonrot = bdev_nonrot(rdev->bdev);
-		has_nonrot_disk |= nonrot;
 		pending = atomic_read(&rdev->nr_pending);
 		dist = abs(this_sector - conf->mirrors[disk].head_position);
 		if (choose_first) {
@@ -733,7 +728,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			 * small, but not a big deal since when the second disk
 			 * starts IO, the first disk is likely still busy.
 			 */
-			if (nonrot && opt_iosize > 0 &&
+			if (test_bit(Nonrot, &rdev->flags) && opt_iosize > 0 &&
 			    mirror->seq_start != MaxSector &&
 			    mirror->next_seq_sect > opt_iosize &&
 			    mirror->next_seq_sect - opt_iosize >=
@@ -765,7 +760,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	 * mixed ratation/non-rotational disks depending on workload.
 	 */
 	if (best_disk == -1) {
-		if (has_nonrot_disk || min_pending == 0)
+		if (READ_ONCE(conf->nonrot_disks) || min_pending == 0)
 			best_disk = best_pending_disk;
 		else
 			best_disk = best_dist_disk;
@@ -1772,6 +1767,11 @@ static bool raid1_add_conf(struct r1conf *conf, struct md_rdev *rdev, int disk,
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
@@ -1795,6 +1795,9 @@ static bool raid1_remove_conf(struct r1conf *conf, int disk)
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


