Return-Path: <linux-kernel+bounces-71865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC37985ABFE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A821F21FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A371950A7E;
	Mon, 19 Feb 2024 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMwfb1Vf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501A44C9C;
	Mon, 19 Feb 2024 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371065; cv=none; b=rLMr1bFDY86nFDG3n730NruDv8/0Fk+PgJftfCOVHw3XLRPlza1+nDT6w5AgYBL4kk9a+Qf128yMIT6Axh0dDJ8F+SizfBUQ0B4R3tq3dSaomYrUFCcX4n41jBuOYp2WmhhHbE4qjSEjkFQ4pUMwfQdsqGONPI4a1U9hRkSjInc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371065; c=relaxed/simple;
	bh=aCehUjfWEY7bQPfSj3Tb0qCMOgqCa/Po76xaUWvsbVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCUs9b2XTGz0eW8I3q3CPd9fEx28GySL4AQw8ouIcv53EMr2y8FWMi8AwljKoYkaFdjnfMF8gPOFa/zoGxCzH2KMYjZ8crGxPc1OBZK3hkTBofSaMy2QL/R+k7vtUpjN/fdz8sD4Gy3Y6lVPYkYaHXHCjT+Y7uBQNu+1tOeutOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMwfb1Vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0477AC433C7;
	Mon, 19 Feb 2024 19:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371065;
	bh=aCehUjfWEY7bQPfSj3Tb0qCMOgqCa/Po76xaUWvsbVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oMwfb1VfyFP9Q1/vl+7kNcmfMzYqLM2mJo8IHs0U530Cq47PFKM0HjHQNDlV7IafK
	 4xTiqqn8xk8NCvLT/dXZV9FV6QpE1rqZpmBeBrjs1h+ixkYRlNHPCkvac65xWWNANp
	 XKDKTzoPN7exX5iQGJAjA1crnJ51a/nUPKxfa883BfVwdWzJb6wrormyRPp3nlX7kx
	 /BxzGA/JrPibw+Ft5bKmzdU00ml4Doso/p/Jppug6k4HV8g436nbT6RdvKpbeUP31h
	 A/6QpTps3kbQwLwi3Y8rfjDVQLyEt/4sRJg/mEBZgxo6AhXz5mYQ0PRQrpo/SyHI1t
	 Rt+pqwsoI/uoQ==
Date: Mon, 19 Feb 2024 19:30:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>,
 alexandru.tachici@analog.com, alisa.roman@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
 krzysztof.kozlowski@linaro.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
 robh+dt@kernel.org, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v3 5/5] iio: adc: ad7192: Add AD7194 support
Message-ID: <20240219193048.32ecd88b@jic23-huawei>
In-Reply-To: <CAMknhBEtz_fSR8gaT_ew5Tk-Q5r7WjbW6q8GqHG7EFN4WZcDhg@mail.gmail.com>
References: <20240208172459.280189-1-alisa.roman@analog.com>
	<20240208172459.280189-6-alisa.roman@analog.com>
	<CAMknhBHU6k8J_PLCmGYF48S1q3uXByiCwzcd+B3q3Cd-02CUow@mail.gmail.com>
	<84546728-f0cb-4b38-a71c-e053b9b9278e@gmail.com>
	<CAMknhBFp-4s+-D8kD9rh0-OCc3gBs3hFX1EZ9ZmOifQOyGgUug@mail.gmail.com>
	<CAMknhBEtz_fSR8gaT_ew5Tk-Q5r7WjbW6q8GqHG7EFN4WZcDhg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2024 10:33:45 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On Thu, Feb 15, 2024 at 11:13=E2=80=AFAM David Lechner <dlechner@baylibre=
com> wrote:
> >
> > On Thu, Feb 15, 2024 at 7:22=E2=80=AFAM Alisa-Dariana Roman
> > <alisadariana@gmail.com> wrote: =20
> > >
> > > Hello and thank you for the feedback!
> > >
> > > On 09.02.2024 00:27, David Lechner wrote: =20
> > > > On Thu, Feb 8, 2024 at 11:25=E2=80=AFAM Alisa-Dariana Roman
> > > > <alisadariana@gmail.com> wrote: =20
> > > >>
> > > >> Unlike the other AD719Xs, AD7194 has configurable differential
> > > >> channels. The default configuration for these channels can be chan=
ged
> > > >> from the devicetree. =20
> > >
> > > ...
> > > =20
> > > >>
> > > >> +static const struct iio_info ad7194_info =3D {
> > > >> +       .read_raw =3D ad7192_read_raw,
> > > >> +       .write_raw =3D ad7192_write_raw,
> > > >> +       .write_raw_get_fmt =3D ad7192_write_raw_get_fmt,
> > > >> +       .read_avail =3D ad7192_read_avail,
> > > >> +       .validate_trigger =3D ad_sd_validate_trigger,
> > > >> +       .update_scan_mode =3D ad7192_update_scan_mode,
> > > >> +}; =20
> > > >
> > > > Isn't this identical to ad7192_info and ad7195_info now that .attrs=
 is
