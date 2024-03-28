Return-Path: <linux-kernel+bounces-122958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB57C890055
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9A31C24D26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDD880BF8;
	Thu, 28 Mar 2024 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtrmNpjL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D27E0E5;
	Thu, 28 Mar 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632877; cv=none; b=SZ4+nstyCBy02zJGrDF0zsKk2LZiAmPvQt3ERAcSlY+1URdFW7/LnDZYiw9FjeVWm+LOTv7RDj6okXyWR5OwLLHk5sqBvx8tc3P42mJvlKPSHTtnNhosjbbnJR9IVs9hFwte3ajz5ohGq+7pjgUyvCm2SwTkaX9/C+tvPjs0nao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632877; c=relaxed/simple;
	bh=1NmwgZQEt4WxSUfU0jQNuBtFGQG8gZZKskF/G6lPMV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYIR9v+pfop7hHsVm34GlI/E99wo9dEq6P/9vYNFNLkY3r3UwjnaDNR5QCuXxXjqq6vld/0ZZXeGR074Io34FasLSANxI49ZwT82eU+mJwaiN30Gnh7Q85llYBKO1Y/w7099ES7gI0gWdiSSpPVA+MHSLPpnDnUf7LPZtRN0K90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtrmNpjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA01BC433F1;
	Thu, 28 Mar 2024 13:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711632876;
	bh=1NmwgZQEt4WxSUfU0jQNuBtFGQG8gZZKskF/G6lPMV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PtrmNpjLmARH0mFur4fcmsRnS+NkMjCh69rTibYgJryMeRha1sXpiAoxC4WswSJPv
	 +HcrXDcP6Fj7Ah9P9A4OaiSz1hbu6BMXADveOR7xZUji+z0md1bF/UR5rZ/V1B9yy0
	 fn44UE/aNMgswFifQkvzp4TpeuBhQwDZ71E+dR8CzKvls8eFlpNtTKS55hXdA666Me
	 iZg8a+Xsli7d4iyTKK2HsC21VDunS+QLJXQ4KTKi8fk+zhkZBEBoogxCQECA8U/MIW
	 ++SGCWTgkZ2yl+rxEYIJikv845H+/xJLGp4oynCIxeo5eVI4OrGsWaxdY13YQHNthp
	 NLYgkfIjRyRnw==
Date: Thu, 28 Mar 2024 13:34:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
Cc: joel@jms.id.au, bsp-development.geo@leica-geosystems.com, Eddie James
 <eajames@linux.ibm.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: support negative pressure and
 temperature values
Message-ID: <20240328133421.1844a83c@jic23-huawei>
In-Reply-To: <20240327084937.3801125-1-thomas.haemmerle@leica-geosystems.com>
References: <20240327084937.3801125-1-thomas.haemmerle@leica-geosystems.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 09:49:36 +0100
Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com> wrote:

> The current implementation interprets negative values returned from
> function invocation as error codes, even those that report actual data.
> This has a side effect that when temperature values are calculated -
> they also converted by error code, which leads to false interpretation
> of results.
> 
> Fix this by using the return values only for error handling and passing
> a pointer for the values.
> 
> Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
Hi Thomas,

This needs a fixes tag so we know where to backport it to.

A few other comments inline.  Note that one aim in a fix is to keep things
minimal to make it easy to backport.  If you want to the follow the fix
with a cleanup patch that makes the driver more consistent that is great,
just don't combine that with the bug fix.

Jonathan

> ---
>  drivers/iio/pressure/dps310.c | 122 +++++++++++++++++++---------------
>  1 file changed, 69 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 1ff091b2f764..373d1c063b05 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -171,7 +171,7 @@ static int dps310_temp_workaround(struct dps310_data *data)
>  	int reg;
>  
>  	rc = regmap_read(data->regmap, 0x32, &reg);
> -	if (rc)
> +	if (rc < 0)
>  		return rc;

Why this change?  It seems unrelated to the issue you are fixing.

