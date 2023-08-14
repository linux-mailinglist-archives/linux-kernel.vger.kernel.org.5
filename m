Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809EE77B49F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjHNIss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjHNIsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:48:15 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A66BB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:48:00 -0700 (PDT)
Date:   Mon, 14 Aug 2023 08:47:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1692002878; x=1692262078;
        bh=kwnI5+l3SlcIXt3YVOWTO7NQq0uMh4+BFKhqIK/WWV4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=WfvQxVkNyUpKJJPJeXtyGEsl3PEPcbjPmZ8VluT61s46kQCr3Xt9ftuIQDW/MExjb
         7W1lqo3DojXVv/la0jVGx/X0G5OL0YcXLGQpEMEo0Qtyfy016ghhJBO6JRVMsoiIOY
         9AIHL0zxiESNlq9BQdAQl0jmExBQagTMNNKIDeNl25iJBAWBEOMOwhforqTWTDGTnW
         TETwDZ+HLzwFDhjXMLi1sFvPyIOAyncw4v2zhqHoG1bwAHbGhSNiS+tqfe97UfFEFG
         /t4SZm36ff/LfJzsXk2Ud5KLsnDPJzp47y4sLgiv1RspkzIP42uDHRyNec4CfJ7ULv
         XkixB7uXama/A==
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
        patches@lists.linux.dev,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v4 11/13] rust: init: make `PinInit<T, E>` a supertrait of `Init<T, E>`
Message-ID: <20230814084602.25699-12-benno.lossin@proton.me>
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

Remove the blanket implementation of `PinInit<T, E> for I where I:
Init<T, E>`. This blanket implementation prevented custom types that
implement `PinInit`.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v3 -> v4:
- added Reviewed-by from Gary.

v2 -> v3:
- add blank missing line,
- added Reviewed-by's from Martin and Alice.

 rust/kernel/init.rs            | 21 ++++++++-------------
 rust/kernel/init/__internal.rs | 12 ++++++++++++
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index f91ecd3b1edf..a15fb5ddbc7d 100644
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
@@ -972,6 +960,13 @@ unsafe fn __init(self, slot: *mut T) -> Result<(), E> =
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


