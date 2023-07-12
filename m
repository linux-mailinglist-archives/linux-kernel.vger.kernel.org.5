Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E3275148B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGLXgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjGLXgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:36:33 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1DCE5C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:36:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b89cfb4571so1151245ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689204992; x=1691796992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ll6Egkvdw2XyI4so+MOhb7XgcVZS6w6LMYmZVyMYbQM=;
        b=EvWAqBuAjMo2D/p0FfsOP7AkCPpRCE2ExmAlSk2HcUMyIM+qDEQh7UbCh0pcmmQ9sA
         4gKF6uACA1jK1lvqgzQlWb8dWAs3G5Q2xMel5fec6/BK8DHHQ3yoCH5K5ptWZhsnW2ZT
         VMkkTsPOxWYa5iGyEMc77CzpB8gD+WFiVHl/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689204992; x=1691796992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ll6Egkvdw2XyI4so+MOhb7XgcVZS6w6LMYmZVyMYbQM=;
        b=lXxReu1LCP1D/bVEut+mgeELRE72LocZUb5+Ox66iClQUnAIynO78XVFj3Y9UJ9T4/
         p6P5P9cwcnvVLzh+f/N5mzdSNsq/cWxmHnbDg/kBBFjoo5oR+XpO+88N0IgiXAbRlmxW
         xSTlrZ1TqMRnl2Up+dDN629KHDBBxBYcRcrKApMXWo7ipnWobilejVMt8qi/HCArbxpb
         Bk2+5tkXMrqj40/S7SiTL7Zvqje2Ql+XX9hDzGm11ulYAFuQ3Dt5Aci1x4e1SBOeOCKP
         i3cX4G5Jy8L531HNIP6SUDdJtMtScBY+mP4HbyPhj5wibiaUvupFKVIYjrQDUKSb0Fzj
         X13Q==
X-Gm-Message-State: ABy/qLb5NYcWM8bmVh6aOJLPW3e27mLzbRJAXcEAEPXJx+INDnwYIL+E
        Olj3W2tuAxrpTbBspNJDnMA56xU/DDFZCInXdqQ=
X-Google-Smtp-Source: APBJJlEg26bT/ZreZ3OjixGX6J28q0p1B3HYJDHPD3+vFlnQueXm3novf7lQJltaKSGxuvJM5xp8eg==
X-Received: by 2002:a17:903:11cc:b0:1b3:c4c1:ec4f with SMTP id q12-20020a17090311cc00b001b3c4c1ec4fmr106374plh.37.1689204991746;
        Wed, 12 Jul 2023 16:36:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ja22-20020a170902efd600b001b8c6662094sm4509001plb.188.2023.07.12.16.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:36:30 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:36:30 -0700
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
Message-ID: <202307121618.17C50DA9A@keescook>
References: <20230712105235.5fc441aa@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712105235.5fc441aa@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:52:35AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The stack_trace event is an event created by the tracing subsystem to
> store stack traces. It originally just contained a hard coded array of 8
> words to hold the stack, and a "size" to know how many entries are there.
> This is exported to user space as:
> 
> name: kernel_stack
> ID: 4
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:int size;	offset:8;	size:4;	signed:1;
> 	field:unsigned long caller[8];	offset:16;	size:64;	signed:0;
> 
> print fmt: "\t=> %ps\n\t=> %ps\n\t=> %ps\n" "\t=> %ps\n\t=> %ps\n\t=> %ps\n" "\t=> %ps\n\t=> %ps\n",i
>  (void *)REC->caller[0], (void *)REC->caller[1], (void *)REC->caller[2],
>  (void *)REC->caller[3], (void *)REC->caller[4], (void *)REC->caller[5],
>  (void *)REC->caller[6], (void *)REC->caller[7]
> 
> Where the user space tracers could parse the stack. The library was
> updated for this specific event to only look at the size, and not the
> array. But some older users still look at the array (note, the older code
> still checks to make sure the array fits inside the event that it read.
> That is, if only 4 words were saved, the parser would not read the fifth
> word because it will see that it was outside of the event size).
> 
> This event was changed a while ago to be more dynamic, and would save a
> full stack even if it was greater than 8 words. It does this by simply
> allocating more ring buffer to hold the extra words. Then it copies in the
> stack via:
> 
> 	memcpy(&entry->caller, fstack->calls, size);
> 
> As the entry is struct stack_entry, that is created by a macro to both
> create the structure and export this to user space, it still had the caller
> field of entry defined as: unsigned long caller[8].
> 
> When the stack is greater than 8, the FORTIFY_SOURCE code notices that the
> amount being copied is greater than the source array and complains about
> it. It has no idea that the source is pointing to the ring buffer with the
> required allocation.
> 
> To hide this from the FORTIFY_SOURCE logic, pointer arithmetic is used:
> 
> 	ptr = ring_buffer_event_data(event);
> 	entry = ptr;
> 	ptr += offsetof(typeof(*entry), caller);
> 	memcpy(ptr, fstack->calls, size);

But... Why are you lying to the compiler? Why not just make this
dynamically sized for real? It's not a "struct stack_entry" if it might
be bigger.

Just create a new struct that isn't lying? (Dealing with the "minimum
size" issue for a dynamic array is usually done with unions, but
ftrace's structs are ... different. As such, I just added a one-off
union.) Here, and you can be the first user of __counted_by too:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4529e264cb86..40935578c365 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3108,6 +3108,14 @@ struct ftrace_stacks {
 static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_stacks);
 static DEFINE_PER_CPU(int, ftrace_stack_reserve);
 
+union stack_entry_dynamic {
+	struct stack_entry entry;
+	struct {
+		int size;
+		unsigned long caller[] __counted_by(size);
+	};
+};
+
 static void __ftrace_trace_stack(struct trace_buffer *buffer,
 				 unsigned int trace_ctx,
 				 int skip, struct pt_regs *regs)
@@ -3116,7 +3124,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 	struct ring_buffer_event *event;
 	unsigned int size, nr_entries;
 	struct ftrace_stack *fstack;
-	struct stack_entry *entry;
+	union stack_entry_dynamic *entry;
 	int stackidx;
 
 	/*
@@ -3155,16 +3163,15 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
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
+	memcpy(entry->caller, fstack->calls, flex_array_size(entry, caller, nr_entries));
 
 	if (!call_filter_check_discard(call, entry, buffer, event))
 		__buffer_unlock_commit(buffer, event);

-- 
Kees Cook
