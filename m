Return-Path: <linux-kernel+bounces-134312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D392B89B02E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0414D282508
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390861799B;
	Sun,  7 Apr 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="loS8/9k4"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B96125D6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712483669; cv=none; b=UjN+l3XfVqzdsUIZmEvAYQ8luUfOpPVsJ19YEUY7CWVlr4jQyzVsUzSevI80znrtUreEdTpTD/BoNyjBpbBeWnY4yoEKLgdDn5ZrB5D8TNnh4yhmPk4rGWHtkT8SCxz0BUukh1xxKwNET/16kTMjNtTKBGc0do7g101JkydbRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712483669; c=relaxed/simple;
	bh=i8Pf56totbaL2ToXcQKolVxiIZ/TpmMBAZ0t/LCkK3w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhonBt7I33DAy3G2CIYqRWZqLmalo0Efb8Fbms11oUw0ShCQrxIQbkl0PX0wGyu2dKkyo3DzVd9zlzAnFoQZSd6tRSSUQ/LcjARqTboBS3+9DgQpZOzdSLJBiFa3ObWu53aaRNER8tJygYStqC5TU5DyeDShvQsOwv2VOijLybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=loS8/9k4; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712483664; x=1712742864;
	bh=FpPOsxrlm7kGglog0YaejIMtnmrT68wmHt8AAfV1foA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=loS8/9k4aV1FTA3BHgGAukGuWqqeBVljBwDIWzkAUljm/0zq6hSqJ8lBwn2P5rfB7
	 7hgv5H2yThaIDK4kSj+MbPpjK7d++cHJcljgs/mFixr8gzLtHjkP/88V2kHVawH6js
	 7P3nOU6SklxAWyFecLxPypNogf82q7zCbK7g2raSQfhM4Ov7Py6moiNoNxkxRwWR2e
	 MmkVjKt1ESsQQMsKZEFCIQwNNeUCgVQLjaUEB7KskCCP5DUYbizydYKDirxFuoNagl
	 v4xhZwOUDNXemN2PNDfDaWK9UrfSplCR2bBZk8bxfFt5paquQALAo39ev4FS7oslvb
	 tv2kLnKfdTylg==
Date: Sun, 07 Apr 2024 09:54:19 +0000
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] rust: Add bindings for OPP framework
Message-ID: <ff6c7d5e-d6e9-4331-b8cc-eab139160e59@proton.me>
In-Reply-To: <06bb914eae00671a69b393bf86bb01ddec86c16f.1712314032.git.viresh.kumar@linaro.org>
References: <cover.1712314032.git.viresh.kumar@linaro.org> <06bb914eae00671a69b393bf86bb01ddec86c16f.1712314032.git.viresh.kumar@linaro.org>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I took a quick look and left some comments from the Rust side of view.

On 05.04.24 13:09, Viresh Kumar wrote:
> +/// Equivalent to `struct dev_pm_opp_config` in the C Code.
> +pub struct Config<T: ConfigOps> {
> +    token: Option<i32>,
> +    clk_names: Option<Pin<Vec<CString>>>,

Why are you using `Pin<Vec<_>>`? The vector may reallocate the backing
storage at any point in time.

> +    prop_name: Option<Pin<CString>>,
> +    regulator_names: Option<Pin<Vec<CString>>>,
> +    genpd_names: Option<Pin<Vec<CString>>>,
> +    supported_hw: Option<Pin<Vec<u32>>>,
> +    required_devs: Option<Pin<Vec<Device>>>,
> +    _data: PhantomData<T>,
> +}

[...]

> +    /// Sets the configuration with the OPP core.
> +    pub fn set(&mut self, dev: &Device) -> Result<()> {
> +        // Already configured.
> +        if self.token.is_some() {

Why does the config hold onto this token? Would it make sense to consume
the config and return a `Handle` or `Token` abstraction? Then you don't
need to check if the config has been "used" before.

> +            return Err(EBUSY);
> +        }
> +
> +        let (_clk_list, clk_names) =3D match &self.clk_names {
> +            Some(x) =3D> {
> +                let list =3D to_c_str_array(x)?;
> +                let ptr =3D list.as_ptr();
> +                (Some(list), ptr)
> +            }
> +            None =3D> (None, ptr::null()),
> +        };

[...]

> +/// Operating performance point (OPP).
> +///
> +/// # Invariants
> +///
> +/// `ptr` is valid, non-null, and has a non-zero reference count. One of=
 the references is owned by
> +/// `self`, and will be decremented when `self` is dropped.
> +#[repr(transparent)]
> +pub struct OPP(*mut bindings::dev_pm_opp);

I think you should use the `ARef` pattern instead:

     #[repr(transparent)]
     pub struct OPP(Opaque<bindings::dev_pm_opp>);

     unsafe impl AlwaysRefCounted for OPP {
         // ...
     }

Then you can use `ARef<OPP>` everywhere you use `OPP` currently.

--=20
Cheers,
Benno


