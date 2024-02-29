Return-Path: <linux-kernel+bounces-86506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E919686C659
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B082876FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6839266B4B;
	Thu, 29 Feb 2024 10:03:28 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B316E63CAC;
	Thu, 29 Feb 2024 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201006; cv=none; b=Y2a9nCLyMRiUAWv2dpVqPYJQNN7R2O8eT2vZ6gp4GaP/a1z67x1qg3d6LRphUkJfITr3g27qGmOgw/l1Kfx1y/t+Mm6JY4WtOBwS5+ndCbrWy5lHu0prsaYpAIgUtCLL1wJFLKJRJhNIeFYj6JvsMF+q59l9hs98oNcxwJl6Y9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201006; c=relaxed/simple;
	bh=AdfUaPu0zOXRGxRzUsboVvYzUsy/7UX1uK/3ejRkSc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9ciX+nCt+HWefOuw3N6xRx4OtfMy8AfHxPaVKfcoP+DHLwVsI0MuZ6AzKtPmVGkrNQelR1EBXhaPPamAvdxQmNBcsxHJ8Hxkt/Qw7dr9INQzSmYHccoblfYucPJGqiC/YCpQW+/e1tI1y10UKtNW4hn/5RsGkwhwqhaRSB6f5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tlmxw3CBvz4f3khh;
	Thu, 29 Feb 2024 18:03:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B03671A0232;
	Thu, 29 Feb 2024 18:03:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5hVuBlFsMHFg--.11578S14;
	Thu, 29 Feb 2024 18:03:21 +0800 (CST)
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
Subject: [PATCH md-6.9 v4 10/11] md/raid1: factor out the code to manage sequential IO
Date: Thu, 29 Feb 2024 17:57:13 +0800
Message-Id: <20240229095714.926789-11-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g5hVuBlFsMHFg--.11578S14
X-Coremail-Antispam: 1UD129KBjvJXoWxZF45XFW8tF4kGF4kuFy8Krg_yoW5KFyDpa
	1avwn3XrWkXr9xu3y3Jr4UCryS9w1fJF48GFZ7A34FgrySqrWUta18KrW3Zr97J393J34U
	X3Z3GrW7C3WkCrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
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
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/raid1.c | 71 ++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index f6e75c123e5a..17c2201d5d2b 100644
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


