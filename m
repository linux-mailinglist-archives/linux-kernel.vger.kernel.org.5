Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E374D754E0C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGPJUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 05:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGPJUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 05:20:23 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B279D19BA;
        Sun, 16 Jul 2023 02:20:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8A2D34212E;
        Sun, 16 Jul 2023 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689499209;
        bh=RvtuONHxMD/ZuJdUaeGGTHUhbKkZrSzqRQIoqmU01DY=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To;
        b=PwkjPMefbVkwucRe6o1ZDMtbaQGU+pNuvcqpP/UOgfOFIYafyM3cVx2dVmXF3RcVW
         LeAUki4Sl2bEqqa/dMlC5TuxX5GYj+OwXSrr8PKPGoHRZz5CJrW/GaVInqU3Mdr6Ly
         ojIjy4wlFyne6ap07W1BRz9u7/O3GTPMZXnJ2DGwNg5y6C4Njs8Hl7BRhRL8NL1aey
         YBWlx8WR8vU9izrJmnn0R0z++6ruGBKdJv07gJFjL1oCLWUHY4yyLSTQshoDfPu4HO
         WBsfbYQtYp4pRcS/TYelJE8uVJjrW30Ofywz7tUq2sAyIu8fok2LnLBAwQAoBwsFZo
         sQKwTY1gV9OgQ==
Message-ID: <5780e4c4-b0a0-382f-d659-9c4722a3582c@asahilina.net>
Date:   Sun, 16 Jul 2023 18:20:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH v2] rust: time: New module for timekeeping functions
To:     Thomas Gleixner <tglx@linutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Josh Stone <jistone@redhat.com>,
        Gaelan Steele <gbs@canishe.com>,
        Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev
References: <20230714-rust-time-v2-1-f5aed84218c4@asahilina.net>
 <87r0pax9a6.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87r0pax9a6.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2023 10.17, Thomas Gleixner wrote:
> Lina!
> 
> On Fri, Jul 14 2023 at 16:55, Asahi Lina wrote:
>> +ktime_t rust_helper_ktime_get_real(void) {
>> +	return ktime_get_real();
>> +}
>> +EXPORT_SYMBOL_GPL(rust_helper_ktime_get_real);
> 
> Colour me confused. But why does this need another export?

Static inline functions aren't exported, so Rust can't call them.

> This just creates yet another layer of duct tape. If it's unsafe from
> the rust perspective then wrapping it into rust_"unsafe_function" does not
> make it any better.
> 
> Why on earth can't you use the actual C interfaces diretly which are
> already exported?

Because Rust isn't C and can't compile static inline C code...

Bindgen very recently gained a feature to autogenerate these wrappers, 
but we're not on that version yet. But there's no reasonable way around 
the wrappers, whether they are automatically generated or not, unless 
someone wants to write a whole C->Rust transpiler...

>> +use crate::{bindings, pr_err};
>> +use core::marker::PhantomData;
>> +use core::time::Duration;
>> +
>> +/// Represents a clock, that is, a unique time source.
>> +pub trait Clock: Sized {}
>> +
>> +/// A time source that can be queried for the current time.
> 
> I doubt you can read anything else than current time from a time
> source. At least the C side does not provide time traveling interfaces
> unless the underlying hardware goes south.

My thought was that we might have time sources (think some kind of 
hardware clock) which might want to use these types but cannot be 
queried for the current time globally (e.g. they are bound to a specific 
device and need state to query the time, so you can't just have a global 
read function with no arguments). Those would probably be declared 
within other subsystems or drivers, so they don't belong here, but the 
idea that a clock source and the ability to query it statically at any 
time are distinct concepts does, to enable that use case with this 
common API.

