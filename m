Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7097937E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjIFJSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjIFJSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:18:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54765CE2;
        Wed,  6 Sep 2023 02:18:38 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RgcCM6wDczNnDX;
        Wed,  6 Sep 2023 17:14:55 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 17:18:36 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <yeweihua4@huawei.com>, <zhengyejian1@huawei.com>
Subject: [PATCH v2] tracing: Fix unexpected ring buffer expand by instance
Date:   Wed, 6 Sep 2023 17:18:37 +0800
Message-ID: <20230906091837.3998020-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230905121744.538b92cc@gandalf.local.home>
References: <20230905121744.538b92cc@gandalf.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ring buffer of global_trace is set to the minimum size in
order to save memory on boot up and then it will be expand when
some trace feature enabled.

However currently operations under an instance can also cause
global_trace ring buffer being expanded, and the expanded memory
would be wasted if global_trace then not being used.

See following case, we enable 'sched_switch' event in instance 'A', then
ring buffer of global_trace is unexpectedly expanded to be 1410KB, also
the '(expanded: 1408)' from 'buffer_size_kb' of instance is confusing.

  # cd /sys/kernel/tracing
  # mkdir instances/A
  # cat buffer_size_kb
  7 (expanded: 1408)
  # cat instances/A/buffer_size_kb
  1410 (expanded: 1408)
  # echo sched:sched_switch > instances/A/set_event
  # cat buffer_size_kb
  1410
  # cat instances/A/buffer_size_kb
  1410

To fix it, we can:
  - Make 'ring_buffer_expanded' as a member of 'struct trace_array';
  - Make 'ring_buffer_expanded' of instance is defaultly true,
    global_trace is defaultly false;
  - In order not to expose 'global_trace' outside of file
    'kernel/trace/trace.c', introduce trace_set_ring_buffer_expanded()
    to set 'ring_buffer_expanded' as 'true';
  - Pass the expected trace_array to tracing_update_buffers().

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---

v2:
  - Add simple description for parameter 'tr' of tracing_update_buffers()
    to clean warning which Reported-by: kernel test robot <lkp@intel.com>
    Link: https://lore.kernel.org/all/202309060320.psgXz5VD-lkp@intel.com/

v1:
  - Link: https://lore.kernel.org/all/20230905121714.3229131-1-zhengyejian1@huawei.com/

 kernel/trace/trace.c        | 47 ++++++++++++++++++++-----------------
 kernel/trace/trace.h        |  9 +++++--
 kernel/trace/trace_events.c | 22 +++++++++--------
 3 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2b4ded753367..75d5863c6be8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -54,12 +54,6 @@
 #include "trace.h"
 #include "trace_output.h"
 
-/*
- * On boot up, the ring buffer is set to the minimum size, so that
- * we do not waste memory on systems that are not using tracing.
- */
-bool ring_buffer_expanded;
-
 #ifdef CONFIG_FTRACE_STARTUP_TEST
 /*
  * We need to change this state when a selftest is running.
@@ -202,7 +196,7 @@ static int __init set_cmdline_ftrace(char *str)
 	strscpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
 	default_bootup_tracer = bootup_tracer_buf;
 	/* We are using ftrace early, expand it */
-	ring_buffer_expanded = true;
+	trace_set_ring_buffer_expanded(NULL);
 	return 1;
 }
 __setup("ftrace=", set_cmdline_ftrace);
@@ -247,7 +241,7 @@ static int __init boot_alloc_snapshot(char *str)
 	} else {
 		allocate_snapshot = true;
 		/* We also need the main ring buffer expanded */
-		ring_buffer_expanded = true;
+		trace_set_ring_buffer_expanded(NULL);
 	}
 	return 1;
 }
@@ -490,6 +484,13 @@ static struct trace_array global_trace = {
 	.trace_flags = TRACE_DEFAULT_FLAGS,
 };
 
+void trace_set_ring_buffer_expanded(struct trace_array *tr)
+{
+	if (!tr)
+		tr = &global_trace;
+	tr->ring_buffer_expanded = true;
+}
+
 LIST_HEAD(ftrace_trace_arrays);
 
 int trace_array_get(struct trace_array *this_tr)
