Return-Path: <linux-kernel+bounces-159662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A898B31B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F90282A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1241D13C8F5;
	Fri, 26 Apr 2024 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eoqfjgFc"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7AA13A271
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117970; cv=none; b=P2sKpYgjK6YeR+Axqqxkp3UPa9eHiiWLuJJE3xygRPxYKdlLX1wYH0eDimeZXVORCFvGBTLZ4mULmpkDa38Mr9f5jo98CJf8M0pbGhKNlX5hVBC7LLhTWlEcOFVPbnZSyrMgc4JeDQet3bHbfe2AKOSkBDqTOCxudjPSjOjpvMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117970; c=relaxed/simple;
	bh=f066WrpDI7eQ/wBEZOaNc1YtPmsY1fNb2G4frBU8rF0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GR15231F2o11sQfCWDIGpVJzPCFJ9TjTZZSPfosn+g/ztbP5/91dOTN87zYCoyjGRmUZaKiAFhB5OxaVU5tMYOM5U/FH+nBM8tp8Y5j1ijCQu8kW+qgpNfwefRvprUxSBOn4Xeb0/4E7hmXJ+vZXGTd33DVj7umlkslLPdRr14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eoqfjgFc; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1714117966; x=1714377166;
	bh=DfDlyCs+TTi5EAirKlmzSmca/Ny5QX0ZbJpvr/HMJDU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eoqfjgFcI+7DuxB9fqJsvCyRKODBXbNE0CtW9Vygwd8yadBv8vmFdFgvWGwAJiwyO
	 yQBikWgws9XVLzm1WXynIdgSYEGCW0VAVBmgnRswg5rTFYzqOc0SDqKVVh/6FbZSeB
	 pLo29tykoy+pUIIrRB4K1xKRfmVt/DLNQvPv7pvrSBKxqsdQlLERJYa9PTACbbdqU8
	 vuMJwKiUYh1dmzEJcC/nNVUg3B+2xiV47EDJlTNDqHO1LRY3mGF6/N9iA6V//Oh+zU
	 /DSk33LvyfVK97Q7JMBOpip5NFP67W5bEUF87U0p0LiFoTaIRV/xhNXaio9BwVAmfd
	 1ieFd651cuU9A==
Date: Fri, 26 Apr 2024 07:52:41 +0000
To: Andreas Hindborg <nmi@metaspace.dk>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: hrtimer: introduce hrtimer support
Message-ID: <a7a560c7-fb8c-4adf-9f46-2e272f24b335@proton.me>
In-Reply-To: <20240425094634.262674-1-nmi@metaspace.dk>
References: <20240425094634.262674-1-nmi@metaspace.dk>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 54bf713338d951f9d261fee021aaf7d56b0e8061
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.04.24 11:46, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> This patch adds support for intrusive use of the hrtimer system. For now,=
 only
> one timer can be embedded in a Rust struct.
>=20
> The hrtimer Rust API is based on the intrusive style pattern introduced b=
y the
> Rust workqueue API.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> ---
>=20
> This patch is a dependency for the Rust null block driver [1].
>=20
> Link: https://lore.kernel.org/rust-for-linux/20240313110515.70088-1-nmi@m=
etaspace.dk/T/#me0990150b9ba9f5b3d00293ec9a473c7bc3cc506 [1]
>=20
>  rust/kernel/hrtimer.rs | 283 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |   1 +
>  2 files changed, 284 insertions(+)
>  create mode 100644 rust/kernel/hrtimer.rs
>=20
> diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs

Hmm is this the right place? I imagine there are other timers, does this
fit better into the `time` module (ie make `hrtimer` a submodule of
`time`) or should we later introduce a `timer` parent module?

