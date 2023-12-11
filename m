Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEDA80DF33
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjLKW64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjLKW6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:58:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DBFF2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:58:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594EFC433C8;
        Mon, 11 Dec 2023 22:58:24 +0000 (UTC)
Date:   Mon, 11 Dec 2023 17:59:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ring-buffer: Fix and comment ring buffer rb_time
 functions on 32-bit
Message-ID: <20231211175904.29e01e8b@gandalf.local.home>
In-Reply-To: <20231211201324.652870-1-mathieu.desnoyers@efficios.com>
References: <20231211201324.652870-1-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 15:13:24 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Going through a review of the ring buffer rb_time functions for 32-bit
> architectures, I updated the comments to match the code, and identified
> the following issues:

Thanks Mathieu!

> 
> - rb_time_cmpxchg() needs to update the msb last, so it matches
>   the validation of top and msb by __rb_time_read(). This is fixed by
>   this patch.

Hmm, does it? This is not parallel programming, it's only protecting
against interrupts.

BTW, it's best not to have a fix like this with a comment change this big,
as the comment change is highly likely to cause conflicts in any backport.

Although, for consistency, I wonder if everything else should be changed to go:

  bottom, top, msb

as it would match the order of the bits, as msb has the highest order, top
the next, and bottom the least. Doing it as:

  top, bottom, msb

seems out of order. I did that because msb was an after thought :-/

> 
> - A cmpxchg interrupted by 4 writes or cmpxchg overflows the counter
>   and produces corrupted time stamps. This is _not_ fixed by this patch.

Except that it's not 4 bits that is compared, but 32 bits.

struct rb_time_struct {
	local_t		cnt;
	local_t		top;
	local_t		bottom;
	local_t		msb;
};

The full local_t (32 bits) is used for synchronization. But the other
elements do get extra bits and there still might be some issues, but not as
severe as you stated here.

Although, I should also change this to be:

struct rb_time_struct {
	local_t		cnt;
	local_t		msb;
	local_t		top;
	local_t		bottom;
};

To match the order of bits as mentioned above.

static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
{
	unsigned long cnt, top, bottom, msb;
	unsigned long cnt2, top2, bottom2, msb2;
	u64 val;

	/* The cmpxchg always fails if it interrupted an update */
	 if (!__rb_time_read(t, &val, &cnt2))

## So the value has to succeed to continue. This is why I don't think order
## matters between them.

		 return false;

	 if (val != expect)

## Must also be what was expected

		 return false;

	 cnt = local_read(&t->cnt);

## We read the full 32 bits here.

	 if ((cnt & 3) != cnt2)

## This is mostly a paranoid check. For this to fail, the interrupting
## context had to write a full timestamp that this context expected,
## otherwise the (val != expect) would be true.

		 return false;

	 cnt2 = cnt + 1;

## We take the 32 bit number and add 1 to it

	 rb_time_split(val, &top, &bottom, &msb);
	 top = rb_time_val_cnt(top, cnt);
	 bottom = rb_time_val_cnt(bottom, cnt);

	 rb_time_split(set, &top2, &bottom2, &msb2);
	 top2 = rb_time_val_cnt(top2, cnt2);
	 bottom2 = rb_time_val_cnt(bottom2, cnt2);

## Now the above takes the value to what was expected and sprinkles the cnt
## on it as "salt"

	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
		return false;

## if something came in here, we fail immediately with no corruption. This
## cmpxchg() is not affected by 4 writes

	if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
		return false;

## if we fail here, it means that something came in and wrote all values
## making everything correct again.

	if (!rb_time_read_cmpxchg(&t->top, top, top2))
		return false;
	if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
		return false;

## The same is true for all the above.

	return true;
}


The 2 bits in the top, bottom and msb, are basically salt to help out the
cmpxchg, but it does suffer from the 4 writes you mention, but only if the
writes wrote the same thing 4 times and then cmpxchg() wants to update it
to something different. The point is that a cmpxchg() should not corrupt a
write that was done by an interrupting context. The logic can fail if the
cmpxchg wants to update one of the fields to a new number, but the
interrupting write kept it the same 4 times. That is, it did not update the
number.

That is, to fail; the old value is to be the same for a multiple of 4
writes in an interrupting event, and the interrupted event wants to update
it to a new number. This is probably not even feasible, because that would
also require the interruption to happen before the value to write was read.
That is, in practice, it may not be possible to hit this race. These are
monotonic time stamps, so the values do not go backwards. That means its
highly unlikely (if not impossible) for the cmpxchg to be putting in a newer
time stamp than what the interrupting context would be adding, as the
interruption would happen after the new timestamp was read. This means that
the interrupting context would likely have the new values and not the old.

