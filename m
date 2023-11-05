Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19F17E146A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 17:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKEQKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 11:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjKEQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 11:10:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DE1125
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 08:10:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF42EC433C8;
        Sun,  5 Nov 2023 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699200628;
        bh=owfDd6JTzvCM2mjVDdOSlbEmkdB46BrUrZqzXjclNlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DChrFFMpRcrcTwjoa7bf2Wg2cA2IsxnVTfMWzssOMgTHcLuK6LQFafhQxAF1oGC3x
         rtCQ5U8qMxod4wcKgG4k5iQH2S2Xr0dV98/0HARMoKy6nSJCIJr6joQUN9Rt6jNiZx
         /0IC6vqqt3CJITKu1ulmp1JhYorPV5a5sq3sotVxBBwUmq3gPmgoVh8pGzoW7mw0Ut
         HbVWGEvrQ5A1NZbxX50j37FmJ7VacfCPPLZupCoKnU+RLTIvXNbAJjNiMHQhrrxfbK
         7gY7o7pa+rcUSP0XUiMWxCmwDEnozQ4Zz81wKkPig6V+V1OOY6PYbXANoq6reaS92a
         RTNrzqpAWJQaw==
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
Subject: [RFC PATCH 19/32] function_graph: Fix to check the return value of ftrace_pop_return_trace()
Date:   Mon,  6 Nov 2023 01:10:22 +0900
Message-Id: <169920062203.482486.9590838723080321966.stgit@devnote2>
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

Fix to check the return value ('ret_stack') of ftrace_pop_return_trace()
instead of passed storage ('ret') because ret_stack becomes NULL in
error case.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fgraph.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 858fb73440ec..e51695441476 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -714,7 +714,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 
 	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer);
 
-	if (unlikely(!ret)) {
+	if (unlikely(!ret_stack)) {
 		ftrace_graph_stop();
 		WARN_ON(1);
 		/* Might as well panic. What else to do? */

