Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CF880E35E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjLLEiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLLEiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:38:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3C1C2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:38:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17832C433C8;
        Tue, 12 Dec 2023 04:38:15 +0000 (UTC)
Date:   Mon, 11 Dec 2023 23:38:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ring-buffer: Fix and comment ring buffer rb_time
 functions on 32-bit
Message-ID: <20231211233856.7ee6eba1@gandalf.local.home>
In-Reply-To: <5529ad68-ffd2-41fe-9dff-2568e71b940b@efficios.com>
References: <20231211201324.652870-1-mathieu.desnoyers@efficios.com>
        <20231211175904.29e01e8b@gandalf.local.home>
        <5529ad68-ffd2-41fe-9dff-2568e71b940b@efficios.com>
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

On Mon, 11 Dec 2023 22:51:04 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2023-12-11 17:59, Steven Rostedt wrote:
> > On Mon, 11 Dec 2023 15:13:24 -0500
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> >> Going through a review of the ring buffer rb_time functions for 32-bit
> >> architectures, I updated the comments to match the code, and identified
> >> the following issues:  
> > 
> > Thanks Mathieu!
> >   
> >>
> >> - rb_time_cmpxchg() needs to update the msb last, so it matches
> >>    the validation of top and msb by __rb_time_read(). This is fixed by
> >>    this patch.  
> > 
> > Hmm, does it? This is not parallel programming, it's only protecting
> > against interrupts.  
> 
> Understood, this is indeed the model I had in mind during my review
> (nested interruption only from local cpu) because preemption is disabled
> around use of the ring buffer.
> 
> For this first issue, here is the race:
> 
> rb_time_cmpxchg()
> [...]
>          if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
>                  return false;
>          if (!rb_time_read_cmpxchg(&t->top, top, top2))
>                  return false;
> <interrupted before updating bottom>
> __rb_time_read()
> [...]
>          do {
>                  c = local_read(&t->cnt);
>                  top = local_read(&t->top);
>                  bottom = local_read(&t->bottom);
>                  msb = local_read(&t->msb);
>          } while (c != local_read(&t->cnt));
> 
>          *cnt = rb_time_cnt(top);
> 
>          /* If top and msb counts don't match, this interrupted a write */
>          if (*cnt != rb_time_cnt(msb))
>                  return false;
>            ^ this check fails to catch that "bottom" is still not updated.
> 
> So the old "bottom" value is returned, which is wrong.

Ah, OK that makes more sense. Yeah, if I had the three words from the
beginning, I would have tested to make sure they all match an not just the
two :-p

As this would fix a commit that tried to fix this before!

  f458a1453424e ("ring-buffer: Test last update in 32bit version of __rb_time_read()")

FYI, that would be the "Fixes" for this patch.

> 
> > 
> > BTW, it's best not to have a fix like this with a comment change this big,
> > as the comment change is highly likely to cause conflicts in any backport.  
> 
> I wanted to start the discussion without having a N-patches series, but I agree
> that this first fix should be split into a separate patch.
> 
> > 
> > Although, for consistency, I wonder if everything else should be changed to go:
> > 
> >    bottom, top, msb
> > 
> > as it would match the order of the bits, as msb has the highest order, top
> > the next, and bottom the least. Doing it as:
> > 
> >    top, bottom, msb
> > 
> > seems out of order. I did that because msb was an after thought :-/  
> 
> Agreed on the order change, but I suspect this would belong to another
> patch (not the fix).

Agreed.

> 
> >   
> >>
> >> - A cmpxchg interrupted by 4 writes or cmpxchg overflows the counter
> >>    and produces corrupted time stamps. This is _not_ fixed by this patch.  
> > 
> > Except that it's not 4 bits that is compared, but 32 bits.
> > 
> > struct rb_time_struct {
> > 	local_t		cnt;
> > 	local_t		top;
> > 	local_t		bottom;
> > 	local_t		msb;
> > };
> > 
> > The full local_t (32 bits) is used for synchronization. But the other
> > elements do get extra bits and there still might be some issues, but not as
> > severe as you stated here.  
> 
> Let's bring up the race scenario I spotted:
> 
> rb_time_cmpxchg()
> [...]
>          /* The cmpxchg always fails if it interrupted an update */
>           if (!__rb_time_read(t, &val, &cnt2))
>                   return false;
> 
>           if (val != expect)
>                   return false;
> <interrupted by 4x rb_time_set() or rb_time_cmpxchg()>
> <iret>
>           cnt = local_read(&t->cnt);
>           if ((cnt & 3) != cnt2)
>                   return false;
>           ^ here (cnt & 3) == cnt2, but @val contains outdated data. This
>             means the piecewise rb_time_read_cmpxchg() that follow will
>             derive expected values from the outdated @val.

