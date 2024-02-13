Return-Path: <linux-kernel+bounces-63800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4EA85349A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C621C21354
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A395DF3E;
	Tue, 13 Feb 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r0I02VdV"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E95DF22
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838095; cv=none; b=K2kIZ7eVZ7wok4zcmVlMmYKXpIcT3VMJ2OiRh1pOYoI+QZfxRfPOpxMO7SJacI/XrRAq5KK7U1SaflQVHXJNLcv9gvj8g5z1CcBAMwdyUGoqGGuboADeE+rX3GB9MTPHHnMDTpVmiLuACEw2HIm/JWMeARo1Z+V0POpkw+6M+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838095; c=relaxed/simple;
	bh=KGR8cBhrRdf4y8P2TLGPhrpUyRSfOFO4v9dE/xVr0xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlp6S38CJdM1dsnrzAMfetsq7cbaoq64cZVPrEFuRSx24GJBsIWPrMho7475hQXfaUyuH14rBBNKsUltol3Bs69wOZVse8lU9pPX6D2O8MjdBo9negq2lOUMUK6haO5ftU32fbdGfZWyfNbTEmhAOxGL/9lw9ClrPjW7Zior6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r0I02VdV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so9927341fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707838089; x=1708442889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ygk6/cDOkwUw/NJeAB8ipuDaGxiTdarNFVMbQnymP4=;
        b=r0I02VdVJHcrGah3/2p+9+atp023WtI8mtsb7Vi0gcMMfXaqIXp8KxLWphDAS6qzl5
         vcW8IiXx+3rNobxko+G7CYmrWzhENDaTHNN3sO+N8KW4JFTRHHHiLXGGhxVqoHppjang
         19Qgr3em1rRj+D1W1Bq7WhjXDt4HvLTbDYWNN/AmU6knad/x/TXeURwYkUShvWCCck2j
         TZoXFd1FLuWiQgA0phrk/OrFueiu6qurzRDQuF9WgDrq4RT+IFHz1VYVxl9K/XPN0iQC
         rsDkKfUMtXs3vyVJJtNpnw8lo9WQdALD7ChQPYyIWDfBPjDmgwU1lQJVY1dJPDhRnn/O
         DHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707838089; x=1708442889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ygk6/cDOkwUw/NJeAB8ipuDaGxiTdarNFVMbQnymP4=;
        b=WCZQ96no7Uxr4vdg3LIITz5RIEOfPQjFSy5qaYeILAtY/s6vghd9XGGREiwj1+EowB
         +K3kvEm2kB6ltir94lUUasBbF6Wx2avtna6r5Uph3Ku4D2Kgn9v5B2TbSxQyEivEsjA9
         ay4hA0sXES1p6rxXFKsj4pGfPpdcayhlEqddZfoGm5OEjxZXVdqKko8thORmdlF7tD7X
         9gRr2cnOhRvsnqrZWqX3iSjQoj/WtnOSf6B7Ej0JFZR1lvOAm5iqqWzScn5UsjYEyuZ1
         pZy4m29ZoFZ13QmVDKJpU3jo+xCMZXZOS7v/jr+926gwU71pTt2pamQCV9NE3vQOb3oS
         LeGw==
X-Gm-Message-State: AOJu0YwyhZD7vr7N6EY56vDrngW7a9yuSJeLRt7DswAFKCCOS1LlOD7B
	b1VFSakPIa7fuKDrOtpX9jjEMFJgjlSQ0mwKkYVAleQIpUZyD3CwOImj8MSefd0LHK7aAEufIV3
	1kTtwhxkm+8RZ+hjAc4Bo1UOd1kH1ShsIhKCCzg==
