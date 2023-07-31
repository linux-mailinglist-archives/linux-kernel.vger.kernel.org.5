Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6962576A4AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjGaXRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjGaXRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:17:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D2E172A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8D3F61355
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6EDC433C9;
        Mon, 31 Jul 2023 23:17:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQc8P-003fKJ-0p;
        Mon, 31 Jul 2023 19:17:05 -0400
Message-ID: <20230731231705.072845526@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 19:16:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [for-next][PATCH 01/15] tracing: Add back FORTIFY_SOURCE logic to kernel_stack event
 structure
References: <20230731231634.031452225@goodmis.org>
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

For backward compatibility, older tooling expects to see the kernel_stack
event with a "caller" field that is a fixed size array of 8 addresses. The
code now supports more than 8 with an added "size" field that states the
real number of entries. But the "caller" field still just looks like a
fixed size to user space.

Since the tracing macros that create the user space format files also
creates the structures that those files represent, the kernel_stack event
structure had its "caller" field a fixed size of 8, but in reality, when
it is allocated on the ring buffer, it can hold more if the stack trace is
bigger that 8 functions. The copying of these entries was simply done with
a memcpy():

  size = nr_entries * sizeof(unsigned long);
  memcpy(entry->caller, fstack->calls, size);

The FORTIFY_SOURCE logic noticed at runtime that when the nr_entries was
larger than 8, that the memcpy() was writing more than what the structure
stated it can hold and it complained about it. This is because the
FORTIFY_SOURCE code is unaware that the amount allocated is actually
enough to hold the size. It does not expect that a fixed size field will
hold more than the fixed size.

This was originally solved by hiding the caller assignment with some
pointer arithmetic.

  ptr = ring_buffer_data();
  entry = ptr;

  ptr += offsetof(typeof(*entry), caller);
  memcpy(ptr, fstack->calls, size);

But it is considered bad form to hide from kernel hardening. Instead, make
it work nicely with FORTIFY_SOURCE by adding a new __stack_array() macro
that is specific for this one special use case. The macro will take 4
arguments: type, item, len, field (whereas the __array() macro takes just
the first three). This macro will act just like the __array() macro when
creating the code to deal with the format file that is exposed to user
space. But for the kernel, it will turn the caller field into:

  type item[] __counted_by(field);

or for this instance:

  unsigned long caller[] __counted_by(size);

Now the kernel code can expose the assignment of the caller to the
FORTIFY_SOURCE and everyone is happy!

Link: https://lore.kernel.org/linux-trace-kernel/20230712105235.5fc441aa@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20230713092605.2ddb9788@rorschach.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/trace/trace.c         | 25 ++++---------------------
 kernel/trace/trace.h         | 10 ++++++++++
 kernel/trace/trace_entries.h |  2 +-
 kernel/trace/trace_export.c  |  9 +++++++++
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8870078ef58..f6ed6b79d91f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3119,7 +3119,6 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 	struct ftrace_stack *fstack;
 	struct stack_entry *entry;
 	int stackidx;
-	void *ptr;
 
 	/*
 	 * Add one, for this function and the call to save_stack_trace()
@@ -3157,32 +3156,16 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 		nr_entries = stack_trace_save(fstack->calls, size, skip);
 	}
 
-	size = nr_entries * sizeof(unsigned long);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
-				    (sizeof(*entry) - sizeof(entry->caller)) + size,
+				    struct_size(entry, caller, nr_entries),
 				    trace_ctx);
 	if (!event)
 		goto out;
-	ptr = ring_buffer_event_data(event);
-	entry = ptr;
-
-	/*
-	 * For backward compatibility reasons, the entry->caller is an
-	 * array of 8 slots to store the stack. This is also exported
-	 * to user space. The amount allocated on the ring buffer actually
-	 * holds enough for the stack specified by nr_entries. This will
-	 * go into the location of entry->caller. Due to string fortifiers
-	 * checking the size of the destination of memcpy() it triggers
-	 * when it detects that size is greater than 8. To hide this from
-	 * the fortifiers, we use "ptr" and pointer arithmetic to assign caller.
-	 *
-	 * The below is really just:
-	 *   memcpy(&entry->caller, fstack->calls, size);
-	 */
-	ptr += offsetof(typeof(*entry), caller);
-	memcpy(ptr, fstack->calls, size);
+	entry = ring_buffer_event_data(event);
 
 	entry->size = nr_entries;
+	memcpy(&entry->caller, fstack->calls,
+	       flex_array_size(entry, caller, nr_entries));
 
 	if (!call_filter_check_discard(call, entry, buffer, event))
 		__buffer_unlock_commit(buffer, event);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e1edc2197fc8..ba7ababb8308 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -77,6 +77,16 @@ enum trace_type {
 #undef __array
 #define __array(type, item, size)	type	item[size];
 
+/*
+ * For backward compatibility, older user space expects to see the
+ * kernel_stack event with a fixed size caller field. But today the fix
+ * size is ignored by the kernel, and the real structure is dynamic.
+ * Expose to user space: "unsigned long caller[8];" but the real structure
+ * will be "unsigned long caller[] __counted_by(size)"
+ */
+#undef __stack_array
+#define __stack_array(type, item, size, field)		type item[] __counted_by(field);
+
 #undef __array_desc
 #define __array_desc(type, container, item, size)
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 340b2fa98218..c47422b20908 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -190,7 +190,7 @@ FTRACE_ENTRY(kernel_stack, stack_entry,
 
 	F_STRUCT(
 		__field(	int,		size	)
-		__array(	unsigned long,	caller,	FTRACE_STACK_ENTRIES	)
+		__stack_array(	unsigned long,	caller,	FTRACE_STACK_ENTRIES, size)
 	),
 
 	F_printk("\t=> %ps\n\t=> %ps\n\t=> %ps\n"
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 58f3946081e2..1698fc22afa0 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -51,6 +51,9 @@ static int ftrace_event_register(struct trace_event_call *call,
 #undef __array
 #define __array(type, item, size)			type item[size];
 
+#undef __stack_array
+#define __stack_array(type, item, size, field)		__array(type, item, size)
+
 #undef __array_desc
 #define __array_desc(type, container, item, size)	type item[size];
 
@@ -114,6 +117,9 @@ static void __always_unused ____ftrace_check_##name(void)		\
 	is_signed_type(_type), .filter_type = FILTER_OTHER,			\
 	.len = _len },
 
+#undef __stack_array
+#define __stack_array(_type, _item, _len, _field) __array(_type, _item, _len)
+
 #undef __array_desc
 #define __array_desc(_type, _container, _item, _len) __array(_type, _item, _len)
 
@@ -149,6 +155,9 @@ static struct trace_event_fields ftrace_event_fields_##name[] = {	\
 #undef __array
 #define __array(type, item, len)
 
+#undef __stack_array
+#define __stack_array(type, item, len, field)
+
 #undef __array_desc
 #define __array_desc(type, container, item, len)
 
-- 
2.40.1
