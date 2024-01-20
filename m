Return-Path: <linux-kernel+bounces-31805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E288334DB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 14:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013B91F2216E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2C9F9DF;
	Sat, 20 Jan 2024 13:47:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125A8BF1;
	Sat, 20 Jan 2024 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705758438; cv=none; b=tOtW0eg5nRTR1AHIBi4i5UEjzIwhb83jVj8G68+7jvD2oaKVZb7UYAGItJ5c2i1xzFB9SFoLjJWgQKXWROu6BXPaaMJXhmnb/9j/JrhrzTAkwto6UJo17eRAjAXwSb8zeOYS3hfyxJL0hxRJ1kjUHUHP3KpA7A/ZPCnAzylJ/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705758438; c=relaxed/simple;
	bh=2e5RDYPkU8r4R81lmsyMSHJXXaJgvogDegRQOLVD3uU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jf1bxVeEG9sXjaBqVfyNUa8n4AFGlX0fEI5B/k2oOxtxIz2wLEHaUcdYwy/TzSVHNoQ8TREqWZI2hUDPeH/AFi+FP9FDEF9COKCRLVOUxnBjocrN9u+qPEohvual0W2Rx8NYizCeg7qjBhNN/iWPHfIT+npbD+9QgW4LhmvYvK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C345C433C7;
	Sat, 20 Jan 2024 13:47:16 +0000 (UTC)
Date: Sat, 20 Jan 2024 08:47:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Philippe Proulx
 <pproulx@efficios.com>
Subject: Re: [PATCH] ring-buffer: Simplify reservation with try_cmpxchg()
 loop
Message-ID: <20240120084713.6eb7aa52@rorschach.local.home>
In-Reply-To: <5d323a65-8a04-4c73-8702-58869982a269@efficios.com>
References: <20240118181206.4977da2f@gandalf.local.home>
	<504085e9-bf91-4948-a158-abae5dcb276a@efficios.com>
	<20240119103754.154dc009@gandalf.local.home>
	<cd3f37cc-31ba-4eb4-8d67-852d05570e7b@efficios.com>
	<20240119164252.54ccb654@gandalf.local.home>
	<5d323a65-8a04-4c73-8702-58869982a269@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 20:49:36 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> >> Let's say we have the following ktime_get() values (monotonic timestamp value) for
> >> a sequence of events:
> >>
> >>                                     Timestamp (Hex)    Encoding in the trace
> >>
> >> Packet header timestamp begin     0x12345678         64-bit: 0x12345678
> >>
> >> Event 1                           0x12345678         16-bit: 0x5678
> >>      (When decoded, same value as previous timestamp, no overflow)
> >> Event 2                           0x12347777         16-bit: 0x7777
> >>      (When decoded, going from "0x5678" to "0x7777" does not overflow 16-bit)
> >> Event 3                           0x12350000         16-bit: 0x0000
> >>      (When decoded, going from "0x7777" to "0x0000" overflow 16-bit exactly once
> >>       which allows the trace reader to reconstruct timestamp 0x12350000 from the
> >>       previous timestamp and the 16-bit timestamp encoding.)
> >> Event 4                           0x12370000         64-bit: 0x12370000
> >>      (Encoding over 16-bit not possible because going from 0x12350000 to
> >>       0x12370000 would overflow 16-bit twice, which cannot be detected
> >>       by a trace reader. Therefore use the full 64-bit timestamp in the
> >>       "large" event header representation.)  
> > 
> > I think that's basically what I said, but you are just looking at it
> > differently ;-) Or should I say, you are using bits for optimization.  
> 
> Based on your explanation below, we are really talking about different things
> here. Let me try to reply to your explanation to try to show where what I am
> doing completely differs from what you have in mind. This will help explain
> how I handle 16-bit overflow as well.
> 
> > The events are based off of the last injected timestamp.  
> 
> Incorrect. There is no "injected timestamp". There is only a concept
> of the "current timestamp" as we either write to or read from the
> event stream. I will take the point of view of the trace reader for
> the rest of the discussion.
> 
> > The above example,
> > starts with an timestamp injection into the packet header: 0x12345678, with
> > the lsb 16bits ignore.  
> 
> Wrong again. The 16 least significant bits are not ignored. The "current timestamp"
> is really 0x12345678 when the packet header is read.

