Return-Path: <linux-kernel+bounces-24445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A3882BCA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1DC1F235A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D765555C06;
	Fri, 12 Jan 2024 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="RWiNGh+S"
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652F56B64
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=xxLKZfR9ym3NvYaTuybR8pXKjRLGsluBabcSdUsoEsA=;
	b=RWiNGh+SiP6oLepQrpQjzq3eyHcLtAafx5MtVsKMs41YlrxI7ZDYzsTEha7a/lscDptg/p8X4EdNG
	 9hQHbb2LuE7Uk1+KOJb52iF4rkGv8v+U7irlFstAzWwblSFHHr2kpCLv5LttCQbC8I/DuV8lypwLrh
	 ukPzt5VNY2e2ta05CYqQUJAH0lh4v4mRXfhbqHUzUwUEsaL5xOd6FZht0tZo7804cM4GnZ8H4fkHME
	 9tjzvQNDu11r7Dk167wVVYPb2lT9z6zget+3lO/HDjuihwGjq7rM4uTW1V/4ij56Th+HnhrF5tgdI+
	 3RE2mITMqmCDX8kcE8XPiaFC3Rp4+mw==
X-MSG-ID: 7eeba78f-b129-11ee-ba53-0050568164d1
Date: Fri, 12 Jan 2024 10:03:47 +0100
From: David Jander <david@protonic.nl>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Frank Rowand <frowand.list@gmail.com>, Thierry Reding
 <thierry.reding@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] spi: add core support for controllers with
 offload capabilities
Message-ID: <20240112100347.548298e9@erd003.prtnl>
In-Reply-To: <829ac770-1955-45b7-9033-6ed60ffdf77e@sirena.org.uk>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	<20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
	<2c74aad9-3cb9-4222-8072-e72120c2658e@sirena.org.uk>
	<CAMknhBGMRed9vDrDAuPJ5DnEe6MyHzd0VBebp5OaLX2Q+AyhMQ@mail.gmail.com>
	<CAMknhBE-1Khe9J-n5WQnH=mFnN0ukiq7=F-SEOU6J-2_u-R0bw@mail.gmail.com>
	<829ac770-1955-45b7-9033-6ed60ffdf77e@sirena.org.uk>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Hi Mark, David,

Thanks for CC'ing me. Been reading the discussion so far.

On Thu, 11 Jan 2024 21:49:53 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Jan 11, 2024 at 03:32:54PM -0600, David Lechner wrote:
> > On Thu, Jan 11, 2024 at 2:54=E2=80=AFPM David Lechner <dlechner@baylibr=
e.com> wrote: =20
>=20
> > > > (CCed) a while back when he was doing all the work he did on optimi=
sing
> > > > the core for uncontended uses, the thinking there was to have a
> > > > spi_prepare_message() (or similar) API that drivers could call and =
then
> > > > reuse the same transfer repeatedly, and even without any interface =
for
> > > > client drivers it's likely that we'd be able to take advantage of i=
t in
> > > > the core for multi-transfer messages.  I'd be surprised if there we=
ren't
> > > > wins when the message goes over the DMA copybreak size.  A much wid=
er
> > > > range of hardware would be able to do this bit, for example David's=
 case
> > > > was a Raspberry Pi using the DMA controller to write into the SPI =
=20
>=20
> > For those, following along, it looks like the RPi business was
> > actually a 2013 discussion with Martin Sperl [2]. Both this and [1]
> > discuss proposed spi_prepare_message() APIs. =20
>=20
> > [2]: https://lore.kernel.org/linux-spi/CACRpkdb4mn_Hxg=3D3tuBu89n6eyJ08=
2EETkwtNbzZDFZYTHbVVg@mail.gmail.com/T/#u =20
>=20
> Oh, yes - sorry, I'd misremembered which optimisation effort it was
> associated with.  Apologies.

Yes. It was Martin Sperl who proposed this on a Rpi. I mentioned something
similar toward the end of my 2nd email reply in that thread [1]. That might
have triggered the confusion.
As for my interests, I am all for devising ways to make the SPI subsystem m=
ore
suitable for optimized high-performance use-cases. In that regard, I think
re-usable messages (spi_prepare_message()) can be useful. More capable
hardware can enable very powerful use-cases for SPI, and it would be cool if
the spi subsystem had the needed infrastructure to support those. As for
hardware-triggers, I still need to wrap my head around how to have a
universally usable API that works nice for the first use-case that comes al=
ong
and also doesn't screw up the next use-case that might follow. Keep me post=
ed.

[1] https://lore.kernel.org/linux-spi/20220513144645.2d16475c@erd992/

Best regards,

--=20
David Jander
Protonic Holland.

