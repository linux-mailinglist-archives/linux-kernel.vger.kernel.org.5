Return-Path: <linux-kernel+bounces-138312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE99C89EFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA4128514F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57B3158217;
	Wed, 10 Apr 2024 10:15:15 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0331553B7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744115; cv=none; b=qT3NdLAZpMHZMSJSfTSA5/8bIOKMDuw83LaLMbYT4WN68IhLVFvOT+ylsyEN4BgM3/kukj8dLY7dCbtBRMFI23Zu/BHG+BKnLnGCK6FVgNlbiCQux1X9iaOSLN+o9zpT7oUkcq1lc2ggV2ivfXw44eM/rQBmhSTtIldxfi2bw7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744115; c=relaxed/simple;
	bh=bPj6QlcLi4XrRHYufTRYNiCGvg+NUZoj2xCvdt9IAsc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BqZ5WETgbKq6KBlUgnA9wnF/RelnIvlRC7btR27v4Y+Asb7Byu/CsFpKcZ3xRf5Mg0aRBdKnr3OMW7OgQjAQcnxaisnFA7seD78k/2/QJXIL6IgVyy59Sj/M2Q3FA4zrhVRVooX2Bv7GjqtpJZ9L3HVCRIZEiadvUQKlumwm31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 43AAElCp055314;
	Wed, 10 Apr 2024 18:14:48 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VDzCn4321z2K5bqN;
	Wed, 10 Apr 2024 18:12:37 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 10 Apr 2024 18:14:45 +0800
From: Dongliang Cui <dongliang.cui@unisoc.com>
To: <axboe@kernel.dk>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>
CC: <ke.wang@unisoc.com>, <hongyu.jin.cn@gmail.com>, <niuzhiguo84@gmail.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <cuidongliang390@gmail.com>,
        Dongliang
 Cui <dongliang.cui@unisoc.com>
Subject: [PATCH] block: Add ioprio to block_rq tracepoint
Date: Wed, 10 Apr 2024 18:14:36 +0800
Message-ID: <20240410101436.1148905-1-dongliang.cui@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 43AAElCp055314

Sometimes we need to track the processing order of requests with
ioprio set. So the ioprio of request can be useful information.

Example：

