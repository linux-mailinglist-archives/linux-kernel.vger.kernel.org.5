Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C190807EA8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443084AbjLGCh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjLGCho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:37:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9BBD68
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 18:37:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55248C4339A;
        Thu,  7 Dec 2023 02:37:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rB4HM-00000001aOg-0cKq;
        Wed, 06 Dec 2023 21:38:20 -0500
Message-ID: <20231207023819.931186714@goodmis.org>
User-Agent: quilt/0.67
Date:   Wed, 06 Dec 2023 21:37:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [for-linus][PATCH 5/8] tracing: Fix a warning when allocating buffered events fails
References: <20231207023752.712829638@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Pavlu <petr.pavlu@suse.com>

Function trace_buffered_event_disable() produces an unexpected warning
when the previous call to trace_buffered_event_enable() fails to
allocate pages for buffered events.

The situation can occur as follows:

* The counter trace_buffered_event_ref is at 0.

* The soft mode gets enabled for some event and
  trace_buffered_event_enable() is called. The function increments
  trace_buffered_event_ref to 1 and starts allocating event pages.

* The allocation fails for some page and trace_buffered_event_disable()
  is called for cleanup.

* Function trace_buffered_event_disable() decrements
  trace_buffered_event_ref back to 0, recognizes that it was the last
  use of buffered events and frees all allocated pages.

* The control goes back to trace_buffered_event_enable() which returns.
  The caller of trace_buffered_event_enable() has no information that
  the function actually failed.

* Some time later, the soft mode is disabled for the same event.
  Function trace_buffered_event_disable() is called. It warns on
  "WARN_ON_ONCE(!trace_buffered_event_ref)" and returns.

Buffered events are just an optimization and can handle failures. Make
trace_buffered_event_enable() exit on the first failure and left any
cleanup later to when trace_buffered_event_disable() is called.

Link: https://lore.kernel.org/all/20231127151248.7232-2-petr.pavlu@suse.com/
Link: https://lkml.kernel.org/r/20231205161736.19663-3-petr.pavlu@suse.com

Fixes: 0fc1b09ff1ff ("tracing: Use temp buffer when filtering events")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6aeffa4a6994..ef72354f61ce 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2728,8 +2728,11 @@ void trace_buffered_event_enable(void)
 	for_each_tracing_cpu(cpu) {
 		page = alloc_pages_node(cpu_to_node(cpu),
 					GFP_KERNEL | __GFP_NORETRY, 0);
-		if (!page)
-			goto failed;
+		/* This is just an optimization and can handle failures */
+		if (!page) {
+			pr_err("Failed to allocate event buffer\n");
+			break;
+		}
 
 		event = page_address(page);
 		memset(event, 0, sizeof(*event));
@@ -2743,10 +2746,6 @@ void trace_buffered_event_enable(void)
 			WARN_ON_ONCE(1);
 		preempt_enable();
 	}
-
-	return;
- failed:
-	trace_buffered_event_disable();
 }
 
 static void enable_trace_buffered_event(void *data)
-- 
2.42.0


