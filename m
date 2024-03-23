Return-Path: <linux-kernel+bounces-112217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80552887703
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 05:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42131C2123C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD32944E;
	Sat, 23 Mar 2024 04:07:27 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A084211C;
	Sat, 23 Mar 2024 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711166846; cv=none; b=A9q+7aRAwY2v2M9enVHIrKS5PDPyd5DHeSHrKQpuM3t4KBzo3EgWGaVBAvZanItNZs7bJ1xGcW/GO0h0IBVgXzoSGgPnI4+6xBbMSi4sYP3G/+FQmDNFJ2nIUjIaGhC/B4IhZ9VqoA9AhR7ZjE5xv9Z9XrVWo7jjOg8EbGqajGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711166846; c=relaxed/simple;
	bh=XEcNbSU9WGBQkbrarjBS+xGi8ayqQQquGvvzRVhnvG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A97cspqWcYr7xom0kDhICu73J6WX/c110lt3jILD/ykVKvaDWw0/cAx47Mcti8cM4zwHDNv5V9Q5A8zu5iInUbLmKMmPtICz6djHgu6NBR/O6sYHB+ytUX6N7tujIG+k5d2Dkz3efJ+DF1Ms2khRERb1kMqYgkiF94LH6oSmMck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V1lyV0497z4f3jsV;
	Sat, 23 Mar 2024 12:07:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 13B651A0172;
	Sat, 23 Mar 2024 12:07:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g51Vf5lhTs2Hw--.40826S5;
	Sat, 23 Mar 2024 12:07:19 +0800 (CST)
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
Subject: [PATCH 1/2] block: support to account io_ticks precisely
Date: Sat, 23 Mar 2024 11:59:55 +0800
Message-Id: <20240323035959.1397382-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX5g51Vf5lhTs2Hw--.40826S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1kWF1fur4xuw43JFWxCrg_yoWrKF15pF
	Wq93WqyrZIgr1ruFWDJa17Ja1rG3Wvk34UZ3W3Jryayr1DKr4fAF1IvrWFvrySvrZ7AFWU
	uw1UAF97Aa1q937anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4T5dUUUUU
	=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently, io_ticks is accounted based on sampling, specifically
update_io_ticks() will always account io_ticks by 1 jiffies from
bdev_start_io_acct()/blk_account_io_start(), and the result can be
inaccurate, for example(HZ is 250):

Test script:
fio -filename=/dev/sda -bs=4k -rw=write -direct=1 -name=test -thinktime=4ms

Test result: util is about 90%, while the disk is really idle.

This behaviour is introduced by commit 5b18b5a73760 ("block: delete
part_round_stats and switch to less precise counting"), however, there
was a key point that is missed that this patch also improve performance
a lot:

Before the commit:
part_round_stats:
  if (part->stamp != now)
   stats |= 1;

  part_in_flight()
  -> there can be lots of task here in 1 jiffies.
  part_round_stats_single()
   __part_stat_add()
  part->stamp = now;

After the commit:
update_io_ticks:
  stamp = part->bd_stamp;
  if (time_after(now, stamp))
   if (try_cmpxchg())
    __part_stat_add()
    -> only one task can reach here in 1 jiffies.

Hence in order to account io_ticks precisely, we only need to know if
there are IO inflight at most once in one jiffies. Noted that for
rq-based device, iterating tags should not be used here because
'tags->lock' is grabbed in blk_mq_find_and_get_req(), hence
part_stat_lock_inc/dec() and part_in_flight() is used to trace inflight.
The additional overhead is quite little:

 - per cpu add/dec for each IO for rq-based device;
 - per cpu sum for each jiffies;

And it's verified by null-blk that there are no performance degration
under heavy IO pressure.

Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c  | 9 +++++----
 block/blk-merge.c | 2 ++
 block/blk-mq.c    | 4 ++++
 block/blk.h       | 1 +
 block/genhd.c     | 2 +-
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a16b5abdbbf5..71c4d3982ef4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -985,10 +985,11 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 	unsigned long stamp;
 again:
 	stamp = READ_ONCE(part->bd_stamp);
-	if (unlikely(time_after(now, stamp))) {
-		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
-			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
-	}
+	if (unlikely(time_after(now, stamp)) &&
+	    likely(try_cmpxchg(&part->bd_stamp, &stamp, now)) &&
+	    (end || part_in_flight(part)))
+		__part_stat_add(part, io_ticks, now - stamp);
+
 	if (part->bd_partno) {
 		part = bdev_whole(part);
 		goto again;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2a06fd33039d..c96f7f612218 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -779,6 +779,8 @@ static void blk_account_io_merge_request(struct request *req)
 	if (blk_do_io_stat(req)) {
 		part_stat_lock();
 		part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
+		part_stat_local_dec(req->part,
+				    in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 555ada922cf0..82045f0ab5ba 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1002,6 +1002,8 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 		update_io_ticks(req->part, jiffies, true);
 		part_stat_inc(req->part, ios[sgrp]);
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
+		part_stat_local_dec(req->part,
+				    in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
@@ -1024,6 +1026,8 @@ static inline void blk_account_io_start(struct request *req)
 
 		part_stat_lock();
 		update_io_ticks(req->part, jiffies, false);
+		part_stat_local_inc(req->part,
+				    in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
diff --git a/block/blk.h b/block/blk.h
index 47960bf31543..5fc206ced744 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -358,6 +358,7 @@ static inline bool blk_do_io_stat(struct request *rq)
 }
 
 void update_io_ticks(struct block_device *part, unsigned long now, bool end);
+unsigned int part_in_flight(struct block_device *part);
 
 static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 {
diff --git a/block/genhd.c b/block/genhd.c
index bb29a68e1d67..782a42718965 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -118,7 +118,7 @@ static void part_stat_read_all(struct block_device *part,
 	}
 }
 
-static unsigned int part_in_flight(struct block_device *part)
+unsigned int part_in_flight(struct block_device *part)
 {
 	unsigned int inflight = 0;
 	int cpu;
-- 
2.39.2


