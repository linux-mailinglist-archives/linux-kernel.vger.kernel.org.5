Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A10767D78
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjG2JKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjG2JKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:10:16 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013544C21;
        Sat, 29 Jul 2023 02:09:52 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:09:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1690621791; x=1690880991;
        bh=JsVvEmezg9Lvg6P1Vn7MyyhGkVZ8a0YG+MpLx2E1ZDo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ktgpeM85JtomgKv0UbJJcMRTJ4ebcj2kBQTzrWH5PtFSUFJ9knKdd720lDuyILOus
         x5qrZG30Qt14nxd9V7nb1HBMHB1wpGMiVRXO0sVT8WeSI7DU+5E9oiiOdEROE9EqTH
         KfY2VFO4C3hc4+pyfx7DCxR0wCWjbySrokZCp8V4fL4UxjGNaqYb1sFzJUfh+tHi39
         ArgBil7DzyHgtbofiYqTzh7/bLdPAXAHBqPLWhtEOg873xVA7Axy6rCOOvGW3GlEUb
         Ukjue2pAdpxUt5BGXJFZ7cxU+7fZXVmGdSqrLU9d/spokyfGJpq8ORFUvrGHbW086U
         Zr/5UdUIqcTRw==
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
        Asahi Lina <lina@asahilina.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v3 04/13] rust: init: make guards in the init macros hygienic
Message-ID: <20230729090838.225225-5-benno.lossin@proton.me>
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

Use hygienic identifiers for the guards instead of the field names. This
makes the init macros feel more like normal struct initializers, since
assigning identifiers with the name of a field does not create
conflicts.
Also change the internals of the guards, no need to make the `forget`
function `unsafe`, since users cannot access the guards anyways. Now the
guards are carried directly on the stack and have no extra `Cell<bool>`
field that marks if they have been forgotten or not, instead they are
just forgotten via `mem::forget`.

Suggested-by: Asahi Lina <lina@asahilina.net>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v2 -> v3:
- added Reviewed-by's from Martin and Alice.

v1 -> v2:
- use Gary's `paste!` macro to create the guard hygiene.

 rust/kernel/init.rs            |   1 -
 rust/kernel/init/__internal.rs |  25 ++-----
 rust/kernel/init/macros.rs     | 116 +++++++++++++++------------------
 3 files changed, 56 insertions(+), 86 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index d431d0b153a2..0120674b451e 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -216,7 +216,6 @@
 use alloc::boxed::Box;
 use core::{
     alloc::AllocError,
-    cell::Cell,
     convert::Infallible,
     marker::PhantomData,
     mem::MaybeUninit,
diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.r=
s
index 44751fb62b51..7abd1fb65e41 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -174,7 +174,6 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl PinInit=
<T, E>) -> Result<Pin<&mu
 /// Can be forgotten to prevent the drop.
 pub struct DropGuard<T: ?Sized> {
     ptr: *mut T,
-    do_drop: Cell<bool>,
 }
=20
 impl<T: ?Sized> DropGuard<T> {
@@ -190,32 +189,16 @@ impl<T: ?Sized> DropGuard<T> {
     /// - will not be dropped by any other means.
     #[inline]
     pub unsafe fn new(ptr: *mut T) -> Self {
-        Self {
-            ptr,
-            do_drop: Cell::new(true),
-        }
-    }
-
-    /// Prevents this guard from dropping the supplied pointer.
-    ///
-    /// # Safety
-    ///
-    /// This function is unsafe in order to prevent safe code from forgett=
ing this guard. It should
-    /// only be called by the macros in this module.
-    #[inline]
-    pub unsafe fn forget(&self) {
-        self.do_drop.set(false);
+        Self { ptr }
     }
 }
=20
 impl<T: ?Sized> Drop for DropGuard<T> {
     #[inline]
     fn drop(&mut self) {
-        if self.do_drop.get() {
-            // SAFETY: A `DropGuard` can only be constructed using the uns=
afe `new` function
-            // ensuring that this operation is safe.
-            unsafe { ptr::drop_in_place(self.ptr) }
-        }
+        // SAFETY: A `DropGuard` can only be constructed using the unsafe =
`new` function
+        // ensuring that this operation is safe.
+        unsafe { ptr::drop_in_place(self.ptr) }
     }
 }
=20
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index 78091756dec0..454f31b8c614 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -994,7 +994,6 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
 /// - `init_slot`: recursively creates the code that initializes all field=
s in `slot`.
 /// - `make_initializer`: recursively create the struct initializer that g=
uarantees that every
 ///   field has been initialized exactly once.
-/// - `forget_guards`: recursively forget the drop guards for every field.
 #[doc(hidden)]
 #[macro_export]
 macro_rules! __init_internal {
@@ -1034,6 +1033,7 @@ macro_rules! __init_internal {
                     $crate::__init_internal!(init_slot($($use_data)?):
                         @data(data),
                         @slot(slot),
+                        @guards(),
                         @munch_fields($($fields)*,),
                     );
                     // We use unreachable code to ensure that all fields h=
ave been mentioned exactly
@@ -1048,10 +1048,6 @@ macro_rules! __init_internal {
                             @acc(),
                         );
                     }
-                    // Forget all guards, since initialization was a succe=
ss.
-                    $crate::__init_internal!(forget_guards:
-                        @munch_fields($($fields)*,),
-                    );
                 }
                 Ok(__InitOk)
             }
