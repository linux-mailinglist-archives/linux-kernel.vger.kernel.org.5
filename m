Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BDE77B498
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjHNIrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjHNIrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:47:32 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEAD1BD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:47:26 -0700 (PDT)
Date:   Mon, 14 Aug 2023 08:47:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=c3ehzphaojh3tmfhfoidalwfii.protonmail; t=1692002844; x=1692262044;
        bh=FtpwglMZkGsk6Cq7uG4CBizP3n1NDqFHuFg1fsdOfrA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Xa+gIRKh6q1Oa69K6I+pgABGtdkERf9oJ46KJRMnqaWH019BrDoZVQBvsJC1XsvlY
         cL/6BtfO3agfXPu+r9+v5wI+z6vETwK2ju/+PstvuGMGXpI/eiMdHIdSrOj/mFto+I
         sTzCCOyfyurQh3tniudsoZmGTyvpp32kHxZ7/Xf8ocuovOZw4cYkzkUoXP4PEs9sgd
         nq1uWTOjzcCxxLr4x5+LBDT7BwJfTVRwJfDFoXHHJ3jpof1FfWgQuk2j3Zw7Fis8Am
         qD1AYbBUR/QOJtqHCST/Qjydszw18rkHua7oYoKE7RM1tNaYTG/6qFV9v5eEo4RygI
         WtBV8gm9Ywzjw==
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
Subject: [PATCH v4 08/13] rust: init: Add functions to create array initializers
Message-ID: <20230814084602.25699-9-benno.lossin@proton.me>
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

Add two functions `pin_init_array_from_fn` and `init_array_from_fn` that
take a function that generates initializers for `T` from usize, the added
functions then return an initializer for `[T; N]` where every element is
initialized by an element returned from the generator function.

Suggested-by: Asahi Lina <lina@asahilina.net>
Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v3 -> v4:
- changed example size from 1_000_000_000 to 1_000,
- made functions unwind-safe by using a ScopeGuard,
- added Reviewed-by from Martin.

v2 -> v3:
- changed doctest: instead of printing the array, assert the length,
- added Reviewed-by's from Alice.

v1 -> v2:
- fix warnings and errors in doctests,
- replace dropping loop with `drop_in_place` and `slice_from_raw_parts_mut`
  inside of `{pin_}init_array_from_fn` functions.

 rust/kernel/init.rs | 88 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 460f808ebf84..b54f32017d00 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -212,6 +212,7 @@
 use crate::{
     error::{self, Error},
     sync::UniqueArc,
+    types::ScopeGuard,
 };
 use alloc::boxed::Box;
 use core::{
@@ -875,6 +876,93 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E> =
{
     unsafe { init_from_closure(|_| Ok(())) }
 }
=20
+/// Initializes an array by initializing each element via the provided ini=
tializer.
+///
+/// # Examples
+///
+/// ```rust
+/// use kernel::{error::Error, init::init_array_from_fn};
+/// let array: Box<[usize; 1_000]>=3D Box::init::<Error>(init_array_from_f=
n(|i| i)).unwrap();
+/// assert_eq!(array.len(), 1_000);
+/// ```
+pub fn init_array_from_fn<I, const N: usize, T, E>(
+    mut make_init: impl FnMut(usize) -> I,
+) -> impl Init<[T; N], E>
+where
+    I: Init<T, E>,
+{
+    let init =3D move |slot: *mut [T; N]| {
+        let slot =3D slot.cast::<T>();
+        // Counts the number of initialized elements and when dropped drop=
s that many elements from
+        // `slot`.
+        let mut init_count =3D ScopeGuard::new_with_data(0, |i| {
+            // We now free every element that has been initialized before:
+            // SAFETY: The loop initialized exactly the values from 0..i a=
nd since we
+            // return `Err` below, the caller will consider the memory at =
`slot` as
+            // uninitialized.
+            unsafe { ptr::drop_in_place(ptr::slice_from_raw_parts_mut(slot=
, i)) };
+        });
+        for i in 0..N {
+            let init =3D make_init(i);
+            // SAFETY: since 0 <=3D `i` < N, it is still in bounds of `[T;=
 N]`.
+            let ptr =3D unsafe { slot.add(i) };
+            // SAFETY: The pointer is derived from `slot` and thus satisfi=
es the `__init`
+            // requirements.
+            unsafe { init.__init(ptr) }?;
+            *init_count +=3D 1;
+        }
+        init_count.dismiss();
+        Ok(())
+    };
+    // SAFETY: The initializer above initializes every element of the arra=
y. On failure it drops
+    // any initialized elements and returns `Err`.
+    unsafe { init_from_closure(init) }
+}
+
+/// Initializes an array by initializing each element via the provided ini=
tializer.
+///
+/// # Examples
+///
+/// ```rust
+/// use kernel::{sync::{Arc, Mutex}, init::pin_init_array_from_fn, new_mut=
ex};
+/// let array: Arc<[Mutex<usize>; 1_000]>=3D
+///     Arc::pin_init(pin_init_array_from_fn(|i| new_mutex!(i))).unwrap();
+/// assert_eq!(array.len(), 1_000);
+/// ```
+pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
+    mut make_init: impl FnMut(usize) -> I,
+) -> impl PinInit<[T; N], E>
+where
+    I: PinInit<T, E>,
+{
+    let init =3D move |slot: *mut [T; N]| {
+        let slot =3D slot.cast::<T>();
+        // Counts the number of initialized elements and when dropped drop=
s that many elements from
+        // `slot`.
+        let mut init_count =3D ScopeGuard::new_with_data(0, |i| {
+            // We now free every element that has been initialized before:
+            // SAFETY: The loop initialized exactly the values from 0..i a=
nd since we
+            // return `Err` below, the caller will consider the memory at =
`slot` as
+            // uninitialized.
+            unsafe { ptr::drop_in_place(ptr::slice_from_raw_parts_mut(slot=
, i)) };
+        });
+        for i in 0..N {
+            let init =3D make_init(i);
+            // SAFETY: since 0 <=3D `i` < N, it is still in bounds of `[T;=
 N]`.
+            let ptr =3D unsafe { slot.add(i) };
+            // SAFETY: The pointer is derived from `slot` and thus satisfi=
es the `__init`
+            // requirements.
+            unsafe { init.__pinned_init(ptr) }?;
+            *init_count +=3D 1;
+        }
+        init_count.dismiss();
+        Ok(())
+    };
+    // SAFETY: The initializer above initializes every element of the arra=
y. On failure it drops
+    // any initialized elements and returns `Err`.
+    unsafe { pin_init_from_closure(init) }
+}
+
 // SAFETY: Every type can be initialized by-value.
 unsafe impl<T, E> Init<T, E> for T {
     unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
--=20
2.41.0


