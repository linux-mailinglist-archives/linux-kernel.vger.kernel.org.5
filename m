Return-Path: <linux-kernel+bounces-111223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003EB88695C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956DD1F2119E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D933210EE;
	Fri, 22 Mar 2024 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="d9YzxvCO"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E56199AD;
	Fri, 22 Mar 2024 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100130; cv=none; b=OKBWaxGG9a6j1y66RSvAZmFKIrClqYfTpT9gJWz3Hc4B5OD1i+gqCPEaA0a/VUQVdPBwDzn2M56kjWwvjkTmjNPHnOuh2DXMLVK+qGrGWQqX4qSFxuap35+54X+kkPcSAIdQzWedgFqgYqlIgYWWM1IEA6uu28OirpsYsay9fVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100130; c=relaxed/simple;
	bh=CKiXwlIgm9grSEOBKwbrUzEK7jX746Nv0f9cDrdsS6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8Z6jvgzp/yD82DBI6Qh0Vrxx+fP0+FDltS73smrbOT7yPdqC7zNWWP+zuDcUi9X9aGO3uTmbKezJ8ke6oaD5fUDIx/1In09C+PDsdUkwtvhaXooDuiv+LQuzY7eO0uvuIyxKFcqwaFyBbGkA89YA3uDlLi1RiHtNalxqdm4bBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=d9YzxvCO; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0C50782A;
	Fri, 22 Mar 2024 10:34:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711100098;
	bh=CKiXwlIgm9grSEOBKwbrUzEK7jX746Nv0f9cDrdsS6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9YzxvCOjLs7kmdP8sE+Ag/sIYqX/E4HX4s32+oS9SIJHx+KvMabhxdD2aCbjMlVH
	 y3averLSxhS1Gb7l8tGXrdMv4xkfD+MSI6W1OQTQG05lRQYFd+kTY1axTI2xTtDUav
	 lLiTd4XxJF6Lc8HNsdU6ZCsGEs72Xjn7i5PrMzQE=
Date: Fri, 22 Mar 2024 11:35:22 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v9 6/6] media: uvcvideo: Fix hw timestamp handling for
 slow FPS
Message-ID: <20240322093522.GN18799@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
 <20220920-resend-hwtimestamp-v9-6-55a89f46f6be@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v9-6-55a89f46f6be@chromium.org>

Hi Ricardo,

Thank you for the patch.

On Wed, Mar 15, 2023 at 02:30:17PM +0100, Ricardo Ribalda wrote:
> In UVC 1.5 we get a single clock value per frame. With the current
> buffer size of 32, FPS slowers than 32 might roll-over twice.
> 
> The current code cannot handle two roll-over and provide invalid
> timestamps.
> 
> Revome all the samples from the circular buffer that are more than two

s/Revome/Remove/

> rollovers old, so the algorithm always provides good timestamps.

Wouldn't it be better to support multiple rollovers instead ?

> Note that we are removing values that are more than one second old,
> which means that there is enough distance between the two points that
> we use for the interpolation to provide good values.
> 
> Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 24 ++++++++++++++++++++++++
>  drivers/media/usb/uvc/uvcvideo.h  |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 1db0d1bc80e6..c58b51207be6 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -471,8 +471,31 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
>  {
>  	unsigned long flags;
>  
> +	/*
> +	 * If we write new data on the position where we had the last
> +	 * overflow, remove the overflow pointer. There is no overflow
> +	 * on the whole circular buffer.
> +	 */
> +	if (clock->head == clock->last_sof_overflow)
> +		clock->last_sof_overflow = -1;
> +
>  	spin_lock_irqsave(&clock->lock, flags);
>  
> +	/* Handle overflows */
> +	if (clock->count > 0 && clock->last_sof > sample->dev_sof) {
> +		/*
> +		 * Remove data from the circular buffer that is older than the
> +		 * last overflow. We only support one overflow per circular
> +		 * buffer.
> +		 */
> +		if (clock->last_sof_overflow != -1) {
> +			clock->count = (clock->head - clock->last_sof_overflow
> +					+ clock->count)	% clock->count;
> +		}
> +		clock->last_sof_overflow = clock->head;
> +	}
> +
> +	/* Add sample */
>  	memcpy(&clock->samples[clock->head], sample, sizeof(*sample));
>  	clock->head = (clock->head + 1) % clock->size;
>  	clock->count = min(clock->count + 1, clock->size);
> @@ -605,6 +628,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
>  	clock->head = 0;
>  	clock->count = 0;
>  	clock->last_sof = -1;
> +	clock->last_sof_overflow = -1;
>  	clock->sof_offset = -1;
>  }
>  
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 07b2fdb80adf..bf9f5162b833 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -499,6 +499,7 @@ struct uvc_streaming {
>  		unsigned int head;
>  		unsigned int count;
>  		unsigned int size;
> +		unsigned int last_sof_overflow;
>  
>  		u16 last_sof;
>  		u16 sof_offset;
> 

-- 
Regards,

Laurent Pinchart

