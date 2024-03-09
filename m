Return-Path: <linux-kernel+bounces-97943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF3C877205
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9FF1F215AE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB345950;
	Sat,  9 Mar 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WogB6urj"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41C2030B;
	Sat,  9 Mar 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709999627; cv=none; b=masleVDo+F+Yp0hsGUE/U2x47P3uuQ+QZ31N7n33aTww2nEN68L6HNhNw019gpZXg61tQEiC8G+agUMQNoHgO/AQacPb8ZPCWXxjXkfObUHPW5CmhMJ0EppsM06qONTCf5zUUS33AA2/+yFoFTBaL2EFX23TH0LSuz+vKV/di78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709999627; c=relaxed/simple;
	bh=3CWLLoC/YK8LKfOW3IASZsYK5Z1CRArxJnF9ZinGRPI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UV8O2fc/odsi+u4W7I5MHZ2s/gz26X8CIxBlu52NNZFlkntMsOYyRhhnq7RGyk9bsOjFmKDsZVv2K1ZSPYH17HOkdR09zxbKzDdVfHoR3QSoUR2ikYUXbRDP0en6B8nwprHoW+pmXwtOMNw0b9WTLaDS4jwwPVODytQlVbUUG2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WogB6urj; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1709999621; x=1710258821;
	bh=RRl9FSGDDeIIww7fc1iAFlaDT0CLV1heSPjT5dnAYEw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WogB6urjQ2N5fE3JjlfUhYh+AoEUfBCHZI4I0qlNBXXCJcAkzd7Ya9i0AGsv6DXfw
	 uaaSuZIMziNLoY3EQn9VtnEnIKHUNjJJ2xx2e/6LbJQzi9TBl1BPTFn1R5dlitqJ8h
	 hxHXta9qEuhnlZ8I2uUAplUZGjKHbOW6E7vceaEhl3+QORP77pyFu8SzXYiSXEP5lY
	 wvA/RxM9iNwa6ARMPPM0KVW/Crq5HeQTzfJCgoyjlsxUFqaNcxwJxPjJDjYlRu62cX
	 7KmACwYNuT8n59/+X4BTfpmRLYtMNVYVGUDoCC9J5Mh3XMSx+GHOl+VuMx238pY9HX
	 YYIeyXDjATr1A==
Date: Sat, 09 Mar 2024 15:53:25 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] rust: macros: add `decl_generics` to `parse_generics()`
Message-ID: <20240309155243.482334-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The generic parameters on a type definition can specify default values.
Currently `parse_generics()` cannot handle this though. For example when
parsing the following generics:

    <T: Clone, const N: usize =3D 0>

The `impl_generics` will be set to `T: Clone, const N: usize =3D 0` and
`ty_generics` will be set to `T, N`. Now using the `impl_generics` on an
impl block:

    impl<$($impl_generics)*> Foo {}

will result in invalid Rust code, because default values are only
available on type definitions.

Therefore add parsing support for generic parameter default values using
a new kind of generics called `decl_generics` and change the old
behavior of `impl_generics` to not contain the generic parameter default
values.

Now `Generics` has three fields:
- `impl_generics`: the generics with bounds
  (e.g. `T: Clone, const N: usize`)
- `decl_generics`: the generics with bounds and default values
  (e.g. `T: Clone, const N: usize =3D 0`)
- `ty_generics`:  contains the generics without bounds and without
  default values (e.g. `T, N`)

`impl_generics` is designed to be used on `impl<$impl_generics>`,
`decl_generics` for the type definition, so `struct Foo<$decl_generics>`
and `ty_generics` whenever you use the type, so `Foo<$ty_generics>`.

Here is an example that uses all three different types of generics:

    let (Generics { decl_generics, impl_generics, ty_generics }, rest) =3D =
parse_generics(input);
    quote! {
        struct Foo<$($decl_generics)*> {
            // ...
        }

        impl<$impl_generics> Foo<$ty_generics> {
            fn foo() {
                // ...
            }
        }
    }

The next commit contains a fix to the `#[pin_data]` macro making it
compatible with generic parameter default values by relying on this new
behavior.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v2 -> v3:
- addressed Gary's nits
- add #[allow(dead_code)] to remove warning
- rebase onto rust-next

v1 -> v2:
- improve documentation and commit message explanation
- add motivation to commit message


