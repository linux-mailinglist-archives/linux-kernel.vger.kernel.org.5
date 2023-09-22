Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D24A7AAD2C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjIVIxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjIVIxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:53:45 -0400
X-Greylist: delayed 156361 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Sep 2023 01:53:33 PDT
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3838BE8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1695372809; x=1695632009;
        bh=ts4PF4d/DPQcSKzx9O++pjI9MrnIEG183Yqs4UuldsY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=TvvJFo9zKUKVOBKC0nkSJImrJdbhmBDXc23Nj6ybYmc2HCbZq0QEyF39+8gLQ9XSa
         D0L/gFVLKt0cG6YrIoTkVLSbDcfWjA7aywYBAPlUhd2Y2U9htOKZsNXbrrYz7ybkZI
         GrgJ48vEWz6pnIHypJu8yFo79GPsERs6RUVNXRnmNfMt00g45SP8fRPFbDulU9sbkV
         ix42urZucMwD4XR6XEfjKIa3uQwpG5QKn5OAvEGJh4fKm0P8kCY3GGzbyDRjnDGV6W
         L5UMpYYWg2QL7KBcgB0ceaniBsx2sfz6W90QwEGtMQKwc6Tfk2reejosBsbukrIi1J
         Kq3rVlplecK/w==
Date:   Fri, 22 Sep 2023 08:53:22 +0000
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
Message-ID: <63223594-1bbe-c4f2-ea82-9b34c66ba1f6@proton.me>
In-Reply-To: <20230921213440.202017-3-wedsonaf@gmail.com>
References: <20230921213440.202017-1-wedsonaf@gmail.com> <20230921213440.202017-3-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.09.23 23:34, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> With GATs, we don't need a separate type to represent a borrowed object
> with a refcount, we can just use Rust's regular shared borrowing. In
> this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
>=20
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

