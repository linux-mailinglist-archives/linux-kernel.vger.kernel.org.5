Return-Path: <linux-kernel+bounces-107712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E3880091
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E552823B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C677B657BA;
	Tue, 19 Mar 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="koSpH4Tf"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C212D05E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862128; cv=none; b=DshVwysHwOj4B8fHPYzosJlulQbkLmpe0wWogfD7XdkiItHSJaxCGPGbPZ8jJZpv54XgY3Rz3Vdl+hoxozqJPR49ArYWWC956zis+fnIE4tOJRkV6N/1uJ7JlBezdW9pc04899u0bM4fUPuvlZ+nQg1XmAe/HHM9/IK2YfZIN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862128; c=relaxed/simple;
	bh=12kIwNAxFbOIGoSa+XT9zKHmXpAAXrGcmFskxrE3FY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMh8w6dgavOnQGUQAC61rhZY7ROeKu+RVn0D9iSC5v4CzvMVB18HU9aqKeiO02Vp9I4dSHPlv+QbR5WK3o++WdcqFybwM/Syupx1FTt+OxPHPiiH345xsqodTMGkPpGbhEulIvS4eOktdWfewrx2AD2vIUU8MrAAlhs8mV3OKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=koSpH4Tf; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d687da75c4so7606631fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710862123; x=1711466923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0YRQCzEtPOovqBNC+M8TvgB+q1bgObduWmwuxVs4xE=;
        b=koSpH4TfSiPqpr51FGdLdyJz8Vsy2XzbkLTD3PxZslCYXZdWvx73ffXYzVl5OU/Iax
         pfbGXyIsst08Z3T2QymVjx0CMwR0ZMTUj20utZSLH7Q+r7bv5/AQh7DP9Xdt9d9attvS
         2LBJ+c9AB5/mTh7pogQCEHJE8/zLQSzhHY3fXXHbPtfIIyFjbxtmyXLgd/w/YMkexsWa
         aFfIXn9DuzNk7nPOnpRrdg1VNlGzwFq9NH++bDzrv/tYOzhQ9KzvSaOsh7ajFnyVI+Vt
         EfrOuC51Lu7/6VJkzkrJrDiyRHsr+pA4kWcEC9rqjCjwAj7msdL3ra+HFjYi+Lo4ko4y
         PCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710862123; x=1711466923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0YRQCzEtPOovqBNC+M8TvgB+q1bgObduWmwuxVs4xE=;
        b=BEWzbSDa39NOppaRS28ESIKVdK3Avedl/BpDgunpdLrmZIaJfJHQk41hvL0XcsxfOy
         +G9+QtF6vHcNF/9BkR8qrDeReJCsp4nrLhJvn5viU4CCeqhrZiC+faPKCdkJuv9xOY5g
         wrnQmSYmrI1QyCDQUTg1mVE0u6w81BRNTQM1dQyElh3GeE1LyBfmWA1C24PP/ZDHxFEt
         tztGsEeOYppWlEWoLld/ufhQ+RkcLUhp4Xlabw1YZeeSIzAUypvmEVtYUy8flBYbI8VF
         HJemj8wsi0ARzubFiqRyuvgnkPpQXdcReD69Kt3fnKKIb1ASkoEAVgtbd7fl57ateMXS
         J1bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaBTSDHXW/hREHJzRBJfSno/MwpTzID/dcZ/XN4B0OnHE6rra1kkEhjkDku+od6Z1XRfzPczLNM/Kh6zI5g8LQ5XFKBwxj/sshJDm0
X-Gm-Message-State: AOJu0Yylk8Ju3pTJ4iVjv8p+dB1CMWzLT/wQdzuS5LAp0kyADlLki1Cm
	vzvgbxOn7pza5fB0b/EuaeW4bPYLRX+KDKz5NZRqr5FogDx0TnrTOHH1xcQzZh28stbpcGxdrJk
	jLyPnpU6Hwr/mKYMrAXoBmplgHMbR4QoWPvSCCg==
X-Google-Smtp-Source: AGHT+IH57csUMlqpNIHKlT6Bfa/3wVTkoYXItlIM1+aBeNDM3LhhVaSf1Xxg3j/2AW9C55ufKxw+GbzavjRq+ggDMbg=
X-Received: by 2002:a2e:b16c:0:b0:2d4:61b6:7a2a with SMTP id
 a12-20020a2eb16c000000b002d461b67a2amr10423928ljm.1.1710862123335; Tue, 19
 Mar 2024 08:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-ad7944-cleanups-v2-1-50e77269351b@baylibre.com> <CAHp75VeO_=r_pMBUTaQQYKDRAV-OVfTnPYPwV8f7KDzOhaBCvQ@mail.gmail.com>
In-Reply-To: <CAHp75VeO_=r_pMBUTaQQYKDRAV-OVfTnPYPwV8f7KDzOhaBCvQ@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 19 Mar 2024 10:28:31 -0500
Message-ID: <CAMknhBETEP123=EHycGtFEJjQ+NPssLXmw9ZdDoY8CRsWiSxVQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7944: simplify adi,spi-mode property parsing
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:01=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Mar 19, 2024 at 4:28=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > This simplifies the adi,spi-mode property parsing by using
> > device_property_match_property_string() instead of two separate
> > functions. Also, the error return value is now more informative
> > in cases where there was problem parsing the property.
>
> a problem
>
> ...
>
> > +       ret =3D device_property_match_property_string(dev, "adi,spi-mod=
e",
> > +                                                   ad7944_spi_modes,
> > +                                                   ARRAY_SIZE(ad7944_s=
pi_modes));
> > +       if (ret < 0) {
> > +               if (ret !=3D -EINVAL)
> > +                       return dev_err_probe(dev, ret,
> > +                                            "getting adi,spi-mode prop=
erty failed\n");
>
> > -               adc->spi_mode =3D ret;
> > -       } else {
>
> Actually we may even leave these unchanged
>
> >                 /* absence of adi,spi-mode property means default mode =
*/
> >                 adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;
> > +       } else {
> > +               adc->spi_mode =3D ret;
> >         }
>
>        ret =3D device_property_match_property_string(dev, "adi,spi-mode",
>                                                    ad7944_spi_modes,
>
> ARRAY_SIZE(ad7944_spi_modes));
>        if (ret >=3D 0) {
>                adc->spi_mode =3D ret;
>        } else if (ret !=3D -EINVAL) {
>                        return dev_err_probe(dev, ret,
>                                             "getting adi,spi-mode
> property failed\n");
>        } else {
>                /* absence of adi,spi-mode property means default mode */
>                adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;
>        }
>
> But I can admit this is not an often used approach.
>

I think Jonathan prefers to have the error path first, so I would like
to wait and see if he has an opinion here.

