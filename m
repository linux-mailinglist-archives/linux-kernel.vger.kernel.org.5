Return-Path: <linux-kernel+bounces-23303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F13682AAC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB7EB276E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0312311719;
	Thu, 11 Jan 2024 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYg6ZHzh"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A4411C94;
	Thu, 11 Jan 2024 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5588a83e0d0so559243a12.3;
        Thu, 11 Jan 2024 01:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704964903; x=1705569703; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ce4vc8GAIvndg6vA5e3AxS0CcpaiHnjGHdfJxz1nHzE=;
        b=CYg6ZHzhweOKwhSIRZ1iNI1fFjlP1QSI7idpSGjxOBdprq6p37vN1XvQeGDljsCBxd
         i9QRAAEIojR+a4C0MUPnKOod6tuLKxqZA6jck+KBo7cZf4UUyfQhKHbwJvUyGS/LkYXq
         D+CbV4fw8rnMlh44V2EpziOzzk8EOJnZcnXAfBmKRYcVS/1LXM6DmHsSF2eYEmNfyaiG
         hYdRWJ5l2ggI1pFSIOhjgZHXB0ScZm3gzRUFS8D6GvEIONHZ317pmpEKpap49guVIDz2
         8QtiRObk3YSM1qIsMthPQF2VjB8bL6kdYlR/jrhqEpyOpFRqsyD2cEZDHA4GPRLfNf+i
         uf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704964903; x=1705569703;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ce4vc8GAIvndg6vA5e3AxS0CcpaiHnjGHdfJxz1nHzE=;
        b=nCZ6C32/fKYj3QveHAlR0W39/bL6qgfH4o0QSEawPACpNXNMgtyjc05BAFgAYeTdT6
         /Jz0egwNzIzIc/9PltrElXXQYyt95Vbf+kft+ofP6r5qqHAmWVoomJHfyTR0RoDIUOaI
         Rb5rg599xJubqtRj29aIwLiC1lFc7iaW4hRLLqB76i8Cvmp+J3IetqFW2Am7rERF9Ub/
         65sAtori9PicrjYZlC9UtwJVBHjMHS0Kih1eGzbwsD0GcfD8mWS2JwUZuOUZRB6iG2bZ
         diuW/CZpBh978NnZ+B6gSEaMG8Sabp5ux1IXC5XnwSrxfcMB2685rqJMdhsjNMRG6LWQ
         i06g==
X-Gm-Message-State: AOJu0Yx/sjDmngRCI1S1WhVHQTEQj13VoYmLs/8AL9KckRFNoBx4OVof
	A6l4aA8VJkeWi3toycL72Us=
X-Google-Smtp-Source: AGHT+IH9LwiHdXnbnFcVRvOx1e2B0WFLGaB6iflxXlXkMRZ5qhw9EBDyi65/pSbk22FAu/fRMIQvYw==
X-Received: by 2002:a17:906:4694:b0:a28:b9a7:c787 with SMTP id a20-20020a170906469400b00a28b9a7c787mr353814ejr.54.1704964903050;
        Thu, 11 Jan 2024 01:21:43 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090626c100b00a26a63346ddsm342965ejc.87.2024.01.11.01.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:21:42 -0800 (PST)
Message-ID: <bd64938e170f967803f244d401c641d1679d0aee.camel@gmail.com>
Subject: Re: [PATCH 08/13] iio: buffer: add new hardware triggered buffer
 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Frank Rowand
 <frowand.list@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>,  linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 11 Jan 2024 10:24:54 +0100
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-8-e42c6a986580@baylibre.com>
References: 
	<20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	 <20240109-axi-spi-engine-series-3-v1-8-e42c6a986580@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-10 at 13:49 -0600, David Lechner wrote:
