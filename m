Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B357548C5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 15:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjGONi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 09:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGONi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 09:38:27 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B79272A
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 06:38:23 -0700 (PDT)
Date:   Sat, 15 Jul 2023 13:38:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1689428301; x=1689687501;
        bh=jpirCVBI6qvy/LH/4UjZlCb+01S49ZLsrI5kKviC7M0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=BCXnCNolLjAUDN4TUo1a5DVnR7eb5kQp9AAbklc6gQxEGhDqoKHI/94leyOWx0/t7
         EsBMf2biwO4puiSdL/KkBvmJ7ziBf6+BI9sVQDmP1Pq2o6RAfjMirctzOVOprSIP/g
         EkwD1NAmaZb5iCV0yDjrYJ3BvR8thJ/0kjQUynQhzsZ/0oS3xW4ga3Hpr9pHNAnMUM
         DMfJ7sm5/Amf6Z14XOC5gnAb802W9NmtxD2+tDgaaa2CRQESSF2C2q/rbiGG9ADnsS
         wpPgGm096BwGsL+aHIs6jbj3mXQDsTkadH10UA/2eOZ+vLd6gZcceyc9ikbYPl9QUW
         IKRc/AQjVAAjA==
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1] rust: add improved version of `ForeignOwnable::borrow_mut`
Message-ID: <ngqoOJ2k3udEHB5h1n7xMP_5LZUvoWaYP1zcTVwcSRYJ8IZYqYK82YMBUAUieYGomPPDPEp-n2MpF3CrAztKunooTU9fkNQ36x3TxrQ5Twc=@proton.me>
In-Reply-To: <20230710074642.683831-1-aliceryhl@google.com>
References: <20230710074642.683831-1-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.23 09:46, Alice Ryhl wrote:
> Previously, the `ForeignOwnable` trait had a method called `borrow_mut`
> that was intended to provide mutable access to the inner value. However,
> the method accidentally made it possible to change the address of the
> object being modified, which usually isn't what we want. (And when we
> want that, it can be done by calling `from_foreign` and `into_foreign`,
> like how the old `borrow_mut` was implemented.)
>=20
> In this patch, we introduce an alternate definition of `borrow_mut` that
> solves the previous problem. Conceptually, given a pointer type `P` that
> implements `ForeignOwnable`, the `borrow_mut` method gives you the same
> kind of access as an `&mut P` would, except that it does not let you
> change the pointer `P` itself.
>=20
> This is analogous to how the existing `borrow` method provides the same
> kind of access to the inner value as an `&P`.
>=20
> Note that for types like `Arc`, having an `&mut Arc<T>` only gives you
> immutable access to the inner `T`. This is because mutable references
> assume exclusive access, but there might be other handles to the same
> reference counted value, so the access isn't exclusive. The `Arc` type
> implements this by making `borrow_mut` return the same type as `borrow`.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno

