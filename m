Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B32B78C24A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjH2KWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjH2KWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:22:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCA391
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:22:13 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693304531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1LUAdGxzScAMOm4Z4EfPTkjwHOUh0rmSHhAJnylK1+4=;
        b=BOvba0YUm0UoHVHiNqUFERKPaHIyqQXbJEZOhhXCg3bLnP27EqMZHQpeeLJtt9Gm+m68Wr
        KdKJ5EpuzqSdB4Zqp0qg/C5UY0vw20W0jU12p72gAu+xetZVWSAeVfAgrFXS46gqQvQ5K0
        xtR38ksTBITtUmI2VqZPTOtNL/rSjz4DDms0VMJ5chhxvVEVfAhdT0zuGcCgHDY8u2la42
        3PJYQsBqox2Xeno0LT5yi0SRfiE713ok+gV/ozEusPir6x6lTWwsZr8J2wj6vwbc4ycey2
        UQHehh/+aomrm1Y35hAu4K2fY4JTKu6jzJAl5uYch3RcCrQ0P45imNprJArxng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693304531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1LUAdGxzScAMOm4Z4EfPTkjwHOUh0rmSHhAJnylK1+4=;
        b=LmS8hR90dqF1IcFx5E8k/ZaBQlyXML2jhAqpC+OiuIUzlML3Sj/NKa5J/Qf8u4tZwkQ0rV
        TEQFdJ3rTyEJQuBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: hostile takeover: Re: [PATCH printk v2 3/8] printk: nbcon: Add
 acquire/release logic
In-Reply-To: <ZNOKSFAGPxYFeeJT@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-4-john.ogness@linutronix.de>
 <ZNOKSFAGPxYFeeJT@alley>
Date:   Tue, 29 Aug 2023 12:28:10 +0206
Message-ID: <87o7iqrvvx.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-09, Petr Mladek <pmladek@suse.com> wrote:
>> Add per console acquire/release functionality. The console 'locked'
>> state is a combination of multiple state fields:
>> 
>>   - Hostile takeover
>> 
>>       The new owner takes the console over without 'req_prio'
>>       handshake.
>> 
>>       This is required when friendly handovers are not possible,
>>       i.e. the higher priority context interrupted the owning
>>       context on the same CPU or the owning context is not able
>>       to make progress on a remote CPU.
>
> I always expected that there would be only one hostile takeover.
> It would allow to take the lock a harsh way when the friendly
> way fails.

You are referring to the hostile takeover when unsafe. A hostile
takeover when safe is still considered a hostile takeover. (At least,
until now that is how it was considered. More below...)

>> All other policy decisions have to be made at the call sites:
>> 
>>   - What is marked as an unsafe section.
>>   - Whether to spinwait if there is already an owner.
>>   - Whether to attempt a hostile takeover when safe.
>>   - Whether to attempt a hostile takeover when unsafe.
>
> But there seems to be actually two variants. How they are
> supposed to be used, please?
>
> I would expect that a higher priority context would always
> be able to takeover the lock when it is in a safe context.
>
> By other words, "hostile takeover when safe" would be
> the standard behavior for context with a higher priority.

The difference is that with "hostile takeover when safe" there is a
foreign CPU that still thinks it has the lock, even though it does not.

> By other words, the difference between normal takeover and
> "hostile takeover when safe" is that the 1st one has to
> wait until the current owner calls nbcon_enter_unsafe().
> But the result is the same. The current owner might
> prematurely end after calling nbcon_enter_unsafe().
>
> Maybe, this another relic from the initial more generic approach?

I suppose so. But then why not try the "hostile takeover when safe"
first and only use the handover request as a fallback? Like this:

1. try direct
2. try hostile takeover when safe
3. try handover
4. try hostile takeover when unsafe

Then we should remove the "hostile" label for #2 and just call it:

1. try direct
2. try safe takeover
3. try handover
4. try hostile takeover

(I guess this is how you imagined things should be.)

>> +/**
>> + * struct nbcon_context - Context for console acquire/release
>> + * @console:		The associated console
>> + * @spinwait_max_us:	Limit for spinwait acquire
>> + * @prio:		Priority of the context
>> + * @unsafe:		This context is in an unsafe section
>
> This seems to be an input value for try_acquire(). It is
> controversial.
>
> I guess that it removes the need to call nbcon_enter_unsafe()
> right after try_acquire_console().

Yes. It removes the "safe window" between try_acquire_console() and
nbcon_enter_unsafe() by allowing to acquire and mark unsafe
atomically. For example, this would be useful for the port_lock()
wrapper we discussed. But it is not strictly necessary. I can remove it.

Below I answer your comments anyway.

> Hmm, this semantic is problematic:
>
>   1. The result would be non-paired enter_unsafe()/exit_unsafe()
>      calls.

The paired calls are either:

try_acquire(unsafe=1) -> release()

or

try_acquire(unsafe=0) + enter_unsafe() -> exit_unsafe() + release()

>   2. I would personally expect that this is an output value
>      set by try_acquire() so that the context might know
>      how it got the lock.

The state structure is used to communicate this information.

>   3. Strictly speaking, as an input value, it would mean that
>      try_acquire() is called when the console is in "unsafe" state.
>      But the caller does not know in which state the console
>      is until it acquires the lock.

This is not about the current state. The calling _context_ wants to set
a certain state. The caller wants to acquire the lock and atomically
mark this as the beginning of an unsafe section. But as I wrote, this is
not strictly necessary. Only an efficient convenience.

> For me it is not easy to remember which permutation is used where ;-)
> It would be easier if we remove the "hostile when safe" variant.
> Then 3 variables might be enough. I suggest something like:
>
>   state.unsafe		 Console is busy and takeover is not safe.
>
>   state.unsafe_takeover  A hostile takeover in an unsafe state happened
> 			 in the past. The console can't be safe until
> 			 re-initialized.
>
>   ctxt.allow_unsafe_takeover Allow hostile takeover even if unsafe.
> 			Can be used only with PANIC prio. Might cause
> 			a system freeze when the console is used later.

Since "safe takeovers" should be handled equivalent to "handovers" then
I agree with your suggestion.

John