v1: https://lore.kernel.org/rust-for-linux/20231125125024.1235933-1-benno.l=
ossin@proton.me/
v2: https://lore.kernel.org/rust-for-linux/20231213220447.3613500-1-benno.l=
ossin@proton.me/

 rust/macros/helpers.rs  | 123 ++++++++++++++++++++++++++++++----------
 rust/macros/pin_data.rs |   1 +
 rust/macros/zeroable.rs |   1 +
 3 files changed, 95 insertions(+), 30 deletions(-)

diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index afb0f2e3a36a..2497d6519f2f 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
=20
-use proc_macro::{token_stream, Group, Punct, Spacing, TokenStream, TokenTr=
ee};
+use proc_macro::{token_stream, Group, TokenStream, TokenTree};
=20
 pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<String>=
 {
     if let Some(TokenTree::Ident(ident)) =3D it.next() {
@@ -70,8 +70,41 @@ pub(crate) fn expect_end(it: &mut token_stream::IntoIter=
) {
     }
 }
=20
+/// Parsed generics.
+///
+/// See the field documentation for an explanation what each of the fields=
 represents.
+///
+/// # Examples
+///
+/// ```rust,ignore
+/// # let input =3D todo!();
+/// let (Generics { decl_generics, impl_generics, ty_generics }, rest) =3D=
 parse_generics(input);
+/// quote! {
+///     struct Foo<$($decl_generics)*> {
+///         // ...
+///     }
+///
+///     impl<$impl_generics> Foo<$ty_generics> {
+///         fn foo() {
+///             // ...
+///         }
+///     }
+/// }
+/// ```
 pub(crate) struct Generics {
+    /// The generics with bounds and default values (e.g. `T: Clone, const=
 N: usize =3D 0`).
+    ///
+    /// Use this on type definitions e.g. `struct Foo<$decl_generics> ...`=
 (or `union`/`enum`).
+    #[allow(dead_code)]
+    pub(crate) decl_generics: Vec<TokenTree>,
+    /// The generics with bounds (e.g. `T: Clone, const N: usize`).
+    ///
+    /// Use this on `impl` blocks e.g. `impl<$impl_generics> Trait for ...=
`.
     pub(crate) impl_generics: Vec<TokenTree>,
+    /// The generics without bounds and without default values (e.g. `T, N=
`).
+    ///
+    /// Use this when you use the type that is declared with these generic=
s e.g.
+    /// `Foo<$ty_generics>`.
     pub(crate) ty_generics: Vec<TokenTree>,
 }
=20
@@ -79,6 +112,8 @@ pub(crate) struct Generics {
 ///
 /// The generics are not present in the rest, but a where clause might rem=
ain.
 pub(crate) fn parse_generics(input: TokenStream) -> (Generics, Vec<TokenTr=
ee>) {
+    // The generics with bounds and default values.
+    let mut decl_generics =3D vec![];
     // `impl_generics`, the declared generics with their bounds.
     let mut impl_generics =3D vec![];
     // Only the names of the generics, without any bounds.
@@ -90,10 +125,17 @@ pub(crate) fn parse_generics(input: TokenStream) -> (G=
enerics, Vec<TokenTree>) {
     let mut toks =3D input.into_iter();
     // If we are at the beginning of a generic parameter.
     let mut at_start =3D true;
-    for tt in &mut toks {
+    let mut skip_until_comma =3D false;
+    while let Some(tt) =3D toks.next() {
+        if nesting =3D=3D 1 && matches!(&tt, TokenTree::Punct(p) if p.as_c=
har() =3D=3D '>') {
+            // Found the end of the generics.
+            break;
+        } else if nesting >=3D 1 {
+            decl_generics.push(tt.clone());
+        }
         match tt.clone() {
             TokenTree::Punct(p) if p.as_char() =3D=3D '<' =3D> {
-                if nesting >=3D 1 {
+                if nesting >=3D 1 && !skip_until_comma {
                     // This is inside of the generics and part of some bou=
nd.
                     impl_generics.push(tt);
                 }
@@ -105,49 +147,70 @@ pub(crate) fn parse_generics(input: TokenStream) -> (=
Generics, Vec<TokenTree>) {
                     break;
                 } else {
                     nesting -=3D 1;
-                    if nesting >=3D 1 {
+                    if nesting >=3D 1 && !skip_until_comma {
                         // We are still inside of the generics and part of=
 some bound.
                         impl_generics.push(tt);
                     }
-                    if nesting =3D=3D 0 {
-                        break;
-                    }
                 }
             }
-            tt =3D> {
+            TokenTree::Punct(p) if skip_until_comma && p.as_char() =3D=3D =
',' =3D> {
                 if nesting =3D=3D 1 {
-                    // Here depending on the token, it might be a generic =
variable name.
-                    match &tt {
-                        // Ignore const.
-                        TokenTree::Ident(i) if i.to_string() =3D=3D "const=
" =3D> {}
-                        TokenTree::Ident(_) if at_start =3D> {
-                            ty_generics.push(tt.clone());
-                            // We also already push the `,` token, this ma=
kes it easier to append
-                            // generics.
-                            ty_generics.push(TokenTree::Punct(Punct::new('=
,', Spacing::Alone)));
-                            at_start =3D false;
-                        }
-                        TokenTree::Punct(p) if p.as_char() =3D=3D ',' =3D>=
 at_start =3D true,
-                        // Lifetimes begin with `'`.
-                        TokenTree::Punct(p) if p.as_char() =3D=3D '\'' && =
at_start =3D> {
-                            ty_generics.push(tt.clone());
-                        }
-                        _ =3D> {}
-                    }
-                }
-                if nesting >=3D 1 {
+                    impl_generics.push(tt.clone());
                     impl_generics.push(tt);
-                } else if nesting =3D=3D 0 {
+                    skip_until_comma =3D false;
+                }
+            }
+            _ if !skip_until_comma =3D> {
+                match nesting {
                     // If we haven't entered the generics yet, we still wa=
nt to keep these tokens.
-                    rest.push(tt);
+                    0 =3D> rest.push(tt),
+                    1 =3D> {
+                        // Here depending on the token, it might be a gene=
ric variable name.
+                        match tt.clone() {
+                            TokenTree::Ident(i) if at_start && i.to_string=
() =3D=3D "const" =3D> {
+                                let Some(name) =3D toks.next() else {
+                                    // Parsing error.
+                                    break;
+                                };
+                                impl_generics.push(tt);
+                                impl_generics.push(name.clone());
+                                ty_generics.push(name.clone());
+                                decl_generics.push(name);
+                                at_start =3D false;
+                            }
+                            TokenTree::Ident(_) if at_start =3D> {
+                                impl_generics.push(tt.clone());
+                                ty_generics.push(tt);
+                                at_start =3D false;
+                            }
+                            TokenTree::Punct(p) if p.as_char() =3D=3D ',' =
=3D> {
+                                impl_generics.push(tt.clone());
+                                ty_generics.push(tt);
+                                at_start =3D true;
+                            }
+                            // Lifetimes begin with `'`.
+                            TokenTree::Punct(p) if p.as_char() =3D=3D '\''=
 && at_start =3D> {
+                                impl_generics.push(tt.clone());
+                                ty_generics.push(tt);
+                            }
+                            // Generics can have default values, we skip t=
hese.
+                            TokenTree::Punct(p) if p.as_char() =3D=3D '=3D=
' =3D> {
+                                skip_until_comma =3D true;
+                            }
+                            _ =3D> impl_generics.push(tt),
+                        }
+                    }
+                    _ =3D> impl_generics.push(tt),
                 }
             }
+            _ =3D> {}
         }
     }
     rest.extend(toks);
     (
         Generics {
             impl_generics,
+            decl_generics,
             ty_generics,
         },
         rest,
diff --git a/rust/macros/pin_data.rs b/rust/macros/pin_data.rs
index 6d58cfda9872..022e68e9720d 100644
--- a/rust/macros/pin_data.rs
+++ b/rust/macros/pin_data.rs
@@ -10,6 +10,7 @@ pub(crate) fn pin_data(args: TokenStream, input: TokenStr=
eam) -> TokenStream {
     let (
         Generics {
             impl_generics,
+            decl_generics: _,
             ty_generics,
         },
         rest,
diff --git a/rust/macros/zeroable.rs b/rust/macros/zeroable.rs
index 0d605c46ab3b..cfee2cec18d5 100644
--- a/rust/macros/zeroable.rs
+++ b/rust/macros/zeroable.rs
@@ -7,6 +7,7 @@ pub(crate) fn derive(input: TokenStream) -> TokenStream {
     let (
         Generics {
             impl_generics,
+            decl_generics: _,
             ty_generics,
         },
         mut rest,

base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
--=20
2.42.0



