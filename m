Return-Path: <linux-kernel+bounces-134325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE46589B057
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D421B218A9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F99118C19;
	Sun,  7 Apr 2024 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ke+OHFQ/"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F217550;
	Sun,  7 Apr 2024 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712485085; cv=none; b=hsjz3m0NUy//pIQYMebtyKQwk/Dta+HQZYmluOLDQsd82YhPiVAKa2RNkXMQnCqn1IxMRxXMSBu1dryCTGLL1mmxOq7D546AldEiEWUgnIPogKu3WPAKxp0Yql0VabqRCs7K8KWG4o9I0KwxXPwNQ+my9Ki6y2QRD9vOGGPVzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712485085; c=relaxed/simple;
	bh=PyzTbx+EV6uWhguY3E9lMN77MG5Dy/bTtQbGz1gti+w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRon2cFjhcGcYH09J5Yu2xPeLCS2wiRVTzdQAvMo4NJ6rVciCb8EPhUqyUA0Z4gdy2fqx+ZkoSFUoVvmklnY1b98vILEdLKROSwCqPk/LOmv56u4RcRAcrwmXuD4KvKaU+fEfCx++E3UTFuZsHz9Or6fDiGPJe96RNymJTrCIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ke+OHFQ/; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=sxa7bzw2fvhc3ioreindctqiwm.protonmail; t=1712485080; x=1712744280;
	bh=O29HBNf2ylU05p6urIS325zaON00H83jAr3bRLHuDus=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ke+OHFQ/1+90MhQrbMijafNQVoXGtkbC3xHr7bZqlVz2VzMazx7jqgD24er9PZmOu
	 pDf78eAlOsmXSK0pikaqX00fttn7yWvZdS/XXgmoVNPTKyyPYh1vTI6arG3zUaG5X2
	 kXTuPPXv0WQF0eaXQiUKQQbKFwCgeKNcGDrEPhtN4TNKwmG+2b6rQEnPrlkKG9LMoP
	 LJNONaYvi9zA89gK0Wg7YU1qZ24cHV0BS1WJw9uQizbefXnDKqJcZ4iQhkLsbERZvy
	 6ujujOTbTVMX6s5VKLyYdqcnfX6ceXWLpvcRxPBaGm47TEYIemXmIX3QIgXe5xTv8v
	 E9GxjE5BPUiFg==
Date: Sun, 07 Apr 2024 10:17:52 +0000
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <8c4f2053-acbc-4f4a-93de-18f149c80869@proton.me>
In-Reply-To: <4ff5f30b-f2b8-4625-b3cd-ac08e4ffb068@proton.me>
References: <cover.1712314032.git.viresh.kumar@linaro.org> <1792467a772b7a8355c6d0cb0cbacfbffff08afd.1712314032.git.viresh.kumar@linaro.org> <4ff5f30b-f2b8-4625-b3cd-ac08e4ffb068@proton.me>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.04.24 11:54, Benno Lossin wrote:
> On 05.04.24 13:09, Viresh Kumar wrote:
>> +// Finds exact supply name from the OF node.
>> +fn find_supply_name_exact(np: *mut bindings::device_node, name: &str) -=
> Option<CString> {
>> +    let sname =3D CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
>> +
>> +    // SAFETY: The OF node is guaranteed by the C code to be valid.
>> +    let pp =3D unsafe { bindings::of_find_property(np, sname.as_ptr() a=
s *mut _, ptr::null_mut()) };
>=20
> Drivers should avoid calling `unsafe` code as much as possible. They
> also should not be calling `bindings` code directly. Please write (or
> find) abstractions for these `unsafe` calls.

Having re-read the cover letter, I see that you are already aware of
this. If you need any help with creating the abstractions, feel free to
reach out!

--=20
Cheers,
Benno


