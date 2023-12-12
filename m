Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF40580F388
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376327AbjLLQtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjLLQtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:49:18 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A95CF;
        Tue, 12 Dec 2023 08:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702399761;
        bh=h4cAc73/Yl4n+QQLokvQSk4xNY4UVK0E0wW2GY4Tkbo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nOViQTK9MtHLe3SaCLpzUhmHdi4dZqHI6Hk0Ljfas3SLoSEM+46liFBdX5hkJGZeT
         e/ZqLMbtl3xKmqe9yWVX+YkSA9QSrk8CwG9zyDHPjhwpSyOAzIWLtwbXjcD+8GMqk/
         UOOFGU+P+Yz6VE7Vzrvhn2h4QcbrwcfyYoHfxbh18eY02RfhPPP6K+OpknNj8qfJPC
         xWHZWUkKxqkyo9rsPN0vW/kUvxXV/6D0vBwlke0hCucou6gq/q5rfshIuT8pV4EPzi
         l41Cx2WGG+CZ6m3MsP6gERfv520PPR+sWLLwpdrjZ5/ZGOzAQpnBGHIjAJlDSNRU/J
         R78zvVQFKBiFA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SqPhx1lJCzGGw;
        Tue, 12 Dec 2023 11:49:21 -0500 (EST)
Message-ID: <08ecc7bd-9c62-42ca-b481-ca2276451260@efficios.com>
Date:   Tue, 12 Dec 2023 11:49:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ring-buffer: Fix and comment ring buffer rb_time
 functions on 32-bit
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
References: <20231211201324.652870-1-mathieu.desnoyers@efficios.com>
 <20231211175904.29e01e8b@gandalf.local.home>
 <5529ad68-ffd2-41fe-9dff-2568e71b940b@efficios.com>
 <20231211233856.7ee6eba1@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231211233856.7ee6eba1@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-11 23:38, Steven Rostedt wrote:
> On Mon, 11 Dec 2023 22:51:04 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
[...]
>>
>> For this first issue, here is the race:
>>
>> rb_time_cmpxchg()
>> [...]
>>           if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
>>                   return false;
>>           if (!rb_time_read_cmpxchg(&t->top, top, top2))
>>                   return false;
>> <interrupted before updating bottom>
>> __rb_time_read()
>> [...]
>>           do {
>>                   c = local_read(&t->cnt);
>>                   top = local_read(&t->top);
>>                   bottom = local_read(&t->bottom);
>>                   msb = local_read(&t->msb);
>>           } while (c != local_read(&t->cnt));
>>
>>           *cnt = rb_time_cnt(top);
>>
>>           /* If top and msb counts don't match, this interrupted a write */
>>           if (*cnt != rb_time_cnt(msb))
>>                   return false;
>>             ^ this check fails to catch that "bottom" is still not updated.
>>
>> So the old "bottom" value is returned, which is wrong.
> 
> Ah, OK that makes more sense. Yeah, if I had the three words from the
> beginning, I would have tested to make sure they all match an not just the
> two :-p

Technically just checking that the very first and last words which are
updated by set/cmpxchg have the same cnt bits would suffice. Because
this is just a scenario of __rb_time_read interrupting an update, the
updates in between are fine if the first/last words to be updated have
the same cnt.

> 
> As this would fix a commit that tried to fix this before!
> 
>    f458a1453424e ("ring-buffer: Test last update in 32bit version of __rb_time_read()")
> 
> FYI, that would be the "Fixes" for this patch.

OK

[...]

