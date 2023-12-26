Return-Path: <linux-kernel+bounces-11579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9341F81E873
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED2628324A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3072B4F1F8;
	Tue, 26 Dec 2023 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DW7JsSsf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA094F880;
	Tue, 26 Dec 2023 16:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CA7C433C9;
	Tue, 26 Dec 2023 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703608408;
	bh=BLpbEr0p82hU35cCL/WJMYoHLvsmOrAn9yaHxoMbAmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DW7JsSsfjLMBTGd8nXVUXHzf+GZ7/kpGKc8X1X9eCgj7QkepA+e+mDEP2CrxG0wI9
	 NJWSHa9mmZTtpy8nyUWhCMHCLW/W3xYZ4nsKhH+MKXFqR+PuvCdvkX9KY4AihGPAhS
	 qB8O8ZW+bOVvELy4sKnq3G9yX2zM/i7YO9DDrVBSg+r3n+0qhGwJhNnHsVC6RsOKkS
	 M9IL1udH7FBYesxANCBG/+cVcjSho8Hjpm8JNHtwfanJ0sAHdWimOEm6fPNtj+xgSf
	 qmj5uvNMnK155X9qnesHDjlQXiqiCuuFfDJTY21ecdEyGWEdJLb5QMxPbIvFVqn3mZ
	 hyZXSk0f+yrFA==
Date: Tue, 26 Dec 2023 16:33:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Klinger
 <ak@it-klinger.de>, Lars-Peter Clausen <lars@metafoo.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Angel Iglesias
 <ang.iglesiasg@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 04/10] iio: pressure: mprls0025pa.c fix off-by-one
 enum
Message-ID: <20231226163321.33c12ff5@jic23-huawei>
In-Reply-To: <20231224143500.10940-5-petre.rodan@subdimension.ro>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
	<20231224143500.10940-5-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Dec 2023 16:34:49 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Fix off-by-one error in transfer-function property.
> The honeywell,transfer-function property takes values between 1-3 so
> make sure the proper enum gets used.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Hi Petre

Same question on what Andreas has to do with this patch and need
for some other tag to explain that.

Needs a fixes tag as well.

> ---
>  drivers/iio/pressure/mprls0025pa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
> index 30fb2de36821..e3f0de020a40 100644
> --- a/drivers/iio/pressure/mprls0025pa.c
> +++ b/drivers/iio/pressure/mprls0025pa.c
> @@ -323,6 +323,7 @@ static int mpr_probe(struct i2c_client *client)
>  	struct iio_dev *indio_dev;
>  	struct device *dev = &client->dev;
>  	s64 scale, offset;
> +	u32 func;
> 
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE))
>  		return dev_err_probe(dev, -EOPNOTSUPP,
> @@ -362,10 +363,11 @@ static int mpr_probe(struct i2c_client *client)
>  			return dev_err_probe(dev, ret,
>  				"honeywell,pmax-pascal could not be read\n");
>  		ret = device_property_read_u32(dev,
> -				"honeywell,transfer-function", &data->function);
> +				"honeywell,transfer-function", &func);
>  		if (ret)
>  			return dev_err_probe(dev, ret,
>  				"honeywell,transfer-function could not be read\n");
> +		data->function = func - 1;
>  		if (data->function > MPR_FUNCTION_C)
>  			return dev_err_probe(dev, -EINVAL,
>  				"honeywell,transfer-function %d invalid\n",
> --
> 2.41.0
> 


