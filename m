Return-Path: <linux-kernel+bounces-51767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507A6848F13
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8866DB2120A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2E722301;
	Sun,  4 Feb 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7W2QHsS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF1225DA;
	Sun,  4 Feb 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062334; cv=none; b=EsAE1ahqWouhjZ+t40eq9YiWFtF58gEbZ505srJTuYzGMXDLUiDCxOliwWFSYjxuPcIOOnPBQKQo8APXsn+jQj87sq99XiV1lm3Ui3Ojd1xz1MEBH9fUwOjdwRkvencbZk6bGnRykN5ByOR8aZpYAlYKMk8sTG2/PyTRcubNoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062334; c=relaxed/simple;
	bh=2TPTwSG7qmk4I4m5yMTg+gaY5sPSQAw8W0fY1U4bLRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jagFl/OBuOgT+WRdtt69XxD2fPHcmd7MeOo+TECcajTUjlFDmOJcqY0B2fqn0usdVHpzp4kV1qGgbPhCPhfTTSbL8CaaODlrWA8hQUOQ44HtEpNSKNkmFwBy/NXShJ8O+WjbsxvrwZ90gIULwGVnOQxo5kBYwMk65AWXsIb0RQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7W2QHsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C574DC433F1;
	Sun,  4 Feb 2024 15:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707062333;
	bh=2TPTwSG7qmk4I4m5yMTg+gaY5sPSQAw8W0fY1U4bLRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r7W2QHsSLXh2uJBDeyua0dBpg1G/oEq2fD08H2bfTXETy7aPPox/M1TGXtdfnlyBx
	 L4Ww7p076YXQSpzoqhUK2wzVFOZpvt0PLBdwnR1EmukuaMpOQSzRgixC3ddsuqGDUt
	 S9K6kK+KAa3bXD5muNiS2oWW+ULgIYPgYWJKzYh/4UIHuHpFR/+xHZr1MEEnFVT1VZ
	 UWJj9ahW6DpHfFS9/qeUw7MsjV8qLnA7JulVz3JmiJlD9KdtIkG8HixeYgzppFeTdn
	 H8cB2rTasKmpYxYR1o9I/jmHvbOdERrPgqHl/gYktNyKByA1q7oHCc0wQXnH6tMeh8
	 PqCpJExbhXe/A==
Date: Sun, 4 Feb 2024 15:58:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, lars@metafoo.de, Basavaraj.Natikar@amd.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] iio: hid-sensor-als: Assign channels dynamically
Message-ID: <20240204155839.3dd1d639@jic23-huawei>
In-Reply-To: <20240204130332.2635760-2-srinivas.pandruvada@linux.intel.com>
References: <20240204130332.2635760-1-srinivas.pandruvada@linux.intel.com>
	<20240204130332.2635760-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 Feb 2024 05:03:29 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Instead of assuming that every channel defined statically by
> als_channels[] is present, assign dynamically based on presence of the
> respective usage id in the descriptor. This will allow to register ALS
> with limited channel support. Append the timestamp as the last channel.
> 
> Update available_scan_mask to specify all channels which are present.
> 
> There is no intentional function changes done.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Hi Srinivas,

Logic looks fine, but not that global variable...

