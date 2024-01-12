Return-Path: <linux-kernel+bounces-24678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC67882C0C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57123284E59
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CDD6D1B1;
	Fri, 12 Jan 2024 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf5AuhO5"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFBB5917D;
	Fri, 12 Jan 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28cc85e6b5so771031566b.1;
        Fri, 12 Jan 2024 05:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705065601; x=1705670401; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=meCwZziRS1l+JY3HMWxrgKDfRVQOEslerG7b0IRFUg8=;
        b=kf5AuhO5q3Ci5Z7HJj07SN/uAz9/Nu0lZzW6abiHCv/JGGVMveY8ASlqI/Xxh6ynhl
         O2cGWhNmkfj1pFhXPE5vXVE+gDyfpK33JoUe0t6S9lvCqs2P/yi4/zil0p63Yvj7aPyf
         8wmPhC0CW4P/Rh9ccaSM8OJwdiMqcXKOuCk6Lip6AnFqX5Swj2VG75i2Y3n0tG2Y6Nqp
         ilmr4U6//EABr0YOr0346/CYF5Z45g6zkBwK21r8G+A5qqq2DrcpOCL3pkJgV5IxcQy1
         5kEuPgrxYGq0SXitWDXDDBTierf40LY0jmoEupCAsiDk8t5EugUcOXdXTwPoaGQkmxop
         0QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705065601; x=1705670401;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=meCwZziRS1l+JY3HMWxrgKDfRVQOEslerG7b0IRFUg8=;
        b=q4lpUMmCqQaucJdMIysC3lhalc3W9Wvrzx9ecJo7zDweCvKceCMdmQHfp81zr6ro1l
         W+UYAmOglJ+vKKx3ymxs6b//hpo/Y20n/U8q1k8N7fy+H6B4lMxgq4OzC+ivRxZo01El
         tCLGy99x42FwN/g3BG0MyjX8U6kKKhrbWO5qEOBbgJLuP4BQ3pcmlvNUiFsKABejmENs
         jVA1uyfsKVfUuv1U6n3UxgSmezGxhxHlpXmLiUjWR1PCfVijVJlGn7LzxWnu9tB60bPD
         ngJFGxkqXdsnRAVr2WN9i/3uUy5ZSbdn73FZ8XvNYm6FBagYaGKy0wAj78qQK2En+5Sk
         VhRQ==
X-Gm-Message-State: AOJu0Yy1wAHzKeSyszTQjzPMSoZ9mI41kXY3ekw30uHH7fusEjXcfyX/
	93hUeoADRdYH2p89ZwfwVmo=
X-Google-Smtp-Source: AGHT+IF1mMFbY+3r5Iaeb+6+PXPEfAiBxU0F2/Ehh28TvjQCfJXftHdkGzVcKuXkLftSNVNWMckWDQ==
X-Received: by 2002:a17:906:2487:b0:a29:f328:be7d with SMTP id e7-20020a170906248700b00a29f328be7dmr432946ejb.70.1705065601121;
        Fri, 12 Jan 2024 05:20:01 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id um7-20020a170906cf8700b00a26ac6d55dasm1779914ejb.46.2024.01.12.05.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 05:20:00 -0800 (PST)
Message-ID: <7e40f4a5df7d6a594659ef1a7705be7d53368466.camel@gmail.com>
Subject: Re: [PATCH 12/13] iio: offload: add new PWM triggered DMA buffer
 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Frank Rowand
 <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>,  linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2024 14:19:59 +0100
In-Reply-To: <20240112125146.00000b68@Huawei.com>
References: 
	<20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	 <20240109-axi-spi-engine-series-3-v1-12-e42c6a986580@baylibre.com>
	 <0e6f38002d83a6a61fa5424499c7c3f2f6d6f3de.camel@gmail.com>
	 <20240112125146.00000b68@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-12 at 12:51 +0000, Jonathan Cameron wrote:
