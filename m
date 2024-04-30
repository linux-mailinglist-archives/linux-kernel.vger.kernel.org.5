Return-Path: <linux-kernel+bounces-163918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C33C8B75D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97461F22F40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBFB171E4A;
	Tue, 30 Apr 2024 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="dV3je0Da"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2430917107C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480440; cv=none; b=T7xdJQtLVIe5hWzOlBiadJC5eqkDVmUyKMMTJC9yfOLFLsQi8g7FLzrGhelBYalH1dodP8OXwXRSXY6WChwQYkO+2nwopFBV5IUOuV4tW6VErqcaUZuFlVKFsjk7w2QL5Kst7DLW70T5a1cmp1vMrXqt5ArPZVqYuCPfiJozkKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480440; c=relaxed/simple;
	bh=xwcL0Ml9mJ5uptb3sd/pMQvy35nQD+xQZJwauXAa6RM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ijXW2llUpqT3pw+h9j0LbN5WNm/0jELb/OAxKeWKmgpFaTZ7SlwOLq2Vqi0+OpbN2SK4CNCBV2zvDUpx0stiYv6h0i87zsQpNHCrq4xxYomuFiLuh9a2Y89mvzGpEPHutD7DIFxsKwdinl29crGT4MNe11Z+fWYvMVYwcJgPCkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=dV3je0Da; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a55bf737cecso666905766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1714480436; x=1715085236; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OIpDrd3C8t83O7GUW+qfsPc1eJYABE3LjCMwbC92HRw=;
        b=dV3je0DaPTivYQLKoUj5GIQPOD7kqI4rOl/bFejCl73IE7um7nwD/xx9ncIFWSP7Ye
         uvR0sPsUo7RPgGzKimEPqi6o6ZURCVIvtm5/WmBgdFkJyRL2d7asxnxaOOO47bmLBtoE
         sa+FtcvH7az0FnQgCqnOoxweBFXSC0SqOkZCBqRFPpDot/utpISwaMHtzo9rNtBW39HQ
         srSBVtk9JdD8ADdImcypAG4Xrdo5/FOEYGGzbhaj/MOSxhp7S9yIeryvf38N5+Q1DdkX
         GNg1eQ1+PawJp+CKwS2JQqdduojty9qzw8PYQ15HlFtAVDXexeFg2J6fsEtz1OY6hjZK
         zfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714480436; x=1715085236;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIpDrd3C8t83O7GUW+qfsPc1eJYABE3LjCMwbC92HRw=;
        b=lnL3LfpLC7nfMf4M1rfqz4wxkO8TWdJtW9UTSDwgsShUkHsSS+9+OKKPwaPYYUe1bb
         O03CnPRbrf0f+t6XKn0mKiHb/9CexH/pMsTPE2i6IC/O3gNvDfw2U0sLDNnMkopy6ya3
         K6FVWifljkj2gUHRL0QyPI7if8T0Hbri5842r3qLFrtrMUhepaYGFQkuWg0asNFCyhyv
         6mgV8cCUI6bdMCLhGSXj0goNx2pAtKkJKppiEUMlde1frfgCR4xA/8NMJKvJ8YauQM9D
         HHeTbNbzAgUtnezUHpCGhiHMz3EhZyYY/d48zDdlMmypkW5hS/cxND3m+2Gd8ZnNtwNT
         ph2w==
X-Forwarded-Encrypted: i=1; AJvYcCW7ujdjjIoDYWQPDKd9HWjNIPPkEF0Y/2+YwN/shifY7mtO/CicW0jVeFGKbNvCQb8a0FSnNAaa975WUWJnv+J2VvERCoUfTj1VECfU
X-Gm-Message-State: AOJu0YwZYm8naoXIqST2Snp0HiaL3JcXKQEu0PH3/fe7m8sVifv8ghnz
	ZR9j10tfpsbA6Gwnj9k9Z0mtYTVdAmpHcUWPJ8rz0i1c617Slx9RA1I0hClGGuI=
X-Google-Smtp-Source: AGHT+IE4VYByIkNz4qJPQaJuO9yZQGrB82spKaQBnv6egBGr5fQOHLku27zYrFOWTWCPkEYclnyqaw==
X-Received: by 2002:a17:906:2409:b0:a55:b2bf:2be8 with SMTP id z9-20020a170906240900b00a55b2bf2be8mr7730732eja.56.1714480435808;
        Tue, 30 Apr 2024 05:33:55 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id hg7-20020a170906f34700b00a4e5a6b57a2sm14970317ejb.163.2024.04.30.05.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:33:55 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>,  Miguel Ojeda <ojeda@kernel.org>,
  Alex Gaynor <alex.gaynor@gmail.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  Anna-Maria Behnsen <anna-maria@linutronix.de>,
  Frederic Weisbecker <frederic@kernel.org>,  Thomas Gleixner
 <tglx@linutronix.de>,  Andreas Hindborg <a.hindborg@samsung.com>,  Gary
 Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Alice Ryhl <aliceryhl@google.com>,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: hrtimer: introduce hrtimer support
