Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC92767D7C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjG2JK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjG2JKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:10:36 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37844EE6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 02:10:12 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:10:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1690621810; x=1690881010;
        bh=n0kp3TT0AEotHmbMlG5LKX11QJLhjQnwXfm8v2x0jbI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=STchfM9pMzNv1kegQLLu7D1J9AWizn4gPoirUYsWKhr3Jksyn56UM+e2jRaN6YvC3
         OUy8eUIsZ0ynQuNAJ+G0dVniFI+6ZMOePtiwKjbvplgzrU1Lezy7lpc4TVh8k42GIh
         fYkEs2cUYit0vfMFa81Qz2hc6/GQx+eckF9Nt5pxFaqZgRVf8IwzXUarKWhy//6BLu
         4IK2sSrlDTlxOKM+LE3mEwVsi5kQ1ZZNyln8cB5TxPJxt2bMgUpEyHmnirebwd48HG
         rAcHMsPiCJz1lea99+7BIWRW+ntM1qApbUpn9Kv3ACzn2XqSanlNZhafl5I3l8+5Ur
         ARZ2+sDGwVaYA==
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
Subject: [PATCH v3 08/13] rust: init: Add functions to create array initializers
Message-ID: <20230729090838.225225-9-benno.lossin@proton.me>
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

Add two functions `pin_init_array_from_fn` and `init_array_from_fn` that
take a function that generates initializers for `T` from usize, the added
functions then return an initializer for `[T; N]` where every element is
initialized by an element returned from the generator function.

Suggested-by: Asahi Lina <lina@asahilina.net>
Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v2 -> v3:
- changed doctest: instead of printing the array, assert the length,
- added Reviewed-by's from Alice.

v1 -> v2:
- fix warnings and errors in doctests,
- replace dropping loop with `drop_in_place` and `slice_from_raw_parts_mut`
  inside of `{pin_}init_array_from_fn` functions.

 rust/kernel/init.rs | 86 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 460f808ebf84..af96d4acc26b 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -875,6 +875,92 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E> =
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
+/// let array: Box<[usize; 1_000_000_000]>=3D Box::init::<Error>(init_arra=
y_from_fn(|i| i)).unwrap();
+/// assert_eq!(array.len(), 1_000_000_000);
+/// ```
+pub fn init_array_from_fn<I, const N: usize, T, E>(
+    mut make_init: impl FnMut(usize) -> I,
+) -> impl Init<[T; N], E>
+where
+    I: Init<T, E>,
+{
+    let init =3D move |slot: *mut [T; N]| {
+        let slot =3D slot.cast::<T>();
+        for i in 0..N {
+            let init =3D make_init(i);
+            // SAFETY: since 0 <=3D `i` < N, it is still in bounds of `[T;=
 N]`.
+            let ptr =3D unsafe { slot.add(i) };
+            // SAFETY: The pointer is derived from `slot` and thus satisfi=
es the `__init`
+            // requirements.
+            match unsafe { init.__init(ptr) } {
+                Ok(()) =3D> {}
+                Err(e) =3D> {
+                    // We now free every element that has been initialized=
 before:
+                    // SAFETY: The loop initialized exactly the values fro=
m 0..i and since we
+                    // return `Err` below, the caller will consider the me=
mory at `slot` as
+                    // uninitialized.
+                    unsafe { ptr::drop_in_place(ptr::slice_from_raw_parts_=
mut(slot, i)) };
+                    return Err(e);
+                }
+            }
+        }
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
+/// let array: Arc<[Mutex<usize>; 1_000_000_000]>=3D
+///     Arc::pin_init(pin_init_array_from_fn(|i| new_mutex!(i))).unwrap();
+/// assert_eq!(array.len(), 1_000_000_000);
+/// ```
+pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
+    mut make_init: impl FnMut(usize) -> I,
+) -> impl PinInit<[T; N], E>
+where
+    I: PinInit<T, E>,
+{
+    let init =3D move |slot: *mut [T; N]| {
+        let slot =3D slot.cast::<T>();
+        for i in 0..N {
+            let init =3D make_init(i);
+            // SAFETY: since 0 <=3D `i` < N, it is still in bounds of `[T;=
 N]`.
+            let ptr =3D unsafe { slot.add(i) };
+            // SAFETY: The pointer is derived from `slot` and thus satisfi=
es the `__pinned_init`
+            // requirements.
+            match unsafe { init.__pinned_init(ptr) } {
+                Ok(()) =3D> {}
+                Err(e) =3D> {
+                    // We now have to free every element that has been ini=
tialized before, since we
+                    // have to abide by the drop guarantee.
+                    // SAFETY: The loop initialized exactly the values fro=
m 0..i and since we
+                    // return `Err` below, the caller will consider the me=
mory at `slot` as
+                    // uninitialized.
+                    unsafe { ptr::drop_in_place(ptr::slice_from_raw_parts_=
mut(slot, i)) };
+                    return Err(e);
+                }
+            }
+        }
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


