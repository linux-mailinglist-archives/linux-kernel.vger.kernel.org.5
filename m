Return-Path: <linux-kernel+bounces-112673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB03887CCD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E4A5B20E76
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F0117BCB;
	Sun, 24 Mar 2024 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAenF61w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6C1A38DA;
	Sun, 24 Mar 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711285313; cv=none; b=MJOHoFLSWyfucB2rDMBgrF7detu50R6nIatHihWi61SR99+39zj35zvisSL+ZnrSIssDyWUjxCuyBMgkVPoBxCK1yRtseYPMTKhzQmeMfQ11VMSfAWgJrX3xXOuQl7vXCWcnX9j+5XPdKy6du6SJXUBsq284dkKlX/Bs+uvUzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711285313; c=relaxed/simple;
	bh=q85Z68QUuaGnDqPVcMzjbmMb/Yg73VYqgOuyBPn6h+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szVqdz48piIvhm8ZneMmuwFIQRPFEvr/JThNFssA1RxbGRpnmIuOqIBtM6ussTGeJdpsGQ034nLVg5CDt2mKIsRKl8WE2GqDpiNgxqv7cAxLAaUKMZnGbOcZNK4zufRoNjXQIUS9GvA0YbJz3WbCLm9bI6BNI+WhTgjvUQKO5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAenF61w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B53C433F1;
	Sun, 24 Mar 2024 13:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711285313;
	bh=q85Z68QUuaGnDqPVcMzjbmMb/Yg73VYqgOuyBPn6h+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XAenF61wMVickWh1iv7exmJKA2JogTz84kcDk03KRDye2GusVxakfzWf5UwTwtNiB
	 xwpnfP74uH0EXRULk0klKj3PTusSXg1dewC7zvlUhd8hah7vDMCgSGA5raZeU2jWNT
	 NbW+bzXkhCKqrAlp1gKKz0sKvencOsEJjFnLJ/FRKShd4ZnR8n7FbkFJOeesVaLIu5
	 LbEEFDVkAOORS11GzpG4TejUD2wRNpT4YFyxqSh9y850TWEuo10hO1dlMjKoPxcisT
	 iGoj981B+wGGZXcxGXScLMP3culVmaQOi+agpo43WpM+RFrz0uQwvp9+1VsN9GJcu0
	 sTYbfQhauo6fg==
Date: Sun, 24 Mar 2024 13:01:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH v5 4/7] iio: adc: ad7380: add support for
 pseudo-differential parts
Message-ID: <20240324130135.35f4b0eb@jic23-huawei>
In-Reply-To: <20240319-adding-new-ad738x-driver-v5-4-ce7df004ceb3@baylibre.com>
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
	<20240319-adding-new-ad738x-driver-v5-4-ce7df004ceb3@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 11:11:25 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> From: David Lechner <dlechner@baylibre.com>
> 
> Add support for AD7383, AD7384 pseudo-differential compatible parts.
> Pseudo differential parts require common mode voltage supplies so add
> the support for them and add the support of IIO_CHAN_INFO_OFFSET to
> retrieve the offset
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Hi Julien,

A few aditional comments inline.  The one about
optional regulators may be something others disagree with.
Mark, perhaps you have time to comment.
Is this usage of devm_regulator_get_optional() to check a real regulator
is supplied (as we are going to get the voltage) sensible?  Feels wrong
given the regulator is the exact opposite of optional.

Jonathan

>  struct ad7380_state {
>  	const struct ad7380_chip_info *chip_info;
>  	struct spi_device *spi;
>  	struct regmap *regmap;
>  	unsigned int vref_mv;
> +	unsigned int vcm_mv[2];
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -304,6 +333,11 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
>  		*val2 = chan->scan_type.realbits;
>  
>  		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = st->vcm_mv[chan->channel] * (1 << chan->scan_type.realbits)
> +			/ st->vref_mv;

So this maths seems to be right to me, but it took me a while to figure it out.
Perhaps a comment would help along the lines of this is transforming

	(raw * scale) + vcm_mv
to
	(raw + vcm_mv / scale) * scale
as IIO ABI says offset is applied before scale.

> +
> +		return IIO_VAL_INT;
>  	}
>  
>  	return -EINVAL;
> @@ -350,7 +384,7 @@ static int ad7380_probe(struct spi_device *spi)
>  	struct iio_dev *indio_dev;
>  	struct ad7380_state *st;
>  	struct regulator *vref;
> -	int ret;
> +	int ret, i;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -394,6 +428,40 @@ static int ad7380_probe(struct spi_device *spi)
>  		st->vref_mv = AD7380_INTERNAL_REF_MV;
>  	}
>  
> +	if (st->chip_info->num_vcm_supplies > ARRAY_SIZE(st->vcm_mv))
> +		return dev_err_probe(&spi->dev, -EINVAL,
> +				     "invalid number of VCM supplies\n");
> +
> +	/*
> +	 * pseudo-differential chips have common mode supplies for the negative
> +	 * input pin.
> +	 */
> +	for (i = 0; i < st->chip_info->num_vcm_supplies; i++) {
> +		struct regulator *vcm;
> +
> +		vcm = devm_regulator_get_optional(&spi->dev,

Why optional?

> +						  st->chip_info->vcm_supplies[i]);
> +		if (IS_ERR(vcm))

This will fail if it's not there, so I'm guessing you are using this to avoid
getting to the regulator_get_voltage?  If it's not present I'd rely on that
failing rather than the confusing handling here.

When the read of voltage wasn't in probe this would have resulted in a problem
much later than initial setup, now it is, we are just pushing it down a few lines.

Arguably we could have a devm_regulator_get_not_dummy()
that had same implementation to as get_optional() but whilst it's called that
I think it's confusing to use like this.

> +			return dev_err_probe(&spi->dev, PTR_ERR(vcm),
> +					     "Failed to get %s regulator\n",
> +					     st->chip_info->vcm_supplies[i]);
> +
> +		ret = regulator_enable(vcm);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(&spi->dev,
> +					       ad7380_regulator_disable, vcm);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_get_voltage(vcm);

I'd let this fail if we have a dummy regulator.

> +		if (ret < 0)
> +			return ret;
> +
> +		st->vcm_mv[i] = ret / 1000;
> +	}
> +