In-Reply-To: <Zi_Zb1lBOBBUFJFV@boqun-archlinux> (Boqun Feng's message of "Mon,
	29 Apr 2024 10:31:27 -0700")
References: <20240425094634.262674-1-nmi@metaspace.dk>
	<a7a560c7-fb8c-4adf-9f46-2e272f24b335@proton.me>
	<87v844lbhm.fsf@metaspace.dk> <Zi_Zb1lBOBBUFJFV@boqun-archlinux>
User-Agent: mu4e 1.12.4; emacs 29.3
Date: Tue, 30 Apr 2024 14:33:50 +0200
Message-ID: <87plu7jahd.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Boqun Feng <boqun.feng@gmail.com> writes:

> On Fri, Apr 26, 2024 at 11:27:49AM +0200, Andreas Hindborg wrote:
>> Benno Lossin <benno.lossin@proton.me> writes:
>> 
>> > On 25.04.24 11:46, Andreas Hindborg wrote:
>> >> From: Andreas Hindborg <a.hindborg@samsung.com>
>> >> 
>> >> This patch adds support for intrusive use of the hrtimer system. For now, only
>> >> one timer can be embedded in a Rust struct.
>> >> 
>> >> The hrtimer Rust API is based on the intrusive style pattern introduced by the
>> >> Rust workqueue API.
>> >> 
>> >> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> >> 
>> >> ---
>> >> 
>> >> This patch is a dependency for the Rust null block driver [1].
>> >> 
>> >> Link: https://lore.kernel.org/rust-for-linux/20240313110515.70088-1-nmi@metaspace.dk/T/#me0990150b9ba9f5b3d00293ec9a473c7bc3cc506 [1]
>> >> 
>> >>  rust/kernel/hrtimer.rs | 283 +++++++++++++++++++++++++++++++++++++++++
>> >>  rust/kernel/lib.rs     |   1 +
>> >>  2 files changed, 284 insertions(+)
>> >>  create mode 100644 rust/kernel/hrtimer.rs
>> >> 
>> >> diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
>> >
>> > Hmm is this the right place? I imagine there are other timers, does this
>> > fit better into the `time` module (ie make `hrtimer` a submodule of
>> > `time`) or should we later introduce a `timer` parent module?
>> 
>> We can always move it. We will move stuff anyway when the kernel crate
>> is split.
>> 
>> We can also take it to `kernel::time::hrtimer` now, either way is fine.
>> 
>
> I think `kernel::time::hrtimer` makes more sense, since ideally
> schedule() function should take a time delta type as the input instead
> of `u64`. So hrtimer has some logical connection to timekeeping module.

Yes, there is a bit of race condition with the ktime series. I guess I
will update this when the ktime patch is in. I am not sure if that was
picked yet or what tree it is going to go through.

>
>> >
>> >> new file mode 100644
>> >> index 000000000000..1e282608e70c
>> >> --- /dev/null
>> >> +++ b/rust/kernel/hrtimer.rs
>> >> @@ -0,0 +1,283 @@
>> >> +// SPDX-License-Identifier: GPL-2.0
>> >> +
>> >> +//! Intrusive high resolution timers.
>> >> +//!
>> >> +//! Allows scheduling timer callbacks without doing allocations at the time of
>> >> +//! scheduling. For now, only one timer per type is allowed.
>> >> +//!
>> >> +//! # Example
>> >> +//!
>> >> +//! ```rust
>> >> +//! use kernel::{
>> >> +//!     sync::Arc, hrtimer::{RawTimer, Timer, TimerCallback},
>> >> +//!     impl_has_timer, prelude::*, stack_pin_init
>> >> +//! };
>> >> +//! use core::sync::atomic::AtomicBool;
>> >> +//! use core::sync::atomic::Ordering;
>> >> +//!
>> >> +//! #[pin_data]
>> >> +//! struct IntrusiveTimer {
>> >> +//!     #[pin]
>> >> +//!     timer: Timer<Self>,
>> >> +//!     flag: AtomicBool,
>
> Could you see if you can replace this with a `SpinLock<bool>` +
> `CondVar`? We shouldn't use Rust atomic in kernel now. I know it's
> unfortunate that LKMM atomics are still work in process, but in real
> world, you won't do busy waiting for a timer to fire, so a
> `CondVar::wait` is better for example purpose.

Since this is only using the atomic from Rust code, it should be fine
right? There is no mixing of memory models on this memory location.

>
>> >> +//! }
>> >> +//!
>> >> +//! impl IntrusiveTimer {
>> >> +//!     fn new() -> impl PinInit<Self> {
>> >> +//!         pin_init!(Self {
>> >> +//!             timer <- Timer::new(),
>> >> +//!             flag: AtomicBool::new(false),
>> >> +//!         })
>> >> +//!     }
>> >> +//! }
>> >> +//!
>> >> +//! impl TimerCallback for IntrusiveTimer {
>> >> +//!     type Receiver = Arc<IntrusiveTimer>;
>> >> +//!
>> >> +//!     fn run(this: Self::Receiver) {
>> >> +//!         pr_info!("Timer called\n");
>> >> +//!         this.flag.store(true, Ordering::Relaxed);
>> >> +//!     }
>> >> +//! }
>> >> +//!
>> >> +//! impl_has_timer! {
>> >> +//!     impl HasTimer<Self> for IntrusiveTimer { self.timer }
>> >> +//! }
>> >> +//!
>> >> +//! let has_timer = Arc::pin_init(IntrusiveTimer::new())?;
>> >
>> > I would not name this variable `has_timer`. Maybe `my_timer` is better?
>> 
>> Right, thanks.
>> 
>> >
>> >> +//! has_timer.clone().schedule(200_000_000);
>> >> +//! while !has_timer.flag.load(Ordering::Relaxed) { core::hint::spin_loop() }
>> >
>> > Weird formatting, we should also use `rustfmt` in examples.
>> 
>> `format_code_in_doc_comments` is a nightly `rustfmt` feature. I tried
>> enabling it in `.rustfmt.toml` and running `rustfmt +nightly
>> hrtimer.rs`. It did not have any effect. There is some discussion here:
>> https://github.com/rust-lang/rustfmt/issues/3348
>> 
>> >
> [...]
>> >> +#[pinned_drop]
>> >> +impl<T> PinnedDrop for Timer<T> {
>> >> +    fn drop(self: Pin<&mut Self>) {
>> >> +        // SAFETY: By struct invariant `self.timer` was initialized by
>> >> +        // `hrtimer_init` so by C API contract it is safe to call
>> >> +        // `hrtimer_cancel`.
>> >> +        unsafe {
>> >> +            bindings::hrtimer_cancel(self.timer.get());
>> >> +        }
>> >> +    }
>> >> +}
>> >
>> > Why is this needed? The only way to schedule a timer using this API is
>> > by having an `Arc` with a timer-containing struct inside. But to
>> > schedule the `Arc`, you consume one refcount which is then sent to the
>> > timer subsystem. So it is impossible for the refcount to drop below zero
>> > while the timer is scheduled, but not yet running.
>> > Do you need to call `hrtimer_cancel` after/while a timer is running?
>> 
>> This is not required any longer. It is a leftover from an earlier
>> revision where timers could be stack allocated. I will remove it.
>> 
>
> So the plan is to add Arc<HasTimer> support first and stack allocated
> timer later? If so, please do add a paragraph in the module level doc
> describing the limition (e.g. stack allocated timers are not supported).

I do not currently have any plans to add support for stack allocated
timers. I can give it another try if someone needs it. I ran into
problems with drop order when I tried it.

I will update the docs to mention this only supports heap allocated timers.

>
>> > Also is it ok to call `hrtimer_cancel` inside the timer callback? Since
>> > that can happen when the timer callback owns the last refcount.
>> 
>> That should be fine, `self` is still valid when the drop method is run?
>> 
>> >
>> >> +
>> >> +/// Implemented by pointer types to structs that embed a [`Timer`]. This trait
>> >> +/// facilitates queueing the timer through the pointer that implements the
>> >> +/// trait.
>> >> +///
>> >> +/// Typical implementers would be [`Box<T>`], [`Arc<T>`], [`ARef<T>`] where `T`
>> >> +/// has a field of type `Timer`.
>> >> +///
>> >> +/// Target must be [`Sync`] because timer callbacks happen in another thread of
>> >> +/// execution.
>> >> +///
>> >> +/// [`Box<T>`]: Box
>> >> +/// [`Arc<T>`]: Arc
>> >> +/// [`ARef<T>`]: crate::types::ARef
>> >> +pub trait RawTimer: Sync {
>> >> +    /// Schedule the timer after `expires` time units
>> >> +    fn schedule(self, expires: u64);
>
> This function should have a return value, see below:
>
>> >> +}
> [...]
>> >> +impl<T> RawTimer for Arc<T>
>> >> +where
>> >> +    T: Send + Sync,
>> >> +    T: HasTimer<T>,
>> >> +{
>> >> +    fn schedule(self, expires: u64) {
>> >> +        let self_ptr = Arc::into_raw(self);
>> >> +
>
> so if the timer is already scheduled, re-scheduling will leak it, e.g.
>
> 	let timer: Arc<SomeTimer> = ...;
>
> 	let reschedule_handle = timer.clone(); // refcount == 2
> 	timer.schedule(...);
>
> 	...
>
> 	// later on, a reschedule is needed
> 	reschedule_handle.schedule(...); // refcount == 2
>
> 	// <timer callback invoked>
> 	Arc::drop();
> 	// refcount == 1, the Arc is leaked.
>
> Looks to me `schedule()` should return the `Arc` back if it's already
> in the queue.

Nice catch. We can use `bindings::hrtimer_cancel` to drop the `Arc` used
to enqueue if the timer was already enqueued. I think that should be OK
as far as usability of the API goes?

> TBH, if you don't need the re-schedule and cancel functionality, maybe
> start with `impl<T> RawTimer for Pin<Box<T>>` first.

I do not need to reschedule, but I need to support reference counted
types, and cancel would be nice to have eventually.

Best regards,
Andreas

