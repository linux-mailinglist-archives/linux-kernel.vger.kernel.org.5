Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05F97D89A0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344835AbjJZUUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjJZUT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:19:59 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEC31AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1698351593; x=1698610793;
        bh=MY6UhJS4wgOAoosPta+TuxtbXCsYhD59Xf2pfqIYj2s=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=dGbPzAOcCpW+TbJACsMXT18aTk1rLFR5+rb05l3gHLPdhgtMrVbqZVRZ50zxXpY2o
         B7mIbgbT0foKPJ/yVeAjyepHdQbl8FwlcawjHZ3G9k940FIvLuXSVKIGt+Ya41Rnfl
         hclu30YXG9ikEA3d98cRg+N9ZFlE5ULWNGl/2Azr+CspZVqq8ncu3jmlU4DsNHvc4B
         sDvr5sJzuAsXe2dfSTsitxxpvm5+FVKPGITNVgASvMAjGcl5v/UdRYDj16Yh2FESpP
         Jh3bz3+/HbJvj674iAU5dmrPCQEUJlRyWlHFFGEl+TWqTpxsOiSXaX52w9YrVY40lo
         uJwBTi5C/5K7g==
Date:   Thu, 26 Oct 2023 20:19:33 +0000
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Asahi Lina <lina@asahilina.net>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Viktor Garske <viktor@v-gar.de>, Finn Behrens <me@kloenk.dev>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] rust: macros: improve `#[vtable]` documentation
Message-ID: <20231026201855.1497680-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Traits marked with `#[vtable]` need to provide default implementations
for optional functions. The C side represents these with `NULL` in the
vtable, so the default functions are never actually called. We do not
want to replicate the default behavior from C in Rust, because that is
not maintainable. Therefore we should use `build_error` in those default
implementations. The error message for that is provided at
`kernel::error::VTABLE_DEFAULT_ERROR`.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v2 -> v3:
- don't hide the import of the constant in the example
- fixed "function" typo
- improve paragraph about optional functions
- do not remove the `Send + Sync + Sized` bounds on the example

v1 -> v2:
- removed imperative mode in the paragraph describing optional
  functions.

 rust/kernel/error.rs |  4 ++++
 rust/macros/lib.rs   | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 05fcab6abfe6..1373cde025ef 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -335,3 +335,7 @@ pub(crate) fn from_result<T, F>(f: F) -> T
         Err(e) =3D> T::from(e.to_errno() as i16),
     }
 }
+
+/// Error message for calling a default function of a [`#[vtable]`](macros=
::vtable) trait.
+pub const VTABLE_DEFAULT_ERROR: &str =3D
+    "This function must not be called, see the #[vtable] documentation.";
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index c42105c2ff96..917a51183c23 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -87,27 +87,48 @@ pub fn module(ts: TokenStream) -> TokenStream {
 /// implementation could just return `Error::EINVAL`); Linux typically use=
 C
 /// `NULL` pointers to represent these functions.
 ///
-/// This attribute is intended to close the gap. Traits can be declared an=
d
-/// implemented with the `#[vtable]` attribute, and a `HAS_*` associated c=
onstant
-/// will be generated for each method in the trait, indicating if the impl=
ementor
-/// has overridden a method.
+/// This attribute closes that gap. A trait can be annotated with the `#[v=
table]` attribute.
+/// Implementers of the trait will then also have to annotate the trait wi=
th `#[vtable]`. This
+/// attribute generates a `HAS_*` associated constant bool for each method=
 in the trait that is set
+/// to true if the implementer has overridden the associated method.
+///
+/// For a trait method to be optional, it must have a default implementati=
on.
+/// This is also the case for traits annotated with `#[vtable]`, but in th=
is
+/// case the default implementation will never be executed. The reason for=
 this
+/// is that the functions will be called through function pointers install=
ed in
+/// C side vtables. When an optional method is not implemented on a `#[vta=
ble]`
+/// trait, a NULL entry is installed in the vtable. Thus the default
+/// implementation is never called. Since these traits are not designed to=
 be
+/// used on the Rust side, it should not be possible to call the default
+/// implementation. This is done to ensure that we call the vtable methods
+/// through the C vtable, and not through the Rust vtable. Therefore, the
+/// default implementation should call `kernel::build_error`, which preven=
ts
+/// calls to this function at compile time:
+///
+/// ```compile_fail
+/// # use kernel::error::VTABLE_DEFAULT_ERROR;
+/// kernel::build_error(VTABLE_DEFAULT_ERROR)
+/// ```
+///
+/// note that you might need to import [`kernel::error::VTABLE_DEFAULT_ERR=
OR`].
 ///
-/// This attribute is not needed if all methods are required.
+/// This macro should not be used when all functions are required.
 ///
 /// # Examples
 ///
 /// ```ignore
+/// use kernel::error::VTABLE_DEFAULT_ERROR;
 /// use kernel::prelude::*;
 ///
 /// // Declares a `#[vtable]` trait
 /// #[vtable]
 /// pub trait Operations: Send + Sync + Sized {
 ///     fn foo(&self) -> Result<()> {
-///         Err(EINVAL)
+///         kernel::build_error(VTABLE_DEFAULT_ERROR)
 ///     }
 ///
 ///     fn bar(&self) -> Result<()> {
-///         Err(EINVAL)
+///         kernel::build_error(VTABLE_DEFAULT_ERROR)
 ///     }
 /// }
 ///
@@ -125,6 +146,8 @@ pub fn module(ts: TokenStream) -> TokenStream {
 /// assert_eq!(<Foo as Operations>::HAS_FOO, true);
 /// assert_eq!(<Foo as Operations>::HAS_BAR, false);
 /// ```
+///
+/// [`kernel::error::VTABLE_DEFAULT_ERROR`]: ../kernel/error/constant.VTAB=
LE_DEFAULT_ERROR.html
 #[proc_macro_attribute]
 pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
     vtable::vtable(attr, ts)

base-commit: 3857af38e57a80b15b994e19d1f4301cac796481
--=20
2.41.0


