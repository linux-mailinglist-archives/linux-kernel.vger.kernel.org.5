Return-Path: <linux-kernel+bounces-24667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E94982C007
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0343E284BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF9F6BB37;
	Fri, 12 Jan 2024 12:51:54 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510D41C67;
	Fri, 12 Jan 2024 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TBLvT4cC1z6K9Bt;
	Fri, 12 Jan 2024 20:49:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D8A21408FF;
	Fri, 12 Jan 2024 20:51:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 12:51:47 +0000
Date: Fri, 12 Jan 2024 12:51:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Frank Rowand
	<frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-spi@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/13] iio: offload: add new PWM triggered DMA buffer
 driver
Message-ID: <20240112125146.00000b68@Huawei.com>
In-Reply-To: <0e6f38002d83a6a61fa5424499c7c3f2f6d6f3de.camel@gmail.com>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	<20240109-axi-spi-engine-series-3-v1-12-e42c6a986580@baylibre.com>
	<0e6f38002d83a6a61fa5424499c7c3f2f6d6f3de.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 11 Jan 2024 15:59:02 +0100
Nuno S=E1 <noname.nuno@gmail.com> wrote:

> On Wed, 2024-01-10 at 13:49 -0600, David Lechner wrote:
> > This adds a new driver for handling SPI offloading using a PWM as the
> > trigger and DMA for the received data. This will be used by ADCs in
> > conjunction with SPI controllers with offloading support to be able
> > to sample at high rates without CPU intervention.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > =A0drivers/iio/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
> > =A0drivers/iio/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
> > =A0.../iio/buffer/industrialio-hw-triggered-buffer.c=A0 |=A0=A0 1 +
> > =A0drivers/iio/offload/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 21 ++
> > =A0drivers/iio/offload/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +
> > =A0drivers/iio/offload/iio-pwm-triggered-dma-buffer.c | 212
> > +++++++++++++++++++++
> > =A06 files changed, 238 insertions(+)
> >=20
> > diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> > index 52eb46ef84c1..56738282d82f 100644
> > --- a/drivers/iio/Kconfig
> > +++ b/drivers/iio/Kconfig
> > @@ -90,6 +90,7 @@ source "drivers/iio/imu/Kconfig"
> > =A0source "drivers/iio/light/Kconfig"
> > =A0source "drivers/iio/magnetometer/Kconfig"
> > =A0source "drivers/iio/multiplexer/Kconfig"
> > +source "drivers/iio/offload/Kconfig"
> > =A0source "drivers/iio/orientation/Kconfig"
> > =A0source "drivers/iio/test/Kconfig"
> > =A0if IIO_TRIGGER
> > diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> > index 9622347a1c1b..20acf5e1a4a7 100644
> > --- a/drivers/iio/Makefile
> > +++ b/drivers/iio/Makefile
> > @@ -34,6 +34,7 @@ obj-y +=3D imu/
> > =A0obj-y +=3D light/
> > =A0obj-y +=3D magnetometer/
> > =A0obj-y +=3D multiplexer/
> > +obj-y +=3D offload/
> > =A0obj-y +=3D orientation/
> > =A0obj-y +=3D position/
> > =A0obj-y +=3D potentiometer/
> > diff --git a/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> > b/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> > index 7a8a71066b0e..a2fae6059616 100644
> > --- a/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> > +++ b/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> > @@ -86,6 +86,7 @@ static int iio_hw_trigger_buffer_probe(struct
> > auxiliary_device *adev,
> > =A0}
> > =A0
> > =A0static const struct auxiliary_device_id iio_hw_trigger_buffer_id_tab=
le[] =3D {
> > +	{ .name =3D "pwm-triggered-dma-buffer.triggered-buffer" },
> > =A0	{ }
> > =A0};
> > =A0MODULE_DEVICE_TABLE(auxiliary, iio_hw_trigger_buffer_id_table);
> > diff --git a/drivers/iio/offload/Kconfig b/drivers/iio/offload/Kconfig
> > new file mode 100644
> > index 000000000000..760c0cfe0e9c
> > --- /dev/null
> > +++ b/drivers/iio/offload/Kconfig
> > @@ -0,0 +1,21 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# SPI offload handlers for Industrial I/O
> > +#
> > +# When adding new entries keep the list in alphabetical order
> > +
> > +menu "SPI offload handlers"
> > +
> > +config IIO_PWM_TRIGGERED_DMA_BUFFER
> > +	tristate "PWM trigger and DMA buffer connected to SPI offload"
> > +	select AUXILIARY_BUS
> > +	select IIO_BUFFER_DMAENGINE
> > +	help
> > +	=A0 Provides a periodic hardware trigger via a PWM connected to the
> > +	=A0 trigger input of a SPI offload and a hardware buffer implemented
> > +	=A0 via DMA connected to the data output stream the a SPI offload.
> > +
> > +	=A0 To compile this driver as a module, choose M here: the
> > +	=A0 module will be called "iio-pwm-triggered-dma-buffer".
> > +
> > +endmenu
> > diff --git a/drivers/iio/offload/Makefile b/drivers/iio/offload/Makefile
> > new file mode 100644
> > index 000000000000..7300ce82f066
> > --- /dev/null
> > +++ b/drivers/iio/offload/Makefile
> > @@ -0,0 +1,2 @@
> > +
> > +obj-$(CONFIG_IIO_PWM_TRIGGERED_DMA_BUFFER) :=3D iio-pwm-triggered-dma-=
buffer.o
> > diff --git a/drivers/iio/offload/iio-pwm-triggered-dma-buffer.c
> > b/drivers/iio/offload/iio-pwm-triggered-dma-buffer.c
> > new file mode 100644
> > index 000000000000..970ea82316f6
> > --- /dev/null
> > +++ b/drivers/iio/offload/iio-pwm-triggered-dma-buffer.c
> > @@ -0,0 +1,212 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Platform driver for a PWM trigger and DMA buffer connected to a SPI
> > + * controller offload instance implementing the iio-hw-triggered-buffer
> > + * interface.
> > + *
> > + * Copyright (C) 2023 Analog Devices, Inc.
> > + * Copyright (C) 2023 BayLibre, SAS
> > + */
> > +
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/pwm.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/hw_triggered_buffer_impl.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/buffer-dmaengine.h>
> > +#include <linux/sysfs.h>
> > +
> > +struct iio_pwm_triggered_dma_buffer {
> > +	struct iio_hw_triggered_buffer_device hw;
> > +	struct pwm_device *pwm;
> > +};
> > +
> > +static const struct iio_trigger_ops iio_pwm_triggered_dma_buffer_ops;
> > +
> > +static int iio_pwm_triggered_dma_buffer_set_state(struct iio_trigger *=
trig,
> > bool state)
> > +{
> > +	struct iio_pwm_triggered_dma_buffer *st =3D
> > iio_trigger_get_drvdata(trig);
> > +
> > +	if (state)
> > +		return pwm_enable(st->pwm);
> > +
> > +	pwm_disable(st->pwm);
> > +
> > +	return 0;
> > +}
> > +
> > +static int iio_pwm_triggered_dma_buffer_validate_device(struct iio_tri=
gger
> > *trig,
> > +							struct iio_dev
> > *indio_dev)
> > +{
> > +	/* Don't allow assigning trigger via sysfs. */
> > +	return -EINVAL;
> > +}
> > +
> > +static const struct iio_trigger_ops iio_pwm_triggered_dma_buffer_ops =
=3D {
> > +	.set_trigger_state =3D iio_pwm_triggered_dma_buffer_set_state,
> > +	.validate_device =3D iio_pwm_triggered_dma_buffer_validate_device,
> > +};
> > +
> > +static u32 axi_spi_engine_offload_pwm_trigger_get_rate(struct iio_trig=
ger
> > *trig)
> > +{
> > +	struct iio_pwm_triggered_dma_buffer *st =3D
> > iio_trigger_get_drvdata(trig);
> > +	u64 period_ns =3D pwm_get_period(st->pwm);
> > +
> > +	if (period_ns)
> > +		return DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, period_ns);
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +axi_spi_engine_offload_set_samp_freq(struct iio_pwm_triggered_dma_buff=
er *st,
> > +				=A0=A0=A0=A0 u32 requested_hz)
> > +{
> > +	int period_ns;
> > +
> > +	if (requested_hz =3D=3D 0)
> > +		return -EINVAL;
> > +
> > +	period_ns =3D DIV_ROUND_UP(NSEC_PER_SEC, requested_hz);
> > +
> > +	/*
> > +	 * FIXME: We really just need a clock, not a PWM. The current duty
> > cycle
> > +	 * value is a hack to work around the edge vs. level offload trigger
> > +	 * issue in the ADI AXI SPI Engine firmware.
> > +	 */
> > +	return pwm_config(st->pwm, 10, period_ns);
> > +}
> > +
> > +static ssize_t sampling_frequency_show(struct device *dev,
> > +				=A0=A0=A0=A0=A0=A0 struct device_attribute *attr, char
> > *buf)
> > +{
> > +	struct iio_trigger *trig =3D to_iio_trigger(dev);
> > +
> > +	return sysfs_emit(buf, "%u\n",
> > +			=A0 axi_spi_engine_offload_pwm_trigger_get_rate(trig));
> > +}
> > +
> > +static ssize_t sampling_frequency_store(struct device *dev,
> > +					struct device_attribute *attr,
> > +					const char *buf, size_t len)
> > +{
> > +	struct iio_trigger *trig =3D to_iio_trigger(dev);
> > +	struct iio_pwm_triggered_dma_buffer *st =3D
> > iio_trigger_get_drvdata(trig);
> > +	int ret;
> > +	u32 val;
> > +
> > +	ret =3D kstrtou32(buf, 10, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D axi_spi_engine_offload_set_samp_freq(st, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return len;
> > +}
> > + =20
>=20
> This is also something that made me wonder... In the end of the day, the
> frequency at which we want to sample the data depends on the converter de=
vice.
> This completely detached interface makes it more easy for the user to scr=
ew up
> things, right?
It's easy to do that anyway :) If you think of a normal SPI attached device=
 that
has it's own internal clocking then it's usually easy to set the device to =
grab
data faster than than the spi bus can drain it.  We drop samples.

Here it might make sense to add some bounds I guess as it's all in hardware
- either have the ADC provide them or push it to DT,

>=20
> Things might even become more complicated in usecases where we have an
> additional pwm (on top of the data fetch trigger one) for triggering conv=
ersions
> in the converter and we might need to properly control the phase between =
those
> two signals. So, how would we handle it in the current form? We have one =
pwm
> belonging to the offload engine and one belonging to the converter but th=
ey need
> to cope together...

Groan loudly?=20
If someone wants careful sync between a trigger for the ADC and the read ba=
ck triggering
they should do it in hardware. Sure we can do it if the pwm is sophisticate=
d enough
but the mess of layering etc needed to make it work is just nasty.

I guess you make a custom trigger that bakes in your requirements.

>=20
> I'm aware you have some alternative ideas for not using pwms but the seri=
es is
> using pwms... And the above usecase is real and it's sitting out of tree =
waiting
> for the offload stuff to get merged so I can upstream that driver :)

Gah.  So much for hoping you were conjecturing something unusual.

Jonathan

>=20
> - Nuno S=E1
>=20
>=20
>=20


