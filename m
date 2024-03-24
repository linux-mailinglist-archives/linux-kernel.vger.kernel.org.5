Return-Path: <linux-kernel+bounces-112817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78051887E8A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA23B20B9A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30875DDA3;
	Sun, 24 Mar 2024 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXZeu3ou"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B4D2F0;
	Sun, 24 Mar 2024 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711307250; cv=none; b=f8XLz3aDe/HZFnFEnsYJ3cOanRPl3pAIDb40mPZi7rd1ImKIy0uusznU/y78EYsNS8ahpoN3KvkX9u1fmKCg93rziguVCLvjU5CPD0zoEqSy0QKwlabdnG+xkled8OjX/GOjvxJGJEwgI5DP4P2Vp7l7H3kKcnOTbWOkbiy0AJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711307250; c=relaxed/simple;
	bh=s6mc64AQ4pZX9KA5bgUlOT5O37aYYHT6vyIdf1+N8kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqUAc/Ku6wSOw1LFX817TDh8un0W3IwlUW4afSpMDXo7yd9s+Echc/kKMFcVyOQd0rAJAjYIiuI8+L7CD4R+zZ+t4B4hBKTrlz+79+aiePV4SbA8nABkbUIboE5yYhVs80WE0HnuMKxJhg+vuoC2vVfTYrdye7PvDVKkkNRSSyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXZeu3ou; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso3588165276.0;
        Sun, 24 Mar 2024 12:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711307248; x=1711912048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkEn4VNOIHeB/qPZaUAJWBjKMI7bAGuebMQs8wKwK+M=;
        b=NXZeu3ouHjIhlQt1SmM8stiROVb0+COKoygrwKh8KbBqfaL6qvjOh3cblNoA5y2Jzl
         2tAzv0HSG5RjaBMPzNY30A0vuevR+1mIj+1J0GLbi28VTEQWsqnFPWb6qdUlFtqNCKU9
         PYSP+sz0vQkLcMdANTFkAeJsKXFqc3l+jJ5DuISkPNIAk/U/CxFLp4+ppZ2hrLr2EqP4
         A5CM1zeKadSglCugBRjqGknFHHw7mPPkQiAazNpOOm990ds1d85dHCR/18fDMCinNo0i
         kNSZIf99Cn8Gst3EJuJJRwRKqio+HTXXvLKkn6HnERqZvuOjU3mmNMlShUMN4SYpGuI3
         ubpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711307248; x=1711912048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkEn4VNOIHeB/qPZaUAJWBjKMI7bAGuebMQs8wKwK+M=;
        b=QQz13kwjcxCDnVXtlc5i0lgolIccxcTcoV5/JbP5VrvUrlp4mYJ1npo79+AEdTJJDh
         5vimT3gm7OJLllUmB9l+9i98tWGWcEAUIhtOWVverugp52PYE+lOypsyc6PPQB3x/Iq3
         yfZY+bTWASV60bpFKoayFckzuN041jHeCvTDBJ4g9/GtTfsqMWHEGN3m29uwNbEeyiG7
         OJkPgDV4KFE7OLytUXuS3AP2T3gKg/ye9FCGu1kC9LpAFsqxuHfkBvQapdEUn3tlM0Lx
         mVZH5XQ81T1ycEAlfVRgK3re4z9kV/61un0BEbPKmeToEXfqC8P+0B8MnZkBBoZeH3sr
         ImHg==
X-Forwarded-Encrypted: i=1; AJvYcCVPeZkAQ4vpUfi5nEd24dD7lBOI7rohO6QhoCV4ehYtmoplVBGE1WDfaEbzFud02rGJB9BBTvCH3tSOGWPueNsk5wRBs4AYbXWp3oZhNsfLefhojRZ49i7oJZKnhQ6h5z4Zege8OUlJ0Ke+xQNNfdp4yTn1xEvSUbHN01sLgVI+nBO+cw==
X-Gm-Message-State: AOJu0Yzlmj5t0Iu0MZAKlwZ5BMgv0XikaelvtwkvRPzNxWpVuCnfZF/g
	EOiIFJRSdJAxNzPWjUaW76R4S0befGFGplkOfRyiYBkDVLBNHAWcUHCNfllzTa4VzeTaL0MUOtb
	0bflDsFp1jyn390yX8Fqscyxf7hI=
