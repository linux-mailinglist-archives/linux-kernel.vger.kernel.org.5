Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7894759809
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGSOUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjGSOUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:20:37 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF51A1724
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:20:29 -0700 (PDT)
Date:   Wed, 19 Jul 2023 14:20:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1689776427; x=1690035627;
        bh=183b5PAZnhFCxp/oOLo9nlLEFrHHHEv1Gt8/V3juWA8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ZkWznvewtTc2Zfd3W9Yvv2Bupu9uWWK5mPAieCwdpT0tqsvRT3KXVvtCpyLAO7ZR+
         6+UWtIFCcjsAAzWicXpOaGb8xE7Ww6gFXFeiXYLopba2JdIeb3LaAjUwGGb/8835ch
         6039ckKVp4EyDHKBC+SEf1q6NqCfQ3YqjbPgWmKiTZ2iVthcxecakVZVYeuROeqMqW
         NXeKiDd+fYLKUYoVx45rnH8MGjtNkAVI3Q7yU6XYN/r+pRQocdATKzA1rJk11mTsbc
         v2WAlt0bzKpD3urZQ+ZW/vDPQJpYLYAXZQGOTUxXpvd+2adqcMjSku2ZJwL3zR5VZu
         yj4vsYo9NjI1A==
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
Subject: [PATCH v2 02/12] rust: add derive macro for `Zeroable`
Message-ID: <20230719141918.543938-3-benno.lossin@proton.me>
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

Add a derive proc-macro for the `Zeroable` trait. The macro supports
structs where every field implements the `Zeroable` trait. This way
`unsafe` implementations can be avoided.

The macro is split into two parts:
- a proc-macro to parse generics into impl and ty generics,
- a declarative macro that expands to the impl block.

Suggested-by: Asahi Lina <lina@asahilina.net>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v1 -> v2:
* fix Zeroable path
* add Reviewed-by from Gary and Bj=C3=B6rn

 rust/kernel/init/macros.rs | 28 ++++++++++++++++++++++++++++
 rust/kernel/prelude.rs     |  2 +-
 rust/macros/lib.rs         | 20 ++++++++++++++++++++
 rust/macros/quote.rs       |  6 ++++++
 rust/macros/zeroable.rs    | 25 +++++++++++++++++++++++++
 5 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 rust/macros/zeroable.rs

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index fbaebd34f218..c50429173fc7 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -1213,3 +1213,31 @@ macro_rules! __init_internal {
         );
     };
 }
+
+#[doc(hidden)]
+#[macro_export]
+macro_rules! __derive_zeroable {
+    (parse_input:
+        @sig(
+            $(#[$($struct_attr:tt)*])*
+            $vis:vis struct $name:ident
+            $(where $($whr:tt)*)?
+        ),
+        @impl_generics($($impl_generics:tt)*),
+        @ty_generics($($ty_generics:tt)*),
+        @body({
+            $(
+                $(#[$($field_attr:tt)*])*
+                $field:ident : $field_ty:ty
+            ),* $(,)?
+        }),
+    ) =3D> {
+        // SAFETY: every field type implements `Zeroable` and padding byte=
s may be zero.
+        #[automatically_derived]
+        unsafe impl<$($impl_generics)*> $crate::init::Zeroable for $name<$=
($ty_generics)*>
+        where
+            $($field_ty: $crate::init::Zeroable,)*
+            $($($whr)*)?
+        {}
+    };
+}
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index c28587d68ebc..ae21600970b3 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -18,7 +18,7 @@
 pub use alloc::{boxed::Box, vec::Vec};
=20
 #[doc(no_inline)]
-pub use macros::{module, pin_data, pinned_drop, vtable};
+pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
=20
 pub use super::build_assert;
=20
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index b4bc44c27bd4..fd7a815e68a8 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -11,6 +11,7 @@
 mod pin_data;
 mod pinned_drop;
 mod vtable;
+mod zeroable;
=20
 use proc_macro::TokenStream;
=20
@@ -343,3 +344,22 @@ pub fn paste(input: TokenStream) -> TokenStream {
     paste::expand(&mut tokens);
     tokens.into_iter().collect()
 }
+
+/// Derives the [`Zeroable`] trait for the given struct.
+///
+/// This can only be used for structs where every field implements the [`Z=
eroable`] trait.
+///
+/// # Examples
+///
+/// ```rust
+/// #[derive(Zeroable)]
+/// pub struct DriverData {
+///     id: i64,
+///     buf_ptr: *mut u8,
+///     len: usize,
+/// }
+/// ```
+#[proc_macro_derive(Zeroable)]
+pub fn derive_zeroable(input: TokenStream) -> TokenStream {
+    zeroable::derive(input)
+}
diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
index dddbb4e6f4cb..b76c198a4ed5 100644
--- a/rust/macros/quote.rs
+++ b/rust/macros/quote.rs
@@ -124,6 +124,12 @@ macro_rules! quote_spanned {
         ));
         quote_spanned!(@proc $v $span $($tt)*);
     };
+    (@proc $v:ident $span:ident ; $($tt:tt)*) =3D> {
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new(';', ::proc_macro::Spacing::Alone=
)
+        ));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
     (@proc $v:ident $span:ident $id:ident $($tt:tt)*) =3D> {
         $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new(st=
ringify!($id), $span)));
         quote_spanned!(@proc $v $span $($tt)*);
diff --git a/rust/macros/zeroable.rs b/rust/macros/zeroable.rs
new file mode 100644
index 000000000000..cddb866c44ef
--- /dev/null
+++ b/rust/macros/zeroable.rs
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use crate::helpers::{parse_generics, Generics};
+use proc_macro::TokenStream;
+
+pub(crate) fn derive(input: TokenStream) -> TokenStream {
+    let (
+        Generics {
+            impl_generics,
+            ty_generics,
+        },
+        mut rest,
+    ) =3D parse_generics(input);
+    // This should be the body of the struct `{...}`.
+    let last =3D rest.pop();
+    quote! {
+        ::kernel::__derive_zeroable!(
+            parse_input:
+                @sig(#(#rest)*),
+                @impl_generics(#(#impl_generics)*),
+                @ty_generics(#(#ty_generics)*),
+                @body(#last),
+        );
+    }
+}
--=20
2.41.0


