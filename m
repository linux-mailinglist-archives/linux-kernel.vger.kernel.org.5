Return-Path: <linux-kernel+bounces-161402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A7B8B4B8D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F8E1C20AB6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAAE5B209;
	Sun, 28 Apr 2024 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxkTjxge"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02945A784;
	Sun, 28 Apr 2024 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714304876; cv=none; b=QBhCOSFoOb9bdmxG4I7NXMfgzcIMXKOQtwYSDOmlSCDu5/4HB6RsMdAV9788+7PrTpKcLleRaMlu4LenPzPNE/9oCVQfLzA06uFWdPX+3PGTFZdRFbGDFpojr1buo2JZwvquMGS6tNkmU6l1JY4tIF1zKmvOGjbtvNFD29iHF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714304876; c=relaxed/simple;
	bh=UP0FMpaWFZuZHz6hK4UAG2FkVrrblgaPvg6DkZrg5Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyi6WV6cbhrQw1aSv+9c5smBPpp7o7C57duQKRrwcpolCnhyY3+U1C6H+NdDeBumK57xSALedPISIE0kuRIkqHCScXG1/4C6pb142wpT0R28Cl45oevk4ub4Roo8VWB82ZXz/BFSU3gwzLx42gldSZtfzXLU9x1wyofuIqjgcFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxkTjxge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292C5C113CC;
	Sun, 28 Apr 2024 11:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714304876;
	bh=UP0FMpaWFZuZHz6hK4UAG2FkVrrblgaPvg6DkZrg5Lg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dxkTjxgeh7Defs2XPb5SzSwxAvDvBi4MyDLvp+qxFHoN3BFhA48DWltopDCfT/SkU
	 j5t2litY6SbbI8n1bhhCL3eP+mK9tZxxBr4muPum10PMZwkUZg4CEEFSpW6/Mw4TJ0
	 2pDjWPwNsiuOut9VG67CBHRgRbkcj2EBkEQ2g8wrwUqXjhyTgQkjK2yYUnGzSlNYsv
	 07n7+1JFNFnNbEp1Dxul6vdL4P6w7Jf6neyO1ZyPbTl+11C051oAF50H4nmHQAHDDZ
	 nKE7mBVzevFbYUDEebCpTKRKzfWj6kjUw2WUbgwBeqbIff+ReJ3J+yItQBI2BLjOLt
	 c/clJx+KHBQEQ==
Date: Sun, 28 Apr 2024 12:47:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: apds9306: Fix input arguments to in_range()
Message-ID: <20240428124745.2cb0e2a2@jic23-huawei>
In-Reply-To: <20240427090914.37274-1-subhajit.ghosh@tweaklogic.com>
References: <20240427090914.37274-1-subhajit.ghosh@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Apr 2024 18:39:14 +0930
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Third input argument to in_range() function requires the number of
> values in range, not the last value in that range. Update macro for
> persistence and adaptive threshold to reflect number of values
> supported instead of the maximum values supported.
> 
> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Applied to the togreg branch of iio.git. Pushed out initially as testing
for 0-day to take a first look.

Thanks,

Jonathan

> ---
>  drivers/iio/light/apds9306.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 46c647ccd44c..d6627b3e6000 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -55,8 +55,8 @@
>  #define APDS9306_ALS_DATA_STAT_MASK	BIT(3)
>  
>  #define APDS9306_ALS_THRES_VAL_MAX	(BIT(20) - 1)
> -#define APDS9306_ALS_THRES_VAR_VAL_MAX	(BIT(3) - 1)
> -#define APDS9306_ALS_PERSIST_VAL_MAX	(BIT(4) - 1)
> +#define APDS9306_ALS_THRES_VAR_NUM_VALS	8
> +#define APDS9306_ALS_PERSIST_NUM_VALS	16
>  #define APDS9306_ALS_READ_DATA_DELAY_US	(20 * USEC_PER_MSEC)
>  #define APDS9306_NUM_REPEAT_RATES	7
>  #define APDS9306_INT_SRC_CLEAR	0
> @@ -726,7 +726,7 @@ static int apds9306_event_period_get(struct apds9306_data *data, int *val)
>  	if (ret)
>  		return ret;
>  
> -	if (!in_range(period, 0, APDS9306_ALS_PERSIST_VAL_MAX))
> +	if (!in_range(period, 0, APDS9306_ALS_PERSIST_NUM_VALS))
>  		return -EINVAL;
>  
>  	*val = period;
> @@ -738,7 +738,7 @@ static int apds9306_event_period_set(struct apds9306_data *data, int val)
>  {
>  	struct apds9306_regfields *rf = &data->rf;
>  
> -	if (!in_range(val, 0, APDS9306_ALS_PERSIST_VAL_MAX))
> +	if (!in_range(val, 0, APDS9306_ALS_PERSIST_NUM_VALS))
>  		return -EINVAL;
>  
>  	return regmap_field_write(rf->int_persist_val, val);
> @@ -796,7 +796,7 @@ static int apds9306_event_thresh_adaptive_get(struct apds9306_data *data, int *v
>  	if (ret)
>  		return ret;
>  
> -	if (!in_range(thr_adpt, 0, APDS9306_ALS_THRES_VAR_VAL_MAX))
> +	if (!in_range(thr_adpt, 0, APDS9306_ALS_THRES_VAR_NUM_VALS))
>  		return -EINVAL;
>  
>  	*val = thr_adpt;
> @@ -808,7 +808,7 @@ static int apds9306_event_thresh_adaptive_set(struct apds9306_data *data, int va
>  {
>  	struct apds9306_regfields *rf = &data->rf;
>  
> -	if (!in_range(val, 0, APDS9306_ALS_THRES_VAR_VAL_MAX))
> +	if (!in_range(val, 0, APDS9306_ALS_THRES_VAR_NUM_VALS))
>  		return -EINVAL;
>  
>  	return regmap_field_write(rf->int_thresh_var_val, val);
> 
> base-commit: b80ad8e3cd2712b78b98804d1f59199680d8ed91


