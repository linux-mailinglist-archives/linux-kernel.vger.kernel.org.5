Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21927E58DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbjKHO22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbjKHO2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:28:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EE41FE6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:27:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA58C433C8;
        Wed,  8 Nov 2023 14:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699453675;
        bh=scic1c4AReJm5CEswQdYp93zWYtdZAuoXxQCoLn6I6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3ABJQPlkE6/AKdvVMkBmcx0aETkZahLXURssP/FG1i4MXurleseWQe6qWAMEiUUO
         DFb3KvNhWrA5K5aLE74PMg2BsIDOJ+riHUiGvmD/BixGjml2YInSgLP3XaTVYPa30r
         gYOJrHO1WPZnl2Gc5257simUaDO/bJ2NtkCr+lbDcQM9gEjBQgBPuCwD/qHSbEHZ/l
         5BYD/Ox4tnP8r69TdBfDTiRJxNskWAjxMxclF1lCq1+j3/XsE9oILBnMYh8ALO2CSt
         YI9Z5pL14IVahVz+O2QxX9R68uEh6YK3O2h8hUAMcABWbo0kqdoDarAK+udErwqQRP
         5b6S1nGs25WWw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH v2 18/31] function_graph: Add selftest for passing local variables
Date:   Wed,  8 Nov 2023 23:27:49 +0900
Message-Id: <169945366902.55307.16626453640949225005.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169945345785.55307.5003201137843449313.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Add boot up selftest that passes variables from a function entry to a
function exit, and make sure that they do get passed around.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Add reserved size test.
  - Use pr_*() instead of printk(KERN_*).
---
 kernel/trace/trace_selftest.c |  169 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index f0758afa2f7d..601e9d475546 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -756,6 +756,173 @@ trace_selftest_startup_function(struct tracer *trace, struct trace_array *tr)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+#define BYTE_NUMBER 123
+#define SHORT_NUMBER 12345
+#define WORD_NUMBER 1234567890
+#define LONG_NUMBER 1234567890123456789LL
+
+static int fgraph_store_size __initdata;
+static const char *fgraph_store_type_name __initdata;
+static char *fgraph_error_str __initdata;
+static char fgraph_error_str_buf[128] __initdata;
+
+static __init int store_entry(struct ftrace_graph_ent *trace,
+			      struct fgraph_ops *gops)
+{
+	const char *type = fgraph_store_type_name;
+	int size = fgraph_store_size;
+	void *p;
+
+	p = fgraph_reserve_data(size);
+	if (!p) {
+		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+			 "Failed to reserve %s\n", type);
+		fgraph_error_str = fgraph_error_str_buf;
+		return 0;
+	}
+
+	switch (fgraph_store_size) {
+	case 1:
+		*(char *)p = BYTE_NUMBER;
+		break;
+	case 2:
+		*(short *)p = SHORT_NUMBER;
+		break;
+	case 4:
+		*(int *)p = WORD_NUMBER;
+		break;
+	case 8:
+		*(long long *)p = LONG_NUMBER;
+		break;
+	}
+
+	return 1;
+}
+
+static __init void store_return(struct ftrace_graph_ret *trace,
+				struct fgraph_ops *gops)
+{
+	const char *type = fgraph_store_type_name;
+	long long expect = 0;
+	long long found = -1;
+	int size;
+	char *p;
+
+	p = fgraph_retrieve_data(&size);
+	if (!p) {
+		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+			 "Failed to retrieve %s\n", type);
+		fgraph_error_str = fgraph_error_str_buf;
+		return;
+	}
+	if (fgraph_store_size > size) {
+		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+			 "Retrieved size %d is smaller than expected %d\n",
+			 size, (int)fgraph_store_size);
+		fgraph_error_str = fgraph_error_str_buf;
+		return;
+	}
+
+	switch (fgraph_store_size) {
+	case 1:
+		expect = BYTE_NUMBER;
+		found = *(char *)p;
+		break;
+	case 2:
+		expect = SHORT_NUMBER;
+		found = *(short *)p;
+		break;
+	case 4:
+		expect = WORD_NUMBER;
+		found = *(int *)p;
+		break;
+	case 8:
+		expect = LONG_NUMBER;
+		found = *(long long *)p;
+		break;
+	}
+
+	if (found != expect) {
+		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+			 "%s returned not %lld but %lld\n", type, expect, found);
+		fgraph_error_str = fgraph_error_str_buf;
+		return;
+	}
+	fgraph_error_str = NULL;
+}
+
+static struct fgraph_ops store_bytes __initdata = {
+	.entryfunc		= store_entry,
+	.retfunc		= store_return,
+};
+
+static int __init test_graph_storage_type(const char *name, int size)
+{
+	char *func_name;
+	int len;
+	int ret;
+
+	fgraph_store_type_name = name;
+	fgraph_store_size = size;
+
+	snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+		 "Failed to execute storage %s\n", name);
+	fgraph_error_str = fgraph_error_str_buf;
+
+	pr_cont("PASSED\n");
+	pr_info("Testing fgraph storage of %d byte%s: ", size, size > 1 ? "s" : "");
+
+	func_name = "*" __stringify(DYN_FTRACE_TEST_NAME);
+	len = strlen(func_name);
+
+	ret = ftrace_set_filter(&store_bytes.ops, func_name, len, 1);
+	if (ret && ret != -ENODEV) {
+		pr_cont("*Could not set filter* ");
+		return -1;
+	}
+
+	ret = register_ftrace_graph(&store_bytes);
+	if (ret) {
+		pr_warn("Failed to init store_bytes fgraph tracing\n");
+		return -1;
+	}
+
+	DYN_FTRACE_TEST_NAME();
+
+	unregister_ftrace_graph(&store_bytes);
+
+	if (fgraph_error_str) {
+		pr_cont("*** %s ***", fgraph_error_str);
+		return -1;
+	}
+
+	return 0;
+}
+/* Test the storage passed across function_graph entry and return */
+static __init int test_graph_storage(void)
+{
+	int ret;
+
+	ret = test_graph_storage_type("byte", 1);
+	if (ret)
+		return ret;
+	ret = test_graph_storage_type("short", 2);
+	if (ret)
+		return ret;
+	ret = test_graph_storage_type("word", 4);
+	if (ret)
+		return ret;
+	ret = test_graph_storage_type("long long", 8);
+	if (ret)
+		return ret;
+	return 0;
+}
+#else
+static inline int test_graph_storage(void) { return 0; }
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
 /* Maximum number of functions to trace before diagnosing a hang */
 #define GRAPH_MAX_FUNC_TEST	100000000
 
@@ -913,6 +1080,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	ftrace_set_global_filter(NULL, 0, 1);
 #endif
 
+	ret = test_graph_storage();
+
 	/* Don't test dynamic tracing, the function tracer already did */
 out:
 	/* Stop it if we failed */

