Return-Path: <linux-kernel+bounces-7166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A26CA81A289
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E4B2841A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4042E4184F;
	Wed, 20 Dec 2023 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCu3/LnQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB5B4185B;
	Wed, 20 Dec 2023 15:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE3DC433C8;
	Wed, 20 Dec 2023 15:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703086186;
	bh=PqB9wZn+CQ7vDdo9UJOCCnwij/2Pm+D9zGbMiKMyoC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eCu3/LnQSsVLoCRaupS6ySewv9m5hzb3skYjdIQop8MoSQGmy+RG/cEGw22LXOOUR
	 ZPxj96S2kDgno8aNjvzltkr5aLghzwjMB0ueyOvr6Z7Sk40RfMS+u7ncxd9HOo6B4O
	 BK4VOcBvMKNWHJvAfO7lTU0yYqhWyB3Yx/7GyVx8AVs2uni5+U0CegAKEazz26aivk
	 5eR85eNtljIT49uTePMQV3VDx3O+ZvGcplVNYD7pF3bFA5WgTTjBG1QLzvga6KElBK
	 BbNFLNgKc89el85w5wv/jVbPHBLG0F0je7kl+LFl5SYzlPlwObhRK7VTJnG6hDjMya
	 kD4zY9+8y+fxA==
Date: Wed, 20 Dec 2023 15:29:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, lars@metafoo.de, Basavaraj.Natikar@amd.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: hid-sensor-als: Add light chromaticity
 support
Message-ID: <20231220152932.1392a8c2@jic23-huawei>
In-Reply-To: <20231218203026.1156375-4-srinivas.pandruvada@linux.intel.com>
References: <20231218203026.1156375-1-srinivas.pandruvada@linux.intel.com>
	<20231218203026.1156375-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 12:30:26 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> 
> In most cases, ambient color sensors also support the x and y light
> colors, which represent the coordinates on the CIE 1931 chromaticity
> diagram. Thus, add light chromaticity x and y.
> 
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Is it not possible to unify the support to be a single pass over the
channels array that just checks each one for availability and copies
the channel in if is found?  Tweaked slightly to deal with
the pair of chromaticity channels.

Jonathan

> ---
> v2:
> Original patch from Basavaraj Natikar <Basavaraj.Natikar@amd.com> is
> modified to prevent failure when the new usage id is not found in the
> descriptor.
> 
>  drivers/iio/light/hid-sensor-als.c | 68 +++++++++++++++++++++++++++++-
>  include/linux/hid-sensor-ids.h     |  3 ++
>  2 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 8d6beacc338a..6e2793fa515c 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -17,6 +17,8 @@ enum {
>  	CHANNEL_SCAN_INDEX_INTENSITY,
>  	CHANNEL_SCAN_INDEX_ILLUM,
>  	CHANNEL_SCAN_INDEX_COLOR_TEMP,
> +	CHANNEL_SCAN_INDEX_CHROMATICITY_X,
> +	CHANNEL_SCAN_INDEX_CHROMATICITY_Y,
>  	CHANNEL_SCAN_INDEX_MAX
>  };
>  
> @@ -76,6 +78,30 @@ static const struct iio_chan_spec als_channels[] = {
>  		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
>  		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
>  	},
> +	{
> +		.type = IIO_CHROMATICITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_X,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
> +		.scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X,
> +	},
> +	{
> +		.type = IIO_CHROMATICITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_Y,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
> +		.scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_Y,
> +	},
>  	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
>  };
>  
> @@ -119,6 +145,16 @@ static int als_read_raw(struct iio_dev *indio_dev,
>  			min = als_state->als[chan->scan_index].logical_minimum;
>  			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
>  			break;
> +		case  CHANNEL_SCAN_INDEX_CHROMATICITY_X:
> +			report_id = als_state->als[chan->scan_index].report_id;
> +			min = als_state->als[chan->scan_index].logical_minimum;
> +			address = HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X;
> +			break;
> +		case  CHANNEL_SCAN_INDEX_CHROMATICITY_Y:
> +			report_id = als_state->als[chan->scan_index].report_id;
> +			min = als_state->als[chan->scan_index].logical_minimum;
> +			address = HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y;
> +			break;
>  		default:
>  			report_id = -1;
>  			break;
> @@ -243,6 +279,14 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
>  		als_state->scan.illum[CHANNEL_SCAN_INDEX_COLOR_TEMP] = sample_data;
>  		ret = 0;
>  		break;
> +	case HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X:
> +		als_state->scan.illum[CHANNEL_SCAN_INDEX_CHROMATICITY_X] = sample_data;
> +		ret = 0;
> +		break;
> +	case HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y:
> +		als_state->scan.illum[CHANNEL_SCAN_INDEX_CHROMATICITY_Y] = sample_data;
> +		ret = 0;
> +		break;
>  	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
>  		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
>  								    *(s64 *)raw_data);
> @@ -303,11 +347,33 @@ static int als_parse_report(struct platform_device *pdev,
>  		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
>  		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
>  
> +skip_temp_channel:
> +	for (i = 0; i < 2; i++) {
> +		int next_scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X + i;
> +
> +		ret = sensor_hub_input_get_attribute_info(hsdev,
> +				HID_INPUT_REPORT, usage_id,
> +				HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X + i,
> +				&st->als[next_scan_index]);
> +		if (ret < 0)
> +			goto skip_chromaticity_channel;
> +
> +		channels[index++] = als_channels[CHANNEL_SCAN_INDEX_CHROMATICITY_X + i];
> +
> +		als_adjust_channel_bit_mask(channels,
> +					CHANNEL_SCAN_INDEX_CHROMATICITY_X + i,
> +					st->als[next_scan_index].size);
> +
> +		dev_dbg(&pdev->dev, "als %x:%x\n",
> +			st->als[next_scan_index].index,
> +			st->als[next_scan_index].report_id);
> +	}
> +
>  	st->scale_precision = hid_sensor_format_scale(usage_id,
>  				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
>  				&st->scale_pre_decml, &st->scale_post_decml);
>  
> -skip_temp_channel:
> +skip_chromaticity_channel:
>  	*channels_out = channels;
>  	*size_channels_out = index;
>  
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> index 8af4fb3e0254..6730ee900ee1 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -22,6 +22,9 @@
>  #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
>  #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
>  #define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
> +#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY			0x2004d3
> +#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X			0x2004d4
> +#define HID_USAGE_SENSOR_LIGHT_CHROMATICITY_Y			0x2004d5
>  
>  /* PROX (200011) */
>  #define HID_USAGE_SENSOR_PROX                                   0x200011


