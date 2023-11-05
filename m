Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29797E146C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 17:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjKEQKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 11:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjKEQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 11:10:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DE5E0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 08:10:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D8AC433C9;
        Sun,  5 Nov 2023 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699200639;
        bh=2WlQKdWbi99vKuQZnLhkUQgCEXy+Nfuzu2d7nEzVsTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t9r39sEcBlbf74NlrzR4B8Lle9WJaLJPkd7Yj8058moBUJM9BSEIitXmIzuxEEaXi
         xfkKEr9LFKF5//Xf6ZTafDe5ngETaGLMNpSCFrglua32coY+eWP255NG3KIJGChiJM
         0mPhZ4OmmEk0xGvLSIY6RR+Kz4+MC4xpgpuqNvffIJkR7UBCwyinyVK+eafTCP3MbP
         hE8/xAY8TcGzILkYg8YnukhSFlP5gLxADP46/f1t6q+O1md8kd0PjUFDHEwEXUGkyI
         21TvMVdjRGRPaE51PhOxqGcdeEsaN4MM+WVwTluLfRpn1M/g0G99Zs5mItY7YHZsWO
         0gnyqS2oZQ8hg==
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
Subject: [RFC PATCH 20/32] function_graph: Pass the size of reserved data when retrieving it
Date:   Mon,  6 Nov 2023 01:10:34 +0900
Message-Id: <169920063363.482486.14684899342898937044.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169920038849.482486.15796387219966662967.stgit@devnote2>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Make the fgraph_retrieve_data() returns the reverved data size via
size_byte parameter.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/ftrace.h        |    2 +-
 kernel/trace/fgraph.c         |    5 ++++-
 kernel/trace/trace_selftest.c |   10 +++++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 115758fe9fec..2e24a2611ca8 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1050,7 +1050,7 @@ struct fgraph_ops {
 };
 
 void *fgraph_reserve_data(int size_bytes);
-void *fgraph_retrieve_data(void);
+void *fgraph_retrieve_data(int *size_bytes);
 
 /*
  * Stack of return addresses for functions
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index e51695441476..0b8a1daef733 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -289,6 +289,7 @@ void *fgraph_reserve_data(int size_bytes)
 
 /**
  * fgraph_retrieve_data - Retrieve stored data from fgraph_reserve_data()
+ * @size_bytes: pointer to retrieved data size.
  *
  * This is to be called by a fgraph_ops retfunc(), to retrieve data that
  * was stored by the fgraph_ops entryfunc() on the function entry.
@@ -300,7 +301,7 @@ void *fgraph_reserve_data(int size_bytes)
  *    matching entryfunc() for the retfunc() this is called from.
  *   Or NULL if there was nothing stored.
  */
-void *fgraph_retrieve_data(void)
+void *fgraph_retrieve_data(int *size_bytes)
 {
 	unsigned long val;
 	int curr_ret_stack = current->curr_ret_stack;
@@ -313,6 +314,8 @@ void *fgraph_retrieve_data(void)
 	val = current->ret_stack[curr_ret_stack - 2];
 	if (__get_type(val) != FGRAPH_TYPE_DATA)
 		return NULL;
+	if (size_bytes)
+		*size_bytes = (__get_data(val) - 1) * sizeof(long);
 
 	return &current->ret_stack[curr_ret_stack -
 				   (__get_data(val) + 1)];
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 14966d8509ed..c656ec5b3348 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -807,15 +807,23 @@ static __init void store_return(struct ftrace_graph_ret *trace,
 	const char *type = fgraph_store_type_name;
 	long long expect = 0;
 	long long found = -1;
+	int size;
 	char *p;
 
-	p = fgraph_retrieve_data();
+	p = fgraph_retrieve_data(&size);
 	if (!p) {
 		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
 			 "Failed to retrieve %s\n", type);
 		fgraph_error_str = fgraph_error_str_buf;
 		return;
 	}
+	if (fgraph_store_size > size) {
+		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+			 "Retrieved size %d is smaller than expected %d\n",
+			 size, (int)fgraph_store_size);
+		fgraph_error_str = fgraph_error_str_buf;
+		return;
+	}
 
 	switch (fgraph_store_size) {
 	case 1:

