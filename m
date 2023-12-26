Return-Path: <linux-kernel+bounces-11582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E621C81E87D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247CF1C21F61
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1302C4F61E;
	Tue, 26 Dec 2023 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8s4Q5pW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9254F1FC;
	Tue, 26 Dec 2023 16:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9F6C433C7;
	Tue, 26 Dec 2023 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703608757;
	bh=U/AR4wLwQTf7eqiS5GFn3+8pIrRcRjP/AN+Er7aV3o0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H8s4Q5pW3psSYDICWfeN1fZWPVyH4bX2AebJtDedBOEcPnvLcfosu4Ps9rKB3oZ5r
	 fP4GY3LZzPNR2nF6zkV6YnBCdiA/MEWNzvtH1EGcjT7oNshOxloGPazSZTyxNaR1GM
	 VpnSlOnl7xY2gQtIMPFz3aiNnLpwikRDsqm/iFDFWd6G88WLaGKyuGpU7jykp0MRlp
	 KP7ILevApKpMQhC6wGoxavLyKTIVXAd55KCgFXMcKQmSCIPoA5BLgsLSoYXWztmqgp
	 U2Ju5kV6fQwVwHg82Gq+eZ8eicvpOViLeDfpGcQ05I7GJ3GJPFHHj9WBKb+unDF/i2
	 yAG5bsyXuMNAw==
Date: Tue, 26 Dec 2023 16:39:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Klinger
 <ak@it-klinger.de>, Lars-Peter Clausen <lars@metafoo.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Angel Iglesias
 <ang.iglesiasg@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 06/10] iio: pressure: mprls0025pa.c remove dangerous
 defaults
Message-ID: <20231226163911.35a4dba2@jic23-huawei>
In-Reply-To: <20231224143500.10940-7-petre.rodan@subdimension.ro>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
	<20231224143500.10940-7-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Dec 2023 16:34:51 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> This driver supports 32*3 combinations of fixed ranges and transfer
> functions, plus custom ranges.
> 
> So statistically a user has more than 99% chance that the provided
> default configuration will generate invalid pressure readings if the
> bindings are not initialized and the driver is instantiated via sysfs.

I guess 99% is strong enough that it's unlikely we will break anyone so
fair enough to drop this attempt to guess the values.

> 
> The current patch removes this loophole making sure the driver loads
> only if the dt has been initialized.

Drop the reference to DT. It's correctly using generic firmware accessors
so should work fine with ACPI PRP0001 for example as well as DT.

Usually we just refer to the need for firmware properties.
There are lots of places they could be coming from.

> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  drivers/iio/pressure/mprls0025pa.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
> index 233cc1dc38ad..63c46592956f 100644
> --- a/drivers/iio/pressure/mprls0025pa.c
> +++ b/drivers/iio/pressure/mprls0025pa.c
> @@ -375,11 +375,8 @@ static int mpr_probe(struct i2c_client *client)
>  				"honeywell,transfer-function %d invalid\n",
>  								data->function);
>  	} else {

I'd prefer the condition flipped even though patch will be more noisy.

	if (!dev_fwnode(dev))
		return dev_err_probe()...

	...

As end result will be more readable.

> -		/* when loaded as i2c device we need to use default values */
> -		dev_notice(dev, "firmware node not found; using defaults\n");
> -		data->pmin = 0;
> -		data->pmax = 172369; /* 25 psi */
> -		data->function = MPR_FUNCTION_A;
> +		return dev_err_probe(dev, -EINVAL,
> +				  "driver needs to be initialized in the dt\n");
>  	}
> 
>  	data->outmin = mpr_func_spec[data->function].output_min;
> --
> 2.41.0
> 


