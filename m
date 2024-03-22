Return-Path: <linux-kernel+bounces-110826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C1A886466
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFAC1F230BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4CF10FA;
	Fri, 22 Mar 2024 00:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="R8Dtj8Is"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674C376;
	Fri, 22 Mar 2024 00:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067799; cv=none; b=qBcJiF5dEnRYnjbKDVTFA2mr4oSvH+tgekp30sPaXXxMphpcHfePpPqFFhS5EQFtVIYk/m3RRRJmEaGvt/T7rR7xnfrd/ACoXFRQplMel1OHwMkGaNFRRS4HSCt2Quf7tGwVL/9bCt2tOZl6V1giULH4dfnZxV/B+0ufotn8HKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067799; c=relaxed/simple;
	bh=8kXxlTmJUzH3MtoAtcY/OmCWO5ge1T7DAHf4NDWaW3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmyIpau/4iyLMphDopVTPAGA6ztZQJ7/wggodrhM3s/dAR57c05zsc/9AInfJnW+Gve0romPw++OXFiBV5a2IV5Qvpx8Rre31PYeNjWtERS5mQf5tR4Q51J9RBzOugxBqnP/D8N+ZsNtAvtXiz19HLtZdj40pIAL9Aj7KbcA4Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=R8Dtj8Is; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D84AABEB;
	Fri, 22 Mar 2024 01:36:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711067768;
	bh=8kXxlTmJUzH3MtoAtcY/OmCWO5ge1T7DAHf4NDWaW3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8Dtj8Is6HZCHdBBnYniJuhImlg+HszLh3ZW7R7WsLuZH5Zgt0rvmQzk+eobOcYNk
	 RdWvPKgPZgxc+5hWBLIu+exejN2nkwNAVSv0RQOp32z+Vxz9LFQNlLHD8P6ct6P9nU
	 aEaezeHBT04MZPODOv4rSHcFxAkBfbvq80SBIEjM=
Date: Fri, 22 Mar 2024 02:36:31 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v9 5/6] media: uvcvideo: Refactor clock circular buffer
Message-ID: <20240322003631.GE20938@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
 <20220920-resend-hwtimestamp-v9-5-55a89f46f6be@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v9-5-55a89f46f6be@chromium.org>

Hi Ricardo,

Thank you for the patch.

On Wed, Mar 15, 2023 at 02:30:16PM +0100, Ricardo Ribalda wrote:
> Isolate all the changes related to the clock circular buffer to its own
> function, that way we can make changes easier to the buffer logic.
> 
> Also simplify the lock, by removing the circular buffer clock handling
> from uvc_video_clock_decode().
> 
> And now that we are at it, unify the API of the clock functions.
> 
> Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 84 ++++++++++++++++++---------------------
>  1 file changed, 38 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 6d0243ea0e07..1db0d1bc80e6 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -466,19 +466,30 @@ static inline ktime_t uvc_video_get_time(void)
>  		return ktime_get_real();
>  }
>  
> +static void uvc_video_clock_add_sample(struct uvc_clock *clock,
> +				       const struct uvc_clock_sample *sample)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&clock->lock, flags);
> +
> +	memcpy(&clock->samples[clock->head], sample, sizeof(*sample));

How about

	clock->samples[clock->head] = *sample;

?

> +	clock->head = (clock->head + 1) % clock->size;
> +	clock->count = min(clock->count + 1, clock->size);
> +
> +	spin_unlock_irqrestore(&clock->lock, flags);
> +
> +	clock->last_sof = sample->dev_sof;

Strictly speaking I wonder if this counts as "adding a sample". Any
objection against keeping it in the caller ?