> > > > removed? It seems like we could consolidate here. =20
> > >
> > > Those are not exactly identical since: 92 has bridge switch attribute,
> > > 95 has bridge switch and ac excitation attributes and 94 has no custom
> > > attributes. I used a different info structure for 94 in order to avoid
> > > showing extra attributes.
> > > =20
> >
> > Ah, I see what you mean. I didn't look close enough at the other patch
> > removing one attribute to see that were still other attributes.
> > =20
> > > > =20
> > > >> +
> > > >>   static const struct iio_info ad7195_info =3D {
> > > >>          .read_raw =3D ad7192_read_raw,
> > > >>          .write_raw =3D ad7192_write_raw,
> > > >> @@ -1009,6 +1049,80 @@ static const struct iio_chan_spec ad7193_ch=
annels[] =3D {
> > > >>          IIO_CHAN_SOFT_TIMESTAMP(14),
> > > >>   };
> > > >>
> > > >> +static struct iio_chan_spec ad7194_channels[] =3D {
> > > >> +       AD7193_DIFF_CHANNEL(0, 1, 2, 0x001),
> > > >> +       AD7193_DIFF_CHANNEL(1, 3, 4, 0x023),
> > > >> +       AD7193_DIFF_CHANNEL(2, 5, 6, 0x045),
> > > >> +       AD7193_DIFF_CHANNEL(3, 7, 8, 0x067),
> > > >> +       AD7193_DIFF_CHANNEL(4, 9, 10, 0x089),
> > > >> +       AD7193_DIFF_CHANNEL(5, 11, 12, 0x0AB),
> > > >> +       AD7193_DIFF_CHANNEL(6, 13, 14, 0x0CD),
> > > >> +       AD7193_DIFF_CHANNEL(7, 15, 16, 0x0EF),
> > > >> +       AD719x_TEMP_CHANNEL(8, AD7194_CH_TEMP),
> > > >> +       AD7193_CHANNEL(9, 1, AD7194_CH_AIN1),
> > > >> +       AD7193_CHANNEL(10, 2, AD7194_CH_AIN2),
> > > >> +       AD7193_CHANNEL(11, 3, AD7194_CH_AIN3),
> > > >> +       AD7193_CHANNEL(12, 4, AD7194_CH_AIN4),
> > > >> +       AD7193_CHANNEL(13, 5, AD7194_CH_AIN5),
> > > >> +       AD7193_CHANNEL(14, 6, AD7194_CH_AIN6),
> > > >> +       AD7193_CHANNEL(15, 7, AD7194_CH_AIN7),
> > > >> +       AD7193_CHANNEL(16, 8, AD7194_CH_AIN8),
> > > >> +       AD7193_CHANNEL(17, 9, AD7194_CH_AIN9),
> > > >> +       AD7193_CHANNEL(18, 10, AD7194_CH_AIN10),
> > > >> +       AD7193_CHANNEL(19, 11, AD7194_CH_AIN11),
> > > >> +       AD7193_CHANNEL(20, 12, AD7194_CH_AIN12),
> > > >> +       AD7193_CHANNEL(21, 13, AD7194_CH_AIN13),
> > > >> +       AD7193_CHANNEL(22, 14, AD7194_CH_AIN14),
> > > >> +       AD7193_CHANNEL(23, 15, AD7194_CH_AIN15),
> > > >> +       AD7193_CHANNEL(24, 16, AD7194_CH_AIN16), =20
> > > >
> > > > Shouldn't these be differential channels since they are
> > > > pseudo-differential inputs measuring the difference between AINx and
> > > > AINCOM?
> > > > =20
> > > >> +       IIO_CHAN_SOFT_TIMESTAMP(25),
> > > >> +}; =20
> > > >
> > > > i.e. like this (where AINCOM is voltage0 AINx is voltagex)
> > > >
> > > > static struct iio_chan_spec ad7194_channels[] =3D {
> > > >         AD7193_DIFF_CHANNEL(0, 1, 0, AD7194_CH_AIN1),
> > > >         AD7193_DIFF_CHANNEL(1, 2, 0, AD7194_CH_AIN2),
> > > >         AD7193_DIFF_CHANNEL(2, 3, 0, AD7194_CH_AIN3),
> > > >         AD7193_DIFF_CHANNEL(3, 4, 0, AD7194_CH_AIN4),
> > > >         AD7193_DIFF_CHANNEL(4, 5, 0, AD7194_CH_AIN5),
> > > >         AD7193_DIFF_CHANNEL(5, 6, 0, AD7194_CH_AIN6),
> > > >         AD7193_DIFF_CHANNEL(6, 7, 0, AD7194_CH_AIN7),
> > > >         AD7193_DIFF_CHANNEL(7, 8, 0, AD7194_CH_AIN8),
> > > >         AD7193_DIFF_CHANNEL(8, 9, 0, AD7194_CH_AIN9),
> > > >         AD7193_DIFF_CHANNEL(9, 10, 0, AD7194_CH_AIN10),
> > > >         AD7193_DIFF_CHANNEL(10, 11, 0, AD7194_CH_AIN11),
> > > >         AD7193_DIFF_CHANNEL(11, 12, 0, AD7194_CH_AIN12),
> > > >         AD7193_DIFF_CHANNEL(12, 13, 0, AD7194_CH_AIN13),
> > > >         AD7193_DIFF_CHANNEL(13, 14, 0, AD7194_CH_AIN14),
> > > >         AD7193_DIFF_CHANNEL(14, 15, 0, AD7194_CH_AIN15),
> > > >         AD7193_DIFF_CHANNEL(15, 16, 0, AD7194_CH_AIN16),
> > > >         AD719x_TEMP_CHANNEL(16, AD7194_CH_TEMP),
> > > >         IIO_CHAN_SOFT_TIMESTAMP(17),
> > > > };
> > > > =20
> > >
> > > I tried to follow the existing style of the driver: for each
> > > pseudo-differential channel(AINx - AINCOM) there is an iio channel li=
ke
> > > this in_voltagex_raw; and for each differential channel(AINx - AINy)
> > > there is an iio channel like this in_voltagex-in_voltagey_raw. AD7194
> > > has 16 pseudo-differential channels/8 fully differential channels so I
> > > thought the (AINx - AINCOM) channels should be static and only the 8
> > > differential ones could be configured by the user from the devicetree=
 by
> > > choosing the input pins.
> > >
> > > The existing style of the driver, AD7192 has 4 pseudo differential
> > > channels and 2 (non configurable) differential channels:
> > > static const struct iio_chan_spec ad7192_channels[] =3D {
> > >         AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
> > >         AD719x_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M),
> > >         AD719x_TEMP_CHANNEL(2, AD7192_CH_TEMP),
> > >         AD719x_DIFF_CHANNEL(3, 2, 2, AD7192_CH_AIN2P_AIN2M),
> > >         AD719x_CHANNEL(4, 1, AD7192_CH_AIN1),
> > >         AD719x_CHANNEL(5, 2, AD7192_CH_AIN2),
> > >         AD719x_CHANNEL(6, 3, AD7192_CH_AIN3),
> > >         AD719x_CHANNEL(7, 4, AD7192_CH_AIN4),
> > >         IIO_CHAN_SOFT_TIMESTAMP(8),
> > > };
> > >
> > > Would it be better to respect the existing style or to do like you
> > > suggested and have a total of 16 differential channels that are
> > > configurable from the device tree? =20
>=20
>=20
> Now that we have it sorted that AINCOM should be a supply, it does
> sound like we should more closely follow the pattern from AD7192. But
> to cover every possible programmable combination of AINx to AINy, we
> would need 256 differential channels (16 * 16) in addition to the
> other channels. Realistically, we probably don't need that many
> though. Since I see that AD7192 has a differential channel where uses
> AIN2 for both + and - I guess having 16 differential channels that are
> configured via device tree would be enough to allow all 16 AINx inputs
> to be used this way. Is there a use case where the same AINx would be
> assigned to multiple channels at the same time?

If there are very large numbers of options, common solution is to
move to dynamic assignment and channel nodes so DT specifies what is
wired.  In theory we then allow all combinations at the same time but
rely on common sense to restrict it.  I don't suggest channel nodes
for most drivers because it adds complexity and a few unwired channels
being exposed is rarely a problem (mostly people buy the right sized ADC).
For cases like this though it can reduce things to a manageable level.

Also little purpose in supporting 1-2 and 2-1 which can simplify things
somewhat. However that can also be left unconstrained on assumption
common sense will be exercised in the DT.


>=20
> >
> > Looking at Table 20 in the AD7192 datasheet, I can see why AD7192 was
> > done this way since only certain combinations of inputs can be used
> > together. (Although I think indexes 4 to 7 should really be
> > differential because they are the difference between the input and
> > AINCOM which may not be GND, but it is probably too late to fix that.)
> >
> > Tables 22, 23 and 24 in the AD7194 datasheet show that this chip is
> > much more configurable than AD7192 when it comes to assigning
> > channels. There are basically no restrictions on which inputs can be
> > used together. So I am still confident that my suggestion is the way
> > to go for AD7194. (Although I didn't actually try it on hardware, so
> > can't be 100% confident. But at least 90% confident :-p) =20


