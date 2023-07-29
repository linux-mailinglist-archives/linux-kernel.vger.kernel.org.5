Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A857C767D81
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjG2JMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG2JMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:12:31 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E3155AA
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 02:11:34 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:10:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=h6xtbgrdufgatmda4763qs5g7i.protonmail; t=1690621850; x=1690881050;
        bh=NqVMCstXwFCJc3Zjw12hIZVzieormXCP1JejQiCIqQY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=CSgrr7X7qKDx8kCzmGmznIJRnEFVnIoDRb7geMsB8UUD+Dz3jsVPHciqCnzNwGHfj
         VXejKX53cT3OwSEu8yXZ1hFbWUfSUdzjSaCTRIZPipFkR7so33LtdSPsxyUgZF1EJz
         t70bBoAP9UU2eU2NrwuCsyuS4OZgjDZWYxm5Pk9dT2qnxaZBNNg+zoEPYxmv953NMM
         iG++ms0jC6oZcxpIPz2rY3mwZUZKEKt3UV59cYoGtj8nwxN5sIZUMy3iH+1YSY0Ztx
         84vC1YIIZLPgjG74o5lanRG1BSHRg/WIf4s9mc3CGP3QTyi+AVhPtCaBSNTkx00Zs9
         wxtMjgpHOJJHg==
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
Subject: [PATCH v3 13/13] rust: init: update expanded macro explanation
Message-ID: <20230729090838.225225-14-benno.lossin@proton.me>
In-Reply-To: <20230729090838.225225-1-benno.lossin@proton.me>
References: <20230729090838.225225-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patches changed the internals of the macros resulting in
the example expanded code being outdated. This patch updates the example
and only changes documentation.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
v2 -> v3:
- added Reviewed-by's from Martin.

 rust/kernel/init/macros.rs | 126 ++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 57 deletions(-)

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index d54243cd3c82..bee172e8599e 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -45,7 +45,7 @@
 //! #[pinned_drop]
 //! impl PinnedDrop for Foo {
 //!     fn drop(self: Pin<&mut Self>) {
-//!         println!("{self:p} is getting dropped.");
+//!         pr_info!("{self:p} is getting dropped.");
 //!     }
 //! }
 //!
@@ -170,8 +170,10 @@
 //!         t: T,
 //!     }
 //!     #[doc(hidden)]
-//!     impl<'__pin, T>
-//!         ::core::marker::Unpin for Bar<T> where __Unpin<'__pin, T>: ::c=
ore::marker::Unpin {}
+//!     impl<'__pin, T> ::core::marker::Unpin for Bar<T>
+//!     where
+//!         __Unpin<'__pin, T>: ::core::marker::Unpin,
+//!     {}
 //!     // Now we need to ensure that `Bar` does not implement `Drop`, sin=
ce that would give users
 //!     // access to `&mut self` inside of `drop` even if the struct was p=
inned. This could lead to
 //!     // UB with only safe code, so we disallow this by giving a trait i=
mplementation error using
@@ -188,8 +190,9 @@
 //!     // for safety, but a good sanity check, since no normal code calls=
 `PinnedDrop::drop`.
 //!     #[allow(non_camel_case_types)]
 //!     trait UselessPinnedDropImpl_you_need_to_specify_PinnedDrop {}
-//!     impl<T: ::kernel::init::PinnedDrop>
-//!         UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for T {}
+//!     impl<
+//!         T: ::kernel::init::PinnedDrop,
+//!     > UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for T {}
 //!     impl<T> UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for B=
ar<T> {}
 //! };
 //! ```
@@ -219,7 +222,7 @@
 //!             // return type and shadow it later when we insert the arbi=
trary user code. That way
 //!             // there will be no possibility of returning without `unsa=
