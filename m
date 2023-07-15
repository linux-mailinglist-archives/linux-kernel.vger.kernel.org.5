Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD2C754611
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 03:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjGOBR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 21:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGOBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 21:17:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB59F30F2;
        Fri, 14 Jul 2023 18:17:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689383874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eHk2tOCqQMTJhAv0OhLX1AImQflejUiinIzgDnEw15o=;
        b=4FfZzhpgC69m4IIl+wXu19M/lJvDJ2/smwPCfc9uu2TrAfng9K9zKXo8YDVCPUfKG6pjn6
        W0nuuS8sXuXGR5mmsDKiXhv90LkpZ9PltSc4qUT58Y1IyksSP/ofwrrAcqTsJ6AW9s/dh7
        ND2f+FwR3HteWdsfTidwRBO7zxuSQ2Z7nD1LRgVVL+Rj2eXqVd6wxxiJj4Sdq8EK3WJ9N6
        Opn0wa2B1b90aVAs7vMeyBRlDriY6zzpeBevexoPfHkFr60PlFS9QsSaTOM0CSNHokmMT7
        aUYrCSAVaGkwjqlTfLzmLsxOa8P1Sitmj0KVqLCa51+d5QmgMm9Dy5Dp+0YWZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689383874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eHk2tOCqQMTJhAv0OhLX1AImQflejUiinIzgDnEw15o=;
        b=Mvu8OEbiZ2tqFwZjYX93HcfO5oGZFo+VN91sd5JBlc2gjlhA7jjCtowATAKIw2w7OIvM4F
        PPg1FFjo8aphc0Ag==
To:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Josh Stone <jistone@redhat.com>,
        Gaelan Steele <gbs@canishe.com>,
        Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH v2] rust: time: New module for timekeeping functions
In-Reply-To: <20230714-rust-time-v2-1-f5aed84218c4@asahilina.net>
References: <20230714-rust-time-v2-1-f5aed84218c4@asahilina.net>
Date:   Sat, 15 Jul 2023 03:17:53 +0200
Message-ID: <87r0pax9a6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lina!

On Fri, Jul 14 2023 at 16:55, Asahi Lina wrote:
> +ktime_t rust_helper_ktime_get_real(void) {
> +	return ktime_get_real();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_ktime_get_real);

Colour me confused. But why does this need another export?

This just creates yet another layer of duct tape. If it's unsafe from
the rust perspective then wrapping it into rust_"unsafe_function" does not
make it any better.

Why on earth can't you use the actual C interfaces diretly which are
already exported?

> +use crate::{bindings, pr_err};
> +use core::marker::PhantomData;
> +use core::time::Duration;
> +
> +/// Represents a clock, that is, a unique time source.
> +pub trait Clock: Sized {}
> +
> +/// A time source that can be queried for the current time.

I doubt you can read anything else than current time from a time
source. At least the C side does not provide time traveling interfaces
unless the underlying hardware goes south.

> +pub trait Now: Clock {
> +impl<T: Clock> Instant<T> {
> +    fn new(nanoseconds: i64) -> Self {
> +        Instant {
> +            nanoseconds,
> +            _type: PhantomData,
> +        }
> +    }
> +
> +    /// Returns the time elapsed since an earlier Instant<t>, or
> +    /// None if the argument is a later Instant.
> +    pub fn since(&self, earlier: Instant<T>) -> Option<Duration> {
> +        if earlier.nanoseconds > self.nanoseconds {
> +            None
> +        } else {
> +            // Casting to u64 and subtracting is guaranteed to give the right
> +            // result for all inputs, as long as the condition we checked above
> +            // holds.
> +            Some(Duration::from_nanos(
> +                self.nanoseconds as u64 - earlier.nanoseconds as u64,

Clever, but any timestamp greater than KTIME_MAX or less than 0 for such
a comparison is invalid. I'm too lazy to do the math for you..

> +            ))
> +        }
> +    }
> +}
> +
> +impl<T: Clock + Now + Monotonic> Instant<T> {
> +    /// Returns the time elapsed since this Instant<T>.
> +    ///
> +    /// This is guaranteed to return a positive result, since
> +    /// it is only implemented for monotonic clocks.
> +    pub fn elapsed(&self) -> Duration {
> +        T::now().since(*self).unwrap_or_else(|| {
> +            pr_err!(
> +                "Monotonic clock {} went backwards!",
> +                core::any::type_name::<T>()

Can you please write this in one line?

 +            pr_err!("Monotonic clock {} went backwards!", core::any::type_name::<T>()

The above is unreadable gunk for no reason.

> +/// Contains the various clock source types available to the kernel.
> +pub mod clock {
> +    use super::*;
> +
> +    /// A clock representing the default kernel time source.
> +    ///
> +    /// This is `CLOCK_MONOTONIC` (though it is not the only
> +    /// monotonic clock) and also the default clock used by
> +    /// `ktime_get()` in the C API.

This "(though it is not the only monotonic clock)" phrase is irritating
at best. CLOCK_MONOTONIC is well defined as the other CLOCK_* variants.

> +    ///
> +    /// This is like `BootTime`, but does not include time
> +    /// spent sleeping.
> +
> +    pub struct KernelTime;
> +
> +    impl Clock for KernelTime {}
> +    impl Monotonic for KernelTime {}
> +    impl Now for KernelTime {
> +        fn now() -> Instant<Self> {
> +            Instant::<Self>::new(unsafe { bindings::ktime_get() })
> +        }
> +    }
> +
> +    /// A clock representing the time elapsed since boot.
> +    ///
> +    /// This is `CLOCK_MONOTONIC` (though it is not the only
> +    /// monotonic clock) and also the default clock used by
> +    /// `ktime_get()` in the C API.

The wonders of copy and pasta...

> +    ///
> +    /// This is like `KernelTime`, but does include time
> +    /// spent sleeping.

Can you please expand your editors line wrap limit to the year 2023
standards? This looks like a IBM 2260 terminal.

> +    /// A clock representing TAI time.
> +    ///
> +    /// This clock is not monotonic and can be changed from userspace.
> +    /// However, it is not affected by leap seconds.

I'm not impressed by this at all.

Lots of copy and pasta with zero content. I don't see how this is an
improvement over the admittedly lousy or non-existant kernel interface
documentations.

I thought Rust is set out to be better, but obviously it's just another
variant of copy & pasta and sloppy wrappers with useless documentation
around some admittedly not well documented, but well understood C
interfaces.

So the right approach to this is:

 1) Extend the kernel C-API documentations first if required

 2) Build your wrapper so that it can refer to the documentation which
    was either there already or got refined/added in #1

 3) Add one clock per patch with a proper changelog and not some
    wholesale drop it all.

It's well documented in Documentation/process/*, no?

Thanks,

        tglx