Ah. Of course this would be fixed if we did the local_read(&t->cnt)
*before* everything else.

> 
>           cnt2 = cnt + 1;
> 
>           rb_time_split(val, &top, &bottom, &msb);
>           top = rb_time_val_cnt(top, cnt);
>           bottom = rb_time_val_cnt(bottom, cnt);
>          ^ top, bottom, and msb contain outdated data, which do not
>            match cnt due to 2-bit overflow.
> 
>           rb_time_split(set, &top2, &bottom2, &msb2);
>           top2 = rb_time_val_cnt(top2, cnt2);
>           bottom2 = rb_time_val_cnt(bottom2, cnt2);
> 
>          if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
>                  return false;
>          ^ This @cnt cmpxchg succeeds because it uses the re-read cnt
>            is used as expected value.

Sure. And I believe you did find another bug. If we read the cnt first,
before reading val, then it would not be outdated.

>          if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
>                  return false;
>          if (!rb_time_read_cmpxchg(&t->top, top, top2))
>                  return false;
>          if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
>                  return false;
>          ^ these cmpxchg have just used the outdated @val as expected
>            values, even though the content of the rb_time was modified
>            by 4 consecutive rb_time_set() or rb_time_cmpxchg(). This
>            means those cmpxchg can fail not only due to being interrupted
>            by another write or cmpxchg, but also simply due to expected
>            value mismatch in any of the fields, which will then cause

Yes, it is expected that this will fail for being interrupt any time during
this operation. So it can only fail for being interrupted. How else would
the value be mismatched if this function had not been interrupted?

>            following __rb_time_read() to fail until a rb_time_set() is done.

How so?  If this had failed, it's because it was interrupted by something
that did the write. The point here is to not modify the value if any of
these failed. If any of the cmpxchg() failed, it means whatever interrupted
it did a rb_time_set(), and that means the value will be valid if a
__rb_time_read() was done on it again.

It doesn't need a rb_time_set() in this context to make it valid again.
That's because an interrupting context had already done that.

> 
>          return true;
> 
> So this overflow scenario on top of cmpxchg does not cause corrupted
> time stamps, but does cause subsequent __rb_time_read() and rb_time_cmpxchg()
> to fail until an eventual rb_time_set().

I still don't see that.

