Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACEE75210C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjGMMSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjGMMSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:18:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D14269D;
        Thu, 13 Jul 2023 05:18:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E658610A6;
        Thu, 13 Jul 2023 12:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9BAC433C7;
        Thu, 13 Jul 2023 12:18:35 +0000 (UTC)
Date:   Thu, 13 Jul 2023 08:18:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tracing: Stop FORTIFY_SOURCE complaining about stack
 trace caller
Message-ID: <20230713081832.4df9e699@rorschach.local.home>
In-Reply-To: <202307122305.029E76A@keescook>
References: <20230712105235.5fc441aa@gandalf.local.home>
        <202307121618.17C50DA9A@keescook>
        <20230712204358.756d0018@gandalf.local.home>
        <202307122118.F4DD6200@keescook>
        <202307122305.029E76A@keescook>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 23:08:37 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Wed, Jul 12, 2023 at 10:22:35PM -0700, Kees Cook wrote:
> > But anyway, I think we can still do better. :)  
> 
> Okay, what about this? I'm really not sure how to test this
> appropriately, but it does appear to build. (famous last words)
> 
> This creates the union, but I think it ends up only being visible for
> trace.c; everything else thinks it's just __array.
> 
> Anyway, maybe I'm closer, but trace internals are hurting my head right
> now...

You need to wear your Macro Wizard hat to protect from brain hurt.

Anyway, I was thinking about this too, and the correct approach is this
patch. But this is something I don't want to push into the -rc release,
and instead will wait till the next merge window. I rather have the
simple pointer arithmetic for now.

But you were close. But instead of doing a union, what I did was to
expose something different to user space and for the kernel make the
dynamic array struct.

This patch is on top of the current code, but the real patch is on top
of my pointer arithmetic change. (I did a "git diff HEAD~1")

But simple testing shows that this does work.

-- Steve

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4529e264cb86..ca8d3aa1058a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3155,16 +3155,16 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 		nr_entries = stack_trace_save(fstack->calls, size, skip);
 	}
 
-	size = nr_entries * sizeof(unsigned long);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
-				    (sizeof(*entry) - sizeof(entry->caller)) + size,
+				    struct_size(entry, caller, nr_entries),
 				    trace_ctx);
 	if (!event)
 		goto out;
 	entry = ring_buffer_event_data(event);
 
-	memcpy(&entry->caller, fstack->calls, size);
 	entry->size = nr_entries;
+	memcpy(&entry->caller, fstack->calls,
+	       flex_array_size(entry, caller, nr_entries));
 
 	if (!call_filter_check_discard(call, entry, buffer, event))
 		__buffer_unlock_commit(buffer, event);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index ed7906b13f09..6f09cf3888c3 100644
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
 
