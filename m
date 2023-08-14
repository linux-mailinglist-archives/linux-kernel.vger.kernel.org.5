Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370D077B49E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjHNIsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbjHNIsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:48:22 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEDD170C;
        Mon, 14 Aug 2023 01:48:04 -0700 (PDT)
Date:   Mon, 14 Aug 2023 08:47:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1692002882; x=1692262082;
        bh=hkVBT1/HhXlC0vpOSaCkYCiuk6RG/epKqCA50EBxt0s=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=H6TSHj0ovbEmRBAYnTfOmitCd0goCXOvTFW1CiF7GfTonLxQXS+KR4Hig9ISdxZ71
         8Xl4r130KWm4xNvRHnSgN5EBw3g9+GvpBJm6P00B7KlfSzcHunr4vFJaaltiNFCYT8
         3d4Exm1EEHD6E+8Yh/5KQ9snDxMhEuiaQanEL6ScJaMhqchCq8qVwfiHSEuwGZL1a4
         7fs3Fx6l1FxLd6LXZDflI33fFCG0aNngyVHynKZztdI0V4U2zESeTU4udaMT6gjk9y
         t0LWKvnFfuxOKeDdrTS7BOP6IHc65TIGuBk4koptQ+CJuwCrDrCVt6Etksq4KTpiUF
         aY0ci2xSPLhng==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v4 12/13] rust: init: add `{pin_}chain` functions to `{Pin}Init<T, E>`
Message-ID: <20230814084602.25699-13-benno.lossin@proton.me>
In-Reply-To: <20230814084602.25699-1-benno.lossin@proton.me>
References: <20230814084602.25699-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `{pin_}chain` functions extend an initializer: it not only
initializes the value, but also executes a closure taking a reference to
the initialized value. This allows to do something with a value directly
after initialization.

Suggested-by: Asahi Lina <lina@asahilina.net>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v3 -> v4:
- added Reviewed-by from Martin.

