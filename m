Return-Path: <linux-kernel+bounces-89820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E452286F617
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4792860BE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8D56CDB6;
	Sun,  3 Mar 2024 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq+O5bvY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D238E2E40B;
	Sun,  3 Mar 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709483481; cv=none; b=T1Ua3uLiuws7EoPkef+gBXELeYPFrNL3bfWVHmc+H8lXtSzhfmgxpjHUCzta0P819ZV2KDq5P1Gt6XkxT4IfEKH1OflR5IfwRvXRJvM2Utq80vu1L60gY36/ZZwRnT/lWTHfuqnp8TyF6hO2cbpJoQVDDqVGq2O2KBs5hmLfVoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709483481; c=relaxed/simple;
	bh=1/k7rOAef6xLqEQ3bxSBmMvZ2cjhxdxUFi46PrI5YVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poqmc0gHi5kHqrU3ikEPFpRZbnZ+qB+HgJXofnwGJ/1+JikhYgsmKToO7WM+hMFHiafy8i8CyBb1jAAlHsBHmF5+2M8tWeqw90K+aDVSlxdNTMfJRMoZSUENyZIlsH9yDz4VjtjS5EbCzZSNtpIFHiH+4vvlH9Uwd2oRb0H6Sso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq+O5bvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71908C433F1;
	Sun,  3 Mar 2024 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709483481;
	bh=1/k7rOAef6xLqEQ3bxSBmMvZ2cjhxdxUFi46PrI5YVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eq+O5bvYIBvJeIdxC7UBcchAZ5mRByJj5pSqhk7j7dQsE7RgD3SfK8WxXxiHcKBmv
	 /KPtG4qa3S+XCH68uGSylOXuWWq9fgLw2c5Geh35a8i4s6I4WbBPkp3Eri8izu7WXv
	 1Iqtq2MNEOZ6MQGwkY1A329LaxuzCR7iHfFmTCFMr+seARLG2RhKpA8vRsD9u5xbnF
	 mVPPLuVyx6KOtgkUaog4oaqXQI/A3z28fAEejI/SMoIoWInn5FiVs7/vrlwQl52XAb
	 um6p1EnIFlJYTfLPwPbVtzd1aaMjRpvd/jQYt8/+eq+DY4+4Eve29Uzreac16jXWNu
	 7f7n7QlRY2EVQ==
Date: Sun, 3 Mar 2024 16:31:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: humidity: hdc3020: add power management
Message-ID: <20240303163106.25dbf4e5@jic23-huawei>
In-Reply-To: <20240226-hdc3020-pm-v2-1-cec6766086e8@gmail.com>
References: <20240226-hdc3020-pm-v2-0-cec6766086e8@gmail.com>
	<20240226-hdc3020-pm-v2-1-cec6766086e8@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 22:25:55 +0100
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

I think you leave the power on in a bunch of error paths in the probe()

Thanks,

Jonathan


> ---
>  drivers/iio/humidity/hdc3020.c | 89 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 73 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> index 1e5d0d4797b1..6848be41e1c8 100644
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
> @@ -551,9 +554,45 @@ static const struct iio_info hdc3020_info = {
>  	.write_event_value = hdc3020_write_thresh,
>  };
>  
> -static void hdc3020_stop(void *data)
> +static int hdc3020_power_off(struct hdc3020_data *data)
>  {
> -	hdc3020_exec_cmd((struct hdc3020_data *)data, HDC3020_EXIT_AUTO);
> +	hdc3020_exec_cmd(data, HDC3020_EXIT_AUTO);
> +
> +	return regulator_disable(data->vdd_supply);
> +}
> +
> +static int hdc3020_power_on(struct hdc3020_data *data)
> +{
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
> +		if (ret) {
> +			hdc3020_power_off(data);
> +			return ret;
> +		}
> +	}
> +
> +	ret = hdc3020_exec_cmd(data, HDC3020_S_AUTO_10HZ_MOD0);
> +	if (ret)
> +		hdc3020_power_off(data);
> +
> +	return ret;
> +}
> +
> +static void hdc3020_exit(void *data)
> +{
> +	hdc3020_power_off(data);
>  }
>  
>  static int hdc3020_probe(struct i2c_client *client)
> @@ -569,6 +608,8 @@ static int hdc3020_probe(struct i2c_client *client)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> +	dev_set_drvdata(&client->dev, (void *)indio_dev);
No need for casting to void *

> +
>  	data = iio_priv(indio_dev);
>  	data->client = client;
>  	mutex_init(&data->lock);
> @@ -580,6 +621,16 @@ static int hdc3020_probe(struct i2c_client *client)
>  	indio_dev->info = &hdc3020_info;
>  	indio_dev->channels = hdc3020_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(hdc3020_channels);
> +
> +	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
> +				     "Unable to get VDD regulator\n");
> +
> +	ret = hdc3020_power_on(data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "Power on failed\n");

Any error after this point needs to power down the regulator and stop the device.
So the devm_add_action_or_reset needs to be here, not down below.

When adding this sort of automated handling walk through the various paths
to check where they diverge.  If you can put the cleanup code right after
what it cleans up, then you get much less divergence where (in this case)
the power gets left on.

> +
>  	if (client->irq) {
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
>  						NULL, hdc3020_interrupt_handler,
> @@ -588,22 +639,9 @@ static int hdc3020_probe(struct i2c_client *client)
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
> @@ -614,6 +652,24 @@ static int hdc3020_probe(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static int hdc3020_suspend(struct device *dev)
> +{
> +	struct iio_dev *iio_dev = dev_get_drvdata(dev);
> +	struct hdc3020_data *data = iio_priv(iio_dev);
> +
> +	return hdc3020_power_off(data);
> +}
> +
> +static int hdc3020_resume(struct device *dev)
> +{
> +	struct iio_dev *iio_dev = dev_get_drvdata(dev);
> +	struct hdc3020_data *data = iio_priv(iio_dev);
> +
> +	return hdc3020_power_on(data);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(hdc3020_pm_ops, hdc3020_suspend, hdc3020_resume);
> +
>  static const struct i2c_device_id hdc3020_id[] = {
>  	{ "hdc3020" },
>  	{ "hdc3021" },
> @@ -633,6 +689,7 @@ MODULE_DEVICE_TABLE(of, hdc3020_dt_ids);
>  static struct i2c_driver hdc3020_driver = {
>  	.driver = {
>  		.name = "hdc3020",
> +		.pm = pm_sleep_ptr(&hdc3020_pm_ops),
>  		.of_match_table = hdc3020_dt_ids,
>  	},
>  	.probe = hdc3020_probe,
> 


