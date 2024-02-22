Return-Path: <linux-kernel+bounces-76047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE49C85F259
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604B3B2230C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2466218050;
	Thu, 22 Feb 2024 08:03:57 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673DE17BA2;
	Thu, 22 Feb 2024 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589036; cv=none; b=bg0Z54ZQg4RjFcu0+gQvI3NavqtIU9r6BT7GG0O+4MLiEj9zmf1eGaY8jq44jT016k6JapgrHxYH5nZNC/sliKBnrLDc4q5hZBFuaSqtNEWfhrKlSfaWYUZSNRhfa1wzczcbDTf4SFTNXUa6fpFT5hVwMa2znemWgl8QOrw/UP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589036; c=relaxed/simple;
	bh=Wm7tBzD2PMsXbTFZd1grk+c6wpGD0RIen3kUu8il2mM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nL4IjuDCGZ/Cvki7/IoTmvHeP7Okw7lkxLZ4CCPzuH/vzX25Degl2oyeh/nB3mSuYTtovwHWwvZY5+7Xdccq50nvtIt7FifZH88nSiAIYTxEspVPOrvVK51nx49GXD70nhJjSvypRPDOMLt7diy5DGfWrMppAZbycodboWqBdFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TgQdC4tkVz4f3l7T;
	Thu, 22 Feb 2024 16:03:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AF50D1A0175;
	Thu, 22 Feb 2024 16:03:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBHc_9ZlnaUhEw--.37287S11;
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
Subject: [PATCH md-6.9 07/10] md/raid1: factor out choose_slow_rdev() from read_balance()
Date: Thu, 22 Feb 2024 15:58:03 +0800
Message-Id: <20240222075806.1816400-8-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBXKBHc_9ZlnaUhEw--.37287S11
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4rKw4kZF4xXF15Zry8AFb_yoW5Zr1Dpa
	y3GFWftryUWry7Wws8J3ykurySga4fGay8GryxJwna9r9agrZ09ayxGFyagFyUWrWrAa4U
	Xw15ZrW293WktFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

This patch factor out the case to read the slow rdev from
read_balance(), there are no functional changes.

Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 69 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 17 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 08c45ca55a7e..bc2f8fcbe5b3 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -620,6 +620,53 @@ static int choose_first_rdev(struct r1conf *conf, struct r1bio *r1_bio,
 	return -1;
 }
 
+static int choose_slow_rdev(struct r1conf *conf, struct r1bio *r1_bio,
+			    int *max_sectors)
+{
+	sector_t this_sector = r1_bio->sector;
+	int bb_disk = -1;
+	int bb_read_len = 0;
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
+		    !test_bit(WriteMostly, &rdev->flags))
+			continue;
+
+		/* there are no bad blocks, we can use this disk */
+		len = r1_bio->sectors;
+		read_len = raid1_check_read_range(rdev, this_sector, &len);
+		if (read_len == r1_bio->sectors) {
+			update_read_sectors(conf, disk, this_sector, read_len);
+			return disk;
+		}
+
+		/*
+		 * there are partial bad blocks, choose the rdev with largest
+		 * read length.
+		 */
+		if (read_len > bb_read_len) {
+			bb_disk = disk;
+			bb_read_len = read_len;
+		}
+	}
+
+	if (bb_disk != -1) {
+		*max_sectors = bb_read_len;
+		update_read_sectors(conf, bb_disk, this_sector, bb_read_len);
+	}
+
+	return bb_disk;
+}
+
 /*
  * This routine returns the disk from which the requested read should
  * be done. There is a per-array 'next expected sequential IO' sector
@@ -672,23 +719,8 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 		if (!test_bit(In_sync, &rdev->flags) &&
 		    rdev->recovery_offset < this_sector + sectors)
 			continue;
-		if (test_bit(WriteMostly, &rdev->flags)) {
-			/* Don't balance among write-mostly, just
-			 * use the first as a last resort */
-			if (best_dist_disk < 0) {
-				if (is_badblock(rdev, this_sector, sectors,
-						&first_bad, &bad_sectors)) {
-					if (first_bad <= this_sector)
-						/* Cannot use this */
-						continue;
-					best_good_sectors = first_bad - this_sector;
-				} else
-					best_good_sectors = sectors;
-				best_dist_disk = disk;
-				best_pending_disk = disk;
-			}
+		if (test_bit(WriteMostly, &rdev->flags))
 			continue;
-		}
 		/* This is a reasonable device to use.  It might
 		 * even be best.
 		 */
@@ -799,7 +831,10 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 	}
 	*max_sectors = sectors;
 
-	return best_disk;
+	if (best_disk >= 0)
+		return best_disk;
+
+	return choose_slow_rdev(conf, r1_bio, max_sectors);
 }
 
 static void wake_up_barrier(struct r1conf *conf)
-- 
2.39.2


