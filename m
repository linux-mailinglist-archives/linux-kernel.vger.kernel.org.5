Return-Path: <linux-kernel+bounces-84964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EAE86AE42
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D36296925
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC561157E62;
	Wed, 28 Feb 2024 11:49:41 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E66CDB4;
	Wed, 28 Feb 2024 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120981; cv=none; b=slyNkaYGqIAiIoqvCWdwSAnCJJzhKdov8TH4pEuO4dv4Y9jDp22K6GPyeEpCt6gIp8b5ybtH+1zQ4FGkoWsjgYfKeUIRD6S/nNSej+2KjN1JSG3Xaidb36BfwdqJAhV2ZT6n+t6ysuMbMIxLdWq6YXI2rImDsMW0741XQuBZ4zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120981; c=relaxed/simple;
	bh=pzr8Ku2BRQFv4XCqmFV3WoGNGchB9CY78i4NXD2/Or0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nLAkcFjZKujbXb4TzrwNf5ynFkH0GsqdZpzbRKjrvgxbmrgAakS/vqRI/NzWgxcUcryQWw9wJAQ2Sh6zqq213xeo+wZquIrDXKOQ/gB3Rvase+jAk2auA8CVTbl0A9AlNLpBOESXtL2LfuDm1FE64ZMb1qsk1QBkIhOXJ2EcNdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlCM03q33z4f3kjx;
	Wed, 28 Feb 2024 19:49:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DC0371A0283;
	Wed, 28 Feb 2024 19:49:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7IHd9l+eamFQ--.6969S13;
	Wed, 28 Feb 2024 19:49:35 +0800 (CST)
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
Subject: [PATCH md-6.9 v3 09/11] md/raid1: factor out choose_bb_rdev() from read_balance()
Date: Wed, 28 Feb 2024 19:43:31 +0800
Message-Id: <20240228114333.527222-10-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn9g7IHd9l+eamFQ--.6969S13
X-Coremail-Antispam: 1UD129KBjvJXoWxZF47Ww4ftFyxtF4fWryUKFg_yoWrJF17pw
	43KFWftryUX34fWws8J3yUuryft345Ka18JryxJ3WS9r93Cr90gFW8GryYgFyUCrWrA3W7
	Zw15Zr4293WkKFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

read_balance() is hard to understand because there are too many status
and branches, and it's overlong.

This patch factor out the case to read the rdev with bad blocks from
read_balance(), there are no functional changes.

Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid1.c | 79 ++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index ccf05391d597..13cc978dc7c0 100644
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
@@ -708,8 +746,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 
 	for (disk = 0 ; disk < conf->raid_disks * 2 ; disk++) {
 		sector_t dist;
-		sector_t first_bad;
-		int bad_sectors;
 		unsigned int pending;
 
 		rdev = conf->mirrors[disk].rdev;
@@ -722,36 +758,8 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
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
@@ -843,6 +851,15 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
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


