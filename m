Return-Path: <linux-kernel+bounces-144562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B948A47CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089711F225D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A311C6B9;
	Mon, 15 Apr 2024 06:08:22 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67E17BA4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161302; cv=none; b=BUWjuB0ZlrcO4BkTJBDA0wozuSN2x4h5Y8ozhuNXrXIYVVb2Yn//qtI7UTnnkMjMFrUpMWiCUjW3zsWMQXBqeaZlPg1HNJOQomRCrkoCCMpMBL8PPk8/8Mwy2ZY9QykNmWcGVI1oJHZ1Ka+E7KVHNV/c7TM3hKCJhvaQRXj4HV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161302; c=relaxed/simple;
	bh=bPj6QlcLi4XrRHYufTRYNiCGvg+NUZoj2xCvdt9IAsc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D0udB9ErHfltj0sLWjcbLDXSy8q9bg4XgiwHRLBZ9yYfyVLbuqtQ3LSiin9p9l2dAVDjUL1yDqxRqVjuG8HzOEyGQcXC75DpwRH75pE5DM7tnWyyFzlJHwoyDgK8LtIyKSBKSUUMsbda0ZohKKtKdrkC8ZxiBg4C0Y8QMJAQFL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 43F67PNl023199;
	Mon, 15 Apr 2024 14:07:25 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VHxTs55Y8z2K6J0J;
	Mon, 15 Apr 2024 14:05:05 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 15 Apr 2024 14:07:23 +0800
From: Dongliang Cui <dongliang.cui@unisoc.com>
To: <axboe@kernel.dk>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <ebiggers@kernel.org>
CC: <ke.wang@unisoc.com>, <hongyu.jin.cn@gmail.com>, <niuzhiguo84@gmail.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cuidongliang390@gmail.com>, Dongliang Cui <dongliang.cui@unisoc.com>
Subject: [PATCH RESEND] block: Add ioprio to block_rq tracepoint
Date: Mon, 15 Apr 2024 14:07:10 +0800
Message-ID: <20240415060710.1199009-1-dongliang.cui@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 43F67PNl023199

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


