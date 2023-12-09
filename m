Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB97F80B6F7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 23:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjLIW4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 17:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLIW4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 17:56:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EA1F9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 14:56:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3089EC433C7;
        Sat,  9 Dec 2023 22:56:41 +0000 (UTC)
Date:   Sat, 9 Dec 2023 17:57:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Increase size of trace_marker_raw to max ring
 buffer entry
Message-ID: <20231209175716.09ac455b@gandalf.local.home>
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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
[
  Depends on: https://lore.kernel.org/linux-trace-kernel/20231209175003.63db40ab@gandalf.local.home/
]
 kernel/trace/trace.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index da837119a446..077b20e83e7c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7351,9 +7351,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	return written;
 }
 
-/* Limit it for now to 3K (including tag) */
-#define RAW_DATA_MAX_SIZE (1024*3)
-
 static ssize_t
 tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 					size_t cnt, loff_t *fpos)
@@ -7375,18 +7372,16 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
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
 
+	if (size > ring_buffer_max_event_size(buffer))
+		return -EINVAL;
+
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_RAW_DATA, size,
 					    tracing_gen_ctx());
-- 
2.42.0

