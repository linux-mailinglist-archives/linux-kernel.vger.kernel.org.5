Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E321C7C8DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjJMT4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjJMT4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:56:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ADBB7;
        Fri, 13 Oct 2023 12:56:05 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DIEFuW021341;
        Fri, 13 Oct 2023 19:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=uTw92DM1IoWivs2nH4QEjwWmKfUHniVV5L72O7JDx7E=;
 b=mHpznbdSOiujbBJ8t22E645n4oHQfeIJiGzWyr7t4c7+4sOnOAdM7GJieyF2AsAyEdqO
 CMb4gGQrB2Wi0bwv/WDDJ9dp8mpGap2Gwo/xtfkzbRZ/kdLQn8yg3Tn0rDqVOMghxPJy
 HfhajgtYfzgSHnJRainf+XjveNO5ege10qjLTSVSQtcSG7pFnCltQp9tfPehHzhAFznL
 GvCbtRNzZwW0C6Ki3Q+/dCBoL+1fC1+/xk7N8pvsVKjnRBCVUvo3yMzrJBFD4b05zYIw
 aw6CLtuqYPiZC2iivJl2AgBByAl9f2t/ZLJFKhZtlkGM6iqVfK1nAMxYThFJJ7MySVpp Pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx8cnv20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 19:56:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DIGXx5039176;
        Fri, 13 Oct 2023 19:55:59 GMT
Received: from gms-mainline-build-2.osdevelopmeniad.oraclevcn.com (gms-mainline-build-2.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.75])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tpt0uc35g-1;
        Fri, 13 Oct 2023 19:55:59 +0000
From:   Gulam Mohamed <gulam.mohamed@oracle.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] Consider inflight IO in io accounting for high latency devices
Date:   Fri, 13 Oct 2023 19:55:59 +0000
Message-Id: <20231013195559.1306345-1-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_11,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130172
X-Proofpoint-ORIG-GUID: pQgdiy7W7ovYKlZcEnhkT1FcEEFFDyDu
X-Proofpoint-GUID: pQgdiy7W7ovYKlZcEnhkT1FcEEFFDyDu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For high latency devices,we need to take into account the inflight IOs
for calculating the disk utilization. For IO accounting in block layer
currently, the io ticks are updated (added) with '1' at the start of the
IO and delta (time difference between start and end of the IO) is added
at the end of the IO. This causes a small issue for high latency
devices.
Multiple IOs can come in before the end of the previous IOs. Suppose,
IO 'A' came in and before its completion a couple of IOs 'B', 'C', 'D'
and 'E' came in. As per the current implementation, we add only 1 to the
ioticks at IO arrival and the disk time 'stamp' is updated with current
time ('now'). Now, just after 'E' IO 'A' completion arrived. For this
completion of 'A', we update the ioticks with delta which is nothing but
"A(end_time) - E(start_time('stamp'))". Eventhough the disk was busy in
processing the IOs B,C,D also, we were missing the processing time of B,C,D
IOs to add to ioticks. This was causing the %util to show the disk
utilization incorrectly. This incorrect behavior was causing it impossible
to drive the disk utilization to 100% even for heavy load.
    
To fix this, we need to take into account the inflight IOs also for
calculating the disk utilization. While updating the ioticks when IO
arrives, check if there are any inflight IOs. If there are any inflight
IOs, then add delta to the ioticks instead of 1.
	   
This may not be an issue for low latency devices as there will be very
less difference between the start and end of an IO. Also, if we add this
inflight IO check for IO accounting of low latency devices, then it will
be an overhead and impact IO performance.
    
So, this inflight IO check will be added only to high latency devices
like HDDs and not to low latency devices like NVME. In the fix, this
distinction is made based upon the number of hardware 'queues' supported
by the disk. Usually HDDs support only 1 HW queue and NVME devices support
multiple HW queues.
	
To find if there are any inflight IOs, the fix will iterate through both
the IO tags and scheduler tags of the hardware context (hctx) to see if
they are occupied or not. If the tags taken are greater than 1 (first one,
we take it for the current IO), then we	say that there are in inflight IOs
	
The following is the fio script used to test the fix with correct results:
    
[global]
bs=64
iodepth=120
direct=1
ioengine=libaio
group_reporting
time_based
runtime=100
numjobs=1
name=raw-read
rw=randread
ignore_error=EIO:EIO
[job1]
filename=/dev/sdb
    