> 
> > 
> > Although, I should also change this to be:
> > 
> > struct rb_time_struct {
> > 	local_t		cnt;
> > 	local_t		msb;
> > 	local_t		top;
> > 	local_t		bottom;
> > };
> > 
> > To match the order of bits as mentioned above.
> > 
> > static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
> > {
> > 	unsigned long cnt, top, bottom, msb;
> > 	unsigned long cnt2, top2, bottom2, msb2;
> > 	u64 val;
> > 
> > 	/* The cmpxchg always fails if it interrupted an update */
> > 	 if (!__rb_time_read(t, &val, &cnt2))
> > 
> > ## So the value has to succeed to continue. This is why I don't think order
> > ## matters between them.
> > 
> > 		 return false;
> > 
> > 	 if (val != expect)
> > 
> > ## Must also be what was expected
> > 
> > 		 return false;
> > 
> > 	 cnt = local_read(&t->cnt);
> > 
> > ## We read the full 32 bits here.
> > 
> > 	 if ((cnt & 3) != cnt2)
> > 
> > ## This is mostly a paranoid check. For this to fail, the interrupting
> > ## context had to write a full timestamp that this context expected,
> > ## otherwise the (val != expect) would be true.  
> 
> As I state in my scenario above, the interrupting context can happen
> after the (val != expect) check.

Which I agree should be fixed. That is, we need to have:

static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
{
	unsigned long cnt, top, bottom, msb;
	unsigned long cnt2, top2, bottom2, msb2;
	u64 val;

+	/* Interrupting writes should make this function fail */
+	 cnt = local_read(&t->cnt);
+
	/* The cmpxchg always fails if it interrupted an update */
	 if (!__rb_time_read(t, &val, &cnt2))
		 return false;

	 if (val != expect)
		 return false;

-	 cnt = local_read(&t->cnt);
	 if ((cnt & 3) != cnt2)
		 return false;

	[..]

> 
> > 
> > 		 return false;
> > 
> > 	 cnt2 = cnt + 1;
> > 
> > ## We take the 32 bit number and add 1 to it
> > 
> > 	 rb_time_split(val, &top, &bottom, &msb);
> > 	 top = rb_time_val_cnt(top, cnt);
> > 	 bottom = rb_time_val_cnt(bottom, cnt);
> > 
> > 	 rb_time_split(set, &top2, &bottom2, &msb2);
> > 	 top2 = rb_time_val_cnt(top2, cnt2);
> > 	 bottom2 = rb_time_val_cnt(bottom2, cnt2);
> > 
> > ## Now the above takes the value to what was expected and sprinkles the cnt
> > ## on it as "salt"
> > 
> > 	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
> > 		return false;
> > 
> > ## if something came in here, we fail immediately with no corruption. This
> > ## cmpxchg() is not affected by 4 writes
> > 
> > 	if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
> > 		return false;
> > 
> > ## if we fail here, it means that something came in and wrote all values
> > ## making everything correct again.
> > 
> > 	if (!rb_time_read_cmpxchg(&t->top, top, top2))
> > 		return false;
> > 	if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
> > 		return false;
> > 
> > ## The same is true for all the above.  
> 
> Not if the interrupting context happens right after the (val != expect) check,
> as stated in my scenario.

And is fixed with what I mentioned.

> 
> > 
> > 	return true;
> > }
> > 
> > 
> > The 2 bits in the top, bottom and msb, are basically salt to help out the
> > cmpxchg, but it does suffer from the 4 writes you mention, but only if the
> > writes wrote the same thing 4 times and then cmpxchg() wants to update it
> > to something different.  
> I suspect only the content of the last of those 4 writes actually matters.

Actually, it's the content of the last write that matters. It just needs 4
times to make the counting bits match.

> 
> >. The point is that a cmpxchg() should not corrupt a
> > write that was done by an interrupting context. The logic can fail if the
> > cmpxchg wants to update one of the fields to a new number, but the
> > interrupting write kept it the same 4 times. That is, it did not update the
> > number.  
> 
> I'm failing to see how letting a cmpxchg succeed in a case where a store
> just happened to write all of its expected values would be a bug ?

Because it could be:

	top = 0x1
	bottom = 0xffff0000

And the interrupt caused that to be:

	top = 0x2
	bottom = 0x00000000

But the lower context wanted it to be:

	top = 0x1
	bottom = 0xffffff00

We don't want the end result to be:

	top = 0x1
	bottom = 0x00000000

Because of a false positive "match". (Note, the above isn't a good example,
but I'm too tired to think of one that will actually cause the problem. But
I think you can get the gist of it).


> 
> And if the nested writes happen bewtween the cmpxchg to top and bottom, and
> the cmpxchg bottom happen to expect exactly the content of the write, then
> it would increment the 2-bit cnt of bottom to a value which won't match
> top/msb, which would cause following reads to fail.

Yes, if there's a false match (a match that should not have happened), then
yes, it will corrupt the counter and make reads fail. But currently it's
near impossible to get that false match. But I think we should make it
totally impossible to do so.

> 
> > 
> > That is, to fail; the old value is to be the same for a multiple of 4
> > writes in an interrupting event, and the interrupted event wants to update
> > it to a new number. This is probably not even feasible, because that would
> > also require the interruption to happen before the value to write was read.
> > That is, in practice, it may not be possible to hit this race. These are
> > monotonic time stamps, so the values do not go backwards. That means its
> > highly unlikely (if not impossible) for the cmpxchg to be putting in a newer
> > time stamp than what the interrupting context would be adding, as the
> > interruption would happen after the new timestamp was read. This means that
> > the interrupting context would likely have the new values and not the old.
> > 
> > For this to fail we need to have:
> > 
> > 
> >    timestamp.bottom = old_ts.bottom;
> > 
> >    new_timestamp = read_ts();
> > 
> >    cmpxchg() {
> >   
> > 	>>>>>> INTERRUPT  
> > 
> > 	ts = read_ts()
> > 	// This needs to match the old number
> > 
> > 	timestamp.bottom = ts.bottom
> > 
> > 	[ repeat 3 more times ]
> > 
> >   
> >     if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
> >   	return false;
> > 
> > The cmpxchg() requires t->bottom to incorrectly match bottom, which is the
> > new_timestamp.bottom. But if the interrupt happened, it would need to write
> > the old number 4 times as well.
> > 
> > Hmm, the most likely way for this to hit, is if bottom were to wrap. Which
> > means it would have to be interrupted for over 1 second (2^30ns is just
> > over a 1 second), and have the value be exactly the same. Possible, but you
> > are probably more likely to be hit by lightning while being attacked by a
> > shark in the desert.
> > 
> > 
> > If we really want to fix this properly, what could work here is to have the
> > two bits in top, bottom and msb be the context level of the write.
> > 
> > But bits 0 and 1 would represent the 4 contexts.
> > 
> >   0 0 : task context
> >   0 1 : softirq context
> >   1 0 : interrupt context
> >   1 1 : NMI context
> > 
> > As the there will be no interruptions between the context themselves. The
> > only thing that is needed is to test to make sure the read wasn't
> > interrupted by a higher context. These bits are just to note the level of
> > the write, it doesn't need the counter. That is separate as "cnt".
> > 
> > Another KTODO: :-)  
> 
> Yes, the nesting approach might work better than a 2-bit counter for tracking
> interruption of reads/cmpxchg by stores/cmpxchg.

Although, it may need at least the LSB of the count too, and we make it
three bits, where the LSB is the LSB of the count and bits 1 and 2 are the
context level. That's because we still need to have the interrupting
context know that the words are in the process of being updated. All it
needs is a toggle, because that bit will go from 0 to 1 in any given
context.

That way, if a irq interrupts a soft irq, it may see:

	msb:	0 1 0
	top:	0 1 0
	bottom:	0 1 1

And know that it interrupted it between top and bottom.

> 
> >   
> >>
> >> - After a cmpxchg fails between updates to top and msb, a write is
> >>    needed before read and cmpxchg can succeed again. I am not entirely
> >>    sure the rest of the ring buffer handles this correctly.  
> > 
> > Note, a cmpxchg() can only fail if it was interrupted by a higher context.
> > The higher context would be doing a write for the cmpxchg() to fail. If a
> > cmpxchg() fails, it means that a higher context has already modified it and
> > in fact, if a cmpxchg() fails, a read should be guaranteed to succeed if
> > done after the failure, because the higher context already did the write.  
> 
> Not in the 2-bit overflow scenario I detailed above.

I still see moving the read of cnt to the beginning as fixing that.

> 
> > 
> > The cmpxchg() is only protecting against being interrupted, not for
> > parallel programming.  
> 
> Of course.
> 
> > 
> > For part of the cmpxchg() to succeed and another part to fail, it requires
> > that it was interrupted between the succeeding part and the failing part.
> > And the interruption would have written to the value making it valid again.  
> 
> Except for the 2-bit cnt overflow scenario.

And the fix I suggested ;-)

