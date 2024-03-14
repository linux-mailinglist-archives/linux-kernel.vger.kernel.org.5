Return-Path: <linux-kernel+bounces-103522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CE987C08E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCAE1F220ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D49271B51;
	Thu, 14 Mar 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4lUgtH2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B371723;
	Thu, 14 Mar 2024 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430911; cv=none; b=UBPW0sDAAnmWTzT1NB96vn12qQBCv/9waCjFLUc312MNSGa1UrpocPpq8q4cZoiSUBnKff3NMpSpqZFsewAeP+7LA3Hvh/qBeiQU5YdUiiBi2aisYMHV8SvfTa1Gcja3dJXT01Pea3jMSdSm4APp/CAXUDYAukCHxO/1AFqrUIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430911; c=relaxed/simple;
	bh=eUVCx3NdID6p/BA28jS+KfLIL/YiKtdyVU65SQqdyP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=raenhc1SNJWoptdrkgl5g7y+XuEQQ2LFgvdB97MQIdRQP4Uko5LiUArlPbjZ6t8Ak+CjlZ+3cqlI10ZWGIvDMCJrPzELmDrUiUw8DHeA4LjIMRRZs9RusyLYiJLUz+iP86bR6QDSgxA1x0dmWyzYjmak2PRU7s1d8MimIWgxIkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4lUgtH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8297C433C7;
	Thu, 14 Mar 2024 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710430911;
	bh=eUVCx3NdID6p/BA28jS+KfLIL/YiKtdyVU65SQqdyP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d4lUgtH2H7p8HGTKr2Vre3wTxWY3ug1n2ud4wFKUe3aGfZNrtU1C9j+NQGQD+aYzv
	 nINVHcmPT2/rG26sWiqBfK8BiEMiPANgjxrgDTf5yDTbdzOiaZDumQe7Kf75C/EfOp
	 24Qtv82XKL34t1VBC8XfCzus3dlb/NOYz4mJCHw1FhoKCOz+hM71gAMHthPEoWGZhP
	 9tlU8LdJf3IgFy3aoSx2XpXS8pM7Y90+LcYUd3V0RrkUJxt8XVBHYxiXOOmkFDXmCf
	 jDHXje5Bu8/rZyeo9s24l/yD1Ss9U1QazBk6PDheDkG8O+Jht0ONwkMLOS1A1BWucs
	 Dm7er3uFJsjpA==
Date: Thu, 14 Mar 2024 15:41:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7944: Add support for "3-wire mode"
Message-ID: <20240314154137.2fdf82ba@jic23-huawei>
In-Reply-To: <CAMknhBE8OwrtbJ9xYVZ8ObsZTnxmn9Fpk2a-gj1aCSaN-whDRg@mail.gmail.com>
References: <20240311-mainline-ad7944-3-wire-mode-v1-1-8e8199efa1f7@baylibre.com>
	<8ee551edeff9c4c959a4dbda53d1a2a26a9bb62c.camel@gmail.com>
	<CAMknhBE8OwrtbJ9xYVZ8ObsZTnxmn9Fpk2a-gj1aCSaN-whDRg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Mar 2024 09:13:56 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Tue, Mar 12, 2024 at 4:08=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >
> > On Mon, 2024-03-11 at 16:26 -0500, David Lechner wrote: =20
>=20
> ...
>=20
> > >  /*
> > >   * ad7944_4wire_mode_conversion - Perform a 4-wire mode conversion a=
nd acquisition
> > >   * @adc: The ADC device structure
> > > @@ -167,9 +246,22 @@ static int ad7944_single_conversion(struct ad794=
4_adc *adc,
> > >  {
> > >       int ret;
> > >
> > > -     ret =3D ad7944_4wire_mode_conversion(adc, chan);
> > > -     if (ret)
> > > -             return ret;
> > > +     switch (adc->spi_mode) {
> > > +     case AD7944_SPI_MODE_DEFAULT:
> > > +             ret =3D ad7944_4wire_mode_conversion(adc, chan);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             break;
> > > +     case AD7944_SPI_MODE_SINGLE:
> > > +             ret =3D ad7944_3wire_cs_mode_conversion(adc, chan);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             break;
> > > +     case AD7944_SPI_MODE_CHAIN:
> > > +             return -EOPNOTSUPP; =20
> >
> > This mode is not really supported for now and in theory we can't really=
 have
> > adc->spi_mode =3D AD7944_SPI_MODE_CHAIN, right? So, I would just make t=
his the
> > 'default' branch and not care about chain mode (implementing it when ad=
ding it). =20
>=20
> The compiler was happy with this, but yeah, default: is probably safer.
>=20
> ...
>=20
> > > +     if (!adc->cnv && adc->spi_mode =3D=3D AD7944_SPI_MODE_DEFAULT)
> > > +             return dev_err_probe(&spi->dev, -EINVAL, "CNV GPIO is
> > > required\n");
> > > +     else if (adc->cnv && adc->spi_mode !=3D AD7944_SPI_MODE_DEFAULT)
> > > +             return dev_err_probe(&spi->dev, -EINVAL,
> > > +                                  "CNV GPIO in single and chain mode=
 is not
> > > currently supported\n");
> > > + =20
> >
> > Redundant else... =20
>=20
> yup
>=20
> > =20
> > >       adc->turbo =3D devm_gpiod_get_optional(dev, "turbo", GPIOD_OUT_=
LOW);
> > >       if (IS_ERR(adc->turbo))
> > >               return dev_err_probe(dev, PTR_ERR(adc->turbo),
> > > @@ -369,6 +486,10 @@ static int ad7944_probe(struct spi_device *spi)
> > >               return dev_err_probe(dev, -EINVAL,
> > >                       "cannot have both turbo-gpios and adi,always-tu=
rbo\n");
> > >
> > > +     if (adc->spi_mode =3D=3D AD7944_SPI_MODE_CHAIN && adc->always_t=
urbo)
> > > +             return dev_err_probe(dev, -EINVAL,
> > > +                     "cannot have both chain mode and always turbo\n=
");
> > > + =20
> >
> >
> > I'm fine in having this now but shouldn't we only have the above when w=
e do support
> > chain mode? A bit odd having it when we don't even allow chain mode.
> > =20
>=20
> Yeah, we could wait to add this. It seemed like something easy to
> overlook though if we don't add chain mode right away, so I just went
> ahead and added it now.
Seems reasonable - maybe just mention it in the patch description.

Other than the tidying up Nuno pointed out looks good to me, so I'll pick up
v2 once posted.

Jonathan



