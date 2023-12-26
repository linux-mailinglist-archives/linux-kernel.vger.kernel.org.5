Return-Path: <linux-kernel+bounces-11318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540C981E481
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 03:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8A71C21B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60023EA4;
	Tue, 26 Dec 2023 02:11:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD9A29;
	Tue, 26 Dec 2023 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BQ2ASig019667;
	Tue, 26 Dec 2023 10:10:28 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SzdNx1CHrz2Q6fVS;
	Tue, 26 Dec 2023 10:04:01 +0800 (CST)
Received: from tj10388pcu.spreadtrum.com (10.5.32.11) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 26 Dec 2023 10:10:25 +0800
From: Dongliang Cui <dongliang.cui@unisoc.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
	<mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: Dongliang Cui <cuidongliang390@gmail.com>,
        Hongyu Jin
	<hongyu.jin@unisoc.com>
Subject: [PATCH] block: Add ioprio to block_rq tracepoint
Date: Tue, 26 Dec 2023 10:09:10 +0800
Message-ID: <1703556550-2858-1-git-send-email-dongliang.cui@unisoc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 3BQ2ASig019667

Sometimes we need to track the processing order of
requests with ioprio set, especially when using
mq-deadline. So the ioprio of request can be useful
information.

Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
---
 include/trace/events/block.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 0e128ad..e84ff93 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -82,6 +82,7 @@
 		__field(  dev_t,	dev			)
 		__field(  sector_t,	sector			)
 		__field(  unsigned int,	nr_sector		)
+		__field(  unsigned int, ioprio			)
 		__array(  char,		rwbs,	RWBS_LEN	)
 		__dynamic_array( char,	cmd,	1		)
 	),
@@ -90,16 +91,17 @@
 		__entry->dev	   = rq->q->disk ? disk_devt(rq->q->disk) : 0;
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
+		__entry->ioprio    = rq->ioprio;
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 	),
 
-	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
+	TP_printk("%d,%d %s (%s) %llu + %u 0x%x [%d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __get_str(cmd),
 		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, 0)
+		  __entry->nr_sector, __entry->ioprio, 0)
 );
 
 DECLARE_EVENT_CLASS(block_rq_completion,
@@ -112,6 +114,7 @@
 		__field(  dev_t,	dev			)
 		__field(  sector_t,	sector			)
 		__field(  unsigned int,	nr_sector		)
+		__field(  unsigned int, ioprio			)
 		__field(  int	,	error			)
 		__array(  char,		rwbs,	RWBS_LEN	)
 		__dynamic_array( char,	cmd,	1		)
@@ -121,17 +124,19 @@
 		__entry->dev	   = rq->q->disk ? disk_devt(rq->q->disk) : 0;
 		__entry->sector    = blk_rq_pos(rq);
 		__entry->nr_sector = nr_bytes >> 9;
+		__entry->ioprio    = rq->ioprio;
 		__entry->error     = blk_status_to_errno(error);
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 	),
 
-	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
+	TP_printk("%d,%d %s (%s) %llu + %u 0x%x [%d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __get_str(cmd),
 		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->error)
+		  __entry->nr_sector, __entry->ioprio,
+		  __entry->error)
 );
 
 /**
@@ -180,6 +185,7 @@
 		__field(  sector_t,	sector			)
 		__field(  unsigned int,	nr_sector		)
 		__field(  unsigned int,	bytes			)
+		__field(  unsigned int, ioprio			)
 		__array(  char,		rwbs,	RWBS_LEN	)
 		__array(  char,         comm,   TASK_COMM_LEN   )
 		__dynamic_array( char,	cmd,	1		)
@@ -190,17 +196,19 @@
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 		__entry->bytes     = blk_rq_bytes(rq);
+		__entry->ioprio    = rq->ioprio;
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
-	TP_printk("%d,%d %s %u (%s) %llu + %u [%s]",
+	TP_printk("%d,%d %s %u (%s) %llu + %u 0x%x [%s]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __entry->bytes, __get_str(cmd),
 		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
+		  __entry->nr_sector, __entry->ioprio,
+		  __entry->comm)
 );
 
 /**
-- 
1.9.1


