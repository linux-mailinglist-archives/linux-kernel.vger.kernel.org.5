Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F00767D7F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjG2JLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjG2JLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:11:22 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1231249F3;
        Sat, 29 Jul 2023 02:10:44 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:10:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1690621836; x=1690881036;
        bh=AH0HIEGjoQqibf1kDSLrSuvQlmckx0/sN/Y3zMQ9l2E=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=e6Ee/Ay28m2aF8g71TkVLHYPgKrHIsI6ZnO0XItdUgFnAlfOZSA0C3ivHqZ7l19nR
         hbHmpw/U7YDSNwfQChTDKu2zRmAru/SNNYCkExVdJYg91XUqmdTL+Ioi8LoWSjVcLo
         r7PRiooEkosYRC95ou+HpyIJV+0Bk5JWKIYr2TR4Sv6lrPp851efgebomRNzFnWoEg
         e9BchDE0QgFYQJewCJ1Go702HyCVikozp1mDXtQ3LhGxmKlc2D22cQHjtjib7jR+Ky
         0KetuWGDpxhVa3h6xC0QG9l7I6QmXKayDlv7WOVubrgXIRzgNhrEtHx//WiNnrTikG
         N+Hff4uUNhzjA==
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
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v3 11/13] rust: init: make `PinInit<T, E>` a supertrait of `Init<T, E>`
Message-ID: <20230729090838.225225-12-benno.lossin@proton.me>
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

Remove the blanket implementation of `PinInit<T, E> for I where I:
Init<T, E>`. This blanket implementation prevented custom types that
implement `PinInit`.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v2 -> v3:
- add blank missing line,
- added Reviewed-by's from Martin and Alice.

 rust/kernel/init.rs            | 21 ++++++++-------------
 rust/kernel/init/__internal.rs | 12 ++++++++++++
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 06ecab4901f2..040dc9a5f9fd 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -807,7 +807,7 @@ pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: =
Sized {
 ///
 /// [`Arc<T>`]: crate::sync::Arc
 #[must_use =3D "An initializer must be used in order to create its value."=
]
-pub unsafe trait Init<T: ?Sized, E =3D Infallible>: Sized {
+pub unsafe trait Init<T: ?Sized, E =3D Infallible>: PinInit<T, E> {
     /// Initializes `slot`.
     ///
     /// # Safety
@@ -818,18 +818,6 @@ pub unsafe trait Init<T: ?Sized, E =3D Infallible>: Si=
zed {
     unsafe fn __init(self, slot: *mut T) -> Result<(), E>;
 }
=20
-// SAFETY: Every in-place initializer can also be used as a pin-initialize=
r.
-unsafe impl<T: ?Sized, E, I> PinInit<T, E> for I
-where
-    I: Init<T, E>,
-{
-    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
-        // SAFETY: `__init` meets the same requirements as `__pinned_init`=
, except that it does not
-        // require `slot` to not move after init.
-        unsafe { self.__init(slot) }
-    }
-}
-
 /// Creates a new [`PinInit<T, E>`] from the given closure.
 ///
 /// # Safety
@@ -971,6 +959,13 @@ unsafe fn __init(self, slot: *mut T) -> Result<(), E> =
{
     }
 }
=20
+// SAFETY: Every type can be initialized by-value. `__pinned_init` calls `=
__init`.
+unsafe impl<T, E> PinInit<T, E> for T {
+    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
+        unsafe { self.__init(slot) }
+    }
+}
+
 /// Smart pointer that can initialize memory in-place.
 pub trait InPlaceInit<T>: Sized {
     /// Use the given pin-initializer to pin-initialize a `T` inside of a =
new smart pointer of this
diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.r=
s
index 7abd1fb65e41..12e195061525 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -32,6 +32,18 @@ unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
     }
 }
=20
+// SAFETY: While constructing the `InitClosure`, the user promised that it=
 upholds the
+// `__pinned_init` invariants.
+unsafe impl<T: ?Sized, F, E> PinInit<T, E> for InitClosure<F, T, E>
+where
+    F: FnOnce(*mut T) -> Result<(), E>,
+{
+    #[inline]
+    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
+        (self.0)(slot)
+    }
+}
+
 /// This trait is only implemented via the `#[pin_data]` proc-macro. It is=
 used to facilitate
 /// the pin projections within the initializers.
 ///
--=20
2.41.0