In the packet header you have 0x12345678 in the first event you have
0x5678 how does that get you the timestamp? If that event had 0x8888,
when the reader reads this packet, it would take the header 0x12345678
chop off (ignore) the 5678, and add the 8888, right?

> 
> > So in actuality, it inserts 0x12340000, plus adds a
> > 5678 that represents the creation of the header (like we discussed about in
> > the last tracing meeting).  
> 
> There is no "0x12340000" reference time. There is only the actual 0x12345678
> current time at packet begin, including those 16 low order bits.

It could be 0x12341111 for all I care. I know you use that as the start
time for when tracing starts. But for the events in the packet (which
is what I care about) that bottom 16 bits in the packet header isn't
necessary.

> 
> > 
> > The first event has: 0x5678 which is based on the previous injected
> > timestamp of 0x12340000.  
> 
> It is not "based" on the previous injected timestamp. It just represents
> the low-order 16-bits of the timestamp at event 1. The trace readers takes
> two informations to compute the complete current timestamp for event 1:
> 
> 1) The current timestamp just before event 1 is read (0x12345678),

And where does that reader get that information from? Either the packet
header, or you need to inject a timestamp somewhere, don't you?

> 2) The low-order 16 bits of event 1 (0x5678).
> 
> Given that there is no 16-bit overflow when comparing:
> 
> 0x12345678 & 0xFFFF and 0x5678
> 
> We know that the resulting current timestamp for event 1 is:
> 
> (0x12345678 & ~0xFFFF) + 0x5678 = 0x12345678

And above you ignore the least 16 bits ;-)

> 
> Or basically that time did not move between the packet header and event 1.
> 
> > 
> > the events go on just using a delta from that until you see it overflow (or
> > too big of a delta to fit in the 16 bits), and you insert a new full
> > timestamps that everything will be based on:
> > 
> >    0x12370000  
> 
> No. The following events use the same algorithm I just described: They use

Right, you mask off the bits of the timestamp.

> this notion of "current timestamp" and the information provided by the new
> timestamp field in the event header to figure out the updated current timestamp.
> 
> It is _never_ based on some kind of arbitrary reference, it is always absolute,
> and is always computed based on the current timestamp and the timestamp field
> encountered.

And that current timestamp was created by some injected timestamp in
the writer. The reader has to get it from somewhere!

> 
> > 
> > Now events following that are just a delta from that timestamp. But
> > you calculate the delta simply by masking out the lower bits.  
> 
> No, again, there is no delta from arbitrary injected time. It's always
> computed from this virtual "current time", which applies to an event
> stream.

> (0x12345678 & ~0xFFFF) + 0x5678 = 0x12345678

Delta from arbitrary injected time of (0x12345678 & ~0xFFFF) = 0x12340000

to event "delta" 0x5678 = 0x12345678

 ;-)

You are just using different terminology for the same thing I'm talking
about.

> 
> > 
> > But how do you detect the overflow? That last timestamps to know if
> > the tsc overflowed or not needs to be saved and compared. I would
> > assume you have a similar race that I have.  
> 
> Yes, I save a "last timestamp" per buffer, but the race does not
> matter because of the order in which it is saved wrt local cmpxchg
> updating the reserved position.
> 
> The algorithm looks like:
> 
> do {
>    - read current reserved position (old pos)
>    - read time
>    - compute new reserved position (new pos)
> } while (cmpxchg(reserved pos, old pos, new pos) != old pos);
> 
> [A]
> 
> save_last_tsc()

So the last_tsc that is saved is from the timestamp read before the
cmpxchg.

> 
> If interrupted at [A] by another trace producer, it will compare with
> an older "last tsc" than the tsc of the event physically located just
> before the nested event. This stale "last tsc" has a value which is
> necessarily lower than the one we would be saving with the
> save_last_tsc immediately afterwards, which means in the worse case
> we end up using a full 64-bit timestamp when in fact we could use a
> more compact representation. But this race is rare and therefore it
> does not matter for size.