>>
>>>    
>>>>
>>>> - A cmpxchg interrupted by 4 writes or cmpxchg overflows the counter
>>>>     and produces corrupted time stamps. This is _not_ fixed by this patch.
>>>
>>> Except that it's not 4 bits that is compared, but 32 bits.
>>>
>>> struct rb_time_struct {
>>> 	local_t		cnt;
>>> 	local_t		top;
>>> 	local_t		bottom;
>>> 	local_t		msb;
>>> };
>>>
>>> The full local_t (32 bits) is used for synchronization. But the other
>>> elements do get extra bits and there still might be some issues, but not as
>>> severe as you stated here.
>>
>> Let's bring up the race scenario I spotted:
>>
>> rb_time_cmpxchg()
>> [...]
>>           /* The cmpxchg always fails if it interrupted an update */
>>            if (!__rb_time_read(t, &val, &cnt2))
>>                    return false;
>>
>>            if (val != expect)
>>                    return false;
>> <interrupted by 4x rb_time_set() or rb_time_cmpxchg()>
>> <iret>
>>            cnt = local_read(&t->cnt);
>>            if ((cnt & 3) != cnt2)
>>                    return false;
>>            ^ here (cnt & 3) == cnt2, but @val contains outdated data. This
>>              means the piecewise rb_time_read_cmpxchg() that follow will
>>              derive expected values from the outdated @val.
> 
> Ah. Of course this would be fixed if we did the local_read(&t->cnt)
> *before* everything else.

But then we could be interrupted after that initial read, before reading
val. I suspect we'd want to propagate the full 32-bit cnt that was
read by __rb_time_read() to the caller, which is not the case today.
With that, we would not have to read it again in rb_time_cmpxchg.

It does leave the issue of having only 2 bits in the msb, top, bottom
fields to detect races, which are subject to overflow.

> 
>>
>>            cnt2 = cnt + 1;
>>
>>            rb_time_split(val, &top, &bottom, &msb);
>>            top = rb_time_val_cnt(top, cnt);
>>            bottom = rb_time_val_cnt(bottom, cnt);
>>           ^ top, bottom, and msb contain outdated data, which do not
>>             match cnt due to 2-bit overflow.
>>
>>            rb_time_split(set, &top2, &bottom2, &msb2);
>>            top2 = rb_time_val_cnt(top2, cnt2);
>>            bottom2 = rb_time_val_cnt(bottom2, cnt2);
>>
>>           if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
>>                   return false;
>>           ^ This @cnt cmpxchg succeeds because it uses the re-read cnt
>>             is used as expected value.
> 
> Sure. And I believe you did find another bug. If we read the cnt first,
> before reading val, then it would not be outdated.

As stated above, I suspect we'd run into other issues if interrupted
between read of cnt and reading val. Propagating the full 32-bit cnt
value read from __rb_time_read() to the caller would be better I think.

> 
>>           if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
>>                   return false;
>>           if (!rb_time_read_cmpxchg(&t->top, top, top2))
>>                   return false;
>>           if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
>>                   return false;
>>           ^ these cmpxchg have just used the outdated @val as expected
>>             values, even though the content of the rb_time was modified
>>             by 4 consecutive rb_time_set() or rb_time_cmpxchg(). This
>>             means those cmpxchg can fail not only due to being interrupted
>>             by another write or cmpxchg, but also simply due to expected
>>             value mismatch in any of the fields, which will then cause
> 
> Yes, it is expected that this will fail for being interrupt any time during
> this operation. So it can only fail for being interrupted. How else would
> the value be mismatched if this function had not been interrupted?

Each of those cmpxchg can fail due to rb_time_cmpxchg() being interrupted
4 times by writes/cmpxchg _before the re-load of the cnt field_: this causes
the 2-bit cnt to match, but each of the sub-fields may not match
anymore, which can cause a situation where the rb_time_cmpxchg() only
partially succeeds and leaves the first fields with a different 2-bit
cnt value than the rest, thus causing following reads to fail.

I suspect that if we don't re-load the cnt value we may eliminate this
unwanted scenario.

> 
>>             following __rb_time_read() to fail until a rb_time_set() is done.
> 
> How so?  If this had failed, it's because it was interrupted by something
> that did the write. The point here is to not modify the value if any of
> these failed. If any of the cmpxchg() failed, it means whatever interrupted
> it did a rb_time_set(), and that means the value will be valid if a
> __rb_time_read() was done on it again.

Except for the case where the interrupting write came before re-load of cnt.

> 
> It doesn't need a rb_time_set() in this context to make it valid again.
> That's because an interrupting context had already done that.

Except for the interrupt before re-load of cnt.

