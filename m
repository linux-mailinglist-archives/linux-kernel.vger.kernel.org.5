Return-Path: <linux-kernel+bounces-112445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4618879EF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC94B214AB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB6456770;
	Sat, 23 Mar 2024 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVb3S2e2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF09F1DFEF;
	Sat, 23 Mar 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711218571; cv=none; b=qNKLjKwmpDk0XE1COT8sGmSsIlQELlhISoqQOAUqCbDti5m4GI1x3rw3Rob93DvehqBExA62I8PgORNjUkEkzxp1qIj9e+zFHjzTIInR7vk8nu5jLTEsZuRr5e9YlgZqjsZs+VqN4YHj/OpZHt5KW2GP6tCkvBHs829iWqjYuws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711218571; c=relaxed/simple;
	bh=6yjkejHerchkwYd8HrquKgDGVDNeDah3/MwMAMh7st4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bm0vBT+vj+BZSB6y2vN8kh2v0GCr9Nm6VdGuyVHz/2wO5wT1sllP3Cd9oDjefTKn8Vm5GS6kSsXCeOZ85zJCXyk/MDCns2yBG9Sp82r85Kgu05wwv2Sy3d9qFNQ991k7vntkBg6oe3k33OcPGVX8tQZJDfZt2LW8Frqa9HNWhK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVb3S2e2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17EEC433C7;
	Sat, 23 Mar 2024 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711218571;
	bh=6yjkejHerchkwYd8HrquKgDGVDNeDah3/MwMAMh7st4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EVb3S2e2IORuiDrurXjosYAm4DKSJkOoqGFqw6X39mGmqcjT0bxQssm4gEKYTrBui
	 Cyq5Fj+1XIgAm0OjwTFM6JOaiu+synfdIqFuzyaKs/J5f3GFZlMIeR9GLNpXfzW8I7
	 n3KaHDhpL3JXhik+ZPimP21iBNSB+Z1uOzJQQyfhMndxVOnhx2W2BwYDldR8jsHa3I
	 XLD5zaEsigRLokVM8NicMv8M7njTfz54kQI3m76X2ZADFPNVE1DeD21dTye6VodXMN
	 bOzuAqBq5cPcYQ1QZMLUO5z0w6fk2olpsoUuZvaMjeh+2I7bjh1DcHbe38kI4HK1Xk
	 3udu5npVgWaVg==
Date: Sat, 23 Mar 2024 18:29:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7944: simplify adi,spi-mode property
 parsing
Message-ID: <20240323182918.2cf624b6@jic23-huawei>
In-Reply-To: <CAMknhBETEP123=EHycGtFEJjQ+NPssLXmw9ZdDoY8CRsWiSxVQ@mail.gmail.com>
References: <20240319-ad7944-cleanups-v2-1-50e77269351b@baylibre.com>
	<CAHp75VeO_=r_pMBUTaQQYKDRAV-OVfTnPYPwV8f7KDzOhaBCvQ@mail.gmail.com>
	<CAMknhBETEP123=EHycGtFEJjQ+NPssLXmw9ZdDoY8CRsWiSxVQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Mar 2024 10:28:31 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Tue, Mar 19, 2024 at 10:01=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, Mar 19, 2024 at 4:28=E2=80=AFPM David Lechner <dlechner@baylibr=
e.com> wrote: =20
> > >
> > > This simplifies the adi,spi-mode property parsing by using
> > > device_property_match_property_string() instead of two separate
> > > functions. Also, the error return value is now more informative
> > > in cases where there was problem parsing the property. =20
> >
> > a problem
> >
I'll fix that up.

> > ...
> > =20
> > > +       ret =3D device_property_match_property_string(dev, "adi,spi-m=
ode",
> > > +                                                   ad7944_spi_modes,
> > > +                                                   ARRAY_SIZE(ad7944=
_spi_modes));
> > > +       if (ret < 0) {
> > > +               if (ret !=3D -EINVAL)
> > > +                       return dev_err_probe(dev, ret,
> > > +                                            "getting adi,spi-mode pr=
operty failed\n"); =20
> > =20
> > > -               adc->spi_mode =3D ret;
> > > -       } else { =20
> >
> > Actually we may even leave these unchanged
> > =20
> > >                 /* absence of adi,spi-mode property means default mod=
e */
> > >                 adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;
> > > +       } else {
> > > +               adc->spi_mode =3D ret;
> > >         } =20
> >
> >        ret =3D device_property_match_property_string(dev, "adi,spi-mode=
",
> >                                                    ad7944_spi_modes,
> >
> > ARRAY_SIZE(ad7944_spi_modes));
> >        if (ret >=3D 0) {
> >                adc->spi_mode =3D ret;
> >        } else if (ret !=3D -EINVAL) {
> >                        return dev_err_probe(dev, ret,
> >                                             "getting adi,spi-mode
> > property failed\n");
> >        } else {
> >                /* absence of adi,spi-mode property means default mode */
> >                adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;
> >        }
> >
> > But I can admit this is not an often used approach.
> > =20
>=20
> I think Jonathan prefers to have the error path first, so I would like
> to wait and see if he has an opinion here.
I do prefer error paths first.  Thanks.

Jonathan


