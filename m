Return-Path: <linux-kernel+bounces-56607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3816D84CC82
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2DC7B24723
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E4C7CF32;
	Wed,  7 Feb 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eKb75DVV"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ACC7C090
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315559; cv=none; b=KqH3pvjFlmg8CcDmK8z8mPAt5YGgFYp8NHQVOhLKpwWf/rytcUWn/xdSaEH2t4Ptzu8majfICSiOY63zVvPR087hqXpUf7dmNaeMMTGFplhnItqvf7vVvctGIXPg2FIKEfXveNXFC+VGwRgIAziQeS+gbQBY8C40DExsgTFxXkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315559; c=relaxed/simple;
	bh=qNiDxmPLRX2gONHjp5V//oNUCAneHOBmKcLQJZDoqq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KExT5umSEc5sTN6FKfCBRox7HZSxhKzCp/Xw+sjaNs6H5jku4cSOOtuorOuK1l1gvgqUxrqW07EQAyhxeVbmiC7yepgOzIY53EaRgjgsF+lEGsxW6tGaMbH46Dos94Pq9oysUYljPs4zbeDfEMRS8IR4yFodyFP0G1VI9FLWO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eKb75DVV; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0cd9871b3so2685541fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707315555; x=1707920355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILWgMVro314dmhUiCh6UxBQcT1f8d7NxX/BsGCT/hZM=;
        b=eKb75DVV8Qd00FiFEn12aPI/vM9FJRtYg4HbueN8N7x9bZC2UPgnapUBtxoaN/vevF
         UJb/GvGkqYWFMnbG5+fpBYrJYxTl/rLqjOtbCMQwYsBTnU35C2PEKOzxpyT0FeMvZnvt
         mX6d91qHVPcbaUw8dvULVdc3aCxBuFWnOnR3hjicX21YqU0wskhqYBucny9KiPtpb4ES
         Yx/Bd8qDUeMOm3QlbRZao6VeWmPKjEeA33zw7/z2+sJkC1dOx6loLLUPlrlckld8SNG9
         Iz606hhjAWL5Iq5CCk1MS2tT6Qmqbcm/BeOwHlqidRZkcX17GdRuwMtvG+cs/WVhWZP8
         OA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315555; x=1707920355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILWgMVro314dmhUiCh6UxBQcT1f8d7NxX/BsGCT/hZM=;
        b=I9PAqzfhULuBmYx3E0nyWU0Cvi2ZTzx4UW8BOU/3KWNYQfZD5V77rvbNs+Ic9diFJz
         tBM0A54GdFFm16nsOrzlwa9wu7KFX3cLQSP21hIZx035W9pef+XubEOfbR842ubvxbSG
         fuXQsGKgmUUIn+OiYjQnhz+sfbTwhaTwrDhQZ+GPvk/vGShv7I4flgPV45Ar6oDt8kVe
         +71pRNG5sUlDg+Y+zg4h8rqQCQOfWgFrX/rzE142s0N7quc1GGK7UWkXovtLdfGWC3MZ
         uqfvqo/Fk4F4N+VScL8TVxM6Dhgr3P+/UwRy+XXkaQUpbF8JwoxcWUf0pFsQw1WKja3l
         q0nw==
X-Forwarded-Encrypted: i=1; AJvYcCV4hEwJJHgMXoPKt1xgxxjGOY70EnrKPyNkvZF1Fl6yDqqUs5WLkN+DF5droBP+OixMgjUWHyw5vZUJ8Vk5ZBL04gpgWtl8+8GFJmIT
X-Gm-Message-State: AOJu0YzqcUdmxyuuBgyT9NChNJauWUJgZhNyKQHO24sVpEguDMTICnsu
	CaLfP8eluERC2ldH2etSMpuPhCVj9WiAx890z3A2RVMmyR9XXiWJ6aR6FuDkTAt7HkfzGTilOxd
	nVLpvEkeKvFIGdm5PE9IxgxHxyoRxlJsKhUwR/9Z+s8tyxS1E
X-Google-Smtp-Source: AGHT+IFfjr9Dp6bX7NVZVfUzrhPOrBXBAFSzMDuPsY9Vk33c1bMGHwminHgD/mEBhygi5I7Rp3i6pg1t4oaeS+X4e5E=
X-Received: by 2002:a2e:988c:0:b0:2cf:57d7:6d35 with SMTP id
 b12-20020a2e988c000000b002cf57d76d35mr2094386ljj.10.1707315554797; Wed, 07
 Feb 2024 06:19:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
 <20240206-ad7944-mainline-v1-2-bf115fa9474f@baylibre.com> <5fd17b66eab1989b9cfb874445c18480a2282809.camel@gmail.com>
