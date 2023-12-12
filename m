Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C6780F553
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346693AbjLLRZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjLLRZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:25:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856549F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:25:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAD1C433C7;
        Tue, 12 Dec 2023 17:25:42 +0000 (UTC)
Date:   Tue, 12 Dec 2023 12:26:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ring-buffer: Fix and comment ring buffer rb_time
 functions on 32-bit
Message-ID: <20231212122624.5b3d378f@gandalf.local.home>
In-Reply-To: <08ecc7bd-9c62-42ca-b481-ca2276451260@efficios.com>
References: <20231211201324.652870-1-mathieu.desnoyers@efficios.com>
        <20231211175904.29e01e8b@gandalf.local.home>
        <5529ad68-ffd2-41fe-9dff-2568e71b940b@efficios.com>
        <20231211233856.7ee6eba1@gandalf.local.home>
        <08ecc7bd-9c62-42ca-b481-ca2276451260@efficios.com>
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

On Tue, 12 Dec 2023 11:49:20 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:


> >> So the old "bottom" value is returned, which is wrong.  
> > 
> > Ah, OK that makes more sense. Yeah, if I had the three words from the
> > beginning, I would have tested to make sure they all match an not just the
> > two :-p  
> 
> Technically just checking that the very first and last words which are
> updated by set/cmpxchg have the same cnt bits would suffice. Because
> this is just a scenario of __rb_time_read interrupting an update, the
> updates in between are fine if the first/last words to be updated have
> the same cnt.

Correct, but I'm paranoid ;-)


> >> rb_time_cmpxchg()
> >> [...]
> >>           /* The cmpxchg always fails if it interrupted an update */
> >>            if (!__rb_time_read(t, &val, &cnt2))
> >>                    return false;
> >>
> >>            if (val != expect)
> >>                    return false;
> >> <interrupted by 4x rb_time_set() or rb_time_cmpxchg()>
> >> <iret>
> >>            cnt = local_read(&t->cnt);
> >>            if ((cnt & 3) != cnt2)
> >>                    return false;
> >>            ^ here (cnt & 3) == cnt2, but @val contains outdated data. This
> >>              means the piecewise rb_time_read_cmpxchg() that follow will
> >>              derive expected values from the outdated @val.  
> > 
> > Ah. Of course this would be fixed if we did the local_read(&t->cnt)
> > *before* everything else.  
> 
> But then we could be interrupted after that initial read, before reading
> val. I suspect we'd want to propagate the full 32-bit cnt that was
> read by __rb_time_read() to the caller, which is not the case today.
> With that, we would not have to read it again in rb_time_cmpxchg.

Not an issue, because before we do *any* update, we have:

	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
		return false;

Which does check the full 32 bits of cnt, and would fail if there was an
interruption, and everything before this point would be tossed.

> 
> It does leave the issue of having only 2 bits in the msb, top, bottom
> fields to detect races, which are subject to overflow.

Yeah, but requires all the bits to be exactly the same. Which is extremely
unlikely. But to fix that, I think the context bits and the toggle bit is
sufficient. Something for a KTODO.

> 
> >   
> >>
> >>            cnt2 = cnt + 1;
> >>
> >>            rb_time_split(val, &top, &bottom, &msb);
> >>            top = rb_time_val_cnt(top, cnt);
> >>            bottom = rb_time_val_cnt(bottom, cnt);
> >>           ^ top, bottom, and msb contain outdated data, which do not
> >>             match cnt due to 2-bit overflow.
> >>
> >>            rb_time_split(set, &top2, &bottom2, &msb2);
> >>            top2 = rb_time_val_cnt(top2, cnt2);
> >>            bottom2 = rb_time_val_cnt(bottom2, cnt2);
> >>
> >>           if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
> >>                   return false;
> >>           ^ This @cnt cmpxchg succeeds because it uses the re-read cnt
> >>             is used as expected value.  

And now it doesn't succeed! And here we exit if there was any interruption
between reading cnt and this cmpxchg.

> > 
> > Sure. And I believe you did find another bug. If we read the cnt first,
> > before reading val, then it would not be outdated.  
> 
> As stated above, I suspect we'd run into other issues if interrupted
> between read of cnt and reading val. Propagating the full 32-bit cnt
> value read from __rb_time_read() to the caller would be better I think.