> This adds a new hardware triggered buffer driver for the IIO subsystem.
> This driver is intended to be used by IIO device drivers that have
> a hardware buffer that is triggered by a hardware signal.
>=20
> It is expected that components such as those providing a backend via the
> IIO backend framework will provide the actual implementation of this
> functionality by registering a matching device on the auxiliary bus.
> The auxiliary bus was chosen since it allows us to make use of existing
> kernel infrastructure instead of implementing our own registration and
> lookup system.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0Documentation/driver-api/driver-model/devres.rst=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> =C2=A0drivers/iio/buffer/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 ++
> =C2=A0drivers/iio/buffer/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../iio/buffer/industrialio-hw-triggered-buffer.c=C2=A0 | 104
> +++++++++++++++++++++
> =C2=A0include/linux/iio/hw_triggered_buffer.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +++
> =C2=A0include/linux/iio/hw_triggered_buffer_impl.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 16 ++++
> =C2=A06 files changed, 143 insertions(+)
>=20
> diff --git a/Documentation/driver-api/driver-model/devres.rst
> b/Documentation/driver-api/driver-model/devres.rst
> index c5f99d834ec5..b23d4a2b68a6 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -296,6 +296,7 @@ IIO
> =C2=A0=C2=A0 devm_iio_channel_get()
> =C2=A0=C2=A0 devm_iio_channel_get_all()
> =C2=A0=C2=A0 devm_iio_hw_consumer_alloc()
> +=C2=A0 devm_iio_hw_triggered_buffer_setup()
> =C2=A0=C2=A0 devm_fwnode_iio_channel_get_by_name()
> =C2=A0
> =C2=A0INPUT
> diff --git a/drivers/iio/buffer/Kconfig b/drivers/iio/buffer/Kconfig
> index 047b931591a9..925c5bf074bc 100644
> --- a/drivers/iio/buffer/Kconfig
> +++ b/drivers/iio/buffer/Kconfig
> @@ -53,3 +53,10 @@ config IIO_TRIGGERED_BUFFER
> =C2=A0	select IIO_KFIFO_BUF
> =C2=A0	help
> =C2=A0	=C2=A0 Provides helper functions for setting up triggered buffers.
> +
> +config IIO_HW_TRIGGERED_BUFFER
> +	tristate "Industrial I/O hardware triggered buffer support"
> +	select AUXILIARY_BUS
> +	select IIO_TRIGGER
> +	help
> +	=C2=A0 Provides helper functions for setting up hardware triggered
> buffers.
> diff --git a/drivers/iio/buffer/Makefile b/drivers/iio/buffer/Makefile
> index 1403eb2f9409..d1142bb20f61 100644
> --- a/drivers/iio/buffer/Makefile
> +++ b/drivers/iio/buffer/Makefile
> @@ -9,4 +9,5 @@ obj-$(CONFIG_IIO_BUFFER_DMA) +=3D industrialio-buffer-dma=
o
> =C2=A0obj-$(CONFIG_IIO_BUFFER_DMAENGINE) +=3D industrialio-buffer-dmaengi=
ne.o
> =C2=A0obj-$(CONFIG_IIO_BUFFER_HW_CONSUMER) +=3D industrialio-hw-consumer.=
o
> =C2=A0obj-$(CONFIG_IIO_TRIGGERED_BUFFER) +=3D industrialio-triggered-buff=
er.o
> +obj-$(CONFIG_IIO_HW_TRIGGERED_BUFFER) +=3D industrialio-hw-triggered-buf=
fer.o
> =C2=A0obj-$(CONFIG_IIO_KFIFO_BUF) +=3D kfifo_buf.o
> diff --git a/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> b/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> new file mode 100644
> index 000000000000..7a8a71066b0e
> --- /dev/null
> +++ b/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 Analog Devices, Inc.
> + * Copyright (c) 2024 BayLibre, SAS
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/container_of.h>
> +#include <linux/export.h>
> +#include <linux/module.h>
> +#include <linux/iio/hw_triggered_buffer_impl.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +
> +static int iio_hw_triggered_buffer_match(struct device *dev, const void
> *match)
> +{
> +	return dev->parent =3D=3D match;
> +}
> +
> +static struct iio_hw_triggered_buffer_device
> +*iio_hw_trigger_buffer_get(struct device *match)
> +{
> +	struct auxiliary_device *adev;
> +
> +	adev =3D auxiliary_find_device(NULL, match,
> iio_hw_triggered_buffer_match);
> +	if (!adev)
> +		return ERR_PTR(-ENOENT);
> +
> +	return container_of(adev, struct iio_hw_triggered_buffer_device,
> adev);
> +}
> +
> +static void iio_hw_trigger_buffer_put(void *dev)
> +{
> +	put_device(dev);
> +}
> +
> +/**
> + * devm_iio_hw_triggered_buffer_setup - Setup a hardware triggered buffe=
r
> + * @dev:	Device for devm management
> + * @indio_dev:	An unconfigured/partially configured IIO device struct
> + * @match:	Device for matching the auxiliary bus device that provides
> the
> + *		interface to the hardware triggered buffer
> + * @ops:	Buffer setup functions to use for this IIO device
> + *
> + * Return: 0 on success, negative error code on failure.
> + *
> + * This function will search all registered hardware triggered buffers f=
or
> one
> + * that matches the given indio_dev. If found, it will be used to setup =
both
> + * the trigger and the buffer on the indio_dev.
> + */
> +int devm_iio_hw_triggered_buffer_setup(struct device *dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *match,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_buffer_setup_o=
ps
> *ops)
> +{
> +	struct iio_hw_triggered_buffer_device *hw;
> +	int ret;
> +
> +	hw =3D iio_hw_trigger_buffer_get(match);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	ret =3D devm_add_action_or_reset(dev, iio_hw_trigger_buffer_put, &hw-
> >adev.dev);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->modes |=3D INDIO_HW_BUFFER_TRIGGERED;
> +	indio_dev->trig =3D iio_trigger_get(hw->trig);
> +	indio_dev->setup_ops =3D ops;
> +
> +	return iio_device_attach_buffer(indio_dev, hw->buffer);
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_hw_triggered_buffer_setup);
> +
> +static int iio_hw_trigger_buffer_probe(struct auxiliary_device *adev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct auxiliary_device_i=
d *id)
> +{
> +	struct iio_hw_triggered_buffer_device *hw =3D
> +		container_of(adev, struct iio_hw_triggered_buffer_device,
> adev);
> +
> +	if (!hw->buffer || !hw->trig)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct auxiliary_device_id iio_hw_trigger_buffer_id_table[]=
 =3D {
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, iio_hw_trigger_buffer_id_table);
> +
> +static struct auxiliary_driver iio_hw_trigger_buffer_driver =3D {
> +	.driver =3D {
> +		.name =3D "iio-hw-triggered-buffer",
> +	},
> +	.probe =3D iio_hw_trigger_buffer_probe,
> +	.id_table =3D iio_hw_trigger_buffer_id_table,
> +};
> +module_auxiliary_driver(iio_hw_trigger_buffer_driver);

This is one more example why I think the whole thing is overly complicated.=
 If
I'm understanding things right, we have the spi controller creating platfor=
m
devices that will be probed by the new IIO offload driver that then creates=
 an
auxiliary device that is probed by this driver. Even by looking at the prob=
e
function, it already feels to me that something is architecturally wrong (a=
s we
are essentially doing error handling in there).

One idea that just occurred to me now is to perhaps extend the IIO inkernel
interface so that we can split the logic a bit and have IIO devices consumi=
ng or
taking ownership of buffers created by other devices. Hmm, maybe not that g=
ood
of an idea :(

- Nuno S=C3=A1