> ---
>=20
> This patch depends on https://lore.kernel.org/all/20230706094615.3080784-=
1-aliceryhl@google.com/
>=20
>   rust/kernel/sync/arc.rs | 31 +++++++++-----
>   rust/kernel/types.rs    | 93 ++++++++++++++++++++++++++++++-----------
>   2 files changed, 89 insertions(+), 35 deletions(-)
>=20
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index d479f8da8f38..1c2fb36906b6 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -20,66 +20,111 @@
>   /// This trait is meant to be used in cases when Rust objects are store=
d in C objects and
>   /// eventually "freed" back to Rust.
>   pub trait ForeignOwnable: Sized {
> -    /// Type of values borrowed between calls to [`ForeignOwnable::into_=
foreign`] and
> -    /// [`ForeignOwnable::from_foreign`].
> +    /// Type used to immutably borrow a value that is currently foreign-=
owned.
>       type Borrowed<'a>;
>=20
> +    /// Type used to mutably borrow a value that is currently foreign-ow=
ned.
> +    type BorrowedMut<'a>;
> +
>       /// Converts a Rust-owned object to a foreign-owned one.
>       ///
>       /// The foreign representation is a pointer to void.
>       fn into_foreign(self) -> *const core::ffi::c_void;
>=20
> -    /// Borrows a foreign-owned object.
> -    ///
> -    /// # Safety
> -    ///
> -    /// `ptr` must have been returned by a previous call to [`ForeignOwn=
able::into_foreign`] for
> -    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn'=
t been called yet.
> -    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowe=
d<'a>;
> -
>       /// Converts a foreign-owned object back to a Rust-owned one.
>       ///
>       /// # Safety
>       ///
> -    /// `ptr` must have been returned by a previous call to [`ForeignOwn=
able::into_foreign`] for
> -    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn'=
t been called yet.
> -    /// Additionally, all instances (if any) of values returned by [`For=
eignOwnable::borrow`] for
> -    /// this object must have been dropped.
> +    /// The provided pointer must have been returned by a previous call =
to [`into_foreign`], and it
> +    /// must not be passed to `from_foreign` more than once.
> +    ///
> +    /// [`into_foreign`]: Self::into_foreign
>       unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
> +
> +    /// Borrows a foreign-owned object immutably.
> +    ///
> +    /// This method provides a way to access a foreign-owned value from =
Rust immutably. It provides
> +    /// you with exactly the same abilities as an `&Self` when the value=
 is Rust-owned.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must have been returned by a previous call =
to [`into_foreign`], and if
> +    /// the pointer is ever passed to [`from_foreign`], then that call m=
ust happen after the end of
> +    /// the lifetime 'a.
> +    ///
> +    /// [`into_foreign`]: Self::into_foreign
> +    /// [`from_foreign`]: Self::from_foreign
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowe=
d<'a>;
> +
> +    /// Borrows a foreign-owned object mutably.
> +    ///
> +    /// This method provides a way to access a foreign-owned value from =
Rust mutably. It provides
> +    /// you with exactly the same abilities as an `&mut Self` when the v=
alue is Rust-owned, except
> +    /// that this method does not let you swap the foreign-owned object =
for another. (That is, it
> +    /// does not let you change the address of the void pointer that the=
 foreign code is storing.)
> +    ///
> +    /// Note that for types like [`Arc`], an `&mut Arc<T>` only gives yo=
u immutable access to the
> +    /// inner value, so this method also only provides immutable access =
in that case.
> +    ///
> +    /// In the case of `Box<T>`, this method gives you the ability to mo=
dify the inner `T`, but it
> +    /// does not let you change the box itself. That is, you cannot chan=
ge which allocation the box
> +    /// points at.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must have been returned by a previous call =
to [`into_foreign`], and if
> +    /// the pointer is ever passed to [`from_foreign`], then that call m=
ust happen after the end of
> +    /// the lifetime 'a.
> +    ///
> +    /// The lifetime 'a must not overlap with the lifetime of any other =
call to [`borrow`] or
> +    /// `borrow_mut` on the same object.
> +    ///
> +    /// [`into_foreign`]: Self::into_foreign
> +    /// [`from_foreign`]: Self::from_foreign
> +    /// [`borrow`]: Self::borrow
> +    /// [`Arc`]: crate::sync::Arc
> +    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> Self::Bor=
rowedMut<'a>;
>   }
>=20
>   impl<T: 'static> ForeignOwnable for Box<T> {
>       type Borrowed<'a> =3D &'a T;
> +    type BorrowedMut<'a> =3D &'a mut T;
>=20
>       fn into_foreign(self) -> *const core::ffi::c_void {
>           Box::into_raw(self) as _
>       }
>=20
> -    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
> -        // SAFETY: The safety requirements for this function ensure that=
 the object is still alive,
> -        // so it is safe to dereference the raw pointer.
> -        // The safety requirements of `from_foreign` also ensure that th=
e object remains alive for
> -        // the lifetime of the returned value.
> -        unsafe { &*ptr.cast() }
> -    }
> -
>       unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
>           // SAFETY: The safety requirements of this function ensure that=
 `ptr` comes from a previous
>           // call to `Self::into_foreign`.
>           unsafe { Box::from_raw(ptr as _) }
>       }
> +
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
> +        // SAFETY: The safety requirements of this method ensure that th=
e object remains alive and
> +        // immutable for the duration of 'a.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> &'a mut T=
 {
> +        // SAFETY: The safety requirements of this method ensure that th=
e pointer is valid and that
> +        // nothing else will access the value for the duration of 'a.
> +        unsafe { &mut *ptr.cast_mut().cast() }
> +    }
>   }
>=20
>   impl ForeignOwnable for () {
>       type Borrowed<'a> =3D ();
> +    type BorrowedMut<'a> =3D ();
>=20
>       fn into_foreign(self) -> *const core::ffi::c_void {
>           core::ptr::NonNull::dangling().as_ptr()
>       }
>=20
> -    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<=
'a> {}
> -
>       unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
> +
> +    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<=
'a> {}
> +    unsafe fn borrow_mut<'a>(_: *const core::ffi::c_void) -> Self::Borro=
wedMut<'a> {}
>   }
>=20
>   /// Runs a cleanup function/closure when dropped.
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 172f563976a9..f152a562c9c3 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -232,26 +232,35 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>=20
>   impl<T: 'static> ForeignOwnable for Arc<T> {
>       type Borrowed<'a> =3D ArcBorrow<'a, T>;
> +    // Mutable access to the `Arc` does not give any extra abilities ove=
r
> +    // immutable access.
> +    type BorrowedMut<'a> =3D ArcBorrow<'a, T>;
>=20
>       fn into_foreign(self) -> *const core::ffi::c_void {
>           ManuallyDrop::new(self).ptr.as_ptr() as _
>       }
>=20
> -    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a,=
 T> {
> -        // SAFETY: By the safety requirement of this function, we know t=
hat `ptr` came from
> -        // a previous call to `Arc::into_foreign`.
> -        let inner =3D NonNull::new(ptr as *mut ArcInner<T>).unwrap();
> -
> -        // SAFETY: The safety requirements of `from_foreign` ensure that=
 the object remains alive
> -        // for the lifetime of the returned value.
> -        unsafe { ArcBorrow::new(inner) }
> -    }
> -
>       unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
>           // SAFETY: By the safety requirement of this function, we know =
that `ptr` came from
>           // a previous call to `Arc::into_foreign`, which guarantees tha=
t `ptr` is valid and
>           // holds a reference count increment that is transferrable to u=
s.
> -        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
> +        unsafe { Self::from_inner(NonNull::new_unchecked(ptr as _)) }
>       }
> +
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a,=
 T> {
> +        // SAFETY: By the safety requirement of this function, we know t=
hat `ptr` came from
> +        // a previous call to `Arc::into_foreign`.
> +        let inner =3D unsafe { NonNull::new_unchecked(ptr as *mut ArcInn=
er<T>) };
> +
> +        // SAFETY: The safety requirements ensure that we will not give =
up our
> +        // foreign-owned refcount while the `ArcBorrow` is still live.
> +        unsafe { ArcBorrow::new(inner) }
> +    }
> +
> +    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow=
<'a, T> {
> +        // SAFETY: The safety requirements for `borrow_mut` are a supers=
et of the safety
> +        // requirements for `borrow`.
> +        unsafe { Self::borrow(ptr) }
> +    }
>   }
>=20
> base-commit: d2e3115d717197cb2bc020dd1f06b06538474ac3
> prerequisite-patch-id: b493b9015cb19f599c4bc03127733193b11ca822
> --
> 2.41.0.255.g8b1d071c50-goog
> 