> 
>>
>>           return true;
>>
>> So this overflow scenario on top of cmpxchg does not cause corrupted
>> time stamps, but does cause subsequent __rb_time_read() and rb_time_cmpxchg()
>> to fail until an eventual rb_time_set().
> 
> I still don't see that.

See explanation above.

> 
>>
>>>
>>> Although, I should also change this to be:
>>>
>>> struct rb_time_struct {
>>> 	local_t		cnt;
>>> 	local_t		msb;
>>> 	local_t		top;
>>> 	local_t		bottom;
>>> };
>>>
>>> To match the order of bits as mentioned above.
>>>
>>> static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
>>> {
>>> 	unsigned long cnt, top, bottom, msb;
>>> 	unsigned long cnt2, top2, bottom2, msb2;
>>> 	u64 val;
>>>
>>> 	/* The cmpxchg always fails if it interrupted an update */
>>> 	 if (!__rb_time_read(t, &val, &cnt2))
>>>
>>> ## So the value has to succeed to continue. This is why I don't think order
>>> ## matters between them.
>>>
>>> 		 return false;
>>>
>>> 	 if (val != expect)
>>>
>>> ## Must also be what was expected
>>>
>>> 		 return false;
>>>
>>> 	 cnt = local_read(&t->cnt);
>>>
>>> ## We read the full 32 bits here.
>>>
>>> 	 if ((cnt & 3) != cnt2)
>>>
>>> ## This is mostly a paranoid check. For this to fail, the interrupting
>>> ## context had to write a full timestamp that this context expected,
>>> ## otherwise the (val != expect) would be true.
>>
>> As I state in my scenario above, the interrupting context can happen
>> after the (val != expect) check.
> 
> Which I agree should be fixed. That is, we need to have:
> 
> static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
> {
> 	unsigned long cnt, top, bottom, msb;
> 	unsigned long cnt2, top2, bottom2, msb2;
> 	u64 val;
> 
> +	/* Interrupting writes should make this function fail */
> +	 cnt = local_read(&t->cnt);

4 nested writes happening just after this read will cause the cnt & 3 check
below to incorrectly succeed.

> +
> 	/* The cmpxchg always fails if it interrupted an update */
> 	 if (!__rb_time_read(t, &val, &cnt2))
> 		 return false;

I'd favor returning the full 32-bit "cnt" value from __rb_time_read instead
so we don't introduce additional state/races.

> 
> 	 if (val != expect)
> 		 return false;
> 
> -	 cnt = local_read(&t->cnt);
> 	 if ((cnt & 3) != cnt2)
> 		 return false;
> 
> 	[..]
> 
>>
>>>
>>> 		 return false;
>>>
>>> 	 cnt2 = cnt + 1;

cnt and cnt2 here would be in the past because they do not take into account the
increments of the 4 nested writes.

>>>
>>> ## We take the 32 bit number and add 1 to it
>>>
>>> 	 rb_time_split(val, &top, &bottom, &msb);
>>> 	 top = rb_time_val_cnt(top, cnt);
>>> 	 bottom = rb_time_val_cnt(bottom, cnt);
>>>
>>> 	 rb_time_split(set, &top2, &bottom2, &msb2);
>>> 	 top2 = rb_time_val_cnt(top2, cnt2);
>>> 	 bottom2 = rb_time_val_cnt(bottom2, cnt2);
>>>
>>> ## Now the above takes the value to what was expected and sprinkles the cnt
>>> ## on it as "salt"
>>>
>>> 	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
>>> 		return false;

This cmpxchg would however catch it, because it compares against the whole
32-bit "cnt" value.


>>>
>>> ## if something came in here, we fail immediately with no corruption. This
>>> ## cmpxchg() is not affected by 4 writes
>>>
>>> 	if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
>>> 		return false;
>>>
>>> ## if we fail here, it means that something came in and wrote all values
>>> ## making everything correct again.
>>>
>>> 	if (!rb_time_read_cmpxchg(&t->top, top, top2))
>>> 		return false;
>>> 	if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
>>> 		return false;
>>>
>>> ## The same is true for all the above.
>>
>> Not if the interrupting context happens right after the (val != expect) check,
>> as stated in my scenario.
> 
> And is fixed with what I mentioned.

Yes, moving the read before seems to work, although I would favor returning the
whole 32-bit cnt from __rb_time_read for simplicity's sake.

> 
>>
>>>
>>> 	return true;
>>> }
>>>
>>>

[...]

> 
>>
>>> . The point is that a cmpxchg() should not corrupt a
>>> write that was done by an interrupting context. The logic can fail if the
>>> cmpxchg wants to update one of the fields to a new number, but the
>>> interrupting write kept it the same 4 times. That is, it did not update the
>>> number.
>>
>> I'm failing to see how letting a cmpxchg succeed in a case where a store
>> just happened to write all of its expected values would be a bug ?
> 
> Because it could be:
> 
> 	top = 0x1
> 	bottom = 0xffff0000
> 
> And the interrupt caused that to be:
> 
> 	top = 0x2
> 	bottom = 0x00000000
> 
> But the lower context wanted it to be:
> 
> 	top = 0x1
> 	bottom = 0xffffff00
> 
> We don't want the end result to be:
> 
> 	top = 0x1
> 	bottom = 0x00000000
> 
> Because of a false positive "match". (Note, the above isn't a good example,
> but I'm too tired to think of one that will actually cause the problem. But
> I think you can get the gist of it).

OK, I think I get it now. So we have this:

rb_time_cmpxchg
   - does a few of the piecewise updates
   < interrupted >
    rb_time_set 4x
   < iret >
   - continues doing one or more of the piecewise updates which are remaining, which
     happen to match the last written field.

More precisely:

static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
[...]
         if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
                 return false;
         if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
                 return false;
    <interrupted here>
     rb_time_set() 4x, which leaves a matching old "top" value.

         if (!rb_time_read_cmpxchg(&t->top, top, top2))
                 return false;
         ^ this cmpxchg can succeed if the old top value written by
           rb_time_set matches, thus corrupting the top value. It will
           increment the 2-bit cnt as well through, which will cause
           following reads to fail.

         if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
                 return false;
         ^ likewise for the bottom value, except that because reads
           to not validate the 2-bit cnt of the bottom part, this
           is silent corruption.
  
> 
>>
>> And if the nested writes happen bewtween the cmpxchg to top and bottom, and
>> the cmpxchg bottom happen to expect exactly the content of the write, then
>> it would increment the 2-bit cnt of bottom to a value which won't match
>> top/msb, which would cause following reads to fail.
> 
> Yes, if there's a false match (a match that should not have happened), then
> yes, it will corrupt the counter and make reads fail. But currently it's
> near impossible to get that false match. But I think we should make it
> totally impossible to do so.

Agreed.

[...]
>>
>> Yes, the nesting approach might work better than a 2-bit counter for tracking
>> interruption of reads/cmpxchg by stores/cmpxchg.
> 
> Although, it may need at least the LSB of the count too, and we make it
> three bits, where the LSB is the LSB of the count and bits 1 and 2 are the
> context level. That's because we still need to have the interrupting
> context know that the words are in the process of being updated. All it
> needs is a toggle, because that bit will go from 0 to 1 in any given
> context.
> 
> That way, if a irq interrupts a soft irq, it may see:
> 
> 	msb:	0 1 0
> 	top:	0 1 0
> 	bottom:	0 1 1
> 
> And know that it interrupted it between top and bottom.

Yes.

> 
>>
>>>    
>>>>
>>>> - After a cmpxchg fails between updates to top and msb, a write is
>>>>     needed before read and cmpxchg can succeed again. I am not entirely
>>>>     sure the rest of the ring buffer handles this correctly.
>>>
>>> Note, a cmpxchg() can only fail if it was interrupted by a higher context.
>>> The higher context would be doing a write for the cmpxchg() to fail. If a
>>> cmpxchg() fails, it means that a higher context has already modified it and
>>> in fact, if a cmpxchg() fails, a read should be guaranteed to succeed if
>>> done after the failure, because the higher context already did the write.
>>
>> Not in the 2-bit overflow scenario I detailed above.
> 
> I still see moving the read of cnt to the beginning as fixing that.

Yes. Or simpler: returning the full 32-bit cnt value from __rb_time_read().

[...]
>>>>     *
>>>> - *  - Reads may fail if it interrupted a modification of the time stamp.
>>>> + *  - Read may fail if it interrupted a modification of the time stamp.
>>>>     *      It will succeed if it did not interrupt another write even if
>>>>     *      the read itself is interrupted by a write.
>>>> + *      A read will fail if it follows a cmpxchg which failed between
>>>> + *      updates to its top and msb bits, until a write is performed.
>>>> + *      (note: this limitation may be unexpected in parts of the
>>>> + *      ring buffer algorithm)
>>>>     *      It returns whether it was successful or not.
>>>>     *
>>>> - *  - Writes always succeed and will overwrite other writes and writes
>>>> + *  - Write always succeeds and will overwrite other writes and writes
>>>
>>> Hmm, Not sure I agree with the above. It should be plural, as in "All
>>> writes".
>>
>> Then we should pick either "writes/reads" and "they", or "A write/A read"
>> and "it", but not a mix.
> 
> Where do you see it mixed?

"Reads may fail if it interrupted a modification of the time stamp."

"Reads" vs "it".

And there is a mix of "Reads", "Writes", "A write" and "A cmpxchg" in the
list. This lacks consistency.

[...]

> 
>>
>>>
>>>    
>>>>     *      Other than that, it acts like a normal cmpxchg.
>>>>     *
>>>> - * The 60 bit time stamp is broken up by 30 bits in a top and bottom half
>>>> - *  (bottom being the least significant 30 bits of the 60 bit time stamp).
>>>> + * The 64-bit time stamp is broken up, from most to least significant,
>>>> + * in: msb, top and bottom fields, of respectively 4, 30, and 30 bits.
>>>>     *
>>>> - * The two most significant bits of each half holds a 2 bit counter (0-3).
>>>> + * The two most significant bits of each field hold a 2-bit counter (0-3).
>>>>     * Each update will increment this counter by one.
>>>> - * When reading the top and bottom, if the two counter bits match then the
>>>> - *  top and bottom together make a valid 60 bit number.
>>>> + * When reading the top, bottom, and msb fields, if the two counter bits
>>>> + *   match, then the combined values make a valid 64-bit number.
>>>> + *
>>>> + * Counter limits. The following situations can generate overflows that
>>>> + * produce corrupted time stamps:
>>>> + *
>>>> + * - A read or a write interrupted by 2^32 writes or cmpxchg.
>>>> + *
>>>> + * - A cmpxchg interrupted by 4 writes or cmpxchg.
>>>> + *   (note: this is not sufficient and should be fixed)
>>>
>>> Remember, it's not just 4 writes that cause it to fail, but also those 4
>>> writes must have the same value, as the cmpxchg() doesn't just look at the
>>> 2 bits, it looks at the rest of the value too.
>>
>> It would not require all 4 of the writes to store the same value, just the
>> last one.
>>
>> Although I detailed an overflow scenario that causes reads to fail after a
>> partially successful cmpxchg, I'm currently failing to understand how the 4
>> writes would cause a read to observe an actual corrupted value.
> 
> reads detect happening within a write. So there is no "4 writes" when doing
> a read. The read cares about what it interrupted, not what interrupted it.
> 
> The order of the cmpxchg that your patch fixed does affect this, because it
> missed the "bottom" update.

I suspect that we'd want the read to check the cnt bits of each of msb, top
and bottom to protect against the scenario where the cmpxchg incorrectly
matches any of the fields and corrupts its content. However it may not be
necessary if we switch to the context level approach you suggest.

[...]

> 
> Having a single toggle and the context level should be sufficient. As two
> bits will tell you which context updated the timestamp, which is useful for
> knowing it got interrupted, and the toggle bit is to let interrupting
> context know the timestamp is being updated.

Yes, that sounds good.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

