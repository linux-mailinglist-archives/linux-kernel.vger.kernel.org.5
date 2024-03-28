Return-Path: <linux-kernel+bounces-123008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B876C8900F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7405328B8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA58B81ABE;
	Thu, 28 Mar 2024 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ijk/u6/e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD95D847C;
	Thu, 28 Mar 2024 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634308; cv=none; b=f92cR0R/7LZCJcpp3EeTVIzjSlAfuCWBiMPNWPkrOi9OGuNI1uwoeNEs0+7gzf74HG19QQ/J5Hb4pzuXjTW157KJImFqYAbPSvGtVquvKTU4JO4YzMbExC2kMxgTk6QRWlYwPAPfGD0UeYNeMXWvqws0NT9Nmy3KgBMGVHWNlYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634308; c=relaxed/simple;
	bh=bI2xEoV9PU+GOHtJWeJ4LDOmjUoV6Fg9c+kVebNAsUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pyqw8PJrNwD5n+wFoKn2j8KyNP0IYuXcWl9HoI7fBrMibYJvhul3TiLiN+q8ddHEswV3uoxd9DZ/z9vEgf6MUOidQb192tgxJlWbNK2cIX+ZpU4pxH3bPRIjKGyVFgUfVWxiW28jlaF3hstwb9DLRKVYpMLMjyIIh9VBb4BCP30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ijk/u6/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF513C433C7;
	Thu, 28 Mar 2024 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634307;
	bh=bI2xEoV9PU+GOHtJWeJ4LDOmjUoV6Fg9c+kVebNAsUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ijk/u6/eIMs0lJPAUjxbsR8WiYAYiZVl1UkN1qf+SvK29HyDnofHeu6+55lPtof+t
	 sUFuhEnV8CCDhb5a4PAh7lrPKW7HKjsUMo1lGUrKAel7cu3vKppeHMf84JQx6cI1KG
	 l3NIX4jVBSWljSlAzrdcskx2mC4ZlrtXRq7pZGvfbU9IeFjoHf6e7vEknJH3zCOVqW
	 YlFjMye65+sZbqjb161UUfvWQZtFZqy4dQpJD6Z5qcz5Wty5wqkaNcqcVEQG6wgLY0
	 QH4btS1yAf/GCJr44H857zWNTPOcpX6IyS/dxm1TQok+PchHzVM9dNTXLW828yPNlU
	 nORfpvBzYSquw==
Date: Thu, 28 Mar 2024 13:58:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter
 Roeck <linux@roeck-us.net>, Support Opensource
 <support.opensource@diasemi.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 4/7] iio: addac: ad74115: Use
 devm_regulator_get_enable_get_voltage()
Message-ID: <20240328135808.7aff4fb5@jic23-huawei>
In-Reply-To: <20240327-regulator-get-enable-get-votlage-v1-4-5f4517faa059@baylibre.com>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
	<20240327-regulator-get-enable-get-votlage-v1-4-5f4517faa059@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 18:18:53 -0500
David Lechner <dlechner@baylibre.com> wrote:

> We can reduce boilerplate code by using
> devm_regulator_get_enable_get_voltage().
There is a change in behaviour in this one. I'd like some
explanation in the patch title for why it is always safe to get
the voltage of avdd_mv when previously it wasn't.

There seems to me to be a corner case where a DTS is not providing
the entry because it's always powered on so we get a stub regulator
but that doesn't matter because we aren't in DIN_THRESHOLD_MOD_AVDD.
After this change that dts is broken as now we read the voltage
whatever.

You could use the optional form and then fail the probe if
in a mode where the value will be used?

> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/addac/ad74115.c | 28 +++-------------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
> index e6bc5eb3788d..01073d7de6aa 100644
> --- a/drivers/iio/addac/ad74115.c
> +++ b/drivers/iio/addac/ad74115.c
> @@ -199,7 +199,6 @@ struct ad74115_state {
>  	struct spi_device		*spi;
>  	struct regmap			*regmap;
>  	struct iio_trigger		*trig;
> -	struct regulator		*avdd;
>  
>  	/*
>  	 * Synchronize consecutive operations when doing a one-shot
> @@ -1672,14 +1671,6 @@ static int ad74115_setup(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	if (val == AD74115_DIN_THRESHOLD_MODE_AVDD) {
> -		ret = regulator_get_voltage(st->avdd);
> -		if (ret < 0)
> -			return ret;
> -
> -		st->avdd_mv = ret / 1000;
> -	}
> -
>  	st->din_threshold_mode = val;
>  
>  	ret = ad74115_apply_fw_prop(st, &ad74115_dac_bipolar_fw_prop, &val);
> @@ -1788,11 +1779,6 @@ static int ad74115_reset(struct ad74115_state *st)
>  	return 0;
>  }
>  
> -static void ad74115_regulator_disable(void *data)
> -{
> -	regulator_disable(data);
> -}
> -
>  static int ad74115_setup_trigger(struct iio_dev *indio_dev)
>  {
>  	struct ad74115_state *st = iio_priv(indio_dev);
> @@ -1855,19 +1841,11 @@ static int ad74115_probe(struct spi_device *spi)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &ad74115_info;
>  
> -	st->avdd = devm_regulator_get(dev, "avdd");
> -	if (IS_ERR(st->avdd))
> -		return PTR_ERR(st->avdd);
> -
> -	ret = regulator_enable(st->avdd);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable avdd regulator\n");
> +	ret = devm_regulator_get_enable_get_voltage(dev, "avdd");
> +	if (ret < 0)
>  		return ret;
> -	}
>  
> -	ret = devm_add_action_or_reset(dev, ad74115_regulator_disable, st->avdd);
> -	if (ret)
> -		return ret;
> +	st->avdd_mv = ret / 1000;
>  
>  	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
>  					     regulator_names);
> 


