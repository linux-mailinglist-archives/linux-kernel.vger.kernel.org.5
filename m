Return-Path: <linux-kernel+bounces-135233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCDA89BD7B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA041C2161F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECD5F87C;
	Mon,  8 Apr 2024 10:47:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DB75F87E;
	Mon,  8 Apr 2024 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573257; cv=none; b=DfehXF5v49xRJE4oooCwisMK9nmUUrOl9SvhXrgqstJLD+NfDYeR8Oc0W/9VqMMZRspjaJjPnGz2LxCLSf7h1FZIDj6v3kvd9o4102tEUNgecW/t9S89EbQIXX2IPTlxH8wN6h7+931xe0rwe8CgocOoZOZv2w1c7Yu2/tfrU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573257; c=relaxed/simple;
	bh=Diq1SBCC+HFcKqwY87I5Y+2gDEwo7cWuc887OJgTYRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdvhCG+/ALkypZ7MBG07UFQ+0I14zXoespA/1OirvFmGzawIuUJsNyhoj1jS3eD0jaTjAcXiOh9wnnIBj4W8n82LxPXI5lD4Bo8mh79bhgN/j4yBTISXgZT/PLgA7foiQx9yVLJufx7o2PaWSq1BS4rMYsn9hUH77dLTJAK7s2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F474C43390;
	Mon,  8 Apr 2024 10:47:36 +0000 (UTC)
Message-ID: <8a0cf515-e450-41b8-950c-4356f2fb9879@xs4all.nl>
Date: Mon, 8 Apr 2024 12:47:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] media: mgb4: Fixed signal frame rate limit
 handling
Content-Language: en-US, nl
To: tumic@gpxsee.org, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Martin_T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
References: <20240322151005.3499-1-tumic@gpxsee.org>
 <20240322151005.3499-4-tumic@gpxsee.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240322151005.3499-4-tumic@gpxsee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/03/2024 16:10, tumic@gpxsee.org wrote:
> From: Martin Tůma <martin.tuma@digiteqautomotive.com>
> 
> Properly document the function of the mgb4 output frame_rate sysfs parameter
> and fix the corner case when the frame rate is set to zero causing a "divide
> by zero" kernel panic.

This is mixing a fix and a documentation improvement into one patch. This
should be split.

Also, shouldn't the fix be either part of the previous patch or come before
that patch?

> 
> Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
> ---
>  Documentation/admin-guide/media/mgb4.rst |  8 ++++++--
>  drivers/media/pci/mgb4/mgb4_sysfs_out.c  |  9 +++++----
>  drivers/media/pci/mgb4/mgb4_vout.c       | 12 ++++++------
>  drivers/media/pci/mgb4/mgb4_vout.h       |  2 +-
>  4 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/media/mgb4.rst b/Documentation/admin-guide/media/mgb4.rst
> index 2977f74d7e26..6fff886003e2 100644
> --- a/Documentation/admin-guide/media/mgb4.rst
> +++ b/Documentation/admin-guide/media/mgb4.rst
> @@ -228,8 +228,12 @@ Common FPDL3/GMSL output parameters
>      open.*
>  
>  **frame_rate** (RW):
> -    Output video frame rate in frames per second. The default frame rate is
> -    60Hz.
> +    Output video signal frame rate limit in frames per second. Due to
> +    the limited output pixel clock steps, the card can not always generate
> +    a frame rate perfectly matching the value required by the connected display.
> +    Using this parameter one can limit the frame rate by "crippling" the signal
> +    so that the lines are not equal but the signal appears like having the exact
> +    frame rate to the connected display. The default frame rate limit is 60Hz.

It's not clear what is meant with 'crippling'. Normally when dealing with video
framerates the driver will pick the closest video timing to the requested framerate.
It is understood that you can't always get the exact framerate, so drivers can
make adjustments.

Regards,

	Hans

