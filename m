Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFDF797E24
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjIGVzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjIGVzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:55:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C2E1BC1;
        Thu,  7 Sep 2023 14:55:49 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387LUVj3029130;
        Thu, 7 Sep 2023 21:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=8kv/5KBFirMoQvpIldrFupjSs90RuwcIRlNO3GdfkOQ=;
 b=uFuLEhF10PRIis6A8Lr9madGRieg2EQ0ZEOUeozydjmxlu3yuu0TEAMVAJ3BAWW6dQzQ
 rxufBGD2jjzvh8zx+s6Z0NhhIXFqYn8ZpUnsxSPyKzK2H38kMetjzBBqiDWqhqBZr8vc
 4/ItFFwr+D65fcCKJyTlrS+RZiOGZeA/10xbqGhmrzeslCaIJYLkLuPW0B9vlfeWn3Ua
 YFzv+nvVOy0daWqYH8Xxb2FENlEROgNVts4k1z54Wvx713u7889XzqcMq4CT0THVjV/q
 pWDjBhu0XH/DudX8vL0ZbYNued5NHn9AgegxWwrHyyWM+XdDN4SyODyLNOswX+YAly4H yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sypg0r1f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 21:55:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387KxE5q037652;
        Thu, 7 Sep 2023 21:45:53 GMT
Received: from gms-mainline-build.osdevelopmeniad.oraclevcn.com (gms-mainline-build.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.249.215])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3suugejgx8-1;
        Thu, 07 Sep 2023 21:45:53 +0000
From:   Gulam Mohamed <gulam.mohamed@oracle.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: Consider inflight IO in io accounting for high latency devices
Date:   Thu,  7 Sep 2023 21:45:52 +0000
Message-Id: <20230907214552.130636-1-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070193
X-Proofpoint-GUID: tXZXkAZ7vRaOKhvxjQn861uScoGriWAK
X-Proofpoint-ORIG-GUID: tXZXkAZ7vRaOKhvxjQn861uScoGriWAK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

The following is the fio script used to test the fix with correct results:

[global]
bs=64K
iodepth=120
direct=1
ioengine=libaio
time_based
runtime=100
numjobs=12
name=raw-randread
rw=randread

[job1]
filename=/dev/sda:/dev/sdb:/dev/sdc:/dev/sdd:/dev/sde:/dev/sdf:/dev/sdg:/dev/sdh:/dev/sdi:/dev/sdj:/dev/sdk:/dev/sdm

Results without fix
-------------------
Device   r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm
r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
sdj    413.00    0.00    25.81     0.00    0.00     0.00    0.00   0.00
26.75    0.00  11.05    64.00     0.00   1.53   63.30

Result with fix
---------------
Device   r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm
r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
sdd      257.00  0.00     16.06      0.00     0.00     0.00   0.00
0.00  101.47    0.00  26.08    64.00     0.00   3.89 100.00

Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
---
 block/blk-core.c | 7 ++++++-
 block/blk-mq.c   | 7 ++++++-
 block/blk.h      | 1 +
 block/genhd.c    | 2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9d51e9894ece..bc3be34b54fc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -953,8 +953,13 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
 				 unsigned long start_time)
 {
+	bool delta = false;
+
 	part_stat_lock();
-	update_io_ticks(bdev, start_time, false);
+	if (bdev->bd_queue->nr_hw_queues == 1) {
+		delta = !!part_in_flight(bdev);
+	}
+	update_io_ticks(bdev, start_time, delta);
 	part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec922c6bccbe..70e5763fb799 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1000,6 +1000,8 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 
 static inline void blk_account_io_start(struct request *req)
 {
+	bool delta = false;
+
 	trace_block_io_start(req);
 
 	if (blk_do_io_stat(req)) {
@@ -1015,7 +1017,10 @@ static inline void blk_account_io_start(struct request *req)
 			req->part = req->q->disk->part0;
 
 		part_stat_lock();
-		update_io_ticks(req->part, jiffies, false);
+		if (req->q->nr_hw_queues == 1) {
+			delta = !!part_in_flight(req->part);
+		}
+		update_io_ticks(req->part, jiffies, delta);
 		part_stat_unlock();
 	}
 }
diff --git a/block/blk.h b/block/blk.h
index 08a358bc0919..37f778c1c1df 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -292,6 +292,7 @@ ssize_t part_fail_store(struct device *dev, struct device_attribute *attr,
 ssize_t part_timeout_show(struct device *, struct device_attribute *, char *);
 ssize_t part_timeout_store(struct device *, struct device_attribute *,
 				const char *, size_t);
+unsigned int part_in_flight(struct block_device *part);
 
 static inline bool bio_may_exceed_limits(struct bio *bio,
 					 const struct queue_limits *lim)
diff --git a/block/genhd.c b/block/genhd.c
index cc32a0c704eb..8cf16dc7e195 100644
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
2.39.3

