Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE99F767D7E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjG2JLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjG2JLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:11:20 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D689B44BC
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 02:10:37 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:10:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1690621832; x=1690881032;
        bh=3zNIMZmZNDCpyXxxyP7KXlpj+oRhkgVcL+Ru9AKEqMQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=chbVs6fHFDVnXKLqa/IdGHFF5wg9kxo0llJBCweB/b7pRciP4kY9xe5QSS3DJ97WN
         uuwVujcl8aAnoN7sMarSEODG0XBsxPWGk9vkwzEf1TDMbgU3t0UkktB6ubMvudcaR3
         BF98jn3lt4nCyIhWqxzhgqIWflFdHbSk1MQNDtq43mkoW3FgD+CFxTTmkmL/3nJqwZ
         2dIBXYQJrjoe4V9Pv99c2YkGP75+1+LdHEUcsqT4XLwp18HuOtsubnoibAjy5VKiLb
         pZHaZwjcpy1ndewgQ6f1t361S+Hu83O7O2ERAQxw0mnZsFJnRg+CvcW2VwMXcrVKNE
         zzLMZTVZagUSQ==
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
Subject: [PATCH v3 10/13] rust: init: implement `Zeroable` for `UnsafeCell<T>` and `Opaque<T>`
Message-ID: <20230729090838.225225-11-benno.lossin@proton.me>
In-Reply-To: <20230729090838.225225-1-benno.lossin@proton.me>
References: <20230729090838.225225-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v2 -> v3:
- also implement Zeroable for `UnsafeCell<T>` when `T: Zeroable`,
- use `impl_zeroable!` instead of `derive(Zeroable)`.

 rust/kernel/init.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index af96d4acc26b..06ecab4901f2 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -212,10 +212,12 @@
 use crate::{
     error::{self, Error},
     sync::UniqueArc,
+    types::Opaque,
 };
 use alloc::boxed::Box;
 use core::{
     alloc::AllocError,
+    cell::UnsafeCell,
     convert::Infallible,
     marker::PhantomData,
     mem::MaybeUninit,
@@ -1157,6 +1159,11 @@ macro_rules! impl_zeroable {
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


