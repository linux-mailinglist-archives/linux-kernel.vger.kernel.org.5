Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C22F77B496
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjHNIrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjHNIrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:47:21 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2E01700;
        Mon, 14 Aug 2023 01:47:18 -0700 (PDT)
Date:   Mon, 14 Aug 2023 08:47:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1692002836; x=1692262036;
        bh=DOUsrR9hesPZ+QVUGZPbd/KrHB27w86EX9+a/GhU1bE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=IUB74zJW3K7iw8YYsQQQIm3nIjvaw1/4UxWkBsHubVAnsKfdJMnWyyfBndiODsXse
         V6MHojc/w9ryltKzL0YkUdos0DS+oY3qWUeNnSIZVJyf/9649VBfcnT6A22MHXsCMe
         aL5KOVq9vEpYXLb9aUuslyANmoE1L4qUDdmZMxNQCPX2hEmyo1GvxizvdLoiDQVGyW
         f7w0CraQ+eqTTAY1miygsq3uEk7NB2KssTfyucgPcNfIohqeBLApyLNx5Qxhk2G6J2
         VmpSYup1MhZBoKox/vH3cyv8eFLod2cRfO9hjx3kdy7wAkw8scC8gyBM6W4ZB/2Eks
         JA0Zu8ktGklLA==
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
Subject: [PATCH v4 07/13] rust: init: add `..Zeroable::zeroed()` syntax for zeroing all missing fields
Message-ID: <20230814084602.25699-8-benno.lossin@proton.me>
In-Reply-To: <20230814084602.25699-1-benno.lossin@proton.me>
References: <20230814084602.25699-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the struct update syntax to the init macros, but only for
`..Zeroable::zeroed()`. Adding this at the end of the struct initializer
allows one to omit fields from the initializer, these fields will be
initialized with 0x00 set to every byte. Only types that implement the
`Zeroable` trait can utilize this.

Suggested-by: Asahi Lina <lina@asahilina.net>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v3 -> v4:
- added Reviewed-by from Gary.

v2 -> v3:
- changed `if false` argument to use `never executed closure`,
- added Reviewed-by's from Martin and Alice.

v1 -> v2:
- fix doctest imports,
- fix doctest examples,
- fix `Zeroable` path in the `__init_internal` macro,
- rename `is_zeroable` -> `assert_zeroable`,
- add missing `{}` to the case when `..Zeroable::zeroed()` is present,
- add `allow(unused_assignments)` in the type-checked struct
  initializer.

 rust/kernel/init.rs        |  16 +++++-
 rust/kernel/init/macros.rs | 115 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 0120674b451e..460f808ebf84 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -517,13 +517,17 @@ macro_rules! stack_try_pin_init {
 /// - Fields that you want to initialize in-place have to use `<-` instead=
 of `:`.
 /// - In front of the initializer you can write `&this in` to have access =
to a [`NonNull<Self>`]
 ///   pointer named `this` inside of the initializer.
+/// - Using struct update syntax one can place `..Zeroable::zeroed()` at t=
he very end of the
+///   struct, this initializes every field with 0 and then runs all initia=
lizers specified in the
+///   body. This can only be done if [`Zeroable`] is implemented for the s=
truct.
 ///
 /// For instance:
 ///
 /// ```rust
-/// # use kernel::{macros::pin_data, pin_init};
+/// # use kernel::{macros::{Zeroable, pin_data}, pin_init};
 /// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
 /// #[pin_data]
+/// #[derive(Zeroable)]
 /// struct Buf {
 ///     // `ptr` points into `buf`.
 ///     ptr: *mut u8,
@@ -536,6 +540,10 @@ macro_rules! stack_try_pin_init {
 ///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
 ///     pin: PhantomPinned,
 /// });
+/// pin_init!(Buf {
+///     buf: [1; 64],
+///     ..Zeroable::zeroed()
+/// });
 /// ```
 ///
 /// [`try_pin_init!`]: kernel::try_pin_init
@@ -555,6 +563,7 @@ macro_rules! pin_init {
             @data(PinData, use_data),
             @has_data(HasPinData, __pin_data),
             @construct_closure(pin_init_from_closure),
+            @munch_fields($($fields)*),
         )
     };
 }
