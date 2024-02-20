Return-Path: <linux-kernel+bounces-72936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 531E885BAE0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8BB2B24330
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A610E6775E;
	Tue, 20 Feb 2024 11:46:42 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632F67756
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429602; cv=none; b=qyUiJSZSSJteQJDNQofAtAaUs715t8Q0Osa5jjoHZDYrHTbOJ0rXfoTLyEJLM/Yb4AQs2FNyVFl+GavTJCjVaZJ3u+/uze9+ZM02jkiXZBl5j+xskzMEy4YW3muLeCOmbdDSo3N9x+tQbZb9NRwzJw42Ow19rCl7TPZzO2g623o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429602; c=relaxed/simple;
	bh=vNZkqBTjlTdoeDozES2fdOqPQvfg/df6N1nv+ImGzOk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D0LR96KYGj6T4v1qhxL7fv2GietTxqt4/WtoZ/a2Bwc9dUbXhBweQJHjUqnYXMhjmq+t1Na0dezuqYFXI9einHkWJ269mNi6+l3GHX2u479jmePX1Bt3XiVE9uj6FUdt1JYteUolHS/fTdRNNRV3TJQ1+Kqr9y7PcByU0KHC8oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41KBjlSv037342;
	Tue, 20 Feb 2024 19:45:47 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TfHdk5cQxz2KGMyM;
	Tue, 20 Feb 2024 19:45:14 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 20 Feb 2024 19:45:46 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot
	<vincent.guittot@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCHv2 2/2] block: adjust CFS request expire time
Date: Tue, 20 Feb 2024 19:45:36 +0800
Message-ID: <20240220114536.513494-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 41KBjlSv037342

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

According to current policy, CFS's may suffer involuntary IO-latency by
being preempted by RT/DL tasks or IRQ since they possess the privilege for
both of CPU and IO scheduler. This commit introduce an approximate and
light method to decrease these affection by adjusting the expire time
via the CFS's proportion among the whole cpu active time.
The average utilization of cpu's run queue could reflect the historical
active proportion of different types of task that can be proved valid for
this goal from belowing three perspective,

1. All types of sched class's load(util) are tracked and calculated in the
same way(using a geometric series which known as PELT)
2. Keep the legacy policy by NOT adjusting rq's position in fifo_list
but only make changes over expire_time.
3. The fixed expire time(hundreds of ms) is in the same range of cpu
avg_load's account series(the utilization will be decayed to 0.5 in 32ms)

TaskA
sched in
|
|
|
submit_bio
|
|
|
fifo_time = jiffies + expire
(insert_request)

TaskB
sched in
|
|
vfs_xxx
|
|preempted by RT,DL,IRQ
|\
| This period time is unfair to TaskB's IO request, should be adjust
|/
|
submit_bio
|
|
|
fifo_time = jiffies + expire * CFS_PROPORTION(rq)
(insert_request)

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
change of v2: introduce direction and threshold to make the hack working
as a guard for CFS's over-preempted.
---
---
 block/mq-deadline.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..b5aa544d69a3 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -54,6 +54,7 @@ enum dd_prio {
 
 enum { DD_PRIO_COUNT = 3 };
 
+#define CFS_PROP_THRESHOLD 60
 /*
  * I/O statistics per I/O priority. It is fine if these counters overflow.
  * What matters is that these counters are at least as wide as
@@ -802,6 +803,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
 	struct dd_per_prio *per_prio;
 	enum dd_prio prio;
+	int fifo_expire;
 
 	lockdep_assert_held(&dd->lock);
 
@@ -839,8 +841,20 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 		/*
 		 * set expire time and add to fifo list
+		 * The expire time is adjusted when current CFS task is
+		 * over-preempted by RT/DL/IRQ which is calculated by the
+		 * proportion of CFS's activation among whole cpu time during
+		 * last several dozen's ms.Whearas, this would NOT affect the
+		 * rq's position in fifo_list but only take effect when this
+		 * rq is checked for its expire time when at head.
 		 */
-		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
+		fifo_expire = dd->fifo_expire[data_dir];
+		if (data_dir == DD_READ &&
+			(cfs_prop_by_util(current, 100) < CFS_PROP_THRESHOLD))
+			fifo_expire = cfs_prop_by_util(current, dd->fifo_expire[data_dir]);
+
+		rq->fifo_time = jiffies + fifo_expire;
+
 		insert_before = &per_prio->fifo_list[data_dir];
 #ifdef CONFIG_BLK_DEV_ZONED
 		/*
-- 
2.25.1


