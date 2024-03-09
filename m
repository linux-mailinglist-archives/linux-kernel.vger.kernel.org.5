Return-Path: <linux-kernel+bounces-97944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F1C877206
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95BC1F2162F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DD54594B;
	Sat,  9 Mar 2024 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Yvk/opDV"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C019E4503F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709999666; cv=none; b=JvVbjnnae877D1mfbbgWOTRqHP7iQ8b2OhRGo/Diy1ZjWvI7BGnS+66iiJYQbgDRgxgZWSRm6+MGPfSUSnHfDwMX+eG8Mk/6F3Q/GCW7Y7q8mhQxXtt496DRTuZiplKTe8LwtTzylr93B8Z7NJR7mjlgB0/zhfIMCDNTZLt+weY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709999666; c=relaxed/simple;
	bh=q6VjSnqQehBqFwPxPtMXVTVwZDM6niOkV3k5Jw1ppqw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtdpI9Z50XYwDCiGcyCsFSZMkW3r1nmpArpX1U1BmJD7GtmfV7LjqzeS1oX6KGVecituTYPWRyRPgSwqFKCjcTSFKQGML3QZ9nd7niLc+HCgZxsrFhuGnwYy3+JPlAZRbYIzXbpTEml4ZaKHMRmGrVvTuu8oh3o7T9hc7usNT5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Yvk/opDV; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1709999662; x=1710258862;
	bh=zaRBfYB1dxA9JIbb7m/PWIO7cdZBiptSmFU6Unknytg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Yvk/opDV6N5HLrZL4eRzioKHR2Cd2Y7KJ3Br3hSJFI/VhUPSke8Zewm1Ux2zlIWWj
	 qKWYTV6jWLnWmr88M4c0YZ2/mUI2bk81v5n7eSjC41LwVT8eLneHD7FvovXqGBOP6q
	 IyaQmxwvystkAqakZv5NP12YqLeyXTtbDo/XvfRWmOdOEGIw9ePVUjTKmqDiyMSOWo
	 JklRDM2sG2+PvAinA4fkPDQ/erKnJM+AyzXiHRpwfb3SvnASCSaL1o64kxm0UdPbz2
	 cERIGL/GIr9CyuSXwL4fa+tjQFJlXayJcskvNPAz5rzpMUVgESLDSi4mkNL6ak8pPE
	 Z+hUGOmt4zu6w==
Date: Sat, 09 Mar 2024 15:54:04 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] rust: macros: allow generic parameter default values in `#[pin_data]`
Message-ID: <20240309155243.482334-2-benno.lossin@proton.me>
In-Reply-To: <20240309155243.482334-1-benno.lossin@proton.me>
References: <20240309155243.482334-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add support for generic parameters defaults in `#[pin_data]` by using
the newly introduced `decl_generics` instead of the `impl_generics`.

Before this would not compile:

    #[pin_data]
    struct Foo<const N: usize =3D 0> {
        // ...
    }

because it would be expanded to this:

    struct Foo<const N: usize =3D 0> {
        // ...
    }

    const _: () =3D {
        struct __ThePinData<const N: usize =3D 0> {
            __phantom: ::core::marker::PhantomData<fn(Foo<N>) -> Foo<N>>,
        }
        impl<const N: usize =3D 0> ::core::clone::Clone for __ThePinData<N>=
 {
            fn clone(&self) -> Self {
                *self
            }
        }

        // [...] rest of expansion omitted
    };

The problem is with the `impl<const N: usize =3D 0>`, since that is
invalid Rust syntax. It should not mention the default value at all,
since default values only make sense on type definitions.

The new `impl_generics` do not contain the default values, thus
generating correct Rust code.

This is used by the next commit that puts `#[pin_data]` on
`kernel::workqueue::Work`.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
---
v2 -> v3:
- remove #[allow(dead_code)] since that part of the code is now used