> new file mode 100644
> index 000000000000..1e282608e70c
> --- /dev/null
> +++ b/rust/kernel/hrtimer.rs
> @@ -0,0 +1,283 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Intrusive high resolution timers.
> +//!
> +//! Allows scheduling timer callbacks without doing allocations at the t=
ime of
> +//! scheduling. For now, only one timer per type is allowed.
> +//!
> +//! # Example
> +//!
> +//! ```rust
> +//! use kernel::{
> +//!     sync::Arc, hrtimer::{RawTimer, Timer, TimerCallback},
> +//!     impl_has_timer, prelude::*, stack_pin_init
> +//! };
> +//! use core::sync::atomic::AtomicBool;
> +//! use core::sync::atomic::Ordering;
> +//!
> +//! #[pin_data]
> +//! struct IntrusiveTimer {
> +//!     #[pin]
> +//!     timer: Timer<Self>,
> +//!     flag: AtomicBool,
> +//! }
> +//!
> +//! impl IntrusiveTimer {
> +//!     fn new() -> impl PinInit<Self> {
> +//!         pin_init!(Self {
> +//!             timer <- Timer::new(),
> +//!             flag: AtomicBool::new(false),
> +//!         })
> +//!     }
> +//! }
> +//!
> +//! impl TimerCallback for IntrusiveTimer {
> +//!     type Receiver =3D Arc<IntrusiveTimer>;
> +//!
> +//!     fn run(this: Self::Receiver) {
> +//!         pr_info!("Timer called\n");
> +//!         this.flag.store(true, Ordering::Relaxed);
> +//!     }
> +//! }
> +//!
> +//! impl_has_timer! {
> +//!     impl HasTimer<Self> for IntrusiveTimer { self.timer }
> +//! }
> +//!
> +//! let has_timer =3D Arc::pin_init(IntrusiveTimer::new())?;

I would not name this variable `has_timer`. Maybe `my_timer` is better?

> +//! has_timer.clone().schedule(200_000_000);
> +//! while !has_timer.flag.load(Ordering::Relaxed) { core::hint::spin_loo=
p() }

Weird formatting, we should also use `rustfmt` in examples.

> +//!
> +//! pr_info!("Flag raised\n");
> +//!
> +//! # Ok::<(), kernel::error::Error>(())
> +//! ```
> +//!
> +//! C header: [`include/linux/hrtimer.h`](srctree/include/linux/hrtimer.=
h)
> +
> +use core::{marker::PhantomData, pin::Pin};
> +
> +use crate::{init::PinInit, prelude::*, sync::Arc, types::Opaque};
> +
> +/// A timer backed by a C `struct hrtimer`

Missing `.` at the end, this also occurs below.

