Return-Path: <linux-kernel+bounces-164485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C526F8B7E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE23B239A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A1917BB11;
	Tue, 30 Apr 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SDPYUuBw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fEtlFSy8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290C17A939;
	Tue, 30 Apr 2024 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496562; cv=none; b=jbkTpj0WQiq4oUSUS1L57Euseth504dV1iEm66XoSf7ZDL+W3s68AeEI4C3bY6YMmtskrLWAJ2OvsDmFDU1czTBUypCKo03Xe2JFXG1kg/0u8ufKn3BQ0bkAL4pstgoCGDqlE+Z9UmD4HLIw1z/cZf+z8Q/BdgaNffX62IclyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496562; c=relaxed/simple;
	bh=JmvLjoWJUwChlhALyFEH9riQ9ruNyjhirZSG/15Xwhk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IyoOu61DVaNE50/HgpSVq8wxMxu54zLGEpAhKLRjahuoT2/rJJu5yEXAHE0eHOPUhPMCvL3QoLZEcpD5IC9J/776u3LovEWmU4wLOYvY56vRMuKSnyKt7qdxmOB8YK6Ddn6v1czSF81J625fjrtMP2PYu0CHZkeDOHngzoJ4kVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SDPYUuBw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fEtlFSy8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714496559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WRhuqnwy0WI0wyTJs5CQs17OaZHMPo/XpcCW7I5z08Q=;
	b=SDPYUuBwSzU4wyQKNg9V/cToAZOOYoMlk4dqIS3nZ8oOzOA9lW0BDRdsTjLGP0KgBqmEYR
	0jDVOmgXQWHM+2ErfjnlaBWfnnkJrnzNFszaNUk+0eVjcsiMvMf7OCpD9BWs7DAihvFc77
	P9EAM7HAGEzFQIx9TiF+Kd0qeMGDLAzm+EPlpu3wAJNb7mZk7bCkEJ+oxJoJvH7UsuyJ5l
	AjEQvYZ5ylssITSQvE4lfDeZtnqeHmV5CLBEroGnN9oGxDsp335UckXYfbCYvElQmh9Yjy
	EOjyrSdd0cwkjLdZm1dEn6SMG6bEhZ9xtWjBDtPrDU9YUSzBm3O4s01qrcr7iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714496559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WRhuqnwy0WI0wyTJs5CQs17OaZHMPo/XpcCW7I5z08Q=;
	b=fEtlFSy8sOAoPJ7IRieA/ZAkWW+ZmwjLpUgOHJUwMG15MWx+TSCKTi+7YGLgtKh/1ZBkRA
	Rj9wljOacejMbOCw==
To: Andreas Hindborg <nmi@metaspace.dk>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice
 Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: hrtimer: introduce hrtimer support
In-Reply-To: <20240425094634.262674-1-nmi@metaspace.dk>
References: <20240425094634.262674-1-nmi@metaspace.dk>
Date: Tue, 30 Apr 2024 19:02:36 +0200
Message-ID: <87r0emss0j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas!

On Thu, Apr 25 2024 at 11:46, Andreas Hindborg wrote:

I'm looking at this purely from a hrtimer perspective and please excuse
my minimal rust knowledge.

> +// SAFETY: A `Timer` can be moved to other threads and used from there.
> +unsafe impl<T> Send for Timer<T> {}
> +
> +// SAFETY: Timer operations are locked on C side, so it is safe to operate on a
> +// timer from multiple threads

Kinda. Using an hrtimer from different threads needs some thought in the
implementation as obviously ordering matters:

     T1                              T2
     hrtimer_start()                 hrtimer_cancel()

So depending on whether T1 gets the internal lock first or T2 the
outcome is different. If T1 gets it first the timer is canceled by
T2. If T2 gets it first the timer ends up armed.

