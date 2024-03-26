Return-Path: <linux-kernel+bounces-119305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7165388C6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1B54B26EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6EBFC0E;
	Tue, 26 Mar 2024 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="H+bHkuwk"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B5313AD03;
	Tue, 26 Mar 2024 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466854; cv=none; b=ftsvJKqj3oTkzk55jTB2Pgl7prwwgx16/GarFUtYDOexmgsu5Nz7rtkesJ3QkjfPPc3dOV4hOSziA3Q+ZefOY7aM91rF7s5XM0guo2qCWImJm+XbyWGfoHF9E8rpbGZ3EK/2SBlxdnyYDe+k9CrIJq0Olj13oc7oAtznm/a6LB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466854; c=relaxed/simple;
	bh=gtc56Pzxa3zd+Gz4XQo7A+Xwpso4wNo6AuhvzHHOn40=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+YWkx3yg7hlhwwjML7ailQZk5lv/LWMDudczFpIz1uBkidVFkPGYxrT2zR38g7wjAG/vJhxK7QqdUvXYHXJk678KIRRBqw5BHMxxWFEO5TihoewPr0TQnhufDudSXE+AbCtWk56CEsy2ExF5XpXm+hGApegIVQKT49T9ib17ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=H+bHkuwk; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711466843; x=1711726043;
	bh=VkNrGer7rVWeExc2E5LbUsoDSwgiynWRPlczlazpxoo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=H+bHkuwkkSJypF0R8vtRs48GgmMDJ/eH2Pn0W1qQucESJPqZt5dm3wwfQ15nWkg9D
	 HC4ggxZOIdiyflP8qNcYv2V57EXKrkgE06Gp6m/Yof0MMcOt/BusW7qXu/nGKb81zQ
	 lWGr0vHsGosqvDgStJnPz5GDQd6gmsqVhwBtDlmE2CRuxgLKE2v8wzl95AiikwY5j2
	 5H7qelFswlaEoiQpJyPsQTqfb/z71J1Ic7p2gbyFyjzsn+xHrSSBpFlcYyP3bOz8T+
	 +IRCivbm2Y+E8ZHmZfiGUU6mA+a3D1Poq5L54uqaBcybEmTcVLtdk8p01OMQXlIBzP
	 /zi48WmL1eOtQ==
Date: Tue, 26 Mar 2024 15:27:18 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 10/10] rust: kernel: remove usage of `allocator_api` unstable feature
Message-ID: <0LNSiT6NSGVXUXFMn80Z2GCSdjCmJfd1idFp6dTgEf4hfDyjNHq59jLZD9U6BcWVCo1QVvRvHb5Pjr7DOUlqnHabGeOAhmLguV0kGcruqS4=@proton.me>
In-Reply-To: <20240325195418.166013-11-wedsonaf@gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-11-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.03.24 20:54, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> With the adoption of `BoxExt` and `VecExt`, we don't need the functions
> provided by this feature (namely the methods prefixed with `try_` and
> different allocator per collection instance).
>=20
> We do need `AllocError`, but we define our own as it is a trivial empty
> struct.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/kernel/alloc.rs        |  3 +++
>  rust/kernel/alloc/boxext.rs |  3 +--
>  rust/kernel/alloc/vecext.rs |  4 ++--
>  rust/kernel/error.rs        | 13 ++-----------
>  rust/kernel/init.rs         |  3 +--
>  rust/kernel/lib.rs          |  1 -
>  rust/kernel/str.rs          |  3 +--
>  rust/kernel/sync/arc.rs     |  4 ++--
>  rust/kernel/workqueue.rs    |  3 +--
>  9 files changed, 13 insertions(+), 24 deletions(-)
>=20
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 5712c81b1308..f17f48130f13 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -8,6 +8,9 @@
>  pub mod boxext;
>  pub mod vecext;
>=20
> +/// Indicates an allocation error.
> +pub struct AllocError;

I think it would be sensible to add this now:
    #[derive(Copy, Clone, PartialEq, Eq, Debug)]

