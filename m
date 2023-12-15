Return-Path: <linux-kernel+bounces-972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D528D8148B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DB71C22F72
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE462D05F;
	Fri, 15 Dec 2023 13:06:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC522D043;
	Fri, 15 Dec 2023 13:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15839C433C8;
	Fri, 15 Dec 2023 13:06:07 +0000 (UTC)
Date: Fri, 15 Dec 2023 08:06:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Joel Fernandes <joel@joelfernandes.org>, Vincent Donnefort 
 <vdonnefort@google.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Remove useless update to write_stamp in
 rb_try_to_discard()
Message-ID: <20231215080605.122b3ead@rorschach.local.home>
In-Reply-To: <20231215074151.447e14c2@rorschach.local.home>
References: <20231215074151.447e14c2@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 07:41:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> When filtering is enabled, a temporary buffer is created to place the
> content of the trace event output so that the filter logic can decide
> from the trace event output if the trace event should be filtered out or
> not. If it is to be filtered out, the content in the temporary buffer is
> simply discarded, otherwise it is written into the trace buffer.
> 
> But if an interrupt were to come in while a previous event was using that
> temporary buffer, the event written by the interrupt would actually go
> into the ring buffer itself to prevent corrupting the data on the
> temporary buffer. If the event is to be filtered out, the event in the
> ring buffer is discarded, or if it fails to discard because another event
> were to have already come in, it is turned into padding.
> 
> The update to the write_stamp in the rb_try_to_discard() happens after a
> fix was made to force the next event after the discard to use an absolute
> timestamp by setting the before_stamp to zero so it does not match the
> write_stamp (which causes an event to use the absolute timestamp).
> 
> But there's an effort in rb_try_to_discard() to put back the write_stamp
> to what it was before the event was added. But this is useless and
> wasteful because nothing is going to be using that write_stamp for
> calculations as it still will not match the before_stamp.
> 
> Remove this useless update, and in doing so, we remove another
> cmpxchg64()!

While debugging the timestamp issues, I found that the cmpxchg64 in the
discard was actually useless after commit b2dd797543cf (in the fixes
below). This removes the third of the 4 cmpxchg64 in the ring buffer
code. The last one has:

		u64 ts;
		/* SLOW PATH - Interrupted between A and C */
		rb_time_read(&cpu_buffer->write_stamp, &info->after);
		ts = rb_time_stamp(cpu_buffer->buffer);
		barrier();
 /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
		    info->after < ts &&
		    rb_time_cmpxchg(&cpu_buffer->write_stamp,
				    info->after, ts)) {
			/* Nothing came after this event between C and E */
			info->delta = ts - info->after;
		} else {

That could actually be changed to:

 /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
		    info->after < ts && info->after == READ_ONCE(cpu_buffer->write_stamp)){
			/* Nothing came after this event between C and E */
			info->delta = ts - info->after;

where the only difference is that the before_stamp and write_stamp will
not match making the next event add an absolute_timestamp.

This would get rid of all the cmpxchg64(). I could have:

/*
 * Returns true if ts == old_ts, and if possible will update with new_ts,
 * but ts is not guaranteed to be updated even if this returns true
 */
static bool rb_time_cmp_and_update(rb_time_t *ts, u64 old_ts, u64 new_ts)
{
#if HAVE_CMPXCHG64
	return local64_cmpxchg(ts, old_ts, new_ts) == old_ts;
#else
	return old_ts == READ_ONCE(*ts);
#endif
}

 /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
		    info->after < ts &&
		    rb_time_cmp_and_update(&cpu_buffer->write_stamp, info->after, ts) {
			/* Nothing came after this event between C and E */
			info->delta = ts - info->after;


And this way we don't even need any CMPXCHG64. And for those that do
have it, it gets the benefit of not having to insert an absolute
timestamp for the next event. That's just a nice-to-have and not
critical for the logic.

-- Steve


> 
> Also update the comments to reflect this change as well as remove some
> extra white space in another comment.
> 
> Fixes: b2dd797543cf ("ring-buffer: Force absolute timestamp on discard of event")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