X-Google-Smtp-Source: AGHT+IFjU8gjABr+Q04WOyL7Grl2TalTDJK9DKBiTp98ZXgPk3IpiSzIM9zHyhjGDStr/psWu7GTXZKN4XhCF8QV8ZI=
X-Received: by 2002:a25:870c:0:b0:dcf:56c3:336e with SMTP id
 a12-20020a25870c000000b00dcf56c3336emr3502881ybl.35.1711307247798; Sun, 24
 Mar 2024 12:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323122030.21800-1-l.rubusch@gmail.com> <20240323122030.21800-5-l.rubusch@gmail.com>
 <20240324133536.01067770@jic23-huawei>
In-Reply-To: <20240324133536.01067770@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 24 Mar 2024 20:06:51 +0100
Message-ID: <CAFXKEHZWArvErzeoaO+jMrrA7AuQ4izJioNW_wWTza-bLXV22A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] iio: accel: adxl345: Remove single info instances
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 2:35=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 23 Mar 2024 12:20:28 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add a common array adxl3x5_chip_info and an enum for
> > indexing. This allows to remove local redundantly
> > initialized code in the bus specific modules.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345.h      |  7 +++++++
> >  drivers/iio/accel/adxl345_core.c | 12 ++++++++++++
> >  drivers/iio/accel/adxl345_i2c.c  | 20 +++++---------------
> >  drivers/iio/accel/adxl345_spi.c  | 20 +++++---------------
> >  4 files changed, 29 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > index 6b84a2cee..de6b1767d 100644
> > --- a/drivers/iio/accel/adxl345.h
> > +++ b/drivers/iio/accel/adxl345.h
> > @@ -26,11 +26,18 @@
> >   */
> >  #define ADXL375_USCALE       480000
> >
> > +enum adxl345_device_type {
> > +     ADXL345,
> > +     ADXL375,
> > +};
> > +
> >  struct adxl345_chip_info {
> >       const char *name;
> >       int uscale;
> >  };
> >
> > +extern const struct adxl345_chip_info adxl3x5_chip_info[];
> > +
> >  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> >                      int (*setup)(struct device*, struct regmap*));
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 33424edca..e3718d0dd 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -62,6 +62,18 @@ struct adxl345_data {
> >               BIT(IIO_CHAN_INFO_SAMP_FREQ),                           \
> >  }
> >
> > +const struct adxl345_chip_info adxl3x5_chip_info[] =3D {
> > +     [ADXL345] =3D {
> > +             .name =3D "adxl345",
> > +             .uscale =3D ADXL345_USCALE,
> > +     },
> > +     [ADXL375] =3D {
> > +             .name =3D "adxl375",
> > +             .uscale =3D ADXL375_USCALE,
> > +     },
> > +};
> > +EXPORT_SYMBOL_NS_GPL(adxl3x5_chip_info, IIO_ADXL345);
>
> There is little advantage here form using an array.  I'd just have
> two exported structures.   Then the name alone is enough in the
> id tables.  And probably no need for the enum definition.
>
> This use of arrays is an old pattern that makes little sense if the
> IDs have no actual meaning and you aren't supporting lots of different
> parts.  For 2 parts I'd argue definitely not worth it.
>

Agree. I see your point. I drop the info array enum patch.

(...)

Btw. may I ask another question: The adxl345/75 driver is doing the
configuration
inside the probe(). Other Analog drivers moved that out into a
xxx_setup() and call
this function in the probe(). In general, is it better to keep all
inside  the probe() or
separate? I mean, the probe is still quite short, and reading through
severl call
hierarchies feels a bit "sparghetti". On the other side I can see a
certain idea of
separation of functionality: dedicated chip configuration. Would you
mind to give
me a small statement/opinion on this please?

