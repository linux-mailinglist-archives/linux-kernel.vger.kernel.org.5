Return-Path: <linux-kernel+bounces-112218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBF9887704
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 05:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00DB1C2307B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80925CA73;
	Sat, 23 Mar 2024 04:07:27 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12363FE4;
	Sat, 23 Mar 2024 04:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711166846; cv=none; b=qRUYlitfKdeZ8f83VuYax9HRvgIaPrhxmdG8xAGEOqogpiCx5oyNQzVUk/sxjaAFGtJkhwXigU5VHOpkMFXsdvHLh7EBaieHVNibiiQQAeXYUpbKdbQqXqaHgrXesnV3m1cCr396ANac14J5wpfN9W/lmwvdLOJtFkGH/L3Qd5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711166846; c=relaxed/simple;
	bh=wlNe565EX6ITZ9VJYXWbOT+/B5W320MRVmxqr+56sGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nCXpim6R1FXvYN3Zx5UGwfeLFTgWxbvMz/aIvXbupGkdSe1zw5Wb8XebSLn6gNOBBrwPkAHuq+l42xWSl1+ib2pysmqq1Oa71tZOoCrCM50x3s5KW9zEyqbYlVMsutpVh9eWGzHjeqkbt5B1CBXociO8YGEIAcmbk6BAR9TLr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V1lyX4db8z4f3jkn;
	Sat, 23 Mar 2024 12:07:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 914721A0C11;
	Sat, 23 Mar 2024 12:07:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g51Vf5lhTs2Hw--.40826S6;
	Sat, 23 Mar 2024 12:07:20 +0800 (CST)
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
Date: Sat, 23 Mar 2024 11:59:56 +0800
Message-Id: <20240323035959.1397382-3-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g51Vf5lhTs2Hw--.40826S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45Kr4xWr43WF4DGw4fuFg_yoWrZw1kpF
	43Ga9xArWjgr18Zr1Dta17XFy3Kws8K34xZwn3ArySyr1jkr13ZF10qrWkXrWSvrZ7AFW7
	uwn0yFyDCF18G37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHbyAUUUUU
	=
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