@@ -611,6 +620,7 @@ macro_rules! try_pin_init {
             @data(PinData, use_data),
             @has_data(HasPinData, __pin_data),
             @construct_closure(pin_init_from_closure),
+            @munch_fields($($fields)*),
         )
     };
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
@@ -624,6 +634,7 @@ macro_rules! try_pin_init {
             @data(PinData, use_data),
             @has_data(HasPinData, __pin_data),
             @construct_closure(pin_init_from_closure),
+            @munch_fields($($fields)*),
         )
     };
 }
@@ -658,6 +669,7 @@ macro_rules! init {
             @data(InitData, /*no use_data*/),
             @has_data(HasInitData, __init_data),
             @construct_closure(init_from_closure),
+            @munch_fields($($fields)*),
         )
     }
 }
@@ -708,6 +720,7 @@ macro_rules! try_init {
             @data(InitData, /*no use_data*/),
             @has_data(HasInitData, __init_data),
             @construct_closure(init_from_closure),
+            @munch_fields($($fields)*),
         )
     };
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
@@ -721,6 +734,7 @@ macro_rules! try_init {
             @data(InitData, /*no use_data*/),
             @has_data(HasInitData, __init_data),
             @construct_closure(init_from_closure),
+            @munch_fields($($fields)*),
         )
     };
 }
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index cfeacc4b3f7d..4c86281301d8 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -991,6 +991,7 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
 ///
 /// This macro has multiple internal call configurations, these are always=
 the very first ident:
 /// - nothing: this is the base case and called by the `{try_}{pin_}init!`=
 macros.
+/// - `with_update_parsed`: when the `..Zeroable::zeroed()` syntax has bee=
n handled.
 /// - `init_slot`: recursively creates the code that initializes all field=
s in `slot`.
 /// - `make_initializer`: recursively create the struct initializer that g=
uarantees that every
 ///   field has been initialized exactly once.