> ---
> v4:
> Addressed comments from Jonthan:
> 	- Use available_scan_masks
> 	- timestamp location is fixed and left gaps in sample data for absent channels
> 	- Use CHANNEL_SCAN_INDEX_MAX as limit to check presence of usage ids, otherwise
> 	  it will miss newer channels added in subsequent patches.
> v3:
> Addressed comments from Jonthan:
> 	- Remove channel allocation and move to iio_priv()
> 	- Parse all usage IDs in a single loop and continue
> 	for failure. This way the temperature and chromaticity
> 	will not need any special processing to parse usage ids.
> 	- Don't leave empty channel indexes
> 
> v2:
> New change
> 
>  drivers/iio/light/hid-sensor-als.c | 52 +++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index b6c4bef2a7bb..d3b892c0e307 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -25,6 +25,7 @@ struct als_state {
>  	struct hid_sensor_hub_callbacks callbacks;
>  	struct hid_sensor_common common_attributes;
>  	struct hid_sensor_hub_attribute_info als[CHANNEL_SCAN_INDEX_MAX];
> +	struct iio_chan_spec channels[CHANNEL_SCAN_INDEX_MAX + 1];
>  	struct {
>  		u32 illum[CHANNEL_SCAN_INDEX_MAX];
>  		u64 timestamp __aligned(8);
> @@ -33,9 +34,16 @@ struct als_state {
>  	int scale_post_decml;
>  	int scale_precision;
>  	int value_offset;
> +	int num_channels;
>  	s64 timestamp;
>  };
>  
> +/* The order of usage ids must match scan index starting from CHANNEL_SCAN_INDEX_INTENSITY */
> +static const u32 als_usage_ids[] = {
> +	HID_USAGE_SENSOR_LIGHT_ILLUM,
> +	HID_USAGE_SENSOR_LIGHT_ILLUM,
> +};
> +
>  static const u32 als_sensitivity_addresses[] = {
>  	HID_USAGE_SENSOR_DATA_LIGHT,
>  	HID_USAGE_SENSOR_LIGHT_ILLUM,
> @@ -68,6 +76,8 @@ static const struct iio_chan_spec als_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
>  };
>  
> +static unsigned long als_scan_mask[] = {0, 0};

Global? No. Could be multiple instances with different sensors supported.
Needs to be embedded in the als_state structure so it is per instance.

> +
>  /* Adjust channel real bits based on report descriptor */
>  static void als_adjust_channel_bit_mask(struct iio_chan_spec *channels,
>  					int channel, int size)
> @@ -238,27 +248,38 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
>  /* Parse report which is specific to an usage id*/
>  static int als_parse_report(struct platform_device *pdev,
>  				struct hid_sensor_hub_device *hsdev,
> -				struct iio_chan_spec *channels,
>  				unsigned usage_id,
>  				struct als_state *st)
>  {
> -	int ret;
> +	struct iio_chan_spec *channels;
> +	int ret, index = 0;
>  	int i;
>  
> -	for (i = 0; i <= CHANNEL_SCAN_INDEX_ILLUM; ++i) {
> +	channels = st->channels;
> +
> +	for (i = 0; i < CHANNEL_SCAN_INDEX_MAX; ++i) {
>  		ret = sensor_hub_input_get_attribute_info(hsdev,
>  						HID_INPUT_REPORT,
>  						usage_id,
> -						HID_USAGE_SENSOR_LIGHT_ILLUM,
> +						als_usage_ids[i],
>  						&st->als[i]);
>  		if (ret < 0)
> -			return ret;
> -		als_adjust_channel_bit_mask(channels, i, st->als[i].size);
> +			continue;
> +
> +		channels[index] = als_channels[i];
> +		als_scan_mask[0] |= BIT(i);
> +		als_adjust_channel_bit_mask(channels, index, st->als[i].size);
> +		++index;
>  
>  		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
>  			st->als[i].report_id);
>  	}
>  
> +	st->num_channels = index;
> +	/* Return success even if one usage id is present */
> +	if (index)
> +		ret = 0;
> +
>  	st->scale_precision = hid_sensor_format_scale(usage_id,
>  				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
>  				&st->scale_pre_decml, &st->scale_post_decml);
> @@ -294,15 +315,7 @@ static int hid_als_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	indio_dev->channels = devm_kmemdup(&pdev->dev, als_channels,
> -					   sizeof(als_channels), GFP_KERNEL);
> -	if (!indio_dev->channels) {
> -		dev_err(&pdev->dev, "failed to duplicate channels\n");
> -		return -ENOMEM;
> -	}
> -
>  	ret = als_parse_report(pdev, hsdev,
> -			       (struct iio_chan_spec *)indio_dev->channels,
>  			       hsdev->usage,
>  			       als_state);
>  	if (ret) {
> @@ -310,8 +323,15 @@ static int hid_als_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	indio_dev->num_channels =
> -				ARRAY_SIZE(als_channels);
> +	/* Add timestamp channel */
> +	als_state->channels[als_state->num_channels] = als_channels[CHANNEL_SCAN_INDEX_TIMESTAMP];
> +
> +	/* +1 for adding timestamp channel */
> +	indio_dev->num_channels = als_state->num_channels + 1;
> +
> +	indio_dev->channels = als_state->channels;
> +	indio_dev->available_scan_masks = als_scan_mask;
> +
>  	indio_dev->info = &als_info;
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;


