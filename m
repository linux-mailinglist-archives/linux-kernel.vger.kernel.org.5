Return-Path: <linux-kernel+bounces-76054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BBF85F268
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA07287B97
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B3A22EEB;
	Thu, 22 Feb 2024 08:04:00 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9549B199AD;
	Thu, 22 Feb 2024 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589039; cv=none; b=G1JwExwXDDEdmgg94P2q5DRuU3JznaqMW+SLNwuq/lRdL7ZVkLq5rATi9RiT5uL4CHzTkxS9tGIQifxDL6HU/rd2oaCtZaaPxPVg+CnsHrGu7yv7sWidp1dm7jNHHBnngukktHBw5L5Jzr9wMQWF0UAnOjVQvkplM/zrxB1qjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589039; c=relaxed/simple;
	bh=Y4HmrSMKl4uVgCZbbbAiGQUuKFrzVMxDJQwIGrs9im4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDHMJD18iL6O9gW7YCOIUuY6YSanMKAai4ZP4+qAQzcNi+QjXDtbXBt6fAas2C4BcdYEgJZN1RKJsXqaMJpLSVo1JDVrjWpedTL4nF8NtpmLOVTV7Dj5WHaY4he425cSVmcTmtud7JHOmjOWwzPMgE9zwt6GoW5VzoOlfhSl6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TgQdD49BLz4f3l7M;
	Thu, 22 Feb 2024 16:03:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 94E741A0283;
	Thu, 22 Feb 2024 16:03:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBHc_9ZlnaUhEw--.37287S13;
	Thu, 22 Feb 2024 16:03:49 +0800 (CST)
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
Subject: [PATCH md-6.9 09/10] md/raid1: factor out the code to manage sequential IO
Date: Thu, 22 Feb 2024 15:58:05 +0800
Message-Id: <20240222075806.1816400-10-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBXKBHc_9ZlnaUhEw--.37287S13
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4rAw48tFW8Ww4xXw45GFg_yoW5KFWxpa
	1avwn3XrykXrnxu3y3Jr4UCryFvw1fJF48GFZ3A34Fgr9aqrW5ta18K3y3Zr97Jws3J34U
	X3Z3GrW3C3WkC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

There is no functional change for now, make read_balance() cleaner and
prepare to fix problems and refactor the handler of sequential IO.

Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 71 +++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 4694e0e71e36..223ef8d06f67 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -705,6 +705,31 @@ static int choose_slow_rdev(struct r1conf *conf, struct r1bio *r1_bio,
 	return bb_disk;
 }
 
+static bool is_sequential(struct r1conf *conf, int disk, struct r1bio *r1_bio)
+{
+	/* TODO: address issues with this check and concurrency. */
+	return conf->mirrors[disk].next_seq_sect == r1_bio->sector ||
+	       conf->mirrors[disk].head_position == r1_bio->sector;
+}
+
+/*
+ * If buffered sequential IO size exceeds optimal iosize, check if there is idle
+ * disk. If yes, choose the idle disk.
+ */
+static bool should_choose_next(struct r1conf *conf, int disk)
+{
+	struct raid1_info *mirror = &conf->mirrors[disk];
+	int opt_iosize;
+
+	if (!test_bit(Nonrot, &mirror->rdev->flags))
+		return false;
+
+	opt_iosize = bdev_io_opt(mirror->rdev->bdev) >> 9;
+	return opt_iosize > 0 && mirror->seq_start != MaxSector &&
+	       mirror->next_seq_sect > opt_iosize &&
+	       mirror->next_seq_sect - opt_iosize >= mirror->seq_start;
+}
+
 /*
  * This routine returns the disk from which the requested read should
  * be done. There is a per-array 'next expected sequential IO' sector
@@ -767,42 +792,22 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 		pending = atomic_read(&rdev->nr_pending);
 		dist = abs(this_sector - conf->mirrors[disk].head_position);
 		/* Don't change to another disk for sequential reads */
-		if (conf->mirrors[disk].next_seq_sect == this_sector
-		    || dist == 0) {
-			int opt_iosize = bdev_io_opt(rdev->bdev) >> 9;
-			struct raid1_info *mirror = &conf->mirrors[disk];
-
-			/*
-			 * If buffered sequential IO size exceeds optimal
-			 * iosize, check if there is idle disk. If yes, choose
-			 * the idle disk. read_balance could already choose an
-			 * idle disk before noticing it's a sequential IO in
-			 * this disk. This doesn't matter because this disk
-			 * will idle, next time it will be utilized after the
-			 * first disk has IO size exceeds optimal iosize. In
-			 * this way, iosize of the first disk will be optimal
-			 * iosize at least. iosize of the second disk might be
-			 * small, but not a big deal since when the second disk
-			 * starts IO, the first disk is likely still busy.
-			 */
-			if (test_bit(Nonrot, &rdev->flags) && opt_iosize > 0 &&
-			    mirror->seq_start != MaxSector &&
-			    mirror->next_seq_sect > opt_iosize &&
-			    mirror->next_seq_sect - opt_iosize >=
-			    mirror->seq_start) {
-				/*
-				 * Add 'pending' to avoid choosing this disk if
-				 * there is other idle disk.
-				 * Set 'dist' to 0, so that if there is no other
-				 * idle disk and all disks are rotational, this
-				 * disk will still be chosen.
-				 */
-				pending++;
-				dist = 0;
-			} else {
+		if (is_sequential(conf, disk, r1_bio)) {
+			if (!should_choose_next(conf, disk)) {
 				best_disk = disk;
 				break;
 			}
+
+			/*
+			 * Add 'pending' to avoid choosing this disk if there is
+			 * other idle disk.
+			 */
+			pending++;
+			/*
+			 * Set 'dist' to 0, so that if there is no other idle
+			 * disk, this disk will still be chosen.
+			 */
+			dist = 0;
 		}
 
 		if (min_pending > pending) {
-- 
2.39.2


