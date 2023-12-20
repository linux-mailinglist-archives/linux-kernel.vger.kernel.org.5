Return-Path: <linux-kernel+bounces-7078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C18BB81A15A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B241F2312B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B390D3D964;
	Wed, 20 Dec 2023 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhaBPw0l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA93D3AC;
	Wed, 20 Dec 2023 14:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97277C433C7;
	Wed, 20 Dec 2023 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703083578;
	bh=yclrQ9WVb2jpGcxaOJhroUgx5E0M9Mg46SOQ/IzXZEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZhaBPw0lfw2aG/SbYwjLTEXE5aZyHBRWbGkDoYEzP/B2XlEQd+oVGsT9sIYOEKxkm
	 A4VfpN54Z4DZGqlmuZntKx0G97a7oSS8wFUlLIbt+rRH5lGfGcxEDsCUgGpnjMkv1/
	 cNoQdMefSPy9GqADFcALOPuH9UXXssqccJCH7xQXRS85PAsjwwJ1tpPJ1erds1Elcx
	 A5oFeejTi6y5HfU3W5Am9L58LGT5W9xCq/DFS5TMDH5SUgcSuWF5gsAnQvDlguEib6
	 04VxGu6zuAJohp1F4jODmntqE7sKHaIxlOm5iem/RWkvLdpNoCd57/b1Z0P6nP707x
	 uf8Fh7n/QHcqA==
Date: Wed, 20 Dec 2023 14:46:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: Jonathan.Cameron@huawei.com, lars@metafoo.de,
 Qing-wu.Li@leica-geosystems.com.cn, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmi088: add i2c support for bmi088 accel
 driver
Message-ID: <20231220144604.66ade667@jic23-huawei>
In-Reply-To: <20231218154045.219317-1-jerrysteve1101@gmail.com>
References: <20231218154045.219317-1-jerrysteve1101@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 23:40:45 +0800
Jun Yan <jerrysteve1101@gmail.com> wrote:

> The BMI088, BMI085 and BMI090L accelerometer also support
> I2C protocol, so let's add the missing I2C support.
> 
> The I2C interface of the {BMI085,BMI088,BMI090L} is compatible with the I2C Specification UM10204 Rev. 03 (19 June
> 2007), available at http://www.nxp.com. The {BMI085,BMI088,BMI090L} supports I2C standard mode and fast mode, only
> 7-bit address mode is supported.[1][2][3]
> 
> [1]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi085-ds001.pdf
> [2]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
> [3]: https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/4807/BST-BMI090L-DS000-00.pdf
> 
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Hi Jun Yan

The header bug that 0-day found is curious given I'm not sure how you built
this with that wrong path...  Anyhow, a local quirk probably!

One comment inline, but it's asking for a significant refactor of the bmi088
core code so I don't mind if you say you'd rather leave that for another time.

Jonathan



> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 311ead9c3ef1..db90532ba24a 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
>  obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
>  obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
>  obj-$(CONFIG_BMI088_ACCEL) += bmi088-accel-core.o
> +obj-$(CONFIG_BMI088_ACCEL_I2C) += bmi088-accel-i2c.o
>  obj-$(CONFIG_BMI088_ACCEL_SPI) += bmi088-accel-spi.o
>  obj-$(CONFIG_DA280)	+= da280.o
>  obj-$(CONFIG_DA311)	+= da311.o
> diff --git a/drivers/iio/accel/bmi088-accel-i2c.c b/drivers/iio/accel/bmi088-accel-i2c.c
> new file mode 100644
> index 000000000000..1dcca0e88c1a
> --- /dev/null
> +++ b/drivers/iio/accel/bmi088-accel-i2c.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
> + *  - BMI088
> + *  - BMI085
> + *  - BMI090L
> + *
> + * Copyright 2023 Jun Yan <jerrysteve1101@gmail.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/i2c/i2c.h>
Path wrong... linux/i2c.h

> +
> +#include "bmi088-accel.h"
> +
> +static int bmi088_accel_probe(struct i2c_device *i2c)
> +{
> +	struct regmap *regmap;
> +	const struct i2c_device_id *id = i2c_get_device_id(i2c);

Hmm. So ideally you would do the following... But it's a major
rework to bring the bmi088 up to date with the new helpers so 
I'll take this without if you'd prefer the simple solution and
we can look at the refactor as a follow up patch (particularly
if you are happy to test the changes!)

Please add data to bmi088_of_match_data() and then use the more
flexible method of i2c_get_match_data()

Using the device ID runs into corner cases with fallback compatibles
where a match might not be found.

Note that to do this you will need to make the bmi088_accel_core_probe()
take a pointer to the chip info + make that data available to this 
> +
> +	regmap = devm_regmap_init_i2c(&i2c->dev, &bmi088_regmap_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&i2c->dev, "Failed to initialize i2c regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return bmi088_accel_core_probe(&i2c->dev, regmap, i2c->irq,
> +					id->driver_data);
> +}
> +
> +static void bmi088_accel_remove(struct i2c_device *i2c)
> +{
> +	bmi088_accel_core_remove(&i2c->dev);
> +}
> +
> +static const struct of_device_id bmi088_of_match[] = {
> +	{ .compatible = "bosch,bmi085-accel" },
> +	{ .compatible = "bosch,bmi088-accel" },
> +	{ .compatible = "bosch,bmi090l-accel" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, bmi088_of_match);
> +
> +static const struct i2c_device_id bmi088_accel_id[] = {
> +	{"bmi085-accel",  BOSCH_BMI085},
> +	{"bmi088-accel",  BOSCH_BMI088},
> +	{"bmi090l-accel", BOSCH_BMI090L},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, bmi088_accel_id);
> +
> +static struct i2c_driver bmi088_accel_driver = {
> +	.driver = {
> +		.name	= "bmi088_accel_i2c",
> +		.pm	= pm_ptr(&bmi088_accel_pm_ops),
> +		.of_match_table = bmi088_of_match,
> +	},
> +	.probe		= bmi088_accel_probe,
> +	.remove		= bmi088_accel_remove,
> +	.id_table	= bmi088_accel_id,
> +};
> +module_i2c_driver(bmi088_accel_driver);
> +
> +MODULE_AUTHOR("Jun Yan <jerrysteve1101@gmail.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("BMI088 accelerometer driver (I2C)");
> +MODULE_IMPORT_NS(IIO_BMI088);