That's equivalent to me "injecting" an absolute value for the same race.

> 
> The fact that I only need this last_tsc value for the sake of
> optimization, and not for computation of a time delta from a previous
> injected timestamp, makes it possible to handle the race gracefully
> without requiring anything more than a single last_tsc value per
> buffer and a single comparison for 16-bit overflow.

If you have:

> do {
>    - read current reserved position (old pos)
>    - read time
>    - compute new reserved position (new pos)
> } while (cmpxchg(reserved pos, old pos, new pos) != old pos);
> 
> [A]

And here you have an interrupt that runs for several minutes (yeah bad
code ;-) And it does the same thing

do {
   - read current reserved position (old pos)
   - read time
   - compute new reserved position (new pos)
} while (cmpxchg(reserved pos, old pos, new pos) != old pos);

save_last_tsc()

But that last_tsc from before the cmpxchg is much later than the one it
interrupted.


> 
> save_last_tsc()

Ah, so if you put the clock back here, it will just cause the next
event to inject a full timestamp again because the delta is too big.

This is how you are able to avoid the "before/after" logic I have, as
the race is automatically detected. The least significant bits of the
timestamp is ignored for the event delta calculation. And if a race
happens where the interrupting event saves a later timestamp and comes
back here, if the interrupted event writes the older timestamp, it just
causes that delta calculation to overflow again and you inject another
64bit timestamp into the buffer.

> >>
> >> Or introduce "trace_pipe_raw2" or some kind of versioned file
> >> names as new ABIs.  
> > 
> > I hate "version numbers" ;-)  I would rather have a meaning name
> > instead.
> > 
> > "trace_pipe_raw_ts_delta" or something that gives a hint to why it's
> > different.  
> 
> It's just that as it evolves and more changes are integrated, you may
> end up with "trace_pipe_raw_featureA_featureB_featureC", which is
> also inconvenient.

Yes, but at least you know what those features are ;-)

And it's been 15 years since the code was written, and this would be
the "first" new feature added.

> 
> >   
> >>  
> >>> Although, if we want to change the "default" way, it may need
> >>> some other knobs or something, which wouldn't be hard.  
> >>
> >> The delta-timestamp-encoding would have to stay there for a while
> >> as long as users have not switched over to trace_pipe_raw2. Then
> >> when it's really gone, the trace_pipe_raw could either go away or
> >> return an error when opened.
> >>  
> >>> Now I have to ask, what's the motivation for this. The code isn't
> >>> that complex anymore. Yes it still has the before/after
> >>> timestamps, but the most complexity in that code was due to what
> >>> happens in the race of updating the reserved data. But that's no
> >>> longer the case with the cmpxchg(). If you look at this patch,
> >>> that entire else statement was deleted. And that deleted code was
> >>> what made me sick to my stomach ;-) Good riddance!  
> >>
> >> The motivation for this would be to further simplify the
> >> implementation of __rb_reserve_next(), rb_add_timestamp(), and
> >> rb_try_to_discard(), and remove a few useless loads, stores, and
> >> conditional branches on the fast-path of __rb_reserve_next(). This
> >> would turn the before/after timestamp stores/loads/comparisons
> >> into a simple "last timestamp" field and a comparison of the
> >> current timestamp against the "last timestamp" value to figure out
> >> whether the compact representation can be used.
> >>
> >> I don't know whether it's worth the trouble or not, it's really up
> >> to you. :)  
> > 
> > Yeah, making such a change would require an analysis to know if it
> > would speed things up enough to make a significant difference to do
> > that effort.  
> 
> I would also consider reducing code complexity as a worthwhile metric
> in addition to speed. It makes it easier to extend in the future,
> easier to understand for reviewers, and subtle bugs are less likely
> to creep in.

Really, it wouldn't make it that much simpler. The addition of the
cmpxchg() of this patch removed the nasty part of the code.

Going through a transition of changing it could end up being just as
complex. I'm not sure the complexity in that transition is better than
the complexity of the current code, as this code has been there for 15
years, and I know of at least 2 other projects that depend on this
format as is.

-- Steve