> +///
> +/// # Invariants
> +///
> +/// * `self.timer` is initialized by `bindings::hrtimer_init`.
> +#[repr(transparent)]
> +#[pin_data(PinnedDrop)]
> +pub struct Timer<T> {
> +    #[pin]
> +    timer: Opaque<bindings::hrtimer>,
> +    _t: PhantomData<T>,
> +}
> +
> +// SAFETY: A `Timer` can be moved to other threads and used from there.
> +unsafe impl<T> Send for Timer<T> {}
> +
> +// SAFETY: Timer operations are locked on C side, so it is safe to opera=
te on a
> +// timer from multiple threads
> +unsafe impl<T> Sync for Timer<T> {}
> +
> +impl<T: TimerCallback> Timer<T> {
> +    /// Return an initializer for a new timer instance.
> +    pub fn new() -> impl PinInit<Self> {
> +        crate::pin_init!( Self {

`pin_init!` is in the prelude, no need to prefix with `crate`.

> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtime=
r| {
> +                // SAFETY: By design of `pin_init!`, `place` is a pointe=
r live
> +                // allocation. hrtimer_init will initialize `place` and =
does not
> +                // require `place` to be initialized prior to the call.
> +                unsafe {
> +                    bindings::hrtimer_init(
> +                        place,
> +                        bindings::CLOCK_MONOTONIC as i32,
> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
> +                    );
> +                }
> +
> +                // SAFETY: `place` is pointing to a live allocation, so =
the deref
> +                // is safe. The `function` field might not be initialize=
d, but
> +                // `addr_of_mut` does not create a reference to the fiel=
d.
> +                let function: *mut Option<_> =3D unsafe { core::ptr::add=
r_of_mut!((*place).function) };
> +
> +                // SAFETY: `function` points to a valid allocation.
> +                unsafe { core::ptr::write(function, Some(T::Receiver::ru=
n)) };
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

Why is this needed? The only way to schedule a timer using this API is
by having an `Arc` with a timer-containing struct inside. But to
schedule the `Arc`, you consume one refcount which is then sent to the
timer subsystem. So it is impossible for the refcount to drop below zero
while the timer is scheduled, but not yet running.
Do you need to call `hrtimer_cancel` after/while a timer is running?

Also is it ok to call `hrtimer_cancel` inside the timer callback? Since
that can happen when the timer callback owns the last refcount.

> +
> +/// Implemented by pointer types to structs that embed a [`Timer`]. This=
 trait
> +/// facilitates queueing the timer through the pointer that implements t=
he
> +/// trait.
> +///
> +/// Typical implementers would be [`Box<T>`], [`Arc<T>`], [`ARef<T>`] wh=
ere `T`
> +/// has a field of type `Timer`.
> +///
> +/// Target must be [`Sync`] because timer callbacks happen in another th=
read of
> +/// execution.
> +///
> +/// [`Box<T>`]: Box
> +/// [`Arc<T>`]: Arc
> +/// [`ARef<T>`]: crate::types::ARef
> +pub trait RawTimer: Sync {
> +    /// Schedule the timer after `expires` time units
> +    fn schedule(self, expires: u64);
> +}
> +
> +/// Implemented by structs that contain timer nodes.
> +///
> +/// Clients of the timer API would usually safely implement this trait b=
y using
> +/// the [`impl_has_timer`] macro.
> +///
> +/// # Safety
> +///
> +/// Implementers of this trait must ensure that the implementer has a [`=
Timer`]
> +/// field at the offset specified by `OFFSET` and that all trait methods=
 are
> +/// implemented according to their documentation.
> +///
> +/// [`impl_has_timer`]: crate::impl_has_timer
> +pub unsafe trait HasTimer<T> {
> +    /// Offset of the [`Timer`] field within `Self`
> +    const OFFSET: usize;
> +
> +    /// Return a pointer to the [`Timer`] within `Self`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to a valid struct of type `Self`.
> +    unsafe fn raw_get_timer(ptr: *const Self) -> *const Timer<T> {
> +        // SAFETY: By the safety requirement of this trait, the trait
> +        // implementor will have a `Timer` field at the specified offset=
.
> +        unsafe { ptr.cast::<u8>().add(Self::OFFSET).cast::<Timer<T>>() }
> +    }
> +
> +    /// Return a pointer to the struct that is embedding the [`Timer`] p=
ointed
> +    /// to by `ptr`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to a [`Timer<T>`] field in a struct of type `Se=
lf`.
> +    unsafe fn timer_container_of(ptr: *mut Timer<T>) -> *mut Self
> +    where
> +        Self: Sized,
> +    {
> +        // SAFETY: By the safety requirement of this trait, the trait
> +        // implementor will have a `Timer` field at the specified offset=
.
> +        unsafe { ptr.cast::<u8>().sub(Self::OFFSET).cast::<Self>() }
> +    }
> +}
> +
> +/// Implemented by pointer types that can be the target of a C timer cal=
lback.
> +pub trait RawTimerCallback: RawTimer {

Do you really need two different traits? Can't we have a single
`TimerPointer` trait that does both `RawTimerCallback` and `RawTimer`?
(I am also wondering why we did this for workqueue)

> +    /// Callback to be called from C.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Only to be called by C code in `hrtimer`subsystem.
> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::h=
rtimer_restart;
> +}
> +
> +/// Implemented by pointers to structs that can the target of a timer ca=
llback
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
> +        let self_ptr =3D Arc::into_raw(self);
> +
> +        // SAFETY: `self_ptr` is a valid pointer to a `T`
> +        let timer_ptr =3D unsafe { T::raw_get_timer(self_ptr) };
> +
> +        // `Timer` is `repr(transparent)`
> +        let c_timer_ptr =3D timer_ptr.cast::<bindings::hrtimer>();
> +
> +        // Schedule the timer - if it is already scheduled it is removed=
 and
> +        // inserted
> +
> +        // SAFETY: c_timer_ptr points to a valid hrtimer instance that w=
as
> +        // initialized by `hrtimer_init`
> +        unsafe {
> +            bindings::hrtimer_start_range_ns(
> +                c_timer_ptr.cast_mut(),
> +                expires as i64,
> +                0,
> +                bindings::hrtimer_mode_HRTIMER_MODE_REL,
> +            );
> +        }
> +    }
> +}
> +
> +impl<T> kernel::hrtimer::RawTimerCallback for Arc<T>

Why are you spelling out the whole path?

> +where
> +    T: Send + Sync,
> +    T: HasTimer<T>,
> +    T: TimerCallback<Receiver =3D Self>,
> +{
> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::h=
rtimer_restart {
> +        // `Timer` is `repr(transparent)`
> +        let timer_ptr =3D ptr.cast::<kernel::hrtimer::Timer<T>>();
> +
> +        // SAFETY: By C API contract `ptr` is the pointer we passed when
> +        // enqueing the timer, so it is a `Timer<T>` embedded in a `T`
> +        let data_ptr =3D unsafe { T::timer_container_of(timer_ptr) };
> +
> +        // SAFETY: This `Arc` comes from a call to `Arc::into_raw()`
> +        let receiver =3D unsafe { Arc::from_raw(data_ptr) };
> +
> +        T::run(receiver);
> +
> +        bindings::hrtimer_restart_HRTIMER_NORESTART
> +    }
> +}
> +
> +/// Use to implement the [`HasTimer<T>`] trait.
> +///
> +/// See [`module`] documentation for an example.
> +///
> +/// [`module`]: crate::hrtimer
> +#[macro_export]
> +macro_rules! impl_has_timer {
> +    ($(impl$(<$($implarg:ident),*>)?

Doing it this way makes it impossible to use more complex types with eg
lifetimes or const generic arguments. There is a workaround, see Alice's
linked list patch [1]:

     macro_rules! impl_list_item {
         (
             impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
                 using ListLinks;
             } $($rest:tt)*
         ) =3D> {

[1]: https://lore.kernel.org/rust-for-linux/20240402-linked-list-v1-4-b1c59=
ba7ae3b@google.com/

> +       HasTimer<$timer_type:ty $(, $id:tt)?>

`HasTimer` currently doesn't have an `id`, so the macro also shouldn't
have it.

--=20
Cheers,
Benno

> +       for $self:ident $(<$($selfarg:ident),*>)?
> +       { self.$field:ident }
> +    )*) =3D> {$(
> +        // SAFETY: This implementation of `raw_get_timer` only compiles =
if the
> +        // field has the right type.
> +        unsafe impl$(<$($implarg),*>)? $crate::hrtimer::HasTimer<$timer_=
type> for $self $(<$($selfarg),*>)? {
> +            const OFFSET: usize =3D ::core::mem::offset_of!(Self, $field=
) as usize;
> +
> +            #[inline]
> +            unsafe fn raw_get_timer(ptr: *const Self) -> *const $crate::=
hrtimer::Timer<$timer_type $(, $id)?> {
> +                // SAFETY: The caller promises that the pointer is not d=
angling.
> +                unsafe {
> +                    ::core::ptr::addr_of!((*ptr).$field)
> +                }
> +            }
> +
> +        }
> +    )*};
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index be68d5e567b1..7af3ca601167 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -33,6 +33,7 @@
>  mod allocator;
>  mod build_assert;
>  pub mod error;
> +pub mod hrtimer;
>  pub mod init;
>  pub mod ioctl;
>  #[cfg(CONFIG_KUNIT)]
>=20
> base-commit: ed30a4a51bb196781c8058073ea720133a65596f
> --
> 2.44.0
>=20