fe`.
 //!             struct __InitOk;
-//!             // Get the pin-data type from the initialized type.
+//!             // Get the data about fields from the supplied type.
 //!             // - the function is unsafe, hence the unsafe block
 //!             // - we `use` the `HasPinData` trait in the block, it is o=
nly available in that
 //!             //   scope.
@@ -227,8 +230,7 @@
 //!                 use ::kernel::init::__internal::HasPinData;
 //!                 Self::__pin_data()
 //!             };
-//!             // Use `data` to help with type inference, the closure sup=
plied will have the type
-//!             // `FnOnce(*mut Self) -> Result<__InitOk, Infallible>`.
+//!             // Ensure that `data` really is of type `PinData` and help=
 with type inference:
 //!             let init =3D ::kernel::init::__internal::PinData::make_clo=
sure::<
 //!                 _,
 //!                 __InitOk,
@@ -236,71 +238,75 @@
 //!             >(data, move |slot| {
 //!                 {
 //!                     // Shadow the structure so it cannot be used to re=
turn early. If a user
-//!                     // tries to write `return Ok(__InitOk)`, then they=
 get a type error, since
-//!                     // that will refer to this struct instead of the o=
ne defined above.
+//!                     // tries to write `return Ok(__InitOk)`, then they=
 get a type error,
+//!                     // since that will refer to this struct instead of=
 the one defined
+//!                     // above.
 //!                     struct __InitOk;
 //!                     // This is the expansion of `t,`, which is syntact=
ic sugar for `t: t,`.
-//!                     unsafe { ::core::ptr::write(::core::addr_of_mut!((=
*slot).t), t) };
-//!                     // Since initialization could fail later (not in t=
his case, since the error
-//!                     // type is `Infallible`) we will need to drop this=
 field if there is an
-//!                     // error later. This `DropGuard` will drop the fie=
ld when it gets dropped
-//!                     // and has not yet been forgotten. We make a refer=
ence to it, so users
-//!                     // cannot `mem::forget` it from the initializer, s=
ince the name is the same
-//!                     // as the field (including hygiene).
-//!                     let t =3D &unsafe {
-//!                         ::kernel::init::__internal::DropGuard::new(
-//!                             ::core::addr_of_mut!((*slot).t),
-//!                         )
+//!                     {
+//!                         unsafe { ::core::ptr::write(::core::addr_of_mu=
t!((*slot).t), t) };
+//!                     }
+//!                     // Since initialization could fail later (not in t=
his case, since the
+//!                     // error type is `Infallible`) we will need to dro=
p this field if there
+//!                     // is an error later. This `DropGuard` will drop t=
he field when it gets
+//!                     // dropped and has not yet been forgotten.
+//!                     let t =3D unsafe {
+//!                         ::pinned_init::__internal::DropGuard::new(::co=
re::addr_of_mut!((*slot).t))
 //!                     };
 //!                     // Expansion of `x: 0,`:
-//!                     // Since this can be an arbitrary expression we ca=
nnot place it inside of
-//!                     // the `unsafe` block, so we bind it here.
-//!                     let x =3D 0;
-//!                     unsafe { ::core::ptr::write(::core::addr_of_mut!((=
*slot).x), x) };
+//!                     // Since this can be an arbitrary expression we ca=
nnot place it inside
+//!                     // of the `unsafe` block, so we bind it here.
+//!                     {
+//!                         let x =3D 0;
+//!                         unsafe { ::core::ptr::write(::core::addr_of_mu=
t!((*slot).x), x) };
+//!                     }
 //!                     // We again create a `DropGuard`.
-//!                     let x =3D &unsafe {
-//!                         ::kernel::init::__internal::DropGuard::new(
-//!                             ::core::addr_of_mut!((*slot).x),
-//!                         )
+//!                     let x =3D unsafe {
+//!                         ::kernel::init::__internal::DropGuard::new(::c=
ore::addr_of_mut!((*slot).x))
 //!                     };
-//!
+//!                     // Since initialization has successfully completed=
, we can now forget
+//!                     // the guards. This is not `mem::forget`, since we=
 only have
+//!                     // `&DropGuard`.
+//!                     ::core::mem::forget(x);
+//!                     ::core::mem::forget(t);
 //!                     // Here we use the type checker to ensure that eve=
ry field has been
 //!                     // initialized exactly once, since this is `if fal=
