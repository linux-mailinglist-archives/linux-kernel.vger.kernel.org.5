Return-Path: <linux-kernel+bounces-11580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8661B81E878
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8766D1C21F65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964AB4F615;
	Tue, 26 Dec 2023 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qU0afQX2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF84E62B;
	Tue, 26 Dec 2023 16:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE6BC433C8;
	Tue, 26 Dec 2023 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703608526;
	bh=eQYBKPZRfkap6n/EQtNAG9M1zkBqA9OiFJTqFAY3ArA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qU0afQX2PMLo95iQO9fa66xXjP/sQosCpZy+I4nl+iPs+ga2C0TQBcUM0/ohGlq/k
	 Jy/efDmCJMK71LAJRulxFv2cZutOAIQs9D6p2w/CuMCsWmpeP2vjR3zTmSo22HBWUw
	 PzRPIYLm7gbK5u670fPac03bsWVvpCTc72JRcNtINiAX4hdIAE/PTxG/UcdoQM24l4
	 jsHH1ucT/lxVzTcaw5kwzdXK0X6r1ISFdjRVmjUKkKdh6tIkoEo99JigI0tCKX+4e+
	 erCWjGUnbynpdXUMVw9n6Nfqo/Lu2yCUSdMywbTMtMoBAqkoksNg32SVXs3/615AQs
	 km5cy71umj/ew==
Date: Tue, 26 Dec 2023 16:35:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Klinger
 <ak@it-klinger.de>, Lars-Peter Clausen <lars@metafoo.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Angel Iglesias
 <ang.iglesiasg@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 05/10] iio: pressure: mprls0025pa.c fix error flag
 check
Message-ID: <20231226163518.63a8690b@jic23-huawei>
In-Reply-To: <20231224143500.10940-6-petre.rodan@subdimension.ro>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
	<20231224143500.10940-6-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Dec 2023 16:34:50 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Take into account all 3 error flags while interacting with the sensor.
> Based on the datasheet, in table 14 on page 14, the status byte
> contains:
>     bit 5 busy flag - 1 if device is busy
>     bit 2 memory integrity/error flag - 1 if integrity test failed
>     bit 0 math saturation - 1 if internal math saturation has occurred
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
I've not problem with the patch, but the 'fix' in the titles means this should
have a fixes tag. I'm not sure that improving the resilience to device errors
is something we count as a fix however.  Maybe more of a feature or improvement
in which case don't say fix. 
Also, drop the .c in the patch title to be inline with similar patches in IIO.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/mprls0025pa.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
> index e3f0de020a40..233cc1dc38ad 100644
> --- a/drivers/iio/pressure/mprls0025pa.c
> +++ b/drivers/iio/pressure/mprls0025pa.c
> @@ -39,6 +39,8 @@
>  #define MPR_I2C_MEMORY	BIT(2)	/* integrity test passed */
>  #define MPR_I2C_MATH	BIT(0)	/* internal math saturation */
> 
> +#define MPR_I2C_ERR_FLAG  (MPR_I2C_BUSY | MPR_I2C_MEMORY | MPR_I2C_MATH)
> +
>  /*
>   * support _RAW sysfs interface:
>   *
> @@ -213,7 +215,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
>  					status);
>  				return status;
>  			}
> -			if (!(status & MPR_I2C_BUSY))
> +			if (!(status & MPR_I2C_ERR_FLAG))
>  				break;
>  		}
>  		if (i == nloops) {
> @@ -233,7 +235,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
>  		return -EIO;
>  	}
> 
> -	if (buf[0] & MPR_I2C_BUSY) {
> +	if (buf[0] & MPR_I2C_ERR_FLAG) {
>  		/*
>  		 * it should never be the case that status still indicates
>  		 * business
> --
> 2.41.0
> 
> 