> 
> >   
> >>
> >> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >> Cc: Steven Rostedt <rostedt@goodmis.org>
> >> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> >> Cc: linux-trace-kernel@vger.kernel.org
> >> ---
> >>   kernel/trace/ring_buffer.c | 64 +++++++++++++++++++++++++++-----------
> >>   1 file changed, 46 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> >> index 8d2a4f00eca9..f6ed699947cd 100644
> >> --- a/kernel/trace/ring_buffer.c
> >> +++ b/kernel/trace/ring_buffer.c
> >> @@ -576,34 +576,50 @@ struct ring_buffer_iter {
> >>   #ifdef RB_TIME_32
> >>   
> >>   /*
> >> - * On 32 bit machines, local64_t is very expensive. As the ring
> >> - * buffer doesn't need all the features of a true 64 bit atomic,
> >> - * on 32 bit, it uses these functions (64 still uses local64_t).
> >> + * On 32-bit machines, local64_t is very expensive. As the ring
> >> + * buffer doesn't need all the features of a true 64-bit atomic,
> >> + * on 32-bit, it uses these functions (64-bit still uses local64_t).
> >>    *
> >> - * For the ring buffer, 64 bit required operations for the time is
> >> - * the following:
> >> + * For the ring buffer, the operations required to manipulate 64-bit
> >> + * time stamps are the following:
> >>    *
> >> - *  - Reads may fail if it interrupted a modification of the time stamp.
> >> + *  - Read may fail if it interrupted a modification of the time stamp.
> >>    *      It will succeed if it did not interrupt another write even if
> >>    *      the read itself is interrupted by a write.
> >> + *      A read will fail if it follows a cmpxchg which failed between
> >> + *      updates to its top and msb bits, until a write is performed.
> >> + *      (note: this limitation may be unexpected in parts of the
> >> + *      ring buffer algorithm)
> >>    *      It returns whether it was successful or not.
> >>    *
> >> - *  - Writes always succeed and will overwrite other writes and writes
> >> + *  - Write always succeeds and will overwrite other writes and writes  
> > 
> > Hmm, Not sure I agree with the above. It should be plural, as in "All
> > writes".  
> 
> Then we should pick either "writes/reads" and "they", or "A write/A read"
> and "it", but not a mix.

Where do you see it mixed?

> 
> >   
> >>    *      that were done by events interrupting the current write.
> >>    *
> >>    *  - A write followed by a read of the same time stamp will always succeed,
> >>    *      but may not contain the same value.
> >>    *
> >>    *  - A cmpxchg will fail if it interrupted another write or cmpxchg.
> >> + *      A cmpxchg will fail if it follows a cmpxchg which failed between
> >> + *      updates to its top and msb bits, until a write is performed.
> >> + *      (note: this limitation may be unexpected in parts of the
> >> + *      ring buffer algorithm)  
> > 
> > The above is incorrect, as to fail a cmpxchg() means a write *was*
> > performed, by a higher context, and the value is now correct.  
> 
> Except for the 2-bit overflow scenario, which can cause the partial
> cmpxchg to fail due to expected value mismatch.

And my proposed fix!

> 
> > 
> >   
> >>    *      Other than that, it acts like a normal cmpxchg.
> >>    *
> >> - * The 60 bit time stamp is broken up by 30 bits in a top and bottom half
> >> - *  (bottom being the least significant 30 bits of the 60 bit time stamp).
> >> + * The 64-bit time stamp is broken up, from most to least significant,
> >> + * in: msb, top and bottom fields, of respectively 4, 30, and 30 bits.
> >>    *
> >> - * The two most significant bits of each half holds a 2 bit counter (0-3).
> >> + * The two most significant bits of each field hold a 2-bit counter (0-3).
> >>    * Each update will increment this counter by one.
> >> - * When reading the top and bottom, if the two counter bits match then the
> >> - *  top and bottom together make a valid 60 bit number.
> >> + * When reading the top, bottom, and msb fields, if the two counter bits
> >> + *   match, then the combined values make a valid 64-bit number.
> >> + *
> >> + * Counter limits. The following situations can generate overflows that
> >> + * produce corrupted time stamps:
> >> + *
> >> + * - A read or a write interrupted by 2^32 writes or cmpxchg.
> >> + *
> >> + * - A cmpxchg interrupted by 4 writes or cmpxchg.
> >> + *   (note: this is not sufficient and should be fixed)  
> > 
> > Remember, it's not just 4 writes that cause it to fail, but also those 4
> > writes must have the same value, as the cmpxchg() doesn't just look at the
> > 2 bits, it looks at the rest of the value too.  
> 
> It would not require all 4 of the writes to store the same value, just the
> last one.
> 
> Although I detailed an overflow scenario that causes reads to fail after a
> partially successful cmpxchg, I'm currently failing to understand how the 4
> writes would cause a read to observe an actual corrupted value.

reads detect happening within a write. So there is no "4 writes" when doing
a read. The read cares about what it interrupted, not what interrupted it.

The order of the cmpxchg that your patch fixed does affect this, because it
missed the "bottom" update.

> 
> > 
> > But even that rare case can be fixed by using context level instead of a
> > counter.
> > 
> >   
> >>    */
> >>   #define RB_TIME_SHIFT	30
> >>   #define RB_TIME_VAL_MASK ((1 << RB_TIME_SHIFT) - 1)
> >> @@ -632,7 +648,7 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
> >>   
> >>   	/*
> >>   	 * If the read is interrupted by a write, then the cnt will
> >> -	 * be different. Loop until both top and bottom have been read
> >> +	 * be different. Loop until top, bottom and msb have been read
> >>   	 * without interruption.
> >>   	 */
> >>   	do {
> >> @@ -644,7 +660,12 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
> >>   
> >>   	*cnt = rb_time_cnt(top);
> >>   
> >> -	/* If top and msb counts don't match, this interrupted a write */
> >> +	/*
> >> +	 * If top and msb counts don't match, this either interrupted a
> >> +	 * write or follows a failed cmpxchg.  
> > 
> > Incorrect. A read following a failed cmpxchg() should always succeed.
> >   
> >> +	 * This requires the update to bottom to be enclosed between
> >> +	 * updates to top and msb.
> >> +	 */
> >>   	if (*cnt != rb_time_cnt(msb))
> >>   		return false;
> >>   
> >> @@ -685,9 +706,10 @@ static void rb_time_set(rb_time_t *t, u64 val)
> >>   
> >>   	rb_time_split(val, &top, &bottom, &msb);
> >>   
> >> -	/* Writes always succeed with a valid number even if it gets interrupted. */
> >> +	/* Write always succeeds with a valid number even if it gets interrupted. */  
> > 
> > I think we have a different way of looking at this. I'm thinking "Writes"
> > as in all writes. Saying "Write always succeeds" sounds funny to me. "A
> > write always succeeds" would sound better.  
> 
> Agreed on "A write".
> 
> >   
> >>   	do {
> >>   		cnt = local_inc_return(&t->cnt);
> >> +		/* The top and msb updates surround bottom update. */
> >>   		rb_time_val_set(&t->top, top, cnt);
> >>   		rb_time_val_set(&t->bottom, bottom, cnt);
> >>   		rb_time_val_set(&t->msb, val >> RB_TIME_MSB_SHIFT, cnt);
> >> @@ -706,7 +728,12 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
> >>   	unsigned long cnt2, top2, bottom2, msb2;
> >>   	u64 val;
> >>   
> >> -	/* The cmpxchg always fails if it interrupted an update */
> >> +	/*
> >> +	 * The cmpxchg always fails if it interrupted an update or if it
> >> +	 * follows a cmpxchg that fails between updates to top and msb.
> >> +	 * A rb_time_set() is needed after a failed cmpxchg to reset to
> >> +	 * a state where cmpxchg can succeed again.  
> > 
> > Again, the above isn't correct. Remember *why* a cmpxchg() would fail. It
> > means it was interrupted by a write, that would make the variable valid again.  
> 
> Except for 2-bit overflow.

Not a problem with my proposed fix.

> 
> >   
> >> +	 */
> >>   	 if (!__rb_time_read(t, &val, &cnt2))
> >>   		 return false;
> >>   
> >> @@ -729,12 +756,13 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
> >>   
> >>   	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
> >>   		return false;
> >> -	if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
> >> -		return false;
> >> +	/* The top and msb updates surround bottom update. */
> >>   	if (!rb_time_read_cmpxchg(&t->top, top, top2))
> >>   		return false;
> >>   	if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
> >>   		return false;
> >> +	if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
> >> +		return false;
> >>   	return true;
> >>   }
> >>     
> > 
> > Thanks Mathieu for spending the time to look into this. Even if I disagree
> > with your analysis ;-)  
> 
> Your reply got me wondering whether the 2-bit overflow can actually cause
> corrupted time-stamps. Unfortunately the partial scenarios you mentioned lack
> information to allow me to fully understand them, and I just ran out of brain
> for tonight. What scenario for corruption of bottom field by cmpxchg
> you have in mind exactly ?
> 
> One approach we could take to improve the 2-bit overflow would be to extend
> this cnt to 10 bits like so:
> 
> msb:      10-bit cnt, 2-bit unused, 20-bit counter
> top:      10-bit cnt, 22-bit counter
> bottom:   10-bit cnt, 22-bit counter
> 
> or to 16 bits like so:
> 
> [0]:      16-bit cnt, 16-bit counter
> [1]:      16-bit cnt, 16-bit counter
> [2]:      16-bit cnt, 16-bit counter
> [3]:      16-bit cnt, 16-bit counter

Having a single toggle and the context level should be sufficient. As two
bits will tell you which context updated the timestamp, which is useful for
knowing it got interrupted, and the toggle bit is to let interrupting
context know the timestamp is being updated.

-- Steve
