Return-Path: <linux-kernel+bounces-134313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A374289B02F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C9D1F215D8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A451C69E;
	Sun,  7 Apr 2024 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MYK1Z1b2"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79AF101E2
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712483670; cv=none; b=IGJ/2Rufjkn23hFWEfHAVJPCqWUlip9YM9qmxFQ2kGMvfjZNB4n3CaHTS39g2qJkYiPxIaBksFE7DAkOeZXAx4PCmD856PB1gN/00Ex0ILH/GMh8EJuXX47Wnz1VtPK5XE4FLy+vqHan/wCTiUWNWGofHmrEK4/200h5XPoqIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712483670; c=relaxed/simple;
	bh=rJcdmdSVaCU80ztqbZrjQkcR0aAJtLC4psVNrXmv+os=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKnL1IBDK51EMqSKzts10H9bhratuujYsZjvI1dTJB9F+0vFAMe3WEcss1eXaq9hAt9hVu4fEX94JhouNK4MnE7cV/BhwImsuzpA/tYtFMda1gVfKKpWsZy9zSkx5GsbiwfEUSgAmTr2j3sQzGMChMYLoEH4ygFYT40XwOYfAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MYK1Z1b2; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712483666; x=1712742866;
	bh=8YZS8eu/oWRcKM7mzkufE33UHJldzqwP/IUT97Ck+U8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MYK1Z1b2S7tyd+lWOKFF1lJUt5Nf0YKgLQis4kkW0p0q3IGOs263WaOyQAJFKuCO+
	 U0Pwn5PPgZ0CpQKxJICDRSoa0nr6hrnYBgXUztWL35ZHiGJBxvojxRDNPLpIiDQ/Ep
	 d9RJY7NqWtRYfqZSuXBxMuEIIryPMP6WCbmMZkYbK6WPhXdTS9xosvMi95FkEIZHbN
	 kjTwMtbzo+XSbSobQDoX6+i3+NfslCtKPb4toLrlWdYXcICviA/RBLY1nnJUa6vtrs
	 2p8fjvGMvtPuO5B+UNLXWCOoDITUXsVf4E18RCeHMWfbCitY/WzRGheZEBkuMP3463
	 bzpeG9vAp0VSw==
Date: Sun, 07 Apr 2024 09:54:22 +0000
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <4ff5f30b-f2b8-4625-b3cd-ac08e4ffb068@proton.me>
In-Reply-To: <1792467a772b7a8355c6d0cb0cbacfbffff08afd.1712314032.git.viresh.kumar@linaro.org>
References: <cover.1712314032.git.viresh.kumar@linaro.org> <1792467a772b7a8355c6d0cb0cbacfbffff08afd.1712314032.git.viresh.kumar@linaro.org>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.04.24 13:09, Viresh Kumar wrote:
> +// Finds exact supply name from the OF node.
> +fn find_supply_name_exact(np: *mut bindings::device_node, name: &str) ->=
 Option<CString> {
> +    let sname =3D CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
> +
> +    // SAFETY: The OF node is guaranteed by the C code to be valid.
> +    let pp =3D unsafe { bindings::of_find_property(np, sname.as_ptr() as=
 *mut _, ptr::null_mut()) };

Drivers should avoid calling `unsafe` code as much as possible. They
also should not be calling `bindings` code directly. Please write (or
find) abstractions for these `unsafe` calls.

--=20
Cheers,
Benno

> +    if pp.is_null() {
> +        None
> +    } else {
> +        CString::try_from_fmt(fmt!("{}", name)).ok()
> +    }
> +}


