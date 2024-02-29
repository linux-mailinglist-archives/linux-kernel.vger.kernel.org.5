Return-Path: <linux-kernel+bounces-86502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0607D86C650
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FD21F22FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C158B63519;
	Thu, 29 Feb 2024 10:03:26 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1569634FF;
	Thu, 29 Feb 2024 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201005; cv=none; b=BC7CVbe9yXn0ais0hCiNGCgQI8Sr0F3E+5hYDry53yrg2O44+DVHvG4R9X/KpLx0Bwo8kLn3WuUIrjpZSpqJ5NMpTpUP1OaLQwQX5zc6xqIpvahfmcorZdBl3tvcIAEKMHVPlO5I48KiJrJ0OJ/WamQczqWMFmdLgIpHJKfxd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201005; c=relaxed/simple;
	bh=83lz6WN6ZOydRyHbS2+V+ojou138gTYgPJOc+1LOqL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WiW6oVE273HxVFz7PIb6+333Pz3pLaKia46z2XlXPOtrgj9imE6Az9ybK84ef8mcaKtEa8Z02m8vIRyLsKmprHa7kSCzPAZPu70dImGOduXbVqhjjwumMGu4sNpI6w2j1Yt9bXoQelHMzWbGKkU+NU6Vx5ofrqAxd3Ea1L3sLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tlmxv3x36z4f3k5n;
	Thu, 29 Feb 2024 18:03:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E80871A132B;
	Thu, 29 Feb 2024 18:03:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5hVuBlFsMHFg--.11578S8;
	Thu, 29 Feb 2024 18:03:18 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: xni@redhat.com,
	paul.e.luse@linux.intel.com,
	song@kernel.org,
	neilb@suse.com,
	shli@fb.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH md-6.9 v4 04/11] md/raid1: fix choose next idle in read_balance()
Date: Thu, 29 Feb 2024 17:57:07 +0800
Message-Id: <20240229095714.926789-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229095714.926789-1-yukuai1@huaweicloud.com>
References: <20240229095714.926789-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5hVuBlFsMHFg--.11578S8
X-Coremail-Antispam: 1UD129KBjvJXoWxXryrKr1kKr4fAFyUJry3twb_yoWrXw1xpw
	4jvwsaqrWUXF43u3sxJw4UurySg345JayrGrZ7C34Fgry3XrWqqa47K342vry8CFs3J347
	Xw18GrZru3WkKa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
	UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

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
---
 drivers/md/raid1.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index de6ea87d4d24..fa86d9fdb16f 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -598,13 +598,12 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
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
@@ -615,11 +614,11 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
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
@@ -712,7 +711,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			int opt_iosize = bdev_io_opt(rdev->bdev) >> 9;
 			struct raid1_info *mirror = &conf->mirrors[disk];
 
-			best_disk = disk;
 			/*
 			 * If buffered sequential IO size exceeds optimal
 			 * iosize, check if there is idle disk. If yes, choose
@@ -731,15 +729,22 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
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
@@ -751,6 +756,13 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
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
2.39.2