v1 -> v2:
- clarify the change in the commit message
- add motivation to the commit message

 rust/kernel/init/macros.rs | 19 ++++++++++++++++++-
 rust/macros/helpers.rs     |  1 -
 rust/macros/pin_data.rs    |  3 ++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index cb6e61b6c50b..624e9108e3b4 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -538,6 +538,7 @@ macro_rules! __pin_data {
         ),
         @impl_generics($($impl_generics:tt)*),
         @ty_generics($($ty_generics:tt)*),
+        @decl_generics($($decl_generics:tt)*),
         @body({ $($fields:tt)* }),
     ) =3D> {
         // We now use token munching to iterate through all of the fields.=
 While doing this we
@@ -560,6 +561,9 @@ macro_rules! __pin_data {
             @impl_generics($($impl_generics)*),
             // The 'ty generics', the generics that will need to be specif=
ied on the impl blocks.
             @ty_generics($($ty_generics)*),
+            // The 'decl generics', the generics that need to be specified=
 on the struct
+            // definition.
+            @decl_generics($($decl_generics)*),
             // The where clause of any impl block and the declaration.
             @where($($($whr)*)?),
             // The remaining fields tokens that need to be processed.
@@ -585,6 +589,7 @@ macro_rules! __pin_data {
         @name($name:ident),
         @impl_generics($($impl_generics:tt)*),
         @ty_generics($($ty_generics:tt)*),
+        @decl_generics($($decl_generics:tt)*),
         @where($($whr:tt)*),
         // We found a PhantomPinned field, this should generally be pinned=
!
         @fields_munch($field:ident : $($($(::)?core::)?marker::)?PhantomPi=
nned, $($rest:tt)*),
@@ -607,6 +612,7 @@ macro_rules! __pin_data {
             @name($name),
             @impl_generics($($impl_generics)*),
             @ty_generics($($ty_generics)*),
+            @decl_generics($($decl_generics)*),
             @where($($whr)*),
             @fields_munch($($rest)*),
             @pinned($($pinned)* $($accum)* $field: ::core::marker::Phantom=
Pinned,),
@@ -623,6 +629,7 @@ macro_rules! __pin_data {
         @name($name:ident),
         @impl_generics($($impl_generics:tt)*),
         @ty_generics($($ty_generics:tt)*),
+        @decl_generics($($decl_generics:tt)*),
         @where($($whr:tt)*),
         // We reached the field declaration.
         @fields_munch($field:ident : $type:ty, $($rest:tt)*),
@@ -640,6 +647,7 @@ macro_rules! __pin_data {
             @name($name),
             @impl_generics($($impl_generics)*),
             @ty_generics($($ty_generics)*),
+            @decl_generics($($decl_generics)*),
             @where($($whr)*),
             @fields_munch($($rest)*),
             @pinned($($pinned)* $($accum)* $field: $type,),
@@ -656,6 +664,7 @@ macro_rules! __pin_data {
         @name($name:ident),
         @impl_generics($($impl_generics:tt)*),
         @ty_generics($($ty_generics:tt)*),
+        @decl_generics($($decl_generics:tt)*),
         @where($($whr:tt)*),
         // We reached the field declaration.
         @fields_munch($field:ident : $type:ty, $($rest:tt)*),
@@ -673,6 +682,7 @@ macro_rules! __pin_data {
             @name($name),
             @impl_generics($($impl_generics)*),
             @ty_generics($($ty_generics)*),
+            @decl_generics($($decl_generics)*),
             @where($($whr)*),
             @fields_munch($($rest)*),
             @pinned($($pinned)*),
@@ -689,6 +699,7 @@ macro_rules! __pin_data {
         @name($name:ident),
         @impl_generics($($impl_generics:tt)*),
         @ty_generics($($ty_generics:tt)*),
+        @decl_generics($($decl_generics:tt)*),
         @where($($whr:tt)*),
         // We found the `#[pin]` attr.
         @fields_munch(#[pin] $($rest:tt)*),
@@ -705,6 +716,7 @@ macro_rules! __pin_data {
             @name($name),
             @impl_generics($($impl_generics)*),
             @ty_generics($($ty_generics)*),
+            @decl_generics($($decl_generics)*),
             @where($($whr)*),
             @fields_munch($($rest)*),
             // We do not include `#[pin]` in the list of attributes, since=
 it is not actually an
@@ -724,6 +736,7 @@ macro_rules! __pin_data {
         @name($name:ident),
         @impl_generics($($impl_generics:tt)*),
         @ty_generics($($ty_generics:tt)*),
+        @decl_generics($($decl_generics:tt)*),
         @where($($whr:tt)*),
         // We reached the field declaration with visibility, for simplicit=
y we only munch the
         // visibility and put it into `$accum`.
@@ -741,6 +754,7 @@ macro_rules! __pin_data {
             @name($name),
             @impl_generics($($impl_generics)*),
             @ty_generics($($ty_generics)*),
+            @decl_generics($($decl_generics)*),
             @where($($whr)*),
             @fields_munch($field $($rest)*),
             @pinned($($pinned)*),
@@ -757,6 +771,7 @@ macro_rules! __pin_data {
         @name($name:ident),
         @impl_generics($($impl_generics:tt)*),
         @ty_generics($($ty_generics:tt)*),
+        @decl_generics($($decl_generics:tt)*),
         @where($($whr:tt)*),
         // Some other attribute, just put it into `$accum`.
         @fields_munch(#[$($attr:tt)*] $($rest:tt)*),
@@ -773,6 +788,7 @@ macro_rules! __pin_data {
             @name($name),
             @impl_generics($($impl_generics)*),
             @ty_generics($($ty_generics)*),
+            @decl_generics($($decl_generics)*),
             @where($($whr)*),
             @fields_munch($($rest)*),
             @pinned($($pinned)*),
@@ -789,6 +805,7 @@ macro_rules! __pin_data {
         @name($name:ident),
         @impl_generics($($impl_generics:tt)*),
         @ty_generics($($ty_generics:tt)*),
+        @decl_generics($($decl_generics:tt)*),
         @where($($whr:tt)*),
         // We reached the end of the fields, plus an optional additional c=
omma, since we added one
         // before and the user is also allowed to put a trailing comma.
@@ -802,7 +819,7 @@ macro_rules! __pin_data {
     ) =3D> {
         // Declare the struct with all fields in the correct order.
         $($struct_attrs)*
-        $vis struct $name <$($impl_generics)*>
+        $vis struct $name <$($decl_generics)*>
         where $($whr)*
         {
             $($fields)*
diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index 2497d6519f2f..563dcd2b7ace 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -95,7 +95,6 @@ pub(crate) struct Generics {
     /// The generics with bounds and default values (e.g. `T: Clone, const=
 N: usize =3D 0`).
     ///
     /// Use this on type definitions e.g. `struct Foo<$decl_generics> ...`=
 (or `union`/`enum`).
-    #[allow(dead_code)]
     pub(crate) decl_generics: Vec<TokenTree>,
     /// The generics with bounds (e.g. `T: Clone, const N: usize`).
     ///
diff --git a/rust/macros/pin_data.rs b/rust/macros/pin_data.rs
index 022e68e9720d..1d4a3547c684 100644
--- a/rust/macros/pin_data.rs
+++ b/rust/macros/pin_data.rs
@@ -10,7 +10,7 @@ pub(crate) fn pin_data(args: TokenStream, input: TokenStr=
eam) -> TokenStream {
     let (
         Generics {
             impl_generics,
-            decl_generics: _,
+            decl_generics,
             ty_generics,
         },
         rest,
@@ -77,6 +77,7 @@ pub(crate) fn pin_data(args: TokenStream, input: TokenStr=
eam) -> TokenStream {
         @sig(#(#rest)*),
         @impl_generics(#(#impl_generics)*),
         @ty_generics(#(#ty_generics)*),
+        @decl_generics(#(#decl_generics)*),
         @body(#last),
     });
     quoted.extend(errs);
--=20
2.42.0



