Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D0D75131F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjGLWBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjGLWBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:01:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082731FDA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87A1E61962
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA25FC433C9;
        Wed, 12 Jul 2023 22:00:58 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qJhtJ-000QkQ-2t;
        Wed, 12 Jul 2023 18:00:57 -0400
Message-ID: <20230712220057.716543026@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Jul 2023 17:50:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [for-linus][PATCH 5/5] tracing: Stop FORTIFY_SOURCE complaining about stack trace caller
References: <20230712215044.496021196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The stack_trace event is an event created by the tracing subsystem to
store stack traces. It originally just contained a hard coded array of 8
words to hold the stack, and a "size" to know how many entries are there.
This is exported to user space as:

name: kernel_stack
ID: 4
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:int size;	offset:8;	size:4;	signed:1;
	field:unsigned long caller[8];	offset:16;	size:64;	signed:0;

print fmt: "\t=> %ps\n\t=> %ps\n\t=> %ps\n" "\t=> %ps\n\t=> %ps\n\t=> %ps\n" "\t=> %ps\n\t=> %ps\n",i
 (void *)REC->caller[0], (void *)REC->caller[1], (void *)REC->caller[2],
 (void *)REC->caller[3], (void *)REC->caller[4], (void *)REC->caller[5],
 (void *)REC->caller[6], (void *)REC->caller[7]

Where the user space tracers could parse the stack. The library was
updated for this specific event to only look at the size, and not the
array. But some older users still look at the array (note, the older code
still checks to make sure the array fits inside the event that it read.
That is, if only 4 words were saved, the parser would not read the fifth
word because it will see that it was outside of the event size).

This event was changed a while ago to be more dynamic, and would save a
full stack even if it was greater than 8 words. It does this by simply
allocating more ring buffer to hold the extra words. Then it copies in the
stack via:

	memcpy(&entry->caller, fstack->calls, size);

As the entry is struct stack_entry, that is created by a macro to both
create the structure and export this to user space, it still had the caller
field of entry defined as: unsigned long caller[8].

When the stack is greater than 8, the FORTIFY_SOURCE code notices that the
amount being copied is greater than the source array and complains about
it. It has no idea that the source is pointing to the ring buffer with the
required allocation.

To hide this from the FORTIFY_SOURCE logic, pointer arithmetic is used:

	ptr = ring_buffer_event_data(event);
	entry = ptr;
	ptr += offsetof(typeof(*entry), caller);
	memcpy(ptr, fstack->calls, size);

Link: https://lore.kernel.org/all/20230612160748.4082850-1-svens@linux.ibm.com/
Link: https://lore.kernel.org/linux-trace-kernel/20230712105235.5fc441aa@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Reported-by: Sven Schnelle <svens@linux.ibm.com>
Tested-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4529e264cb86..20122eeccf97 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3118,6 +3118,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 	struct ftrace_stack *fstack;
 	struct stack_entry *entry;
 	int stackidx;
+	void *ptr;
 
 	/*
 	 * Add one, for this function and the call to save_stack_trace()
@@ -3161,9 +3162,25 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 				    trace_ctx);
 	if (!event)
 		goto out;
-	entry = ring_buffer_event_data(event);
+	ptr = ring_buffer_event_data(event);
+	entry = ptr;
+
+	/*
+	 * For backward compatibility reasons, the entry->caller is an
+	 * array of 8 slots to store the stack. This is also exported
+	 * to user space. The amount allocated on the ring buffer actually
+	 * holds enough for the stack specified by nr_entries. This will
+	 * go into the location of entry->caller. Due to string fortifiers
+	 * checking the size of the destination of memcpy() it triggers
+	 * when it detects that size is greater than 8. To hide this from
+	 * the fortifiers, we use "ptr" and pointer arithmetic to assign caller.
+	 *
+	 * The below is really just:
+	 *   memcpy(&entry->caller, fstack->calls, size);
+	 */
+	ptr += offsetof(typeof(*entry), caller);
+	memcpy(ptr, fstack->calls, size);
 
-	memcpy(&entry->caller, fstack->calls, size);
 	entry->size = nr_entries;
 
 	if (!call_filter_check_discard(call, entry, buffer, event))
-- 
2.40.1
