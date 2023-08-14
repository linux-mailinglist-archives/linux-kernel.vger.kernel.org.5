Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2073D77B49D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbjHNIse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjHNIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:47:57 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C9E1737;
        Mon, 14 Aug 2023 01:47:51 -0700 (PDT)
Date:   Mon, 14 Aug 2023 08:47:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1692002870; x=1692262070;
        bh=RmXK6p609GEJrLnFk9jfesnOhQMMA5F6nnV0NJXuXV4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=BtvXsbftFR8N1LTgE1UOZEG9t4qE9EuuVvtX+vYczOwYQTDCI6do7dB9Oe+P+mXvC
         vO0kWckuR+N7GqoP1Mg1O2VQ4DL2GP6nmCsdCdiprbCXpVa6Ye7ySV0wRp216IV3TK
         5vr/VEITqjSoZSiuxuvzygMTNeH5nDNVpkS4dBuuRf15eGe+vpTcNi6iF1HvltYKBw
         Rdbq5L3pndnFSRvAsvD8gA0FYBfhXin9XUlaV2f8RfixAcdl2OXBrBrjWFRoCpSteq
         3eKTzrZ/Nh+Ffvxz30ouhZQUijNWuR9lSNqnyvsKOPx5UF2g7jfF3/0EhabGZXN6E0
         UzN7Us8ciVtTw==
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
Subject: [PATCH v4 10/13] rust: init: implement `Zeroable` for `UnsafeCell<T>` and `Opaque<T>`
Message-ID: <20230814084602.25699-11-benno.lossin@proton.me>
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

`UnsafeCell<T>` and `T` have the same layout so if `T` is `Zeroable`
then so should `UnsafeCell<T>` be. This allows using the derive macro
for `Zeroable` on types that contain an `UnsafeCell<T>`.
Since `Opaque<T>` contains a `MaybeUninit<T>`, all bytes zero is a valid
bit pattern for that type.

Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v3 -> v4:
- added Reviewed-by's from Gary and Martin.

v2 -> v3:
- also implement Zeroable for `UnsafeCell<T>` when `T: Zeroable`,
- use `impl_zeroable!` instead of `derive(Zeroable)`.

 rust/kernel/init.rs | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index b54f32017d00..f91ecd3b1edf 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -212,11 +212,12 @@
 use crate::{
     error::{self, Error},
     sync::UniqueArc,
-    types::ScopeGuard,
+    types::{Opaque, ScopeGuard},
 };
 use alloc::boxed::Box;
 use core::{
     alloc::AllocError,
+    cell::UnsafeCell,
     convert::Infallible,
     marker::PhantomData,
     mem::MaybeUninit,
@@ -1159,6 +1160,11 @@ macro_rules! impl_zeroable {
=20
     // SAFETY: Type is allowed to take any value, including all zeros.
     {<T>} MaybeUninit<T>,
+    // SAFETY: Type is allowed to take any value, including all zeros.
+    {<T>} Opaque<T>,
+
+    // SAFETY: `T: Zeroable` and `UnsafeCell` is `repr(transparent)`.
+    {<T: ?Sized + Zeroable>} UnsafeCell<T>,
=20
     // SAFETY: All zeros is equivalent to `None` (option layout optimizati=
on guarantee).
     Option<NonZeroU8>, Option<NonZeroU16>, Option<NonZeroU32>, Option<NonZ=
eroU64>,
--=20
2.41.0