For this to fail we need to have:


  timestamp.bottom = old_ts.bottom;

  new_timestamp = read_ts();

  cmpxchg() {

	>>>>>> INTERRUPT

	ts = read_ts()
	// This needs to match the old number

	timestamp.bottom = ts.bottom

	[ repeat 3 more times ]

 
   if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
 	return false;

The cmpxchg() requires t->bottom to incorrectly match bottom, which is the
new_timestamp.bottom. But if the interrupt happened, it would need to write
the old number 4 times as well.

Hmm, the most likely way for this to hit, is if bottom were to wrap. Which
means it would have to be interrupted for over 1 second (2^30ns is just
over a 1 second), and have the value be exactly the same. Possible, but you
are probably more likely to be hit by lightning while being attacked by a
shark in the desert.


If we really want to fix this properly, what could work here is to have the
two bits in top, bottom and msb be the context level of the write.

But bits 0 and 1 would represent the 4 contexts.

 0 0 : task context
 0 1 : softirq context
 1 0 : interrupt context
 1 1 : NMI context

As the there will be no interruptions between the context themselves. The
only thing that is needed is to test to make sure the read wasn't
interrupted by a higher context. These bits are just to note the level of
the write, it doesn't need the counter. That is separate as "cnt".

Another KTODO: :-)

> 
> - After a cmpxchg fails between updates to top and msb, a write is
>   needed before read and cmpxchg can succeed again. I am not entirely
>   sure the rest of the ring buffer handles this correctly.

Note, a cmpxchg() can only fail if it was interrupted by a higher context.
The higher context would be doing a write for the cmpxchg() to fail. If a
cmpxchg() fails, it means that a higher context has already modified it and
in fact, if a cmpxchg() fails, a read should be guaranteed to succeed if
done after the failure, because the higher context already did the write.

The cmpxchg() is only protecting against being interrupted, not for
parallel programming.

For part of the cmpxchg() to succeed and another part to fail, it requires
that it was interrupted between the succeeding part and the failing part.
And the interruption would have written to the value making it valid again.

> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-trace-kernel@vger.kernel.org
> ---
>  kernel/trace/ring_buffer.c | 64 +++++++++++++++++++++++++++-----------
>  1 file changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 8d2a4f00eca9..f6ed699947cd 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -576,34 +576,50 @@ struct ring_buffer_iter {
>  #ifdef RB_TIME_32
>  
>  /*
> - * On 32 bit machines, local64_t is very expensive. As the ring
> - * buffer doesn't need all the features of a true 64 bit atomic,
> - * on 32 bit, it uses these functions (64 still uses local64_t).
> + * On 32-bit machines, local64_t is very expensive. As the ring
> + * buffer doesn't need all the features of a true 64-bit atomic,
> + * on 32-bit, it uses these functions (64-bit still uses local64_t).
>   *
> - * For the ring buffer, 64 bit required operations for the time is
> - * the following:
> + * For the ring buffer, the operations required to manipulate 64-bit
> + * time stamps are the following:
>   *
> - *  - Reads may fail if it interrupted a modification of the time stamp.
> + *  - Read may fail if it interrupted a modification of the time stamp.
>   *      It will succeed if it did not interrupt another write even if
>   *      the read itself is interrupted by a write.
> + *      A read will fail if it follows a cmpxchg which failed between
> + *      updates to its top and msb bits, until a write is performed.
> + *      (note: this limitation may be unexpected in parts of the
> + *      ring buffer algorithm)
>   *      It returns whether it was successful or not.
>   *
> - *  - Writes always succeed and will overwrite other writes and writes
> + *  - Write always succeeds and will overwrite other writes and writes

Hmm, Not sure I agree with the above. It should be plural, as in "All
writes".

>   *      that were done by events interrupting the current write.
>   *
>   *  - A write followed by a read of the same time stamp will always succeed,
>   *      but may not contain the same value.
>   *
>   *  - A cmpxchg will fail if it interrupted another write or cmpxchg.
> + *      A cmpxchg will fail if it follows a cmpxchg which failed between
> + *      updates to its top and msb bits, until a write is performed.
> + *      (note: this limitation may be unexpected in parts of the
> + *      ring buffer algorithm)

The above is incorrect, as to fail a cmpxchg() means a write *was*
performed, by a higher context, and the value is now correct.


>   *      Other than that, it acts like a normal cmpxchg.
>   *
> - * The 60 bit time stamp is broken up by 30 bits in a top and bottom half
> - *  (bottom being the least significant 30 bits of the 60 bit time stamp).
> + * The 64-bit time stamp is broken up, from most to least significant,
> + * in: msb, top and bottom fields, of respectively 4, 30, and 30 bits.
>   *
> - * The two most significant bits of each half holds a 2 bit counter (0-3).
> + * The two most significant bits of each field hold a 2-bit counter (0-3).
>   * Each update will increment this counter by one.
> - * When reading the top and bottom, if the two counter bits match then the
> - *  top and bottom together make a valid 60 bit number.
> + * When reading the top, bottom, and msb fields, if the two counter bits
> + *   match, then the combined values make a valid 64-bit number.
> + *
> + * Counter limits. The following situations can generate overflows that
> + * produce corrupted time stamps:
> + *
> + * - A read or a write interrupted by 2^32 writes or cmpxchg.
> + *
> + * - A cmpxchg interrupted by 4 writes or cmpxchg.
> + *   (note: this is not sufficient and should be fixed)

Remember, it's not just 4 writes that cause it to fail, but also those 4
writes must have the same value, as the cmpxchg() doesn't just look at the
2 bits, it looks at the rest of the value too.

But even that rare case can be fixed by using context level instead of a
counter.


>   */
>  #define RB_TIME_SHIFT	30
>  #define RB_TIME_VAL_MASK ((1 << RB_TIME_SHIFT) - 1)
> @@ -632,7 +648,7 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
>  
>  	/*
>  	 * If the read is interrupted by a write, then the cnt will
> -	 * be different. Loop until both top and bottom have been read
> +	 * be different. Loop until top, bottom and msb have been read
>  	 * without interruption.
>  	 */
>  	do {
> @@ -644,7 +660,12 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
>  
>  	*cnt = rb_time_cnt(top);
>  
> -	/* If top and msb counts don't match, this interrupted a write */
> +	/*
> +	 * If top and msb counts don't match, this either interrupted a
> +	 * write or follows a failed cmpxchg.

Incorrect. A read following a failed cmpxchg() should always succeed.

> +	 * This requires the update to bottom to be enclosed between
> +	 * updates to top and msb.
> +	 */
>  	if (*cnt != rb_time_cnt(msb))
>  		return false;
>  
> @@ -685,9 +706,10 @@ static void rb_time_set(rb_time_t *t, u64 val)
>  
>  	rb_time_split(val, &top, &bottom, &msb);
>  
> -	/* Writes always succeed with a valid number even if it gets interrupted. */
> +	/* Write always succeeds with a valid number even if it gets interrupted. */

I think we have a different way of looking at this. I'm thinking "Writes"
as in all writes. Saying "Write always succeeds" sounds funny to me. "A
write always succeeds" would sound better.

>  	do {
>  		cnt = local_inc_return(&t->cnt);
> +		/* The top and msb updates surround bottom update. */
>  		rb_time_val_set(&t->top, top, cnt);
>  		rb_time_val_set(&t->bottom, bottom, cnt);
>  		rb_time_val_set(&t->msb, val >> RB_TIME_MSB_SHIFT, cnt);
> @@ -706,7 +728,12 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
>  	unsigned long cnt2, top2, bottom2, msb2;
>  	u64 val;
>  
> -	/* The cmpxchg always fails if it interrupted an update */
> +	/*
> +	 * The cmpxchg always fails if it interrupted an update or if it
> +	 * follows a cmpxchg that fails between updates to top and msb.
> +	 * A rb_time_set() is needed after a failed cmpxchg to reset to
> +	 * a state where cmpxchg can succeed again.

Again, the above isn't correct. Remember *why* a cmpxchg() would fail. It
means it was interrupted by a write, that would make the variable valid again.

> +	 */
>  	 if (!__rb_time_read(t, &val, &cnt2))
>  		 return false;
>  
> @@ -729,12 +756,13 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
>  
>  	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
>  		return false;
> -	if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
> -		return false;
> +	/* The top and msb updates surround bottom update. */
>  	if (!rb_time_read_cmpxchg(&t->top, top, top2))
>  		return false;
>  	if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
>  		return false;
> +	if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
> +		return false;
>  	return true;
>  }
>  

Thanks Mathieu for spending the time to look into this. Even if I disagree
with your analysis ;-)

-- Steve
