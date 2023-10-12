Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211D77C6F07
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377488AbjJLNWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343733AbjJLNWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:22:02 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4594;
        Thu, 12 Oct 2023 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1697116916; x=1697376116;
        bh=a9Ak0X7bSTujHRssN+a+Hftra+UlXwNVYvmyqQQCilw=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=CakwaJnKAjcxT7b1G6jSKT+/BpZ3n4TnAJBO+wUhocU6wDlKI0nP6WhL3GDpYIuVE
         3k+/Yb3acb18mnH+POGqFjYWjep/842QnWQkdVKtVjlEIvZNx6QofnjHqFN9j6Be96
         DR9+/HiPdmnid2Fx0HaIcmtRo69k3Yft/IhUMoKmtFjrfi2t3jv+BuuVYL7e5T2YrQ
         QzgYq9iQfC+Yj69RHyPe0jMoPIMcR+Et7ovrd4/H+i53LxRniPGghs2zgQyyBGdRaI
         XtxPXUwaLpCc4pxaSGm+6QWomk58RgZKY+Te7tgXc8Sqs5ZQYbeqEkamajMZ/9F+8u
         qJ19tjsuo75bA==
Date:   Thu, 12 Oct 2023 13:21:46 +0000
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
Subject: [PATCH] rust: macros: improve `#[vtable]` documentation
Message-ID: <20231012132131.300014-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 rust/kernel/error.rs |  4 ++++
 rust/macros/lib.rs   | 32 ++++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

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
index c42105c2ff96..dab9a1080b82 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -87,27 +87,41 @@ pub fn module(ts: TokenStream) -> TokenStream {
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
+/// If you want to make a function optional, you must provide a default im=
plementation. But this
+/// default implementation will never be executed, since these functions a=
re exclusively called
+/// from callbacks from the C side. This is because the vtable will have a=
 `NULL` entry and the C
+/// side will execute the default behavior. Since it is not maintainable t=
o replicate the default
+/// behavior in Rust, you should use the following code:
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
+/// This macro should not be used when all function are required.
 ///
 /// # Examples
 ///
 /// ```ignore
+/// # use kernel::error::VTABLE_DEFAULT_ERROR;
 /// use kernel::prelude::*;
 ///
 /// // Declares a `#[vtable]` trait
 /// #[vtable]
-/// pub trait Operations: Send + Sync + Sized {
+/// pub trait Operations {
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
@@ -125,6 +139,8 @@ pub fn module(ts: TokenStream) -> TokenStream {
 /// assert_eq!(<Foo as Operations>::HAS_FOO, true);
 /// assert_eq!(<Foo as Operations>::HAS_BAR, false);
 /// ```
+///
+/// [`kernel::error::VTABLE_DEFAULT_ERROR`]: ../kernel/error/constant.VTAB=
LE_DEFAULT_ERROR.html
 #[proc_macro_attribute]
 pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
     vtable::vtable(attr, ts)

base-commit: b2516f7af9d238ebc391bdbdae01ac9528f1109e
--=20
2.41.0