@@ -2012,7 +2013,7 @@ static int run_tracer_selftest(struct tracer *type)
 #ifdef CONFIG_TRACER_MAX_TRACE
 	if (type->use_max_tr) {
 		/* If we expanded the buffers, make sure the max is expanded too */
-		if (ring_buffer_expanded)
+		if (tr->ring_buffer_expanded)
 			ring_buffer_resize(tr->max_buffer.buffer, trace_buf_size,
 					   RING_BUFFER_ALL_CPUS);
 		tr->allocated_snapshot = true;
@@ -2038,7 +2039,7 @@ static int run_tracer_selftest(struct tracer *type)
 		tr->allocated_snapshot = false;
 
 		/* Shrink the max buffer again */
-		if (ring_buffer_expanded)
+		if (tr->ring_buffer_expanded)
 			ring_buffer_resize(tr->max_buffer.buffer, 1,
 					   RING_BUFFER_ALL_CPUS);
 	}
@@ -3403,7 +3404,7 @@ void trace_printk_init_buffers(void)
 	pr_warn("**********************************************************\n");
 
 	/* Expand the buffers to set size */
-	tracing_update_buffers();
+	tracing_update_buffers(&global_trace);
 
 	buffers_allocated = 1;
 
@@ -6347,7 +6348,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	 * we use the size that was given, and we can forget about
 	 * expanding it later.
 	 */
-	ring_buffer_expanded = true;
+	trace_set_ring_buffer_expanded(tr);
 
 	/* May be called before buffers are initialized */
 	if (!tr->array_buffer.buffer)
@@ -6425,6 +6426,7 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 
 /**
  * tracing_update_buffers - used by tracing facility to expand ring buffers
+ * @tr: The tracing instance
  *
  * To save on memory when the tracing is never used on a system with it
  * configured in. The ring buffers are set to a minimum size. But once
@@ -6433,13 +6435,13 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
  *
  * This function is to be called when a tracer is about to be used.
  */