And as I stated above, we do check the full cnt before we update anything.
So that would not cause any other race issue.

> 
> >   
> >>           if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
> >>                   return false;
> >>           if (!rb_time_read_cmpxchg(&t->top, top, top2))
> >>                   return false;
> >>           if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
> >>                   return false;
> >>           ^ these cmpxchg have just used the outdated @val as expected
> >>             values, even though the content of the rb_time was modified
> >>             by 4 consecutive rb_time_set() or rb_time_cmpxchg(). This
> >>             means those cmpxchg can fail not only due to being interrupted
> >>             by another write or cmpxchg, but also simply due to expected
> >>             value mismatch in any of the fields, which will then cause  
> > 
> > Yes, it is expected that this will fail for being interrupt any time during
> > this operation. So it can only fail for being interrupted. How else would
> > the value be mismatched if this function had not been interrupted?  
> 
> Each of those cmpxchg can fail due to rb_time_cmpxchg() being interrupted
> 4 times by writes/cmpxchg _before the re-load of the cnt field_: this causes
> the 2-bit cnt to match, but each of the sub-fields may not match
> anymore, which can cause a situation where the rb_time_cmpxchg() only
> partially succeeds and leaves the first fields with a different 2-bit
> cnt value than the rest, thus causing following reads to fail.

Note, besides the unlikely case that a cmpxchg() succeeded because of an
exact match overflow and the two bits also matching (which again, you are
more likely to win the powerball than that happening), we do not care about
any other successes. Why, because if it succeeded, it means there was no
interruption.

As soon as there was an interruption, the interruption will modify *all*
values. Setting *all* to be correct.

Note, all interruptions perform at least one rb_time_set() on all the
values being modified here. That means, if a cmpxchg() fails due to an
interruption, whatever interrupted it will have overwritten the value and
set it to be valid again. This is why as soon as this detects something
changed, it bails out.

> 
> I suspect that if we don't re-load the cnt value we may eliminate this
> unwanted scenario.

Not sure what you mean by that.

> 
> >   
> >>             following __rb_time_read() to fail until a rb_time_set() is done.  
> > 
> > How so?  If this had failed, it's because it was interrupted by something
> > that did the write. The point here is to not modify the value if any of
> > these failed. If any of the cmpxchg() failed, it means whatever interrupted
> > it did a rb_time_set(), and that means the value will be valid if a
> > __rb_time_read() was done on it again.  
> 
> Except for the case where the interrupting write came before re-load of cnt.

What do you mean by "re-load of cnt"? The count is loaded once at the
beginning and never modified.

> 
> > 
> > It doesn't need a rb_time_set() in this context to make it valid again.
> > That's because an interrupting context had already done that.  
> 
> Except for the interrupt before re-load of cnt.

??

> 
> >   
> >>
> >>           return true;
> >>
> >> So this overflow scenario on top of cmpxchg does not cause corrupted
> >> time stamps, but does cause subsequent __rb_time_read() and rb_time_cmpxchg()
> >> to fail until an eventual rb_time_set().  
> > 
> > I still don't see that.  
> 
> See explanation above.

See mine too ;-)