se` it will never get
 //!                     // executed, but still type-checked.
-//!                     // Additionally we abuse `slot` to automatically i=
nfer the correct type for
-//!                     // the struct. This is also another check that eve=
ry field is accessible
-//!                     // from this scope.
+//!                     // Additionally we abuse `slot` to automatically i=
nfer the correct type
+//!                     // for the struct. This is also another check that=
 every field is
+//!                     // accessible from this scope.
 //!                     #[allow(unreachable_code, clippy::diverging_sub_ex=
pression)]
-//!                     if false {
+//!                     let _ =3D || {
 //!                         unsafe {
 //!                             ::core::ptr::write(
 //!                                 slot,
 //!                                 Self {
-//!                                     // We only care about typecheck fi=
nding every field here,
-//!                                     // the expression does not matter,=
 just conjure one using
-//!                                     // `panic!()`:
+//!                                     // We only care about typecheck fi=
nding every field
+//!                                     // here, the expression does not m=
atter, just conjure
+//!                                     // one using `panic!()`:
 //!                                     t: ::core::panic!(),
 //!                                     x: ::core::panic!(),
 //!                                 },
 //!                             );
 //!                         };
-//!                     }
-//!                     // Since initialization has successfully completed=
, we can now forget the
-//!                     // guards. This is not `mem::forget`, since we onl=
y have `&DropGuard`.
-//!                     unsafe { ::kernel::init::__internal::DropGuard::fo=
rget(t) };
-//!                     unsafe { ::kernel::init::__internal::DropGuard::fo=
rget(x) };
+//!                     };
 //!                 }
 //!                 // We leave the scope above and gain access to the pre=
viously shadowed
 //!                 // `__InitOk` that we need to return.
 //!                 Ok(__InitOk)
 //!             });
 //!             // Change the return type from `__InitOk` to `()`.
-//!             let init =3D move |slot| -> ::core::result::Result<(), ::c=
ore::convert::Infallible> {
+//!             let init =3D move |
+//!                 slot,
+//!             | -> ::core::result::Result<(), ::core::convert::Infallibl=
e> {
 //!                 init(slot).map(|__InitOk| ())
 //!             };
 //!             // Construct the initializer.
 //!             let init =3D unsafe {
-//!                 ::kernel::init::pin_init_from_closure::<_, ::core::con=
vert::Infallible>(init)
+//!                 ::kernel::init::pin_init_from_closure::<
+//!                     _,
+//!                     ::core::convert::Infallible,
+//!                 >(init)
 //!             };
 //!             init
 //!         }
@@ -374,7 +380,10 @@
 //!         b: Bar<u32>,
 //!     }
 //!     #[doc(hidden)]
-//!     impl<'__pin> ::core::marker::Unpin for Foo where __Unpin<'__pin>: =
::core::marker::Unpin {}
+//!     impl<'__pin> ::core::marker::Unpin for Foo
+//!     where
+//!         __Unpin<'__pin>: ::core::marker::Unpin,
+//!     {}
 //!     // Since we specified `PinnedDrop` as the argument to `#[pin_data]=
`, we expect `Foo` to
 //!     // implement `PinnedDrop`. Thus we do not need to prevent `Drop` i=
mplementations like
 //!     // before, instead we implement `Drop` here and delegate to `Pinne=
dDrop`.
@@ -403,7 +412,7 @@
 //! #[pinned_drop]
 //! impl PinnedDrop for Foo {
 //!     fn drop(self: Pin<&mut Self>) {
-//!         println!("{self:p} is getting dropped.");
+//!         pr_info!("{self:p} is getting dropped.");
 //!     }
 //! }
 //! ```
@@ -414,7 +423,7 @@
 //! // `unsafe`, full path and the token parameter are added, everything e=
lse stays the same.
 //! unsafe impl ::kernel::init::PinnedDrop for Foo {
 //!     fn drop(self: Pin<&mut Self>, _: ::kernel::init::__internal::OnlyC=
allFromDrop) {
-//!         println!("{self:p} is getting dropped.");
+//!         pr_info!("{self:p} is getting dropped.");
 //!     }
 //! }
 //! ```
@@ -449,18 +458,21 @@
 //!     >(data, move |slot| {
 //!         {
 //!             struct __InitOk;
-//!             unsafe { ::core::ptr::write(::core::addr_of_mut!((*slot).a=
), a) };
-//!             let a =3D &unsafe {
+//!             {
+//!                 unsafe { ::core::ptr::write(::core::addr_of_mut!((*slo=
t).a), a) };
+//!             }
+//!             let a =3D unsafe {
 //!                 ::kernel::init::__internal::DropGuard::new(::core::add=
r_of_mut!((*slot).a))
 //!             };
-//!             let b =3D Bar::new(36);
+//!             let init =3D Bar::new(36);
 //!             unsafe { data.b(::core::addr_of_mut!((*slot).b), b)? };
-//!             let b =3D &unsafe {
+//!             let b =3D unsafe {
 //!                 ::kernel::init::__internal::DropGuard::new(::core::add=
r_of_mut!((*slot).b))
 //!             };
-//!
+//!             ::core::mem::forget(b);
+//!             ::core::mem::forget(a);
 //!             #[allow(unreachable_code, clippy::diverging_sub_expression=
)]
-//!             if false {
+//!             let _ =3D || {
 //!                 unsafe {
 //!                     ::core::ptr::write(
 //!                         slot,
@@ -470,13 +482,13 @@
 //!                         },
 //!                     );
 //!                 };
-//!             }
-//!             unsafe { ::kernel::init::__internal::DropGuard::forget(a) =
};
-//!             unsafe { ::kernel::init::__internal::DropGuard::forget(b) =
};
+//!             };
 //!         }
 //!         Ok(__InitOk)
 //!     });
-//!     let init =3D move |slot| -> ::core::result::Result<(), ::core::con=
vert::Infallible> {
+//!     let init =3D move |
+//!         slot,
+//!     | -> ::core::result::Result<(), ::core::convert::Infallible> {
 //!         init(slot).map(|__InitOk| ())
 //!     };
 //!     let init =3D unsafe {
--=20
2.41.0


