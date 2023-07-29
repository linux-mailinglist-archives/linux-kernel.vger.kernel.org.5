Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E9D767D79
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjG2JKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjG2JKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:10:31 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD7449C4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 02:10:03 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:09:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1690621802; x=1690881002;
        bh=rixSAlF8H68fR6m3THBV7cCNL7So1w86OXDiq2xYBjU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=fnB7DKQrA5Mk3rcM0qdH1bUwWWwZruoJbh//pq9ObBMiIuInGNNV8FSd6v4xXHd6Z
         eBJ8TiauGbt8+31hQ3QoQ4JHTlkaaW9jl4S7EYP6FyrdW2wF6YFPFlEN2cUxt82UP3
         5qF43KJejvkdGm5PTJ/fF3eQsjH4LrYxXW3FYBTe9isFjDp/E3SuvmKGEPbIUkocf0
         Q+Haw7xBMFQ8sy0zpMg+NIiVNOO+2IJ1plEaaZtZB8OEGBH+r+OdwO7EoV8EhsexrD
         UPZ7X097/SV6kA4GbIurWboVWrBdHSy36+FRBLCVOV/XPPOhsdeNGcyaSOCqnyQUGf
         RAEFQxJXWLkyg==
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
Subject: [PATCH v3 06/13] rust: init: make initializer values inaccessible after initializing
Message-ID: <20230729090838.225225-7-benno.lossin@proton.me>
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

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v2 -> v3:
- added Reviewed-by's from Martin and Alice.

 rust/kernel/init/macros.rs | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index 2bad086cda0a..cfeacc4b3f7d 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -1075,13 +1075,13 @@ macro_rules! __init_internal {
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
@@ -1107,12 +1107,12 @@ macro_rules! __init_internal {
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
@@ -1138,11 +1138,13 @@ macro_rules! __init_internal {
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


