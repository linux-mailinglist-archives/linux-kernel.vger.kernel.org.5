Return-Path: <linux-kernel+bounces-138317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450F789EFB9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689121C22900
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F9D158D94;
	Wed, 10 Apr 2024 10:19:23 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6288154BF8;
	Wed, 10 Apr 2024 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744363; cv=none; b=j6VGhdyM9HKu/xGdXjNvp3B/N2XmKGgIB8bLSBotzd0vMnJmepdwDZk0spRVnNf1UvIYPVaQvjNfdTpssekcUTndxw3rWQ12M8Y49rcUlkQNRgqix63xKATa3GqaMqchQcyXDPk9cXoOIW+9AdhiKo/An4R5IJLgThDxwiilo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744363; c=relaxed/simple;
	bh=Wlt5TYwemaRDasTDIslgfyRVjbLy54/727IWt5nC2e0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CyXD6FVMjKx4F5dbBIb6YBaYzNpvX9NTKRHJqJq02WIyKwb4o/PdOIItOFfzK6qVz+3okf2CCjeRGz2BDTJdvzkcbYLpnp0XWafnvoCgLMxscWmfzDlP2M7dQ1KUThzu4qCbGNDNkbK/ZvN41zRzHqtv3UGmaN5RBwROnsbYqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 43AAJ6oK062742;
	Wed, 10 Apr 2024 18:19:06 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VDzJm1xS6z2MfQWC;
	Wed, 10 Apr 2024 18:16:56 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 10 Apr 2024 18:19:04 +0800
From: Dongliang Cui <dongliang.cui@unisoc.com>
To: <axboe@kernel.dk>
CC: <ke.wang@unisoc.com>, <hongyu.jin.cn@gmail.com>, <niuzhiguo84@gmail.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cuidongliang390@gmail.com>, Dongliang Cui <dongliang.cui@unisoc.com>
Subject: [PATCH] block: add max_dispatch to sysfs
Date: Wed, 10 Apr 2024 18:18:58 +0800
Message-ID: <20240410101858.1149134-1-dongliang.cui@unisoc.com>
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
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 43AAJ6oK062742

The default configuration in the current code is that when the device
is not busy, a single dispatch will attempt to pull 'nr_requests'
requests out of the schedule queue.

I tried to track the dispatch process:

COMM            TYPE    SEC_START       IOPRIO       INDEX
fio-17304       R	196798040	0x2005	     0
fio-17306       R	197060504	0x2005	     1
fio-17307       R	197346904	0x2005	     2
fio-17308       R	197609400	0x2005	     3
fio-17309       R	197873048	0x2005	     4
fio-17310       R	198134936	0x2005	     5
..
fio-17237       R	197122936	  0x0	    57
fio-17238       R	197384984	  0x0	    58
<...>-17239     R	197647128	  0x0	    59
fio-17240       R	197909208	  0x0	    60
fio-17241       R	198171320	  0x0	    61
fio-17242       R	198433432	  0x0	    62
fio-17300       R	195744088	0x2005	     0
fio-17301       R	196008504	0x2005	     0

The above data is calculated based on the block event trace, with each
column containing: process name, request type, sector start address,
IO priority.

The INDEX represents the order in which the requests are extracted from
the scheduler queue during a single dispatch process.

Some low-speed devices cannot process these requests at once, and they will
be requeued to hctx->dispatch and wait for the next issuance.

There will be a problem here, when the IO priority is enabled, if you try
to dispatch "nr_request" requests at once, the IO priority will be ignored
from the scheduler queue and all requests will be extracted.

In this scenario, if a high priority request is inserted into the scheduler
queue, it needs to wait for the low priority request in the hctx->dispatch
to be processed first.

--------------------dispatch 1st----------------------
fio-17241       R       198171320         0x0       61
fio-17242       R       198433432         0x0       62
--------------------dispatch 2nd----------------------
fio-17300       R       195744088       0x2005       0

In certain scenarios, we hope that requests can be processed in order of io
priority as much as possible.

Maybe max_dispatch should not be a fixed value, but can be adjusted
according to device conditions.

So we give a interface to control the maximum value of single dispatch
so that users can configure it according to devices characteristics.

Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq-sched.c   |  4 +++-
 block/blk-mq.c         |  3 +++
 block/blk-sysfs.c      | 32 ++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index de771093b526..f5a917085eae 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -442,6 +442,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 
 	blk_set_default_limits(&q->limits);
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
+	q->max_dispatch = BLKDEV_DEFAULT_RQ;
 
 	return q;
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 451a2c1f1f32..019958c0a4c3 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -97,7 +97,7 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 	if (hctx->dispatch_busy)
 		max_dispatch = 1;
 	else
-		max_dispatch = hctx->queue->nr_requests;
+		max_dispatch = hctx->queue->max_dispatch;
 
 	do {
 		struct request *rq;
@@ -454,6 +454,8 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
 				   BLKDEV_DEFAULT_RQ);
 
+	q->max_dispatch = q->nr_requests;
+
 	if (blk_mq_is_shared_tags(flags)) {
 		ret = blk_mq_init_sched_shared_tags(q);
 		if (ret)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2dc01551e27c..9c286001f429 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4285,6 +4285,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	spin_lock_init(&q->requeue_lock);
 
 	q->nr_requests = set->queue_depth;
+	q->max_dispatch = set->queue_depth;
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 	blk_mq_add_queue_tag_set(set, q);
@@ -4634,6 +4635,8 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	}
 	if (!ret) {
 		q->nr_requests = nr;
+		if (q->max_dispatch > nr)
+			q->max_dispatch = nr;
 		if (blk_mq_is_shared_tags(set->flags)) {
 			if (q->elevator)
 				blk_mq_tag_update_sched_shared_tags(q);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6b2429cad81a..909b5f158bd3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -100,6 +100,36 @@ queue_ra_store(struct request_queue *q, const char *page, size_t count)
 	return ret;
 }
 
+static ssize_t queue_max_dispatch_show(struct request_queue *q, char *page)
+{
+	unsigned long max_dispatch;
+
+	if (!q->disk)
+		return -EINVAL;
+	max_dispatch = q->max_dispatch;
+	return queue_var_show(max_dispatch, page);
+}
+
+static ssize_t
+queue_max_dispatch_store(struct request_queue *q, const char *page, size_t count)
+{
+	unsigned long max_dispatch;
+	ssize_t ret;
+
+	if (!q->disk)
+		return -EINVAL;
+
+	ret = queue_var_store(&max_dispatch, page, count);
+	if (ret < 0)
+		return ret;
+
+	if (max_dispatch > q->nr_requests)
+		max_dispatch = q->nr_requests;
+
+	q->max_dispatch = max_dispatch;
+	return ret;
+}
+
 static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
 {
 	int max_sectors_kb = queue_max_sectors(q) >> 1;
@@ -484,6 +514,7 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
 QUEUE_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
+QUEUE_RW_ENTRY(queue_max_dispatch, "max_dispatch");
 QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
 QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
@@ -614,6 +645,7 @@ QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
 static struct attribute *queue_attrs[] = {
 	&queue_ra_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
+	&queue_max_dispatch_entry.attr,
 	&queue_max_sectors_entry.attr,
 	&queue_max_segments_entry.attr,
 	&queue_max_discard_segments_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 99e4f5e72213..a96791b83977 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -434,6 +434,8 @@ struct request_queue {
 	 */
 	unsigned long		nr_requests;	/* Max # of requests */
 
+	unsigned long		max_dispatch;	/* Max # of single dispatch */
+
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
 	struct kobject *crypto_kobject;
-- 
2.25.1


