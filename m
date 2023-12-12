Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EE780EAB5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjLLLnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLLnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:43:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A73CD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:43:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B701C433C7;
        Tue, 12 Dec 2023 11:43:54 +0000 (UTC)
Date:   Tue, 12 Dec 2023 06:44:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] ring-buffer: Fix buffer max_data_size with
 max_event_size
Message-ID: <20231212064435.58522007@gandalf.local.home>
In-Reply-To: <20231211204033.a3658f5f497f0c7541dee025@kernel.org>
References: <20231209170139.33c1b452@gandalf.local.home>
        <20231209170925.71d4e02e@gandalf.local.home>
        <20231211204033.a3658f5f497f0c7541dee025@kernel.org>
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

On Mon, 11 Dec 2023 20:40:33 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Sat, 9 Dec 2023 17:09:25 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat, 9 Dec 2023 17:01:39 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > > 
> > > The maximum ring buffer data size is the maximum size of data that can be
> > > recorded on the ring buffer. Events must be smaller than the sub buffer
> > > data size minus any meta data. This size is checked before trying to
> > > allocate from the ring buffer because the allocation assumes that the size
> > > will fit on the sub buffer.
> > > 
> > > The maximum size was calculated as the size of a sub buffer page (which is
> > > currently PAGE_SIZE minus the sub buffer header) minus the size of the
> > > meta data of an individual event. But it missed the possible adding of a
> > > time stamp for events that are added long enough apart that the event meta
> > > data can't hold the time delta.
> > > 
> > > When an event is added that is greater than the current BUF_MAX_DATA_SIZE
> > > minus the size of a time stamp, but still less than or equal to
> > > BUF_MAX_DATA_SIZE, the ring buffer would go into an infinite loop, looking
> > > for a page that can hold the event. Luckily, there's a check for this loop
> > > and after 1000 iterations and a warning is emitted and the ring buffer is
> > > disabled. But this should never happen.
> > > 
> > > This can happen when a large event is added first, or after a long period
> > > where an absolute timestamp is prefixed to the event, increasing its size
> > > by 8 bytes. This passes the check and then goes into the algorithm that
> > > causes the infinite loop.
> > > 
> > > Fix this by creating a BUF_MAX_EVENT_SIZE to be used to determine if the
> > > passed in event is too big for the buffer.
> > >   
> > 
> > Forgot to add:
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: a4543a2fa9ef3 ("ring-buffer: Get timestamp after event is allocated")  
> 
> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Actually, I found out that this can be fixed with:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 86a60a0eb279..aaad104a1707 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3594,7 +3594,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 			info->length += RB_LEN_TIME_EXTEND;
 		} else {
 			info->delta = info->ts - info->after;
-			if (unlikely(test_time_stamp(info->delta))) {
+			if (w && unlikely(test_time_stamp(info->delta))) {
 				info->add_timestamp |= RB_ADD_STAMP_EXTEND;
 				info->length += RB_LEN_TIME_EXTEND;
 			}

The bug that this patch fixed was that the size that was acceptable did not take
into account the added time stamp. But the time stamp should *not* be added
if it's the first event on the sub buffer. And once it goes to the next
buffer, it should be the first event.

I ran the same tests with this change, and it works just as well. I believe
this is the proper fix.

I'll send a v2.

Thanks!

-- Steve


> 
> Thanks,
> > 
> > -- Steve
> > 
> >   
> > > Reported-by: Kent Overstreet <kent.overstreet@linux.dev> # (on IRC)
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > ---
> > >  kernel/trace/ring_buffer.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index 8d2a4f00eca9..a38e5a3c6803 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -378,6 +378,9 @@ static inline bool test_time_stamp(u64 delta)
> > >  /* Max payload is BUF_PAGE_SIZE - header (8bytes) */
> > >  #define BUF_MAX_DATA_SIZE (BUF_PAGE_SIZE - (sizeof(u32) * 2))
> > >  
> > > +/* Events may have a time stamp attached to them */
> > > +#define BUF_MAX_EVENT_SIZE (BUF_MAX_DATA_SIZE - RB_LEN_TIME_EXTEND)
> > > +
> > >  int ring_buffer_print_page_header(struct trace_seq *s)
> > >  {
> > >  	struct buffer_data_page field;
> > > @@ -3810,7 +3813,7 @@ ring_buffer_lock_reserve(struct trace_buffer *buffer, unsigned long length)
> > >  	if (unlikely(atomic_read(&cpu_buffer->record_disabled)))
> > >  		goto out;
> > >  
> > > -	if (unlikely(length > BUF_MAX_DATA_SIZE))
> > > +	if (unlikely(length > BUF_MAX_EVENT_SIZE))
> > >  		goto out;
> > >  
> > >  	if (unlikely(trace_recursive_lock(cpu_buffer)))
> > > @@ -3960,7 +3963,7 @@ int ring_buffer_write(struct trace_buffer *buffer,
> > >  	if (atomic_read(&cpu_buffer->record_disabled))
> > >  		goto out;
> > >  
> > > -	if (length > BUF_MAX_DATA_SIZE)
> > > +	if (length > BUF_MAX_EVENT_SIZE)
> > >  		goto out;
> > >  
> > >  	if (unlikely(trace_recursive_lock(cpu_buffer)))  
> >   
> 
> 

