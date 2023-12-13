Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A500E80FBDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377748AbjLMAG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377735AbjLMAGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:06:48 -0500
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F428BE;
        Tue, 12 Dec 2023 16:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702426007; x=1733962007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W4f7NpctXKZH3cmvw+OkpzmI5P36spomZeCIdEWiFNg=;
  b=DkbR7zzfwsrmsGshX3hhRfCzBMcF7zk+VBbnG4zcEKOkwWOOS0Lfdhrw
   qlO/PG95sHD3MdIQFzZA51dRINcNWCTELZ0NXPFn9gfITZpHDHUlUZ4Iv
   HB6jDwD1t7CuMndMzQ0C/nkw4BvFnwtk7KddlrioPDHu+hm4LLRfxCDpi
   g=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="316893079"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:06:43 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 1B5EEA0AE1;
        Wed, 13 Dec 2023 00:06:38 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:30423]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.243:2525] with esmtp (Farcaster)
 id f27b5327-6195-40ac-be88-dcf792d94fa4; Wed, 13 Dec 2023 00:06:38 +0000 (UTC)
X-Farcaster-Flow-ID: f27b5327-6195-40ac-be88-dcf792d94fa4
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:06:38 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:06:34 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <x86@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        James Gowans <jgowans@amazon.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        <arnd@arndb.de>, <pbonzini@redhat.com>,
        <madvenka@linux.microsoft.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Usama Arif <usama.arif@bytedance.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 09/15] tracing: Introduce names for events
Date:   Wed, 13 Dec 2023 00:04:46 +0000
Message-ID: <20231213000452.88295-10-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000452.88295-1-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With KHO (Kexec HandOver), we want to preserve trace buffers. To parse
them, we need to ensure that all trace events that exist in the logs are
identical to the ones we parse as. That means we need to match the
events before and after kexec.

As a first step towards that, let's give every event a unique name. That
way we can clearly identify the event before and after kexec and restore
its ID post-kexec.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 include/linux/trace_events.h         |  1 +
 include/trace/trace_events.h         |  2 ++
 kernel/trace/blktrace.c              |  1 +
 kernel/trace/trace_branch.c          |  1 +
 kernel/trace/trace_events.c          |  3 +++
 kernel/trace/trace_functions_graph.c |  4 +++-
 kernel/trace/trace_output.c          | 13 +++++++++++++
 kernel/trace/trace_probe.c           |  3 +++
 kernel/trace/trace_syscalls.c        | 29 ++++++++++++++++++++++++++++
 9 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d68ff9b1247f..7670224aa92d 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -149,6 +149,7 @@ struct trace_event {
 	struct hlist_node		node;
 	int				type;
 	struct trace_event_functions	*funcs;
+	const char			*name;
 };
 
 extern int register_trace_event(struct trace_event *event);
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index c2f9cabf154d..bb4e6a33eef9 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -443,6 +443,7 @@ static struct trace_event_call __used event_##call = {			\
 		.tp			= &__tracepoint_##call,		\
 	},								\
 	.event.funcs		= &trace_event_type_funcs_##template,	\
+	.event.name		= __stringify(call),			\
 	.print_fmt		= print_fmt_##template,			\
 	.flags			= TRACE_EVENT_FL_TRACEPOINT,		\
 };									\
@@ -460,6 +461,7 @@ static struct trace_event_call __used event_##call = {			\
 		.tp			= &__tracepoint_##call,		\
 	},								\
 	.event.funcs		= &trace_event_type_funcs_##call,	\
