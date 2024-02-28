Return-Path: <linux-kernel+bounces-84963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684386AE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589571C20C00
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B85070CB6;
	Wed, 28 Feb 2024 11:49:41 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CE70CA0;
	Wed, 28 Feb 2024 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120980; cv=none; b=jzDIoqRx8NWwodmODZ4Rrw3bLXkDcHkK53EcMjHt3nZ+3xzzbJ0PwQQm54wvCPSnS3O9rjeJTjTxUU5y79HTZ6NCEfCyZbg1fMbdjlfP7zzC7MYsQcMiPCYX9VbjBPYMh1tKmbmwG+BvxzPowfv3N+HCDHYgnKtjntxkZGo9Rm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120980; c=relaxed/simple;
	bh=Cxh4fxQ7w5CVZ5id4tlW0SqHG+Sx6hsAJJcAlSeebGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e63JZbZBJRW+/0GXwVof8l5m7LtR5582oMvI+HQK4GC+LLBP9kIL8uEcft2lpcsbuBLTvbZjyEcbS/tBBtkzWGHLnQWlboI/c8fbvcxMxigaR1S+k7YEGuRQXC9X4Gjnm+ygfrAbrQ+qZ0/I74sPlqKzFLRnEc9fvGTiPb+jUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlCM00WZlz4f3kL1;
	Wed, 28 Feb 2024 19:49:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6C1831A0283;
	Wed, 28 Feb 2024 19:49:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7IHd9l+eamFQ--.6969S12;
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
Subject: [PATCH md-6.9 v3 08/11] md/raid1: factor out choose_slow_rdev() from read_balance()
Date: Wed, 28 Feb 2024 19:43:30 +0800
Message-Id: <20240228114333.527222-9-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn9g7IHd9l+eamFQ--.6969S12
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4rKw4kZryUuF1DXw1DJrb_yoW5ZF15pa
	y3CFWSqryUXry7uws8J3yDur9aga4rGFW8GryxJw1S9r9agrZ09FWxGFyagFyUWrWrJFyU
	Xw15ZrW293WktFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
	X7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

read_balance() is hard to understand because there are too many status
and branches, and it's overlong.

This patch factor out the case to read the slow rdev from
read_balance(), there are no functional changes.

Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid1.c | 69 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 17 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index b42b947bbd34..ccf05391d597 100644
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
@@ -673,23 +720,8 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
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
@@ -808,7 +840,10 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
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


