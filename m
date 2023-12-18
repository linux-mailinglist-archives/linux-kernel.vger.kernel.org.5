Return-Path: <linux-kernel+bounces-4455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29C2817D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A672820AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB8A76085;
	Mon, 18 Dec 2023 22:51:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB503D557;
	Mon, 18 Dec 2023 22:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3D7C433C8;
	Mon, 18 Dec 2023 22:51:32 +0000 (UTC)
Date: Mon, 18 Dec 2023 17:52:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] ring-buffer: Replace rb_time_cmpxchg() with
 rb_time_cmp_and_update()
Message-ID: <20231218175229.58ec3daf@gandalf.local.home>
In-Reply-To: <20231218134240.4ed0ecbd@gandalf.local.home>
References: <20231215165512.280088765@goodmis.org>
	<20231215165628.096822746@goodmis.org>
	<20231218232455.03aa6506f855109476e34212@kernel.org>
	<20231218101531.63d138df@gandalf.local.home>
	<20231218134240.4ed0ecbd@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 13:42:40 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > >     
> > > >  static bool rb_time_cmp_and_update(rb_time_t *t, u64 expect, u64 set)
> > > >  {
> > > > -	return rb_time_cmpxchg(t, expect, set);
> > > > +#ifdef RB_TIME_32
> > > > +	return expect == READ_ONCE(t->time);    
> > 
> > And I need to make a v2 as the above is wrong. It should have been:
> > 
> > 	return expect == local64_read(&t->time);  
> 
> 
> My v2 version will also make 64 bit not guaranteed to update on return of
> true. Which adds even more reason to separate out the two.

This code was failing my tests, and after figuring out why, I realized I
can remove this 64-bit cmpxchg for both 64-bit and 32-bit architectures!

I was thinking that the 64-bit cmpxchg() was to keep from adding an
absolute timestamp to after the slowpath. But that was not the case. It was
actually going to *add* a absolute timestamp if it succeeded. Well, not in
every case, but in some cases.

First let me explain the purpose of this last 64-bit cmpxchg:

Before reserving the data on the ring buffer, we do:


 /*A*/	w = local_read(&tail_page->write) & RB_WRITE_MASK;
	barrier();
	b_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
	a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
	barrier();
	info->ts = rb_time_stamp(cpu_buffer->buffer);

The 'w' is the location we expect to have our data on.

Then we read the two timestamps "before_stamp" and "write_stamp" and save
them locally on the stack (info is a stack item).

Then we read the current timestamp and place it into info->ts.

 /*B*/	rb_time_set(&cpu_buffer->before_stamp, info->ts);

All events written into the ring buffer will write into the "before_stamp"
before reserving the ring buffer. I cut out the logic above that makes sure
that "before_stamp" matches "write_stamp", as if they do not match, the
"write_stamp" can not be trusted. As soon as the "before_stamp" is written
to, then any interrupting events will not trust the "write_stamp" and add
its own absolute timestamp, but also update the write_stamp to its
before_stamp so that later events can be trusted.

Now reserve the data for this event on the ring buffer:

 /*C*/	write = local_add_return(info->length, &tail_page->write);

	tail = write - info->length;

	if (likely(tail == w)) {

The above reserves the data for the event on the ring buffer, and then
checks to see if where it was reserved matches where it expected to be
reserved at the start of the operations above.

		[...]

	} else {

Now we go into the slow path of where some thing snucked in between /*A*/
and /*C*/

		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);

Read the write_stamp again.

		ts = rb_time_stamp(cpu_buffer->buffer);

Get the current timestamp

		barrier();
 /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
		    info->after < ts &&

If "write" from /*C*/ still matches the current location on the ring
buffer, we know that nothing came in between /*C*/ and /*E*/


		    rb_time_cmpxchg(&cpu_buffer->write_stamp,
				    info->after, ts)) {

			info->delta = ts - info->after;

Now the above cmpxchg() is needed in this code because we need to update
the write_stamp to the current timestamp so that we can safely calculate the
delta.

But by writing to the write_stamp via the cmpxchg() we are actually making
it different than the before_stamp, as the interruption could have been
between /*B*/ and /*C*/, and this would also force the next event to use an
absolute timestamp. Of course, if it happened between /*A*/ and /*B*/ it is
actually validating the write_stamp again by making it match the
before_stamp.

The real reason we need to do the cmpxchg() is because of a possible
interruption after /*E*/ above. The write_stamp needs to be updated
atomically, otherwise the interrupting event that comes after /*E*/, will
be using the previous interruption write_stamp to calculate its delta from.

For example:

 /*B*/	rb_time_set(&cpu_buffer->before_stamp, info->ts);

  ---> interrupt, updates before_stamp and write_stamp to its own ts

 /*C*/	write = local_add_return(info->length, &tail_page->write);

/* Allocated memory, any interruptions here, will be using the previous
   interrupt ts and not this event */

 /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
		    info->after < ts &&

If write == tail_page->write than nothing came in, so it is still safe to
add a delta, but only if we atomically update the write_stamp, forcing
interrupting events to add an absolute timestamp. If it is not done
atomically, then there's a race that another interrupt could come in, and
use the previous interrupt event to calculate its delta, even though, this
event is in between the two.

BUT! we can also do this instead without the cmpcxchg! Especially as
success of cmpxchg could possibly force a absolute timestamp. If we always
force the absolute timestamp, then there's no need for the cmpxchg at all.

By doing:

		/*
		 * Read a new timestamp and update before_stamp with it.
		 * Any new event coming in now will use an absolute timestamp
		 */
		ts = rb_time_stamp(cpu_buffer->buffer);
		rb_time_set(&cpu_buffer->before_stamp, ts);

		/* Next event will force an absolute timestamp */

		barrier();
		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
		barrier();

 /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
		    info->after < ts) {

			/*
			 * If nothing came in between C and E, it is safe
			 * to use the write_stamp as the delta.
			 */
			info->delta = ts - info->after;
		} else {
			/*
			 * Interrupted twice and the second interruption is possibly
			 * using the first interruption to calculate its delta. Just
			 * set our delta to zero to not mess the event that came in
			 * after up.
			 */
			info->delta = 0;
		}


With this logic, we do not need any 64-bit cmpxchg() at all!

-- Steve

