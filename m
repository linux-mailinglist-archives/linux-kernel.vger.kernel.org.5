Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6FA77B490
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjHNIrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjHNIqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:46:48 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E36510C1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:46:46 -0700 (PDT)
Date:   Mon, 14 Aug 2023 08:46:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=rayheo6bwfb25jkb4mklfbwy2m.protonmail; t=1692002804; x=1692262004;
        bh=bMYBy/yxUzYNLePNMMjA4ZSmmlU+epSTw1cc5ylrenA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=MzE73qw+hMEoBUfH8OMzukx5yOplVWu6U1j0jSdZwHWnYoYdMjonRcqbiPMbfyYGZ
         zDW0DsdwwGuzMoZNDdrhjAZrQmhGZdX3TuakGyGiPA941Fp3z5hxbwL8q750+NgZUb
         kOHVd+VGE9BYn7FRXYQN2GIhihuzHiNRX9vQoWp3uipYnecmX473MkCOcw/nvEKDoj
         +Y5jRB5IWEOYnBAEAR7jHIJyXRVrBFO4BDK23G2fz1GhG/WgvW0You56RSMffk4FRu
         +OD4OajI5bv+phpUTRIA2/rYNtTzgyb8PPrm7/M3kOkcuP/FnjlfwPiT5/2meTHQd7
         ewTgdvID3CYeA==
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
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: [PATCH v4 03/13] rust: add derive macro for `Zeroable`
Message-ID: <20230814084602.25699-4-benno.lossin@proton.me>
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

Add a derive proc-macro for the `Zeroable` trait. The macro supports
structs where every field implements the `Zeroable` trait. This way
`unsafe` implementations can be avoided.

The macro is split into two parts:
- a proc-macro to parse generics into impl and ty generics,
- a declarative macro that expands to the impl block.

Suggested-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v3 -> v4:
- add support for `+` in `quote!`.

v2 -> v3:
- change derive behavior, instead of adding `Zeroable` bounds for every
  field, add them only for generic type parameters,
- still check that every field implements `Zeroable`,
- removed Reviewed-by's due to changes.

v1 -> v2:
- fix Zeroable path,
- add Reviewed-by from Gary and Bj=C3=B6rn.

 rust/kernel/init/macros.rs | 35 ++++++++++++++++++
 rust/kernel/prelude.rs     |  2 +-
 rust/macros/lib.rs         | 20 +++++++++++
 rust/macros/quote.rs       | 12 +++++++
 rust/macros/zeroable.rs    | 72 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 rust/macros/zeroable.rs

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index 9182fdf99e7e..78091756dec0 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -1215,3 +1215,38 @@ macro_rules! __init_internal {
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
+            $($($whr)*)?
+        {}
+        const _: () =3D {
+            fn assert_zeroable<T: ?::core::marker::Sized + $crate::init::Z=
eroable>() {}
+            fn ensure_zeroable<$($impl_generics)*>()
+                where $($($whr)*)?
+            {
+                $(assert_zeroable::<$field_ty>();)*
+            }
+        };
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
index dddbb4e6f4cb..33a199e4f176 100644
--- a/rust/macros/quote.rs
+++ b/rust/macros/quote.rs
@@ -124,6 +124,18 @@ macro_rules! quote_spanned {
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
+    (@proc $v:ident $span:ident + $($tt:tt)*) =3D> {
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new('+', ::proc_macro::Spacing::Alone=
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
index 000000000000..0d605c46ab3b
--- /dev/null
+++ b/rust/macros/zeroable.rs
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use crate::helpers::{parse_generics, Generics};
+use proc_macro::{TokenStream, TokenTree};
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
+    // Now we insert `Zeroable` as a bound for every generic parameter in =
`impl_generics`.
+    let mut new_impl_generics =3D Vec::with_capacity(impl_generics.len());
+    // Are we inside of a generic where we want to add `Zeroable`?
+    let mut in_generic =3D !impl_generics.is_empty();
+    // Have we already inserted `Zeroable`?
+    let mut inserted =3D false;
+    // Level of `<>` nestings.
+    let mut nested =3D 0;
+    for tt in impl_generics {
+        match &tt {
+            // If we find a `,`, then we have finished a generic/constant/=
lifetime parameter.
+            TokenTree::Punct(p) if nested =3D=3D 0 && p.as_char() =3D=3D '=
,' =3D> {
+                if in_generic && !inserted {
+                    new_impl_generics.extend(quote! { : ::kernel::init::Ze=
roable });
+                }
+                in_generic =3D true;
+                inserted =3D false;
+                new_impl_generics.push(tt);
+            }
+            // If we find `'`, then we are entering a lifetime.
+            TokenTree::Punct(p) if nested =3D=3D 0 && p.as_char() =3D=3D '=
\'' =3D> {
+                in_generic =3D false;
+                new_impl_generics.push(tt);
+            }
+            TokenTree::Punct(p) if nested =3D=3D 0 && p.as_char() =3D=3D '=
:' =3D> {
+                new_impl_generics.push(tt);
+                if in_generic {
+                    new_impl_generics.extend(quote! { ::kernel::init::Zero=
able + });
+                    inserted =3D true;
+                }
+            }
+            TokenTree::Punct(p) if p.as_char() =3D=3D '<' =3D> {
+                nested +=3D 1;
+                new_impl_generics.push(tt);
+            }
+            TokenTree::Punct(p) if p.as_char() =3D=3D '>' =3D> {
+                assert!(nested > 0);
+                nested -=3D 1;
+                new_impl_generics.push(tt);
+            }
+            _ =3D> new_impl_generics.push(tt),
+        }
+    }
+    assert_eq!(nested, 0);
+    if in_generic && !inserted {
+        new_impl_generics.extend(quote! { : ::kernel::init::Zeroable });
+    }
+    quote! {
+        ::kernel::__derive_zeroable!(
+            parse_input:
+                @sig(#(#rest)*),
+                @impl_generics(#(#new_impl_generics)*),
+                @ty_generics(#(#ty_generics)*),
+                @body(#last),
+        );
+    }
+}
--=20
2.41.0


