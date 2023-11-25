Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0BC7F8ADC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjKYMvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYMvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:51:03 -0500
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9964FA5;
        Sat, 25 Nov 2023 04:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=qh2uj6xbbvbxrnxhxti6oxthfi.protonmail; t=1700916665; x=1701175865;
        bh=bzZvCYsbJgfCiGy9vIa+JkIEYDyc8iF8244zXEcpiHg=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=GVmy2iMxJHq9iElHjyYdipNjbfCH53bjqnSfPZ2DLKxnWqkx31YLNeJnqfZyS8J8m
         NVhahLyT9M5SMThAzuqRfmfP2bDZOqEjk+2Y2GFixw6EQEybLb0MXr0BA6VqEFcvx8
         4u3Dd3lW4ytsSuumAoaqYPv1SKcos0yRzUSX0rImOl6uMqG/rN5E6UtJxfK56Q1VaG
         HivdhnsNJYhlc2lt23xlSeZ70Eequ9oFb56lIckCeLyyae/EtHCBRSJux+ZluYi/9F
         RLKBfXNg2/XADzqevnu5OKYDqY++zNTndl3KOVeiQ+6HFysYoaDlPnNLmI2F7MEO5C
         Zju/8HHaNdDTQ==
Date:   Sat, 25 Nov 2023 12:50:49 +0000
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Asahi Lina <lina@asahilina.net>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] rust: macros: `parse_generics` add `decl_generics`
Message-ID: <20231125125024.1235933-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When parsing generics of a type definition, default values can be
specified. This syntax is however only available on type definitions and
not e.g. impl blocks.

This patch adds the `decl_generics` which can only be used on type
defintions, since they contain the default values for generic
parameters. This patch also changes how `impl_generics` are made up, as
these should be used with `impl<$impl_generics>`, they will omit the
default values.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/macros/helpers.rs  | 91 +++++++++++++++++++++++++++--------------
 rust/macros/pin_data.rs |  1 +
 rust/macros/zeroable.rs |  1 +
 3 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index afb0f2e3a36a..36fecdd998d0 100644
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
@@ -72,6 +72,7 @@ pub(crate) fn expect_end(it: &mut token_stream::IntoIter)=
 {
=20
 pub(crate) struct Generics {
     pub(crate) impl_generics: Vec<TokenTree>,
+    pub(crate) decl_generics: Vec<TokenTree>,
     pub(crate) ty_generics: Vec<TokenTree>,
 }
=20
@@ -81,6 +82,8 @@ pub(crate) struct Generics {
 pub(crate) fn parse_generics(input: TokenStream) -> (Generics, Vec<TokenTr=
ee>) {
     // `impl_generics`, the declared generics with their bounds.
     let mut impl_generics =3D vec![];
+    // The generics with bounds and default values.
+    let mut decl_generics =3D vec![];
     // Only the names of the generics, without any bounds.
     let mut ty_generics =3D vec![];
     // Tokens not related to the generics e.g. the `where` token and defin=
ition.
@@ -90,10 +93,17 @@ pub(crate) fn parse_generics(input: TokenStream) -> (Ge=
nerics, Vec<TokenTree>) {
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
@@ -105,49 +115,70 @@ pub(crate) fn parse_generics(input: TokenStream) -> (=
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
+                    impl_generics.push(TokenTree::Punct(p.clone()));
+                    ty_generics.push(TokenTree::Punct(p));
+                    skip_until_comma =3D false;
                 }
-                if nesting >=3D 1 {
-                    impl_generics.push(tt);
-                } else if nesting =3D=3D 0 {
+            }
+            tt if !skip_until_comma =3D> {
+                match nesting {
                     // If we haven't entered the generics yet, we still wa=
nt to keep these tokens.
-                    rest.push(tt);
+                    0 =3D> rest.push(tt),
+                    1 =3D> {
+                        // Here depending on the token, it might be a gene=
ric variable name.
+                        match tt {
+                            TokenTree::Ident(i) if at_start && i.to_string=
() =3D=3D "const" =3D> {
+                                let Some(name) =3D toks.next() else {
+                                    // Parsing error.
+                                    break;
+                                };
+                                impl_generics.push(TokenTree::Ident(i));
+                                impl_generics.push(name.clone());
+                                ty_generics.push(name.clone());
+                                decl_generics.push(name);
+                                at_start =3D false;
+                            }
+                            tt @ TokenTree::Ident(_) if at_start =3D> {
+                                impl_generics.push(tt.clone());
+                                ty_generics.push(tt);
+                                at_start =3D false;
+                            }
+                            TokenTree::Punct(p) if p.as_char() =3D=3D ',' =
=3D> {
+                                impl_generics.push(TokenTree::Punct(p.clon=
e()));
+                                ty_generics.push(TokenTree::Punct(p));
+                                at_start =3D true;
+                            }
+                            // Lifetimes begin with `'`.
+                            TokenTree::Punct(p) if p.as_char() =3D=3D '\''=
 && at_start =3D> {
+                                ty_generics.push(TokenTree::Punct(p.clone(=
)));
+                                impl_generics.push(TokenTree::Punct(p));
+                            }
+                            // Generics can have default values, we skip t=
hese.
+                            TokenTree::Punct(p) if p.as_char() =3D=3D '=3D=
' =3D> {
+                                skip_until_comma =3D true;
+                            }
+                            tt =3D> impl_generics.push(tt),
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

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
--=20
2.40.1


