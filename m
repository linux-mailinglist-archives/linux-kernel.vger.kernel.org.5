Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E7E759812
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjGSOVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjGSOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:21:48 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEF519A3;
        Wed, 19 Jul 2023 07:21:22 -0700 (PDT)
Date:   Wed, 19 Jul 2023 14:21:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1689776469; x=1690035669;
        bh=ycSUa09BWmPYG+p0T3v8MXq1UGIxA3oXkswxIya2goA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Hp0gqBpu5Kg0lTyFWlOUxr4CFlT3YRUF3s6qV9d9wWK/qCU6Myt8GwZT33ypBSzwr
         ObLAaGrCb5pyVC4sZP4dDzVQ2xDgRuV8aoiFTfnNYJtdyTpUxUlK092JCDkZaprUCQ
         SfkSLTY8juIJkd6chETk2t54ejpvmenxydWJKtB+8DWFcUBG7MS1eZ2YV2UzcoehUJ
         Iwu2LD9ZycYtUouWT6KEvAhhdB8SHfjRQmVJa4rw3qmThKvHfBk4P8zPdPmF/58OJ4
         eDQ+7Fv5minHxoZPSKEOohDsQ/sncyXOewAsZ1xjPXw86/64mGl/Fobzesg8qiWvSq
         ++0ATtS+WotfQ==
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
Subject: [PATCH v2 09/12] rust: init: implement Zeroable for Opaque<T>
Message-ID: <20230719141918.543938-10-benno.lossin@proton.me>
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

Since `Opaque<T>` contains a `MaybeUninit<T>`, all bytes zero is a valid
bit pattern for that type.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/types.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index d849e1979ac7..f0f540578d0f 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -11,6 +11,7 @@
     ops::{Deref, DerefMut},
     ptr::NonNull,
 };
+use macros::Zeroable;
=20
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///
@@ -251,6 +252,7 @@ fn drop(&mut self) {
 ///
 /// This is meant to be used with FFI objects that are never interpreted b=
y Rust code.
 #[repr(transparent)]
+#[derive(Zeroable)]
 pub struct Opaque<T> {
     value: UnsafeCell<MaybeUninit<T>>,
     _pin: PhantomPinned,
--=20
2.41.0