@@ -1009,6 +1010,82 @@ macro_rules! __init_internal {
         @has_data($has_data:ident, $get_data:ident),
         // `pin_init_from_closure` or `init_from_closure`.
         @construct_closure($construct_closure:ident),
+        @munch_fields(),
+    ) =3D> {
+        $crate::__init_internal!(with_update_parsed:
+            @this($($this)?),
+            @typ($t $(::<$($generics),*>)? ),
+            @fields($($fields)*),
+            @error($err),
+            @data($data, $($use_data)?),
+            @has_data($has_data, $get_data),
+            @construct_closure($construct_closure),
+            @zeroed(), // nothing means default behavior.
+        )
+    };
+    (
+        @this($($this:ident)?),
+        @typ($t:ident $(::<$($generics:ty),*>)?),
+        @fields($($fields:tt)*),
+        @error($err:ty),
+        // Either `PinData` or `InitData`, `$use_data` should only be pres=
ent in the `PinData`
+        // case.
+        @data($data:ident, $($use_data:ident)?),
+        // `HasPinData` or `HasInitData`.
+        @has_data($has_data:ident, $get_data:ident),
+        // `pin_init_from_closure` or `init_from_closure`.
+        @construct_closure($construct_closure:ident),
+        @munch_fields(..Zeroable::zeroed()),
+    ) =3D> {
+        $crate::__init_internal!(with_update_parsed:
+            @this($($this)?),
+            @typ($t $(::<$($generics),*>)? ),
+            @fields($($fields)*),
+            @error($err),
+            @data($data, $($use_data)?),
+            @has_data($has_data, $get_data),
+            @construct_closure($construct_closure),
+            @zeroed(()), // `()` means zero all fields not mentioned.
+        )
+    };
+    (
+        @this($($this:ident)?),
+        @typ($t:ident $(::<$($generics:ty),*>)?),
+        @fields($($fields:tt)*),
+        @error($err:ty),
+        // Either `PinData` or `InitData`, `$use_data` should only be pres=
ent in the `PinData`
+        // case.
+        @data($data:ident, $($use_data:ident)?),
+        // `HasPinData` or `HasInitData`.
+        @has_data($has_data:ident, $get_data:ident),
+        // `pin_init_from_closure` or `init_from_closure`.
+        @construct_closure($construct_closure:ident),
+        @munch_fields($ignore:tt $($rest:tt)*),
+    ) =3D> {
+        $crate::__init_internal!(
+            @this($($this)?),
+            @typ($t $(::<$($generics),*>)? ),
+            @fields($($fields)*),
+            @error($err),
+            @data($data, $($use_data)?),
+            @has_data($has_data, $get_data),
+            @construct_closure($construct_closure),
+            @munch_fields($($rest)*),
+        )
+    };
+    (with_update_parsed:
+        @this($($this:ident)?),
+        @typ($t:ident $(::<$($generics:ty),*>)?),
+        @fields($($fields:tt)*),
+        @error($err:ty),
+        // Either `PinData` or `InitData`, `$use_data` should only be pres=
ent in the `PinData`
+        // case.
+        @data($data:ident, $($use_data:ident)?),
+        // `HasPinData` or `HasInitData`.
+        @has_data($has_data:ident, $get_data:ident),
+        // `pin_init_from_closure` or `init_from_closure`.
+        @construct_closure($construct_closure:ident),
+        @zeroed($($init_zeroed:expr)?),
     ) =3D> {{
         // We do not want to allow arbitrary returns, so we declare this t=
ype as the `Ok` return
         // type and shadow it later when we insert the arbitrary user code=
. That way there will be
@@ -1026,6 +1103,17 @@ macro_rules! __init_internal {
                 {
                     // Shadow the structure so it cannot be used to return=
 early.
                     struct __InitOk;
+                    // If `$init_zeroed` is present we should zero the slo=
t now and not emit an
+                    // error when fields are missing (since they will be z=
eroed). We also have to
+                    // check that the type actually implements `Zeroable`.
+                    $({
+                        fn assert_zeroable<T: $crate::init::Zeroable>(_: *=
mut T) {}
+                        // Ensure that the struct is indeed `Zeroable`.
+                        assert_zeroable(slot);
+                        // SAFETY:  The type implements `Zeroable` by the =
check above.
+                        unsafe { ::core::ptr::write_bytes(slot, 0, 1) };
+                        $init_zeroed // this will be `()` if set.
+                    })?
                     // Create the `this` so it can be referenced by the us=
er inside of the
                     // expressions creating the individual fields.
                     $(let $this =3D unsafe { ::core::ptr::NonNull::new_unc=
hecked(slot) };)?
@@ -1062,7 +1150,7 @@ macro_rules! __init_internal {
         @data($data:ident),
         @slot($slot:ident),
         @guards($($guards:ident,)*),
-        @munch_fields($(,)?),
+        @munch_fields($(..Zeroable::zeroed())? $(,)?),
     ) =3D> {
         // Endpoint of munching, no fields are left. If execution reaches =
this point, all fields
         // have been initialized. Therefore we can now dismiss the guards =
by forgetting them.
@@ -1163,6 +1251,31 @@ macro_rules! __init_internal {
             );
         }
     };
+    (make_initializer:
+        @slot($slot:ident),
+        @type_name($t:ident),
+        @munch_fields(..Zeroable::zeroed() $(,)?),
+        @acc($($acc:tt)*),
+    ) =3D> {
+        // Endpoint, nothing more to munch, create the initializer. Since =
the users specified
+        // `..Zeroable::zeroed()`, the slot will already have been zeroed =
and all field that have
+        // not been overwritten are thus zero and initialized. We still ch=
eck that all fields are
+        // actually accessible by using the struct update syntax ourselves=
.
+        // We are inside of a closure that is never executed and thus we c=
an abuse `slot` to
+        // get the correct type inference here:
+        #[allow(unused_assignments)]
+        unsafe {
+            let mut zeroed =3D ::core::mem::zeroed();
+            // We have to use type inference here to make zeroed have the =
correct type. This does
+            // not get executed, so it has no effect.
+            ::core::ptr::write($slot, zeroed);
+            zeroed =3D ::core::mem::zeroed();
+            ::core::ptr::write($slot, $t {
+                $($acc)*
+                ..zeroed
+            });
+        }
+    };
     (make_initializer:
         @slot($slot:ident),
         @type_name($t:ident),
--=20
2.41.0