Results without fix
-------------------
Device  r/s     rkB/s        rrqm/s  %rrqm r_await rareq-sz   %util
sda     4001.00 256064.00     0.00   0.00   26.20    64.00    69.00
	
lat (usec): min=1639, max=295085, avg=26327.48, stdev=60948.84
    
Result with fix
---------------
	
Device  r/s     rkB/s     %rrqm r_await rareq-sz  %util
sdb    3970.00 254080.00   0.00   26.32    64.00  100.00
	
lat (usec): min=1553, max=281217, avg=26319.47, stdev=60563.99
	
Changes V1->V2:
1. Created a new function blk_mq_hctx_has_tags() instead of using
   the existing function part_in_flight()
2. This new function will check if there are any inflight IOs
   and returns true if any inflight. Else returns false

Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
---
 block/blk-core.c | 11 ++++++++++-
 block/blk-mq.c   | 50 +++++++++++++++++++++++++++++++++++++++++++++++-
 block/blk-mq.h   |  1 +
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9d51e9894ece..ea59f4f3cbdf 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -953,8 +953,17 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
 				 unsigned long start_time)
 {
+	bool inflight = false;
+	struct blk_mq_hw_ctx *hctx;
+
 	part_stat_lock();
-	update_io_ticks(bdev, start_time, false);
+
+	if (bdev->bd_queue->nr_hw_queues == 1) {
+		hctx = xa_load(&bdev->bd_queue->hctx_table, 0);
+		inflight = blk_mq_hctx_has_tags(hctx);
+	}
+
+	update_io_ticks(bdev, start_time, inflight);
 	part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1fafd54dce3c..5748327de92d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1000,6 +1000,9 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 
 static inline void blk_account_io_start(struct request *req)
 {
+	bool inflight = false;
+	struct blk_mq_hw_ctx *hctx;
+
 	trace_block_io_start(req);
 
 	if (blk_do_io_stat(req)) {
@@ -1015,7 +1018,13 @@ static inline void blk_account_io_start(struct request *req)
 			req->part = req->q->disk->part0;
 
 		part_stat_lock();
-		update_io_ticks(req->part, jiffies, false);
+
+		if (req->q->nr_hw_queues == 1) {
+			hctx = xa_load(&req->q->hctx_table, 0);
+			inflight = blk_mq_hctx_has_tags(hctx);
+		}
+
+		update_io_ticks(req->part, jiffies, inflight);
 		part_stat_unlock();
 	}
 }
@@ -3476,6 +3485,45 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 	return data.has_rq;
 }
 
+struct tags_iter_data {
+	struct blk_mq_hw_ctx *hctx;
+	unsigned tags;
+	bool has_tags;
+};
+
+static bool blk_mq_hctx_has_tag(struct request *rq, void *data)
+{
+	struct tags_iter_data *iter_data = data;
+
+	if (rq->mq_hctx != iter_data->hctx)
+		return true;
+
+	iter_data->tags++;
+
+	if (iter_data->tags > 1){
+		iter_data->has_tags = true;
+		return false;
+	}
+	return true;
+}
+
+bool blk_mq_hctx_has_tags(struct blk_mq_hw_ctx *hctx)
+{
+       struct tags_iter_data data = {
+               .hctx = hctx,
+               .has_tags = false,
+               .tags = 0,
+       };
+
+	if (hctx->sched_tags)
+		blk_mq_all_tag_iter(hctx->sched_tags, blk_mq_hctx_has_tag, &data);
+
+	if (hctx->tags && !data.has_tags)
+		blk_mq_all_tag_iter(hctx->tags, blk_mq_hctx_has_tag, &data);
+
+	return data.has_tags;
+}
+
 static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
 		struct blk_mq_hw_ctx *hctx)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 1743857e0b01..7707033dcaa2 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -240,6 +240,7 @@ unsigned int blk_mq_in_flight(struct request_queue *q,
 		struct block_device *part);
 void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
 		unsigned int inflight[2]);
+bool blk_mq_hctx_has_tags(struct blk_mq_hw_ctx *hctx);
 
 static inline void blk_mq_put_dispatch_budget(struct request_queue *q,
 					      int budget_token)
-- 
2.39.3