-int tracing_update_buffers(void)
+int tracing_update_buffers(struct trace_array *tr)
 {
 	int ret = 0;
 
 	mutex_lock(&trace_types_lock);
-	if (!ring_buffer_expanded)
-		ret = __tracing_resize_ring_buffer(&global_trace, trace_buf_size,
+	if (!tr->ring_buffer_expanded)
+		ret = __tracing_resize_ring_buffer(tr, trace_buf_size,
 						RING_BUFFER_ALL_CPUS);
 	mutex_unlock(&trace_types_lock);
 
@@ -6493,7 +6495,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 
 	mutex_lock(&trace_types_lock);
 
-	if (!ring_buffer_expanded) {
+	if (!tr->ring_buffer_expanded) {
 		ret = __tracing_resize_ring_buffer(tr, trace_buf_size,
 						RING_BUFFER_ALL_CPUS);
 		if (ret < 0)
@@ -7161,7 +7163,7 @@ tracing_entries_read(struct file *filp, char __user *ubuf,
 		}
 
 		if (buf_size_same) {
-			if (!ring_buffer_expanded)
+			if (!tr->ring_buffer_expanded)
 				r = sprintf(buf, "%lu (expanded: %lu)\n",
 					    size >> 10,
 					    trace_buf_size >> 10);
@@ -7218,10 +7220,10 @@ tracing_total_entries_read(struct file *filp, char __user *ubuf,
 	mutex_lock(&trace_types_lock);
 	for_each_tracing_cpu(cpu) {
 		size += per_cpu_ptr(tr->array_buffer.data, cpu)->entries >> 10;
-		if (!ring_buffer_expanded)
+		if (!tr->ring_buffer_expanded)
 			expanded_size += trace_buf_size >> 10;
 	}
-	if (ring_buffer_expanded)
+	if (tr->ring_buffer_expanded)
 		r = sprintf(buf, "%lu\n", size);
 	else
 		r = sprintf(buf, "%lu (expanded: %lu)\n", size, expanded_size);
@@ -7615,7 +7617,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	unsigned long val;
 	int ret;
 
-	ret = tracing_update_buffers();
+	ret = tracing_update_buffers(tr);
 	if (ret < 0)
 		return ret;
 
@@ -9496,6 +9498,9 @@ static struct trace_array *trace_array_create(const char *name)
 	if (allocate_trace_buffers(tr, trace_buf_size) < 0)
 		goto out_free_tr;
 
+	/* The ring buffer is defaultly expanded */
+	trace_set_ring_buffer_expanded(tr);
+
 	if (ftrace_allocate_ftrace_ops(tr) < 0)
 		goto out_free_tr;
 
@@ -10390,7 +10395,7 @@ __init static int tracer_alloc_buffers(void)
 		trace_printk_init_buffers();
 
 	/* To save memory, keep the ring buffer size to its minimum */
-	if (ring_buffer_expanded)
+	if (global_trace.ring_buffer_expanded)
 		ring_buf_size = trace_buf_size;
 	else
 		ring_buf_size = 1;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5669dd1f90d9..c02ae9cbd108 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -410,6 +410,11 @@ struct trace_array {
 	struct cond_snapshot	*cond_snapshot;
 #endif
 	struct trace_func_repeats	__percpu *last_func_repeats;
+	/*
+	 * On boot up, the ring buffer is set to the minimum size, so that
+	 * we do not waste memory on systems that are not using tracing.
+	 */
+	bool ring_buffer_expanded;
 };
 
 enum {
@@ -759,7 +764,7 @@ extern int DYN_FTRACE_TEST_NAME(void);
 #define DYN_FTRACE_TEST_NAME2 trace_selftest_dynamic_test_func2
 extern int DYN_FTRACE_TEST_NAME2(void);
 
-extern bool ring_buffer_expanded;
+extern void trace_set_ring_buffer_expanded(struct trace_array *tr);
 extern bool tracing_selftest_disabled;
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
@@ -1303,7 +1308,7 @@ static inline void trace_branch_disable(void)
 #endif /* CONFIG_BRANCH_TRACER */
 
 /* set ring buffers to default size if not already done so */
-int tracing_update_buffers(void);
+int tracing_update_buffers(struct trace_array *tr);
 
 union trace_synth_field {
 	u8				as_u8;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index ed367d713be0..a32d50a136d8 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1179,7 +1179,7 @@ ftrace_event_write(struct file *file, const char __user *ubuf,
 	if (!cnt)
 		return 0;
 
-	ret = tracing_update_buffers();
+	ret = tracing_update_buffers(tr);
 	if (ret < 0)
 		return ret;
 
@@ -1410,18 +1410,20 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	if (ret)
 		return ret;
 
-	ret = tracing_update_buffers();
-	if (ret < 0)
-		return ret;
-
 	switch (val) {
 	case 0:
 	case 1:
 		ret = -ENODEV;
 		mutex_lock(&event_mutex);
 		file = event_file_data(filp);
-		if (likely(file))
+		if (likely(file)) {
+			ret = tracing_update_buffers(file->tr);
+			if (ret < 0) {
+				mutex_unlock(&event_mutex);
+				return ret;
+			}
 			ret = ftrace_event_enable_disable(file, val);
+		}
 		mutex_unlock(&event_mutex);
 		break;
 
@@ -1495,7 +1497,7 @@ system_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	if (ret)
 		return ret;
 
-	ret = tracing_update_buffers();
+	ret = tracing_update_buffers(dir->tr);
 	if (ret < 0)
 		return ret;
 
@@ -1969,7 +1971,7 @@ event_pid_write(struct file *filp, const char __user *ubuf,
 	if (!cnt)
 		return 0;
 
-	ret = tracing_update_buffers();
+	ret = tracing_update_buffers(tr);
 	if (ret < 0)
 		return ret;
 
@@ -2829,7 +2831,7 @@ static __init int setup_trace_triggers(char *str)
 	int i;
 
 	strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
-	ring_buffer_expanded = true;
+	trace_set_ring_buffer_expanded(NULL);
 	disable_tracing_selftest("running event triggers");
 
 	buf = bootup_trigger_buf;
@@ -3619,7 +3621,7 @@ static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
 static __init int setup_trace_event(char *str)
 {
 	strscpy(bootup_event_buf, str, COMMAND_LINE_SIZE);
-	ring_buffer_expanded = true;
+	trace_set_ring_buffer_expanded(NULL);
 	disable_tracing_selftest("running event tracing");
 
 	return 1;
-- 
2.25.1