block_rq_insert: 8,0 WS 4096 () 16573296 + 8 rt,4 [highpool[1]]
block_rq_issue: 8,0 WS 4096 () 16573296 + 8 rt,4 [kworker/7:0H]
block_rq_complete: 8,0 WS () 16573296 + 8 rt,4 [0]

Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
---
 include/linux/blktrace_api.h |  2 ++
 include/trace/events/block.h | 63 ++++++++++++++++++++++--------------
 kernel/trace/blktrace.c      | 11 +++++++
 3 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 122c62e561fc..adb0333efbdb 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -112,6 +112,8 @@ struct compat_blk_user_trace_setup {
 
 void blk_fill_rwbs(char *rwbs, blk_opf_t opf);
 
+void blk_fill_ioprio(u32 ioprio, char *ioprio_class, u32 *ioprio_value);
+
 static inline sector_t blk_rq_trace_sector(struct request *rq)
 {
 	/*
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 0e128ad51460..1d41fade160a 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -10,7 +10,8 @@
 #include <linux/buffer_head.h>
 #include <linux/tracepoint.h>
 
-#define RWBS_LEN	8
+#define RWBS_LEN		8
+#define IOPRIO_CLASS_LEN	8
 
 #ifdef CONFIG_BUFFER_HEAD
 DECLARE_EVENT_CLASS(block_buffer,
@@ -79,11 +80,13 @@ TRACE_EVENT(block_rq_requeue,
 	TP_ARGS(rq),
 
 	TP_STRUCT__entry(
-		__field(  dev_t,	dev			)
-		__field(  sector_t,	sector			)
-		__field(  unsigned int,	nr_sector		)
-		__array(  char,		rwbs,	RWBS_LEN	)
-		__dynamic_array( char,	cmd,	1		)
+		__field(  dev_t,	dev				)
+		__field(  sector_t,	sector				)
+		__field(  unsigned int,	nr_sector			)
+		__array(  char,		rwbs,	RWBS_LEN		)
+		__array(  char,		ioprio_class, IOPRIO_CLASS_LEN	)
+		__field(  unsigned int, ioprio_value			)
+		__dynamic_array( char,	cmd,	1			)
 	),
 
 	TP_fast_assign(
@@ -92,14 +95,16 @@ TRACE_EVENT(block_rq_requeue,
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
+		blk_fill_ioprio(rq->ioprio, __entry->ioprio_class, &__entry->ioprio_value);
 		__get_str(cmd)[0] = '\0';
 	),
 
-	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
+	TP_printk("%d,%d %s (%s) %llu + %u %s,%u [%d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __get_str(cmd),
 		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, 0)
+		  __entry->nr_sector, __entry->ioprio_class,
+		  __entry->ioprio_value, 0)
 );
 
 DECLARE_EVENT_CLASS(block_rq_completion,
@@ -109,12 +114,14 @@ DECLARE_EVENT_CLASS(block_rq_completion,
 	TP_ARGS(rq, error, nr_bytes),
 
 	TP_STRUCT__entry(
-		__field(  dev_t,	dev			)
-		__field(  sector_t,	sector			)
-		__field(  unsigned int,	nr_sector		)
-		__field(  int	,	error			)
-		__array(  char,		rwbs,	RWBS_LEN	)
-		__dynamic_array( char,	cmd,	1		)
+		__field(  dev_t,	dev				)
+		__field(  sector_t,	sector				)
+		__field(  unsigned int,	nr_sector			)
+		__field(  int,		error				)
+		__array(  char,		rwbs,	RWBS_LEN		)
+		__array(  char,		ioprio_class, IOPRIO_CLASS_LEN	)
+		__field(  unsigned int,	ioprio_value			)
+		__dynamic_array( char,	cmd,	1			)
 	),
 
 	TP_fast_assign(
@@ -124,14 +131,16 @@ DECLARE_EVENT_CLASS(block_rq_completion,
 		__entry->error     = blk_status_to_errno(error);
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
+		blk_fill_ioprio(rq->ioprio, __entry->ioprio_class, &__entry->ioprio_value);
 		__get_str(cmd)[0] = '\0';
 	),
 
-	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
+	TP_printk("%d,%d %s (%s) %llu + %u %s,%u [%d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __get_str(cmd),
 		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->error)
+		  __entry->nr_sector, __entry->ioprio_class,
+		  __entry->ioprio_value, __entry->error)
 );
 
 /**
@@ -176,13 +185,15 @@ DECLARE_EVENT_CLASS(block_rq,
 	TP_ARGS(rq),
 
 	TP_STRUCT__entry(
-		__field(  dev_t,	dev			)
-		__field(  sector_t,	sector			)
-		__field(  unsigned int,	nr_sector		)
-		__field(  unsigned int,	bytes			)
-		__array(  char,		rwbs,	RWBS_LEN	)
-		__array(  char,         comm,   TASK_COMM_LEN   )
-		__dynamic_array( char,	cmd,	1		)
+		__field(  dev_t,	dev				)
+		__field(  sector_t,	sector				)
+		__field(  unsigned int,	nr_sector			)
+		__field(  unsigned int,	bytes				)
+		__array(  char,		rwbs,	RWBS_LEN		)
+		__array(  char,		ioprio_class, IOPRIO_CLASS_LEN	)
+		__field(  unsigned int,	ioprio_value			)
+		__array(  char,		comm,   TASK_COMM_LEN		)
+		__dynamic_array( char,	cmd,	1			)
 	),
 
 	TP_fast_assign(
@@ -192,15 +203,17 @@ DECLARE_EVENT_CLASS(block_rq,
 		__entry->bytes     = blk_rq_bytes(rq);
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
+		blk_fill_ioprio(rq->ioprio, __entry->ioprio_class, &__entry->ioprio_value);
 		__get_str(cmd)[0] = '\0';
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
-	TP_printk("%d,%d %s %u (%s) %llu + %u [%s]",
+	TP_printk("%d,%d %s %u (%s) %llu + %u %s,%u [%s]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __entry->bytes, __get_str(cmd),
 		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
+		  __entry->nr_sector, __entry->ioprio_class,
+		  __entry->ioprio_value, __entry->comm)
 );
 
 /**
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510afd3..e55aa49f94db 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -19,6 +19,7 @@
 #include <linux/uaccess.h>
 #include <linux/list.h>
 #include <linux/blk-cgroup.h>
+#include <linux/ioprio.h>
 
 #include "../../block/blk.h"
 
@@ -26,6 +27,9 @@
 
 #include "trace_output.h"
 
+/* Type of ioprio */
+static char *classes[] = {"none", "rt", "be", "idle"};
+
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 
 static unsigned int blktrace_seq __read_mostly = 1;
@@ -1914,5 +1918,12 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
 }
 EXPORT_SYMBOL_GPL(blk_fill_rwbs);
 
+void blk_fill_ioprio(u32 ioprio, char *ioprio_class, u32 *ioprio_value)
+{
+	memcpy(ioprio_class, classes[(ioprio >> IOPRIO_CLASS_SHIFT) & 0x3], IOPRIO_CLASS_LEN);
+	*ioprio_value = ioprio & 0xff;
+}
+EXPORT_SYMBOL_GPL(blk_fill_ioprio);
+
 #endif /* CONFIG_EVENT_TRACING */
 
-- 
2.25.1


