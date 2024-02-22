Return-Path: <linux-kernel+bounces-76055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D383C85F269
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDC41F21CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0B623758;
	Thu, 22 Feb 2024 08:04:00 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954761947B;
	Thu, 22 Feb 2024 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589039; cv=none; b=f91TXZtAD/b554Md8J7WoHMSENcvJM0a0pMGryteJpS2GJ20YD83OltwWpxeBQPirRHO5Cg2OroWdiR/dvy/vQRolEQ8U2Hv4jZ+sIyJBIRKCqquUCx10DAeFowlRBsXiqZdNViEc5bwcq894vYYGu9Ncrh7+Ytib6S0VXOsPco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589039; c=relaxed/simple;
	bh=tFSMnR9X+6Kg1bzSGn07rQER2Sa1F57YKXTDaqbsTCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ML2nm0fEB1w3Zj6anpur65BkNGUaqk6vZ9YP0V+antHE+MglJxUN/2i0Bs1EoAy4B/fS9vboYBIZnU2qBMIL0IePTcO9Y+5mNK/46I0wjna4EJdjW6dajmDpiNIgGVFWZA1LZNvZdxYaI1H9oUNDiR3IaUdlx3Dwnj1N9nknwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TgQdD19Zzz4f3jdQ;
	Thu, 22 Feb 2024 16:03:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2EF481A0172;
	Thu, 22 Feb 2024 16:03:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBHc_9ZlnaUhEw--.37287S12;
	Thu, 22 Feb 2024 16:03:48 +0800 (CST)
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
Subject: [PATCH md-6.9 08/10] md/raid1: factor out choose_bb_rdev() from read_balance()
Date: Thu, 22 Feb 2024 15:58:04 +0800
Message-Id: <20240222075806.1816400-9-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBXKBHc_9ZlnaUhEw--.37287S12
X-Coremail-Antispam: 1UD129KBjvJXoWxZF47Ww4ftFyxtF4fWryUKFg_yoWrJr4Upw
	43KFWftryUX34fWws8J3yUuryft345Gay8JryxJ3WS9r93CrZ0gFW8GryYgFyUCrWrA3W2
	vw15Zr4293WkKFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
	UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

read_balance() is hard to understand because there are too many status
and branches, and it's overlong.

This patch factor out the case to read the rdev with bad blocks from
read_balance(), there are no functional changes.

Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 79 ++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index bc2f8fcbe5b3..4694e0e71e36 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -620,6 +620,44 @@ static int choose_first_rdev(struct r1conf *conf, struct r1bio *r1_bio,
 	return -1;
 }
 
+static int choose_bb_rdev(struct r1conf *conf, struct r1bio *r1_bio,
+			  int *max_sectors)
+{
+	sector_t this_sector = r1_bio->sector;
+	int best_disk = -1;
+	int best_len = 0;
+	int disk;
+
+	for (disk = 0 ; disk < conf->raid_disks * 2 ; disk++) {
+		struct md_rdev *rdev;
+		int len;
+		int read_len;
+
+		if (r1_bio->bios[disk] == IO_BLOCKED)
+			continue;
+
+		rdev = conf->mirrors[disk].rdev;
+		if (!rdev || test_bit(Faulty, &rdev->flags) ||
+		    test_bit(WriteMostly, &rdev->flags))
+			continue;
+
+		/* keep track of the disk with the most readable sectors. */
+		len = r1_bio->sectors;
+		read_len = raid1_check_read_range(rdev, this_sector, &len);
+		if (read_len > best_len) {
+			best_disk = disk;
+			best_len = read_len;
+		}
+	}
+
+	if (best_disk != -1) {
+		*max_sectors = best_len;
+		update_read_sectors(conf, best_disk, this_sector, best_len);
+	}
+
+	return best_disk;
+}
+
 static int choose_slow_rdev(struct r1conf *conf, struct r1bio *r1_bio,
 			    int *max_sectors)
 {
@@ -707,8 +745,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 
 	for (disk = 0 ; disk < conf->raid_disks * 2 ; disk++) {
 		sector_t dist;
-		sector_t first_bad;
-		int bad_sectors;
 		unsigned int pending;
 
 		rdev = conf->mirrors[disk].rdev;
@@ -721,36 +757,8 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 			continue;
 		if (test_bit(WriteMostly, &rdev->flags))
 			continue;
-		/* This is a reasonable device to use.  It might
-		 * even be best.
-		 */
-		if (is_badblock(rdev, this_sector, sectors,
-				&first_bad, &bad_sectors)) {
-			if (best_dist < MaxSector)
-				/* already have a better device */
-				continue;
-			if (first_bad <= this_sector) {
-				/* cannot read here. If this is the 'primary'
-				 * device, then we must not read beyond
-				 * bad_sectors from another device..
-				 */
-				bad_sectors -= (this_sector - first_bad);
-				if (best_good_sectors > sectors)
-					best_good_sectors = sectors;
-
-			} else {
-				sector_t good_sectors = first_bad - this_sector;
-				if (good_sectors > best_good_sectors) {
-					best_good_sectors = good_sectors;
-					best_disk = disk;
-				}
-			}
+		if (rdev_has_badblock(rdev, this_sector, sectors))
 			continue;
-		} else {
-			if ((sectors > best_good_sectors) && (best_disk >= 0))
-				best_disk = -1;
-			best_good_sectors = sectors;
-		}
 
 		if (best_disk >= 0)
 			/* At least two disks to choose from so failfast is OK */
@@ -834,6 +842,15 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	if (best_disk >= 0)
 		return best_disk;
 
+	/*
+	 * If we are here it means we didn't find a perfectly good disk so
+	 * now spend a bit more time trying to find one with the most good
+	 * sectors.
+	 */
+	disk = choose_bb_rdev(conf, r1_bio, max_sectors);
+	if (disk >= 0)
+		return disk;
+
 	return choose_slow_rdev(conf, r1_bio, max_sectors);
 }
 
-- 
2.39.2


