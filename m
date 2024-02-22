Return-Path: <linux-kernel+bounces-76048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1E385F25B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480411F22E15
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A70E18B15;
	Thu, 22 Feb 2024 08:03:57 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6728917BA1;
	Thu, 22 Feb 2024 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589037; cv=none; b=CTCLUn+40NF+6c3TD7Pbjasy3xSQtJrjKVd/1ULuJAhWXDX1i291VzbslCtVW+OO0CkaUbbb0/yF51cdGKxThjXJw7uUghl2emf45pG3pb20brrJLigmqrmFWMuiFyUP1dR6nZRWTZYnPhN29k5PjmzL5p3sgiqhcTn1VLm1YEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589037; c=relaxed/simple;
	bh=VED7vyza1XPnVVt1G1gqgD1vJ+Gh9DgRXBESSaC/Xtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hz2CfAny/RUzIKAE8BmWGJXfCMmOVRnxWR0wwbiSALR6N638pwZD350S+y6ktXrIsPJLmAo3KNZcveOrjBPpEu8i6K74ft7ORxTvERGMBmCJt5tCaeJLcsPINMG5iqIxHHmW0s8kL/VE+L5mmeiNZiVL8AQWomu6o7tOBbSdAjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TgQd96lyZz4f3l6y;
	Thu, 22 Feb 2024 16:03:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EFAB11A1051;
	Thu, 22 Feb 2024 16:03:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBHc_9ZlnaUhEw--.37287S7;
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
Subject: [PATCH md-6.9 03/10] md/raid1: fix choose next idle in read_balance()
Date: Thu, 22 Feb 2024 15:57:59 +0800
Message-Id: <20240222075806.1816400-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBXKBHc_9ZlnaUhEw--.37287S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXryrKr1kKr4fAFyUWrW3ZFb_yoW5CFW5pa
	1jvwsavr4UX343C3s8tw48ZrySq345JFW8CFZ7A34Fgry3XFWYqa18K34a9ry8CFn3t34a
	qr1UGrZF93WkGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Commit 12cee5a8a29e ("md/raid1: prevent merging too large request") add
the case choose next idle in read_balance():

read_balance:
 for_each_rdev
  if(next_seq_sect == this_sector || disk == 0)
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
3) set 'dist' to 0 so that if there is no other idle disk, and all disks
   are rotational, this disk will still be chosen;

Fixes: 2e52d449bcec ("md/raid1: add failfast handling for reads.")
Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index c60ea58ae8c5..d0bc67e6d068 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -604,7 +604,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	unsigned int min_pending;
 	struct md_rdev *rdev;
 	int choose_first;
-	int choose_next_idle;
 
 	/*
 	 * Check if we can balance. We can balance on the whole
@@ -619,7 +618,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	best_pending_disk = -1;
 	min_pending = UINT_MAX;
 	best_good_sectors = 0;
-	choose_next_idle = 0;
 	clear_bit(R1BIO_FailFast, &r1_bio->state);
 
 	if ((conf->mddev->recovery_cp < this_sector + sectors) ||
@@ -712,7 +710,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			int opt_iosize = bdev_io_opt(rdev->bdev) >> 9;
 			struct raid1_info *mirror = &conf->mirrors[disk];
 
-			best_disk = disk;
 			/*
 			 * If buffered sequential IO size exceeds optimal
 			 * iosize, check if there is idle disk. If yes, choose
@@ -731,15 +728,21 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			    mirror->next_seq_sect > opt_iosize &&
 			    mirror->next_seq_sect - opt_iosize >=
 			    mirror->seq_start) {
-				choose_next_idle = 1;
-				continue;
+				/*
+				 * Add 'pending' to avoid choosing this disk if
+				 * there is other idle disk.
+				 * Set 'dist' to 0, so that if there is no other
+				 * idle disk and all disks are rotational, this
+				 * disk will still be chosen.
+				 */
+				pending++;
+				dist = 0;
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
-- 
2.39.2