I only have a very small comment below, so

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>   rust/kernel/sync.rs     |   2 +-
>   rust/kernel/sync/arc.rs | 180 ++++++++++++++--------------------------
>   2 files changed, 62 insertions(+), 120 deletions(-)
>=20
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index d219ee518eff..083494884500 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -12,7 +12,7 @@
>   pub mod lock;
>   mod locked_by;
>=20
> -pub use arc::{Arc, ArcBorrow, UniqueArc};
> +pub use arc::{Arc, UniqueArc, WithRef};
>   pub use condvar::CondVar;
>   pub use lock::{mutex::Mutex, spinlock::SpinLock};
>   pub use locked_by::LockedBy;
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 86bff1e0002c..5948e42b9c8f 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -105,14 +105,14 @@
>   /// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
>   ///
>   /// ```
> -/// use kernel::sync::{Arc, ArcBorrow};
> +/// use kernel::sync::{Arc, WithRef};
>   ///
>   /// trait MyTrait {
>   ///     // Trait has a function whose `self` type is `Arc<Self>`.
>   ///     fn example1(self: Arc<Self>) {}
>   ///
> -///     // Trait has a function whose `self` type is `ArcBorrow<'_, Self=
>`.
> -///     fn example2(self: ArcBorrow<'_, Self>) {}
> +///     // Trait has a function whose `self` type is `&WithRef<Self>`.
> +///     fn example2(self: &WithRef<Self>) {}
>   /// }
>   ///
>   /// struct Example;
> @@ -130,9 +130,48 @@ pub struct Arc<T: ?Sized> {
>       _p: PhantomData<WithRef<T>>,
>   }
>=20
> +/// An instance of `T` with an attached reference count.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::sync::{Arc, WithRef};
> +///
> +/// struct Example;
> +///
> +/// fn do_something(e: &WithRef<Example>) -> Arc<Example> {
> +///     e.into()
> +/// }
> +///
> +/// let obj =3D Arc::try_new(Example)?;
> +/// let cloned =3D do_something(obj.as_with_ref());
> +///
> +/// // Assert that both `obj` and `cloned` point to the same underlying =
object.
> +/// assert!(core::ptr::eq(&*obj, &*cloned));
> +/// ```
> +///
> +/// Using `WithRef<T>` as the type of `self`:
> +///
> +/// ```
> +/// use kernel::sync::{Arc, WithRef};
> +///
> +/// struct Example {
> +///     _a: u32,
> +///     _b: u32,
> +/// }
> +///
> +/// impl Example {
> +///     fn use_reference(self: &WithRef<Self>) {
> +///         // ...
> +///     }
> +/// }
> +///
> +/// let obj =3D Arc::try_new(Example { _a: 10, _b: 20 })?;
> +/// obj.as_with_ref().use_reference();
> +/// ```
>   #[pin_data]
>   #[repr(C)]
> -struct WithRef<T: ?Sized> {
> +pub struct WithRef<T: ?Sized> {
>       refcount: Opaque<bindings::refcount_t>,
>       data: T,
>   }

I do not really like the position of this definition in this file.
It should be further down with the other code (like the
`impl<T: ?Sized> From<&WithRef<T>> for Arc<T>`).

> @@ -215,16 +254,16 @@ unsafe fn from_inner(inner: NonNull<WithRef<T>>) ->=
 Self {
>           }
>       }
>=20
> -    /// Returns an [`ArcBorrow`] from the given [`Arc`].
> +    /// Returns a [`WithRef`] from the given [`Arc`].
>       ///
> -    /// This is useful when the argument of a function call is an [`ArcB=
orrow`] (e.g., in a method
> -    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcBorro=
w`] is free when optimised.
> +    /// This is useful when the argument of a function call is a [`WithR=
ef`] (e.g., in a method
> +    /// receiver), but we have an [`Arc`] instead. Getting a [`WithRef`]=
 is free when optimised.
>       #[inline]
> -    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
> +    pub fn as_with_ref(&self) -> &WithRef<T> {
>           // SAFETY: The constraint that the lifetime of the shared refer=
ence must outlive that of
> -        // the returned `ArcBorrow` ensures that the object remains aliv=
e and that no mutable
> +        // the returned `WithRef` ensures that the object remains alive =
and that no mutable
>           // reference can be created.
> -        unsafe { ArcBorrow::new(self.ptr) }
> +        unsafe { self.ptr.as_ref() }
>       }
>=20
>       /// Compare whether two [`Arc`] pointers reference the same underly=
ing object.
> @@ -234,20 +273,17 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>   }
>=20
>   impl<T: 'static> ForeignOwnable for Arc<T> {
> -    type Borrowed<'a> =3D ArcBorrow<'a, T>;
> +    type Borrowed<'a> =3D &'a WithRef<T>;
>=20
>       fn into_foreign(self) -> *const core::ffi::c_void {
>           ManuallyDrop::new(self).ptr.as_ptr() as _
>       }
>=20
> -    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a,=
 T> {
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a WithRef<T=
> {
>           // SAFETY: By the safety requirement of this function, we know =
that `ptr` came from
> -        // a previous call to `Arc::into_foreign`.
> -        let inner =3D NonNull::new(ptr as *mut WithRef<T>).unwrap();
> -
> -        // SAFETY: The safety requirements of `from_foreign` ensure that=
 the object remains alive
> -        // for the lifetime of the returned value.
> -        unsafe { ArcBorrow::new(inner) }
> +        // a previous call to `Arc::into_foreign`. The safety requiremen=
ts of `from_foreign` ensure
> +        // that the object remains alive for the lifetime of the returne=
d value.
> +        unsafe { &*(ptr.cast::<WithRef<T>>()) }
>       }
>=20
>       unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> @@ -320,119 +356,25 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
>       }
>   }
>=20
> -/// A borrowed reference to an [`Arc`] instance.
> -///
> -/// For cases when one doesn't ever need to increment the refcount on th=
e allocation, it is simpler
> -/// to use just `&T`, which we can trivially get from an `Arc<T>` instan=
ce.
> -///
> -/// However, when one may need to increment the refcount, it is preferab=
le to use an `ArcBorrow<T>`
> -/// over `&Arc<T>` because the latter results in a double-indirection: a=
 pointer (shared reference)
> -/// to a pointer (`Arc<T>`) to the object (`T`). An [`ArcBorrow`] elimin=
ates this double
> -/// indirection while still allowing one to increment the refcount and g=
etting an `Arc<T>` when/if
> -/// needed.
> -///
> -/// # Invariants
> -///
> -/// There are no mutable references to the underlying [`Arc`], and it re=
mains valid for the
> -/// lifetime of the [`ArcBorrow`] instance.
> -///
> -/// # Example
> -///
> -/// ```
> -/// use kernel::sync::{Arc, ArcBorrow};
> -///
> -/// struct Example;
> -///
> -/// fn do_something(e: ArcBorrow<'_, Example>) -> Arc<Example> {
> -///     e.into()
> -/// }
> -///
> -/// let obj =3D Arc::try_new(Example)?;
> -/// let cloned =3D do_something(obj.as_arc_borrow());
> -///
> -/// // Assert that both `obj` and `cloned` point to the same underlying =
object.
> -/// assert!(core::ptr::eq(&*obj, &*cloned));
> -/// # Ok::<(), Error>(())
> -/// ```
> -///
> -/// Using `ArcBorrow<T>` as the type of `self`:
> -///
> -/// ```
> -/// use kernel::sync::{Arc, ArcBorrow};
> -///
> -/// struct Example {
> -///     a: u32,
> -///     b: u32,
> -/// }
> -///
> -/// impl Example {
> -///     fn use_reference(self: ArcBorrow<'_, Self>) {
> -///         // ...
> -///     }
> -/// }
> -///
> -/// let obj =3D Arc::try_new(Example { a: 10, b: 20 })?;
> -/// obj.as_arc_borrow().use_reference();
> -/// # Ok::<(), Error>(())
> -/// ```
> -pub struct ArcBorrow<'a, T: ?Sized + 'a> {
> -    inner: NonNull<WithRef<T>>,
> -    _p: PhantomData<&'a ()>,
> -}
> -
> -// This is to allow [`ArcBorrow`] (and variants) to be used as the type =
of `self`.
> -impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
> -
> -// This is to allow `ArcBorrow<U>` to be dispatched on when `ArcBorrow<T=
>` can be coerced into
> -// `ArcBorrow<U>`.
> -impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<ArcBor=
row<'_, U>>
> -    for ArcBorrow<'_, T>
> -{
> -}
> -
> -impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
> -    fn clone(&self) -> Self {
> -        *self
> -    }
> -}
> -
> -impl<T: ?Sized> Copy for ArcBorrow<'_, T> {}
> -
> -impl<T: ?Sized> ArcBorrow<'_, T> {
> -    /// Creates a new [`ArcBorrow`] instance.
> -    ///
> -    /// # Safety
> -    ///
> -    /// Callers must ensure the following for the lifetime of the return=
ed [`ArcBorrow`] instance:
> -    /// 1. That `inner` remains valid;
> -    /// 2. That no mutable references to `inner` are created.
> -    unsafe fn new(inner: NonNull<WithRef<T>>) -> Self {
> -        // INVARIANT: The safety requirements guarantee the invariants.
> -        Self {
> -            inner,
> -            _p: PhantomData,
> -        }
> -    }
> -}

I think here would be the correct location. Another option would be
to move this code up to the definition. I don't think this is important,
so I can maybe just create an issue and let this be someone's first contrib=
ution.

> +// This is to allow [`WithRef`] (and variants) to be used as the type of=
 `self`.
> +impl<T: ?Sized> core::ops::Receiver for WithRef<T> {}
>=20
> -impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {
> -    fn from(b: ArcBorrow<'_, T>) -> Self {
> +impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
> +    fn from(b: &WithRef<T>) -> Self {
>           // SAFETY: The existence of `b` guarantees that the refcount is=
 non-zero. `ManuallyDrop`
>           // guarantees that `drop` isn't called, so it's ok that the tem=
porary `Arc` doesn't own the
>           // increment.
> -        ManuallyDrop::new(unsafe { Arc::from_inner(b.inner) })
> +        ManuallyDrop::new(unsafe { Arc::from_inner(b.into()) })
>               .deref()
>               .clone()
>       }
>   }
>=20
> -impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
> +impl<T: ?Sized> Deref for WithRef<T> {
>       type Target =3D T;
>=20
>       fn deref(&self) -> &Self::Target {
> -        // SAFETY: By the type invariant, the underlying object is still=
 alive with no mutable
> -        // references to it, so it is safe to create a shared reference.
> -        unsafe { &self.inner.as_ref().data }
> +        &self.data
>       }
>   }
>=20
> --
> 2.34.1
>=20


