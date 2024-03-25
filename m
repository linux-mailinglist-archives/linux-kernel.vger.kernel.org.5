Return-Path: <linux-kernel+bounces-117858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFAB88B08B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A391C62165
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7844482EB;
	Mon, 25 Mar 2024 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XS9EwVrd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B024AEC8;
	Mon, 25 Mar 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396432; cv=none; b=ObXmace8GyBii1ZtlotxGUtxAI28Qz9lovbtDpeWP0n25VI9ridELeOxQOHSm+qZBzY7HioAUtJo+y0SpaU0Ts+EXXVco55dnjBeYdQguc0fS5Ek7DYjF1rdIeMaV9qbFEZkC5ArsSXkztGicLNeAF5nhLDeaYx0brPajW87IRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396432; c=relaxed/simple;
	bh=kXcAHUIetVbRyjbtKeQYiiL+n8qiDIttqJSMygp6HMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MyI+Lbhk3B9fp4fwRNEXcFFaSd+vg6o6LFGTAP71rkHI7fvut5LSobTTqdvXZ39JDze/1+1IYpBw2hTFoX5BZyZgvExJMwCVuz5x3ubp31SRWRHlJX0W1wYmNdt4vHLlk9R7C/c6LsRGBESRgj5SKlqPcij6xeJXMSUSJZ0u90M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XS9EwVrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B1EC433F1;
	Mon, 25 Mar 2024 19:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711396431;
	bh=kXcAHUIetVbRyjbtKeQYiiL+n8qiDIttqJSMygp6HMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XS9EwVrdlwYox7g8Fb6j4PP3b8BuFO/KOnAyDIRk3yzwL9RBklwd2Gue3l0ZKhq7c
	 UeGoBuQ7w+hxlxNPJ9rS8DQ5b9BWapJpzqksUtBPxeixubIY7/C82k9sHg0YVAjuUR
	 P8T9k6gbFaGWigeIyhw1dyqJ103aAGcWPbPig0i3oCCFZCXLnWGAHqGSrHR1iUjAoO
	 o477mtrpU6OCOU5/hKM/9tR6L51iMhE9ayntSEmLjAUybyYogN1ZVFEjm+bRVFAWfq
	 heCN8Kn5+TxVycbu/GKO+C0WHXD6OKN6rhHTvojdWxlz2qkp8CY27/agD2e/Zdbywo
	 BpktQil6URIVw==
Date: Mon, 25 Mar 2024 19:53:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, marek.vasut@gmail.com, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [RESEND PATCH v2 4/4] iio: adc: rcar-gyroadc: use
 for_each_available_child_node_scoped()
Message-ID: <20240325195336.5528172d@jic23-huawei>
In-Reply-To: <20240225142714.286440-5-jic23@kernel.org>
References: <20240225142714.286440-1-jic23@kernel.org>
	<20240225142714.286440-5-jic23@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 14:27:14 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Using automated cleanup to replace of_node_put() handling allows for
> a simplfied flow by enabling direct returns on errors.
> 
> Non available child nodes should never have been considered; that
> is ones where status != okay and was defined.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/rcar-gyroadc.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
> index d524f2e8e927..15a21d2860e7 100644
> --- a/drivers/iio/adc/rcar-gyroadc.c
> +++ b/drivers/iio/adc/rcar-gyroadc.c
> @@ -318,7 +318,6 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  	struct rcar_gyroadc *priv = iio_priv(indio_dev);
>  	struct device *dev = priv->dev;
>  	struct device_node *np = dev->of_node;
> -	struct device_node *child;
>  	struct regulator *vref;
>  	unsigned int reg;
>  	unsigned int adcmode = -1, childmode;
> @@ -326,7 +325,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  	unsigned int num_channels;
>  	int ret, first = 1;
>  
> -	for_each_child_of_node(np, child) {
> +	for_each_available_child_of_node_scoped(np, child) {
>  		of_id = of_match_node(rcar_gyroadc_child_match, child);
>  		if (!of_id) {
>  			dev_err(dev, "Ignoring unsupported ADC \"%pOFn\".",
> @@ -352,7 +351,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  			num_channels = ARRAY_SIZE(rcar_gyroadc_iio_channels_3);
>  			break;
>  		default:
> -			goto err_e_inval;
> +			return -EINVAL;
>  		}
>  
>  		/*
> @@ -369,7 +368,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  				dev_err(dev,
>  					"Failed to get child reg property of ADC \"%pOFn\".\n",
>  					child);
> -				goto err_of_node_put;
> +				return ret;
>  			}
>  
>  			/* Channel number is too high. */
> @@ -377,7 +376,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  				dev_err(dev,
>  					"Only %i channels supported with %pOFn, but reg = <%i>.\n",
>  					num_channels, child, reg);
> -				goto err_e_inval;
> +				return -EINVAL;
>  			}
>  		}
>  
> @@ -386,7 +385,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  			dev_err(dev,
>  				"Channel %i uses different ADC mode than the rest.\n",
>  				reg);
> -			goto err_e_inval;
> +			return -EINVAL;
>  		}
>  
>  		/* Channel is valid, grab the regulator. */
> @@ -396,8 +395,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  		if (IS_ERR(vref)) {
>  			dev_dbg(dev, "Channel %i 'vref' supply not connected.\n",
>  				reg);
> -			ret = PTR_ERR(vref);
> -			goto err_of_node_put;
> +			return PTR_ERR(vref);
>  		}
>  
>  		priv->vref[reg] = vref;
> @@ -422,7 +420,6 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  		 * we can stop parsing here.
>  		 */
>  		if (childmode == RCAR_GYROADC_MODE_SELECT_1_MB88101A) {
> -			of_node_put(child);
>  			break;
>  		}
>  	}
> @@ -433,12 +430,6 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  	}
>  
>  	return 0;
> -
> -err_e_inval:
> -	ret = -EINVAL;
> -err_of_node_put:
> -	of_node_put(child);
> -	return ret;
>  }
>  
>  static void rcar_gyroadc_deinit_supplies(struct iio_dev *indio_dev)