>  
>  **hsync_polarity** (RW):
>      HSYNC signal polarity.
> diff --git a/drivers/media/pci/mgb4/mgb4_sysfs_out.c b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
> index f67ff2a48329..573aa61c69d4 100644
> --- a/drivers/media/pci/mgb4/mgb4_sysfs_out.c
> +++ b/drivers/media/pci/mgb4/mgb4_sysfs_out.c
> @@ -229,9 +229,9 @@ static ssize_t frame_rate_show(struct device *dev,
>  	struct video_device *vdev = to_video_device(dev);
>  	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
>  	u32 period = mgb4_read_reg(&voutdev->mgbdev->video,
> -				   voutdev->config->regs.frame_period);
> +				   voutdev->config->regs.frame_limit);
>  
> -	return sprintf(buf, "%u\n", MGB4_HW_FREQ / period);
> +	return sprintf(buf, "%u\n", period ? MGB4_HW_FREQ / period : 0);
>  }
>  
>  /*
> @@ -245,14 +245,15 @@ static ssize_t frame_rate_store(struct device *dev,
>  	struct video_device *vdev = to_video_device(dev);
>  	struct mgb4_vout_dev *voutdev = video_get_drvdata(vdev);
>  	unsigned long val;
> -	int ret;
> +	int limit, ret;
>  
>  	ret = kstrtoul(buf, 10, &val);
>  	if (ret)
>  		return ret;
>  
> +	limit = val ? MGB4_HW_FREQ / val : 0;
>  	mgb4_write_reg(&voutdev->mgbdev->video,
> -		       voutdev->config->regs.frame_period, MGB4_HW_FREQ / val);
> +		       voutdev->config->regs.frame_limit, limit);
>  
>  	return count;
>  }
> diff --git a/drivers/media/pci/mgb4/mgb4_vout.c b/drivers/media/pci/mgb4/mgb4_vout.c
> index a6b55669f0a8..cd001ceaae63 100644
> --- a/drivers/media/pci/mgb4/mgb4_vout.c
> +++ b/drivers/media/pci/mgb4/mgb4_vout.c
> @@ -680,12 +680,12 @@ static void fpga_init(struct mgb4_vout_dev *voutdev)
>  	mgb4_write_reg(video, regs->config, 0x00000011);
>  	mgb4_write_reg(video, regs->resolution,
>  		       (DEFAULT_WIDTH << 16) | DEFAULT_HEIGHT);
> -	mgb4_write_reg(video, regs->hsync, 0x00102020);
> -	mgb4_write_reg(video, regs->vsync, 0x40020202);
> -	mgb4_write_reg(video, regs->frame_period, DEFAULT_PERIOD);
> +	mgb4_write_reg(video, regs->hsync, 0x00283232);
> +	mgb4_write_reg(video, regs->vsync, 0x40141F1E);
> +	mgb4_write_reg(video, regs->frame_limit, DEFAULT_PERIOD);
>  	mgb4_write_reg(video, regs->padding, 0x00000000);
>  
> -	voutdev->freq = mgb4_cmt_set_vout_freq(voutdev, 70000 >> 1) << 1;
> +	voutdev->freq = mgb4_cmt_set_vout_freq(voutdev, 61150 >> 1) << 1;
>  
>  	mgb4_write_reg(video, regs->config,
>  		       (voutdev->config->id + MGB4_VIN_DEVICES) << 2 | 1 << 4);
> @@ -711,8 +711,8 @@ static void debugfs_init(struct mgb4_vout_dev *voutdev)
>  	voutdev->regs[3].offset = voutdev->config->regs.hsync;
>  	voutdev->regs[4].name = "VIDEO_PARAMS_2";
>  	voutdev->regs[4].offset = voutdev->config->regs.vsync;
> -	voutdev->regs[5].name = "FRAME_PERIOD";
> -	voutdev->regs[5].offset = voutdev->config->regs.frame_period;
> +	voutdev->regs[5].name = "FRAME_LIMIT";
> +	voutdev->regs[5].offset = voutdev->config->regs.frame_limit;
>  	voutdev->regs[6].name = "PADDING_PIXELS";
>  	voutdev->regs[6].offset = voutdev->config->regs.padding;
>  	if (has_timeperframe(video)) {
> diff --git a/drivers/media/pci/mgb4/mgb4_vout.h b/drivers/media/pci/mgb4/mgb4_vout.h
> index ab9b58b1deb7..adc8fe1e7ae6 100644
> --- a/drivers/media/pci/mgb4/mgb4_vout.h
> +++ b/drivers/media/pci/mgb4/mgb4_vout.h
> @@ -19,7 +19,7 @@ struct mgb4_vout_regs {
>  	u32 config;
>  	u32 status;
>  	u32 resolution;
> -	u32 frame_period;
> +	u32 frame_limit;
>  	u32 hsync;
>  	u32 vsync;
>  	u32 padding;


