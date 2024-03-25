Return-Path: <linux-kernel+bounces-117939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2D488B18A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1352E0D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FB0524B4;
	Mon, 25 Mar 2024 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0tERFDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE33611CAF;
	Mon, 25 Mar 2024 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398894; cv=none; b=oqF7+ewjQpd6DdFVEY8Mr0Ressrcs4mLClWxRHgZId7QSjAcx9LQv4Slp609LtZ8SNk2zad9GWf/eEi9ueSBvRr9gQAe+8Mdiv6TW1hGaBj4b24Ljmz97uJ82M/HNXvxsRVxYsQWkF3+9/dq6lg6t4BUUWaDr4wOClpzkz5XH/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398894; c=relaxed/simple;
	bh=z8pkwhblPYDWYbUTkiPmAZiyHWIKzehcJ1vL6rpN18Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJwIKX2HEQCLjgXLbbV4VYGni3t6PYCGPw1oBbW4pIoL0PreMV8sxlI6sOl6T7wEah77eUa33WkTXlSVpsYV8PTsNSM9S/sYWB3OHxKptUKRw03VNjDsF8W74AAD6Eaptg9NsMcQ6l8nlhkt47et4uD/Zjaz8xSmDowftGY7ou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0tERFDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B478C433F1;
	Mon, 25 Mar 2024 20:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711398894;
	bh=z8pkwhblPYDWYbUTkiPmAZiyHWIKzehcJ1vL6rpN18Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n0tERFDGr/pybjI3rXaJv03Ao0pvHDmmyw/h7nJ1J4d46QkDb1w1DDKgabVTnX9zZ
	 sqk8m+MiFSuleZv3XZExFzEi0dACU83oLJmiuoIK6BIldzXhy2o0vJ6GiTbxGTdf1e
	 IltsHBqWsG+ZyWi3kDFUUTjFFLSaTlltS9yFUnWGWxsiHB/cSbxx5LKtS3Ia6YRwH+
	 IjqA0IR8/huiRxsL6wbfG9zWJdMgeG9V5DhKp00WLM86u/jmAi58yx1SIDKyhczTzv
	 VeeCrdTZbBrRRyJcy+WnzTEgzYvTa5VYkwEI4j6unc8socZzlZLhzli0bHOonLgl4G
	 6G2YuQKffdnGQ==
Date: Mon, 25 Mar 2024 20:34:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v4 5/7] iio: accel: adxl345: Pass function pointer to
 core
Message-ID: <20240325203439.4c418016@jic23-huawei>
In-Reply-To: <20240325153356.46112-6-l.rubusch@gmail.com>
References: <20240325153356.46112-1-l.rubusch@gmail.com>
	<20240325153356.46112-6-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 15:33:54 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add a function pointer argument to the probe function in
> the core module to provide a way to pre-configure the bus.
> 
> The passed setup function can be prepared in the bus
> specific spi or the i2c module, or NULL otherwise. It shall
> then be executed in the bus independent core module.

Wrap descriptions at 75 chars, not around 60 as you've done here.

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345.h      |  3 ++-
>  drivers/iio/accel/adxl345_core.c | 10 +++++++++-
>  drivers/iio/accel/adxl345_i2c.c  |  2 +-
>  drivers/iio/accel/adxl345_spi.c  |  2 +-
>  4 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index ee169fed4..620a2e0f0 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -59,6 +59,7 @@ struct adxl345_chip_info {
>  	int uscale;
>  };
>  
> -int adxl345_core_probe(struct device *dev, struct regmap *regmap);
> +int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> +		       int (*setup)(struct device*, struct regmap*));
>  
>  #endif /* _ADXL345_H_ */
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index eba9c048a..476d729bc 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -168,13 +168,21 @@ static void adxl345_powerdown(void *regmap)
>  	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
>  }
>  
> -int adxl345_core_probe(struct device *dev, struct regmap *regmap)
> +int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> +	int (*setup)(struct device*, struct regmap*))

Wrap as per the header definition above. (align just after opening bracket).

>  {
>  	struct adxl345_data *data;
>  	struct iio_dev *indio_dev;
>  	u32 regval;
>  	int ret;
>  
> +	/* Perform optional initial bus specific configuration */
> +	if (setup) {
> +		ret = setup(dev, regmap);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Error reading device ID\n");
> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> index a3084b0a8..4065b8f7c 100644
> --- a/drivers/iio/accel/adxl345_i2c.c
> +++ b/drivers/iio/accel/adxl345_i2c.c
> @@ -27,7 +27,7 @@ static int adxl345_i2c_probe(struct i2c_client *client)
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>  
> -	return adxl345_core_probe(&client->dev, regmap);
> +	return adxl345_core_probe(&client->dev, regmap, NULL);
>  }
>  
>  static const struct adxl345_chip_info adxl345_i2c_info = {
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index 93ca349f1..1c0513bd3 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -33,7 +33,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>  
> -	return adxl345_core_probe(&spi->dev, regmap);
> +	return adxl345_core_probe(&spi->dev, regmap, NULL);
>  }
>  
>  static const struct adxl345_chip_info adxl345_spi_info = {


