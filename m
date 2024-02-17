Return-Path: <linux-kernel+bounces-69962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CEE8590E1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A639282579
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4507CF2D;
	Sat, 17 Feb 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6GDmaEz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72503657AF;
	Sat, 17 Feb 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187126; cv=none; b=iFFhhUn9qp+4A6HYnqfPLE7Euz5JWeP1jCNvR7O/P7ui8R8pRXB68V//GoM7OWML/uOux9+pI0dqyMDkma+2dKCDJeVyjOlaU6kYAn96kw/xpD7/WHkBEMXlRPhwMPW0/AMSyDqCakCmKD2GuADv2aB+4XAKcFGa4BiV83TS+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187126; c=relaxed/simple;
	bh=q0KAwiquKdamki/N1WpUyiHvK30Fp2G7BM3OnIa7uko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lf7q/zBOMJZqV0wNN7nTb1fVI7YCWLtusj+fSgfaVj9PFKMMlfWti0dZihEGoAC9I2NKbL3fe7ZVGAJJoGzUdqbsNrSc0CgswtIYrd+wt5r/djCBwpdpvuzKz2hDWHipEdiQPgSAVRgxBQRJnNvx0gahb6XkTyu5NUxElh0b4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6GDmaEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091D6C433C7;
	Sat, 17 Feb 2024 16:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708187126;
	bh=q0KAwiquKdamki/N1WpUyiHvK30Fp2G7BM3OnIa7uko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e6GDmaEzwJjaM2xsUo57vl7imy+sZ/vyxRer5rVkM0Pz+hGRjEN0JNzo5/8me/mYy
	 ZHbLebQrvoL1j9oWJ6An2d7vCe5tlL3wPooPjvKnzqe3Ln1dmRBeY/aymnxL5NSxjC
	 KOTg2s91kb2e4f9p4CKze+drobkZkjYkg85k0R4tdmFtKrR3YoRBcUCnW0Wdp5eZ4I
	 g1DvmG23tXqTfahmBWH851HyKcsWxmZcjjhWlJPv7PVaFcafh8nGNach3+VX912lTj
	 NIs8dc0zWMrvNXeWXWWcucdxNstd/uo1oxUbBR2pWEmIOqZBs9MPa0TuTNrwAYzGax
	 3+xXX0i8GTSHw==
Date: Sat, 17 Feb 2024 16:25:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>,
 alexandru.tachici@analog.com, alisa.roman@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
 krzysztof.kozlowski@linaro.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
 robh+dt@kernel.org, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v3 5/5] iio: adc: ad7192: Add AD7194 support
Message-ID: <20240217162510.5d5d4511@jic23-huawei>
In-Reply-To: <CAMknhBEtLR1QNEv6HhcW35jiGEkx=srzy41NXt8bJ=gokzoemw@mail.gmail.com>
References: <20240208172459.280189-1-alisa.roman@analog.com>
	<20240208172459.280189-6-alisa.roman@analog.com>
	<CAMknhBHU6k8J_PLCmGYF48S1q3uXByiCwzcd+B3q3Cd-02CUow@mail.gmail.com>
	<84546728-f0cb-4b38-a71c-e053b9b9278e@gmail.com>
	<CAMknhBFp-4s+-D8kD9rh0-OCc3gBs3hFX1EZ9ZmOifQOyGgUug@mail.gmail.com>
	<20240216142158.30e96c53@jic23-huawei>
	<CAMknhBEtLR1QNEv6HhcW35jiGEkx=srzy41NXt8bJ=gokzoemw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Feb 2024 10:57:33 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Fri, Feb 16, 2024 at 8:22=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Thu, 15 Feb 2024 11:13:19 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> > =20
>=20
> ...
>=20
> > >
> > > Tables 22, 23 and 24 in the AD7194 datasheet show that this chip is
> > > much more configurable than AD7192 when it comes to assigning
> > > channels. There are basically no restrictions on which inputs can be
> > > used together. So I am still confident that my suggestion is the way
> > > to go for AD7194. (Although I didn't actually try it on hardware, so
> > > can't be 100% confident. But at least 90% confident :-p) =20
> >
> > You would have to define a channel number for aincom.  There is an expl=
icit
> > example in the datasheet of it being at 2.5V using a reference supply.
> >
> > I wonder what expectation here is.  Allways a reference regulator on th=
at pin, or
> > an actually varying input? Maybe in long term we want to support both
> > options - so if aincom-supply is provided these are single ended with
> > an offset, but if not they are differential channels between channel X =
and
> > channel AINCOM.
> >
> > Note though that this mode is described a pseudo differential which nor=
mally
> > means a fixed voltage on the negative.
> >
> > So gut feeling from me is treat them as single ended and add an
> > aincom-supply + the offsets that result if that is provided in DT and
> > voltage from it is non 0. =20
>=20
> Calling AINCOM a supply doesn't sound right to me since usually this
> signal is coming somewhere external, i.e. you have a twisted pair
> connected to AIN1 and AINCOM going to some signal source that may be
> hot-pluggable and not known at compile time. As an example, if AINCOM
> was modeled as a supply, then we would have to change the device tree
> every time we changed the voltage offset on the signal generator while
> we are testing using an evaluation board.

We tend to stick away from designing features to support testing with
devboards where external wiring is involved because anything could be
wired up there. (Examples are things like shunt resistors - normally
they are DT only) So sometimes it's a bit painful to work with such boards.
The main focus has to be production devices or at least stable set ups
where a fixed DT is sufficient.

So I'm more interested in focusing on production device use cases.
Do we have an information on how this is this used in those environments?

Jonathan