@@ -1065,13 +1061,17 @@ macro_rules! __init_internal {
     (init_slot($($use_data:ident)?):
         @data($data:ident),
         @slot($slot:ident),
+        @guards($($guards:ident,)*),
         @munch_fields($(,)?),
     ) =3D> {
-        // Endpoint of munching, no fields are left.
+        // Endpoint of munching, no fields are left. If execution reaches =
this point, all fields
+        // have been initialized. Therefore we can now dismiss the guards =
by forgetting them.
+        $(::core::mem::forget($guards);)*
     };
     (init_slot($use_data:ident): // use_data is present, so we use the `da=
ta` to init fields.
         @data($data:ident),
         @slot($slot:ident),
+        @guards($($guards:ident,)*),
         // In-place initialization syntax.
         @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
     ) =3D> {
@@ -1082,24 +1082,28 @@ macro_rules! __init_internal {
         // return when an error/panic occurs.
         // We also use the `data` to require the correct trait (`Init` or =
`PinInit`) for `$field`.
         unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), =
$field)? };
-        // Create the drop guard.
-        //
-        // We only give access to `&DropGuard`, so it cannot be forgotten =
via safe code.
+        // Create the drop guard:
         //
-        // SAFETY: We forget the guard later when initialization has succe=
eded.
-        let $field =3D &unsafe {
-            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_=
mut!((*$slot).$field))
-        };
+        // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
+        // We use `paste!` to create new hygiene for $field.
+        ::kernel::macros::paste! {
+            // SAFETY: We forget the guard later when initialization has s=
ucceeded.
+            let [<$field>] =3D unsafe {
+                $crate::init::__internal::DropGuard::new(::core::ptr::addr=
_of_mut!((*$slot).$field))
+            };
=20
-        $crate::__init_internal!(init_slot($use_data):
-            @data($data),
-            @slot($slot),
-            @munch_fields($($rest)*),
-        );
+            $crate::__init_internal!(init_slot($use_data):
+                @data($data),
+                @slot($slot),
+                @guards([<$field>], $($guards,)*),
+                @munch_fields($($rest)*),
+            );
+        }
     };
     (init_slot(): // no use_data, so we use `Init::__init` directly.
         @data($data:ident),
         @slot($slot:ident),
+        @guards($($guards:ident,)*),
         // In-place initialization syntax.
         @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
     ) =3D> {
@@ -1109,24 +1113,28 @@ macro_rules! __init_internal {
         // SAFETY: `slot` is valid, because we are inside of an initialize=
r closure, we
         // return when an error/panic occurs.
         unsafe { $crate::init::Init::__init($field, ::core::ptr::addr_of_m=
ut!((*$slot).$field))? };
-        // Create the drop guard.
-        //
-        // We only give access to `&DropGuard`, so it cannot be forgotten =
via safe code.
+        // Create the drop guard:
         //
-        // SAFETY: We forget the guard later when initialization has succe=
eded.
-        let $field =3D &unsafe {
-            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_=
mut!((*$slot).$field))
-        };
+        // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
+        // We use `paste!` to create new hygiene for $field.
+        ::kernel::macros::paste! {
+            // SAFETY: We forget the guard later when initialization has s=
ucceeded.
+            let [<$field>] =3D unsafe {
+                $crate::init::__internal::DropGuard::new(::core::ptr::addr=
_of_mut!((*$slot).$field))
+            };
=20
-        $crate::__init_internal!(init_slot():
-            @data($data),
-            @slot($slot),
-            @munch_fields($($rest)*),
-        );
+            $crate::__init_internal!(init_slot():
+                @data($data),
+                @slot($slot),
+                @guards([<$field>], $($guards,)*),
+                @munch_fields($($rest)*),
+            );
+        }
     };
     (init_slot($($use_data:ident)?):
         @data($data:ident),
         @slot($slot:ident),
+        @guards($($guards:ident,)*),
         // Init by-value.
         @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
     ) =3D> {
@@ -1137,18 +1145,21 @@ macro_rules! __init_internal {
         unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$fi=
eld), $field) };
         // Create the drop guard:
         //
-        // We only give access to `&DropGuard`, so it cannot be accidental=
ly forgotten.
-        //
-        // SAFETY: We forget the guard later when initialization has succe=
eded.
-        let $field =3D &unsafe {
-            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_=
mut!((*$slot).$field))
-        };
+        // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
+        // We use `paste!` to create new hygiene for $field.
+        ::kernel::macros::paste! {
+            // SAFETY: We forget the guard later when initialization has s=
ucceeded.
+            let [<$field>] =3D unsafe {
+                $crate::init::__internal::DropGuard::new(::core::ptr::addr=
_of_mut!((*$slot).$field))
+            };
=20
-        $crate::__init_internal!(init_slot($($use_data)?):
-            @data($data),
-            @slot($slot),
-            @munch_fields($($rest)*),
-        );
+            $crate::__init_internal!(init_slot($($use_data)?):
+                @data($data),
+                @slot($slot),
+                @guards([<$field>], $($guards,)*),
+                @munch_fields($($rest)*),
+            );
+        }
     };
     (make_initializer:
         @slot($slot:ident),
@@ -1191,29 +1202,6 @@ macro_rules! __init_internal {
             @acc($($acc)* $field: ::core::panic!(),),
         );
     };
-    (forget_guards:
-        @munch_fields($(,)?),
-    ) =3D> {
-        // Munching finished.
-    };
-    (forget_guards:
-        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
-    ) =3D> {
-        unsafe { $crate::init::__internal::DropGuard::forget($field) };
-
-        $crate::__init_internal!(forget_guards:
-            @munch_fields($($rest)*),
-        );
-    };
-    (forget_guards:
-        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
-    ) =3D> {
-        unsafe { $crate::init::__internal::DropGuard::forget($field) };
-
-        $crate::__init_internal!(forget_guards:
-            @munch_fields($($rest)*),
-        );
-    };
 }
=20
 #[doc(hidden)]
--=20
2.41.0


