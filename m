Return-Path: <linux-kernel+bounces-2649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27726815FE3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13DE1F22E02
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5477636AF8;
	Sun, 17 Dec 2023 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxvLuPbn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C8044397;
	Sun, 17 Dec 2023 14:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E542BC433C7;
	Sun, 17 Dec 2023 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702824054;
	bh=1khrOZaRj2KF8KpFgTKDYoPsimZYPVswOCKbdLmQpwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DxvLuPbnfJwoxdOrjelMj4pfEOqdqcEL3QYH5XTvsHporeriDbMto9pqg0zGdRP0B
	 emnsRwtQ+r1jwYQYtxHb+Bp+IZG82pahORO/Tyx5Z2zUMg1qM9Mcrsp1mzMsHFttyy
	 TMFvMOQEu1fg2Bp83ZFg2DLIblnXbEa91e9KG3iq5XVIVhwT6JTY328hSIlDvSQV/l
	 rxbTVgKtB26cWZwjMzVIBKaYwjpk+L41SissU7MI8F6fGqTidkdSBV9NKKr7f3C+Ji
	 19ykWo0ehINO0yYZ25+QBJcuCEO4gfC+Wv5JQns712jQiP0/CeQHRBxSLSYAwMqmdJ
	 C5zFMc/RGdVHQ==
Date: Sun, 17 Dec 2023 14:40:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Basavaraj
 Natikar <Basavaraj.Natikar@amd.com>
Subject: Re: [PATCH] iio: hid-sensor-als: Don't stop probing at
 non-supported attribute
Message-ID: <20231217144039.5c971685@jic23-huawei>
In-Reply-To: <20231216114229.652020-1-jekhor@gmail.com>
References: <20231216114229.652020-1-jekhor@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 13:42:29 +0200
Yauhen Kharuzhy <jekhor@gmail.com> wrote:

> Some ambient light sensors don't support color temperature and
> chromaticity attributes. The driver stops probing if it finds this.
> 
> To support sensors without of color temperature and chromaticity
> attributes, just skip them at probing if they weren't found.
> 
> Tested at Lenovo Yogabook YB1-X91L tablet.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
i reviewed this one as as well as Srinivas' as that had issues that need solving.

This one just seems to half paper over the problem  It won't update the channels
etc but the set of channels provided to userspace are still garbage.

So better than before, but not fixing the issue fully.

Jonathan

> ---
>  drivers/iio/light/hid-sensor-als.c | 39 ++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index f17304b54468..b711bac3bb2b 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -314,8 +314,11 @@ static int als_parse_report(struct platform_device *pdev,
>  						usage_id,
>  						HID_USAGE_SENSOR_LIGHT_ILLUM,
>  						&st->als[i]);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			dev_err(&pdev->dev,
> +				"Failed to setup Illuminance attribute\n");
>  			return ret;
> +		}

Unrelated change. For a fix we should look to keep things minimal.

>  		als_adjust_channel_bit_mask(channels, i, st->als[i].size);
>  
>  		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
> @@ -326,14 +329,16 @@ static int als_parse_report(struct platform_device *pdev,
>  				usage_id,
>  				HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
>  				&st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP]);
> -	if (ret < 0)
> -		return ret;
> -	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_COLOR_TEMP,
> -				st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
> +	if (!ret) {
> +		dev_info(&pdev->dev, "Color temperature is supported\n");

I'd argue we shouldn't print a message on this.
Use the availability of channels after driver is probed to figure this out if
needed. 

> +		als_adjust_channel_bit_mask(channels,
> +			CHANNEL_SCAN_INDEX_COLOR_TEMP,
> +			st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
>  
> -	dev_dbg(&pdev->dev, "als %x:%x\n",
> -		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
> -		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
> +		dev_dbg(&pdev->dev, "als %x:%x\n",
> +			st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
> +			st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
> +	}
>  
>  	for (i = 0; i < 2; i++) {
>  		int next_scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X + i;
> @@ -342,23 +347,25 @@ static int als_parse_report(struct platform_device *pdev,
>  				HID_INPUT_REPORT, usage_id,
>  				HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X + i,
>  				&st->als[next_scan_index]);
> -		if (ret < 0)
> -			return ret;
> -
> -		als_adjust_channel_bit_mask(channels,
> +		if (!ret) {
> +			dev_info(&pdev->dev,
> +				 "Light chromaticity %c is supported\n",
> +				 i ? 'Y' : 'X');
> +			als_adjust_channel_bit_mask(channels,
>  					CHANNEL_SCAN_INDEX_CHROMATICITY_X + i,
>  					st->als[next_scan_index].size);
>  
> -		dev_dbg(&pdev->dev, "als %x:%x\n",
> -			st->als[next_scan_index].index,
> -			st->als[next_scan_index].report_id);
> +			dev_dbg(&pdev->dev, "als %x:%x\n",
> +				st->als[next_scan_index].index,
> +				st->als[next_scan_index].report_id);
> +		}
>  	}
>  
>  	st->scale_precision = hid_sensor_format_scale(usage_id,
>  				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
>  				&st->scale_pre_decml, &st->scale_post_decml);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  /* Function to initialize the processing for usage id */


