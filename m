Return-Path: <linux-kernel+bounces-133963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F36A89AB80
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FEB1C20AA8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB89D39851;
	Sat,  6 Apr 2024 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKXUGwO9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61531CFB9;
	Sat,  6 Apr 2024 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712415846; cv=none; b=damCFc6IQp+lL/j15s2Tl9CO97jWoLbSWypVUjFoqq4biQlCi1S3eKP42eD9pqvQ61vYmp4arrfJPcGL0+cRuiNTroRiEScnBIXErwRro+00kjyzxxidATgs08lMSVEqFqXOQWMuhzgHZkvJYtJIcDfGk6Q46O06KztQG1Eau+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712415846; c=relaxed/simple;
	bh=MmwmhbXSkaRYOLQIxgZS7orKIHrXbyGxfV1A4cAr9nI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WeHxrse+L/L6QwCO1ukj5FulMu+C/V6oX3uSp39Xo/lMNUlZQ/s4VMuU7WKEV8+gL6R8FUljuheyP+mlU3dwfAXlcorl4tFgurbBi7nWSTlozFfbrc72qpsn3OmriamGUjLBt0toIjgG2g0/xWF6NsPXvz7B4l5zzbAexH+A464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKXUGwO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34EDC433F1;
	Sat,  6 Apr 2024 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712415845;
	bh=MmwmhbXSkaRYOLQIxgZS7orKIHrXbyGxfV1A4cAr9nI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CKXUGwO9CRl2f6/YUmp/d+Aue2N0RLDMIwWxjrZQugnV6lDXzlWlY7h0e5akqAWvh
	 5fg3G4ZkYU7NjAEC0MFguDziH/AFWSIM+hYqT0yjTBClTW6s/UMa9YrA3jrfIAJfrZ
	 DGBD0V4qATOgjIhGmECcPmH9ZCarAQNLo/qwusuPttjkck2FOWCLOCbNWwO4egnyT5
	 RSKC8F/FiE9gbm+uS8A1OFmZWFtSOQhHgR3L1D96YJVSsmT2wUJqzPOGGMSN/RbiPn
	 vwUNHs/wcYKQW4KtvbI0NZaVFV9zs9Ep82jH0nQA9KWGxdOcKBLoyqkocHNsuxbj9m
	 pc51UVPr4trdw==
Date: Sat, 6 Apr 2024 16:03:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH 4/6] iio: adc: ad7173: refactor ain and vref selection
Message-ID: <20240406160350.751d23ae@jic23-huawei>
In-Reply-To: <20240401-ad4111-v1-4-34618a9cc502@analog.com>
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
	<20240401-ad4111-v1-4-34618a9cc502@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Apr 2024 18:32:22 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> 
> Move validation of analog inputs and reference voltage selection to
> separate functions.
> 
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
A few line wrapping comments inline. 

> ---
>  drivers/iio/adc/ad7173.c | 59 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 41 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 699bc6970790..bf5a5b384fe2 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -910,6 +910,41 @@ static int ad7173_register_clk_provider(struct iio_dev *indio_dev)
>  					   &st->int_clk_hw);
>  }
>  
> +static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
> +					      unsigned int ain[2])
> +{
> +	struct device *dev = &st->sd.spi->dev;
> +
> +	if (ain[0] >= st->info->num_inputs ||
> +	    ain[1] >= st->info->num_inputs)

No need to line wrap the above - its under 80 chars on one line with the
new reduced indent due to factoring this out.

> +		return dev_err_probe(dev, -EINVAL,
> +			"Input pin number out of range for pair (%d %d).\n",
> +			ain[0], ain[1]);
> +
> +	return 0;
> +}
> +
> +static int ad7173_validate_reference(struct ad7173_state *st, int ref_sel)
> +{
> +	struct device *dev = &st->sd.spi->dev;
> +	int ret;
> +
> +	if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF && !st->info->has_int_ref)
> +		return dev_err_probe(dev, -EINVAL,
> +			"Internal reference is not available on current model.\n");
> +
> +	if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 && !st->info->has_ref2)
> +		return dev_err_probe(dev, -EINVAL,
> +			"External reference 2 is not available on current model.\n");
> +
> +	ret = ad7173_get_ref_voltage_milli(st, ref_sel);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +			"Cannot use reference %u\n", ref_sel);

Can pull the string to previous line and then align ref_sel just after (
whilst still remaining under 80 chars and end up a little prettier.


> +
> +	return 0;
> +}
> +
>  static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  {
>  	struct ad7173_channel *chans_st_arr, *chan_st_priv;
> @@ -970,11 +1005,9 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		if (ret)
>  			return ret;
>  
> -		if (ain[0] >= st->info->num_inputs ||
> -		    ain[1] >= st->info->num_inputs)
> -			return dev_err_probe(dev, -EINVAL,
> -				"Input pin number out of range for pair (%d %d).\n",
> -				ain[0], ain[1]);
> +		ret = ad7173_validate_voltage_ain_inputs(st, ain);
> +		if (ret)
> +			return ret;
>  
>  		ret = fwnode_property_match_property_string(child,
>  							    "adi,reference-select",
> @@ -985,19 +1018,9 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		else
>  			ref_sel = ret;
>  
> -		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF &&
> -		    !st->info->has_int_ref)
> -			return dev_err_probe(dev, -EINVAL,
> -				"Internal reference is not available on current model.\n");
> -
> -		if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 && !st->info->has_ref2)
> -			return dev_err_probe(dev, -EINVAL,
> -				"External reference 2 is not available on current model.\n");
> -
> -		ret = ad7173_get_ref_voltage_milli(st, ref_sel);
> -		if (ret < 0)
> -			return dev_err_probe(dev, ret,
> -					     "Cannot use reference %u\n", ref_sel);
> +		ret = ad7173_validate_reference(st, ref_sel);
> +		if (ret)
> +			return ret;
>  
>  		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF)
>  			st->adc_mode |= AD7173_ADC_MODE_REF_EN;
> 


