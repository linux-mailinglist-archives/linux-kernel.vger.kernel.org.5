Return-Path: <linux-kernel+bounces-83175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58645868FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD4E2844FE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC44145325;
	Tue, 27 Feb 2024 12:09:34 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7589013AA5C;
	Tue, 27 Feb 2024 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035773; cv=none; b=BgsyA+RDhSOpJmQzSm6spDap1r1fxNnL3Q8K/uUuGt/hVyfn3h1utKU86ine794lvhrQaQJlwkZ35zpEJb5PexHLJKwynhz1Zi7HtMzT77BPcjWfDEy0GkNd0US9OCxDjOWQ5pFxnN57Vn0IjBdZM+sCC4Afe4iWWKmPeCEkS7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035773; c=relaxed/simple;
	bh=e7VEpwjkZpubVBdOHDpFqeGrY5dOQNY4u1VlFpGkt24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wio9yh1Unaqmshar35x3TLk9Dy4s7uwlrHXRMo5EZLYZbd+5DG9se1xI42kwiOQvGIFxMtRGMxqe0KE92YwVonXYoBSTtURTPWr3BaoPndSFaCJ/Rp4za9fh6LUqmagy9Ba/p5PcWaYd0cSsRWkvdqQA+LJHQnLouuKK3aE1X9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TkbrN3gjtz4f3kKp;
	Tue, 27 Feb 2024 20:09:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D2A7E1A0232;
	Tue, 27 Feb 2024 20:09:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHv0N1lpKNAFQ--.28259S13;
	Tue, 27 Feb 2024 20:09:27 +0800 (CST)
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
Subject: [PATCH md-6.9 v2 09/10] md/raid1: factor out the code to manage sequential IO
Date: Tue, 27 Feb 2024 20:03:26 +0800
Message-Id: <20240227120327.1432511-10-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+RHv0N1lpKNAFQ--.28259S13
X-Coremail-Antispam: 1UD129KBjvJXoWxZF45JryrWF1kZw4fJr13Jwb_yoW5KrW7pa
	1avwn3XrWkXr9xu3y3Jr4UCryF9w1fGF48GFZ7A34FgrySqrW5ta18KrW3Zr97J393J34U
	X3Z3GrW7C3WkC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

There is no functional change for now, make read_balance() cleaner and
prepare to fix problems and refactor the handler of sequential IO.

Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1.c | 71 ++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 76bb59ad1485..d3e9a0157437 100644
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
@@ -768,43 +793,21 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
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
-				 */
-				pending++;
-				/*
-				 * If there is no other idle disk, this disk
-				 * will be chosen.
-				 */
-				sequential_disk = disk;
-			} else {
+		if (is_sequential(conf, disk, r1_bio)) {
+			if (!should_choose_next(conf, disk)) {
 				best_disk = disk;
 				break;
 			}
+			/*
+			 * Add 'pending' to avoid choosing this disk if
+			 * there is other idle disk.
+			 */
+			pending++;
+			/*
+			 * If there is no other idle disk, this disk
+			 * will be chosen.
+			 */
+			sequential_disk = disk;
 		}
 
 		if (min_pending > pending) {
-- 
2.39.2


