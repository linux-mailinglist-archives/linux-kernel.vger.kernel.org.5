Return-Path: <linux-kernel+bounces-105354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCA887DC92
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 09:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674AF1C20AD6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377DD11184;
	Sun, 17 Mar 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh307Yvt"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7D2FBEA;
	Sun, 17 Mar 2024 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710663838; cv=none; b=OzJKbZshRVMX6GgBgd2Wdk5EjcoxxK0VG+Uu3nh7kpI0yVedhyfqYmt8g+elT3RHztS/nGlC8+V86E5KmJ+xp/Gb36/RMmjR3/x4xxXhSbDnstjuLHFCeEd0oYaUoPuZNzXUQ4KRVmw/ztAPNs3zovYIwh8TLgruabyjoLbQ3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710663838; c=relaxed/simple;
	bh=5efYS0Mz1r4k8/xBfdeZ5uezDz3yfNPpDBbLm2tF4do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nx+n9atFSskY9Rsm78kJycbshUATZUgi1KiOjuIiz3luXoitsPHXnji7CTtxgcQ18tWr3ah73wvWtndFO6EaODYd4i5rDXCN1UZy2WND6nQXDpkQpkzP0QYZmPRnebE+/I5SCBVUgNS06z1iKzDvAl99vSQqJrkWO/N54VLFT4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh307Yvt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-568c6c391d8so623689a12.3;
        Sun, 17 Mar 2024 01:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710663835; x=1711268635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymcnCfzxIXJPRJZKuRvTXsxDMCvEERb4Lu1UACKCvMM=;
        b=Uh307Yvt2YknydGVHpitElt3hPT9l0q8TGzrWk/7lnDpvd4k/qPT2Eb3WAqGZSv3by
         7CsyQZsv3k1qxxVii1+gUlSSGMPlMUKSHUnl/rcjOfoeqJlROCI5jvnc790cliAZ99OL
         bfX6qv1Ek5jD1G/wS/YtTgf55coN7ShUptEZfw1HZRjmCldtZUQ83Kzir3ix9rmhVhmr
         sM1e0kdy80bLYNiHj+W/Hxlbfel0V0kHczsAfkEBhQ/+K37rg7AvmsPQUIke3G0/At8R
         0Syo/5Q38XBZxhS20sDX4KXI54q+h35Fa1QoyaHiKEt7dsaQAvnp9Ym5CKxmvNgXomXy
         RBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710663835; x=1711268635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymcnCfzxIXJPRJZKuRvTXsxDMCvEERb4Lu1UACKCvMM=;
        b=Li6C/uVLnycfh+k7vECYCLNWnA07SKHrwL19ZGfS4mSgeMFB36yGhd1bFfOgYG8hf+
         pCFq14W7SMxV93YiMm/3FpxSdFUZBVTLykzwPCOa57nWVSquVOlN1H3W2OfudNikTRt6
         6bVN2UwPULKIVRoFv90oAmBxM6F8d5Jb6buHGSs5sBqdls0GHyHI3nei2IEbDGPL7WWD
         BcPcLWfPrBf2iWBFjD6OVtuwBk7qBSaAykdZOFgnoXRIGO58JhXFicLkcctYWoYO5s8q
         CtKtxRCVAIFAd1RfbOgTTe2pRFbJLo93ensZ1ua+pWymKuWDSk0FtH08N87i9wTCB6tA
         vZMg==
X-Forwarded-Encrypted: i=1; AJvYcCXSYvGNzE3kgor1vQlHKjbNh/hGlk0/C/hlHjttqFS+aM0uIDNJFmpsO6Krd68l6qQFmJgH6K6Lyw4KGAUd2uBs02kaiagiEAJNwO2ESDFMjRGX7AGB+h74uluClUm6tUNwUIeHj2VJ
X-Gm-Message-State: AOJu0YxWp181+NodPh98Savp8d9k3WHTKR7JMFtvLAeTHe0BhOXpijLi
	0cl8vtcRFtQyg58PAr7w0/NKm4q3NhafdG3fwVyzDTHxEayBAob6EcPJOXnafC+ipZk5wOU2Ss+
	vQQoMIVejDa+vkgL7G3TePWnbn5A=
