Return-Path: <linux-kernel+bounces-83170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D8E868FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3856CB28D19
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE49313B299;
	Tue, 27 Feb 2024 12:09:31 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21513A878;
	Tue, 27 Feb 2024 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035771; cv=none; b=TBYD5AwCcp2cf9dZus/bQU8EHKzNx/fzMlzH/Uoe10gJLqgX4HXKPRhNvOCHUhoez+XDYp7xSFTiNLnCXCr5JMg9u+5ZBc8D64l4ZVOP6QijAzUO84uwaZFmnqt3ieRsl7mQxTZ/OfAbKcVmFs8Xy+LjETZXzS9Y9GFcHd9gmR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035771; c=relaxed/simple;
	bh=2c/lRR6BYe0jqzqLX94eTav/pOJl8LWew6XeDkC265s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iAPuyhSmggzDGSKvuCVly6sSP3W7cpQQpvWiDjS4i+sWauhVHYnH1hVZ9M/AalQFAKbHc1hXYqdqPuaIRlxpV4BRr4pwipiG21eu+0a19zsudtdhwz2IDz4yYNqMiL+Cb5hyv9CHvcPcAIAbecVGvQSBqhNgHvM0w0mk88BACtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TkbrK1tJMz4f3jrl;
	Tue, 27 Feb 2024 20:09:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 761EC1A0232;
	Tue, 27 Feb 2024 20:09:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHv0N1lpKNAFQ--.28259S10;
	Tue, 27 Feb 2024 20:09:26 +0800 (CST)
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
Subject: [PATCH md-6.9 v2 06/10] md/raid1: factor out read_first_rdev() from read_balance()
Date: Tue, 27 Feb 2024 20:03:23 +0800
Message-Id: <20240227120327.1432511-7-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+RHv0N1lpKNAFQ--.28259S10
X-Coremail-Antispam: 1UD129KBjvJXoWxZFW8CrW5GFW3Jr1UAw13Arb_yoWrCw47pw
	45AFZ3tryUX34rZws8J3yDWr93t34fJF48GrZ7Xwnagrn3KryqgFWUGrya9Fy5Crs8Jw1U
	Zw15Ar4ak3Z7KFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
	X7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

read_balance() is hard to understand because there are too many status
and branches, and it's overlong.

This patch factor out the case to read the first rdev from
read_balance(), there are no functional changes.

Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid1.c | 63 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 640d5d8f789a..3eeaef7f8ded 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -579,6 +579,47 @@ static sector_t align_to_barrier_unit_end(sector_t start_sector,
 	return len;
 }
 
+static void update_read_sectors(struct r1conf *conf, int disk,
+				sector_t this_sector, int len)
+{
+	struct raid1_info *info = &conf->mirrors[disk];
+
+	atomic_inc(&info->rdev->nr_pending);
+	if (info->next_seq_sect != this_sector)
+		info->seq_start = this_sector;
+	info->next_seq_sect = this_sector + len;
+}
+
+static int choose_first_rdev(struct r1conf *conf, struct r1bio *r1_bio,
+			     int *max_sectors)
+{
+	sector_t this_sector = r1_bio->sector;
+	int len = r1_bio->sectors;
+	int disk;
+
+	for (disk = 0 ; disk < conf->raid_disks * 2 ; disk++) {
+		struct md_rdev *rdev;
+		int read_len;
+
+		if (r1_bio->bios[disk] == IO_BLOCKED)
+			continue;
+
+		rdev = conf->mirrors[disk].rdev;
+		if (!rdev || test_bit(Faulty, &rdev->flags))
+			continue;
+
+		/* choose the first disk even if it has some bad blocks. */
+		read_len = raid1_check_read_range(rdev, this_sector, &len);
+		if (read_len > 0) {
+			update_read_sectors(conf, disk, this_sector, read_len);
+			*max_sectors = read_len;
+			return disk;
+		}
+	}
+
+	return -1;
+}
+
 /*
  * This routine returns the disk from which the requested read should
  * be done. There is a per-array 'next expected sequential IO' sector
@@ -603,7 +644,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	sector_t best_dist;
 	unsigned int min_pending;
 	struct md_rdev *rdev;
-	int choose_first;
 
  retry:
 	sectors = r1_bio->sectors;
@@ -614,10 +654,11 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	best_pending_disk = -1;
 	min_pending = UINT_MAX;
 	best_good_sectors = 0;
-	choose_first = raid1_should_read_first(conf->mddev, this_sector,
-					       sectors);
 	clear_bit(R1BIO_FailFast, &r1_bio->state);
 
+	if (raid1_should_read_first(conf->mddev, this_sector, sectors))
+		return choose_first_rdev(conf, r1_bio, max_sectors);
+
 	for (disk = 0 ; disk < conf->raid_disks * 2 ; disk++) {
 		sector_t dist;
 		sector_t first_bad;
@@ -663,8 +704,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 				 * bad_sectors from another device..
 				 */
 				bad_sectors -= (this_sector - first_bad);
-				if (choose_first && sectors > bad_sectors)
-					sectors = bad_sectors;
 				if (best_good_sectors > sectors)
 					best_good_sectors = sectors;
 
@@ -674,8 +713,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 					best_good_sectors = good_sectors;
 					best_disk = disk;
 				}
-				if (choose_first)
-					break;
 			}
 			continue;
 		} else {
@@ -690,10 +727,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 
 		pending = atomic_read(&rdev->nr_pending);
 		dist = abs(this_sector - conf->mirrors[disk].head_position);
-		if (choose_first) {
-			best_disk = disk;
-			break;
-		}
 		/* Don't change to another disk for sequential reads */
 		if (conf->mirrors[disk].next_seq_sect == this_sector
 		    || dist == 0) {
@@ -769,13 +802,9 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 		rdev = conf->mirrors[best_disk].rdev;
 		if (!rdev)
 			goto retry;
-		atomic_inc(&rdev->nr_pending);
-		sectors = best_good_sectors;
-
-		if (conf->mirrors[best_disk].next_seq_sect != this_sector)
-			conf->mirrors[best_disk].seq_start = this_sector;
 
-		conf->mirrors[best_disk].next_seq_sect = this_sector + sectors;
+		sectors = best_good_sectors;
+		update_read_sectors(conf, disk, this_sector, sectors);
 	}
 	*max_sectors = sectors;
 
-- 
2.39.2


