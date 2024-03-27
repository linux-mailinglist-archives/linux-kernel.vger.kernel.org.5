Return-Path: <linux-kernel+bounces-121618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A2A88EAEB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA5F29ED50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E260D130A51;
	Wed, 27 Mar 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CmtSSXme"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7D712F595
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556213; cv=none; b=WCoJuNlY3zOjztjWITxXBIzWRK2ywoqK3YEgnI17W2Z++Lkm2T1ooMfpI4kdOno6ORwVhdCOAoNYcqq25fxHSmfKLQVfjEdnIwgGEAbjAQp8/bvbQGKhd2kvtk4PA+BSC6xtLlyyZDBUIX6cbY3JCoHSwzK+ROhMrVBnpD3X6Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556213; c=relaxed/simple;
	bh=sT+XSyK8g3hoLB6WyZQzp0atORjqibEBbeZ/n0I3qqE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEj0tZbqIqVw0WZ0vB9H0RMIktLwkan9uexEb/7K67zPUZdgk0nd8IkpbA9wbod9BF0c313GGBVflm5DUWKOS/HrKsV5YjgyUiOWSHMw8xYzQqul+qanK1TsRgaOVHj8enJy1J5xazHJny5C7p5IgBCxu/bi0s3ofF0NhZWWA/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CmtSSXme; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711556208; x=1711815408;
	bh=G/e/npas1/bGg+7eT8JQjC5kkF+PlgUlu2xBXL7JzFM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CmtSSXmeJqyCDvrxz/ujRxKklqo3n5yinfdAzeFaCpXNwM+/LouWzkuH1MMkkl4vR
	 e1WCWozqUYgIsd2blozs0Nhfo/YmBNfhjyrulekfZxQ8lGnn5Mj20ShGWX++AujijA
	 yuZ905Ge6s2KeqTdeH+E5vxk/afjyrI/faqnSSTey18eXQOq2sGqeroRpE0evDK+CI
	 PlOAfYgNr/mY4C0sdz4OAIj6opFxya+hNVuIvT6wjt5Pm/LTvPrCfkZx1U+IQ2CruN
	 er0mphtVZ8dCEGhkdhbvMKUGGtQXO+k6wUBuy5UVqUwshiZcdj/jOdUfyyjLnZ4rw+
	 IiwujdrO/mohw==
Date: Wed, 27 Mar 2024 16:16:33 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 1/2] rust: introduce `InPlaceModule`
Message-ID: <b5ef6fdb-781f-4caf-98ac-1f2ceca9f6d0@proton.me>
In-Reply-To: <20240327032337.188938-2-wedsonaf@gmail.com>
References: <20240327032337.188938-1-wedsonaf@gmail.com> <20240327032337.188938-2-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.03.24 04:23, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> This allows modules to be initialised in-place in pinned memory, which
> enables the usage of pinned types (e.g., mutexes, spinlocks, driver
> registrations, etc.) in modules without any extra allocations.
>=20
> Drivers that don't need this may continue to implement `Module` without
> any changes.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

I have some suggestions below, with those fixed,

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>  rust/kernel/lib.rs    | 25 ++++++++++++++++++++++++-
>  rust/macros/module.rs | 18 ++++++------------
>  2 files changed, 30 insertions(+), 13 deletions(-)
>=20
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 5c641233e26d..64aee4fbc53b 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -62,7 +62,7 @@
>  /// The top level entrypoint to implementing a kernel module.
>  ///
>  /// For any teardown or cleanup operations, your type may implement [`Dr=
op`].
> -pub trait Module: Sized + Sync {
> +pub trait Module: Sized + Sync + Send {
>      /// Called at module initialization time.
>      ///
>      /// Use this method to perform whatever setup or registration your m=
odule
> @@ -72,6 +72,29 @@ pub trait Module: Sized + Sync {
>      fn init(module: &'static ThisModule) -> error::Result<Self>;
>  }
>=20
> +/// A module that is pinned and initialised in-place.
> +pub trait InPlaceModule: Sync + Send {
> +    /// Creates an initialiser for the module.
> +    ///
> +    /// It is called when the module is loaded.
> +    fn init(module: &'static ThisModule) -> impl init::PinInit<Self, err=
or::Error>;
> +}
> +
> +impl<T: Module> InPlaceModule for T {
> +    fn init(module: &'static ThisModule) -> impl init::PinInit<Self, err=
or::Error> {
> +        let initer =3D move |slot: *mut Self| {
> +            let m =3D <Self as Module>::init(module)?;
> +
> +            // SAFETY: `slot` is valid for write per the contract with `=
pin_init_from_closure`.
> +            unsafe { slot.write(m) };
> +            Ok(())
> +        };
> +
> +        // SAFETY: On success, `initer` always fully initialises an inst=
ance of `Self`.
> +        unsafe { init::pin_init_from_closure(initer) }
> +    }
> +}
> +
>  /// Equivalent to `THIS_MODULE` in the C API.
>  ///
>  /// C header: [`include/linux/export.h`](srctree/include/linux/export.h)
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 27979e582e4b..0b2bb4ec2fba 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -208,7 +208,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream =
{
>              #[used]
>              static __IS_RUST_MODULE: () =3D ();
>=20
> -            static mut __MOD: Option<{type_}> =3D None;
> +            static mut __MOD: core::mem::MaybeUninit<{type_}> =3D core::=
mem::MaybeUninit::uninit();

I would prefer `::core::mem::MaybeUninit`, since that prevents
accidentally referring to a module named `core`.

>=20
>              // SAFETY: `__this_module` is constructed by the kernel at l=
oad time and will not be
>              // freed until the module is unloaded.
> @@ -275,23 +275,17 @@ pub(crate) fn module(ts: TokenStream) -> TokenStrea=
m {
>              }}
>=20
>              fn __init() -> core::ffi::c_int {{
> -                match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
> -                    Ok(m) =3D> {{
> -                        unsafe {{
> -                            __MOD =3D Some(m);
> -                        }}
> -                        return 0;
> -                    }}
> -                    Err(e) =3D> {{
> -                        return e.to_errno();
> -                    }}
> +                let initer =3D <{type_} as kernel::InPlaceModule>::init(=
&THIS_MODULE);

Ditto with `::kernel::InPlaceModule`.

> +                match unsafe {{ initer.__pinned_init(__MOD.as_mut_ptr())=
 }} {{

This requires that the `PinInit` trait is in scope, I would use:

     match unsafe {{ ::kernel::init::PinInit::__pinned_init(initer, __MOD.a=
s_mut_ptr()) }} {{

--=20
Cheers,
Benno

> +                    Ok(m) =3D> 0,
> +                    Err(e) =3D> e.to_errno(),
>                  }}
>              }}
>=20
>              fn __exit() {{
>                  unsafe {{
>                      // Invokes `drop()` on `__MOD`, which should be used=
 for cleanup.
> -                    __MOD =3D None;
> +                    __MOD.assume_init_drop();
>                  }}
>              }}
>=20
> --
> 2.34.1
>=20


