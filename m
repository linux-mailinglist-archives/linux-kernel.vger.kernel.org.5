Return-Path: <linux-kernel+bounces-84967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E317286AE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1376D1C22744
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E481159582;
	Wed, 28 Feb 2024 11:49:43 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242FC6CDDB;
	Wed, 28 Feb 2024 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120981; cv=none; b=YpzKZEWfRM0f6BSe35E3rASEQ0dOnNrGH9qPFGx6HpTC9T0tgTQ/MCDREQZMWafSbrqZzVT9UEotAChwruReR4Up8zB9rZm6WQU3xWZJqrXJj0vT1fEGjtMS1coF/al8hHWBM12alxa1VzCVUwEonAJcnSbSePqRlmN+3grDLJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120981; c=relaxed/simple;
	bh=AZ9SJ8Ws9UIzKwZBqDyxIqj2dRCU8An1gMQqmKewSbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s3qhLcJha3SqaZEO4hSY4cmdDdg2lHMXEY1pSHz00mvRqDezWzMGauFQI1YZ6jMk1FijM8LcqWUR3a7JYanI/bVLmmlzDqTrc/ixmT0F5+GD/r3zVGlDVcnOGHelEsPvQgbVbO6b3BBG0IW27foSy9r0+PPXcOxlMVfQg3zu8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlCLs5ngpz4f3lfq;
	Wed, 28 Feb 2024 19:49:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 25A811A016E;
	Wed, 28 Feb 2024 19:49:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7IHd9l+eamFQ--.6969S7;
	Wed, 28 Feb 2024 19:49:32 +0800 (CST)
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
Subject: [PATCH md-6.9 v3 03/11] md/raid1: record nonrot rdevs while adding/removing rdevs to conf
Date: Wed, 28 Feb 2024 19:43:25 +0800
Message-Id: <20240228114333.527222-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228114333.527222-1-yukuai1@huaweicloud.com>
References: <20240228114333.527222-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7IHd9l+eamFQ--.6969S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZF47AF1xGFWxJryxCryUZFb_yoWrZF1Dpa
	y5ta9av3yUJa98Cw4ktw48Cr1Sv34UKay8GFZ7C3yF9asIqFWqqFW8G342qr1kGrs8Aw42
	vr1UGws8C3WxKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

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
---
 drivers/md/md.h    |  1 +
 drivers/md/raid1.c | 17 ++++++++++-------
 drivers/md/raid1.h |  1 +
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index a49ab04ab707..b2076a165c10 100644
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
index 1940ff398c23..032a6a6c3730 100644
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
+		if (READ_ONCE(conf->nonrot_disks) || min_pending == 0)
 			best_disk = best_pending_disk;
 		else
 			best_disk = best_dist_disk;
@@ -1764,6 +1759,11 @@ static bool raid1_add_conf(struct r1conf *conf, struct md_rdev *rdev, int disk)
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
@@ -1787,6 +1787,9 @@ static bool raid1_remove_conf(struct r1conf *conf, int disk)
 	    rdev->mddev->degraded < conf->raid_disks)
 		return false;
 
+	if (test_and_clear_bit(Nonrot, &rdev->flags))
+		WRITE_ONCE(conf->nonrot_disks, conf->nonrot_disks - 1);
+
 	WRITE_ONCE(info->rdev, NULL);
 	return true;
 }
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index 14d4211a123a..5300cbaa58a4 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -71,6 +71,7 @@ struct r1conf {
 						 * allow for replacements.
 						 */
 	int			raid_disks;
+	int			nonrot_disks;
 
 	spinlock_t		device_lock;
 
-- 
2.39.2