> On Thu, 11 Jan 2024 15:59:02 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Wed, 2024-01-10 at 13:49 -0600, David Lechner wrote:
> > > This adds a new driver for handling SPI offloading using a PWM as the
> > > trigger and DMA for the received data. This will be used by ADCs in
> > > conjunction with SPI controllers with offloading support to be able
> > > to sample at high rates without CPU intervention.
> > >=20
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > > =C2=A0drivers/iio/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> > > =C2=A0drivers/iio/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> > > =C2=A0.../iio/buffer/industrialio-hw-triggered-buffer.c=C2=A0 |=C2=A0=
=C2=A0 1 +
> > > =C2=A0drivers/iio/offload/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 21 ++
> > > =C2=A0drivers/iio/offload/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > =C2=A0drivers/iio/offload/iio-pwm-triggered-dma-buffer.c | 212
> > > +++++++++++++++++++++
> > > =C2=A06 files changed, 238 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> > > index 52eb46ef84c1..56738282d82f 100644
> > > --- a/drivers/iio/Kconfig
> > > +++ b/drivers/iio/Kconfig
> > > @@ -90,6 +90,7 @@ source "drivers/iio/imu/Kconfig"
> > > =C2=A0source "drivers/iio/light/Kconfig"
> > > =C2=A0source "drivers/iio/magnetometer/Kconfig"
> > > =C2=A0source "drivers/iio/multiplexer/Kconfig"
> > > +source "drivers/iio/offload/Kconfig"
> > > =C2=A0source "drivers/iio/orientation/Kconfig"
> > > =C2=A0source "drivers/iio/test/Kconfig"
> > > =C2=A0if IIO_TRIGGER
> > > diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> > > index 9622347a1c1b..20acf5e1a4a7 100644
> > > --- a/drivers/iio/Makefile
> > > +++ b/drivers/iio/Makefile
> > > @@ -34,6 +34,7 @@ obj-y +=3D imu/
> > > =C2=A0obj-y +=3D light/
> > > =C2=A0obj-y +=3D magnetometer/
> > > =C2=A0obj-y +=3D multiplexer/
> > > +obj-y +=3D offload/
> > > =C2=A0obj-y +=3D orientation/
> > > =C2=A0obj-y +=3D position/
> > > =C2=A0obj-y +=3D potentiometer/
> > > diff --git a/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> > > b/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> > > index 7a8a71066b0e..a2fae6059616 100644
> > > --- a/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> > > +++ b/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> > > @@ -86,6 +86,7 @@ static int iio_hw_trigger_buffer_probe(struct
> > > auxiliary_device *adev,
> > > =C2=A0}
> > > =C2=A0
> > > =C2=A0static const struct auxiliary_device_id iio_hw_trigger_buffer_i=
d_table[] =3D {
> > > +	{ .name =3D "pwm-triggered-dma-buffer.triggered-buffer" },
> > > =C2=A0	{ }
> > > =C2=A0};
> > > =C2=A0MODULE_DEVICE_TABLE(auxiliary, iio_hw_trigger_buffer_id_table);
> > > diff --git a/drivers/iio/offload/Kconfig b/drivers/iio/offload/Kconfi=
g
> > > new file mode 100644
> > > index 000000000000..760c0cfe0e9c
> > > --- /dev/null
> > > +++ b/drivers/iio/offload/Kconfig
> > > @@ -0,0 +1,21 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +#
> > > +# SPI offload handlers for Industrial I/O
> > > +#
> > > +# When adding new entries keep the list in alphabetical order
> > > +
> > > +menu "SPI offload handlers"
> > > +
> > > +config IIO_PWM_TRIGGERED_DMA_BUFFER
> > > +	tristate "PWM trigger and DMA buffer connected to SPI offload"
> > > +	select AUXILIARY_BUS
> > > +	select IIO_BUFFER_DMAENGINE
> > > +	help
> > > +	=C2=A0 Provides a periodic hardware trigger via a PWM connected to =
the
> > > +	=C2=A0 trigger input of a SPI offload and a hardware buffer impleme=
nted
> > > +	=C2=A0 via DMA connected to the data output stream the a SPI offloa=
d.
> > > +
> > > +	=C2=A0 To compile this driver as a module, choose M here: the
> > > +	=C2=A0 module will be called "iio-pwm-triggered-dma-buffer".
> > > +
> > > +endmenu
> > > diff --git a/drivers/iio/offload/Makefile b/drivers/iio/offload/Makef=
ile
> > > new file mode 100644
> > > index 000000000000..7300ce82f066
> > > --- /dev/null
> > > +++ b/drivers/iio/offload/Makefile
> > > @@ -0,0 +1,2 @@
> > > +
> > > +obj-$(CONFIG_IIO_PWM_TRIGGERED_DMA_BUFFER) :=3D iio-pwm-triggered-dm=
a-buffer.o
> > > diff --git a/drivers/iio/offload/iio-pwm-triggered-dma-buffer.c
> > > b/drivers/iio/offload/iio-pwm-triggered-dma-buffer.c
> > > new file mode 100644
> > > index 000000000000..970ea82316f6
> > > --- /dev/null
> > > +++ b/drivers/iio/offload/iio-pwm-triggered-dma-buffer.c
> > > @@ -0,0 +1,212 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Platform driver for a PWM trigger and DMA buffer connected to a S=
PI
> > > + * controller offload instance implementing the iio-hw-triggered-buf=
fer
> > > + * interface.
> > > + *
> > > + * Copyright (C) 2023 Analog Devices, Inc.
> > > + * Copyright (C) 2023 BayLibre, SAS
> > > + */
> > > +
> > > +#include <linux/auxiliary_bus.h>
> > > +#include <linux/pwm.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/iio/buffer.h>
> > > +#include <linux/iio/hw_triggered_buffer_impl.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/trigger.h>
> > > +#include <linux/iio/sysfs.h>
> > > +#include <linux/iio/buffer-dmaengine.h>
> > > +#include <linux/sysfs.h>
> > > +
> > > +struct iio_pwm_triggered_dma_buffer {
> > > +	struct iio_hw_triggered_buffer_device hw;
> > > +	struct pwm_device *pwm;
> > > +};
> > > +
> > > +static const struct iio_trigger_ops iio_pwm_triggered_dma_buffer_ops=
;
> > > +
> > > +static int iio_pwm_triggered_dma_buffer_set_state(struct iio_trigger=
 *trig,
> > > bool state)
> > > +{
> > > +	struct iio_pwm_triggered_dma_buffer *st =3D
> > > iio_trigger_get_drvdata(trig);
> > > +
> > > +	if (state)
> > > +		return pwm_enable(st->pwm);
> > > +
> > > +	pwm_disable(st->pwm);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int iio_pwm_triggered_dma_buffer_validate_device(struct iio_t=
rigger
> > > *trig,
> > > +							struct iio_dev
> > > *indio_dev)
> > > +{
> > > +	/* Don't allow assigning trigger via sysfs. */
> > > +	return -EINVAL;
> > > +}
> > > +
> > > +static const struct iio_trigger_ops iio_pwm_triggered_dma_buffer_ops=
 =3D {
> > > +	.set_trigger_state =3D iio_pwm_triggered_dma_buffer_set_state,
> > > +	.validate_device =3D iio_pwm_triggered_dma_buffer_validate_device,
> > > +};
> > > +
> > > +static u32 axi_spi_engine_offload_pwm_trigger_get_rate(struct iio_tr=
igger
> > > *trig)
> > > +{
> > > +	struct iio_pwm_triggered_dma_buffer *st =3D
> > > iio_trigger_get_drvdata(trig);
> > > +	u64 period_ns =3D pwm_get_period(st->pwm);
> > > +
> > > +	if (period_ns)
> > > +		return DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, period_ns);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int
> > > +axi_spi_engine_offload_set_samp_freq(struct iio_pwm_triggered_dma_bu=
ffer *st,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 u32 requested_hz)
> > > +{
> > > +	int period_ns;
> > > +
> > > +	if (requested_hz =3D=3D 0)
> > > +		return -EINVAL;
> > > +
> > > +	period_ns =3D DIV_ROUND_UP(NSEC_PER_SEC, requested_hz);
> > > +
> > > +	/*
> > > +	 * FIXME: We really just need a clock, not a PWM. The current duty
> > > cycle
> > > +	 * value is a hack to work around the edge vs. level offload trigge=
r
> > > +	 * issue in the ADI AXI SPI Engine firmware.
> > > +	 */
> > > +	return pwm_config(st->pwm, 10, period_ns);
> > > +}
> > > +
> > > +static ssize_t sampling_frequency_show(struct device *dev,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *at=
tr, char
> > > *buf)
> > > +{
> > > +	struct iio_trigger *trig =3D to_iio_trigger(dev);
> > > +
> > > +	return sysfs_emit(buf, "%u\n",
> > > +			=C2=A0 axi_spi_engine_offload_pwm_trigger_get_rate(trig));
> > > +}
> > > +
> > > +static ssize_t sampling_frequency_store(struct device *dev,
> > > +					struct device_attribute *attr,
> > > +					const char *buf, size_t len)
> > > +{
> > > +	struct iio_trigger *trig =3D to_iio_trigger(dev);
> > > +	struct iio_pwm_triggered_dma_buffer *st =3D
> > > iio_trigger_get_drvdata(trig);
> > > +	int ret;
> > > +	u32 val;
> > > +
> > > +	ret =3D kstrtou32(buf, 10, &val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D axi_spi_engine_offload_set_samp_freq(st, val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return len;
> > > +}
> > > +=C2=A0=20
> >=20
> > This is also something that made me wonder... In the end of the day, th=
e
> > frequency at which we want to sample the data depends on the converter =
device.
> > This completely detached interface makes it more easy for the user to s=
crew up
> > things, right?
> It's easy to do that anyway :) If you think of a normal SPI attached devi=
ce that
> has it's own internal clocking then it's usually easy to set the device t=
o grab
> data faster than than the spi bus can drain it.=C2=A0 We drop samples.

> Here it might make sense to add some bounds I guess as it's all in hardwa=
re
> - either have the ADC provide them or push it to DT,

Indeed... DT would likely be simpler

>=20
> >=20
> > Things might even become more complicated in usecases where we have an
> > additional pwm (on top of the data fetch trigger one) for triggering co=
nversions
> > in the converter and we might need to properly control the phase betwee=
n those
> > two signals. So, how would we handle it in the current form? We have on=
e pwm
> > belonging to the offload engine and one belonging to the converter but =
they need
> > to cope together...
>=20
> Groan loudly?=20
> If someone wants careful sync between a trigger for the ADC and the read =
back
> triggering
> they should do it in hardware. Sure we can do it if the pwm is sophistica=
ted enough
> but the mess of layering etc needed to make it work is just nasty.
>=20
> I guess you make a custom trigger that bakes in your requirements.
>=20

Yeah, we have yet another FPGA soft core implementing a pwm controller (als=
o to be
upstreamed soon) which can output multiple signals at different phases, fre=
quency,
etc...

- Nuno S=C3=A1

