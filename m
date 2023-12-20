Return-Path: <linux-kernel+bounces-7153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365F981A259
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E808928563D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403F5374D1;
	Wed, 20 Dec 2023 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdfPOyqn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F03D96A;
	Wed, 20 Dec 2023 15:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404BDC433C7;
	Wed, 20 Dec 2023 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703085900;
	bh=X+u9nYdLYElrZ3zk8UbToNjqduUlCREvNkwwC45pkco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RdfPOyqn4Fg3psJw91hTYOE4zRnb68Q/jDYIrVowqfeaiAHGzSD03PX7h/7tTOBuq
	 88ttaLsDDdUu4Icqfqz2Q3czheb5s2EVNrR2g0ITClXARlC2hJk7ojo30MrfxqIDLy
	 zl1ifv+0Iiw1DLKpxj00NreH7uIdFGaUM8zMtkDXEQe8lLzBAJps/ZRswUZGoCDW2Q
	 iupEy057l/WJsH3TmPVRBteiXiZRBMPkSxV3iEt4tynuql9f4oq3Zo8f9WNqr5qzac
	 5cYwuwl3EPgshmb7/WiCQjemXldIpwOYB1/fAWdz+GYQ/+3XNCPcW2lf+cYAZrHxqI
	 1LXaj6eolGSmQ==
Date: Wed, 20 Dec 2023 15:24:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, lars@metafoo.de, Basavaraj.Natikar@amd.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: hid-sensor-als: Allocate channels
 dynamically
Message-ID: <20231220152446.18d220d2@jic23-huawei>
In-Reply-To: <20231218203026.1156375-2-srinivas.pandruvada@linux.intel.com>
References: <20231218203026.1156375-1-srinivas.pandruvada@linux.intel.com>
	<20231218203026.1156375-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 12:30:24 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Instead of assuming that every channel defined statically by
> als_channels[] is present, allocate dynamically based on presence of the
> respective usage id in the descriptor. This will allow to register ALS
> with limited channel support. Append the timestamp as the last channel.
> 
> There is no intentional function changes done.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Hi Srinivas,

No huge rush on this as I'll not have the revert in my upstream now
until after the merge window + may not have a chance for a second pull
request anyway.

A few comments inline,

Jonathan

> ---
> v2:
> New change
> 
>  drivers/iio/light/hid-sensor-als.c | 57 ++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 5cd27f04b45e..e57ad1946b56 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -236,14 +236,21 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
>  
>  /* Parse report which is specific to an usage id*/
>  static int als_parse_report(struct platform_device *pdev,
> -				struct hid_sensor_hub_device *hsdev,
> -				struct iio_chan_spec *channels,
> -				unsigned usage_id,
> -				struct als_state *st)
> +			    struct hid_sensor_hub_device *hsdev,
> +			    struct iio_chan_spec **channels_out,
> +			    int *size_channels_out,
> +			    unsigned int usage_id,
> +			    struct als_state *st)

Align with opening bracket.  Also, try in general to avoid white space changes
when changing anything else.  It would be easier to see what actually changed
here without that.

>  {
> -	int ret;
> +	struct iio_chan_spec *channels;
> +	int ret, index = 0;
>  	int i;
>  
> +	channels = devm_kcalloc(&pdev->dev, ARRAY_SIZE(als_channels),
> +				sizeof(als_channels), GFP_KERNEL);

Given it's a fixed size (which is fine even though you might not use it
all), can you just make it part of the iio_priv() structure
and avoid need for handling the allocation here?


> +	if (!channels)
> +		return -ENOMEM;
> +
>  	for (i = 0; i <= CHANNEL_SCAN_INDEX_ILLUM; ++i) {
>  		ret = sensor_hub_input_get_attribute_info(hsdev,
>  						HID_INPUT_REPORT,
> @@ -251,9 +258,11 @@ static int als_parse_report(struct platform_device *pdev,
>  						HID_USAGE_SENSOR_LIGHT_ILLUM,
>  						&st->als[i]);
>  		if (ret < 0)
> -			return ret;
> -		als_adjust_channel_bit_mask(channels, i, st->als[i].size);
> +			break;
>  
> +		channels[i] = als_channels[i];

channels[index] = als_channels[i]? Might be gaps. What you currently have
only works if the 'present channels' are all at the start.

> +		als_adjust_channel_bit_mask(channels, i, st->als[i].size);

Would use index not i.

> +		++index;
>  		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
>  			st->als[i].report_id);
>  	}
> @@ -262,17 +271,24 @@ static int als_parse_report(struct platform_device *pdev,
>  				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
>  				&st->scale_pre_decml, &st->scale_post_decml);
>  
> -	return ret;
> +	*channels_out = channels;
> +	*size_channels_out = index;
> +
> +	if (!index)
> +		ret = -ENODEV;
> +
> +	return 0;
>  }
>  
>  /* Function to initialize the processing for usage id */
>  static int hid_als_probe(struct platform_device *pdev)
>  {
> -	int ret = 0;
> +	int ret = 0, max_channel_index;
>  	static const char *name = "als";
>  	struct iio_dev *indio_dev;
>  	struct als_state *als_state;
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
> +	struct iio_chan_spec *channels;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct als_state));
>  	if (!indio_dev)
> @@ -293,24 +309,21 @@ static int hid_als_probe(struct platform_device *pdev)
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
> -	ret = als_parse_report(pdev, hsdev,
> -			       (struct iio_chan_spec *)indio_dev->channels,
> -			       hsdev->usage,
> -			       als_state);
> +	ret = als_parse_report(pdev, hsdev, &channels, &max_channel_index,
> +			       hsdev->usage, als_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>  		return ret;
>  	}
>  
> -	indio_dev->num_channels =
> -				ARRAY_SIZE(als_channels);
> +	/* Add timestamp channel */
> +	channels[max_channel_index] = als_channels[CHANNEL_SCAN_INDEX_TIMESTAMP];
> +	channels[max_channel_index].scan_index = max_channel_index;
> +
> +	/* +1 for adding timestamp channel */
> +	indio_dev->num_channels = max_channel_index + 1;
> +
> +	indio_dev->channels = channels;
>  	indio_dev->info = &als_info;
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;


