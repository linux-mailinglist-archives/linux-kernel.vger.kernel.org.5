Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7FC81178D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442240AbjLMPla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442177AbjLMPl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:41:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7226BBD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:41:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B580C433C8;
        Wed, 13 Dec 2023 15:41:34 +0000 (UTC)
Date:   Wed, 13 Dec 2023 10:42:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Increase size of trace_marker_raw to max ring
 buffer entry
Message-ID: <20231213104218.2efc70c1@gandalf.local.home>
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

There's no reason to give an arbitrary limit to the size of a raw trace
marker. Just let it be as big as the size that is allowed by the ring
buffer itself.

And there's also no reason to artificially break up the write to
TRACE_BUF_SIZE, as that's not even used.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20231209175716.09ac455b@gandalf.local.home

- Moved "if (size > ring_buffer_max_event_size(buffer))" to after
  "buffer" is assigned, otherwise it creates an uninitialized warning
  error. (kernel test robot)

 kernel/trace/trace.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e07baf388ab3..95d02804d3ae 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7359,9 +7359,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	return written;
 }
 
-/* Limit it for now to 3K (including tag) */
-#define RAW_DATA_MAX_SIZE (1024*3)
-
 static ssize_t
 tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 					size_t cnt, loff_t *fpos)
@@ -7383,19 +7380,18 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 		return -EINVAL;
 
 	/* The marker must at least have a tag id */
-	if (cnt < sizeof(unsigned int) || cnt > RAW_DATA_MAX_SIZE)
+	if (cnt < sizeof(unsigned int))
 		return -EINVAL;
 
-	if (cnt > TRACE_BUF_SIZE)
-		cnt = TRACE_BUF_SIZE;
-
-	BUILD_BUG_ON(TRACE_BUF_SIZE >= PAGE_SIZE);
-
 	size = sizeof(*entry) + cnt;
 	if (cnt < FAULT_SIZE_ID)
 		size += FAULT_SIZE_ID - cnt;
 
 	buffer = tr->array_buffer.buffer;
+
+	if (size > ring_buffer_max_event_size(buffer))
+		return -EINVAL;
+
 	event = __trace_buffer_lock_reserve(buffer, TRACE_RAW_DATA, size,
 					    tracing_gen_ctx());
 	if (!event)
-- 
2.42.0

