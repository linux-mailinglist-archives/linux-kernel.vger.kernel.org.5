Return-Path: <linux-kernel+bounces-83171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84454868FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D041F2A5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8DA13F015;
	Tue, 27 Feb 2024 12:09:33 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8913A267;
	Tue, 27 Feb 2024 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035771; cv=none; b=LlHaqg/HkVXvjNhrTzLry4tiVA5O1iNuxkdaQu7kHB8VC01CVWuPj6dmKDCJGfBEkmQojOp+hLzL9+CgxVIyQYh3LXSRz3Z/ylSjFhnm7mkxjuLff6UWWy5PtVAB9kn8Jblp9CIOHcOhn3Oh4zy12auDgoH7DiAYlx6vngsCsjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035771; c=relaxed/simple;
	bh=0lr/5ZipfqArmNnB6+C7frTwogbx5iqqr9Z6rpgjZyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lUcnIlECvjOZ7J8whszwpqrqm+4Cnmq1vfiG3fFcoNcjh9OVER1blNkt+//FZUTePo5ZXFN8EdZjP9zoekCK1lFa0TjSO7k4yF2rbopLxba88mbpbXDu5HjpWueeVciOH+l+QCbyyXRgXxsAmYDxhSsu9TdpaySyB2Ia1cYJ+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TkbrF5cpzz4f3mHQ;
	Tue, 27 Feb 2024 20:09:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 198EB1A0283;
	Tue, 27 Feb 2024 20:09:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHv0N1lpKNAFQ--.28259S7;
	Tue, 27 Feb 2024 20:09:24 +0800 (CST)
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
Subject: [PATCH md-6.9 v2 03/10] md/raid1: fix choose next idle in read_balance()
Date: Tue, 27 Feb 2024 20:03:20 +0800
Message-Id: <20240227120327.1432511-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+RHv0N1lpKNAFQ--.28259S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXryrKr1kKr4fAFyUJry3twb_yoWrXF48pw
	4jvwsaqr4UXF43u3sxJw4UurySg345JayrGrZ7C34Ygry3XrWqq3W7K342vry8CFs3J342
	qw18GrZrW3WkKa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73DUUUUU=
	=
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
---
 drivers/md/raid1.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 0fed01b06de9..fc5899fb08c1 100644
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


