Return-Path: <linux-kernel+bounces-133991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C6789ABCF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AB41B2101D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C853BBDC;
	Sat,  6 Apr 2024 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTgRRDQ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671853B18D;
	Sat,  6 Apr 2024 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712418806; cv=none; b=uj85MfuxcScP/kdVYa8p3CE3PdtOm4qAizdjn2n9ZnERneI2i4/0fB6FDc5jCVTdlp+SwkYcQJnJBEannwOSUUc2/FP4Z2pjzSAHLP5A54ZpMuGbGo6meibQkaa82/zw0pQszJoQrAGDyvCq0IQ1SBJktKHNZcvvar+4u2wlrsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712418806; c=relaxed/simple;
	bh=cA3GkqTWw5E8y/RoN2cAyWjMv+WvEeEnY27Bkl1E75w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anMsgzBQiXkvICh34Jodn055XvBseGr1HpdXL5DQ83pUL751EZW5Vv5axqpzBUqK+ubb7ClDbPaTuS3GqYLRpZu7VLzCwJUe3eQPRlqn3XncPC9rfTMbuRTq5aE88MGme9ZpxWFFDYRURNyh9xckTy9TaQxeQV7Y9bVHbvCiflc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTgRRDQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABB0C433F1;
	Sat,  6 Apr 2024 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712418806;
	bh=cA3GkqTWw5E8y/RoN2cAyWjMv+WvEeEnY27Bkl1E75w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HTgRRDQ0yraghY/nHAhMzHQ7zi+KZB2WKHEg5AG+nr+lz0RA7EVU1urfNHXEQI19K
	 QLBxR7/CcOoVIns5OaHcqsbAdS0B4NAXCNZ8wVjjo1aEGGjAWUpisOOqIWfclKCXMj
	 VPYE/vgftuHA4olpkgqGzozUTmaHmGDvDFsQodLO0NBSOO5f59c57IV2eL4plgjehG
	 8fGQ9La0YazjM+11omEoySrQjUaZY1JP4QMJ8rJFPI3weh/D5gvQ2Z4GoFxGbU0+FJ
	 dU2UPjZsdk5ss9FXiVsguY2ZC/NijdvVjmjh4e0Uu/Ji0AMXccK/nQWFfsqMOPm6xG
	 MHmihy9bzLwLQ==
Date: Sat, 6 Apr 2024 16:53:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: apds9306: Improve
 apds9306_write_event_config()
Message-ID: <20240406165314.1b3403df@jic23-huawei>
In-Reply-To: <20240405104641.29478-1-subhajit.ghosh@tweaklogic.com>
References: <20240405104641.29478-1-subhajit.ghosh@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Apr 2024 21:16:41 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Simplify event configuration flow.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/all/20240310124237.52fa8a56@jic23-huawei/
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
LGTM
Applied to the togreg branch of iio.git and pushed out initially as testing
to let 0-day see if we missed anything.

Jonathan

> ---
>  drivers/iio/light/apds9306.c | 48 ++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 4d8490602cd7..465b6957682b 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -1075,14 +1075,16 @@ static int apds9306_write_event_config(struct iio_dev *indio_dev,
>  {
>  	struct apds9306_data *data = iio_priv(indio_dev);
>  	struct apds9306_regfields *rf = &data->rf;
> -	int ret, val;
> -
> -	state = !!state;
> +	int ret, enabled;
>  
>  	switch (type) {
>  	case IIO_EV_TYPE_THRESH: {
>  		guard(mutex)(&data->mutex);
>  
> +		ret = regmap_field_read(rf->int_en, &enabled);
> +		if (ret)
> +			return ret;
> +
>  		/*
>  		 * If interrupt is enabled, the channel is set before enabling
>  		 * the interrupt. In case of disable, no need to switch
> @@ -1091,38 +1093,42 @@ static int apds9306_write_event_config(struct iio_dev *indio_dev,
>  		 */
>  		if (state) {
>  			if (chan->type == IIO_LIGHT)
> -				val = 1;
> +				ret = regmap_field_write(rf->int_src, 1);
>  			else if (chan->type == IIO_INTENSITY)
> -				val = 0;
> +				ret = regmap_field_write(rf->int_src, 0);
>  			else
>  				return -EINVAL;
>  
> -			ret = regmap_field_write(rf->int_src, val);
>  			if (ret)
>  				return ret;
> -		}
>  
> -		ret = regmap_field_read(rf->int_en, &val);
> -		if (ret)
> -			return ret;
> -
> -		if (val == state)
> -			return 0;
> +			if (enabled)
> +				return 0;
>  
> -		ret = regmap_field_write(rf->int_en, state);
> -		if (ret)
> -			return ret;
> +			ret = regmap_field_write(rf->int_en, 1);
> +			if (ret)
> +				return ret;
>  
> -		if (state)
>  			return pm_runtime_resume_and_get(data->dev);
> +		} else {
> +			if (!enabled)
> +				return 0;
>  
> -		pm_runtime_mark_last_busy(data->dev);
> -		pm_runtime_put_autosuspend(data->dev);
> +			ret = regmap_field_write(rf->int_en, 0);
> +			if (ret)
> +				return ret;
>  
> -		return 0;
> +			pm_runtime_mark_last_busy(data->dev);
> +			pm_runtime_put_autosuspend(data->dev);
> +
> +			return 0;
> +		}
>  	}
>  	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> -		return regmap_field_write(rf->int_thresh_var_en, state);
> +		if (state)
> +			return regmap_field_write(rf->int_thresh_var_en, 1);
> +		else
> +			return regmap_field_write(rf->int_thresh_var_en, 0);
>  	default:
>  		return -EINVAL;
>  	}
> 
> base-commit: 526f7f17b651c78ead26fea7cea20948c00e47a5