v2 -> v3:
- clarify that if `f` errors, the already initialized value will be
  dropped in both functions.

 rust/kernel/init.rs            | 142 +++++++++++++++++++++++++++++++++
 rust/kernel/init/__internal.rs |   2 +-
 2 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index a15fb5ddbc7d..d75220c8b3f1 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -775,6 +775,79 @@ pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>:=
 Sized {
     ///   deallocate.
     /// - `slot` will not move until it is dropped, i.e. it will be pinned=
.
     unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E>;
+
+    /// First initializes the value using `self` then calls the function `=
f` with the initialized
+    /// value.
+    ///
+    /// If `f` returns an error the value is dropped and the initializer w=
ill forward the error.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// # #![allow(clippy::disallowed_names)]
+    /// use kernel::{types::Opaque, init::pin_init_from_closure};
+    /// #[repr(C)]
+    /// struct RawFoo([u8; 16]);
+    /// extern {
+    ///     fn init_foo(_: *mut RawFoo);
+    /// }
+    ///
+    /// #[pin_data]
+    /// struct Foo {
+    ///     #[pin]
+    ///     raw: Opaque<RawFoo>,
+    /// }
+    ///
+    /// impl Foo {
+    ///     fn setup(self: Pin<&mut Self>) {
+    ///         pr_info!("Setting up foo");
+    ///     }
+    /// }
+    ///
+    /// let foo =3D pin_init!(Foo {
+    ///     raw <- unsafe {
+    ///         Opaque::ffi_init(|s| {
+    ///             init_foo(s);
+    ///         })
+    ///     },
+    /// }).pin_chain(|foo| {
+    ///     foo.setup();
+    ///     Ok(())
+    /// });
+    /// ```
+    fn pin_chain<F>(self, f: F) -> ChainPinInit<Self, F, T, E>
+    where
+        F: FnOnce(Pin<&mut T>) -> Result<(), E>,
+    {
+        ChainPinInit(self, f, PhantomData)
+    }
+}
+
+/// An initializer returned by [`PinInit::pin_chain`].
+pub struct ChainPinInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E=
, Box<T>)>);
+
+// SAFETY: the `__pinned_init` function is implemented such that it
+// - returns `Ok(())` on successful initialization,
+// - returns `Err(err)` on error and in this case `slot` will be dropped.
+// - considers `slot` pinned.
+unsafe impl<T: ?Sized, E, I, F> PinInit<T, E> for ChainPinInit<I, F, T, E>
+where
+    I: PinInit<T, E>,
+    F: FnOnce(Pin<&mut T>) -> Result<(), E>,
+{
+    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
+        // SAFETY: all requirements fulfilled since this function is `__pi=
nned_init`.
+        unsafe { self.0.__pinned_init(slot)? };
+        // SAFETY: The above call initialized `slot` and we still have uni=
que access.
+        let val =3D unsafe { &mut *slot };
+        // SAFETY: `slot` is considered pinned
+        let val =3D unsafe { Pin::new_unchecked(val) };
+        (self.1)(val).map_err(|e| {
+            // SAFETY: `slot` was initialized above.
+            unsafe { core::ptr::drop_in_place(slot) };
+            e
+        })
+    }
 }
=20
 /// An initializer for `T`.
@@ -816,6 +889,75 @@ pub unsafe trait Init<T: ?Sized, E =3D Infallible>: Pi=
nInit<T, E> {
     /// - the caller does not touch `slot` when `Err` is returned, they ar=
e only permitted to
     ///   deallocate.
     unsafe fn __init(self, slot: *mut T) -> Result<(), E>;
+
+    /// First initializes the value using `self` then calls the function `=
f` with the initialized
+    /// value.
+    ///
+    /// If `f` returns an error the value is dropped and the initializer w=
ill forward the error.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// # #![allow(clippy::disallowed_names)]
+    /// use kernel::{types::Opaque, init::{self, init_from_closure}};
+    /// struct Foo {
+    ///     buf: [u8; 1_000_000],
+    /// }
+    ///
+    /// impl Foo {
+    ///     fn setup(&mut self) {
+    ///         pr_info!("Setting up foo");
+    ///     }
+    /// }
+    ///
+    /// let foo =3D init!(Foo {
+    ///     buf <- init::zeroed()
+    /// }).chain(|foo| {
+    ///     foo.setup();
+    ///     Ok(())
+    /// });
+    /// ```
+    fn chain<F>(self, f: F) -> ChainInit<Self, F, T, E>
+    where
+        F: FnOnce(&mut T) -> Result<(), E>,
+    {
+        ChainInit(self, f, PhantomData)
+    }
+}
+
+/// An initializer returned by [`Init::chain`].
+pub struct ChainInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, B=
ox<T>)>);
+
+// SAFETY: the `__init` function is implemented such that it
+// - returns `Ok(())` on successful initialization,
+// - returns `Err(err)` on error and in this case `slot` will be dropped.
+unsafe impl<T: ?Sized, E, I, F> Init<T, E> for ChainInit<I, F, T, E>
+where
+    I: Init<T, E>,
+    F: FnOnce(&mut T) -> Result<(), E>,
+{
+    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
+        // SAFETY: all requirements fulfilled since this function is `__in=
it`.
+        unsafe { self.0.__pinned_init(slot)? };
+        // SAFETY: The above call initialized `slot` and we still have uni=
que access.
+        (self.1)(unsafe { &mut *slot }).map_err(|e| {
+            // SAFETY: `slot` was initialized above.
+            unsafe { core::ptr::drop_in_place(slot) };
+            e
+        })
+    }
+}
+
+// SAFETY: `__pinned_init` behaves exactly the same as `__init`.
+unsafe impl<T: ?Sized, E, I, F> PinInit<T, E> for ChainInit<I, F, T, E>
+where
+    I: Init<T, E>,
+    F: FnOnce(&mut T) -> Result<(), E>,
+{
+    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
+        // SAFETY: `__init` has less strict requirements compared to `__pi=
nned_init`.
+        unsafe { self.__init(slot) }
+    }
 }
=20
 /// Creates a new [`PinInit<T, E>`] from the given closure.
diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.r=
s
index 12e195061525..db3372619ecd 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -13,7 +13,7 @@
 ///
 /// [nomicon]: https://doc.rust-lang.org/nomicon/subtyping.html
 /// [this table]: https://doc.rust-lang.org/nomicon/phantom-data.html#tabl=
e-of-phantomdata-patterns
-type Invariant<T> =3D PhantomData<fn(*mut T) -> *mut T>;
+pub(super) type Invariant<T> =3D PhantomData<fn(*mut T) -> *mut T>;
=20
 /// This is the module-internal type implementing `PinInit` and `Init`. It=
 is unsafe to create this
 /// type, since the closure needs to fulfill the same safety requirement a=
s the
--=20
2.41.0


