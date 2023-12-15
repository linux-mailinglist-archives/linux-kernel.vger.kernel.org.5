Return-Path: <linux-kernel+bounces-411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E838140B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5AC31F22C47
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC6A53A9;
	Fri, 15 Dec 2023 03:36:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9240AD268;
	Fri, 15 Dec 2023 03:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196F0C433C7;
	Fri, 15 Dec 2023 03:36:46 +0000 (UTC)
Date: Thu, 14 Dec 2023 22:37:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Joel Fernandes <joel@joelfernandes.org>, Vincent Donnefort
 <vdonnefort@google.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Do not try to put back write_stamp
Message-ID: <20231214223734.5090c558@gandalf.local.home>
In-Reply-To: <20231214221803.1a923e10@gandalf.local.home>
References: <20231214221803.1a923e10@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 22:18:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> If an update to an event is interrupted by another event between the time
> the initial event allocated its buffer and where it wrote to the
> write_stamp, the code try to reset the write stamp back to the what it had
> just overwritten. It knows that it was overwritten via checking the
> before_stamp, and if it didn't match what it wrote to the before_stamp
> before it allocated its space, it knows it was overwritten.
> 
> To put back the write_stamp, it uses the before_stamp it read. The problem
> here is that by writing the before_stamp to the write_stamp it makes the
> two equal again, which means that the write_stamp can be considered valid
> as the last timestamp written to the ring buffer. But this is not
> necessarily true. The event that interrupted the event could have been
> interrupted in a way that it was interrupted as well, and can end up
> leaving with an invalid write_stamp. But if this happens and returns to
> this context that uses the before_stamp to update the write_stamp again,
> it can possibly incorrectly make it valid, causing later events to have in
> correct time stamps.
> 
> As it is OK to leave this function with an invalid write_stamp (one that
> doesn't match the before_stamp), there's no reason to try to make it valid
> again in this case. If this race happens, then just leave with the invalid
> write_stamp and the next event to come along will just add a absolute
> timestamp and validate everything again.
> 
> Bonus points: This gets rid of another cmpxchg64!
> 

With this patch and https://lore.kernel.org/linux-trace-kernel/20231211114420.36dde01b@gandalf.local.home

I remove two critical uses of cmpxchg64, leaving only two other use cases.
Both of which are pretty much optional!

One is used in the discard path, which I plan on getting rid of anyway, and
if the cmpxchg64 fails there, it just doesn't discard the event but
converts it to padding.

The other location is in another slow path were it tries to get a more
accurate timestamp. If that cmpxchg64 fails, it just uses the timestamp of
the previous event that interrupted it. Which is what the code use to do
before all this timestamp magic was done.

That is, I can still get rid of the 32-bit cmpxchg64 logic and instead just
replace it with:

#ifdef CONFIG_ARCH_DOES_NOT_HAVE_CMPXCHG64 /* I made this up, but you get the gist */
static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
{
	return false;
}
#else
static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
{
	return local64_try_cmpxchg(&t->time, &expect, set);
}
#endif

And that makes things so much easier!

Again, after this and the other patch applied, the cmpxcg64 is just a
nice-to-have and not required for the ring buffer to work.

-- Steve