>  
>  	/*
> @@ -256,24 +256,24 @@ static int dps310_startup(struct dps310_data *data)
>  	return dps310_temp_workaround(data);
>  }
>  
> -static int dps310_get_pres_precision(struct dps310_data *data)
> +static int dps310_get_pres_precision(struct dps310_data *data, int *val)
>  {
>  	int rc;
> -	int val;
>  
> -	rc = regmap_read(data->regmap, DPS310_PRS_CFG, &val);
> +	rc = regmap_read(data->regmap, DPS310_PRS_CFG, val);
>  	if (rc < 0)
>  		return rc;
I'd prefer a local variable here for the intermediate result.
>  
> -	return BIT(val & GENMASK(2, 0));
> +	*val = BIT(*val & GENMASK(2, 0));
For these precision values, it's positive anyway, so why
change it to report this way?  Consistency only or am I missing something else?
> +
> +	return 0;
>  }
>  
> -static int dps310_get_temp_precision(struct dps310_data *data)
> +static int dps310_get_temp_precision(struct dps310_data *data, int *val)
>  {
>  	int rc;
> -	int val;
>  
> -	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &val);
> +	rc = regmap_read(data->regmap, DPS310_TMP_CFG, val);
As above, local variable for intermediate result would be clearer.
>  	if (rc < 0)
>  		return rc;
>  
> @@ -281,7 +281,9 @@ static int dps310_get_temp_precision(struct dps310_data *data)
>  	 * Scale factor is bottom 4 bits of the register, but 1111 is
>  	 * reserved so just grab bottom three
>  	 */
> -	return BIT(val & GENMASK(2, 0));
> +	*val = BIT(*val & GENMASK(2, 0));
> +
> +	return 0;
>  }
>  
>  /* Called with lock held */
> @@ -350,48 +352,56 @@ static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
>  				  DPS310_TMP_RATE_BITS, val);
>  }
>  
> -static int dps310_get_pres_samp_freq(struct dps310_data *data)
> +static int dps310_get_pres_samp_freq(struct dps310_data *data, int *val)
>  {
>  	int rc;
> -	int val;
>  
> -	rc = regmap_read(data->regmap, DPS310_PRS_CFG, &val);
> +	rc = regmap_read(data->regmap, DPS310_PRS_CFG, val);
Same again.
>  	if (rc < 0)
>  		return rc;
>  
> -	return BIT((val & DPS310_PRS_RATE_BITS) >> 4);
> +	*val = BIT((*val & DPS310_PRS_RATE_BITS) >> 4);
Whilst here nice to use BIT(FIELD_GET(regval, DPS310_PRS_RATE_BITS));
> +
> +	return 0;
>  }
>  
> -static int dps310_get_temp_samp_freq(struct dps310_data *data)
> +static int dps310_get_temp_samp_freq(struct dps310_data *data, int *val)
>  {
>  	int rc;
> -	int val;
>  
> -	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &val);
> +	rc = regmap_read(data->regmap, DPS310_TMP_CFG, val);
>  	if (rc < 0)
>  		return rc;
>  
> -	return BIT((val & DPS310_TMP_RATE_BITS) >> 4);
> +	*val = BIT((*val & DPS310_TMP_RATE_BITS) >> 4);
As above.

> +
> +	return 0;
>  }
>  
> -static int dps310_get_pres_k(struct dps310_data *data)
> +static int dps310_get_pres_k(struct dps310_data *data, int *val)
>  {
> -	int rc = dps310_get_pres_precision(data);
> +	int rc;
>  
> -	if (rc < 0)
> +	rc = dps310_get_pres_precision(data, val);
> +	if (rc)
>  		return rc;
>  
> -	return scale_factors[ilog2(rc)];
> +	*val = scale_factors[ilog2(*val)];
This only just went to the effort of 2^val, so why not skip that step and
pull the BIT() section out to read_pressure() where we do want that form.
You will need an extra local variable at that call site I think, but
in general it is a useful additional simplification of the code.
> +
> +	return 0;
>  }
>  
> -static int dps310_get_temp_k(struct dps310_data *data)
> +static int dps310_get_temp_k(struct dps310_data *data, int *val)
>  {
> -	int rc = dps310_get_temp_precision(data);
> +	int rc;
>  
> -	if (rc < 0)
> +	rc = dps310_get_temp_precision(data, val);
> +	if (rc)
>  		return rc;
>  
> -	return scale_factors[ilog2(rc)];
> +	*val = scale_factors[ilog2(*val)];
As above.
> +
> +	return 0;
>  }


