Return-Path: <linux-kernel+bounces-79790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4778626BF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7911F21370
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BF14C3D0;
	Sat, 24 Feb 2024 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puNCuUNB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D08481D0;
	Sat, 24 Feb 2024 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708798951; cv=none; b=pR8wbUAU+wE6R4VwtaGGJKwwW2H7V9CnuLyAVxRBbypDeqM0pP1HrnnWnsDi/tzsMN2b0JMMbtHh2/YDtXP5FyEA+0fnL9TN9x2Q7fSZB5D3gSYaMr6Izjt/S4abE8poslx+U4JDI2zqo3Jc77VvPUKljUWRqK50LseELojWTzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708798951; c=relaxed/simple;
	bh=vITQDNHGejyqlMVNnPYBxyzzJU5RBoH076vJprzwKp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvbN7fBXWYUu3FqDH0evUmDTG9QoGVa54ohxhBzdTRGTxLjLJLjUk7/1jHWIAith+apRccSGVHwJiu+03N0bbXgoQe33QQbsnJXX1rsi8Wac0MXfRlJPHneIu+XCpbT5V83Igkde8VwxU5zKtresSwDKnjvfNDMSBBZ6TTlSEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puNCuUNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DECAC433C7;
	Sat, 24 Feb 2024 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708798951;
	bh=vITQDNHGejyqlMVNnPYBxyzzJU5RBoH076vJprzwKp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=puNCuUNBtjbmwNa9S5Zz8I5sBpVY8EFbGj0mYnM1BxHYs4giFO8FK62F1eZFQ66OF
	 fulO2ZdQr09QEzLrFY+p/Fves3PROh2Xz2zMxVmxvkTuC9O3KJ/BIlELPhXgicJtid
	 0RFLCBYkt2zr/lDcDwLwLRSEeOoQuzB3UxBKrFwFngxKxUWSu92ZKNkaxmZENkRI0Z
	 fK86TDfWjLztOK59S4N1AYib1OyitZvZYSkry6LcfOkjFK2ZVN6fbt/Thw2HPgC9e0
	 TEpkvTQ8RlIaYue5s/LNyHTfNNs7Xn2JyCE8Wj8bkg6RegiQF+W6J6CS0bnTcyBl2N
	 YsgrW2b8+heIw==
Date: Sat, 24 Feb 2024 18:22:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: humidity: hdc3020: add power management
Message-ID: <20240224182215.058aaecb@jic23-huawei>
In-Reply-To: <20240220-hdc3020-pm-v1-2-d8e60dbe79e9@gmail.com>
References: <20240220-hdc3020-pm-v1-0-d8e60dbe79e9@gmail.com>
	<20240220-hdc3020-pm-v1-2-d8e60dbe79e9@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 22:14:56 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The HDC3020 sensor carries out periodic measurements during normal
> operation, but as long as the power supply is enabled, it will carry on
> in low-power modes. In order to avoid that and reduce power consumption,
> the device can be switched to Trigger-on Demand mode, and if possible,
> turn off its regulator.
> 
> According to the datasheet, the maximum "Power Up Ready" is 5 ms.
> 
> Add resume/suspend pm operations to manage measurement mode and
> regulator state.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Hi Javier,

Comments inline. Mainly that you should not have side effects if the power
up fails and you should fail probe.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/hdc3020.c | 81 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 65 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> index 11ede97a31d7..0da5c5c41cd2 100644
> --- a/drivers/iio/humidity/hdc3020.c
> +++ b/drivers/iio/humidity/hdc3020.c
> @@ -20,6 +20,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/units.h>
>  
>  #include <asm/unaligned.h>
> @@ -68,6 +70,7 @@
>  
>  struct hdc3020_data {
>  	struct i2c_client *client;
> +	struct regulator *vdd_supply;
>  	/*
>  	 * Ensure that the sensor configuration (currently only heater is
>  	 * supported) will not be changed during the process of reading
> @@ -551,9 +554,39 @@ static const struct iio_info hdc3020_info = {
>  	.write_event_value = hdc3020_write_thresh,
>  };
>  
> -static void hdc3020_stop(void *data)
> +static int hdc3020_power_on(struct hdc3020_data *data)
>  {
> -	hdc3020_exec_cmd((struct hdc3020_data *)data, HDC3020_EXIT_AUTO);
> +	int ret;
> +
> +	ret = regulator_enable(data->vdd_supply);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(5000);
> +
> +	if (data->client->irq) {
> +		/*
> +		 * The alert output is activated by default upon power up,
> +		 * hardware reset, and soft reset. Clear the status register.
> +		 */
> +		ret = hdc3020_exec_cmd(data, HDC3020_S_STATUS);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return hdc3020_exec_cmd(data, HDC3020_S_AUTO_10HZ_MOD0);
Expectation of a power on fail, in probe at least is it should cleanup after
itself.  It's messier in resume because there isn't anything sensible to do
about it, but we should keep to the convention of no side effects on
failure.

As such if either of the later parts of this fail, you should power
down the regulator before returning.


> +}
> +
> +static int hdc3020_power_off(struct hdc3020_data *data)
> +{
> +	hdc3020_exec_cmd(data, HDC3020_EXIT_AUTO);
> +
> +	return regulator_disable(data->vdd_supply);
> +}
> +
> +static void hdc3020_exit(void *data)
> +{
> +	hdc3020_power_off((struct hdc3020_data *)data);

Trivial but no need to cast a void * to anything as the C standard says this
is fine as implicit.

>  }
>  
>  static int hdc3020_probe(struct i2c_client *client)
> @@ -569,6 +602,8 @@ static int hdc3020_probe(struct i2c_client *client)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> +	dev_set_drvdata(&client->dev, (void *)indio_dev);
> +
>  	data = iio_priv(indio_dev);
>  	data->client = client;
>  	mutex_init(&data->lock);
> @@ -580,6 +615,14 @@ static int hdc3020_probe(struct i2c_client *client)
>  	indio_dev->info = &hdc3020_info;
>  	indio_dev->channels = hdc3020_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
> +
> +	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
> +				     "Unable to get VDD regulator\n");
> +
> +	hdc3020_power_on(data)

Check return value. We want to fail probe if the power up didn't work!

> +
>  	if (client->irq) {
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
>  						NULL, hdc3020_interrupt_handler,
> @@ -588,22 +631,9 @@ static int hdc3020_probe(struct i2c_client *client)
>  		if (ret)
>  			return dev_err_probe(&client->dev, ret,
>  					     "Failed to request IRQ\n");
> -
> -		/*
> -		 * The alert output is activated by default upon power up,
> -		 * hardware reset, and soft reset. Clear the status register.
> -		 */
> -		ret = hdc3020_exec_cmd(data, HDC3020_S_STATUS);
> -		if (ret)
> -			return ret;
>  	}
>  
> -	ret = hdc3020_exec_cmd(data, HDC3020_S_AUTO_10HZ_MOD0);
> -	if (ret)
> -		return dev_err_probe(&client->dev, ret,
> -				     "Unable to set up measurement\n");
> -
> -	ret = devm_add_action_or_reset(&data->client->dev, hdc3020_stop, data);
> +	ret = devm_add_action_or_reset(&data->client->dev, hdc3020_exit, data);
>  	if (ret)
>  		return ret;
>  
> @@ -614,6 +644,24 @@ static int hdc3020_probe(struct i2c_client *client)
>  	return 0;
>  }
>

