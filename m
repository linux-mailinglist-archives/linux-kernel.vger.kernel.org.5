Return-Path: <linux-kernel+bounces-130515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDC189792B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE051C21DB0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADF515538C;
	Wed,  3 Apr 2024 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CWdGqKKH"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F012D2F24
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173426; cv=none; b=ZqHp8fIZA0VgqYZ4dTTzl3WnaE+boTiepQyDk8oMopd8G1RzmthZANeASuDWH1qP0Q2Ah+1Q6mkTqXACeSXblWE2XK4rqvnxKMwTmAceUqIBDeGgpE8V0aPNTGvU8nBtGN7yPGvE1qTqEdpvlK5emO3x0OWQ24nVTp/vvSSRLTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173426; c=relaxed/simple;
	bh=lzf+ES6yHZZVg6XniA+JFvQLjo8zG+VMBXl7BaaBibs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DBLWRCAbd1qTx9RMgRMlwT0mw8kpAz3yTy8EkILL7qosTczKzilEKcQercbEsxh9dZyEsslSZAaKnzObp2/E2JBwQzqDRvoytd2MhAV7H/NTDaLlR4DamFEKyypiFEIT+6EkgM3Ggfo3BWxcUBWrh0f34hqszw7eYJQ2BmfUxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CWdGqKKH; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712173422; x=1712432622;
	bh=Z/cYaiGjtg8Hl/T+kAOXPPgB1Msfoi/aGGBHya0iD3M=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=CWdGqKKHsAsyjwmhI5qIPRNj3R979LLdUL13yfBfn2xREbHxs/5Nqcjh2uILvfI5O
	 JZPJy+Otrd+NutyHe9h+ONVRsSIcKOyBuiuVFYGba+GsQZOau3ZW71NpEozrU/2Z+x
	 hRaj2IQzTATd50O0EiLt6V546HEYTYe68Od/d9CRFpVqGj93a2ImfgGU9tw0TGQHyL
	 vC+QA1/BmpAGTnSRjtsFB/UUFtIByWdp6Mm5f1FlbL/Qvnr9rWXpnCOdWkFcmyF65q
	 7F/PnsO8oMpJD4it0zHRM5+iv2zdkOloAKCXUACNaGtzddHCLsi5ZEbREfo8KUXJUB
	 npe1RSrkHXkMQ==
Date: Wed, 03 Apr 2024 19:43:37 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rust: init: change the generated name of guard variables
Message-ID: <20240403194321.88716-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The initializers created by the `[try_][pin_]init!` macros utilize the
guard pattern to drop already initialized fields, when initialization
fails mid-way. These guards are generated to have the same name as the
field that they handle. To prevent namespacing issues when the field
name is the same as e.g. a constant name, add `__` as a prefix and
`_guard` as the suffix.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/init/macros.rs | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index cb6e61b6c50b..93bf4c3080f9 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -250,7 +250,7 @@
 //!                     // error type is `Infallible`) we will need to dro=
p this field if there
 //!                     // is an error later. This `DropGuard` will drop t=
he field when it gets
 //!                     // dropped and has not yet been forgotten.
-//!                     let t =3D unsafe {
+//!                     let __t_guard =3D unsafe {
 //!                         ::pinned_init::__internal::DropGuard::new(::co=
re::addr_of_mut!((*slot).t))
 //!                     };
 //!                     // Expansion of `x: 0,`:
@@ -261,14 +261,14 @@
 //!                         unsafe { ::core::ptr::write(::core::addr_of_mu=
t!((*slot).x), x) };
 //!                     }
 //!                     // We again create a `DropGuard`.
-//!                     let x =3D unsafe {
+//!                     let __x_guard =3D unsafe {
 //!                         ::kernel::init::__internal::DropGuard::new(::c=
ore::addr_of_mut!((*slot).x))
 //!                     };
 //!                     // Since initialization has successfully completed=
, we can now forget
 //!                     // the guards. This is not `mem::forget`, since we=
 only have
 //!                     // `&DropGuard`.
-//!                     ::core::mem::forget(x);
-//!                     ::core::mem::forget(t);
+//!                     ::core::mem::forget(__x_guard);
+//!                     ::core::mem::forget(__t_guard);
 //!                     // Here we use the type checker to ensure that eve=
ry field has been
 //!                     // initialized exactly once, since this is `if fal=
se` it will never get
 //!                     // executed, but still type-checked.
@@ -461,16 +461,16 @@
 //!             {
 //!                 unsafe { ::core::ptr::write(::core::addr_of_mut!((*slo=
t).a), a) };
 //!             }
-//!             let a =3D unsafe {
+//!             let __a_guard =3D unsafe {
 //!                 ::kernel::init::__internal::DropGuard::new(::core::add=
r_of_mut!((*slot).a))
 //!             };
 //!             let init =3D Bar::new(36);
 //!             unsafe { data.b(::core::addr_of_mut!((*slot).b), b)? };
-//!             let b =3D unsafe {
+//!             let __b_guard =3D unsafe {
 //!                 ::kernel::init::__internal::DropGuard::new(::core::add=
r_of_mut!((*slot).b))
 //!             };
-//!             ::core::mem::forget(b);
-//!             ::core::mem::forget(a);
+//!             ::core::mem::forget(__b_guard);
+//!             ::core::mem::forget(__a_guard);
 //!             #[allow(unreachable_code, clippy::diverging_sub_expression=
)]
 //!             let _ =3D || {
 //!                 unsafe {
@@ -1192,14 +1192,14 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *m=
ut T) {}
         // We use `paste!` to create new hygiene for `$field`.
         ::kernel::macros::paste! {
             // SAFETY: We forget the guard later when initialization has s=
ucceeded.
-            let [<$field>] =3D unsafe {
+            let [< __ $field _guard >] =3D unsafe {
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr=
_of_mut!((*$slot).$field))
             };
=20
             $crate::__init_internal!(init_slot($use_data):
                 @data($data),
                 @slot($slot),
-                @guards([<$field>], $($guards,)*),
+                @guards([< __ $field _guard >], $($guards,)*),
                 @munch_fields($($rest)*),
             );
         }
@@ -1223,14 +1223,14 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *m=
ut T) {}
         // We use `paste!` to create new hygiene for `$field`.
         ::kernel::macros::paste! {
             // SAFETY: We forget the guard later when initialization has s=
ucceeded.
-            let [<$field>] =3D unsafe {
+            let [< __ $field _guard >] =3D unsafe {
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr=
_of_mut!((*$slot).$field))
             };
=20
             $crate::__init_internal!(init_slot():
                 @data($data),
                 @slot($slot),
-                @guards([<$field>], $($guards,)*),
+                @guards([< __ $field _guard >], $($guards,)*),
                 @munch_fields($($rest)*),
             );
         }
@@ -1255,14 +1255,14 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *m=
ut T) {}
         // We use `paste!` to create new hygiene for `$field`.
         ::kernel::macros::paste! {
             // SAFETY: We forget the guard later when initialization has s=
ucceeded.
-            let [<$field>] =3D unsafe {
+            let [< __ $field _guard >] =3D unsafe {
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr=
_of_mut!((*$slot).$field))
             };
=20
             $crate::__init_internal!(init_slot($($use_data)?):
                 @data($data),
                 @slot($slot),
-                @guards([<$field>], $($guards,)*),
+                @guards([< __ $field _guard >], $($guards,)*),
                 @munch_fields($($rest)*),
             );
         }

base-commit: 9ffe2a730313f27cebd0859ea856247ac59c576c
--=20
2.44.0



