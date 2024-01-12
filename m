Return-Path: <linux-kernel+bounces-24662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC8D82BFED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07560B23AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8E86BB57;
	Fri, 12 Jan 2024 12:45:15 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1936BB3E;
	Fri, 12 Jan 2024 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TBLlr27Q8z6K9B9;
	Fri, 12 Jan 2024 20:42:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EEF014058E;
	Fri, 12 Jan 2024 20:45:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 12:45:10 +0000
Date: Fri, 12 Jan 2024 12:45:09 +0000
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
Subject: Re: [PATCH 12/13] iio: offload: add new PWM triggered DMA buffer
 driver
Message-ID: <20240112124509.000001b8@Huawei.com>
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-12-e42c6a986580@baylibre.com>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	<20240109-axi-spi-engine-series-3-v1-12-e42c6a986580@baylibre.com>
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

On Wed, 10 Jan 2024 13:49:53 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This adds a new driver for handling SPI offloading using a PWM as the
> trigger and DMA for the received data. This will be used by ADCs in
> conjunction with SPI controllers with offloading support to be able
> to sample at high rates without CPU intervention.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Ah. So if I read this right, the trigger only exists to provide somewhere
to hang the frequency control?   Not sure it's worth the complexity for that.


Do we expect a given offload engine to allow a bunch of 'standard' triggers?
If that's the case then I don't mind them being exposed as triggers. We do
that for a few other devices where we need to pick between a bunch of
different internal signals and it works fine.

> +
> +static int iio_pwm_triggered_dma_buffer_probe(struct platform_device *pdev)
> +{
> +	struct iio_pwm_triggered_dma_buffer *st;
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	st->pwm = devm_pwm_get(&pdev->dev, NULL);
> +	if (IS_ERR(st->pwm))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(st->pwm),
> +				     "failed to get PWM\n");
> +
> +	st->hw.buffer = devm_iio_dmaengine_buffer_alloc(&pdev->dev, "rx");
> +	if (IS_ERR(st->hw.buffer))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(st->hw.buffer),
> +				     "failed to allocate buffer\n");
> +
> +	st->hw.trig = devm_iio_trigger_alloc(&pdev->dev, "%s-%s-pwm-trigger",
> +					     dev_name(pdev->dev.parent),
> +					     dev_name(&pdev->dev));
> +	if (!st->hw.trig)
> +		return -ENOMEM;
> +
> +	st->hw.trig->ops = &iio_pwm_triggered_dma_buffer_ops;
> +	st->hw.trig->dev.parent = &pdev->dev;
> +	st->hw.trig->dev.groups = iio_pwm_triggered_dma_buffer_groups;
> +	iio_trigger_set_drvdata(st->hw.trig, st);
> +
> +	/* start with a reasonable default value */
> +	ret = axi_spi_engine_offload_set_samp_freq(st, 1000);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to set sampling frequency\n");
> +
> +	ret = devm_iio_trigger_register(&pdev->dev, st->hw.trig);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to register trigger\n");
> +
> +	adev = &st->hw.adev;
> +	adev->name = "triggered-buffer";
> +	adev->dev.parent = &pdev->dev;
> +	adev->dev.release = iio_pwm_triggered_dma_buffer_adev_release;
> +	adev->id = 0;
> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret)
> +		return ret;
> +
> +	ret = auxiliary_device_add(adev);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(&pdev->dev,
> +			iio_pwm_triggered_dma_buffer_unregister_adev, adev);
Split this an register the uninit and delete as separate callbacks to so we
can clearly see what each is doing.

> +}


