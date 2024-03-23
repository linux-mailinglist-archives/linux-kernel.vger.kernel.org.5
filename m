Return-Path: <linux-kernel+bounces-112219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B104887705
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 05:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7AC1C230A4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2B2D53B;
	Sat, 23 Mar 2024 04:07:27 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B039137E;
	Sat, 23 Mar 2024 04:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711166847; cv=none; b=OG+FtMOXEyIxDG2DQ2e5O2YLALNUSKK5NzjwsBOWdEn8gus2Ja+xINVPfo0fD+pxx5qJ5fUSWSNrZJehrG8hFpLfHF5c81qrvckIwOsB2xiitKsikH+tcmWqpPQt84G1iiAOwixtBleN+cvfMpxG/liPYrMeJfTzy3x9cgiv9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711166847; c=relaxed/simple;
	bh=wlNe565EX6ITZ9VJYXWbOT+/B5W320MRVmxqr+56sGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W7awSal/pnR4yBqSxwNYU3uIIo0pWGhBa5sNiHWz1PFfzEflhRui0v6uuGJogHxStA3iM0b2UZ/J202cf6nl/ksMjmJq+dCKh7s+Jp9Iicl/yn2DAIKEc9AYuYffPki4jvccJy9aL6kOSbd6g1gYy6TcSsemaN8wF+WXDtZuY94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V1lyX0PSCz4f3kFq;
	Sat, 23 Mar 2024 12:07:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 23F0D1A0B9D;
	Sat, 23 Mar 2024 12:07:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g51Vf5lhTs2Hw--.40826S9;
	Sat, 23 Mar 2024 12:07:21 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: ming.lei@redhat.com,
	hch@lst.de,
	bvanassche@acm.org,
	axboe@kernel.dk,
	mpatocka@redhat.com,
	snitzer@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 2/2] block: remove blk_mq_in_flight() and blk_mq_in_flight_rw()
Date: Sat, 23 Mar 2024 11:59:59 +0800
Message-Id: <20240323035959.1397382-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240323035959.1397382-1-yukuai1@huaweicloud.com>
References: <20240323035959.1397382-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g51Vf5lhTs2Hw--.40826S9
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45Kr4xWr43WF4DGw4fuFg_yoWrZw1kpF
	43Ga9xArWjgr18Zr1Dta17XFy3Kws8K34xZwn3ArySyr1jkr13ZF10qrWkXrWSvrZ7AFW7
	uwn0yFyDCF18G37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Now that blk-mq also use per_cpu counter to trace inflight as bio-based
device, they can be replaced by part_in_flight() and part_in_flight_rw()
directly.

Noted that there will be a change that inflight will be accounted from
blk_account_io_start() instead of blk_mq_start_request(). This also fix
an inconsistence for rq-based device that if there are rq allocated but
not started, io_ticks will be updated from blk_account_io_start() but not
from part_stat_show() or diskstats_show(). For consequence, for example:

blk_account_io_start  -> 0s
-> something is wrong with driver, rq can't be dispatched to driver
-> finially the driver recovers
blk_mq_start_request  -> 10s

Then in this case, if user is using "iostat 1", then user will found
that 'util' is 0 from 0s-9s, because diskstats_show() doesn't update
io_ticks, then in 9s-10s user will found 'util' is 1000%.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq.c | 32 --------------------------------
 block/blk-mq.h |  5 -----
 block/genhd.c  | 18 +++---------------
 3 files changed, 3 insertions(+), 52 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 82045f0ab5ba..dfbb4e24f04a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -87,38 +87,6 @@ struct mq_inflight {
 	unsigned int inflight[2];
 };
 
-static bool blk_mq_check_inflight(struct request *rq, void *priv)
-{
-	struct mq_inflight *mi = priv;
-
-	if (rq->part && blk_do_io_stat(rq) &&
-	    (!mi->part->bd_partno || rq->part == mi->part) &&
-	    blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
-		mi->inflight[rq_data_dir(rq)]++;
-
-	return true;
-}
-
-unsigned int blk_mq_in_flight(struct request_queue *q,
-		struct block_device *part)
-{
-	struct mq_inflight mi = { .part = part };
-
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
-
-	return mi.inflight[0] + mi.inflight[1];
-}
-
-void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
-		unsigned int inflight[2])
-{
-	struct mq_inflight mi = { .part = part };
-
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
-	inflight[0] = mi.inflight[0];
-	inflight[1] = mi.inflight[1];
-}
-
 void blk_freeze_queue_start(struct request_queue *q)
 {
 	mutex_lock(&q->mq_freeze_lock);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index f75a9ecfebde..aa92e1317f18 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -236,11 +236,6 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 	return hctx->nr_ctx && hctx->tags;
 }
 
-unsigned int blk_mq_in_flight(struct request_queue *q,
-		struct block_device *part);
-void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
-		unsigned int inflight[2]);
-
 static inline void blk_mq_put_dispatch_budget(struct request_queue *q,
 					      int budget_token)
 {
diff --git a/block/genhd.c b/block/genhd.c
index 782a42718965..9c64d34b7dc3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -954,15 +954,10 @@ ssize_t part_stat_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
 {
 	struct block_device *bdev = dev_to_bdev(dev);
-	struct request_queue *q = bdev_get_queue(bdev);
 	struct disk_stats stat;
 	unsigned int inflight;
 
-	if (queue_is_mq(q))
-		inflight = blk_mq_in_flight(q, bdev);
-	else
-		inflight = part_in_flight(bdev);
-
+	inflight = part_in_flight(bdev);
 	if (inflight) {
 		part_stat_lock();
 		update_io_ticks(bdev, jiffies, true);
@@ -1003,13 +998,9 @@ ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct block_device *bdev = dev_to_bdev(dev);
-	struct request_queue *q = bdev_get_queue(bdev);
 	unsigned int inflight[2];
 
-	if (queue_is_mq(q))
-		blk_mq_in_flight_rw(q, bdev, inflight);
-	else
-		part_in_flight_rw(bdev, inflight);
+	part_in_flight_rw(bdev, inflight);
 
 	return sprintf(buf, "%8u %8u\n", inflight[0], inflight[1]);
 }
@@ -1251,11 +1242,8 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	xa_for_each(&gp->part_tbl, idx, hd) {
 		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
 			continue;
-		if (queue_is_mq(gp->queue))
-			inflight = blk_mq_in_flight(gp->queue, hd);
-		else
-			inflight = part_in_flight(hd);
 
+		inflight = part_in_flight(hd);
 		if (inflight) {
 			part_stat_lock();
 			update_io_ticks(hd, jiffies, true);
-- 
2.39.2


