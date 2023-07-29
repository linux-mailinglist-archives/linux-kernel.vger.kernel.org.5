Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFACB767D80
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjG2JL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjG2JLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:11:22 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB8E49FA;
        Sat, 29 Jul 2023 02:10:45 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:10:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1690621839; x=1690881039;
        bh=ir44Jd6eKvbhVWw3SrVOCnjRYoKyTsX6wUbiHNFNeuw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=QjdEGGh5iVrIYeObk69+J0k9U0sCzDsFr7ceKXxv2r9Wg9F5H7mEDwyhw2SK5qurt
         jmJZjDhWVdLGgHx8qvpKWo2qIaR2eAx+GVceWGoPN1wl+t6hdwdApda21/cWYfuNif
         sOhimMnwif9B/xSbrzKH9vG9pIr/WK+VHj84b4obztjCWEnER8AkAbMKorG+8Skp15
         z/R53HOxat9HOzNJDXQKKye9CkYzyc4nJ2WHvMyn+y7Pide7esFKYLjtaP1FJznSgg
         JyfVx7EABTaA6ovrk9Z7QGHhdlGKh6dovJeqK7FIEksQ+v6U7p+0dh5PPemTjyWpbK
         yKkfjutqZGDRA==
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
        Asahi Lina <lina@asahilina.net>
Subject: [PATCH v3 12/13] rust: init: add `{pin_}chain` functions to `{Pin}Init<T, E>`
Message-ID: <20230729090838.225225-13-benno.lossin@proton.me>
In-Reply-To: <20230729090838.225225-1-benno.lossin@proton.me>
References: <20230729090838.225225-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v2 -> v3:
- clarify that if `f` errors, the already initialized value will be
  dropped in both functions.

 rust/kernel/init.rs            | 142 +++++++++++++++++++++++++++++++++
 rust/kernel/init/__internal.rs |   2 +-
 2 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 040dc9a5f9fd..c1e70d150934 100644
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


