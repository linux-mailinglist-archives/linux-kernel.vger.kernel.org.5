Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5727380F166
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377129AbjLLPpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377023AbjLLPpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:45:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BB499
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:45:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E4EC433C8;
        Tue, 12 Dec 2023 15:45:07 +0000 (UTC)
Date:   Tue, 12 Dec 2023 10:45:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] tracing: Allow for max buffer data size trace_marker
 writes
Message-ID: <20231212104549.58863438@gandalf.local.home>
In-Reply-To: <445ac00d-0f0c-4f6a-b85a-97209635c3f3@efficios.com>
References: <20231212090057.41b28efe@gandalf.local.home>
        <445ac00d-0f0c-4f6a-b85a-97209635c3f3@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 09:33:11 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2023-12-12 09:00, Steven Rostedt wrote:
> [...]
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -7272,6 +7272,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
> >   	enum event_trigger_type tt = ETT_NONE;
> >   	struct trace_buffer *buffer;
> >   	struct print_entry *entry;
> > +	int meta_size;
> >   	ssize_t written;
> >   	int size;
> >   	int len;
> > @@ -7286,12 +7287,9 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
> >   	if (!(tr->trace_flags & TRACE_ITER_MARKERS))
> >   		return -EINVAL;
> >   
> > -	if (cnt > TRACE_BUF_SIZE)
> > -		cnt = TRACE_BUF_SIZE;  
> 
> You're removing an early bound check for a size_t userspace input...
> 
> > -
> > -	BUILD_BUG_ON(TRACE_BUF_SIZE >= PAGE_SIZE);
> > -
> > -	size = sizeof(*entry) + cnt + 2; /* add '\0' and possible '\n' */
> > +	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
> > + again:
> > +	size = cnt + meta_size;  
> 
> ... and then implicitly casting it into a "int" size variable, which
> can therefore become a negative value.
> 
> Just for the sake of not having to rely on ring_buffer_lock_reserve
> catching (length > BUF_MAX_DATA_SIZE), I would recommend to add an
> early check for negative here.

size_t is not signed, so nothing should be negative. But you are right, I
need to have "size" be of size_t type too to prevent the overflow.

And I could make cnt of ssize_t type and check for negative and fail early
in such a case.

Thanks!

> 
> >   
> >   	/* If less than "<faulted>", then make sure we can still add
> > that */ if (cnt < FAULTED_SIZE)
> > @@ -7300,9 +7298,25 @@ tracing_mark_write(struct file *filp, const char
> > __user *ubuf, buffer = tr->array_buffer.buffer;
> >   	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
> >   					    tracing_gen_ctx());
> > -	if (unlikely(!event))
> > +	if (unlikely(!event)) {
> > +		/*
> > +		 * If the size was greated than what was allowed, then
> >  
> 
> greater ?

Nah, the size is "greated" like "greated cheese" ;-)

Thanks for the review, I'll send out a v3.

-- Steve
