Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2622480B6BB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 23:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjLIWKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 17:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIWKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 17:10:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DC7125
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 14:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4D4C433C7;
        Sat,  9 Dec 2023 22:10:23 +0000 (UTC)
Date:   Sat, 9 Dec 2023 17:10:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Have large events show up as '[LINE TOO BIG]'
 instead of nothing
Message-ID: <20231209171058.78c1a026@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If a large event was added to the ring buffer that is larger than what the
trace_seq can handle, it just drops the output:

 ~# cat /sys/kernel/tracing/trace
 # tracer: nop
 #
 # entries-in-buffer/entries-written: 2/2   #P:8
 #
 #                                _-----=> irqs-off/BH-disabled
 #                               / _----=> need-resched
 #                              | / _---=> hardirq/softirq
 #                              || / _--=> preempt-depth
 #                              ||| / _-=> migrate-disable
 #                              |||| /     delay
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
            <...>-859     [001] .....   141.118951: tracing_mark_write           <...>-859     [001] .....   141.148201: tracing_mark_write: 78901234

Instead, catch this case and add some context:

 ~# cat /sys/kernel/tracing/trace
 # tracer: nop
 #
 # entries-in-buffer/entries-written: 2/2   #P:8
 #
 #                                _-----=> irqs-off/BH-disabled
 #                               / _----=> need-resched
 #                              | / _---=> hardirq/softirq
 #                              || / _--=> preempt-depth
 #                              ||| / _-=> migrate-disable
 #                              |||| /     delay
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
            <...>-852     [001] .....   121.550551: tracing_mark_write[LINE TOO BIG]
            <...>-852     [001] .....   121.550581: tracing_mark_write: 78901234

This now emulates the same output as trace_pipe.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index fbcd3bafb93e..aa8f99f3e5de 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4722,7 +4722,11 @@ static int s_show(struct seq_file *m, void *v)
 		iter->leftover = ret;
 
 	} else {
-		print_trace_line(iter);
+		ret = print_trace_line(iter);
+		if (ret == TRACE_TYPE_PARTIAL_LINE) {
+			iter->seq.full = 0;
+			trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");
+		}
 		ret = trace_print_seq(m, &iter->seq);
 		/*
 		 * If we overflow the seq_file buffer, then it will
-- 
2.42.0