> 
> >   
> >>  
> >>>
> >>> Although, I should also change this to be:
> >>>
> >>> struct rb_time_struct {
> >>> 	local_t		cnt;
> >>> 	local_t		msb;
> >>> 	local_t		top;
> >>> 	local_t		bottom;
> >>> };
> >>>
> >>> To match the order of bits as mentioned above.
> >>>
> >>> static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
> >>> {
> >>> 	unsigned long cnt, top, bottom, msb;
> >>> 	unsigned long cnt2, top2, bottom2, msb2;
> >>> 	u64 val;
> >>>
> >>> 	/* The cmpxchg always fails if it interrupted an update */
> >>> 	 if (!__rb_time_read(t, &val, &cnt2))
> >>>
> >>> ## So the value has to succeed to continue. This is why I don't think order
> >>> ## matters between them.
> >>>
> >>> 		 return false;
> >>>
> >>> 	 if (val != expect)
> >>>
> >>> ## Must also be what was expected
> >>>
> >>> 		 return false;
> >>>
> >>> 	 cnt = local_read(&t->cnt);
> >>>
> >>> ## We read the full 32 bits here.
> >>>
> >>> 	 if ((cnt & 3) != cnt2)
> >>>
> >>> ## This is mostly a paranoid check. For this to fail, the interrupting
> >>> ## context had to write a full timestamp that this context expected,
> >>> ## otherwise the (val != expect) would be true.  
> >>
> >> As I state in my scenario above, the interrupting context can happen
> >> after the (val != expect) check.  
> > 
> > Which I agree should be fixed. That is, we need to have:
> > 
> > static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
> > {
> > 	unsigned long cnt, top, bottom, msb;
> > 	unsigned long cnt2, top2, bottom2, msb2;
> > 	u64 val;
> > 
> > +	/* Interrupting writes should make this function fail */
> > +	 cnt = local_read(&t->cnt);  
> 
> 4 nested writes happening just after this read will cause the cnt & 3 check
> below to incorrectly succeed.

Sure. If I wanted to, I could just remove that check. I probably should.

> 
> > +
> > 	/* The cmpxchg always fails if it interrupted an update */
> > 	 if (!__rb_time_read(t, &val, &cnt2))
> > 		 return false;  
> 
> I'd favor returning the full 32-bit "cnt" value from __rb_time_read instead
> so we don't introduce additional state/races.
> 
> > 
> > 	 if (val != expect)
> > 		 return false;
> > 
> > -	 cnt = local_read(&t->cnt);
> > 	 if ((cnt & 3) != cnt2)
> > 		 return false;
> > 
> > 	[..]
> >   
> >>  
> >>>
> >>> 		 return false;
> >>>
> >>> 	 cnt2 = cnt + 1;  
> 
> cnt and cnt2 here would be in the past because they do not take into account the
> increments of the 4 nested writes.
> 
> >>>
> >>> ## We take the 32 bit number and add 1 to it
> >>>
> >>> 	 rb_time_split(val, &top, &bottom, &msb);
> >>> 	 top = rb_time_val_cnt(top, cnt);
> >>> 	 bottom = rb_time_val_cnt(bottom, cnt);
> >>>
> >>> 	 rb_time_split(set, &top2, &bottom2, &msb2);
> >>> 	 top2 = rb_time_val_cnt(top2, cnt2);
> >>> 	 bottom2 = rb_time_val_cnt(bottom2, cnt2);
> >>>
> >>> ## Now the above takes the value to what was expected and sprinkles the cnt
> >>> ## on it as "salt"
> >>>
> >>> 	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
> >>> 		return false;  
> 
> This cmpxchg would however catch it, because it compares against the whole
> 32-bit "cnt" value.

Exactly!

This is what I've been talking about. Note, nothing has been modified till
this point. If a change happened, we drop out and everyone is happy!

> 
> 
> >>>
> >>> ## if something came in here, we fail immediately with no corruption. This
> >>> ## cmpxchg() is not affected by 4 writes
> >>>
> >>> 	if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
> >>> 		return false;
> >>>
> >>> ## if we fail here, it means that something came in and wrote all values
> >>> ## making everything correct again.
> >>>
> >>> 	if (!rb_time_read_cmpxchg(&t->top, top, top2))
> >>> 		return false;
> >>> 	if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
> >>> 		return false;
> >>>
> >>> ## The same is true for all the above.  
> >>
> >> Not if the interrupting context happens right after the (val != expect) check,
> >> as stated in my scenario.  
> > 
> > And is fixed with what I mentioned.  
> 
> Yes, moving the read before seems to work, although I would favor returning the
> whole 32-bit cnt from __rb_time_read for simplicity's sake.

Hmm, yeah we could do that too. I would add that as a clean up and not a fix.

> 
> >   
> >>  
> >>>
> >>> 	return true;
> >>> }
> >>>
> >>>  
> 
> [...]
> 
> >   
> >>  
> >>> . The point is that a cmpxchg() should not corrupt a
> >>> write that was done by an interrupting context. The logic can fail if the
> >>> cmpxchg wants to update one of the fields to a new number, but the
> >>> interrupting write kept it the same 4 times. That is, it did not update the
> >>> number.  
> >>
> >> I'm failing to see how letting a cmpxchg succeed in a case where a store
> >> just happened to write all of its expected values would be a bug ?  
> > 
> > Because it could be:
> > 
> > 	top = 0x1
> > 	bottom = 0xffff0000
> > 
> > And the interrupt caused that to be:
> > 
> > 	top = 0x2
> > 	bottom = 0x00000000
> > 
> > But the lower context wanted it to be:
> > 
> > 	top = 0x1
> > 	bottom = 0xffffff00
> > 
> > We don't want the end result to be:
> > 
> > 	top = 0x1
> > 	bottom = 0x00000000
> > 
> > Because of a false positive "match". (Note, the above isn't a good example,
> > but I'm too tired to think of one that will actually cause the problem. But
> > I think you can get the gist of it).  
> 
> OK, I think I get it now. So we have this:
> 
> rb_time_cmpxchg
>    - does a few of the piecewise updates
>    < interrupted >
>     rb_time_set 4x
>    < iret >
>    - continues doing one or more of the piecewise updates which are remaining, which
>      happen to match the last written field.
> 
> More precisely:
> 
> static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
> [...]
>          if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
>                  return false;
>          if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
>                  return false;
>     <interrupted here>
>      rb_time_set() 4x, which leaves a matching old "top" value.
> 
>          if (!rb_time_read_cmpxchg(&t->top, top, top2))
>                  return false;
>          ^ this cmpxchg can succeed if the old top value written by
>            rb_time_set matches, thus corrupting the top value. It will
>            increment the 2-bit cnt as well through, which will cause
>            following reads to fail.
> 
>          if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
>                  return false;
>          ^ likewise for the bottom value, except that because reads
>            to not validate the 2-bit cnt of the bottom part, this
>            is silent corruption.

Yeah something like that.

>   
> >   
> >>
> >> And if the nested writes happen bewtween the cmpxchg to top and bottom, and
> >> the cmpxchg bottom happen to expect exactly the content of the write, then
> >> it would increment the 2-bit cnt of bottom to a value which won't match
> >> top/msb, which would cause following reads to fail.  
> > 
> > Yes, if there's a false match (a match that should not have happened), then
> > yes, it will corrupt the counter and make reads fail. But currently it's
> > near impossible to get that false match. But I think we should make it
> > totally impossible to do so.  
> 
> Agreed.
> 
> [...]
> >>
> >> Yes, the nesting approach might work better than a 2-bit counter for tracking
> >> interruption of reads/cmpxchg by stores/cmpxchg.  
> > 
> > Although, it may need at least the LSB of the count too, and we make it
> > three bits, where the LSB is the LSB of the count and bits 1 and 2 are the
> > context level. That's because we still need to have the interrupting
> > context know that the words are in the process of being updated. All it
> > needs is a toggle, because that bit will go from 0 to 1 in any given
> > context.
> > 
> > That way, if a irq interrupts a soft irq, it may see:
> > 
> > 	msb:	0 1 0
> > 	top:	0 1 0
> > 	bottom:	0 1 1
> > 
> > And know that it interrupted it between top and bottom.  
> 
> Yes.
> 
> >   
> >>  
> >>>      
> >>>>
> >>>> - After a cmpxchg fails between updates to top and msb, a write is
> >>>>     needed before read and cmpxchg can succeed again. I am not entirely
> >>>>     sure the rest of the ring buffer handles this correctly.  
> >>>
> >>> Note, a cmpxchg() can only fail if it was interrupted by a higher context.
> >>> The higher context would be doing a write for the cmpxchg() to fail. If a
> >>> cmpxchg() fails, it means that a higher context has already modified it and
> >>> in fact, if a cmpxchg() fails, a read should be guaranteed to succeed if
> >>> done after the failure, because the higher context already did the write.  
> >>
> >> Not in the 2-bit overflow scenario I detailed above.  
> > 
> > I still see moving the read of cnt to the beginning as fixing that.  
> 
> Yes. Or simpler: returning the full 32-bit cnt value from __rb_time_read().

That is a bigger change as it __rb_time_read() is used in other places, and
for backporting I prefer the smaller of the changes.

But I do think that change could be a nice cleanup.

> 
> [...]
> >>>>     *
> >>>> - *  - Reads may fail if it interrupted a modification of the time stamp.
> >>>> + *  - Read may fail if it interrupted a modification of the time stamp.
> >>>>     *      It will succeed if it did not interrupt another write even if
> >>>>     *      the read itself is interrupted by a write.
> >>>> + *      A read will fail if it follows a cmpxchg which failed between
> >>>> + *      updates to its top and msb bits, until a write is performed.
> >>>> + *      (note: this limitation may be unexpected in parts of the
> >>>> + *      ring buffer algorithm)
> >>>>     *      It returns whether it was successful or not.
> >>>>     *
> >>>> - *  - Writes always succeed and will overwrite other writes and writes
> >>>> + *  - Write always succeeds and will overwrite other writes and writes  
> >>>
> >>> Hmm, Not sure I agree with the above. It should be plural, as in "All
> >>> writes".  
> >>
> >> Then we should pick either "writes/reads" and "they", or "A write/A read"
> >> and "it", but not a mix.  
> > 
> > Where do you see it mixed?  
> 
> "Reads may fail if it interrupted a modification of the time stamp."
> 
> "Reads" vs "it".

OK, that should be either "A read" or "they".

> 
> And there is a mix of "Reads", "Writes", "A write" and "A cmpxchg" in the
> list. This lacks consistency.

No really with the "Writes" and "A write" because one is stressing
plurality, while the other is stressing an instance.


 *  - Writes always succeed and will overwrite other writes and writes
 *      that were done by events interrupting the current write.

The above is "all writes". Stress on plurality.

 *
 *  - A write followed by a read of the same time stamp will always succeed,
 *      but may not contain the same value.

This is specifying a specific write that happens to be followed by a read.
An instance.

> 
> [...]
> 
> >   
> >>  
> >>>
> >>>      
> >>>>     *      Other than that, it acts like a normal cmpxchg.
> >>>>     *
> >>>> - * The 60 bit time stamp is broken up by 30 bits in a top and bottom half
> >>>> - *  (bottom being the least significant 30 bits of the 60 bit time stamp).
> >>>> + * The 64-bit time stamp is broken up, from most to least significant,
> >>>> + * in: msb, top and bottom fields, of respectively 4, 30, and 30 bits.
> >>>>     *
> >>>> - * The two most significant bits of each half holds a 2 bit counter (0-3).
> >>>> + * The two most significant bits of each field hold a 2-bit counter (0-3).
> >>>>     * Each update will increment this counter by one.
> >>>> - * When reading the top and bottom, if the two counter bits match then the
> >>>> - *  top and bottom together make a valid 60 bit number.
> >>>> + * When reading the top, bottom, and msb fields, if the two counter bits
> >>>> + *   match, then the combined values make a valid 64-bit number.
> >>>> + *
> >>>> + * Counter limits. The following situations can generate overflows that
> >>>> + * produce corrupted time stamps:
> >>>> + *
> >>>> + * - A read or a write interrupted by 2^32 writes or cmpxchg.
> >>>> + *
> >>>> + * - A cmpxchg interrupted by 4 writes or cmpxchg.
> >>>> + *   (note: this is not sufficient and should be fixed)  
> >>>
> >>> Remember, it's not just 4 writes that cause it to fail, but also those 4
> >>> writes must have the same value, as the cmpxchg() doesn't just look at the
> >>> 2 bits, it looks at the rest of the value too.  
> >>
> >> It would not require all 4 of the writes to store the same value, just the
> >> last one.
> >>
> >> Although I detailed an overflow scenario that causes reads to fail after a
> >> partially successful cmpxchg, I'm currently failing to understand how the 4
> >> writes would cause a read to observe an actual corrupted value.  
> > 
> > reads detect happening within a write. So there is no "4 writes" when doing
> > a read. The read cares about what it interrupted, not what interrupted it.
> > 
> > The order of the cmpxchg that your patch fixed does affect this, because it
> > missed the "bottom" update.  
> 
> I suspect that we'd want the read to check the cnt bits of each of msb, top
> and bottom to protect against the scenario where the cmpxchg incorrectly
> matches any of the fields and corrupts its content. However it may not be
> necessary if we switch to the context level approach you suggest.

I think your fix is fine for now.

> 
> [...]
> 
> > 
> > Having a single toggle and the context level should be sufficient. As two
> > bits will tell you which context updated the timestamp, which is useful for
> > knowing it got interrupted, and the toggle bit is to let interrupting
> > context know the timestamp is being updated.  
> 
> Yes, that sounds good.

Great, someone already asked about one of these KTODO projects. I'll let
them know about this one ;-)

-- Steve
