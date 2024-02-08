Return-Path: <linux-kernel+bounces-57751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 070FC84DD02
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D761C21B05
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08926BB5B;
	Thu,  8 Feb 2024 09:32:44 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF6171B4
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384764; cv=none; b=o3woQGTWXZCxsHo22Zw7JiYnfaHmbMDeQB/Gf7BvoV7WdwvwMrwHQ7H4p3Qr60DyHr1h87KgHc+Fqqcv/a/hTHaSX9A27CDmAfWHexH080Vk/KBX+01YXQSzX6ZNAH7GngJCYPXQoA/8AtYofQFhPnBGpblf6xbreqvs2LooRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384764; c=relaxed/simple;
	bh=Z43mwuX48ZWWYGQscTT9lPoGr9fJEhXO9dvSyk7+URw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gT5csCWPTuIFRNTl0eYNFLIo4dJqjYaa6YtWBvddDjaQEuo52waSgNDQk2iX7wc//fAlK5/UdkxIRWVEippGSRljCEg8d7LUIphdWda3n+3ISH4PUHNDWWs1dY99ePtz/AaxU4lHeX3hqSz5zaEsaS++pw4Erppm+FCRxU6B/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4189VqAL048943;
	Thu, 8 Feb 2024 17:31:52 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TVsFB4n1fz2K4gjP;
	Thu,  8 Feb 2024 17:31:42 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 8 Feb 2024 17:31:49 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
        Ingo
 Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent
 Guittot <vincent.guittot@linaro.org>,
        Yu Zhao <yuzhao@google.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH 3/3] block: introducing a bias over deadline's fifo_time
Date: Thu, 8 Feb 2024 17:31:36 +0800
Message-ID: <20240208093136.178797-3-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208093136.178797-1-zhaoyang.huang@unisoc.com>
References: <20240208093136.178797-1-zhaoyang.huang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 4189VqAL048943

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

According to current policy, RT tasks possess the privilege for both of
CPU and IO scheduler which could have the preempted CFS tasks suffer big
IO-latency unfairly. This commit introduce an approximate method to
deduct the preempt affection.

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
preempted by RT task
|\
| This period time is unfair to TaskB's IO request, should be adjust
|/
submit_bio
|
|
|
fifo_time = jiffies + expire * CFS_PROPORTION(rq)
(insert_request)

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 block/mq-deadline.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..43c08c3d6f18 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -15,6 +15,7 @@
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
 #include <linux/sbitmap.h>
+#include "../kernel/sched/sched.h"
 
 #include <trace/events/block.h>
 
@@ -802,6 +803,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
 	struct dd_per_prio *per_prio;
 	enum dd_prio prio;
+	int fifo_expire;
 
 	lockdep_assert_held(&dd->lock);
 
@@ -840,7 +842,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		/*
 		 * set expire time and add to fifo list
 		 */
-		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
+		fifo_expire = task_is_realtime(current) ? dd->fifo_expire[data_dir] :
+			CFS_PROPORTION(current, dd->fifo_expire[data_dir]);
+		rq->fifo_time = jiffies + fifo_expire;
 		insert_before = &per_prio->fifo_list[data_dir];
 #ifdef CONFIG_BLK_DEV_ZONED
 		/*
-- 
2.25.1


