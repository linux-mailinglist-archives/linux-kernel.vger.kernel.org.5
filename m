Return-Path: <linux-kernel+bounces-3418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92612816C00
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1691C22EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D9519463;
	Mon, 18 Dec 2023 11:14:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2492D18E2D;
	Mon, 18 Dec 2023 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11C991FB;
	Mon, 18 Dec 2023 03:14:53 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFCA53F738;
	Mon, 18 Dec 2023 03:14:06 -0800 (PST)
Date: Mon, 18 Dec 2023 11:14:04 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Martin Botka <martin.botka@somainline.org>, Vasily Khoruzhick
 <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, linux-pm@vger.kernel.org (open
 list:ALLWINNER THERMAL DRIVER), linux-arm-kernel@lists.infradead.org
 (moderated list:ARM/Allwinner sunXi SoC support),
 linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v1] thermal: sun8i: extend H6 calibration function to
 support 4 sensors
Message-ID: <20231218111404.5f08a4c4@donnerap.manchester.arm.com>
In-Reply-To: <20231217133637.54773-1-bigunclemax@gmail.com>
References: <20231217133637.54773-1-bigunclemax@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Dec 2023 16:36:36 +0300
Maksim Kiselev <bigunclemax@gmail.com> wrote:

Hi Maksim,

many thanks for sending this!

> The H616 SoC resembles the H6 thermal sensor controller, with a few
> changes like four sensors.
> 
> Extend sun50i_h6_ths_calibrate() function to support calibration of
> these sensors.

Oh wow, I didn't expect that, but it's indeed that simple: we just need to
cater for the 4th sensor's data to be cramped into the other bits, the
rest is exactly the same! Well spotted!

> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

I don't think the Signed-off-by:s are accurate here. Please replace those
two with just:
Co-developed-by: Martin Botka <martin.botka@somainline.org>
(I didn't really do anything in those parts)

> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

I compared the two routines and came to the same solution as you, so:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

I will incorporate this patch into the next submission of the H616 THS
series, so there is no need to merge this patch as is.

Cheers,
Andre

> ---
>  drivers/thermal/sun8i_thermal.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index f989b55a8aa8..9af95b4785be 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -221,16 +221,21 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
>  	struct device *dev = tmdev->dev;
>  	int i, ft_temp;
>  
> -	if (!caldata[0] || callen < 2 + 2 * tmdev->chip->sensor_num)
> +	if (!caldata[0])
>  		return -EINVAL;
>  
>  	/*
>  	 * efuse layout:
>  	 *
> -	 *	0   11  16	 32
> -	 *	+-------+-------+-------+
> -	 *	|temp|  |sensor0|sensor1|
> -	 *	+-------+-------+-------+
> +	 * 0      11  16     27   32     43   48    57
> +	 * +----------+-----------+-----------+-----------+
> +	 * |  temp |  |sensor0|   |sensor1|   |sensor2|   |
> +	 * +----------+-----------+-----------+-----------+
> +	 *                      ^           ^           ^
> +	 *                      |           |           |
> +	 *                      |           |           sensor3[11:8]
> +	 *                      |           sensor3[7:4]
> +	 *                      sensor3[3:0]
>  	 *
>  	 * The calibration data on the H6 is the ambient temperature and
>  	 * sensor values that are filled during the factory test stage.
> @@ -243,9 +248,16 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
>  	ft_temp = (caldata[0] & FT_TEMP_MASK) * 100;
>  
>  	for (i = 0; i < tmdev->chip->sensor_num; i++) {
> -		int sensor_reg = caldata[i + 1] & TEMP_CALIB_MASK;
> -		int cdata, offset;
> -		int sensor_temp = tmdev->chip->calc_temp(tmdev, i, sensor_reg);
> +		int sensor_reg, sensor_temp, cdata, offset;
> +
> +		if (i == 3)
> +			sensor_reg = (caldata[1] >> 12)
> +				     | ((caldata[2] >> 12) << 4)
> +				     | ((caldata[3] >> 12) << 8);
> +		else
> +			sensor_reg = caldata[i + 1] & TEMP_CALIB_MASK;
> +
> +		sensor_temp = tmdev->chip->calc_temp(tmdev, i, sensor_reg);
>  
>  		/*
>  		 * Calibration data is CALIBRATE_DEFAULT - (calculated


