Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075E17E1468
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 17:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjKEQK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 11:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjKEQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 11:10:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118BD13E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 08:10:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31C1C433C7;
        Sun,  5 Nov 2023 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699200616;
        bh=/gBbJf7g1QrUiEN7ZPrz7W4ai3w02Yrm1jHvyS8561U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijq8qE6apP/3tEMc7xQNaT1ZgohMP5WaYkHJZJLjvfucgOnkq8r8tZKlMpnIaRzoG
         iAgl0QVwW8FRbNaoPA/aBIVbNAp1IW7ANhQrFRRo6ITaqIvkVGnn7cnFDbwRuAtGX7
         AGAMb81eNQdq7SI/g6khmRUvWkHaqrSTyUAkslVhM09Cqa/6UbPC35PM5SJQv8T0hm
         2lD1u208cjdCKzkYrE75U/ZT1OpISl8GDOQuSp9HdwT171hfKZgk3GzG6+kDoNzaP6
         b+v/jsTZnxYX4auQr1LcKkM0uowq0gHJyRNe/1l6yDnU1Ng7Z+kzrq1jNiLX6UcYx/
         0BVdFt5sbwbJw==
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
Subject: [RFC PATCH 18/32] function_graph: Fix to initalize ftrace_ops for fgraph with ftrace_graph_func
Date:   Mon,  6 Nov 2023 01:10:10 +0900
Message-Id: <169920060974.482486.15664806338999944098.stgit@devnote2>
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

Fix to initialize the ftrace_ops of fgraph_ops with ftrace_graph_func
instead of ftrace_stub.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fgraph.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 597250bd30dc..858fb73440ec 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -872,7 +872,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 void fgraph_init_ops(struct ftrace_ops *dst_ops,
 		     struct ftrace_ops *src_ops)
 {
-	dst_ops->func = ftrace_stub;
+	dst_ops->func = ftrace_graph_func;
 	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_FL_STUB;
 
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
@@ -1120,7 +1120,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 	if (!gops->ops.func) {
 		gops->ops.flags |= FTRACE_OPS_FL_STUB;
-		gops->ops.func = ftrace_stub;
+		gops->ops.func = ftrace_graph_func;
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
 		gops->ops.trampoline = FTRACE_GRAPH_TRAMP_ADDR;
 #endif

