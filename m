Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5F7759818
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjGSOWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjGSOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:22:13 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01B5198D;
        Wed, 19 Jul 2023 07:21:54 -0700 (PDT)
Date:   Wed, 19 Jul 2023 14:21:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1689776494; x=1690035694;
        bh=PY3Ej/DIQyjr1nZd2KtYmX46DbaLv5+ISgZDgCfGk58=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=JbZ3uC2P97beRJVTZB8zzWyQWqTrD2X3DqO614uvYpMuDtjxTr8BcSXwvtmuhFBe6
         C7yftw8MTtWqDeWbJA+4c5RRhAxTYBJBRKv8bo8z05YKe/gqdOKV+TKqA4duvrxZIn
         wcC9LKyrbxSxp8GlSIHztsAgFe51qHjkWNc51k1AS9SUQduqUH4bDCEyqvX0r0qHn3
         BpTfDawsATp14Zoz5DH5WH9XkeUOTkkZdyXX59ofNUgelkkhVs9nen57LuxEfgYHx/
         9N0PZbP76v0NSO8drATOMc1SxQnzzngSkeYBtqoEWsV3DZlgaoqkXiEMWEwFgJLER2
         6vJwO4xk9yv0A==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/12] rust: init: make `PinInit<T, E>` a supertrait of `Init<T, E>`
Message-ID: <20230719141918.543938-11-benno.lossin@proton.me>
In-Reply-To: <20230719141918.543938-1-benno.lossin@proton.me>
References: <20230719141918.543938-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the blanket implementation of `PinInit<T, E> for I where I:
Init<T, E>`. This blanket implementation prevented custom types that
implement `PinInit`.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/init.rs            | 20 +++++++-------------
 rust/kernel/init/__internal.rs | 12 ++++++++++++
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index fa1ebdbf5f4b..3c7cd36a424b 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -805,7 +805,7 @@ pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: =
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
@@ -816,18 +816,6 @@ pub unsafe trait Init<T: ?Sized, E =3D Infallible>: Si=
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
@@ -968,6 +956,12 @@ unsafe fn __init(self, slot: *mut T) -> Result<(), E> =
{
         Ok(())
     }
 }
+// SAFETY: Every type can be initialized by-value. `__pinned_init` calls `=
__init`.
+unsafe impl<T, E> PinInit<T, E> for T {
+    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
+        unsafe { self.__init(slot) }
+    }
+}
=20
 /// Smart pointer that can initialize memory in-place.
 pub trait InPlaceInit<T>: Sized {
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


