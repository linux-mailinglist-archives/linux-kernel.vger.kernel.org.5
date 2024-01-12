Return-Path: <linux-kernel+bounces-24892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFB482C44E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E8D283782
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9300E1B5BE;
	Fri, 12 Jan 2024 17:09:31 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FCA17C78;
	Fri, 12 Jan 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TBSdY1Rxcz6K5sT;
	Sat, 13 Jan 2024 01:07:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 84D8D140B2A;
	Sat, 13 Jan 2024 01:09:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 17:09:25 +0000
Date: Fri, 12 Jan 2024 17:09:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 5/6] iio: pressure: hsc030pa add triggered buffer
Message-ID: <20240112170924.000040af@Huawei.com>
In-Reply-To: <20240110172306.31273-6-petre.rodan@subdimension.ro>
References: <20240110172306.31273-1-petre.rodan@subdimension.ro>
	<20240110172306.31273-6-petre.rodan@subdimension.ro>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 10 Jan 2024 19:22:40 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add triggered buffer feature.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Hi Petre,

A few minor things inline. + you almost certainly need some Kconfig
changes to ensure buffered support is built for the IIO core.

> ---
>  drivers/iio/pressure/hsc030pa.c | 42 +++++++++++++++++++++++++++++++++
>  drivers/iio/pressure/hsc030pa.h |  2 +-
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030pa.c
> index 7e3f74d53b47..3faa0fd42201 100644
> --- a/drivers/iio/pressure/hsc030pa.c
> +++ b/drivers/iio/pressure/hsc030pa.c
> @@ -22,8 +22,11 @@
>  #include <linux/types.h>
>  #include <linux/units.h>
> 
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> 
>  #include <asm/unaligned.h>
> 
> @@ -297,6 +300,23 @@ static int hsc_get_measurement(struct hsc_data *data)
>  	return 0;
>  }
> 
> +static irqreturn_t hsc_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct hsc_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = hsc_get_measurement(data);
> +	if (!ret) {
Prefer error handling out of line + no {} for single statements

	if (ret)
		goto error;

	iio_push...

error:
	iio_trigger...

> +		iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> +						   iio_get_time_ns(indio_dev));
> +	}
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  /*
>   * IIO ABI expects
>   * value = (conv + offset) * scale
> @@ -382,13 +402,30 @@ static const struct iio_chan_spec hsc_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 14,
> +			.storagebits = 16,
> +			.shift = 0,

No need to specify shift if it's zero. That's considered the obvious default
and C will ensure it's set to 0 anyway.

> +			.endianness = IIO_BE,
> +		},
>  	},
>  	{
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 11,
> +			.storagebits = 16,
> +			.shift = 5,
> +			.endianness = IIO_BE,
> +		},
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
> 
>  static const struct iio_info hsc_info = {
> @@ -485,6 +522,11 @@ int hsc_common_probe(struct device *dev, hsc_recv_fn recv)
>  	indio_dev->channels = hsc->chip->channels;
>  	indio_dev->num_channels = hsc->chip->num_channels;
> 
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      hsc_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS(hsc_common_probe, IIO_HONEYWELL_HSC030PA);
> diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
> index 56dc8e88194b..6c635c42d85d 100644
> --- a/drivers/iio/pressure/hsc030pa.h
> +++ b/drivers/iio/pressure/hsc030pa.h
> @@ -56,7 +56,7 @@ struct hsc_data {
>  	s32 p_scale_dec;
>  	s64 p_offset;
>  	s32 p_offset_dec;
> -	u8 buffer[HSC_REG_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
> +	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);

Justify that size.  Normal trick is to use a suitable structure definition with
the channels and a timestamp s64 with force alignment (To deal with te annoying 
x86 32bit alignment)

>  };
> 
>  struct hsc_chip_data {
> --
> 2.41.0
> 
> 


