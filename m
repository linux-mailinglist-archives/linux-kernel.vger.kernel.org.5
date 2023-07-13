Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E86F751578
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjGMAoI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 20:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjGMAoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:44:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71871FF7;
        Wed, 12 Jul 2023 17:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39404619E0;
        Thu, 13 Jul 2023 00:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCEBC433C8;
        Thu, 13 Jul 2023 00:44:02 +0000 (UTC)
Date:   Wed, 12 Jul 2023 20:43:58 -0400
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
Message-ID: <20230712204358.756d0018@gandalf.local.home>
In-Reply-To: <202307121618.17C50DA9A@keescook>
References: <20230712105235.5fc441aa@gandalf.local.home>
        <202307121618.17C50DA9A@keescook>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 16:36:30 -0700
Kees Cook <keescook@chromium.org> wrote:

> > 
> > To hide this from the FORTIFY_SOURCE logic, pointer arithmetic is used:
> > 
> > 	ptr = ring_buffer_event_data(event);
> > 	entry = ptr;
> > 	ptr += offsetof(typeof(*entry), caller);
> > 	memcpy(ptr, fstack->calls, size);  
> 
> But... Why are you lying to the compiler? Why not just make this
> dynamically sized for real? It's not a "struct stack_entry" if it might
> be bigger.

I was waiting for some controversy from this patch ;-)

> 
> Just create a new struct that isn't lying? (Dealing with the "minimum
> size" issue for a dynamic array is usually done with unions, but
> ftrace's structs are ... different. As such, I just added a one-off
> union.) Here, and you can be the first user of __counted_by too:
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 4529e264cb86..40935578c365 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3108,6 +3108,14 @@ struct ftrace_stacks {
>  static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_stacks);
>  static DEFINE_PER_CPU(int, ftrace_stack_reserve);
>  
> +union stack_entry_dynamic {
> +	struct stack_entry entry;
> +	struct {
> +		int size;
> +		unsigned long caller[] __counted_by(size);
> +	};
> +};

This actually makes it more likely to cause a bug in the future (and the
present!). Now we need to know that if stack_entry were to ever change, we
have to change this too. And it can change (although highly unlikely).

The problem comes with this structure being created by a macro that creates
the structure and what it exports to user space.

From kernel/trace/trace_entries.h: The macro that creates this structure.

FTRACE_ENTRY(kernel_stack, stack_entry,

	TRACE_STACK,

	F_STRUCT(
		__field(	int,		size	)
		__array(	unsigned long,	caller,	FTRACE_STACK_ENTRIES	)
	),

	F_printk("\t=> %ps\n\t=> %ps\n\t=> %ps\n"
		 "\t=> %ps\n\t=> %ps\n\t=> %ps\n"
		 "\t=> %ps\n\t=> %ps\n",
		 (void *)__entry->caller[0], (void *)__entry->caller[1],
		 (void *)__entry->caller[2], (void *)__entry->caller[3],
		 (void *)__entry->caller[4], (void *)__entry->caller[5],
		 (void *)__entry->caller[6], (void *)__entry->caller[7])
);

Now, this event is unique, as it's the only event that has a dynamic array
that is not done by the way other dynamic arrays are done. Which is to
insert a field that has an offset and length to it. That is, other events
would look like this:

struct stack_entry {
	int		size;
	short		offset; length;
	[ more fields ]
	int		dynamic[];
}

Where offset would be the ((void *)(struct stack_entry *)data) + offset. As
all the dynamic size portions of an event are at the end of the event, with
these offset/length tuples to tell user space and the kernel where to look
in the event binary data for those fields.

But to keep backward compatibility, as this event had code specific for
parsing it in libtraceevent that doesn't expect that offset/length tuple,
and instead just looked at the "caller[8]" portion to see that it had 8
fields (this is static for all events). New code uses the size to know, and
ignores the [8]. The event meta data gives the actual size of the stored
data so the parser knows not to go beyond that.

Note, this event existed before normal trace events that had the dynamic
arrays, which is why it didn't do the same.

The only thing this code is doing is filling in the ring buffer. The entry
structure is just a helper to know where to place the data in the ring
buffer.

So my question to you is, what's the purpose of hardening? To prevent
future bugs, right? By making a shadow struct, we are now burdened to
remember to modify the shadow stack if we ever modify this current
structure.

Oh, to further my point, your change is buggy too (and I almost didn't even
notice it!)

> +
>  static void __ftrace_trace_stack(struct trace_buffer *buffer,
>  				 unsigned int trace_ctx,
>  				 int skip, struct pt_regs *regs)
> @@ -3116,7 +3124,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>  	struct ring_buffer_event *event;
>  	unsigned int size, nr_entries;
>  	struct ftrace_stack *fstack;
> -	struct stack_entry *entry;
> +	union stack_entry_dynamic *entry;
>  	int stackidx;
>  
>  	/*
> @@ -3155,16 +3163,15 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>  		nr_entries = stack_trace_save(fstack->calls, size, skip);
>  	}
>  
> -	size = nr_entries * sizeof(unsigned long);
>  	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
> -				    (sizeof(*entry) - sizeof(entry->caller)) + size,
> +				    struct_size(entry, caller, nr_entries),
>  				    trace_ctx);

Your definition of stack_entry_dynamic is wrong, because stack_entry is
really (as created by the macro, hence why this is error prone):

struct stack_entry {
	struct trace_entry	ent;
	int			size;
	long			caller[8];
};

So you didn't allocate enough, and are writing into the wrong part of the
data, corrupting it.

This is why I much rather prefer the simple:

 	ptr += offsetof(typeof(*entry), caller);
 	memcpy(ptr, fstack->calls, size);

Which doesn't need to care about synchronizing with the macro magic of the
structure, which may change in the future, and this will lead to one more
location that would need to be updated, but likely forgotten.

C is fun, let's go shopping!

-- Steve


>  	if (!event)
>  		goto out;
>  	entry = ring_buffer_event_data(event);
>  
> -	memcpy(&entry->caller, fstack->calls, size);
>  	entry->size = nr_entries;
> +	memcpy(entry->caller, fstack->calls, flex_array_size(entry, caller, nr_entries));
>  
>  	if (!call_filter_check_discard(call, entry, buffer, event))
>  		__buffer_unlock_commit(buffer, event);
> 