In-Reply-To: <5fd17b66eab1989b9cfb874445c18480a2282809.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 7 Feb 2024 08:19:03 -0600
Message-ID: <CAMknhBHP40uXtviZ1KCQ3ZyruaLUVrjpp573u7QqMCT1tuoYjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7944: add driver for AD7944/AD7985/AD7986
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 4:07=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
>
> Hi David,
>
> The driver It's in pretty good shape... Just some comments from me
>
> On Tue, 2024-02-06 at 11:26 -0600, David Lechner wrote:
> > This adds a driver for the Analog Devices Inc. AD7944, AD7985, and
> > AD7986 ADCs. These are a family of pin-compatible ADCs that can sample
> > at rates up to 2.5 MSPS.
> >
> > The initial driver adds support for sampling at lower rates using the
> > usual IIO triggered buffer and can handle all 3 possible reference
> > voltage configurations.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  MAINTAINERS              |   1 +
> >  drivers/iio/adc/Kconfig  |  10 ++
> >  drivers/iio/adc/Makefile |   1 +
> >  drivers/iio/adc/ad7944.c | 397
> > +++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 409 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4f1e658e1e0d..83d8367595f1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -458,6 +458,7 @@ R:        David Lechner <dlechner@baylibre.com>
> >  S:   Supported
> >  W:   https://ez.analog.com/linux-software-drivers
> >  F:   Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> > +F:   drivers/iio/adc/ad7944.c
> >
> >  ADAFRUIT MINI I2C GAMEPAD
> >  M:   Anshul Dalal <anshulusr@gmail.com>
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 59ae1d17b50d..93fbe6f8e306 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -280,6 +280,16 @@ config AD7923
> >         To compile this driver as a module, choose M here: the
> >         module will be called ad7923.
> >
> > +config AD7944
> > +     tristate "Analog Devices AD7944 and similar ADCs driver"
> > +     depends on SPI
> > +     help
> > +       Say yes here to build support for Analog Devices
> > +       AD7944, AD7985, AD7986 ADCs.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called ad7944
> > +
> >  config AD7949
> >       tristate "Analog Devices AD7949 and similar ADCs driver"
> >       depends on SPI
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 5a26ab6f1109..52d803b92cd7 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -29,6 +29,7 @@ obj-$(CONFIG_AD7780) +=3D ad7780.o
> >  obj-$(CONFIG_AD7791) +=3D ad7791.o
> >  obj-$(CONFIG_AD7793) +=3D ad7793.o
> >  obj-$(CONFIG_AD7887) +=3D ad7887.o
> > +obj-$(CONFIG_AD7944) +=3D ad7944.o
> >  obj-$(CONFIG_AD7949) +=3D ad7949.o
> >  obj-$(CONFIG_AD799X) +=3D ad799x.o
> >  obj-$(CONFIG_AD9467) +=3D ad9467.o
> > diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> > new file mode 100644
> > index 000000000000..67b525fb8e59
> > --- /dev/null
> > +++ b/drivers/iio/adc/ad7944.c
> > @@ -0,0 +1,397 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Analog Devices AD7944/85/86 PulSAR ADC family driver.
> > + *
> > + * Copyright 2024 Analog Devices, Inc.
> > + * Copyright 2024 Baylibre, SAS
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/property.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +
> > +#define AD7944_INTERNAL_REF_MV               4096
> > +
> > +struct ad7944_timing_spec {
> > +     /* Normal mode minimum CNV pulse width in nanoseconds. */
> > +     unsigned int cnv_ns;
> > +     /* TURBO mode minimum CNV pulse width in nanoseconds. */
> > +     unsigned int turbo_cnv_ns;
> > +};
> > +
> >
>
> ...
>
> > +}
> > +
> > +static int ad7944_single_conversion(struct ad7944_adc *adc,
> > +                                 const struct iio_chan_spec *chan,
> > +                                 int *val)
> > +{
> > +     int ret;
> > +
> > +     ret =3D ad7944_4_wire_mode_conversion(adc, chan);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (chan->scan_type.storagebits > 16)
> > +             *val =3D adc->sample.raw.u32;
> > +     else
> > +             *val =3D adc->sample.raw.u16;
> > +
>
> Will this work both in big vs little endian archs? I don't think so but m=
aybe
> I'm missing something. At a first glance, it seems we get big endian from=
 spi so
> shouldn't we have __be16 and __be32?

Yes, in Linux SPI words are always CPU-endian. It is the drivers that
use 8-bit transfers to read 16 bits that need to handle big-endian
swapping. But here we are using 14/16/18 bit transfers.

>
> > +     if (chan->scan_type.sign =3D=3D 's')
> > +             *val =3D sign_extend32(*val, chan->scan_type.realbits - 1=
);
> > +
> > +     return IIO_VAL_INT;
> > +}
> > +
> > +static int ad7944_read_raw(struct iio_dev *indio_dev,
> > +                        const struct iio_chan_spec *chan,
> > +                        int *val, int *val2, long info)
> > +{
> > +     struct ad7944_adc *adc =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     switch (info) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret =3D iio_device_claim_direct_mode(indio_dev);
> > +             if (ret)
> > +                     return ret;
> > +
>
> I'm not totally sure but I think Jonathan already merged his series for t=
he
> cleanup stuff for the claim direct mode. Maybe take a look and use it? No=
t a big
> win in here but I guess we could still reduce some LOC.

Yes, if it is merged already, happy to make use of it here.

>
> > +             ret =3D ad7944_single_conversion(adc, chan, val);
> > +             iio_device_release_direct_mode(indio_dev);
> > +             return ret;
> > +
> > +     case IIO_CHAN_INFO_SCALE:
> > +             switch (chan->type) {
> > +             case IIO_VOLTAGE:
> > +                     *val =3D adc->ref_mv;
> > +                     *val2 =3D chan->scan_type.realbits;
> > +
> > +                     return IIO_VAL_FRACTIONAL_LOG2;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static const struct iio_info ad7944_iio_info =3D {
> > +     .read_raw =3D &ad7944_read_raw,
> > +};
> > +
> > +static irqreturn_t ad7944_trigger_handler(int irq, void *p)
> > +{
> > +     struct iio_poll_func *pf =3D p;
> > +     struct iio_dev *indio_dev =3D pf->indio_dev;
> > +     struct ad7944_adc *adc =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     ret =3D ad7944_4_wire_mode_conversion(adc, &indio_dev->channels[0=
]);
> > +     if (ret)
> > +             goto out;
> > +
> > +     iio_push_to_buffers_with_timestamp(indio_dev, &adc->sample.raw,
> > +                                        indio_dev->scan_timestamp);
> > +
> > +out:
> > +     iio_trigger_notify_done(indio_dev->trig);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static const char * const ad7944_power_supplies[] =3D {
> > +     "avdd", "dvdd", "bvdd", "vio"
> > +};
> > +
> > +static void ad7944_ref_disable(void *ref)
> > +{
> > +     regulator_disable(ref);
> > +}
> > +
> > +static int ad7944_probe(struct spi_device *spi)
> > +{
> > +     const struct ad7944_chip_info *chip_info;
> > +     struct iio_dev *indio_dev;
> > +     struct ad7944_adc *adc;
> > +     struct regulator *ref;
> > +     const char *str_val;
> > +     int ret;
> > +
> > +     /* adi,spi-mode property defaults to "4-wire" if not present */
> > +     if (device_property_read_string(&spi->dev, "adi,spi-mode", &str_v=
al)
> > < 0)
> > +             str_val =3D "4-wire";
> > +
> > +     if (strcmp(str_val, "4-wire"))
> > +             return dev_err_probe(&spi->dev, -EINVAL,
> > +                                  "only \"4-wire\" mode is currently
> > supported\n");
>
> Did you looked at spi core? I guess the chain mode is not available but I=
IRC spi
> already has spi-3wire. So maybe you could just have a boolean property fo=
r the
> chain mode and check both that and 3wire?

I used the term "3-wire" because that is what the datasheet calls it,
but it is not the same as what the SPI core calls SPI_3WIRE. The
former is described in the DT bindings patch in this series and the
latter means that SDI and SDO are on the same pin, which is not the
case here.

>
> > +
> > +     indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     adc =3D iio_priv(indio_dev);
> > +     adc->spi =3D spi;
> > +
> > +     chip_info =3D spi_get_device_match_data(spi);
> > +     if (!chip_info)
> > +             return dev_err_probe(&spi->dev, -EINVAL, "no chip info\n"=
);
> > +
> > +     adc->t =3D chip_info->t;
> > +
> > +     /*
> > +      * Some chips use unusual word sizes, so check now instead of wai=
ting
> > +      * for the first xfer.
> > +      */
> > +     if (!spi_is_bpw_supported(spi, chip_info-
> > >channels[0].scan_type.realbits))
> > +             return dev_err_probe(&spi->dev, -EINVAL,
> > +                             "SPI host does not support %d bits per
> > word\n",
> > +                             chip_info->channels[0].scan_type.realbits=
);
> > +
> > +     ret =3D devm_regulator_bulk_get_enable(&spi->dev,
> > +
> > ARRAY_SIZE(ad7944_power_supplies),
> > +                                          ad7944_power_supplies);
> > +     if (ret)
> > +             return dev_err_probe(&spi->dev, ret,
> > +                                  "failed to get and enable supplies\n=
");
> > +
> > +     /* adi,reference property defaults to "internal" if not present *=
/
> > +     if (device_property_read_string(&spi->dev, "adi,reference", &str_=
val)
> > < 0)
> > +             str_val =3D "internal";
> > +
> > +     /* sort out what is being used for the reference voltage */
> > +     if (strcmp(str_val, "internal") =3D=3D 0) {
>
> Maybe you can make the code neater with match_string() and some enum...

I did not know about this function. Sounds useful.

>
> - Nuno S=C3=A1
>

