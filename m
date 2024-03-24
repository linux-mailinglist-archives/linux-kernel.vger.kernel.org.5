Return-Path: <linux-kernel+bounces-113643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACC8888E23
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4594D297B32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48161D8BC3;
	Sun, 24 Mar 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejoD+RvL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54101D44AF;
	Sun, 24 Mar 2024 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320556; cv=none; b=RcJ46/Evfpy2+4FlCkWN2fsNvi1z1PncKetigKVbshFirIRO50O7/by6K/O/5T54Zk4xD6zLzGHEXfBzbOJGuPr1KncPylofj7YYEo67JJhX1ENYcdu9CDPaXuCCkeKpS4DykSEjDu3qA2PmaGNLVdqvFEeuUKoX9ujzCgJoclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320556; c=relaxed/simple;
	bh=vqjNV31bAJM76RZC3bgXxtzZINuHlO/JuRr4ZD6dRS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIqrQ78PVXwQEcV3ir6GH+KlrJHMXgjY02RPUEAKxeWwkzPcIxzLNcqHmjnWVJ0VojDdPrjynN9SU00M8qrpQJYy4uOh5Nqxb17REifDHd7OLCraFegSx89Z2K3X1NbFbH6gsxjIcKY5JUkR2YXBQuRYCr4iZN95y86K7XwESlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejoD+RvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7159C433C7;
	Sun, 24 Mar 2024 22:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320555;
	bh=vqjNV31bAJM76RZC3bgXxtzZINuHlO/JuRr4ZD6dRS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejoD+RvLaTXOI5EowjalqC+qmNfhUUrBVsXzu/2LyggJes7jrhtXYAV4hG37A5Kqo
	 lTk1XhIJHpcYMOzQ7U248SlpMsmDtQ/6VcAawNKlqmEEehii6DFHCNaKi5VhQlu+T/
	 xnXk8uuLi+3nqWlr85G6TtMVR/YGnGLo2BlFS4ii1GLguO/4M2TwxCdhWkWX7FYqKo
	 gr8297/4OVI3vGC4lc53SfSjwjaFnz+rZjVpt1HZZkujFpYCYyWDji4TBigmUtOKMh
	 DsHgv0rpgkww+F10QRvvtohbBt58KWU/GkwqmBuZ5psLbt7/AjakUw36UFk9U8s0FU
	 ho6mIWQjHvOfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Paul Luse <paul.e.luse@linux.intel.com>,
	Xiao Ni <xni@redhat.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 116/713] md/raid1: fix choose next idle in read_balance()
Date: Sun, 24 Mar 2024 18:37:22 -0400
Message-ID: <20240324224720.1345309-117-sashal@kernel.org>
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

[ Upstream commit 257ac239ffcfd097a9a0732bf5095fb00164f334 ]

Commit 12cee5a8a29e ("md/raid1: prevent merging too large request") add
the case choose next idle in read_balance():

read_balance:
 for_each_rdev
  if(next_seq_sect == this_sector || dist == 0)
  -> sequential reads
   best_disk = disk;
   if (...)
    choose_next_idle = 1
    continue;

 for_each_rdev
 -> iterate next rdev
  if (pending == 0)
   best_disk = disk;
   -> choose the next idle disk
   break;

  if (choose_next_idle)
   -> keep using this rdev if there are no other idle disk
   contine

However, commit 2e52d449bcec ("md/raid1: add failfast handling for reads.")
remove the code:

-               /* If device is idle, use it */
-               if (pending == 0) {
-                       best_disk = disk;
-                       break;
-               }

Hence choose next idle will never work now, fix this problem by
following:

1) don't set best_disk in this case, read_balance() will choose the best
   disk after iterating all the disks;
2) add 'pending' so that other idle disk will be chosen;
3) add a new local variable 'sequential_disk' to record the disk, and if
   there is no other idle disk, 'sequential_disk' will be chosen;

Fixes: 2e52d449bcec ("md/raid1: add failfast handling for reads.")
Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240229095714.926789-5-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 27d15b640eff3..750a802478e52 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -600,13 +600,12 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	const sector_t this_sector = r1_bio->sector;
 	int sectors;
 	int best_good_sectors;
-	int best_disk, best_dist_disk, best_pending_disk;
+	int best_disk, best_dist_disk, best_pending_disk, sequential_disk;
 	int disk;
 	sector_t best_dist;
 	unsigned int min_pending;
 	struct md_rdev *rdev;
 	int choose_first;
-	int choose_next_idle;
 
 	/*
 	 * Check if we can balance. We can balance on the whole
@@ -617,11 +616,11 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	sectors = r1_bio->sectors;
 	best_disk = -1;
 	best_dist_disk = -1;
+	sequential_disk = -1;
 	best_dist = MaxSector;
 	best_pending_disk = -1;
 	min_pending = UINT_MAX;
 	best_good_sectors = 0;
-	choose_next_idle = 0;
 	clear_bit(R1BIO_FailFast, &r1_bio->state);
 
 	if ((conf->mddev->recovery_cp < this_sector + sectors) ||
@@ -714,7 +713,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			int opt_iosize = bdev_io_opt(rdev->bdev) >> 9;
 			struct raid1_info *mirror = &conf->mirrors[disk];
 
-			best_disk = disk;
 			/*
 			 * If buffered sequential IO size exceeds optimal
 			 * iosize, check if there is idle disk. If yes, choose
@@ -733,15 +731,22 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			    mirror->next_seq_sect > opt_iosize &&
 			    mirror->next_seq_sect - opt_iosize >=
 			    mirror->seq_start) {
-				choose_next_idle = 1;
-				continue;
+				/*
+				 * Add 'pending' to avoid choosing this disk if
+				 * there is other idle disk.
+				 */
+				pending++;
+				/*
+				 * If there is no other idle disk, this disk
+				 * will be chosen.
+				 */
+				sequential_disk = disk;
+			} else {
+				best_disk = disk;
+				break;
 			}
-			break;
 		}
 
-		if (choose_next_idle)
-			continue;
-
 		if (min_pending > pending) {
 			min_pending = pending;
 			best_pending_disk = disk;
@@ -753,6 +758,13 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 		}
 	}
 
+	/*
+	 * sequential IO size exceeds optimal iosize, however, there is no other
+	 * idle disk, so choose the sequential disk.
+	 */
+	if (best_disk == -1 && min_pending != 0)
+		best_disk = sequential_disk;
+
 	/*
 	 * If all disks are rotational, choose the closest disk. If any disk is
 	 * non-rotational, choose the disk with less pending request even the
-- 
2.43.0


