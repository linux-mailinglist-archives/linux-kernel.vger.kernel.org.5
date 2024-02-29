Return-Path: <linux-kernel+bounces-86497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C6686C644
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955CB1C22A25
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450B46351A;
	Thu, 29 Feb 2024 10:03:24 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417CD634F4;
	Thu, 29 Feb 2024 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201003; cv=none; b=Je3zkbc9/tL7Mhn60St3QGgSATuLkE3TcP2tfaXNb+YwDjaNXQzwVeIL+36t9uS46t+zCTECeXG4ubOWkssZJ5yjJxbJYAXQDxztSqVtm1QL00beVDB0G18bXhI4pz8rQWKVpSGiZS/SgVfIUi373GcpYjAd5fdmJShelxAjOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201003; c=relaxed/simple;
	bh=dBEhrO69v1tUiScfuvp6rCCLobs7hvaQGjGvjJLlHOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MIM5gZyNx7xW5E9Oqwdf63jfLJWPPtG0ZF8I/TePx7xWVJXHhlqZRy1iWuxzAUB3UDd58dZNuxBVOHFWeeu1sSN3OWAQxCkFBj0izGsF4VAyhXn2BIMg5eeDJN8Oedkehz6jX+0b2CsqkHxl4lsFCpoKQvy+Ywe5AEcKVTulBz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tlmxs1g2Lz4f3khN;
	Thu, 29 Feb 2024 18:03:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7A04B1A016E;
	Thu, 29 Feb 2024 18:03:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5hVuBlFsMHFg--.11578S7;
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
Subject: [PATCH md-6.9 v4 03/11] md/raid1: record nonrot rdevs while adding/removing rdevs to conf
Date: Thu, 29 Feb 2024 17:57:06 +0800
Message-Id: <20240229095714.926789-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g5hVuBlFsMHFg--.11578S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZF47AF1xGFWxJryxCryUZFb_yoWrZF1Dpa
	15Ja9av3yUJa98Cw4ktw48Cr1Sv34UKay8GFZ7C3yF9asIqFZFqFW8G342qrykGrsxAw42
	vr15Gws8C3WxKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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
index 6ec9998f6257..de6ea87d4d24 100644
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
@@ -1768,6 +1763,11 @@ static bool raid1_add_conf(struct r1conf *conf, struct md_rdev *rdev, int disk,
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
@@ -1791,6 +1791,9 @@ static bool raid1_remove_conf(struct r1conf *conf, int disk)
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