X-Google-Smtp-Source: AGHT+IEG/45MPPL42t7BqEeTOXPjDgozwk0UVr8x9PA5b+mVpjqnodS3p2OvFWi4swSx/5X/1sbGF7hhq1NnkICWlAo=
X-Received: by 2002:a17:907:c783:b0:a45:a7f8:1b6b with SMTP id
 tz3-20020a170907c78300b00a45a7f81b6bmr7644169ejc.46.1710663834825; Sun, 17
 Mar 2024 01:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>
 <ZfX5jynjW4M9pvw1@surfacebook.localdomain> <CAMknhBGMUQFoQ9TxTTgy0dxHoyXkt+5tS93tpwz5Wo=h1UQD3Q@mail.gmail.com>
In-Reply-To: <CAMknhBGMUQFoQ9TxTTgy0dxHoyXkt+5tS93tpwz5Wo=h1UQD3Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 17 Mar 2024 10:23:18 +0200
Message-ID: <CAHp75VcP7sZKgoXzgTihf96rc5rz=U0Amoardj1Sy9uTMDHknA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7944: Add support for "3-wire mode"
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 1:10=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
> On Sat, Mar 16, 2024 at 2:57=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > Thu, Mar 14, 2024 at 12:43:38PM -0500, David Lechner kirjoitti:

..

> > > +enum ad7944_spi_mode {
> > > +     /* datasheet calls this "4-wire mode" */
> > > +     AD7944_SPI_MODE_DEFAULT,
> > > +     /* datasheet calls this "3-wire mode" (not related to SPI_3WIRE=
!) */
> > > +     AD7944_SPI_MODE_SINGLE,
> > > +     /* datasheet calls this "chain mode" */
> > > +     AD7944_SPI_MODE_CHAIN,
> >
> > Why not kernel doc?
>
> This isn't a public/shared enum so it doesn't seem like it needs it.

It doesn't matter.

> It would just add redundant enum member names.

These comments make it harder to follow in my opinion.

..

> > > +/*
> >
> > The below is mimicking the kernel doc, but there is no marker for this.
> > Why?
>
> I received feedback on another patch in a different subsystem that
> static functions shouldn't use /** since they aren't used outside of
> the file where they are.

Was it the IIO subsystem? (I believe not).
Again, that feedback is bogus as we control what to share and what not
in the documentation (when importing we may say internal or external
or even on the function granularity), however, even for static
functions it's good to have documentation in the approved format as it
makes it easier to render.

> > > + * ad7944_3wire_cs_mode_conversion - Perform a 3-wire CS mode conver=
sion and
> > > + *                                   acquisition
> > > + * @adc: The ADC device structure
> > > + * @chan: The channel specification
> > > + * Return: 0 on success, a negative error code on failure
> > > + *
> > > + * This performs a conversion and reads data when the chip is wired =
in 3-wire
> > > + * mode with the CNV line on the ADC tied to the CS line on the SPI =
controller.
> > > + *
> > > + * Upon successful return adc->sample.raw will contain the conversio=
n result.
> > > + */

..

> > > +     case AD7944_SPI_MODE_SINGLE:
> > > +             ret =3D ad7944_3wire_cs_mode_conversion(adc, &indio_dev=
->channels[0]);
> > > +             if (ret)
> > > +                     goto out;
> > > +
> > > +             break;
> > > +     default:
> > > +             /* not supported */
> >
> > No error code set?
>
> This is in an interrupt handler, so I didn't think there was anything
> we can do with an error.

return IRQ_NONE?

> > >               goto out;
> > > +     }

..

> > > +     if (device_property_read_string(dev, "adi,spi-mode", &str_val) =
=3D=3D 0) {
> > > +             ret =3D sysfs_match_string(ad7944_spi_modes, str_val);
> >
> > Don't you want use new fwnode/device property API for making these two =
in
> > one go?
>
> I didn't know there was one. I assume you mean
> fwnode_property_match_property_string().

Yes, but here is the device_ variant of it.

> > > +             if (ret < 0)
> > > +                     return dev_err_probe(dev, -EINVAL,
> >
> > Why shadowing the error code?
>
> Cargo culted from one of a few of users of sysfs_match_string() that does=
 this.
>
> Jonathan already picked this patch up so I can follow up with a patch
> to clean up these two items.

As far as I remember he was planning to rebase, so I believe he can
easily fold fixups.

> > > +                                          "unsupported adi,spi-mode\=
n");
> > > +
> > > +             adc->spi_mode =3D ret;
> > > +     } else {
> > > +             /* absence of adi,spi-mode property means default mode =
*/
> > > +             adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;
> > > +     }

--=20
With Best Regards,
Andy Shevchenko