>> +pub trait Now: Clock {
>> +impl<T: Clock> Instant<T> {
>> +    fn new(nanoseconds: i64) -> Self {
>> +        Instant {
>> +            nanoseconds,
>> +            _type: PhantomData,
>> +        }
>> +    }
>> +
>> +    /// Returns the time elapsed since an earlier Instant<t>, or
>> +    /// None if the argument is a later Instant.
>> +    pub fn since(&self, earlier: Instant<T>) -> Option<Duration> {
>> +        if earlier.nanoseconds > self.nanoseconds {
>> +            None
>> +        } else {
>> +            // Casting to u64 and subtracting is guaranteed to give the right
>> +            // result for all inputs, as long as the condition we checked above
>> +            // holds.
>> +            Some(Duration::from_nanos(
>> +                self.nanoseconds as u64 - earlier.nanoseconds as u64,
> 
> Clever, but any timestamp greater than KTIME_MAX or less than 0 for such
> a comparison is invalid. I'm too lazy to do the math for you..

This is computing a Rust Duration (which is unsigned and always 
positive) from the difference between two ktimes. As long as the two 
ktimes have the right >= relationship, the difference will always lie 
within the representable range of an unsigned 64-bit integer, which is 
itself a subset of the representable range of a Rust Duration (which is 
u64 seconds + u32 nanoseconds). This is trivially true, since the types 
have the same size and the absolute difference between two values can 
never exceed the number of values representable in that number of bits, 
regardless of whether the types are signed or unsigned. Feel free to do 
the math ^^

Or are you saying ktime timestamps can never be negative anyway, or that 
those conditions should be special-cased somehow?

> 
>> +            ))
>> +        }
>> +    }
>> +}
>> +
>> +impl<T: Clock + Now + Monotonic> Instant<T> {
>> +    /// Returns the time elapsed since this Instant<T>.
>> +    ///
>> +    /// This is guaranteed to return a positive result, since
>> +    /// it is only implemented for monotonic clocks.
>> +    pub fn elapsed(&self) -> Duration {
>> +        T::now().since(*self).unwrap_or_else(|| {
>> +            pr_err!(
>> +                "Monotonic clock {} went backwards!",
>> +                core::any::type_name::<T>()
> 
> Can you please write this in one line?
> 
>   +            pr_err!("Monotonic clock {} went backwards!", core::any::type_name::<T>()
> 
> The above is unreadable gunk for no reason.

We use rustfmt style for all Rust code in the kernel, and this code 
follows that. See Documentation/rust/coding-guidelines.rst.

>> +/// Contains the various clock source types available to the kernel.
>> +pub mod clock {
>> +    use super::*;
>> +
>> +    /// A clock representing the default kernel time source.
>> +    ///
>> +    /// This is `CLOCK_MONOTONIC` (though it is not the only
>> +    /// monotonic clock) and also the default clock used by
>> +    /// `ktime_get()` in the C API.
> 
> This "(though it is not the only monotonic clock)" phrase is irritating
> at best. CLOCK_MONOTONIC is well defined as the other CLOCK_* variants.

The issue I ran into here is what to call this clock when "Monotonic" is 
both a trait that a clock can have and the name of the canonical default 
clock. CLOCK_BOOTTIME is also monotonic and therefore implements the 
Monotonic trait. That's why I called it KernelTime and why I made a 
point that, while this one is called CLOCK_MONOTONIC in C, it's not the 
*only* monotonic clock.

I'm open to suggestions for the naming, I just think we might as well 
try to make things clear since clock selection can be a confusing thing.

>> +    ///
>> +    /// This is like `BootTime`, but does not include time
>> +    /// spent sleeping.
>> +
>> +    pub struct KernelTime;
>> +
>> +    impl Clock for KernelTime {}
>> +    impl Monotonic for KernelTime {}
>> +    impl Now for KernelTime {
>> +        fn now() -> Instant<Self> {
>> +            Instant::<Self>::new(unsafe { bindings::ktime_get() })
>> +        }
>> +    }
>> +
>> +    /// A clock representing the time elapsed since boot.
>> +    ///
>> +    /// This is `CLOCK_MONOTONIC` (though it is not the only
>> +    /// monotonic clock) and also the default clock used by
>> +    /// `ktime_get()` in the C API.
> 
> The wonders of copy and pasta...

Oops, sorry... I'll fix it for v2.

> 
>> +    ///
>> +    /// This is like `KernelTime`, but does include time
>> +    /// spent sleeping.
> 
> Can you please expand your editors line wrap limit to the year 2023
> standards? This looks like a IBM 2260 terminal.

I think I manually wrapped this, I can rewrap it up to the rustfmt limit 
for v2.

>> +    /// A clock representing TAI time.
>> +    ///
>> +    /// This clock is not monotonic and can be changed from userspace.
>> +    /// However, it is not affected by leap seconds.
> 
> I'm not impressed by this at all.
> 
> Lots of copy and pasta with zero content. I don't see how this is an
> improvement over the admittedly lousy or non-existant kernel interface
> documentations.
> 
> I thought Rust is set out to be better, but obviously it's just another
> variant of copy & pasta and sloppy wrappers with useless documentation
> around some admittedly not well documented, but well understood C
> interfaces.

At least the API doesn't conflate all clock sources as well as intervals 
derived from them into a single type, like the C API does... I thought 
that was what we were aiming to fix here, based on the previous discussion.

I can definitely improve the docs, but I don't think it's fair to call 
this "copy & pasta sloppy wrappers"...

> So the right approach to this is:
> 
>   1) Extend the kernel C-API documentations first if required

I am not comfortable further documenting the Linux timekeeping 
subsystem, since I am not an expert in that area... if you think the 
docs should be improved across the board, I'm afraid you'll have to do 
that yourself first. It doesn't make any sense for me to become a 
timekeeping expert just to write some missing C docs.

I'm trying to upstream abstractions for a whole bunch of Linux 
subsystems, I can't become an expert in all of them to improve the C 
docs just because the people writing the C code didn't document it 
properly themselves... it's hard enough wrapping my head around the 
lifetime constraints and all that stuff already (which is almost never 
documented), just to make sure the Rust abstraction is safe. Thankfully 
that one isn't an issue for timekeeping, since there are no objects with 
lifetimes...

>   2) Build your wrapper so that it can refer to the documentation which
>      was either there already or got refined/added in #1

The Rust documentation needs to at least cover the Rust API. I can link 
to Documentation/core-api/timekeeping.rst for reference, but we still 
need module/function docs in the Rust code.

What I can certainly do is expand on the current docs with more details 
from that file, to try to get things more consistent. I'll look it over 
for v2.

>   3) Add one clock per patch with a proper changelog and not some
>      wholesale drop it all.

The whole file is 151 lines of code... do you really want me to break it 
up into 5 patches where the last 4 add 10 lines each? What does that 
accomplish? I don't get it... it's just a bunch of clock options, it's 
not like there's any logic to review or actual clock implementations here.

~~ Lina

