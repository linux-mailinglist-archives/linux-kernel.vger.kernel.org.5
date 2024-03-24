Return-Path: <linux-kernel+bounces-112662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815FF887CB6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D471C20A86
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3F117BB7;
	Sun, 24 Mar 2024 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYMg6VO/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF2B2CA4;
	Sun, 24 Mar 2024 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711282747; cv=none; b=pbGuRqq2nXqSdO9u1zJIHVEHlRBrC6R9KrlO/JNPArfXZpm6l1guHEuRvgBg9RDQHnoPU6W+4sCvLkgiSvmA515jTWmS5ypJQJ2MTLGOuLjdn6dF7EwAyDiH9F2T1emjxKO04l36VVOsJqAZcaC61IxXO+00EgYsbVj0Xm+dEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711282747; c=relaxed/simple;
	bh=+pU0k+ZWilbCia11XhbE7gGOdKY/GmRecul8h9PKu88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQeHp5lpuJRbGHynVivNYMfOYr0wzmmejL2U+rDLvb7+TsK7vF7ZC8K41jK01D+ltDA7kyOLzH825YP3J97WuMYv6yaJhyO4YO+3WnFi1Ei2YylANc5pdlJ+kjDvEZBjGzGASD/mVGbk+myIDTXxUOXXRwom9dckqBn/6odCEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYMg6VO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E44C433C7;
	Sun, 24 Mar 2024 12:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711282747;
	bh=+pU0k+ZWilbCia11XhbE7gGOdKY/GmRecul8h9PKu88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YYMg6VO/64puC/UfwZMRjYpEiwE10K9N5zInYwqr9GFBeEjm9EIgT2f04QGJ4WeYC
	 6A+jillw6tEA3Y0HS56QKe8LahS8ev7njVTBVN4Qqjaeb/+w9WfntMLFzjpR9NK3O0
	 6u1UbMxKNfCO4vJ6q834jG31nz3LMutzsdjRKm0fXrfy70nn/y0QsZHTXjbhRO7kR6
	 Jh4qaF353ifpq8CmzsCj7w19wODa3f72Z5W9OwQ5Tm5b184/ux03gbGtYqFp+OZ/RS
	 mDebvOoBO8+CiRW8mZzkNkgNl/I8bo1a5HA6r9FEoZ1z7rocdlxchm7zt4mMSdA9Ex
	 AE26KNGlwVrBA==
Date: Sun, 24 Mar 2024 12:18:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7944: simplify adi,spi-mode property
 parsing
Message-ID: <20240324121853.460ba5f8@jic23-huawei>
In-Reply-To: <Zf8_NZ5cNb9TVThx@surfacebook.localdomain>
References: <20240319-ad7944-cleanups-v2-1-50e77269351b@baylibre.com>
	<CAHp75VeO_=r_pMBUTaQQYKDRAV-OVfTnPYPwV8f7KDzOhaBCvQ@mail.gmail.com>
	<CAMknhBETEP123=EHycGtFEJjQ+NPssLXmw9ZdDoY8CRsWiSxVQ@mail.gmail.com>
	<20240323182918.2cf624b6@jic23-huawei>
	<Zf8_NZ5cNb9TVThx@surfacebook.localdomain>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 23 Mar 2024 22:44:37 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Sat, Mar 23, 2024 at 06:29:18PM +0000, Jonathan Cameron kirjoitti:
> > On Tue, 19 Mar 2024 10:28:31 -0500
> > David Lechner <dlechner@baylibre.com> wrote: =20
> > > On Tue, Mar 19, 2024 at 10:01=E2=80=AFAM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote: =20
> > > > On Tue, Mar 19, 2024 at 4:28=E2=80=AFPM David Lechner <dlechner@bay=
libre.com> wrote:   =20
>=20
> ...
>=20
> > > > > +       ret =3D device_property_match_property_string(dev, "adi,s=
pi-mode",
> > > > > +                                                   ad7944_spi_mo=
des,
> > > > > +                                                   ARRAY_SIZE(ad=
7944_spi_modes));
> > > > > +       if (ret < 0) {
> > > > > +               if (ret !=3D -EINVAL)
> > > > > +                       return dev_err_probe(dev, ret,
> > > > > +                                            "getting adi,spi-mod=
e property failed\n");   =20
> > > >   =20
> > > > > -               adc->spi_mode =3D ret;
> > > > > -       } else {   =20
> > > >
> > > > Actually we may even leave these unchanged
> > > >   =20
> > > > >                 /* absence of adi,spi-mode property means default=
 mode */
> > > > >                 adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;
> > > > > +       } else {
> > > > > +               adc->spi_mode =3D ret;
> > > > >         }   =20
> > > >
> > > >        ret =3D device_property_match_property_string(dev, "adi,spi-=
mode",
> > > >                                                    ad7944_spi_modes,
> > > >
> > > > ARRAY_SIZE(ad7944_spi_modes));
> > > >        if (ret >=3D 0) {
> > > >                adc->spi_mode =3D ret;
> > > >        } else if (ret !=3D -EINVAL) {
> > > >                        return dev_err_probe(dev, ret,
> > > >                                             "getting adi,spi-mode
> > > > property failed\n");
> > > >        } else {
> > > >                /* absence of adi,spi-mode property means default mo=
de */
> > > >                adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;
> > > >        }
> > > >
> > > > But I can admit this is not an often used approach.
> > > >   =20
> > >=20
> > > I think Jonathan prefers to have the error path first, so I would like
> > > to wait and see if he has an opinion here. =20
> > I do prefer error paths first.  Thanks. =20
>=20
> Still the above can be refactored to have one line less
>=20
> 	ret =3D device_property_match_property_string(dev, "adi,spi-mode",
>                                                     ad7944_spi_modes,
> 						    ARRAY_SIZE(ad7944_spi_modes));
> 	if (ret =3D=3D -EINVAL) {
> 		/* absence of adi,spi-mode property means default mode */
> 		adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;
> 	} else if (ret < 0) {
> 		return dev_err_probe(dev, ret, "getting adi,spi-mode property failed\n"=
);
> 	} else {
> 		adc->spi_mode =3D ret;
>         }
>=20
True.  I'll take a patch doing that, but I'm not going to tweak
it again directly.

Thanks,

Jonathan