> +unsafe impl<T> Sync for Timer<T> {}
> +
> +impl<T: TimerCallback> Timer<T> {
> +    /// Return an initializer for a new timer instance.
> +    pub fn new() -> impl PinInit<Self> {
> +        crate::pin_init!( Self {
> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtimer| {
> +                // SAFETY: By design of `pin_init!`, `place` is a pointer live
> +                // allocation. hrtimer_init will initialize `place` and does not
> +                // require `place` to be initialized prior to the call.
> +                unsafe {
> +                    bindings::hrtimer_init(
> +                        place,
> +                        bindings::CLOCK_MONOTONIC as i32,
> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,

This is odd. The initializer really should take a clock ID and a mode
argument. Otherwise you end up implementing a gazillion of different
timers.

> +                    );
> +                }
> +
> +                // SAFETY: `place` is pointing to a live allocation, so the deref
> +                // is safe. The `function` field might not be initialized, but
> +                // `addr_of_mut` does not create a reference to the field.
> +                let function: *mut Option<_> = unsafe { core::ptr::addr_of_mut!((*place).function) };
> +
> +                // SAFETY: `function` points to a valid allocation.
> +                unsafe { core::ptr::write(function, Some(T::Receiver::run)) };

We probably should introduce hrtimer_setup(timer, clockid, mode, function)
to avoid this construct. That would allow to cleanup existing C code too.

> +            }),
> +            _t: PhantomData,
> +        })
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<T> PinnedDrop for Timer<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: By struct invariant `self.timer` was initialized by
> +        // `hrtimer_init` so by C API contract it is safe to call
> +        // `hrtimer_cancel`.
> +        unsafe {
> +            bindings::hrtimer_cancel(self.timer.get());
> +        }
> +    }
> +}
> +
> +/// Implemented by pointer types to structs that embed a [`Timer`]. This trait
> +/// facilitates queueing the timer through the pointer that implements the
> +/// trait.
> +///
> +/// Typical implementers would be [`Box<T>`], [`Arc<T>`], [`ARef<T>`] where `T`
> +/// has a field of type `Timer`.
> +///
> +/// Target must be [`Sync`] because timer callbacks happen in another thread of
> +/// execution.

Timer callbacks happen in hard or soft interrupt context.

> +/// [`Box<T>`]: Box
> +/// [`Arc<T>`]: Arc
> +/// [`ARef<T>`]: crate::types::ARef
> +pub trait RawTimer: Sync {
> +    /// Schedule the timer after `expires` time units
> +    fn schedule(self, expires: u64);

Don't we have some time related rust types in the kernel by now?

> +}

> +/// Implemented by pointer types that can be the target of a C timer callback.
> +pub trait RawTimerCallback: RawTimer {
> +    /// Callback to be called from C.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Only to be called by C code in `hrtimer`subsystem.
> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart;
> +}
> +
> +/// Implemented by pointers to structs that can the target of a timer callback
> +pub trait TimerCallback {
> +    /// Type of `this` argument for `run()`.
> +    type Receiver: RawTimerCallback;
> +
> +    /// Called by the timer logic when the timer fires
> +    fn run(this: Self::Receiver);
> +}
> +
> +impl<T> RawTimer for Arc<T>
> +where
> +    T: Send + Sync,
> +    T: HasTimer<T>,
> +{
> +    fn schedule(self, expires: u64) {
> +        let self_ptr = Arc::into_raw(self);
> +
> +        // SAFETY: `self_ptr` is a valid pointer to a `T`
> +        let timer_ptr = unsafe { T::raw_get_timer(self_ptr) };
> +
> +        // `Timer` is `repr(transparent)`
> +        let c_timer_ptr = timer_ptr.cast::<bindings::hrtimer>();
> +
> +        // Schedule the timer - if it is already scheduled it is removed and
> +        // inserted
> +
> +        // SAFETY: c_timer_ptr points to a valid hrtimer instance that was
> +        // initialized by `hrtimer_init`
> +        unsafe {
> +            bindings::hrtimer_start_range_ns(
> +                c_timer_ptr.cast_mut(),
> +                expires as i64,

same comment vs. time

> +                0,
> +                bindings::hrtimer_mode_HRTIMER_MODE_REL,

and mode.

> +            );
> +        }
> +    }
> +}
> +
> +impl<T> kernel::hrtimer::RawTimerCallback for Arc<T>
> +where
> +    T: Send + Sync,
> +    T: HasTimer<T>,
> +    T: TimerCallback<Receiver = Self>,
> +{
> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
> +        // `Timer` is `repr(transparent)`
> +        let timer_ptr = ptr.cast::<kernel::hrtimer::Timer<T>>();
> +
> +        // SAFETY: By C API contract `ptr` is the pointer we passed when
> +        // enqueing the timer, so it is a `Timer<T>` embedded in a `T`
> +        let data_ptr = unsafe { T::timer_container_of(timer_ptr) };
> +
> +        // SAFETY: This `Arc` comes from a call to `Arc::into_raw()`
> +        let receiver = unsafe { Arc::from_raw(data_ptr) };
> +
> +        T::run(receiver);
> +
> +        bindings::hrtimer_restart_HRTIMER_NORESTART

One of the common use cases of hrtimers is to create periodic schedules
where the timer callback advances the expiry value and returns
HRTIMER_RESTART. It might be not required for your initial use case at
hand, but you'll need that in the long run IMO.

Thanks,

        tglx