> +
>  /// Flags to be used when allocating memory.
>  ///
>  /// They can be combined with the operators `|`, `&`, and `!`.
> diff --git a/rust/kernel/alloc/boxext.rs b/rust/kernel/alloc/boxext.rs
> index 26a918df7acf..3cdda0f635a3 100644
> --- a/rust/kernel/alloc/boxext.rs
> +++ b/rust/kernel/alloc/boxext.rs
> @@ -2,9 +2,8 @@
>=20
>  //! Extensions to [`Box`] for fallible allocations.
>=20
> -use super::Flags;
> +use super::{AllocError, Flags};
>  use alloc::boxed::Box;
> -use core::alloc::AllocError;
>  use core::mem::MaybeUninit;
>  use core::result::Result;
>=20
> diff --git a/rust/kernel/alloc/vecext.rs b/rust/kernel/alloc/vecext.rs
> index 1d4d51b45a49..85ca6a6db6de 100644
> --- a/rust/kernel/alloc/vecext.rs
> +++ b/rust/kernel/alloc/vecext.rs
> @@ -2,8 +2,8 @@
>=20
>  //! Extensions to [`Vec`] for fallible allocations.
>=20
> -use super::Flags;
> -use alloc::{alloc::AllocError, vec::Vec};
> +use super::{AllocError, Flags};
> +use alloc::vec::Vec;
>  use core::{mem::ManuallyDrop, result::Result};
>=20
>  /// Extensions to [`Vec`].
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 4786d3ee1e92..fc986bc24c6d 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -4,12 +4,9 @@
>  //!
>  //! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/=
uapi/asm-generic/errno-base.h)
>=20
> -use crate::str::CStr;
> +use crate::{alloc::AllocError, str::CStr};
>=20
> -use alloc::{
> -    alloc::{AllocError, LayoutError},
> -    collections::TryReserveError,
> -};
> +use alloc::alloc::LayoutError;
>=20
>  use core::convert::From;
>  use core::fmt;
> @@ -192,12 +189,6 @@ fn from(_: Utf8Error) -> Error {
>      }
>  }
>=20
> -impl From<TryReserveError> for Error {
> -    fn from(_: TryReserveError) -> Error {
> -        code::ENOMEM
> -    }
> -}
> -

Why are you removing this?

--=20
Cheers,
Benno

>  impl From<LayoutError> for Error {
>      fn from(_: LayoutError) -> Error {
>          code::ENOMEM
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 1a8b0464db0c..1f7a6b5892ac 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -211,14 +211,13 @@
>  //! [`pin_init!`]: crate::pin_init!
>=20
>  use crate::{
> -    alloc::{boxext::BoxExt, Flags},
> +    alloc::{boxext::BoxExt, AllocError, Flags},
>      error::{self, Error},
>      sync::UniqueArc,
>      types::{Opaque, ScopeGuard},
>  };
>  use alloc::boxed::Box;
>  use core::{
> -    alloc::AllocError,
>      cell::UnsafeCell,
>      convert::Infallible,
>      marker::PhantomData,
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 51f30e55bd00..5c641233e26d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -12,7 +12,6 @@
>  //! do so first instead of bypassing this crate.
>=20
>  #![no_std]
> -#![feature(allocator_api)]
>  #![feature(coerce_unsized)]
>  #![feature(dispatch_from_dyn)]
>  #![feature(new_uninit)]
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 34dbc85b5220..5206b18f882b 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -2,8 +2,7 @@
>=20
>  //! String representations.
>=20
> -use crate::alloc::{flags::*, vecext::VecExt};
> -use alloc::alloc::AllocError;
> +use crate::alloc::{flags::*, vecext::VecExt, AllocError};
>  use alloc::vec::Vec;
>  use core::fmt::{self, Write};
>  use core::ops::{self, Deref, Index};
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index af539c5eb4bc..8db25f73b37f 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -16,7 +16,7 @@
>  //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
>=20
>  use crate::{
> -    alloc::{boxext::BoxExt, Flags},
> +    alloc::{boxext::BoxExt, AllocError, Flags},
>      bindings,
>      error::{self, Error},
>      init::{self, InPlaceInit, Init, PinInit},
> @@ -25,7 +25,7 @@
>  };
>  use alloc::boxed::Box;
>  use core::{
> -    alloc::{AllocError, Layout},
> +    alloc::Layout,
>      fmt,
>      marker::{PhantomData, Unsize},
>      mem::{ManuallyDrop, MaybeUninit},
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 09a0f158ff1b..50837e56efc7 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -132,9 +132,8 @@
>  //!
>  //! C header: [`include/linux/workqueue.h`](srctree/include/linux/workqu=
eue.h)
>=20
> -use crate::alloc::Flags;
> +use crate::alloc::{AllocError, Flags};
>  use crate::{bindings, prelude::*, sync::Arc, sync::LockClassKey, types::=
Opaque};
> -use alloc::alloc::AllocError;
>  use alloc::boxed::Box;
>  use core::marker::PhantomData;
>  use core::pin::Pin;
> --
> 2.34.1
> 

