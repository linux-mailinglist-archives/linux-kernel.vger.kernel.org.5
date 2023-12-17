Return-Path: <linux-kernel+bounces-2671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0121981603D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8611F21ADF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4353245972;
	Sun, 17 Dec 2023 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUbrrj04"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E044C85;
	Sun, 17 Dec 2023 15:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A995BC433C8;
	Sun, 17 Dec 2023 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702828013;
	bh=9u5BaYhIisfzNS8HzBpNUNRjTxkpWextM4rdkhbCPmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bUbrrj04PveYg5hi7UTHjX4kRYxZIwfu+cPFoReJQbctsOLE+eSEZIMHg5igA7J9L
	 fdOVmi+pvCjGeE7RxlT4EmOWm7NIY6jFpGZsWT+uv3Ygk5y115T43Q2PN+FeFXtUY0
	 9ABL/Qtf4Mn6Td/3Kv4+3h/ZD4YGgLfpn/k6VAmvgn5UmfjPvsedaKcYTldsWU0R/E
	 i2Mvo+NgSLpugjSemxbEp58uUowql+JBX+U6QD6k1FyWzFDCQFqAPgVUuObyzZ0kA+
	 gNflBnWfzAE8ww5z8kSrffbahGJkP1eIOJh5C05QGs7IqLG1riZqEybVr0pk2KmGBE
	 Ghd5UtfzgvQmA==
Date: Sun, 17 Dec 2023 15:46:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
 <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
 <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <dan.carpenter@linaro.org>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 13/15] iio: adc: Add support for AD7091R-8
Message-ID: <20231217154636.07ed31b4@jic23-huawei>
In-Reply-To: <9a0267bc8d444f2c196d1cbc4e9a22debf5d8e4e.1702746240.git.marcelo.schmitt1@gmail.com>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
	<9a0267bc8d444f2c196d1cbc4e9a22debf5d8e4e.1702746240.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 14:50:44 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add support for Analog Devices AD7091R-2, AD7091R-4, and AD7091R-8
> low power 12-Bit SAR ADCs with SPI interface.
> Extend ad7091r-base driver so it can be used by the AD7091R-8 driver.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo

A few trivial things from taking another look.

Jonathan

> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index a30dc587ce45..57355ca157a1 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/bitfield.h>

Not obvious what connection of this header to the code below is...
Wrong patch perhaps?
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
> @@ -187,6 +188,12 @@ int ad7091r_probe(struct device *dev, const struct ad7091r_init_info *init_info,
>  	iio_dev->info = &ad7091r_info;
>  	iio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	if (init_info->setup) {
> +		ret = init_info->setup(st);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	if (irq) {
>  		st->chip_info = &init_info->irq_info;
>  		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> index 2b4e25e766c8..994505a740b3 100644
> --- a/drivers/iio/adc/ad7091r-base.h
> +++ b/drivers/iio/adc/ad7091r-base.h
> @@ -45,6 +45,8 @@
>  	.scan_type.realbits = bits,					\
>  }
>  
> +#include <linux/gpio/consumer.h>
> +

struct gpio_desc;

and drop the include which only provides an opaque definition anyway.

>  struct device;
>  
>  enum ad7091r_mode {
> @@ -56,10 +58,14 @@ enum ad7091r_mode {
>  struct ad7091r_state {
>  	struct device *dev;
>  	struct regmap *map;
> +	struct gpio_desc *convst_gpio;
> +	struct gpio_desc *reset_gpio;
>  	struct regulator *vref;
>  	const struct ad7091r_chip_info *chip_info;
>  	enum ad7091r_mode mode;
>  	struct mutex lock; /*lock to prevent concurent reads */
> +	__be16 tx_buf __aligned(IIO_DMA_MINALIGN);
> +	__be16 rx_buf;
>  };
>  
>  struct ad7091r_chip_info {
> @@ -77,6 +83,7 @@ struct ad7091r_init_info {
>  	const struct regmap_config *regmap_config;
>  	void (*init_adc_regmap)(struct ad7091r_state *st,
>  				const struct regmap_config *regmap_conf);
> +	int (*setup)(struct ad7091r_state *st);
>  };
>  
>  extern const struct iio_event_spec ad7091r_events[3];
> diff --git a/drivers/iio/adc/ad7091r8.c b/drivers/iio/adc/ad7091r8.c
> new file mode 100644
> index 000000000000..0a6da47d89c0
> --- /dev/null
> +++ b/drivers/iio/adc/ad7091r8.c

> +static int ad7091r8_gpio_setup(struct ad7091r_state *st)
> +{
> +	st->convst_gpio = devm_gpiod_get(st->dev, "adi,conversion-start",
> +					 GPIOD_OUT_LOW);
> +	if (IS_ERR(st->convst_gpio))
> +		return dev_err_probe(st->dev, PTR_ERR(st->convst_gpio),
> +				     "Error getting convst GPIO\n");
> +
> +	st->reset_gpio =  devm_gpiod_get_optional(st->dev, "reset",

Trivial but looks like a bonus space after the =

> +						  GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->reset_gpio))
> +		return dev_err_probe(st->dev, PTR_ERR(st->convst_gpio),
> +				     "Error on requesting reset GPIO\n");
> +
> +	if (st->reset_gpio) {
> +		fsleep(20);
> +		gpiod_set_value_cansleep(st->reset_gpio, 0);
> +	}
> +
> +	return 0;
> +}

