Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF479960B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbjIIDXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjIIDXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:23:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24AD1FEF;
        Fri,  8 Sep 2023 20:23:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95669C433C9;
        Sat,  9 Sep 2023 03:23:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qeoZZ-000YfT-0f;
        Fri, 08 Sep 2023 23:23:49 -0400
Message-ID: <20230909032349.020450746@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Sep 2023 23:16:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Zheng Yejian <zhengyejian1@huawei.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [for-linus][PATCH 05/15] tracing: Have tracing_max_latency inc the trace array ref count
References: <20230909031615.047488015@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The tracing_max_latency file points to the trace_array max_latency field.
For an instance, if the file is opened and the instance is deleted,
reading or writing to the file will cause a use after free.

Up the ref count of the trace_array when tracing_max_latency is opened.

Link: https://lkml.kernel.org/r/20230907024803.666889383@goodmis.org
Link: https://lore.kernel.org/all/1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Fixes: 8530dec63e7b4 ("tracing: Add tracing_check_open_get_tr()")
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0827037ee3b8..c8b8b4c6feaf 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1772,7 +1772,7 @@ static void trace_create_maxlat_file(struct trace_array *tr,
 	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
 	tr->d_max_latency = trace_create_file("tracing_max_latency",
 					      TRACE_MODE_WRITE,
-					      d_tracer, &tr->max_latency,
+					      d_tracer, tr,
 					      &tracing_max_lat_fops);
 }
 
@@ -1805,7 +1805,7 @@ void latency_fsnotify(struct trace_array *tr)
 
 #define trace_create_maxlat_file(tr, d_tracer)				\
 	trace_create_file("tracing_max_latency", TRACE_MODE_WRITE,	\
-			  d_tracer, &tr->max_latency, &tracing_max_lat_fops)
+			  d_tracer, tr, &tracing_max_lat_fops)
 
 #endif
 
@@ -6717,14 +6717,18 @@ static ssize_t
 tracing_max_lat_read(struct file *filp, char __user *ubuf,
 		     size_t cnt, loff_t *ppos)
 {
-	return tracing_nsecs_read(filp->private_data, ubuf, cnt, ppos);
+	struct trace_array *tr = filp->private_data;
+
+	return tracing_nsecs_read(&tr->max_latency, ubuf, cnt, ppos);
 }
 
 static ssize_t
 tracing_max_lat_write(struct file *filp, const char __user *ubuf,
 		      size_t cnt, loff_t *ppos)
 {
-	return tracing_nsecs_write(filp->private_data, ubuf, cnt, ppos);
+	struct trace_array *tr = filp->private_data;
+
+	return tracing_nsecs_write(&tr->max_latency, ubuf, cnt, ppos);
 }
 
 #endif
@@ -7778,10 +7782,11 @@ static const struct file_operations tracing_thresh_fops = {
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 static const struct file_operations tracing_max_lat_fops = {
-	.open		= tracing_open_generic,
+	.open		= tracing_open_generic_tr,
 	.read		= tracing_max_lat_read,
 	.write		= tracing_max_lat_write,
 	.llseek		= generic_file_llseek,
+	.release	= tracing_release_generic_tr,
 };
 #endif
 
-- 
2.40.1
