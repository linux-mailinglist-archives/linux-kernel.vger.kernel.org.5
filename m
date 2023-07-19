Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5C75980F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGSOVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGSOV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:21:28 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E10F2122;
        Wed, 19 Jul 2023 07:21:01 -0700 (PDT)
Date:   Wed, 19 Jul 2023 14:20:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=r5yynngpuvbuthttlghkc7g77y.protonmail; t=1689776458; x=1690035658;
        bh=ssgVP+xm/xUxRo5NGKU6FQiwAj0frSX0JCoESMRG9+4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=g+vfPcqM0arg3Xzi+IPsZG7G/BF/jKT9SNSx+ctTlu2zdhzxFxxhOAGG0pLGfFEPY
         10fLtiyor6Ot2+c+USFvHRwDiNqwalSOlAI+X3jUMXn3uuSbfushJedmjJNmqS1dj/
         XuwFeMSa//FBPmn1psngv0glJ9+r2I2lIYYU6aOcpsv7g2T9BlhUzl7tsor77HP5Y2
         tVR4tv22Gkc/bnJbkrilMGfm1N5S0l2SufWT2aDkfNesWLsSZNMnDycmknTkeym24l
         r4OVWO8ejG6ipRs+I54mIwWe17uF7EQg8xMYncAq1oQ1FOyna0jIllEyMfO5fl6e4H
         ZtO/KzbmaxBwQ==
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
Subject: [PATCH v2 05/12] rust: init: make initializer values inaccessible after initializing
Message-ID: <20230719141918.543938-6-benno.lossin@proton.me>
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

Previously the init macros would create a local variable with the name
and hygiene of the field that is being initialized to store the value of
the field. This would override any user defined variables. For example:
```
struct Foo {
    a: usize,
    b: usize,
}
let a =3D 10;
let foo =3D init!(Foo{
    a: a + 1, // This creates a local variable named `a`.
    b: a, // This refers to that variable!
});
let foo =3D Box::init!(foo)?;
assert_eq!(foo.a, 11);
assert_eq!(foo.b, 11);
```

This patch changes this behavior, so the above code would panic at the
last assertion, since `b` would have value 10.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/init/macros.rs | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index 160b95fc03c9..5de939e0801f 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -1073,13 +1073,13 @@ macro_rules! __init_internal {
         // In-place initialization syntax.
         @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
     ) =3D> {
-        let $field =3D $val;
+        let init =3D $val;
         // Call the initializer.
         //
         // SAFETY: `slot` is valid, because we are inside of an initialize=
r closure, we
         // return when an error/panic occurs.
         // We also use the `data` to require the correct trait (`Init` or =
`PinInit`) for `$field`.
-        unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), =
$field)? };
+        unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), =
init)? };
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
@@ -1105,12 +1105,12 @@ macro_rules! __init_internal {
         // In-place initialization syntax.
         @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
     ) =3D> {
-        let $field =3D $val;
+        let init =3D $val;
         // Call the initializer.
         //
         // SAFETY: `slot` is valid, because we are inside of an initialize=
r closure, we
         // return when an error/panic occurs.
-        unsafe { $crate::init::Init::__init($field, ::core::ptr::addr_of_m=
ut!((*$slot).$field))? };
+        unsafe { $crate::init::Init::__init(init, ::core::ptr::addr_of_mut=
!((*$slot).$field))? };
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
@@ -1136,11 +1136,13 @@ macro_rules! __init_internal {
         // Init by-value.
         @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
     ) =3D> {
-        $(let $field =3D $val;)?
-        // Initialize the field.
-        //
-        // SAFETY: The memory at `slot` is uninitialized.
-        unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$fi=
eld), $field) };
+        {
+            $(let $field =3D $val;)?
+            // Initialize the field.
+            //
+            // SAFETY: The memory at `slot` is uninitialized.
+            unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot)=
.$field), $field) };
+        }
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
--=20
2.41.0


