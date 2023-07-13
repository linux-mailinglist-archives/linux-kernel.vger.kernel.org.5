Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7292751894
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjGMGIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjGMGIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:08:42 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567CA2102
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:08:40 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b5ef64bca6so305853a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689228519; x=1691820519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pj7DUmpLML6yNU1NjHCziNlXmSGScXnxQvY9KIP6tNQ=;
        b=isWCAc3ZbnpsJfYZOTsB8HP5BC/8HTzQLCz0SLgEytqbXNa8lbxlhifbot3YkISyrA
         qPhDjPL0IZeHGAzZrliEueEKEq6BmOqOOXYM9j8VoWgBYObzjTbVtTsznq1GxQHyM8oy
         tmi5m5ZrHIHWk21bYXm/EpP5grnJpZOkHvUWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689228519; x=1691820519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj7DUmpLML6yNU1NjHCziNlXmSGScXnxQvY9KIP6tNQ=;
        b=AFMmJi2jCr+gPFLXps3EwF1hksxYlNs1njwx08nKH4A9y2754VEsqUBdTf11C5zW4v
         2gB4kQdSC0Prkz3QRFKsNJN9/1wYZxVW8fMDNEVLX0E7H31MLruKZSQAGczBMwNa5/Vz
         hqpQX4OTOTGfAIeN/ZdIuu2WkHOGzEc5lvpWLTGAOb9VvMOt2KDp37JNX9WVGga3hD1N
         UI0EqrhM2eWFF44iUFvVbexNe06LK0vfoLekiLC4vWOwL8Xzl1Bvdzx2tRrzxA11Emih
         6J8CxFsnoJSJiWz8NrU3NgihdlJZXnLh35oTO4XCHNFwQ02kxwVg03VCNUwrdjH2XeUK
         //qA==
X-Gm-Message-State: ABy/qLZfcuI+qx69i7d6nRa7IpZu683LUwXudRyANUA7f68wb1h98Gyb
        +/R/5e1Onc1iwvO+A0PU+Zy4nA==
X-Google-Smtp-Source: APBJJlEGbC8LCr2vG4gHXAU03Ecw+Q5BoCed5yb16HPqkfl2cN68fXlNjzhAoQKHsIKEr4Yg4eP5sg==
X-Received: by 2002:a9d:74cf:0:b0:6b8:dcd2:8b9e with SMTP id a15-20020a9d74cf000000b006b8dcd28b9emr828192otl.7.1689228519264;
        Wed, 12 Jul 2023 23:08:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709028f9600b001b8b2a6c4a4sm5004848plo.172.2023.07.12.23.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 23:08:38 -0700 (PDT)
Date:   Wed, 12 Jul 2023 23:08:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tracing: Stop FORTIFY_SOURCE complaining about stack
 trace caller
Message-ID: <202307122305.029E76A@keescook>
References: <20230712105235.5fc441aa@gandalf.local.home>
 <202307121618.17C50DA9A@keescook>
 <20230712204358.756d0018@gandalf.local.home>
 <202307122118.F4DD6200@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307122118.F4DD6200@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:22:35PM -0700, Kees Cook wrote:
> But anyway, I think we can still do better. :)

Okay, what about this? I'm really not sure how to test this
appropriately, but it does appear to build. (famous last words)

This creates the union, but I think it ends up only being visible for
trace.c; everything else thinks it's just __array.

Anyway, maybe I'm closer, but trace internals are hurting my head right
now...

-Kees


diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4529e264cb86..fba49d6c590c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3157,7 +3157,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 
 	size = nr_entries * sizeof(unsigned long);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
-				    (sizeof(*entry) - sizeof(entry->caller)) + size,
+				    (sizeof(*entry) - sizeof(entry->__legacy_caller)) + size,
 				    trace_ctx);
 	if (!event)
 		goto out;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index ed7906b13f09..29be88ad6227 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -83,6 +83,12 @@ enum trace_type {
 #undef __dynamic_array
 #define __dynamic_array(type, item)	type	item[];
 
+#define __min_array(type, item, size)		\
+	union {					\
+		type __legacy_ ## item[size];	\
+		DECLARE_FLEX_ARRAY(type, item);	\
+	};
+
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(type, item)	type	item[];
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 340b2fa98218..311a6c338385 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -190,7 +190,7 @@ FTRACE_ENTRY(kernel_stack, stack_entry,
 
 	F_STRUCT(
 		__field(	int,		size	)
-		__array(	unsigned long,	caller,	FTRACE_STACK_ENTRIES	)
+		__min_array(	unsigned long,	caller,	FTRACE_STACK_ENTRIES	)
 	),
 
 	F_printk("\t=> %ps\n\t=> %ps\n\t=> %ps\n"
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 58f3946081e2..8f6dcd616d85 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -57,6 +57,9 @@ static int ftrace_event_register(struct trace_event_call *call,
 #undef __dynamic_array
 #define __dynamic_array(type, item)			type item[];
 
+#undef __min_array
+#define __min_array(type, item, size)			type item[size];
+
 #undef F_STRUCT
 #define F_STRUCT(args...)				args
 
@@ -123,6 +126,9 @@ static void __always_unused ____ftrace_check_##name(void)		\
 	.size = 0, .align = __alignof__(_type),				\
 	is_signed_type(_type), .filter_type = FILTER_OTHER },
 
+#undef __min_array
+#define __min_array(_type, _item, _len) __array(_type, _item, _len)
+
 #undef FTRACE_ENTRY
 #define FTRACE_ENTRY(name, struct_name, id, tstruct, print)		\
 static struct trace_event_fields ftrace_event_fields_##name[] = {	\
@@ -155,6 +161,9 @@ static struct trace_event_fields ftrace_event_fields_##name[] = {	\
 #undef __dynamic_array
 #define __dynamic_array(type, item)
 
+#undef __min_array
+#define __min_array(type, item, len)
+
 #undef F_printk
 #define F_printk(fmt, args...) __stringify(fmt) ", "  __stringify(args)
 

-- 
Kees Cook