X-Google-Smtp-Source: AGHT+IG01ij/IVy0hSByNzSy26iGI4SuB13+tw+QvBXX+3JkeX51jqeUndyf9KdenM1FhyxlUzQas9cWZ1padoUdZB8=
X-Received: by 2002:a2e:8755:0:b0:2d0:a6ef:651d with SMTP id
 q21-20020a2e8755000000b002d0a6ef651dmr6311505ljj.47.1707838089550; Tue, 13
 Feb 2024 07:28:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
 <20240212-mainline-spi-precook-message-v1-5-a2373cd72d36@baylibre.com> <c06dfa1ecf88b07ef467ad7c08667d0cab400613.camel@gmail.com>
In-Reply-To: <c06dfa1ecf88b07ef467ad7c08667d0cab400613.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 13 Feb 2024 09:27:58 -0600
Message-ID: <CAMknhBEU=iMzpE_P0KePL4cZZktBOGHRXaEox5a7XcVjXDT+Dg@mail.gmail.com>
Subject: Re: [PATCH 5/5] iio: adc: ad7380: use spi_optimize_message()
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Martin Sperl <kernel@martin.sperl.org>, 
	David Jander <david@protonic.nl>, Jonathan Cameron <jic23@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:47=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> On Mon, 2024-02-12 at 17:26 -0600, David Lechner wrote:
> > This modifies the ad7380 ADC driver to use spi_optimize_message() to
> > optimize the SPI message for the buffered read operation. Since buffere=
d
> > reads reuse the same SPI message for each read, this can improve
> > performance by reducing the overhead of setting up some parts the SPI
> > message in each spi_sync() call.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  drivers/iio/adc/ad7380.c | 52 ++++++++++++++++++++++++++++++++++++++++=
+------
> > -
> >  1 file changed, 45 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> > index abd746aef868..5c5d2642a474 100644
> > --- a/drivers/iio/adc/ad7380.c
> > +++ b/drivers/iio/adc/ad7380.c
> > @@ -133,6 +133,7 @@ struct ad7380_state {
> >       struct spi_device *spi;
> >       struct regulator *vref;
> >       struct regmap *regmap;
> > +     struct spi_message *msg;
> >       /*
> >        * DMA (thus cache coherency maintenance) requires the
> >        * transfer buffers to live in their own cache lines.
> > @@ -231,19 +232,55 @@ static int ad7380_debugfs_reg_access(struct iio_d=
ev
> > *indio_dev, u32 reg,
> >       return ret;
> >  }
> >
> > +static int ad7380_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +     struct ad7380_state *st =3D iio_priv(indio_dev);
> > +     struct spi_transfer *xfer;
> > +     int ret;
> > +
> > +     st->msg =3D spi_message_alloc(1, GFP_KERNEL);
> > +     if (!st->msg)
> > +             return -ENOMEM;
> > +
> > +     xfer =3D list_first_entry(&st->msg->transfers, struct spi_transfe=
r,
> > +                             transfer_list);
> > +
> > +     xfer->bits_per_word =3D st->chip_info->channels[0].scan_type.real=
bits;
> > +     xfer->len =3D 4;
> > +     xfer->rx_buf =3D st->scan_data.raw;
> > +
> > +     ret =3D spi_optimize_message(st->spi, st->msg);
> > +     if (ret) {
> > +             spi_message_free(st->msg);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ad7380_buffer_postdisable(struct iio_dev *indio_dev)
> > +{
> > +     struct ad7380_state *st =3D iio_priv(indio_dev);
> > +
> > +     spi_unoptimize_message(st->msg);
> > +     spi_message_free(st->msg);
> > +
> > +     return 0;
> > +}
> > +
>
> Not such a big deal but unless I'm missing something we could have the
> spi_message (+ the transfer) statically allocated in struct ad7380_state =
and do
> the optimize only once at probe (naturally with proper devm action for
> unoptimize). Then we would not need to this for every buffer enable + dis=
able. I
> know in terms of performance it won't matter but it would be less code I =
guess.
>
> Am I missing something?

No, your understanding is correct for the current state of everything
in this series. So, we could do as you suggest, but I have a feeling
that future additions to this driver might require that it gets
changed back this way eventually.

