Return-Path: <linux-kernel+bounces-24659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8618F82BFDE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E121B22681
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D327959B58;
	Fri, 12 Jan 2024 12:38:05 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7D55917E;
	Fri, 12 Jan 2024 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TBLbq6m5nz6D8wj;
	Fri, 12 Jan 2024 20:35:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 46C1D140B2F;
	Fri, 12 Jan 2024 20:38:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 12:38:00 +0000
Date: Fri, 12 Jan 2024 12:37:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S?=
 =?ISO-8859-1?Q?=E1?= <nuno.sa@analog.com>, Frank Rowand
	<frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-spi@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/13] iio: buffer: dmaengine: export
 devm_iio_dmaengine_buffer_alloc()
Message-ID: <20240112123759.00007440@Huawei.com>
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-10-e42c6a986580@baylibre.com>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	<20240109-axi-spi-engine-series-3-v1-10-e42c6a986580@baylibre.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 10 Jan 2024 13:49:51 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This changes devm_iio_dmaengine_buffer_alloc() to an exported symbol.
> This will be used by drivers that need to allocate a DMA buffer without
> attaching it to an IIO device.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  Documentation/driver-api/driver-model/devres.rst   |  1 +
>  drivers/iio/buffer/Kconfig                         | 14 +++++++-------
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  3 ++-
>  include/linux/iio/buffer-dmaengine.h               |  2 ++
>  4 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index b23d4a2b68a6..60e4b7ba38e5 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -285,6 +285,7 @@ I2C
>  IIO
>    devm_iio_device_alloc()
>    devm_iio_device_register()
> +  devm_iio_dmaengine_buffer_alloc()
>    devm_iio_dmaengine_buffer_setup()
>    devm_iio_kfifo_buffer_setup()
>    devm_iio_kfifo_buffer_setup_ext()
> diff --git a/drivers/iio/buffer/Kconfig b/drivers/iio/buffer/Kconfig
> index 925c5bf074bc..27d82fb4bc4d 100644
> --- a/drivers/iio/buffer/Kconfig
> +++ b/drivers/iio/buffer/Kconfig
> @@ -40,6 +40,13 @@ config IIO_BUFFER_HW_CONSUMER
>  	  Should be selected by drivers that want to use the generic Hw consumer
>  	  interface.
>  
> +config IIO_HW_TRIGGERED_BUFFER
> +	tristate "Industrial I/O hardware triggered buffer support"
> +	select AUXILIARY_BUS
> +	select IIO_TRIGGER
> +	help
> +	  Provides helper functions for setting up hardware triggered buffers.
> +
>  config IIO_KFIFO_BUF
>  	tristate "Industrial I/O buffering based on kfifo"
>  	help
> @@ -53,10 +60,3 @@ config IIO_TRIGGERED_BUFFER
>  	select IIO_KFIFO_BUF
>  	help
>  	  Provides helper functions for setting up triggered buffers.
> -
> -config IIO_HW_TRIGGERED_BUFFER
> -	tristate "Industrial I/O hardware triggered buffer support"
> -	select AUXILIARY_BUS
> -	select IIO_TRIGGER
> -	help
> -	  Provides helper functions for setting up hardware triggered buffers.

Why move this?

> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index c67ddf963bfb..03225939f223 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -244,7 +244,7 @@ static void __devm_iio_dmaengine_buffer_free(void *buffer)
>   *
>   * The buffer will be automatically de-allocated once the device gets destroyed.
>   */
> -static struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
> +struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
>  	const char *channel)
>  {
>  	struct iio_buffer *buffer;
> @@ -261,6 +261,7 @@ static struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
>  
>  	return buffer;
>  }
> +EXPORT_SYMBOL_GPL(devm_iio_dmaengine_buffer_alloc);
>  
>  /**
>   * devm_iio_dmaengine_buffer_setup() - Setup a DMA buffer for an IIO device
> diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
> index 5c355be89814..3ac616ddf5b9 100644
> --- a/include/linux/iio/buffer-dmaengine.h
> +++ b/include/linux/iio/buffer-dmaengine.h
> @@ -10,6 +10,8 @@
>  struct iio_dev;
>  struct device;
>  
> +struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
> +						   const char *channel);
>  int devm_iio_dmaengine_buffer_setup(struct device *dev,
>  				    struct iio_dev *indio_dev,
>  				    const char *channel);
> 