+	.event.name		= __stringify(template),		\
 	.print_fmt		= print_fmt_##call,			\
 	.flags			= TRACE_EVENT_FL_TRACEPOINT,		\
 };									\
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510afd3..7f86fd41b38e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1584,6 +1584,7 @@ static struct trace_event_functions trace_blk_event_funcs = {
 static struct trace_event trace_blk_event = {
 	.type		= TRACE_BLK,
 	.funcs		= &trace_blk_event_funcs,
+	.name		= "blk",
 };
 
 static int __init init_blk_tracer(void)
diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index e47fdb4c92fb..3372070f2e85 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -168,6 +168,7 @@ static struct trace_event_functions trace_branch_funcs = {
 static struct trace_event trace_branch_event = {
 	.type		= TRACE_BRANCH,
 	.funcs		= &trace_branch_funcs,
+	.name		= "branch",
 };
 
 static struct tracer branch_trace __read_mostly =
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f29e815ca5b2..4f5d37f96a17 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2658,6 +2658,9 @@ static int event_init(struct trace_event_call *call)
 	if (WARN_ON(!name))
 		return -EINVAL;
 
+	if (!call->event.name)
+		call->event.name = name;
+
 	if (call->class->raw_init) {
 		ret = call->class->raw_init(call);
 		if (ret < 0 && ret != -ENOSYS)
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index c35fbaab2a47..088dfd4a1a56 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1342,11 +1342,13 @@ static struct trace_event_functions graph_functions = {
 static struct trace_event graph_trace_entry_event = {
 	.type		= TRACE_GRAPH_ENT,
 	.funcs		= &graph_functions,
+	.name		= "graph_ent",
 };
 
 static struct trace_event graph_trace_ret_event = {
 	.type		= TRACE_GRAPH_RET,
-	.funcs		= &graph_functions
+	.funcs		= &graph_functions,
+	.name		= "graph_ret",
 };
 
 static struct tracer graph_trace __tracer_data = {
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index d8b302d01083..f3677e0da795 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1067,6 +1067,7 @@ static struct trace_event_functions trace_fn_funcs = {
 static struct trace_event trace_fn_event = {
 	.type		= TRACE_FN,
 	.funcs		= &trace_fn_funcs,
+	.name		= "fn",
 };
 
 /* TRACE_CTX an TRACE_WAKE */
@@ -1207,6 +1208,7 @@ static struct trace_event_functions trace_ctx_funcs = {
 static struct trace_event trace_ctx_event = {
 	.type		= TRACE_CTX,
 	.funcs		= &trace_ctx_funcs,
+	.name		= "ctx",
 };
 
 static struct trace_event_functions trace_wake_funcs = {
@@ -1219,6 +1221,7 @@ static struct trace_event_functions trace_wake_funcs = {
 static struct trace_event trace_wake_event = {
 	.type		= TRACE_WAKE,
 	.funcs		= &trace_wake_funcs,
+	.name		= "wake",
 };
 
 /* TRACE_STACK */
@@ -1256,6 +1259,7 @@ static struct trace_event_functions trace_stack_funcs = {
 static struct trace_event trace_stack_event = {
 	.type		= TRACE_STACK,
 	.funcs		= &trace_stack_funcs,
+	.name		= "stack",
 };
 
 /* TRACE_USER_STACK */
@@ -1309,6 +1313,7 @@ static struct trace_event_functions trace_user_stack_funcs = {
 static struct trace_event trace_user_stack_event = {
 	.type		= TRACE_USER_STACK,
 	.funcs		= &trace_user_stack_funcs,
+	.name		= "user_stack",
 };
 
 /* TRACE_HWLAT */
@@ -1373,6 +1378,7 @@ static struct trace_event_functions trace_hwlat_funcs = {
 static struct trace_event trace_hwlat_event = {
 	.type		= TRACE_HWLAT,
 	.funcs		= &trace_hwlat_funcs,
+	.name		= "hwlat",
 };
 
 /* TRACE_OSNOISE */
@@ -1443,6 +1449,7 @@ static struct trace_event_functions trace_osnoise_funcs = {
 static struct trace_event trace_osnoise_event = {
 	.type		= TRACE_OSNOISE,
 	.funcs		= &trace_osnoise_funcs,
+	.name		= "osnoise",
 };
 
 /* TRACE_TIMERLAT */
@@ -1491,6 +1498,7 @@ static struct trace_event_functions trace_timerlat_funcs = {
 static struct trace_event trace_timerlat_event = {
 	.type		= TRACE_TIMERLAT,
 	.funcs		= &trace_timerlat_funcs,
+	.name		= "timerlat",
 };
 
 /* TRACE_BPUTS */
@@ -1535,6 +1543,7 @@ static struct trace_event_functions trace_bputs_funcs = {
 static struct trace_event trace_bputs_event = {
 	.type		= TRACE_BPUTS,
 	.funcs		= &trace_bputs_funcs,
+	.name		= "bputs",
 };
 
 /* TRACE_BPRINT */
@@ -1579,6 +1588,7 @@ static struct trace_event_functions trace_bprint_funcs = {
 static struct trace_event trace_bprint_event = {
 	.type		= TRACE_BPRINT,
 	.funcs		= &trace_bprint_funcs,
+	.name		= "bprint",
 };
 
 /* TRACE_PRINT */
@@ -1616,6 +1626,7 @@ static struct trace_event_functions trace_print_funcs = {
 static struct trace_event trace_print_event = {
 	.type	 	= TRACE_PRINT,
 	.funcs		= &trace_print_funcs,
+	.name		= "print",
 };
 
 static enum print_line_t trace_raw_data(struct trace_iterator *iter, int flags,
@@ -1645,6 +1656,7 @@ static struct trace_event_functions trace_raw_data_funcs = {
 static struct trace_event trace_raw_data_event = {
 	.type	 	= TRACE_RAW_DATA,
 	.funcs		= &trace_raw_data_funcs,
+	.name		= "raw_data",
 };
 
 static enum print_line_t
@@ -1691,6 +1703,7 @@ static struct trace_event_functions trace_func_repeats_funcs = {
 static struct trace_event trace_func_repeats_event = {
 	.type	 	= TRACE_FUNC_REPEATS,
 	.funcs		= &trace_func_repeats_funcs,
+	.name		= "func_repeats",
 };
 
 static struct trace_event *events[] __initdata = {
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4dc74d73fc1d..9356f3f2fdc0 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1835,6 +1835,9 @@ int trace_probe_register_event_call(struct trace_probe *tp)
 				  trace_probe_name(tp)))
 		return -EEXIST;
 
+	if (!call->event.name)
+		call->event.name = call->name;
+
 	ret = register_trace_event(&call->event);
 	if (!ret)
 		return -ENODEV;
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 9c581d6da843..3e7e10b691f5 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -441,8 +441,29 @@ static void unreg_event_syscall_exit(struct trace_event_file *file,
 	mutex_unlock(&syscall_trace_lock);
 }
 
+/**
+ * trace_csum - a simple checksum generator
+ *
+ * This returns a checksum for data that should not generate
+ * a lot of collisions, but is trivial to read.
+ */
+static u32 __init trace_csum(void *data, u32 len)
+{
+	u32 r = 0, i;
+	char *p = data;
+
+	if (!data)
+		return 0;
+
+	for (i = 0; i < len; i++)
+		r = (r >> 31) + (r << 1) + p[i];
+
+	return (r << 4) + len;
+}
+
 static int __init init_syscall_trace(struct trace_event_call *call)
 {
+	u32 csum;
 	int id;
 	int num;
 
@@ -456,9 +477,17 @@ static int __init init_syscall_trace(struct trace_event_call *call)
 	if (set_syscall_print_fmt(call) < 0)
 		return -ENOMEM;
 
+	csum = (trace_csum(call->print_fmt, strlen(call->print_fmt)) << 4) + num;
+	call->event.name = kasprintf(GFP_KERNEL, "sc-%x", csum);
+	if (!call->event.name) {
+		free_syscall_print_fmt(call);
+		return -ENOMEM;
+	}
+
 	id = trace_event_raw_init(call);
 
 	if (id < 0) {
+		kfree(call->event.name);
 		free_syscall_print_fmt(call);
 		return id;
 	}
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