> +}
> +
>  static void
>  uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
>  		       const u8 *data, int len)
>  {
> -	struct uvc_clock_sample *sample;
> +	struct uvc_clock_sample sample;
>  	unsigned int header_size;
>  	bool has_pts = false;
>  	bool has_scr = false;
> -	unsigned long flags;
> -	ktime_t time;
> -	u16 host_sof;
> -	u16 dev_sof;
> -	u32 dev_stc;
>  
>  	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
>  	case UVC_STREAM_PTS | UVC_STREAM_SCR:
> @@ -523,11 +534,11 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
>  	 * all the data packets of the same frame contains the same SOF. In that
>  	 * case only the first one will match the host_sof.
>  	 */
> -	dev_sof = get_unaligned_le16(&data[header_size - 2]);
> -	if (dev_sof == stream->clock.last_sof)
> +	sample.dev_sof = get_unaligned_le16(&data[header_size - 2]);
> +	if (sample.dev_sof == stream->clock.last_sof)
>  		return;
>  
> -	dev_stc = get_unaligned_le32(&data[header_size - 6]);
> +	sample.dev_stc = get_unaligned_le32(&data[header_size - 6]);
>  
>  	/*
>  	 * STC (Source Time Clock) is the clock used by the camera. The UVC 1.5
> @@ -541,21 +552,19 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
>  	 * and stc and sof are zero.
>  	 */
>  	if (buf && buf->bytesused == 0 && len == header_size &&
> -	    dev_stc == 0 && dev_sof == 0)
> +	    sample.dev_stc == 0 && sample.dev_sof == 0)
>  		return;
>  
> -	stream->clock.last_sof = dev_sof;
> -
> -	host_sof = usb_get_current_frame_number(stream->dev->udev);
> +	sample.host_sof = usb_get_current_frame_number(stream->dev->udev);
>  
>  	/*
>  	 * On some devices, like the Logitech C922, the device SOF does not run
>  	 * at a stable rate of 1kHz. For those devices use the host SOF instead.
>  	 */
>  	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
> -		dev_sof = host_sof;
> +		sample.dev_sof = sample.host_sof;
>  
> -	time = uvc_video_get_time();
> +	sample.host_time = uvc_video_get_time();
>  
>  	/*
>  	 * The UVC specification allows device implementations that can't obtain
> @@ -578,46 +587,29 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
>  	 * the 8 LSBs of the delta are kept.
>  	 */
>  	if (stream->clock.sof_offset == (u16)-1) {
> -		u16 delta_sof = (host_sof - dev_sof) & 255;
> +		u16 delta_sof = (sample.host_sof - sample.dev_sof) & 255;
>  		if (delta_sof >= 10)
>  			stream->clock.sof_offset = delta_sof;
>  		else
>  			stream->clock.sof_offset = 0;
>  	}
>  
> -	dev_sof = (dev_sof + stream->clock.sof_offset) & 2047;
> -
> -	spin_lock_irqsave(&stream->clock.lock, flags);
> -
> -	sample = &stream->clock.samples[stream->clock.head];
> -	sample->dev_stc = dev_stc;
> -	sample->dev_sof = dev_sof;
> -	sample->host_sof = host_sof;
> -	sample->host_time = time;
> -
> -	/* Update the sliding window head and count. */
> -	stream->clock.head = (stream->clock.head + 1) % stream->clock.size;
> +	sample.dev_sof = (sample.dev_sof + stream->clock.sof_offset) & 2047;
> +	sample.dev_stc = get_unaligned_le32(&data[header_size - 6]);

This is already done above.

With these small issues addressed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
> -	if (stream->clock.count < stream->clock.size)
> -		stream->clock.count++;
> -
> -	spin_unlock_irqrestore(&stream->clock.lock, flags);
> +	uvc_video_clock_add_sample(&stream->clock, &sample);
>  }
>  
> -static void uvc_video_clock_reset(struct uvc_streaming *stream)
> +static void uvc_video_clock_reset(struct uvc_clock *clock)
>  {
> -	struct uvc_clock *clock = &stream->clock;
> -
>  	clock->head = 0;
>  	clock->count = 0;
>  	clock->last_sof = -1;
>  	clock->sof_offset = -1;
>  }
>  
> -static int uvc_video_clock_init(struct uvc_streaming *stream)
> +static int uvc_video_clock_init(struct uvc_clock *clock)
>  {
> -	struct uvc_clock *clock = &stream->clock;
> -
>  	spin_lock_init(&clock->lock);
>  	clock->size = 32;
>  
> @@ -626,15 +618,15 @@ static int uvc_video_clock_init(struct uvc_streaming *stream)
>  	if (clock->samples == NULL)
>  		return -ENOMEM;
>  
> -	uvc_video_clock_reset(stream);
> +	uvc_video_clock_reset(clock);
>  
>  	return 0;
>  }
>  
> -static void uvc_video_clock_cleanup(struct uvc_streaming *stream)
> +static void uvc_video_clock_cleanup(struct uvc_clock *clock)
>  {
> -	kfree(stream->clock.samples);
> -	stream->clock.samples = NULL;
> +	kfree(clock->samples);
> +	clock->samples = NULL;
>  }
>  
>  /*
> @@ -2108,7 +2100,7 @@ int uvc_video_resume(struct uvc_streaming *stream, int reset)
>  
>  	stream->frozen = 0;
>  
> -	uvc_video_clock_reset(stream);
> +	uvc_video_clock_reset(&stream->clock);
>  
>  	if (!uvc_queue_streaming(&stream->queue))
>  		return 0;
> @@ -2257,7 +2249,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
>  {
>  	int ret;
>  
> -	ret = uvc_video_clock_init(stream);
> +	ret = uvc_video_clock_init(&stream->clock);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -2275,7 +2267,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
>  error_video:
>  	usb_set_interface(stream->dev->udev, stream->intfnum, 0);
>  error_commit:
> -	uvc_video_clock_cleanup(stream);
> +	uvc_video_clock_cleanup(&stream->clock);
>  
>  	return ret;
>  }
> @@ -2303,5 +2295,5 @@ void uvc_video_stop_streaming(struct uvc_streaming *stream)
>  		usb_clear_halt(stream->dev->udev, pipe);
>  	}
>  
> -	uvc_video_clock_cleanup(stream);
> +	uvc_video_clock_cleanup(&stream->clock);
>  }
> 

-- 
Regards,

Laurent Pinchart

